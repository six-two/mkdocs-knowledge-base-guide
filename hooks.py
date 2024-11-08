#!/usr/bin/python3
# @TODO: make me a plugin
# The idea is based roughly on https://github.com/danodic-dev/mkdocs-backlinks, but instead of dealing with a template, this plugin just injects the backlinks into the HTML at the bottom of the page
import os
import html
import random
import urllib

from bs4 import BeautifulSoup
from mkdocs.config.base import Config
from mkdocs.config.config_options import ListOfItems, Type
from mkdocs.config.defaults import MkDocsConfig
from mkdocs.plugins import BasePlugin
from mkdocs.structure.files import File, Files
from mkdocs.structure.pages import Page

BAD_URL_STARTS = ["http://", "https://", "tel:", "#"]

# Use a random placeholder to prevent accidential collisions with strings like BACKLINK_PLUGIN
BACKLINK_PLACEHOLDER = f"BACKLINK_PLUGIN_{random.randint(0,10000000)}_PLACEHOLDER"

def is_valid_link(link_element):
    if "href" in link_element.attrs:
        # It is a link tag
        url = link_element.attrs["href"].lower()
        for bad_pattern in BAD_URL_STARTS:
            if url.startswith(bad_pattern):
                # Url is not a local path
                return False
        # Url is probably a local file
        return True

    # Link has not target
    return False


def parse_links_to_other_pages(html: str) -> list[str]:
    return [link.attrs["href"]
            for link in BeautifulSoup(html, features="lxml").find_all("a")
            if is_valid_link(link)]


file_dict = {}
backlinks = {}

def on_nav(nav, config: MkDocsConfig, files: Files):
    global file_dict
    file_dict = {normalize_link(file.url): file for file in files}

    for key in file_dict:
        backlinks[key] = set()

    return nav


def normalize_link(path: str, base_url: str = "") -> str:
    path = path.split("#", 1)[0] # Remove anything after a hashtag (exact anchor on page)

    # @TODO: isn't this dependent on how directory urls? A: probs not, does not need to be "right", just consistent(ly wrong)
    if path.startswith("/"):
        # Absolute URL
        path = os.path.normpath(path)[1:]
    else:
        if base_url:
            path = os.path.join(os.path.dirname(base_url), path)
    
        path = os.path.normpath(path)
    
    if path.endswith("/index.html") or path == "index.html":
        path = path[:-len("index.html")]

    return path

def on_page_content(html, page: Page, config: MkDocsConfig, files: Files):
    for url in parse_links_to_other_pages(html):
        destination_link = normalize_link(url, page.url)

        if destination_link in backlinks:
            backlinks[destination_link].add((page.url, page.title))

    # Add a placeholder, that we replace afterwards
    # @TODO: should the backlinks section appear in the TOC? Then I would need to inject in markdown phase. But what if no backlings are on the page? An empty section looks stupid
    return html + BACKLINK_PLACEHOLDER

def on_post_page(output: str, page: Page, config: MkDocsConfig):
    key = normalize_link(page.url, "")
    links = backlinks[key]
    if links:
        backlink_html = "<h2>Backlinks</h2><ul>"
        # sort by title
        for link, title in sorted(links, key=lambda x: x[1]):
            link_to_page = "/" + link # @TODO: only for testing, this will break later # @TODO: escape?
            backlink_html += f'<li><a href="{link_to_page}">{html.escape(title)}</a></li>'
        backlink_html += "</ul>"
        output = output.replace(BACKLINK_PLACEHOLDER, backlink_html)
    else:
        output = output.replace(BACKLINK_PLACEHOLDER, "")
    return output

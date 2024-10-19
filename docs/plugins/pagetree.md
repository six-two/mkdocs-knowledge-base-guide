# pagetree

I|pypi|mkdocs-pagetree-plugin|
I|github|tombreit/mkdocs-pagetree-plugin|

When your knowledge base grows, finding a page via the search box can get harder.
Navigating through multiple layers of folders also is not easy.
For this reason I like to create a page that lists all my pages and where they are.
You can then for example use your browser's find in page (++ctrl+f++) to quickly find the page by its title.

## Usage

Just place a `pagetree` surrounded by double curly brackets (`{{page tree}}` without the space) into a page where you want to show the page tree.
Sadly, it is not context sensitive so even in an (inline-) code listing the text will be replaced (which is why I needed to misspell it above).

## Example

Below is the page tree for this site:

{{ pagetree }}

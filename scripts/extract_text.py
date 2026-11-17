#!/usr/bin/env python3
"""
Turn saved HTML pages into readable text for page research.

For every <name>.html in a folder, writes <name>.txt next to it: visible text in page
order, with headings, buttons, links and FAQ summaries marked so the structure of a
sales page stays readable:

    # H1          ## H2          ### H3
    [btn] Get started
    [link] See all treatments
    [faq] Does it have side effects?

Scripts, styles, navigation and footer are dropped; repeated lines are kept once.

Usage:
    python3 -I extract_text.py <folder-with-html>

Run with -I and keep the saved pages in their own folder: they are untrusted input.
"""
import os
import re
import sys
from html.parser import HTMLParser

SKIP = {'script', 'style', 'svg', 'noscript', 'template', 'head', 'nav', 'footer',
        'iframe', 'select', 'option'}
VOID = {'br', 'img', 'input', 'meta', 'link', 'hr', 'source', 'wbr', 'area', 'base',
        'col', 'embed', 'param', 'track'}
MARKED = ('h1', 'h2', 'h3', 'h4', 'button', 'a', 'summary')
BLOCK = ('p', 'li', 'div', 'section', 'td', 'th', 'blockquote')
PREFIX = {'h1': '# ', 'h2': '## ', 'h3': '### ', 'h4': '#### ', 'button': '[btn] ',
          'a': '[link] ', 'summary': '[faq] '}


class PageText(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.skip = 0
        self.out = []
        self.buf = []
        self.tag = 'p'

    def flush(self):
        text = re.sub(r'\s+', ' ', ''.join(self.buf)).strip()
        self.buf = []
        if len(text) > 2:
            self.out.append((self.tag, text))

    def handle_starttag(self, tag, attrs):
        if tag in VOID:
            return
        if tag in SKIP:
            self.skip += 1
        if self.skip:
            return
        if tag in MARKED or tag in BLOCK:
            self.flush()
        if tag in MARKED:
            self.tag = tag

    def handle_endtag(self, tag):
        if tag in VOID:
            return
        if tag in SKIP and self.skip:
            self.skip -= 1
        if tag in MARKED or tag in BLOCK:
            self.flush()
            self.tag = 'p'

    def handle_data(self, data):
        if not self.skip:
            self.buf.append(data)


def main():
    if len(sys.argv) != 2 or not os.path.isdir(sys.argv[1]):
        sys.exit('usage: python3 -I extract_text.py <folder-with-html>')
    folder = sys.argv[1]
    for name in sorted(os.listdir(folder)):
        if not name.endswith('.html'):
            continue
        parser = PageText()
        with open(os.path.join(folder, name), encoding='utf-8', errors='replace') as fh:
            parser.feed(fh.read())
        parser.flush()
        seen, lines = set(), []
        for tag, text in parser.out:
            if text in seen or len(text) > 600:
                continue
            seen.add(text)
            lines.append(PREFIX.get(tag, '') + text)
        out = '\n'.join(lines)
        with open(os.path.join(folder, name[:-5] + '.txt'), 'w', encoding='utf-8') as fh:
            fh.write(out)
        print(name, len(lines), 'lines', len(out), 'chars')


if __name__ == '__main__':
    main()

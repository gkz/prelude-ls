default: all

SRC = $(shell find src -name "*.ls" -type f | sort)
LIB = $(SRC:src/%.ls=lib/%.js)
LS = node_modules/LiveScript
LSC = node_modules/.bin/lsc
BROWSERIFY = node_modules/.bin/browserify
UGLIFYJS = node_modules/.bin/uglifyjs
MOCHA = node_modules/.bin/mocha

lib:
	mkdir lib/

lib/%.js: src/%.ls lib
	$(LSC) --compile --bare --print "$<" > "$@"

browser:
	mkdir browser/

prelude-browser.js: $(LIB) browser
	$(BROWSERIFY) -r ./lib/index.js:prelude-ls > browser/prelude-browser.js

prelude-browser-min.js: browser/prelude-browser.js
	$(UGLIFYJS) browser/prelude-browser.js --mangle --comments "all" > browser/prelude-browser-min.js

package.json: package.ls
	$(LSC) --compile --json package.ls

.PHONY: build-browser test install loc clean

all: build

build: $(LIB) package.json

build-browser: prelude-browser.js prelude-browser-min.js

test: build
	$(MOCHA) --reporter dot --ui tdd --compilers ls:$(LS)

dev-install:
	npm install .

loc:
	wc --lines src/*

clean:
	rm --force ./*.js
	rm --force --recursive lib
	rm --force --recursive browser
	rm --force package.json

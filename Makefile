default: all

SRC = $(shell find src -name "*.ls" -type f | sort)
LIB = $(SRC:src/%.ls=lib/%.js)
LS = node_modules/LiveScript
LSC = node_modules/.bin/lsc
BROWSERIFY = node_modules/.bin/browserify
UGLIFYJS = node_modules/.bin/uglifyjs
MOCHA = node_modules/.bin/mocha
MOCHA2 = node_modules/.bin/_mocha
ISTANBUL = node_modules/.bin/istanbul

lib:
	mkdir lib/

lib/%.js: src/%.ls lib
	$(LSC) --output lib --bare --compile "$<"

browser:
	mkdir browser/

prelude-browser.js: $(LIB) browser preroll.ls
	{ $(LSC) ./preroll.ls ; $(BROWSERIFY) -r ./lib/index.js:prelude-ls ; } > browser/prelude-browser.js

prelude-browser-min.js: browser/prelude-browser.js
	$(UGLIFYJS) browser/prelude-browser.js --mangle --comments "all" > browser/prelude-browser-min.js

package.json: package.json.ls
	$(LSC) --compile package.json.ls

.PHONY: build build-browser test coverage dev-install loc clean

all: build

build: $(LIB) package.json

build-browser: prelude-browser.js prelude-browser-min.js

test: build
	$(MOCHA) --reporter dot --ui tdd --compilers ls:$(LS)

coverage: build
	$(ISTANBUL) cover $(MOCHA2) -- --reporter dot --ui tdd --compilers ls:$(LS)

dev-install: package.json
	npm install .

loc:
	wc --lines src/*

clean:
	rm -f ./*.js
	rm -rf lib
	rm -rf browser
	rm -rf coverage
	rm -f package.json

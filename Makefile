default: all

LS = node_modules/LiveScript
LSC = node_modules/.bin/lsc
UGLIFYJS = node_modules/.bin/uglifyjs
MOCHA = node_modules/.bin/mocha

all: build

prelude.js: prelude.ls
	$(LSC) --compile --bare prelude.ls

prelude-browser.js: prelude.js
	./build-browser > prelude-browser.js

prelude-browser-min.js: prelude-browser.js
	$(UGLIFYJS) prelude-browser.js --mangle --comments "all" > prelude-browser-min.js

package.json: package.ls
	$(LSC) --compile --json package.ls

.PHONY: build build-browser test install loc clean

build: prelude.js package.json

build-browser: prelude-browser.js prelude-browser-min.js

test: build
	$(MOCHA) --reporter dot --ui tdd --compilers ls:$(LS)

install:
	npm install .

loc:
	wc --lines prelude.ls

clean:
	rm --force ./*.js
	rm --force package.json

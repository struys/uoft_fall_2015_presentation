all: scss bower_components

.PHONY: scss
scss: build/presentation.css

venv: requirements.txt
	rm -rf venv && virtualenv venv && . venv/bin/activate && pip install -r requirements.txt
	virtualenv venv
	sh -c ". venv/bin/activate && pip install -rrequirements.txt"

nenv: venv
	./venv/bin/nodeenv --prebuilt nenv
	sh -c '. nenv/bin/activate && npm install -g bower node-sass'

bower_components: nenv bower.json
	sh -c ". nenv/bin/activate && bower install"

build/presentation.css: assets/presentation.scss bower_components
	sh -c ". nenv/bin/activate && node-sass $< -o build/"

clean:
	rm -rf venv nenv bower_components build
	find . -iname '*.pyc' -delete

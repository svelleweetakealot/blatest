PROJECT=bla
VENV_DIR = virtualenv
PIP = $(VENV_DIR)/bin/pip
PYTHON = $(VENV_DIR)/bin/python
WHEEL_DIR = wheeldir
DEST_DIR=dist
DEST=$(DEST_DIR)/$(PROJECT).tar.gz

.PHONY: clean build

$(VENV_DIR):
	virtualenv --no-site-packages $(VENV_DIR)
	$(PIP) install -U pip

install: $(VENV_DIR)

build: install
	rm -fr wheels && \
	mkdir ./wheels && \
	$(PIP) install . --download="wheels" --no-cache-dir  && \
	$(PYTHON) setup.py sdist --dist-dir="wheels" && \
	rm -fr $(DEST_DIR) &&  mkdir $(DEST_DIR) && \
	tar -czvf $(DEST) wheels/ etc/ scripts/  && \
        rm -fr *.egg-info build/ wheels/

clean:
	rm -fr $(VENV_DIR)
	rm -fr $(WHEEL_DIR)
	rm -fr $(DEST_DIR)
	rm -fr wheels
	rm -fr dist
	rm -fr *.egg-info
	rm -fr build
	find . -iname "*.pyc" -delete



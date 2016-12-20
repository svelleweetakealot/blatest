PROJECT=bla
VENV_DIR = virtualenv
PIP = $(VENV_DIR)/bin/pip  # might need -i to point to Takealot's PyPI
PYTHON = $(VENV_DIR)/bin/python
WHEEL_DIR = wheeldir
DEST_DIR=dist
DEST=$(DEST_DIR)/$(PROJECT).tar.gz
S3_DIST=s3-dist

.PHONY: clean build

$(VENV_DIR):
	@echo "========== CREATING VENV '$@' ============="
	virtualenv --no-site-packages $(VENV_DIR)
	$(PIP) install -U pip

build: $(VENV_DIR)
	@echo "========== BUILD ============="
	rm -fr wheels && \
	mkdir ./wheels && \
	$(PIP) install . --download="wheels" --no-cache-dir  && \
	$(PYTHON) setup.py sdist --dist-dir="wheels" && \
	rm -fr $(DEST_DIR) &&  mkdir $(DEST_DIR) && \
	tar -czvf $(DEST) wheels/ etc/ scripts/  && \
        rm -fr *.egg-info build/ wheels/

clean:
	@echo "========== cleaning EVERYTHING ============="
	rm -fr $(VENV_DIR)
	rm -fr $(WHEEL_DIR)
	rm -fr $(DEST_DIR)
	rm -fr wheels
	rm -fr dist
	rm -fr *.egg-info
	rm -fr build
	rm -fr s3-dist pypidist
	find . -iname "*.pyc" -delete


test:	$(VENV_DIR)
	@echo "========== TESTING ============="
	$(PIP) install .  # for testing
	ROLE=TEST $(PYTHON) -m unittest tests.test_bla  # enumerate tests, or use "discover"



upload-s3: test build
	@echo "========== PREPPING & UPLOADING TO S3 ============="
	rm -fr $(S3_DIST) && mkdir $(S3_DIST)
	mv $(DEST) s3-dist/$(PROJECT).tar.gz
	@echo "Do the actual upload to s3..."


upload-pypi: test
	rm -fr pypidist
	@echo "========== PREPPING & UPLOADING TO PyPI ============="
	$(PYTHON) setup.py sdist --dist-dir pypidist
	@echo "Do the actual upload to PyPI..."

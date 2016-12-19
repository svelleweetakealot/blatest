VENV_DIR=./virtualenv
PIP=$(VENV_DIR)/bin/pip
PYTHON=$(VENV_DIR)/bin/python
WHEEL_DIR=./wheeldir

.PHONY: wheels clean tests

$(VENV_DIR):
	virtualenv --no-site-packages $(VENV_DIR)
	$(PIP) install -U pip

$(WHEEL_DIR): $(VENV_DIR)
	$(PIP) wheel . --wheel-dir=$@

tests: $(VENV_DIR)
	$(PYTHON) -m unittest discover

wheels: $(WHEEL_DIR)

clean:
	rm -fr $(VENV_DIR)
	rm -fr $(WHEEL_DIR)
	find . -iname "*.pyc" -delete

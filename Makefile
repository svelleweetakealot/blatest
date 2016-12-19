PIP=./venv/bin/pip
PYTHON=./venv/bin/python
WHEEL_DIR=./wheeldir

venv:
	virtualenv --no-site-packages $@

wheel:
	$(PIP) wheel . --wheel-dir=$(WHEEL_DIR)

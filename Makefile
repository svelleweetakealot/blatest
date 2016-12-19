PIP=./venv/bin/pip
PYTHON=./venv/bin/python
WHEEL_DIR=./wheeldir

.PHONY:
	wheels clean

venv:
	virtualenv --no-site-packages $@
	$(PIP) install -U pip

$(WHEEL_DIR): venv
	$(PIP) wheel . --wheel-dir=$@

wheels: $(WHEEL_DIR)

clean:
	rm -fr venv
	rm -fr $(WHEEL_DIR)
	find . -iname "*.pyc" -delete

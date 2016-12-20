Demo of General CI Ideas
========================

General demo of CI and testing

Build
-----
The first step, usually means building either a binary wheel or a source distribution. In this code we tried to follow what we do in our [travis](travis-ci.com) builds.

Assuming a similar directory structure:
```
.
├── README.md
├── setup.py
├── bla
│   └── __init__.py
├── etc
├── scripts
└── tests
    ├── __init__.py
    └── test_bla.py
```
- Create/clear the _wheels_ directory
- download dependencies in the form of _wheels_
- run _python setup.py sdist_ and output to the _wheels_ directory. (For a binary, pre-built, distribution *bdist_wheel* might be advisable)


Test
----
You are encouraged to write automated tests. Your code should support a _ROLE_ environment variable that supports a _TEST_ role. (This is *essential* that your code consults this environment variable since you don't want to drop a production database while running a random travis build test, for example. In this code one (broken) test case is provided and called as follows.

```bash
ROLE=TEST python -m unittest tests.test_bla
```

If your tests fail your deployment system should not continue and upload broken code to PyPI or S3.

Deploy
------
Once all tests pass then deployment to either/both S3 and PyPI needs to occur. Since this is a public repo I'm not going to add passwords or parameters (Please be mindful of which are *PUBLIC* and *PRIVATE* github repo's)

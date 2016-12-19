from setuptools import setup

requirements = ["requests"]

setup_args = {
   "name": "bla",
   "packages": [ "bla" ],
   "install_requires" :requirements,
}

setup(**setup_args)

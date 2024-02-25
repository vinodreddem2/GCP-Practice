from setuptools import setup, find_packages

setup(
    name='dataflow',
    version='0.1',
    packages=find_packages(),
    install_requires=[
        'apache-beam[gcp]==2.27.0',
        # Add any other dependencies your pipeline needs
    ],
)

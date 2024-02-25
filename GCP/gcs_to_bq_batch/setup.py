import setuptools

setuptools.setup(
    name='dataflow',
    version='1.0',
    install_requires=['apache-beam[gcp]'],
    packages=setuptools.find_packages(),
    author='gcpthummala',
    author_email='gcpthummala95@gmail.com')
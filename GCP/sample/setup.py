import setuptools

setuptools.setup(
    name='dataflow',
    version='1.0',
    install_requires=['protobuf==4.21.12','mysql-connector-python==8.2.0'],
    packages=setuptools.find_packages(),
    author='gcpthummala',
    author_email='gcpthummala95@gmail.com')
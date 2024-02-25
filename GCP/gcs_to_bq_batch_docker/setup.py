import setuptools

setuptools.setup(
    name='batch_pipeline',
    version='1.0',
    install_requires=['google-cloud-storage','google-cloud-bigquery'],
    # packages=setuptools.find_packages(where='batch_pipeline'),
    packages=setuptools.find_packages("batch_pipeline"),
    package_dir = {"": "batch_pipeline"
                  },
    author='gcpthummala',
    author_email='gcpthummala95@gmail.com')
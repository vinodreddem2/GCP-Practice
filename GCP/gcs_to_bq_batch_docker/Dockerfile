# set base image
FROM gcr.io/dataflow-templates-base/python3-template-launcher-base

ARG WORKDIR=/dataflow/template
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

ENV PYTHONPATH="${WORKDIR}"

# copy files
COPY setup.py .
# COPY batch_pipeline/ ./batch_pipeline
COPY batch_pipeline/helper_class/ ./batch_pipeline/helper_class
COPY batch_pipeline/pipeline.py ./batch_pipeline

RUN ls ${WORKDIR}/batch_pipeline
RUN ls ${WORKDIR}/batch_pipeline/helper_class

# set environment variables
ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/batch_pipeline/pipeline.py"
ENV FLEX_TEMPLATE_PYTHON_SETUP_FILE="${WORKDIR}/setup.py"

# Install apache-beam and other dependencies to launch the pipeline
RUN apt-get update
RUN pip install --no-cache-dir --upgrade pip
RUN pip install 'apache-beam[gcp]'

# Since we already downloaded all the dependencies, there's no need to rebuild everything.
ENV PIP_NO_DEPS=True
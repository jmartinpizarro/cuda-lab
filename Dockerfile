FROM nvidia/cuda:13.2.0-runtime-ubuntu22.04

WORKDIR /app/src

ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	software-properties-common \
	build-essential \
	gcc \
	libasound2-dev \
	&& add-apt-repository ppa:deadsnakes/ppa \
	&& apt-get update && apt-get install -y --no-install-recommends \
	python3.13 \
	python3.13-venv \
	python3.13-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN python3.13 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY ./requirements.txt ./requirements.txt

RUN python -m pip install --upgrade pip setuptools wheel \
	&& python -m pip install --no-cache-dir -r requirements.txt

COPY src /app/src

COPY .env .env
RUN export $(cat .env | xargs) && python -c "from huggingface_hub import login; login(token='$ACCESS_TOKEN', add_to_git_credential=False)"


# the data folder is going to be mounted as a volume so the 
# container is light-weight


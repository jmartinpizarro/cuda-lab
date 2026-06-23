# cuda-lab
A simple way for launching your experiments without any CUDA conflict dependencies.

## Why should you use it?

1. Launching your experiments in an independent persistant container has tons of benefits.
2. Because it introduces an easy and automatic way of using the Hugging Face CLI Autentication so your downloads are much quicker.
3. If needed, you can add more dependencies using the `pip install nameDep` command.

## Building and Deploying

Uses a CUDA-based Docker image. Asumes that the user launches this against 
a machine with GPUs. 

A folder `data/` (contains the dataset, feel free to change the directory or add more volumes) must exist in the root of this repository. That folder will 
be used as a volume for the docker container. You can move your data there for 
executing the scripts.

For building the image:

```bash 
docker buildx build . -t cuda-lab 
```

For launching the container with that image and the corresponding `data/` volume:

```bash
docker run -it -v data/:/app/src/data --gpus '"device=0,1"' -v ~/.cache/huggingface:/root/.cache/huggingface cuda-lab:latest bash
```

Test the default application inside the container:

```bash
python main.py
```


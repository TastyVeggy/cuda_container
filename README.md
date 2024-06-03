# Minimal cuda development container

Specifications:

- OS: Ubuntu 22.04
- Python: 3.10 with pip
- Cuda: 11.8.0

## Usage

### 1. Docker Image

#### Building from scratch

```
docker build . -t cuda_container/<project name>:<type>
```

#### Import from tarball

```
docker load -i cuda_container.tar.gz
```

### 2. Docker container

```
docker run -it --gpus all -v <path of working directory>:/code -v <data>:/data ... <docker image id>
```

### 3. Develop with vscode

<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> then select `Attach to Running Container`

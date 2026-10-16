# CNEquity MCP server over stdio, ready to inspect or try in a container.
#
# The image ships an offline SAMPLE lake (synthetic rows, source=mock) so the
# server starts and lists its tools with no network and no setup. It is for
# trying the tools and for MCP directories that introspect servers — not for
# research. For real data, mount your own lake and config:
#
#   docker run -i --rm -v /abs/lake:/abs/lake -v /abs/cnequity.toml:/config.toml \
#     cnequity mcp --config /config.toml
## FROM python:3.12-slim
## 
## ENV PYTHONDONTWRITEBYTECODE=1 PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1
## 
## RUN pip install cnequity \
##    && cne init --profile sample --data-root /opt/cnequity/sample \
##         --config-out /opt/cnequity/sample.toml

## ENTRYPOINT ["cne"]
## CMD ["mcp", "--config", "/opt/cnequity/sample.toml"]


### AI
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    TZ=Asia/Shanghai

WORKDIR /app

# 复制仓库源码并直接安装当前最新代码（而非从 PyPI 下载旧版）
COPY . /app
RUN pip install . && rm -rf /app/*

# 预创建标准的数据湖与配置挂载目录
RUN mkdir -p /data /configs

ENTRYPOINT ["cne"]
CMD ["--help"]

FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /opt/open-gospel

COPY pyproject.toml README.md README.zh-CN.md README.ja.md README.ko.md ./
COPY canon ./canon
COPY agents ./agents
COPY docs ./docs
COPY open_gospel ./open_gospel

RUN python -m pip install --upgrade pip \
    && python -m pip install --no-cache-dir .

EXPOSE 8080

CMD ["python", "-m", "open_gospel", "serve-env"]

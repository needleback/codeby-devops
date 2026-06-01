# =========================
# Stage 1 — build
# =========================
FROM python:3.6 AS builder

WORKDIR /app

COPY blog-app/requirements.txt .

RUN pip install --target /app/packages -r requirements.txt


# =========================
# Stage 2 — production
# =========================
FROM python:3.6-slim

WORKDIR /app

COPY --from=builder /app/packages /app/packages

COPY ./blog-app/flaskr /app/flaskr

ENV PYTHONPATH=/app/packages
ENV FLASK_APP=/app/flaskr
ENV FLASK_ENV=development

EXPOSE 5000

CMD sh -c "python -m flask init-db && python -m flask run --host=0.0.0.0"

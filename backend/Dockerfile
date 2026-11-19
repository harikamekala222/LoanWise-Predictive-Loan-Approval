FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY . .

RUN pip install --no-cache-dir \
    fastapi \
    "uvicorn[standard]" \
    joblib \
    PyJWT \
    pandas \
    numpy \
    scikit-learn \
    mysql-connector-python \
    python-dotenv \
    "pydantic[email]" \
    "pwdlib[argon2]" \
    pytest

EXPOSE 8000

CMD ["uvicorn", "backend.app:app", "--host", "0.0.0.0", "--port", "8000"]

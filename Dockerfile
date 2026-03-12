# Image de base imposée par le sujet
FROM python:3.11-slim-bookworm

# Métadonnées
LABEL maintainer="taskflow"

# Répertoire de travail
WORKDIR /app

# On copie UNIQUEMENT requirements.txt en premier
# pour exploiter le cache Docker (layer stable)
COPY requirements.txt .

# Installation des dépendances
RUN pip install --no-cache-dir -r requirements.txt

# On copie le reste du code ensuite
COPY . .

# Création d'un utilisateur non-root
RUN adduser --disabled-password --gecos "" appuser
USER appuser

# Port exposé
EXPOSE 5000

# Lancement avec gunicorn (production-ready)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]

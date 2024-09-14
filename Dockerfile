# Utiliser une image légère de Node.js
FROM node:18-alpine

# Définir le répertoire de travail à l'intérieur du conteneur
WORKDIR /app

# Copier uniquement package.json et package-lock.json pour l'installation des dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm install --frozen-lockfile

# Copier le reste du code
COPY . .

# Exposer le port utilisé par l'application (8000 si c'est celui-ci que vous utilisez)
EXPOSE 8080

# Démarrer l'application en mode développement (ou production selon les besoins)
CMD ["npm", "run", "dev"]

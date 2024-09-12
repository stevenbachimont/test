# Docker + React + Vite

Avant de lire ce README, assure-toi de lancer la commande `npm install` 😊

### Docker, d'accord ! Mais à quoi ça sert ?

Docker, comme les machines virtuelles, va permettre d'exécuter des applications dans un environnement isolé et maîtrisé.

Docker et les VM vont avoir des besoins similaires :
- Une machine hôte (un ordinateur)
- Une infrastructure (des ressources physiques)
- Un système d'exploitation (Linux, Mac, Windows)

Docker a besoin d'un Docker Engine pour être exécuté. En _conteneurisant_ notre application, nous allons lui attribuer un système d'exploitation, par exemple Linux. Si plusieurs applications utilisent le même système d'exploitation, une mutualisation s'opèrera en ce que ce dernier ne sera téléchargé qu'une seule fois. C'est une des différences majeures avec les VM, pour lesquelles la mutualisation n'existe pas.

Autre gros avantage de Docker sur les VM : Docker prélève / ampute la machine hôte en ressources réelles, là où la VM prélève / ampute la machine hôte en ressources théoriques.
Par exemple, si j'ai une application qui nécessite théoriquement 800mo de RAM, alors qu'elle ne requiert que 12mo en réalité, la VM ponctionnera 800mo, tandis que Docker n'en ponctionnera que 12.

### Mais c'est quoi, Docker ?!

C'est un outil de conteneurisation parmi bien d'autres, qui possède comme avantage majeur de pouvoir exécuter nos applications dans un environnement maîtrisé. 

Admettons que je veuille exécuter mon application dans un environnement node v.18, il m'est tout à fait possible de le faire et de la maintenir dans cet environnement. Docker nous permet donc une **indépendance vis-à-vis des systèmes d'exploitation individuels**.

Les avantages de cette indépendance sont pluriels, puisque l'environnement Docker restera imperméable aux mises à jour système de la machine hôte, lesquelles peuvent compromettre l'intégrité d'un projet.

### Comment je conteneurise mon application React ?

On part du principe que tu as ton Docker Engine (Docker Desktop). En théorie, on pourrait lancer le conteneur _à la main_ en écrivant une série de commandes. Nous, nous allons préférer Docker Compose, un logiciel associé à Docker permettant d'exécuter des applications à partir de multiples conteneurs. Il est basé sur un fichier YAML qui permet de définir les services et les paramètres de leurs créations et ainsi de les démarrer par une commande unique. 

En associant l'existence d'un fichier docker-compose.yml et d'un Dockerfile, le reste se réalise en une seule commande :

- `docker compose up --build` - ligne permettant de monter / mettre à jour le conteneur en évitant de rebuild tout ce qui est en cache.

- `docker compose up` - permet de recréer / démarrer le conteneur en utilisant les configurations spécifiées dans le fichier docker-compose.yml, en reconstruisant les images Docker si nécessaire.
.

Avant d'aller plus loin, il est bon de créer un fichier _.dockerignore_ qui va omettre les fichiers qui y seront écrits lors du build du conteneur. Notamment, nous ne voulons pas pousser :

  - le dossier **node_modules**, qui sera construit / reconstruit via la commande `npm install` du Dockerfile.

### Explication des commandes du docker-compose.yml

`version: "3.4"` : spécification de la version de la syntaxe utilisée dans le fichier docker-compose. Dans ce cas, la version est "3.4". Cela indique quelles fonctionnalités et quelles options sont disponibles pour la configuration.

`services:` : Cette ligne marque le début de la section où est / sont définis le / les services de l'application. Un service est essentiellement un conteneur Docker ou un groupe de conteneurs qui travaillent ensemble pour fournir une fonctionnalité.

`vite_docker:` : Ceci est le nom du service, tel qu'on souhaite le nommer. Dans ce cas, il s'agit d'un service appelé "vite_docker".

`build: ./` : Cette ligne spécifie le chemin vers le répertoire où se trouve le fichier Dockerfile pour construire l'image Docker pour ce service. Dans ce cas, le fichier Dockerfile est dans le répertoire racine du projet.

`container_name: vite_docker` : Cette ligne spécifie le nom du conteneur Docker lorsqu'il est créé à partir de l'image / service dont il est question. Dans ce cas, le conteneur sera nommé "vite_docker".

`ports:` : Cette ligne indique les ports qu'on souhaite exposer sur le conteneur Docker. Le port réseau est la porte d'entrée et de sortie

- `8000:8000` : C'est la configuration de port. La syntaxe est <port_hôte>:<port_conteneur>. Cela signifie que le port 8000 de l'hôte sera redirigé vers le / connecté au port 8000 du conteneur.

`volumes:` : Cette ligne spécifie les volumes que l'on veut monter dans le conteneur Docker. Les volumes permettent de partager des données entre l'hôte et le conteneur. 

- `./src:/app/src` : C'est la configuration du volume. La syntaxe est <chemin_hôte>:<chemin_conteneur>. Cela signifie que le répertoire src dans le répertoire racine du projet sur l'hôte sera monté dans le répertoire /app/src dans le conteneur Docker. Toute modification apportée à ces fichiers dans le conteneur sera également visible sur l'hôte et vice versa.
# test

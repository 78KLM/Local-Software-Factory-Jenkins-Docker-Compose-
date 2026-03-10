# Jenkins officiel
FROM jenkins/jenkins:lts

# Mode administrateurs
USER root

# On installe le client Docker
RUN apt-get update && \
    apt-get install -y docker.io docker-compose && \
    rm -rf /var/lib/apt/lists/*

# Pour la sécurité on ajoute l'utilisateur "jenkins" au groupe "docker"
# Cela lui donne la permission exclusive de parler au daemon Docker sans être root
RUN usermod -aG docker jenkins

# On retire la casquette "root" et on remet la casquette "jenkins" pour lancer l'application en sécurité !
USER jenkins
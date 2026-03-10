pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/78KLM/Containerized-Java-Microservice-Spring-Boot-Docker-'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Fabrication de la nouvelle image...'
                sh 'docker build -t devops-api-image:latest .'
            }
        }

        stage('Deploy Test Environment') {
            steps {
                echo 'Lancement de PostgreSQL et de l API...'
                // On utilise le docker-compose du projet Java !
                sh 'docker-compose up -d'
                
                echo 'On laisse 15 secondes a Spring Boot pour demarrer...'
                sh 'sleep 15'
            }
        }

        stage('Healthcheck (Test de l API)') {
            steps {
                echo 'Test de la route /api/status depuis le serveur Jenkins...'
                sh 'curl -s http://host.docker.internal:8081/api/status'
            }
        }
    }

    // Le bloc POST s'exécute toujour à la fin, que le test soit réussi ou raté !
    post {
        failure {
            echo '🛑 LE PIPELINE A ECHOUE ! Recuperation des logs de l API Java :'
            sh 'docker logs devops-api'
        }
        
        // On remplace 'always' par 'cleanup' !
        cleanup {
            echo 'Nettoyage de l environnement de test et des volumes...'
            // Le '-v' force la destruction du volume PostgreSQL
            sh 'docker-compose down -v'
        }
    }
}
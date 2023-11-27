pipeline {
    agent any

    environment {
        registry = "innovativeacademy"
        registryCredentials = 'Dockerhub'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
            post {
                success {
                    echo "Now Archiving..."
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }

        stage('Build App Image') {
            steps {
                script {
                    dockerImage = docker.build "${registry}:Innovative${BUILD_ID}"
                }
            }
        }
        stage('Upload Image') {
            steps {
                script {
                    docker.withRegistry('', registryCredentials) {
                        dockerImage.push("Innovative${BUILD_ID}")
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Kubernetes Deploy') {
            agent { label 'KOPS' }
            steps {
                sh "helm upgrade --install --force vprofile-stack helm/vprofilecharts --set appimage=${registry}:Innovative${BUILD_ID} --namespace prod"
            }
        }
    }
}


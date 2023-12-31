pipeline {
    agent any

    environment {
        registry = "innovativeacademy/innovativeapp"
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
                script {
                    echo "Running Kubernetes Deploy stage..."
                    sh "kubectl config get-contexts"
                    echo "Helm version:"
                    sh "helm version"
                    echo "Deploying to Kubernetes..."
                    sh "helm upgrade --install --force innovative-stack helm/innovativecharts --set appimage=${registry}:Innovative${BUILD_ID} --namespace prod"
                    echo "Deployment completed."
                }
            }
        }
    }
}


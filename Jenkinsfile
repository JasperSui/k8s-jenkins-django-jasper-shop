pipeline {
    environment {
        registry = "suiyang03/k8s-jenkins-django-jasper-shop_api:latest"
        registryCredential = 'docker-hub-credential'
    }

    agent {
        kubernetes {
            label "jenkins-docker"
            defaultContainer "docker"
                yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: my-release-jenkins
  containers:
    - name: docker
      image: docker:stable
      tty: true
      securityContext:
          runAsUser: 0
          privileged: true
      volumeMounts: 
        - mountPath: /var/run/docker.sock
          name: docker-sock
  volumes:
    - name: docker-sock
      hostPath:
        path: /var/run/docker.sock
"""
        }
    }
    stages{
        stage('GitHub Source'){
            steps{
                git branch: 'master', url: 'https://github.com/JasperSui/k8s-jenkins-django-jasper-shop'
            }
        }

        stage('Build Image') {
            steps {
                script{
                    dockerImage = docker.build(registry, "JasperShop/.")
                }
            }
        }

        stage('Push Image') {
            steps {
                script{
                    docker.withRegistry('', registryCredential){
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Initalize Kubectl'){
            steps {
                sh 'yum install curl'
                sh "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl"
                sh "chmod +x ./kubectl"
                sh "mv ./kubectl /usr/local/bin/kubectl"
            }
        }
        
        stage('Apply K8s Shell Script'){
            steps {
                withKubeConfig([credentialsId: 'JasperShop', serverUrl: 'https://35.201.219.29']) {
                    sh 'chmod +x k8s-yaml/scripts/update_k8s.sh'
                    sh 'k8s-yaml/scripts/update_k8s.sh'
                }
            }
        }
        
        stage('Rollout Restart All Deployment'){
            steps {
                withKubeConfig([credentialsId: 'JasperShop', serverUrl: 'https://35.201.219.29']) {
                    sh "kubectl rollout restart Deployment/jaspershop"
                    sh "kubectl rollout restart Deployment/jaspershop-db"
                    sh "kubectl rollout restart Deployment/jaspershop-rabbitmq"
                }
            }
        }
    }
}
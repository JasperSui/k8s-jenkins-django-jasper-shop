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
    }
}
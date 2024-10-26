pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    stages {
        stage('Build') {
            steps {
                sh 'rm -rf *.war'
                sh 'jar -cvf surveyformPart2.war -C surveyformPart2/src/main/webapp .'
                sh 'docker build -t chiragnarkar/swe645-assignment02:latest .'
            }
        }
        stage('Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push image to docker hub') {
            steps {
                sh 'docker push chiragnarkar/swe645-assignment02:latest'
            }
        }
        stage('deploying on k8') {
            steps {
                sh 'kubectl set image deployment/hw2-cluster-deployment container=0=chiragnarkar/swe645-assignment02:latest -n default'
                sh 'kubectl rollout restart deploy hw2-cluster-deployment -n default'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}


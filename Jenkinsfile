pipeline {
    agent any
    stages {
       stage('Git Checkout') {
            steps {
                git url: 'https://github.com/MBKRE/-jenkins-maven-project.git', branch: 'master'
            }
        }
        stage("Terraform Init") {
            steps {
                sh "terraform init"
                sleep 300
            }
        }
        stage("Terraform Plan") {
            steps {
                sh "terraform plan"
                sleep 300
            }
            
        }
        stage("Terraform Apply") {
            steps {
                sh "terraform apply --auto-approve"
                sleep 300
            }
        }
        stage('Test') {
            steps {
                sh 'mvn -f hello-app/pom.xml test'
            }
            post {
                always {
                    junit 'hello-app/target/surefire-reports/*.xml'
                }
            }
        }
    }

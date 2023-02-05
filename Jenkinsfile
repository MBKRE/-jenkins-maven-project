pipeline {
    agent any
    stages {
       stage('Git Checkout') {
            steps {
                git url: 'https://github.com/MBKRE/jenkins-maven-project.git', branch: 'master'
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
        stage('Build') {
            steps {
                sh 'cd ./java-servlet-hello && mvn clean install'
            }
                        
        }
        
        stage( 'Deploy')
        {
            steps {
                
                sh deploy.sh
                
            }
        }
    }
}

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
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
                        
        }
        
        stage( 'Deploy')
        {
            steps {
                
                sh 'export public_ip=`terraform output "public_ip"|tr -d '"'`'
                 sh 'scp ./target/hello.war ec2-user@$public_ip:$TOMCAT_HOME/webapps'
            }
        }
    }
}

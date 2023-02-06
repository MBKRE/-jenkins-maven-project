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
                
            }
        }
        stage("Terraform Plan") {
            steps {
                sh "terraform plan -var 'accesskey=${env.accesskey}' -var 'secretkey=${env.secretkey}'"
               
            }
            
        }
        stage("Terraform Apply") {
            steps {
                sh "terraform apply -var 'accesskey=${env.accesskey}' -var 'secretkey=${env.secretkey}' --auto-approve"
                sleep 10
            }
        }
        stage('Build') {
            steps {
                sh 'cd ./java-servlet-hello && /home/ec2-user/java8/apache-maven-3.8.7/bin/mvn -X clean install'
            }
                        
        }
        
        stage( 'Deploy')
        {
            steps {
                
                withCredentials(bindings: [sshUserPrivateKey(credentialsId: '	52163aec-3253-41a8-a326-880ec75a4858',  keyFileVariable: 'SSH_KEY_UBUNTU')]) {
                    
                    sh deploy.sh
                    sh 'scp -i ${SSH_KEY_UBUNTU} ./target/hello.war ubuntu@$public_ip:/tmp'
                    sh 'ssh i -c "sudo cp /tmp /root/apache-tomcat-9.0.71/webapps"'
                    
                }
                
                
                
            }
        }
    }
}

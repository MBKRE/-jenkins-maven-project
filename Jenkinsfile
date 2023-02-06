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
                
                withCredentials([file(credentialsId: 'helloworld',  variable: 'file')]) {
                    
                
                    sh '''
                    cd /var/lib/jenkins/workspace/helloworld-app
                    export public_ip=`terraform output "public_ip"|tr -d '"'`
                    scp -i $file -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/helloworld-app/java-servlet-hello/target/hello.war ubuntu@$public_ip:/tmp
                    ssh -i $file -o StrictHostKeyChecking=no ubuntu@$public_ip -c "sudo cp /tmp/hello.war /root/apache-tomcat-9.0.71/webapps/"
                    '''
                   
                    
                }
                
                
                
            }
        }
    }
}

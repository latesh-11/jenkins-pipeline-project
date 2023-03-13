pipeline{
    agent any
    tools {
        maven 'maven' 
    }
    stages{
       
        stage("Unit test"){
            steps{
                sh "mvn test"
                echo "========executing A========"
                sh "mvn --version"
            }
        }
        stage("Build"){
            steps{
                sh "mvn package"
                echo "========executing b========"
            }
        }
        
        stage("Deploy on Test"){
            steps{
                //deploy on container -> plugin
                deploy adapters: [tomcat9(credentialsId: '91952ba5-466f-4339-877c-c1f55b5550d2', path: '', url: 'http://43.207.39.180:8081')], contextPath: '/app', war: '**/*.war'
                echo "========executing c========"
            }
        }
        stage("Deploy on prod"){
            steps{
                //deploy on container -> plugin
                deploy adapters: [tomcat9(credentialsId: '91952ba5-466f-4339-877c-c1f55b5550d2', path: '', url: 'http://43.207.40.87:8080')], contextPath: '/app', war: '**/*.war'
  
                echo "========executing d========"
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}

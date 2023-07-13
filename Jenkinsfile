pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Venugopal1998/Terraform_VM.git']]])
            }
        }
        
        stage('Build and Publish Terraform Configuration') {
            steps {
                sh 'terraform init'
                sh 'terraform plan -out=tfplan'
                archiveArtifacts artifacts: 'tfplan', fingerprint: true
            }
        }
        
        stage('Create VM') {
            environment {
                GOOGLE_APPLICATION_CREDENTIALS = credentials('Terraform-vm')
            }
            
            steps {
                withCredentials([file(credentialsId: 'Terraform-vm', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}'
                    sh 'gcloud config set project harsha-test-392010'
                    sh 'gcloud config set compute/zone us-central1-a'
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
}

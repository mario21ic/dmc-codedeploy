pipeline {

    agent any

    parameters {
        string(name: 'CD_NAME', defaultValue: 'draft-demo3-cd', description: 'Codedeploy App name')
        string(name: 'CD_GROUP', defaultValue: 'draft-demo3-dg', description: 'Deployment Group name')
        string(name: 'BUCKET', defaultValue: 'dmc-devops-code', description: 'Aws Bucket to get artifact')
        string(name: 'BUCKET_DIR', defaultValue: 'web', description: 'Bucket directory')
        string(name: 'aws_credentials', defaultValue: 'aws-mario', description: 'AWS credentials')
    }

    environment {
        ARTIFACT = "${env.BUILD_NUMBER}.zip"
        SLACK_MESSAGE = "Job '${env.JOB_NAME}' Build ${env.BUILD_NUMBER} URL ${env.BUILD_URL}"
    }

    stages {
        stage ('Repository') {
            steps {
                checkout scm
            }
        }

        stage ('Build') {
            steps {
                writeFile file: "build_number.txt", text: "${env.BUILD_NUMBER}"
                sh "./scripts/aws_artifact_build ${ARTIFACT}"
            }
        }

        stage ('Deploy') {
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.aws_credentials}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                sh "./scripts/aws_artifact_upload ${params.BUCKET} ${params.BUCKET_DIR} ${ARTIFACT}"
                sh "./scripts/aws_codedeploy_deployment ${params.CD_NAME} ${params.CD_GROUP} ${params.BUCKET} ${params.BUCKET_DIR} ${ARTIFACT}"
              }
            }
        }
    }

    post {
        always {
            echo "Job has finished"
            sh "rm -f ${ARTIFACT}"
        }
        success {
            echo "good"
        }
        failure {
            echo "danger"
        }
        unstable {
            echo "warning"
        }
    }
}


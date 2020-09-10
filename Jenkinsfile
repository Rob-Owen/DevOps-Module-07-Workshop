pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Typescript Build') {
            steps {
                dir("DotnetTemplate.Web/") {
                    sh "npm ci"
                    sh "npm run build"
                }
            }
        }
        stage('Typescript Lint') {
            steps {
                dir ("DotnetTemplate.Web/") {
                    sh "npm run lint"
                }
            }
        }
        stage('Typescript Tests') {
            steps {
                dir ("DotnetTemplate.Web/") {
                    sh "npm test"
                }
            }
        }
        stage('Dotnet Build') {
            steps {
                sh "dotnet build DotnetTemplate.sln"
            }
        }
        stage('Dotnet Tests') {
            steps {
                sh "dotnet test DotnetTemplate.Web.Tests"
            }
        }
    }

    post {
        failure {
            slack(":red_circle: Build failed", "danger")
        }
        success {
            slack(":heavy_check_mark: Build succeeded", "good")
        }
    }
}

def slack(message, color = "") {
    withCredentials([string(credentialsId: 'softwire-slack-token', variable: 'SLACKTOKEN')]) {
        slackSend teamDomain: "softwire",
            channel: "#devops-course-builds",
            token: "$SLACKTOKEN",
            message: "*$message* - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)",
            color: color
    }
}
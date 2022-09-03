pipeline {
  agent any
  environment {
        REGISTRY = 'irwankilay'
        APPS = 'frontend-prod'
  }
    stages{
      stage('Build with Docker') {
        steps {
          sh "docker build -f Dockerfile -t ${REGISTRY}/${APPS}:${BUILD_NUMBER} ."
        }
      }
      stage('Publish Docker Image') {
        steps {
          sh "docker push ${REGISTRY}/${APPS}:${BUILD_NUMBER}"
        }
      }
      stage('Deploy to Kubernetes') {
        steps {
          script {
            if ( env.GIT_BRANCH == 'staging' ) {
              echo "deployed"
            }
            else if ( env.GIT_BRANCH == 'main' ) {
              sh "sed -i 's/IMAGE_TAG/${BUILD_NUMBER}/g' deployment.yaml"
              sh "kubectl apply -f deployment.yaml -n production"
              sh "kubectl apply -f hpa.yaml -n production"
            }
          }
        }
      }
    }
    post {
        always {
            echo 'One way or another, I have finished'
            sh "docker image prune -a --force"
        }
        success {
            echo 'I succeeded!'
        }
        failure {
            echo 'I failed :('
        }
    }
}

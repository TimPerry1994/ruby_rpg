pipeline {
    agent {
        docker {
            image 'ruby:2.4-alpine3.6'
        }
    }
    stages {
        stage('Build') {
		steps {
			sh 'ruby lib/runner.rb'
		}
        }
    }
}

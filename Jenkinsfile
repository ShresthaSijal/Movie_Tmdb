pipeline {
  agent any

  triggers {
    githubPush()
  }

  stages {
    stage('Checkout Test Repo') {
      steps {
        git branch: 'main', url: 'https://github.com/PocketPandit/pocketpanditai-server-api-test.git'
      }
    }

    stage('Trigger Server Api Tests') {
      steps {
        script {
          def folders = sh(script: 'ls cypress/e2e', returnStdout: true).trim().split("\n")
          def results = [:]

          folders.each { folder ->
            echo "▶️ Triggering Server Api with SPEC_FOLDER = ${folder}"
            def result = build job: 'Server Api',
              parameters: [string(name: 'SPEC_FOLDER', value: folder)],
              propagate: false,
              wait: true

            results[folder] = result.result
          }

          echo "\n📋 Test Summary:"
          results.each { folder, status ->
            echo "${folder.padRight(25)} : ${status}"
          }

          if (results.values().any { it != 'SUCCESS' }) {
            currentBuild.result = 'UNSTABLE'
          }
        }
      }
    }
  }
}

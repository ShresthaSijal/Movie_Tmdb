pipeline {
  agent any

  triggers {
    githubPush()
  }

  stages {
    stage('Checkout server-api-test repo') {
      steps {
        git branch: 'main',
            url: 'https://github.com/PocketPandit/pocketpanditai-server-api-test.git',
            credentialsId: 'c0567682-d08b-4f6f-a0b8-1d054ab4fb0b'
      }
    }

    stage('Discover folders and trigger tests') {
      steps {
        script {
          def folders = sh(script: 'ls cypress/e2e', returnStdout: true)
                          .trim()
                          .split("\n")

          def results = [:]

          for (int i = 0; i < folders.size(); i++) {
            def folder = folders[i]

            if (folder == 'auth') {
              echo "⏭️ Skipping folder '${folder}' as requested."
              continue
            }

            echo "▶️ Triggering Server Api with SPEC_FOLDER = ${folder}"

            def result = build job: 'Server Api',
              parameters: [string(name: 'SPEC_FOLDER', value: folder)],
              propagate: false,
              wait: true

            results[folder] = result.result
          }

          echo "\n📋 Cypress Test Summary:"
          results.each { folder, status ->
            echo "${folder.padRight(25)} : ${status}"
          }

          if (results.values().any { it != 'SUCCESS' }) {
            echo "\n⚠️ One or more test runs failed or were unstable."
            currentBuild.result = 'UNSTABLE'
          } else {
            echo "\n✅ All test runs succeeded."
          }
        }
      }
    }
  }
}

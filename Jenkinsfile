pipeline {
  agent any

  triggers {
    githubPush()
  }

  environment {
    EMAIL_RECIPIENTS = 'shresthasijal9@gmail.com'  // change to your email(s)
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
          def summary = "\n📋 Cypress Test Summary:\n"

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
            summary += "${folder.padRight(25)} : ${result.result}\n"
          }

          echo summary

          if (results.values().any { it != 'SUCCESS' }) {
            echo "\n⚠️ One or more test runs failed or were unstable."
            currentBuild.result = 'UNSTABLE'
          } else {
            echo "\n✅ All test runs succeeded."
          }

          // Send the summary email
          emailext (
            subject: "[Cypress Report] Server API Test Run Summary: ${currentBuild.currentResult}",
            body: """Hello,

Here is the summary of your Cypress tests:

${summary}

View full details at: ${env.BUILD_URL}

Regards,
Jenkins
""",
            to: "${EMAIL_RECIPIENTS}"
          )
        }
      }
    }
  }
}

pipeline {
  agent any

  triggers {
    // 🟢 Trigger this job automatically when there's a Git push to server-api repo
    githubPush()  // Or use pollSCM('H/5 * * * *') if webhooks aren’t configured
  }

  environment {
    GIT_REPO = 'https://github.com/ShresthaSijal/Movie_Tmdb.git'  // 🔁 Replace this with your actual repo
    BRANCH = 'main'
  }

  stages {
    stage('Checkout Server API Repo') {
      steps {
        // Not strictly needed for logic, but good for visibility/logs
        git branch: "${BRANCH}", url: "${GIT_REPO}"
        echo "Checked out latest commit from ${BRANCH}"
      }
    }

    stage('Trigger Tests for All Folders') {
      steps {
        script {
          def folders = [
            'banner',
            'birth_profile',
            'country',
            'currency_bills',
            'faq',
            'my',
            'notification_subscribers',
            'notification_subscriptions',
            'permission',
            'preferences',
            'products',
            'redeem_code',
            'testimonials',
            'users',
            'wallet'
          ]

          def results = [:]

          folders.each { folder ->
            echo "➡️ Triggering Server Api with SPEC_FOLDER = '${folder}'"
            def result = build job: 'Server Api',  // 🔁 Must match exact freestyle job name
              parameters: [string(name: 'SPEC_FOLDER', value: folder)],
              propagate: false,
              wait: true

            results[folder] = result.result
          }

          echo "\n🧾 ---- Cypress Test Summary ----"
          results.each { folder, status ->
            echo "${folder.padRight(25)} : ${status}"
          }

          if (results.values().any { it != 'SUCCESS' }) {
            echo "\n⚠️ Some tests failed or were unstable."
            currentBuild.result = 'UNSTABLE'
          } else {
            echo "\n✅ All tests passed successfully."
          }
        }
      }
    }
  }
}

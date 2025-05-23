pipeline {
  agent any

  // 🟢 Trigger this pipeline from GitHub webhook
  triggers {
    githubPush()
  }

  stages {
    stage('Run Cypress Tests for All Folders') {
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

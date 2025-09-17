pipeline {
    agent any
    environment {
        IMAGE_NAME = "supermario-wine"
        CONTAINER_NAME = "supermario"
        VNC_PASSWORD = "jenkinsVnc"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-username/SuperMarioBros-Fork.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME:latest .'
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    // Stop old container if exists
                    sh 'docker rm -f $CONTAINER_NAME || true'
                    
                    // Run container with VNC and noVNC exposed
                    sh """
                    docker run -d \
                        --name $CONTAINER_NAME \
                        -p 5901:5901 -p 6901:6901 \
                        -e VNC_PW=$VNC_PASSWORD \
                        $IMAGE_NAME:latest
                    """
                }
            }
        }
    }
    post {
        success {
            echo "✅ Deployment successful!"
            echo "👉 Access noVNC at: http://<EC2_PUBLIC_IP>:6901/"
            echo "👉 Use VNC password: $VNC_PASSWORD"
        }
        failure {
            echo "❌ Deployment failed. Check Jenkins logs."
        }
    }
}

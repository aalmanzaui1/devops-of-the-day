
locals {
  app_deploy = <<-EOT
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    creationTimestamp: null
    labels:
      app: django-app
    name: django-app
  spec:
    replicas: 1
    selector:
      matchLabels:
        app: django-app
    strategy: {}
    template:
      metadata:
        creationTimestamp: null
        labels:
          app: django-app
      spec:
        containers:
        - image: alvaroalmanza/stylesage:v1
          name: django-app
          env:
          - name: DJANGO_SETTINGS_MODULE
            value: iotd.settings
          - name: RDS_DB_NAME
            value: ${aws_db_instance.appRds.name}
          - name: RDS_USERNAME
            value: ${aws_db_instance.appRds.username}
          - name: RDS_PASSWORD
            value: ${aws_db_instance.appRds.password}
          - name: RDS_HOSTNAME
            value:$ ${aws_db_instance.appRds.address}
          - name: RDS_PORT
            value: ${aws_db_instance.appRds.port}
          - name: S3_BUCKET_NAME
            value: ${aws_s3_bucket.appBucket.bucket}
          ports:
          - containerPort: 8000
  ---
  apiVersion: v1
  kind: Service
  metadata:
    name: django-app-service
  spec:
    selector:
      app: prisma-app
    ports:
      - protocol: TCP
        port: 80
        targetPort: 8000
    type: LoadBalancer

 EOT
}

resource "local_file" "container1_deployment" {
  filename   = "/tmp/django_deployment.yml"
  content    = local.app_deploy
  depends_on = [aws_eks_cluster.eks-cluster]
}

/* provider "kubernetes" {
  host                   = aws_eks_cluster.eks-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority[0].data)
  token                  = aws_eks_cluster_auth.eks-cluster.token
  load_config_file       = false
}

resource "kubernetes_deployment" "django-app" {
  metadata {
    name      = "django-app"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "django-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "django-app"
        }
      }
      spec {
        container {
          image = "alvaroalmanza/django-app:develop"
          name  = "django-app"
          port {
            container_port = 8000
          }
          env {
            DJANGO_SETTINGS_MODULE = "iotd.settings"
            RDS_DB_NAME            = "${aws_db_instance.appRds.name}"
            RDS_USERNAME           = "${aws_db_instance.appRds.username}"
            RDS_PASSWORD           = "${aws_db_instance.appRds.password}"
            RDS_HOSTNAME           = "${aws_db_instance.appRds.address}"
            RDS_PORT               = "${aws_db_instance.appRds.port}"
            S3_BUCKET_NAME         = "${aws_s3_bucket.appBucket.bucket}"
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "django-app" {
  metadata {
    name      = "django-app"
  }
  spec {
    selector = {
      app = kubernetes_deployment.django-app.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 8000
    }
  }
} */
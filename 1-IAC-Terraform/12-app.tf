
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
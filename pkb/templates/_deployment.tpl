{{- define "pkb.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "{{- .name -}}-deployment"
spec:
  replicas: {{ .replicas }}
  selector:
    matchLabels:
      app: {{ .name | quote }}
  template:
    metadata:
      labels:
        app: {{ .name | quote }}
      annotations:
        k8s.grafana.com/scrape: 'true'
    spec:
      containers:
        - name: "{{- .name -}}-app"
          image: "{{ .podValues.image.name }}:{{ .podValues.image.tag | default .appVersion }}"
          imagePullPolicy: {{ .podValues.image.pullPolicy | quote }}
          ports:
            - containerPort: 8000
          env: {{- .podValues.env | toYaml | nindent 12 }}
          readinessProbe:
            httpGet:
              path: /healthcheck
              port: 8000
            initialDelaySeconds: 5
            periodSeconds: 10
            timeoutSeconds: 2
            successThreshold: 1
            failureThreshold: 3
          livenessProbe:
            httpGet:
              path: /healthcheck
              port: 8000
            initialDelaySeconds: 10
            periodSeconds: 20
            timeoutSeconds: 2
            successThreshold: 1
            failureThreshold: 3
{{- end }}

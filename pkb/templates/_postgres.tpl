{{- define "pkb.postgres" -}}
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ .name | quote }}
spec:
  serviceName: {{ .name | quote }}
  replicas: {{ .replicas }}
  selector:
    matchLabels:
      app: {{ .name | quote }}
  template:
    metadata:
      labels:
        app: {{ .name | quote }}
    spec:
      containers:
        - name: "{{- .name -}}-postgres"
          image: "{{ .podValues.image.name }}:{{ .podValues.image.tag | default "latest" }}"
          imagePullPolicy: {{ .podValues.image.pullPolicy | quote }}
          ports:
            - containerPort: 5432
          env: {{- .podValues.env | toYaml | nindent 12 }}
          volumeMounts:
            - name: "{{- .name -}}-postgres-data"
              mountPath: /var/lib/postgresql/data
          readinessProbe:
            exec:
              command: ["pg_isready" ,"-U" ,"$(POSTGRES_USER)"]
            initialDelaySeconds: 5
            periodSeconds: 10
            timeoutSeconds: 5
            successThreshold: 1
            failureThreshold: 3
          livenessProbe:
            exec:
              command: ["pg_isready" ,"-U" ,"$(POSTGRES_USER)"]
            initialDelaySeconds: 30
            periodSeconds: 20
            timeoutSeconds: 5
            successThreshold: 1
            failureThreshold: 5
  volumeClaimTemplates:
    - metadata:
        name: "{{- .name -}}-postgres-data"
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 1Gi
{{- end }}

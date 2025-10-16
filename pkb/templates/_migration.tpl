{{- define "pkb.migration" -}}
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ .migration.name | quote }}
spec:
  template:
    spec:
      containers:
        - name: {{ .migration.name | quote }}
          image: "{{- .migration.image.name -}}:{{- .migration.image.tag | default .appVersion -}}"
          imagePullPolicy: {{ .migration.image.pullPolicy }}
          command:
            {{- range .migration.image.command }}
              - {{ . | quote }}
            {{- end }}
          {{- if .migration.env }}
          env: {{- .migration.env | toYaml | nindent 12 }}
          {{- end }}
      restartPolicy: Never
{{- end }}

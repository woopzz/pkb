{{- define "pkb.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: "{{- .name -}}-service"
spec:
  selector:
    app: {{ .name | quote }}
  ports: {{- .ports | toYaml | nindent 4 }}
{{- end }}

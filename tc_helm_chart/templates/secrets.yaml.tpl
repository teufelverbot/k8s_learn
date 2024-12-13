{{- if .Values.secret }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Values.name }}-secret
type: Opaque
stringData:
  {{- range $key, $val := .Values.secret }}
  {{ $key }}: {{ $val }}
  {{- end }}
{{- end }}

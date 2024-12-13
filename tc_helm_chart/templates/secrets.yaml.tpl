{{- if .Values.secret.enabled -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Values.name }}-secret
type: Opaque
{{- if .Values.stringdata }}
stringData:
  id_ed25519: {{ .Values.stringdata.secret.privatekey -}}
  password: {{ .Values.stringdata.secret.password -}}
{{- end }}
{{- if .Values.secret.data }}
data:
  {{- range $key, $val := .Values.data }}
  {{ $key }}: {{ $val }}
  {{- end }}
{{- end }}
{{- end }}
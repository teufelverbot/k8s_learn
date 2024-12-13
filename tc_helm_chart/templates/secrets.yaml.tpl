{{- if .Values.secret.enabled -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Values.name }}-secret
type: Opaque
{{- if .Values.secret }}
stringData:
  {{- range $key, $val := .Values.secret }}
  {{ $key }}: {{ $val | b64enc | quote }}
  {{- end }}
{{- end }}
{{- if .Values.secret.data }}
# data:
#   {{- range $key, $val := .Values.secret.data }}
#   {{ $key }}: {{ $val | b64enc | quote }}
#   {{- end }}
# {{- end }}
# {{- end }}
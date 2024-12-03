{{- if .Values.ingress.enabled -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Release.Name }}-ingress
spec:
  ingressClassName: {{ .Values.ingress.className }}
  rules:
  {{- range .Values.ingress.hosts }}
  - host: {{ .host }}
    http:
      paths:
        - path: {{ .path | quote }}
          pathType: {{ .pathType }}
          backend:
            service:
              name: {{ .name }}
              port:
                number: {{ .number }}
  {{- end }}
{{- end }}



{{/*
{{ .Files.Get "ingress-values.yaml" | indent 2 }}
{{- end}}
  labels:
    {{- toYaml .Values.ingress.labels | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- with .Values.ingress.className }}
  ingressClassName: {{ . }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            {{- with .pathType }}
            pathType: {{ . }}
            {{- end }}
            backend:
              service:
                {{- with .name }}
                name: {{ . }}
                {{- end }}
                port:
                  {{- with .number }}
                  number: {{ .number }}
                  {{- end }}
          {{- end }}
    {{- end }}
*/}}
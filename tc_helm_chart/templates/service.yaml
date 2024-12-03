apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.name | default .Release.Name }}-svc
spec:
  ports:
  {{- range .Values.servicePorts }}
  - name: {{ .name | default ""}}
    protocol: {{ .protocol | default "TCP"}}
    port: {{ .port }}
    targetPort: {{ .targetPort }}
  {{- end }}
  selector:
    app: {{ .Values.name }}
  type: {{ .Values.serviceType }}

apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ tpl ($.Values.name | toYaml) $ | default .Release.Name }}
  labels:
    app: {{ $.Values.name | default .Release.Name }}
spec:
  replicas: {{ $.Values.replicas }}
  selector:
    matchLabels:
      app: {{ .Values.name }}
  template:
    metadata:
      labels:
        app: {{ .Values.name }}
    spec:
      # securityContext:
      #   runAsUser: 1000
      #   runAsGroup: 1000
      #   fsGroup: 1000
      containers:
      - name: {{ .Values.name }}
        image: {{ .Values.image }}
        {{- if .Values.env.sname }}
        env:
        {{- range .Values.env }}
        - name: {{ .name }}
          valueFrom:
            secretKeyRef:
              name: {{ .sname }}
              key: {{ .skey }}
        {{- end }}
        {{ else }}
        env:
        {{- range .Values.env }}
        - name: {{ .name }}
          value: {{ .value }}
        {{- end }}
        {{- end }}
        ports: 
        {{- range .Values.ports }}
        - name: {{ .name | default "" }}
          protocol: {{ .protocol }}
          containerPort: {{ .containerPort }}
        {{- end }}
        volumeMounts: 
          {{- range .Values.volumeMounts }}
          - name: {{ .name }}
            mountPath: {{ .mountPath }}
            # {{- if .subPath }}
            # subPath: {{ .subPath }}
            # {{- end -}}
            {{- if .readOnly }}
            readOnly: {{ .readOnly | default true }}
            {{- end -}}
          {{- end }}
      volumes: 
        {{- range .Values.volumes }}
        - name: {{ .name }}
          {{- if .hostPath }}
          hostPath:
            path: {{ .hostPath.path }}
            type: {{ .hostPath.type }}
          {{- end -}}
          {{- if .secret }}
          secret:
            secretName: {{ $.Values.name }}-{{ .secret.secretName }}
          {{- end -}}
        {{- end }}

FROM openjdk:9

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget http://downloadirpf.receita.fazenda.gov.br/irpf/2018/irpf/arquivos/IRPF2018-1.6.zip -O irpf2018.zip \
    && unzip irpf2018.zip -d /opt/ \
    && mv /opt/IRPF*/ /opt/irpf2018

RUN groupadd --gid 1000 irpf && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash irpf

USER irpf

ENV TZ=America/Sao_Paulo

CMD ["java", "-Xms128M", "-Xmx512M", "-jar", "/opt/irpf2018/irpf.jar"]

FROM openjdk:8

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget http://downloadirpf.receita.fazenda.gov.br/irpf/2017/irpf/arquivos/IRPF2017-1.1.zip -O irpf2017.zip \
    && unzip irpf2017.zip -d /opt/ \
    && mv /opt/IRPF*/ /opt/irpf2017

RUN groupadd --gid 1000 irpf && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash irpf

USER irpf

CMD ["java", "-Xms128M", "-Xmx512M", "-jar", "/opt/irpf2017/irpf.jar"]

FROM openjdk:9

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget http://downloadirpf.receita.fazenda.gov.br/irpf/2019/gcap/GCAP2019v1.2.zip -O GCAP2019v1.2.zip \
    && unzip GCAP2019v1.2.zip -d /opt/ \
    && mv /opt/GCAP*/ /opt/gcap2019

RUN groupadd --gid 1000 gcap && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash gcap

USER gcap

CMD ["java", "-Xms128M", "-Xmx512M", "-jar", "/opt/gcap2019/GCAP.jar"]

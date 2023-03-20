FROM openjdk:11

RUN chmod 1777 /tmp \
    && apt-get update \
    && apt-get install -o APT::Immediate-Configure=0 -y --no-install-recommends libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://downloadirpf.receita.fazenda.gov.br/irpf/2023/irpf/arquivos/IRPF2023-1.1.zip -O IRPF2023.zip
RUN unzip IRPF2023.zip -d /opt/

RUN groupadd --gid 1000 irpf && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash irpf

USER irpf

ENV TZ=America/Sao_Paulo

CMD ["java", "-Xms128M", "-Xmx512M", "-jar", "/opt/IRPF2023/irpf.jar"]

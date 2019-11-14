# Technická dokumentácia

## Meno: Ján Nemčík

## Predmet: APS

## Ak. rok: 2019/2020

## Obsah

- [1. Zadanie projektu](#zadanie)

- [2. Návrh](#navrh)

- [3. Implementácia](#implementacia)

- [4. Testovanie](#testing)

- [5. Používateľská príručka](#manual)

<a name="zadanie"></a>

## 1. Zadanie projektu

Zadaním tohto projektu bolo otestovanie konkrétneho scenáru na rôznych typoch virtualizácií a porovnať výsledky medzi jednotlivými typmi. Pre tento účel som si ako scenár zadefinoval build linux kernel-u. V tomto projekte som použil definíciu pre zariadenie [Odroid X-2](https://www.hardkernel.com/shop/odroid-x2/). Pôvodným zámerom bolo buildenie kernelu pre debian, čo sa ale ukázalo pri softvérovej virtualizácii ako nevhodný scenár, nakoľko trval rádovo dni. Taktiež som mal v úmysle buildovať kernel na nasledujúcich typoch virtualizácie:

- hardvérová
- softvérová
- paravirtualizácie
- kontajnerizácia

Z týchto typov som ale vylúčil paravirtualizáciu, nakoľko by bolo potrebné zakomponovať softvér, ktorý paravirtualizáciu podporuje do grub loaderu môjho počítača, čo som považoval za príliš nebezpečné.

<a name="navrh"></a>

## 2. Návrh

<a name="implementacia"></a>

## 3. Implementácia

<a name="testing"></a>

## 4. Testovanie

<a name="manual"></a>

## 5. Používateľská príručka

Tento projekt pozostáva z nasledujúcih scriptov:

- [build-kernel.sh](#kernel)
- [build-docker.sh](#docker)
- [run-docker.sh](#docker_run)
- [get-result.sh](#result)
- [virt-install.sh](#install)

Každý z vyššie vymenovaných sciptov, okrem _build-docker_, obsahuje svoj vlastný _help_, a preto budú v nasledujúcich podsekciách iba zhrnuté ich úlohy, _help_ je možné vykonať nasledovne: _<script_name> -h|--help_.

<a name="kernel"></a>

### **<p>build-kernel.sh</p>**

Tento script nainštaluje potrebne dependencies pre build kernelu a pre spracovanie výsledkov. Súčasťou scriptu je taktiež stiahnutie a rozbalenie samotného kernelu. Po týchto krokoch sa spustí samotný build pomocou príkazu make. Po úspešnom vykonaní buildu sa odstránia stiahnuté súbory a výsledky sa odošlú na server. Používateľ má taktiež možnosť po vykonaní buildu odstrániť všetky doinštalované dependencies (viac v _help_-e scriptu). Script taktiež umožňuje definovať počet jadier, na ktorých build prebiehať (viac v _help_-e scriptu). **Script je potrebné spúštať ako sudo user, poprípade s userom, ktorý ma práva inštalovať dependencies ako root!**

Inštalované dependencies:

build-essential \
libncurses-dev \
bison \
flex \
libssl-dev \
libelf-dev \
bc \
time \
curl \
jq \
wget

<a name="docker"></a>

### **<p>build-docker.sh</p>**

Tento script builduje docker image z Dockerfile v aktuálnom adresári a taguje ho ako aps:latest. Využiteľný v prípade, že nie je dostupný image z [Docker hub](https://hub.docker.com/r/jany15/aps)-u, je možné po zbuildovaní spustiť container priamo lokálne pomocou príkazu [docker run](https://docs.docker.com/engine/reference/commandline/run/) alebo spustením scriptu run-docker.sh.

<a name="docker_run"></a>

### **<p>run-docker.sh</p>**

Tento script zabezpečuje spestenie docker containera podľa predpripravenej definície, ktorá už obsahuje všetky potrebné dependencie aj samotný priečinok s kernel modulmi. Pri spustení containera sa automacitky spustí build kernelu. Po ukončení sa výsledky odošlú na server a container sa zastaví a vymaže. Script obsahuje možnosť -r --results s hodnotami _auto_ alebo _load_, kde _auto_ znamená, že výsledky sa automaticky zobrazia pre posledný vykonaný build v docker containeri. Možnosť _load_ hovorí o tom, že používateľ chce výsledky zobraziť manuálne, viac informácií o možnostiach scriptu na sa nachádzajú v _help_-e.

<a name="result"></a>

### **<p>get-result.sh</p>**

Tento script slúži na získanie výsledkov buildov kernelu v rámci projektu. Ponúka rôzne možnosti filtrovania a formátovania výstupu. Všetky prípady použitia sú popísané v _help_-e scriptu. **Dependencie potrebné pre získanie výsledkov boli nainštalované v rámci scriptu build-kernel.sh a môžu byť donštalované vykonaním príkazu ./get-result.sh -i, ktorý musí byť spustený ako sudo príkaz.**

<a name="install"></a>

### **<p>virt-install.sh</p>**

Tento script zabezpečí inštaláciu KVM virtuálneho stroja s Debian 10 OS. Všetky možnosti použitia sú popísané v _help_-e scriptu.

<div style="page-break-after: always;"></div>

https://github.com/JanNemcik/aps-project

https://hub.docker.com/r/jany15/aps

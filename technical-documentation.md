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

<a name="docker"></a>

### **<p>build-docker.sh</p>**

<a name="docker_run"></a>

### **<p>run-docker.sh</p>**

<a name="result"></a>

### **<p>get-result.sh</p>**

<a name="install"></a>

### **<p>virt-install.sh</p>**

<div style="page-break-after: always;"></div>

https://github.com/JanNemcik/aps-project

https://hub.docker.com/r/jany15/aps

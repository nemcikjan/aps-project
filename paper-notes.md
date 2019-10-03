# System performance evaluation using different virtuazlization techniques

## Definition of problem

In this evaluation, we will emulate several virtualization types and in created environments we will try to use building of Linux kernel as a benchmark use case.

## Virtualization environments

For emulation purposes we will use Windows 10 and Ubuntu 19.04 as host machines and on the same hardware to ensure specification consistency for performed tests. For emulation we choosed following techniques:

- containerization (Docker - Windows, Linux)
- full virtualization

  - software (VirtualBox, KVM)
  - hardware (KVM, HYPER-V)

- para virtualization (Xen, ...)

## What to do

- measure guest machine performance during building of Linux kernel
- measure host machine impact due to VMx
- advantages/disadvantages of usage different virtualization approaches as result of defined problem

## Evaluation

- best virtualization -> high performance of guest machine / low impact on host machine
- differences between each virtualization

As a result we will provide couple of figures with comparisions given above

## Sources

1. A. B. S., H. M.J., J. P. Martin, S. Cherian and Y. Sastri, "System Performance Evaluation of Para Virtualization, Container Virtualization, and Full Virtualization Using Xen, OpenVZ, and XenServer," 2014 Fourth International Conference on Advances in Computing and Communications, Cochin, 2014, pp. 247-250.
2. B. Lakshmikanth and M. R. Mundada, "Automation Framework Development for Continuous Integration and Deployment in CT Machines Using LXC and Docker Container Lightweight Virtualization Techniques," 2018 International Conference on Current Trends towards Converging Technologies (ICCTCT), Coimbatore, 2018, pp. 1-4.
3. G. Nakagawa and S. Oikawa, "Behavior-Based Memory Resource Management for Container-Based Virtualization," 2016 4th Intl Conf on Applied Computing and Information Technology/3rd Intl Conf on Computational Science/Intelligence and Applied Informatics/1st Intl Conf on Big Data, Cloud Computing, Data Science & Engineering (ACIT-CSII-BCD), Las Vegas, NV, 2016, pp. 213-217.
4. M. G. Xavier, M. V. Neves, F. D. Rossi, T. C. Ferreto, T. Lange and C. A. F. De Rose, "Performance Evaluation of Container-Based Virtualization for High Performance Computing Environments," 2013 21st Euromicro International Conference on Parallel, Distributed, and Network-Based Processing, Belfast, 2013, pp. 233-240.
5. X. Hu, B. Cong, Z. Xi and K. Li, "Hardware-virtualization-based software compatibility analysis method and its applications," 2014 IEEE International Conference on Progress in Informatics and Computing, Shanghai, 2014, pp. 442-445.
6. V. Soundararajan, B. Agrawal, B. Herndon, P. Sethuraman and R. Taheri, "Benchmarking a virtualization platform," 2014 IEEE International Symposium on Workload Characterization (IISWC), Raleigh, NC, 2014, pp. 99-109.
7. C. H. Kao, P. Chi and Y. Lee, "Automatic Testing Framework for Virtualization Environment," 2014 IEEE International Symposium on Software Reliability Engineering Workshops, Naples, 2014, pp. 134-135
8. X. Xie, Q. Chen, W. Cao, P. Yuan and H. Jin, "Benchmark Object for Virtual Machines," 2010 Second International Workshop on Education Technology and Computer Science, Wuhan, 2010, pp. 28-31.

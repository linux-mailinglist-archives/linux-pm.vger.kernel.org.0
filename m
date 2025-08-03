Return-Path: <linux-pm+bounces-31779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B916EB19324
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4501B3B429A
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2D280CE5;
	Sun,  3 Aug 2025 08:55:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pd.grulic.org.ar (pd.grulic.org.ar [200.16.16.187])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2AE35977
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.16.16.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754211354; cv=none; b=CpTUHDc5QmeUS/uKUmn1Yu2N7xCPHltdAfj2S2AohzI3yfga/Y/9p+xQ7sfM0fM4pviACUoTHm7hKs74PPZ5V2H7/wq1fra4jHruf21YCwsjAxd1tIMjOZHL5CYN7cm0hD3n8quyKzvJV7R2hhsNGybEI2AKCUTLLNOdYyzqXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754211354; c=relaxed/simple;
	bh=3hTJg1eG2I41SpUdp9iKEGxutZm5SrgfbgXCpDuYjiA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ksC6gPBoFewOMjGtuodwm84stK5SLKO0pPwunfLRytgEz5G1bv0hYcypjGf399v3jKAiTKzzsdKLFjCLNdNSrYtPjXGjiYZiqJ8dDLhDOEh7P0tUlRR8/VmhnjDh4TaioZuB3tTIqWiIvyZQ++hy4gqxy3B2hTqsR2iv/7sQLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar; spf=pass smtp.mailfrom=grulic.org.ar; arc=none smtp.client-ip=200.16.16.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grulic.org.ar
Received: from localhost (82-64-43-81.subs.proxad.net [82.64.43.81])
	by pd.grulic.org.ar (Postfix) with ESMTPSA id 4C0AF80F4A
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 05:57:49 -0300 (-03)
Date: Sun, 3 Aug 2025 10:55:45 +0200
From: Marcos Dione <mdione@grulic.org.ar>
To: linux-pm@vger.kernel.org
Subject: [Possible bug]: thermal and an scaling governor issues
Message-ID: <aI6Pb99qXaSaB-Fy@ioniq>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


    Before anything, please CC: me, as I'm not subscribed to the list.

    Right now I'm running 6.12.38+deb13-amd64 from Debian
testing/unstable, which are the same due to the freeze until next week :)

    First, some HW info:

* kernel modules:

Module                  Size  Used by
acpi_thermal_rel       20480  1 int3400_thermal
aesni_intel           122880  6
battery                28672  1 dell_laptop
binfmt_misc            28672  1
dcdbas                 20480  1 dell_smbios
dell_laptop            40960  0
dell_pc                12288  0
dell_rbtn              20480  0
dell_smbios            36864  3 dell_wmi,dell_pc,dell_laptop
dell_smm_hwmon         28672  0
dell_wmi               16384  0
dell_wmi_descriptor    20480  2 dell_wmi,dell_smbios
gf128mul               16384  1 aesni_intel
ghash_clmulni_intel    16384  0
i2c_algo_bit           16384  1 i915
i2c_dev                28672  0
i2c_hid                40960  1 i2c_hid_acpi
i2c_hid_acpi           12288  0
i2c_i801               36864  0
i2c_smbus              16384  1 i2c_i801
i915                 4386816  178
iTCO_vendor_support    12288  1 iTCO_wdt
iTCO_wdt               16384  0
idma64                 20480  0
int3400_thermal        20480  0
int3403_thermal        16384  0
int340x_thermal_zone    16384  2 int3403_thermal,processor_thermal_device
intel_cstate           20480  0
intel_hid              28672  0
intel_lpss             12288  1 intel_lpss_pci
intel_lpss_pci         28672  0
intel_pch_thermal      16384  0
intel_pmc_bxt          16384  1 iTCO_wdt
intel_pmc_core        122880  0
intel_powerclamp       16384  0
intel_rapl_common      53248  2 intel_rapl_msr,processor_thermal_rapl
intel_rapl_msr         20480  0
intel_soc_dts_iosf     16384  1 processor_thermal_device_pci_legacy
intel_uncore          258048  0
intel_uncore_frequency    12288  0
intel_uncore_frequency_common    16384  1 intel_uncore_frequency
intel_vsec             20480  1 intel_pmc_core
intel_wmi_thunderbolt    16384  0
platform_profile       12288  1 dell_pc
pmt_class              16384  1 pmt_telemetry
pmt_telemetry          16384  1 intel_pmc_core
ppdev                  24576  0
processor_thermal_device    20480  1 processor_thermal_device_pci_legacy
processor_thermal_device_pci_legacy    12288  0
processor_thermal_mbox    12288  4 processor_thermal_power_floor,processor_thermal_wt_req,processor_thermal_rfim,processor_thermal_wt_hint
processor_thermal_power_floor    12288  1 processor_thermal_device
processor_thermal_rapl    16384  1 processor_thermal_device
processor_thermal_rfim    24576  1 processor_thermal_device
processor_thermal_wt_hint    16384  1 processor_thermal_device
processor_thermal_wt_req    12288  1 processor_thermal_device
sparse_keymap          12288  2 intel_hid,dell_wmi
watchdog               49152  2 iTCO_wdt,mei_wdt

* CPU info:

$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 158
model name      : Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
stepping        : 9
microcode       : 0xde
cpu MHz         : 1099.995
cache size      : 6144 KB
physical id     : 0
siblings        : 8
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb pti ssbd ibrs ibpb stibp tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi md_clear flush_l1d
vmx flags       : vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple pml ept_violation_ve ept_mode_based_exec
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit srbds mmio_stale_data retbleed gds
bogomips        : 5599.85
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

    Is it OK that the last line is empty?

* lshw:

    description: Notebook
    product: Precision 5520 (07BF)
    vendor: Dell Inc.
    serial: 7ZZVQN2
    width: 64 bits
    capabilities: smbios-3.0.0 dmi-3.0.0 smp vsyscall32
    configuration: boot=normal chassis=notebook family=Precision sku=07BF uuid=4c4c4544-005a-5a10-8056-b7c04f514e32
  *-core
       description: Motherboard
       product: 0NKT5P
       vendor: Dell Inc.
       physical id: 0
       version: A00
       serial: /7ZZVQN2/CN1296384S0016/
        *-generic:0
             description: Signal processing controller
             product: Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
             vendor: Intel Corporation
             physical id: 4
             bus info: pci@0000:00:04.0
             version: 05
             width: 64 bits
             clock: 33MHz
             capabilities: msi pm cap_list
             configuration: driver=proc_thermal latency=0
             resources: irq:16 memory:ecc20000-ecc27fff
        *-generic:1
             description: Signal processing controller
             product: 100 Series/C230 Series Chipset Family Thermal Subsystem
             vendor: Intel Corporation
             physical id: 14.2
             bus info: pci@0000:00:14.2
             version: 31
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi cap_list
             configuration: driver=intel_pch_thermal latency=0
             resources: irq:18 memory:ecc38000-ecc38fff
        *-generic:2
             description: Signal processing controller
             product: 100 Series/C230 Series Chipset Family Serial IO I2C Controller #0
             vendor: Intel Corporation
             physical id: 15
             bus info: pci@0000:00:15.0
             version: 31
             width: 64 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list
             configuration: driver=intel-lpss latency=0
             resources: irq:16 memory:ecc37000-ecc37fff
        *-generic:3
             description: Signal processing controller
             product: 100 Series/C230 Series Chipset Family Serial IO I2C Controller #1
             vendor: Intel Corporation
             physical id: 15.1
             bus info: pci@0000:00:15.1
             version: 31
             width: 64 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list
             configuration: driver=intel-lpss latency=0
             resources: irq:17 memory:ecc36000-ecc36fff
  *-battery
       product: DELL GPM0365
       vendor: SMP
       physical id: 1
       version: 10/25/2019
       serial: 0CA7
       slot: Sys. Battery Bay
       capacity: 97000mWh
       configuration: voltage=11,4V

* sensors:

$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +47.0°C  (high = +100.0°C, crit = +100.0°C)
Core 0:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
Core 1:        +47.0°C  (high = +100.0°C, crit = +100.0°C)
Core 2:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
Core 3:        +45.0°C  (high = +100.0°C, crit = +100.0°C)

pch_skylake-virtual-0
Adapter: Virtual device
temp1:        +67.0°C  

nvme-pci-0300
Adapter: PCI adapter
Composite:    +42.9°C  (low  =  -5.2°C, high = +79.8°C)
                       (crit = +84.8°C)

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +25.0°C  

iwlwifi_1-virtual-0
Adapter: Virtual device
temp1:        +33.0°C  

dell_smm-isa-00de
Adapter: ISA adapter
fan1:        2506 RPM  (min =    0 RPM, max = 4900 RPM)
fan2:        2506 RPM  (min =    0 RPM, max = 4900 RPM)
temp1:        +47.0°C  
temp2:        +46.0°C  
temp3:        +42.0°C  
temp4:        +42.0°C  
temp5:        +46.0°C  
temp6:        +39.0°C  
temp7:        +55.0°C  
temp8:        +42.0°C  
pwm1:             64%
pwm2:             64%

BAT0-acpi-0
Adapter: ACPI interface
in0:          12.68 V  
curr1:       1000.00 uA 

============= 8< ===============

    It all seems to have started at the beginning of the year. The
symptom was hiccups which could be seen as high load (f.i. 40 on an 8
core machine) with not much CPU usage. I tracked it down to
prometheus-node-exporter stalling on disk accesses. Looking with strace
I find there were multisecond reads on files related to sensors in
general, which I still experience:

23:30:13.855780 (+     0.004490) openat(AT_FDCWD, "/sys/class/hwmon/hwmon1/in0_input", O_RDONLY) = 3 <0.000152>
23:30:13.856286 (+     0.000494) fstat(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0 <0.000052>
23:30:13.856574 (+     0.000286) read(3, "12686\n", 4096) = 6 <3.196855>
23:30:17.053632 (+     3.197072) close(3) = 0 <0.000061>

23:33:39.689505 (+     0.000167) openat(AT_FDCWD, "/sys/class/hwmon/hwmon5/fan1_input", O_RDONLY) = 3 <0.000081>
23:33:39.689708 (+     0.000201) fstat(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0 <0.000047>
23:33:39.689870 (+     0.000164) read(3, "3225\n", 4096) = 5 <0.018190>
23:33:39.708237 (+     0.018376) close(3) = 0 <0.000060>

23:33:39.710771 (+     0.000151) openat(AT_FDCWD, "/sys/class/hwmon/hwmon5/fan2_input", O_RDONLY) = 3 <0.000073>
23:33:39.710947 (+     0.000176) fstat(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0 <0.000042>
23:33:39.711089 (+     0.000141) read(3, "3215\n", 4096) = 5 <0.128783>
23:33:39.840088 (+     0.129024) close(3) = 0 <0.000067>

    Accumulating all those reads led to the node exporter to gradually
take more and more time to finish the scrape, going beyond the 15s
between scrapes. I'm not sure, but I think that the node exporter just
launches goroutines to do these sweeps and they just pile up one on top
of the other. I had to disable the collectors for hwmon, thermal_zone
and powersupplyclass.

    That's problem #1.

    Today I was (ab)using the 8 cores compiling stuff, while watching
videos, so a load of above 10. I'm using (KDE's?) upowerd, but I'm not
sure this has any impact. KDE's power plasmoid shows it's using the
performance governor, but checking the files I get another story:

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
powersave
powersave
powersave
powersave
powersave
powersave
powersave
powersave

    So I manually set them to performance:

$ echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance
performance
performance
performance
performance
performance
performance
performance

    But CPU frequency stays below the 1GHz for a 3.8GHz CPU and the
temps stay below 47C.

    Now, I'm not sure if these things are connected, but I wager they
do. Even if they aren't, they are annoying independently. The problem
is: I have no idea how to debug this. I see no particular info in dmesg.
I tried other Debian kernel versions all down to the latest 5.x I could
get from snapshots.d.o. I'm open to a slow tracking down of this thing
because the distro has been working on this HW for some 6.5y before
these behaviors. My other alternative is to buy new HW.

    Cheers,

	-- Marcos.


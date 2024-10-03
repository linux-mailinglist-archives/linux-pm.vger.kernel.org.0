Return-Path: <linux-pm+bounces-15105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CDD98F250
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DC4283F24
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06A1A0AF8;
	Thu,  3 Oct 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBkgilcE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9744779F;
	Thu,  3 Oct 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968565; cv=none; b=bSi9FHj/KMHZHzgE7LudjGiop9xtxEb2agDwLjS9qrX5sAGpDLVIKAsAFy7oi2/N/1+lllzsnfG7YwsT4L2ZEMWccBepKll1x4rubrbONcjUSE2MDJvX0fWgdQxsvKTPF7CMQIvvhlKTFiLsLQDpnQKPD11U+G0F1PKIJlSZKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968565; c=relaxed/simple;
	bh=ULEFalfJIBmkulEUN8RCG1+i9fevcvBDwpKEQDf8AZg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=YwyO7ZgpltjOpcSK67MecFAC7Al9DcOkDT4Z+MtYj0Om3kGOw9AzwcwBwh7PbL0AesG8FTgY/KTx75jQUcwu20T38OngP8eKTOK6zllSpCqW1gggi9mJL5UxQ9EkhgiXQ3qlpRn4/bTJNpaWaqywMxP8wJZkgOtKjiQAVyeUFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBkgilcE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5389917ef34so1276331e87.2;
        Thu, 03 Oct 2024 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727968559; x=1728573359; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75ZEPPMwPeGa+94YDT2A1TsDimVVq8yX77PAqisT0jI=;
        b=VBkgilcEeD2EBh5vcIFLhCx4zi1QNdV8/YA8pyQVDttGLVJyds9GdTtkvUzJkcNas9
         31dTP28s1/PDL7PJbP5jslQcbFwIj9BswIIHQEvBoltoN1kGgqJv9Hsx+DLMOhL9lQQo
         bH+zFq3wE2c71Bck5GwdPrPTyqPe3LGBfAVQE8DnHAInBBz3K/CB75VzVjC748KBxExd
         vveEHnEybLFwL19RQ100rKO5RVZ5PsDoq2obgN6MpV3QqX3DH8p4UaO6PZ0jp6Emffkv
         Mj3QDZt3LD+AcQbEQ6zr+s2Whxzx9SrN3u+8oWzi3oN6TJTHYWYVlspNgyvsIYbGOgZ1
         nhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968559; x=1728573359;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=75ZEPPMwPeGa+94YDT2A1TsDimVVq8yX77PAqisT0jI=;
        b=gTbqrDa5kCBCpifKHHwGKLA55KOJaHciHKV5C2eAVwcE0FUGwzPNsH/qNy2Vf245eJ
         NRNPFoVL0Y1T1dK5GTqEMTH/uzimOm6wHj5LcRa74B/vFd6CDCf/0yx9CDsqO0LS1Ekk
         zeMFpK9TDms2iJiDXtfSrYsI4xI2ZNY17hHIa1sGffhglgF34vstl4WkrKiZk6+leWHW
         UDVNHXd5DvdwUbGKSt3SIGH1mbnr3SunvSLGBvAkiUp+OLH99gB37vaprUOfsGwyzi/5
         cG3xj0qkAEdpVX3mF0out2Rr2bxNREuR9d8fH+T9SZd6uTyv8YoEDUgzHATXfNm7KxWq
         QfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTNrSX212ZQZVwinqVSmdRmAny+ArkH2x3F1v9z/W0ElLLzM7jcr+wbivSe0UvB4ySGlQdM8k5IfY=@vger.kernel.org, AJvYcCX9l8q67DhpkytBA0cbPbnabC5s3mlNkFIqLkgGpW/c3oJpZJAkWxyt8+tZLg4N7OH78XPHhdkBxGsFTx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBR/qfYZ0SJiAibepTH4iFQ6IGCJlqEIpjQDOU3jitqLj92SLY
	OHu7ZoNGtk18YotbK/eoEbIuOaQ5vQb6MqWmJcsiUsVwKJi31L+/Fqu2O0fS
X-Google-Smtp-Source: AGHT+IFSNKAR1CqpIUBuTjGoLlj9OTNK5ezJyNF/CmFdO9hFGeJhQcKRZ5mejP7RL2baUHa0hcnT2A==
X-Received: by 2002:a05:6512:b18:b0:52c:dfa0:dca0 with SMTP id 2adb3069b0e04-539a0793cd9mr4668670e87.43.1727968557867;
        Thu, 03 Oct 2024 08:15:57 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802b26a6sm17769235e9.43.2024.10.03.08.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:15:56 -0700 (PDT)
Message-ID: <6e341522-70f6-413c-b9ba-8ac86a19b5f3@gmail.com>
Date: Thu, 3 Oct 2024 18:15:49 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, tr, en-GB
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Pin-yen Lin <treapking@chromium.org>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Erroneous sbs-battery sysfs info a MT8173 Chromebook
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I have a MT8173 Chromebook ("Lenovo 300e") where I'm getting a lot of 
battery-related errors:

[   34.678473] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.702079] power_supply_show_property: 5 callbacks suppressed
[   34.702096] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   34.754401] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.782568] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.806020] power_supply sbs-6-000b: driver failed to report `manufacturer' property: -22
[   34.826135] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   34.844078] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.864128] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.889015] power_supply sbs-6-000b: driver failed to report `model_name' property: -22
[   34.895486] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   34.945035] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20

These infinitely repeat because upower keeps trying to read them. I also 
see this which might be important:

[   18.111500] cros-usbpd-charger cros-usbpd-charger.7.auto: Could not get charger port count
[   18.197166] sbs-battery 6-000b: sbs-battery: battery gas gauge device registered
[   18.248105] sbs-battery 6-000b: I2C adapter does not support I2C_FUNC_SMBUS_READ_BLOCK_DATA.
               Fallback method does not support PEC.

Properties seem to be stuck to weird values (0xffff ?):

  $ for f in /sys/class/power_supply/sbs-6-000b/*; do
      printf "$(basename "$f"):  "
      cat "$f" 2>/dev/null || echo
    done
  capacity:  100
  capacity_error_margin:  0
  capacity_level:  Full
  charge_full:  65535000
  charge_full_design:  65535000
  charge_now:  65535000
  constant_charge_current_max:  65535000
  constant_charge_voltage_max:  65535000
  current_avg:  -1000
  current_now:  -1000
  cycle_count:  65535
  device:
  energy_full:  655350000
  energy_full_design:  655350000
  energy_now:  655350000
  health:  Calibration required
  hwmon2:
  manufacture_day:  31
  manufacture_month:  15
  manufacturer:  
  manufacture_year:  2107
  model_name:
  of_node:
  power:
  present:  1
  serial_number:  ffff
  status:  Discharging
  subsystem:
  technology:  Unknown
  temp:  62804
  time_to_empty_avg:  3932100
  time_to_empty_now:  3932100
  time_to_full_avg:  3932100
  type:  Battery
  uevent:
  voltage_max_design:  65535000
  voltage_min_design:  65535000
  voltage_now:  65535000
  wakeup10:

I suspected a hardware issue, but I can get battery info from the EC 
just fine with the same kernel:

  $ sudo ectool battery
  Battery info:
    OEM name:               LGC
    Model number:           L15L3PB
    Chemistry   :           LiP
    Serial number:          0E0C
    Design capacity:        4050 mAh
    Last full charge:       3341 mAh
    Design output voltage   11100 mV
    Cycle count             115
    Present voltage         11671 mV
    Present current         344 mA
    Remaining capacity      2734 mAh
    Flags                   0x06 BATT_PRESENT DISCHARGING
  
  $ sudo ectool version
  RO version:    hana_v1.1.4824-d58e50539
  RW version:    hana_v1.1.4825-1473136d99
  Firmware copy: RW
  Build info:    hana_v1.1.4825-1473136d99 2021-09-11 00:11:48 @chromeos-ci-firmware-us-central2-d-x32-0-jx9e

I have _another_ MT8173 Chromebook ("ASUS C202X") where things work 
fine. But I couldn't find a good mainline kernel version for this one.
Anyone have any idea what is going on?

Here's the rest of kernel messages in case it helps:

------8<------

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd032]
[    0.000000] Linux version 6.12.0-rc1-next-20241001-hana-00006-g61df9cddd695 (alpernebbi@ALPER-PC) (aarch64-linux-gnu-gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP PREEMPT Tue Oct  1 19:42:30 +03 2024
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Google Hana
[    0.000000] earlycon: mtk8250 at MMIO32 0x0000000011002000 (options '115200n8')
[    0.000000] printk: legacy bootconsole [mtk8250] enabled
[    0.000000] printk: debug: skip boot console de-registration.
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000b7000000, size 5 MiB
[    0.000000] OF: reserved mem: initialized node vpu-dma-mem@b7000000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x00000000b7000000..0x00000000b74fffff (5120 KiB) nomap non-reusable vpu-dma-mem@b7000000
[    0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x13f5d2b40-0x13f5d4e7f]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000b6ffffff]
[    0.000000]   node   0: [mem 0x00000000b7000000-0x00000000b74fffff]
[    0.000000]   node   0: [mem 0x00000000b7500000-0x00000000ffefffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.000000] kasan: KernelAddressSanitizer initialized (generic)
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 25 pages/cpu s62168 r8192 d32040 u102400
[    0.000000] pcpu-alloc: s62168 r8192 d32040 u102400 alloc=25*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 843419
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] CPU features: detected: ARM errata 826319, 827319, 824069, or 819472
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: cros_secure kern_guid=e4eaab62-9817-4dd8-b6df-bb826d6584ad earlycon keep_bootcon console=tty1 console=ttyS0,115200n8 splash plymouth.ignore-serial-consoles ipv6.disable=1 kasan_multi_shot root=UUID=c16826e5-0b66-4648-87db-8a2601010f0a
[    0.000000] Unknown kernel command line parameters "cros_secure splash kern_guid=e4eaab62-9817-4dd8-b6df-bb826d6584ad", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1048320
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] stackdepot: allocating hash table via alloc_large_system_hash
[    0.000000] stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x00000000fbf00000-0x00000000fff00000] (64MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.000000] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 13.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x2ff89eacb, max_idle_ns: 440795202429 ns
[    0.000001] sched_clock: 56 bits at 13MHz, resolution 76ns, wraps every 4398046511101ns
[    0.008213] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 147020034397 ns
[    0.017368] sched_clock: 32 bits at 13MHz, resolution 76ns, wraps every 165191050201ns
[    0.025912] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.036190] Console: colour dummy device 80x25
[    0.040622] printk: legacy console [tty1] enabled
[    0.046656] Calibrating delay loop (skipped), value calculated using timer frequency.. 26.00 BogoMIPS (lpj=52000)
[    0.056892] pid_max: default: 32768 minimum: 301
[    0.061673] LSM: initializing lsm=capability,apparmor
[    0.067125] AppArmor: AppArmor initialized
[    0.071396] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.078789] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.088760] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.097566] rcu: Hierarchical SRCU implementation.
[    0.102435] rcu: 	Max phase no-delay instances is 1000.
[    0.108138] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.116540] EFI services will not be available.
[    0.121662] smp: Bringing up secondary CPUs ...
[    0.127770] Detected VIPT I-cache on CPU1
[    0.127922] CPU1: Booted secondary processor 0x0000000001 [0x410fd032]
[    0.129254] CPU features: detected: Spectre-v2
[    0.129275] CPU features: detected: Spectre-v3a
[    0.129287] CPU features: detected: Spectre-v4
[    0.129298] CPU features: detected: Spectre-BHB
[    0.129309] CPU features: detected: ARM erratum 1742098
[    0.129321] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.129332] Detected PIPT I-cache on CPU2
[    0.129435] CPU2: Booted secondary processor 0x0000000100 [0x410fd080]
[    0.130826] Detected PIPT I-cache on CPU3
[    0.130902] CPU3: Booted secondary processor 0x0000000101 [0x410fd080]
[    0.131122] smp: Brought up 1 node, 4 CPUs
[    0.196759] SMP: Total of 4 processors activated.
[    0.201463] CPU: All CPU(s) started at EL2
[    0.205613] CPU features: detected: 32-bit EL0 Support
[    0.210742] CPU features: detected: 32-bit EL1 Support
[    0.215895] CPU features: detected: CRC32 instructions
[    0.221104] alternatives: applying system-wide alternatives
[    0.228899] Memory: 3404264K/4193280K available (42368K kernel code, 8146K rwdata, 11312K rodata, 2432K init, 960K bss, 782948K reserved, 0K cma-reserved)
[    0.244783] devtmpfs: initialized
[    0.283990] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.293794] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.300837] 16400 pages in range for non-PLT usage
[    0.300850] 507920 pages in range for PLT usage
[    0.306031] pinctrl core: initialized pinctrl subsystem
[    0.316957] DMI not present or invalid.
[    0.320956] psi: inconsistent task state! task=1:swapper/0 cpu=2 psi_flags=4 clear=0 set=4
[    0.333591] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.341358] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.348703] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.356683] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.364795] audit: initializing netlink subsys (disabled)
[    0.370642] audit: type=2000 audit(0.268:1): state=initialized audit_enabled=0 res=1
[    0.372188] thermal_sys: Registered thermal governor 'step_wise'
[    0.378441] thermal_sys: Registered thermal governor 'power_allocator'
[    0.384586] cpuidle: using governor ladder
[    0.395281] cpuidle: using governor menu
[    0.400010] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.406981] ASID allocator initialised with 65536 entries
[    0.413958] Serial: AMBA PL011 UART driver
[    0.485993] platform 1401b000.dsi: Fixed dependency cycle(s) with /soc/i2c@11007000/edp-bridge@8
[    0.495593] platform 1401d000.dpi: Fixed dependency cycle(s) with /soc/hdmi@14025000
[    0.506797] platform 1401d000.dpi: Fixed dependency cycle(s) with /soc/hdmi@14025000
[    0.514937] platform 14025000.hdmi: Fixed dependency cycle(s) with /soc/dpi@1401d000
[    0.533929] platform 14025000.hdmi: Fixed dependency cycle(s) with /connector
[    0.541292] platform connector: Fixed dependency cycle(s) with /soc/hdmi@14025000
[    0.551167] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.557993] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.564277] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.571076] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.577356] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.584154] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.590433] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.597230] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.671527] raid6: neonx8   gen()   901 MB/s
[    0.743644] raid6: neonx4   gen()   903 MB/s
[    0.815790] raid6: neonx2   gen()   890 MB/s
[    0.887913] raid6: neonx1   gen()   825 MB/s
[    0.960077] raid6: int64x8  gen()   758 MB/s
[    1.032520] raid6: int64x4  gen()   938 MB/s
[    1.104639] raid6: int64x2  gen()   884 MB/s
[    1.176765] raid6: int64x1  gen()   717 MB/s
[    1.181050] raid6: using algorithm int64x4 gen() 938 MB/s
[    1.252888] raid6: .... xor() 581 MB/s, rmw enabled
[    1.257779] raid6: using neon recovery algorithm
[    1.265811] fixedregulator0 enforce active low on GPIO handle
[    1.266882] iommu: Default domain type: Translated
[    1.276441] iommu: DMA domain TLB invalidation policy: strict mode
[    1.283958] SCSI subsystem initialized
[    1.288136] libata version 3.00 loaded.
[    1.288555] usbcore: registered new interface driver usbfs
[    1.294182] usbcore: registered new interface driver hub
[    1.299609] usbcore: registered new device driver usb
[    1.305336] pps_core: LinuxPPS API ver. 1 registered
[    1.310322] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.319504] PTP clock support registered
[    1.323540] EDAC MC: Ver: 3.0.0
[    1.327552] scmi_core: SCMI protocol bus registered
[    1.336103] FPGA manager framework
[    1.339843] Advanced Linux Sound Architecture Driver Initialized.
[    1.348411] vgaarb: loaded
[    1.352151] clocksource: Switched to clocksource arch_sys_counter
[    1.359079] VFS: Disk quotas dquot_6.6.0
[    1.363076] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.372007] AppArmor: AppArmor Filesystem Enabled
[    1.394825] NET: Registered PF_INET protocol family
[    1.400082] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    1.412997] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    1.421680] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.429506] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.437797] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    1.445729] TCP: Hash tables configured (established 32768 bind 32768)
[    1.452496] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.459305] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.466810] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.473556] RPC: Registered named UNIX socket transport module.
[    1.479530] RPC: Registered udp transport module.
[    1.484255] RPC: Registered tcp transport module.
[    1.488976] RPC: Registered tcp-with-tls transport module.
[    1.494479] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.500963] PCI: CLS 0 bytes, default 64
[    1.505342] Unpacking initramfs...
[    1.519508] kvm [1]: nv: 554 coarse grained trap handlers
[    1.525618] kvm [1]: IPA Size Limit: 40 bits
[    1.533329] kvm [1]: vgic interrupt IRQ9
[    1.537339] kvm [1]: Hyp nVHE mode initialized successfully
[    1.546658] Initialise system trusted keyrings
[    1.551587] workingset: timestamp_bits=42 max_order=20 bucket_order=0
[    1.559242] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.565870] NFS: Registering the id_resolver key type
[    1.571045] Key type id_resolver registered
[    1.575256] Key type id_legacy registered
[    1.579356] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.586093] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    1.677068] NET: Registered PF_ALG protocol family
[    1.681922] xor: measuring software checksum speed
[    1.688823]    8regs           :  1573 MB/sec
[    1.695387]    32regs          :  1516 MB/sec
[    1.701394]    arm64_neon      :  2024 MB/sec
[    1.705780] xor: using function: arm64_neon (2024 MB/sec)
[    1.711235] Key type asymmetric registered
[    1.715365] Asymmetric key parser 'x509' registered
[    1.720475] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    1.728351] io scheduler mq-deadline registered
[    1.732924] io scheduler kyber registered
[    1.741466] mediatek-mipi-tx 10215000.dsi-phy: can't get nvmem_cell_get, ignore it
[    1.753400] ledtrig-cpu: registered to indicate activity on CPUs
[    1.772293] cannot find "mediatek,mt8173-fhctl"
[    1.784671] ==================================================================
[    1.791916] BUG: KASAN: slab-out-of-bounds in mtk_clk_register_fixed_clks.part.0+0x1b8/0x2e4
[    1.800380] Read of size 8 at addr ffff0000c6bb4468 by task swapper/0/1

[    1.808497] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-next-20241001-hana-00006-g61df9cddd695 #1
[    1.818768] Hardware name: Google Hana (DT)
[    1.822957] Call trace:
[    1.825405]  dump_backtrace.part.0+0xd4/0xe0
[    1.829686]  show_stack+0x18/0x30
[    1.833009]  dump_stack_lvl+0x5c/0x7c
[    1.836684]  print_report+0x160/0x4c0
[    1.840354]  kasan_report+0x9c/0xe8
[    1.843855]  __asan_report_load8_noabort+0x20/0x34
[    1.848653]  mtk_clk_register_fixed_clks.part.0+0x1b8/0x2e4
[    1.854239]  __mtk_clk_simple_probe+0x250/0xe40
[    1.858781]  mtk_clk_simple_probe+0x38/0x50
[    1.862974]  platform_probe+0xc4/0x198
[    1.866730]  really_probe+0x17c/0x5d0
[    1.870403]  __driver_probe_device+0x158/0x2b0
[    1.874858]  driver_probe_device+0xe8/0x260
[    1.879049]  __driver_attach+0x124/0x44c
[    1.882982]  bus_for_each_dev+0xf8/0x180
[    1.886915]  driver_attach+0x3c/0x58
[    1.890501]  bus_add_driver+0x1c4/0x43c
[    1.894346]  driver_register+0x154/0x398
[    1.898278]  __platform_driver_register+0x5c/0x84
[    1.902988]  clk_mt8173_topckgen_drv_init+0x1c/0x28
[    1.907876]  do_one_initcall+0xbc/0x380
[    1.911719]  kernel_init_freeable+0x448/0x4b4
[    1.916087]  kernel_init+0x24/0x15c
[    1.919582]  ret_from_fork+0x10/0x20

[    1.924659] Allocated by task 1:
[    1.927889]  kasan_save_stack+0x2c/0x54
[    1.931737]  kasan_save_track+0x20/0x40
[    1.935581]  kasan_save_alloc_info+0x40/0x60
[    1.939856]  __kasan_kmalloc+0xd4/0xdc
[    1.943613]  __kmalloc_noprof+0x174/0x33c
[    1.947633]  mtk_alloc_clk_data+0x24/0xc8
[    1.951652]  __mtk_clk_simple_probe+0x1fc/0xe40
[    1.956191]  mtk_clk_simple_probe+0x38/0x50
[    1.960382]  platform_probe+0xc4/0x198
[    1.964138]  really_probe+0x17c/0x5d0
[    1.967809]  __driver_probe_device+0x158/0x2b0
[    1.972261]  driver_probe_device+0xe8/0x260
[    1.976452]  __driver_attach+0x124/0x44c
[    1.980383]  bus_for_each_dev+0xf8/0x180
[    1.984313]  driver_attach+0x3c/0x58
[    1.987897]  bus_add_driver+0x1c4/0x43c
[    1.991741]  driver_register+0x154/0x398
[    1.995673]  __platform_driver_register+0x5c/0x84
[    2.000381]  clk_mt8173_topckgen_drv_init+0x1c/0x28
[    2.005271]  do_one_initcall+0xbc/0x380
[    2.009115]  kernel_init_freeable+0x448/0x4b4
[    2.013486]  kernel_init+0x24/0x15c
[    2.016983]  ret_from_fork+0x10/0x20

[    2.022063] The buggy address belongs to the object at ffff0000c6bb4000
                which belongs to the cache kmalloc-2k of size 2048
[    2.034588] The buggy address is located 0 bytes to the right of
                allocated 1128-byte region [ffff0000c6bb4000, ffff0000c6bb4468)

[    2.049127] The buggy address belongs to the physical page:
[    2.054697] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106bb0
[    2.062707] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    2.070366] flags: 0xbfffe0000000040(head|node=0|zone=2|lastcpupid=0x1ffff)
[    2.077337] page_type: f5(slab)
[    2.080487] raw: 0bfffe0000000040 ffff0000c0002f00 dead000000000122 0000000000000000
[    2.088236] raw: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[    2.095984] head: 0bfffe0000000040 ffff0000c0002f00 dead000000000122 0000000000000000
[    2.103816] head: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[    2.111647] head: 0bfffe0000000003 fffffdffc31aec01 ffffffffffffffff 0000000000000000
[    2.119480] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[    2.127312] page dumped because: kasan: bad access detected

[    2.134381] Memory state around the buggy address:
[    2.139175]  ffff0000c6bb4300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.146402]  ffff0000c6bb4380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.153628] >ffff0000c6bb4400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
[    2.160847]                                                           ^
[    2.167464]  ffff0000c6bb4480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    2.174690]  ffff0000c6bb4500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    2.181913] ==================================================================
[    2.189232] Disabling lock debugging due to kernel taint
[    2.194835] ==================================================================
[    2.202064] BUG: KASAN: slab-out-of-bounds in mtk_clk_register_fixed_clks.part.0+0x174/0x2e4
[    2.210521] Write of size 8 at addr ffff0000c6bb4468 by task swapper/0/1

[    2.218725] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G    B              6.12.0-rc1-next-20241001-hana-00006-g61df9cddd695 #1
[    2.230474] Tainted: [B]=BAD_PAGE
[    2.233792] Hardware name: Google Hana (DT)
[    2.237977] Call trace:
[    2.240426]  dump_backtrace.part.0+0xd4/0xe0
[    2.244707]  show_stack+0x18/0x30
[    2.248029]  dump_stack_lvl+0x5c/0x7c
[    2.251706]  print_report+0x160/0x4c0
[    2.255376]  kasan_report+0x9c/0xe8
[    2.258878]  __asan_report_store8_noabort+0x20/0x2c
[    2.263766]  mtk_clk_register_fixed_clks.part.0+0x174/0x2e4
[    2.269350]  __mtk_clk_simple_probe+0x250/0xe40
[    2.273894]  mtk_clk_simple_probe+0x38/0x50
[    2.278088]  platform_probe+0xc4/0x198
[    2.281846]  really_probe+0x17c/0x5d0
[    2.285519]  __driver_probe_device+0x158/0x2b0
[    2.289973]  driver_probe_device+0xe8/0x260
[    2.294169]  __driver_attach+0x124/0x44c
[    2.298105]  bus_for_each_dev+0xf8/0x180
[    2.302039]  driver_attach+0x3c/0x58
[    2.305626]  bus_add_driver+0x1c4/0x43c
[    2.309471]  driver_register+0x154/0x398
[    2.313405]  __platform_driver_register+0x5c/0x84
[    2.318118]  clk_mt8173_topckgen_drv_init+0x1c/0x28
[    2.323011]  do_one_initcall+0xbc/0x380
[    2.326856]  kernel_init_freeable+0x448/0x4b4
[    2.331224]  kernel_init+0x24/0x15c
[    2.334718]  ret_from_fork+0x10/0x20

[    2.339797] Allocated by task 1:
[    2.343029]  kasan_save_stack+0x2c/0x54
[    2.346879]  kasan_save_track+0x20/0x40
[    2.350722]  kasan_save_alloc_info+0x40/0x60
[    2.354997]  __kasan_kmalloc+0xd4/0xdc
[    2.358755]  __kmalloc_noprof+0x174/0x33c
[    2.362776]  mtk_alloc_clk_data+0x24/0xc8
[    2.366797]  __mtk_clk_simple_probe+0x1fc/0xe40
[    2.371334]  mtk_clk_simple_probe+0x38/0x50
[    2.375527]  platform_probe+0xc4/0x198
[    2.379284]  really_probe+0x17c/0x5d0
[    2.382959]  __driver_probe_device+0x158/0x2b0
[    2.387413]  driver_probe_device+0xe8/0x260
[    2.391608]  __driver_attach+0x124/0x44c
[    2.395541]  bus_for_each_dev+0xf8/0x180
[    2.399473]  driver_attach+0x3c/0x58
[    2.403058]  bus_add_driver+0x1c4/0x43c
[    2.406903]  driver_register+0x154/0x398
[    2.410835]  __platform_driver_register+0x5c/0x84
[    2.415547]  clk_mt8173_topckgen_drv_init+0x1c/0x28
[    2.420435]  do_one_initcall+0xbc/0x380
[    2.424279]  kernel_init_freeable+0x448/0x4b4
[    2.428648]  kernel_init+0x24/0x15c
[    2.432146]  ret_from_fork+0x10/0x20

[    2.437223] The buggy address belongs to the object at ffff0000c6bb4000
                which belongs to the cache kmalloc-2k of size 2048
[    2.449740] The buggy address is located 0 bytes to the right of
                allocated 1128-byte region [ffff0000c6bb4000, ffff0000c6bb4468)

[    2.464282] The buggy address belongs to the physical page:
[    2.469855] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106bb0
[    2.477866] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    2.485525] flags: 0xbfffe0000000040(head|node=0|zone=2|lastcpupid=0x1ffff)
[    2.492497] page_type: f5(slab)
[    2.495646] raw: 0bfffe0000000040 ffff0000c0002f00 dead000000000122 0000000000000000
[    2.503392] raw: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[    2.511143] head: 0bfffe0000000040 ffff0000c0002f00 dead000000000122 0000000000000000
[    2.518977] head: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[    2.526810] head: 0bfffe0000000003 fffffdffc31aec01 ffffffffffffffff 0000000000000000
[    2.534643] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[    2.542472] page dumped because: kasan: bad access detected

[    2.549538] Memory state around the buggy address:
[    2.554332]  ffff0000c6bb4300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.561556]  ffff0000c6bb4380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.568778] >ffff0000c6bb4400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
[    2.575998]                                                           ^
[    2.582611]  ffff0000c6bb4480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    2.589836]  ffff0000c6bb4500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    2.597055] ==================================================================
[    2.604340] ==================================================================
[    2.611582] BUG: KASAN: slab-out-of-bounds in mtk_clk_register_fixed_clks.part.0+0x1b8/0x2e4
[    2.620038] Read of size 8 at addr ffff0000c6bb4470 by task swapper/0/1

[    2.628154] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G    B              6.12.0-rc1-next-20241001-hana-00006-g61df9cddd695 #1
[    2.639898] Tainted: [B]=BAD_PAGE
[    2.643217] Hardware name: Google Hana (DT)
[    2.647402] Call trace:
[    2.649850]  dump_backtrace.part.0+0xd4/0xe0
[    2.654132]  show_stack+0x18/0x30
[    2.657457]  dump_stack_lvl+0x5c/0x7c
[    2.661133]  print_report+0x160/0x4c0
[    2.664803]  kasan_report+0x9c/0xe8
[    2.668304]  __asan_report_load8_noabort+0x20/0x34
[    2.673102]  mtk_clk_register_fixed_clks.part.0+0x1b8/0x2e4
[    2.678689]  __mtk_clk_simple_probe+0x250/0xe40
[    2.683233]  mtk_clk_simple_probe+0x38/0x50
[    2.687426]  platform_probe+0xc4/0x198
[    2.691184]  really_probe+0x17c/0x5d0
[    2.694857]  __driver_probe_device+0x158/0x2b0
[    2.699312]  driver_probe_device+0xe8/0x260
[    2.703504]  __driver_attach+0x124/0x44c
[    2.707438]  bus_for_each_dev+0xf8/0x180
[    2.711371]  driver_attach+0x3c/0x58
[    2.714956]  bus_add_driver+0x1c4/0x43c
[    2.718801]  driver_register+0x154/0x398
[    2.722735]  __platform_driver_register+0x5c/0x84
[    2.727448]  clk_mt8173_topckgen_drv_init+0x1c/0x28
[    2.732342]  do_one_initcall+0xbc/0x380
[    2.736186]  kernel_init_freeable+0x448/0x4b4
[    2.740553]  kernel_init+0x24/0x15c
[    2.744048]  ret_from_fork+0x10/0x20

[    2.749125] Allocated by task 1:
[    2.752354]  kasan_save_stack+0x2c/0x54
[    2.756203]  kasan_save_track+0x20/0x40
[    2.760047]  kasan_save_alloc_info+0x40/0x60
[    2.764322]  __kasan_kmalloc+0xd4/0xdc
[    2.768079]  __kmalloc_noprof+0x174/0x33c
[    2.772099]  mtk_alloc_clk_data+0x24/0xc8
[    2.776119]  __mtk_clk_simple_probe+0x1fc/0xe40
[    2.780657]  mtk_clk_simple_probe+0x38/0x50
[    2.784850]  platform_probe+0xc4/0x198
[    2.788606]  really_probe+0x17c/0x5d0
[    2.792278]  __driver_probe_device+0x158/0x2b0
[    2.796734]  driver_probe_device+0xe8/0x260
[    2.800929]  __driver_attach+0x124/0x44c
[    2.804862]  bus_for_each_dev+0xf8/0x180
[    2.808794]  driver_attach+0x3c/0x58
[    2.812379]  bus_add_driver+0x1c4/0x43c
[    2.816223]  driver_register+0x154/0x398
[    2.820156]  __platform_driver_register+0x5c/0x84
[    2.824865]  clk_mt8173_topckgen_drv_init+0x1c/0x28
[    2.829754]  do_one_initcall+0xbc/0x380
[    2.833599]  kernel_init_freeable+0x448/0x4b4
[    2.837967]  kernel_init+0x24/0x15c
[    2.841463]  ret_from_fork+0x10/0x20

[    2.846540] The buggy address belongs to the object at ffff0000c6bb4000
                which belongs to the cache kmalloc-2k of size 2048
[    2.859060] The buggy address is located 8 bytes to the right of
                allocated 1128-byte region [ffff0000c6bb4000, ffff0000c6bb4468)

[    2.873602] The buggy address belongs to the physical page:
[    2.879175] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106bb0
[    2.887184] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    2.894844] flags: 0xbfffe0000000040(head|node=0|zone=2|lastcpupid=0x1ffff)
[    2.901812] page_type: f5(slab)
[    2.904964] raw: 0bfffe0000000040 ffff0000c0002f00 dead000000000122 0000000000000000
[    2.912715] raw: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[    2.920469] head: 0bfffe0000000040 ffff0000c0002f00 dead000000000122 0000000000000000
[    2.928306] head: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[    2.936141] head: 0bfffe0000000003 fffffdffc31aec01 ffffffffffffffff 0000000000000000
[    2.943974] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[    2.951804] page dumped because: kasan: bad access detected

[    2.958870] Memory state around the buggy address:
[    2.963666]  ffff0000c6bb4300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.970893]  ffff0000c6bb4380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.978119] >ffff0000c6bb4400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
[    2.985343]                                                              ^
[    2.992220]  ffff0000c6bb4480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    2.999443]  ffff0000c6bb4500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    3.006663] ==================================================================
[    3.014175] ==================================================================
[    3.021417] BUG: KASAN: slab-out-of-bounds in mtk_clk_register_fixed_clks.part.0+0x174/0x2e4
[    3.029873] Write of size 8 at addr ffff0000c6bb4470 by task swapper/0/1

[    3.038073] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G    B              6.12.0-rc1-next-20241001-hana-00006-g61df9cddd695 #1
[    3.049818] Tainted: [B]=BAD_PAGE
[    3.053136] Hardware name: Google Hana (DT)
[    3.057320] Call trace:
[    3.059767]  dump_backtrace.part.0+0xd4/0xe0
[    3.064045]  show_stack+0x18/0x30
[    3.067365]  dump_stack_lvl+0x5c/0x7c
[    3.071039]  print_report+0x160/0x4c0
[    3.074708]  kasan_report+0x9c/0xe8
[    3.078208]  __asan_report_store8_noabort+0x20/0x2c
[    3.083091]  mtk_clk_register_fixed_clks.part.0+0x174/0x2e4
[    3.088672]  __mtk_clk_simple_probe+0x250/0xe40
[    3.093213]  mtk_clk_simple_probe+0x38/0x50
[    3.097406]  platform_probe+0xc4/0x198
[    3.101164]  really_probe+0x17c/0x5d0
[    3.104838]  __driver_probe_device+0x158/0x2b0
[    3.109293]  driver_probe_device+0xe8/0x260
[    3.113487]  __driver_attach+0x124/0x44c
[    3.117419]  bus_for_each_dev+0xf8/0x180
[    3.121350]  driver_attach+0x3c/0x58
[    3.124935]  bus_add_driver+0x1c4/0x43c
[    3.128778]  driver_register+0x154/0x398
[    3.132713]  __platform_driver_register+0x5c/0x84
[    3.137423]  clk_mt8173_topckgen_drv_init+0x1c/0x28
[    3.142313]  do_one_initcall+0xbc/0x380
[    3.146154]  kernel_init_freeable+0x448/0x4b4
[    3.150522]  kernel_init+0x24/0x15c
[    3.154018]  ret_from_fork+0x10/0x20

[    3.159093] Allocated by task 1:
[    3.162324]  kasan_save_stack+0x2c/0x54
[    3.166178]  kasan_save_track+0x20/0x40
[    3.170025]  kasan_save_alloc_info+0x40/0x60
[    3.174302]  __kasan_kmalloc+0xd4/0xdc
[    3.178062]  __kmalloc_noprof+0x174/0x33c
[    3.182084]  mtk_alloc_clk_data+0x24/0xc8
[    3.186103]  __mtk_clk_simple_probe+0x1fc/0xe40
[    3.190642]  mtk_clk_simple_probe+0x38/0x50
[    3.194834]  platform_probe+0xc4/0x198
[    3.198591]  really_probe+0x17c/0x5d0
[    3.202262]  __driver_probe_device+0x158/0x2b0
[    3.206713]  driver_probe_device+0xe8/0x260
[    3.210906]  __driver_attach+0x124/0x44c
[    3.214839]  bus_for_each_dev+0xf8/0x180
[    3.218773]  driver_attach+0x3c/0x58
[    3.222363]  bus_add_driver+0x1c4/0x43c
[    3.226211]  driver_register+0x154/0x398
[    3.230146]  __platform_driver_register+0x5c/0x84
[    3.234858]  clk_mt8173_topckgen_drv_init+0x1c/0x28
[    3.239748]  do_one_initcall+0xbc/0x380
[    3.243596]  kernel_init_freeable+0x448/0x4b4
[    3.247964]  kernel_init+0x24/0x15c
[    3.251461]  ret_from_fork+0x10/0x20

[    3.256539] The buggy address belongs to the object at ffff0000c6bb4000
                which belongs to the cache kmalloc-2k of size 2048
[    3.269060] The buggy address is located 8 bytes to the right of
                allocated 1128-byte region [ffff0000c6bb4000, ffff0000c6bb4468)

[    3.283602] The buggy address belongs to the physical page:
[    3.289174] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106bb0
[    3.297185] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    3.304844] flags: 0xbfffe0000000040(head|node=0|zone=2|lastcpupid=0x1ffff)
[    3.311814] page_type: f5(slab)
[    3.314963] raw: 0bfffe0000000040 ffff0000c0002f00 dead000000000122 0000000000000000
[    3.322714] raw: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[    3.330462] head: 0bfffe0000000040 ffff0000c0002f00 dead000000000122 0000000000000000
[    3.338298] head: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
[    3.346134] head: 0bfffe0000000003 fffffdffc31aec01 ffffffffffffffff 0000000000000000
[    3.353969] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[    3.361800] page dumped because: kasan: bad access detected

[    3.368867] Memory state around the buggy address:
[    3.373662]  ffff0000c6bb4300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.380892]  ffff0000c6bb4380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.388121] >ffff0000c6bb4400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
[    3.395346]                                                              ^
[    3.402226]  ffff0000c6bb4480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    3.409455]  ffff0000c6bb4500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    3.416680] ==================================================================
[    3.483149] mtk-socinfo mtk-socinfo.0.auto: MediaTek MT8173 (MT8173) SoC detected.
[    3.491815] mtk-scpsys 10006000.syscon: Cannot find infracfg controller: -19
[    3.512245] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.524340] printk: legacy console [ttyS0] disabled
[    3.550304] 11002000.serial: ttyS0 at MMIO 0x11002000 (irq = 242, base_baud = 1625000) is a ST16650V2
[    3.559656] printk: legacy console [ttyS0] enabled
[    3.571841] Serial: AMBA driver
[    3.614651] loop: module loaded
[    3.625079] mt6397-codec: Failed to locate of_node [id: -1]
[    3.626168] mt6397-regulator mt6397-regulator: Chip ID = 0x2091
[    3.637817] mtk-pmic-keys: Failed to locate of_node [id: -1]
[    3.650331] vcamaf: Bringing 2800000uV into 1800000-1800000uV
[    3.655499] megasas: 07.727.03.00-rc1
[    3.687054] mtk-spi-nor 1100d000.spi: IRQ not available.
[    7.034821] Freeing initrd memory: 12984K
[    7.062584] mtk-spi-nor 1100d000.spi: spi frequency: 26000000 Hz
[    7.075265] e1000: Intel(R) PRO/1000 Network Driver
[    7.085099] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    7.096752] e1000e: Intel(R) PRO/1000 Network Driver
[    7.106751] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.118768] igb: Intel(R) Gigabit Ethernet Network Driver
[    7.129660] igb: Copyright (c) 2007-2014 Intel Corporation.
[    7.140976] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    7.153590] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    7.165596] sky2: driver version 1.30
[    7.173844] VFIO - User Level meta-driver version: 0.3
[    7.189146] usbcore: registered new interface driver usb-storage
[    7.205884] i2c_dev: i2c /dev entries driver
[    7.217642] platform 1401b000.dsi: Fixed dependency cycle(s) with /soc/i2c@11007000/edp-bridge@8
[    7.235793] i2c 1-0008: Fixed dependency cycle(s) with /soc/i2c@11007000/edp-bridge@8/aux-bus/panel
[    7.254076] i2c 1-0008: Fixed dependency cycle(s) with /soc/dsi@1401b000
[    7.278552] tpm_i2c_infineon 3-0020: 1.2 TPM (device-id 0x1A)
[    7.374516] arm_smc_wdt watchdog: Watchdog registered (timeout=31 sec, nowayout=0)
[    7.386635] random: crng init done
[    7.390485] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    7.421196] cpufreq: cpufreq_online: CPU0: Running at unlisted initial frequency: 1699999 KHz, changing to: 1703000 KHz
[    7.443794] cpu cpu0: EM: created perf domain
[    7.454434] cpufreq: cpufreq_online: CPU2: Running at unlisted initial frequency: 851500 KHz, changing to: 1001000 KHz
[    7.476717] cpu cpu2: EM: created perf domain
[    7.488786] sdhci: Secure Digital Host Controller Interface driver
[    7.501284] sdhci: Copyright(c) Pierre Ossman
[    7.511168] Synopsys Designware Multimedia Card Interface Driver
[    7.511698] mtk-msdc 11240000.mmc: Got CD GPIO
[    7.517926] sdhci-pltfm: SDHCI platform and OF driver helper
[    7.521729] mtk-msdc 11240000.mmc: Got WP GPIO
[    7.528593] usbcore: registered new interface driver usbhid
[    7.545225] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=52 arg=00000C00; host->error=0x00000002
[    7.547827] usbhid: USB HID core driver
[    7.548557] spi_master spi0: will run message pump with realtime priority
[    7.557110] mtk-msdc 11260000.mmc: msdc_track_cmd_data: cmd=52 arg=00000C00; host->error=0x00000002
[    7.622023] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=52 arg=80000C08; host->error=0x00000002
[    7.622334] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 (0,8000003f) counters available
[    7.631254] mtk-msdc 11260000.mmc: msdc_track_cmd_data: cmd=52 arg=80000C08; host->error=0x00000002
[    7.678002] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 (0,8000003f) counters available
[    7.681863] mtk-msdc 11260000.mmc: msdc_track_cmd_data: cmd=8 arg=000001AA; host->error=0x00000002
[    7.690723] NET: Registered PF_PACKET protocol family
[    7.696459] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=8 arg=000001AA; host->error=0x00000002
[    7.701489] 9pnet: Installing 9P2000 support
[    7.711143] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=5 arg=00000000; host->error=0x00000002
[    7.714686] Key type dns_resolver registered
[    7.724839] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=5 arg=00000000; host->error=0x00000002
[    7.741480] registered taskstats version 1
[    7.746761] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=5 arg=00000000; host->error=0x00000002
[    7.750451] Loading compiled-in X.509 certificates
[    7.759719] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=5 arg=00000000; host->error=0x00000002
[    7.850327] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=55 arg=00000000; host->error=0x00000002
[    7.868958] Demotion targets for Node 0: null
[    7.869062] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=55 arg=00000000; host->error=0x00000002
[    7.879847] Btrfs loaded, zoned=no, fsverity=no
[    7.882993] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=55 arg=00000000; host->error=0x00000002
[    7.887643] AppArmor: AppArmor sha256 policy hashing enabled
[    7.896601] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=55 arg=00000000; host->error=0x00000002
[    7.958438] mediatek-hdmi-phy 10209100.hdmi-phy: Using default TX DRV impedance: 4.2k/36
[    7.981981] mtu3 11271000.usb: uwk - reg:0x400, version:1
[    7.992915] mtu3 11271000.usb: supply vbus not found, using dummy regulator
[    8.004268] mmc2: new ultra high speed SDR104 SDIO card at address 0001
[    8.007061] mtu3 11271000.usb: dr_mode: 1, drd: auto
[    8.027336] input: cros_ec as /devices/platform/soc/1100a000.spi/spi_master/spi0/spi0.0/1100a000.spi:ec@0:keyboard-controller/input/input0
[    8.030130] mtu3 11271000.usb: u2p_dis_msk: 0, u3p_dis_msk: 0
[    8.030588] mtu3 11271000.usb: usb3-drd: 0
[    8.047534] cros-ec-spi spi0.0: Chrome EC device registered
[    8.051474] xhci-mtk 11270000.usb: supply vbus not found, using dummy regulator
[    8.101639] xhci-mtk 11270000.usb: xHCI Host Controller
[    8.112193] xhci-mtk 11270000.usb: new USB bus registered, assigned bus number 1
[    8.127201] xhci-mtk 11270000.usb: hcc params 0x01401198 hci version 0x96 quirks 0x0000000000280010
[    8.145436] xhci-mtk 11270000.usb: irq 261, io mem 0x11270000
[    8.157200] xhci-mtk 11270000.usb: xHCI Host Controller
[    8.167709] xhci-mtk 11270000.usb: new USB bus registered, assigned bus number 2
[    8.182591] xhci-mtk 11270000.usb: Host supports USB 3.0 SuperSpeed
[    8.197004] hub 1-0:1.0: USB hub found
[    8.204758] hub 1-0:1.0: 2 ports detected
[    8.213776] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    8.231432] hub 2-0:1.0: USB hub found
[    8.239058] hub 2-0:1.0: 1 port detected
[    8.241548] mtk-msdc 11230000.mmc: Final PAD_DS_TUNE: 0x14015
[    8.243535] mtu3 11271000.usb: xHCI platform device register success...
[    8.250974] mmc0: new HS400 MMC card at address 0001
[    8.268696] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/ovl@1400c000
[    8.272811] mmcblk0: mmc0:0001 MMC32G 29.1 GiB
[    8.278688] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/ovl@1400d000
[    8.290630]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[    8.291470] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/rdma@1400e000
[    8.303899] mmcblk0boot0: mmc0:0001 MMC32G 4.00 MiB
[    8.305690] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/rdma@1400f000
[    8.315843] mmcblk0boot1: mmc0:0001 MMC32G 4.00 MiB
[    8.318993] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/color@14013000
[    8.328455] mmcblk0rpmb: mmc0:0001 MMC32G 4.00 MiB, chardev (240:0)
[    8.332390] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/color@14014000
[    8.436128] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/aal@14015000
[    8.452966] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/gamma@14016000
[    8.470255] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/dsi@1401b000
[    8.487093] mediatek-drm mediatek-drm.16.auto: Adding component match for /soc/dpi@1401d000
[    8.510897] [drm] hdmi-audio-codec driver bound to HDMI
[    8.573600] usb 2-1: new SuperSpeed USB device number 2 using xhci-mtk
[    8.629724] hub 2-1:1.0: USB hub found
[    8.639389] hub 2-1:1.0: 2 ports detected
[    8.728416] usb 1-1: new high-speed USB device number 2 using xhci-mtk
[    8.856099] ps8640 1-0008: Failed to create device link (0x180) with backlight
[    8.871766] mtk-iommu 10205000.iommu: bound 14021000.larb (ops mtk_smi_larb_component_ops)
[    8.888467] mtk-iommu 10205000.iommu: bound 16010000.larb (ops mtk_smi_larb_component_ops)
[    8.905105] mtk-iommu 10205000.iommu: bound 15001000.larb (ops mtk_smi_larb_component_ops)
[    8.921728] mtk-iommu 10205000.iommu: bound 18001000.larb (ops mtk_smi_larb_component_ops)
[    8.938325] mtk-iommu 10205000.iommu: bound 14027000.larb (ops mtk_smi_larb_component_ops)
[    8.954933] mtk-iommu 10205000.iommu: bound 19001000.larb (ops mtk_smi_larb_component_ops)
[    8.972168] mediatek-disp-ovl 1400c000.ovl: Adding to iommu group 0
[    8.972255] usb 2-1.1: new SuperSpeed USB device number 3 using xhci-mtk
[    8.979601] mediatek-disp-ovl 1400d000.ovl: Adding to iommu group 0
[    9.011709] mediatek-disp-rdma 1400e000.rdma: Adding to iommu group 0
[    9.013235] usb-storage 2-1.1:1.0: USB Mass Storage device detected
[    9.018965] mediatek-disp-rdma 1400f000.rdma: Adding to iommu group 0
[    9.027045] scsi host0: usb-storage 2-1.1:1.0
[    9.031809] mediatek-disp-rdma 14010000.rdma: Adding to iommu group 0
[    9.075267] mediatek-dpi 1401d000.dpi: Found bridge node: /soc/hdmi@14025000
[    9.124540] usb 1-2: new high-speed USB device number 3 using xhci-mtk
[    9.221005] panel-simple-dp-aux aux-1-0008: Detected AUO B116XAN04.0 (0x405c)
[    9.237885] mediatek-drm mediatek-drm.16.auto: bound 1400c000.ovl (ops mtk_disp_ovl_component_ops)
[    9.256309] mediatek-drm mediatek-drm.16.auto: bound 1400d000.ovl (ops mtk_disp_ovl_component_ops)
[    9.274576] mediatek-drm mediatek-drm.16.auto: bound 1400e000.rdma (ops mtk_disp_rdma_component_ops)
[    9.293130] mediatek-drm mediatek-drm.16.auto: bound 1400f000.rdma (ops mtk_disp_rdma_component_ops)
[    9.311940] mediatek-drm mediatek-drm.16.auto: bound 14013000.color (ops mtk_disp_color_component_ops)
[    9.315567] hub 1-2:1.0: USB hub found
[    9.321309] mediatek-drm mediatek-drm.16.auto: bound 14014000.color (ops mtk_disp_color_component_ops)
[    9.321327] mediatek-drm mediatek-drm.16.auto: bound 14015000.aal (ops mtk_disp_aal_component_ops)
[    9.321343] mediatek-drm mediatek-drm.16.auto: bound 14016000.gamma (ops mtk_disp_gamma_component_ops)
[    9.323362] mediatek-drm mediatek-drm.16.auto: bound 1401b000.dsi (ops mtk_dsi_component_ops)
[    9.326550] hub 1-2:1.0: 2 ports detected
[    9.334542] mediatek-drm mediatek-drm.16.auto: bound 1401d000.dpi (ops mtk_dpi_component_ops)
[    9.438631] [drm] Initialized mediatek 1.0.0 for mediatek-drm.16.auto on minor 0
[    9.658742] Console: switching to colour frame buffer device 170x48
[    9.702200] mediatek-drm mediatek-drm.16.auto: [drm] fb0: mediatekdrmfb frame buffer device
[    9.721963] input: gpio-keys as /devices/platform/gpio-keys/input/input1
[    9.737163] clk: Disabling unused clocks
[    9.745660] PM: genpd: Disabling unused power domains
[    9.756163] ALSA device list:
[    9.762215]   No soundcards found.
[    9.770111] Freeing unused kernel memory: 2432K
[    9.779368] Run /init as init process
[    9.786757]   with arguments:
[    9.786764]     /init
[    9.786770]     cros_secure
[    9.786775]     splash
[    9.786780]   with environment:
[    9.786785]     HOME=/
[    9.786791]     TERM=linux
[    9.786796]     kern_guid=e4eaab62-9817-4dd8-b6df-bb826d6584ad
[   10.062981] scsi 0:0:0:0: Direct-Access     Samsung  Portable SSD T5  0    PQ: 0 ANSI: 6
[   10.086247] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[   10.102999] sd 0:0:0:0: [sda] Write Protect is off
[   10.112884] sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
[   10.116762] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   10.166281]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10
[   10.184086] sd 0:0:0:0: [sda] Attached SCSI disk
[   10.908341] mt6397-rtc mt6397-rtc: registered as rtc0
[   10.918987] mt6397-rtc mt6397-rtc: setting system clock to 2024-10-03T13:22:19 UTC (1727961739)
[   10.942514] i2c_hid_of 4-0020: supply vdd not found, using dummy regulator
[   10.945151] i2c_hid_of 4-0040: supply vdd not found, using dummy regulator
[   10.949788] i2c_hid_of 5-002c: supply vdd not found, using dummy regulator
[   10.954685] i2c_hid_of 4-0020: supply vddl not found, using dummy regulator
[   10.956931] i2c_hid_of 4-0040: supply vddl not found, using dummy regulator
[   10.965068] i2c_hid_of 5-002c: supply vddl not found, using dummy regulator
[   11.111930] input: hid-over-i2c 06CB:7818 Touchscreen as /devices/platform/soc/11010000.i2c/i2c-4/4-0020/0018:06CB:7818.0001/input/input2
[   11.161473] hid-generic 0018:06CB:7818.0001: input: I2C HID v1.00 Device [hid-over-i2c 06CB:7818] on 4-0020
[   11.322959] input: hid-over-i2c 06CB:7818 as /devices/platform/soc/11010000.i2c/i2c-4/4-0020/0018:06CB:7818.0001/input/input4
[   11.355588] hid-multitouch 0018:06CB:7818.0001: input: I2C HID v1.00 Device [hid-over-i2c 06CB:7818] on 4-0020
[   11.977276] EXT4-fs (sda4): mounted filesystem c16826e5-0b66-4648-87db-8a2601010f0a ro with ordered data mode. Quota mode: none.
[   12.500234] IPv6: Loaded, but administratively disabled, reboot required to enable
[   12.578996] systemd[1]: systemd 256.5-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT +LIBARCHIVE)
[   12.644571] systemd[1]: Detected architecture arm64.
[   12.664984] systemd[1]: Hostname set to <DEBIAN-T5-ARM64>.
[   13.152169] systemd[1]: bpf-restrict-fs: BPF LSM hook not enabled in the kernel, BPF LSM not supported.
[   14.115610] systemd[1]: Queued start job for default target graphical.target.
[   14.195226] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[   14.212677] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[   14.230671] systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
[   14.250692] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[   14.270458] systemd[1]: Created slice user.slice - User and Session Slice.
[   14.285048] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[   14.306825] systemd[1]: proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point was skipped because of an unmet condition check (ConditionPathExists=/proc/sys/fs/binfmt_misc).
[   14.345763] systemd[1]: Expecting device dev-disk-by\x2duuid-605450ef\x2d43fc\x2d41e4\x2d83d7\x2d9c204d5c1c03.device - /dev/disk/by-uuid/605450ef-43fc-41e4-83d7-9c204d5c1c03...
[   14.377883] systemd[1]: Expecting device dev-disk-by\x2duuid-92da49dd\x2d921b\x2d4e87\x2d9b65\x2d3ecbd9905707.device - /dev/disk/by-uuid/92da49dd-921b-4e87-9b65-3ecbd9905707...
[   14.410004] systemd[1]: Expecting device dev-disk-by\x2duuid-9409\x2dDA15.device - /dev/disk/by-uuid/9409-DA15...
[   14.431048] systemd[1]: Expecting device dev-ttyAMA0.device - /dev/ttyAMA0...
[   14.445668] systemd[1]: Expecting device dev-ttyS0.device - /dev/ttyS0...
[   14.460887] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[   14.479105] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[   14.497561] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[   14.512484] systemd[1]: Reached target slices.target - Slice Units.
[   14.525788] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[   14.552102] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
[   14.572407] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[   14.594872] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   14.613903] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
[   14.629239] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   14.656933] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   14.657461] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   14.701238] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   14.724387] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[   14.744548] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[   14.783454] systemd[1]: Mounting run-lock.mount - Legacy Locks Directory /run/lock...
[   14.803034] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[   14.820238] systemd[1]: sys-kernel-tracing.mount - Kernel Trace File System was skipped because of an unmet condition check (ConditionPathExists=/sys/kernel/tracing).
[   14.858914] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[   14.881626] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   14.904457] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[   14.948993] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[   14.970415] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[   14.993124] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[   15.009727] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
[   15.042412] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[   15.093809] systemd[1]: Starting systemd-journald.service - Journal Service...
[   15.116955] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   15.133462] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   15.133715] fuse: init (API version 7.41)
[   15.152381] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[   15.191342] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   15.225838] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
[   15.254559] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[   15.282914] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[   15.298879] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[   15.315605] systemd[1]: Mounted run-lock.mount - Legacy Locks Directory /run/lock.
[   15.319323] systemd-journald[234]: Collecting audit messages is disabled.
[   15.334343] EXT4-fs (sda4): re-mounted c16826e5-0b66-4648-87db-8a2601010f0a r/w. Quota mode: none.
[   15.366478] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[   15.385047] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[   15.403869] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[   15.423818] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[   15.439743] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[   15.457403] systemd[1]: Started systemd-journald.service - Journal Service.
[   15.629450] systemd-journald[234]: Received client request to flush runtime journal.
[   17.813577] mtk_vpu 10020000.vpu: 4GB mode 1
[   17.822830] mtk_vpu 10020000.vpu: assigned reserved memory node vpu-dma-mem@b7000000
[   17.839317] mtk_vpu 10020000.vpu: Data extend memory phy=0xb7000000 virt=0x000000006a53c292
[   17.839516] mtk_vpu 10020000.vpu: Program extend memory phy=0xb7400000 virt=0x000000005c7955a7
[   17.871182] elants_i2c 4-0010: supply vcc33 not found, using dummy regulator
[   17.909405] elants_i2c 4-0010: supply vccio not found, using dummy regulator
[   17.917577] mip4_ts 4-0034: nothing at this address
[   17.930801] elants_i2c 4-0010: nothing at this address
[   17.966394] Adding 31457276k swap on /dev/sda6.  Priority:-2 extents:1 across:31457276k 
[   18.047697] mt8173-afe-pcm 11220000.audio-controller: MT8173 AFE driver initialized.
[   18.111500] cros-usbpd-charger cros-usbpd-charger.7.auto: Could not get charger port count
[   18.197166] sbs-battery 6-000b: sbs-battery: battery gas gauge device registered
[   18.248105] sbs-battery 6-000b: I2C adapter does not support I2C_FUNC_SMBUS_READ_BLOCK_DATA.
               Fallback method does not support PEC.
[   18.291194] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   18.316102] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   18.335846] elan_i2c 5-0015: Elan Touchpad: Module ID: 0x009f, Firmware: 0x0002, Sample: 0x0002, IAP: 0x000e
[   18.365724] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   18.369060] mc: Linux media interface: v0.10
[   18.380639] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   18.411368] input: Elan Touchpad as /devices/platform/soc/11011000.i2c/i2c-5/5-0015/input/input7
[   18.448620] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   18.458359] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   18.490910] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   18.493015] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   18.532665] videodev: Linux video capture interface: v2.00
[   18.554485] EXT4-fs (sda2): mounted filesystem 605450ef-43fc-41e4-83d7-9c204d5c1c03 r/w with ordered data mode. Quota mode: none.
[   18.591958] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   18.614517] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   18.636413] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   18.651125] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   18.674378] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   18.690571] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   18.706018] Bluetooth: Core ver 2.22
[   18.710506] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   18.713483] NET: Registered PF_BLUETOOTH protocol family
[   18.739233] Bluetooth: HCI device and connection manager initialized
[   18.752165] Bluetooth: HCI socket layer initialized
[   18.757818] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
[   18.762011] Bluetooth: L2CAP socket layer initialized
[   18.762076] Bluetooth: SCO socket layer initialized
[   18.789039] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   18.819321] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   18.858054] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   18.863409] mtk-mdp 14001000.rdma: Adding to iommu group 0
[   18.869642] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   18.874709] mtk-msdc 11260000.mmc: msdc_track_cmd_data: cmd=52 arg=00000C00; host->error=0x00000002
[   18.883106] mtk-vcodec-enc 18002000.vcodec: Adding to iommu group 0
[   18.891028] mtk-msdc 11260000.mmc: msdc_track_cmd_data: cmd=52 arg=80000C08; host->error=0x00000002
[   18.928462] mtk-mdp 14001000.rdma: driver registered as /dev/video2
[   18.933366] usb 1-1: Found UVC 1.00 device EasyCamera (04f2:b5eb)
[   18.939136] mtk-vcodec-enc 19002000.vcodec: Adding to iommu group 0
[   18.947195] mtk-msdc 11260000.mmc: msdc_track_cmd_data: cmd=8 arg=000001AA; host->error=0x00000002
[   18.963604] debugfs: Directory 'vcodec-enc' with parent '/' already present!
[   19.005001] mtk-jpeg 18004000.jpegdec: Adding to iommu group 0
[   19.008443] mtk-vcodec-enc 19002000.vcodec: create venc dir err:1
[   19.038927] usbcore: registered new interface driver uvcvideo
[   19.042783] Bluetooth: vendor=0x2df, device=0x912e, class=255, fn=2
[   19.053334] mtk-vcodec-dec 16020000.vcodec: Adding to iommu group 0
[   19.054705] mtk-jpeg 18004000.jpegdec: mtk-jpeg-dec device registered as /dev/video5 (81,5)
[   19.121142] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   19.142478] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   19.180993] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   19.239711] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   19.270582] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   19.304712] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   19.459608] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   19.509763] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   19.592260] mtk_vpu 10020000.vpu: vpu is ready. Fw version 1.2.0
[   19.623494] audit: type=1400 audit(1727961748.200:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=412 comm="apparmor_parser"
[   19.661224] audit: type=1400 audit(1727961748.200:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=412 comm="apparmor_parser"
[   19.699028] audit: type=1400 audit(1727961748.200:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=411 comm="apparmor_parser"
[   19.736445] input: mtk-rt5650 Headset Jack as /devices/platform/sound/sound/card0/input8
[   19.744428] audit: type=1400 audit(1727961748.276:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=413 comm="apparmor_parser"
[   19.764598] input: mtk-rt5650 HDMI Jack as /devices/platform/sound/sound/card0/input9
[   19.770839] audit: type=1400 audit(1727961748.276:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=413 comm="apparmor_parser"
[   19.858322] audit: type=1400 audit(1727961748.276:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=413 comm="apparmor_parser"
[   19.912200] audit: type=1400 audit(1727961748.276:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/{,usr/}sbin/dhclient" pid=413 comm="apparmor_parser"
[   19.946219] audit: type=1400 audit(1727961748.292:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/aarch64-linux-gnu/lightdm/lightdm-guest-session" pid=410 comm="apparmor_parser"
[   19.984672] audit: type=1400 audit(1727961748.292:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/aarch64-linux-gnu/lightdm/lightdm-guest-session//chromium" pid=410 comm="apparmor_parser"
[   20.024919] audit: type=1400 audit(1727961748.324:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=437 comm="apparmor_parser"
[   20.636628] mwifiex_sdio mmc2:0001:1: info: FW download over, size 717068 bytes
[   21.408682] mwifiex_sdio mmc2:0001:1: WLAN FW is active
[   21.439219] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   21.491664] mwifiex_sdio mmc2:0001:1: host_mlme: disable, key_api: 2
[   21.563071] mwifiex_sdio mmc2:0001:1: Bad HW revision detected, disabling deep sleep
[   21.645541] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (15.68.19.p54) 
[   21.662568] mwifiex_sdio mmc2:0001:1: driver_version = mwifiex 1.0 (15.68.19.p54) 
[   21.951561] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   21.962618] Bluetooth: BNEP socket layer initialized
[   22.014719] Bluetooth: MGMT ver 1.23
[   22.076049] Bluetooth: RFCOMM TTY layer initialized
[   22.086595] Bluetooth: RFCOMM socket layer initialized
[   22.097967] Bluetooth: RFCOMM ver 1.11
[   22.483070] NET: Registered PF_QIPCRTR protocol family
[   27.131838] mwifiex_sdio mmc2:0001:1: info: trying to associate to bssid 00:1c:7b:cc:83:c6
[   27.195264] mwifiex_sdio mmc2:0001:1: assoc: associated with 00:1c:7b:cc:83:c6
[   27.210832] mwifiex_sdio mmc2:0001:1: info: associated to bssid 00:1c:7b:cc:83:c6 successfully
[   27.231741] mwifiex_sdio mmc2:0001:1: key: send EAPOL to 00:1c:7b:cc:83:c6
[   27.268802] mwifiex_sdio mmc2:0001:1: key: send EAPOL to 00:1c:7b:cc:83:c6
[   34.678473] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.702079] power_supply_show_property: 5 callbacks suppressed
[   34.702096] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   34.754401] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.782568] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.806020] power_supply sbs-6-000b: driver failed to report `manufacturer' property: -22
[   34.826135] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   34.844078] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.864128] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.889015] power_supply sbs-6-000b: driver failed to report `model_name' property: -22
[   34.895486] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   34.945035] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   34.957187] rfkill: input handler disabled
[   34.976241] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   35.022993] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   35.075006] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   35.125879] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   35.180205] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   35.236214] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   35.268217] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   35.320205] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   35.354639] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   35.411750] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   35.457813] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   35.495008] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   35.541767] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   40.136265] vgpu: disabling
[   40.142071] va28: disabling
[   40.963948] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   40.985523] power_supply_show_property: 4 callbacks suppressed
[   40.985540] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   41.031802] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.040231] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.076231] power_supply sbs-6-000b: driver failed to report `manufacturer' property: -22
[   41.094479] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   41.112518] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.127781] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.152811] power_supply sbs-6-000b: driver failed to report `model_name' property: -22
[   41.170690] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   41.214003] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.218265] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.253373] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   41.255223] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   41.310492] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.331462] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   41.361666] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.382564] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   41.415964] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.438480] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   41.471083] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.508354] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.596193] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   41.645744] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   44.546892]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[   46.325195] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.354126] power_supply_show_property: 4 callbacks suppressed
[   46.354164] power_supply sbs-6-000b: driver failed to report `manufacturer' property: -22
[   46.402243] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.464557] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.486474] power_supply sbs-6-000b: driver failed to report `model_name' property: -22
[   46.506513] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   46.549266] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.572202] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   46.595848] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.617650] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   46.651556] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.673088] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   46.707475] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.729165] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   46.759966] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.781289] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   46.820317] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.841739] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   46.877970] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.899679] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   46.931623] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   46.971665] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   47.017472] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.616341] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.639934] power_supply_show_property: 3 callbacks suppressed
[   51.639970] power_supply sbs-6-000b: driver failed to report `manufacturer' property: -22
[   51.665958] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.688990] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.709015] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   51.728278] power_supply sbs-6-000b: driver failed to report `model_name' property: -22
[   51.741348] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.767454] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   51.812518] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.816701] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.852448] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   51.870292] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   51.919413] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.944566] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   51.977344] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   51.998857] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   52.032642] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   52.053569] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   52.093297] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   52.114635] power_supply sbs-6-000b: driver failed to report `technology' property: -22
[   52.145879] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
[   52.182010] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20



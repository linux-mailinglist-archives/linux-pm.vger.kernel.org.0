Return-Path: <linux-pm+bounces-14525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2497DB1B
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 03:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90961F22113
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 01:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5536C;
	Sat, 21 Sep 2024 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUO1CLkP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CC370;
	Sat, 21 Sep 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726880660; cv=none; b=cuTFKpUlwT9F7fzP0hlKy6v/wFONCSHflyveX55pBFWX2jN66tZ1kjHO0ocAMQUWHPeC/NTN3+QCzFymDXtRGFlqKBDihIyH5mQZhHKxMDxmDqCUgpjA8VYiFGjiUBVaKl5dGglXT6ytWeAswbn4u5HzmE3wfXf5uDyZUXTdyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726880660; c=relaxed/simple;
	bh=ox2fI96np6i2tGXnpGuRMIj84L7twmcyyiH2tsLQxIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw49Ot/3PooZjqMgh23b7FL+TUwssO9UZsp1+uFfeOt91lcAQE+VlmcHoheRT0ZASkNVVxTPvv0b54jPY8hJgBbuF7SKNYwoIbFtxj+SR5et4EEH1+x0lD3MK2c4/C/vlo/HJOPVrtuN/IckMmXyousbSwefBQVE/h2PqEHD5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUO1CLkP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso3099260a12.1;
        Fri, 20 Sep 2024 18:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726880634; x=1727485434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6LjsGFepcEcdYYRCvONYCT6eXDv/VoaQxZWDrNh7EM=;
        b=UUO1CLkPB7IAtaSHf+yrgUEgQywthO5EpI30FJ5wgR7DY/TPeavW2lZInL89BcQLiN
         xSnwJk9n8jGg9s7KtziO3yTnpxbKA0mBGBpxxprv8zRHcGeVFmKK0nq/p589tmLZvxYU
         4Vo3CSE0URt/Ft2vkDUyIsWO06L/cGgA/vjP+fPrQNt6IgixtCOHD+jKaGILfLVPl+aF
         6cundlCvvCcvaNow8zNt/Pk0Nl7gGWc6bYlp2N6L2RBxNWV1CvythIwIKqiDNUcya4hx
         EGz6c7LxUxiDcChKdFjorlAQ8vPlziyWAXM7cwbhTbBIzZcxkyKPokXCGrd2pJobf2tC
         xGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726880634; x=1727485434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6LjsGFepcEcdYYRCvONYCT6eXDv/VoaQxZWDrNh7EM=;
        b=YI62oA1kCNGYadLm1jB/6BN1+2J27pQYWbrF9fYJkNYojs/cAz3AXu3jTjmgtFpnCP
         swjKbbw1ckvqofbNc/a1x57EWIVGGMyitfNAmQ0pHI8CoNWKm8xi1LKbYZYLCKMEHPGi
         Kpn2mC6hf4YbOpqyaCjQvKI7W2yfn6NnX4Xj8Bp4kGEw8gWzJk3R1z0ldojSLgYFYrOp
         3WpofSQDP+kIB04Jj3wnk7GoczdbFwoHIe/v/CSWHQYQ3oWFSk+6CuuM0w/yxhEEOxSw
         wV9DI/hwmXiuVGJYiYsk7i9cO06AHrjRv043LX1W15UiuWowF9s5u5/3VfyJ5uL3xrjn
         2hvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxWVvEUpyVcS8K6PJ+qc88+F7fWsPNUyaVCrO65KMpRfyKv55b9Hx0368fyt4lre08P2Z8ULzQi2+xt1kVFiEcXuuY@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtva00q9a/yxMiJE71AD/mBaE2hQIYJLjlx0Xahp7vGNAclDk
	9bgpuXM0VU09/4a1M5+OvVA8qU6DTmqBXqWCgGw0iO9ijF/AY9rQ
X-Google-Smtp-Source: AGHT+IF22/lcsvYEUPWKDb53OJAeSJ/M5qzJPykV9JV/C4KRhljEsRVTGf0ml2F2JJuURj1ziB/ozg==
X-Received: by 2002:a17:907:e260:b0:a7d:e5b1:bf65 with SMTP id a640c23a62f3a-a90d4fe7f68mr343465666b.21.1726880632772;
        Fri, 20 Sep 2024 18:03:52 -0700 (PDT)
Received: from [192.168.1.127] ([151.95.54.104])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4416sm914206266b.60.2024.09.20.18.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 18:03:50 -0700 (PDT)
Message-ID: <f164e172-0030-48d0-9c33-aaaa6d0cc6ff@gmail.com>
Date: Sat, 21 Sep 2024 03:03:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 luke@ljones.dev, me@kylegospodneti.ch
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-4-lkml@antheas.dev>
 <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
 <CAGwozwGSVAExH_9zCCKreC88J0FRU4ZM3RkBk==HvRwCUuuqLw@mail.gmail.com>
 <25b14b4f-96b7-453c-b876-6a46c4f3789c@amd.com>
 <CAGwozwHmd8yHzjbutOd4T39h5CZRh2rOWYH4V4AnLN+RXrRRnQ@mail.gmail.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwHmd8yHzjbutOd4T39h5CZRh2rOWYH4V4AnLN+RXrRRnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/24 22:54, Antheas Kapenekakis wrote:
> I will try to merge all the suggestions and make a V2 on Saturday then.
> 
> Antheas

Hello everybody,

I own an RC71L and I want to see the issue solved, therefore I carefully tested proposed changes from you as well from Luke.

Testing on yours has been performed firstly with a preview patch that you shared on github and then I dedicated a few hours to test the submitted work.

On the preview I highlighted regressions I have found with your work, and given I have taken more time to test what you are submitting here I have found that not only reported regressions have not been addressed in any way, but I was able to identify some more: in particular entering s2idle appears to abort sometimes and I was able to reproduce failures in mcu_powersave=1.

I have filmed a few samples of problems as they manifests, as well as gathering logs in form of dmesg and amd_s2idle.py.

Visually all appears the same in mcu_powersave 0 and 1, therefore I filmed only mcu_powersave=0, but I will include logs of mcu_powersave=1 as well.

I want to express concerns about two main points:
- these patches are written with two devices in mind, but change the s2idle implementation of all devices: considering one of those two devices is showing serious regressions in every scenario I doubt the effectiveness of removing those csee call.
- despite being fully aware of issues this patch series introduces, you sent them with very little modification, against my best judgment and against interests of owners of this device.

I feel it's imperative you understand the root cause of these regressions and ensure they are adequately addressed before submitting a v2 of this patch as they renders the device completely unreliable (might wakeup in a bag, for example). I am available to provide testing before you submit to LKML.

A test MCU fw was made available to Luke by ASUS after they worked together on the issue. This fixes the root cause of issues in Linux. Testing by others (including ASUS) has indicated that this patch series is not required if the fixed firmware is used - as such there is communication progressing with ASUS to bring them onboard to use fwupd to update firmware in Linux. The old quirk will be updated to account for the new FW. My own testing of this firmware is delayed while I test your patches.

Best regards,
Denis Benato

mcu_powersave=0 AC spurious => https://youtu.be/GvM2LvdKGI4
mcu_powersave=0 battery wake by face buttons => https://youtu.be/xJQbzOawnsc
mcu_powersave=0 battery spurious => https://youtu.be/RV_ununSVxA
mcu_powersave=0 AC abort => https://youtu.be/H0lv9-CAEHQ

This is an example on what is written on terminal when such spurious wakeups happens:

Debugging script for s2idle on AMD systems
💻 ASUSTeK COMPUTER INC. ROG Ally RC71L_RC71L (ROG Ally) running BIOS 5.29 (RC71L.339) released 07/02/2024 and EC 3.27
🐧 ChimeraOS 47 (8a71d33)
🐧 Kernel 6.11.0-00004-ge11bee8239e6-dirty
🔋 Battery BAT0 (ASUSTeK ASUS Battery) is operating at 83.74% of design
Checking prerequisites for s2idle
✅ Logs are provided via systemd
✅ AMD Ryzen Z1 Extreme (family 19 model 74)
✅ SMT enabled
✅ LPS0 _DSM enabled
✅ ACPI FADT supports Low-power S0 idle
✅ HSMP driver `amd_hsmp` not detected (blocked: False)
✅ PMC driver `amd_pmc` loaded (Program 0 Firmware 76.71.0)
✅ GPU driver `amdgpu` bound to 0000:09:00.0
✅ System is configured for s2idle
✅ NVME Micron Technology Inc 2400 NVMe SSD (DRAM-less) is configured for s2idle in BIOS
✅ GPIO driver `pinctrl_amd` available
How long should suspend cycles last in seconds (default 10)? 90
How long to wait in between suspend cycles in seconds (default 4)? 4
How many suspend cycles to run (default 1)? 1
Started at 2024-09-20 20:14:50.477685 (cycle finish expected @ 2024-09-20 20:16:24.477692)
Results from last s2idle cycle
○ Suspend count: 1
○ Hardware sleep cycle count: 1
○ GPIOs active: ['0']
○ Wakeup triggered from IRQ 7: GPIO Controller
○ Wakeup triggered from IRQ 29: GPIO 0 (ACPI:Event)
❌ ACPI BIOS errors found
○ Woke up from IRQ 7: GPIO Controller
❌ Userspace suspended for 0:00:43.521302 (< minimum expected 0:01:21)
✅ In a hardware sleep state for 0:00:37.798797 (86.85%)
🔋 Battery BAT0 lost 270000 µWh (0.81%) [Average rate 2.23W]
Explanations for your system
🚦 ACPI BIOS Errors detected
	When running a firmware component utilized for s2idle
	the ACPI interpreter in the Linux kernel encountered some
	problems. This usually means it's a bug in the system BIOS
	that should be fixed the system manufacturer.

	You may have problems with certain devices after resume or high
	power consumption when this error occurs.
	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
🚦 Userspace wasn't asleep at least 0:01:30
	The system was programmed to sleep for 0:01:30, but woke up prematurely.
	This typically happens when the system was woken up from a non-timer based source.

	If you didn't intentionally wake it up, then there may be a kernel or firmware bug.


Here it is a full dmesg of a boot with attempted sleep resulting in a spurious wakeup:

[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009a7efff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009a7f000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a23bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a23c000-0x000000008e2fefff] usable
[    0.000000] BIOS-e820: [mem 0x000000008e2ff000-0x00000000910fefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000910ff000-0x00000000911fefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000911ff000-0x00000000966fefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000966ff000-0x000000009adfefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009adff000-0x000000009bff8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000009bff9000-0x000000009bffcfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009bffd000-0x000000009bffefff] usable
[    0.000000] BIOS-e820: [mem 0x000000009bfff000-0x000000009cffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009d790000-0x000000009d7effff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009d7f5000-0x000000009fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041e2fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000041f340000-0x00000004801fffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x794b1018-0x794b5257] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009a7efff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009a7f000-0x0000000009ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a23bfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000a23c000-0x00000000794b1017] usable
[    0.000000] reserve setup_data: [mem 0x00000000794b1018-0x00000000794b5257] usable
[    0.000000] reserve setup_data: [mem 0x00000000794b5258-0x000000008e2fefff] usable
[    0.000000] reserve setup_data: [mem 0x000000008e2ff000-0x00000000910fefff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000910ff000-0x00000000911fefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000911ff000-0x00000000966fefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000966ff000-0x000000009adfefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009adff000-0x000000009bff8fff] usable
[    0.000000] reserve setup_data: [mem 0x000000009bff9000-0x000000009bffcfff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009bffd000-0x000000009bffefff] usable
[    0.000000] reserve setup_data: [mem 0x000000009bfff000-0x000000009cffffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009d790000-0x000000009d7effff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009d7f5000-0x000000009fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000041e2fffff] usable
[    0.000000] reserve setup_data: [mem 0x000000041f340000-0x00000004801fffff] reserved
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=0x911fe000 ACPI 2.0=0x911fe014 TPMFinalLog=0x966b4000 SMBIOS=0x9aa7a000 SMBIOS 3.0=0x9aa79000 MEMATTR=0x8ac7b018 ESRT=0x8789cf18 RNG=0x91190f18 INITRD=0x7c2c3f18 TPMEventLog=0x794b6018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem53: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Remove mem54: MMIO range=[0xfd000000-0xfedfffff] (30MB) from e820 map
[    0.000000] e820: remove [mem 0xfd000000-0xfedfffff] reserved
[    0.000000] efi: Not removing mem55: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem56: MMIO range=[0xfee01000-0xffffffff] (17MB) from e820 map
[    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
[    0.000000] efi: Remove mem58: MMIO range=[0x460000000-0x4801fffff] (514MB) from e820 map
[    0.000000] e820: remove [mem 0x460000000-0x4801fffff] reserved
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: ASUSTeK COMPUTER INC. ROG Ally RC71L_RC71L/RC71L, BIOS RC71L.339 07/02/2024
[    0.000000] DMI: Memory slots populated: 4/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3293.956 MHz processor
[    0.000069] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000070] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000074] last_pfn = 0x41e300 max_arch_pfn = 0x400000000
[    0.000079] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built from 9 variable MTRRs
[    0.000081] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000277] e820: update [mem 0xa0000000-0xffffffff] usable ==> reserved
[    0.000283] last_pfn = 0x9bfff max_arch_pfn = 0x400000000
[    0.002299] esrt: Reserving ESRT space from 0x000000008789cf18 to 0x000000008789cf50.
[    0.002305] e820: update [mem 0x8789c000-0x8789cfff] usable ==> reserved
[    0.002312] Using GB pages for direct mapping
[    0.002671] Secure boot disabled
[    0.002671] RAMDISK: [mem 0x794c0000-0x7c2c2fff]
[    0.002675] ACPI: Early table checksum verification disabled
[    0.002678] ACPI: RSDP 0x00000000911FE014 000024 (v02 ALASKA)
[    0.002681] ACPI: XSDT 0x00000000911FD728 000164 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.002685] ACPI: FACP 0x00000000911F1000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.002688] ACPI: DSDT 0x00000000911DE000 01206E (v02 ALASKA A M I    01072009 INTL 20200717)
[    0.002689] ACPI: FACS 0x00000000924A1000 000040
[    0.002690] ACPI: MSDM 0x00000000911FC000 000055 (v03 ALASKA A M I    01072009 ASUS 00000001)
[    0.002691] ACPI: SSDT 0x00000000911F3000 008416 (v02 AMD    AmdTable 00000002 MSFT 02000002)
[    0.002692] ACPI: SSDT 0x00000000911F2000 000221 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.002693] ACPI: FIDT 0x00000000911DD000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.002694] ACPI: ECDT 0x00000000911DC000 0000C1 (v01 ALASKA A M I    01072009 AMI. 00000005)
[    0.002695] ACPI: MCFG 0x00000000911DB000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.002696] ACPI: HPET 0x00000000911DA000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.002697] ACPI: FPDT 0x00000000911D9000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.002698] ACPI: VFCT 0x00000000911D4000 004284 (v01 ALASKA A M I    00000001 AMD  33504F47)
[    0.002699] ACPI: SSDT 0x00000000911CE000 00547E (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.002700] ACPI: CRAT 0x00000000911CD000 000EE8 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.002700] ACPI: CDIT 0x00000000911CC000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.002701] ACPI: BGRT 0x00000000911CB000 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.002702] ACPI: TPM2 0x00000000911CA000 000044 (v05 ALASKA A M I    00000001 AMI  00000000)
[    0.002703] ACPI: SSDT 0x00000000911C8000 0015C8 (v02 AMD    CPMDFIG2 00000001 INTL 20200717)
[    0.002704] ACPI: SSDT 0x00000000911C5000 0028E1 (v02 AMD    CDFAAIG2 00000001 INTL 20200717)
[    0.002705] ACPI: SSDT 0x00000000911C4000 000024 (v02 AMD    CPMDFDG1 00000001 INTL 20200717)
[    0.002706] ACPI: SSDT 0x00000000911BE000 0050D6 (v02 AMD    CPMD3CLD 00000001 INTL 20200717)
[    0.002707] ACPI: SSDT 0x00000000911BD000 000935 (v02 AMD    CPMWLRC  00000001 INTL 20200717)
[    0.002708] ACPI: SSDT 0x00000000911BC000 0009DC (v02 AMD    OEMACP   00000001 INTL 20200717)
[    0.002709] ACPI: SSDT 0x00000000911BB000 00063C (v02 AMD    OEMPMF   00000001 INTL 20200717)
[    0.002709] ACPI: SSDT 0x00000000911B1000 009894 (v02 AMD    CPMCMN   00000001 INTL 20200717)
[    0.002710] ACPI: WSMT 0x00000000911B0000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.002711] ACPI: APIC 0x00000000911AF000 0000E8 (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.002712] ACPI: MHSP 0x00000000911AE000 0000C8 (v04 AMD    AGESA    20505348 ?    00000001)
[    0.002713] ACPI: SSDT 0x00000000911AD000 0000E5 (v02 MSFT   MHSP     00000004 INTL 20200717)
[    0.002714] ACPI: IVRS 0x00000000911AC000 0001A4 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.002715] ACPI: SSDT 0x00000000911AB000 000956 (v02 AMD    CPMMSOSC 00000001 INTL 20200717)
[    0.002716] ACPI: SSDT 0x00000000911AA000 000EAD (v02 AMD    CPMACPV5 00000001 INTL 20200717)
[    0.002717] ACPI: SSDT 0x00000000911A9000 0007DD (v02 AMD    THERMAL0 00000001 INTL 20200717)
[    0.002717] ACPI: SSDT 0x00000000911A8000 000FF7 (v02 AMD    GPP_PME_ 00000001 INTL 20200717)
[    0.002718] ACPI: SSDT 0x000000009119E000 0097E3 (v02 AMD    INTGPP03 00000001 INTL 20200717)
[    0.002719] ACPI: SSDT 0x0000000091199000 004FEB (v02 AMD    INTGPP01 00000001 INTL 20200717)
[    0.002720] ACPI: SSDT 0x0000000091198000 0009DB (v02 AMD    CPMGPIO0 00000001 INTL 20200717)
[    0.002721] ACPI: SSDT 0x0000000091197000 00008D (v02 AMD    CPMMSLPI 00000001 INTL 20200717)
[    0.002722] ACPI: SSDT 0x0000000091195000 0010EF (v01 AMD    CPMUCSI  00000001 INTL 20200717)
[    0.002723] ACPI: SSDT 0x0000000091194000 000CE0 (v02 AMD    WwanSsdt 00000001 INTL 20200717)
[    0.002724] ACPI: SSDT 0x0000000091193000 000747 (v02 AMD    NVME     00000001 INTL 20200717)
[    0.002725] ACPI: SSDT 0x0000000091191000 001470 (v02 AMD    UPEP     00000001 INTL 20200717)
[    0.002726] ACPI: Reserving FACP table memory at [mem 0x911f1000-0x911f1113]
[    0.002726] ACPI: Reserving DSDT table memory at [mem 0x911de000-0x911f006d]
[    0.002727] ACPI: Reserving FACS table memory at [mem 0x924a1000-0x924a103f]
[    0.002727] ACPI: Reserving MSDM table memory at [mem 0x911fc000-0x911fc054]
[    0.002727] ACPI: Reserving SSDT table memory at [mem 0x911f3000-0x911fb415]
[    0.002727] ACPI: Reserving SSDT table memory at [mem 0x911f2000-0x911f2220]
[    0.002728] ACPI: Reserving FIDT table memory at [mem 0x911dd000-0x911dd09b]
[    0.002728] ACPI: Reserving ECDT table memory at [mem 0x911dc000-0x911dc0c0]
[    0.002728] ACPI: Reserving MCFG table memory at [mem 0x911db000-0x911db03b]
[    0.002728] ACPI: Reserving HPET table memory at [mem 0x911da000-0x911da037]
[    0.002729] ACPI: Reserving FPDT table memory at [mem 0x911d9000-0x911d9043]
[    0.002729] ACPI: Reserving VFCT table memory at [mem 0x911d4000-0x911d8283]
[    0.002729] ACPI: Reserving SSDT table memory at [mem 0x911ce000-0x911d347d]
[    0.002729] ACPI: Reserving CRAT table memory at [mem 0x911cd000-0x911cdee7]
[    0.002730] ACPI: Reserving CDIT table memory at [mem 0x911cc000-0x911cc028]
[    0.002730] ACPI: Reserving BGRT table memory at [mem 0x911cb000-0x911cb037]
[    0.002730] ACPI: Reserving TPM2 table memory at [mem 0x911ca000-0x911ca043]
[    0.002730] ACPI: Reserving SSDT table memory at [mem 0x911c8000-0x911c95c7]
[    0.002731] ACPI: Reserving SSDT table memory at [mem 0x911c5000-0x911c78e0]
[    0.002731] ACPI: Reserving SSDT table memory at [mem 0x911c4000-0x911c4023]
[    0.002731] ACPI: Reserving SSDT table memory at [mem 0x911be000-0x911c30d5]
[    0.002731] ACPI: Reserving SSDT table memory at [mem 0x911bd000-0x911bd934]
[    0.002732] ACPI: Reserving SSDT table memory at [mem 0x911bc000-0x911bc9db]
[    0.002732] ACPI: Reserving SSDT table memory at [mem 0x911bb000-0x911bb63b]
[    0.002732] ACPI: Reserving SSDT table memory at [mem 0x911b1000-0x911ba893]
[    0.002732] ACPI: Reserving WSMT table memory at [mem 0x911b0000-0x911b0027]
[    0.002733] ACPI: Reserving APIC table memory at [mem 0x911af000-0x911af0e7]
[    0.002733] ACPI: Reserving MHSP table memory at [mem 0x911ae000-0x911ae0c7]
[    0.002733] ACPI: Reserving SSDT table memory at [mem 0x911ad000-0x911ad0e4]
[    0.002733] ACPI: Reserving IVRS table memory at [mem 0x911ac000-0x911ac1a3]
[    0.002734] ACPI: Reserving SSDT table memory at [mem 0x911ab000-0x911ab955]
[    0.002734] ACPI: Reserving SSDT table memory at [mem 0x911aa000-0x911aaeac]
[    0.002734] ACPI: Reserving SSDT table memory at [mem 0x911a9000-0x911a97dc]
[    0.002734] ACPI: Reserving SSDT table memory at [mem 0x911a8000-0x911a8ff6]
[    0.002735] ACPI: Reserving SSDT table memory at [mem 0x9119e000-0x911a77e2]
[    0.002735] ACPI: Reserving SSDT table memory at [mem 0x91199000-0x9119dfea]
[    0.002735] ACPI: Reserving SSDT table memory at [mem 0x91198000-0x911989da]
[    0.002736] ACPI: Reserving SSDT table memory at [mem 0x91197000-0x9119708c]
[    0.002736] ACPI: Reserving SSDT table memory at [mem 0x91195000-0x911960ee]
[    0.002736] ACPI: Reserving SSDT table memory at [mem 0x91194000-0x91194cdf]
[    0.002736] ACPI: Reserving SSDT table memory at [mem 0x91193000-0x91193746]
[    0.002737] ACPI: Reserving SSDT table memory at [mem 0x91191000-0x9119246f]
[    0.002794] No NUMA configuration found
[    0.002794] Faking a node at [mem 0x0000000000000000-0x000000041e2fffff]
[    0.002796] NODE_DATA(0) allocated [mem 0x41e2fb000-0x41e2fffff]
[    0.002810] Zone ranges:
[    0.002810]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002811]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002812]   Normal   [mem 0x0000000100000000-0x000000041e2fffff]
[    0.002812]   Device   empty
[    0.002813] Movable zone start for each node
[    0.002813] Early memory node ranges
[    0.002814]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.002815]   node   0: [mem 0x0000000000100000-0x0000000009a7efff]
[    0.002815]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.002815]   node   0: [mem 0x000000000a23c000-0x000000008e2fefff]
[    0.002816]   node   0: [mem 0x000000009adff000-0x000000009bff8fff]
[    0.002816]   node   0: [mem 0x000000009bffd000-0x000000009bffefff]
[    0.002816]   node   0: [mem 0x0000000100000000-0x000000041e2fffff]
[    0.002817] Initmem setup node 0 [mem 0x0000000000001000-0x000000041e2fffff]
[    0.002820] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002829] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.002906] On node 0, zone DMA32: 1409 pages in unavailable ranges
[    0.004291] On node 0, zone DMA32: 60 pages in unavailable ranges
[    0.004372] On node 0, zone DMA32: 19200 pages in unavailable ranges
[    0.004373] On node 0, zone DMA32: 4 pages in unavailable ranges
[    0.013106] On node 0, zone Normal: 16385 pages in unavailable ranges
[    0.013132] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.013372] ACPI: PM-Timer IO Port: 0x808
[    0.013379] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.013391] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
[    0.013397] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55
[    0.013398] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.013400] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
[    0.013400] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.013402] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.013403] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.013410] e820: update [mem 0x884cd000-0x8871dfff] usable ==> reserved
[    0.013420] CPU topo: Max. logical packages:   1
[    0.013420] CPU topo: Max. logical dies:       1
[    0.013421] CPU topo: Max. dies per package:   1
[    0.013423] CPU topo: Max. threads per core:   2
[    0.013423] CPU topo: Num. cores per package:     8
[    0.013424] CPU topo: Num. threads per package:  16
[    0.013424] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.013435] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.013436] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.013437] PM: hibernation: Registered nosave memory: [mem 0x09a7f000-0x09ffffff]
[    0.013437] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a23bfff]
[    0.013438] PM: hibernation: Registered nosave memory: [mem 0x794b1000-0x794b1fff]
[    0.013439] PM: hibernation: Registered nosave memory: [mem 0x794b5000-0x794b5fff]
[    0.013439] PM: hibernation: Registered nosave memory: [mem 0x8789c000-0x8789cfff]
[    0.013440] PM: hibernation: Registered nosave memory: [mem 0x884cd000-0x8871dfff]
[    0.013440] PM: hibernation: Registered nosave memory: [mem 0x8e2ff000-0x910fefff]
[    0.013440] PM: hibernation: Registered nosave memory: [mem 0x910ff000-0x911fefff]
[    0.013441] PM: hibernation: Registered nosave memory: [mem 0x911ff000-0x966fefff]
[    0.013441] PM: hibernation: Registered nosave memory: [mem 0x966ff000-0x9adfefff]
[    0.013441] PM: hibernation: Registered nosave memory: [mem 0x9bff9000-0x9bffcfff]
[    0.013442] PM: hibernation: Registered nosave memory: [mem 0x9bfff000-0x9cffffff]
[    0.013442] PM: hibernation: Registered nosave memory: [mem 0x9d000000-0x9d78ffff]
[    0.013442] PM: hibernation: Registered nosave memory: [mem 0x9d790000-0x9d7effff]
[    0.013443] PM: hibernation: Registered nosave memory: [mem 0x9d7f0000-0x9d7f4fff]
[    0.013443] PM: hibernation: Registered nosave memory: [mem 0x9d7f5000-0x9fffffff]
[    0.013443] PM: hibernation: Registered nosave memory: [mem 0xa0000000-0xfedfffff]
[    0.013443] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.013443] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
[    0.013445] [mem 0xa0000000-0xfedfffff] available for PCI devices
[    0.013447] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.017231] setup_percpu: NR_CPUS:320 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.017513] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u262144
[    0.017517] pcpu-alloc: s225280 r8192 d28672 u262144 alloc=1*2097152
[    0.017518] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.017526] Kernel command line: initrd=\initramfs-frzr.img root=gpt-auto rw quiet splash loglevel=3 rd.systemd.show_status=auto rd.udev.log_priority=3 preempt=full nowatchdog
[    0.019347] Dynamic Preempt: full
[    0.019350] Unknown kernel command line parameters "splash", will be passed to user space.
[    0.020326] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.020718] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.020770] Fallback order for Node 0: 0 
[    0.020772] Built 1 zonelists, mobility grouping on.  Total pages: 3854813
[    0.020772] Policy zone: Normal
[    0.020893] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.020939] software IO TLB: area num 16.
[    0.043181] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.043209] ftrace: allocating 47991 entries in 188 pages
[    0.043294] ftrace: allocated 188 pages with 5 groups
[    0.043376] rcu: Preemptible hierarchical RCU implementation.
[    0.043377] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=16.
[    0.043377] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.043378] 	Trampoline variant of Tasks RCU enabled.
[    0.043378] 	Rude variant of Tasks RCU enabled.
[    0.043379] 	Tracing variant of Tasks RCU enabled.
[    0.043379] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    0.043379] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.043387] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.043389] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.043390] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.044698] NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16
[    0.044892] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.045049] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.045077] Console: colour dummy device 80x25
[    0.045079] printk: legacy console [tty0] enabled
[    0.045105] ACPI: Core revision 20240322
[    0.045278] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.045298] APIC: Switch to symmetric I/O mode setup
[    0.045697] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160
[    0.045698] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160
[    0.045698] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160
[    0.045699] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160
[    0.045699] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
[    0.046049] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.046057] APIC: Switched APIC routing to: physical flat
[    0.046826] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.061969] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2f7aff227d7, max_idle_ns: 440795312506 ns
[    0.061972] Calibrating delay loop (skipped), value calculated using timer frequency.. 6590.40 BogoMIPS (lpj=10979853)
[    0.061992] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.062041] LVT offset 1 assigned for vector 0xf9
[    0.062215] LVT offset 2 assigned for vector 0xf4
[    0.062254] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.062255] Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
[    0.062262] process: using mwait in idle threads
[    0.062264] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.062267] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.062268] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.062270] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.062271] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.062272] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.062274] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.062282] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.062283] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.062284] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.062284] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.062285] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.062285] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.062285] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.062286] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.062286] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.062287] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.062288] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.062288] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.062288] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.062289] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.062289] x86/fpu: Enabled xstate features 0xae7, context size is 2456 bytes, using 'compacted' format.
[    0.076775] SMP alternatives: Using kCFI
[    0.090937] Freeing SMP alternatives memory: 108K
[    0.090938] pid_max: default: 32768 minimum: 301
[    0.092544] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
[    0.092561] landlock: Up and running.
[    0.092561] Yama: becoming mindful.
[    0.092565] LSM support for eBPF active
[    0.092594] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.092608] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.203504] smpboot: CPU0: AMD Ryzen Z1 Extreme (family: 0x19, model: 0x74, stepping: 0x1)
[    0.203682] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PMU driver.
[    0.203702] ... version:                2
[    0.203703] ... bit width:              48
[    0.203703] ... generic registers:      6
[    0.203704] ... value mask:             0000ffffffffffff
[    0.203705] ... max period:             00007fffffffffff
[    0.203705] ... fixed-purpose events:   0
[    0.203706] ... event mask:             000000000000003f
[    0.203790] signal: max sigframe size: 3376
[    0.203813] rcu: Hierarchical SRCU implementation.
[    0.203814] rcu: 	Max phase no-delay instances is 1000.
[    0.203861] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.209335] MCE: In-kernel MCE decoding enabled.
[    0.209462] smp: Bringing up secondary CPUs ...
[    0.209548] smpboot: x86: Booting SMP configuration:
[    0.209549] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.227306] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.241987] smp: Brought up 1 node, 16 CPUs
[    0.241987] smpboot: Total of 16 processors activated (105448.53 BogoMIPS)
[    0.243389] Memory: 14961496K/15419252K available (22528K kernel code, 2040K rwdata, 12828K rodata, 3428K init, 3268K bss, 442580K reserved, 0K cma-reserved)
[    0.243389] devtmpfs: initialized
[    0.243389] x86/mm: Memory block size: 128MB
[    0.245714] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a23bfff] (245760 bytes)
[    0.245714] ACPI: PM: Registering ACPI NVS region [mem 0x911ff000-0x966fefff] (89128960 bytes)
[    0.245820] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.245832] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.245884] pinctrl core: initialized pinctrl subsystem
[    0.246099] PM: RTC time: 23:10:22, date: 2024-09-19
[    0.246337] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.246457] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.246522] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.246589] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.246597] audit: initializing netlink subsys (disabled)
[    0.246602] audit: type=2000 audit(1726787421.199:1): state=initialized audit_enabled=0 res=1
[    0.246602] thermal_sys: Registered thermal governor 'fair_share'
[    0.246602] thermal_sys: Registered thermal governor 'bang_bang'
[    0.246602] thermal_sys: Registered thermal governor 'step_wise'
[    0.246602] thermal_sys: Registered thermal governor 'user_space'
[    0.246602] thermal_sys: Registered thermal governor 'power_allocator'
[    0.246602] cpuidle: using governor ladder
[    0.246602] cpuidle: using governor menu
[    0.246602] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.246602] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.246602] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.246602] PCI: Using configuration type 1 for base access
[    0.246602] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.253224] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.253224] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.253224] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.253224] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.253224] ACPI: Added _OSI(Module Device)
[    0.253224] ACPI: Added _OSI(Processor Device)
[    0.253224] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.253224] ACPI: Added _OSI(Processor Aggregator Device)
[    0.263684] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GPP2.WWAN], AE_NOT_FOUND (20240322/dswload2-163)
[    0.263689] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20240322/psobject-220)
[    0.263691] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.264216] ACPI: 25 ACPI AML tables successfully acquired and loaded
[    0.265346] ACPI: EC: EC started
[    0.265347] ACPI: EC: interrupt blocked
[    0.265824] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.265825] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.269277] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.279556] ACPI: Interpreter enabled
[    0.279570] ACPI: PM: (supports S0 S4 S5)
[    0.279571] ACPI: Using IOAPIC for interrupt routing
[    0.280478] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.280478] PCI: Ignoring E820 reservations for host bridge windows
[    0.280478] ACPI: Enabled 4 GPEs in block 00 to 1F
[    0.280478] ACPI: \_SB_.PCI0.GPP2.P0WW: New power resource
[    0.280478] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.284044] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resource
[    0.284098] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power resource
[    0.284338] ACPI: \_SB_.PCI0.GPP7.RPR2: New power resource

[    0.284549] ACPI: \_SB_.PCI0.GPP8.P0NV: New power resource
[    0.285332] ACPI: \_SB_.PCI0.GP11.PWRS: New power resource
[    0.285769] ACPI: \_SB_.PCI0.GP11.SWUS.PWRS: New power resource
[    0.286165] ACPI: \_SB_.PCI0.GP12.PWRS: New power resource
[    0.286585] ACPI: \_SB_.PCI0.GP12.SWUS.PWRS: New power resource
[    0.286748] ACPI: \_SB_.PCI0.GP17.PWRS: New power resource
[    0.286924] ACPI: \_SB_.PCI0.GP17.VGA_.PWRS: New power resource
[    0.287134] ACPI: \_SB_.PCI0.GP17.HDAU.PWRS: New power resource
[    0.287314] ACPI: \_SB_.PCI0.GP17.ACP_.PWRS: New power resource
[    0.287709] ACPI: \_SB_.PCI0.GP17.AZAL.PWRS: New power resource
[    0.288108] ACPI: \_SB_.PCI0.GP17.XHC0.PWRS: New power resource
[    0.288462] ACPI: \_SB_.PCI0.GP17.XHC0.RHUB.PRT4.BTPR: New power resource
[    0.288796] ACPI: \_SB_.PCI0.GP17.XHC1.PWRS: New power resource
[    0.289428] ACPI: \_SB_.PCI0.GP19.XHC2.PWRS: New power resource
[    0.290035] ACPI: \_SB_.PCI0.GP19.XHC3.PWRS: New power resource
[    0.290659] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
[    0.291288] ACPI: \_SB_.PCI0.GP19.NHI0.PWRS: New power resource
[    0.291694] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
[    0.296550] ACPI: \_SB_.PRWL: New power resource
[    0.297407] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.297411] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.297527] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.297528] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.297961] PCI host bridge to bus 0000:00
[    0.297964] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.297966] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.297967] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.297968] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.297969] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfcffffff window]
[    0.297970] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xf9ffffff window]
[    0.297970] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdfffffff window]
[    0.297971] pci_bus 0000:00: root bus resource [mem 0x460000000-0x7fffffffff window]
[    0.297972] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.297985] pci 0000:00:00.0: [1022:14e8] type 00 class 0x060000 conventional PCI endpoint
[    0.298074] pci 0000:00:00.2: [1022:14e9] type 00 class 0x080600 conventional PCI endpoint
[    0.298152] pci 0000:00:01.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.298202] pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
[    0.298220] pci 0000:00:01.1: PCI bridge to [bus 01-05]
[    0.298224] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.298227] pci 0000:00:01.1:   bridge window [mem 0xfb000000-0xfc0fffff]
[    0.298234] pci 0000:00:01.1:   bridge window [mem 0x7000000000-0x7801ffffff 64bit pref]
[    0.298241] pci 0000:00:01.1: enabling Extended Tags
[    0.298298] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.298687] pci 0000:00:02.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.298744] pci 0000:00:02.2: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.298762] pci 0000:00:02.2: PCI bridge to [bus 06]
[    0.298767] pci 0000:00:02.2:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.298774] pci 0000:00:02.2:   bridge window [mem 0x7820900000-0x78209fffff 64bit pref]
[    0.298834] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.298951] pci 0000:00:02.3: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.298969] pci 0000:00:02.3: PCI bridge to [bus 07]
[    0.298975] pci 0000:00:02.3:   bridge window [mem 0xfcb00000-0xfcbfffff]
[    0.299039] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.299157] pci 0000:00:02.4: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.299175] pci 0000:00:02.4: PCI bridge to [bus 08]
[    0.299180] pci 0000:00:02.4:   bridge window [mem 0xfca00000-0xfcafffff]
[    0.299194] pci 0000:00:02.4: enabling Extended Tags
[    0.299247] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    0.299366] pci 0000:00:03.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.299422] pci 0000:00:04.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.299482] pci 0000:00:08.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.299529] pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.299544] pci 0000:00:08.1: PCI bridge to [bus 09]
[    0.299547] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.299549] pci 0000:00:08.1:   bridge window [mem 0xfc200000-0xfc7fffff]
[    0.299555] pci 0000:00:08.1:   bridge window [mem 0x7810000000-0x78207fffff 64bit pref]
[    0.299560] pci 0000:00:08.1: enabling Extended Tags
[    0.299598] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.299699] pci 0000:00:08.2: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.299716] pci 0000:00:08.2: PCI bridge to [bus 0a]
[    0.299730] pci 0000:00:08.2: enabling Extended Tags
[    0.299768] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.299846] pci 0000:00:08.3: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.299861] pci 0000:00:08.3: PCI bridge to [bus 0b]
[    0.299865] pci 0000:00:08.3:   bridge window [mem 0xfc800000-0xfc9fffff]
[    0.299876] pci 0000:00:08.3: enabling Extended Tags
[    0.299913] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.300110] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
[    0.300218] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
[    0.300336] pci 0000:00:18.0: [1022:14f0] type 00 class 0x060000 conventional PCI endpoint
[    0.300361] pci 0000:00:18.1: [1022:14f1] type 00 class 0x060000 conventional PCI endpoint
[    0.300386] pci 0000:00:18.2: [1022:14f2] type 00 class 0x060000 conventional PCI endpoint
[    0.300411] pci 0000:00:18.3: [1022:14f3] type 00 class 0x060000 conventional PCI endpoint
[    0.300436] pci 0000:00:18.4: [1022:14f4] type 00 class 0x060000 conventional PCI endpoint
[    0.300460] pci 0000:00:18.5: [1022:14f5] type 00 class 0x060000 conventional PCI endpoint
[    0.300485] pci 0000:00:18.6: [1022:14f6] type 00 class 0x060000 conventional PCI endpoint
[    0.300510] pci 0000:00:18.7: [1022:14f7] type 00 class 0x060000 conventional PCI endpoint
[    0.300600] pci 0000:00:01.1: PCI bridge to [bus 01-05]
[    0.300659] pci 0000:06:00.0: [14c3:0616] type 00 class 0x028000 PCIe Endpoint
[    0.300682] pci 0000:06:00.0: BAR 0 [mem 0x7820900000-0x78209fffff 64bit pref]
[    0.300698] pci 0000:06:00.0: BAR 2 [mem 0xfcc00000-0xfcc07fff 64bit]
[    0.300801] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.300991] pci 0000:00:02.2: PCI bridge to [bus 06]
[    0.301281] pci 0000:07:00.0: [17a0:9755] type 00 class 0x080501 PCIe Endpoint
[    0.301405] pci 0000:07:00.0: BAR 0 [mem 0xfcb00000-0xfcb00fff]
[    0.302479] pci 0000:07:00.0: supports D1 D2
[    0.302480] pci 0000:07:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.303621] pci 0000:00:02.3: PCI bridge to [bus 07]
[    0.303728] pci 0000:08:00.0: [1344:5413] type 00 class 0x010802 PCIe Endpoint
[    0.303744] pci 0000:08:00.0: BAR 0 [mem 0xfca00000-0xfca03fff 64bit]
[    0.304085] pci 0000:00:02.4: PCI bridge to [bus 08]
[    0.304161] pci 0000:09:00.0: [1002:15bf] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.304174] pci 0000:09:00.0: BAR 0 [mem 0x7810000000-0x781fffffff 64bit pref]
[    0.304182] pci 0000:09:00.0: BAR 2 [mem 0xfc200000-0xfc3fffff 64bit pref]
[    0.304188] pci 0000:09:00.0: BAR 4 [io  0xe000-0xe0ff]
[    0.304194] pci 0000:09:00.0: BAR 5 [mem 0xfc700000-0xfc77ffff]
[    0.304203] pci 0000:09:00.0: enabling Extended Tags
[    0.304264] pci 0000:09:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.304393] pci 0000:09:00.1: [1002:1640] type 00 class 0x040300 PCIe Legacy Endpoint
[    0.304402] pci 0000:09:00.1: BAR 0 [mem 0xfc7c8000-0xfc7cbfff]
[    0.304426] pci 0000:09:00.1: enabling Extended Tags
[    0.304462] pci 0000:09:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.304532] pci 0000:09:00.2: [1022:15c7] type 00 class 0x108000 PCIe Endpoint
[    0.304547] pci 0000:09:00.2: BAR 2 [mem 0xfc600000-0xfc6fffff]
[    0.304558] pci 0000:09:00.2: BAR 5 [mem 0xfc7cc000-0xfc7cdfff]
[    0.304565] pci 0000:09:00.2: enabling Extended Tags
[    0.304669] pci 0000:09:00.3: [1022:15b9] type 00 class 0x0c0330 PCIe Endpoint
[    0.304682] pci 0000:09:00.3: BAR 0 [mem 0xfc500000-0xfc5fffff 64bit]
[    0.304710] pci 0000:09:00.3: enabling Extended Tags
[    0.304748] pci 0000:09:00.3: PME# supported from D0 D3hot D3cold
[    0.304823] pci 0000:09:00.4: [1022:15ba] type 00 class 0x0c0330 PCIe Endpoint
[    0.304835] pci 0000:09:00.4: BAR 0 [mem 0xfc400000-0xfc4fffff 64bit]
[    0.304863] pci 0000:09:00.4: enabling Extended Tags
[    0.304902] pci 0000:09:00.4: PME# supported from D0 D3hot D3cold
[    0.304974] pci 0000:09:00.5: [1022:15e2] type 00 class 0x048000 PCIe Endpoint
[    0.304982] pci 0000:09:00.5: BAR 0 [mem 0xfc780000-0xfc7bffff]
[    0.304992] pci 0000:09:00.5: BAR 2 [mem 0x7820000000-0x78207fffff 64bit pref]
[    0.305007] pci 0000:09:00.5: enabling Extended Tags
[    0.305043] pci 0000:09:00.5: PME# supported from D0 D3hot D3cold
[    0.305115] pci 0000:09:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
[    0.305125] pci 0000:09:00.6: BAR 0 [mem 0xfc7c0000-0xfc7c7fff]
[    0.305157] pci 0000:09:00.6: enabling Extended Tags
[    0.305193] pci 0000:09:00.6: PME# supported from D0 D3hot D3cold
[    0.305273] pci 0000:00:08.1: PCI bridge to [bus 09]
[    0.305315] pci 0000:0a:00.0: [1022:14ec] type 00 class 0x130000 PCIe Endpoint
[    0.305346] pci 0000:0a:00.0: enabling Extended Tags
[    0.305394] pci 0000:0a:00.0: PME# supported from D3hot D3cold
[    0.305479] pci 0000:00:08.2: PCI bridge to [bus 0a]
[    0.305540] pci 0000:0b:00.0: [1022:14ec] type 00 class 0x130000 PCIe Endpoint
[    0.305572] pci 0000:0b:00.0: enabling Extended Tags
[    0.305710] pci 0000:0b:00.3: [1022:15c0] type 00 class 0x0c0330 PCIe Endpoint
[    0.305722] pci 0000:0b:00.3: BAR 0 [mem 0xfc900000-0xfc9fffff 64bit]
[    0.305750] pci 0000:0b:00.3: enabling Extended Tags
[    0.305788] pci 0000:0b:00.3: PME# supported from D0 D3hot D3cold
[    0.305860] pci 0000:0b:00.4: [1022:15c1] type 00 class 0x0c0330 PCIe Endpoint
[    0.305873] pci 0000:0b:00.4: BAR 0 [mem 0xfc800000-0xfc8fffff 64bit]
[    0.305900] pci 0000:0b:00.4: enabling Extended Tags
[    0.305939] pci 0000:0b:00.4: PME# supported from D0 D3hot D3cold
[    0.306013] pci 0000:00:08.3: PCI bridge to [bus 0b]
[    0.312543] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.312582] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.312615] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.312656] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.312694] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.312725] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.312756] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.312787] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.315835] Low-power S0 idle used by default for system suspend
[    0.316036] ACPI: EC: interrupt unblocked
[    0.316037] ACPI: EC: event unblocked
[    0.316044] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.316045] ACPI: EC: GPE=0x10
[    0.316046] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot ECDT EC initialization complete
[    0.316047] ACPI: \_SB_.PCI0.SBRG.EC0_: EC: Used to handle transactions and events
[    0.316082] iommu: Default domain type: Translated
[    0.316082] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.316082] SCSI subsystem initialized
[    0.316082] libata version 3.00 loaded.
[    0.316082] ACPI: bus type USB registered
[    0.316082] usbcore: registered new interface driver usbfs
[    0.316082] usbcore: registered new interface driver hub
[    0.316082] usbcore: registered new device driver usb
[    0.370128] EDAC MC: Ver: 3.0.0
[    0.371990] efivars: Registered efivars operations
[    0.372099] NetLabel: Initializing
[    0.372100] NetLabel:  domain hash size = 128
[    0.372101] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.372109] NetLabel:  unlabeled traffic allowed by default
[    0.372112] mctp: management component transport protocol core
[    0.372112] NET: Registered PF_MCTP protocol family
[    0.372115] PCI: Using ACPI for IRQ routing
[    0.379596] PCI: pci_cache_line_size set to 64 bytes
[    0.379973] e820: reserve RAM buffer [mem 0x09a7f000-0x0bffffff]
[    0.379974] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.379974] e820: reserve RAM buffer [mem 0x794b1018-0x7bffffff]
[    0.379975] e820: reserve RAM buffer [mem 0x8789c000-0x87ffffff]
[    0.379976] e820: reserve RAM buffer [mem 0x884cd000-0x8bffffff]
[    0.379976] e820: reserve RAM buffer [mem 0x8e2ff000-0x8fffffff]
[    0.379977] e820: reserve RAM buffer [mem 0x9bff9000-0x9bffffff]
[    0.379977] e820: reserve RAM buffer [mem 0x9bfff000-0x9bffffff]
[    0.379978] e820: reserve RAM buffer [mem 0x41e300000-0x41fffffff]
[    0.380001] pci 0000:09:00.0: vgaarb: setting as boot VGA device
[    0.380001] pci 0000:09:00.0: vgaarb: bridge control possible
[    0.380001] pci 0000:09:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.380001] vgaarb: loaded
[    0.380001] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.380001] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.382024] clocksource: Switched to clocksource tsc-early
[    0.382105] VFS: Disk quotas dquot_6.6.0
[    0.382111] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.382157] pnp: PnP ACPI init
[    0.382217] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.385178] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.385178] system 00:02: [io  0x040b] has been reserved
[    0.385178] system 00:02: [io  0x04d6] has been reserved
[    0.385178] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.385178] system 00:02: [io  0x0c14] has been reserved
[    0.385178] system 00:02: [io  0x0c50-0x0c51] has been reserved
[    0.385178] system 00:02: [io  0x0c52] has been reserved
[    0.385178] system 00:02: [io  0x0c6c] has been reserved
[    0.385178] system 00:02: [io  0x0c6f] has been reserved
[    0.385179] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    0.385180] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    0.385180] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    0.385181] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    0.385182] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    0.385183] system 00:02: [io  0x0800-0x089f] has been reserved
[    0.385184] system 00:02: [io  0x0b00-0x0b0f] has been reserved
[    0.385185] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    0.385186] system 00:02: [io  0x0900-0x090f] has been reserved
[    0.385186] system 00:02: [io  0x0910-0x091f] has been reserved
[    0.385188] system 00:02: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.385189] system 00:02: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.385190] system 00:02: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.385191] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.385192] system 00:02: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.385193] system 00:02: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.385194] system 00:02: [mem 0xff000000-0xffffffff] has been reserved
[    0.385338] ACPI: IRQ 1 override to edge, low(!)
[    0.385879] pnp: PnP ACPI: found 4 devices
[    0.391477] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.391552] NET: Registered PF_INET protocol family
[    0.391674] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.400150] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.400159] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.400197] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.400328] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.400384] TCP: Hash tables configured (established 131072 bind 65536)
[    0.400421] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
[    0.400444] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.400464] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.400507] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.400512] NET: Registered PF_XDP protocol family
[    0.400520] pci 0000:00:01.1: PCI bridge to [bus 01-05]
[    0.400527] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.400531] pci 0000:00:01.1:   bridge window [mem 0xfb000000-0xfc0fffff]
[    0.400533] pci 0000:00:01.1:   bridge window [mem 0x7000000000-0x7801ffffff 64bit pref]
[    0.400537] pci 0000:00:02.2: PCI bridge to [bus 06]
[    0.400540] pci 0000:00:02.2:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.400542] pci 0000:00:02.2:   bridge window [mem 0x7820900000-0x78209fffff 64bit pref]
[    0.400545] pci 0000:00:02.3: PCI bridge to [bus 07]
[    0.400548] pci 0000:00:02.3:   bridge window [mem 0xfcb00000-0xfcbfffff]
[    0.400553] pci 0000:00:02.4: PCI bridge to [bus 08]
[    0.400555] pci 0000:00:02.4:   bridge window [mem 0xfca00000-0xfcafffff]
[    0.400561] pci 0000:00:08.1: PCI bridge to [bus 09]
[    0.400562] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.400568] pci 0000:00:08.1:   bridge window [mem 0xfc200000-0xfc7fffff]
[    0.400569] pci 0000:00:08.1:   bridge window [mem 0x7810000000-0x78207fffff 64bit pref]
[    0.400573] pci 0000:00:08.2: PCI bridge to [bus 0a]
[    0.400578] pci 0000:00:08.3: PCI bridge to [bus 0b]
[    0.400580] pci 0000:00:08.3:   bridge window [mem 0xfc800000-0xfc9fffff]
[    0.400585] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.400586] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.400587] pci_bus 0000:00: resource 6 [io  0x0d00-0xffff window]
[    0.400588] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff window]
[    0.400589] pci_bus 0000:00: resource 8 [mem 0xfa000000-0xfcffffff window]
[    0.400589] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xf9ffffff window]
[    0.400590] pci_bus 0000:00: resource 10 [mem 0xa0000000-0xdfffffff window]
[    0.400591] pci_bus 0000:00: resource 11 [mem 0x460000000-0x7fffffffff window]
[    0.400592] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.400593] pci_bus 0000:01: resource 1 [mem 0xfb000000-0xfc0fffff]
[    0.400594] pci_bus 0000:01: resource 2 [mem 0x7000000000-0x7801ffffff 64bit pref]
[    0.400595] pci_bus 0000:06: resource 1 [mem 0xfcc00000-0xfccfffff]
[    0.400595] pci_bus 0000:06: resource 2 [mem 0x7820900000-0x78209fffff 64bit pref]
[    0.400596] pci_bus 0000:07: resource 1 [mem 0xfcb00000-0xfcbfffff]
[    0.400597] pci_bus 0000:08: resource 1 [mem 0xfca00000-0xfcafffff]
[    0.400598] pci_bus 0000:09: resource 0 [io  0xe000-0xefff]
[    0.400599] pci_bus 0000:09: resource 1 [mem 0xfc200000-0xfc7fffff]
[    0.400600] pci_bus 0000:09: resource 2 [mem 0x7810000000-0x78207fffff 64bit pref]
[    0.400601] pci_bus 0000:0b: resource 1 [mem 0xfc800000-0xfc9fffff]
[    0.400680] pci 0000:00:02.3: mask Replay Timer Timeout Correctable Errors due to 0000:07:00.0 hardware defect
[    0.400867] pci 0000:09:00.1: D0 power state depends on 0000:09:00.0
[    0.400926] pci 0000:00:08.1: can't derive routing for PCI INT A
[    0.400927] pci 0000:00:08.1: PCI INT A: not connected
[    0.401062] pci 0000:00:08.3: can't derive routing for PCI INT A
[    0.401062] pci 0000:00:08.3: PCI INT A: not connected
[    0.401162] PCI: CLS 64 bytes, default 64
[    0.401187] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.401229] pci 0000:00:01.0: Adding to iommu group 0
[    0.401229] Trying to unpack rootfs image as initramfs...
[    0.401240] pci 0000:00:01.1: Adding to iommu group 1
[    0.401255] pci 0000:00:02.0: Adding to iommu group 2
[    0.401265] pci 0000:00:02.2: Adding to iommu group 3
[    0.401275] pci 0000:00:02.3: Adding to iommu group 4
[    0.401284] pci 0000:00:02.4: Adding to iommu group 5
[    0.401296] pci 0000:00:03.0: Adding to iommu group 6
[    0.401309] pci 0000:00:04.0: Adding to iommu group 7
[    0.401324] pci 0000:00:08.0: Adding to iommu group 8
[    0.401333] pci 0000:00:08.1: Adding to iommu group 9
[    0.401342] pci 0000:00:08.2: Adding to iommu group 10
[    0.401351] pci 0000:00:08.3: Adding to iommu group 11
[    0.401368] pci 0000:00:14.0: Adding to iommu group 12
[    0.401377] pci 0000:00:14.3: Adding to iommu group 12
[    0.401417] pci 0000:00:18.0: Adding to iommu group 13
[    0.401426] pci 0000:00:18.1: Adding to iommu group 13
[    0.401435] pci 0000:00:18.2: Adding to iommu group 13
[    0.401444] pci 0000:00:18.3: Adding to iommu group 13
[    0.401454] pci 0000:00:18.4: Adding to iommu group 13
[    0.401463] pci 0000:00:18.5: Adding to iommu group 13
[    0.401472] pci 0000:00:18.6: Adding to iommu group 13
[    0.401481] pci 0000:00:18.7: Adding to iommu group 13
[    0.401497] pci 0000:06:00.0: Adding to iommu group 14
[    0.401507] pci 0000:07:00.0: Adding to iommu group 15
[    0.401517] pci 0000:08:00.0: Adding to iommu group 16
[    0.401539] pci 0000:09:00.0: Adding to iommu group 17
[    0.401550] pci 0000:09:00.1: Adding to iommu group 18
[    0.401560] pci 0000:09:00.2: Adding to iommu group 19
[    0.401571] pci 0000:09:00.3: Adding to iommu group 20
[    0.401582] pci 0000:09:00.4: Adding to iommu group 21
[    0.401593] pci 0000:09:00.5: Adding to iommu group 22
[    0.401604] pci 0000:09:00.6: Adding to iommu group 23
[    0.401613] pci 0000:0a:00.0: Adding to iommu group 24
[    0.401624] pci 0000:0b:00.0: Adding to iommu group 25
[    0.401635] pci 0000:0b:00.3: Adding to iommu group 26
[    0.401646] pci 0000:0b:00.4: Adding to iommu group 27
[    0.403520] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA PC GA_vAPIC
[    0.403529] AMD-Vi: Interrupt remapping enabled
[    0.403652] AMD-Vi: Virtual APIC enabled
[    0.403660] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.403669] software IO TLB: mapped [mem 0x00000000754b1000-0x00000000794b1000] (64MB)
[    0.403689] LVT offset 0 assigned for vector 0x400
[    0.406444] perf: AMD IBS detected (0x00000bff)
[    0.406456] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.408363] Initialise system trusted keyrings
[    0.408372] Key type blacklist registered
[    0.408408] workingset: timestamp_bits=41 max_order=22 bucket_order=0
[    0.408414] zbud: loaded
[    0.408482] fuse: init (API version 7.40)
[    0.408528] integrity: Platform Keyring initialized
[    0.408530] integrity: Machine keyring initialized
[    0.413848] Key type asymmetric registered
[    0.413849] Asymmetric key parser 'x509' registered
[    0.413861] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.413892] io scheduler mq-deadline registered
[    0.413893] io scheduler kyber registered
[    0.413899] io scheduler bfq registered
[    0.415263] pcieport 0000:00:01.1: PME: Signaling with IRQ 34
[    0.415304] pcieport 0000:00:01.1: AER: enabled with IRQ 34
[    0.415318] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.415467] pcieport 0000:00:02.2: PME: Signaling with IRQ 35
[    0.415506] pcieport 0000:00:02.2: AER: enabled with IRQ 35
[    0.415611] pcieport 0000:00:02.3: PME: Signaling with IRQ 36
[    0.415651] pcieport 0000:00:02.3: AER: enabled with IRQ 36
[    0.415758] pcieport 0000:00:02.4: PME: Signaling with IRQ 37
[    0.415800] pcieport 0000:00:02.4: AER: enabled with IRQ 37
[    0.415902] pcieport 0000:00:08.1: PME: Signaling with IRQ 38
[    0.415984] pcieport 0000:00:08.2: can't derive routing for PCI INT A
[    0.415985] pcieport 0000:00:08.2: PCI INT A: not connected
[    0.416030] pcieport 0000:00:08.2: PME: Signaling with IRQ 39
[    0.416113] pcieport 0000:00:08.3: PME: Signaling with IRQ 40
[    0.416188] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.416751] ACPI: AC: AC Adapter [AC0] (on-line)
[    0.416789] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.416800] ACPI: button: Power Button [PWRB]
[    0.416817] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.416827] ACPI: button: Sleep Button [SLPB]
[    0.417171] Estimated ratio of average max frequency by base frequency (times 1024): 1548
[    0.417187] Monitor-Mwait will be used to enter C-1 state
[    0.417191] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    0.417294] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    0.417350] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    0.417435] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    0.417558] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    0.417677] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    0.417800] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
[    0.417920] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
[    0.418025] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    0.418102] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    0.418159] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    0.418246] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    0.418352] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    0.418460] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    0.418568] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
[    0.418669] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
[    0.419778] thermal LNXTHERM:00: registered as thermal_zone0
[    0.419780] ACPI: thermal: Thermal Zone [THRM] (60 C)
[    0.419933] thermal LNXTHERM:01: registered as thermal_zone1
[    0.419935] ACPI: thermal: Thermal Zone [TZ01] (20 C)
[    0.420165] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.420526] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.421869] Non-volatile memory driver v1.3
[    0.424245] ACPI: battery: Slot [BAT0] (battery present)
[    0.492448] ACPI: bus type drm_connector registered
[    0.494196] usbcore: registered new interface driver usbserial_generic
[    0.494200] usbserial: USB Serial support registered for generic
[    0.494285] rtc_cmos 00:01: RTC can wake from S4
[    0.494517] rtc_cmos 00:01: registered as rtc0
[    0.494553] rtc_cmos 00:01: setting system clock to 2024-09-19T23:10:22 UTC (1726787422)
[    0.494584] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    0.498519] ledtrig-cpu: registered to indicate activity on CPUs
[    0.498831] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    0.500274] fbcon: Deferring console take-over
[    0.500276] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.500313] hid: raw HID events driver (C) Jiri Kosina
[    0.500356] drop_monitor: Initializing network drop monitor service
[    0.500447] NET: Registered PF_INET6 protocol family
[    1.433731] tsc: Refined TSC clocksource calibration: 3293.782 MHz
[    1.433738] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2f7a5a93bc9, max_idle_ns: 440795240669 ns
[    1.433778] clocksource: Switched to clocksource tsc
[    1.483804] Freeing initrd memory: 47116K
[    1.489104] Segment Routing with IPv6
[    1.489105] RPL Segment Routing with IPv6
[    1.489116] In-situ OAM (IOAM) with IPv6
[    1.489147] NET: Registered PF_PACKET protocol family
[    1.491724] microcode: Current revision: 0x0a704104
[    1.492545] resctrl: L3 allocation detected
[    1.492549] resctrl: MB allocation detected
[    1.492551] resctrl: SMBA allocation detected
[    1.492552] resctrl: L3 monitoring detected
[    1.492584] IPI shorthand broadcast: enabled
[    1.493851] sched_clock: Marking stable (1493333899, 382620)->(1503951976, -10235457)
[    1.493991] registered taskstats version 1
[    1.494836] Loading compiled-in X.509 certificates
[    1.496269] Loaded X.509 cert 'Build time autogenerated kernel key: 88e0b33328a369262766d649accd99a983dab9a9'
[    1.498934] zswap: loaded using pool zstd/zsmalloc
[    1.498992] Demotion targets for Node 0: null
[    1.499165] Key type .fscrypt registered
[    1.499166] Key type fscrypt-provisioning registered
[    1.499271] integrity: Loading X.509 certificate: UEFI:db
[    1.501826] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    1.501828] integrity: Loading X.509 certificate: UEFI:db
[    1.501851] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.501852] integrity: Loading X.509 certificate: UEFI:db
[    1.501870] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.502986] PM:   Magic number: 8:504:201
[    1.505577] RAS: Correctable Errors collector initialized.
[    1.514635] clk: Disabling unused clocks
[    1.514639] PM: genpd: Disabling unused power domains
[    1.515775] Freeing unused decrypted memory: 2044K
[    1.516093] Freeing unused kernel image (initmem) memory: 3428K
[    1.516106] Write protecting the kernel read-only data: 36864k
[    1.516391] Freeing unused kernel image (rodata/data gap) memory: 1508K
[    1.549439] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.549442] rodata_test: all tests were successful
[    1.549446] Run /init as init process
[    1.549447]   with arguments:
[    1.549448]     /init
[    1.549449]     splash
[    1.549449]   with environment:
[    1.549450]     HOME=/
[    1.549451]     TERM=linux
[    1.556810] systemd[1]: Successfully made /usr/ read-only.
[    1.556897] systemd[1]: systemd 256.6-1-arch running in system mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    1.556900] systemd[1]: Detected architecture x86-64.
[    1.556901] systemd[1]: Running in initrd.
[    1.557010] systemd[1]: Initializing machine ID from random generator.
[    1.640476] systemd[1]: Queued start job for default target Initrd Default Target.
[    1.677797] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    1.677860] systemd[1]: Expecting device /dev/gpt-auto-root...
[    1.677883] systemd[1]: Reached target Initrd /usr File System.
[    1.677903] systemd[1]: Reached target Path Units.
[    1.677920] systemd[1]: Reached target Slice Units.
[    1.677938] systemd[1]: Reached target Swaps.
[    1.677958] systemd[1]: Reached target Timer Units.
[    1.678061] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.678140] systemd[1]: Listening on Journal Sockets.
[    1.678219] systemd[1]: Listening on udev Control Socket.
[    1.678268] systemd[1]: Listening on udev Kernel Socket.
[    1.678281] systemd[1]: Reached target Socket Units.
[    1.679198] systemd[1]: Starting Create List of Static Device Nodes...
[    1.680068] systemd[1]: Starting Journal Service...
[    1.680512] systemd[1]: Starting Load Kernel Modules...
[    1.680908] systemd[1]: Starting Virtual Console Setup...
[    1.683087] systemd[1]: Finished Create List of Static Device Nodes.
[    1.683543] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    1.688062] systemd[1]: Finished Load Kernel Modules.
[    1.688216] systemd[1]: Finished Create Static Device Nodes in /dev gracefully.
[    1.688657] systemd[1]: Starting Apply Kernel Variables...
[    1.688819] systemd-journald[219]: Collecting audit messages is disabled.
[    1.689050] systemd[1]: Starting Create System Users...
[    1.692440] systemd[1]: Finished Virtual Console Setup.
[    1.692919] systemd[1]: Starting dracut ask for additional cmdline parameters...
[    1.693059] systemd[1]: Finished Apply Kernel Variables.
[    1.693515] systemd[1]: Finished Create System Users.
[    1.693963] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.698405] systemd[1]: Finished Create Static Device Nodes in /dev.
[    1.698496] systemd[1]: Reached target Preparation for Local File Systems.
[    1.698511] systemd[1]: Reached target Local File Systems.
[    1.707833] systemd[1]: Started Journal Service.
[    1.772676] xor: automatically using best checksumming function   avx       
[    1.775270] raid6: skipped pq benchmark and selected avx512x4
[    1.775271] raid6: using avx512x2 recovery algorithm
[    1.840479] Btrfs loaded, zoned=yes, fsverity=yes
[    1.948587] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.948593] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.950324] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.955858] ccp 0000:09:00.2: enabling device (0000 -> 0002)
[    1.956766] xhci_hcd 0000:09:00.3: xHCI Host Controller
[    1.956775] xhci_hcd 0000:09:00.3: new USB bus registered, assigned bus number 1
[    1.957213] ccp 0000:09:00.2: tee enabled
[    1.957255] xhci_hcd 0000:09:00.3: hcc params 0x0128ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.957602] ccp 0000:09:00.2: psp enabled
[    1.957818] xhci_hcd 0000:09:00.3: xHCI Host Controller
[    1.957822] xhci_hcd 0000:09:00.3: new USB bus registered, assigned bus number 2
[    1.957825] xhci_hcd 0000:09:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    1.957876] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.957880] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.957882] usb usb1: Product: xHCI Host Controller
[    1.957884] usb usb1: Manufacturer: Linux 6.11.0-00004-ge11bee8239e6-dirty xhci-hcd
[    1.957886] usb usb1: SerialNumber: 0000:09:00.3
[    1.958153] cryptd: max_cpu_qlen set to 1000
[    1.958238] hub 1-0:1.0: USB hub found
[    1.958259] hub 1-0:1.0: 5 ports detected
[    1.962752] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.962774] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.962777] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.962778] usb usb2: Product: xHCI Host Controller
[    1.962780] usb usb2: Manufacturer: Linux 6.11.0-00004-ge11bee8239e6-dirty xhci-hcd
[    1.962781] usb usb2: SerialNumber: 0000:09:00.3
[    1.962984] hub 2-0:1.0: USB hub found
[    1.963004] hub 2-0:1.0: 2 ports detected
[    1.965258] xhci_hcd 0000:09:00.4: xHCI Host Controller
[    1.965262] xhci_hcd 0000:09:00.4: new USB bus registered, assigned bus number 3
[    1.965694] xhci_hcd 0000:09:00.4: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.966121] xhci_hcd 0000:09:00.4: xHCI Host Controller
[    1.966122] xhci_hcd 0000:09:00.4: new USB bus registered, assigned bus number 4
[    1.966124] xhci_hcd 0000:09:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    1.966181] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.966182] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.966183] usb usb3: Product: xHCI Host Controller
[    1.966184] usb usb3: Manufacturer: Linux 6.11.0-00004-ge11bee8239e6-dirty xhci-hcd
[    1.966185] usb usb3: SerialNumber: 0000:09:00.4
[    1.966393] hub 3-0:1.0: USB hub found
[    1.966409] hub 3-0:1.0: 1 port detected
[    1.967064] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.967078] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.967079] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.967080] usb usb4: Product: xHCI Host Controller
[    1.967081] usb usb4: Manufacturer: Linux 6.11.0-00004-ge11bee8239e6-dirty xhci-hcd
[    1.967081] usb usb4: SerialNumber: 0000:09:00.4
[    1.967244] hub 4-0:1.0: USB hub found
[    1.967262] hub 4-0:1.0: 1 port detected
[    1.968495] xhci_hcd 0000:0b:00.3: xHCI Host Controller
[    1.968498] xhci_hcd 0000:0b:00.3: new USB bus registered, assigned bus number 5
[    1.968813] xhci_hcd 0000:0b:00.3: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.969559] xhci_hcd 0000:0b:00.3: xHCI Host Controller
[    1.969561] xhci_hcd 0000:0b:00.3: new USB bus registered, assigned bus number 6
[    1.969562] xhci_hcd 0000:0b:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    1.969585] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.969586] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.969587] usb usb5: Product: xHCI Host Controller
[    1.969588] usb usb5: Manufacturer: Linux 6.11.0-00004-ge11bee8239e6-dirty xhci-hcd
[    1.969589] usb usb5: SerialNumber: 0000:0b:00.3
[    1.969738] hub 5-0:1.0: USB hub found
[    1.969752] hub 5-0:1.0: 1 port detected
[    1.970551] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.970566] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.970567] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.970568] usb usb6: Product: xHCI Host Controller
[    1.970569] usb usb6: Manufacturer: Linux 6.11.0-00004-ge11bee8239e6-dirty xhci-hcd
[    1.970569] usb usb6: SerialNumber: 0000:0b:00.3
[    1.970915] hub 6-0:1.0: USB hub found
[    1.970934] hub 6-0:1.0: 1 port detected
[    1.973046] xhci_hcd 0000:0b:00.4: xHCI Host Controller
[    1.973050] xhci_hcd 0000:0b:00.4: new USB bus registered, assigned bus number 7
[    1.973420] xhci_hcd 0000:0b:00.4: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.974296] xhci_hcd 0000:0b:00.4: xHCI Host Controller
[    1.974298] xhci_hcd 0000:0b:00.4: new USB bus registered, assigned bus number 8
[    1.974300] xhci_hcd 0000:0b:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    1.974323] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.974325] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.974326] usb usb7: Product: xHCI Host Controller
[    1.974327] usb usb7: Manufacturer: Linux 6.11.0-00004-ge11bee8239e6-dirty xhci-hcd
[    1.974327] usb usb7: SerialNumber: 0000:0b:00.4
[    1.974472] hub 7-0:1.0: USB hub found
[    1.974481] hub 7-0:1.0: 1 port detected
[    1.975338] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.975371] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.975374] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.975376] usb usb8: Product: xHCI Host Controller
[    1.975378] usb usb8: Manufacturer: Linux 6.11.0-00004-ge11bee8239e6-dirty xhci-hcd
[    1.975380] usb usb8: SerialNumber: 0000:0b:00.4
[    1.975620] hub 8-0:1.0: USB hub found
[    1.975638] hub 8-0:1.0: 1 port detected
[    2.113203] input: NVTK0603:00 0603:F200 Touchscreen as /devices/platform/AMDI0010:00/i2c-0/i2c-NVTK0603:00/0018:0603:F200.0001/input/input2
[    2.113304] hid-generic 0018:0603:F200.0001: input,hidraw0: I2C HID v1.00 Device [NVTK0603:00 0603:F200] on i2c-NVTK0603:00
[    2.114645] sdhci: Secure Digital Host Controller Interface driver
[    2.114647] sdhci: Copyright(c) Pierre Ossman
[    2.115201] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    2.119236] AES CTR mode by8 optimization enabled
[    2.122027] nvme 0000:08:00.0: platform quirk: setting simple suspend
[    2.122076] nvme nvme0: pci function 0000:08:00.0
[    2.130334] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    2.135938] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:27/LNXVIDEO:00/input/input4
[    2.155349] input: NVTK0603:00 0603:F200 as /devices/platform/AMDI0010:00/i2c-0/i2c-NVTK0603:00/0018:0603:F200.0001/input/input5
[    2.158834] nvme nvme0: allocated 64 MiB host memory buffer.
[    2.182350] nvme nvme0: 16/0/0 default/read/poll queues
[    2.190396]  nvme0n1: p1 p2
[    2.210401] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    2.220419] usb 5-1: new high-speed USB device number 2 using xhci_hcd
[    2.244136] hid-multitouch 0018:0603:F200.0001: input,hidraw0: I2C HID v1.00 Device [NVTK0603:00 0603:F200] on i2c-NVTK0603:00
[    2.268492] sdhci-pci 0000:07:00.0: SDHCI controller found [17a0:9755] (rev 1)
[    2.268629] sdhci-pci 0000:07:00.0: enabling device (0000 -> 0002)
[    2.340566] mmc0: SDHCI controller on PCI [0000:07:00.0] using ADMA 64-bit
[    2.368547] usb 5-1: New USB device found, idVendor=0bda, idProduct=5487, bcdDevice= 1.57
[    2.368553] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.368556] usb 5-1: Product: Dell dock
[    2.368558] usb 5-1: Manufacturer: Dell Inc.
[    2.377852] usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
[    2.377858] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.377861] usb 1-2: Product: Controller
[    2.377864] usb 1-2: Manufacturer: ©Microsoft Corporation
[    2.377866] usb 1-2: SerialNumber: 1DD5F3D
[    2.418117] hub 5-1:1.0: USB hub found
[    2.418670] hub 5-1:1.0: 5 ports detected
[    2.487204] usb 6-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[    2.506900] usb 6-1: New USB device found, idVendor=0bda, idProduct=0487, bcdDevice= 1.57
[    2.506906] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.506909] usb 6-1: Product: Dell dock
[    2.506912] usb 6-1: Manufacturer: Dell Inc.
[    2.513757] usb 1-3: new full-speed USB device number 3 using xhci_hcd
[    2.531967] hub 6-1:1.0: USB hub found
[    2.532255] hub 6-1:1.0: 4 ports detected
[    2.676852] usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
[    2.676858] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.676861] usb 1-3: Product: N-KEY Device
[    2.676864] usb 1-3: Manufacturer: ASUSTeK Computer Inc.
[    2.680964] mmc0: new ultra high speed SDR104 SDXC card at address 5048
[    2.684360] mmcblk0: mmc0:5048 SD512 461 GiB
[    2.688349]  mmcblk0: p1
[    2.707474] BTRFS: device label frzr_root devid 1 transid 15866 /dev/nvme0n1p2 (259:2) scanned by mount (454)
[    2.707640] BTRFS info (device nvme0n1p2): first mount of filesystem c3018100-8976-4d03-ac7a-79ebc84ecdad
[    2.707646] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) checksum algorithm
[    2.707650] BTRFS info (device nvme0n1p2): using free-space-tree
[    2.767099] usb 5-1.3: new high-speed USB device number 3 using xhci_hcd
[    2.837095] usb 1-4: new high-speed USB device number 4 using xhci_hcd
[    2.891852] usb 5-1.3: New USB device found, idVendor=0bda, idProduct=5413, bcdDevice= 1.22
[    2.891859] usb 5-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.891863] usb 5-1.3: Product: Dell dock
[    2.891865] usb 5-1.3: Manufacturer: Dell Inc.
[    2.930298] hub 5-1.3:1.0: USB hub found
[    2.931601] hub 5-1.3:1.0: 6 ports detected
[    2.962335] usb 6-1.3: new SuperSpeed USB device number 3 using xhci_hcd
[    2.980451] usb 1-4: New USB device found, idVendor=0489, idProduct=e0f5, bcdDevice= 1.00
[    2.980457] usb 1-4: New USB device strings: Mfr=5, Product=6, SerialNumber=7
[    2.980461] usb 1-4: Product: Wireless_Device
[    2.980463] usb 1-4: Manufacturer: MediaTek Inc.
[    2.980465] usb 1-4: SerialNumber: 000000000
[    2.994235] usb 6-1.3: New USB device found, idVendor=0bda, idProduct=0413, bcdDevice= 1.22
[    2.994241] usb 6-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.994244] usb 6-1.3: Product: Dell dock
[    2.994246] usb 6-1.3: Manufacturer: Dell Inc.
[    3.030182] hub 6-1.3:1.0: USB hub found
[    3.031652] hub 6-1.3:1.0: 4 ports detected
[    3.107170] usb 1-5: new high-speed USB device number 5 using xhci_hcd
[    3.113756] usb 5-1.5: new high-speed USB device number 4 using xhci_hcd
[    3.207355] usb 5-1.5: New USB device found, idVendor=413c, idProduct=b06e, bcdDevice= 1.01
[    3.207361] usb 5-1.5: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.207364] usb 5-1.5: Product: Dell dock
[    3.249586] usb 1-5: New USB device found, idVendor=1c7a, idProduct=0588, bcdDevice=65.92
[    3.249592] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.249596] usb 1-5: Product: ETU905A86-E
[    3.249598] usb 1-5: Manufacturer: EGIS
[    3.249600] usb 1-5: SerialNumber: 102F19PNA360
[    3.258521] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0002/input/input6
[    3.277217] usb 6-1.4: new SuperSpeed USB device number 4 using xhci_hcd
[    3.294550] usb 6-1.4: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.11
[    3.294556] usb 6-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[    3.294559] usb 6-1.4: Product: USB 10/100/1000 LAN
[    3.294561] usb 6-1.4: Manufacturer: Realtek
[    3.294563] usb 6-1.4: SerialNumber: 111000001
[    3.367090] usb 5-1.3.1: new full-speed USB device number 5 using xhci_hcd
[    3.407555] hid-generic 0003:0B05:1ABE.0002: input,hidraw1: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
[    3.412355] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0003/input/input7
[    3.412570] hid-generic 0003:0B05:1ABE.0003: input,hidraw2: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
[    3.417724] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0004/input/input8
[    3.417847] input: ASUSTeK Computer Inc. N-KEY Device Consumer Control as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0004/input/input9
[    3.473899] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0004/input/input10
[    3.474046] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0004/input/input11
[    3.474382] hid-generic 0003:0B05:1ABE.0004: input,hiddev96,hidraw3: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
[    3.475475] hid-generic 0003:413C:B06E.0005: hiddev97,hidraw4: USB HID v1.11 Device [Dell dock] on usb-0000:0b:00.3-1.5/input0
[    3.475493] usbcore: registered new interface driver usbhid
[    3.475494] usbhid: USB HID core driver
[    3.476790] usb 5-1.3.1: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=24.11
[    3.476792] usb 5-1.3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.476793] usb 5-1.3.1: Product: USB Receiver
[    3.476794] usb 5-1.3.1: Manufacturer: Logitech
[    3.485512] asus_wmi: ASUS WMI generic driver loaded
[    3.610850] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:08.3/0000:0b:00.3/usb5/5-1/5-1.3/5-1.3.1/5-1.3.1:1.0/0003:046D:C52B.0006/input/input12
[    3.687575] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0002/input/input13
[    3.914021] hid-generic 0003:046D:C52B.0006: input,hidraw1: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:0b:00.3-1.3.1/input0
[    3.917955] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:08.3/0000:0b:00.3/usb5/5-1/5-1.3/5-1.3.1/5-1.3.1:1.1/0003:046D:C52B.0007/input/input14
[    4.077421] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:08.3/0000:0b:00.3/usb5/5-1/5-1.3/5-1.3.1/5-1.3.1:1.1/0003:046D:C52B.0007/input/input15
[    4.077430] asus 0003:0B05:1ABE.0002: input,hidraw5: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
[    4.133899] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:08.3/0000:0b:00.3/usb5/5-1/5-1.3/5-1.3.1/5-1.3.1:1.1/0003:046D:C52B.0007/input/input16
[    4.160765] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0003/input/input18
[    4.160787] hid-generic 0003:046D:C52B.0007: input,hiddev98,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:0b:00.3-1.3.1/input1
[    4.160977] asus 0003:0B05:1ABE.0003: input,hidraw6: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
[    4.165066] hid-generic 0003:046D:C52B.0008: hiddev99,hidraw7: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:0b:00.3-1.3.1/input2
[    4.253750] usb 5-1.3.4: new high-speed USB device number 6 using xhci_hcd
[    4.334775] asus 0003:0B05:1ABE.0004: Fixing up Asus N-Key report descriptor
[    4.346951] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0004/input/input19
[    4.401748] asus 0003:0B05:1ABE.0004: input,hiddev96,hidraw3: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
[    4.426675] usb 5-1.3.4: New USB device found, idVendor=0bda, idProduct=402e, bcdDevice= 0.01
[    4.426689] usb 5-1.3.4: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    4.426694] usb 5-1.3.4: Product: USB Audio
[    4.426698] usb 5-1.3.4: Manufacturer: Generic
[    4.426701] usb 5-1.3.4: SerialNumber: 200901010001
[    4.559484] usb 5-1.3.5: new high-speed USB device number 7 using xhci_hcd
[    4.634060] systemd-journald[219]: Received SIGTERM from PID 1 (systemd).
[    4.674859] usb 5-1.3.5: New USB device found, idVendor=413c, idProduct=b06f, bcdDevice= 1.01
[    4.674865] usb 5-1.3.5: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    4.674868] usb 5-1.3.5: Product: Dell dock
[    4.704489] systemd[1]: systemd 256.6-1-arch running in system mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    4.704492] systemd[1]: Detected architecture x86-64.
[    4.705349] systemd[1]: Hostname set to <chimeraos>.
[    4.727937] hid-generic 0003:413C:B06F.0009: hiddev100,hidraw8: USB HID v1.11 Device [Dell dock] on usb-0000:0b:00.3-1.3.5/input0
[    4.876387] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    5.104111] systemd[1]: run-credentials-systemd\x2djournald.service.mount: Deactivated successfully.
[    5.104303] systemd[1]: initrd-switch-root.service: Deactivated successfully.
[    5.104386] systemd[1]: Stopped Switch Root.
[    5.104816] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    5.105040] systemd[1]: Created slice Slice /system/dirmngr.
[    5.105213] systemd[1]: Created slice Slice /system/getty.
[    5.105383] systemd[1]: Created slice Slice /system/gpg-agent.
[    5.105561] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    5.105723] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    5.105888] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    5.106048] systemd[1]: Created slice Slice /system/keyboxd.
[    5.106162] systemd[1]: Created slice User and Session Slice.
[    5.106191] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    5.106213] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    5.106309] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    5.106316] systemd[1]: Expecting device /dev/disk/by-label/frzr_root...
[    5.106323] systemd[1]: Reached target Local Encrypted Volumes.
[    5.106330] systemd[1]: Reached target Login Prompts.
[    5.106340] systemd[1]: Stopped target Switch Root.
[    5.106347] systemd[1]: Stopped target Initrd File Systems.
[    5.106352] systemd[1]: Stopped target Initrd Root File System.
[    5.106358] systemd[1]: Reached target Local Integrity Protected Volumes.
[    5.106367] systemd[1]: Reached target Path Units.
[    5.106373] systemd[1]: Reached target Remote File Systems.
[    5.106379] systemd[1]: Reached target Slice Units.
[    5.106393] systemd[1]: Reached target Local Verity Protected Volumes.
[    5.106433] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    5.107119] systemd[1]: Listening on Process Core Dump Socket.
[    5.107533] systemd[1]: Listening on Credential Encryption/Decryption.
[    5.107556] systemd[1]: TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.107563] systemd[1]: Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.107597] systemd[1]: Listening on udev Control Socket.
[    5.107621] systemd[1]: Listening on udev Kernel Socket.
[    5.107647] systemd[1]: Listening on User Database Manager Socket.
[    5.108354] systemd[1]: Mounting Huge Pages File System...
[    5.108737] systemd[1]: Mounting POSIX Message Queue File System...
[    5.109113] systemd[1]: Mounting Kernel Debug File System...
[    5.109484] systemd[1]: Mounting Kernel Trace File System...
[    5.110038] systemd[1]: Starting Create List of Static Device Nodes...
[    5.110914] systemd[1]: Starting Load Kernel Module configfs...
[    5.111505] systemd[1]: Starting Load Kernel Module dm_mod...
[    5.136443] systemd[1]: Starting Load Kernel Module drm...
[    5.137076] systemd[1]: Starting Load Kernel Module fuse...
[    5.137696] systemd[1]: Starting Load Kernel Module loop...
[    5.137798] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    5.138796] systemd[1]: Starting Load Kernel Modules...
[    5.138811] systemd[1]: TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.138825] systemd[1]: TPM PCR Root File System Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.139285] systemd[1]: Starting Remount Root and Kernel File Systems...
[    5.139317] systemd[1]: Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.139767] systemd[1]: Starting Load udev Rules from Credentials...
[    5.140195] systemd[1]: Starting Coldplug All udev Devices...
[    5.141542] systemd[1]: Mounted Huge Pages File System.
[    5.141603] systemd[1]: Mounted POSIX Message Queue File System.
[    5.141655] systemd[1]: Mounted Kernel Debug File System.
[    5.141705] systemd[1]: Mounted Kernel Trace File System.
[    5.141859] systemd[1]: Finished Create List of Static Device Nodes.
[    5.142029] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    5.142135] systemd[1]: Finished Load Kernel Module configfs.
[    5.142294] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    5.142418] systemd[1]: Finished Load Kernel Module drm.
[    5.142606] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    5.142715] systemd[1]: Finished Load Kernel Module fuse.
[    5.143637] systemd[1]: Mounting FUSE Control File System...
[    5.144151] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    5.144196] BTRFS info (device nvme0n1p2 state M): setting nodatasum
[    5.144198] BTRFS info (device nvme0n1p2 state M): setting nodatasum
[    5.144835] loop: module loaded
[    5.145000] device-mapper: uevent: version 1.0.3
[    5.145046] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    5.145170] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    5.145282] systemd[1]: Finished Load Kernel Module loop.
[    5.145477] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    5.145580] systemd[1]: Finished Load Kernel Module dm_mod.
[    5.145741] systemd[1]: Finished Load Kernel Modules.
[    5.145893] systemd[1]: Finished Remount Root and Kernel File Systems.
[    5.146056] systemd[1]: Finished Load udev Rules from Credentials.
[    5.146397] systemd[1]: Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[    5.146881] systemd[1]: Starting Load/Save OS Random Seed...
[    5.146916] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[    5.147429] systemd[1]: Starting Apply Kernel Variables...
[    5.147455] systemd[1]: TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.148251] systemd[1]: Mounted FUSE Control File System.
[    5.155346] systemd[1]: Finished Apply Kernel Variables.
[    5.156562] systemd[1]: Finished Load/Save OS Random Seed.
[    5.161769] systemd[1]: Starting User Database Manager...
[    5.178689] systemd[1]: Started User Database Manager.
[    5.193033] systemd[1]: Finished Create Static Device Nodes in /dev gracefully.
[    5.193167] systemd[1]: Create System Users was skipped because no trigger condition checks were met.
[    5.193988] systemd[1]: Starting Create Static Device Nodes in /dev...
[    5.207009] systemd[1]: Finished Create Static Device Nodes in /dev.
[    5.207069] systemd[1]: Reached target Preparation for Local File Systems.
[    5.207103] systemd[1]: Entropy Daemon based on the HAVEGE algorithm was skipped because of an unmet condition check (ConditionKernelVersion=<5.6).
[    5.208529] systemd[1]: Starting Journal Service...
[    5.209420] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    5.219235] systemd-journald[622]: Collecting audit messages is disabled.
[    5.222551] systemd[1]: Started Journal Service.
[    5.231732] systemd-journald[622]: Received client request to flush runtime journal.
[    5.309142] mousedev: PS/2 mouse device common for all mice
[    5.334035] Serial bus multi instantiate pseudo device driver CSC3551:00: Instantiated 2 I2C devices.
[    5.360734] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    5.360740] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    5.362570] bmc150_accel_i2c i2c-BOSC0200:00: supply vdd not found, using dummy regulator
[    5.362618] bmc150_accel_i2c i2c-BOSC0200:00: supply vddio not found, using dummy regulator
[    5.365455] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    5.370252] i2c i2c-5: Successfully instantiated SPD at 0x50
[    5.371407] i2c i2c-5: Successfully instantiated SPD at 0x52
[    5.379882] bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0
[    5.389990] input: PC Speaker as /devices/platform/pcspkr/input/input20
[    5.390190] asus_wmi: Initialization: 0x1
[    5.390243] asus_wmi: BIOS WMI version: 9.0
[    5.390275] asus_wmi: SFUN value: 0x21
[    5.390277] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[    5.390636] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
[    5.390638] RAPL PMU: hw unit of domain package 2^-16 Joules
[    5.394062] bmi323 i2c-BOSC0200:00: supply vdd not found, using dummy regulator
[    5.394339] bmi323 i2c-BOSC0200:00: supply vddio not found, using dummy regulator
[    5.398417] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    5.398564] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.398677] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    5.399465] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    5.399469] cfg80211: failed to load regulatory.db
[    5.414203] asus-nb-wmi asus-nb-wmi: Using throttle_thermal_policy for platform_profile support
[    5.433986] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Adding DSD properties for 104317F3
[    5.433991] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Cannot add Reset/Speaker ID/SPI CS GPIO Mapping, _DSD already exists.
[    5.435673] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input21
[    5.436902] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Using extra _DSD properties, bypassing _DSD in ACPI
[    5.471270] asus_wmi: fan_curve_get_factory_default (0x00110032) failed: -19
[    5.484225] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Cirrus Logic CS35L41 (35a40), Revision: B2
[    5.484502] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Adding DSD properties for 104317F3
[    5.484506] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Cannot add Reset/Speaker ID/SPI CS GPIO Mapping, _DSD already exists.
[    5.486822] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Using extra _DSD properties, bypassing _DSD in ACPI
[    5.486825] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Reset line busy, assuming shared reset
[    5.519979] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Cirrus Logic CS35L41 (35a40), Revision: B2
[    5.589373] mc: Linux media interface: v0.10
[    5.598281] Bluetooth: Core ver 2.22
[    5.598300] NET: Registered PF_BLUETOOTH protocol family
[    5.598301] Bluetooth: HCI device and connection manager initialized
[    5.598306] Bluetooth: HCI socket layer initialized
[    5.598309] Bluetooth: L2CAP socket layer initialized
[    5.598313] Bluetooth: SCO socket layer initialized
[    5.600457] input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input22
[    5.600662] kvm_amd: TSC scaling supported
[    5.600664] kvm_amd: Nested Virtualization enabled
[    5.600665] kvm_amd: Nested Paging enabled
[    5.600666] kvm_amd: LBR virtualization supported
[    5.600672] kvm_amd: Virtual VMLOAD VMSAVE supported
[    5.600673] kvm_amd: Virtual GIF supported
[    5.600674] kvm_amd: Virtual NMI enabled
[    5.605978] snd_hda_intel 0000:09:00.1: enabling device (0000 -> 0002)
[    5.606112] snd_hda_intel 0000:09:00.1: Handle vga_switcheroo audio client
[    5.613133] usbcore: registered new device driver r8152-cfgselector
[    5.624036] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:09:00.1/sound/card0/input23
[    5.638125] mt7921e 0000:06:00.0: ASIC revision: 79220010
[    5.638282] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
[    5.638285] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
[    5.638856] snd_pci_ps 0000:09:00.5: enabling device (0000 -> 0002)
[    5.639058] acpi device:2e: Failed to read mipi-sdw-manager-list: -22
[    5.725290] mt7921e 0000:06:00.0: HW/SW Version: 0x8a108a10, Build Time: 20240716163242a

[    5.740495] mt7921e 0000:06:00.0: WM Firmware Version: ____000000, Build Time: 20240716163327
[    5.775834] intel_rapl_common: Found RAPL domain package
[    5.775837] intel_rapl_common: Found RAPL domain core
[    5.776355] amd_atl: AMD Address Translation Library initialized
[    5.905860] r8152-cfgselector 6-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
[    6.113341] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
[    6.114453] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
[    6.114455] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
[    6.183806] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
[    6.198047] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
[    6.198080] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: CS35L41 Bound - SSID: 104317F3, BST: 0, VSPK: 0, CH: L, FW EN: 1, SPKID: 1
[    6.198083] snd_hda_codec_realtek hdaudioC1D0: bound i2c-CSC3551:00-cs35l41-hda.0 (ops cs35l41_hda_comp_ops [snd_hda_scodec_cs35l41])
[    6.201027] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
[    6.201031] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
[    6.207427] usbcore: registered new interface driver xpad
[    6.409216] Adding 1048572k swap on /home/swapfile.  Priority:-2 extents:2 across:1077432k 
[    6.491189] r8152 6-1.4:1.0 eth0: v1.12.13
[    6.500514] ACPI: battery: new extension: ASUS Battery Extension
[    6.501684] usbcore: registered new interface driver btusb
[    6.541826] usbcore: registered new interface driver r8152
[    6.569960] usbcore: registered new interface driver snd-usb-audio
[    6.615339] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20240716163633
[    6.675657] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
[    6.676765] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
[    6.676767] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
[    6.746023] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
[    6.760022] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
[    6.760087] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: CS35L41 Bound - SSID: 104317F3, BST: 0, VSPK: 0, CH: R, FW EN: 1, SPKID: 1
[    6.760092] snd_hda_codec_realtek hdaudioC1D0: bound i2c-CSC3551:00-cs35l41-hda.1 (ops cs35l41_hda_comp_ops [snd_hda_scodec_cs35l41])
[    6.760821] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC294: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    6.760826] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    6.760828] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    6.760830] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    6.760832] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    6.760834] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x1a
[    6.760836] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
[    6.760837] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[    6.805158] usbcore: registered new interface driver cdc_ether
[    6.807952] usbcore: registered new interface driver r8153_ecm
[    6.810796] logitech-djreceiver 0003:046D:C52B.0008: hiddev98,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:0b:00.3-1.3.1/input2
[    6.810988] [drm] amdgpu kernel modesetting enabled.
[    6.818292] amdgpu: Virtual CRAT table created for CPU
[    6.818303] amdgpu: Topology: Add CPU node
[    6.818422] amdgpu 0000:09:00.0: enabling device (0006 -> 0007)
[    6.818462] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x15BF 0x1043:0x17F3 0x04).
[    6.818601] [drm] register mmio base: 0xFC700000
[    6.818602] [drm] register mmio size: 524288
[    6.822367] [drm] add ip block number 0 <soc21_common>
[    6.822370] [drm] add ip block number 1 <gmc_v11_0>
[    6.822370] [drm] add ip block number 2 <ih_v6_0>
[    6.822372] [drm] add ip block number 3 <psp>
[    6.822372] [drm] add ip block number 4 <smu>
[    6.822373] [drm] add ip block number 5 <dm>
[    6.822374] [drm] add ip block number 6 <gfx_v11_0>
[    6.822375] [drm] add ip block number 7 <sdma_v6_0>
[    6.822377] [drm] add ip block number 8 <vcn_v4_0>
[    6.822377] [drm] add ip block number 9 <jpeg_v4_0>
[    6.822378] [drm] add ip block number 10 <mes_v11_0>
[    6.822402] amdgpu 0000:09:00.0: amdgpu: Fetched VBIOS from VFCT
[    6.822405] amdgpu: ATOM BIOS: 113-PHXGENERIC-001
[    6.861165] mt7921e 0000:06:00.0 wlp6s0: renamed from wlan0
[    6.877435] amdgpu 0000:09:00.0: vgaarb: deactivate vga console
[    6.877442] amdgpu 0000:09:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
[    6.877480] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    6.877503] amdgpu 0000:09:00.0: amdgpu: VRAM: 1024M 0x0000008000000000 - 0x000000803FFFFFFF (1024M used)
[    6.877507] amdgpu 0000:09:00.0: amdgpu: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    6.877523] [drm] Detected VRAM RAM=1024M, BAR=1024M
[    6.877524] [drm] RAM width 128bits LPDDR5
[    6.877642] [drm] amdgpu: 1024M of VRAM memory ready
[    6.877644] [drm] amdgpu: 7339M of GTT memory ready.
[    6.877669] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    6.878128] [drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
[    6.878532] [drm] Loading DMUB firmware via PSP: version=0x08004300
[    6.878867] [drm] Found VCN firmware Version ENC: 1.22 DEC: 8 VEP: 0 Revision: 3
[    6.903275] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.903279] Bluetooth: BNEP filters: protocol multicast
[    6.903285] Bluetooth: BNEP socket layer initialized
[    6.903289] amdgpu 0000:09:00.0: amdgpu: reserve 0x4000000 from 0x8038000000 for PSP TMR
[    6.910773] r8152 6-1.4:1.0 enp11s0f3u1u4: renamed from eth0
[    6.927931] input input22: unable to receive magic message: -32
[    6.930054] input: Logitech Wireless Device PID:404d Keyboard as /devices/pci0000:00/0000:00:08.3/0000:0b:00.3/usb5/5-1/5-1.3/5-1.3.1/5-1.3.1:1.2/0003:046D:C52B.0008/0003:046D:404D.000A/input/input24
[    7.003933] input input22: unable to receive magic message: -32
[    7.044068] input: Logitech Wireless Device PID:404d Mouse as /devices/pci0000:00/0000:00:08.3/0000:0b:00.3/usb5/5-1/5-1.3/5-1.3.1/5-1.3.1:1.2/0003:046D:C52B.0008/0003:046D:404D.000A/input/input25
[    7.044626] hid-generic 0003:046D:404D.000A: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Device PID:404d] on usb-0000:0b:00.3-1.3.1/input2:1
[    7.094980] input input22: unable to receive magic message: -32
[    7.199556] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:09:00.6/sound/card1/input29
[    7.232854] input: Microsoft X-Box One Elite 2 pad as /devices/virtual/input/input32
[    7.273937] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:09:00.6/sound/card1/input30
[    7.274067] input: InputPlumber Mouse as /devices/virtual/input/input33
[    7.350674] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:08.1/0000:09:00.6/sound/card1/input31
[    7.350851] input: InputPlumber Keyboard as /devices/virtual/input/input34
[    7.355985] input: Logitech K400 Plus as /devices/pci0000:00/0000:00:08.3/0000:0b:00.3/usb5/5-1/5-1.3/5-1.3.1/5-1.3.1:1.2/0003:046D:C52B.0008/0003:046D:404D.000A/input/input35
[    7.446807] amdgpu 0000:09:00.0: amdgpu: RAS: optional ras ta ucode is not available
[    7.454141] amdgpu 0000:09:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    7.454145] amdgpu 0000:09:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[    7.484996] amdgpu 0000:09:00.0: amdgpu: SMU is initialized successfully!
[    7.485003] [drm] Seamless boot condition check passed
[    7.486507] [drm] Display Core v3.2.291 initialized on DCN 3.1.4
[    7.486510] [drm] DP-HDMI FRL PCON supported
[    7.488737] [drm] DMUB hardware initialized: version=0x08004300
[    7.490474] snd_hda_intel 0000:09:00.1: bound 0000:09:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    7.494118] logitech-hidpp-device 0003:046D:404D.000A: input,hidraw2: USB HID v1.11 Keyboard [Logitech K400 Plus] on usb-0000:0b:00.3-1.3.1/input2:1
[    7.583226] [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    7.591305] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    7.591331] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    7.591857] amdgpu: Virtual CRAT table created for GPU
[    7.592010] amdgpu: Topology: Add dGPU node [0x15bf:0x1002]
[    7.592014] kfd kfd: amdgpu: added device 1002:15bf
[    7.592029] amdgpu 0000:09:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 6, active_cu_number 12
[    7.592036] amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    7.592039] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    7.592041] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    7.592043] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    7.592044] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    7.592046] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    7.592047] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    7.592049] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    7.592051] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    7.592052] amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[    7.592054] amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    7.592055] amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[    7.592057] amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[    7.602596] [drm] ring gfx_32768.1.1 was added
[    7.603274] [drm] ring compute_32768.2.2 was added
[    7.603862] [drm] ring sdma_32768.3.3 was added
[    7.603905] [drm] ring gfx_32768.1.1 ib test pass
[    7.603946] [drm] ring compute_32768.2.2 ib test pass
[    7.604000] [drm] ring sdma_32768.3.3 ib test pass
[    7.606541] amdgpu 0000:09:00.0: amdgpu: Runtime PM not available
[    7.613811] [drm] Initialized amdgpu 3.58.0 for 0000:09:00.0 on minor 1
[    7.635007] fbcon: amdgpudrmfb (fb0) is primary device
[    7.635011] fbcon: Deferring console take-over
[    7.635014] amdgpu 0000:09:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    7.849880] block nvme0n1: No UUID available providing old NGUID
[    7.922189] EXT4-fs (mmcblk0p1): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
[    7.972830] EXT4-fs (mmcblk0p1): warning: mounting fs with errors, running e2fsck is recommended
[    8.218416] EXT4-fs (mmcblk0p1): mounted filesystem 566d5238-fe90-4079-9b8d-a7f2f0b5d68e r/w with ordered data mode. Quota mode: none.
[    8.839547] Bluetooth: hci0: Device setup in 2283055 usecs
[    8.839555] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[    8.897377] Bluetooth: hci0: AOSP extensions version v1.00
[    8.897383] Bluetooth: hci0: AOSP quality report is supported
[    8.897540] Bluetooth: MGMT ver 1.23
[    8.902628] NET: Registered PF_ALG protocol family
[   10.055323] [drm] DSC precompute is not needed.
[   10.070723] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
[   10.073184] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
[   10.075751] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
[   10.078190] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
[   10.148842] Bluetooth: RFCOMM TTY layer initialized
[   10.148849] Bluetooth: RFCOMM socket layer initialized
[   10.148851] Bluetooth: RFCOMM ver 1.11
[   10.261906] r8152 6-1.4:1.0 enp11s0f3u1u4: carrier on
[   10.642336] wlp6s0: authenticate with 30:ea:e7:54:50:82 (local address=74:97:79:9e:4c:89)
[   10.789645] wlp6s0: send auth to 30:ea:e7:54:50:82 (try 1/3)
[   10.793706] wlp6s0: authenticated
[   10.798190] wlp6s0: associate with 30:ea:e7:54:50:82 (try 1/3)
[   10.812327] wlp6s0: RX AssocResp from 30:ea:e7:54:50:82 (capab=0x8431 status=0 aid=2)
[   10.844340] wlp6s0: associated
[   15.833799] wlp6s0: deauthenticated from 30:ea:e7:54:50:82 (Reason: 1=UNSPECIFIED)
[   17.736784] input: Sony Interactive Entertainment DualSense Edge Wireless Controller as /devices/virtual/misc/uhid/0003:054C:0DF2.000B/input/input36
[   17.736967] hid-generic 0003:054C:0DF2.000B: input,hidraw7: USB HID v1.00 Gamepad [Sony Interactive Entertainment DualSense Edge Wireless Controller] on 
[   17.914172] playstation 0003:054C:0DF2.000B: hidraw7: USB HID v1.00 Gamepad [Sony Interactive Entertainment DualSense Edge Wireless Controller] on 
[   17.919914] input: Sony Interactive Entertainment DualSense Edge Wireless Controller as /devices/virtual/misc/uhid/0003:054C:0DF2.000B/input/input37
[   17.920039] input: Sony Interactive Entertainment DualSense Edge Wireless Controller Motion Sensors as /devices/virtual/misc/uhid/0003:054C:0DF2.000B/input/input38
[   17.920143] input: Sony Interactive Entertainment DualSense Edge Wireless Controller Touchpad as /devices/virtual/misc/uhid/0003:054C:0DF2.000B/input/input39
[   17.920483] playstation 0003:054C:0DF2.000B: Registered DualSense controller hw_version=0x01000208 fw_version=0x01000036
[   22.540646] input: Microsoft X-Box 360 pad 0 as /devices/virtual/input/input40
[   37.585842] PM: suspend entry (s2idle)
[   37.624882] Filesystems sync: 0.039 seconds
[   37.627762] Freezing user space processes
[   37.629052] Freezing user space processes completed (elapsed 0.001 seconds)
[   37.629054] OOM killer disabled.
[   37.629054] Freezing remaining freezable tasks
[   37.630176] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   37.632382] printk: Suspending console(s) (use no_console_suspend to debug)
[   37.659513] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
[   37.936193] ACPI: EC: interrupt blocked
[  146.324860] ACPI: EC: interrupt unblocked
[  146.498770] [drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
[  146.498844] amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
[  146.503023] amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
[  146.508340] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
[  146.510848] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
[  146.513352] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
[  146.515853] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
[  146.530488] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
[  146.530491] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
[  146.533336] nvme nvme0: 16/0/0 default/read/poll queues
[  146.684259] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
[  146.684265] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
[  146.693200] amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[  146.693204] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  146.693206] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  146.693208] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[  146.693210] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[  146.693211] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[  146.693213] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[  146.693214] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[  146.693216] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[  146.693218] amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[  146.693220] amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[  146.693222] amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[  146.693223] amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[  146.699788] [drm] ring gfx_32787.1.1 was added
[  146.700589] [drm] ring compute_32787.2.2 was added
[  146.701377] [drm] ring sdma_32787.3.3 was added
[  146.701410] [drm] ring gfx_32787.1.1 ib test pass
[  146.701447] [drm] ring compute_32787.2.2 ib test pass
[  146.701557] [drm] ring sdma_32787.3.3 ib test pass
[  146.749960] usb 5-1: reset high-speed USB device number 2 using xhci_hcd
[  147.015286] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
[  147.019864] usb 6-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[  147.050767] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
[  147.050780] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
[  147.259913] usb 5-1.5: reset high-speed USB device number 4 using xhci_hcd
[  147.451954] usb 5-1.3: reset high-speed USB device number 3 using xhci_hcd
[  147.567253] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
[  147.569085] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
[  147.569096] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
[  147.642206] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
[  147.643673] r8152-cfgselector 6-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
[  147.644470] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
[  147.665331] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
[  147.665743] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
[  147.678619] r8152 6-1.4:1.0: skip request firmware
[  147.740648] usb 6-1.3: reset SuperSpeed USB device number 3 using xhci_hcd
[  147.932455] usb 5-1.3.1: reset full-speed USB device number 5 using xhci_hcd
[  148.123730] usb 5-1.3.4: reset high-speed USB device number 6 using xhci_hcd
[  148.349268] usb 5-1.3.5: reset high-speed USB device number 7 using xhci_hcd
[  149.294160] xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
[  149.296575] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
[  149.296583] ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
[  149.296814] OOM killer enabled.
[  149.296814] Restarting tasks ... 
[  149.296991] usb 1-2: USB disconnect, device number 2
[  149.297077] xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
[  149.297300] done.
[  149.297375] random: crng reseeded on system resumption
[  149.305987] PM: suspend exit
[  149.367210] usb 1-3: USB disconnect, device number 3
[  149.450767] xprop[4819]: segfault at 0 ip 00007f8cead8808b sp 00007ffc87a8f110 error 4 in libc.so.6[5108b,7f8cead5b000+171000] likely on CPU 10 (core 2, socket 0)
[  149.450776] Code: 48 89 75 b8 44 89 45 c8 85 c9 0f 85 9f 02 00 00 83 ff 01 0f 84 76 01 00 00 83 ff 24 0f 87 6d 01 00 00 48 8b 5d c0 49 8b 49 68 <48> 0f be 13 48 89 d0 f6 44 51 01 20 74 1a 0f 1f 80 00 00 00 00 48
[  150.265659] usb 1-3: new full-speed USB device number 6 using xhci_hcd
[  150.428942] usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
[  150.428949] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  150.428950] usb 1-3: Product: N-KEY Device
[  150.428952] usb 1-3: Manufacturer: ASUSTeK Computer Inc.
[  150.465217] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.000C/input/input41
[  150.632507] asus 0003:0B05:1ABE.000C: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
[  150.640357] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.000D/input/input42
[  150.640537] asus 0003:0B05:1ABE.000D: input,hidraw5: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
[  150.648400] asus 0003:0B05:1ABE.000E: Fixing up Asus N-Key report descriptor
[  150.657094] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.000E/input/input43
[  150.715849] asus 0003:0B05:1ABE.000E: input,hiddev96,hidraw6: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
[  150.972340] usb 1-2: new full-speed USB device number 7 using xhci_hcd
[  151.141960] usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
[  151.141968] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  151.141971] usb 1-2: Product: Controller
[  151.141973] usb 1-2: Manufacturer: ©Microsoft Corporation
[  151.141975] usb 1-2: SerialNumber: 1DD5F3D
[  151.156241] input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input44
[  151.158026] input input44: unable to receive magic message: -32
[  151.210047] input input44: unable to receive magic message: -32
[  151.358353] r8152 6-1.4:1.0 enp11s0f3u1u4: carrier on
[  152.183623] wlp6s0: authenticate with 30:ea:e7:54:50:82 (local address=74:97:79:9e:4c:89)
[  152.196087] wlp6s0: send auth to 30:ea:e7:54:50:82 (try 1/3)
[  152.199881] wlp6s0: authenticated
[  152.205662] wlp6s0: associate with 30:ea:e7:54:50:82 (try 1/3)
[  152.218407] wlp6s0: RX AssocResp from 30:ea:e7:54:50:82 (capab=0x8431 status=0 aid=2)
[  152.239071] wlp6s0: associated
[  157.241693] wlp6s0: deauthenticated from 30:ea:e7:54:50:82 (Reason: 1=UNSPECIFIED)
[  221.259809] PM: suspend entry (s2idle)
[  221.281576] Filesystems sync: 0.021 seconds
[  221.284118] Freezing user space processes
[  221.286891] Freezing user space processes completed (elapsed 0.002 seconds)
[  221.286898] OOM killer disabled.
[  221.286900] Freezing remaining freezable tasks
[  221.288154] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  221.289254] printk: Suspending console(s) (use no_console_suspend to debug)
[  221.315568] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
[  221.652418] ACPI: EC: interrupt blocked
[  290.245662] Reading current time from RTC took around 112 ms
[  290.248061] ACPI: EC: interrupt unblocked
[  290.421989] [drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
[  290.422084] amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
[  290.426284] amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
[  290.430719] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
[  290.433230] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
[  290.435730] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
[  290.438231] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
[  290.453620] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
[  290.453623] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
[  290.459273] nvme nvme0: 16/0/0 default/read/poll queues
[  290.606096] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
[  290.606104] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
[  290.606307] amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[  290.606309] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  290.606311] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  290.606312] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[  290.606313] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[  290.606324] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[  290.606325] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[  290.606326] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[  290.606327] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[  290.606328] amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[  290.606329] amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[  290.606330] amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[  290.606331] amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[  290.610704] r8152 6-1.4:1.0 enp11s0f3u1u4: carrier on
[  290.613179] [drm] ring gfx_32776.1.1 was added
[  290.613975] [drm] ring compute_32776.2.2 was added
[  290.614754] [drm] ring sdma_32776.3.3 was added
[  290.614788] [drm] ring gfx_32776.1.1 ib test pass
[  290.614825] [drm] ring compute_32776.2.2 ib test pass
[  290.614935] [drm] ring sdma_32776.3.3 ib test pass
[  290.938496] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
[  290.974256] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
[  290.974269] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
[  291.494769] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
[  291.496487] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
[  291.496494] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
[  291.568381] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
[  291.570693] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
[  291.591777] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
[  291.592173] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
[  293.218200] xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
[  293.220903] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
[  293.220912] ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
[  293.221150] OOM killer enabled.
[  293.221151] Restarting tasks ... 
[  293.221371] usb 1-2: USB disconnect, device number 7
[  293.221484] xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
[  293.222012] done.
[  293.222092] random: crng reseeded on system resumption
[  293.246542] PM: suspend exit
[  293.287140] usb 1-3: USB disconnect, device number 6
[  293.425558] r8152 6-1.4:1.0 enp11s0f3u1u4: carrier on
[  294.070750] usb 1-3: new full-speed USB device number 8 using xhci_hcd
[  294.236949] usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
[  294.236960] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  294.236964] usb 1-3: Product: N-KEY Device
[  294.236966] usb 1-3: Manufacturer: ASUSTeK Computer Inc.
[  294.273288] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.000F/input/input45
[  294.447096] asus 0003:0B05:1ABE.000F: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
[  294.454412] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0010/input/input46
[  294.454611] asus 0003:0B05:1ABE.0010: input,hidraw5: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
[  294.462237] asus 0003:0B05:1ABE.0011: Fixing up Asus N-Key report descriptor
[  294.471170] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0011/input/input47
[  294.529234] asus 0003:0B05:1ABE.0011: input,hiddev96,hidraw6: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
[  294.795058] usb 1-2: new full-speed USB device number 9 using xhci_hcd
[  294.967968] usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
[  294.967976] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  294.967979] usb 1-2: Product: Controller
[  294.967981] usb 1-2: Manufacturer: ©Microsoft Corporation
[  294.967983] usb 1-2: SerialNumber: 1DD5F3D
[  294.980135] input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input48
[  294.982035] input input48: unable to receive magic message: -32
[  295.702360] input: Microsoft X-Box 360 pad 1 as /devices/virtual/input/input49
[  296.091767] wlp6s0: authenticate with 30:ea:e7:54:50:82 (local address=74:97:79:9e:4c:89)
[  296.104238] wlp6s0: send auth to 30:ea:e7:54:50:82 (try 1/3)
[  296.213898] wlp6s0: send auth to 30:ea:e7:54:50:82 (try 2/3)
[  296.217678] wlp6s0: authenticated
[  296.222532] wlp6s0: associate with 30:ea:e7:54:50:82 (try 1/3)
[  296.234564] wlp6s0: RX AssocResp from 30:ea:e7:54:50:82 (capab=0x8431 status=0 aid=2)
[  296.254928] wlp6s0: associated
[  301.258524] wlp6s0: deauthenticated from 30:ea:e7:54:50:82 (Reason: 1=UNSPECIFIED)
[  327.978336] input input48: unable to receive magic message: -32
[  327.982911] input: Microsoft X-Box One Elite 2 pad as /devices/virtual/input/input50
[  327.983252] input: InputPlumber Mouse as /devices/virtual/input/input51
[  327.983426] input: InputPlumber Keyboard as /devices/virtual/input/input52
[  329.313225] rfkill: input handler disabled
[  329.863386] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[  330.095816] hid-generic 0003:413C:B06F.0012: hiddev99,hidraw7: USB HID v1.11 Device [Dell dock] on usb-0000:0b:00.3-1.3.5/input0
[  330.154814] hid-generic 0003:413C:B06E.0013: hiddev97,hidraw4: USB HID v1.11 Device [Dell dock] on usb-0000:0b:00.3-1.5/input0
[  332.022030] wlp6s0: authenticate with 30:ea:e7:54:50:82 (local address=74:97:79:9e:4c:89)
[  332.034520] wlp6s0: send auth to 30:ea:e7:54:50:82 (try 1/3)
[  332.038387] wlp6s0: authenticated
[  332.039976] wlp6s0: associate with 30:ea:e7:54:50:82 (try 1/3)
[  332.056541] wlp6s0: RX AssocResp from 30:ea:e7:54:50:82 (capab=0x8431 status=0 aid=2)
[  332.077520] wlp6s0: associated
[  336.957173] wlp6s0: deauthenticating from 30:ea:e7:54:50:82 by local choice (Reason: 3=DEAUTH_LEAVING)
[  337.292969] PM: suspend entry (s2idle)
[  337.319780] Filesystems sync: 0.026 seconds
[  337.322248] Freezing user space processes
[  337.323605] Freezing user space processes completed (elapsed 0.001 seconds)
[  337.323607] OOM killer disabled.
[  337.323608] Freezing remaining freezable tasks
[  337.324738] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  337.325522] printk: Suspending console(s) (use no_console_suspend to debug)
[  337.326383] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
[  337.460470] ACPI: EC: interrupt blocked
[  360.830694] ACPI: EC: interrupt unblocked
[  361.010607] [drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
[  361.010684] amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
[  361.014881] amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
[  361.019326] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
[  361.021820] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
[  361.024318] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
[  361.026799] amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
[  361.042063] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
[  361.042068] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
[  361.044891] nvme nvme0: 16/0/0 default/read/poll queues
[  361.084552] amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[  361.084558] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  361.084559] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  361.084560] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[  361.084562] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[  361.084563] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[  361.084563] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[  361.084564] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[  361.084566] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[  361.084567] amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[  361.084568] amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[  361.084569] amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
[  361.084570] amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[  361.090950] [drm] ring gfx_32772.1.1 was added
[  361.091755] [drm] ring compute_32772.2.2 was added
[  361.092605] [drm] ring sdma_32772.3.3 was added
[  361.092639] [drm] ring gfx_32772.1.1 ib test pass
[  361.092676] [drm] ring compute_32772.2.2 ib test pass
[  361.092785] [drm] ring sdma_32772.3.3 ib test pass
[  361.196267] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
[  361.196277] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
[  361.526815] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
[  361.564728] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
[  361.564740] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
[  362.077574] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
[  362.079603] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
[  362.079610] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
[  362.155626] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
[  362.157909] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
[  362.178790] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
[  362.179387] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
[  363.808645] xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
[  364.012470] usb 6-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[  364.365878] usb 6-1.3: reset SuperSpeed USB device number 3 using xhci_hcd
[  366.060486] r8152-cfgselector 6-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
[  366.095869] r8152 6-1.4:1.0: skip request firmware
[  366.135712] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
[  366.135720] ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
[  366.135902] OOM killer enabled.
[  366.135903] Restarting tasks ... 
[  366.136503] usb 1-2: USB disconnect, device number 9
[  366.136685] xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
[  366.136786] done.
[  366.136863] random: crng reseeded on system resumption
[  366.158202] PM: suspend exit
[  366.247400] usb 1-3: USB disconnect, device number 8
[  367.090828] usb 1-3: new full-speed USB device number 10 using xhci_hcd
[  367.253214] usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
[  367.253221] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  367.253224] usb 1-3: Product: N-KEY Device
[  367.253227] usb 1-3: Manufacturer: ASUSTeK Computer Inc.
[  367.289675] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0014/input/input53
[  367.431291] asus 0003:0B05:1ABE.0014: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
[  367.438586] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0015/input/input54
[  367.438942] asus 0003:0B05:1ABE.0015: input,hidraw5: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
[  367.446303] asus 0003:0B05:1ABE.0016: Fixing up Asus N-Key report descriptor
[  367.455306] input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0016/input/input55
[  367.511088] asus 0003:0B05:1ABE.0016: input,hiddev96,hidraw6: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
[  367.770860] usb 1-2: new full-speed USB device number 11 using xhci_hcd
[  367.936247] usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
[  367.936257] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  367.936262] usb 1-2: Product: Controller
[  367.936266] usb 1-2: Manufacturer: ©Microsoft Corporation
[  367.936269] usb 1-2: SerialNumber: 1DD5F3D
[  367.948490] input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input56
[  367.950276] input input56: unable to receive magic message: -32
[  369.031122] wlp6s0: authenticate with 30:ea:e7:54:50:82 (local address=74:97:79:9e:4c:89)
[  369.043631] wlp6s0: send auth to 30:ea:e7:54:50:82 (try 1/3)
[  369.047523] wlp6s0: authenticated
[  369.050995] wlp6s0: associate with 30:ea:e7:54:50:82 (try 1/3)
[  369.065676] wlp6s0: RX AssocResp from 30:ea:e7:54:50:82 (capab=0x8431 status=0 aid=2)
[  369.086789] wlp6s0: associated
[  369.870635] r8152 6-1.4:1.0 enp11s0f3u1u4: carrier on
[  374.088435] wlp6s0: deauthenticated from 30:ea:e7:54:50:82 (Reason: 1=UNSPECIFIED)

The following is the log with mcu_powersave=1 left unattended for a few hours:

2024-09-20 20:34:21,582 INFO:	Debugging script for s2idle on AMD systems
2024-09-20 20:34:21,582 INFO:	💻 ASUSTeK COMPUTER INC. ROG Ally RC71L_RC71L (ROG Ally) running BIOS 5.29 (RC71L.339) released 07/02/2024 and EC 3.27
2024-09-20 20:34:21,582 INFO:	🐧 ChimeraOS 47 (8a71d33)
2024-09-20 20:34:21,582 INFO:	🐧 Kernel 6.11.0-00004-ge11bee8239e6-dirty
2024-09-20 20:34:21,584 DEBUG:	BAT0 energy level is 21360000 µWh
2024-09-20 20:34:21,584 INFO:	🔋 Battery BAT0 (ASUSTeK ASUS Battery) is operating at 83.74% of design
2024-09-20 20:34:21,584 INFO:	Checking prerequisites for s2idle
2024-09-20 20:34:21,584 INFO:	✅ Logs are provided via systemd
2024-09-20 20:34:21,585 INFO:	✅ AMD Ryzen Z1 Extreme (family 19 model 74)
2024-09-20 20:34:21,585 DEBUG:	SMT control: on
2024-09-20 20:34:21,585 INFO:	✅ SMT enabled
2024-09-20 20:34:21,585 INFO:	✅ LPS0 _DSM enabled
2024-09-20 20:34:21,591 INFO:	✅ ACPI FADT supports Low-power S0 idle
2024-09-20 20:34:21,591 DEBUG:	/sys/module/gpiolib_acpi/parameters/ignore_wake is not configured
2024-09-20 20:34:21,591 DEBUG:	/sys/module/gpiolib_acpi/parameters/ignore_interrupt is not configured
2024-09-20 20:34:21,591 DEBUG:	/proc/cmdline: rd.systemd.show_status=auto rd.udev.log_priority=3 preempt=full nowatchdog
2024-09-20 20:34:21,592 DEBUG:	LOGIND: no configuration changes
2024-09-20 20:34:21,592 INFO:	✅ HSMP driver `amd_hsmp` not detected (blocked: False)
2024-09-20 20:34:21,594 INFO:	✅ PMC driver `amd_pmc` loaded (Program 0 Firmware 76.71.0)
2024-09-20 20:34:21,598 INFO:	✅ GPU driver `amdgpu` bound to 0000:09:00.0
2024-09-20 20:34:21,622 INFO:	✅ System is configured for s2idle
2024-09-20 20:34:21,632 INFO:	✅ NVME Micron Technology Inc 2400 NVMe SSD (DRAM-less) is configured for s2idle in BIOS
2024-09-20 20:34:21,634 INFO:	✅ GPIO driver `pinctrl_amd` available
2024-09-20 20:34:21,636 DEBUG:	Winblue GPIO 0 debounce: disabled
2024-09-20 20:34:21,636 DEBUG:	gpio	  int|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg
2024-09-20 20:34:21,636 DEBUG:	#0	   😛|     ↑|   edge|  ⏰| ⏰|     |⏰|    |  ↑ |input  ↑|b (🕑 046875us)|0x81578e3
2024-09-20 20:34:21,636 DEBUG:	#2	   😛|     ↓|   edge|  ⏰| ⏰|     |  |    |  ↑ |input  ↑|               |0x157a00
2024-09-20 20:34:21,636 DEBUG:	#9	   😛|     ↑|  level|    |   |     |  |    |  ↓ |input  ↓|               |0x241900
2024-09-20 20:34:21,636 DEBUG:	#18	   😷|     ↓|  level|    |   |     |  |    |  ↑ |input  ↑|               |0x150b00
2024-09-20 20:34:21,636 DEBUG:	#44	   😷|     ↑|   edge|    |   |     |  |    |    |input  ↓|               |0x800
2024-09-20 20:34:21,636 DEBUG:	#54	   😛|     ↑|   edge|  ⏰| ⏰|     |  |    |    |input  ↓|               |0x7800
2024-09-20 20:34:21,636 DEBUG:	#58	   😛|     ↑|  level|  ⏰| ⏰|     |⏰|    |    |input  ↓|               |0x8007900
2024-09-20 20:34:21,636 DEBUG:	#59	   😛|     ↑|  level|  ⏰| ⏰|     |⏰|    |    |input  ↓|               |0x8007900
2024-09-20 20:34:21,636 DEBUG:	#84	   😛|     ↓|  level|    |   |     |  |    |  ↑ |input  ↑|b (🕑 000976us)|0x351b74
2024-09-20 20:34:21,661 DEBUG:	Micron Technology Inc Micron 2400 MTFDKBK512QFM firmware version: 'V3MA003'
2024-09-20 20:34:21,662 DEBUG:	| ['84b40af9-5392-5d04-ab7a-92c6ecd85f9f', '518236e8-44dc-5c54-86bf-8ab9c098cd5e', '83af6de5-10a8-52af-a66f-b8f2976550b3']
2024-09-20 20:34:21,662 DEBUG:	└─['NVME\\VEN_1344&DEV_5413', 'NVME\\VEN_1344&DEV_5413&SUBSYS_13441100', 'Micron_2400_MTFDKBK512QFM']
2024-09-20 20:34:21,662 DEBUG:	ASUSTeK COMPUTER INC. System Firmware firmware version: '825'
2024-09-20 20:34:21,662 DEBUG:	| ['b89ff2c6-881a-5e4f-8b4a-4138242a99f7']
2024-09-20 20:34:21,662 DEBUG:	└─[]
2024-09-20 20:34:21,662 DEBUG:	Microsoft TPM firmware version: '6.3.1.610'
2024-09-20 20:34:21,662 DEBUG:	| ['2a65d4b6-60a0-5e8c-acfa-d86cc3cbe4c3', '31a7bb1b-f5e1-53ff-b0e5-8692a21caed6', '5bea8d58-c840-513e-a5ad-0184cbaa9821', 'e02519c6-9139-5de8-89d4-9dca2f5c3b66']
2024-09-20 20:34:21,662 DEBUG:	└─['TPM\\VEN_MSFT&DEV_0001', 'TPM\\VEN_MSFT&MOD_Pluton.TPM.A', 'TPM\\VEN_MSFT&DEV_0001&VER_2.0', 'TPM\\VEN_MSFT&MOD_Pluton.TPM.A&VER_2.0']
2024-09-20 20:34:21,684 DEBUG:	Lockdown: [none] integrity confidentiality
2024-09-20 20:34:21,684 DEBUG:	VCE feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	UVD feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	MC feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	ME feature version: 35, firmware version: 0x00000027
2024-09-20 20:34:21,684 DEBUG:	PFP feature version: 35, firmware version: 0x00000030
2024-09-20 20:34:21,684 DEBUG:	CE feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	RLC feature version: 1, firmware version: 0x00000080
2024-09-20 20:34:21,684 DEBUG:	RLC SRLC feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	RLC SRLG feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	RLC SRLS feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	RLCP feature version: 1, firmware version: 0x0000000f
2024-09-20 20:34:21,684 DEBUG:	RLCV feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	MEC feature version: 35, firmware version: 0x00000027
2024-09-20 20:34:21,684 DEBUG:	IMU feature version: 0, firmware version: 0x0b012c00
2024-09-20 20:34:21,684 DEBUG:	SOS feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	ASD feature version: 553648351, firmware version: 0x210000df
2024-09-20 20:34:21,684 DEBUG:	TA XGMI feature version: 0x00000000, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	TA RAS feature version: 0x00000000, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	TA HDCP feature version: 0x00000000, firmware version: 0x17000040
2024-09-20 20:34:21,684 DEBUG:	TA DTM feature version: 0x00000000, firmware version: 0x12000016
2024-09-20 20:34:21,684 DEBUG:	TA RAP feature version: 0x00000000, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	SMC feature version: 0, program: 0, firmware version: 0x004c4700 (76.71.0)
2024-09-20 20:34:21,684 DEBUG:	SDMA0 feature version: 60, firmware version: 0x00000015
2024-09-20 20:34:21,684 DEBUG:	VCN feature version: 0, firmware version: 0x08116003
2024-09-20 20:34:21,684 DEBUG:	DMCU feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	DMCUB feature version: 0, firmware version: 0x08004300
2024-09-20 20:34:21,684 DEBUG:	TOC feature version: 0, firmware version: 0x0000000b
2024-09-20 20:34:21,684 DEBUG:	MES_KIQ feature version: 6, firmware version: 0x00000073
2024-09-20 20:34:21,684 DEBUG:	MES feature version: 1, firmware version: 0x00000062
2024-09-20 20:34:21,684 DEBUG:	VPE feature version: 0, firmware version: 0x00000000
2024-09-20 20:34:21,684 DEBUG:	VBIOS version: 113-PHXGENERIC-001
2024-09-20 20:34:21,687 DEBUG:	PCI devices
2024-09-20 20:34:21,687 DEBUG:	| 0000:00:00.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14e8] : \_SB_.PCI0.D002
2024-09-20 20:34:21,687 DEBUG:	| 0000:00:00.2 : Advanced Micro Devices, Inc. [AMD] IOMMU [1022:14e9] : \_SB_.PCI0.IOMA
2024-09-20 20:34:21,687 DEBUG:	| 0000:00:01.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-20 20:34:21,687 DEBUG:	| 0000:00:01.1 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14ed] : \_SB_.PCI0.GPP0
2024-09-20 20:34:21,688 DEBUG:	| 0000:00:02.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-20 20:34:21,688 DEBUG:	| 0000:00:02.2 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14ee] : \_SB_.PCI0.GPP6
2024-09-20 20:34:21,688 DEBUG:	├─ 0000:06:00.0 : MEDIATEK Corp. Network controller [14c3:0616] : \_SB_.PCI0.GPP6.WLAN
2024-09-20 20:34:21,688 DEBUG:	| 0000:00:02.3 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14ee] : \_SB_.PCI0.GPP7
2024-09-20 20:34:21,688 DEBUG:	├─ 0000:07:00.0 : Genesys Logic, Inc SD Host controller [17a0:9755] : \_SB_.PCI0.GPP7.CADR
2024-09-20 20:34:21,688 DEBUG:	| 0000:00:02.4 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14ee] : \_SB_.PCI0.GPP8
2024-09-20 20:34:21,688 DEBUG:	├─ 0000:08:00.0 : Micron Technology Inc Non-Volatile memory controller [1344:5413] : \_SB_.PCI0.GPP8.NVME
2024-09-20 20:34:21,688 DEBUG:	| 0000:00:03.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-20 20:34:21,688 DEBUG:	| 0000:00:04.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-20 20:34:21,688 DEBUG:	| 0000:00:08.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-20 20:34:21,688 DEBUG:	| 0000:00:08.1 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14eb] : \_SB_.PCI0.GP17
2024-09-20 20:34:21,688 DEBUG:	├─ 0000:09:00.0 : Advanced Micro Devices, Inc. [AMD/ATI] VGA compatible controller [1002:15bf] : \_SB_.PCI0.GP17.VGA_
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:09:00.1 : Advanced Micro Devices, Inc. [AMD/ATI] Audio device [1002:1640] : \_SB_.PCI0.GP17.HDAU
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:09:00.2 : Advanced Micro Devices, Inc. [AMD] Encryption controller [1022:15c7] : \_SB_.PCI0.GP17.APSP
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:09:00.3 : Advanced Micro Devices, Inc. [AMD] USB controller [1022:15b9] : \_SB_.PCI0.GP17.XHC0
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:09:00.4 : Advanced Micro Devices, Inc. [AMD] USB controller [1022:15ba] : \_SB_.PCI0.GP17.XHC1
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:09:00.5 : Advanced Micro Devices, Inc. [AMD] Multimedia controller [1022:15e2] : \_SB_.PCI0.GP17.ACP_
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:09:00.6 : Advanced Micro Devices, Inc. [AMD] Audio device [1022:15e3] : \_SB_.PCI0.GP17.AZAL
2024-09-20 20:34:21,689 DEBUG:	| 0000:00:08.2 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14eb] : \_SB_.PCI0.GP18
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:0a:00.0 : Advanced Micro Devices, Inc. [AMD]  [1022:14ec]
2024-09-20 20:34:21,689 DEBUG:	| 0000:00:08.3 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14eb] : \_SB_.PCI0.GP19
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:0b:00.0 : Advanced Micro Devices, Inc. [AMD]  [1022:14ec] : \_SB_.PCI0.GP19.XHC2
2024-09-20 20:34:21,689 DEBUG:	├─ 0000:0b:00.3 : Advanced Micro Devices, Inc. [AMD] USB controller [1022:15c0] : \_SB_.PCI0.GP19.XHC3
2024-09-20 20:34:21,690 DEBUG:	├─ 0000:0b:00.4 : Advanced Micro Devices, Inc. [AMD] USB controller [1022:15c1] : \_SB_.PCI0.GP19.XHC4
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:14.0 : Advanced Micro Devices, Inc. [AMD] SMBus [1022:790b] : \_SB_.PCI0.D02B
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:14.3 : Advanced Micro Devices, Inc. [AMD] ISA bridge [1022:790e] : \_SB_.PCI0.SBRG
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:18.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f0]
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:18.1 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f1]
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:18.2 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f2]
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:18.3 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f3]
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:18.4 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f4]
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:18.5 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f5]
2024-09-20 20:34:21,690 DEBUG:	| 0000:00:18.6 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f6]
2024-09-20 20:34:21,690 DEBUG:	└─0000:00:18.7 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f7]
2024-09-20 20:34:21,774 DEBUG:	Interrupts
2024-09-20 20:34:21,774 DEBUG:	| 0: Timer
2024-09-20 20:34:21,774 DEBUG:	| 1: PS/2 controller
2024-09-20 20:34:21,774 DEBUG:	| 2: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 3: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 4: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 5: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 6: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 7: GPIO Controller
2024-09-20 20:34:21,774 DEBUG:	| 8: RTC
2024-09-20 20:34:21,774 DEBUG:	| 9: ACPI SCI
2024-09-20 20:34:21,774 DEBUG:	| 10: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 11: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 12: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 13: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 14: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 15: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 24: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 25: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 26: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 27: Disabled interrupt
2024-09-20 20:34:21,774 DEBUG:	| 28: Advanced Micro Devices, Inc. [AMD] Generic system peripheral (0000:00:00.2) (AMD-Vi)
2024-09-20 20:34:21,774 DEBUG:	| 29: GPIO 0 (ACPI:Event)
2024-09-20 20:34:21,774 DEBUG:	| 30: GPIO 58 (ACPI:Event)
2024-09-20 20:34:21,774 DEBUG:	| 31: GPIO 59 (ACPI:Event)
2024-09-20 20:34:21,775 DEBUG:	| 32: GPIO 2 (ACPI:Event)
2024-09-20 20:34:21,775 DEBUG:	| 33: GPIO 54 (ACPI:Event)
2024-09-20 20:34:21,775 DEBUG:	| 34: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:01.1) (PCIe PME,aerdrv,pciehp)
2024-09-20 20:34:21,775 DEBUG:	| 35: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:02.2) (PCIe PME,aerdrv)
2024-09-20 20:34:21,775 DEBUG:	| 36: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:02.3) (PCIe PME,aerdrv)
2024-09-20 20:34:21,775 DEBUG:	| 37: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:02.4) (PCIe PME,aerdrv)
2024-09-20 20:34:21,775 DEBUG:	| 38: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:08.1) (PCIe PME)
2024-09-20 20:34:21,775 DEBUG:	| 39: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:08.2) (PCIe PME)
2024-09-20 20:34:21,775 DEBUG:	| 40: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:08.3) (PCIe PME)
2024-09-20 20:34:21,775 DEBUG:	| 41: GPIO 9 (NVTK0603:00)
2024-09-20 20:34:21,775 DEBUG:	| 42: Disabled interrupt
2024-09-20 20:34:21,775 DEBUG:	| 43: Advanced Micro Devices, Inc. [AMD] Encryption controller (0000:09:00.2) (psp-1)
2024-09-20 20:34:21,775 DEBUG:	| 44: Advanced Micro Devices, Inc. [AMD] Encryption controller (0000:09:00.2)
2024-09-20 20:34:21,775 DEBUG:	| 45: Disabled interrupt
2024-09-20 20:34:21,775 DEBUG:	| 46: Advanced Micro Devices, Inc. [AMD] Serial bus controller (0000:09:00.3) (xhci_hcd)
2024-09-20 20:34:21,775 DEBUG:	| 47: Disabled interrupt
2024-09-20 20:34:21,775 DEBUG:	| 48: Advanced Micro Devices, Inc. [AMD] Multimedia controller (0000:09:00.6) (snd_hda_intel:card1)
2024-09-20 20:34:21,775 DEBUG:	| 49: Disabled interrupt
2024-09-20 20:34:21,775 DEBUG:	| 50: Advanced Micro Devices, Inc. [AMD] Serial bus controller (0000:09:00.4) (xhci_hcd)
2024-09-20 20:34:21,775 DEBUG:	| 51: Disabled interrupt
2024-09-20 20:34:21,775 DEBUG:	| 52: Advanced Micro Devices, Inc. [AMD] Serial bus controller (0000:0b:00.3) (xhci_hcd)
2024-09-20 20:34:21,775 DEBUG:	| 53: Disabled interrupt
2024-09-20 20:34:21,775 DEBUG:	| 54: Advanced Micro Devices, Inc. [AMD] Serial bus controller (0000:0b:00.4) (xhci_hcd)
2024-09-20 20:34:21,775 DEBUG:	| 55: Genesys Logic, Inc Generic system peripheral (0000:07:00.0) (mmc0)
2024-09-20 20:34:21,775 DEBUG:	| 56: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q0)
2024-09-20 20:34:21,775 DEBUG:	| 57: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q1)
2024-09-20 20:34:21,775 DEBUG:	| 58: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q2)
2024-09-20 20:34:21,775 DEBUG:	| 59: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q3)
2024-09-20 20:34:21,775 DEBUG:	| 60: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q4)
2024-09-20 20:34:21,775 DEBUG:	| 61: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q5)
2024-09-20 20:34:21,775 DEBUG:	| 62: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q6)
2024-09-20 20:34:21,775 DEBUG:	| 63: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q7)
2024-09-20 20:34:21,775 DEBUG:	| 64: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q8)
2024-09-20 20:34:21,775 DEBUG:	| 65: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q9)
2024-09-20 20:34:21,775 DEBUG:	| 66: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q10)
2024-09-20 20:34:21,775 DEBUG:	| 67: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q11)
2024-09-20 20:34:21,775 DEBUG:	| 68: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q12)
2024-09-20 20:34:21,775 DEBUG:	| 69: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q13)
2024-09-20 20:34:21,775 DEBUG:	| 70: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q14)
2024-09-20 20:34:21,775 DEBUG:	| 71: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q15)
2024-09-20 20:34:21,775 DEBUG:	| 72: GPIO 84 (cs35l41 IRQ1 Controller,cs35l41 IRQ1 Controller)
2024-09-20 20:34:21,775 DEBUG:	| 73: Disabled interrupt (Boost Overvoltage Error)
2024-09-20 20:34:21,775 DEBUG:	| 74: Disabled interrupt (Boost Undervoltage Error)
2024-09-20 20:34:21,775 DEBUG:	| 75: Disabled interrupt (Boost Inductor Short Error)
2024-09-20 20:34:21,775 DEBUG:	| 76: Disabled interrupt (Temperature Warning)
2024-09-20 20:34:21,775 DEBUG:	| 77: Disabled interrupt (Temperature Error)
2024-09-20 20:34:21,775 DEBUG:	| 78: Disabled interrupt (Amp Short)
2024-09-20 20:34:21,775 DEBUG:	| 79: Disabled interrupt (Boost Overvoltage Error)
2024-09-20 20:34:21,775 DEBUG:	| 80: Disabled interrupt (Boost Undervoltage Error)
2024-09-20 20:34:21,775 DEBUG:	| 81: Disabled interrupt (Boost Inductor Short Error)
2024-09-20 20:34:21,775 DEBUG:	| 82: Disabled interrupt (Temperature Warning)
2024-09-20 20:34:21,775 DEBUG:	| 83: Disabled interrupt (Temperature Error)
2024-09-20 20:34:21,775 DEBUG:	| 84: Disabled interrupt (Amp Short)
2024-09-20 20:34:21,775 DEBUG:	| 85: Disabled interrupt
2024-09-20 20:34:21,775 DEBUG:	| 86: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q16)
2024-09-20 20:34:21,775 DEBUG:	| 87: Advanced Micro Devices, Inc. [AMD/ATI] Multimedia controller (0000:09:00.1) (snd_hda_intel:card0)
2024-09-20 20:34:21,775 DEBUG:	| 88: MEDIATEK Corp. Network controller (0000:06:00.0) (mt7921e)
2024-09-20 20:34:21,775 DEBUG:	└─89: Advanced Micro Devices, Inc. [AMD/ATI] Display controller (0000:09:00.0) (amdgpu)
2024-09-20 20:34:21,783 DEBUG:	I2C HID devices
2024-09-20 20:34:21,783 DEBUG:	└─"NVTK0603:00 0603:F200" [NVTK0603] : \_SB_.I2CA.TPL0
2024-09-20 20:34:21,795 DEBUG:	Wakeup sources:
2024-09-20 20:34:21,795 DEBUG:	| ACPI Battery [PNP0C0A:00]: enabled
2024-09-20 20:34:21,795 DEBUG:	| ACPI Power Button [PNP0C0C:00]: enabled
2024-09-20 20:34:21,795 DEBUG:	| ACPI Sleep Button [PNP0C0E:00]: enabled
2024-09-20 20:34:21,795 DEBUG:	| AT Translated Set 2 keyboard [serio0]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Advanced Micro Devices, Inc. [AMD] ISA bridge [0000:00:14.3]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Advanced Micro Devices, Inc. [AMD] Multimedia controller [0000:09:00.5]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Advanced Micro Devices, Inc. [AMD] PCI bridge [0000:00:01.1]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:09:00.3]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:09:00.3]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:09:00.4]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:0b:00.3]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:0b:00.4]: enabled
2024-09-20 20:34:21,795 DEBUG:	| Plug-n-play Real Time Clock [00:01]: enabled
2024-09-20 20:34:21,795 DEBUG:	└─Real Time Clock alarm timer [rtc0]: enabled
2024-09-20 20:34:21,798 DEBUG:	/*
2024-09-20 20:34:21,798 DEBUG:	 * Intel ACPI Component Architecture
2024-09-20 20:34:21,798 DEBUG:	 * AML/ASL+ Disassembler version 20230628 (64-bit version)
2024-09-20 20:34:21,798 DEBUG:	 * Copyright (c) 2000 - 2023 Intel Corporation
2024-09-20 20:34:21,798 DEBUG:	 *
2024-09-20 20:34:21,798 DEBUG:	 * Disassembling to symbolic ASL+ operators
2024-09-20 20:34:21,798 DEBUG:	 *
2024-09-20 20:34:21,798 DEBUG:	 * Disassembly of /sys/firmware/acpi/tables/SSDT19
2024-09-20 20:34:21,798 DEBUG:	 *
2024-09-20 20:34:21,798 DEBUG:	 * Original Table Header:
2024-09-20 20:34:21,798 DEBUG:	 *     Signature        "SSDT"
2024-09-20 20:34:21,798 DEBUG:	 *     Length           0x000009DB (2523)
2024-09-20 20:34:21,798 DEBUG:	 *     Revision         0x02
2024-09-20 20:34:21,798 DEBUG:	 *     Checksum         0xB0
2024-09-20 20:34:21,798 DEBUG:	 *     OEM ID           "AMD"
2024-09-20 20:34:21,798 DEBUG:	 *     OEM Table ID     "CPMGPIO0"
2024-09-20 20:34:21,798 DEBUG:	 *     OEM Revision     0x00000001 (1)
2024-09-20 20:34:21,798 DEBUG:	 *     Compiler ID      "INTL"
2024-09-20 20:34:21,798 DEBUG:	 *     Compiler Version 0x20200717 (538969879)
2024-09-20 20:34:21,798 DEBUG:	 */
2024-09-20 20:34:21,798 DEBUG:	DefinitionBlock ("", "SSDT", 2, "AMD", "CPMGPIO0", 0x00000001)
2024-09-20 20:34:21,798 DEBUG:	{
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.GPIO, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GP17.ACP_, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GP17.AZAL, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GP17.MP2C, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GP17.XHC0, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GP17.XHC1, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GPP0, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GPP1, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GPP2, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GPP5, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GPP6, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GPP7, DeviceObj)
2024-09-20 20:34:21,798 DEBUG:	    External (_SB_.PCI0.GPP7.DEV0, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (_SB_.PCI0.SBRG.EC0_, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (_SB_.PCI0.SBRG.EC0_.OKEC, IntObj)
2024-09-20 20:34:21,799 DEBUG:	    External (_SB_.PCI0.SBRG.EC0_.Z009, MutexObj)
2024-09-20 20:34:21,799 DEBUG:	    External (_SB_.PWRB, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M000, MethodObj)    // 1 Arguments
2024-09-20 20:34:21,799 DEBUG:	    External (M037, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M046, IntObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M047, IntObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M050, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M051, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M052, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M053, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M054, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M055, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M056, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M057, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M058, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M059, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M062, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M068, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M069, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M070, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M071, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M072, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M074, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M075, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M076, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M077, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M078, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M079, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M080, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M081, DeviceObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M082, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M083, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M084, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M085, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M086, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M087, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M088, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M089, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M090, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M091, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M092, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M093, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M094, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M095, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M096, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M097, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M098, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M099, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M100, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M101, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M102, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M103, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M104, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M105, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M106, FieldUnitObj)
2024-09-20 20:34:21,799 DEBUG:	    External (M107, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M108, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M109, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M110, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M115, BuffObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M116, BuffFieldObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M117, BuffFieldObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M118, BuffFieldObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M119, BuffFieldObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M120, BuffFieldObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M122, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M127, DeviceObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M128, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M131, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M132, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M133, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M134, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M135, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M136, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M220, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M221, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M226, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M227, DeviceObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M229, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M231, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M233, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M235, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M23A, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M251, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M280, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M290, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M29A, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M310, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M31C, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M320, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M321, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M322, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M323, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M324, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M325, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M326, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M327, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M328, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M329, DeviceObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M32A, DeviceObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M32B, DeviceObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M330, DeviceObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M331, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M378, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M379, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M380, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M381, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M382, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M383, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M384, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M385, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M386, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M387, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M388, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M389, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M390, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M391, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M392, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M404, BuffObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M408, MutexObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M414, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M444, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M449, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M453, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M454, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M455, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M456, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M457, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M460, MethodObj)    // 7 Arguments
2024-09-20 20:34:21,800 DEBUG:	    External (M4C0, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M4F0, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M610, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M620, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M631, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	    External (M652, FieldUnitObj)
2024-09-20 20:34:21,800 DEBUG:	
2024-09-20 20:34:21,800 DEBUG:	    Scope (\_SB.PCI0.SBRG.EC0)
2024-09-20 20:34:21,800 DEBUG:	    {
2024-09-20 20:34:21,800 DEBUG:	        OperationRegion (ECRM, EmbeddedControl, Zero, 0xFF)
2024-09-20 20:34:21,800 DEBUG:	        Field (ECRM, ByteAcc, NoLock, Preserve)
2024-09-20 20:34:21,800 DEBUG:	        {
2024-09-20 20:34:21,800 DEBUG:	            Offset (0xCC),
2024-09-20 20:34:21,800 DEBUG:	            PBCN,   8
2024-09-20 20:34:21,800 DEBUG:	        }
2024-09-20 20:34:21,800 DEBUG:	    }
2024-09-20 20:34:21,800 DEBUG:	
2024-09-20 20:34:21,800 DEBUG:	    Scope (\_SB.GPIO)
2024-09-20 20:34:21,800 DEBUG:	    {
2024-09-20 20:34:21,800 DEBUG:	        Method (_AEI, 0, NotSerialized)  // _AEI: ACPI Event Interrupts
2024-09-20 20:34:21,800 DEBUG:	        {
2024-09-20 20:34:21,800 DEBUG:	            Name (BUF0, ResourceTemplate ()
2024-09-20 20:34:21,800 DEBUG:	            {
2024-09-20 20:34:21,800 DEBUG:	                GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullDefault, 0x1388,
2024-09-20 20:34:21,800 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-20 20:34:21,800 DEBUG:	                    )
2024-09-20 20:34:21,800 DEBUG:	                    {   // Pin list
2024-09-20 20:34:21,800 DEBUG:	                        0x0000
2024-09-20 20:34:21,800 DEBUG:	                    }
2024-09-20 20:34:21,800 DEBUG:	                GpioInt (Level, ActiveHigh, ExclusiveAndWake, PullNone, 0x0000,
2024-09-20 20:34:21,800 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-20 20:34:21,800 DEBUG:	                    )
2024-09-20 20:34:21,800 DEBUG:	                    {   // Pin list
2024-09-20 20:34:21,800 DEBUG:	                        0x003A
2024-09-20 20:34:21,800 DEBUG:	                    }
2024-09-20 20:34:21,800 DEBUG:	                GpioInt (Level, ActiveHigh, ExclusiveAndWake, PullNone, 0x0000,
2024-09-20 20:34:21,800 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-20 20:34:21,800 DEBUG:	                    )
2024-09-20 20:34:21,800 DEBUG:	                    {   // Pin list
2024-09-20 20:34:21,801 DEBUG:	                        0x003B
2024-09-20 20:34:21,801 DEBUG:	                    }
2024-09-20 20:34:21,801 DEBUG:	                GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
2024-09-20 20:34:21,801 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-20 20:34:21,801 DEBUG:	                    )
2024-09-20 20:34:21,801 DEBUG:	                    {   // Pin list
2024-09-20 20:34:21,801 DEBUG:	                        0x0002
2024-09-20 20:34:21,801 DEBUG:	                    }
2024-09-20 20:34:21,801 DEBUG:	                GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone, 0x0000,
2024-09-20 20:34:21,801 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-20 20:34:21,801 DEBUG:	                    )
2024-09-20 20:34:21,801 DEBUG:	                    {   // Pin list
2024-09-20 20:34:21,801 DEBUG:	                        0x0036
2024-09-20 20:34:21,801 DEBUG:	                    }
2024-09-20 20:34:21,801 DEBUG:	            })
2024-09-20 20:34:21,801 DEBUG:	            M460 ("  OEM-ASL-\\_SB.GPIO._AEI\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	            Return (BUF0) /* \_SB_.GPIO._AEI.BUF0 */
2024-09-20 20:34:21,801 DEBUG:	        }
2024-09-20 20:34:21,801 DEBUG:	
2024-09-20 20:34:21,801 DEBUG:	        Method (_EVT, 1, Serialized)  // _EVT: Event
2024-09-20 20:34:21,801 DEBUG:	        {
2024-09-20 20:34:21,801 DEBUG:	            Name (HPDW, 0x55)
2024-09-20 20:34:21,801 DEBUG:	            M460 ("  OEM-ASL-\\_SB.GPIO._EVT-Start Case %d\n", ToInteger (Arg0), Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	            Switch (ToInteger (Arg0))
2024-09-20 20:34:21,801 DEBUG:	            {
2024-09-20 20:34:21,801 DEBUG:	                Case (Zero)
2024-09-20 20:34:21,801 DEBUG:	                {
2024-09-20 20:34:21,801 DEBUG:	                    M000 (0x3900)
2024-09-20 20:34:21,801 DEBUG:	                    M460 ("    Notify (\\_SB.PWRB, 0x80)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	                    Notify (\_SB.PWRB, 0x80) // Status Change
2024-09-20 20:34:21,801 DEBUG:	                }
2024-09-20 20:34:21,801 DEBUG:	                Case (0x02)
2024-09-20 20:34:21,801 DEBUG:	                {
2024-09-20 20:34:21,801 DEBUG:	                    M000 (0x3902)
2024-09-20 20:34:21,801 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GPP0, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	                    Notify (\_SB.PCI0.GPP0, 0x02) // Device Wake
2024-09-20 20:34:21,801 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GPP1, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	                    Notify (\_SB.PCI0.GPP1, 0x02) // Device Wake
2024-09-20 20:34:21,801 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GPP2, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	                    Notify (\_SB.PCI0.GPP2, 0x02) // Device Wake
2024-09-20 20:34:21,801 DEBUG:	                }
2024-09-20 20:34:21,801 DEBUG:	                Case (0x36)
2024-09-20 20:34:21,801 DEBUG:	                {
2024-09-20 20:34:21,801 DEBUG:	                    M000 (0x3936)
2024-09-20 20:34:21,801 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GP17.MP2C, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	                    Notify (\_SB.PCI0.GP17.MP2C, 0x02) // Device Wake
2024-09-20 20:34:21,801 DEBUG:	                    If ((HPDW == One))
2024-09-20 20:34:21,801 DEBUG:	                    {
2024-09-20 20:34:21,801 DEBUG:	                        M460 ("    Notify (\\_SB.PCI0.GP17.MP2C(HPDW):PWRB 0x80)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	                        Notify (\_SB.PWRB, 0x80) // Status Change
2024-09-20 20:34:21,801 DEBUG:	                    }
2024-09-20 20:34:21,801 DEBUG:	                }
2024-09-20 20:34:21,801 DEBUG:	                Case (0x3A)
2024-09-20 20:34:21,801 DEBUG:	                {
2024-09-20 20:34:21,801 DEBUG:	                    M000 (0x393A)
2024-09-20 20:34:21,801 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GP17.XHC0, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	                    Notify (\_SB.PCI0.GP17.XHC0, 0x02) // Device Wake
2024-09-20 20:34:21,801 DEBUG:	                }
2024-09-20 20:34:21,801 DEBUG:	                Case (0x3B)
2024-09-20 20:34:21,801 DEBUG:	                {
2024-09-20 20:34:21,801 DEBUG:	                    M000 (0x393B)
2024-09-20 20:34:21,801 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GP17.XHC1, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	                    Notify (\_SB.PCI0.GP17.XHC1, 0x02) // Device Wake
2024-09-20 20:34:21,801 DEBUG:	                }
2024-09-20 20:34:21,801 DEBUG:	
2024-09-20 20:34:21,801 DEBUG:	            }
2024-09-20 20:34:21,801 DEBUG:	
2024-09-20 20:34:21,801 DEBUG:	            M460 ("  OEM-ASL-\\_SB.GPIO._EVT-End Case %d\n", ToInteger (Arg0), Zero, Zero, Zero, Zero, Zero)
2024-09-20 20:34:21,801 DEBUG:	        }
2024-09-20 20:34:21,801 DEBUG:	    }
2024-09-20 20:34:21,801 DEBUG:	}
2024-09-20 20:35:30,089 INFO:	Running 80 cycles (Test finish expected @ 2024-09-20 23:20:50.089780)
2024-09-20 20:35:30,090 DEBUG:	Suspend timer programmed for 0:02:00
2024-09-20 20:35:32,094 INFO:	Suspend cycle 1: Started at 2024-09-20 20:35:32.094086 (cycle finish expected @ 2024-09-20 20:37:36.094121)
2024-09-20 20:37:35,002 ERROR:	❌ Failed to suspend
2024-09-20 20:37:35,002 DEBUG:	[Errno 16] Device or resource busy
2024-09-20 20:37:37,003 INFO:	Suspend cycle 2: Started at 2024-09-20 20:37:37.003413 (cycle finish expected @ 2024-09-20 20:39:41.003431)
2024-09-20 20:39:41,992 INFO:	Results from last s2idle cycle
2024-09-20 20:39:41,992 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:39:41,993 DEBUG:	Filesystems sync: 0.005 seconds
2024-09-20 20:39:41,993 DEBUG:	Freezing user space processes
2024-09-20 20:39:41,993 DEBUG:	Freezing user space processes completed (elapsed 0.046 seconds)
2024-09-20 20:39:41,993 DEBUG:	OOM killer disabled.
2024-09-20 20:39:41,993 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:39:41,993 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 20:39:41,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:39:41,993 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:39:41,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:39:41,993 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:39:41,993 DEBUG:	PM: suspend of devices complete after 347.300 msecs
2024-09-20 20:39:41,993 DEBUG:	PM: start suspend of devices complete after 347.828 msecs
2024-09-20 20:39:41,993 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:39:41,993 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:39:41,993 DEBUG:	PM: late suspend of devices complete after 0.997 msecs
2024-09-20 20:39:41,993 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:39:41,993 DEBUG:	PM: noirq suspend of devices complete after 89.451 msecs
2024-09-20 20:39:41,993 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:39:41,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:39:41,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:39:41,993 DEBUG:	PM: suspend-to-idle
2024-09-20 20:39:41,993 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:39:41,993 DEBUG:	Timekeeping suspended for 119.500 seconds
2024-09-20 20:39:41,993 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:39:41,993 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:39:41,993 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:39:41,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:39:41,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:39:41,993 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:39:41,993 DEBUG:	PM: noirq resume of devices complete after 164.883 msecs
2024-09-20 20:39:41,993 DEBUG:	PM: early resume of devices complete after 2.927 msecs
2024-09-20 20:39:41,993 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:39:41,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:39:41,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:39:41,993 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:39:41,993 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:39:41,993 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:39:41,993 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:39:41,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:39:41,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:39:41,994 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:39:41,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:39:41,994 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:39:41,994 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:39:41,994 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:39:41,994 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:39:41,994 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:39:41,994 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:39:41,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:39:41,994 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:39:41,994 DEBUG:	PM: resume of devices complete after 2802.427 msecs
2024-09-20 20:39:41,994 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:39:41,994 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:39:41,994 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:39:41,994 DEBUG:	OOM killer enabled.
2024-09-20 20:39:41,994 DEBUG:	Restarting tasks ... done.
2024-09-20 20:39:41,994 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:39:41,994 DEBUG:	usb 1-2: USB disconnect, device number 21
2024-09-20 20:39:41,994 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:39:41,994 DEBUG:	PM: suspend exit
2024-09-20 20:39:41,994 DEBUG:	usb 1-3: USB disconnect, device number 20
2024-09-20 20:39:41,994 DEBUG:	usb 1-3: new full-speed USB device number 22 using xhci_hcd
2024-09-20 20:39:41,994 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:39:41,994 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:39:41,995 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:39:41,995 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:39:41,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.002E/input/input77
2024-09-20 20:39:41,995 DEBUG:	asus 0003:0B05:1ABE.002E: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:39:41,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.002F/input/input78
2024-09-20 20:39:41,995 DEBUG:	asus 0003:0B05:1ABE.002F: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:39:41,995 DEBUG:	asus 0003:0B05:1ABE.0030: Fixing up Asus N-Key report descriptor
2024-09-20 20:39:41,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0030/input/input79
2024-09-20 20:39:41,995 DEBUG:	asus 0003:0B05:1ABE.0030: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:39:41,995 DEBUG:	usb 1-2: new full-speed USB device number 23 using xhci_hcd
2024-09-20 20:39:41,995 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:39:41,995 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:39:41,995 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:39:41,995 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:39:41,995 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:39:41,995 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input80
2024-09-20 20:39:41,995 DEBUG:	input input80: unable to receive magic message: -32
2024-09-20 20:39:41,995 INFO:	○ Suspend count: 1
2024-09-20 20:39:41,995 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:39:41,995 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:39:41,995 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:39:41,995 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:39:41,995 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:39:41,996 INFO:	○ gpe10 increased from 57 to 61
2024-09-20 20:39:41,996 INFO:	✅ Userspace suspended for 0:02:04.992871
2024-09-20 20:39:41,996 DEBUG:	Kernel suspended for total of 0:01:59.500000 (95.61%)
2024-09-20 20:39:41,996 INFO:	✅ In a hardware sleep state for 0:01:58.937378 (95.16%)
2024-09-20 20:39:41,997 DEBUG:	BAT0 energy level is 20994000 µWh
2024-09-20 20:39:41,997 INFO:	🔋 Battery BAT0 lost 366000 µWh (1.09%) [Average rate 1.05W]
2024-09-20 20:39:43,997 INFO:	Suspend cycle 3: Started at 2024-09-20 20:39:43.997464 (cycle finish expected @ 2024-09-20 20:41:47.997489)
2024-09-20 20:41:49,011 INFO:	Results from last s2idle cycle
2024-09-20 20:41:49,012 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:41:49,012 DEBUG:	Filesystems sync: 0.032 seconds
2024-09-20 20:41:49,012 DEBUG:	Freezing user space processes
2024-09-20 20:41:49,012 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:41:49,012 DEBUG:	OOM killer disabled.
2024-09-20 20:41:49,012 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:41:49,012 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 20:41:49,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:41:49,013 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:41:49,013 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:41:49,013 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:41:49,013 DEBUG:	PM: suspend of devices complete after 348.880 msecs
2024-09-20 20:41:49,013 DEBUG:	PM: start suspend of devices complete after 349.658 msecs
2024-09-20 20:41:49,013 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:41:49,013 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:41:49,013 DEBUG:	PM: late suspend of devices complete after 1.195 msecs
2024-09-20 20:41:49,013 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:41:49,013 DEBUG:	PM: noirq suspend of devices complete after 108.082 msecs
2024-09-20 20:41:49,013 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:41:49,013 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:41:49,013 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:41:49,013 DEBUG:	PM: suspend-to-idle
2024-09-20 20:41:49,013 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:41:49,013 DEBUG:	Timekeeping suspended for 119.504 seconds
2024-09-20 20:41:49,013 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:41:49,013 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:41:49,013 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:41:49,013 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:41:49,013 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:41:49,013 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:41:49,013 DEBUG:	PM: noirq resume of devices complete after 164.547 msecs
2024-09-20 20:41:49,013 DEBUG:	PM: early resume of devices complete after 3.189 msecs
2024-09-20 20:41:49,013 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:41:49,013 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:41:49,013 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:41:49,013 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:41:49,014 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:41:49,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:41:49,014 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:41:49,014 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:41:49,014 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:41:49,014 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:41:49,014 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:41:49,014 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:41:49,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:41:49,014 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:41:49,014 DEBUG:	PM: resume of devices complete after 2808.621 msecs
2024-09-20 20:41:49,015 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:41:49,015 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:41:49,015 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:41:49,015 DEBUG:	OOM killer enabled.
2024-09-20 20:41:49,015 DEBUG:	Restarting tasks ... 
2024-09-20 20:41:49,015 DEBUG:	usb 1-2: USB disconnect, device number 23
2024-09-20 20:41:49,015 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:41:49,015 DEBUG:	done.
2024-09-20 20:41:49,015 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:41:49,015 DEBUG:	PM: suspend exit
2024-09-20 20:41:49,015 DEBUG:	usb 1-3: USB disconnect, device number 22
2024-09-20 20:41:49,015 DEBUG:	usb 1-3: new full-speed USB device number 24 using xhci_hcd
2024-09-20 20:41:49,015 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:41:49,015 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:41:49,015 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:41:49,015 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:41:49,015 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0031/input/input81
2024-09-20 20:41:49,015 DEBUG:	asus 0003:0B05:1ABE.0031: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:41:49,015 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0032/input/input82
2024-09-20 20:41:49,015 DEBUG:	asus 0003:0B05:1ABE.0032: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:41:49,015 DEBUG:	asus 0003:0B05:1ABE.0033: Fixing up Asus N-Key report descriptor
2024-09-20 20:41:49,015 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0033/input/input83
2024-09-20 20:41:49,015 DEBUG:	asus 0003:0B05:1ABE.0033: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:41:49,015 DEBUG:	usb 1-2: new full-speed USB device number 25 using xhci_hcd
2024-09-20 20:41:49,015 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:41:49,015 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:41:49,015 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:41:49,015 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:41:49,015 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:41:49,015 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input84
2024-09-20 20:41:49,015 DEBUG:	input input84: unable to receive magic message: -32
2024-09-20 20:41:49,015 DEBUG:	input input84: unable to receive magic message: -32
2024-09-20 20:41:49,015 INFO:	○ Suspend count: 1
2024-09-20 20:41:49,015 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:41:49,015 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:41:49,015 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:41:49,015 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:41:49,015 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:41:49,016 INFO:	○ gpe10 increased from 61 to 63
2024-09-20 20:41:49,016 INFO:	✅ Userspace suspended for 0:02:05.019067
2024-09-20 20:41:49,016 DEBUG:	Kernel suspended for total of 0:01:59.504000 (95.59%)
2024-09-20 20:41:49,016 INFO:	✅ In a hardware sleep state for 0:01:58.946075 (95.14%)
2024-09-20 20:41:49,017 DEBUG:	BAT0 energy level is 20962000 µWh
2024-09-20 20:41:49,017 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 20:41:51,018 INFO:	Suspend cycle 4: Started at 2024-09-20 20:41:51.017907 (cycle finish expected @ 2024-09-20 20:43:55.017933)
2024-09-20 20:43:55,993 INFO:	Results from last s2idle cycle
2024-09-20 20:43:55,993 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:43:55,993 DEBUG:	Filesystems sync: 0.032 seconds
2024-09-20 20:43:55,993 DEBUG:	Freezing user space processes
2024-09-20 20:43:55,993 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:43:55,993 DEBUG:	OOM killer disabled.
2024-09-20 20:43:55,993 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:43:55,993 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 20:43:55,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:43:55,993 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:43:55,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:43:55,993 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:43:55,993 DEBUG:	PM: suspend of devices complete after 346.356 msecs
2024-09-20 20:43:55,993 DEBUG:	PM: start suspend of devices complete after 346.793 msecs
2024-09-20 20:43:55,993 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:43:55,993 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:43:55,993 DEBUG:	PM: late suspend of devices complete after 0.980 msecs
2024-09-20 20:43:55,993 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:43:55,993 DEBUG:	PM: noirq suspend of devices complete after 94.573 msecs
2024-09-20 20:43:55,993 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:43:55,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:43:55,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:43:55,994 DEBUG:	PM: suspend-to-idle
2024-09-20 20:43:55,994 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:43:55,994 DEBUG:	Timekeeping suspended for 119.500 seconds
2024-09-20 20:43:55,994 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:43:55,994 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:43:55,994 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:43:55,994 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:43:55,994 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:43:55,994 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:43:55,994 DEBUG:	PM: noirq resume of devices complete after 162.568 msecs
2024-09-20 20:43:55,994 DEBUG:	PM: early resume of devices complete after 3.020 msecs
2024-09-20 20:43:55,994 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:43:55,994 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:43:55,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:43:55,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:43:55,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:43:55,995 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:43:55,995 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:43:55,995 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:43:55,995 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:43:55,995 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:43:55,996 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:43:55,996 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:43:55,996 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:43:55,996 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:43:55,996 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:43:55,997 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:43:55,997 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:43:55,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:43:55,997 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:43:55,997 DEBUG:	PM: resume of devices complete after 2803.097 msecs
2024-09-20 20:43:55,997 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:43:55,997 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:43:55,997 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:43:55,997 DEBUG:	OOM killer enabled.
2024-09-20 20:43:55,997 DEBUG:	Restarting tasks ... 
2024-09-20 20:43:55,997 DEBUG:	usb 1-2: USB disconnect, device number 25
2024-09-20 20:43:55,997 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:43:55,997 DEBUG:	done.
2024-09-20 20:43:55,997 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:43:55,997 DEBUG:	PM: suspend exit
2024-09-20 20:43:55,997 DEBUG:	usb 1-3: USB disconnect, device number 24
2024-09-20 20:43:55,997 DEBUG:	usb 1-3: new full-speed USB device number 26 using xhci_hcd
2024-09-20 20:43:55,997 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:43:55,997 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:43:55,998 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:43:55,998 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:43:55,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0034/input/input85
2024-09-20 20:43:55,998 DEBUG:	asus 0003:0B05:1ABE.0034: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:43:55,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0035/input/input86
2024-09-20 20:43:55,998 DEBUG:	asus 0003:0B05:1ABE.0035: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:43:55,998 DEBUG:	asus 0003:0B05:1ABE.0036: Fixing up Asus N-Key report descriptor
2024-09-20 20:43:55,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0036/input/input87
2024-09-20 20:43:55,998 DEBUG:	asus 0003:0B05:1ABE.0036: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:43:55,998 DEBUG:	usb 1-2: new full-speed USB device number 27 using xhci_hcd
2024-09-20 20:43:55,998 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:43:55,998 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:43:55,998 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:43:55,998 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:43:55,998 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:43:55,998 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input88
2024-09-20 20:43:55,998 DEBUG:	input input88: unable to receive magic message: -32
2024-09-20 20:43:55,998 INFO:	○ Suspend count: 1
2024-09-20 20:43:55,998 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:43:55,998 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:43:55,998 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:43:55,998 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:43:55,998 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:43:55,999 INFO:	○ gpe10 increased from 63 to 65
2024-09-20 20:43:55,999 INFO:	✅ Userspace suspended for 0:02:04.981292
2024-09-20 20:43:55,999 DEBUG:	Kernel suspended for total of 0:01:59.500000 (95.61%)
2024-09-20 20:43:55,999 INFO:	✅ In a hardware sleep state for 0:01:58.936065 (95.16%)
2024-09-20 20:43:55,999 DEBUG:	BAT0 energy level is 20930000 µWh
2024-09-20 20:43:55,999 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 20:43:58,000 INFO:	Suspend cycle 5: Started at 2024-09-20 20:43:58.000364 (cycle finish expected @ 2024-09-20 20:46:02.000379)
2024-09-20 20:46:02,987 INFO:	Results from last s2idle cycle
2024-09-20 20:46:02,987 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:46:02,987 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 20:46:02,987 DEBUG:	Freezing user space processes
2024-09-20 20:46:02,987 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:46:02,987 DEBUG:	OOM killer disabled.
2024-09-20 20:46:02,988 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:46:02,988 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 20:46:02,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:46:02,988 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:46:02,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:46:02,988 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:46:02,988 DEBUG:	PM: suspend of devices complete after 1062.324 msecs
2024-09-20 20:46:02,988 DEBUG:	PM: start suspend of devices complete after 1062.783 msecs
2024-09-20 20:46:02,988 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:46:02,988 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:46:02,988 DEBUG:	PM: late suspend of devices complete after 0.979 msecs
2024-09-20 20:46:02,988 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:46:02,988 DEBUG:	PM: noirq suspend of devices complete after 85.855 msecs
2024-09-20 20:46:02,988 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:46:02,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:46:02,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:46:02,988 DEBUG:	PM: suspend-to-idle
2024-09-20 20:46:02,988 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:46:02,988 DEBUG:	Timekeeping suspended for 118.807 seconds
2024-09-20 20:46:02,988 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:46:02,988 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:46:02,988 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:46:02,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:46:02,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:46:02,988 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:46:02,988 DEBUG:	PM: noirq resume of devices complete after 161.668 msecs
2024-09-20 20:46:02,988 DEBUG:	PM: early resume of devices complete after 2.850 msecs
2024-09-20 20:46:02,988 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:46:02,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:46:02,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:46:02,988 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:46:02,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:46:02,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:46:02,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:46:02,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:46:02,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:46:02,989 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:46:02,989 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:46:02,989 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:46:02,989 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:46:02,989 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:46:02,989 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:46:02,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:46:02,989 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:46:02,989 DEBUG:	PM: resume of devices complete after 2807.550 msecs
2024-09-20 20:46:02,989 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:46:02,989 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:46:02,989 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:46:02,989 DEBUG:	OOM killer enabled.
2024-09-20 20:46:02,989 DEBUG:	Restarting tasks ... 
2024-09-20 20:46:02,989 DEBUG:	usb 1-2: USB disconnect, device number 27
2024-09-20 20:46:02,989 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:46:02,989 DEBUG:	done.
2024-09-20 20:46:02,989 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:46:02,989 DEBUG:	PM: suspend exit
2024-09-20 20:46:02,989 DEBUG:	usb 1-3: USB disconnect, device number 26
2024-09-20 20:46:02,989 DEBUG:	usb 1-3: new full-speed USB device number 28 using xhci_hcd
2024-09-20 20:46:02,989 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:46:02,989 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:46:02,989 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:46:02,989 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:46:02,989 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0037/input/input89
2024-09-20 20:46:02,989 DEBUG:	asus 0003:0B05:1ABE.0037: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:46:02,989 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0038/input/input90
2024-09-20 20:46:02,989 DEBUG:	asus 0003:0B05:1ABE.0038: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:46:02,989 DEBUG:	asus 0003:0B05:1ABE.0039: Fixing up Asus N-Key report descriptor
2024-09-20 20:46:02,989 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0039/input/input91
2024-09-20 20:46:02,989 DEBUG:	asus 0003:0B05:1ABE.0039: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:46:02,989 DEBUG:	usb 1-2: new full-speed USB device number 29 using xhci_hcd
2024-09-20 20:46:02,990 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:46:02,990 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:46:02,990 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:46:02,990 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:46:02,990 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:46:02,990 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input92
2024-09-20 20:46:02,990 DEBUG:	input input92: unable to receive magic message: -32
2024-09-20 20:46:02,990 INFO:	○ Suspend count: 1
2024-09-20 20:46:02,990 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:46:02,990 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:46:02,990 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:46:02,990 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:46:02,990 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:46:02,990 INFO:	○ gpe10 increased from 65 to 67
2024-09-20 20:46:02,990 INFO:	✅ Userspace suspended for 0:02:04.990520
2024-09-20 20:46:02,990 DEBUG:	Kernel suspended for total of 0:01:58.807000 (95.05%)
2024-09-20 20:46:02,990 INFO:	✅ In a hardware sleep state for 0:01:58.249328 (94.61%)
2024-09-20 20:46:02,991 DEBUG:	BAT0 energy level is 20899000 µWh
2024-09-20 20:46:02,991 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 20:46:04,992 INFO:	Suspend cycle 6: Started at 2024-09-20 20:46:04.991923 (cycle finish expected @ 2024-09-20 20:48:08.991937)
2024-09-20 20:48:10,006 INFO:	Results from last s2idle cycle
2024-09-20 20:48:10,006 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:48:10,007 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 20:48:10,007 DEBUG:	Freezing user space processes
2024-09-20 20:48:10,007 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:48:10,007 DEBUG:	OOM killer disabled.
2024-09-20 20:48:10,007 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:48:10,007 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 20:48:10,007 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:48:10,007 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:48:10,007 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:48:10,007 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:48:10,007 DEBUG:	PM: suspend of devices complete after 334.853 msecs
2024-09-20 20:48:10,007 DEBUG:	PM: start suspend of devices complete after 335.302 msecs
2024-09-20 20:48:10,007 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:48:10,007 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:48:10,007 DEBUG:	PM: late suspend of devices complete after 1.239 msecs
2024-09-20 20:48:10,007 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:48:10,007 DEBUG:	PM: noirq suspend of devices complete after 93.170 msecs
2024-09-20 20:48:10,007 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:48:10,007 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:48:10,007 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:48:10,007 DEBUG:	PM: suspend-to-idle
2024-09-20 20:48:10,007 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:48:10,007 DEBUG:	Timekeeping suspended for 119.535 seconds
2024-09-20 20:48:10,007 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:48:10,007 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:48:10,007 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:48:10,007 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:48:10,007 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:48:10,007 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:48:10,007 DEBUG:	PM: noirq resume of devices complete after 168.286 msecs
2024-09-20 20:48:10,007 DEBUG:	PM: early resume of devices complete after 2.821 msecs
2024-09-20 20:48:10,007 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:48:10,007 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:48:10,007 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:48:10,007 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:48:10,007 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:48:10,008 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:48:10,008 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:48:10,008 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:48:10,008 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:48:10,008 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:48:10,008 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:48:10,008 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:48:10,008 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:48:10,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:48:10,008 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:48:10,008 DEBUG:	PM: resume of devices complete after 2804.012 msecs
2024-09-20 20:48:10,008 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:48:10,008 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:48:10,008 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:48:10,008 DEBUG:	OOM killer enabled.
2024-09-20 20:48:10,008 DEBUG:	Restarting tasks ... done.
2024-09-20 20:48:10,008 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:48:10,008 DEBUG:	usb 1-2: USB disconnect, device number 29
2024-09-20 20:48:10,008 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:48:10,008 DEBUG:	PM: suspend exit
2024-09-20 20:48:10,008 DEBUG:	usb 1-3: USB disconnect, device number 28
2024-09-20 20:48:10,009 DEBUG:	usb 1-3: new full-speed USB device number 30 using xhci_hcd
2024-09-20 20:48:10,009 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:48:10,009 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:48:10,009 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:48:10,009 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:48:10,009 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.003A/input/input93
2024-09-20 20:48:10,009 DEBUG:	asus 0003:0B05:1ABE.003A: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:48:10,009 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.003B/input/input94
2024-09-20 20:48:10,009 DEBUG:	asus 0003:0B05:1ABE.003B: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:48:10,009 DEBUG:	asus 0003:0B05:1ABE.003C: Fixing up Asus N-Key report descriptor
2024-09-20 20:48:10,009 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.003C/input/input95
2024-09-20 20:48:10,009 DEBUG:	asus 0003:0B05:1ABE.003C: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:48:10,009 DEBUG:	usb 1-2: new full-speed USB device number 31 using xhci_hcd
2024-09-20 20:48:10,009 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:48:10,009 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:48:10,009 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:48:10,009 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:48:10,009 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:48:10,009 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input96
2024-09-20 20:48:10,009 DEBUG:	input input96: unable to receive magic message: -32
2024-09-20 20:48:10,009 INFO:	○ Suspend count: 1
2024-09-20 20:48:10,009 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:48:10,009 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:48:10,009 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:48:10,009 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:48:10,009 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:48:10,009 INFO:	○ gpe10 increased from 67 to 69
2024-09-20 20:48:10,010 INFO:	✅ Userspace suspended for 0:02:05.018208
2024-09-20 20:48:10,010 DEBUG:	Kernel suspended for total of 0:01:59.535000 (95.61%)
2024-09-20 20:48:10,010 INFO:	✅ In a hardware sleep state for 0:01:58.976166 (95.17%)
2024-09-20 20:48:10,010 DEBUG:	BAT0 energy level is 20867000 µWh
2024-09-20 20:48:10,010 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 20:48:12,011 INFO:	Suspend cycle 7: Started at 2024-09-20 20:48:12.011189 (cycle finish expected @ 2024-09-20 20:50:16.011213)
2024-09-20 20:50:17,004 INFO:	Results from last s2idle cycle
2024-09-20 20:50:17,005 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:50:17,005 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 20:50:17,005 DEBUG:	Freezing user space processes
2024-09-20 20:50:17,005 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:50:17,005 DEBUG:	OOM killer disabled.
2024-09-20 20:50:17,005 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:50:17,005 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 20:50:17,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:50:17,005 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:50:17,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:50:17,005 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:50:17,005 DEBUG:	PM: suspend of devices complete after 349.231 msecs
2024-09-20 20:50:17,005 DEBUG:	PM: start suspend of devices complete after 349.675 msecs
2024-09-20 20:50:17,005 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:50:17,005 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:50:17,005 DEBUG:	PM: late suspend of devices complete after 0.978 msecs
2024-09-20 20:50:17,005 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:50:17,005 DEBUG:	PM: noirq suspend of devices complete after 108.888 msecs
2024-09-20 20:50:17,005 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:50:17,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:50:17,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:50:17,005 DEBUG:	PM: suspend-to-idle
2024-09-20 20:50:17,005 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:50:17,005 DEBUG:	Timekeeping suspended for 119.489 seconds
2024-09-20 20:50:17,005 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:50:17,005 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:50:17,005 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:50:17,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:50:17,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:50:17,005 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:50:17,005 DEBUG:	PM: noirq resume of devices complete after 162.754 msecs
2024-09-20 20:50:17,005 DEBUG:	PM: early resume of devices complete after 3.117 msecs
2024-09-20 20:50:17,005 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:50:17,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:50:17,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:50:17,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:50:17,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:50:17,006 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:50:17,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:50:17,006 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:50:17,006 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:50:17,006 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:50:17,006 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:50:17,006 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:50:17,006 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:50:17,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:50:17,006 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:50:17,006 DEBUG:	PM: resume of devices complete after 2804.841 msecs
2024-09-20 20:50:17,006 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:50:17,006 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:50:17,006 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:50:17,006 DEBUG:	OOM killer enabled.
2024-09-20 20:50:17,006 DEBUG:	Restarting tasks ... 
2024-09-20 20:50:17,006 DEBUG:	usb 1-2: USB disconnect, device number 31
2024-09-20 20:50:17,006 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:50:17,006 DEBUG:	done.
2024-09-20 20:50:17,006 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:50:17,006 DEBUG:	PM: suspend exit
2024-09-20 20:50:17,006 DEBUG:	usb 1-3: USB disconnect, device number 30
2024-09-20 20:50:17,007 DEBUG:	usb 1-3: new full-speed USB device number 32 using xhci_hcd
2024-09-20 20:50:17,007 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:50:17,007 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:50:17,007 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:50:17,007 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:50:17,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.003D/input/input97
2024-09-20 20:50:17,007 DEBUG:	asus 0003:0B05:1ABE.003D: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:50:17,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.003E/input/input98
2024-09-20 20:50:17,007 DEBUG:	asus 0003:0B05:1ABE.003E: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:50:17,007 DEBUG:	asus 0003:0B05:1ABE.003F: Fixing up Asus N-Key report descriptor
2024-09-20 20:50:17,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.003F/input/input99
2024-09-20 20:50:17,007 DEBUG:	asus 0003:0B05:1ABE.003F: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:50:17,007 DEBUG:	usb 1-2: new full-speed USB device number 33 using xhci_hcd
2024-09-20 20:50:17,007 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:50:17,007 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:50:17,007 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:50:17,007 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:50:17,007 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:50:17,007 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input100
2024-09-20 20:50:17,007 DEBUG:	input input100: unable to receive magic message: -32
2024-09-20 20:50:17,007 INFO:	○ Suspend count: 1
2024-09-20 20:50:17,007 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:50:17,007 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:50:17,007 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:50:17,007 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:50:17,007 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:50:17,008 INFO:	○ gpe10 increased from 69 to 71
2024-09-20 20:50:17,008 INFO:	✅ Userspace suspended for 0:02:04.997041
2024-09-20 20:50:17,008 DEBUG:	Kernel suspended for total of 0:01:59.489000 (95.59%)
2024-09-20 20:50:17,008 INFO:	✅ In a hardware sleep state for 0:01:58.924591 (95.14%)
2024-09-20 20:50:17,009 DEBUG:	BAT0 energy level is 20835000 µWh
2024-09-20 20:50:17,009 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 20:50:19,009 INFO:	Suspend cycle 8: Started at 2024-09-20 20:50:19.009453 (cycle finish expected @ 2024-09-20 20:52:23.009469)
2024-09-20 20:52:24,000 INFO:	Results from last s2idle cycle
2024-09-20 20:52:24,000 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:52:24,000 DEBUG:	Filesystems sync: 0.032 seconds
2024-09-20 20:52:24,001 DEBUG:	Freezing user space processes
2024-09-20 20:52:24,001 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:52:24,001 DEBUG:	OOM killer disabled.
2024-09-20 20:52:24,001 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:52:24,001 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 20:52:24,001 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:52:24,001 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:52:24,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:52:24,001 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:52:24,001 DEBUG:	PM: suspend of devices complete after 340.858 msecs
2024-09-20 20:52:24,001 DEBUG:	PM: start suspend of devices complete after 341.609 msecs
2024-09-20 20:52:24,001 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:52:24,001 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:52:24,001 DEBUG:	PM: late suspend of devices complete after 1.015 msecs
2024-09-20 20:52:24,001 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:52:24,001 DEBUG:	PM: noirq suspend of devices complete after 113.818 msecs
2024-09-20 20:52:24,001 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:52:24,001 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:52:24,001 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:52:24,001 DEBUG:	PM: suspend-to-idle
2024-09-20 20:52:24,001 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:52:24,001 DEBUG:	Timekeeping suspended for 119.495 seconds
2024-09-20 20:52:24,001 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:52:24,001 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:52:24,001 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:52:24,001 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:52:24,001 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:52:24,001 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:52:24,001 DEBUG:	PM: noirq resume of devices complete after 164.660 msecs
2024-09-20 20:52:24,001 DEBUG:	PM: early resume of devices complete after 3.115 msecs
2024-09-20 20:52:24,001 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:52:24,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:52:24,002 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:52:24,002 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:52:24,002 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:52:24,002 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:52:24,003 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:52:24,003 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:52:24,003 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:52:24,003 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:52:24,003 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:52:24,003 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:52:24,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:52:24,004 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:52:24,004 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:52:24,004 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:52:24,004 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:52:24,004 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:52:24,004 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:52:24,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:52:24,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:52:24,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:52:24,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:52:24,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:52:24,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:52:24,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:52:24,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:52:24,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:52:24,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:52:24,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:52:24,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:52:24,005 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:52:24,005 DEBUG:	PM: resume of devices complete after 2806.009 msecs
2024-09-20 20:52:24,005 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:52:24,005 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:52:24,005 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:52:24,005 DEBUG:	OOM killer enabled.
2024-09-20 20:52:24,005 DEBUG:	Restarting tasks ... 
2024-09-20 20:52:24,005 DEBUG:	usb 1-2: USB disconnect, device number 33
2024-09-20 20:52:24,005 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:52:24,005 DEBUG:	done.
2024-09-20 20:52:24,005 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:52:24,005 DEBUG:	PM: suspend exit
2024-09-20 20:52:24,005 DEBUG:	usb 1-3: USB disconnect, device number 32
2024-09-20 20:52:24,005 DEBUG:	usb 1-3: new full-speed USB device number 34 using xhci_hcd
2024-09-20 20:52:24,005 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:52:24,005 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:52:24,005 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:52:24,005 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:52:24,005 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0040/input/input101
2024-09-20 20:52:24,005 DEBUG:	asus 0003:0B05:1ABE.0040: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:52:24,005 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0041/input/input102
2024-09-20 20:52:24,005 DEBUG:	asus 0003:0B05:1ABE.0041: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:52:24,005 DEBUG:	asus 0003:0B05:1ABE.0042: Fixing up Asus N-Key report descriptor
2024-09-20 20:52:24,005 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0042/input/input103
2024-09-20 20:52:24,005 DEBUG:	asus 0003:0B05:1ABE.0042: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:52:24,005 DEBUG:	usb 1-2: new full-speed USB device number 35 using xhci_hcd
2024-09-20 20:52:24,005 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:52:24,005 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:52:24,005 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:52:24,005 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:52:24,005 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:52:24,005 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input104
2024-09-20 20:52:24,005 DEBUG:	input input104: unable to receive magic message: -32
2024-09-20 20:52:24,005 INFO:	○ Suspend count: 1
2024-09-20 20:52:24,005 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:52:24,005 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:52:24,005 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:52:24,005 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:52:24,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:52:24,006 INFO:	○ gpe10 increased from 71 to 73
2024-09-20 20:52:24,006 INFO:	✅ Userspace suspended for 0:02:04.997131
2024-09-20 20:52:24,006 DEBUG:	Kernel suspended for total of 0:01:59.495000 (95.60%)
2024-09-20 20:52:24,006 INFO:	✅ In a hardware sleep state for 0:01:58.929077 (95.15%)
2024-09-20 20:52:24,007 DEBUG:	BAT0 energy level is 20787000 µWh
2024-09-20 20:52:24,007 INFO:	🔋 Battery BAT0 lost 48000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 20:52:26,007 INFO:	Suspend cycle 9: Started at 2024-09-20 20:52:26.007679 (cycle finish expected @ 2024-09-20 20:54:30.007705)
2024-09-20 20:54:31,005 INFO:	Results from last s2idle cycle
2024-09-20 20:54:31,005 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:54:31,005 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 20:54:31,005 DEBUG:	Freezing user space processes
2024-09-20 20:54:31,005 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:54:31,005 DEBUG:	OOM killer disabled.
2024-09-20 20:54:31,005 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:54:31,005 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 20:54:31,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:54:31,005 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:54:31,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:54:31,005 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:54:31,005 DEBUG:	PM: suspend of devices complete after 342.985 msecs
2024-09-20 20:54:31,005 DEBUG:	PM: start suspend of devices complete after 343.739 msecs
2024-09-20 20:54:31,005 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:54:31,005 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:54:31,005 DEBUG:	PM: late suspend of devices complete after 0.929 msecs
2024-09-20 20:54:31,005 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:54:31,005 DEBUG:	PM: noirq suspend of devices complete after 103.909 msecs
2024-09-20 20:54:31,005 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:54:31,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:54:31,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:54:31,005 DEBUG:	PM: suspend-to-idle
2024-09-20 20:54:31,005 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:54:31,006 DEBUG:	Timekeeping suspended for 119.503 seconds
2024-09-20 20:54:31,006 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:54:31,006 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:54:31,006 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:54:31,006 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:54:31,006 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:54:31,006 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:54:31,006 DEBUG:	PM: noirq resume of devices complete after 163.486 msecs
2024-09-20 20:54:31,006 DEBUG:	PM: early resume of devices complete after 2.997 msecs
2024-09-20 20:54:31,006 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:54:31,006 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:54:31,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:54:31,006 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:54:31,006 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:54:31,006 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:54:31,006 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:54:31,006 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:54:31,006 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:54:31,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:54:31,007 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:54:31,007 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:54:31,007 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:54:31,007 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:54:31,007 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:54:31,007 DEBUG:	PM: resume of devices complete after 2802.753 msecs
2024-09-20 20:54:31,007 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:54:31,007 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:54:31,007 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:54:31,007 DEBUG:	OOM killer enabled.
2024-09-20 20:54:31,007 DEBUG:	Restarting tasks ... done.
2024-09-20 20:54:31,007 DEBUG:	usb 1-2: USB disconnect, device number 35
2024-09-20 20:54:31,007 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:54:31,007 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:54:31,007 DEBUG:	PM: suspend exit
2024-09-20 20:54:31,007 DEBUG:	usb 1-3: USB disconnect, device number 34
2024-09-20 20:54:31,007 DEBUG:	usb 1-3: new full-speed USB device number 36 using xhci_hcd
2024-09-20 20:54:31,007 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:54:31,007 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:54:31,007 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:54:31,007 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:54:31,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0043/input/input105
2024-09-20 20:54:31,007 DEBUG:	asus 0003:0B05:1ABE.0043: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:54:31,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0044/input/input106
2024-09-20 20:54:31,007 DEBUG:	asus 0003:0B05:1ABE.0044: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:54:31,007 DEBUG:	asus 0003:0B05:1ABE.0045: Fixing up Asus N-Key report descriptor
2024-09-20 20:54:31,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0045/input/input107
2024-09-20 20:54:31,007 DEBUG:	asus 0003:0B05:1ABE.0045: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:54:31,007 DEBUG:	usb 1-2: new full-speed USB device number 37 using xhci_hcd
2024-09-20 20:54:31,007 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:54:31,007 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:54:31,007 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:54:31,007 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:54:31,007 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:54:31,007 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input108
2024-09-20 20:54:31,007 DEBUG:	input input108: unable to receive magic message: -32
2024-09-20 20:54:31,007 INFO:	○ Suspend count: 1
2024-09-20 20:54:31,007 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:54:31,007 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:54:31,007 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:54:31,007 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:54:31,007 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:54:31,008 INFO:	○ gpe10 increased from 73 to 75
2024-09-20 20:54:31,008 INFO:	✅ Userspace suspended for 0:02:05.000799
2024-09-20 20:54:31,008 DEBUG:	Kernel suspended for total of 0:01:59.503000 (95.60%)
2024-09-20 20:54:31,008 INFO:	✅ In a hardware sleep state for 0:01:58.939728 (95.15%)
2024-09-20 20:54:31,011 DEBUG:	BAT0 energy level is 20771000 µWh
2024-09-20 20:54:31,011 INFO:	🔋 Battery BAT0 lost 16000 µWh (0.05%) [Average rate 0.05W]
2024-09-20 20:54:33,011 INFO:	Suspend cycle 10: Started at 2024-09-20 20:54:33.011575 (cycle finish expected @ 2024-09-20 20:56:37.011593)
2024-09-20 20:56:37,992 INFO:	Results from last s2idle cycle
2024-09-20 20:56:37,992 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:56:37,992 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 20:56:37,992 DEBUG:	Freezing user space processes
2024-09-20 20:56:37,992 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:56:37,993 DEBUG:	OOM killer disabled.
2024-09-20 20:56:37,993 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:56:37,993 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 20:56:37,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:56:37,993 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:56:37,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:56:37,993 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:56:37,993 DEBUG:	PM: suspend of devices complete after 343.471 msecs
2024-09-20 20:56:37,993 DEBUG:	PM: start suspend of devices complete after 344.237 msecs
2024-09-20 20:56:37,993 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:56:37,993 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:56:37,993 DEBUG:	PM: late suspend of devices complete after 0.852 msecs
2024-09-20 20:56:37,994 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:56:37,994 DEBUG:	PM: noirq suspend of devices complete after 84.920 msecs
2024-09-20 20:56:37,994 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:56:37,994 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:56:37,994 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:56:37,994 DEBUG:	PM: suspend-to-idle
2024-09-20 20:56:37,994 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:56:37,994 DEBUG:	Timekeeping suspended for 119.518 seconds
2024-09-20 20:56:37,994 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:56:37,994 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:56:37,994 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:56:37,994 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:56:37,994 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:56:37,994 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:56:37,994 DEBUG:	PM: noirq resume of devices complete after 165.451 msecs
2024-09-20 20:56:37,995 DEBUG:	PM: early resume of devices complete after 3.041 msecs
2024-09-20 20:56:37,995 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:56:37,995 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:56:37,996 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:56:37,996 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:56:37,996 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:56:37,997 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:56:37,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:56:37,997 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:56:37,997 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:56:37,997 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:56:37,997 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:56:37,997 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:56:37,997 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:56:37,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:56:37,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:56:37,998 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:56:37,998 DEBUG:	PM: resume of devices complete after 2805.424 msecs
2024-09-20 20:56:37,998 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:56:37,998 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:56:37,998 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:56:37,998 DEBUG:	OOM killer enabled.
2024-09-20 20:56:37,998 DEBUG:	Restarting tasks ... 
2024-09-20 20:56:37,998 DEBUG:	usb 1-2: USB disconnect, device number 37
2024-09-20 20:56:37,998 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:56:37,998 DEBUG:	done.
2024-09-20 20:56:37,998 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:56:37,998 DEBUG:	PM: suspend exit
2024-09-20 20:56:37,998 DEBUG:	usb 1-3: USB disconnect, device number 36
2024-09-20 20:56:37,998 DEBUG:	usb 1-3: new full-speed USB device number 38 using xhci_hcd
2024-09-20 20:56:37,998 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:56:37,998 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:56:37,998 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:56:37,998 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:56:37,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0046/input/input109
2024-09-20 20:56:37,998 DEBUG:	asus 0003:0B05:1ABE.0046: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:56:37,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0047/input/input110
2024-09-20 20:56:37,998 DEBUG:	asus 0003:0B05:1ABE.0047: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:56:37,998 DEBUG:	asus 0003:0B05:1ABE.0048: Fixing up Asus N-Key report descriptor
2024-09-20 20:56:37,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0048/input/input111
2024-09-20 20:56:37,998 DEBUG:	asus 0003:0B05:1ABE.0048: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:56:37,998 DEBUG:	usb 1-2: new full-speed USB device number 39 using xhci_hcd
2024-09-20 20:56:37,998 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:56:37,998 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:56:37,998 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:56:37,998 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:56:37,998 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:56:37,998 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input112
2024-09-20 20:56:37,998 DEBUG:	input input112: unable to receive magic message: -32
2024-09-20 20:56:37,998 INFO:	○ Suspend count: 1
2024-09-20 20:56:37,998 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:56:37,998 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:56:37,998 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:56:37,998 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:56:37,999 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:56:37,999 INFO:	○ gpe10 increased from 75 to 77
2024-09-20 20:56:37,999 INFO:	✅ Userspace suspended for 0:02:04.988037
2024-09-20 20:56:37,999 DEBUG:	Kernel suspended for total of 0:01:59.518000 (95.62%)
2024-09-20 20:56:37,999 INFO:	✅ In a hardware sleep state for 0:01:58.962158 (95.18%)
2024-09-20 20:56:38,001 DEBUG:	BAT0 energy level is 20724000 µWh
2024-09-20 20:56:38,001 INFO:	🔋 Battery BAT0 lost 47000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 20:56:40,002 INFO:	Suspend cycle 11: Started at 2024-09-20 20:56:40.002065 (cycle finish expected @ 2024-09-20 20:58:44.002083)
2024-09-20 20:58:45,005 INFO:	Results from last s2idle cycle
2024-09-20 20:58:45,005 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 20:58:45,006 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 20:58:45,006 DEBUG:	Freezing user space processes
2024-09-20 20:58:45,006 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 20:58:45,006 DEBUG:	OOM killer disabled.
2024-09-20 20:58:45,006 DEBUG:	Freezing remaining freezable tasks
2024-09-20 20:58:45,006 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 20:58:45,006 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 20:58:45,006 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 20:58:45,007 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 20:58:45,007 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 20:58:45,007 DEBUG:	PM: suspend of devices complete after 341.831 msecs
2024-09-20 20:58:45,007 DEBUG:	PM: start suspend of devices complete after 342.690 msecs
2024-09-20 20:58:45,007 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 20:58:45,007 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 20:58:45,007 DEBUG:	PM: late suspend of devices complete after 0.888 msecs
2024-09-20 20:58:45,007 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 20:58:45,008 DEBUG:	PM: noirq suspend of devices complete after 101.563 msecs
2024-09-20 20:58:45,008 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 20:58:45,008 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 20:58:45,008 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 20:58:45,008 DEBUG:	PM: suspend-to-idle
2024-09-20 20:58:45,008 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 20:58:45,009 DEBUG:	Timekeeping suspended for 119.513 seconds
2024-09-20 20:58:45,009 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 20:58:45,009 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 20:58:45,009 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 20:58:45,010 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 20:58:45,010 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 20:58:45,010 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 20:58:45,010 DEBUG:	PM: noirq resume of devices complete after 162.660 msecs
2024-09-20 20:58:45,010 DEBUG:	PM: early resume of devices complete after 2.778 msecs
2024-09-20 20:58:45,010 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 20:58:45,010 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:58:45,010 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:58:45,010 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 20:58:45,010 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 20:58:45,011 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 20:58:45,011 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 20:58:45,011 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 20:58:45,011 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 20:58:45,011 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 20:58:45,011 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 20:58:45,011 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 20:58:45,011 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:58:45,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 20:58:45,011 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:58:45,011 DEBUG:	PM: resume of devices complete after 2807.505 msecs
2024-09-20 20:58:45,011 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 20:58:45,011 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 20:58:45,011 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 20:58:45,011 DEBUG:	OOM killer enabled.
2024-09-20 20:58:45,011 DEBUG:	Restarting tasks ... 
2024-09-20 20:58:45,011 DEBUG:	usb 1-2: USB disconnect, device number 39
2024-09-20 20:58:45,011 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 20:58:45,011 DEBUG:	done.
2024-09-20 20:58:45,011 DEBUG:	random: crng reseeded on system resumption
2024-09-20 20:58:45,011 DEBUG:	PM: suspend exit
2024-09-20 20:58:45,011 DEBUG:	usb 1-3: USB disconnect, device number 38
2024-09-20 20:58:45,011 DEBUG:	usb 1-3: new full-speed USB device number 40 using xhci_hcd
2024-09-20 20:58:45,011 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 20:58:45,011 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 20:58:45,011 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 20:58:45,011 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 20:58:45,011 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0049/input/input113
2024-09-20 20:58:45,011 DEBUG:	asus 0003:0B05:1ABE.0049: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 20:58:45,011 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.004A/input/input114
2024-09-20 20:58:45,011 DEBUG:	asus 0003:0B05:1ABE.004A: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 20:58:45,011 DEBUG:	asus 0003:0B05:1ABE.004B: Fixing up Asus N-Key report descriptor
2024-09-20 20:58:45,011 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.004B/input/input115
2024-09-20 20:58:45,011 DEBUG:	asus 0003:0B05:1ABE.004B: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 20:58:45,011 DEBUG:	usb 1-2: new full-speed USB device number 41 using xhci_hcd
2024-09-20 20:58:45,011 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 20:58:45,012 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 20:58:45,012 DEBUG:	usb 1-2: Product: Controller
2024-09-20 20:58:45,012 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 20:58:45,012 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 20:58:45,012 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input116
2024-09-20 20:58:45,012 DEBUG:	input input116: unable to receive magic message: -32
2024-09-20 20:58:45,012 DEBUG:	input input116: unable to receive magic message: -32
2024-09-20 20:58:45,012 INFO:	○ Suspend count: 1
2024-09-20 20:58:45,012 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 20:58:45,012 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 20:58:45,012 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 20:58:45,012 ERROR:	❌ ACPI BIOS errors found
2024-09-20 20:58:45,012 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 20:58:45,012 INFO:	○ gpe10 increased from 77 to 79
2024-09-20 20:58:45,012 INFO:	✅ Userspace suspended for 0:02:05.010767
2024-09-20 20:58:45,012 DEBUG:	Kernel suspended for total of 0:01:59.513000 (95.60%)
2024-09-20 20:58:45,012 INFO:	✅ In a hardware sleep state for 0:01:58.950927 (95.15%)
2024-09-20 20:58:45,013 DEBUG:	BAT0 energy level is 20676000 µWh
2024-09-20 20:58:45,013 INFO:	🔋 Battery BAT0 lost 48000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 20:58:47,014 INFO:	Suspend cycle 12: Started at 2024-09-20 20:58:47.014044 (cycle finish expected @ 2024-09-20 21:00:51.014068)
2024-09-20 21:00:51,996 INFO:	Results from last s2idle cycle
2024-09-20 21:00:51,996 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:00:51,996 DEBUG:	Filesystems sync: 0.032 seconds
2024-09-20 21:00:51,996 DEBUG:	Freezing user space processes
2024-09-20 21:00:51,997 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:00:51,997 DEBUG:	OOM killer disabled.
2024-09-20 21:00:51,997 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:00:51,997 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:00:51,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:00:51,997 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:00:51,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:00:51,997 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:00:51,997 DEBUG:	PM: suspend of devices complete after 343.925 msecs
2024-09-20 21:00:51,997 DEBUG:	PM: start suspend of devices complete after 344.795 msecs
2024-09-20 21:00:51,997 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:00:51,997 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:00:51,997 DEBUG:	PM: late suspend of devices complete after 1.167 msecs
2024-09-20 21:00:51,997 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:00:51,997 DEBUG:	PM: noirq suspend of devices complete after 113.457 msecs
2024-09-20 21:00:51,997 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:00:51,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:00:51,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:00:51,997 DEBUG:	PM: suspend-to-idle
2024-09-20 21:00:51,997 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:00:51,997 DEBUG:	Timekeeping suspended for 119.486 seconds
2024-09-20 21:00:51,997 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:00:51,997 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:00:51,997 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:00:51,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:00:51,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:00:51,997 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:00:51,997 DEBUG:	PM: noirq resume of devices complete after 165.892 msecs
2024-09-20 21:00:51,997 DEBUG:	PM: early resume of devices complete after 3.016 msecs
2024-09-20 21:00:51,998 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:00:51,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:00:51,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:00:51,998 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:00:51,998 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:00:51,998 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:00:51,999 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:00:51,999 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:00:51,999 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:00:51,999 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:00:52,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:00:52,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:00:52,000 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:00:52,000 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:00:52,000 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:00:52,000 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:00:52,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:00:52,001 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:00:52,001 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:00:52,001 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:00:52,001 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:00:52,001 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:00:52,001 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:00:52,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:00:52,001 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:00:52,001 DEBUG:	PM: resume of devices complete after 2809.503 msecs
2024-09-20 21:00:52,001 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:00:52,001 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:00:52,001 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:00:52,001 DEBUG:	OOM killer enabled.
2024-09-20 21:00:52,001 DEBUG:	Restarting tasks ... 
2024-09-20 21:00:52,001 DEBUG:	usb 1-2: USB disconnect, device number 41
2024-09-20 21:00:52,002 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:00:52,002 DEBUG:	done.
2024-09-20 21:00:52,002 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:00:52,002 DEBUG:	PM: suspend exit
2024-09-20 21:00:52,002 DEBUG:	usb 1-3: USB disconnect, device number 40
2024-09-20 21:00:52,002 DEBUG:	usb 1-3: new full-speed USB device number 42 using xhci_hcd
2024-09-20 21:00:52,002 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:00:52,002 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:00:52,002 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:00:52,002 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:00:52,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.004C/input/input117
2024-09-20 21:00:52,002 DEBUG:	asus 0003:0B05:1ABE.004C: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:00:52,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.004D/input/input118
2024-09-20 21:00:52,002 DEBUG:	asus 0003:0B05:1ABE.004D: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:00:52,002 DEBUG:	asus 0003:0B05:1ABE.004E: Fixing up Asus N-Key report descriptor
2024-09-20 21:00:52,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.004E/input/input119
2024-09-20 21:00:52,002 DEBUG:	asus 0003:0B05:1ABE.004E: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:00:52,002 DEBUG:	usb 1-2: new full-speed USB device number 43 using xhci_hcd
2024-09-20 21:00:52,002 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:00:52,002 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:00:52,002 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:00:52,002 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:00:52,002 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:00:52,002 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input120
2024-09-20 21:00:52,002 DEBUG:	input input120: unable to receive magic message: -32
2024-09-20 21:00:52,002 INFO:	○ Suspend count: 1
2024-09-20 21:00:52,002 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:00:52,002 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:00:52,002 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:00:52,002 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:00:52,002 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:00:52,003 INFO:	○ gpe10 increased from 79 to 81
2024-09-20 21:00:52,003 INFO:	✅ Userspace suspended for 0:02:04.989212
2024-09-20 21:00:52,003 DEBUG:	Kernel suspended for total of 0:01:59.486000 (95.60%)
2024-09-20 21:00:52,003 INFO:	✅ In a hardware sleep state for 0:01:58.925995 (95.15%)
2024-09-20 21:00:52,006 DEBUG:	BAT0 energy level is 20644000 µWh
2024-09-20 21:00:52,007 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:00:54,007 INFO:	Suspend cycle 13: Started at 2024-09-20 21:00:54.007482 (cycle finish expected @ 2024-09-20 21:02:58.007497)
2024-09-20 21:02:59,001 INFO:	Results from last s2idle cycle
2024-09-20 21:02:59,001 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:02:59,001 DEBUG:	Filesystems sync: 0.032 seconds
2024-09-20 21:02:59,001 DEBUG:	Freezing user space processes
2024-09-20 21:02:59,001 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:02:59,001 DEBUG:	OOM killer disabled.
2024-09-20 21:02:59,001 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:02:59,001 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:02:59,001 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:02:59,001 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:02:59,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:02:59,001 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:02:59,001 DEBUG:	PM: suspend of devices complete after 347.839 msecs
2024-09-20 21:02:59,001 DEBUG:	PM: start suspend of devices complete after 348.393 msecs
2024-09-20 21:02:59,001 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:02:59,001 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:02:59,001 DEBUG:	PM: late suspend of devices complete after 0.864 msecs
2024-09-20 21:02:59,002 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:02:59,002 DEBUG:	PM: noirq suspend of devices complete after 106.107 msecs
2024-09-20 21:02:59,002 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:02:59,002 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:02:59,002 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:02:59,002 DEBUG:	PM: suspend-to-idle
2024-09-20 21:02:59,002 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:02:59,002 DEBUG:	Timekeeping suspended for 119.497 seconds
2024-09-20 21:02:59,002 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:02:59,002 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:02:59,002 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:02:59,002 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:02:59,002 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:02:59,002 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:02:59,002 DEBUG:	PM: noirq resume of devices complete after 162.305 msecs
2024-09-20 21:02:59,002 DEBUG:	PM: early resume of devices complete after 2.961 msecs
2024-09-20 21:02:59,002 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:02:59,002 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:02:59,002 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:02:59,002 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:02:59,002 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:02:59,003 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:02:59,003 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:02:59,003 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:02:59,003 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:02:59,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:02:59,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:02:59,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:02:59,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:02:59,004 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:02:59,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:02:59,005 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:02:59,005 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:02:59,005 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:02:59,005 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:02:59,005 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:02:59,005 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:02:59,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:02:59,005 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:02:59,005 DEBUG:	PM: resume of devices complete after 2802.624 msecs
2024-09-20 21:02:59,006 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:02:59,006 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:02:59,006 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:02:59,006 DEBUG:	OOM killer enabled.
2024-09-20 21:02:59,006 DEBUG:	Restarting tasks ... done.
2024-09-20 21:02:59,006 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:02:59,006 DEBUG:	usb 1-2: USB disconnect, device number 43
2024-09-20 21:02:59,006 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:02:59,006 DEBUG:	PM: suspend exit
2024-09-20 21:02:59,006 DEBUG:	usb 1-3: USB disconnect, device number 42
2024-09-20 21:02:59,006 DEBUG:	usb 1-3: new full-speed USB device number 44 using xhci_hcd
2024-09-20 21:02:59,006 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:02:59,006 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:02:59,006 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:02:59,006 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:02:59,006 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.004F/input/input121
2024-09-20 21:02:59,006 DEBUG:	asus 0003:0B05:1ABE.004F: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:02:59,006 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0050/input/input122
2024-09-20 21:02:59,006 DEBUG:	asus 0003:0B05:1ABE.0050: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:02:59,006 DEBUG:	asus 0003:0B05:1ABE.0051: Fixing up Asus N-Key report descriptor
2024-09-20 21:02:59,006 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0051/input/input123
2024-09-20 21:02:59,006 DEBUG:	asus 0003:0B05:1ABE.0051: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:02:59,006 DEBUG:	usb 1-2: new full-speed USB device number 45 using xhci_hcd
2024-09-20 21:02:59,006 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:02:59,006 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:02:59,006 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:02:59,006 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:02:59,006 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:02:59,006 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input124
2024-09-20 21:02:59,006 DEBUG:	input input124: unable to receive magic message: -32
2024-09-20 21:02:59,006 INFO:	○ Suspend count: 1
2024-09-20 21:02:59,006 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:02:59,006 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:02:59,006 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:02:59,006 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:02:59,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:02:59,007 INFO:	○ gpe10 increased from 81 to 83
2024-09-20 21:02:59,007 INFO:	✅ Userspace suspended for 0:02:05.000091
2024-09-20 21:02:59,007 DEBUG:	Kernel suspended for total of 0:01:59.497000 (95.60%)
2024-09-20 21:02:59,007 INFO:	✅ In a hardware sleep state for 0:01:58.936157 (95.15%)
2024-09-20 21:02:59,008 DEBUG:	BAT0 energy level is 20612000 µWh
2024-09-20 21:02:59,008 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:03:01,008 INFO:	Suspend cycle 14: Started at 2024-09-20 21:03:01.008760 (cycle finish expected @ 2024-09-20 21:05:05.008775)
2024-09-20 21:05:05,987 INFO:	Results from last s2idle cycle
2024-09-20 21:05:05,988 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:05:05,988 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 21:05:05,988 DEBUG:	Freezing user space processes
2024-09-20 21:05:05,988 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:05:05,988 DEBUG:	OOM killer disabled.
2024-09-20 21:05:05,988 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:05:05,988 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:05:05,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:05:05,988 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:05:05,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:05:05,989 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:05:05,989 DEBUG:	PM: suspend of devices complete after 344.236 msecs
2024-09-20 21:05:05,989 DEBUG:	PM: start suspend of devices complete after 344.993 msecs
2024-09-20 21:05:05,990 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:05:05,990 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:05:05,990 DEBUG:	PM: late suspend of devices complete after 0.910 msecs
2024-09-20 21:05:05,991 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:05:05,991 DEBUG:	PM: noirq suspend of devices complete after 90.164 msecs
2024-09-20 21:05:05,991 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:05:05,991 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:05:05,991 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:05:05,991 DEBUG:	PM: suspend-to-idle
2024-09-20 21:05:05,991 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:05:05,991 DEBUG:	Timekeeping suspended for 119.514 seconds
2024-09-20 21:05:05,991 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:05:05,992 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:05:05,992 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:05:05,992 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:05:05,992 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:05:05,992 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:05:05,992 DEBUG:	PM: noirq resume of devices complete after 162.761 msecs
2024-09-20 21:05:05,992 DEBUG:	PM: early resume of devices complete after 3.168 msecs
2024-09-20 21:05:05,992 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:05:05,992 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:05:05,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:05:05,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:05:05,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:05:05,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:05:05,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:05:05,992 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:05:05,992 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:05:05,992 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:05:05,993 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:05:05,993 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:05:05,993 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:05:05,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:05:05,993 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:05:05,993 DEBUG:	PM: resume of devices complete after 2805.148 msecs
2024-09-20 21:05:05,993 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:05:05,993 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:05:05,993 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:05:05,993 DEBUG:	OOM killer enabled.
2024-09-20 21:05:05,993 DEBUG:	Restarting tasks ... 
2024-09-20 21:05:05,993 DEBUG:	usb 1-2: USB disconnect, device number 45
2024-09-20 21:05:05,993 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:05:05,993 DEBUG:	done.
2024-09-20 21:05:05,993 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:05:05,993 DEBUG:	PM: suspend exit
2024-09-20 21:05:05,993 DEBUG:	usb 1-3: USB disconnect, device number 44
2024-09-20 21:05:05,993 DEBUG:	usb 1-3: new full-speed USB device number 46 using xhci_hcd
2024-09-20 21:05:05,993 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:05:05,993 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:05:05,993 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:05:05,993 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:05:05,993 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0052/input/input125
2024-09-20 21:05:05,993 DEBUG:	asus 0003:0B05:1ABE.0052: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:05:05,993 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0053/input/input126
2024-09-20 21:05:05,993 DEBUG:	asus 0003:0B05:1ABE.0053: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:05:05,993 DEBUG:	asus 0003:0B05:1ABE.0054: Fixing up Asus N-Key report descriptor
2024-09-20 21:05:05,993 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0054/input/input127
2024-09-20 21:05:05,993 DEBUG:	asus 0003:0B05:1ABE.0054: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:05:05,993 DEBUG:	usb 1-2: new full-speed USB device number 47 using xhci_hcd
2024-09-20 21:05:05,993 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:05:05,993 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:05:05,993 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:05:05,993 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:05:05,993 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:05:05,994 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input128
2024-09-20 21:05:05,994 DEBUG:	input input128: unable to receive magic message: -32
2024-09-20 21:05:05,994 INFO:	○ Suspend count: 1
2024-09-20 21:05:05,994 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:05:05,994 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:05:05,994 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:05:05,994 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:05:05,994 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:05:05,994 INFO:	○ gpe10 increased from 83 to 85
2024-09-20 21:05:05,994 INFO:	✅ Userspace suspended for 0:02:04.986110
2024-09-20 21:05:05,994 DEBUG:	Kernel suspended for total of 0:01:59.514000 (95.62%)
2024-09-20 21:05:05,994 INFO:	✅ In a hardware sleep state for 0:01:58.950134 (95.17%)
2024-09-20 21:05:05,997 DEBUG:	BAT0 energy level is 20581000 µWh
2024-09-20 21:05:05,997 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 21:05:07,998 INFO:	Suspend cycle 15: Started at 2024-09-20 21:05:07.998143 (cycle finish expected @ 2024-09-20 21:07:11.998165)
2024-09-20 21:07:13,001 INFO:	Results from last s2idle cycle
2024-09-20 21:07:13,002 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:07:13,002 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 21:07:13,002 DEBUG:	Freezing user space processes
2024-09-20 21:07:13,002 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:07:13,002 DEBUG:	OOM killer disabled.
2024-09-20 21:07:13,002 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:07:13,002 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 21:07:13,002 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:07:13,003 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:07:13,003 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:07:13,003 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:07:13,003 DEBUG:	PM: suspend of devices complete after 956.287 msecs
2024-09-20 21:07:13,003 DEBUG:	PM: start suspend of devices complete after 956.752 msecs
2024-09-20 21:07:13,003 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:07:13,003 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:07:13,003 DEBUG:	PM: late suspend of devices complete after 0.959 msecs
2024-09-20 21:07:13,003 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:07:13,003 DEBUG:	clocksource: timekeeping watchdog on CPU12: hpet wd-wd read-back delay of 379936ns
2024-09-20 21:07:13,003 DEBUG:	clocksource: wd-tsc-wd read-back delay of 3622527ns, clock-skew test skipped!
2024-09-20 21:07:13,003 DEBUG:	PM: noirq suspend of devices complete after 99.736 msecs
2024-09-20 21:07:13,003 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:07:13,003 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:07:13,003 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:07:13,003 DEBUG:	PM: suspend-to-idle
2024-09-20 21:07:13,003 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:07:13,003 DEBUG:	Timekeeping suspended for 118.901 seconds
2024-09-20 21:07:13,003 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:07:13,003 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:07:13,003 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:07:13,003 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:07:13,003 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:07:13,003 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:07:13,003 DEBUG:	PM: noirq resume of devices complete after 164.756 msecs
2024-09-20 21:07:13,003 DEBUG:	PM: early resume of devices complete after 3.175 msecs
2024-09-20 21:07:13,003 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:07:13,003 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:07:13,003 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:07:13,003 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:07:13,004 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:07:13,004 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:07:13,004 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:07:13,004 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:07:13,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:07:13,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:07:13,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:07:13,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:07:13,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:07:13,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:07:13,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:07:13,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:07:13,006 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:07:13,006 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:07:13,006 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:07:13,006 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:07:13,006 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:07:13,006 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:07:13,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:07:13,006 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:07:13,006 DEBUG:	PM: resume of devices complete after 2805.795 msecs
2024-09-20 21:07:13,007 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:07:13,007 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:07:13,007 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:07:13,007 DEBUG:	OOM killer enabled.
2024-09-20 21:07:13,007 DEBUG:	Restarting tasks ... 
2024-09-20 21:07:13,007 DEBUG:	usb 1-2: USB disconnect, device number 47
2024-09-20 21:07:13,007 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:07:13,007 DEBUG:	done.
2024-09-20 21:07:13,007 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:07:13,007 DEBUG:	PM: suspend exit
2024-09-20 21:07:13,007 DEBUG:	usb 1-3: USB disconnect, device number 46
2024-09-20 21:07:13,007 DEBUG:	usb 1-3: new full-speed USB device number 48 using xhci_hcd
2024-09-20 21:07:13,007 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:07:13,007 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:07:13,007 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:07:13,007 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:07:13,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0055/input/input129
2024-09-20 21:07:13,007 DEBUG:	asus 0003:0B05:1ABE.0055: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:07:13,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0056/input/input130
2024-09-20 21:07:13,007 DEBUG:	asus 0003:0B05:1ABE.0056: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:07:13,007 DEBUG:	asus 0003:0B05:1ABE.0057: Fixing up Asus N-Key report descriptor
2024-09-20 21:07:13,007 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0057/input/input131
2024-09-20 21:07:13,007 DEBUG:	asus 0003:0B05:1ABE.0057: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:07:13,007 DEBUG:	usb 1-2: new full-speed USB device number 49 using xhci_hcd
2024-09-20 21:07:13,007 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:07:13,007 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:07:13,007 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:07:13,007 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:07:13,007 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:07:13,007 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input132
2024-09-20 21:07:13,007 DEBUG:	input input132: unable to receive magic message: -32
2024-09-20 21:07:13,007 DEBUG:	input input132: unable to receive magic message: -32
2024-09-20 21:07:13,007 INFO:	○ Suspend count: 1
2024-09-20 21:07:13,007 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:07:13,007 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:07:13,007 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:07:13,007 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:07:13,007 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:07:13,008 INFO:	○ gpe10 increased from 85 to 87
2024-09-20 21:07:13,008 INFO:	✅ Userspace suspended for 0:02:05.010253
2024-09-20 21:07:13,008 DEBUG:	Kernel suspended for total of 0:01:58.901000 (95.11%)
2024-09-20 21:07:13,008 INFO:	✅ In a hardware sleep state for 0:01:58.341797 (94.67%)
2024-09-20 21:07:13,010 DEBUG:	BAT0 energy level is 20549000 µWh
2024-09-20 21:07:13,010 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:07:15,010 INFO:	Suspend cycle 16: Started at 2024-09-20 21:07:15.010818 (cycle finish expected @ 2024-09-20 21:09:19.010835)
2024-09-20 21:09:20,002 INFO:	Results from last s2idle cycle
2024-09-20 21:09:20,003 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:09:20,003 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 21:09:20,003 DEBUG:	Freezing user space processes
2024-09-20 21:09:20,004 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:09:20,004 DEBUG:	OOM killer disabled.
2024-09-20 21:09:20,004 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:09:20,004 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:09:20,004 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:09:20,004 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:09:20,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:09:20,004 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:09:20,004 DEBUG:	PM: suspend of devices complete after 1112.956 msecs
2024-09-20 21:09:20,004 DEBUG:	PM: start suspend of devices complete after 1113.406 msecs
2024-09-20 21:09:20,004 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:09:20,004 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:09:20,004 DEBUG:	PM: late suspend of devices complete after 1.041 msecs
2024-09-20 21:09:20,004 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:09:20,004 DEBUG:	PM: noirq suspend of devices complete after 107.610 msecs
2024-09-20 21:09:20,004 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:09:20,004 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:09:20,004 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:09:20,004 DEBUG:	PM: suspend-to-idle
2024-09-20 21:09:20,004 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:09:20,005 DEBUG:	Timekeeping suspended for 118.727 seconds
2024-09-20 21:09:20,005 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:09:20,005 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:09:20,005 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:09:20,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:09:20,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:09:20,005 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:09:20,005 DEBUG:	PM: noirq resume of devices complete after 165.115 msecs
2024-09-20 21:09:20,005 DEBUG:	PM: early resume of devices complete after 3.323 msecs
2024-09-20 21:09:20,005 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:09:20,005 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:09:20,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:09:20,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:09:20,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:09:20,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:09:20,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:09:20,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:09:20,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:09:20,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:09:20,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:09:20,006 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:09:20,007 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:09:20,007 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:09:20,007 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:09:20,007 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:09:20,007 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:09:20,007 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:09:20,008 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:09:20,008 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:09:20,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:09:20,008 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:09:20,008 DEBUG:	PM: resume of devices complete after 2805.327 msecs
2024-09-20 21:09:20,008 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:09:20,008 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:09:20,008 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:09:20,008 DEBUG:	OOM killer enabled.
2024-09-20 21:09:20,008 DEBUG:	Restarting tasks ... 
2024-09-20 21:09:20,008 DEBUG:	usb 1-2: USB disconnect, device number 49
2024-09-20 21:09:20,008 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:09:20,008 DEBUG:	done.
2024-09-20 21:09:20,008 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:09:20,008 DEBUG:	usb 1-3: USB disconnect, device number 48
2024-09-20 21:09:20,008 DEBUG:	PM: suspend exit
2024-09-20 21:09:20,008 DEBUG:	usb 1-3: new full-speed USB device number 50 using xhci_hcd
2024-09-20 21:09:20,008 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:09:20,008 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:09:20,008 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:09:20,008 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:09:20,009 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0058/input/input133
2024-09-20 21:09:20,009 DEBUG:	asus 0003:0B05:1ABE.0058: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:09:20,009 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0059/input/input134
2024-09-20 21:09:20,009 DEBUG:	asus 0003:0B05:1ABE.0059: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:09:20,009 DEBUG:	asus 0003:0B05:1ABE.005A: Fixing up Asus N-Key report descriptor
2024-09-20 21:09:20,009 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.005A/input/input135
2024-09-20 21:09:20,009 DEBUG:	asus 0003:0B05:1ABE.005A: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:09:20,009 DEBUG:	usb 1-2: new full-speed USB device number 51 using xhci_hcd
2024-09-20 21:09:20,009 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:09:20,009 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:09:20,009 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:09:20,009 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:09:20,009 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:09:20,009 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input136
2024-09-20 21:09:20,009 DEBUG:	input input136: unable to receive magic message: -32
2024-09-20 21:09:20,009 DEBUG:	input input136: unable to receive magic message: -32
2024-09-20 21:09:20,009 INFO:	○ Suspend count: 1
2024-09-20 21:09:20,009 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:09:20,009 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:09:20,009 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:09:20,009 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:09:20,009 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:09:20,010 INFO:	○ gpe10 increased from 87 to 89
2024-09-20 21:09:20,010 INFO:	✅ Userspace suspended for 0:02:04.999415
2024-09-20 21:09:20,010 DEBUG:	Kernel suspended for total of 0:01:58.727000 (94.98%)
2024-09-20 21:09:20,010 INFO:	✅ In a hardware sleep state for 0:01:58.164550 (94.53%)
2024-09-20 21:09:20,011 DEBUG:	BAT0 energy level is 20517000 µWh
2024-09-20 21:09:20,011 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:09:22,011 INFO:	Suspend cycle 17: Started at 2024-09-20 21:09:22.011517 (cycle finish expected @ 2024-09-20 21:11:26.011535)
2024-09-20 21:11:26,989 INFO:	Results from last s2idle cycle
2024-09-20 21:11:26,989 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:11:26,989 DEBUG:	Filesystems sync: 0.041 seconds
2024-09-20 21:11:26,989 DEBUG:	Freezing user space processes
2024-09-20 21:11:26,989 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:11:26,989 DEBUG:	OOM killer disabled.
2024-09-20 21:11:26,989 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:11:26,989 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 21:11:26,989 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:11:26,990 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:11:26,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:11:26,990 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:11:26,990 DEBUG:	PM: suspend of devices complete after 334.846 msecs
2024-09-20 21:11:26,990 DEBUG:	PM: start suspend of devices complete after 335.608 msecs
2024-09-20 21:11:26,990 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:11:26,990 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:11:26,990 DEBUG:	PM: late suspend of devices complete after 1.035 msecs
2024-09-20 21:11:26,990 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:11:26,990 DEBUG:	PM: noirq suspend of devices complete after 98.700 msecs
2024-09-20 21:11:26,990 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:11:26,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:11:26,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:11:26,990 DEBUG:	PM: suspend-to-idle
2024-09-20 21:11:26,990 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:11:26,990 DEBUG:	Timekeeping suspended for 119.504 seconds
2024-09-20 21:11:26,990 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:11:26,990 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:11:26,990 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:11:26,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:11:26,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:11:26,990 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:11:26,990 DEBUG:	PM: noirq resume of devices complete after 160.634 msecs
2024-09-20 21:11:26,990 DEBUG:	PM: early resume of devices complete after 2.959 msecs
2024-09-20 21:11:26,990 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:11:26,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:11:26,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:11:26,990 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:11:26,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:11:26,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:11:26,992 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:11:26,992 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:11:26,992 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:11:26,992 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:11:26,992 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:11:26,993 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:11:26,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:11:26,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:11:26,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:11:26,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:11:26,994 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:11:26,994 DEBUG:	PM: resume of devices complete after 2807.049 msecs
2024-09-20 21:11:26,994 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:11:26,994 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:11:26,994 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:11:26,994 DEBUG:	OOM killer enabled.
2024-09-20 21:11:26,994 DEBUG:	Restarting tasks ... 
2024-09-20 21:11:26,994 DEBUG:	usb 1-2: USB disconnect, device number 51
2024-09-20 21:11:26,994 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:11:26,994 DEBUG:	done.
2024-09-20 21:11:26,994 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:11:26,994 DEBUG:	PM: suspend exit
2024-09-20 21:11:26,994 DEBUG:	usb 1-3: USB disconnect, device number 50
2024-09-20 21:11:26,994 DEBUG:	usb 1-3: new full-speed USB device number 52 using xhci_hcd
2024-09-20 21:11:26,994 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:11:26,994 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:11:26,994 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:11:26,994 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:11:26,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.005B/input/input137
2024-09-20 21:11:26,995 DEBUG:	asus 0003:0B05:1ABE.005B: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:11:26,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.005C/input/input138
2024-09-20 21:11:26,995 DEBUG:	asus 0003:0B05:1ABE.005C: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:11:26,995 DEBUG:	asus 0003:0B05:1ABE.005D: Fixing up Asus N-Key report descriptor
2024-09-20 21:11:26,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.005D/input/input139
2024-09-20 21:11:26,995 DEBUG:	asus 0003:0B05:1ABE.005D: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:11:26,995 DEBUG:	usb 1-2: new full-speed USB device number 53 using xhci_hcd
2024-09-20 21:11:26,995 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:11:26,995 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:11:26,995 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:11:26,995 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:11:26,995 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:11:26,995 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input140
2024-09-20 21:11:26,995 DEBUG:	input input140: unable to receive magic message: -32
2024-09-20 21:11:26,995 INFO:	○ Suspend count: 1
2024-09-20 21:11:26,995 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:11:26,995 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:11:26,995 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:11:26,995 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:11:26,995 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:11:26,996 INFO:	○ gpe10 increased from 89 to 91
2024-09-20 21:11:26,996 INFO:	✅ Userspace suspended for 0:02:04.984937
2024-09-20 21:11:26,996 DEBUG:	Kernel suspended for total of 0:01:59.504000 (95.61%)
2024-09-20 21:11:26,996 INFO:	✅ In a hardware sleep state for 0:01:58.939178 (95.16%)
2024-09-20 21:11:26,997 DEBUG:	BAT0 energy level is 20485000 µWh
2024-09-20 21:11:26,997 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:11:28,997 INFO:	Suspend cycle 18: Started at 2024-09-20 21:11:28.997682 (cycle finish expected @ 2024-09-20 21:13:32.997694)
2024-09-20 21:13:33,995 INFO:	Results from last s2idle cycle
2024-09-20 21:13:33,996 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:13:33,996 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 21:13:33,996 DEBUG:	Freezing user space processes
2024-09-20 21:13:33,996 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:13:33,996 DEBUG:	OOM killer disabled.
2024-09-20 21:13:33,996 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:13:33,996 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:13:33,996 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:13:33,996 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:13:33,996 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:13:33,997 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:13:33,997 DEBUG:	PM: suspend of devices complete after 340.140 msecs
2024-09-20 21:13:33,997 DEBUG:	PM: start suspend of devices complete after 340.600 msecs
2024-09-20 21:13:33,997 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:13:33,997 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:13:33,997 DEBUG:	PM: late suspend of devices complete after 1.104 msecs
2024-09-20 21:13:33,997 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:13:33,997 DEBUG:	PM: noirq suspend of devices complete after 114.167 msecs
2024-09-20 21:13:33,997 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:13:33,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:13:33,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:13:33,997 DEBUG:	PM: suspend-to-idle
2024-09-20 21:13:33,997 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:13:33,997 DEBUG:	Timekeeping suspended for 119.504 seconds
2024-09-20 21:13:33,997 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:13:33,997 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:13:33,997 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:13:33,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:13:33,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:13:33,997 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:13:33,997 DEBUG:	PM: noirq resume of devices complete after 162.242 msecs
2024-09-20 21:13:33,997 DEBUG:	PM: early resume of devices complete after 3.031 msecs
2024-09-20 21:13:33,997 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:13:33,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:13:33,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:13:33,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:13:33,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:13:33,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:13:33,998 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:13:33,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:13:33,998 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:13:33,998 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:13:33,998 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:13:33,998 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:13:33,998 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:13:33,998 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:13:33,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:13:33,998 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:13:33,998 DEBUG:	PM: resume of devices complete after 2805.034 msecs
2024-09-20 21:13:33,998 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:13:33,998 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:13:33,998 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:13:33,998 DEBUG:	OOM killer enabled.
2024-09-20 21:13:33,998 DEBUG:	Restarting tasks ... 
2024-09-20 21:13:33,998 DEBUG:	usb 1-2: USB disconnect, device number 53
2024-09-20 21:13:33,998 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:13:33,998 DEBUG:	done.
2024-09-20 21:13:33,998 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:13:33,998 DEBUG:	PM: suspend exit
2024-09-20 21:13:33,998 DEBUG:	usb 1-3: USB disconnect, device number 52
2024-09-20 21:13:33,999 DEBUG:	usb 1-3: new full-speed USB device number 54 using xhci_hcd
2024-09-20 21:13:33,999 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:13:33,999 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:13:33,999 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:13:33,999 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:13:33,999 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.005E/input/input141
2024-09-20 21:13:33,999 DEBUG:	asus 0003:0B05:1ABE.005E: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:13:33,999 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.005F/input/input142
2024-09-20 21:13:33,999 DEBUG:	asus 0003:0B05:1ABE.005F: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:13:33,999 DEBUG:	asus 0003:0B05:1ABE.0060: Fixing up Asus N-Key report descriptor
2024-09-20 21:13:33,999 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0060/input/input143
2024-09-20 21:13:33,999 DEBUG:	asus 0003:0B05:1ABE.0060: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:13:33,999 DEBUG:	usb 1-2: new full-speed USB device number 55 using xhci_hcd
2024-09-20 21:13:33,999 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:13:33,999 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:13:33,999 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:13:33,999 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:13:33,999 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:13:33,999 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input144
2024-09-20 21:13:33,999 DEBUG:	input input144: unable to receive magic message: -32
2024-09-20 21:13:33,999 INFO:	○ Suspend count: 1
2024-09-20 21:13:33,999 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:13:33,999 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:13:33,999 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:13:33,999 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:13:33,999 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:13:34,000 INFO:	○ gpe10 increased from 91 to 93
2024-09-20 21:13:34,000 INFO:	✅ Userspace suspended for 0:02:05.002527
2024-09-20 21:13:34,000 DEBUG:	Kernel suspended for total of 0:01:59.504000 (95.60%)
2024-09-20 21:13:34,000 INFO:	✅ In a hardware sleep state for 0:01:58.945556 (95.15%)
2024-09-20 21:13:34,001 DEBUG:	BAT0 energy level is 20453000 µWh
2024-09-20 21:13:34,001 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:13:36,002 INFO:	Suspend cycle 19: Started at 2024-09-20 21:13:36.001956 (cycle finish expected @ 2024-09-20 21:15:40.001981)
2024-09-20 21:15:40,995 INFO:	Results from last s2idle cycle
2024-09-20 21:15:40,996 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:15:40,996 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 21:15:40,996 DEBUG:	Freezing user space processes
2024-09-20 21:15:40,996 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:15:40,996 DEBUG:	OOM killer disabled.
2024-09-20 21:15:40,996 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:15:40,996 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:15:40,996 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:15:40,996 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:15:40,996 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:15:40,996 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:15:40,996 DEBUG:	PM: suspend of devices complete after 339.140 msecs
2024-09-20 21:15:40,996 DEBUG:	PM: start suspend of devices complete after 339.904 msecs
2024-09-20 21:15:40,996 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:15:40,996 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:15:40,996 DEBUG:	PM: late suspend of devices complete after 0.994 msecs
2024-09-20 21:15:40,996 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:15:40,996 DEBUG:	PM: noirq suspend of devices complete after 107.512 msecs
2024-09-20 21:15:40,996 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:15:40,996 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:15:40,996 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:15:40,996 DEBUG:	PM: suspend-to-idle
2024-09-20 21:15:40,996 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:15:40,997 DEBUG:	Timekeeping suspended for 119.509 seconds
2024-09-20 21:15:40,997 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:15:40,997 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:15:40,997 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:15:40,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:15:40,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:15:40,997 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:15:40,997 DEBUG:	PM: noirq resume of devices complete after 162.244 msecs
2024-09-20 21:15:40,997 DEBUG:	PM: early resume of devices complete after 2.879 msecs
2024-09-20 21:15:40,997 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:15:40,997 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:15:40,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:15:40,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:15:40,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:15:40,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:15:40,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:15:40,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:15:40,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:15:40,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:15:40,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:15:40,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:15:40,999 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:15:40,999 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:15:40,999 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:15:40,999 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:15:40,999 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:15:41,000 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:15:41,000 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:15:41,000 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:15:41,000 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:15:41,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:15:41,000 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:15:41,000 DEBUG:	PM: resume of devices complete after 2805.638 msecs
2024-09-20 21:15:41,000 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:15:41,000 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:15:41,000 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:15:41,000 DEBUG:	OOM killer enabled.
2024-09-20 21:15:41,000 DEBUG:	Restarting tasks ... 
2024-09-20 21:15:41,000 DEBUG:	usb 1-2: USB disconnect, device number 55
2024-09-20 21:15:41,000 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:15:41,000 DEBUG:	done.
2024-09-20 21:15:41,000 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:15:41,000 DEBUG:	PM: suspend exit
2024-09-20 21:15:41,000 DEBUG:	usb 1-3: USB disconnect, device number 54
2024-09-20 21:15:41,001 DEBUG:	usb 1-3: new full-speed USB device number 56 using xhci_hcd
2024-09-20 21:15:41,001 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:15:41,001 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:15:41,001 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:15:41,001 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:15:41,001 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0061/input/input145
2024-09-20 21:15:41,001 DEBUG:	asus 0003:0B05:1ABE.0061: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:15:41,001 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0062/input/input146
2024-09-20 21:15:41,001 DEBUG:	asus 0003:0B05:1ABE.0062: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:15:41,001 DEBUG:	asus 0003:0B05:1ABE.0063: Fixing up Asus N-Key report descriptor
2024-09-20 21:15:41,001 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0063/input/input147
2024-09-20 21:15:41,001 DEBUG:	asus 0003:0B05:1ABE.0063: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:15:41,001 DEBUG:	usb 1-2: new full-speed USB device number 57 using xhci_hcd
2024-09-20 21:15:41,001 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:15:41,001 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:15:41,001 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:15:41,001 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:15:41,001 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:15:41,001 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input148
2024-09-20 21:15:41,001 DEBUG:	input input148: unable to receive magic message: -32
2024-09-20 21:15:41,001 INFO:	○ Suspend count: 1
2024-09-20 21:15:41,001 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:15:41,001 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:15:41,001 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:15:41,001 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:15:41,001 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:15:41,002 INFO:	○ gpe10 increased from 93 to 95
2024-09-20 21:15:41,002 INFO:	✅ Userspace suspended for 0:02:05.000424
2024-09-20 21:15:41,002 DEBUG:	Kernel suspended for total of 0:01:59.509000 (95.61%)
2024-09-20 21:15:41,002 INFO:	✅ In a hardware sleep state for 0:01:58.949920 (95.16%)
2024-09-20 21:15:41,003 DEBUG:	BAT0 energy level is 20422000 µWh
2024-09-20 21:15:41,003 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 21:15:43,003 INFO:	Suspend cycle 20: Started at 2024-09-20 21:15:43.003721 (cycle finish expected @ 2024-09-20 21:17:47.003736)
2024-09-20 21:17:48,000 INFO:	Results from last s2idle cycle
2024-09-20 21:17:48,000 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:17:48,000 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 21:17:48,000 DEBUG:	Freezing user space processes
2024-09-20 21:17:48,000 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:17:48,000 DEBUG:	OOM killer disabled.
2024-09-20 21:17:48,000 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:17:48,000 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:17:48,000 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:17:48,000 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:17:48,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:17:48,000 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:17:48,000 DEBUG:	PM: suspend of devices complete after 340.557 msecs
2024-09-20 21:17:48,000 DEBUG:	PM: start suspend of devices complete after 341.011 msecs
2024-09-20 21:17:48,000 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:17:48,000 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:17:48,000 DEBUG:	PM: late suspend of devices complete after 1.180 msecs
2024-09-20 21:17:48,000 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:17:48,000 DEBUG:	PM: noirq suspend of devices complete after 101.224 msecs
2024-09-20 21:17:48,000 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:17:48,000 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:17:48,000 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:17:48,001 DEBUG:	PM: suspend-to-idle
2024-09-20 21:17:48,001 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:17:48,001 DEBUG:	Timekeeping suspended for 119.512 seconds
2024-09-20 21:17:48,001 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:17:48,001 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:17:48,001 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:17:48,001 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:17:48,001 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:17:48,001 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:17:48,001 DEBUG:	PM: noirq resume of devices complete after 163.352 msecs
2024-09-20 21:17:48,001 DEBUG:	PM: early resume of devices complete after 3.062 msecs
2024-09-20 21:17:48,001 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:17:48,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:17:48,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:17:48,001 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:17:48,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:17:48,001 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:17:48,001 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:17:48,001 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:17:48,001 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:17:48,001 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:17:48,001 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:17:48,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:17:48,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:17:48,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:17:48,001 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:17:48,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:17:48,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:17:48,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:17:48,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:17:48,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:17:48,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:17:48,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:17:48,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:17:48,002 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:17:48,002 DEBUG:	PM: resume of devices complete after 2807.667 msecs
2024-09-20 21:17:48,002 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:17:48,002 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:17:48,002 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:17:48,002 DEBUG:	OOM killer enabled.
2024-09-20 21:17:48,002 DEBUG:	Restarting tasks ... 
2024-09-20 21:17:48,002 DEBUG:	usb 1-2: USB disconnect, device number 57
2024-09-20 21:17:48,002 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:17:48,002 DEBUG:	done.
2024-09-20 21:17:48,002 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:17:48,002 DEBUG:	PM: suspend exit
2024-09-20 21:17:48,002 DEBUG:	usb 1-3: USB disconnect, device number 56
2024-09-20 21:17:48,002 DEBUG:	usb 1-3: new full-speed USB device number 58 using xhci_hcd
2024-09-20 21:17:48,002 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:17:48,002 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:17:48,002 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:17:48,002 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:17:48,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0064/input/input149
2024-09-20 21:17:48,002 DEBUG:	asus 0003:0B05:1ABE.0064: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:17:48,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0065/input/input150
2024-09-20 21:17:48,002 DEBUG:	asus 0003:0B05:1ABE.0065: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:17:48,002 DEBUG:	asus 0003:0B05:1ABE.0066: Fixing up Asus N-Key report descriptor
2024-09-20 21:17:48,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0066/input/input151
2024-09-20 21:17:48,002 DEBUG:	asus 0003:0B05:1ABE.0066: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:17:48,002 DEBUG:	usb 1-2: new full-speed USB device number 59 using xhci_hcd
2024-09-20 21:17:48,002 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:17:48,002 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:17:48,002 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:17:48,002 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:17:48,002 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:17:48,002 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input152
2024-09-20 21:17:48,002 DEBUG:	input input152: unable to receive magic message: -32
2024-09-20 21:17:48,002 INFO:	○ Suspend count: 1
2024-09-20 21:17:48,003 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:17:48,003 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:17:48,003 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:17:48,003 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:17:48,003 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:17:48,003 INFO:	○ gpe10 increased from 95 to 97
2024-09-20 21:17:48,003 INFO:	✅ Userspace suspended for 0:02:05.000144
2024-09-20 21:17:48,003 DEBUG:	Kernel suspended for total of 0:01:59.512000 (95.61%)
2024-09-20 21:17:48,003 INFO:	✅ In a hardware sleep state for 0:01:58.949463 (95.16%)
2024-09-20 21:17:48,004 DEBUG:	BAT0 energy level is 20390000 µWh
2024-09-20 21:17:48,004 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:17:50,005 INFO:	Suspend cycle 21: Started at 2024-09-20 21:17:50.005192 (cycle finish expected @ 2024-09-20 21:19:54.005223)
2024-09-20 21:19:54,996 INFO:	Results from last s2idle cycle
2024-09-20 21:19:54,996 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:19:54,996 DEBUG:	Filesystems sync: 0.032 seconds
2024-09-20 21:19:54,996 DEBUG:	Freezing user space processes
2024-09-20 21:19:54,996 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:19:54,996 DEBUG:	OOM killer disabled.
2024-09-20 21:19:54,996 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:19:54,997 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:19:54,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:19:54,997 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:19:54,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:19:54,997 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:19:54,997 DEBUG:	PM: suspend of devices complete after 348.855 msecs
2024-09-20 21:19:54,997 DEBUG:	PM: start suspend of devices complete after 349.719 msecs
2024-09-20 21:19:54,997 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:19:54,997 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:19:54,997 DEBUG:	PM: late suspend of devices complete after 1.098 msecs
2024-09-20 21:19:54,997 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:19:54,997 DEBUG:	PM: noirq suspend of devices complete after 90.008 msecs
2024-09-20 21:19:54,997 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:19:54,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:19:54,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:19:54,997 DEBUG:	PM: suspend-to-idle
2024-09-20 21:19:54,997 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:19:54,997 DEBUG:	Timekeeping suspended for 119.512 seconds
2024-09-20 21:19:54,997 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:19:54,997 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:19:54,997 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:19:54,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:19:54,997 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:19:54,997 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:19:54,997 DEBUG:	PM: noirq resume of devices complete after 162.118 msecs
2024-09-20 21:19:54,997 DEBUG:	PM: early resume of devices complete after 3.107 msecs
2024-09-20 21:19:54,997 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:19:54,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:19:54,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:19:54,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:19:54,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:19:54,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:19:54,997 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:19:54,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:19:54,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:19:54,997 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:19:54,998 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:19:54,998 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:19:54,998 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:19:54,998 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:19:54,998 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:19:54,998 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:19:54,998 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:19:54,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:19:54,998 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:19:54,998 DEBUG:	PM: resume of devices complete after 2803.045 msecs
2024-09-20 21:19:54,998 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:19:54,998 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:19:54,998 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:19:54,998 DEBUG:	OOM killer enabled.
2024-09-20 21:19:54,999 DEBUG:	Restarting tasks ... 
2024-09-20 21:19:54,999 DEBUG:	usb 1-2: USB disconnect, device number 59
2024-09-20 21:19:54,999 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:19:54,999 DEBUG:	done.
2024-09-20 21:19:54,999 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:19:54,999 DEBUG:	PM: suspend exit
2024-09-20 21:19:54,999 DEBUG:	usb 1-3: USB disconnect, device number 58
2024-09-20 21:19:54,999 DEBUG:	usb 1-3: new full-speed USB device number 60 using xhci_hcd
2024-09-20 21:19:54,999 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:19:54,999 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:19:54,999 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:19:54,999 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:19:54,999 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0067/input/input153
2024-09-20 21:19:54,999 DEBUG:	asus 0003:0B05:1ABE.0067: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:19:54,999 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0068/input/input154
2024-09-20 21:19:54,999 DEBUG:	asus 0003:0B05:1ABE.0068: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:19:54,999 DEBUG:	asus 0003:0B05:1ABE.0069: Fixing up Asus N-Key report descriptor
2024-09-20 21:19:54,999 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0069/input/input155
2024-09-20 21:19:54,999 DEBUG:	asus 0003:0B05:1ABE.0069: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:19:54,999 DEBUG:	usb 1-2: new full-speed USB device number 61 using xhci_hcd
2024-09-20 21:19:54,999 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:19:54,999 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:19:54,999 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:19:54,999 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:19:54,999 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:19:54,999 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input156
2024-09-20 21:19:54,999 DEBUG:	input input156: unable to receive magic message: -32
2024-09-20 21:19:54,999 INFO:	○ Suspend count: 1
2024-09-20 21:19:54,999 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:19:54,999 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:19:54,999 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:19:54,999 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:19:54,999 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:19:55,000 INFO:	○ gpe10 increased from 97 to 99
2024-09-20 21:19:55,000 INFO:	✅ Userspace suspended for 0:02:04.995278
2024-09-20 21:19:55,000 DEBUG:	Kernel suspended for total of 0:01:59.512000 (95.61%)
2024-09-20 21:19:55,000 INFO:	✅ In a hardware sleep state for 0:01:58.947876 (95.16%)
2024-09-20 21:19:55,001 DEBUG:	BAT0 energy level is 20358000 µWh
2024-09-20 21:19:55,001 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:19:57,001 INFO:	Suspend cycle 22: Started at 2024-09-20 21:19:57.001526 (cycle finish expected @ 2024-09-20 21:22:01.001537)
2024-09-20 21:22:01,992 INFO:	Results from last s2idle cycle
2024-09-20 21:22:01,993 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:22:01,993 DEBUG:	Filesystems sync: 0.032 seconds
2024-09-20 21:22:01,993 DEBUG:	Freezing user space processes
2024-09-20 21:22:01,993 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:22:01,993 DEBUG:	OOM killer disabled.
2024-09-20 21:22:01,993 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:22:01,993 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 21:22:01,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:22:01,993 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:22:01,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:22:01,993 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:22:01,993 DEBUG:	PM: suspend of devices complete after 342.143 msecs
2024-09-20 21:22:01,993 DEBUG:	PM: start suspend of devices complete after 342.908 msecs
2024-09-20 21:22:01,993 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:22:01,993 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:22:01,993 DEBUG:	PM: late suspend of devices complete after 0.869 msecs
2024-09-20 21:22:01,993 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:22:01,993 DEBUG:	PM: noirq suspend of devices complete after 113.715 msecs
2024-09-20 21:22:01,993 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:22:01,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:22:01,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:22:01,993 DEBUG:	PM: suspend-to-idle
2024-09-20 21:22:01,993 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:22:01,993 DEBUG:	Timekeeping suspended for 119.502 seconds
2024-09-20 21:22:01,993 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:22:01,993 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:22:01,993 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:22:01,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:22:01,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:22:01,994 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:22:01,994 DEBUG:	PM: noirq resume of devices complete after 166.785 msecs
2024-09-20 21:22:01,994 DEBUG:	PM: early resume of devices complete after 2.734 msecs
2024-09-20 21:22:01,994 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:22:01,994 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:22:01,994 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:22:01,994 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:22:01,994 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:22:01,994 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:22:01,994 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:22:01,994 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:22:01,994 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:22:01,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:22:01,995 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:22:01,995 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:22:01,995 DEBUG:	PM: resume of devices complete after 2805.410 msecs
2024-09-20 21:22:01,995 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:22:01,995 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:22:01,995 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:22:01,995 DEBUG:	OOM killer enabled.
2024-09-20 21:22:01,995 DEBUG:	Restarting tasks ... 
2024-09-20 21:22:01,995 DEBUG:	usb 1-2: USB disconnect, device number 61
2024-09-20 21:22:01,995 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:22:01,995 DEBUG:	done.
2024-09-20 21:22:01,995 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:22:01,995 DEBUG:	PM: suspend exit
2024-09-20 21:22:01,995 DEBUG:	usb 1-3: USB disconnect, device number 60
2024-09-20 21:22:01,995 DEBUG:	usb 1-3: new full-speed USB device number 62 using xhci_hcd
2024-09-20 21:22:01,995 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:22:01,995 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:22:01,995 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:22:01,995 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:22:01,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.006A/input/input157
2024-09-20 21:22:01,995 DEBUG:	asus 0003:0B05:1ABE.006A: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:22:01,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.006B/input/input158
2024-09-20 21:22:01,995 DEBUG:	asus 0003:0B05:1ABE.006B: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:22:01,995 DEBUG:	asus 0003:0B05:1ABE.006C: Fixing up Asus N-Key report descriptor
2024-09-20 21:22:01,995 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.006C/input/input159
2024-09-20 21:22:01,995 DEBUG:	asus 0003:0B05:1ABE.006C: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:22:01,995 DEBUG:	usb 1-2: new full-speed USB device number 63 using xhci_hcd
2024-09-20 21:22:01,995 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:22:01,995 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:22:01,995 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:22:01,995 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:22:01,995 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:22:01,995 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input160
2024-09-20 21:22:01,995 DEBUG:	input input160: unable to receive magic message: -32
2024-09-20 21:22:01,995 INFO:	○ Suspend count: 1
2024-09-20 21:22:01,995 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:22:01,995 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:22:01,995 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:22:01,995 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:22:01,995 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:22:01,997 INFO:	○ gpe10 increased from 99 to 101
2024-09-20 21:22:01,998 INFO:	✅ Userspace suspended for 0:02:04.997164
2024-09-20 21:22:01,998 DEBUG:	Kernel suspended for total of 0:01:59.502000 (95.60%)
2024-09-20 21:22:01,998 INFO:	✅ In a hardware sleep state for 0:01:58.936920 (95.15%)
2024-09-20 21:22:01,999 DEBUG:	BAT0 energy level is 20326000 µWh
2024-09-20 21:22:01,999 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:22:03,999 INFO:	Suspend cycle 23: Started at 2024-09-20 21:22:03.999815 (cycle finish expected @ 2024-09-20 21:24:07.999834)
2024-09-20 21:24:08,986 INFO:	Results from last s2idle cycle
2024-09-20 21:24:08,987 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:24:08,987 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 21:24:08,987 DEBUG:	Freezing user space processes
2024-09-20 21:24:08,987 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:24:08,987 DEBUG:	OOM killer disabled.
2024-09-20 21:24:08,987 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:24:08,987 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:24:08,987 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:24:08,987 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:24:08,987 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:24:08,987 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:24:08,987 DEBUG:	PM: suspend of devices complete after 343.703 msecs
2024-09-20 21:24:08,987 DEBUG:	PM: start suspend of devices complete after 344.453 msecs
2024-09-20 21:24:08,987 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:24:08,987 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:24:08,987 DEBUG:	PM: late suspend of devices complete after 0.787 msecs
2024-09-20 21:24:08,987 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:24:08,987 DEBUG:	PM: noirq suspend of devices complete after 84.995 msecs
2024-09-20 21:24:08,987 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:24:08,987 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:24:08,987 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:24:08,987 DEBUG:	PM: suspend-to-idle
2024-09-20 21:24:08,987 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:24:08,987 DEBUG:	Timekeeping suspended for 119.528 seconds
2024-09-20 21:24:08,987 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:24:08,988 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:24:08,988 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:24:08,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:24:08,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:24:08,988 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:24:08,988 DEBUG:	PM: noirq resume of devices complete after 161.076 msecs
2024-09-20 21:24:08,988 DEBUG:	PM: early resume of devices complete after 3.057 msecs
2024-09-20 21:24:08,988 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:24:08,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:24:08,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:24:08,988 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:24:08,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:24:08,988 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:24:08,988 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:24:08,988 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:24:08,988 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:24:08,988 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:24:08,988 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:24:08,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:24:08,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:24:08,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:24:08,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:24:08,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:24:08,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:24:08,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:24:08,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:24:08,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:24:08,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:24:08,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:24:08,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:24:08,991 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:24:08,991 DEBUG:	PM: resume of devices complete after 2804.920 msecs
2024-09-20 21:24:08,991 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:24:08,991 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:24:08,991 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:24:08,991 DEBUG:	OOM killer enabled.
2024-09-20 21:24:08,992 DEBUG:	Restarting tasks ... 
2024-09-20 21:24:08,992 DEBUG:	usb 1-2: USB disconnect, device number 63
2024-09-20 21:24:08,992 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:24:08,992 DEBUG:	done.
2024-09-20 21:24:08,992 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:24:08,992 DEBUG:	PM: suspend exit
2024-09-20 21:24:08,992 DEBUG:	usb 1-3: USB disconnect, device number 62
2024-09-20 21:24:08,992 DEBUG:	usb 1-3: new full-speed USB device number 64 using xhci_hcd
2024-09-20 21:24:08,992 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:24:08,992 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:24:08,992 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:24:08,992 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:24:08,992 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.006D/input/input161
2024-09-20 21:24:08,992 DEBUG:	asus 0003:0B05:1ABE.006D: input,hidraw2: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:24:08,992 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.006E/input/input162
2024-09-20 21:24:08,992 DEBUG:	asus 0003:0B05:1ABE.006E: input,hidraw3: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:24:08,992 DEBUG:	asus 0003:0B05:1ABE.006F: Fixing up Asus N-Key report descriptor
2024-09-20 21:24:08,992 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.006F/input/input163
2024-09-20 21:24:08,992 DEBUG:	asus 0003:0B05:1ABE.006F: input,hiddev96,hidraw4: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:24:08,992 DEBUG:	usb 1-2: new full-speed USB device number 65 using xhci_hcd
2024-09-20 21:24:08,992 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:24:08,992 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:24:08,992 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:24:08,992 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:24:08,992 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:24:08,992 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input164
2024-09-20 21:24:08,992 DEBUG:	input input164: unable to receive magic message: -32
2024-09-20 21:24:08,992 INFO:	○ Suspend count: 1
2024-09-20 21:24:08,993 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:24:08,993 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:24:08,993 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:24:08,993 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:24:08,993 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:24:08,993 INFO:	○ gpe10 increased from 101 to 103
2024-09-20 21:24:08,994 INFO:	✅ Userspace suspended for 0:02:04.994229
2024-09-20 21:24:08,994 DEBUG:	Kernel suspended for total of 0:01:59.528000 (95.63%)
2024-09-20 21:24:08,994 INFO:	✅ In a hardware sleep state for 0:01:58.963623 (95.18%)
2024-09-20 21:24:08,994 DEBUG:	BAT0 energy level is 20294000 µWh
2024-09-20 21:24:08,994 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:24:10,995 INFO:	Suspend cycle 24: Started at 2024-09-20 21:24:10.995252 (cycle finish expected @ 2024-09-20 21:26:14.995264)
2024-09-20 21:24:18,807 ERROR:	❌ Failed to suspend
2024-09-20 21:24:18,807 DEBUG:	[Errno 16] Device or resource busy
2024-09-20 21:24:20,808 INFO:	Suspend cycle 25: Started at 2024-09-20 21:24:20.807993 (cycle finish expected @ 2024-09-20 21:26:24.808011)
2024-09-20 21:26:26,005 INFO:	Results from last s2idle cycle
2024-09-20 21:26:26,005 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:26:26,005 DEBUG:	Filesystems sync: 0.009 seconds
2024-09-20 21:26:26,005 DEBUG:	Freezing user space processes
2024-09-20 21:26:26,005 DEBUG:	Freezing user space processes completed (elapsed 0.013 seconds)
2024-09-20 21:26:26,005 DEBUG:	OOM killer disabled.
2024-09-20 21:26:26,005 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:26:26,005 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:26:26,005 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:26:26,006 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:26:26,006 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:26:26,006 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:26:26,006 DEBUG:	PM: suspend of devices complete after 347.958 msecs
2024-09-20 21:26:26,006 DEBUG:	PM: start suspend of devices complete after 348.428 msecs
2024-09-20 21:26:26,006 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:26:26,006 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:26:26,006 DEBUG:	PM: late suspend of devices complete after 1.049 msecs
2024-09-20 21:26:26,006 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:26:26,006 DEBUG:	PM: noirq suspend of devices complete after 99.387 msecs
2024-09-20 21:26:26,006 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:26:26,006 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:26:26,006 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:26:26,006 DEBUG:	PM: suspend-to-idle
2024-09-20 21:26:26,006 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:26:26,006 DEBUG:	Timekeeping suspended for 119.713 seconds
2024-09-20 21:26:26,006 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:26:26,006 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:26:26,006 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:26:26,006 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:26:26,006 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:26:26,006 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:26:26,007 DEBUG:	PM: noirq resume of devices complete after 163.546 msecs
2024-09-20 21:26:26,007 DEBUG:	PM: early resume of devices complete after 3.028 msecs
2024-09-20 21:26:26,007 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:26:26,007 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:26:26,007 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:26:26,007 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:26:26,008 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:26:26,008 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:26:26,008 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:26:26,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:26:26,009 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:26:26,009 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:26:26,009 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:26:26,009 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:26:26,009 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:26:26,009 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:26:26,009 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:26:26,009 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:26:26,009 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:26:26,009 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:26:26,009 DEBUG:	PM: resume of devices complete after 2802.586 msecs
2024-09-20 21:26:26,009 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:26:26,009 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:26:26,009 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:26:26,009 DEBUG:	OOM killer enabled.
2024-09-20 21:26:26,009 DEBUG:	Restarting tasks ... 
2024-09-20 21:26:26,009 DEBUG:	usb 1-2: USB disconnect, device number 69
2024-09-20 21:26:26,009 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:26:26,009 DEBUG:	done.
2024-09-20 21:26:26,009 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:26:26,009 DEBUG:	PM: suspend exit
2024-09-20 21:26:26,010 DEBUG:	usb 1-3: USB disconnect, device number 68
2024-09-20 21:26:26,010 DEBUG:	pcieport 0000:00:02.3: AER: Correctable error message received from 0000:07:00.0
2024-09-20 21:26:26,010 DEBUG:	sdhci-pci 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
2024-09-20 21:26:26,010 DEBUG:	sdhci-pci 0000:07:00.0:   device [17a0:9755] error status/mask=00000080/00003000
2024-09-20 21:26:26,010 DEBUG:	sdhci-pci 0000:07:00.0:    [ 7] BadDLLP               
2024-09-20 21:26:26,010 DEBUG:	usb 1-3: new full-speed USB device number 70 using xhci_hcd
2024-09-20 21:26:26,010 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:26:26,010 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:26:26,010 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:26:26,010 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:26:26,010 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0076/input/input173
2024-09-20 21:26:26,010 DEBUG:	asus 0003:0B05:1ABE.0076: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:26:26,010 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0077/input/input174
2024-09-20 21:26:26,010 DEBUG:	asus 0003:0B05:1ABE.0077: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:26:26,010 DEBUG:	asus 0003:0B05:1ABE.0078: Fixing up Asus N-Key report descriptor
2024-09-20 21:26:26,010 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0078/input/input175
2024-09-20 21:26:26,010 DEBUG:	asus 0003:0B05:1ABE.0078: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:26:26,010 DEBUG:	usb 1-2: new full-speed USB device number 71 using xhci_hcd
2024-09-20 21:26:26,010 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:26:26,010 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:26:26,010 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:26:26,010 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:26:26,010 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:26:26,010 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input176
2024-09-20 21:26:26,010 DEBUG:	input input176: unable to receive magic message: -32
2024-09-20 21:26:26,010 INFO:	○ Suspend count: 1
2024-09-20 21:26:26,010 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:26:26,010 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:26:26,010 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:26:26,010 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:26:26,010 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:26:26,011 INFO:	○ gpe10 increased from 103 to 109
2024-09-20 21:26:26,011 INFO:	✅ Userspace suspended for 0:02:05.203230
2024-09-20 21:26:26,011 DEBUG:	Kernel suspended for total of 0:01:59.713000 (95.61%)
2024-09-20 21:26:26,011 INFO:	✅ In a hardware sleep state for 0:01:59.153686 (95.17%)
2024-09-20 21:26:26,011 DEBUG:	BAT0 energy level is 20231000 µWh
2024-09-20 21:26:26,012 INFO:	🔋 Battery BAT0 lost 63000 µWh (0.19%) [Average rate 0.18W]
2024-09-20 21:26:28,012 INFO:	Suspend cycle 26: Started at 2024-09-20 21:26:28.012370 (cycle finish expected @ 2024-09-20 21:28:32.012384)
2024-09-20 21:28:33,010 INFO:	Results from last s2idle cycle
2024-09-20 21:28:33,011 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:28:33,011 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 21:28:33,011 DEBUG:	Freezing user space processes
2024-09-20 21:28:33,011 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:28:33,011 DEBUG:	OOM killer disabled.
2024-09-20 21:28:33,011 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:28:33,011 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:28:33,011 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:28:33,011 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:28:33,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:28:33,011 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:28:33,011 DEBUG:	PM: suspend of devices complete after 349.764 msecs
2024-09-20 21:28:33,012 DEBUG:	PM: start suspend of devices complete after 350.533 msecs
2024-09-20 21:28:33,012 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:28:33,012 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:28:33,012 DEBUG:	PM: late suspend of devices complete after 1.419 msecs
2024-09-20 21:28:33,012 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:28:33,012 DEBUG:	PM: noirq suspend of devices complete after 101.991 msecs
2024-09-20 21:28:33,012 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:28:33,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:28:33,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:28:33,012 DEBUG:	PM: suspend-to-idle
2024-09-20 21:28:33,012 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:28:33,012 DEBUG:	Timekeeping suspended for 119.491 seconds
2024-09-20 21:28:33,012 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:28:33,012 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:28:33,012 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:28:33,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:28:33,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:28:33,012 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:28:33,012 DEBUG:	PM: noirq resume of devices complete after 166.117 msecs
2024-09-20 21:28:33,012 DEBUG:	PM: early resume of devices complete after 3.002 msecs
2024-09-20 21:28:33,012 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:28:33,013 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:28:33,013 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:28:33,013 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:28:33,013 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:28:33,014 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:28:33,014 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:28:33,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:28:33,014 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:28:33,014 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:28:33,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:28:33,015 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:28:33,015 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:28:33,015 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:28:33,015 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:28:33,015 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:28:33,015 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:28:33,015 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:28:33,015 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:28:33,015 DEBUG:	PM: resume of devices complete after 2805.902 msecs
2024-09-20 21:28:33,015 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:28:33,015 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:28:33,015 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:28:33,015 DEBUG:	OOM killer enabled.
2024-09-20 21:28:33,015 DEBUG:	Restarting tasks ... done.
2024-09-20 21:28:33,015 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:28:33,015 DEBUG:	usb 1-2: USB disconnect, device number 71
2024-09-20 21:28:33,016 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:28:33,016 DEBUG:	PM: suspend exit
2024-09-20 21:28:33,016 DEBUG:	usb 1-3: USB disconnect, device number 70
2024-09-20 21:28:33,016 DEBUG:	usb 1-3: new full-speed USB device number 72 using xhci_hcd
2024-09-20 21:28:33,016 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:28:33,016 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:28:33,016 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:28:33,016 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:28:33,016 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0079/input/input177
2024-09-20 21:28:33,016 DEBUG:	asus 0003:0B05:1ABE.0079: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:28:33,016 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.007A/input/input178
2024-09-20 21:28:33,016 DEBUG:	asus 0003:0B05:1ABE.007A: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:28:33,016 DEBUG:	asus 0003:0B05:1ABE.007B: Fixing up Asus N-Key report descriptor
2024-09-20 21:28:33,016 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.007B/input/input179
2024-09-20 21:28:33,016 DEBUG:	asus 0003:0B05:1ABE.007B: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:28:33,016 DEBUG:	usb 1-2: new full-speed USB device number 73 using xhci_hcd
2024-09-20 21:28:33,016 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:28:33,016 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:28:33,016 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:28:33,016 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:28:33,016 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:28:33,016 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input180
2024-09-20 21:28:33,016 DEBUG:	input input180: unable to receive magic message: -32
2024-09-20 21:28:33,016 INFO:	○ Suspend count: 1
2024-09-20 21:28:33,016 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:28:33,016 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:28:33,016 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:28:33,016 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:28:33,017 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:28:33,017 INFO:	○ gpe10 increased from 109 to 111
2024-09-20 21:28:33,017 INFO:	✅ Userspace suspended for 0:02:05.005207
2024-09-20 21:28:33,017 DEBUG:	Kernel suspended for total of 0:01:59.491000 (95.59%)
2024-09-20 21:28:33,017 INFO:	✅ In a hardware sleep state for 0:01:58.933044 (95.14%)
2024-09-20 21:28:33,018 DEBUG:	BAT0 energy level is 20199000 µWh
2024-09-20 21:28:33,018 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:28:35,019 INFO:	Suspend cycle 27: Started at 2024-09-20 21:28:35.019020 (cycle finish expected @ 2024-09-20 21:30:39.019036)
2024-09-20 21:30:40,011 INFO:	Results from last s2idle cycle
2024-09-20 21:30:40,011 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:30:40,011 DEBUG:	Filesystems sync: 0.235 seconds
2024-09-20 21:30:40,011 DEBUG:	Freezing user space processes
2024-09-20 21:30:40,012 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:30:40,012 DEBUG:	OOM killer disabled.
2024-09-20 21:30:40,012 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:30:40,012 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:30:40,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:30:40,012 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:30:40,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:30:40,012 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:30:40,012 DEBUG:	PM: suspend of devices complete after 1106.665 msecs
2024-09-20 21:30:40,012 DEBUG:	PM: start suspend of devices complete after 1107.426 msecs
2024-09-20 21:30:40,012 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:30:40,012 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:30:40,012 DEBUG:	PM: late suspend of devices complete after 1.084 msecs
2024-09-20 21:30:40,012 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:30:40,012 DEBUG:	PM: noirq suspend of devices complete after 90.707 msecs
2024-09-20 21:30:40,012 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:30:40,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:30:40,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:30:40,012 DEBUG:	PM: suspend-to-idle
2024-09-20 21:30:40,012 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:30:40,012 DEBUG:	Timekeeping suspended for 118.540 seconds
2024-09-20 21:30:40,012 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:30:40,012 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:30:40,012 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:30:40,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:30:40,012 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:30:40,012 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:30:40,012 DEBUG:	PM: noirq resume of devices complete after 162.678 msecs
2024-09-20 21:30:40,012 DEBUG:	PM: early resume of devices complete after 2.858 msecs
2024-09-20 21:30:40,012 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:30:40,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:30:40,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:30:40,012 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:30:40,012 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:30:40,012 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:30:40,012 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:30:40,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:30:40,013 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:30:40,013 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:30:40,013 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:30:40,013 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:30:40,013 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:30:40,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:30:40,014 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:30:40,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:30:40,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:30:40,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:30:40,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:30:40,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:30:40,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:30:40,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:30:40,015 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:30:40,016 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:30:40,016 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:30:40,016 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:30:40,016 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:30:40,016 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:30:40,016 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:30:40,016 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:30:40,016 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:30:40,016 DEBUG:	PM: resume of devices complete after 2811.778 msecs
2024-09-20 21:30:40,016 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:30:40,016 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:30:40,016 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:30:40,016 DEBUG:	OOM killer enabled.
2024-09-20 21:30:40,016 DEBUG:	Restarting tasks ... 
2024-09-20 21:30:40,016 DEBUG:	usb 1-2: USB disconnect, device number 73
2024-09-20 21:30:40,016 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:30:40,016 DEBUG:	done.
2024-09-20 21:30:40,016 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:30:40,016 DEBUG:	usb 1-3: USB disconnect, device number 72
2024-09-20 21:30:40,016 DEBUG:	PM: suspend exit
2024-09-20 21:30:40,016 DEBUG:	usb 1-3: new full-speed USB device number 74 using xhci_hcd
2024-09-20 21:30:40,016 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:30:40,016 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:30:40,016 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:30:40,017 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:30:40,017 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.007C/input/input181
2024-09-20 21:30:40,017 DEBUG:	asus 0003:0B05:1ABE.007C: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:30:40,017 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.007D/input/input182
2024-09-20 21:30:40,017 DEBUG:	asus 0003:0B05:1ABE.007D: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:30:40,017 DEBUG:	asus 0003:0B05:1ABE.007E: Fixing up Asus N-Key report descriptor
2024-09-20 21:30:40,017 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.007E/input/input183
2024-09-20 21:30:40,017 DEBUG:	asus 0003:0B05:1ABE.007E: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:30:40,017 DEBUG:	usb 1-2: new full-speed USB device number 75 using xhci_hcd
2024-09-20 21:30:40,017 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:30:40,017 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:30:40,017 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:30:40,017 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:30:40,017 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:30:40,017 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input184
2024-09-20 21:30:40,017 DEBUG:	input input184: unable to receive magic message: -32
2024-09-20 21:30:40,017 INFO:	○ Suspend count: 1
2024-09-20 21:30:40,017 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:30:40,017 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:30:40,017 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:30:40,017 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:30:40,017 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:30:40,017 INFO:	○ gpe10 increased from 111 to 113
2024-09-20 21:30:40,018 INFO:	✅ Userspace suspended for 0:02:04.999070
2024-09-20 21:30:40,018 DEBUG:	Kernel suspended for total of 0:01:58.540000 (94.83%)
2024-09-20 21:30:40,018 INFO:	✅ In a hardware sleep state for 0:01:57.979461 (94.38%)
2024-09-20 21:30:40,018 DEBUG:	BAT0 energy level is 20167000 µWh
2024-09-20 21:30:40,018 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:30:42,019 INFO:	Suspend cycle 28: Started at 2024-09-20 21:30:42.019160 (cycle finish expected @ 2024-09-20 21:32:46.019182)
2024-09-20 21:32:46,988 INFO:	Results from last s2idle cycle
2024-09-20 21:32:46,988 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:32:46,988 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 21:32:46,988 DEBUG:	Freezing user space processes
2024-09-20 21:32:46,988 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:32:46,988 DEBUG:	OOM killer disabled.
2024-09-20 21:32:46,988 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:32:46,988 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:32:46,989 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:32:46,989 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:32:46,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:32:46,989 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:32:46,989 DEBUG:	PM: suspend of devices complete after 337.106 msecs
2024-09-20 21:32:46,989 DEBUG:	PM: start suspend of devices complete after 337.888 msecs
2024-09-20 21:32:46,989 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:32:46,989 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:32:46,989 DEBUG:	PM: late suspend of devices complete after 0.918 msecs
2024-09-20 21:32:46,989 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:32:46,989 DEBUG:	PM: noirq suspend of devices complete after 98.372 msecs
2024-09-20 21:32:46,989 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:32:46,989 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:32:46,989 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:32:46,989 DEBUG:	PM: suspend-to-idle
2024-09-20 21:32:46,989 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:32:46,989 DEBUG:	Timekeeping suspended for 119.503 seconds
2024-09-20 21:32:46,989 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:32:46,989 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:32:46,989 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:32:46,989 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:32:46,989 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:32:46,989 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:32:46,989 DEBUG:	PM: noirq resume of devices complete after 159.955 msecs
2024-09-20 21:32:46,989 DEBUG:	PM: early resume of devices complete after 3.038 msecs
2024-09-20 21:32:46,989 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:32:46,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:32:46,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:32:46,989 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:32:46,989 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:32:46,989 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:32:46,989 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:32:46,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:32:46,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:32:46,989 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:32:46,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:32:46,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:32:46,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:32:46,990 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:32:46,990 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:32:46,990 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:32:46,990 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:32:46,990 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:32:46,990 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:32:46,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:32:46,990 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:32:46,990 DEBUG:	PM: resume of devices complete after 2805.696 msecs
2024-09-20 21:32:46,990 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:32:46,990 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:32:46,990 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:32:46,990 DEBUG:	OOM killer enabled.
2024-09-20 21:32:46,990 DEBUG:	Restarting tasks ... 
2024-09-20 21:32:46,990 DEBUG:	usb 1-2: USB disconnect, device number 75
2024-09-20 21:32:46,990 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:32:46,990 DEBUG:	done.
2024-09-20 21:32:46,990 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:32:46,990 DEBUG:	PM: suspend exit
2024-09-20 21:32:46,990 DEBUG:	usb 1-3: USB disconnect, device number 74
2024-09-20 21:32:46,990 DEBUG:	usb 1-3: new full-speed USB device number 76 using xhci_hcd
2024-09-20 21:32:46,990 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:32:46,991 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:32:46,991 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:32:46,991 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:32:46,991 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.007F/input/input185
2024-09-20 21:32:46,991 DEBUG:	asus 0003:0B05:1ABE.007F: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:32:46,991 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0080/input/input186
2024-09-20 21:32:46,991 DEBUG:	asus 0003:0B05:1ABE.0080: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:32:46,991 DEBUG:	asus 0003:0B05:1ABE.0081: Fixing up Asus N-Key report descriptor
2024-09-20 21:32:46,991 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0081/input/input187
2024-09-20 21:32:46,991 DEBUG:	asus 0003:0B05:1ABE.0081: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:32:46,991 DEBUG:	usb 1-2: new full-speed USB device number 77 using xhci_hcd
2024-09-20 21:32:46,992 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:32:46,992 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:32:46,992 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:32:46,992 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:32:46,992 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:32:46,993 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input188
2024-09-20 21:32:46,993 DEBUG:	input input188: unable to receive magic message: -32
2024-09-20 21:32:46,993 INFO:	○ Suspend count: 1
2024-09-20 21:32:46,993 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:32:46,993 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:32:46,993 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:32:46,993 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:32:46,993 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:32:46,994 INFO:	○ gpe10 increased from 113 to 115
2024-09-20 21:32:46,994 INFO:	✅ Userspace suspended for 0:02:04.975069
2024-09-20 21:32:46,994 DEBUG:	Kernel suspended for total of 0:01:59.503000 (95.62%)
2024-09-20 21:32:46,994 INFO:	✅ In a hardware sleep state for 0:01:58.946289 (95.18%)
2024-09-20 21:32:46,995 DEBUG:	BAT0 energy level is 20135000 µWh
2024-09-20 21:32:46,995 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:32:48,995 INFO:	Suspend cycle 29: Started at 2024-09-20 21:32:48.995579 (cycle finish expected @ 2024-09-20 21:34:52.995611)
2024-09-20 21:34:53,992 INFO:	Results from last s2idle cycle
2024-09-20 21:34:53,993 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:34:53,993 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 21:34:53,993 DEBUG:	Freezing user space processes
2024-09-20 21:34:53,993 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:34:53,993 DEBUG:	OOM killer disabled.
2024-09-20 21:34:53,993 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:34:53,993 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:34:53,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:34:53,993 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:34:53,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:34:53,993 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:34:53,993 DEBUG:	PM: suspend of devices complete after 350.622 msecs
2024-09-20 21:34:53,994 DEBUG:	PM: start suspend of devices complete after 351.408 msecs
2024-09-20 21:34:53,994 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:34:53,994 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:34:53,994 DEBUG:	PM: late suspend of devices complete after 0.930 msecs
2024-09-20 21:34:53,994 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:34:53,995 DEBUG:	PM: noirq suspend of devices complete after 95.121 msecs
2024-09-20 21:34:53,995 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:34:53,995 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:34:53,995 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:34:53,995 DEBUG:	PM: suspend-to-idle
2024-09-20 21:34:53,995 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:34:53,996 DEBUG:	Timekeeping suspended for 119.516 seconds
2024-09-20 21:34:53,996 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:34:53,996 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:34:53,996 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:34:53,996 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:34:53,996 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:34:53,996 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:34:53,996 DEBUG:	PM: noirq resume of devices complete after 159.887 msecs
2024-09-20 21:34:53,996 DEBUG:	PM: early resume of devices complete after 3.040 msecs
2024-09-20 21:34:53,996 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:34:53,996 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:34:53,996 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:34:53,996 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:34:53,996 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:34:53,996 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:34:53,996 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:34:53,996 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:34:53,996 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:34:53,996 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:34:53,997 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:34:53,997 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:34:53,997 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:34:53,997 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:34:53,997 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:34:53,997 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:34:53,997 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:34:53,997 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:34:53,997 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:34:53,997 DEBUG:	PM: resume of devices complete after 2807.409 msecs
2024-09-20 21:34:53,997 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:34:53,997 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:34:53,997 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:34:53,997 DEBUG:	OOM killer enabled.
2024-09-20 21:34:53,997 DEBUG:	Restarting tasks ... 
2024-09-20 21:34:53,997 DEBUG:	usb 1-2: USB disconnect, device number 77
2024-09-20 21:34:53,997 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:34:53,997 DEBUG:	done.
2024-09-20 21:34:53,997 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:34:53,997 DEBUG:	usb 1-3: USB disconnect, device number 76
2024-09-20 21:34:53,997 DEBUG:	PM: suspend exit
2024-09-20 21:34:53,997 DEBUG:	usb 1-3: new full-speed USB device number 78 using xhci_hcd
2024-09-20 21:34:53,998 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:34:53,998 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:34:53,998 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:34:53,998 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:34:53,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0082/input/input189
2024-09-20 21:34:53,998 DEBUG:	asus 0003:0B05:1ABE.0082: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:34:53,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0083/input/input190
2024-09-20 21:34:53,998 DEBUG:	asus 0003:0B05:1ABE.0083: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:34:53,998 DEBUG:	asus 0003:0B05:1ABE.0084: Fixing up Asus N-Key report descriptor
2024-09-20 21:34:53,998 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0084/input/input191
2024-09-20 21:34:53,998 DEBUG:	asus 0003:0B05:1ABE.0084: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:34:53,998 DEBUG:	usb 1-2: new full-speed USB device number 79 using xhci_hcd
2024-09-20 21:34:53,998 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:34:53,998 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:34:53,998 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:34:53,998 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:34:53,998 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:34:53,998 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input192
2024-09-20 21:34:53,998 DEBUG:	input input192: unable to receive magic message: -32
2024-09-20 21:34:53,998 INFO:	○ Suspend count: 1
2024-09-20 21:34:53,998 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:34:53,998 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:34:53,998 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:34:53,998 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:34:53,998 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:34:53,998 INFO:	○ gpe10 increased from 115 to 117
2024-09-20 21:34:53,999 INFO:	✅ Userspace suspended for 0:02:05.003561
2024-09-20 21:34:53,999 DEBUG:	Kernel suspended for total of 0:01:59.516000 (95.61%)
2024-09-20 21:34:53,999 INFO:	✅ In a hardware sleep state for 0:01:58.949280 (95.16%)
2024-09-20 21:34:53,999 DEBUG:	BAT0 energy level is 20103000 µWh
2024-09-20 21:34:53,999 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:34:56,000 INFO:	Suspend cycle 30: Started at 2024-09-20 21:34:56.000192 (cycle finish expected @ 2024-09-20 21:37:00.000216)
2024-09-20 21:37:01,006 INFO:	Results from last s2idle cycle
2024-09-20 21:37:01,007 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:37:01,007 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 21:37:01,007 DEBUG:	Freezing user space processes
2024-09-20 21:37:01,007 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:37:01,007 DEBUG:	OOM killer disabled.
2024-09-20 21:37:01,007 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:37:01,008 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:37:01,008 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:37:01,008 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:37:01,008 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:37:01,008 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:37:01,008 DEBUG:	PM: suspend of devices complete after 335.077 msecs
2024-09-20 21:37:01,008 DEBUG:	PM: start suspend of devices complete after 335.848 msecs
2024-09-20 21:37:01,008 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:37:01,008 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:37:01,008 DEBUG:	PM: late suspend of devices complete after 0.813 msecs
2024-09-20 21:37:01,009 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:37:01,009 DEBUG:	PM: noirq suspend of devices complete after 127.543 msecs
2024-09-20 21:37:01,009 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:37:01,009 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:37:01,009 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:37:01,010 DEBUG:	PM: suspend-to-idle
2024-09-20 21:37:01,010 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:37:01,010 DEBUG:	Timekeeping suspended for 119.493 seconds
2024-09-20 21:37:01,010 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:37:01,010 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:37:01,010 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:37:01,010 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:37:01,010 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:37:01,010 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:37:01,010 DEBUG:	PM: noirq resume of devices complete after 163.530 msecs
2024-09-20 21:37:01,011 DEBUG:	PM: early resume of devices complete after 3.144 msecs
2024-09-20 21:37:01,011 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:37:01,011 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:37:01,011 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:37:01,011 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:37:01,011 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:37:01,011 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:37:01,011 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:37:01,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:37:01,011 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:37:01,011 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:37:01,012 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:37:01,012 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:37:01,012 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:37:01,012 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:37:01,012 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:37:01,012 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:37:01,012 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:37:01,012 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:37:01,012 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:37:01,012 DEBUG:	PM: resume of devices complete after 2807.751 msecs
2024-09-20 21:37:01,012 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:37:01,012 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:37:01,012 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:37:01,012 DEBUG:	OOM killer enabled.
2024-09-20 21:37:01,012 DEBUG:	Restarting tasks ... 
2024-09-20 21:37:01,012 DEBUG:	usb 1-2: USB disconnect, device number 79
2024-09-20 21:37:01,012 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:37:01,013 DEBUG:	done.
2024-09-20 21:37:01,013 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:37:01,013 DEBUG:	PM: suspend exit
2024-09-20 21:37:01,013 DEBUG:	usb 1-3: USB disconnect, device number 78
2024-09-20 21:37:01,013 DEBUG:	usb 1-3: new full-speed USB device number 80 using xhci_hcd
2024-09-20 21:37:01,013 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:37:01,013 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:37:01,013 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:37:01,013 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:37:01,013 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0085/input/input193
2024-09-20 21:37:01,013 DEBUG:	asus 0003:0B05:1ABE.0085: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:37:01,013 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0086/input/input194
2024-09-20 21:37:01,013 DEBUG:	asus 0003:0B05:1ABE.0086: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:37:01,013 DEBUG:	asus 0003:0B05:1ABE.0087: Fixing up Asus N-Key report descriptor
2024-09-20 21:37:01,013 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0087/input/input195
2024-09-20 21:37:01,013 DEBUG:	asus 0003:0B05:1ABE.0087: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:37:01,013 DEBUG:	usb 1-2: new full-speed USB device number 81 using xhci_hcd
2024-09-20 21:37:01,013 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:37:01,013 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:37:01,013 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:37:01,013 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:37:01,013 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:37:01,013 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input196
2024-09-20 21:37:01,013 DEBUG:	input input196: unable to receive magic message: -32
2024-09-20 21:37:01,013 DEBUG:	input input196: unable to receive magic message: -32
2024-09-20 21:37:01,013 INFO:	○ Suspend count: 1
2024-09-20 21:37:01,013 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:37:01,013 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:37:01,013 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:37:01,013 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:37:01,013 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:37:01,014 INFO:	○ gpe10 increased from 117 to 119
2024-09-20 21:37:01,014 INFO:	✅ Userspace suspended for 0:02:05.014040
2024-09-20 21:37:01,014 DEBUG:	Kernel suspended for total of 0:01:59.493000 (95.58%)
2024-09-20 21:37:01,014 INFO:	✅ In a hardware sleep state for 0:01:58.929107 (95.13%)
2024-09-20 21:37:01,014 DEBUG:	BAT0 energy level is 20072000 µWh
2024-09-20 21:37:01,014 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 21:37:03,015 INFO:	Suspend cycle 31: Started at 2024-09-20 21:37:03.015365 (cycle finish expected @ 2024-09-20 21:39:07.015388)
2024-09-20 21:39:07,990 INFO:	Results from last s2idle cycle
2024-09-20 21:39:07,991 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:39:07,991 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 21:39:07,991 DEBUG:	Freezing user space processes
2024-09-20 21:39:07,991 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:39:07,991 DEBUG:	OOM killer disabled.
2024-09-20 21:39:07,991 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:39:07,991 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 21:39:07,991 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:39:07,991 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:39:07,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:39:07,991 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:39:07,991 DEBUG:	PM: suspend of devices complete after 337.348 msecs
2024-09-20 21:39:07,991 DEBUG:	PM: start suspend of devices complete after 338.011 msecs
2024-09-20 21:39:07,991 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:39:07,991 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:39:07,991 DEBUG:	PM: late suspend of devices complete after 0.762 msecs
2024-09-20 21:39:07,991 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:39:07,991 DEBUG:	PM: noirq suspend of devices complete after 102.258 msecs
2024-09-20 21:39:07,991 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:39:07,991 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:39:07,991 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:39:07,991 DEBUG:	PM: suspend-to-idle
2024-09-20 21:39:07,991 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:39:07,992 DEBUG:	Timekeeping suspended for 119.502 seconds
2024-09-20 21:39:07,992 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:39:07,992 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:39:07,992 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:39:07,992 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:39:07,992 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:39:07,992 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:39:07,992 DEBUG:	PM: noirq resume of devices complete after 165.512 msecs
2024-09-20 21:39:07,992 DEBUG:	PM: early resume of devices complete after 3.016 msecs
2024-09-20 21:39:07,992 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:39:07,992 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:39:07,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:39:07,992 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:39:07,992 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:39:07,992 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:39:07,992 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:39:07,992 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:39:07,992 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:39:07,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:39:07,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:39:07,993 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:39:07,993 DEBUG:	PM: resume of devices complete after 2804.462 msecs
2024-09-20 21:39:07,993 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:39:07,993 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:39:07,993 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:39:07,993 DEBUG:	OOM killer enabled.
2024-09-20 21:39:07,993 DEBUG:	Restarting tasks ... 
2024-09-20 21:39:07,993 DEBUG:	usb 1-2: USB disconnect, device number 81
2024-09-20 21:39:07,993 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:39:07,993 DEBUG:	done.
2024-09-20 21:39:07,993 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:39:07,993 DEBUG:	PM: suspend exit
2024-09-20 21:39:07,993 DEBUG:	usb 1-3: USB disconnect, device number 80
2024-09-20 21:39:07,993 DEBUG:	usb 1-3: new full-speed USB device number 82 using xhci_hcd
2024-09-20 21:39:07,993 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:39:07,993 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:39:07,993 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:39:07,993 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:39:07,993 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0088/input/input197
2024-09-20 21:39:07,993 DEBUG:	asus 0003:0B05:1ABE.0088: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:39:07,993 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0089/input/input198
2024-09-20 21:39:07,993 DEBUG:	asus 0003:0B05:1ABE.0089: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:39:07,993 DEBUG:	asus 0003:0B05:1ABE.008A: Fixing up Asus N-Key report descriptor
2024-09-20 21:39:07,993 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.008A/input/input199
2024-09-20 21:39:07,993 DEBUG:	asus 0003:0B05:1ABE.008A: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:39:07,993 DEBUG:	usb 1-2: new full-speed USB device number 83 using xhci_hcd
2024-09-20 21:39:07,993 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:39:07,993 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:39:07,993 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:39:07,993 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:39:07,993 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:39:07,993 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input200
2024-09-20 21:39:07,993 DEBUG:	input input200: unable to receive magic message: -32
2024-09-20 21:39:07,994 INFO:	○ Suspend count: 1
2024-09-20 21:39:07,994 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:39:07,994 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:39:07,994 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:39:07,994 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:39:07,995 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:39:07,996 INFO:	○ gpe10 increased from 119 to 121
2024-09-20 21:39:07,997 INFO:	✅ Userspace suspended for 0:02:04.981669
2024-09-20 21:39:07,997 DEBUG:	Kernel suspended for total of 0:01:59.502000 (95.62%)
2024-09-20 21:39:07,997 INFO:	✅ In a hardware sleep state for 0:01:58.937988 (95.16%)
2024-09-20 21:39:07,998 DEBUG:	BAT0 energy level is 20040000 µWh
2024-09-20 21:39:07,998 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:39:09,998 INFO:	Suspend cycle 32: Started at 2024-09-20 21:39:09.998558 (cycle finish expected @ 2024-09-20 21:41:13.998574)
2024-09-20 21:41:14,989 INFO:	Results from last s2idle cycle
2024-09-20 21:41:14,989 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:41:14,989 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 21:41:14,989 DEBUG:	Freezing user space processes
2024-09-20 21:41:14,989 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:41:14,989 DEBUG:	OOM killer disabled.
2024-09-20 21:41:14,989 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:41:14,989 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:41:14,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:41:14,990 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:41:14,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:41:14,990 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:41:14,990 DEBUG:	PM: suspend of devices complete after 338.186 msecs
2024-09-20 21:41:14,990 DEBUG:	PM: start suspend of devices complete after 338.946 msecs
2024-09-20 21:41:14,990 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:41:14,990 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:41:14,990 DEBUG:	PM: late suspend of devices complete after 0.999 msecs
2024-09-20 21:41:14,990 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:41:14,990 DEBUG:	PM: noirq suspend of devices complete after 105.902 msecs
2024-09-20 21:41:14,990 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:41:14,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:41:14,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:41:14,990 DEBUG:	PM: suspend-to-idle
2024-09-20 21:41:14,990 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:41:14,990 DEBUG:	Timekeeping suspended for 119.514 seconds
2024-09-20 21:41:14,990 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:41:14,990 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:41:14,990 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:41:14,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:41:14,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:41:14,990 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:41:14,990 DEBUG:	PM: noirq resume of devices complete after 161.564 msecs
2024-09-20 21:41:14,990 DEBUG:	PM: early resume of devices complete after 2.765 msecs
2024-09-20 21:41:14,990 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:41:14,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:41:14,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:41:14,991 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:41:14,991 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:41:14,991 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:41:14,991 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:41:14,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:41:14,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:41:14,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:41:14,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:41:14,992 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:41:14,992 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:41:14,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:41:14,993 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:41:14,993 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:41:14,993 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:41:14,993 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:41:14,993 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:41:14,993 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:41:14,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:41:14,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:41:14,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:41:14,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:41:14,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:41:14,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:41:14,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:41:14,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:41:14,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:41:14,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:41:14,994 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:41:14,994 DEBUG:	PM: resume of devices complete after 2806.447 msecs
2024-09-20 21:41:14,994 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:41:14,994 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:41:14,994 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:41:14,994 DEBUG:	OOM killer enabled.
2024-09-20 21:41:14,994 DEBUG:	Restarting tasks ... 
2024-09-20 21:41:14,994 DEBUG:	usb 1-2: USB disconnect, device number 83
2024-09-20 21:41:14,994 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:41:14,994 DEBUG:	done.
2024-09-20 21:41:14,994 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:41:14,994 DEBUG:	PM: suspend exit
2024-09-20 21:41:14,994 DEBUG:	usb 1-3: USB disconnect, device number 82
2024-09-20 21:41:14,994 DEBUG:	usb 1-3: new full-speed USB device number 84 using xhci_hcd
2024-09-20 21:41:14,994 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:41:14,994 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:41:14,994 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:41:14,994 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:41:14,994 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.008B/input/input201
2024-09-20 21:41:14,994 DEBUG:	asus 0003:0B05:1ABE.008B: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:41:14,994 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.008C/input/input202
2024-09-20 21:41:14,994 DEBUG:	asus 0003:0B05:1ABE.008C: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:41:14,994 DEBUG:	asus 0003:0B05:1ABE.008D: Fixing up Asus N-Key report descriptor
2024-09-20 21:41:14,994 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.008D/input/input203
2024-09-20 21:41:14,994 DEBUG:	asus 0003:0B05:1ABE.008D: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:41:14,994 DEBUG:	usb 1-2: new full-speed USB device number 85 using xhci_hcd
2024-09-20 21:41:14,994 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:41:14,994 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:41:14,994 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:41:14,994 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:41:14,994 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:41:14,994 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input204
2024-09-20 21:41:14,994 DEBUG:	input input204: unable to receive magic message: -32
2024-09-20 21:41:14,994 INFO:	○ Suspend count: 1
2024-09-20 21:41:14,994 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:41:14,994 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:41:14,994 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:41:14,995 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:41:14,995 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:41:14,995 INFO:	○ gpe10 increased from 121 to 123
2024-09-20 21:41:14,995 INFO:	✅ Userspace suspended for 0:02:04.997077
2024-09-20 21:41:14,995 DEBUG:	Kernel suspended for total of 0:01:59.514000 (95.61%)
2024-09-20 21:41:14,995 INFO:	✅ In a hardware sleep state for 0:01:58.953094 (95.16%)
2024-09-20 21:41:14,996 DEBUG:	BAT0 energy level is 19992000 µWh
2024-09-20 21:41:14,996 INFO:	🔋 Battery BAT0 lost 48000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 21:41:16,996 INFO:	Suspend cycle 33: Started at 2024-09-20 21:41:16.996674 (cycle finish expected @ 2024-09-20 21:43:20.996689)
2024-09-20 21:43:21,996 INFO:	Results from last s2idle cycle
2024-09-20 21:43:21,997 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:43:21,997 DEBUG:	Filesystems sync: 0.033 seconds
2024-09-20 21:43:21,997 DEBUG:	Freezing user space processes
2024-09-20 21:43:21,997 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:43:21,997 DEBUG:	OOM killer disabled.
2024-09-20 21:43:21,997 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:43:21,998 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-20 21:43:21,998 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:43:21,998 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:43:21,998 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:43:21,998 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:43:21,998 DEBUG:	PM: suspend of devices complete after 340.778 msecs
2024-09-20 21:43:21,998 DEBUG:	PM: start suspend of devices complete after 341.344 msecs
2024-09-20 21:43:21,998 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:43:21,998 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:43:21,998 DEBUG:	PM: late suspend of devices complete after 0.990 msecs
2024-09-20 21:43:21,998 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:43:21,998 DEBUG:	PM: noirq suspend of devices complete after 103.918 msecs
2024-09-20 21:43:21,998 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:43:21,998 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:43:21,998 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:43:21,998 DEBUG:	PM: suspend-to-idle
2024-09-20 21:43:21,998 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:43:21,998 DEBUG:	Timekeeping suspended for 119.516 seconds
2024-09-20 21:43:21,998 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:43:21,998 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:43:21,998 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:43:21,998 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:43:21,998 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:43:21,998 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:43:21,998 DEBUG:	PM: noirq resume of devices complete after 164.573 msecs
2024-09-20 21:43:21,999 DEBUG:	PM: early resume of devices complete after 2.768 msecs
2024-09-20 21:43:21,999 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:43:21,999 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:43:21,999 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:43:21,999 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:43:22,000 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:43:22,000 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:43:22,000 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:43:22,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:43:22,000 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:43:22,001 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:43:22,001 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:43:22,001 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:43:22,001 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:43:22,001 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:43:22,001 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:43:22,002 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:43:22,002 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:43:22,002 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:43:22,002 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:43:22,002 DEBUG:	PM: resume of devices complete after 2803.898 msecs
2024-09-20 21:43:22,002 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:43:22,002 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:43:22,002 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:43:22,002 DEBUG:	OOM killer enabled.
2024-09-20 21:43:22,002 DEBUG:	Restarting tasks ... 
2024-09-20 21:43:22,002 DEBUG:	usb 1-2: USB disconnect, device number 85
2024-09-20 21:43:22,002 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:43:22,002 DEBUG:	done.
2024-09-20 21:43:22,002 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:43:22,002 DEBUG:	PM: suspend exit
2024-09-20 21:43:22,002 DEBUG:	usb 1-3: USB disconnect, device number 84
2024-09-20 21:43:22,002 DEBUG:	usb 1-3: new full-speed USB device number 86 using xhci_hcd
2024-09-20 21:43:22,002 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:43:22,002 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:43:22,002 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:43:22,002 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:43:22,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.008E/input/input205
2024-09-20 21:43:22,002 DEBUG:	asus 0003:0B05:1ABE.008E: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:43:22,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.008F/input/input206
2024-09-20 21:43:22,002 DEBUG:	asus 0003:0B05:1ABE.008F: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:43:22,002 DEBUG:	asus 0003:0B05:1ABE.0090: Fixing up Asus N-Key report descriptor
2024-09-20 21:43:22,002 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0090/input/input207
2024-09-20 21:43:22,002 DEBUG:	asus 0003:0B05:1ABE.0090: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:43:22,002 DEBUG:	usb 1-2: new full-speed USB device number 87 using xhci_hcd
2024-09-20 21:43:22,002 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:43:22,002 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:43:22,003 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:43:22,003 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:43:22,003 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:43:22,003 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input208
2024-09-20 21:43:22,003 DEBUG:	input input208: unable to receive magic message: -32
2024-09-20 21:43:22,003 INFO:	○ Suspend count: 1
2024-09-20 21:43:22,003 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:43:22,003 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:43:22,003 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:43:22,003 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:43:22,003 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:43:22,003 INFO:	○ gpe10 increased from 123 to 125
2024-09-20 21:43:22,004 INFO:	✅ Userspace suspended for 0:02:05.007363
2024-09-20 21:43:22,004 DEBUG:	Kernel suspended for total of 0:01:59.516000 (95.61%)
2024-09-20 21:43:22,004 INFO:	✅ In a hardware sleep state for 0:01:58.955688 (95.16%)
2024-09-20 21:43:22,004 DEBUG:	BAT0 energy level is 19960000 µWh
2024-09-20 21:43:22,004 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:43:24,005 INFO:	Suspend cycle 34: Started at 2024-09-20 21:43:24.005275 (cycle finish expected @ 2024-09-20 21:45:28.005290)
2024-09-20 21:45:28,991 INFO:	Results from last s2idle cycle
2024-09-20 21:45:28,992 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:45:28,992 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-20 21:45:28,992 DEBUG:	Freezing user space processes
2024-09-20 21:45:28,992 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:45:28,992 DEBUG:	OOM killer disabled.
2024-09-20 21:45:28,992 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:45:28,992 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:45:28,992 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:45:28,992 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:45:28,992 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:45:28,992 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:45:28,992 DEBUG:	PM: suspend of devices complete after 340.961 msecs
2024-09-20 21:45:28,992 DEBUG:	PM: start suspend of devices complete after 341.877 msecs
2024-09-20 21:45:28,992 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:45:28,992 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:45:28,992 DEBUG:	PM: late suspend of devices complete after 1.294 msecs
2024-09-20 21:45:28,992 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:45:28,992 DEBUG:	PM: noirq suspend of devices complete after 107.682 msecs
2024-09-20 21:45:28,992 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:45:28,992 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:45:28,992 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:45:28,992 DEBUG:	PM: suspend-to-idle
2024-09-20 21:45:28,992 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:45:28,992 DEBUG:	Timekeeping suspended for 119.502 seconds
2024-09-20 21:45:28,993 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:45:28,993 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:45:28,993 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:45:28,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:45:28,993 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:45:28,993 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:45:28,993 DEBUG:	PM: noirq resume of devices complete after 164.913 msecs
2024-09-20 21:45:28,993 DEBUG:	PM: early resume of devices complete after 3.070 msecs
2024-09-20 21:45:28,993 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:45:28,993 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:45:28,993 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:45:28,993 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:45:28,993 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:45:28,993 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:45:28,993 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:45:28,993 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:45:28,993 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:45:28,993 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:45:28,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:45:28,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:45:28,994 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:45:28,994 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:45:28,994 DEBUG:	PM: resume of devices complete after 2805.994 msecs
2024-09-20 21:45:28,995 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:45:28,995 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:45:28,995 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:45:28,995 DEBUG:	OOM killer enabled.
2024-09-20 21:45:28,995 DEBUG:	Restarting tasks ... 
2024-09-20 21:45:28,995 DEBUG:	usb 1-2: USB disconnect, device number 87
2024-09-20 21:45:28,996 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:45:28,996 DEBUG:	done.
2024-09-20 21:45:28,996 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:45:28,996 DEBUG:	PM: suspend exit
2024-09-20 21:45:28,996 DEBUG:	usb 1-3: USB disconnect, device number 86
2024-09-20 21:45:28,996 DEBUG:	usb 1-3: new full-speed USB device number 88 using xhci_hcd
2024-09-20 21:45:28,996 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:45:28,996 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:45:28,996 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:45:28,996 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:45:28,997 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0091/input/input209
2024-09-20 21:45:28,997 DEBUG:	asus 0003:0B05:1ABE.0091: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:45:28,997 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0092/input/input210
2024-09-20 21:45:28,997 DEBUG:	asus 0003:0B05:1ABE.0092: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:45:28,997 DEBUG:	asus 0003:0B05:1ABE.0093: Fixing up Asus N-Key report descriptor
2024-09-20 21:45:28,997 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0093/input/input211
2024-09-20 21:45:28,997 DEBUG:	asus 0003:0B05:1ABE.0093: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:45:28,997 DEBUG:	usb 1-2: new full-speed USB device number 89 using xhci_hcd
2024-09-20 21:45:28,997 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:45:28,997 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:45:28,997 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:45:28,997 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:45:28,997 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:45:28,997 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input212
2024-09-20 21:45:28,997 DEBUG:	input input212: unable to receive magic message: -32
2024-09-20 21:45:28,997 INFO:	○ Suspend count: 1
2024-09-20 21:45:28,997 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:45:28,997 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:45:28,997 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:45:28,997 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:45:28,997 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:45:28,997 INFO:	○ gpe10 increased from 125 to 127
2024-09-20 21:45:28,998 INFO:	✅ Userspace suspended for 0:02:04.992849
2024-09-20 21:45:28,998 DEBUG:	Kernel suspended for total of 0:01:59.502000 (95.61%)
2024-09-20 21:45:28,998 INFO:	✅ In a hardware sleep state for 0:01:58.940582 (95.16%)
2024-09-20 21:45:28,998 DEBUG:	BAT0 energy level is 19928000 µWh
2024-09-20 21:45:28,998 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:45:30,999 INFO:	Suspend cycle 35: Started at 2024-09-20 21:45:30.999394 (cycle finish expected @ 2024-09-20 21:47:34.999421)
2024-09-20 21:47:36,011 INFO:	Results from last s2idle cycle
2024-09-20 21:47:36,017 DEBUG:	PM: suspend entry (s2idle)
2024-09-20 21:47:36,017 DEBUG:	Filesystems sync: 0.040 seconds
2024-09-20 21:47:36,017 DEBUG:	Freezing user space processes
2024-09-20 21:47:36,017 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-20 21:47:36,017 DEBUG:	OOM killer disabled.
2024-09-20 21:47:36,017 DEBUG:	Freezing remaining freezable tasks
2024-09-20 21:47:36,017 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-20 21:47:36,017 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-20 21:47:36,017 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-20 21:47:36,017 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-20 21:47:36,017 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-20 21:47:36,017 DEBUG:	PM: suspend of devices complete after 345.521 msecs
2024-09-20 21:47:36,017 DEBUG:	PM: start suspend of devices complete after 346.389 msecs
2024-09-20 21:47:36,017 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-20 21:47:36,017 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-20 21:47:36,017 DEBUG:	PM: late suspend of devices complete after 1.267 msecs
2024-09-20 21:47:36,018 DEBUG:	ACPI: EC: interrupt blocked
2024-09-20 21:47:36,018 DEBUG:	PM: noirq suspend of devices complete after 99.123 msecs
2024-09-20 21:47:36,018 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-20 21:47:36,018 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-20 21:47:36,018 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-20 21:47:36,018 DEBUG:	PM: suspend-to-idle
2024-09-20 21:47:36,018 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x3ffb3eb5
2024-09-20 21:47:36,018 DEBUG:	Timekeeping suspended for 119.505 seconds
2024-09-20 21:47:36,018 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-20 21:47:36,018 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-20 21:47:36,018 DEBUG:	PM: resume from suspend-to-idle
2024-09-20 21:47:36,018 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-20 21:47:36,018 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-20 21:47:36,018 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-20 21:47:36,018 DEBUG:	PM: noirq resume of devices complete after 164.524 msecs
2024-09-20 21:47:36,018 DEBUG:	PM: early resume of devices complete after 3.022 msecs
2024-09-20 21:47:36,018 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-20 21:47:36,018 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:47:36,018 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:47:36,018 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-20 21:47:36,018 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-20 21:47:36,018 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-20 21:47:36,018 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-20 21:47:36,018 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-20 21:47:36,018 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-20 21:47:36,018 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-20 21:47:36,018 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-20 21:47:36,018 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-20 21:47:36,018 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-20 21:47:36,018 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:47:36,019 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-20 21:47:36,019 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:47:36,019 DEBUG:	PM: resume of devices complete after 2807.841 msecs
2024-09-20 21:47:36,019 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-20 21:47:36,019 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-20 21:47:36,019 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-20 21:47:36,019 DEBUG:	OOM killer enabled.
2024-09-20 21:47:36,019 DEBUG:	Restarting tasks ... 
2024-09-20 21:47:36,019 DEBUG:	usb 1-2: USB disconnect, device number 89
2024-09-20 21:47:36,019 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-20 21:47:36,019 DEBUG:	done.
2024-09-20 21:47:36,019 DEBUG:	random: crng reseeded on system resumption
2024-09-20 21:47:36,019 DEBUG:	PM: suspend exit
2024-09-20 21:47:36,019 DEBUG:	usb 1-3: USB disconnect, device number 88
2024-09-20 21:47:36,019 DEBUG:	usb 1-3: new full-speed USB device number 90 using xhci_hcd
2024-09-20 21:47:36,019 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-20 21:47:36,019 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-20 21:47:36,019 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-20 21:47:36,019 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-20 21:47:36,019 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0094/input/input213
2024-09-20 21:47:36,019 DEBUG:	asus 0003:0B05:1ABE.0094: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-20 21:47:36,019 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0095/input/input214
2024-09-20 21:47:36,019 DEBUG:	asus 0003:0B05:1ABE.0095: input,hidraw4: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-20 21:47:36,019 DEBUG:	asus 0003:0B05:1ABE.0096: Fixing up Asus N-Key report descriptor
2024-09-20 21:47:36,019 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0096/input/input215
2024-09-20 21:47:36,019 DEBUG:	asus 0003:0B05:1ABE.0096: input,hiddev96,hidraw5: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-20 21:47:36,019 DEBUG:	usb 1-2: new full-speed USB device number 91 using xhci_hcd
2024-09-20 21:47:36,019 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-20 21:47:36,019 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-20 21:47:36,019 DEBUG:	usb 1-2: Product: Controller
2024-09-20 21:47:36,019 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-20 21:47:36,019 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-20 21:47:36,019 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input216
2024-09-20 21:47:36,019 INFO:	○ Suspend count: 1
2024-09-20 21:47:36,019 INFO:	○ Hardware sleep cycle count: 1
2024-09-20 21:47:36,019 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-20 21:47:36,019 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-20 21:47:36,019 ERROR:	❌ ACPI BIOS errors found
2024-09-20 21:47:36,020 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:47:36,020 INFO:	○ gpe10 increased from 127 to 129
2024-09-20 21:47:36,020 INFO:	✅ Userspace suspended for 0:02:05.021214
2024-09-20 21:47:36,020 DEBUG:	Kernel suspended for total of 0:01:59.505000 (95.59%)
2024-09-20 21:47:36,020 INFO:	✅ In a hardware sleep state for 0:01:58.943390 (95.14%)
2024-09-20 21:47:36,021 DEBUG:	BAT0 energy level is 19897000 µWh
2024-09-20 21:47:36,021 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 21:47:38,021 INFO:	Suspend cycle 36: Started at 2024-09-20 21:47:38.021764 (cycle finish expected @ 2024-09-20 21:49:42.021778)
2024-09-20 21:49:42,990 INFO:	Results from last s2idle cycle
2024-09-20 21:49:42,991 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:49:42,991 INFO:	○ gpe10 increased from 129 to 131
2024-09-20 21:49:42,992 INFO:	✅ Userspace suspended for 0:02:04.970388
2024-09-20 21:49:42,992 INFO:	✅ In a hardware sleep state for 0:01:58.909393 (95.15%)
2024-09-20 21:49:42,993 DEBUG:	BAT0 energy level is 19865000 µWh
2024-09-20 21:49:42,993 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:49:44,993 INFO:	Suspend cycle 37: Started at 2024-09-20 21:49:44.993479 (cycle finish expected @ 2024-09-20 21:51:48.993500)
2024-09-20 21:51:49,986 INFO:	Results from last s2idle cycle
2024-09-20 21:51:49,986 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:51:49,987 INFO:	○ gpe10 increased from 131 to 133
2024-09-20 21:51:49,987 INFO:	✅ Userspace suspended for 0:02:04.993792
2024-09-20 21:51:49,987 INFO:	✅ In a hardware sleep state for 0:01:58.946167 (95.16%)
2024-09-20 21:51:49,993 DEBUG:	BAT0 energy level is 19833000 µWh
2024-09-20 21:51:49,993 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:51:51,994 INFO:	Suspend cycle 38: Started at 2024-09-20 21:51:51.994226 (cycle finish expected @ 2024-09-20 21:53:55.994245)
2024-09-20 21:53:57,001 INFO:	Results from last s2idle cycle
2024-09-20 21:53:57,001 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:53:57,002 INFO:	○ gpe10 increased from 133 to 135
2024-09-20 21:53:57,002 INFO:	✅ Userspace suspended for 0:02:05.008491
2024-09-20 21:53:57,002 INFO:	✅ In a hardware sleep state for 0:01:58.964019 (95.16%)
2024-09-20 21:53:57,005 DEBUG:	BAT0 energy level is 19801000 µWh
2024-09-20 21:53:57,005 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:53:59,006 INFO:	Suspend cycle 39: Started at 2024-09-20 21:53:59.006180 (cycle finish expected @ 2024-09-20 21:56:03.006196)
2024-09-20 21:56:04,006 INFO:	Results from last s2idle cycle
2024-09-20 21:56:04,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:56:04,007 INFO:	○ gpe10 increased from 135 to 137
2024-09-20 21:56:04,007 INFO:	✅ Userspace suspended for 0:02:05.001384
2024-09-20 21:56:04,007 INFO:	✅ In a hardware sleep state for 0:01:58.187011 (94.55%)
2024-09-20 21:56:04,010 DEBUG:	BAT0 energy level is 19769000 µWh
2024-09-20 21:56:04,010 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 21:56:06,011 INFO:	Suspend cycle 40: Started at 2024-09-20 21:56:06.011441 (cycle finish expected @ 2024-09-20 21:58:10.011460)
2024-09-20 21:58:11,006 INFO:	Results from last s2idle cycle
2024-09-20 21:58:11,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 21:58:11,008 INFO:	○ gpe10 increased from 137 to 139
2024-09-20 21:58:11,008 INFO:	✅ Userspace suspended for 0:02:04.997090
2024-09-20 21:58:11,008 INFO:	✅ In a hardware sleep state for 0:01:58.935394 (95.15%)
2024-09-20 21:58:11,011 DEBUG:	BAT0 energy level is 19722000 µWh
2024-09-20 21:58:11,011 INFO:	🔋 Battery BAT0 lost 47000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 21:58:13,012 INFO:	Suspend cycle 41: Started at 2024-09-20 21:58:13.012081 (cycle finish expected @ 2024-09-20 22:00:17.012098)
2024-09-20 21:58:21,442 ERROR:	❌ Failed to suspend
2024-09-20 21:58:21,442 DEBUG:	[Errno 16] Device or resource busy
2024-09-20 21:58:23,443 INFO:	Suspend cycle 42: Started at 2024-09-20 21:58:23.443283 (cycle finish expected @ 2024-09-20 22:00:27.443302)
2024-09-20 22:00:28,003 INFO:	Results from last s2idle cycle
2024-09-20 22:00:28,003 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:00:28,004 INFO:	○ gpe10 increased from 139 to 145
2024-09-20 22:00:28,004 INFO:	✅ Userspace suspended for 0:02:04.561667
2024-09-20 22:00:28,005 INFO:	✅ In a hardware sleep state for 0:01:58.525757 (95.15%)
2024-09-20 22:00:28,006 DEBUG:	BAT0 energy level is 19674000 µWh
2024-09-20 22:00:28,006 INFO:	🔋 Battery BAT0 lost 48000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 22:00:30,007 INFO:	Suspend cycle 43: Started at 2024-09-20 22:00:30.006899 (cycle finish expected @ 2024-09-20 22:02:34.006918)
2024-09-20 22:02:34,982 INFO:	Results from last s2idle cycle
2024-09-20 22:02:34,982 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:02:34,983 INFO:	○ gpe10 increased from 145 to 147
2024-09-20 22:02:34,983 INFO:	✅ Userspace suspended for 0:02:04.976672
2024-09-20 22:02:34,983 INFO:	✅ In a hardware sleep state for 0:01:58.979767 (95.20%)
2024-09-20 22:02:34,988 DEBUG:	BAT0 energy level is 19642000 µWh
2024-09-20 22:02:34,988 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:02:36,988 INFO:	Suspend cycle 44: Started at 2024-09-20 22:02:36.988562 (cycle finish expected @ 2024-09-20 22:04:40.988582)
2024-09-20 22:04:41,997 INFO:	Results from last s2idle cycle
2024-09-20 22:04:41,998 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:04:41,999 INFO:	○ gpe10 increased from 147 to 149
2024-09-20 22:04:41,999 INFO:	✅ Userspace suspended for 0:02:05.011290
2024-09-20 22:04:41,999 INFO:	✅ In a hardware sleep state for 0:01:58.973571 (95.17%)
2024-09-20 22:04:42,006 DEBUG:	BAT0 energy level is 19610000 µWh
2024-09-20 22:04:42,007 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:04:44,007 INFO:	Suspend cycle 45: Started at 2024-09-20 22:04:44.007505 (cycle finish expected @ 2024-09-20 22:06:48.007529)
2024-09-20 22:06:47,006 ERROR:	❌ Failed to suspend
2024-09-20 22:06:47,006 DEBUG:	[Errno 16] Device or resource busy
2024-09-20 22:06:49,007 INFO:	Suspend cycle 46: Started at 2024-09-20 22:06:49.007062 (cycle finish expected @ 2024-09-20 22:08:53.007080)
2024-09-20 22:08:53,988 INFO:	Results from last s2idle cycle
2024-09-20 22:08:53,988 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:08:53,989 INFO:	○ gpe10 increased from 149 to 155
2024-09-20 22:08:53,989 INFO:	✅ Userspace suspended for 0:02:04.982518
2024-09-20 22:08:53,989 INFO:	✅ In a hardware sleep state for 0:01:58.956054 (95.18%)
2024-09-20 22:08:53,990 DEBUG:	BAT0 energy level is 19531000 µWh
2024-09-20 22:08:53,990 INFO:	🔋 Battery BAT0 lost 79000 µWh (0.24%) [Average rate 0.23W]
2024-09-20 22:08:55,990 INFO:	Suspend cycle 47: Started at 2024-09-20 22:08:55.990623 (cycle finish expected @ 2024-09-20 22:10:59.990635)
2024-09-20 22:10:59,010 ERROR:	❌ Failed to suspend
2024-09-20 22:10:59,010 DEBUG:	[Errno 16] Device or resource busy
2024-09-20 22:11:01,011 INFO:	Suspend cycle 48: Started at 2024-09-20 22:11:01.011274 (cycle finish expected @ 2024-09-20 22:13:05.011296)
2024-09-20 22:13:05,986 INFO:	Results from last s2idle cycle
2024-09-20 22:13:05,986 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:13:05,987 INFO:	○ gpe10 increased from 155 to 161
2024-09-20 22:13:05,987 INFO:	✅ Userspace suspended for 0:02:04.976225
2024-09-20 22:13:05,987 INFO:	✅ In a hardware sleep state for 0:01:58.203247 (94.58%)
2024-09-20 22:13:06,001 DEBUG:	BAT0 energy level is 19467000 µWh
2024-09-20 22:13:06,001 INFO:	🔋 Battery BAT0 lost 64000 µWh (0.19%) [Average rate 0.18W]
2024-09-20 22:13:08,001 INFO:	Suspend cycle 49: Started at 2024-09-20 22:13:08.001786 (cycle finish expected @ 2024-09-20 22:15:12.001809)
2024-09-20 22:15:13,005 INFO:	Results from last s2idle cycle
2024-09-20 22:15:13,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:15:13,007 INFO:	○ gpe10 increased from 161 to 163
2024-09-20 22:15:13,007 INFO:	✅ Userspace suspended for 0:02:05.005500
2024-09-20 22:15:13,007 INFO:	✅ In a hardware sleep state for 0:01:58.976135 (95.18%)
2024-09-20 22:15:13,010 DEBUG:	BAT0 energy level is 19435000 µWh
2024-09-20 22:15:13,010 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:15:15,011 INFO:	Suspend cycle 50: Started at 2024-09-20 22:15:15.010875 (cycle finish expected @ 2024-09-20 22:17:19.010902)
2024-09-20 22:17:19,988 INFO:	Results from last s2idle cycle
2024-09-20 22:17:19,988 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:17:19,989 INFO:	○ gpe10 increased from 163 to 165
2024-09-20 22:17:19,989 INFO:	✅ Userspace suspended for 0:02:04.978878
2024-09-20 22:17:19,989 INFO:	✅ In a hardware sleep state for 0:01:58.923553 (95.15%)
2024-09-20 22:17:19,992 DEBUG:	BAT0 energy level is 19404000 µWh
2024-09-20 22:17:19,992 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 22:17:21,992 INFO:	Suspend cycle 51: Started at 2024-09-20 22:17:21.992746 (cycle finish expected @ 2024-09-20 22:19:25.992770)
2024-09-20 22:19:27,015 INFO:	Results from last s2idle cycle
2024-09-20 22:19:27,016 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:19:27,017 INFO:	○ gpe10 increased from 165 to 167
2024-09-20 22:19:27,018 INFO:	✅ Userspace suspended for 0:02:05.025271
2024-09-20 22:19:27,018 INFO:	✅ In a hardware sleep state for 0:01:58.976349 (95.16%)
2024-09-20 22:19:27,019 DEBUG:	BAT0 energy level is 19356000 µWh
2024-09-20 22:19:27,019 INFO:	🔋 Battery BAT0 lost 48000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 22:19:29,020 INFO:	Suspend cycle 52: Started at 2024-09-20 22:19:29.020169 (cycle finish expected @ 2024-09-20 22:21:33.020189)
2024-09-20 22:21:33,991 INFO:	Results from last s2idle cycle
2024-09-20 22:21:33,992 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:21:33,992 INFO:	○ gpe10 increased from 167 to 169
2024-09-20 22:21:33,993 INFO:	✅ Userspace suspended for 0:02:04.972870
2024-09-20 22:21:33,993 INFO:	✅ In a hardware sleep state for 0:01:58.945648 (95.18%)
2024-09-20 22:21:34,006 DEBUG:	BAT0 energy level is 19324000 µWh
2024-09-20 22:21:34,006 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:21:36,007 INFO:	Suspend cycle 53: Started at 2024-09-20 22:21:36.006997 (cycle finish expected @ 2024-09-20 22:23:40.007019)
2024-09-20 22:23:41,005 INFO:	Results from last s2idle cycle
2024-09-20 22:23:41,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:23:41,006 INFO:	○ gpe10 increased from 169 to 171
2024-09-20 22:23:41,007 INFO:	✅ Userspace suspended for 0:02:05.000120
2024-09-20 22:23:41,007 INFO:	✅ In a hardware sleep state for 0:01:58.949585 (95.16%)
2024-09-20 22:23:41,010 DEBUG:	BAT0 energy level is 19292000 µWh
2024-09-20 22:23:41,010 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:23:43,010 INFO:	Suspend cycle 54: Started at 2024-09-20 22:23:43.010631 (cycle finish expected @ 2024-09-20 22:25:47.010650)
2024-09-20 22:25:47,991 INFO:	Results from last s2idle cycle
2024-09-20 22:25:47,991 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:25:47,992 INFO:	○ gpe10 increased from 171 to 173
2024-09-20 22:25:47,992 INFO:	✅ Userspace suspended for 0:02:04.981960
2024-09-20 22:25:47,992 INFO:	✅ In a hardware sleep state for 0:01:58.956970 (95.18%)
2024-09-20 22:25:47,996 DEBUG:	BAT0 energy level is 19260000 µWh
2024-09-20 22:25:47,996 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:25:49,997 INFO:	Suspend cycle 55: Started at 2024-09-20 22:25:49.997286 (cycle finish expected @ 2024-09-20 22:27:53.997305)
2024-09-20 22:27:55,006 INFO:	Results from last s2idle cycle
2024-09-20 22:27:55,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:27:55,008 INFO:	○ gpe10 increased from 173 to 175
2024-09-20 22:27:55,008 INFO:	✅ Userspace suspended for 0:02:05.011091
2024-09-20 22:27:55,008 INFO:	✅ In a hardware sleep state for 0:01:58.950256 (95.15%)
2024-09-20 22:27:55,011 DEBUG:	BAT0 energy level is 19229000 µWh
2024-09-20 22:27:55,011 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 22:27:57,011 INFO:	Suspend cycle 56: Started at 2024-09-20 22:27:57.011828 (cycle finish expected @ 2024-09-20 22:30:01.011855)
2024-09-20 22:30:02,006 INFO:	Results from last s2idle cycle
2024-09-20 22:30:02,007 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:30:02,007 INFO:	○ gpe10 increased from 175 to 177
2024-09-20 22:30:02,008 INFO:	✅ Userspace suspended for 0:02:04.996484
2024-09-20 22:30:02,008 INFO:	✅ In a hardware sleep state for 0:01:58.950622 (95.16%)
2024-09-20 22:30:02,010 DEBUG:	BAT0 energy level is 19197000 µWh
2024-09-20 22:30:02,010 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:30:04,011 INFO:	Suspend cycle 57: Started at 2024-09-20 22:30:04.011528 (cycle finish expected @ 2024-09-20 22:32:08.011544)
2024-09-20 22:32:09,015 INFO:	Results from last s2idle cycle
2024-09-20 22:32:09,016 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:32:09,016 INFO:	○ gpe10 increased from 177 to 179
2024-09-20 22:32:09,017 INFO:	✅ Userspace suspended for 0:02:05.005579
2024-09-20 22:32:09,017 INFO:	✅ In a hardware sleep state for 0:01:58.921447 (95.13%)
2024-09-20 22:32:09,019 DEBUG:	BAT0 energy level is 19165000 µWh
2024-09-20 22:32:09,020 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:32:11,020 INFO:	Suspend cycle 58: Started at 2024-09-20 22:32:11.020333 (cycle finish expected @ 2024-09-20 22:34:15.020346)
2024-09-20 22:34:16,002 INFO:	Results from last s2idle cycle
2024-09-20 22:34:16,002 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:34:16,003 INFO:	○ gpe10 increased from 179 to 181
2024-09-20 22:34:16,003 INFO:	✅ Userspace suspended for 0:02:04.983464
2024-09-20 22:34:16,003 INFO:	✅ In a hardware sleep state for 0:01:58.933441 (95.16%)
2024-09-20 22:34:16,006 DEBUG:	BAT0 energy level is 19133000 µWh
2024-09-20 22:34:16,006 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:34:18,007 INFO:	Suspend cycle 59: Started at 2024-09-20 22:34:18.007454 (cycle finish expected @ 2024-09-20 22:36:22.007480)
2024-09-20 22:36:22,988 INFO:	Results from last s2idle cycle
2024-09-20 22:36:22,989 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:36:22,989 INFO:	○ gpe10 increased from 181 to 183
2024-09-20 22:36:22,989 INFO:	✅ Userspace suspended for 0:02:04.982294
2024-09-20 22:36:22,989 INFO:	✅ In a hardware sleep state for 0:01:58.183044 (94.56%)
2024-09-20 22:36:22,996 DEBUG:	BAT0 energy level is 19101000 µWh
2024-09-20 22:36:22,996 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:36:24,997 INFO:	Suspend cycle 60: Started at 2024-09-20 22:36:24.997030 (cycle finish expected @ 2024-09-20 22:38:28.997050)
2024-09-20 22:38:30,006 INFO:	Results from last s2idle cycle
2024-09-20 22:38:30,007 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:38:30,008 INFO:	○ gpe10 increased from 183 to 185
2024-09-20 22:38:30,009 INFO:	✅ Userspace suspended for 0:02:05.012279
2024-09-20 22:38:30,010 INFO:	✅ In a hardware sleep state for 0:01:58.951690 (95.15%)
2024-09-20 22:38:30,012 DEBUG:	BAT0 energy level is 19070000 µWh
2024-09-20 22:38:30,012 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 22:38:32,012 INFO:	Suspend cycle 61: Started at 2024-09-20 22:38:32.012602 (cycle finish expected @ 2024-09-20 22:40:36.012622)
2024-09-20 22:40:36,991 INFO:	Results from last s2idle cycle
2024-09-20 22:40:36,992 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:40:36,992 INFO:	○ gpe10 increased from 185 to 187
2024-09-20 22:40:36,992 INFO:	✅ Userspace suspended for 0:02:04.980247
2024-09-20 22:40:36,992 INFO:	✅ In a hardware sleep state for 0:01:58.924743 (95.15%)
2024-09-20 22:40:36,996 DEBUG:	BAT0 energy level is 19038000 µWh
2024-09-20 22:40:36,996 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:40:38,997 INFO:	Suspend cycle 62: Started at 2024-09-20 22:40:38.997013 (cycle finish expected @ 2024-09-20 22:42:42.997038)
2024-09-20 22:42:43,991 INFO:	Results from last s2idle cycle
2024-09-20 22:42:43,992 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:42:43,993 INFO:	○ gpe10 increased from 187 to 189
2024-09-20 22:42:43,993 INFO:	✅ Userspace suspended for 0:02:04.996232
2024-09-20 22:42:43,993 INFO:	✅ In a hardware sleep state for 0:01:58.972442 (95.18%)
2024-09-20 22:42:44,006 DEBUG:	BAT0 energy level is 19006000 µWh
2024-09-20 22:42:44,006 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:42:46,006 INFO:	Suspend cycle 63: Started at 2024-09-20 22:42:46.006833 (cycle finish expected @ 2024-09-20 22:44:50.006858)
2024-09-20 22:44:50,991 INFO:	Results from last s2idle cycle
2024-09-20 22:44:50,991 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:44:50,992 INFO:	○ gpe10 increased from 189 to 191
2024-09-20 22:44:50,993 INFO:	✅ Userspace suspended for 0:02:04.987029
2024-09-20 22:44:50,994 INFO:	✅ In a hardware sleep state for 0:01:58.948547 (95.17%)
2024-09-20 22:44:51,010 DEBUG:	BAT0 energy level is 18958000 µWh
2024-09-20 22:44:51,010 INFO:	🔋 Battery BAT0 lost 48000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 22:44:53,011 INFO:	Suspend cycle 64: Started at 2024-09-20 22:44:53.011010 (cycle finish expected @ 2024-09-20 22:46:57.011025)
2024-09-20 22:46:58,001 INFO:	Results from last s2idle cycle
2024-09-20 22:46:58,001 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:46:58,002 INFO:	○ gpe10 increased from 191 to 193
2024-09-20 22:46:58,003 INFO:	✅ Userspace suspended for 0:02:04.992101
2024-09-20 22:46:58,003 INFO:	✅ In a hardware sleep state for 0:01:58.939300 (95.16%)
2024-09-20 22:46:58,005 DEBUG:	BAT0 energy level is 18942000 µWh
2024-09-20 22:46:58,005 INFO:	🔋 Battery BAT0 lost 16000 µWh (0.05%) [Average rate 0.05W]
2024-09-20 22:47:00,006 INFO:	Suspend cycle 65: Started at 2024-09-20 22:47:00.006286 (cycle finish expected @ 2024-09-20 22:49:04.006302)
2024-09-20 22:49:05,005 INFO:	Results from last s2idle cycle
2024-09-20 22:49:05,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:49:05,007 INFO:	○ gpe10 increased from 193 to 195
2024-09-20 22:49:05,007 INFO:	✅ Userspace suspended for 0:02:05.001067
2024-09-20 22:49:05,007 INFO:	✅ In a hardware sleep state for 0:01:58.327026 (94.66%)
2024-09-20 22:49:05,010 DEBUG:	BAT0 energy level is 18911000 µWh
2024-09-20 22:49:05,010 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 22:49:07,011 INFO:	Suspend cycle 66: Started at 2024-09-20 22:49:07.011331 (cycle finish expected @ 2024-09-20 22:51:11.011348)
2024-09-20 22:51:11,990 INFO:	Results from last s2idle cycle
2024-09-20 22:51:11,990 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:51:11,991 INFO:	○ gpe10 increased from 195 to 197
2024-09-20 22:51:11,991 INFO:	✅ Userspace suspended for 0:02:04.980489
2024-09-20 22:51:11,991 INFO:	✅ In a hardware sleep state for 0:01:58.715851 (94.99%)
2024-09-20 22:51:11,997 DEBUG:	BAT0 energy level is 18879000 µWh
2024-09-20 22:51:11,997 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:51:13,997 INFO:	Suspend cycle 67: Started at 2024-09-20 22:51:13.997769 (cycle finish expected @ 2024-09-20 22:53:17.997785)
2024-09-20 22:53:18,990 INFO:	Results from last s2idle cycle
2024-09-20 22:53:18,991 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:53:18,992 INFO:	○ gpe10 increased from 197 to 199
2024-09-20 22:53:18,992 INFO:	✅ Userspace suspended for 0:02:04.994912
2024-09-20 22:53:18,992 INFO:	✅ In a hardware sleep state for 0:01:58.948944 (95.16%)
2024-09-20 22:53:19,000 DEBUG:	BAT0 energy level is 18847000 µWh
2024-09-20 22:53:19,000 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:53:21,001 INFO:	Suspend cycle 68: Started at 2024-09-20 22:53:21.000914 (cycle finish expected @ 2024-09-20 22:55:25.000933)
2024-09-20 22:55:26,016 INFO:	Results from last s2idle cycle
2024-09-20 22:55:26,017 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:55:26,017 INFO:	○ gpe10 increased from 199 to 201
2024-09-20 22:55:26,018 INFO:	✅ Userspace suspended for 0:02:05.017192
2024-09-20 22:55:26,018 INFO:	✅ In a hardware sleep state for 0:01:58.947021 (95.14%)
2024-09-20 22:55:26,019 DEBUG:	BAT0 energy level is 18815000 µWh
2024-09-20 22:55:26,020 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 22:55:28,021 INFO:	Suspend cycle 69: Started at 2024-09-20 22:55:28.021086 (cycle finish expected @ 2024-09-20 22:57:32.021100)
2024-09-20 22:57:32,992 INFO:	Results from last s2idle cycle
2024-09-20 22:57:32,992 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:57:32,993 INFO:	○ gpe10 increased from 201 to 203
2024-09-20 22:57:32,993 INFO:	✅ Userspace suspended for 0:02:04.972393
2024-09-20 22:57:32,993 INFO:	✅ In a hardware sleep state for 0:01:58.924011 (95.16%)
2024-09-20 22:57:32,996 DEBUG:	BAT0 energy level is 18767000 µWh
2024-09-20 22:57:32,996 INFO:	🔋 Battery BAT0 lost 48000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 22:57:34,997 INFO:	Suspend cycle 70: Started at 2024-09-20 22:57:34.997337 (cycle finish expected @ 2024-09-20 22:59:38.997354)
2024-09-20 22:59:40,005 INFO:	Results from last s2idle cycle
2024-09-20 22:59:40,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 22:59:40,006 INFO:	○ gpe10 increased from 203 to 205
2024-09-20 22:59:40,007 INFO:	✅ Userspace suspended for 0:02:05.009809
2024-09-20 22:59:40,007 INFO:	✅ In a hardware sleep state for 0:01:58.955353 (95.16%)
2024-09-20 22:59:40,008 DEBUG:	BAT0 energy level is 18736000 µWh
2024-09-20 22:59:40,008 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 22:59:42,009 INFO:	Suspend cycle 71: Started at 2024-09-20 22:59:42.009444 (cycle finish expected @ 2024-09-20 23:01:46.009459)
2024-09-20 23:01:46,996 INFO:	Results from last s2idle cycle
2024-09-20 23:01:47,001 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:01:47,001 INFO:	○ gpe10 increased from 205 to 207
2024-09-20 23:01:47,002 INFO:	✅ Userspace suspended for 0:02:04.992644
2024-09-20 23:01:47,002 INFO:	✅ In a hardware sleep state for 0:01:58.201202 (94.57%)
2024-09-20 23:01:47,002 DEBUG:	BAT0 energy level is 18688000 µWh
2024-09-20 23:01:47,003 INFO:	🔋 Battery BAT0 lost 48000 µWh (0.14%) [Average rate 0.14W]
2024-09-20 23:01:49,003 INFO:	Suspend cycle 72: Started at 2024-09-20 23:01:49.003452 (cycle finish expected @ 2024-09-20 23:03:53.003466)
2024-09-20 23:03:53,996 INFO:	Results from last s2idle cycle
2024-09-20 23:03:53,997 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:03:53,998 INFO:	○ gpe10 increased from 207 to 209
2024-09-20 23:03:53,998 INFO:	✅ Userspace suspended for 0:02:04.995455
2024-09-20 23:03:53,998 INFO:	✅ In a hardware sleep state for 0:01:58.949737 (95.16%)
2024-09-20 23:03:54,002 DEBUG:	BAT0 energy level is 18656000 µWh
2024-09-20 23:03:54,002 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 23:03:56,003 INFO:	Suspend cycle 73: Started at 2024-09-20 23:03:56.003054 (cycle finish expected @ 2024-09-20 23:06:00.003068)
2024-09-20 23:06:00,996 INFO:	Results from last s2idle cycle
2024-09-20 23:06:00,997 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:06:00,997 INFO:	○ gpe10 increased from 209 to 211
2024-09-20 23:06:00,997 INFO:	✅ Userspace suspended for 0:02:04.994895
2024-09-20 23:06:00,998 INFO:	✅ In a hardware sleep state for 0:01:58.951874 (95.17%)
2024-09-20 23:06:01,002 DEBUG:	BAT0 energy level is 18624000 µWh
2024-09-20 23:06:01,002 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 23:06:03,003 INFO:	Suspend cycle 74: Started at 2024-09-20 23:06:03.003391 (cycle finish expected @ 2024-09-20 23:08:07.003417)
2024-09-20 23:08:08,000 INFO:	Results from last s2idle cycle
2024-09-20 23:08:08,000 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:08:08,001 INFO:	○ gpe10 increased from 211 to 213
2024-09-20 23:08:08,001 INFO:	✅ Userspace suspended for 0:02:04.998105
2024-09-20 23:08:08,001 INFO:	✅ In a hardware sleep state for 0:01:58.956421 (95.17%)
2024-09-20 23:08:08,004 DEBUG:	BAT0 energy level is 18592000 µWh
2024-09-20 23:08:08,004 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 23:08:10,005 INFO:	Suspend cycle 75: Started at 2024-09-20 23:08:10.004969 (cycle finish expected @ 2024-09-20 23:10:14.004983)
2024-09-20 23:10:15,002 INFO:	Results from last s2idle cycle
2024-09-20 23:10:15,003 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:10:15,003 INFO:	○ gpe10 increased from 213 to 215
2024-09-20 23:10:15,004 INFO:	✅ Userspace suspended for 0:02:04.999030
2024-09-20 23:10:15,004 INFO:	✅ In a hardware sleep state for 0:01:58.953705 (95.16%)
2024-09-20 23:10:15,007 DEBUG:	BAT0 energy level is 18561000 µWh
2024-09-20 23:10:15,007 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 23:10:17,007 INFO:	Suspend cycle 76: Started at 2024-09-20 23:10:17.007633 (cycle finish expected @ 2024-09-20 23:12:21.007646)
2024-09-20 23:12:22,011 INFO:	Results from last s2idle cycle
2024-09-20 23:12:22,011 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:12:22,012 INFO:	○ gpe10 increased from 215 to 217
2024-09-20 23:12:22,012 INFO:	✅ Userspace suspended for 0:02:05.005060
2024-09-20 23:12:22,012 INFO:	✅ In a hardware sleep state for 0:01:58.954040 (95.16%)
2024-09-20 23:12:22,015 DEBUG:	BAT0 energy level is 18529000 µWh
2024-09-20 23:12:22,015 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 23:12:24,016 INFO:	Suspend cycle 77: Started at 2024-09-20 23:12:24.016439 (cycle finish expected @ 2024-09-20 23:14:28.016465)
2024-09-20 23:14:26,994 ERROR:	❌ Failed to suspend
2024-09-20 23:14:26,994 DEBUG:	[Errno 16] Device or resource busy
2024-09-20 23:14:28,995 INFO:	Suspend cycle 78: Started at 2024-09-20 23:14:28.995081 (cycle finish expected @ 2024-09-20 23:16:32.995098)
2024-09-20 23:16:33,997 INFO:	Results from last s2idle cycle
2024-09-20 23:16:33,997 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:16:33,998 INFO:	○ gpe10 increased from 217 to 223
2024-09-20 23:16:33,998 INFO:	✅ Userspace suspended for 0:02:05.003631
2024-09-20 23:16:33,998 INFO:	✅ In a hardware sleep state for 0:01:58.921112 (95.13%)
2024-09-20 23:16:34,002 DEBUG:	BAT0 energy level is 18465000 µWh
2024-09-20 23:16:34,002 INFO:	🔋 Battery BAT0 lost 64000 µWh (0.19%) [Average rate 0.18W]
2024-09-20 23:16:36,002 INFO:	Suspend cycle 79: Started at 2024-09-20 23:16:36.002640 (cycle finish expected @ 2024-09-20 23:18:40.002663)
2024-09-20 23:18:40,989 INFO:	Results from last s2idle cycle
2024-09-20 23:18:40,990 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:18:40,990 INFO:	○ gpe10 increased from 223 to 225
2024-09-20 23:18:40,990 INFO:	✅ Userspace suspended for 0:02:04.988238
2024-09-20 23:18:40,990 INFO:	✅ In a hardware sleep state for 0:01:58.913971 (95.14%)
2024-09-20 23:18:40,998 DEBUG:	BAT0 energy level is 18433000 µWh
2024-09-20 23:18:40,998 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.09W]
2024-09-20 23:18:42,998 INFO:	Suspend cycle 80: Started at 2024-09-20 23:18:42.998820 (cycle finish expected @ 2024-09-20 23:20:46.998837)
2024-09-20 23:20:47,999 INFO:	Results from last s2idle cycle
2024-09-20 23:20:47,999 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-20 23:20:48,000 INFO:	○ gpe10 increased from 225 to 227
2024-09-20 23:20:48,000 INFO:	✅ Userspace suspended for 0:02:05.002013
2024-09-20 23:20:48,000 INFO:	✅ In a hardware sleep state for 0:01:58.945404 (95.15%)
2024-09-20 23:20:48,006 DEBUG:	BAT0 energy level is 18402000 µWh
2024-09-20 23:20:48,006 INFO:	🔋 Battery BAT0 lost 31000 µWh (0.09%) [Average rate 0.09W]
2024-09-20 23:20:48,006 INFO:	Explanations for your system
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-20 23:20:48,006 WARNING:	🚦 ACPI BIOS Errors detected

This is with mcu_powersave=0

2024-09-19 23:38:25,186 INFO:	Debugging script for s2idle on AMD systems
2024-09-19 23:38:25,186 INFO:	💻 ASUSTeK COMPUTER INC. ROG Ally RC71L_RC71L (ROG Ally) running BIOS 5.29 (RC71L.339) released 07/02/2024 and EC 3.27
2024-09-19 23:38:25,186 INFO:	🐧 ChimeraOS 47 (8a71d33)
2024-09-19 23:38:25,186 INFO:	🐧 Kernel 6.11.0-00004-ge11bee8239e6-dirty
2024-09-19 23:38:25,190 DEBUG:	BAT0 energy level is 31969000 µWh
2024-09-19 23:38:25,190 INFO:	🔋 Battery BAT0 (ASUSTeK ASUS Battery) is operating at 83.74% of design
2024-09-19 23:38:25,190 INFO:	Checking prerequisites for s2idle
2024-09-19 23:38:25,190 INFO:	✅ Logs are provided via systemd
2024-09-19 23:38:25,190 INFO:	✅ AMD Ryzen Z1 Extreme (family 19 model 74)
2024-09-19 23:38:25,190 DEBUG:	SMT control: on
2024-09-19 23:38:25,190 INFO:	✅ SMT enabled
2024-09-19 23:38:25,190 INFO:	✅ LPS0 _DSM enabled
2024-09-19 23:38:25,195 INFO:	✅ ACPI FADT supports Low-power S0 idle
2024-09-19 23:38:25,195 DEBUG:	/sys/module/gpiolib_acpi/parameters/ignore_wake is not configured
2024-09-19 23:38:25,195 DEBUG:	/sys/module/gpiolib_acpi/parameters/ignore_interrupt is not configured
2024-09-19 23:38:25,195 DEBUG:	/proc/cmdline: rd.systemd.show_status=auto rd.udev.log_priority=3 preempt=full nowatchdog
2024-09-19 23:38:25,196 DEBUG:	LOGIND: no configuration changes
2024-09-19 23:38:25,197 INFO:	✅ HSMP driver `amd_hsmp` not detected (blocked: False)
2024-09-19 23:38:25,199 INFO:	✅ PMC driver `amd_pmc` loaded (Program 0 Firmware 76.71.0)
2024-09-19 23:38:25,202 INFO:	✅ GPU driver `amdgpu` bound to 0000:09:00.0
2024-09-19 23:38:25,220 INFO:	✅ System is configured for s2idle
2024-09-19 23:38:25,231 INFO:	✅ NVME Micron Technology Inc 2400 NVMe SSD (DRAM-less) is configured for s2idle in BIOS
2024-09-19 23:38:25,233 INFO:	✅ GPIO driver `pinctrl_amd` available
2024-09-19 23:38:25,234 DEBUG:	Winblue GPIO 0 debounce: disabled
2024-09-19 23:38:25,234 DEBUG:	gpio	  int|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg
2024-09-19 23:38:25,234 DEBUG:	#0	   😛|     ↑|   edge|  ⏰| ⏰|     |⏰|    |  ↑ |input  ↑|b (🕑 046875us)|0x81578e3
2024-09-19 23:38:25,234 DEBUG:	#2	   😛|     ↓|   edge|  ⏰| ⏰|     |  |    |  ↑ |input  ↑|               |0x157a00
2024-09-19 23:38:25,234 DEBUG:	#9	   😛|     ↑|  level|    |   |     |  |    |  ↓ |input  ↓|               |0x241900
2024-09-19 23:38:25,234 DEBUG:	#18	   😷|     ↓|  level|    |   |     |  |    |  ↑ |input  ↑|               |0x150b00
2024-09-19 23:38:25,234 DEBUG:	#44	   😷|     ↑|   edge|    |   |     |  |    |    |input  ↓|               |0x800
2024-09-19 23:38:25,234 DEBUG:	#54	   😛|     ↑|   edge|  ⏰| ⏰|     |  |    |    |input  ↓|               |0x7800
2024-09-19 23:38:25,234 DEBUG:	#58	   😛|     ↑|  level|  ⏰| ⏰|     |⏰|    |    |input  ↓|               |0x8007900
2024-09-19 23:38:25,234 DEBUG:	#59	   😛|     ↑|  level|  ⏰| ⏰|     |⏰|    |    |input  ↓|               |0x8007900
2024-09-19 23:38:25,234 DEBUG:	#84	   😛|     ↓|  level|    |   |     |  |    |  ↑ |input  ↑|b (🕑 000976us)|0x351b74
2024-09-19 23:38:25,257 DEBUG:	Micron Technology Inc Micron 2400 MTFDKBK512QFM firmware version: 'V3MA003'
2024-09-19 23:38:25,257 DEBUG:	| ['84b40af9-5392-5d04-ab7a-92c6ecd85f9f', '518236e8-44dc-5c54-86bf-8ab9c098cd5e', '83af6de5-10a8-52af-a66f-b8f2976550b3']
2024-09-19 23:38:25,257 DEBUG:	└─['NVME\\VEN_1344&DEV_5413', 'NVME\\VEN_1344&DEV_5413&SUBSYS_13441100', 'Micron_2400_MTFDKBK512QFM']
2024-09-19 23:38:25,257 DEBUG:	ASUSTeK COMPUTER INC. System Firmware firmware version: '825'
2024-09-19 23:38:25,257 DEBUG:	| ['b89ff2c6-881a-5e4f-8b4a-4138242a99f7']
2024-09-19 23:38:25,257 DEBUG:	└─[]
2024-09-19 23:38:25,257 DEBUG:	Microsoft TPM firmware version: '6.3.1.610'
2024-09-19 23:38:25,257 DEBUG:	| ['2a65d4b6-60a0-5e8c-acfa-d86cc3cbe4c3', '31a7bb1b-f5e1-53ff-b0e5-8692a21caed6', '5bea8d58-c840-513e-a5ad-0184cbaa9821', 'e02519c6-9139-5de8-89d4-9dca2f5c3b66']
2024-09-19 23:38:25,257 DEBUG:	└─['TPM\\VEN_MSFT&DEV_0001', 'TPM\\VEN_MSFT&MOD_Pluton.TPM.A', 'TPM\\VEN_MSFT&DEV_0001&VER_2.0', 'TPM\\VEN_MSFT&MOD_Pluton.TPM.A&VER_2.0']
2024-09-19 23:38:25,276 DEBUG:	Lockdown: [none] integrity confidentiality
2024-09-19 23:38:25,276 DEBUG:	VCE feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	UVD feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	MC feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	ME feature version: 35, firmware version: 0x00000027
2024-09-19 23:38:25,276 DEBUG:	PFP feature version: 35, firmware version: 0x00000030
2024-09-19 23:38:25,276 DEBUG:	CE feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	RLC feature version: 1, firmware version: 0x00000080
2024-09-19 23:38:25,276 DEBUG:	RLC SRLC feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	RLC SRLG feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	RLC SRLS feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	RLCP feature version: 1, firmware version: 0x0000000f
2024-09-19 23:38:25,276 DEBUG:	RLCV feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	MEC feature version: 35, firmware version: 0x00000027
2024-09-19 23:38:25,276 DEBUG:	IMU feature version: 0, firmware version: 0x0b012c00
2024-09-19 23:38:25,276 DEBUG:	SOS feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	ASD feature version: 553648351, firmware version: 0x210000df
2024-09-19 23:38:25,276 DEBUG:	TA XGMI feature version: 0x00000000, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	TA RAS feature version: 0x00000000, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	TA HDCP feature version: 0x00000000, firmware version: 0x17000040
2024-09-19 23:38:25,276 DEBUG:	TA DTM feature version: 0x00000000, firmware version: 0x12000016
2024-09-19 23:38:25,276 DEBUG:	TA RAP feature version: 0x00000000, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	SMC feature version: 0, program: 0, firmware version: 0x004c4700 (76.71.0)
2024-09-19 23:38:25,276 DEBUG:	SDMA0 feature version: 60, firmware version: 0x00000015
2024-09-19 23:38:25,276 DEBUG:	VCN feature version: 0, firmware version: 0x08116003
2024-09-19 23:38:25,276 DEBUG:	DMCU feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	DMCUB feature version: 0, firmware version: 0x08004300
2024-09-19 23:38:25,276 DEBUG:	TOC feature version: 0, firmware version: 0x0000000b
2024-09-19 23:38:25,276 DEBUG:	MES_KIQ feature version: 6, firmware version: 0x00000073
2024-09-19 23:38:25,276 DEBUG:	MES feature version: 1, firmware version: 0x00000062
2024-09-19 23:38:25,276 DEBUG:	VPE feature version: 0, firmware version: 0x00000000
2024-09-19 23:38:25,276 DEBUG:	VBIOS version: 113-PHXGENERIC-001
2024-09-19 23:38:25,279 DEBUG:	PCI devices
2024-09-19 23:38:25,279 DEBUG:	| 0000:00:00.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14e8] : \_SB_.PCI0.D002
2024-09-19 23:38:25,279 DEBUG:	| 0000:00:00.2 : Advanced Micro Devices, Inc. [AMD] IOMMU [1022:14e9] : \_SB_.PCI0.IOMA
2024-09-19 23:38:25,279 DEBUG:	| 0000:00:01.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-19 23:38:25,279 DEBUG:	| 0000:00:01.1 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14ed] : \_SB_.PCI0.GPP0
2024-09-19 23:38:25,279 DEBUG:	| 0000:00:02.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-19 23:38:25,279 DEBUG:	| 0000:00:02.2 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14ee] : \_SB_.PCI0.GPP6
2024-09-19 23:38:25,279 DEBUG:	├─ 0000:06:00.0 : MEDIATEK Corp. Network controller [14c3:0616] : \_SB_.PCI0.GPP6.WLAN
2024-09-19 23:38:25,279 DEBUG:	| 0000:00:02.3 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14ee] : \_SB_.PCI0.GPP7
2024-09-19 23:38:25,279 DEBUG:	├─ 0000:07:00.0 : Genesys Logic, Inc SD Host controller [17a0:9755] : \_SB_.PCI0.GPP7.CADR
2024-09-19 23:38:25,280 DEBUG:	| 0000:00:02.4 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14ee] : \_SB_.PCI0.GPP8
2024-09-19 23:38:25,280 DEBUG:	├─ 0000:08:00.0 : Micron Technology Inc Non-Volatile memory controller [1344:5413] : \_SB_.PCI0.GPP8.NVME
2024-09-19 23:38:25,280 DEBUG:	| 0000:00:03.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-19 23:38:25,280 DEBUG:	| 0000:00:04.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-19 23:38:25,280 DEBUG:	| 0000:00:08.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14ea]
2024-09-19 23:38:25,280 DEBUG:	| 0000:00:08.1 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14eb] : \_SB_.PCI0.GP17
2024-09-19 23:38:25,280 DEBUG:	├─ 0000:09:00.0 : Advanced Micro Devices, Inc. [AMD/ATI] VGA compatible controller [1002:15bf] : \_SB_.PCI0.GP17.VGA_
2024-09-19 23:38:25,280 DEBUG:	├─ 0000:09:00.1 : Advanced Micro Devices, Inc. [AMD/ATI] Audio device [1002:1640] : \_SB_.PCI0.GP17.HDAU
2024-09-19 23:38:25,280 DEBUG:	├─ 0000:09:00.2 : Advanced Micro Devices, Inc. [AMD] Encryption controller [1022:15c7] : \_SB_.PCI0.GP17.APSP
2024-09-19 23:38:25,280 DEBUG:	├─ 0000:09:00.3 : Advanced Micro Devices, Inc. [AMD] USB controller [1022:15b9] : \_SB_.PCI0.GP17.XHC0
2024-09-19 23:38:25,280 DEBUG:	├─ 0000:09:00.4 : Advanced Micro Devices, Inc. [AMD] USB controller [1022:15ba] : \_SB_.PCI0.GP17.XHC1
2024-09-19 23:38:25,280 DEBUG:	├─ 0000:09:00.5 : Advanced Micro Devices, Inc. [AMD] Multimedia controller [1022:15e2] : \_SB_.PCI0.GP17.ACP_
2024-09-19 23:38:25,281 DEBUG:	├─ 0000:09:00.6 : Advanced Micro Devices, Inc. [AMD] Audio device [1022:15e3] : \_SB_.PCI0.GP17.AZAL
2024-09-19 23:38:25,281 DEBUG:	| 0000:00:08.2 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14eb] : \_SB_.PCI0.GP18
2024-09-19 23:38:25,281 DEBUG:	├─ 0000:0a:00.0 : Advanced Micro Devices, Inc. [AMD]  [1022:14ec]
2024-09-19 23:38:25,281 DEBUG:	| 0000:00:08.3 : Advanced Micro Devices, Inc. [AMD] PCI bridge [1022:14eb] : \_SB_.PCI0.GP19
2024-09-19 23:38:25,281 DEBUG:	├─ 0000:0b:00.0 : Advanced Micro Devices, Inc. [AMD]  [1022:14ec] : \_SB_.PCI0.GP19.XHC2
2024-09-19 23:38:25,281 DEBUG:	├─ 0000:0b:00.3 : Advanced Micro Devices, Inc. [AMD] USB controller [1022:15c0] : \_SB_.PCI0.GP19.XHC3
2024-09-19 23:38:25,281 DEBUG:	├─ 0000:0b:00.4 : Advanced Micro Devices, Inc. [AMD] USB controller [1022:15c1] : \_SB_.PCI0.GP19.XHC4
2024-09-19 23:38:25,281 DEBUG:	| 0000:00:14.0 : Advanced Micro Devices, Inc. [AMD] SMBus [1022:790b] : \_SB_.PCI0.D02B
2024-09-19 23:38:25,281 DEBUG:	| 0000:00:14.3 : Advanced Micro Devices, Inc. [AMD] ISA bridge [1022:790e] : \_SB_.PCI0.SBRG
2024-09-19 23:38:25,281 DEBUG:	| 0000:00:18.0 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f0]
2024-09-19 23:38:25,281 DEBUG:	| 0000:00:18.1 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f1]
2024-09-19 23:38:25,281 DEBUG:	| 0000:00:18.2 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f2]
2024-09-19 23:38:25,281 DEBUG:	| 0000:00:18.3 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f3]
2024-09-19 23:38:25,282 DEBUG:	| 0000:00:18.4 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f4]
2024-09-19 23:38:25,282 DEBUG:	| 0000:00:18.5 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f5]
2024-09-19 23:38:25,282 DEBUG:	| 0000:00:18.6 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f6]
2024-09-19 23:38:25,282 DEBUG:	└─0000:00:18.7 : Advanced Micro Devices, Inc. [AMD] Host bridge [1022:14f7]
2024-09-19 23:38:25,367 DEBUG:	Interrupts
2024-09-19 23:38:25,367 DEBUG:	| 0: Timer
2024-09-19 23:38:25,367 DEBUG:	| 1: PS/2 controller
2024-09-19 23:38:25,367 DEBUG:	| 2: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 3: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 4: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 5: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 6: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 7: GPIO Controller
2024-09-19 23:38:25,367 DEBUG:	| 8: RTC
2024-09-19 23:38:25,367 DEBUG:	| 9: ACPI SCI
2024-09-19 23:38:25,367 DEBUG:	| 10: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 11: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 12: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 13: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 14: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 15: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 24: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 25: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 26: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 27: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 28: Advanced Micro Devices, Inc. [AMD] Generic system peripheral (0000:00:00.2) (AMD-Vi)
2024-09-19 23:38:25,367 DEBUG:	| 29: GPIO 0 (ACPI:Event)
2024-09-19 23:38:25,367 DEBUG:	| 30: GPIO 58 (ACPI:Event)
2024-09-19 23:38:25,367 DEBUG:	| 31: GPIO 59 (ACPI:Event)
2024-09-19 23:38:25,367 DEBUG:	| 32: GPIO 2 (ACPI:Event)
2024-09-19 23:38:25,367 DEBUG:	| 33: GPIO 54 (ACPI:Event)
2024-09-19 23:38:25,367 DEBUG:	| 34: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:01.1) (PCIe PME,aerdrv,pciehp)
2024-09-19 23:38:25,367 DEBUG:	| 35: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:02.2) (PCIe PME,aerdrv)
2024-09-19 23:38:25,367 DEBUG:	| 36: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:02.3) (PCIe PME,aerdrv)
2024-09-19 23:38:25,367 DEBUG:	| 37: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:02.4) (PCIe PME,aerdrv)
2024-09-19 23:38:25,367 DEBUG:	| 38: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:08.1) (PCIe PME)
2024-09-19 23:38:25,367 DEBUG:	| 39: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:08.2) (PCIe PME)
2024-09-19 23:38:25,367 DEBUG:	| 40: Advanced Micro Devices, Inc. [AMD] Bridge (0000:00:08.3) (PCIe PME)
2024-09-19 23:38:25,367 DEBUG:	| 41: GPIO 9 (NVTK0603:00)
2024-09-19 23:38:25,367 DEBUG:	| 42: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 43: Advanced Micro Devices, Inc. [AMD] Encryption controller (0000:09:00.2) (psp-1)
2024-09-19 23:38:25,367 DEBUG:	| 44: Advanced Micro Devices, Inc. [AMD] Encryption controller (0000:09:00.2)
2024-09-19 23:38:25,367 DEBUG:	| 45: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 46: Advanced Micro Devices, Inc. [AMD] Serial bus controller (0000:09:00.3) (xhci_hcd)
2024-09-19 23:38:25,367 DEBUG:	| 47: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 48: Advanced Micro Devices, Inc. [AMD] Serial bus controller (0000:09:00.4) (xhci_hcd)
2024-09-19 23:38:25,367 DEBUG:	| 49: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 50: Advanced Micro Devices, Inc. [AMD] Serial bus controller (0000:0b:00.3) (xhci_hcd)
2024-09-19 23:38:25,367 DEBUG:	| 51: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 52: Advanced Micro Devices, Inc. [AMD] Serial bus controller (0000:0b:00.4) (xhci_hcd)
2024-09-19 23:38:25,367 DEBUG:	| 53: Disabled interrupt
2024-09-19 23:38:25,367 DEBUG:	| 54: Advanced Micro Devices, Inc. [AMD] Multimedia controller (0000:09:00.6) (snd_hda_intel:card1)
2024-09-19 23:38:25,367 DEBUG:	| 55: Genesys Logic, Inc Generic system peripheral (0000:07:00.0) (mmc0)
2024-09-19 23:38:25,367 DEBUG:	| 56: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q0)
2024-09-19 23:38:25,367 DEBUG:	| 57: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q1)
2024-09-19 23:38:25,367 DEBUG:	| 58: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q2)
2024-09-19 23:38:25,367 DEBUG:	| 59: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q3)
2024-09-19 23:38:25,367 DEBUG:	| 60: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q4)
2024-09-19 23:38:25,367 DEBUG:	| 61: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q5)
2024-09-19 23:38:25,367 DEBUG:	| 62: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q6)
2024-09-19 23:38:25,367 DEBUG:	| 63: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q7)
2024-09-19 23:38:25,367 DEBUG:	| 64: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q8)
2024-09-19 23:38:25,367 DEBUG:	| 65: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q9)
2024-09-19 23:38:25,367 DEBUG:	| 66: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q10)
2024-09-19 23:38:25,367 DEBUG:	| 67: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q11)
2024-09-19 23:38:25,367 DEBUG:	| 68: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q12)
2024-09-19 23:38:25,367 DEBUG:	| 69: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q13)
2024-09-19 23:38:25,367 DEBUG:	| 70: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q14)
2024-09-19 23:38:25,367 DEBUG:	| 71: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q15)
2024-09-19 23:38:25,368 DEBUG:	| 72: GPIO 84 (cs35l41 IRQ1 Controller,cs35l41 IRQ1 Controller)
2024-09-19 23:38:25,368 DEBUG:	| 73: Disabled interrupt (Boost Overvoltage Error)
2024-09-19 23:38:25,368 DEBUG:	| 74: Disabled interrupt (Boost Undervoltage Error)
2024-09-19 23:38:25,368 DEBUG:	| 75: Disabled interrupt (Boost Inductor Short Error)
2024-09-19 23:38:25,368 DEBUG:	| 76: Disabled interrupt (Temperature Warning)
2024-09-19 23:38:25,368 DEBUG:	| 77: Disabled interrupt (Temperature Error)
2024-09-19 23:38:25,368 DEBUG:	| 78: Disabled interrupt (Amp Short)
2024-09-19 23:38:25,368 DEBUG:	| 79: Disabled interrupt (Boost Overvoltage Error)
2024-09-19 23:38:25,368 DEBUG:	| 80: Disabled interrupt (Boost Undervoltage Error)
2024-09-19 23:38:25,368 DEBUG:	| 81: Disabled interrupt (Boost Inductor Short Error)
2024-09-19 23:38:25,368 DEBUG:	| 82: Disabled interrupt (Temperature Warning)
2024-09-19 23:38:25,368 DEBUG:	| 83: Disabled interrupt (Temperature Error)
2024-09-19 23:38:25,368 DEBUG:	| 84: Disabled interrupt (Amp Short)
2024-09-19 23:38:25,368 DEBUG:	| 85: Disabled interrupt
2024-09-19 23:38:25,368 DEBUG:	| 86: Micron Technology Inc Mass storage controller (0000:08:00.0) (nvme0q16)
2024-09-19 23:38:25,368 DEBUG:	| 87: Advanced Micro Devices, Inc. [AMD/ATI] Multimedia controller (0000:09:00.1) (snd_hda_intel:card0)
2024-09-19 23:38:25,368 DEBUG:	| 88: MEDIATEK Corp. Network controller (0000:06:00.0) (mt7921e)
2024-09-19 23:38:25,368 DEBUG:	└─89: Advanced Micro Devices, Inc. [AMD/ATI] Display controller (0000:09:00.0) (amdgpu)
2024-09-19 23:38:25,376 DEBUG:	I2C HID devices
2024-09-19 23:38:25,376 DEBUG:	└─"NVTK0603:00 0603:F200" [NVTK0603] : \_SB_.I2CA.TPL0
2024-09-19 23:38:25,389 DEBUG:	Wakeup sources:
2024-09-19 23:38:25,389 DEBUG:	| ACPI Battery [PNP0C0A:00]: enabled
2024-09-19 23:38:25,389 DEBUG:	| ACPI Power Button [PNP0C0C:00]: enabled
2024-09-19 23:38:25,389 DEBUG:	| ACPI Sleep Button [PNP0C0E:00]: enabled
2024-09-19 23:38:25,389 DEBUG:	| AT Translated Set 2 keyboard [serio0]: enabled
2024-09-19 23:38:25,389 DEBUG:	| Advanced Micro Devices, Inc. [AMD] ISA bridge [0000:00:14.3]: enabled
2024-09-19 23:38:25,389 DEBUG:	| Advanced Micro Devices, Inc. [AMD] Multimedia controller [0000:09:00.5]: enabled
2024-09-19 23:38:25,389 DEBUG:	| Advanced Micro Devices, Inc. [AMD] PCI bridge [0000:00:01.1]: enabled
2024-09-19 23:38:25,389 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:09:00.3]: enabled
2024-09-19 23:38:25,389 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:09:00.3]: enabled
2024-09-19 23:38:25,390 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:09:00.4]: enabled
2024-09-19 23:38:25,390 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:0b:00.3]: enabled
2024-09-19 23:38:25,390 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:0b:00.3]: enabled
2024-09-19 23:38:25,390 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:0b:00.3]: enabled
2024-09-19 23:38:25,390 DEBUG:	| Advanced Micro Devices, Inc. [AMD] USB controller [0000:0b:00.4]: enabled
2024-09-19 23:38:25,390 DEBUG:	| Logitech K400 Plus [0003:046D:404D.000A]: enabled
2024-09-19 23:38:25,390 DEBUG:	| Plug-n-play Real Time Clock [00:01]: enabled
2024-09-19 23:38:25,390 DEBUG:	└─Real Time Clock alarm timer [rtc0]: enabled
2024-09-19 23:38:25,392 DEBUG:	/*
2024-09-19 23:38:25,392 DEBUG:	 * Intel ACPI Component Architecture
2024-09-19 23:38:25,392 DEBUG:	 * AML/ASL+ Disassembler version 20230628 (64-bit version)
2024-09-19 23:38:25,392 DEBUG:	 * Copyright (c) 2000 - 2023 Intel Corporation
2024-09-19 23:38:25,392 DEBUG:	 *
2024-09-19 23:38:25,392 DEBUG:	 * Disassembling to symbolic ASL+ operators
2024-09-19 23:38:25,392 DEBUG:	 *
2024-09-19 23:38:25,392 DEBUG:	 * Disassembly of /sys/firmware/acpi/tables/SSDT19
2024-09-19 23:38:25,392 DEBUG:	 *
2024-09-19 23:38:25,392 DEBUG:	 * Original Table Header:
2024-09-19 23:38:25,392 DEBUG:	 *     Signature        "SSDT"
2024-09-19 23:38:25,392 DEBUG:	 *     Length           0x000009DB (2523)
2024-09-19 23:38:25,392 DEBUG:	 *     Revision         0x02
2024-09-19 23:38:25,392 DEBUG:	 *     Checksum         0xB0
2024-09-19 23:38:25,392 DEBUG:	 *     OEM ID           "AMD"
2024-09-19 23:38:25,392 DEBUG:	 *     OEM Table ID     "CPMGPIO0"
2024-09-19 23:38:25,392 DEBUG:	 *     OEM Revision     0x00000001 (1)
2024-09-19 23:38:25,392 DEBUG:	 *     Compiler ID      "INTL"
2024-09-19 23:38:25,392 DEBUG:	 *     Compiler Version 0x20200717 (538969879)
2024-09-19 23:38:25,392 DEBUG:	 */
2024-09-19 23:38:25,392 DEBUG:	DefinitionBlock ("", "SSDT", 2, "AMD", "CPMGPIO0", 0x00000001)
2024-09-19 23:38:25,392 DEBUG:	{
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.GPIO, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GP17.ACP_, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GP17.AZAL, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GP17.MP2C, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GP17.XHC0, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GP17.XHC1, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GPP0, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GPP1, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GPP2, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GPP5, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GPP6, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GPP7, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.GPP7.DEV0, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.SBRG.EC0_, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.SBRG.EC0_.OKEC, IntObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PCI0.SBRG.EC0_.Z009, MutexObj)
2024-09-19 23:38:25,392 DEBUG:	    External (_SB_.PWRB, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M000, MethodObj)    // 1 Arguments
2024-09-19 23:38:25,392 DEBUG:	    External (M037, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M046, IntObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M047, IntObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M050, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M051, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M052, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M053, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M054, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M055, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M056, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M057, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M058, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M059, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M062, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M068, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M069, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M070, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M071, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M072, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M074, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M075, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M076, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M077, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M078, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M079, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M080, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M081, DeviceObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M082, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M083, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M084, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M085, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M086, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M087, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M088, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M089, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M090, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M091, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M092, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M093, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M094, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M095, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M096, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M097, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M098, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M099, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M100, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M101, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M102, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M103, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M104, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M105, FieldUnitObj)
2024-09-19 23:38:25,392 DEBUG:	    External (M106, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M107, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M108, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M109, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M110, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M115, BuffObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M116, BuffFieldObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M117, BuffFieldObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M118, BuffFieldObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M119, BuffFieldObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M120, BuffFieldObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M122, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M127, DeviceObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M128, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M131, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M132, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M133, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M134, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M135, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M136, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M220, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M221, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M226, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M227, DeviceObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M229, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M231, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M233, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M235, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M23A, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M251, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M280, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M290, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M29A, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M310, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M31C, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M320, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M321, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M322, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M323, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M324, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M325, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M326, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M327, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M328, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M329, DeviceObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M32A, DeviceObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M32B, DeviceObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M330, DeviceObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M331, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M378, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M379, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M380, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M381, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M382, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M383, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M384, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M385, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M386, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M387, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M388, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M389, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M390, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M391, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M392, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M404, BuffObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M408, MutexObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M414, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M444, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M449, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M453, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M454, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M455, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M456, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M457, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M460, MethodObj)    // 7 Arguments
2024-09-19 23:38:25,393 DEBUG:	    External (M4C0, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M4F0, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M610, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M620, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M631, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	    External (M652, FieldUnitObj)
2024-09-19 23:38:25,393 DEBUG:	
2024-09-19 23:38:25,393 DEBUG:	    Scope (\_SB.PCI0.SBRG.EC0)
2024-09-19 23:38:25,393 DEBUG:	    {
2024-09-19 23:38:25,393 DEBUG:	        OperationRegion (ECRM, EmbeddedControl, Zero, 0xFF)
2024-09-19 23:38:25,393 DEBUG:	        Field (ECRM, ByteAcc, NoLock, Preserve)
2024-09-19 23:38:25,393 DEBUG:	        {
2024-09-19 23:38:25,393 DEBUG:	            Offset (0xCC),
2024-09-19 23:38:25,393 DEBUG:	            PBCN,   8
2024-09-19 23:38:25,393 DEBUG:	        }
2024-09-19 23:38:25,393 DEBUG:	    }
2024-09-19 23:38:25,393 DEBUG:	
2024-09-19 23:38:25,393 DEBUG:	    Scope (\_SB.GPIO)
2024-09-19 23:38:25,393 DEBUG:	    {
2024-09-19 23:38:25,393 DEBUG:	        Method (_AEI, 0, NotSerialized)  // _AEI: ACPI Event Interrupts
2024-09-19 23:38:25,393 DEBUG:	        {
2024-09-19 23:38:25,393 DEBUG:	            Name (BUF0, ResourceTemplate ()
2024-09-19 23:38:25,393 DEBUG:	            {
2024-09-19 23:38:25,393 DEBUG:	                GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullDefault, 0x1388,
2024-09-19 23:38:25,393 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-19 23:38:25,393 DEBUG:	                    )
2024-09-19 23:38:25,393 DEBUG:	                    {   // Pin list
2024-09-19 23:38:25,393 DEBUG:	                        0x0000
2024-09-19 23:38:25,393 DEBUG:	                    }
2024-09-19 23:38:25,393 DEBUG:	                GpioInt (Level, ActiveHigh, ExclusiveAndWake, PullNone, 0x0000,
2024-09-19 23:38:25,393 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-19 23:38:25,393 DEBUG:	                    )
2024-09-19 23:38:25,393 DEBUG:	                    {   // Pin list
2024-09-19 23:38:25,393 DEBUG:	                        0x003A
2024-09-19 23:38:25,393 DEBUG:	                    }
2024-09-19 23:38:25,393 DEBUG:	                GpioInt (Level, ActiveHigh, ExclusiveAndWake, PullNone, 0x0000,
2024-09-19 23:38:25,393 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-19 23:38:25,393 DEBUG:	                    )
2024-09-19 23:38:25,393 DEBUG:	                    {   // Pin list
2024-09-19 23:38:25,393 DEBUG:	                        0x003B
2024-09-19 23:38:25,394 DEBUG:	                    }
2024-09-19 23:38:25,394 DEBUG:	                GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
2024-09-19 23:38:25,394 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-19 23:38:25,394 DEBUG:	                    )
2024-09-19 23:38:25,394 DEBUG:	                    {   // Pin list
2024-09-19 23:38:25,394 DEBUG:	                        0x0002
2024-09-19 23:38:25,394 DEBUG:	                    }
2024-09-19 23:38:25,394 DEBUG:	                GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone, 0x0000,
2024-09-19 23:38:25,394 DEBUG:	                    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
2024-09-19 23:38:25,394 DEBUG:	                    )
2024-09-19 23:38:25,394 DEBUG:	                    {   // Pin list
2024-09-19 23:38:25,394 DEBUG:	                        0x0036
2024-09-19 23:38:25,394 DEBUG:	                    }
2024-09-19 23:38:25,394 DEBUG:	            })
2024-09-19 23:38:25,394 DEBUG:	            M460 ("  OEM-ASL-\\_SB.GPIO._AEI\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	            Return (BUF0) /* \_SB_.GPIO._AEI.BUF0 */
2024-09-19 23:38:25,394 DEBUG:	        }
2024-09-19 23:38:25,394 DEBUG:	
2024-09-19 23:38:25,394 DEBUG:	        Method (_EVT, 1, Serialized)  // _EVT: Event
2024-09-19 23:38:25,394 DEBUG:	        {
2024-09-19 23:38:25,394 DEBUG:	            Name (HPDW, 0x55)
2024-09-19 23:38:25,394 DEBUG:	            M460 ("  OEM-ASL-\\_SB.GPIO._EVT-Start Case %d\n", ToInteger (Arg0), Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	            Switch (ToInteger (Arg0))
2024-09-19 23:38:25,394 DEBUG:	            {
2024-09-19 23:38:25,394 DEBUG:	                Case (Zero)
2024-09-19 23:38:25,394 DEBUG:	                {
2024-09-19 23:38:25,394 DEBUG:	                    M000 (0x3900)
2024-09-19 23:38:25,394 DEBUG:	                    M460 ("    Notify (\\_SB.PWRB, 0x80)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	                    Notify (\_SB.PWRB, 0x80) // Status Change
2024-09-19 23:38:25,394 DEBUG:	                }
2024-09-19 23:38:25,394 DEBUG:	                Case (0x02)
2024-09-19 23:38:25,394 DEBUG:	                {
2024-09-19 23:38:25,394 DEBUG:	                    M000 (0x3902)
2024-09-19 23:38:25,394 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GPP0, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	                    Notify (\_SB.PCI0.GPP0, 0x02) // Device Wake
2024-09-19 23:38:25,394 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GPP1, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	                    Notify (\_SB.PCI0.GPP1, 0x02) // Device Wake
2024-09-19 23:38:25,394 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GPP2, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	                    Notify (\_SB.PCI0.GPP2, 0x02) // Device Wake
2024-09-19 23:38:25,394 DEBUG:	                }
2024-09-19 23:38:25,394 DEBUG:	                Case (0x36)
2024-09-19 23:38:25,394 DEBUG:	                {
2024-09-19 23:38:25,394 DEBUG:	                    M000 (0x3936)
2024-09-19 23:38:25,394 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GP17.MP2C, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	                    Notify (\_SB.PCI0.GP17.MP2C, 0x02) // Device Wake
2024-09-19 23:38:25,394 DEBUG:	                    If ((HPDW == One))
2024-09-19 23:38:25,394 DEBUG:	                    {
2024-09-19 23:38:25,394 DEBUG:	                        M460 ("    Notify (\\_SB.PCI0.GP17.MP2C(HPDW):PWRB 0x80)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	                        Notify (\_SB.PWRB, 0x80) // Status Change
2024-09-19 23:38:25,394 DEBUG:	                    }
2024-09-19 23:38:25,394 DEBUG:	                }
2024-09-19 23:38:25,394 DEBUG:	                Case (0x3A)
2024-09-19 23:38:25,394 DEBUG:	                {
2024-09-19 23:38:25,394 DEBUG:	                    M000 (0x393A)
2024-09-19 23:38:25,394 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GP17.XHC0, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	                    Notify (\_SB.PCI0.GP17.XHC0, 0x02) // Device Wake
2024-09-19 23:38:25,394 DEBUG:	                }
2024-09-19 23:38:25,394 DEBUG:	                Case (0x3B)
2024-09-19 23:38:25,394 DEBUG:	                {
2024-09-19 23:38:25,394 DEBUG:	                    M000 (0x393B)
2024-09-19 23:38:25,394 DEBUG:	                    M460 ("    Notify (\\_SB.PCI0.GP17.XHC1, 0x02)\n", Zero, Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	                    Notify (\_SB.PCI0.GP17.XHC1, 0x02) // Device Wake
2024-09-19 23:38:25,394 DEBUG:	                }
2024-09-19 23:38:25,394 DEBUG:	
2024-09-19 23:38:25,394 DEBUG:	            }
2024-09-19 23:38:25,394 DEBUG:	
2024-09-19 23:38:25,394 DEBUG:	            M460 ("  OEM-ASL-\\_SB.GPIO._EVT-End Case %d\n", ToInteger (Arg0), Zero, Zero, Zero, Zero, Zero)
2024-09-19 23:38:25,394 DEBUG:	        }
2024-09-19 23:38:25,394 DEBUG:	    }
2024-09-19 23:38:25,394 DEBUG:	}
2024-09-19 23:38:49,041 INFO:	Running 4 cycles (Test finish expected @ 2024-09-19 23:44:25.041275)
2024-09-19 23:38:49,041 DEBUG:	Suspend timer programmed for 0:01:20
2024-09-19 23:38:51,043 INFO:	Suspend cycle 1: Started at 2024-09-19 23:38:51.043069 (cycle finish expected @ 2024-09-19 23:40:15.043076)
2024-09-19 23:40:15,986 INFO:	Results from last s2idle cycle
2024-09-19 23:40:15,987 DEBUG:	PM: suspend entry (s2idle)
2024-09-19 23:40:15,987 DEBUG:	Filesystems sync: 0.019 seconds
2024-09-19 23:40:15,987 DEBUG:	Freezing user space processes
2024-09-19 23:40:15,987 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-19 23:40:15,987 DEBUG:	OOM killer disabled.
2024-09-19 23:40:15,987 DEBUG:	Freezing remaining freezable tasks
2024-09-19 23:40:15,987 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-19 23:40:15,987 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-19 23:40:15,987 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-19 23:40:15,987 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-19 23:40:15,987 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-19 23:40:15,988 DEBUG:	PM: suspend of devices complete after 340.772 msecs
2024-09-19 23:40:15,988 DEBUG:	PM: start suspend of devices complete after 341.318 msecs
2024-09-19 23:40:15,988 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-19 23:40:15,988 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-19 23:40:15,988 DEBUG:	PM: late suspend of devices complete after 0.989 msecs
2024-09-19 23:40:15,988 DEBUG:	ACPI: EC: interrupt blocked
2024-09-19 23:40:15,988 DEBUG:	PM: noirq suspend of devices complete after 101.295 msecs
2024-09-19 23:40:15,988 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-19 23:40:15,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-19 23:40:15,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-19 23:40:15,988 DEBUG:	PM: suspend-to-idle
2024-09-19 23:40:15,988 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x2ffb3eb5
2024-09-19 23:40:15,988 DEBUG:	Timekeeping suspended for 79.486 seconds
2024-09-19 23:40:15,988 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-19 23:40:15,988 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-19 23:40:15,988 DEBUG:	PM: resume from suspend-to-idle
2024-09-19 23:40:15,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-19 23:40:15,988 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-19 23:40:15,988 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-19 23:40:15,988 DEBUG:	PM: noirq resume of devices complete after 159.967 msecs
2024-09-19 23:40:15,988 DEBUG:	PM: early resume of devices complete after 3.054 msecs
2024-09-19 23:40:15,988 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-19 23:40:15,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-19 23:40:15,988 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-19 23:40:15,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-19 23:40:15,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-19 23:40:15,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-19 23:40:15,988 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-19 23:40:15,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-19 23:40:15,988 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-19 23:40:15,988 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-19 23:40:15,989 DEBUG:	r8152 6-1.4:1.0 enp11s0f3u1u4: carrier on
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-19 23:40:15,989 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-19 23:40:15,989 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-19 23:40:15,989 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-19 23:40:15,989 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-19 23:40:15,989 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-19 23:40:15,989 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-19 23:40:15,989 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-19 23:40:15,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-19 23:40:15,989 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-19 23:40:15,989 DEBUG:	PM: resume of devices complete after 2807.434 msecs
2024-09-19 23:40:15,989 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-19 23:40:15,989 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-19 23:40:15,989 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-19 23:40:15,989 DEBUG:	OOM killer enabled.
2024-09-19 23:40:15,989 DEBUG:	Restarting tasks ... 
2024-09-19 23:40:15,989 DEBUG:	usb 1-2: USB disconnect, device number 13
2024-09-19 23:40:15,989 DEBUG:	done.
2024-09-19 23:40:15,989 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-19 23:40:15,989 DEBUG:	random: crng reseeded on system resumption
2024-09-19 23:40:15,989 DEBUG:	PM: suspend exit
2024-09-19 23:40:15,989 DEBUG:	usb 1-3: USB disconnect, device number 12
2024-09-19 23:40:15,989 DEBUG:	usb 1-3: new full-speed USB device number 14 using xhci_hcd
2024-09-19 23:40:15,989 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-19 23:40:15,990 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-19 23:40:15,990 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-19 23:40:15,990 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-19 23:40:15,990 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.001A/input/input61
2024-09-19 23:40:15,990 DEBUG:	asus 0003:0B05:1ABE.001A: input,hidraw3: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-19 23:40:15,990 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.001B/input/input62
2024-09-19 23:40:15,990 DEBUG:	asus 0003:0B05:1ABE.001B: input,hidraw5: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-19 23:40:15,990 DEBUG:	asus 0003:0B05:1ABE.001C: Fixing up Asus N-Key report descriptor
2024-09-19 23:40:15,990 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.001C/input/input63
2024-09-19 23:40:15,990 DEBUG:	asus 0003:0B05:1ABE.001C: input,hiddev96,hidraw6: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-19 23:40:15,990 DEBUG:	usb 1-2: new full-speed USB device number 15 using xhci_hcd
2024-09-19 23:40:15,990 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-19 23:40:15,990 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-19 23:40:15,990 DEBUG:	usb 1-2: Product: Controller
2024-09-19 23:40:15,990 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-19 23:40:15,990 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-19 23:40:15,990 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input64
2024-09-19 23:40:15,990 DEBUG:	input input64: unable to receive magic message: -32
2024-09-19 23:40:15,990 INFO:	○ Suspend count: 1
2024-09-19 23:40:15,990 INFO:	○ Hardware sleep cycle count: 1
2024-09-19 23:40:15,990 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-19 23:40:15,990 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-19 23:40:15,990 ERROR:	❌ ACPI BIOS errors found
2024-09-19 23:40:15,990 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-19 23:40:15,991 INFO:	○ gpe10 increased from 71 to 75
2024-09-19 23:40:15,991 INFO:	✅ Userspace suspended for 0:01:24.948163
2024-09-19 23:40:15,991 DEBUG:	Kernel suspended for total of 0:01:19.486000 (93.57%)
2024-09-19 23:40:15,991 INFO:	✅ In a hardware sleep state for 0:01:18.988403 (92.98%)
2024-09-19 23:40:15,996 DEBUG:	BAT0 energy level is 31937000 µWh
2024-09-19 23:40:15,996 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.14W]
2024-09-19 23:40:17,996 INFO:	Suspend cycle 2: Started at 2024-09-19 23:40:17.996529 (cycle finish expected @ 2024-09-19 23:41:41.996543)
2024-09-19 23:41:40,997 ERROR:	❌ Failed to suspend
2024-09-19 23:41:40,997 DEBUG:	[Errno 16] Device or resource busy
2024-09-19 23:41:42,998 INFO:	Suspend cycle 3: Started at 2024-09-19 23:41:42.998261 (cycle finish expected @ 2024-09-19 23:43:06.998292)
2024-09-19 23:43:08,003 INFO:	Results from last s2idle cycle
2024-09-19 23:43:08,004 DEBUG:	PM: suspend entry (s2idle)
2024-09-19 23:43:08,004 DEBUG:	Filesystems sync: 0.010 seconds
2024-09-19 23:43:08,004 DEBUG:	Freezing user space processes
2024-09-19 23:43:08,004 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-19 23:43:08,004 DEBUG:	OOM killer disabled.
2024-09-19 23:43:08,004 DEBUG:	Freezing remaining freezable tasks
2024-09-19 23:43:08,004 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2024-09-19 23:43:08,004 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-19 23:43:08,004 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-19 23:43:08,004 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-19 23:43:08,004 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-19 23:43:08,004 DEBUG:	PM: suspend of devices complete after 344.197 msecs
2024-09-19 23:43:08,004 DEBUG:	PM: start suspend of devices complete after 344.894 msecs
2024-09-19 23:43:08,004 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-19 23:43:08,004 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-19 23:43:08,004 DEBUG:	PM: late suspend of devices complete after 1.503 msecs
2024-09-19 23:43:08,004 DEBUG:	ACPI: EC: interrupt blocked
2024-09-19 23:43:08,004 DEBUG:	PM: noirq suspend of devices complete after 94.206 msecs
2024-09-19 23:43:08,004 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-19 23:43:08,004 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-19 23:43:08,004 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-19 23:43:08,004 DEBUG:	PM: suspend-to-idle
2024-09-19 23:43:08,004 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x2ffb3eb5
2024-09-19 23:43:08,004 DEBUG:	Timekeeping suspended for 79.542 seconds
2024-09-19 23:43:08,004 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-19 23:43:08,004 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-19 23:43:08,004 DEBUG:	PM: resume from suspend-to-idle
2024-09-19 23:43:08,004 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-19 23:43:08,004 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-19 23:43:08,004 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-19 23:43:08,004 DEBUG:	PM: noirq resume of devices complete after 165.749 msecs
2024-09-19 23:43:08,004 DEBUG:	PM: early resume of devices complete after 2.953 msecs
2024-09-19 23:43:08,005 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-19 23:43:08,005 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-19 23:43:08,005 DEBUG:	r8152 6-1.4:1.0 enp11s0f3u1u4: carrier on
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-19 23:43:08,005 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-19 23:43:08,005 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-19 23:43:08,005 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-19 23:43:08,005 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-19 23:43:08,005 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-19 23:43:08,005 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-19 23:43:08,005 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-19 23:43:08,005 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-19 23:43:08,005 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-19 23:43:08,005 DEBUG:	PM: resume of devices complete after 2802.462 msecs
2024-09-19 23:43:08,005 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-19 23:43:08,005 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-19 23:43:08,005 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-19 23:43:08,005 DEBUG:	OOM killer enabled.
2024-09-19 23:43:08,005 DEBUG:	Restarting tasks ... 
2024-09-19 23:43:08,006 DEBUG:	usb 1-2: USB disconnect, device number 19
2024-09-19 23:43:08,006 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-19 23:43:08,006 DEBUG:	done.
2024-09-19 23:43:08,006 DEBUG:	random: crng reseeded on system resumption
2024-09-19 23:43:08,006 DEBUG:	PM: suspend exit
2024-09-19 23:43:08,006 DEBUG:	usb 1-3: USB disconnect, device number 18
2024-09-19 23:43:08,006 DEBUG:	usb 1-3: new full-speed USB device number 20 using xhci_hcd
2024-09-19 23:43:08,006 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-19 23:43:08,006 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-19 23:43:08,006 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-19 23:43:08,006 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-19 23:43:08,006 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0023/input/input73
2024-09-19 23:43:08,006 DEBUG:	asus 0003:0B05:1ABE.0023: input,hidraw5: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-19 23:43:08,006 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0024/input/input74
2024-09-19 23:43:08,006 DEBUG:	asus 0003:0B05:1ABE.0024: input,hidraw6: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-19 23:43:08,006 DEBUG:	asus 0003:0B05:1ABE.0025: Fixing up Asus N-Key report descriptor
2024-09-19 23:43:08,006 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0025/input/input75
2024-09-19 23:43:08,006 DEBUG:	asus 0003:0B05:1ABE.0025: input,hiddev96,hidraw8: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-19 23:43:08,006 DEBUG:	usb 1-2: new full-speed USB device number 21 using xhci_hcd
2024-09-19 23:43:08,006 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-19 23:43:08,006 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-19 23:43:08,006 DEBUG:	usb 1-2: Product: Controller
2024-09-19 23:43:08,006 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-19 23:43:08,006 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-19 23:43:08,006 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input76
2024-09-19 23:43:08,006 DEBUG:	input input76: unable to receive magic message: -32
2024-09-19 23:43:08,006 INFO:	○ Suspend count: 1
2024-09-19 23:43:08,006 INFO:	○ Hardware sleep cycle count: 1
2024-09-19 23:43:08,006 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-19 23:43:08,006 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-19 23:43:08,006 ERROR:	❌ ACPI BIOS errors found
2024-09-19 23:43:08,006 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-19 23:43:08,007 INFO:	○ gpe10 increased from 75 to 89
2024-09-19 23:43:08,007 INFO:	✅ Userspace suspended for 0:01:25.009007
2024-09-19 23:43:08,007 DEBUG:	Kernel suspended for total of 0:01:19.542000 (93.57%)
2024-09-19 23:43:08,007 INFO:	✅ In a hardware sleep state for 0:01:19.004791 (92.94%)
2024-09-19 23:43:08,008 DEBUG:	BAT0 energy level is 31905000 µWh
2024-09-19 23:43:08,008 INFO:	🔋 Battery BAT0 lost 32000 µWh (0.10%) [Average rate 0.14W]
2024-09-19 23:43:10,008 INFO:	Suspend cycle 4: Started at 2024-09-19 23:43:10.008857 (cycle finish expected @ 2024-09-19 23:44:34.008873)
2024-09-19 23:44:34,988 INFO:	Results from last s2idle cycle
2024-09-19 23:44:34,989 DEBUG:	PM: suspend entry (s2idle)
2024-09-19 23:44:34,989 DEBUG:	Filesystems sync: 0.034 seconds
2024-09-19 23:44:34,989 DEBUG:	Freezing user space processes
2024-09-19 23:44:34,989 DEBUG:	Freezing user space processes completed (elapsed 0.001 seconds)
2024-09-19 23:44:34,989 DEBUG:	OOM killer disabled.
2024-09-19 23:44:34,989 DEBUG:	Freezing remaining freezable tasks
2024-09-19 23:44:34,989 DEBUG:	Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
2024-09-19 23:44:34,989 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
2024-09-19 23:44:34,989 DEBUG:	printk: Suspending console(s) (use no_console_suspend to debug)
2024-09-19 23:44:34,989 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Asserting Reset
2024-09-19 23:44:34,990 DEBUG:	queueing ieee80211 work while going to suspend
2024-09-19 23:44:34,990 DEBUG:	PM: suspend of devices complete after 346.468 msecs
2024-09-19 23:44:34,990 DEBUG:	PM: start suspend of devices complete after 346.898 msecs
2024-09-19 23:44:34,990 DEBUG:	Disabling GPIO #9 interrupt for suspend.
2024-09-19 23:44:34,990 DEBUG:	Disabling GPIO #84 interrupt for suspend.
2024-09-19 23:44:34,990 DEBUG:	PM: late suspend of devices complete after 0.883 msecs
2024-09-19 23:44:34,990 DEBUG:	ACPI: EC: interrupt blocked
2024-09-19 23:44:34,990 DEBUG:	PM: noirq suspend of devices complete after 104.723 msecs
2024-09-19 23:44:34,990 DEBUG:	ACPI: \_SB_.PCI0.GP19.XHC2: LPI: Constraint not met; min power state:D3hot current power state:D0
2024-09-19 23:44:34,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
2024-09-19 23:44:34,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
2024-09-19 23:44:34,990 DEBUG:	PM: suspend-to-idle
2024-09-19 23:44:34,990 DEBUG:	amd_pmc: SMU idlemask s0i3: 0x2ffb3eb5
2024-09-19 23:44:34,990 DEBUG:	Timekeeping suspended for 79.497 seconds
2024-09-19 23:44:34,990 DEBUG:	PM: Triggering wakeup from IRQ 9
2024-09-19 23:44:34,990 DEBUG:	ACPI: PM: ACPI fixed event wakeup
2024-09-19 23:44:34,990 DEBUG:	PM: resume from suspend-to-idle
2024-09-19 23:44:34,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
2024-09-19 23:44:34,990 DEBUG:	ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
2024-09-19 23:44:34,990 DEBUG:	ACPI: EC: interrupt unblocked
2024-09-19 23:44:34,990 DEBUG:	PM: noirq resume of devices complete after 160.908 msecs
2024-09-19 23:44:34,990 DEBUG:	PM: early resume of devices complete after 2.872 msecs
2024-09-19 23:44:34,990 DEBUG:	[drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resuming...
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: SMU is resumed successfully!
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:227
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:235
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:243
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: [drm] REG_WAIT timeout 1us * 1000 tries - dcn314_dsc_pg_control line:251
2024-09-19 23:44:34,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-19 23:44:34,990 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-19 23:44:34,990 DEBUG:	nvme nvme0: 16/0/0 default/read/poll queues
2024-09-19 23:44:34,990 DEBUG:	r8152 6-1.4:1.0 enp11s0f3u1u4: carrier on
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-09-19 23:44:34,990 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-09-19 23:44:34,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-09-19 23:44:34,991 DEBUG:	amdgpu 0000:09:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-09-19 23:44:34,991 DEBUG:	[drm] ring gfx_32772.1.1 was added
2024-09-19 23:44:34,991 DEBUG:	[drm] ring compute_32772.2.2 was added
2024-09-19 23:44:34,991 DEBUG:	[drm] ring sdma_32772.3.3 was added
2024-09-19 23:44:34,991 DEBUG:	[drm] ring gfx_32772.1.1 ib test pass
2024-09-19 23:44:34,991 DEBUG:	[drm] ring compute_32772.2.2 ib test pass
2024-09-19 23:44:34,991 DEBUG:	[drm] ring sdma_32772.3.3 ib test pass
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: format 3 timestamp 0x6128e16b
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3.wmfw: Fri 27 Aug 2021 14:58:19 W. Europe Daylight Time
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-r0.bin: v0.43.1
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A1.bin
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.43.1, 2 algorithms
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot-104317f3-spkid1-l0.bin: v0.43.1
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: C:\Users\dchunyi\Documents\Asus_ROG\Project\NR2301\Tuning\20221125\104317F3_221125_V1_A0.bin
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Calibration applied: R0=11654
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=11654
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-19 23:44:34,991 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
2024-09-19 23:44:34,991 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-19 23:44:34,991 DEBUG:	PM: resume of devices complete after 2805.051 msecs
2024-09-19 23:44:34,991 DEBUG:	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SBRG.EC0.LID], AE_NOT_FOUND (20240322/psargs-330)
2024-09-19 23:44:34,991 DEBUG:	ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20240322/psparse-531)
2024-09-19 23:44:34,991 DEBUG:	ACPI: \_SB_.PEP_: Failed to transitioned to state screen on
2024-09-19 23:44:34,991 DEBUG:	OOM killer enabled.
2024-09-19 23:44:34,991 DEBUG:	Restarting tasks ... 
2024-09-19 23:44:34,991 DEBUG:	usb 1-2: USB disconnect, device number 21
2024-09-19 23:44:34,991 DEBUG:	xpad 1-2:1.0: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
2024-09-19 23:44:34,991 DEBUG:	done.
2024-09-19 23:44:34,991 DEBUG:	random: crng reseeded on system resumption
2024-09-19 23:44:34,991 DEBUG:	PM: suspend exit
2024-09-19 23:44:34,991 DEBUG:	usb 1-3: USB disconnect, device number 20
2024-09-19 23:44:34,991 DEBUG:	usb 1-3: new full-speed USB device number 22 using xhci_hcd
2024-09-19 23:44:34,991 DEBUG:	usb 1-3: New USB device found, idVendor=0b05, idProduct=1abe, bcdDevice= 0.02
2024-09-19 23:44:34,991 DEBUG:	usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-09-19 23:44:34,991 DEBUG:	usb 1-3: Product: N-KEY Device
2024-09-19 23:44:34,991 DEBUG:	usb 1-3: Manufacturer: ASUSTeK Computer Inc.
2024-09-19 23:44:34,991 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.0/0003:0B05:1ABE.0026/input/input77
2024-09-19 23:44:34,991 DEBUG:	asus 0003:0B05:1ABE.0026: input,hidraw5: USB HID v1.10 Keyboard [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input0
2024-09-19 23:44:34,991 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.1/0003:0B05:1ABE.0027/input/input78
2024-09-19 23:44:34,991 DEBUG:	asus 0003:0B05:1ABE.0027: input,hidraw6: USB HID v1.10 Mouse [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input1
2024-09-19 23:44:34,991 DEBUG:	asus 0003:0B05:1ABE.0028: Fixing up Asus N-Key report descriptor
2024-09-19 23:44:34,991 DEBUG:	input: ASUSTeK Computer Inc. N-KEY Device as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-3/1-3:1.2/0003:0B05:1ABE.0028/input/input79
2024-09-19 23:44:34,991 DEBUG:	asus 0003:0B05:1ABE.0028: input,hiddev96,hidraw8: USB HID v1.10 Device [ASUSTeK Computer Inc. N-KEY Device] on usb-0000:09:00.3-3/input2
2024-09-19 23:44:34,991 DEBUG:	usb 1-2: new full-speed USB device number 23 using xhci_hcd
2024-09-19 23:44:34,991 DEBUG:	usb 1-2: New USB device found, idVendor=045e, idProduct=028e, bcdDevice= 1.14
2024-09-19 23:44:34,991 DEBUG:	usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
2024-09-19 23:44:34,992 DEBUG:	usb 1-2: Product: Controller
2024-09-19 23:44:34,992 DEBUG:	usb 1-2: Manufacturer: ©Microsoft Corporation
2024-09-19 23:44:34,992 DEBUG:	usb 1-2: SerialNumber: 1DD5F3D
2024-09-19 23:44:34,992 DEBUG:	input: Microsoft X-Box 360 pad as /devices/pci0000:00/0000:00:08.1/0000:09:00.3/usb1/1-2/1-2:1.0/input/input80
2024-09-19 23:44:34,992 DEBUG:	input input80: unable to receive magic message: -32
2024-09-19 23:44:34,992 INFO:	○ Suspend count: 1
2024-09-19 23:44:34,992 INFO:	○ Hardware sleep cycle count: 1
2024-09-19 23:44:34,992 INFO:	○ Wakeup triggered from IRQ 9: ACPI SCI
2024-09-19 23:44:34,992 DEBUG:	Used Microsoft uPEP GUID in LPS0 _DSM
2024-09-19 23:44:34,992 ERROR:	❌ ACPI BIOS errors found
2024-09-19 23:44:34,992 INFO:	○ Woke up from IRQ 9: ACPI SCI
2024-09-19 23:44:34,992 INFO:	○ gpe10 increased from 89 to 95
2024-09-19 23:44:34,992 INFO:	✅ Userspace suspended for 0:01:24.984043
2024-09-19 23:44:34,992 DEBUG:	Kernel suspended for total of 0:01:19.497000 (93.54%)
2024-09-19 23:44:34,992 INFO:	✅ In a hardware sleep state for 0:01:18.970489 (92.92%)
2024-09-19 23:44:34,999 DEBUG:	BAT0 energy level is 31889000 µWh
2024-09-19 23:44:34,999 INFO:	🔋 Battery BAT0 lost 16000 µWh (0.05%) [Average rate 0.07W]
2024-09-19 23:44:34,999 INFO:	Explanations for your system
2024-09-19 23:44:34,999 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-19 23:44:34,999 WARNING:	🚦 ACPI BIOS Errors detected
2024-09-19 23:44:34,999 WARNING:	🚦 ACPI BIOS Errors detected


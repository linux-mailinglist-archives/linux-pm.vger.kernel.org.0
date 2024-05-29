Return-Path: <linux-pm+bounces-8354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F7C8D33C2
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 11:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03140284F3C
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F61174EE4;
	Wed, 29 May 2024 09:56:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968516A360
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976562; cv=none; b=YcV0hIi+Yr3sE152glw9nvc5jWT+RWANjQN90bevhnGOjTCQpGDdUweXGy1CPhtgMVIk9TznE/ntitBw0BC/kku5giGw2AWosS1RSeZatzg53C/j7YI5tl5MSGGG+hPv48s+G5x1yv6QJYKfy5ajkbc1u67H3RUz6Cx1Ny9QMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976562; c=relaxed/simple;
	bh=ITQ/z1zIzrYZ4Xd1fZmZm4bgCItj5Q61mHuXHgbtJug=;
	h=Message-ID:Date:MIME-Version:From:Cc:To:Subject:Content-Type; b=ut8ebyrPorG8lTsEKmkJdl335kZig8QFn58prFiPFqXA6tx7eUi7wi/Tm3WN1lyGB6IpMLnjbJ+rSZQJduT34uJ5R2SL/PoJE2gZANnSM9ym0of0EgUlJdjo7tHB4/cYyPY+k7TrcEObKgJWnN24k2fpAC5/5692Z0rQH+Uft+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af7f7.dynamic.kabel-deutschland.de [95.90.247.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C3DAC61E5FE01;
	Wed, 29 May 2024 11:55:41 +0200 (CEST)
Message-ID: <83326c68-e1f9-43b3-8cc4-6cf88cfbdbfa@molgen.mpg.de>
Date: Wed, 29 May 2024 11:55:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mike Jones <mike@mjones.io>, Hans de Goede <hdegoede@redhat.com>
To: linux-pm@vger.kernel.org
Subject: Dell XPS 13 9360 (Kaby Lake): Power button LED stays sporadically
 trying to S0ix suspend
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On the Intel Kaby Lake Dell XPS 13 9360, I have been using ACPI S3 
(`mem_sleep_default=deep`) over S0ix since starting to use the device 
over half a year in October/November 2023 due to the feeling, that the 
battery was drained a lot more with S0ix.

Looking into other problems, cf. *Dell XPS 13 9360: 
`slp_s0_residency_usec` stays 0* [1], I was pointed to S0ix self test 
tools [2], and now test s2idle sporadically. Today, with Linux 
6.10.0-rc1-00021-ge0cce98fe279, I did

     $ echo s2idle | sudo tee /sys/power/mem_sleep

and suspended the system from the GNOME Shell menu. The screen turned 
black, but the power button LED stayed on, so I believe it didn’t really 
suspend. Pressing a keyboard key did nothing – maybe expected. Pressing 
the power button it resumed. The logs contain:

     [    0.000000] Linux version 6.10.0-rc1-00021-ge0cce98fe279 
(build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-25) 13.2.0, 
GNU ld (GNU Binutils for Debian) 2.42) #167 SMP PREEMPT_DYNAMIC Wed May 
29 06:05:16 CEST 2024
     [    0.000000] Command line: 
BOOT_IMAGE=/vmlinuz-6.10.0-rc1-00021-ge0cce98fe279 
root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer 
mem_sleep_default=deep log_buf_len=8M cryptomgr.notests
     [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 
06/02/2022
     […]
     [ 2917.885886] PM: suspend entry (s2idle)
     [ 2917.893434] Filesystems sync: 0.007 seconds
     [ 2917.895608] Freezing user space processes
     [ 2917.897114] Freezing user space processes completed (elapsed 
0.001 seconds)
     [ 2917.897117] OOM killer disabled.
     [ 2917.897118] Freezing remaining freezable tasks
     [ 2917.898487] Freezing remaining freezable tasks completed 
(elapsed 0.001 seconds)
     [ 2917.898490] printk: Suspending console(s) (use 
no_console_suspend to debug)
     [ 2918.091771] ACPI: EC: interrupt blocked
     [ 2956.317686] intel_pch_thermal 0000:00:14.2: Wakeup event 
detected, abort cooling
     [ 2956.350676] ACPI: EC: interrupt unblocked
     [ 2956.589690] usb 1-3: reset full-speed USB device number 2 using 
xhci_hcd
     [ 2956.616448] r8152 4-1.2:1.0 enx18dbf22dccf3: carrier on
     [ 2956.741393] OOM killer enabled.
     [ 2956.741402] Restarting tasks ... done.
     [ 2956.744243] random: crng reseeded on system resumption
     [ 2956.745947] mei_hdcp 
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 
(ops i915_hdcp_ops [i915])
     [ 2956.833723] PM: suspend exit
     [ 2956.887812] Process accounting resumed

Testing a later again, it worked, that means the power button LED turned 
off.

     [ 7977.402744] PM: suspend entry (s2idle)
     [ 7977.410894] Filesystems sync: 0.008 seconds
     [ 7977.414415] Freezing user space processes
     [ 7977.415982] Freezing user space processes completed (elapsed 
0.001 seconds)
     [ 7977.415985] OOM killer disabled.
     [ 7977.415986] Freezing remaining freezable tasks
     [ 7977.417507] Freezing remaining freezable tasks completed 
(elapsed 0.001 seconds)
     [ 7977.417524] printk: Suspending console(s) (use 
no_console_suspend to debug)
     [ 7977.637987] ACPI: EC: interrupt blocked
     [ 7977.641470] intel_pch_thermal 0000:00:14.2: CPU-PCH is cool [44C]
     [ 7979.244068] ACPI: EC: interrupt unblocked
     [ 7979.489907] usb 1-3: reset full-speed USB device number 2 using 
xhci_hcd
     [ 7979.510653] r8152 4-1.2:1.0 enx18dbf22dccf3: carrier on
     [ 7979.644236] OOM killer enabled.
     [ 7979.644243] Restarting tasks ... done.
     [ 7979.648330] random: crng reseeded on system resumption
     [ 7979.649654] mei_hdcp 
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 
(ops i915_hdcp_ops [i915])
     [ 7979.745631] PM: suspend exit
     [ 7979.799159] Process accounting resumed

The difference is:

1.  LED stays on:

         intel_pch_thermal 0000:00:14.2: Wakeup event detected, abort 
cooling

2.  LED turns off:

         intel_pch_thermal 0000:00:14.2: CPU-PCH is cool [44C]

Does intel_pch_thermal prevent the system from S0ix suspending, so the 
LED stays on until the device is cooled down? If so, could this be 
better logged, so users know, what is going on. The driver description 
only says, that reading capabilities are provided:

     config INTEL_PCH_THERMAL
             tristate "Intel PCH Thermal Reporting Driver"
             depends on X86 && PCI
             select ACPI_THERMAL_LIB if ACPI
             help
               Enable this to support thermal reporting on certain intel 
PCHs.
               Thermal reporting device will provide temperature reading,
               programmable trip points and other information.

If intel_pch_thermal does *not* prevent the system from reaching S0ix 
state, can you please point me to the correct subsystem to report this to?


Kind regards,

Paul


[1]: 
https://lore.kernel.org/platform-driver-x86/38fc334a-7c8c-4e43-bf63-6ac9aa882a2f@molgen.mpg.de/
[2]: https://github.com/intel/S0ixSelftestTool/


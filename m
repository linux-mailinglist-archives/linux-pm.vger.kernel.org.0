Return-Path: <linux-pm+bounces-7940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054FE8C8AB9
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 19:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED7F286BEA
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0813DB98;
	Fri, 17 May 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN5sDJ31"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8413DB92;
	Fri, 17 May 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966164; cv=none; b=cSPibZp1/rJyvpiUcFE4QKFCKIsIz2ZRZDr7RUTb7f0lQ+8QMDhw7N1yMC2Jv4FbzDPDagMJaQ/ge1kug2Dem8vv89RyGqTUDReZMG0RNTqI5LBNx+TdXrKWYkz4aU4t0ud2GJCU+jcwapLV6TISzPPwUv1YDhznokQ8s5VLBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966164; c=relaxed/simple;
	bh=kwg0K5xFOVJ5fadBAcdAiQ0mtr4TMZzrMeT9bnHwdrc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GxWBd7Nb8u/61hY0lX3+x+nlP6PZRZoZCtm/NoRhTKxJrryqR1PGQnUQYNZy+GxO0fHhSBjqpEh/ZUf4wPdOOUlyNUFmNTe73QAqJ1jqh1/nIuEyqJXgH96GSMPaKIDrV1TTcg/j3m+2jWyahocqmsosBoCqCvL5KD9v+/T1mm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN5sDJ31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4DDC2BD10;
	Fri, 17 May 2024 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715966163;
	bh=kwg0K5xFOVJ5fadBAcdAiQ0mtr4TMZzrMeT9bnHwdrc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NN5sDJ31JWaxWloEJoEuta+u1E1pBH3p1OVqId1u6Zbmt2MlLF6mDl2zO/RrmFj61
	 kJe2oCErsuOuNUCWA2kun2vhimEKK5F3ove3yaXjfv8s9PmKMfdNsn4ztw4TE2uaAd
	 F/TFsa8rmeRRylJe5B73+6635MvGTzaYYhlMyybEALlZ84+wzncPfnjAvDd+ddRNzg
	 PidoyT1VB9NmJtD7ruZG7tQhINJ7v2b2gur+NSGqPfX3m01we8MTKco7pvg2146Wwk
	 BtL1lSiNdPVM93GtEDqMfZy8oObgO7qZNvwj99A8w6wM241lGiCK5h+/nEy5YYsPdT
	 l+k8hiNIj4/AA==
From: Kalle Valo <kvalo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  x86@kernel.org,  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org,
  regressions@lists.linux.dev,  Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
References: <87o79cjjik.fsf@kernel.org>
	<20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
	<20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
	<87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org>
	<874jb0jzx5.fsf@kernel.org>
	<20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>
Date: Fri, 17 May 2024 20:15:58 +0300
In-Reply-To: <20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local> (Borislav
	Petkov's message of "Tue, 14 May 2024 18:05:55 +0200")
Message-ID: <87msoofjg1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Borislav Petkov <bp@alien8.de> writes:

> Kalle, can you connect that box to serial and catch full dmesg?
>
> There might be some #GP or so in the logs in case we've managed to f*ck
> up microcode application which emulates that IBRS MSR bit and the
> actual toggling or so when suspending...

So the weird part is that when the bug happens (ie. suspend stalls) I
can access the box normally using ssh and I don't see anything special
in dmesg. Below is a full copy of dmesg output after the suspend
stalled. Do note that I copied this dmesg before I updated microcode so
it will still show the old microcode version.

Let me know if you need more info.

Kalle


[    0.000000] Linux version 6.9.0 (kvalo@tykki) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1516 SMP PREEMPT_DYNAMIC Fri May 17 11:11:04 EEST 2024
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.9.0 root=UUID=61a268dc-df96-4e69-9272-928240dcc445 ro net.ifnames=0 net.ifnames=0 ignore_loglevel ignore_loglevel netconsole=6666@192.168.2.104/eth1,514@192.168.2.1/ba:52:4d:77:4f:8e
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007704ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000077050000-0x0000000077050fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000077051000-0x0000000077051fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000077052000-0x000000007e701fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e702000-0x000000007ebc5fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ebc6000-0x000000007ec24fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007ec25000-0x000000007ec84fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007ec85000-0x000000007f7fdfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007f7fe000-0x000000007f7fefff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f7ff000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027effffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x74058018-0x74076457] usable ==> usable
[    0.000000] e820: update [mem 0x74048018-0x74057057] usable ==> usable
[    0.000000] e820: update [mem 0x74037018-0x74047e57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000074037017] usable
[    0.000000] reserve setup_data: [mem 0x0000000074037018-0x0000000074047e57] usable
[    0.000000] reserve setup_data: [mem 0x0000000074047e58-0x0000000074048017] usable
[    0.000000] reserve setup_data: [mem 0x0000000074048018-0x0000000074057057] usable
[    0.000000] reserve setup_data: [mem 0x0000000074057058-0x0000000074058017] usable
[    0.000000] reserve setup_data: [mem 0x0000000074058018-0x0000000074076457] usable
[    0.000000] reserve setup_data: [mem 0x0000000074076458-0x000000007704ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000077050000-0x0000000077050fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000077051000-0x0000000077051fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000077052000-0x000000007e701fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007e702000-0x000000007ebc5fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007ebc6000-0x000000007ec24fff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007ec25000-0x000000007ec84fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007ec85000-0x000000007f7fdfff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f7fe000-0x000000007f7fefff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f7ff000-0x000000007fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000027effffff] usable
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: TPMFinalLog=0x7ec54000 ACPI 2.0=0x7ebda000 ACPI=0x7ebda000 SMBIOS=0x7f5e6000 SMBIOS 3.0=0x7f5e5000 ESRT=0x7f5ad598 MEMATTR=0x7cd71418 RNG=0x7ebd9018 TPMEventLog=0x77130018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem35: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Not removing mem36: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem37: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem38: MMIO range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem39: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem40: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[    0.000000] tsc: Detected 3100.000 MHz processor
[    0.000000] tsc: Detected 3099.999 MHz TSC
[    0.001298] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001309] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001324] last_pfn = 0x27f000 max_arch_pfn = 0x400000000
[    0.001330] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.001334] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001905] last_pfn = 0x7f7ff max_arch_pfn = 0x400000000
[    0.008598] esrt: Reserving ESRT space from 0x000000007f5ad598 to 0x000000007f5ad5d0.
[    0.030357] Secure boot disabled
[    0.030362] RAMDISK: [mem 0x74077000-0x7504bfff]
[    0.030370] ACPI: Early table checksum verification disabled
[    0.030376] ACPI: RSDP 0x000000007EBDA000 000024 (v02 INTEL )
[    0.030387] ACPI: XSDT 0x000000007EBDA0C0 000104 (v01 INTEL  NUC8i7HN 00000043 AMI  00010013)
[    0.030399] ACPI: FACP 0x000000007EC07240 000114 (v06 INTEL  NUC8i7HN 00000043 AMI  00010013)
[    0.030412] ACPI: DSDT 0x000000007EBDA258 02CFE7 (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030421] ACPI: FACS 0x000000007EC84F80 000040
[    0.030430] ACPI: APIC 0x000000007EC07358 0000BC (v03 INTEL  NUC8i7HN 00000043 AMI  00010013)
[    0.030439] ACPI: FPDT 0x000000007EC07418 000044 (v01 INTEL  NUC8i7HN 00000043 AMI  00010013)
[    0.030448] ACPI: FIDT 0x000000007EC07460 00009C (v01 INTEL  NUC8i7HN 00000043 AMI  00010013)
[    0.030457] ACPI: MCFG 0x000000007EC07500 00003C (v01 INTEL  NUC8i7HN 00000043 MSFT 00000097)
[    0.030466] ACPI: SSDT 0x000000007EC07540 000359 (v01 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030475] ACPI: SSDT 0x000000007EC078A0 003165 (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030485] ACPI: SSDT 0x000000007EC0AA08 002892 (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030494] ACPI: HPET 0x000000007EC0D2A0 000038 (v01 INTEL  NUC8i7HN 00000043 MSFT 0000005F)
[    0.030503] ACPI: SSDT 0x000000007EC0D2D8 0011AA (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030512] ACPI: SSDT 0x000000007EC0E488 0008FC (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030521] ACPI: UEFI 0x000000007EC0ED88 000048 (v01 INTEL  NUC8i7HN 00000043      01000013)
[    0.030530] ACPI: SSDT 0x000000007EC0EDD0 00071D (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030539] ACPI: SSDT 0x000000007EC0F4F0 0017AE (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030549] ACPI: LPIT 0x000000007EC10CA0 000094 (v01 INTEL  NUC8i7HN 00000043 MSFT 0000005F)
[    0.030558] ACPI: SSDT 0x000000007EC10D38 000141 (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030567] ACPI: SSDT 0x000000007EC10E80 00029F (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030576] ACPI: SSDT 0x000000007EC11120 003002 (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030585] ACPI: SSDT 0x000000007EC14128 000279 (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030594] ACPI: SSDT 0x000000007EC143A8 0002E9 (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030603] ACPI: DBGP 0x000000007EC14698 000034 (v01 INTEL  NUC8i7HN 00000043 MSFT 0000005F)
[    0.030612] ACPI: DBG2 0x000000007EC146D0 000054 (v00 INTEL  NUC8i7HN 00000043 MSFT 0000005F)
[    0.030622] ACPI: SSDT 0x000000007EC14728 0004F4 (v02 INTEL  NUC8i7HN 00000043 INTL 20160422)
[    0.030631] ACPI: DMAR 0x000000007EC14C20 0000DC (v01 INTEL  NUC8i7HN 00000043 INTL 00000001)
[    0.030640] ACPI: VFCT 0x000000007EC14D00 00FE84 (v01 INTEL  NUC8i7HN 00000043 AMD  31504F47)
[    0.030649] ACPI: TPM2 0x000000007EC24B88 000034 (v04 INTEL  NUC8i7HN 00000043 AMI  00000000)
[    0.030658] ACPI: BGRT 0x000000007EC24BC0 000038 (v01 INTEL  NUC8i7HN 00000043 AMI  00010013)
[    0.030667] ACPI: WSMT 0x000000007EC24BF8 000028 (v01 INTEL  NUC8i7HN 00000043 AMI  00010013)
[    0.030676] ACPI: Reserving FACP table memory at [mem 0x7ec07240-0x7ec07353]
[    0.030680] ACPI: Reserving DSDT table memory at [mem 0x7ebda258-0x7ec0723e]
[    0.030684] ACPI: Reserving FACS table memory at [mem 0x7ec84f80-0x7ec84fbf]
[    0.030687] ACPI: Reserving APIC table memory at [mem 0x7ec07358-0x7ec07413]
[    0.030690] ACPI: Reserving FPDT table memory at [mem 0x7ec07418-0x7ec0745b]
[    0.030693] ACPI: Reserving FIDT table memory at [mem 0x7ec07460-0x7ec074fb]
[    0.030696] ACPI: Reserving MCFG table memory at [mem 0x7ec07500-0x7ec0753b]
[    0.030699] ACPI: Reserving SSDT table memory at [mem 0x7ec07540-0x7ec07898]
[    0.030702] ACPI: Reserving SSDT table memory at [mem 0x7ec078a0-0x7ec0aa04]
[    0.030705] ACPI: Reserving SSDT table memory at [mem 0x7ec0aa08-0x7ec0d299]
[    0.030708] ACPI: Reserving HPET table memory at [mem 0x7ec0d2a0-0x7ec0d2d7]
[    0.030712] ACPI: Reserving SSDT table memory at [mem 0x7ec0d2d8-0x7ec0e481]
[    0.030715] ACPI: Reserving SSDT table memory at [mem 0x7ec0e488-0x7ec0ed83]
[    0.030718] ACPI: Reserving UEFI table memory at [mem 0x7ec0ed88-0x7ec0edcf]
[    0.030721] ACPI: Reserving SSDT table memory at [mem 0x7ec0edd0-0x7ec0f4ec]
[    0.030724] ACPI: Reserving SSDT table memory at [mem 0x7ec0f4f0-0x7ec10c9d]
[    0.030727] ACPI: Reserving LPIT table memory at [mem 0x7ec10ca0-0x7ec10d33]
[    0.030730] ACPI: Reserving SSDT table memory at [mem 0x7ec10d38-0x7ec10e78]
[    0.030734] ACPI: Reserving SSDT table memory at [mem 0x7ec10e80-0x7ec1111e]
[    0.030737] ACPI: Reserving SSDT table memory at [mem 0x7ec11120-0x7ec14121]
[    0.030740] ACPI: Reserving SSDT table memory at [mem 0x7ec14128-0x7ec143a0]
[    0.030743] ACPI: Reserving SSDT table memory at [mem 0x7ec143a8-0x7ec14690]
[    0.030746] ACPI: Reserving DBGP table memory at [mem 0x7ec14698-0x7ec146cb]
[    0.030749] ACPI: Reserving DBG2 table memory at [mem 0x7ec146d0-0x7ec14723]
[    0.030752] ACPI: Reserving SSDT table memory at [mem 0x7ec14728-0x7ec14c1b]
[    0.030756] ACPI: Reserving DMAR table memory at [mem 0x7ec14c20-0x7ec14cfb]
[    0.030759] ACPI: Reserving VFCT table memory at [mem 0x7ec14d00-0x7ec24b83]
[    0.030762] ACPI: Reserving TPM2 table memory at [mem 0x7ec24b88-0x7ec24bbb]
[    0.030765] ACPI: Reserving BGRT table memory at [mem 0x7ec24bc0-0x7ec24bf7]
[    0.030768] ACPI: Reserving WSMT table memory at [mem 0x7ec24bf8-0x7ec24c1f]
[    0.031118] No NUMA configuration found
[    0.031121] Faking a node at [mem 0x0000000000000000-0x000000027effffff]
[    0.031130] NODE_DATA(0) allocated [mem 0x27e012000-0x27e015fff]
[    0.040296] Zone ranges:
[    0.040299]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.040305]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.040310]   Normal   [mem 0x0000000100000000-0x000000027effffff]
[    0.040316] Movable zone start for each node
[    0.040318] Early memory node ranges
[    0.040321]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.040324]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.040327]   node   0: [mem 0x0000000000100000-0x000000007704ffff]
[    0.040331]   node   0: [mem 0x0000000077052000-0x000000007e701fff]
[    0.040334]   node   0: [mem 0x000000007f7fe000-0x000000007f7fefff]
[    0.040337]   node   0: [mem 0x0000000100000000-0x000000027effffff]
[    0.040341] Initmem setup node 0 [mem 0x0000000000001000-0x000000027effffff]
[    0.040353] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.040359] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.040501] On node 0, zone DMA: 98 pages in unavailable ranges
[    0.053927] On node 0, zone DMA32: 2 pages in unavailable ranges
[    0.055444] On node 0, zone DMA32: 4348 pages in unavailable ranges
[    0.097875] On node 0, zone Normal: 2049 pages in unavailable ranges
[    0.099305] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.176718] kasan: KernelAddressSanitizer initialized
[    0.177661] ACPI: PM-Timer IO Port: 0x1808
[    0.177670] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.177674] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.177677] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.177679] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.177682] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.177685] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.177687] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.177690] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.177727] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.177735] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.177739] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.177748] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.177750] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.177761] e820: update [mem 0x7b09d000-0x7b136fff] usable ==> reserved
[    0.177783] TSC deadline timer available
[    0.177789] CPU topo: Max. logical packages:   1
[    0.177791] CPU topo: Max. logical dies:       1
[    0.177794] CPU topo: Max. dies per package:   1
[    0.177799] CPU topo: Max. threads per core:   2
[    0.177802] CPU topo: Num. cores per package:     4
[    0.177804] CPU topo: Num. threads per package:   8
[    0.177807] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.177878] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.177884] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.177889] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x000fffff]
[    0.177894] PM: hibernation: Registered nosave memory: [mem 0x74037000-0x74037fff]
[    0.177899] PM: hibernation: Registered nosave memory: [mem 0x74047000-0x74047fff]
[    0.177902] PM: hibernation: Registered nosave memory: [mem 0x74048000-0x74048fff]
[    0.177907] PM: hibernation: Registered nosave memory: [mem 0x74057000-0x74057fff]
[    0.177909] PM: hibernation: Registered nosave memory: [mem 0x74058000-0x74058fff]
[    0.177914] PM: hibernation: Registered nosave memory: [mem 0x74076000-0x74076fff]
[    0.177919] PM: hibernation: Registered nosave memory: [mem 0x77050000-0x77050fff]
[    0.177922] PM: hibernation: Registered nosave memory: [mem 0x77051000-0x77051fff]
[    0.177927] PM: hibernation: Registered nosave memory: [mem 0x7b09d000-0x7b136fff]
[    0.177932] PM: hibernation: Registered nosave memory: [mem 0x7e702000-0x7ebc5fff]
[    0.177935] PM: hibernation: Registered nosave memory: [mem 0x7ebc6000-0x7ec24fff]
[    0.177938] PM: hibernation: Registered nosave memory: [mem 0x7ec25000-0x7ec84fff]
[    0.177940] PM: hibernation: Registered nosave memory: [mem 0x7ec85000-0x7f7fdfff]
[    0.177946] PM: hibernation: Registered nosave memory: [mem 0x7f7ff000-0x7fffffff]
[    0.177948] PM: hibernation: Registered nosave memory: [mem 0x80000000-0xfdffffff]
[    0.177951] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.177954] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.177956] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.177959] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.177962] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.177964] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfedfffff]
[    0.177967] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.177969] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
[    0.177977] [mem 0x80000000-0xfdffffff] available for PCI devices
[    0.177984] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.178003] setup_percpu: NR_CPUS:64 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.181709] percpu: Embedded 525 pages/cpu s2110760 r8192 d31448 u4194304
[    0.181725] pcpu-alloc: s2110760 r8192 d31448 u4194304 alloc=2*2097152
[    0.181731] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.181806] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.9.0 root=UUID=61a268dc-df96-4e69-9272-928240dcc445 ro net.ifnames=0 net.ifnames=0 ignore_loglevel ignore_loglevel netconsole=6666@192.168.2.104/eth1,514@192.168.2.1/ba:52:4d:77:4f:8e
[    0.181969] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.9.0", will be passed to user space.
[    0.182569] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.182855] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.183292] Fallback order for Node 0: 0 
[    0.183298] Built 1 zonelists, mobility grouping on.  Total pages: 2053796
[    0.183301] Policy zone: Normal
[    0.183327] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.183331] stackdepot: allocating hash table via alloc_large_system_hash
[    0.183337] stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
[    0.184472] software IO TLB: area num 8.
[    1.209408] Memory: 6586356K/8346228K available (49152K kernel code, 14265K rwdata, 10640K rodata, 4148K init, 278252K bss, 1759616K reserved, 0K cma-reserved)
[    1.209415] **********************************************************
[    1.209418] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    1.209420] **                                                      **
[    1.209422] ** This system shows unhashed kernel memory addresses   **
[    1.209425] ** via the console, logs, and other interfaces. This    **
[    1.209427] ** might reduce the security of your system.            **
[    1.209429] **                                                      **
[    1.209431] ** If you see this message and you are not debugging    **
[    1.209433] ** the kernel, report this immediately to your system   **
[    1.209436] ** administrator!                                       **
[    1.209438] **                                                      **
[    1.209440] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    1.209442] **********************************************************
[    1.209947] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    1.214108] allocated 16777216 bytes of page_ext
[    1.214696] Dynamic Preempt: full
[    1.216214] Running RCU self tests
[    1.216217] Running RCU synchronous self tests
[    1.216279] rcu: Preemptible hierarchical RCU implementation.
[    1.216282] rcu: 	RCU event tracing is enabled.
[    1.216284] rcu: 	RCU lockdep checking is enabled.
[    1.216287] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[    1.216290] rcu: 	RCU callback double-/use-after-free debug is enabled.
[    1.216292] rcu: 	RCU debug extended QS entry/exit.
[    1.216295] 	Trampoline variant of Tasks RCU enabled.
[    1.216297] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    1.216300] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    1.216427] Running RCU synchronous self tests
[    1.216440] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    1.250121] NR_IRQS: 4352, nr_irqs: 2048, preallocated irqs: 16
[    1.251017] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    1.251737] Console: colour dummy device 80x25
[    1.251767] printk: legacy console [tty0] enabled
[    1.261171] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    1.261214] ... MAX_LOCKDEP_SUBCLASSES:  8
[    1.261238] ... MAX_LOCK_DEPTH:          48
[    1.261262] ... MAX_LOCKDEP_KEYS:        8192
[    1.261287] ... CLASSHASH_SIZE:          4096
[    1.261311] ... MAX_LOCKDEP_ENTRIES:     32768
[    1.261336] ... MAX_LOCKDEP_CHAINS:      65536
[    1.261361] ... CHAINHASH_SIZE:          32768
[    1.261386]  memory used by lock dependency info: 6941 kB
[    1.261415]  memory used for stack traces: 262272 kB
[    1.261442]  per task-struct memory footprint: 2688 bytes
[    1.261616] ACPI: Core revision 20230628
[    1.263554] hpet: HPET dysfunctional in PC10. Force disabled.
[    1.263587] APIC: Switch to symmetric I/O mode setup
[    1.263617] DMAR: Host address width 39
[    1.263640] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    1.263791] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap d2008c40660462 ecap f050da
[    1.263836] DMAR: RMRR base: 0x0000007ef05000 end: 0x0000007f14efff
[    1.263897] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    1.263926] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    1.263953] DMAR: ANDD device: 9 name: \_SB.PCI0.UA00
[    1.263982] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
[    1.264016] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
[    1.265640] DMAR-IR: Enabled IRQ remapping in xapic mode
[    1.271111] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2caf46e03c8, max_idle_ns: 440795329092 ns
[    1.271319] Calibrating delay loop (skipped), value calculated using timer frequency.. 6199.99 BogoMIPS (lpj=3099999)
[    1.271401] CPU0: Thermal monitoring enabled (TM1)
[    1.271548] numa_add_cpu cpu 0 node 0: mask now 0
[    1.271580] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    1.271611] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    1.271654] process: using mwait in idle threads
[    1.271689] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.271737] Spectre V2 : Mitigation: IBRS
[    1.271766] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.271824] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    1.271871] RETBleed: Mitigation: IBRS
[    1.271907] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    1.271966] Spectre V2 : User space: Mitigation: STIBP via prctl
[    1.272014] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    1.272104] MDS: Mitigation: Clear CPU buffers
[    1.272141] MMIO Stale Data: Mitigation: Clear CPU buffers
[    1.272187] SRBDS: Mitigation: Microcode
[    1.272228] GDS: Mitigation: Microcode
[    1.272277] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    1.272304] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    1.272304] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    1.272304] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    1.272304] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    1.272304] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    1.272304] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    1.272304] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    1.272304] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    1.272304] debug: unmapping init [mem 0xffffffff9a239000-0xffffffff9a243fff]
[    1.272304] pid_max: default: 32768 minimum: 301
[    1.272304] LSM: initializing lsm=capability,selinux
[    1.272304] SELinux:  Initializing.
[    1.272304] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.272304] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.272304] Running RCU synchronous self tests
[    1.272304] Running RCU synchronous self tests
[    1.272304] smpboot: CPU0: Intel(R) Core(TM) i7-8809G CPU @ 3.10GHz (family: 0x6, model: 0x9e, stepping: 0x9)
[    1.277873] Running RCU Tasks wait API self tests
[    1.383425] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    1.383661] ... version:                4
[    1.383698] ... bit width:              48
[    1.383735] ... generic registers:      4
[    1.383771] ... value mask:             0000ffffffffffff
[    1.383816] ... max period:             00007fffffffffff
[    1.383861] ... fixed-purpose events:   3
[    1.383897] ... event mask:             000000070000000f
[    1.384645] signal: max sigframe size: 2032
[    1.384749] Estimated ratio of average max frequency by base frequency (times 1024): 1288
[    1.387399] rcu: Hierarchical SRCU implementation.
[    1.387443] rcu: 	Max phase no-delay instances is 400.
[    1.399742] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.402959] smp: Bringing up secondary CPUs ...
[    1.405895] smpboot: x86: Booting SMP configuration:
[    1.405961] .... node  #0, CPUs:      #1 #2 #3
[    0.021155] numa_add_cpu cpu 1 node 0: mask now 0-1
[    0.021155] numa_add_cpu cpu 2 node 0: mask now 0-2
[    0.021155] numa_add_cpu cpu 3 node 0: mask now 0-3
[    1.417484]  #4 #5 #6 #7
[    0.021155] numa_add_cpu cpu 4 node 0: mask now 0-4
[    1.430366] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    1.430568] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.021155] numa_add_cpu cpu 5 node 0: mask now 0-5
[    0.021155] numa_add_cpu cpu 6 node 0: mask now 0-6
[    0.021155] numa_add_cpu cpu 7 node 0: mask now 0-7
[    1.432508] smp: Brought up 1 node, 8 CPUs
[    1.432532] smpboot: Total of 8 processors activated (49599.98 BogoMIPS)
[    1.446329] devtmpfs: initialized
[    1.472344] ACPI: PM: Registering ACPI NVS region [mem 0x77050000-0x77050fff] (4096 bytes)
[    1.472453] ACPI: PM: Registering ACPI NVS region [mem 0x7ec25000-0x7ec84fff] (393216 bytes)
[    1.476026] Running RCU synchronous self tests
[    1.476114] Running RCU synchronous self tests
[    1.484774] DMA-API: preallocated 65536 debug entries
[    1.484824] DMA-API: debugging enabled by kernel config
[    1.484871] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.484985] futex hash table entries: 2048 (order: 6, 262144 bytes, linear)
[    1.487688] PM: RTC time: 10:24:11, date: 2024-05-17
[    1.490516] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.497900] audit: initializing netlink subsys (disabled)
[    1.498567] audit: type=2000 audit(1715941451.227:1): state=initialized audit_enabled=0 res=1
[    1.503495] thermal_sys: Registered thermal governor 'step_wise'
[    1.503504] thermal_sys: Registered thermal governor 'user_space'
[    1.503826] cpuidle: using governor menu
[    1.506275] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.509637] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    1.509718] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not reserved)
[    1.509787] PCI: Using configuration type 1 for base access
[    1.510532] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.511703] workqueue: round-robin CPU selection forced, expect performance impact
[    1.514508] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.514535] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.516982] Demotion targets for Node 0: null
[    1.527801] ACPI: Added _OSI(Module Device)
[    1.527845] ACPI: Added _OSI(Processor Device)
[    1.527887] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.527930] ACPI: Added _OSI(Processor Aggregator Device)
[    1.592091] Callback from call_rcu_tasks() invoked.
[    3.992350] ACPI: 14 ACPI AML tables successfully acquired and loaded
[    4.623700] ACPI: Dynamic OEM Table Load:
[    4.623816] ACPI: SSDT 0xFFFF888106EF9000 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    4.662510] ACPI: Dynamic OEM Table Load:
[    4.662620] ACPI: SSDT 0xFFFF888106F3E800 0006B4 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    4.746857] ACPI: Dynamic OEM Table Load:
[    4.746970] ACPI: SSDT 0xFFFF888106F04000 000D14 (v02 PmRef  ApIst    00003000 INTL 20160422)
[    4.894776] ACPI: Dynamic OEM Table Load:
[    4.894939] ACPI: SSDT 0xFFFF888106EF9C00 000317 (v02 PmRef  ApHwp    00003000 INTL 20160422)
[    4.931954] ACPI: Dynamic OEM Table Load:
[    4.932128] ACPI: SSDT 0xFFFF888106EFA800 00030A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    5.206816] ACPI: _OSC evaluated successfully for all CPUs
[    5.216292] ACPI: EC: EC started
[    5.216309] ACPI: EC: interrupt blocked
[    5.216878] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    5.216946] ACPI: \_SB_.PCI0.LPCB.H_EC: Boot DSDT EC used to handle transactions
[    5.217020] ACPI: Interpreter enabled
[    5.217693] ACPI: PM: (supports S0 S3 S4 S5)
[    5.217745] ACPI: Using IOAPIC for interrupt routing
[    5.220079] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    5.360057] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
[    5.397927] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    5.398003] PCI: Using E820 reservations for host bridge windows
[    5.488466] ACPI: Enabled 7 GPEs in block 00 to 7F
[    5.677483] ACPI: \_SB_.PCI0.PEG0.PG00: New power resource
[    5.712106] ACPI: \_SB_.PCI0.PEG1.PG01: New power resource
[    5.796532] ACPI: \_SB_.PCI0.PEG2.PG02: New power resource
[    8.157611] ACPI: \_TZ_.FN00: New power resource
[    8.165670] ACPI: \_TZ_.FN01: New power resource
[    8.174017] ACPI: \_TZ_.FN02: New power resource
[    8.181980] ACPI: \_TZ_.FN03: New power resource
[    8.190180] ACPI: \_TZ_.FN04: New power resource
[    8.266350] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    8.266491] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    8.278254] acpi PNP0A08:00: _OSC: platform does not support [PME AER]
[    8.300320] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability LTR]
[    8.300380] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    8.338654] PCI host bridge to bus 0000:00
[    8.338719] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    8.338803] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    8.339038] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000effff window]
[    8.339123] pci_bus 0000:00: root bus resource [mem 0x80000000-0xdfffffff window]
[    8.339204] pci_bus 0000:00: root bus resource [mem 0x2000000000-0x2fffffffff window]
[    8.339288] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    8.339336] pci_bus 0000:00: root bus resource [bus 00-fe]
[    8.344386] pci 0000:00:00.0: [8086:5910] type 00 class 0x060000 conventional PCI endpoint
[    8.346765] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400 PCIe Root Port
[    8.346890] pci 0000:00:01.0: PCI bridge to [bus 01]
[    8.346940] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    8.346997] pci 0000:00:01.0:   bridge window [mem 0xdb800000-0xdc1fffff]
[    8.347081] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff 64bit pref]
[    8.347438] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    8.393894] pci 0000:00:01.1: [8086:1905] type 01 class 0x060400 PCIe Root Port
[    8.394020] pci 0000:00:01.1: PCI bridge to [bus 02]
[    8.394070] pci 0000:00:01.1:   bridge window [io  0xd000-0xdfff]
[    8.394126] pci 0000:00:01.1:   bridge window [mem 0xdae00000-0xdb7fffff]
[    8.394479] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    8.440037] pci 0000:00:01.2: [8086:1909] type 01 class 0x060400 PCIe Root Port
[    8.440162] pci 0000:00:01.2: PCI bridge to [bus 03]
[    8.440212] pci 0000:00:01.2:   bridge window [io  0xc000-0xcfff]
[    8.440268] pci 0000:00:01.2:   bridge window [mem 0xda400000-0xdadfffff]
[    8.440617] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    8.486057] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000 conventional PCI endpoint
[    8.486161] pci 0000:00:08.0: BAR 0 [mem 0x2ffff2b000-0x2ffff2bfff 64bit]
[    8.489065] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330 conventional PCI endpoint
[    8.489192] pci 0000:00:14.0: BAR 0 [mem 0x2ffff10000-0x2ffff1ffff 64bit]
[    8.489594] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    8.534252] pci 0000:00:14.2: [8086:a131] type 00 class 0x118000 conventional PCI endpoint
[    8.534761] pci 0000:00:14.2: BAR 0 [mem 0x2ffff2a000-0x2ffff2afff 64bit]
[    8.536769] pci 0000:00:15.0: [8086:a160] type 00 class 0x118000 conventional PCI endpoint
[    8.537050] pci 0000:00:15.0: BAR 0 [mem 0x2ffff29000-0x2ffff29fff 64bit]
[    8.555311] pci 0000:00:15.1: [8086:a161] type 00 class 0x118000 conventional PCI endpoint
[    8.555593] pci 0000:00:15.1: BAR 0 [mem 0x2ffff28000-0x2ffff28fff 64bit]
[    8.573056] pci 0000:00:15.2: [8086:a162] type 00 class 0x118000 conventional PCI endpoint
[    8.573337] pci 0000:00:15.2: BAR 0 [mem 0x2ffff27000-0x2ffff27fff 64bit]
[    8.591236] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000 conventional PCI endpoint
[    8.591942] pci 0000:00:16.0: BAR 0 [mem 0x2ffff26000-0x2ffff26fff 64bit]
[    8.592299] pci 0000:00:16.0: PME# supported from D3hot
[    8.620040] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400 PCIe Root Port
[    8.620195] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    8.620984] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    8.673676] pci 0000:00:1c.1: [8086:a111] type 01 class 0x060400 PCIe Root Port
[    8.673830] pci 0000:00:1c.1: PCI bridge to [bus 05]
[    8.673884] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    8.673942] pci 0000:00:1c.1:   bridge window [mem 0xdc300000-0xdc3fffff]
[    8.674402] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    8.674513] pci 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[    8.726214] pci 0000:00:1c.2: [8086:a112] type 01 class 0x060400 PCIe Root Port
[    8.726366] pci 0000:00:1c.2: PCI bridge to [bus 06]
[    8.726425] pci 0000:00:1c.2:   bridge window [mem 0xda200000-0xda3fffff]
[    8.726893] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    8.727003] pci 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[    8.777957] pci 0000:00:1c.4: [8086:a114] type 01 class 0x060400 PCIe Root Port
[    8.778113] pci 0000:00:1c.4: PCI bridge to [bus 07-71]
[    8.778175] pci 0000:00:1c.4:   bridge window [mem 0xac000000-0xda0fffff]
[    8.778259] pci 0000:00:1c.4:   bridge window [mem 0x2fb0000000-0x2ff9ffffff 64bit pref]
[    8.778669] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    8.778779] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[    8.829245] pci 0000:00:1d.0: [8086:a118] type 01 class 0x060400 PCIe Root Port
[    8.829781] pci 0000:00:1d.0: PCI bridge to [bus 72]
[    8.829842] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
[    8.830297] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    8.830369] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[    8.882009] pci 0000:00:1e.0: [8086:a127] type 00 class 0x118000 conventional PCI endpoint
[    8.882291] pci 0000:00:1e.0: BAR 0 [mem 0x2ffff25000-0x2ffff25fff 64bit]
[    8.899957] pci 0000:00:1f.0: [8086:a152] type 00 class 0x060100 conventional PCI endpoint
[    8.917804] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000 conventional PCI endpoint
[    8.917908] pci 0000:00:1f.2: BAR 0 [mem 0xda120000-0xda123fff]
[    8.935518] pci 0000:00:1f.3: [8086:a171] type 00 class 0x040300 conventional PCI endpoint
[    8.935637] pci 0000:00:1f.3: BAR 0 [mem 0x2ffff20000-0x2ffff23fff 64bit]
[    8.935752] pci 0000:00:1f.3: BAR 4 [mem 0x2ffff00000-0x2ffff0ffff 64bit]
[    8.936054] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    8.983451] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500 conventional PCI endpoint
[    8.983606] pci 0000:00:1f.4: BAR 0 [mem 0x2ffff24000-0x2ffff240ff 64bit]
[    8.983768] pci 0000:00:1f.4: BAR 4 [io  0xf000-0xf01f]
[    9.000528] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000 conventional PCI endpoint
[    9.000635] pci 0000:00:1f.6: BAR 0 [mem 0xda100000-0xda11ffff]
[    9.001014] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    9.019813] pci 0000:01:00.0: [1002:694c] type 00 class 0x030000 PCIe Legacy Endpoint
[    9.019923] pci 0000:01:00.0: BAR 0 [mem 0x90000000-0x9fffffff 64bit pref]
[    9.020008] pci 0000:01:00.0: BAR 2 [mem 0xa0000000-0xa01fffff 64bit pref]
[    9.020092] pci 0000:01:00.0: BAR 4 [io  0xe000-0xe0ff]
[    9.020156] pci 0000:01:00.0: BAR 5 [mem 0xdb800000-0xdb83ffff]
[    9.020225] pci 0000:01:00.0: ROM [mem 0xdb840000-0xdb85ffff pref]
[    9.020679] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    9.020895] pci 0000:01:00.0: supports D1 D2
[    9.020936] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    9.026797] pci 0000:01:00.1: [1002:ab08] type 00 class 0x040300 PCIe Legacy Endpoint
[    9.026901] pci 0000:01:00.1: BAR 0 [mem 0xdb860000-0xdb863fff 64bit]
[    9.027424] pci 0000:01:00.1: supports D1 D2
[    9.029095] pci 0000:00:01.0: PCI bridge to [bus 01]
[    9.030574] pci 0000:02:00.0: [1b21:2142] type 00 class 0x0c0330 PCIe Legacy Endpoint
[    9.030685] pci 0000:02:00.0: BAR 0 [mem 0xdae00000-0xdae07fff 64bit]
[    9.031259] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    9.036324] pci 0000:00:01.1: PCI bridge to [bus 02]
[    9.037329] pci 0000:03:00.0: [1217:8621] type 00 class 0x080501 PCIe Endpoint
[    9.037430] pci 0000:03:00.0: BAR 0 [mem 0xda401000-0xda401fff]
[    9.037503] pci 0000:03:00.0: BAR 1 [mem 0xda400000-0xda4007ff]
[    9.038198] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    9.046615] pci 0000:00:01.2: PCI bridge to [bus 03]
[    9.047448] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    9.048454] pci 0000:05:00.0: [8086:157b] type 00 class 0x020000 PCIe Endpoint
[    9.048564] pci 0000:05:00.0: BAR 0 [mem 0xdc300000-0xdc31ffff]
[    9.048658] pci 0000:05:00.0: BAR 2 [io  0xb000-0xb01f]
[    9.048730] pci 0000:05:00.0: BAR 3 [mem 0xdc320000-0xdc323fff]
[    9.049331] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    9.054498] pci 0000:00:1c.1: PCI bridge to [bus 05]
[    9.055634] pci 0000:06:00.0: [17cb:1103] type 00 class 0x028000 PCIe Endpoint
[    9.055742] pci 0000:06:00.0: BAR 0 [mem 0xda200000-0xda3fffff 64bit]
[    9.056375] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    9.061500] pci 0000:00:1c.2: PCI bridge to [bus 06]
[    9.062339] pci 0000:00:1c.4: PCI bridge to [bus 07-71]
[    9.063534] pci 0000:72:00.0: [c0a9:2263] type 00 class 0x010802 PCIe Endpoint
[    9.063696] pci 0000:72:00.0: BAR 0 [mem 0xdc200000-0xdc203fff 64bit]
[    9.069654] pci 0000:00:1d.0: PCI bridge to [bus 72]
[    9.284204] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    9.290729] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    9.296745] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    9.302817] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    9.307939] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    9.313895] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    9.320728] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    9.326669] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    9.731124] ACPI: EC: interrupt unblocked
[    9.731177] ACPI: EC: event unblocked
[    9.731218] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    9.731269] ACPI: EC: GPE=0x12
[    9.731326] ACPI: \_SB_.PCI0.LPCB.H_EC: Boot DSDT EC initialization complete
[    9.731426] ACPI: \_SB_.PCI0.LPCB.H_EC: EC: Used to handle transactions and events
[    9.732995] iommu: Default domain type: Translated
[    9.733040] iommu: DMA domain TLB invalidation policy: lazy mode
[    9.738195] SCSI subsystem initialized
[    9.739537] libata version 3.00 loaded.
[    9.741405] ACPI: bus type USB registered
[    9.742386] usbcore: registered new interface driver usbfs
[    9.742813] usbcore: registered new interface driver hub
[    9.743371] usbcore: registered new device driver usb
[    9.744660] pps_core: LinuxPPS API ver. 1 registered
[    9.744705] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    9.744980] PTP clock support registered
[    9.747139] EDAC MC: Ver: 3.0.0
[    9.751357] efivars: Registered efivars operations
[    9.759783] NetLabel: Initializing
[    9.759823] NetLabel:  domain hash size = 128
[    9.759862] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    9.760754] NetLabel:  unlabeled traffic allowed by default
[    9.762332] PCI: Using ACPI for IRQ routing
[    9.788276] PCI: pci_cache_line_size set to 64 bytes
[    9.788825] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    9.788929] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    9.789004] e820: reserve RAM buffer [mem 0x74037018-0x77ffffff]
[    9.789078] e820: reserve RAM buffer [mem 0x74048018-0x77ffffff]
[    9.789152] e820: reserve RAM buffer [mem 0x74058018-0x77ffffff]
[    9.789225] e820: reserve RAM buffer [mem 0x77050000-0x77ffffff]
[    9.789299] e820: reserve RAM buffer [mem 0x7b09d000-0x7bffffff]
[    9.789335] e820: reserve RAM buffer [mem 0x7e702000-0x7fffffff]
[    9.789418] e820: reserve RAM buffer [mem 0x7f7ff000-0x7fffffff]
[    9.789497] e820: reserve RAM buffer [mem 0x27f000000-0x27fffffff]
[    9.792447] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    9.792515] pci 0000:01:00.0: vgaarb: bridge control possible
[    9.792565] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=mem,locks=none
[    9.792652] vgaarb: loaded
[    9.803885] clocksource: Switched to clocksource tsc-early
[    9.809741] VFS: Disk quotas dquot_6.6.0
[    9.810039] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    9.812928] pnp: PnP ACPI init
[    9.837304] system 00:00: [io  0x0a00-0x0a1f] has been reserved
[    9.837406] system 00:00: [io  0x0a20-0x0a2f] has been reserved
[    9.837496] system 00:00: [io  0x0a30-0x0a3f] has been reserved
[    9.837585] system 00:00: [io  0x0a40-0x0a4f] has been reserved
[    9.837673] system 00:00: [io  0x0a50-0x0a5f] has been reserved
[    9.837767] system 00:00: [io  0x0a60-0x0a6f] has been reserved
[    9.858639] system 00:01: [io  0x0680-0x069f] has been reserved
[    9.858733] system 00:01: [io  0xffff] has been reserved
[    9.858819] system 00:01: [io  0xffff] has been reserved
[    9.858910] system 00:01: [io  0xffff] has been reserved
[    9.858994] system 00:01: [io  0x1800-0x18fe] has been reserved
[    9.859082] system 00:01: [io  0x164e-0x164f] has been reserved
[    9.863449] system 00:02: [io  0x0800-0x087f] has been reserved
[    9.867673] system 00:04: [io  0x1854-0x1857] has been reserved
[    9.887528] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    9.887634] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    9.887734] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    9.887828] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    9.887921] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    9.888044] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    9.888139] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    9.888262] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    9.888381] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    9.888477] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    9.892054] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    9.892151] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    9.892263] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    9.892389] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    9.892486] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    9.892579] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    9.892671] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    9.906204] system 00:07: [io  0xff00-0xfffe] has been reserved
[   10.057022] pnp: PnP ACPI: found 9 devices
[   10.129600] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   10.129970] pci 0000:00:1f.1: [8086:a120] type 00 class 0x058000 conventional PCI endpoint
[   10.130139] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
[   10.133475] NET: Registered PF_INET protocol family
[   10.134124] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[   10.140851] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 327680 bytes, linear)
[   10.141147] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[   10.141522] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[   10.143837] TCP bind hash table entries: 65536 (order: 11, 10485760 bytes, vmalloc hugepage)
[   10.150525] TCP: Hash tables configured (established 65536 bind 65536)
[   10.152025] UDP hash table entries: 4096 (order: 7, 786432 bytes, linear)
[   10.152778] UDP-Lite hash table entries: 4096 (order: 7, 786432 bytes, linear)
[   10.155474] NET: Registered PF_UNIX/PF_LOCAL protocol family
[   10.159284] RPC: Registered named UNIX socket transport module.
[   10.159354] RPC: Registered udp transport module.
[   10.159397] RPC: Registered tcp transport module.
[   10.159440] RPC: Registered tcp-with-tls transport module.
[   10.159488] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.159577] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 07-71] add_size 1000
[   10.159703] pci 0000:00:1c.4: bridge window [io  0x2000-0x2fff]: assigned
[   10.159802] pci 0000:00:01.0: PCI bridge to [bus 01]
[   10.159849] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[   10.159909] pci 0000:00:01.0:   bridge window [mem 0xdb800000-0xdc1fffff]
[   10.159971] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff 64bit pref]
[   10.160046] pci 0000:00:01.1: PCI bridge to [bus 02]
[   10.160091] pci 0000:00:01.1:   bridge window [io  0xd000-0xdfff]
[   10.160150] pci 0000:00:01.1:   bridge window [mem 0xdae00000-0xdb7fffff]
[   10.160244] pci 0000:00:01.2: PCI bridge to [bus 03]
[   10.160289] pci 0000:00:01.2:   bridge window [io  0xc000-0xcfff]
[   10.160348] pci 0000:00:01.2:   bridge window [mem 0xda400000-0xdadfffff]
[   10.160421] pci 0000:00:1c.0: PCI bridge to [bus 04]
[   10.160498] pci 0000:00:1c.1: PCI bridge to [bus 05]
[   10.160544] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[   10.160607] pci 0000:00:1c.1:   bridge window [mem 0xdc300000-0xdc3fffff]
[   10.160685] pci 0000:00:1c.2: PCI bridge to [bus 06]
[   10.160740] pci 0000:00:1c.2:   bridge window [mem 0xda200000-0xda3fffff]
[   10.160818] pci 0000:00:1c.4: PCI bridge to [bus 07-71]
[   10.160868] pci 0000:00:1c.4:   bridge window [io  0x2000-0x2fff]
[   10.160932] pci 0000:00:1c.4:   bridge window [mem 0xac000000-0xda0fffff]
[   10.160997] pci 0000:00:1c.4:   bridge window [mem 0x2fb0000000-0x2ff9ffffff 64bit pref]
[   10.161080] pci 0000:00:1d.0: PCI bridge to [bus 72]
[   10.161136] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
[   10.161239] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   10.161292] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[   10.161344] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000effff window]
[   10.161401] pci_bus 0000:00: resource 7 [mem 0x80000000-0xdfffffff window]
[   10.161458] pci_bus 0000:00: resource 8 [mem 0x2000000000-0x2fffffffff window]
[   10.161519] pci_bus 0000:00: resource 9 [mem 0xfd000000-0xfe7fffff window]
[   10.161576] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[   10.161624] pci_bus 0000:01: resource 1 [mem 0xdb800000-0xdc1fffff]
[   10.161677] pci_bus 0000:01: resource 2 [mem 0x90000000-0xa01fffff 64bit pref]
[   10.161737] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[   10.161785] pci_bus 0000:02: resource 1 [mem 0xdae00000-0xdb7fffff]
[   10.161838] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[   10.161886] pci_bus 0000:03: resource 1 [mem 0xda400000-0xdadfffff]
[   10.161939] pci_bus 0000:05: resource 0 [io  0xb000-0xbfff]
[   10.161987] pci_bus 0000:05: resource 1 [mem 0xdc300000-0xdc3fffff]
[   10.162040] pci_bus 0000:06: resource 1 [mem 0xda200000-0xda3fffff]
[   10.162093] pci_bus 0000:07: resource 0 [io  0x2000-0x2fff]
[   10.162141] pci_bus 0000:07: resource 1 [mem 0xac000000-0xda0fffff]
[   10.162208] pci_bus 0000:07: resource 2 [mem 0x2fb0000000-0x2ff9ffffff 64bit pref]
[   10.162272] pci_bus 0000:72: resource 1 [mem 0xdc200000-0xdc2fffff]
[   10.187645] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x2f0 took 18140 usecs
[   10.189144] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[   10.189417] pci 0000:02:00.0: PME# does not work under D0, disabling it
[   10.202867] pci 0000:02:00.0: quirk_usb_early_handoff+0x0/0x2f0 took 13076 usecs
[   10.203321] PCI: CLS 64 bytes, default 64
[   10.203657] DMAR: ACPI device "device:85" under DMAR at fed90000 as 00:15.0
[   10.203769] DMAR: ACPI device "device:86" under DMAR at fed90000 as 00:15.1
[   10.203863] DMAR: ACPI device "device:88" under DMAR at fed90000 as 00:1e.0
[   10.204045] DMAR: No ATSR found
[   10.204077] DMAR: No SATC found
[   10.204109] DMAR: dmar0: Using Queued invalidation
[   10.205437] Unpacking initramfs...
[   10.206716] pci 0000:00:00.0: Adding to iommu group 0
[   10.207602] pci 0000:00:01.0: Adding to iommu group 1
[   10.207964] pci 0000:00:01.1: Adding to iommu group 1
[   10.208334] pci 0000:00:01.2: Adding to iommu group 1
[   10.208857] pci 0000:00:08.0: Adding to iommu group 2
[   10.209560] pci 0000:00:14.0: Adding to iommu group 3
[   10.209927] pci 0000:00:14.2: Adding to iommu group 3
[   10.210710] pci 0000:00:15.0: Adding to iommu group 4
[   10.211089] pci 0000:00:15.1: Adding to iommu group 4
[   10.211481] pci 0000:00:15.2: Adding to iommu group 4
[   10.212107] pci 0000:00:16.0: Adding to iommu group 5
[   10.212750] pci 0000:00:1c.0: Adding to iommu group 6
[   10.214183] pci 0000:00:1c.1: Adding to iommu group 7
[   10.214710] pci 0000:00:1c.2: Adding to iommu group 8
[   10.215256] pci 0000:00:1c.4: Adding to iommu group 9
[   10.215799] pci 0000:00:1d.0: Adding to iommu group 10
[   10.217715] pci 0000:00:1e.0: Adding to iommu group 11
[   10.218606] pci 0000:00:1f.0: Adding to iommu group 12
[   10.219001] pci 0000:00:1f.2: Adding to iommu group 12
[   10.219416] pci 0000:00:1f.3: Adding to iommu group 12
[   10.219816] pci 0000:00:1f.4: Adding to iommu group 12
[   10.220386] pci 0000:00:1f.6: Adding to iommu group 13
[   10.220667] pci 0000:01:00.0: Adding to iommu group 1
[   10.220931] pci 0000:01:00.1: Adding to iommu group 1
[   10.221209] pci 0000:02:00.0: Adding to iommu group 1
[   10.221485] pci 0000:03:00.0: Adding to iommu group 1
[   10.222013] pci 0000:05:00.0: Adding to iommu group 14
[   10.222563] pci 0000:06:00.0: Adding to iommu group 15
[   10.223095] pci 0000:72:00.0: Adding to iommu group 16
[   10.338532] DMAR: Intel(R) Virtualization Technology for Directed I/O
[   10.338593] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   10.338645] software IO TLB: mapped [mem 0x0000000070037000-0x0000000074037000] (64MB)
[   10.339582] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[   10.339651] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   10.339700] RAPL PMU: hw unit of domain package 2^-14 Joules
[   10.339748] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   10.394238] Initialise system trusted keyrings
[   10.395130] workingset: timestamp_bits=56 max_order=21 bucket_order=0
[   10.406893] debugfs: Directory 'file_lock_cache' with parent 'slab' already present!
[   10.435347] NFS: Registering the id_resolver key type
[   10.435519] Key type id_resolver registered
[   10.435577] Key type id_legacy registered
[   10.462859] Key type asymmetric registered
[   10.462919] Asymmetric key parser 'x509' registered
[   10.463639] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[   10.463717] io scheduler mq-deadline registered
[   10.463760] io scheduler kyber registered
[   10.525932] debug: unmapping init [mem 0xffff888074077000-0xffff88807504bfff]
[   10.557750] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[   10.560041] ACPI: button: Sleep Button [SLPB]
[   10.561561] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[   10.563000] ACPI: button: Power Button [PWRB]
[   10.564487] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   10.566769] ACPI: button: Power Button [PWRF]
[   10.601362] Monitor-Mwait will be used to enter C-1 state
[   10.601500] Monitor-Mwait will be used to enter C-2 state
[   10.601584] Monitor-Mwait will be used to enter C-3 state
[   10.601678] ACPI: \_PR_.PR00: Found 3 idle states
[   10.616496] ACPI: \_PR_.PR01: Found 3 idle states
[   10.631315] ACPI: \_PR_.PR02: Found 3 idle states
[   10.647248] ACPI: \_PR_.PR03: Found 3 idle states
[   10.662678] ACPI: \_PR_.PR04: Found 3 idle states
[   10.677531] ACPI: \_PR_.PR05: Found 3 idle states
[   10.692128] ACPI: \_PR_.PR06: Found 3 idle states
[   10.707126] ACPI: \_PR_.PR07: Found 3 idle states
[   10.757439] thermal LNXTHERM:00: registered as thermal_zone0
[   10.757494] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[   10.775430] thermal LNXTHERM:01: registered as thermal_zone1
[   10.775486] ACPI: thermal: Thermal Zone [TZ01] (30 C)
[   10.778881] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   10.798303] hpet_acpi_add: no address or irqs in _CRS
[   10.799683] Non-volatile memory driver v1.3
[   10.799727] Linux agpgart interface v0.103
[   10.801136] ACPI: bus type drm_connector registered
[   10.892346] loop: module loaded
[   10.906090] e100: Intel(R) PRO/100 Network Driver
[   10.906135] e100: Copyright(c) 1999-2006 Intel Corporation
[   10.906569] e1000: Intel(R) PRO/1000 Network Driver
[   10.906613] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   10.907081] e1000e: Intel(R) PRO/1000 Network Driver
[   10.907124] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   10.907449] e1000e 0000:00:1f.6: enabling device (0000 -> 0002)
[   10.917076] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   11.148471] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[   11.217057] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 54:b2:03:11:ca:cf
[   11.217134] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[   11.217275] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[   11.217819] igb: Intel(R) Gigabit Ethernet Network Driver
[   11.217867] igb: Copyright (c) 2007-2014 Intel Corporation.
[   11.218205] igb 0000:05:00.0: enabling device (0000 -> 0002)
[   11.267785] pps pps0: new PPS source ptp1
[   11.269920] igb 0000:05:00.0: added PHC on eth1
[   11.270022] igb 0000:05:00.0: Intel(R) Gigabit Ethernet Network Connection
[   11.270082] igb 0000:05:00.0: eth1: (PCIe:2.5Gb/s:Width x1) 54:b2:03:11:ca:d0
[   11.270143] igb 0000:05:00.0: eth1: PBA No: FFFFFF-0FF
[   11.270219] igb 0000:05:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[   11.283496] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.286110] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[   11.295879] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
[   11.322372] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.324000] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[   11.324143] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[   11.326153] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.09
[   11.326269] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.326335] usb usb1: Product: xHCI Host Controller
[   11.326381] usb usb1: Manufacturer: Linux 6.9.0 xhci-hcd
[   11.326430] usb usb1: SerialNumber: 0000:00:14.0
[   11.333310] hub 1-0:1.0: USB hub found
[   11.333776] hub 1-0:1.0: 16 ports detected
[   11.351311] tsc: Refined TSC clocksource calibration: 3095.999 MHz
[   11.351413] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2ca0846bcce, max_idle_ns: 440795348689 ns
[   11.351644] clocksource: Switched to clocksource tsc
[   11.564626] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.09
[   11.564704] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.564769] usb usb2: Product: xHCI Host Controller
[   11.564815] usb usb2: Manufacturer: Linux 6.9.0 xhci-hcd
[   11.564864] usb usb2: SerialNumber: 0000:00:14.0
[   11.570001] hub 2-0:1.0: USB hub found
[   11.570630] hub 2-0:1.0: 8 ports detected
[   11.705324] xhci_hcd 0000:02:00.0: xHCI Host Controller
[   11.706789] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 3
[   11.767954] xhci_hcd 0000:02:00.0: hcc params 0x0200ef80 hci version 0x110 quirks 0x0000000000800010
[   11.777965] xhci_hcd 0000:02:00.0: xHCI Host Controller
[   11.779312] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 4
[   11.779443] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[   11.781257] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.09
[   11.781334] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.781399] usb usb3: Product: xHCI Host Controller
[   11.781445] usb usb3: Manufacturer: Linux 6.9.0 xhci-hcd
[   11.781494] usb usb3: SerialNumber: 0000:02:00.0
[   11.785477] hub 3-0:1.0: USB hub found
[   11.785853] hub 3-0:1.0: 2 ports detected
[   11.790661] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[   11.792336] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.09
[   11.792413] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.792478] usb usb4: Product: xHCI Host Controller
[   11.792524] usb usb4: Manufacturer: Linux 6.9.0 xhci-hcd
[   11.792573] usb usb4: SerialNumber: 0000:02:00.0
[   11.796442] hub 4-0:1.0: USB hub found
[   11.796766] hub 4-0:1.0: 2 ports detected
[   11.801915] usbcore: registered new interface driver usblp
[   11.802367] usbcore: registered new interface driver usb-storage
[   11.803265] i8042: PNP: No PS/2 controller found.
[   11.803308] i8042: Probing ports directly.
[   11.807281] usb 1-9: new full-speed USB device number 2 using xhci_hcd
[   11.811525] i8042: Detected active multiplexing controller, rev 1.1
[   11.820282] serio: i8042 KBD port at 0x60,0x64 irq 1
[   11.821204] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   11.821347] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   11.821479] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   11.821609] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   11.828848] rtc_cmos 00:03: RTC can wake from S4
[   11.835412] rtc_cmos 00:03: registered as rtc0
[   11.836394] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
[   11.847153] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   11.848001] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   11.848422] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[   11.848761] intel_pstate: Intel P-state driver initializing
[   11.854531] intel_pstate: Disabling energy efficiency optimization
[   11.854584] intel_pstate: HWP enabled
[   11.855559] efifb: probing for efifb
[   11.856437] efifb: framebuffer at 0x90000000, using 5120k, total 5120k
[   11.856509] efifb: mode is 1280x1024x32, linelength=5120, pages=1
[   11.856550] efifb: scrolling: redraw
[   11.856576] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   11.862564] Console: switching to colour frame buffer device 160x64
[   11.864713] fb0: EFI VGA frame buffer device
[   11.865694] pstore: Using crash dump compression: deflate
[   11.865784] pstore: Registered efi_pstore as persistent store backend
[   11.866618] hid: raw HID events driver (C) Jiri Kosina
[   11.872949] usbcore: registered new interface driver usbhid
[   11.873000] usbhid: USB HID core driver
[   11.881860] Initializing XFRM netlink socket
[   11.882581] NET: Registered PF_INET6 protocol family
[   11.889834] Segment Routing with IPv6
[   11.890587] In-situ OAM (IOAM) with IPv6
[   11.891316] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   11.895532] NET: Registered PF_PACKET protocol family
[   11.896271] Key type dns_resolver registered
[   11.896826] start plist test
[   11.897799] end plist test
[   11.909595] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[   11.910417] microcode: Current revision: 0x000000f4
[   11.910463] microcode: Updated early from: 0x000000ea
[   11.912685] IPI shorthand broadcast: enabled
[   11.925963] i2c i2c-0: Successfully instantiated SPD at 0x50
[   11.936276] usb 1-9: New USB device found, idVendor=0cf3, idProduct=e600, bcdDevice= 0.01
[   11.936371] usb 1-9: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   12.079999] sched_clock: Marking stable (12059022839, 20155949)->(12243790397, -164611609)
[   12.081522] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[   12.083141] registered taskstats version 1
[   12.083230] Loading compiled-in X.509 certificates
[   12.327745] kmemleak: Kernel memory leak detector initialized (mem pool available: 9875)
[   12.327751] kmemleak: Automatic memory scanning thread started
[   12.327815] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   12.328212] page_owner is disabled
[   12.345358] PM:   Magic number: 8:704:426
[   12.345610] netpoll: netconsole: local port 6666
[   12.345651] netpoll: netconsole: local IPv4 address 192.168.2.104
[   12.345701] netpoll: netconsole: interface 'eth1'
[   12.346351] netpoll: netconsole: remote port 514
[   12.346978] netpoll: netconsole: remote IPv4 address 192.168.2.1
[   12.347620] netpoll: netconsole: remote ethernet address ba:52:4d:77:4f:8e
[   12.348314] netpoll: netconsole: device eth1 not up yet, forcing it
[   12.631733] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[   12.679292] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   12.680196] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   12.884938] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   12.887498] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   13.093897] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   13.095329] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   13.301414] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   13.303888] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   13.513254] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   13.516000] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   13.718962] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   13.721700] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   13.935902] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   13.938886] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   14.142447] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   14.145873] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   14.349876] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   14.353019] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   15.159307] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   15.281603] printk: legacy console [netcon0] enabled
[   15.328015] netconsole: network logging started
[   15.332361] clk: Disabling unused clocks
[   15.334008] debug: unmapping init [mem 0xffffffff99e2c000-0xffffffff9a238fff]
[   15.335185] Write protecting the kernel read-only data: 61440k
[   15.337385] debug: unmapping init [mem 0xffffffff98e64000-0xffffffff98ffffff]
[   15.470632] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   15.471524] Run /init as init process
[   15.472397]   with arguments:
[   15.473244]     /init
[   15.474039]   with environment:
[   15.474845]     HOME=/
[   15.475652]     TERM=linux
[   15.476501]     BOOT_IMAGE=/boot/vmlinuz-6.9.0
[   15.488992] mkdir (90) used greatest stack depth: 28672 bytes left
[   15.517459] mount (94) used greatest stack depth: 26176 bytes left
[   15.718006] systemd-udevd (108) used greatest stack depth: 25888 bytes left
[   19.124873] nvme nvme0: pci function 0000:72:00.0
[   19.144319] nvme nvme0: missing or invalid SUBNQN field.
[   19.211830] nvme nvme0: 8/0/0 default/read/poll queues
[   19.256386]  nvme0n1: p1 p2 p3
[   20.477880] EXT4-fs (nvme0n1p2): mounted filesystem 61a268dc-df96-4e69-9272-928240dcc445 ro with ordered data mode. Quota mode: none.
[   20.480719] mount (178) used greatest stack depth: 24848 bytes left
[   21.521472] modprobe (193) used greatest stack depth: 24288 bytes left
[   21.538720] systemd[1]: systemd 245.4-4ubuntu3.23 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[   21.549274] systemd[1]: Detected architecture x86-64.
[   21.572440] systemd[1]: Set hostname to <nuc2>.
[   21.846522] cat (199) used greatest stack depth: 24056 bytes left
[   23.348742] systemd[1]: system-modprobe.slice: unit configures an IP firewall, but the local system does not support BPF/cgroup firewalling.
[   23.349761] systemd[1]: (This warning is only shown for the first unit using IP firewalling.)
[   23.363634] systemd[1]: Created slice system-modprobe.slice.
[   23.369611] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   23.375150] systemd[1]: Created slice User and Session Slice.
[   23.379884] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   23.387447] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   23.391084] systemd[1]: Reached target User and Group Name Lookups.
[   23.394384] systemd[1]: Reached target Remote File Systems.
[   23.398008] systemd[1]: Reached target Slices.
[   23.401670] systemd[1]: Reached target Mounting snaps.
[   23.406810] systemd[1]: Listening on Syslog Socket.
[   23.411570] systemd[1]: Listening on fsck to fsckd communication Socket.
[   23.415838] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   23.421448] systemd[1]: Listening on Journal Audit Socket.
[   23.432988] systemd[1]: Listening on Journal Socket (/dev/log).
[   23.438662] systemd[1]: Listening on Journal Socket.
[   23.443884] systemd[1]: Listening on udev Control Socket.
[   23.448454] systemd[1]: Listening on udev Kernel Socket.
[   23.489862] systemd[1]: Mounting Huge Pages File System...
[   23.514407] systemd[1]: Mounting POSIX Message Queue File System...
[   23.567665] systemd[1]: Mounting Kernel Debug File System...
[   23.592792] systemd[1]: Mounting Kernel Trace File System...
[   23.633985] systemd[1]: Starting Journal Service...
[   23.670889] systemd[1]: Starting Set the console keyboard layout...
[   23.674752] systemd[1]: Condition check resulted in Create list of static device nodes for the current kernel being skipped.
[   23.718032] systemd[1]: Starting Load Kernel Module chromeos_pstore...
[   23.721475] systemd[1]: Condition check resulted in Load Kernel Module drm being skipped.
[   23.724066] systemd[1]: Condition check resulted in Load Kernel Module efi_pstore being skipped.
[   23.761553] systemd[1]: Starting Load Kernel Module pstore_blk...
[   23.828461] systemd[1]: Starting Load Kernel Module pstore_zone...
[   23.872419] systemd[1]: Starting Load Kernel Module ramoops...
[   23.879582] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[   23.880777] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[   23.937834] systemd[1]: Starting Load Kernel Modules...
[   23.982407] systemd[1]: Starting Remount Root and Kernel File Systems...
[   24.032793] systemd[1]: Starting udev Coldplug all Devices...
[   24.091532] systemd[1]: Starting Uncomplicated firewall...
[   24.124147] systemd[1]: Mounted Huge Pages File System.
[   24.130935] systemd[1]: Mounted POSIX Message Queue File System.
[   24.137407] systemd[1]: Mounted Kernel Debug File System.
[   24.142874] systemd[1]: Mounted Kernel Trace File System.
[   24.153513] systemd[1]: modprobe@chromeos_pstore.service: Succeeded.
[   24.159611] systemd[1]: Finished Load Kernel Module chromeos_pstore.
[   24.174747] systemd[1]: modprobe@pstore_blk.service: Succeeded.
[   24.179545] systemd[1]: Finished Load Kernel Module pstore_blk.
[   24.196514] systemd[1]: modprobe@pstore_zone.service: Succeeded.
[   24.204070] systemd[1]: Finished Load Kernel Module pstore_zone.
[   24.212500] systemd[1]: modprobe@ramoops.service: Succeeded.
[   24.217813] systemd[1]: Finished Load Kernel Module ramoops.
[   24.220491] EXT4-fs (nvme0n1p2): re-mounted 61a268dc-df96-4e69-9272-928240dcc445 r/w. Quota mode: none.
[   24.251568] systemd[1]: Finished Load Kernel Modules.
[   24.263154] systemd[1]: Finished Remount Root and Kernel File Systems.
[   24.275023] systemd[1]: Finished Uncomplicated firewall.
[   24.282639] systemd[1]: Condition check resulted in FUSE Control File System being skipped.
[   24.332531] systemd[1]: Mounting Kernel Configuration File System...
[   24.360193] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[   24.362601] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[   24.421390] systemd[1]: Starting Load/Save Random Seed...
[   24.488086] systemd[1]: Starting Apply Kernel Variables...
[   24.517687] systemd[1]: Starting Create System Users...
[   24.535371] systemd[1]: Mounted Kernel Configuration File System.
[   24.616103] systemd[1]: Finished Load/Save Random Seed.
[   24.737426] systemd[1]: Finished Apply Kernel Variables.
[   24.802652] systemd[1]: Finished Set the console keyboard layout.
[   24.837394] systemd[1]: Finished Create System Users.
[   24.888803] systemd[1]: Starting Create Static Device Nodes in /dev...
[   25.110740] systemd[1]: Finished Create Static Device Nodes in /dev.
[   25.116066] systemd[1]: Reached target Local File Systems (Pre).
[   25.168877] systemd[1]: Mounting Mount unit for bare, revision 5...
[   25.214421] systemd[1]: Mounting Mount unit for core18, revision 2128...
[   25.216590] loop0: detected capacity change from 0 to 8
[   25.257142] loop1: detected capacity change from 0 to 113536
[   25.263829] systemd[1]: Mounting Mount unit for core20, revision 1169...
[   25.299916] systemd[1]: Mounting Mount unit for gnome-3-34-1804, revision 72...
[   25.319756] loop0: detected capacity change from 0 to 126632
[   25.350289] loop1: detected capacity change from 0 to 448512
[   25.374639] systemd[1]: Mounting Mount unit for gnome-3-38-2004, revision 76...
[   25.411408] loop0: detected capacity change from 0 to 496320
[   25.426577] systemd[1]: Mounting Mount unit for gnome-calculator, revision 884...
[   25.464982] loop1: detected capacity change from 0 to 5088
[   25.473552] systemd[1]: Mounting Mount unit for gnome-characters, revision 726...
[   25.509155] loop0: detected capacity change from 0 to 1408
[   25.527598] systemd[1]: Mounting Mount unit for gnome-logs, revision 106...
[   25.564623] loop1: detected capacity change from 0 to 1096
[   25.571946] systemd[1]: Mounting Mount unit for gnome-system-monitor, revision 163...
[   25.621424] systemd[1]: Mounting Mount unit for gtk-common-themes, revision 1519...
[   25.632016] loop0: detected capacity change from 0 to 5120
[   25.656247] systemd[1]: Mounting Mount unit for snap-store, revision 547...
[   25.683767] loop1: detected capacity change from 0 to 133552
[   25.719461] systemd[1]: Mounting Mount unit for snapd, revision 13170...
[   25.733007] loop0: detected capacity change from 0 to 104360
[   25.766881] loop1: detected capacity change from 0 to 66168
[   25.770829] systemd[1]: Mounting Mount unit for snapd, revision 13270...
[   25.824419] systemd[1]: Starting udev Kernel Device Manager...
[   25.838756] systemd[1]: Started Journal Service.
[   25.851040] loop0: detected capacity change from 0 to 66368
[   26.247863] systemd-journald[217]: Received client request to flush runtime journal.
[   30.093401] Adding 999420k swap on /dev/nvme0n1p3.  Priority:-2 extents:1 across:999420k SS
[   33.589948] loop0: detected capacity change from 0 to 8
[   54.945105] rtcwake test 1
[   55.162603] PM: suspend entry (deep)
[   55.168875] Filesystems sync: 0.006 seconds
[   55.182427] Freezing user space processes
[   55.191498] Freezing user space processes completed (elapsed 0.008 seconds)
[   55.191711] OOM killer disabled.
[   55.191805] Freezing remaining freezable tasks
[   55.193507] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   55.194056] printk: Suspending console(s) (use no_console_suspend to debug)
[   55.244962] e1000e: EEE TX LPI TIMER: 00000011
[   55.340247] ACPI: EC: interrupt blocked
[   55.389569] ACPI: PM: Preparing to enter system sleep state S3
[   55.415845] ACPI: EC: event blocked
[   55.415852] ACPI: EC: EC stopped
[   55.415856] ACPI: PM: Saving platform NVS memory
[   55.416102] Disabling non-boot CPUs ...
[   55.427605] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[   55.429875] smpboot: CPU 1 is now offline
[   55.446283] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[   55.447794] smpboot: CPU 2 is now offline
[   55.462648] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[   55.463913] smpboot: CPU 3 is now offline
[   55.479249] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[   55.480901] smpboot: CPU 4 is now offline
[   55.493282] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[   55.495333] smpboot: CPU 5 is now offline
[   55.510120] numa_remove_cpu cpu 6 node 0: mask now 0,7
[   55.511556] smpboot: CPU 6 is now offline
[   55.528344] numa_remove_cpu cpu 7 node 0: mask now 0
[   55.529556] smpboot: CPU 7 is now offline
[   55.534475] ACPI: PM: Low-level resume complete
[   55.534544] ACPI: EC: EC started
[   55.534549] ACPI: PM: Restoring platform NVS memory
[   55.538224] Enabling non-boot CPUs ...
[   55.539277] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   55.543747] numa_add_cpu cpu 1 node 0: mask now 0-1
[   55.564209] ACPI: \_PR_.PR01: Found 3 idle states
[   55.570591] CPU1 is up
[   55.571142] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   55.573624] numa_add_cpu cpu 2 node 0: mask now 0-2
[   55.587784] ACPI: \_PR_.PR02: Found 3 idle states
[   55.593828] CPU2 is up
[   55.594337] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   55.596620] numa_add_cpu cpu 3 node 0: mask now 0-3
[   55.610465] ACPI: \_PR_.PR03: Found 3 idle states
[   55.615859] CPU3 is up
[   55.616446] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   55.616851] numa_add_cpu cpu 4 node 0: mask now 0-4
[   55.631228] ACPI: \_PR_.PR04: Found 3 idle states
[   55.637056] CPU4 is up
[   55.637654] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   55.637996] numa_add_cpu cpu 5 node 0: mask now 0-5
[   55.652012] ACPI: \_PR_.PR05: Found 3 idle states
[   55.657994] CPU5 is up
[   55.658518] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   55.658898] numa_add_cpu cpu 6 node 0: mask now 0-6
[   55.672881] ACPI: \_PR_.PR06: Found 3 idle states
[   55.679202] CPU6 is up
[   55.679758] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   55.680098] numa_add_cpu cpu 7 node 0: mask now 0-7
[   55.694088] ACPI: \_PR_.PR07: Found 3 idle states
[   55.701263] CPU7 is up
[   55.704832] ACPI: PM: Waking up from system sleep state S3
[   56.468194] ACPI: EC: interrupt unblocked
[   56.469705] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[   56.469814] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[   56.469862] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[   56.469910] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[   57.645133] ACPI: EC: event unblocked
[   57.649723] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
[   57.649739] usb usb3: root hub lost power or was reset
[   57.649744] usb usb4: root hub lost power or was reset
[   57.654230] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[   57.654238] usb usb1: root hub lost power or was reset
[   57.654242] usb usb2: root hub lost power or was reset
[   57.735802] nvme nvme0: 8/0/0 default/read/poll queues
[   58.008117] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[   58.216393] OOM killer enabled.
[   58.217506] Restarting tasks ... done.
[   58.226852] random: crng reseeded on system resumption
[   58.242280] PM: suspend exit
[   58.242280] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   58.242299] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   58.444037] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   58.444329] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   58.655940] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   58.656089] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   58.861604] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   58.861753] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   59.069931] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   59.070086] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   59.276154] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   59.276678] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   59.486762] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   59.487330] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   59.691965] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   59.692118] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   59.902199] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   59.903803] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   60.000998] igb 0000:05:00.0 eth1: Reset adapter
[   62.996292] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   68.290341] rtcwake test 2
[   68.420454] PM: suspend entry (deep)
[   68.423937] Filesystems sync: 0.002 seconds
[   68.427471] Freezing user space processes
[   68.430716] Freezing user space processes completed (elapsed 0.002 seconds)
[   68.431507] OOM killer disabled.
[   68.432392] Freezing remaining freezable tasks
[   68.435487] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
[   68.438889] printk: Suspending console(s) (use no_console_suspend to debug)
[   68.498259] e1000e: EEE TX LPI TIMER: 00000011
[   68.602654] ACPI: EC: interrupt blocked
[   68.649702] ACPI: PM: Preparing to enter system sleep state S3
[   68.675521] ACPI: EC: event blocked
[   68.675525] ACPI: EC: EC stopped
[   68.675832] ACPI: PM: Saving platform NVS memory
[   68.675984] Disabling non-boot CPUs ...
[   68.688850] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[   68.690290] smpboot: CPU 1 is now offline
[   68.706372] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[   68.707817] smpboot: CPU 2 is now offline
[   68.720198] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[   68.721652] smpboot: CPU 3 is now offline
[   68.736671] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[   68.738586] smpboot: CPU 4 is now offline
[   68.750945] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[   68.752097] smpboot: CPU 5 is now offline
[   68.764158] numa_remove_cpu cpu 6 node 0: mask now 0,7
[   68.765309] smpboot: CPU 6 is now offline
[   68.781946] numa_remove_cpu cpu 7 node 0: mask now 0
[   68.783109] smpboot: CPU 7 is now offline
[   68.787821] ACPI: PM: Low-level resume complete
[   68.787891] ACPI: EC: EC started
[   68.787895] ACPI: PM: Restoring platform NVS memory
[   68.791027] Enabling non-boot CPUs ...
[   68.791667] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   68.795186] numa_add_cpu cpu 1 node 0: mask now 0-1
[   68.815545] ACPI: \_PR_.PR01: Found 3 idle states
[   68.820421] CPU1 is up
[   68.821009] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   68.823954] numa_add_cpu cpu 2 node 0: mask now 0-2
[   68.838404] ACPI: \_PR_.PR02: Found 3 idle states
[   68.843155] CPU2 is up
[   68.843704] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   68.845951] numa_add_cpu cpu 3 node 0: mask now 0-3
[   68.860311] ACPI: \_PR_.PR03: Found 3 idle states
[   68.865676] CPU3 is up
[   68.866243] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   68.866621] numa_add_cpu cpu 4 node 0: mask now 0-4
[   68.881195] ACPI: \_PR_.PR04: Found 3 idle states
[   68.887161] CPU4 is up
[   68.887685] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   68.888043] numa_add_cpu cpu 5 node 0: mask now 0-5
[   68.902727] ACPI: \_PR_.PR05: Found 3 idle states
[   68.908917] CPU5 is up
[   68.909445] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   68.909792] numa_add_cpu cpu 6 node 0: mask now 0-6
[   68.924433] ACPI: \_PR_.PR06: Found 3 idle states
[   68.930981] CPU6 is up
[   68.931516] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   68.931865] numa_add_cpu cpu 7 node 0: mask now 0-7
[   68.946306] ACPI: \_PR_.PR07: Found 3 idle states
[   68.953262] CPU7 is up
[   68.957036] ACPI: PM: Waking up from system sleep state S3
[   69.684097] ACPI: EC: interrupt unblocked
[   69.684695] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[   69.685022] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[   69.685127] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[   69.685251] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[   70.834395] ACPI: EC: event unblocked
[   70.843269] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[   70.843278] usb usb1: root hub lost power or was reset
[   70.843283] usb usb2: root hub lost power or was reset
[   70.868689] nvme nvme0: 8/0/0 default/read/poll queues
[   71.148029] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[   71.352789] OOM killer enabled.
[   71.353610] Restarting tasks ... 
[   71.354210] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   71.355367] done.
[   71.356698] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   71.359289] random: crng reseeded on system resumption
[   71.367082] PM: suspend exit
[   71.562777] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   71.563005] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   71.769461] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   71.769680] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   71.979323] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   71.979548] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   72.186240] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   72.186389] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   72.410519] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   72.411002] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   72.620848] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   72.621056] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   72.827039] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   72.827206] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   73.038435] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   73.038589] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   73.688629] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   81.391038] rtcwake test 3
[   81.598144] PM: suspend entry (deep)
[   81.610433] Filesystems sync: 0.012 seconds
[   81.614370] Freezing user space processes
[   81.617210] Freezing user space processes completed (elapsed 0.002 seconds)
[   81.618033] OOM killer disabled.
[   81.618799] Freezing remaining freezable tasks
[   81.621183] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   81.622236] printk: Suspending console(s) (use no_console_suspend to debug)
[   81.665648] e1000e: EEE TX LPI TIMER: 00000011
[   81.765994] ACPI: EC: interrupt blocked
[   81.828823] ACPI: PM: Preparing to enter system sleep state S3
[   81.883643] ACPI: EC: event blocked
[   81.883649] ACPI: EC: EC stopped
[   81.883653] ACPI: PM: Saving platform NVS memory
[   81.884009] Disabling non-boot CPUs ...
[   81.901857] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[   81.903635] smpboot: CPU 1 is now offline
[   81.916603] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[   81.918096] smpboot: CPU 2 is now offline
[   81.939963] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[   81.941508] smpboot: CPU 3 is now offline
[   81.957230] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[   81.958674] smpboot: CPU 4 is now offline
[   81.978857] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[   81.980928] smpboot: CPU 5 is now offline
[   81.999688] numa_remove_cpu cpu 6 node 0: mask now 0,7
[   82.001145] smpboot: CPU 6 is now offline
[   82.021954] numa_remove_cpu cpu 7 node 0: mask now 0
[   82.023280] smpboot: CPU 7 is now offline
[   82.030106] ACPI: PM: Low-level resume complete
[   82.030176] ACPI: EC: EC started
[   82.030181] ACPI: PM: Restoring platform NVS memory
[   82.033361] Enabling non-boot CPUs ...
[   82.033995] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   82.036313] numa_add_cpu cpu 1 node 0: mask now 0-1
[   82.063618] ACPI: \_PR_.PR01: Found 3 idle states
[   82.070055] CPU1 is up
[   82.070744] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   82.073618] numa_add_cpu cpu 2 node 0: mask now 0-2
[   82.107263] ACPI: \_PR_.PR02: Found 3 idle states
[   82.116059] CPU2 is up
[   82.116682] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   82.119255] numa_add_cpu cpu 3 node 0: mask now 0-3
[   82.138875] ACPI: \_PR_.PR03: Found 3 idle states
[   82.143946] CPU3 is up
[   82.144461] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   82.144853] numa_add_cpu cpu 4 node 0: mask now 0-4
[   82.170062] ACPI: \_PR_.PR04: Found 3 idle states
[   82.178448] CPU4 is up
[   82.179031] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   82.179423] numa_add_cpu cpu 5 node 0: mask now 0-5
[   82.199570] ACPI: \_PR_.PR05: Found 3 idle states
[   82.206502] CPU5 is up
[   82.207047] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   82.207383] numa_add_cpu cpu 6 node 0: mask now 0-6
[   82.223561] ACPI: \_PR_.PR06: Found 3 idle states
[   82.230623] CPU6 is up
[   82.231439] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   82.231757] numa_add_cpu cpu 7 node 0: mask now 0-7
[   82.246898] ACPI: \_PR_.PR07: Found 3 idle states
[   82.254232] CPU7 is up
[   82.257544] ACPI: PM: Waking up from system sleep state S3
[   83.121161] ACPI: EC: interrupt unblocked
[   83.122338] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[   83.122376] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[   83.122411] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[   83.122426] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[   84.281703] ACPI: EC: event unblocked
[   84.289926] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[   84.289936] usb usb1: root hub lost power or was reset
[   84.289943] usb usb2: root hub lost power or was reset
[   84.319018] nvme nvme0: 8/0/0 default/read/poll queues
[   84.586261] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[   84.803836] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   84.803844] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   84.828936] OOM killer enabled.
[   84.829728] Restarting tasks ... done.
[   84.833867] random: crng reseeded on system resumption
[   84.841693] PM: suspend exit
[   85.011513] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   85.011728] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   85.216791] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   85.217100] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   85.427347] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   85.427493] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   85.631587] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   85.631734] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   85.839978] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   85.840117] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   86.054811] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   86.054960] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   86.259229] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   86.259416] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   86.464836] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   86.465891] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   87.106918] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   94.863889] rtcwake test 4
[   94.978531] PM: suspend entry (deep)
[   94.980802] Filesystems sync: 0.001 seconds
[   94.985793] Freezing user space processes
[   94.988580] Freezing user space processes completed (elapsed 0.001 seconds)
[   94.989410] OOM killer disabled.
[   94.990193] Freezing remaining freezable tasks
[   94.992538] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   94.993529] printk: Suspending console(s) (use no_console_suspend to debug)
[   95.037366] e1000e: EEE TX LPI TIMER: 00000011
[   95.146509] ACPI: EC: interrupt blocked
[   95.207563] ACPI: PM: Preparing to enter system sleep state S3
[   95.239068] ACPI: EC: event blocked
[   95.239073] ACPI: EC: EC stopped
[   95.239076] ACPI: PM: Saving platform NVS memory
[   95.239306] Disabling non-boot CPUs ...
[   95.249662] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[   95.251124] smpboot: CPU 1 is now offline
[   95.261302] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[   95.262751] smpboot: CPU 2 is now offline
[   95.277593] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[   95.279017] smpboot: CPU 3 is now offline
[   95.288421] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[   95.290061] smpboot: CPU 4 is now offline
[   95.307494] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[   95.308663] smpboot: CPU 5 is now offline
[   95.315818] numa_remove_cpu cpu 6 node 0: mask now 0,7
[   95.317824] smpboot: CPU 6 is now offline
[   95.327084] numa_remove_cpu cpu 7 node 0: mask now 0
[   95.328708] smpboot: CPU 7 is now offline
[   95.336500] ACPI: PM: Low-level resume complete
[   95.336570] ACPI: EC: EC started
[   95.336574] ACPI: PM: Restoring platform NVS memory
[   95.342445] Enabling non-boot CPUs ...
[   95.343889] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   95.347067] numa_add_cpu cpu 1 node 0: mask now 0-1
[   95.366622] ACPI: \_PR_.PR01: Found 3 idle states
[   95.371690] CPU1 is up
[   95.372264] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   95.374599] numa_add_cpu cpu 2 node 0: mask now 0-2
[   95.390915] ACPI: \_PR_.PR02: Found 3 idle states
[   95.396030] CPU2 is up
[   95.396577] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   95.399591] numa_add_cpu cpu 3 node 0: mask now 0-3
[   95.414032] ACPI: \_PR_.PR03: Found 3 idle states
[   95.419244] CPU3 is up
[   95.419791] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   95.420183] numa_add_cpu cpu 4 node 0: mask now 0-4
[   95.434874] ACPI: \_PR_.PR04: Found 3 idle states
[   95.442611] CPU4 is up
[   95.443138] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   95.443486] numa_add_cpu cpu 5 node 0: mask now 0-5
[   95.458154] ACPI: \_PR_.PR05: Found 3 idle states
[   95.464312] CPU5 is up
[   95.464879] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   95.465230] numa_add_cpu cpu 6 node 0: mask now 0-6
[   95.479750] ACPI: \_PR_.PR06: Found 3 idle states
[   95.486222] CPU6 is up
[   95.486776] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   95.487125] numa_add_cpu cpu 7 node 0: mask now 0-7
[   95.501538] ACPI: \_PR_.PR07: Found 3 idle states
[   95.508440] CPU7 is up
[   95.512030] ACPI: PM: Waking up from system sleep state S3
[   96.233406] ACPI: EC: interrupt unblocked
[   96.234021] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[   96.234311] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[   96.234426] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[   96.234610] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[   97.407138] ACPI: EC: event unblocked
[   97.414277] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[   97.414284] usb usb1: root hub lost power or was reset
[   97.414289] usb usb2: root hub lost power or was reset
[   97.446972] nvme nvme0: 8/0/0 default/read/poll queues
[   97.705835] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[   97.914310] OOM killer enabled.
[   97.915111] Restarting tasks ... 
[   97.917317] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   97.917610] done.
[   97.918524] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   97.921325] random: crng reseeded on system resumption
[   97.929190] PM: suspend exit
[   98.118857] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   98.120288] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   98.327772] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   98.328895] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   98.536380] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   98.537446] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   98.745014] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   98.746084] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   98.951116] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   98.952184] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   99.161451] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   99.162536] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   99.366098] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   99.367126] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[   99.574141] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[   99.575181] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  100.017932] igb 0000:05:00.0 eth1: Reset adapter
[  104.050266] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  107.958806] rtcwake test 5
[  108.099189] PM: suspend entry (deep)
[  108.102456] Filesystems sync: 0.002 seconds
[  108.106137] Freezing user space processes
[  108.110921] Freezing user space processes completed (elapsed 0.004 seconds)
[  108.111816] OOM killer disabled.
[  108.112656] Freezing remaining freezable tasks
[  108.114881] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  108.115904] printk: Suspending console(s) (use no_console_suspend to debug)
[  108.164655] e1000e: EEE TX LPI TIMER: 00000011
[  108.260459] ACPI: EC: interrupt blocked
[  108.308479] ACPI: PM: Preparing to enter system sleep state S3
[  108.333041] ACPI: EC: event blocked
[  108.333045] ACPI: EC: EC stopped
[  108.333049] ACPI: PM: Saving platform NVS memory
[  108.333220] Disabling non-boot CPUs ...
[  108.342945] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  108.344378] smpboot: CPU 1 is now offline
[  108.359974] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  108.361422] smpboot: CPU 2 is now offline
[  108.370937] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  108.372584] smpboot: CPU 3 is now offline
[  108.385169] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  108.386630] smpboot: CPU 4 is now offline
[  108.395705] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  108.397792] smpboot: CPU 5 is now offline
[  108.412065] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  108.413231] smpboot: CPU 6 is now offline
[  108.425422] numa_remove_cpu cpu 7 node 0: mask now 0
[  108.426991] smpboot: CPU 7 is now offline
[  108.432500] ACPI: PM: Low-level resume complete
[  108.432570] ACPI: EC: EC started
[  108.432575] ACPI: PM: Restoring platform NVS memory
[  108.435650] Enabling non-boot CPUs ...
[  108.439321] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  108.442799] numa_add_cpu cpu 1 node 0: mask now 0-1
[  108.461525] ACPI: \_PR_.PR01: Found 3 idle states
[  108.466924] CPU1 is up
[  108.467495] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  108.470939] numa_add_cpu cpu 2 node 0: mask now 0-2
[  108.485396] ACPI: \_PR_.PR02: Found 3 idle states
[  108.491500] CPU2 is up
[  108.492065] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  108.494934] numa_add_cpu cpu 3 node 0: mask now 0-3
[  108.509322] ACPI: \_PR_.PR03: Found 3 idle states
[  108.514700] CPU3 is up
[  108.515246] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  108.515618] numa_add_cpu cpu 4 node 0: mask now 0-4
[  108.530247] ACPI: \_PR_.PR04: Found 3 idle states
[  108.536321] CPU4 is up
[  108.536879] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  108.537232] numa_add_cpu cpu 5 node 0: mask now 0-5
[  108.552075] ACPI: \_PR_.PR05: Found 3 idle states
[  108.558241] CPU5 is up
[  108.558767] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  108.559114] numa_add_cpu cpu 6 node 0: mask now 0-6
[  108.573594] ACPI: \_PR_.PR06: Found 3 idle states
[  108.580133] CPU6 is up
[  108.580661] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  108.581012] numa_add_cpu cpu 7 node 0: mask now 0-7
[  108.595510] ACPI: \_PR_.PR07: Found 3 idle states
[  108.602431] CPU7 is up
[  108.606036] ACPI: PM: Waking up from system sleep state S3
[  109.352632] ACPI: EC: interrupt unblocked
[  109.353530] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  109.353727] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  109.353741] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  109.353795] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  110.534805] ACPI: EC: event unblocked
[  110.543989] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  110.543997] usb usb1: root hub lost power or was reset
[  110.544001] usb usb2: root hub lost power or was reset
[  110.567253] nvme nvme0: 8/0/0 default/read/poll queues
[  110.839234] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  111.056898] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  111.068178] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  111.069690] OOM killer enabled.
[  111.070526] Restarting tasks ... done.
[  111.077196] random: crng reseeded on system resumption
[  111.085178] PM: suspend exit
[  111.262210] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  111.264267] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  111.468726] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  111.469805] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  111.678363] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  111.679488] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  111.884232] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  111.885273] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  112.093903] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  112.095014] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  112.304973] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  112.305048] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  112.510958] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  112.512061] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  112.716505] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  112.717577] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  113.408594] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  121.119269] rtcwake test 6
[  121.245655] PM: suspend entry (deep)
[  121.247960] Filesystems sync: 0.000 seconds
[  121.250934] Freezing user space processes
[  121.256385] Freezing user space processes completed (elapsed 0.005 seconds)
[  121.257679] OOM killer disabled.
[  121.258504] Freezing remaining freezable tasks
[  121.261241] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  121.262396] printk: Suspending console(s) (use no_console_suspend to debug)
[  121.310246] e1000e: EEE TX LPI TIMER: 00000011
[  121.402775] ACPI: EC: interrupt blocked
[  121.455998] ACPI: PM: Preparing to enter system sleep state S3
[  121.487704] ACPI: EC: event blocked
[  121.487709] ACPI: EC: EC stopped
[  121.487713] ACPI: PM: Saving platform NVS memory
[  121.487892] Disabling non-boot CPUs ...
[  121.499120] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  121.500557] smpboot: CPU 1 is now offline
[  121.509374] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  121.510804] smpboot: CPU 2 is now offline
[  121.527411] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  121.529893] smpboot: CPU 3 is now offline
[  121.544390] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  121.546035] smpboot: CPU 4 is now offline
[  121.558926] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  121.560267] smpboot: CPU 5 is now offline
[  121.568353] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  121.569550] smpboot: CPU 6 is now offline
[  121.587648] numa_remove_cpu cpu 7 node 0: mask now 0
[  121.588969] smpboot: CPU 7 is now offline
[  121.598213] ACPI: PM: Low-level resume complete
[  121.598282] ACPI: EC: EC started
[  121.598287] ACPI: PM: Restoring platform NVS memory
[  121.601411] Enabling non-boot CPUs ...
[  121.602022] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  121.604300] numa_add_cpu cpu 1 node 0: mask now 0-1
[  121.623757] ACPI: \_PR_.PR01: Found 3 idle states
[  121.628837] CPU1 is up
[  121.629430] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  121.632263] numa_add_cpu cpu 2 node 0: mask now 0-2
[  121.646837] ACPI: \_PR_.PR02: Found 3 idle states
[  121.652737] CPU2 is up
[  121.653291] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  121.656258] numa_add_cpu cpu 3 node 0: mask now 0-3
[  121.670673] ACPI: \_PR_.PR03: Found 3 idle states
[  121.675906] CPU3 is up
[  121.676453] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  121.676826] numa_add_cpu cpu 4 node 0: mask now 0-4
[  121.691540] ACPI: \_PR_.PR04: Found 3 idle states
[  121.697502] CPU4 is up
[  121.698031] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  121.698388] numa_add_cpu cpu 5 node 0: mask now 0-5
[  121.712991] ACPI: \_PR_.PR05: Found 3 idle states
[  121.719141] CPU5 is up
[  121.719704] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  121.720056] numa_add_cpu cpu 6 node 0: mask now 0-6
[  121.734645] ACPI: \_PR_.PR06: Found 3 idle states
[  121.741165] CPU6 is up
[  121.741734] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  121.742083] numa_add_cpu cpu 7 node 0: mask now 0-7
[  121.756576] ACPI: \_PR_.PR07: Found 3 idle states
[  121.763544] CPU7 is up
[  121.767079] ACPI: PM: Waking up from system sleep state S3
[  122.500488] ACPI: EC: interrupt unblocked
[  122.501408] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  122.501653] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  122.501773] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  122.501791] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  123.665973] ACPI: EC: event unblocked
[  123.673107] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  123.673117] usb usb1: root hub lost power or was reset
[  123.673124] usb usb2: root hub lost power or was reset
[  123.702350] nvme nvme0: 8/0/0 default/read/poll queues
[  123.973336] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  124.189948] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  124.189956] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  124.201356] OOM killer enabled.
[  124.202078] Restarting tasks ... done.
[  124.205695] random: crng reseeded on system resumption
[  124.218420] PM: suspend exit
[  124.397525] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  124.399026] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  124.604233] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  124.605279] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  124.810825] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  124.811875] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  125.019618] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  125.019735] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  125.228199] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  125.229254] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  125.436388] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  125.437438] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  125.642560] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  125.643627] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  125.853272] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  125.857046] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  126.613949] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  134.247842] rtcwake test 7
[  134.364097] PM: suspend entry (deep)
[  134.366120] Filesystems sync: 0.000 seconds
[  134.370925] Freezing user space processes
[  134.380951] Freezing user space processes completed (elapsed 0.009 seconds)
[  134.381802] OOM killer disabled.
[  134.382618] Freezing remaining freezable tasks
[  134.385225] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  134.386281] printk: Suspending console(s) (use no_console_suspend to debug)
[  134.430404] e1000e: EEE TX LPI TIMER: 00000011
[  134.526566] ACPI: EC: interrupt blocked
[  134.571459] ACPI: PM: Preparing to enter system sleep state S3
[  134.596457] ACPI: EC: event blocked
[  134.596462] ACPI: EC: EC stopped
[  134.596465] ACPI: PM: Saving platform NVS memory
[  134.596654] Disabling non-boot CPUs ...
[  134.609882] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  134.612212] smpboot: CPU 1 is now offline
[  134.623438] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  134.624888] smpboot: CPU 2 is now offline
[  134.639863] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  134.641319] smpboot: CPU 3 is now offline
[  134.656051] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  134.657509] smpboot: CPU 4 is now offline
[  134.673742] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  134.674909] smpboot: CPU 5 is now offline
[  134.682118] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  134.683292] smpboot: CPU 6 is now offline
[  134.698617] numa_remove_cpu cpu 7 node 0: mask now 0
[  134.699846] smpboot: CPU 7 is now offline
[  134.705453] ACPI: PM: Low-level resume complete
[  134.705523] ACPI: EC: EC started
[  134.705528] ACPI: PM: Restoring platform NVS memory
[  134.708830] Enabling non-boot CPUs ...
[  134.709438] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  134.711397] numa_add_cpu cpu 1 node 0: mask now 0-1
[  134.731307] ACPI: \_PR_.PR01: Found 3 idle states
[  134.736008] CPU1 is up
[  134.736609] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  134.739596] numa_add_cpu cpu 2 node 0: mask now 0-2
[  134.754128] ACPI: \_PR_.PR02: Found 3 idle states
[  134.758903] CPU2 is up
[  134.759432] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  134.762589] numa_add_cpu cpu 3 node 0: mask now 0-3
[  134.776957] ACPI: \_PR_.PR03: Found 3 idle states
[  134.782200] CPU3 is up
[  134.782751] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  134.783139] numa_add_cpu cpu 4 node 0: mask now 0-4
[  134.797823] ACPI: \_PR_.PR04: Found 3 idle states
[  134.803824] CPU4 is up
[  134.804351] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  134.804708] numa_add_cpu cpu 5 node 0: mask now 0-5
[  134.819304] ACPI: \_PR_.PR05: Found 3 idle states
[  134.825456] CPU5 is up
[  134.826042] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  134.826390] numa_add_cpu cpu 6 node 0: mask now 0-6
[  134.840995] ACPI: \_PR_.PR06: Found 3 idle states
[  134.847548] CPU6 is up
[  134.848108] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  134.848461] numa_add_cpu cpu 7 node 0: mask now 0-7
[  134.862967] ACPI: \_PR_.PR07: Found 3 idle states
[  134.869916] CPU7 is up
[  134.873462] ACPI: PM: Waking up from system sleep state S3
[  135.603817] ACPI: EC: interrupt unblocked
[  135.604056] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  135.604321] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  135.604538] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  135.604606] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  136.788094] ACPI: EC: event unblocked
[  136.793243] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  136.793268] usb usb1: root hub lost power or was reset
[  136.793273] usb usb2: root hub lost power or was reset
[  136.830034] nvme nvme0: 8/0/0 default/read/poll queues
[  137.092828] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  137.322786] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  137.332235] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  137.333994] OOM killer enabled.
[  137.334833] Restarting tasks ... done.
[  137.337973] random: crng reseeded on system resumption
[  137.346113] PM: suspend exit
[  137.528293] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  137.530069] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  137.729083] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  137.730142] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  137.939728] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  137.940782] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  138.144856] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  138.145893] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  138.355824] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  138.356867] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  138.566419] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  138.567922] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  138.772555] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  138.776335] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  138.978168] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  138.979289] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  139.662305] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  147.376659] rtcwake test 8
[  147.488616] PM: suspend entry (deep)
[  147.493013] Filesystems sync: 0.003 seconds
[  147.497471] Freezing user space processes
[  147.500741] Freezing user space processes completed (elapsed 0.002 seconds)
[  147.501748] OOM killer disabled.
[  147.502478] Freezing remaining freezable tasks
[  147.505646] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
[  147.508925] printk: Suspending console(s) (use no_console_suspend to debug)
[  147.580153] e1000e: EEE TX LPI TIMER: 00000011
[  147.683303] ACPI: EC: interrupt blocked
[  147.733876] ACPI: PM: Preparing to enter system sleep state S3
[  147.758968] ACPI: EC: event blocked
[  147.758973] ACPI: EC: EC stopped
[  147.758977] ACPI: PM: Saving platform NVS memory
[  147.759063] Disabling non-boot CPUs ...
[  147.767391] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  147.768820] smpboot: CPU 1 is now offline
[  147.779127] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  147.781432] smpboot: CPU 2 is now offline
[  147.796407] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  147.798541] smpboot: CPU 3 is now offline
[  147.814407] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  147.815865] smpboot: CPU 4 is now offline
[  147.828771] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  147.829941] smpboot: CPU 5 is now offline
[  147.848873] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  147.850050] smpboot: CPU 6 is now offline
[  147.861687] numa_remove_cpu cpu 7 node 0: mask now 0
[  147.862862] smpboot: CPU 7 is now offline
[  147.872177] ACPI: PM: Low-level resume complete
[  147.872247] ACPI: EC: EC started
[  147.872252] ACPI: PM: Restoring platform NVS memory
[  147.875324] Enabling non-boot CPUs ...
[  147.876017] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  147.878951] numa_add_cpu cpu 1 node 0: mask now 0-1
[  147.898611] ACPI: \_PR_.PR01: Found 3 idle states
[  147.903320] CPU1 is up
[  147.903919] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  147.906928] numa_add_cpu cpu 2 node 0: mask now 0-2
[  147.923248] ACPI: \_PR_.PR02: Found 3 idle states
[  147.928779] CPU2 is up
[  147.929331] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  147.931927] numa_add_cpu cpu 3 node 0: mask now 0-3
[  147.946331] ACPI: \_PR_.PR03: Found 3 idle states
[  147.951580] CPU3 is up
[  147.952129] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  147.952500] numa_add_cpu cpu 4 node 0: mask now 0-4
[  147.967196] ACPI: \_PR_.PR04: Found 3 idle states
[  147.973254] CPU4 is up
[  147.973799] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  147.974154] numa_add_cpu cpu 5 node 0: mask now 0-5
[  147.989043] ACPI: \_PR_.PR05: Found 3 idle states
[  147.995183] CPU5 is up
[  147.995735] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  147.996083] numa_add_cpu cpu 6 node 0: mask now 0-6
[  148.010607] ACPI: \_PR_.PR06: Found 3 idle states
[  148.017081] CPU6 is up
[  148.017631] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  148.017978] numa_add_cpu cpu 7 node 0: mask now 0-7
[  148.032325] ACPI: \_PR_.PR07: Found 3 idle states
[  148.039543] CPU7 is up
[  148.043167] ACPI: PM: Waking up from system sleep state S3
[  148.777238] ACPI: EC: interrupt unblocked
[  148.778033] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  148.786751] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  148.787121] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  148.787315] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  149.977496] ACPI: EC: event unblocked
[  149.984281] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  149.984292] usb usb1: root hub lost power or was reset
[  149.984298] usb usb2: root hub lost power or was reset
[  150.012558] nvme nvme0: 8/0/0 default/read/poll queues
[  150.284220] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  150.493267] OOM killer enabled.
[  150.494079] Restarting tasks ... 
[  150.495339] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  150.495573] done.
[  150.496570] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  150.499717] random: crng reseeded on system resumption
[  150.508910] PM: suspend exit
[  150.703784] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  150.704947] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  150.914001] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  150.915107] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  151.120042] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  151.121085] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  151.330878] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  151.331903] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  151.535576] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  151.536627] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  151.746183] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  151.749340] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  151.954892] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  151.956021] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  152.160527] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  152.161620] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  152.807573] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  160.540095] rtcwake test 9
[  160.648273] PM: suspend entry (deep)
[  160.649764] Filesystems sync: 0.000 seconds
[  160.654288] Freezing user space processes
[  160.657263] Freezing user space processes completed (elapsed 0.002 seconds)
[  160.658171] OOM killer disabled.
[  160.658986] Freezing remaining freezable tasks
[  160.661202] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  160.662276] printk: Suspending console(s) (use no_console_suspend to debug)
[  160.707570] e1000e: EEE TX LPI TIMER: 00000011
[  160.819999] ACPI: EC: interrupt blocked
[  160.869806] ACPI: PM: Preparing to enter system sleep state S3
[  160.894007] ACPI: EC: event blocked
[  160.894012] ACPI: EC: EC stopped
[  160.894016] ACPI: PM: Saving platform NVS memory
[  160.894120] Disabling non-boot CPUs ...
[  160.905144] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  160.906611] smpboot: CPU 1 is now offline
[  160.917578] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  160.919038] smpboot: CPU 2 is now offline
[  160.937261] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  160.938730] smpboot: CPU 3 is now offline
[  160.955240] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  160.956867] smpboot: CPU 4 is now offline
[  160.967015] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  160.969100] smpboot: CPU 5 is now offline
[  160.979381] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  160.980556] smpboot: CPU 6 is now offline
[  160.995820] numa_remove_cpu cpu 7 node 0: mask now 0
[  160.996998] smpboot: CPU 7 is now offline
[  161.002574] ACPI: PM: Low-level resume complete
[  161.002643] ACPI: EC: EC started
[  161.002648] ACPI: PM: Restoring platform NVS memory
[  161.007545] Enabling non-boot CPUs ...
[  161.008149] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  161.012348] numa_add_cpu cpu 1 node 0: mask now 0-1
[  161.033016] ACPI: \_PR_.PR01: Found 3 idle states
[  161.037686] CPU1 is up
[  161.038284] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  161.040838] numa_add_cpu cpu 2 node 0: mask now 0-2
[  161.056914] ACPI: \_PR_.PR02: Found 3 idle states
[  161.062720] CPU2 is up
[  161.063523] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  161.066269] numa_add_cpu cpu 3 node 0: mask now 0-3
[  161.080697] ACPI: \_PR_.PR03: Found 3 idle states
[  161.085945] CPU3 is up
[  161.086503] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  161.086935] numa_add_cpu cpu 4 node 0: mask now 0-4
[  161.101596] ACPI: \_PR_.PR04: Found 3 idle states
[  161.107593] CPU4 is up
[  161.108140] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  161.108498] numa_add_cpu cpu 5 node 0: mask now 0-5
[  161.123236] ACPI: \_PR_.PR05: Found 3 idle states
[  161.129432] CPU5 is up
[  161.129992] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  161.130340] numa_add_cpu cpu 6 node 0: mask now 0-6
[  161.144930] ACPI: \_PR_.PR06: Found 3 idle states
[  161.151429] CPU6 is up
[  161.151958] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  161.152305] numa_add_cpu cpu 7 node 0: mask now 0-7
[  161.166825] ACPI: \_PR_.PR07: Found 3 idle states
[  161.173762] CPU7 is up
[  161.179253] ACPI: PM: Waking up from system sleep state S3
[  161.915058] ACPI: EC: interrupt unblocked
[  161.915821] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  161.916069] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  161.916150] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  161.917147] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  163.058816] ACPI: EC: event unblocked
[  163.066026] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  163.066036] usb usb1: root hub lost power or was reset
[  163.066043] usb usb2: root hub lost power or was reset
[  163.102927] nvme nvme0: 8/0/0 default/read/poll queues
[  163.351388] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  163.559190] OOM killer enabled.
[  163.559966] Restarting tasks ... done.
[  163.562270] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  163.563285] random: crng reseeded on system resumption
[  163.564010] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  163.569048] PM: suspend exit
[  163.770048] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  163.770153] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  163.970696] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  163.971771] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  164.177954] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  164.179031] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  164.382672] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  164.383760] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  164.590733] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  164.591825] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  164.790389] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  164.791696] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  164.995094] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  164.996227] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  165.202706] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  165.203828] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  165.874102] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  173.512318] rtcwake test 10
[  173.617802] PM: suspend entry (deep)
[  173.620828] Filesystems sync: 0.001 seconds
[  173.625334] Freezing user space processes
[  173.628582] Freezing user space processes completed (elapsed 0.002 seconds)
[  173.629359] OOM killer disabled.
[  173.630188] Freezing remaining freezable tasks
[  173.632898] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  173.633936] printk: Suspending console(s) (use no_console_suspend to debug)
[  173.673982] e1000e: EEE TX LPI TIMER: 00000011
[  173.792136] ACPI: EC: interrupt blocked
[  173.841021] ACPI: PM: Preparing to enter system sleep state S3
[  173.871986] ACPI: EC: event blocked
[  173.871991] ACPI: EC: EC stopped
[  173.871995] ACPI: PM: Saving platform NVS memory
[  173.872347] Disabling non-boot CPUs ...
[  173.882159] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  173.884133] smpboot: CPU 1 is now offline
[  173.897513] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  173.899209] smpboot: CPU 2 is now offline
[  173.911420] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  173.913339] smpboot: CPU 3 is now offline
[  173.924530] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  173.925977] smpboot: CPU 4 is now offline
[  173.943503] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  173.944667] smpboot: CPU 5 is now offline
[  173.960153] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  173.961321] smpboot: CPU 6 is now offline
[  173.973624] numa_remove_cpu cpu 7 node 0: mask now 0
[  173.974936] smpboot: CPU 7 is now offline
[  173.987711] ACPI: PM: Low-level resume complete
[  173.987781] ACPI: EC: EC started
[  173.987785] ACPI: PM: Restoring platform NVS memory
[  173.990873] Enabling non-boot CPUs ...
[  173.991591] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  173.995906] numa_add_cpu cpu 1 node 0: mask now 0-1
[  174.014571] ACPI: \_PR_.PR01: Found 3 idle states
[  174.020734] CPU1 is up
[  174.021335] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  174.024262] numa_add_cpu cpu 2 node 0: mask now 0-2
[  174.038714] ACPI: \_PR_.PR02: Found 3 idle states
[  174.043486] CPU2 is up
[  174.044034] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  174.047169] numa_add_cpu cpu 3 node 0: mask now 0-3
[  174.061582] ACPI: \_PR_.PR03: Found 3 idle states
[  174.066810] CPU3 is up
[  174.067386] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  174.067758] numa_add_cpu cpu 4 node 0: mask now 0-4
[  174.082394] ACPI: \_PR_.PR04: Found 3 idle states
[  174.088358] CPU4 is up
[  174.088886] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  174.089246] numa_add_cpu cpu 5 node 0: mask now 0-5
[  174.103905] ACPI: \_PR_.PR05: Found 3 idle states
[  174.110107] CPU5 is up
[  174.110641] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  174.110989] numa_add_cpu cpu 6 node 0: mask now 0-6
[  174.125666] ACPI: \_PR_.PR06: Found 3 idle states
[  174.133480] CPU6 is up
[  174.134035] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  174.134382] numa_add_cpu cpu 7 node 0: mask now 0-7
[  174.148871] ACPI: \_PR_.PR07: Found 3 idle states
[  174.156604] CPU7 is up
[  174.160155] ACPI: PM: Waking up from system sleep state S3
[  174.889866] ACPI: EC: interrupt unblocked
[  174.890272] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  174.890417] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  174.890517] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  174.890583] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  176.077113] ACPI: EC: event unblocked
[  176.086103] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  176.086113] usb usb1: root hub lost power or was reset
[  176.086120] usb usb2: root hub lost power or was reset
[  176.114174] nvme nvme0: 8/0/0 default/read/poll queues
[  176.382130] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  176.588246] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  176.589043] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  176.590044] OOM killer enabled.
[  176.590860] Restarting tasks ... done.
[  176.593846] random: crng reseeded on system resumption
[  176.602183] PM: suspend exit
[  176.796587] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  176.798600] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  177.001399] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  177.002446] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  177.208659] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  177.209706] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  177.420723] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  177.421788] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  177.644737] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  177.647946] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  177.849570] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  177.850686] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  178.056545] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  178.057677] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  178.262588] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  178.263707] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  179.021969] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  186.618014] rtcwake test 11
[  186.725253] PM: suspend entry (deep)
[  186.727001] Filesystems sync: 0.000 seconds
[  186.731586] Freezing user space processes
[  186.757395] Freezing user space processes completed (elapsed 0.024 seconds)
[  186.758227] OOM killer disabled.
[  186.758968] Freezing remaining freezable tasks
[  186.761574] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  186.772742] printk: Suspending console(s) (use no_console_suspend to debug)
[  186.816146] e1000e: EEE TX LPI TIMER: 00000011
[  186.917977] ACPI: EC: interrupt blocked
[  186.967637] ACPI: PM: Preparing to enter system sleep state S3
[  186.999389] ACPI: EC: event blocked
[  186.999393] ACPI: EC: EC stopped
[  186.999397] ACPI: PM: Saving platform NVS memory
[  186.999569] Disabling non-boot CPUs ...
[  187.008608] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  187.010186] smpboot: CPU 1 is now offline
[  187.024477] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  187.025938] smpboot: CPU 2 is now offline
[  187.038883] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  187.040316] smpboot: CPU 3 is now offline
[  187.050748] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  187.052191] smpboot: CPU 4 is now offline
[  187.072170] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  187.073329] smpboot: CPU 5 is now offline
[  187.082965] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  187.084857] smpboot: CPU 6 is now offline
[  187.097069] numa_remove_cpu cpu 7 node 0: mask now 0
[  187.098243] smpboot: CPU 7 is now offline
[  187.103045] ACPI: PM: Low-level resume complete
[  187.103115] ACPI: EC: EC started
[  187.103120] ACPI: PM: Restoring platform NVS memory
[  187.106145] Enabling non-boot CPUs ...
[  187.106893] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  187.110789] numa_add_cpu cpu 1 node 0: mask now 0-1
[  187.130713] ACPI: \_PR_.PR01: Found 3 idle states
[  187.135581] CPU1 is up
[  187.136170] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  187.139268] numa_add_cpu cpu 2 node 0: mask now 0-2
[  187.153780] ACPI: \_PR_.PR02: Found 3 idle states
[  187.158538] CPU2 is up
[  187.159086] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  187.161255] numa_add_cpu cpu 3 node 0: mask now 0-3
[  187.175675] ACPI: \_PR_.PR03: Found 3 idle states
[  187.180925] CPU3 is up
[  187.181477] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  187.181849] numa_add_cpu cpu 4 node 0: mask now 0-4
[  187.196520] ACPI: \_PR_.PR04: Found 3 idle states
[  187.202569] CPU4 is up
[  187.203095] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  187.203453] numa_add_cpu cpu 5 node 0: mask now 0-5
[  187.218017] ACPI: \_PR_.PR05: Found 3 idle states
[  187.224189] CPU5 is up
[  187.224717] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  187.225065] numa_add_cpu cpu 6 node 0: mask now 0-6
[  187.239689] ACPI: \_PR_.PR06: Found 3 idle states
[  187.246491] CPU6 is up
[  187.247019] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  187.247367] numa_add_cpu cpu 7 node 0: mask now 0-7
[  187.261829] ACPI: \_PR_.PR07: Found 3 idle states
[  187.268813] CPU7 is up
[  187.272338] ACPI: PM: Waking up from system sleep state S3
[  187.995800] ACPI: EC: interrupt unblocked
[  187.996874] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  187.996998] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  187.997053] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  187.997096] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  189.184371] ACPI: EC: event unblocked
[  189.190305] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  189.190314] usb usb1: root hub lost power or was reset
[  189.190319] usb usb2: root hub lost power or was reset
[  189.220229] nvme nvme0: 8/0/0 default/read/poll queues
[  189.480931] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  189.689226] OOM killer enabled.
[  189.690068] Restarting tasks ... 
[  189.690149] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  189.691704] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  189.696816] done.
[  189.698297] random: crng reseeded on system resumption
[  189.712594] PM: suspend exit
[  189.899132] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  189.901151] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  190.111142] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  190.113243] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  190.319870] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  190.320997] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  190.527139] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  190.528361] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  190.739171] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  190.740394] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  190.947495] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  190.948637] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  191.153390] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  191.154499] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  191.358794] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  191.358802] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  191.919934] igb 0000:05:00.0 eth1: Reset adapter
[  195.564294] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  199.768315] rtcwake test 12
[  199.889433] PM: suspend entry (deep)
[  199.893011] Filesystems sync: 0.001 seconds
[  199.897396] Freezing user space processes
[  199.902135] Freezing user space processes completed (elapsed 0.003 seconds)
[  199.902988] OOM killer disabled.
[  199.903823] Freezing remaining freezable tasks
[  199.906241] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  199.907365] printk: Suspending console(s) (use no_console_suspend to debug)
[  199.957407] e1000e: EEE TX LPI TIMER: 00000011
[  200.080426] ACPI: EC: interrupt blocked
[  200.131016] ACPI: PM: Preparing to enter system sleep state S3
[  200.157223] ACPI: EC: event blocked
[  200.157228] ACPI: EC: EC stopped
[  200.157232] ACPI: PM: Saving platform NVS memory
[  200.157372] Disabling non-boot CPUs ...
[  200.167343] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  200.168797] smpboot: CPU 1 is now offline
[  200.178394] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  200.179835] smpboot: CPU 2 is now offline
[  200.195538] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  200.197424] smpboot: CPU 3 is now offline
[  200.208716] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  200.210638] smpboot: CPU 4 is now offline
[  200.218891] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  200.220518] smpboot: CPU 5 is now offline
[  200.234175] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  200.235798] smpboot: CPU 6 is now offline
[  200.246840] numa_remove_cpu cpu 7 node 0: mask now 0
[  200.248018] smpboot: CPU 7 is now offline
[  200.252835] ACPI: PM: Low-level resume complete
[  200.252904] ACPI: EC: EC started
[  200.252909] ACPI: PM: Restoring platform NVS memory
[  200.256050] Enabling non-boot CPUs ...
[  200.256693] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  200.260293] numa_add_cpu cpu 1 node 0: mask now 0-1
[  200.279350] ACPI: \_PR_.PR01: Found 3 idle states
[  200.286158] CPU1 is up
[  200.286748] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  200.288998] numa_add_cpu cpu 2 node 0: mask now 0-2
[  200.305291] ACPI: \_PR_.PR02: Found 3 idle states
[  200.310070] CPU2 is up
[  200.310621] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  200.313313] numa_add_cpu cpu 3 node 0: mask now 0-3
[  200.327724] ACPI: \_PR_.PR03: Found 3 idle states
[  200.332985] CPU3 is up
[  200.333514] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  200.333921] numa_add_cpu cpu 4 node 0: mask now 0-4
[  200.348611] ACPI: \_PR_.PR04: Found 3 idle states
[  200.354618] CPU4 is up
[  200.355188] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  200.355537] numa_add_cpu cpu 5 node 0: mask now 0-5
[  200.370111] ACPI: \_PR_.PR05: Found 3 idle states
[  200.376323] CPU5 is up
[  200.376888] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  200.377238] numa_add_cpu cpu 6 node 0: mask now 0-6
[  200.391858] ACPI: \_PR_.PR06: Found 3 idle states
[  200.398395] CPU6 is up
[  200.398939] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  200.399288] numa_add_cpu cpu 7 node 0: mask now 0-7
[  200.413727] ACPI: \_PR_.PR07: Found 3 idle states
[  200.420714] CPU7 is up
[  200.424245] ACPI: PM: Waking up from system sleep state S3
[  201.173164] ACPI: EC: interrupt unblocked
[  201.174050] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  201.174269] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  201.174452] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  201.174508] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  202.316167] ACPI: EC: event unblocked
[  202.324615] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  202.324626] usb usb1: root hub lost power or was reset
[  202.324632] usb usb2: root hub lost power or was reset
[  202.350880] nvme nvme0: 8/0/0 default/read/poll queues
[  202.630714] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  202.844541] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  202.856717] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  202.858098] OOM killer enabled.
[  202.858949] Restarting tasks ... done.
[  202.861712] random: crng reseeded on system resumption
[  202.869825] PM: suspend exit
[  203.047940] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  203.049752] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  203.252941] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  203.254021] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  203.457585] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  203.458688] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  203.660037] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  203.661132] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  203.865799] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  203.866853] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  204.069631] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  204.070716] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  204.272649] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  204.272720] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  204.477447] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  204.478501] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  205.133861] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  212.778709] rtcwake test 13
[  212.898734] PM: suspend entry (deep)
[  212.900309] Filesystems sync: 0.000 seconds
[  212.905120] Freezing user space processes
[  212.909818] Freezing user space processes completed (elapsed 0.003 seconds)
[  212.910651] OOM killer disabled.
[  212.911447] Freezing remaining freezable tasks
[  212.913811] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  212.914900] printk: Suspending console(s) (use no_console_suspend to debug)
[  212.959231] e1000e: EEE TX LPI TIMER: 00000011
[  213.060058] ACPI: EC: interrupt blocked
[  213.104857] ACPI: PM: Preparing to enter system sleep state S3
[  213.136378] ACPI: EC: event blocked
[  213.136383] ACPI: EC: EC stopped
[  213.136387] ACPI: PM: Saving platform NVS memory
[  213.136559] Disabling non-boot CPUs ...
[  213.145533] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  213.146980] smpboot: CPU 1 is now offline
[  213.164589] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  213.166046] smpboot: CPU 2 is now offline
[  213.181414] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  213.183376] smpboot: CPU 3 is now offline
[  213.197280] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  213.198923] smpboot: CPU 4 is now offline
[  213.208850] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  213.210917] smpboot: CPU 5 is now offline
[  213.221851] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  213.223864] smpboot: CPU 6 is now offline
[  213.239570] numa_remove_cpu cpu 7 node 0: mask now 0
[  213.240740] smpboot: CPU 7 is now offline
[  213.245480] ACPI: PM: Low-level resume complete
[  213.245550] ACPI: EC: EC started
[  213.245555] ACPI: PM: Restoring platform NVS memory
[  213.248655] Enabling non-boot CPUs ...
[  213.249608] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  213.253936] numa_add_cpu cpu 1 node 0: mask now 0-1
[  213.273388] ACPI: \_PR_.PR01: Found 3 idle states
[  213.278080] CPU1 is up
[  213.278647] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  213.281768] numa_add_cpu cpu 2 node 0: mask now 0-2
[  213.296254] ACPI: \_PR_.PR02: Found 3 idle states
[  213.302665] CPU2 is up
[  213.303193] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  213.305642] numa_add_cpu cpu 3 node 0: mask now 0-3
[  213.320152] ACPI: \_PR_.PR03: Found 3 idle states
[  213.328237] CPU3 is up
[  213.328784] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  213.329155] numa_add_cpu cpu 4 node 0: mask now 0-4
[  213.343802] ACPI: \_PR_.PR04: Found 3 idle states
[  213.349787] CPU4 is up
[  213.350339] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  213.350688] numa_add_cpu cpu 5 node 0: mask now 0-5
[  213.365407] ACPI: \_PR_.PR05: Found 3 idle states
[  213.371626] CPU5 is up
[  213.372160] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  213.372511] numa_add_cpu cpu 6 node 0: mask now 0-6
[  213.387327] ACPI: \_PR_.PR06: Found 3 idle states
[  213.395217] CPU6 is up
[  213.395749] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  213.396096] numa_add_cpu cpu 7 node 0: mask now 0-7
[  213.410576] ACPI: \_PR_.PR07: Found 3 idle states
[  213.418512] CPU7 is up
[  213.422035] ACPI: PM: Waking up from system sleep state S3
[  214.159702] ACPI: EC: interrupt unblocked
[  214.160585] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  214.160705] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  214.160792] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  214.160898] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  215.298342] ACPI: EC: event unblocked
[  215.313781] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  215.313791] usb usb1: root hub lost power or was reset
[  215.313797] usb usb2: root hub lost power or was reset
[  215.340046] nvme nvme0: 8/0/0 default/read/poll queues
[  215.610486] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  215.816150] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  215.816158] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  215.820076] OOM killer enabled.
[  215.820881] Restarting tasks ... done.
[  215.823697] random: crng reseeded on system resumption
[  215.836683] PM: suspend exit
[  216.021752] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  216.023769] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  216.229318] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  216.230411] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  216.438348] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  216.439469] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  216.645515] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  216.646600] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  216.849968] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  216.851037] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  217.058139] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  217.059245] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  217.266375] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  217.267453] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  217.472413] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  217.473495] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  218.121810] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  225.837209] rtcwake test 14
[  225.945072] PM: suspend entry (deep)
[  225.946721] Filesystems sync: 0.000 seconds
[  225.952515] Freezing user space processes
[  225.955371] Freezing user space processes completed (elapsed 0.002 seconds)
[  225.956248] OOM killer disabled.
[  225.957045] Freezing remaining freezable tasks
[  225.959574] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  225.960589] printk: Suspending console(s) (use no_console_suspend to debug)
[  226.006650] e1000e: EEE TX LPI TIMER: 00000011
[  226.108402] ACPI: EC: interrupt blocked
[  226.153829] ACPI: PM: Preparing to enter system sleep state S3
[  226.179434] ACPI: EC: event blocked
[  226.179439] ACPI: EC: EC stopped
[  226.179443] ACPI: PM: Saving platform NVS memory
[  226.179619] Disabling non-boot CPUs ...
[  226.201654] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  226.203094] smpboot: CPU 1 is now offline
[  226.219239] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  226.220681] smpboot: CPU 2 is now offline
[  226.232630] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  226.234131] smpboot: CPU 3 is now offline
[  226.246887] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  226.248396] smpboot: CPU 4 is now offline
[  226.262706] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  226.264312] smpboot: CPU 5 is now offline
[  226.279373] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  226.280553] smpboot: CPU 6 is now offline
[  226.288868] numa_remove_cpu cpu 7 node 0: mask now 0
[  226.290141] smpboot: CPU 7 is now offline
[  226.297081] ACPI: PM: Low-level resume complete
[  226.297151] ACPI: EC: EC started
[  226.297156] ACPI: PM: Restoring platform NVS memory
[  226.300955] Enabling non-boot CPUs ...
[  226.301567] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  226.303878] numa_add_cpu cpu 1 node 0: mask now 0-1
[  226.322700] ACPI: \_PR_.PR01: Found 3 idle states
[  226.328258] CPU1 is up
[  226.328858] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  226.331811] numa_add_cpu cpu 2 node 0: mask now 0-2
[  226.346343] ACPI: \_PR_.PR02: Found 3 idle states
[  226.351474] CPU2 is up
[  226.352029] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  226.354774] numa_add_cpu cpu 3 node 0: mask now 0-3
[  226.369372] ACPI: \_PR_.PR03: Found 3 idle states
[  226.374604] CPU3 is up
[  226.375151] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  226.375521] numa_add_cpu cpu 4 node 0: mask now 0-4
[  226.390240] ACPI: \_PR_.PR04: Found 3 idle states
[  226.396203] CPU4 is up
[  226.396923] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  226.397272] numa_add_cpu cpu 5 node 0: mask now 0-5
[  226.411838] ACPI: \_PR_.PR05: Found 3 idle states
[  226.418009] CPU5 is up
[  226.418545] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  226.418895] numa_add_cpu cpu 6 node 0: mask now 0-6
[  226.433399] ACPI: \_PR_.PR06: Found 3 idle states
[  226.439882] CPU6 is up
[  226.440438] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  226.440786] numa_add_cpu cpu 7 node 0: mask now 0-7
[  226.455203] ACPI: \_PR_.PR07: Found 3 idle states
[  226.462130] CPU7 is up
[  226.465954] ACPI: PM: Waking up from system sleep state S3
[  227.193582] ACPI: EC: interrupt unblocked
[  227.194633] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  227.194816] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  227.194903] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  227.194962] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  228.398016] ACPI: EC: event unblocked
[  228.404358] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  228.404366] usb usb1: root hub lost power or was reset
[  228.404370] usb usb2: root hub lost power or was reset
[  228.430713] nvme nvme0: 8/0/0 default/read/poll queues
[  228.705980] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  228.919392] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  228.919399] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  228.941240] OOM killer enabled.
[  228.942021] Restarting tasks ... done.
[  228.945728] random: crng reseeded on system resumption
[  228.957807] PM: suspend exit
[  229.129803] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  229.131772] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  229.336385] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  229.337475] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  229.542396] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  229.543462] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  229.752488] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  229.753595] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  229.960473] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  229.961536] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  230.166179] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  230.167254] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  230.374668] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  230.376626] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  230.581246] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  230.582293] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  231.272709] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  238.974666] rtcwake test 15
[  239.087661] PM: suspend entry (deep)
[  239.090836] Filesystems sync: 0.002 seconds
[  239.094961] Freezing user space processes
[  239.097153] Freezing user space processes completed (elapsed 0.002 seconds)
[  239.097991] OOM killer disabled.
[  239.098804] Freezing remaining freezable tasks
[  239.101245] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  239.102276] printk: Suspending console(s) (use no_console_suspend to debug)
[  239.149002] e1000e: EEE TX LPI TIMER: 00000011
[  239.242825] ACPI: EC: interrupt blocked
[  239.296185] ACPI: PM: Preparing to enter system sleep state S3
[  239.326080] ACPI: EC: event blocked
[  239.326085] ACPI: EC: EC stopped
[  239.326089] ACPI: PM: Saving platform NVS memory
[  239.326242] Disabling non-boot CPUs ...
[  239.337864] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  239.339313] smpboot: CPU 1 is now offline
[  239.350489] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  239.352799] smpboot: CPU 2 is now offline
[  239.367069] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  239.368723] smpboot: CPU 3 is now offline
[  239.384340] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  239.385818] smpboot: CPU 4 is now offline
[  239.401256] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  239.402421] smpboot: CPU 5 is now offline
[  239.413029] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  239.414521] smpboot: CPU 6 is now offline
[  239.428992] numa_remove_cpu cpu 7 node 0: mask now 0
[  239.430308] smpboot: CPU 7 is now offline
[  239.437920] ACPI: PM: Low-level resume complete
[  239.437990] ACPI: EC: EC started
[  239.437994] ACPI: PM: Restoring platform NVS memory
[  239.441197] Enabling non-boot CPUs ...
[  239.441807] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  239.444011] numa_add_cpu cpu 1 node 0: mask now 0-1
[  239.463257] ACPI: \_PR_.PR01: Found 3 idle states
[  239.467924] CPU1 is up
[  239.468490] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  239.470955] numa_add_cpu cpu 2 node 0: mask now 0-2
[  239.485531] ACPI: \_PR_.PR02: Found 3 idle states
[  239.492872] CPU2 is up
[  239.493399] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  239.495950] numa_add_cpu cpu 3 node 0: mask now 0-3
[  239.510399] ACPI: \_PR_.PR03: Found 3 idle states
[  239.518426] CPU3 is up
[  239.518976] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  239.519347] numa_add_cpu cpu 4 node 0: mask now 0-4
[  239.533950] ACPI: \_PR_.PR04: Found 3 idle states
[  239.542776] CPU4 is up
[  239.543346] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  239.543694] numa_add_cpu cpu 5 node 0: mask now 0-5
[  239.558986] ACPI: \_PR_.PR05: Found 3 idle states
[  239.566416] CPU5 is up
[  239.567003] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  239.567353] numa_add_cpu cpu 6 node 0: mask now 0-6
[  239.582117] ACPI: \_PR_.PR06: Found 3 idle states
[  239.589998] CPU6 is up
[  239.590546] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  239.590912] numa_add_cpu cpu 7 node 0: mask now 0-7
[  239.605386] ACPI: \_PR_.PR07: Found 3 idle states
[  239.614995] CPU7 is up
[  239.618574] ACPI: PM: Waking up from system sleep state S3
[  240.347821] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  240.347838] ACPI: EC: interrupt unblocked
[  240.348196] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  240.348346] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  240.348695] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  241.521526] ACPI: EC: event unblocked
[  241.528448] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  241.528455] usb usb1: root hub lost power or was reset
[  241.528460] usb usb2: root hub lost power or was reset
[  241.559227] nvme nvme0: 8/0/0 default/read/poll queues
[  241.821646] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  242.057853] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  242.074255] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  242.075692] OOM killer enabled.
[  242.076486] Restarting tasks ... done.
[  242.079776] random: crng reseeded on system resumption
[  242.087797] PM: suspend exit
[  242.266260] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  242.268107] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  242.467001] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  242.468149] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  242.676731] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  242.677829] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  242.883474] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  242.884560] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  243.090231] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  243.091319] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  243.300582] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  243.302612] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  243.505732] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  243.507587] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  243.715926] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  243.717772] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  244.396624] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  252.113294] rtcwake test 16
[  252.240731] PM: suspend entry (deep)
[  252.242409] Filesystems sync: 0.000 seconds
[  252.246128] Freezing user space processes
[  252.250881] Freezing user space processes completed (elapsed 0.004 seconds)
[  252.251746] OOM killer disabled.
[  252.253341] Freezing remaining freezable tasks
[  252.255950] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  252.257301] printk: Suspending console(s) (use no_console_suspend to debug)
[  252.299704] e1000e: EEE TX LPI TIMER: 00000011
[  252.400920] ACPI: EC: interrupt blocked
[  252.449164] ACPI: PM: Preparing to enter system sleep state S3
[  252.491066] ACPI: EC: event blocked
[  252.491071] ACPI: EC: EC stopped
[  252.491075] ACPI: PM: Saving platform NVS memory
[  252.491232] Disabling non-boot CPUs ...
[  252.499572] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  252.501014] smpboot: CPU 1 is now offline
[  252.515522] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  252.517144] smpboot: CPU 2 is now offline
[  252.527084] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  252.529389] smpboot: CPU 3 is now offline
[  252.543100] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  252.545378] smpboot: CPU 4 is now offline
[  252.555486] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  252.556651] smpboot: CPU 5 is now offline
[  252.571589] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  252.572767] smpboot: CPU 6 is now offline
[  252.588714] numa_remove_cpu cpu 7 node 0: mask now 0
[  252.589987] smpboot: CPU 7 is now offline
[  252.596517] ACPI: PM: Low-level resume complete
[  252.596587] ACPI: EC: EC started
[  252.596592] ACPI: PM: Restoring platform NVS memory
[  252.601174] Enabling non-boot CPUs ...
[  252.601808] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  252.604829] numa_add_cpu cpu 1 node 0: mask now 0-1
[  252.624168] ACPI: \_PR_.PR01: Found 3 idle states
[  252.628860] CPU1 is up
[  252.629434] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  252.631712] numa_add_cpu cpu 2 node 0: mask now 0-2
[  252.646207] ACPI: \_PR_.PR02: Found 3 idle states
[  252.650998] CPU2 is up
[  252.651525] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  252.653698] numa_add_cpu cpu 3 node 0: mask now 0-3
[  252.668118] ACPI: \_PR_.PR03: Found 3 idle states
[  252.673338] CPU3 is up
[  252.673889] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  252.674276] numa_add_cpu cpu 4 node 0: mask now 0-4
[  252.688992] ACPI: \_PR_.PR04: Found 3 idle states
[  252.694996] CPU4 is up
[  252.695625] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  252.695980] numa_add_cpu cpu 5 node 0: mask now 0-5
[  252.710596] ACPI: \_PR_.PR05: Found 3 idle states
[  252.716790] CPU5 is up
[  252.717348] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  252.717696] numa_add_cpu cpu 6 node 0: mask now 0-6
[  252.732256] ACPI: \_PR_.PR06: Found 3 idle states
[  252.738781] CPU6 is up
[  252.739340] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  252.739689] numa_add_cpu cpu 7 node 0: mask now 0-7
[  252.754237] ACPI: \_PR_.PR07: Found 3 idle states
[  252.761206] CPU7 is up
[  252.764755] ACPI: PM: Waking up from system sleep state S3
[  253.512487] ACPI: EC: interrupt unblocked
[  253.513368] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  253.513503] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  253.513675] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  253.513716] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  254.692279] ACPI: EC: event unblocked
[  254.700486] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  254.700498] usb usb1: root hub lost power or was reset
[  254.700505] usb usb2: root hub lost power or was reset
[  254.721879] nvme nvme0: 8/0/0 default/read/poll queues
[  254.988584] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  255.191911] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  255.195598] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  255.197058] OOM killer enabled.
[  255.197870] Restarting tasks ... done.
[  255.200826] random: crng reseeded on system resumption
[  255.209065] PM: suspend exit
[  255.399011] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  255.400240] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  255.604053] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  255.605146] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  255.810672] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  255.811747] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  256.017250] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  256.018299] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  256.226136] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  256.227210] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  256.434679] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  256.435786] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  256.643041] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  256.644084] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  256.849039] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  256.850094] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  257.526839] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  265.235498] rtcwake test 17
[  265.353820] PM: suspend entry (deep)
[  265.356979] Filesystems sync: 0.002 seconds
[  265.360383] Freezing user space processes
[  265.369893] Freezing user space processes completed (elapsed 0.009 seconds)
[  265.370730] OOM killer disabled.
[  265.371567] Freezing remaining freezable tasks
[  265.374271] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  265.375319] printk: Suspending console(s) (use no_console_suspend to debug)
[  265.417097] e1000e: EEE TX LPI TIMER: 00000011
[  265.519811] ACPI: EC: interrupt blocked
[  265.564782] ACPI: PM: Preparing to enter system sleep state S3
[  265.591173] ACPI: EC: event blocked
[  265.591178] ACPI: EC: EC stopped
[  265.591182] ACPI: PM: Saving platform NVS memory
[  265.591330] Disabling non-boot CPUs ...
[  265.604582] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  265.606037] smpboot: CPU 1 is now offline
[  265.623109] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  265.625020] smpboot: CPU 2 is now offline
[  265.635080] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  265.636524] smpboot: CPU 3 is now offline
[  265.651059] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  265.652506] smpboot: CPU 4 is now offline
[  265.660275] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  265.661428] smpboot: CPU 5 is now offline
[  265.673992] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  265.676052] smpboot: CPU 6 is now offline
[  265.692083] numa_remove_cpu cpu 7 node 0: mask now 0
[  265.693262] smpboot: CPU 7 is now offline
[  265.703242] ACPI: PM: Low-level resume complete
[  265.703312] ACPI: EC: EC started
[  265.703316] ACPI: PM: Restoring platform NVS memory
[  265.706765] Enabling non-boot CPUs ...
[  265.707679] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  265.710366] numa_add_cpu cpu 1 node 0: mask now 0-1
[  265.729646] ACPI: \_PR_.PR01: Found 3 idle states
[  265.734779] CPU1 is up
[  265.735383] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  265.738343] numa_add_cpu cpu 2 node 0: mask now 0-2
[  265.752850] ACPI: \_PR_.PR02: Found 3 idle states
[  265.757632] CPU2 is up
[  265.758162] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  265.760330] numa_add_cpu cpu 3 node 0: mask now 0-3
[  265.774748] ACPI: \_PR_.PR03: Found 3 idle states
[  265.780054] CPU3 is up
[  265.780629] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  265.781017] numa_add_cpu cpu 4 node 0: mask now 0-4
[  265.796128] ACPI: \_PR_.PR04: Found 3 idle states
[  265.802047] CPU4 is up
[  265.802629] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  265.802977] numa_add_cpu cpu 5 node 0: mask now 0-5
[  265.817630] ACPI: \_PR_.PR05: Found 3 idle states
[  265.823764] CPU5 is up
[  265.824330] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  265.824678] numa_add_cpu cpu 6 node 0: mask now 0-6
[  265.839155] ACPI: \_PR_.PR06: Found 3 idle states
[  265.845636] CPU6 is up
[  265.846169] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  265.846516] numa_add_cpu cpu 7 node 0: mask now 0-7
[  265.860962] ACPI: \_PR_.PR07: Found 3 idle states
[  265.867905] CPU7 is up
[  265.871470] ACPI: PM: Waking up from system sleep state S3
[  266.613362] ACPI: EC: interrupt unblocked
[  266.614320] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  266.614462] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  266.614551] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  266.614608] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  267.811477] ACPI: EC: event unblocked
[  267.819600] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  267.819608] usb usb1: root hub lost power or was reset
[  267.819612] usb usb2: root hub lost power or was reset
[  267.854734] nvme nvme0: 8/0/0 default/read/poll queues
[  268.117392] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  268.336906] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  268.353193] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  268.354687] OOM killer enabled.
[  268.355503] Restarting tasks ... done.
[  268.358999] random: crng reseeded on system resumption
[  268.376473] PM: suspend exit
[  268.538071] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  268.540160] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  268.748112] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  268.749226] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  268.953495] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  268.953599] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  269.160938] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  269.162009] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  269.369256] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  269.370312] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  269.578017] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  269.579158] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  269.786393] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  269.787882] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  269.992926] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  269.994027] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  270.663560] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  278.417771] rtcwake test 18
[  278.534403] PM: suspend entry (deep)
[  278.538180] Filesystems sync: 0.002 seconds
[  278.542646] Freezing user space processes
[  278.545995] Freezing user space processes completed (elapsed 0.002 seconds)
[  278.546782] OOM killer disabled.
[  278.547591] Freezing remaining freezable tasks
[  278.550257] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  278.551264] printk: Suspending console(s) (use no_console_suspend to debug)
[  278.605941] e1000e: EEE TX LPI TIMER: 00000011
[  278.705413] ACPI: EC: interrupt blocked
[  278.750372] ACPI: PM: Preparing to enter system sleep state S3
[  278.776860] ACPI: EC: event blocked
[  278.776864] ACPI: EC: EC stopped
[  278.776868] ACPI: PM: Saving platform NVS memory
[  278.777048] Disabling non-boot CPUs ...
[  278.785626] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  278.787074] smpboot: CPU 1 is now offline
[  278.805889] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  278.807341] smpboot: CPU 2 is now offline
[  278.814390] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  278.815849] smpboot: CPU 3 is now offline
[  278.830881] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  278.832749] smpboot: CPU 4 is now offline
[  278.848986] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  278.850152] smpboot: CPU 5 is now offline
[  278.866730] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  278.867891] smpboot: CPU 6 is now offline
[  278.882537] numa_remove_cpu cpu 7 node 0: mask now 0
[  278.883714] smpboot: CPU 7 is now offline
[  278.889910] ACPI: PM: Low-level resume complete
[  278.889980] ACPI: EC: EC started
[  278.889985] ACPI: PM: Restoring platform NVS memory
[  278.896312] Enabling non-boot CPUs ...
[  278.896949] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  278.901140] numa_add_cpu cpu 1 node 0: mask now 0-1
[  278.919439] ACPI: \_PR_.PR01: Found 3 idle states
[  278.926502] CPU1 is up
[  278.927085] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  278.930049] numa_add_cpu cpu 2 node 0: mask now 0-2
[  278.944936] ACPI: \_PR_.PR02: Found 3 idle states
[  278.949698] CPU2 is up
[  278.950277] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  278.953030] numa_add_cpu cpu 3 node 0: mask now 0-3
[  278.967453] ACPI: \_PR_.PR03: Found 3 idle states
[  278.972664] CPU3 is up
[  278.973232] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  278.973621] numa_add_cpu cpu 4 node 0: mask now 0-4
[  278.988308] ACPI: \_PR_.PR04: Found 3 idle states
[  278.994259] CPU4 is up
[  278.994785] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  278.995143] numa_add_cpu cpu 5 node 0: mask now 0-5
[  279.009808] ACPI: \_PR_.PR05: Found 3 idle states
[  279.015951] CPU5 is up
[  279.016483] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  279.016836] numa_add_cpu cpu 6 node 0: mask now 0-6
[  279.031357] ACPI: \_PR_.PR06: Found 3 idle states
[  279.037798] CPU6 is up
[  279.038349] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  279.038696] numa_add_cpu cpu 7 node 0: mask now 0-7
[  279.053207] ACPI: \_PR_.PR07: Found 3 idle states
[  279.060109] CPU7 is up
[  279.064218] ACPI: PM: Waking up from system sleep state S3
[  279.789065] ACPI: EC: interrupt unblocked
[  279.789835] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  279.790125] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  279.790151] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  279.790226] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  280.996018] ACPI: EC: event unblocked
[  281.007835] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  281.007845] usb usb1: root hub lost power or was reset
[  281.007852] usb usb2: root hub lost power or was reset
[  281.034582] nvme nvme0: 8/0/0 default/read/poll queues
[  281.316916] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  281.532557] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  281.551134] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  281.557882] OOM killer enabled.
[  281.558679] Restarting tasks ... done.
[  281.564440] random: crng reseeded on system resumption
[  281.577286] PM: suspend exit
[  281.740097] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  281.742113] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  281.951552] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  281.952625] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  282.152963] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  282.154026] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  282.361950] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  282.362987] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  282.569918] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  282.571041] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  282.778517] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  282.779647] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  282.985736] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  282.986869] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  283.197756] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  283.198938] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  283.817254] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  291.609848] rtcwake test 19
[  291.719529] PM: suspend entry (deep)
[  291.721224] Filesystems sync: 0.000 seconds
[  291.726268] Freezing user space processes
[  291.750991] Freezing user space processes completed (elapsed 0.023 seconds)
[  291.751864] OOM killer disabled.
[  291.752698] Freezing remaining freezable tasks
[  291.755000] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  291.756022] printk: Suspending console(s) (use no_console_suspend to debug)
[  291.797471] e1000e: EEE TX LPI TIMER: 00000011
[  291.905461] ACPI: EC: interrupt blocked
[  291.951087] ACPI: PM: Preparing to enter system sleep state S3
[  291.976897] ACPI: EC: event blocked
[  291.976901] ACPI: EC: EC stopped
[  291.976905] ACPI: PM: Saving platform NVS memory
[  291.977079] Disabling non-boot CPUs ...
[  291.988073] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  291.989528] smpboot: CPU 1 is now offline
[  292.012565] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  292.014011] smpboot: CPU 2 is now offline
[  292.025751] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  292.027199] smpboot: CPU 3 is now offline
[  292.039098] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  292.041148] smpboot: CPU 4 is now offline
[  292.055683] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  292.056841] smpboot: CPU 5 is now offline
[  292.068788] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  292.069962] smpboot: CPU 6 is now offline
[  292.082271] numa_remove_cpu cpu 7 node 0: mask now 0
[  292.083453] smpboot: CPU 7 is now offline
[  292.089502] ACPI: PM: Low-level resume complete
[  292.089572] ACPI: EC: EC started
[  292.089577] ACPI: PM: Restoring platform NVS memory
[  292.092639] Enabling non-boot CPUs ...
[  292.095354] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  292.098664] numa_add_cpu cpu 1 node 0: mask now 0-1
[  292.116978] ACPI: \_PR_.PR01: Found 3 idle states
[  292.121649] CPU1 is up
[  292.122260] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  292.124778] numa_add_cpu cpu 2 node 0: mask now 0-2
[  292.139257] ACPI: \_PR_.PR02: Found 3 idle states
[  292.145423] CPU2 is up
[  292.146003] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  292.148761] numa_add_cpu cpu 3 node 0: mask now 0-3
[  292.163167] ACPI: \_PR_.PR03: Found 3 idle states
[  292.168430] CPU3 is up
[  292.168984] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  292.169354] numa_add_cpu cpu 4 node 0: mask now 0-4
[  292.184132] ACPI: \_PR_.PR04: Found 3 idle states
[  292.190118] CPU4 is up
[  292.190648] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  292.191054] numa_add_cpu cpu 5 node 0: mask now 0-5
[  292.205634] ACPI: \_PR_.PR05: Found 3 idle states
[  292.211820] CPU5 is up
[  292.212357] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  292.212751] numa_add_cpu cpu 6 node 0: mask now 0-6
[  292.227356] ACPI: \_PR_.PR06: Found 3 idle states
[  292.233934] CPU6 is up
[  292.234462] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  292.234808] numa_add_cpu cpu 7 node 0: mask now 0-7
[  292.249327] ACPI: \_PR_.PR07: Found 3 idle states
[  292.256247] CPU7 is up
[  292.259787] ACPI: PM: Waking up from system sleep state S3
[  292.982372] ACPI: EC: interrupt unblocked
[  292.983525] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  292.983687] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  292.983788] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  292.983849] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  294.177190] ACPI: EC: event unblocked
[  294.184289] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  294.184297] usb usb1: root hub lost power or was reset
[  294.184301] usb usb2: root hub lost power or was reset
[  294.212549] nvme nvme0: 8/0/0 default/read/poll queues
[  294.475777] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  294.695860] OOM killer enabled.
[  294.696710] Restarting tasks ... done.
[  294.699585] random: crng reseeded on system resumption
[  294.709760] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  294.709771] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  294.710258] PM: suspend exit
[  294.914686] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  294.916801] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  295.128654] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  295.130701] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  295.329352] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  295.330543] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  295.536456] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  295.537614] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  295.746280] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  295.747599] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  295.952434] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  295.953558] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  296.161564] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  296.162713] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  296.370286] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  296.370391] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  296.999003] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  304.763718] rtcwake test 20
[  304.891621] PM: suspend entry (deep)
[  304.893592] Filesystems sync: 0.000 seconds
[  304.898591] Freezing user space processes
[  304.902451] Freezing user space processes completed (elapsed 0.003 seconds)
[  304.905041] OOM killer disabled.
[  304.907190] Freezing remaining freezable tasks
[  304.911729] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
[  304.913649] printk: Suspending console(s) (use no_console_suspend to debug)
[  304.961542] e1000e: EEE TX LPI TIMER: 00000011
[  305.082143] ACPI: EC: interrupt blocked
[  305.180687] ACPI: PM: Preparing to enter system sleep state S3
[  305.227020] ACPI: EC: event blocked
[  305.227024] ACPI: EC: EC stopped
[  305.227028] ACPI: PM: Saving platform NVS memory
[  305.227219] Disabling non-boot CPUs ...
[  305.235763] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  305.237246] smpboot: CPU 1 is now offline
[  305.250922] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  305.252388] smpboot: CPU 2 is now offline
[  305.265250] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  305.266683] smpboot: CPU 3 is now offline
[  305.274094] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  305.275540] smpboot: CPU 4 is now offline
[  305.287182] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  305.288342] smpboot: CPU 5 is now offline
[  305.298552] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  305.299705] smpboot: CPU 6 is now offline
[  305.319436] numa_remove_cpu cpu 7 node 0: mask now 0
[  305.320742] smpboot: CPU 7 is now offline
[  305.325539] ACPI: PM: Low-level resume complete
[  305.325610] ACPI: EC: EC started
[  305.325614] ACPI: PM: Restoring platform NVS memory
[  305.328732] Enabling non-boot CPUs ...
[  305.329373] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  305.335208] numa_add_cpu cpu 1 node 0: mask now 0-1
[  305.355084] ACPI: \_PR_.PR01: Found 3 idle states
[  305.359997] CPU1 is up
[  305.360614] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  305.363509] numa_add_cpu cpu 2 node 0: mask now 0-2
[  305.378044] ACPI: \_PR_.PR02: Found 3 idle states
[  305.382820] CPU2 is up
[  305.383349] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  305.386489] numa_add_cpu cpu 3 node 0: mask now 0-3
[  305.400923] ACPI: \_PR_.PR03: Found 3 idle states
[  305.406133] CPU3 is up
[  305.406682] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  305.407055] numa_add_cpu cpu 4 node 0: mask now 0-4
[  305.421774] ACPI: \_PR_.PR04: Found 3 idle states
[  305.427759] CPU4 is up
[  305.428288] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  305.428648] numa_add_cpu cpu 5 node 0: mask now 0-5
[  305.443264] ACPI: \_PR_.PR05: Found 3 idle states
[  305.449457] CPU5 is up
[  305.449987] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  305.450335] numa_add_cpu cpu 6 node 0: mask now 0-6
[  305.464970] ACPI: \_PR_.PR06: Found 3 idle states
[  305.471533] CPU6 is up
[  305.472063] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  305.472418] numa_add_cpu cpu 7 node 0: mask now 0-7
[  305.486775] ACPI: \_PR_.PR07: Found 3 idle states
[  305.493677] CPU7 is up
[  305.497245] ACPI: PM: Waking up from system sleep state S3
[  306.229528] ACPI: EC: interrupt unblocked
[  306.230432] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  306.230597] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  306.230693] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  306.230762] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  307.426169] ACPI: EC: event unblocked
[  307.434330] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  307.434340] usb usb1: root hub lost power or was reset
[  307.434346] usb usb2: root hub lost power or was reset
[  307.458109] nvme nvme0: 8/0/0 default/read/poll queues
[  307.731484] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  307.943800] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  307.959019] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  307.965566] OOM killer enabled.
[  307.966410] Restarting tasks ... done.
[  307.971541] random: crng reseeded on system resumption
[  307.979269] PM: suspend exit
[  308.145397] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  308.146535] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  308.356462] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  308.358674] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  308.560480] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  308.561610] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  308.771836] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  308.773080] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  308.977882] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  308.978991] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  309.184131] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  309.185228] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  309.393651] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  309.394700] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  309.600755] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  309.601872] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  310.260811] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  318.005240] rtcwake test 21
[  318.130162] PM: suspend entry (deep)
[  318.131957] Filesystems sync: 0.000 seconds
[  318.136691] Freezing user space processes
[  318.140454] Freezing user space processes completed (elapsed 0.002 seconds)
[  318.141273] OOM killer disabled.
[  318.142015] Freezing remaining freezable tasks
[  318.144414] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  318.145445] printk: Suspending console(s) (use no_console_suspend to debug)
[  318.185577] e1000e: EEE TX LPI TIMER: 00000011
[  318.307754] ACPI: EC: interrupt blocked
[  318.354139] ACPI: PM: Preparing to enter system sleep state S3
[  318.380501] ACPI: EC: event blocked
[  318.380505] ACPI: EC: EC stopped
[  318.380509] ACPI: PM: Saving platform NVS memory
[  318.380679] Disabling non-boot CPUs ...
[  318.398223] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  318.399673] smpboot: CPU 1 is now offline
[  318.413327] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  318.414777] smpboot: CPU 2 is now offline
[  318.434140] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  318.435575] smpboot: CPU 3 is now offline
[  318.447536] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  318.448995] smpboot: CPU 4 is now offline
[  318.464008] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  318.465982] smpboot: CPU 5 is now offline
[  318.479174] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  318.480339] smpboot: CPU 6 is now offline
[  318.495671] numa_remove_cpu cpu 7 node 0: mask now 0
[  318.496868] smpboot: CPU 7 is now offline
[  318.505102] ACPI: PM: Low-level resume complete
[  318.505171] ACPI: EC: EC started
[  318.505176] ACPI: PM: Restoring platform NVS memory
[  318.508404] Enabling non-boot CPUs ...
[  318.509037] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  318.511309] numa_add_cpu cpu 1 node 0: mask now 0-1
[  318.530915] ACPI: \_PR_.PR01: Found 3 idle states
[  318.535593] CPU1 is up
[  318.536162] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  318.539258] numa_add_cpu cpu 2 node 0: mask now 0-2
[  318.555727] ACPI: \_PR_.PR02: Found 3 idle states
[  318.560478] CPU2 is up
[  318.561003] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  318.563244] numa_add_cpu cpu 3 node 0: mask now 0-3
[  318.577617] ACPI: \_PR_.PR03: Found 3 idle states
[  318.582876] CPU3 is up
[  318.584494] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  318.584846] numa_add_cpu cpu 4 node 0: mask now 0-4
[  318.600851] ACPI: \_PR_.PR04: Found 3 idle states
[  318.607957] CPU4 is up
[  318.608515] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  318.608868] numa_add_cpu cpu 5 node 0: mask now 0-5
[  318.623541] ACPI: \_PR_.PR05: Found 3 idle states
[  318.629655] CPU5 is up
[  318.630232] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  318.630621] numa_add_cpu cpu 6 node 0: mask now 0-6
[  318.645303] ACPI: \_PR_.PR06: Found 3 idle states
[  318.651810] CPU6 is up
[  318.652371] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  318.652718] numa_add_cpu cpu 7 node 0: mask now 0-7
[  318.667220] ACPI: \_PR_.PR07: Found 3 idle states
[  318.674175] CPU7 is up
[  318.677764] ACPI: PM: Waking up from system sleep state S3
[  319.411766] ACPI: EC: interrupt unblocked
[  319.412867] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  319.412954] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  319.413193] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  319.413207] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  320.610268] ACPI: EC: event unblocked
[  320.618553] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  320.618563] usb usb1: root hub lost power or was reset
[  320.618569] usb usb2: root hub lost power or was reset
[  320.649294] nvme nvme0: 8/0/0 default/read/poll queues
[  320.925590] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  321.147328] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  321.160655] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  321.162091] OOM killer enabled.
[  321.162830] Restarting tasks ... done.
[  321.166593] random: crng reseeded on system resumption
[  321.186771] PM: suspend exit
[  321.353655] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  321.355808] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  321.565542] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  321.566689] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  321.774220] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  321.775359] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  321.975825] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  321.976909] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  322.184660] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  322.185772] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  322.391883] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  322.392982] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  322.602754] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  322.603799] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  322.807672] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  322.809691] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  323.428456] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  331.228592] rtcwake test 22
[  331.320529] PM: suspend entry (deep)
[  331.323694] Filesystems sync: 0.002 seconds
[  331.329371] Freezing user space processes
[  331.332204] Freezing user space processes completed (elapsed 0.002 seconds)
[  331.333145] OOM killer disabled.
[  331.333988] Freezing remaining freezable tasks
[  331.336162] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  331.337193] printk: Suspending console(s) (use no_console_suspend to debug)
[  331.376247] e1000e: EEE TX LPI TIMER: 00000011
[  331.469396] ACPI: EC: interrupt blocked
[  331.520363] ACPI: PM: Preparing to enter system sleep state S3
[  331.552910] ACPI: EC: event blocked
[  331.552915] ACPI: EC: EC stopped
[  331.552919] ACPI: PM: Saving platform NVS memory
[  331.553077] Disabling non-boot CPUs ...
[  331.565082] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  331.566531] smpboot: CPU 1 is now offline
[  331.586453] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  331.587917] smpboot: CPU 2 is now offline
[  331.596872] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  331.598344] smpboot: CPU 3 is now offline
[  331.607586] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  331.609024] smpboot: CPU 4 is now offline
[  331.623821] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  331.624986] smpboot: CPU 5 is now offline
[  331.633029] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  331.634808] smpboot: CPU 6 is now offline
[  331.645397] numa_remove_cpu cpu 7 node 0: mask now 0
[  331.646571] smpboot: CPU 7 is now offline
[  331.651218] ACPI: PM: Low-level resume complete
[  331.651288] ACPI: EC: EC started
[  331.651293] ACPI: PM: Restoring platform NVS memory
[  331.654390] Enabling non-boot CPUs ...
[  331.655180] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  331.660824] numa_add_cpu cpu 1 node 0: mask now 0-1
[  331.680696] ACPI: \_PR_.PR01: Found 3 idle states
[  331.685371] CPU1 is up
[  331.686023] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  331.689019] numa_add_cpu cpu 2 node 0: mask now 0-2
[  331.703496] ACPI: \_PR_.PR02: Found 3 idle states
[  331.709424] CPU2 is up
[  331.709972] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  331.713001] numa_add_cpu cpu 3 node 0: mask now 0-3
[  331.727441] ACPI: \_PR_.PR03: Found 3 idle states
[  331.732666] CPU3 is up
[  331.733251] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  331.733632] numa_add_cpu cpu 4 node 0: mask now 0-4
[  331.750064] ACPI: \_PR_.PR04: Found 3 idle states
[  331.756944] CPU4 is up
[  331.757474] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  331.757824] numa_add_cpu cpu 5 node 0: mask now 0-5
[  331.772506] ACPI: \_PR_.PR05: Found 3 idle states
[  331.778631] CPU5 is up
[  331.779212] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  331.779560] numa_add_cpu cpu 6 node 0: mask now 0-6
[  331.794086] ACPI: \_PR_.PR06: Found 3 idle states
[  331.800579] CPU6 is up
[  331.801147] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  331.801518] numa_add_cpu cpu 7 node 0: mask now 0-7
[  331.816179] ACPI: \_PR_.PR07: Found 3 idle states
[  331.823141] CPU7 is up
[  331.827558] ACPI: PM: Waking up from system sleep state S3
[  332.581968] ACPI: EC: interrupt unblocked
[  332.582639] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  332.582826] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  332.583037] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  332.583209] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  333.733462] ACPI: EC: event unblocked
[  333.740252] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  333.740261] usb usb1: root hub lost power or was reset
[  333.740267] usb usb2: root hub lost power or was reset
[  333.766071] nvme nvme0: 8/0/0 default/read/poll queues
[  334.035170] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  334.243144] OOM killer enabled.
[  334.243970] Restarting tasks ... 
[  334.248235] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  334.248406] done.
[  334.249434] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  334.253933] random: crng reseeded on system resumption
[  334.267020] PM: suspend exit
[  334.282808] loop0: detected capacity change from 0 to 8
[  334.459889] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  334.461836] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  334.665309] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  334.666491] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  334.880010] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  334.881103] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  335.080707] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  335.081765] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  335.287742] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  335.288823] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  335.497586] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  335.498649] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  335.703361] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  335.704370] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  335.912869] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  335.913997] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  336.603234] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  344.302113] rtcwake test 23
[  344.426692] PM: suspend entry (deep)
[  344.430133] Filesystems sync: 0.002 seconds
[  344.434499] Freezing user space processes
[  344.440877] Freezing user space processes completed (elapsed 0.005 seconds)
[  344.443662] OOM killer disabled.
[  344.445745] Freezing remaining freezable tasks
[  344.450331] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
[  344.452298] printk: Suspending console(s) (use no_console_suspend to debug)
[  344.498717] e1000e: EEE TX LPI TIMER: 00000011
[  344.610704] ACPI: EC: interrupt blocked
[  344.656569] ACPI: PM: Preparing to enter system sleep state S3
[  344.690542] ACPI: EC: event blocked
[  344.690547] ACPI: EC: EC stopped
[  344.690551] ACPI: PM: Saving platform NVS memory
[  344.690717] Disabling non-boot CPUs ...
[  344.704359] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  344.705794] smpboot: CPU 1 is now offline
[  344.719623] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  344.721074] smpboot: CPU 2 is now offline
[  344.731990] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  344.734448] smpboot: CPU 3 is now offline
[  344.758535] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  344.759971] smpboot: CPU 4 is now offline
[  344.773965] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  344.776421] smpboot: CPU 5 is now offline
[  344.788460] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  344.790463] smpboot: CPU 6 is now offline
[  344.805901] numa_remove_cpu cpu 7 node 0: mask now 0
[  344.807135] smpboot: CPU 7 is now offline
[  344.819304] ACPI: PM: Low-level resume complete
[  344.819374] ACPI: EC: EC started
[  344.819379] ACPI: PM: Restoring platform NVS memory
[  344.822445] Enabling non-boot CPUs ...
[  344.823129] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  344.825805] numa_add_cpu cpu 1 node 0: mask now 0-1
[  344.845204] ACPI: \_PR_.PR01: Found 3 idle states
[  344.850195] CPU1 is up
[  344.850785] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  344.853759] numa_add_cpu cpu 2 node 0: mask now 0-2
[  344.868331] ACPI: \_PR_.PR02: Found 3 idle states
[  344.874052] CPU2 is up
[  344.874580] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  344.876753] numa_add_cpu cpu 3 node 0: mask now 0-3
[  344.891185] ACPI: \_PR_.PR03: Found 3 idle states
[  344.896435] CPU3 is up
[  344.896980] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  344.897367] numa_add_cpu cpu 4 node 0: mask now 0-4
[  344.912193] ACPI: \_PR_.PR04: Found 3 idle states
[  344.918194] CPU4 is up
[  344.918755] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  344.919105] numa_add_cpu cpu 5 node 0: mask now 0-5
[  344.933719] ACPI: \_PR_.PR05: Found 3 idle states
[  344.939879] CPU5 is up
[  344.940419] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  344.940766] numa_add_cpu cpu 6 node 0: mask now 0-6
[  344.955596] ACPI: \_PR_.PR06: Found 3 idle states
[  344.962079] CPU6 is up
[  344.962660] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  344.963007] numa_add_cpu cpu 7 node 0: mask now 0-7
[  344.977402] ACPI: \_PR_.PR07: Found 3 idle states
[  344.984293] CPU7 is up
[  344.988367] ACPI: PM: Waking up from system sleep state S3
[  345.714722] ACPI: EC: interrupt unblocked
[  345.715592] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  345.715909] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  345.715994] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  345.716041] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  346.913401] ACPI: EC: event unblocked
[  346.920687] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  346.920696] usb usb1: root hub lost power or was reset
[  346.920702] usb usb2: root hub lost power or was reset
[  346.949778] nvme nvme0: 8/0/0 default/read/poll queues
[  347.210683] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  347.422006] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  347.439175] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  347.440595] OOM killer enabled.
[  347.441335] Restarting tasks ... done.
[  347.445300] random: crng reseeded on system resumption
[  347.457603] PM: suspend exit
[  347.624283] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  347.626243] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  347.835684] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  347.837553] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  348.039938] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  348.041979] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  348.248305] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  348.249376] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  348.456524] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  348.457562] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  348.663406] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  348.664477] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  348.873379] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  348.874421] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  349.079652] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  349.082827] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  349.733011] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  357.481094] rtcwake test 24
[  357.593122] PM: suspend entry (deep)
[  357.596219] Filesystems sync: 0.002 seconds
[  357.601025] Freezing user space processes
[  357.603731] Freezing user space processes completed (elapsed 0.001 seconds)
[  357.604569] OOM killer disabled.
[  357.605383] Freezing remaining freezable tasks
[  357.607764] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  357.608828] printk: Suspending console(s) (use no_console_suspend to debug)
[  357.653638] e1000e: EEE TX LPI TIMER: 00000011
[  357.756766] ACPI: EC: interrupt blocked
[  357.813719] ACPI: PM: Preparing to enter system sleep state S3
[  357.838368] ACPI: EC: event blocked
[  357.838373] ACPI: EC: EC stopped
[  357.838377] ACPI: PM: Saving platform NVS memory
[  357.838520] Disabling non-boot CPUs ...
[  357.852802] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  357.854243] smpboot: CPU 1 is now offline
[  357.865216] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  357.866661] smpboot: CPU 2 is now offline
[  357.882429] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  357.883878] smpboot: CPU 3 is now offline
[  357.891902] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  357.894222] smpboot: CPU 4 is now offline
[  357.910131] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  357.911307] smpboot: CPU 5 is now offline
[  357.921408] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  357.922578] smpboot: CPU 6 is now offline
[  357.932903] numa_remove_cpu cpu 7 node 0: mask now 0
[  357.934101] smpboot: CPU 7 is now offline
[  357.945103] ACPI: PM: Low-level resume complete
[  357.945171] ACPI: EC: EC started
[  357.945176] ACPI: PM: Restoring platform NVS memory
[  357.948224] Enabling non-boot CPUs ...
[  357.949220] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  357.951603] numa_add_cpu cpu 1 node 0: mask now 0-1
[  357.971168] ACPI: \_PR_.PR01: Found 3 idle states
[  357.976128] CPU1 is up
[  357.976731] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  357.979550] numa_add_cpu cpu 2 node 0: mask now 0-2
[  357.994110] ACPI: \_PR_.PR02: Found 3 idle states
[  357.999239] CPU2 is up
[  357.999787] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  358.002538] numa_add_cpu cpu 3 node 0: mask now 0-3
[  358.016996] ACPI: \_PR_.PR03: Found 3 idle states
[  358.022211] CPU3 is up
[  358.022759] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  358.023130] numa_add_cpu cpu 4 node 0: mask now 0-4
[  358.037880] ACPI: \_PR_.PR04: Found 3 idle states
[  358.045398] CPU4 is up
[  358.045956] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  358.046305] numa_add_cpu cpu 5 node 0: mask now 0-5
[  358.061070] ACPI: \_PR_.PR05: Found 3 idle states
[  358.067224] CPU5 is up
[  358.067811] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  358.068160] numa_add_cpu cpu 6 node 0: mask now 0-6
[  358.082724] ACPI: \_PR_.PR06: Found 3 idle states
[  358.089206] CPU6 is up
[  358.089777] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  358.090124] numa_add_cpu cpu 7 node 0: mask now 0-7
[  358.104531] ACPI: \_PR_.PR07: Found 3 idle states
[  358.111441] CPU7 is up
[  358.114999] ACPI: PM: Waking up from system sleep state S3
[  358.842263] ACPI: EC: interrupt unblocked
[  358.843155] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  358.843248] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  358.843513] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  358.843533] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  360.034778] ACPI: EC: event unblocked
[  360.042057] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  360.042064] usb usb1: root hub lost power or was reset
[  360.042068] usb usb2: root hub lost power or was reset
[  360.066944] nvme nvme0: 8/0/0 default/read/poll queues
[  360.340191] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  360.551448] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  360.575550] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  360.577050] OOM killer enabled.
[  360.577881] Restarting tasks ... done.
[  360.582060] random: crng reseeded on system resumption
[  360.588527] PM: suspend exit
[  360.764966] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  360.766499] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  360.973200] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  360.973272] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  361.175536] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  361.176583] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  361.384911] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  361.385931] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  361.591267] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  361.592326] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  361.800584] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  361.802143] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  362.008155] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  362.009239] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  362.219959] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  362.221073] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  362.861786] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  370.615774] rtcwake test 25
[  370.724591] PM: suspend entry (deep)
[  370.726259] Filesystems sync: 0.000 seconds
[  370.729383] Freezing user space processes
[  370.731715] Freezing user space processes completed (elapsed 0.002 seconds)
[  370.732547] OOM killer disabled.
[  370.733337] Freezing remaining freezable tasks
[  370.738726] Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
[  370.742944] printk: Suspending console(s) (use no_console_suspend to debug)
[  370.802176] e1000e: EEE TX LPI TIMER: 00000011
[  370.918443] ACPI: EC: interrupt blocked
[  370.965713] ACPI: PM: Preparing to enter system sleep state S3
[  370.989845] ACPI: EC: event blocked
[  370.989850] ACPI: EC: EC stopped
[  370.989853] ACPI: PM: Saving platform NVS memory
[  370.990028] Disabling non-boot CPUs ...
[  371.002919] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  371.004360] smpboot: CPU 1 is now offline
[  371.018579] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  371.020050] smpboot: CPU 2 is now offline
[  371.028690] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  371.030986] smpboot: CPU 3 is now offline
[  371.042890] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  371.045056] smpboot: CPU 4 is now offline
[  371.054972] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  371.056136] smpboot: CPU 5 is now offline
[  371.069992] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  371.072003] smpboot: CPU 6 is now offline
[  371.087220] numa_remove_cpu cpu 7 node 0: mask now 0
[  371.088539] smpboot: CPU 7 is now offline
[  371.094727] ACPI: PM: Low-level resume complete
[  371.094797] ACPI: EC: EC started
[  371.094801] ACPI: PM: Restoring platform NVS memory
[  371.097886] Enabling non-boot CPUs ...
[  371.101491] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  371.104669] numa_add_cpu cpu 1 node 0: mask now 0-1
[  371.123720] ACPI: \_PR_.PR01: Found 3 idle states
[  371.128464] CPU1 is up
[  371.129031] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  371.131329] numa_add_cpu cpu 2 node 0: mask now 0-2
[  371.147526] ACPI: \_PR_.PR02: Found 3 idle states
[  371.152800] CPU2 is up
[  371.153349] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  371.156324] numa_add_cpu cpu 3 node 0: mask now 0-3
[  371.170741] ACPI: \_PR_.PR03: Found 3 idle states
[  371.175975] CPU3 is up
[  371.176522] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  371.176892] numa_add_cpu cpu 4 node 0: mask now 0-4
[  371.191527] ACPI: \_PR_.PR04: Found 3 idle states
[  371.197492] CPU4 is up
[  371.198041] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  371.198404] numa_add_cpu cpu 5 node 0: mask now 0-5
[  371.212977] ACPI: \_PR_.PR05: Found 3 idle states
[  371.219134] CPU5 is up
[  371.219731] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  371.220079] numa_add_cpu cpu 6 node 0: mask now 0-6
[  371.234669] ACPI: \_PR_.PR06: Found 3 idle states
[  371.241203] CPU6 is up
[  371.241737] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  371.242085] numa_add_cpu cpu 7 node 0: mask now 0-7
[  371.256620] ACPI: \_PR_.PR07: Found 3 idle states
[  371.263571] CPU7 is up
[  371.267144] ACPI: PM: Waking up from system sleep state S3
[  372.003970] ACPI: EC: interrupt unblocked
[  372.004099] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  372.004153] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  372.004423] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  372.004575] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  373.154028] ACPI: EC: event unblocked
[  373.162145] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  373.162163] usb usb1: root hub lost power or was reset
[  373.162169] usb usb2: root hub lost power or was reset
[  373.189772] nvme nvme0: 8/0/0 default/read/poll queues
[  373.459219] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  373.668734] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  373.692813] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  373.694326] OOM killer enabled.
[  373.695167] Restarting tasks ... done.
[  373.698194] random: crng reseeded on system resumption
[  373.708662] PM: suspend exit
[  373.875217] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  373.877198] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  374.079734] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  374.080858] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  374.287347] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  374.288427] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  374.499141] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  374.500241] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  374.707749] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  374.708915] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  374.934446] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  374.941019] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  375.135229] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  375.136380] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  375.347000] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  375.348098] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  375.972556] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  383.728227] rtcwake test 26
[  383.842186] PM: suspend entry (deep)
[  383.845144] Filesystems sync: 0.001 seconds
[  383.850088] Freezing user space processes
[  383.853314] Freezing user space processes completed (elapsed 0.002 seconds)
[  383.854164] OOM killer disabled.
[  383.855033] Freezing remaining freezable tasks
[  383.857274] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  383.858371] printk: Suspending console(s) (use no_console_suspend to debug)
[  383.898981] e1000e: EEE TX LPI TIMER: 00000011
[  384.017908] ACPI: EC: interrupt blocked
[  384.063896] ACPI: PM: Preparing to enter system sleep state S3
[  384.095072] ACPI: EC: event blocked
[  384.095076] ACPI: EC: EC stopped
[  384.095080] ACPI: PM: Saving platform NVS memory
[  384.095269] Disabling non-boot CPUs ...
[  384.107525] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  384.108975] smpboot: CPU 1 is now offline
[  384.122947] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  384.124886] smpboot: CPU 2 is now offline
[  384.140267] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  384.141698] smpboot: CPU 3 is now offline
[  384.148477] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  384.150766] smpboot: CPU 4 is now offline
[  384.164063] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  384.165217] smpboot: CPU 5 is now offline
[  384.175178] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  384.176578] smpboot: CPU 6 is now offline
[  384.187893] numa_remove_cpu cpu 7 node 0: mask now 0
[  384.189878] smpboot: CPU 7 is now offline
[  384.196272] ACPI: PM: Low-level resume complete
[  384.196342] ACPI: EC: EC started
[  384.196347] ACPI: PM: Restoring platform NVS memory
[  384.199439] Enabling non-boot CPUs ...
[  384.201124] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  384.204133] numa_add_cpu cpu 1 node 0: mask now 0-1
[  384.221669] ACPI: \_PR_.PR01: Found 3 idle states
[  384.229403] CPU1 is up
[  384.229968] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  384.233105] numa_add_cpu cpu 2 node 0: mask now 0-2
[  384.247670] ACPI: \_PR_.PR02: Found 3 idle states
[  384.253837] CPU2 is up
[  384.254392] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  384.257086] numa_add_cpu cpu 3 node 0: mask now 0-3
[  384.271530] ACPI: \_PR_.PR03: Found 3 idle states
[  384.276748] CPU3 is up
[  384.277318] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  384.277695] numa_add_cpu cpu 4 node 0: mask now 0-4
[  384.292387] ACPI: \_PR_.PR04: Found 3 idle states
[  384.298325] CPU4 is up
[  384.298873] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  384.299231] numa_add_cpu cpu 5 node 0: mask now 0-5
[  384.314087] ACPI: \_PR_.PR05: Found 3 idle states
[  384.320230] CPU5 is up
[  384.320759] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  384.321105] numa_add_cpu cpu 6 node 0: mask now 0-6
[  384.335647] ACPI: \_PR_.PR06: Found 3 idle states
[  384.342131] CPU6 is up
[  384.342667] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  384.343016] numa_add_cpu cpu 7 node 0: mask now 0-7
[  384.357416] ACPI: \_PR_.PR07: Found 3 idle states
[  384.364316] CPU7 is up
[  384.367906] ACPI: PM: Waking up from system sleep state S3
[  385.092817] ACPI: EC: interrupt unblocked
[  385.093619] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  385.093835] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  385.094082] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  385.094160] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  386.276758] ACPI: EC: event unblocked
[  386.283576] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  386.283583] usb usb1: root hub lost power or was reset
[  386.283587] usb usb2: root hub lost power or was reset
[  386.312669] nvme nvme0: 8/0/0 default/read/poll queues
[  386.587079] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  386.792406] OOM killer enabled.
[  386.793199] Restarting tasks ... 
[  386.794250] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  386.797063] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  386.797094] done.
[  386.799423] random: crng reseeded on system resumption
[  386.812969] PM: suspend exit
[  387.003046] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  387.005108] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  387.211664] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  387.212763] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  387.420300] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  387.421416] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  387.625919] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  387.627020] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  387.830884] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  387.831994] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  388.041618] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  388.042774] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  388.248868] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  388.250000] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  388.460839] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  388.462831] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  388.692185] igb 0000:05:00.0 eth1: Reset adapter
[  391.532187] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  396.834445] rtcwake test 27
[  396.943819] PM: suspend entry (deep)
[  396.945530] Filesystems sync: 0.000 seconds
[  396.950897] Freezing user space processes
[  396.954205] Freezing user space processes completed (elapsed 0.002 seconds)
[  396.955035] OOM killer disabled.
[  396.955844] Freezing remaining freezable tasks
[  396.958197] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  396.959265] printk: Suspending console(s) (use no_console_suspend to debug)
[  396.997974] e1000e: EEE TX LPI TIMER: 00000011
[  397.089338] ACPI: EC: interrupt blocked
[  397.136483] ACPI: PM: Preparing to enter system sleep state S3
[  397.170696] ACPI: EC: event blocked
[  397.170700] ACPI: EC: EC stopped
[  397.170704] ACPI: PM: Saving platform NVS memory
[  397.170869] Disabling non-boot CPUs ...
[  397.181358] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  397.182889] smpboot: CPU 1 is now offline
[  397.193647] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  397.195304] smpboot: CPU 2 is now offline
[  397.211738] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  397.213183] smpboot: CPU 3 is now offline
[  397.225713] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  397.227156] smpboot: CPU 4 is now offline
[  397.245891] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  397.247058] smpboot: CPU 5 is now offline
[  397.258591] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  397.259872] smpboot: CPU 6 is now offline
[  397.272848] numa_remove_cpu cpu 7 node 0: mask now 0
[  397.274021] smpboot: CPU 7 is now offline
[  397.278840] ACPI: PM: Low-level resume complete
[  397.278910] ACPI: EC: EC started
[  397.278914] ACPI: PM: Restoring platform NVS memory
[  397.282036] Enabling non-boot CPUs ...
[  397.282673] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  397.286191] numa_add_cpu cpu 1 node 0: mask now 0-1
[  397.305095] ACPI: \_PR_.PR01: Found 3 idle states
[  397.310561] CPU1 is up
[  397.311157] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  397.313901] numa_add_cpu cpu 2 node 0: mask now 0-2
[  397.328501] ACPI: \_PR_.PR02: Found 3 idle states
[  397.333268] CPU2 is up
[  397.333843] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  397.336882] numa_add_cpu cpu 3 node 0: mask now 0-3
[  397.351316] ACPI: \_PR_.PR03: Found 3 idle states
[  397.356599] CPU3 is up
[  397.357174] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  397.357552] numa_add_cpu cpu 4 node 0: mask now 0-4
[  397.372245] ACPI: \_PR_.PR04: Found 3 idle states
[  397.378255] CPU4 is up
[  397.378823] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  397.379180] numa_add_cpu cpu 5 node 0: mask now 0-5
[  397.393785] ACPI: \_PR_.PR05: Found 3 idle states
[  397.400000] CPU5 is up
[  397.400528] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  397.400880] numa_add_cpu cpu 6 node 0: mask now 0-6
[  397.415493] ACPI: \_PR_.PR06: Found 3 idle states
[  397.422036] CPU6 is up
[  397.422566] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  397.422913] numa_add_cpu cpu 7 node 0: mask now 0-7
[  397.437423] ACPI: \_PR_.PR07: Found 3 idle states
[  397.444352] CPU7 is up
[  397.447896] ACPI: PM: Waking up from system sleep state S3
[  398.172718] ACPI: EC: interrupt unblocked
[  398.172803] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  398.173114] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  398.173158] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  398.173465] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  399.329987] ACPI: EC: event unblocked
[  399.337609] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  399.337616] usb usb1: root hub lost power or was reset
[  399.337621] usb usb2: root hub lost power or was reset
[  399.370356] nvme nvme0: 8/0/0 default/read/poll queues
[  399.643001] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  399.855885] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  399.866257] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  399.867701] OOM killer enabled.
[  399.868445] Restarting tasks ... done.
[  399.872040] random: crng reseeded on system resumption
[  399.880201] PM: suspend exit
[  400.066466] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  400.068497] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  400.273245] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  400.275198] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  400.480258] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  400.484574] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  400.690428] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  400.694598] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  400.902355] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  400.903447] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  401.110919] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  401.112960] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  401.320961] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  401.325678] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  401.527884] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  401.532565] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  402.182258] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  409.905902] rtcwake test 28
[  409.972706] PM: suspend entry (deep)
[  409.974714] Filesystems sync: 0.000 seconds
[  409.981746] Freezing user space processes
[  409.984984] Freezing user space processes completed (elapsed 0.002 seconds)
[  409.986021] OOM killer disabled.
[  409.987014] Freezing remaining freezable tasks
[  409.990040] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
[  409.991300] printk: Suspending console(s) (use no_console_suspend to debug)
[  410.030703] e1000e: EEE TX LPI TIMER: 00000011
[  410.128246] ACPI: EC: interrupt blocked
[  410.182488] ACPI: PM: Preparing to enter system sleep state S3
[  410.212714] ACPI: EC: event blocked
[  410.212719] ACPI: EC: EC stopped
[  410.212723] ACPI: PM: Saving platform NVS memory
[  410.212895] Disabling non-boot CPUs ...
[  410.220437] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  410.221879] smpboot: CPU 1 is now offline
[  410.240732] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  410.242188] smpboot: CPU 2 is now offline
[  410.252263] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  410.253693] smpboot: CPU 3 is now offline
[  410.270860] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  410.272307] smpboot: CPU 4 is now offline
[  410.285060] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  410.287372] smpboot: CPU 5 is now offline
[  410.294506] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  410.295670] smpboot: CPU 6 is now offline
[  410.307566] numa_remove_cpu cpu 7 node 0: mask now 0
[  410.308763] smpboot: CPU 7 is now offline
[  410.316346] ACPI: PM: Low-level resume complete
[  410.316415] ACPI: EC: EC started
[  410.316419] ACPI: PM: Restoring platform NVS memory
[  410.320327] Enabling non-boot CPUs ...
[  410.321369] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  410.323743] numa_add_cpu cpu 1 node 0: mask now 0-1
[  410.343342] ACPI: \_PR_.PR01: Found 3 idle states
[  410.348039] CPU1 is up
[  410.348667] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  410.351711] numa_add_cpu cpu 2 node 0: mask now 0-2
[  410.366204] ACPI: \_PR_.PR02: Found 3 idle states
[  410.372562] CPU2 is up
[  410.373143] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  410.375699] numa_add_cpu cpu 3 node 0: mask now 0-3
[  410.390175] ACPI: \_PR_.PR03: Found 3 idle states
[  410.398377] CPU3 is up
[  410.398933] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  410.399306] numa_add_cpu cpu 4 node 0: mask now 0-4
[  410.415708] ACPI: \_PR_.PR04: Found 3 idle states
[  410.423665] CPU4 is up
[  410.424193] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  410.424543] numa_add_cpu cpu 5 node 0: mask now 0-5
[  410.439225] ACPI: \_PR_.PR05: Found 3 idle states
[  410.447827] CPU5 is up
[  410.448355] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  410.448703] numa_add_cpu cpu 6 node 0: mask now 0-6
[  410.463303] ACPI: \_PR_.PR06: Found 3 idle states
[  410.472231] CPU6 is up
[  410.472785] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  410.473134] numa_add_cpu cpu 7 node 0: mask now 0-7
[  410.487733] ACPI: \_PR_.PR07: Found 3 idle states
[  410.497362] CPU7 is up
[  410.501197] ACPI: PM: Waking up from system sleep state S3
[  411.232298] ACPI: EC: interrupt unblocked
[  411.233229] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  411.233529] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  411.233620] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  411.233695] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  412.384253] ACPI: EC: event unblocked
[  412.391096] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  412.391106] usb usb1: root hub lost power or was reset
[  412.391113] usb usb2: root hub lost power or was reset
[  412.418050] nvme nvme0: 8/0/0 default/read/poll queues
[  412.682707] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  412.889533] OOM killer enabled.
[  412.890257] Restarting tasks ... 
[  412.891026] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  412.893490] done.
[  412.893630] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  412.894802] random: crng reseeded on system resumption
[  412.906366] PM: suspend exit
[  413.105416] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  413.107435] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  413.311068] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  413.312557] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  413.525815] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  413.529667] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  413.726903] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  413.730978] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  413.936638] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  413.940728] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  414.143240] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  414.144359] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  414.350018] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  414.351144] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  414.559246] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  414.560338] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  414.672723] igb 0000:05:00.0 eth1: Reset adapter
[  417.539775] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  422.941793] rtcwake test 29
[  423.059920] PM: suspend entry (deep)
[  423.063003] Filesystems sync: 0.002 seconds
[  423.067866] Freezing user space processes
[  423.071301] Freezing user space processes completed (elapsed 0.002 seconds)
[  423.072094] OOM killer disabled.
[  423.073016] Freezing remaining freezable tasks
[  423.075753] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  423.076854] printk: Suspending console(s) (use no_console_suspend to debug)
[  423.121800] e1000e: EEE TX LPI TIMER: 00000011
[  423.262914] ACPI: EC: interrupt blocked
[  423.310461] ACPI: PM: Preparing to enter system sleep state S3
[  423.337074] ACPI: EC: event blocked
[  423.337078] ACPI: EC: EC stopped
[  423.337082] ACPI: PM: Saving platform NVS memory
[  423.337220] Disabling non-boot CPUs ...
[  423.346706] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  423.348390] smpboot: CPU 1 is now offline
[  423.365123] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  423.367354] smpboot: CPU 2 is now offline
[  423.376744] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  423.378188] smpboot: CPU 3 is now offline
[  423.391987] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  423.393425] smpboot: CPU 4 is now offline
[  423.406090] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  423.407370] smpboot: CPU 5 is now offline
[  423.420703] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  423.421873] smpboot: CPU 6 is now offline
[  423.435523] numa_remove_cpu cpu 7 node 0: mask now 0
[  423.436701] smpboot: CPU 7 is now offline
[  423.447920] ACPI: PM: Low-level resume complete
[  423.447990] ACPI: EC: EC started
[  423.447994] ACPI: PM: Restoring platform NVS memory
[  423.451081] Enabling non-boot CPUs ...
[  423.452046] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  423.455195] numa_add_cpu cpu 1 node 0: mask now 0-1
[  423.474019] ACPI: \_PR_.PR01: Found 3 idle states
[  423.479363] CPU1 is up
[  423.479976] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  423.482495] numa_add_cpu cpu 2 node 0: mask now 0-2
[  423.497041] ACPI: \_PR_.PR02: Found 3 idle states
[  423.502839] CPU2 is up
[  423.503392] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  423.505891] numa_add_cpu cpu 3 node 0: mask now 0-3
[  423.520337] ACPI: \_PR_.PR03: Found 3 idle states
[  423.525581] CPU3 is up
[  423.526107] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  423.526535] numa_add_cpu cpu 4 node 0: mask now 0-4
[  423.541402] ACPI: \_PR_.PR04: Found 3 idle states
[  423.547372] CPU4 is up
[  423.547936] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  423.548284] numa_add_cpu cpu 5 node 0: mask now 0-5
[  423.562965] ACPI: \_PR_.PR05: Found 3 idle states
[  423.569145] CPU5 is up
[  423.569865] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  423.570212] numa_add_cpu cpu 6 node 0: mask now 0-6
[  423.584727] ACPI: \_PR_.PR06: Found 3 idle states
[  423.591208] CPU6 is up
[  423.591766] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  423.592114] numa_add_cpu cpu 7 node 0: mask now 0-7
[  423.606515] ACPI: \_PR_.PR07: Found 3 idle states
[  423.613505] CPU7 is up
[  423.617062] ACPI: PM: Waking up from system sleep state S3
[  424.351226] ACPI: EC: interrupt unblocked
[  424.352055] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  424.352382] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  424.352478] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  424.352525] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  425.519411] ACPI: EC: event unblocked
[  425.527196] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  425.527207] usb usb1: root hub lost power or was reset
[  425.527213] usb usb2: root hub lost power or was reset
[  425.553292] nvme nvme0: 8/0/0 default/read/poll queues
[  425.818340] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  426.036886] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  426.052689] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  426.059160] OOM killer enabled.
[  426.059975] Restarting tasks ... done.
[  426.063023] random: crng reseeded on system resumption
[  426.071427] PM: suspend exit
[  426.243299] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  426.245292] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  426.444195] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  426.444318] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  426.648033] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  426.650032] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  426.850756] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  426.852653] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  427.055530] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  427.056601] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  427.265808] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  427.267668] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  427.466447] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  427.467569] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  427.672629] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  427.673739] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  428.412507] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  435.990334] rtcwake test 30
[  436.106519] PM: suspend entry (deep)
[  436.108072] Filesystems sync: 0.000 seconds
[  436.112780] Freezing user space processes
[  436.115529] Freezing user space processes completed (elapsed 0.001 seconds)
[  436.116412] OOM killer disabled.
[  436.117204] Freezing remaining freezable tasks
[  436.119563] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  436.120641] printk: Suspending console(s) (use no_console_suspend to debug)
[  436.157090] e1000e: EEE TX LPI TIMER: 00000011
[  436.253662] ACPI: EC: interrupt blocked
[  436.302343] ACPI: PM: Preparing to enter system sleep state S3
[  436.326367] ACPI: EC: event blocked
[  436.326371] ACPI: EC: EC stopped
[  436.326375] ACPI: PM: Saving platform NVS memory
[  436.326501] Disabling non-boot CPUs ...
[  436.344019] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  436.345461] smpboot: CPU 1 is now offline
[  436.364336] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  436.365777] smpboot: CPU 2 is now offline
[  436.378447] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  436.379900] smpboot: CPU 3 is now offline
[  436.388250] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  436.389799] smpboot: CPU 4 is now offline
[  436.403557] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  436.404714] smpboot: CPU 5 is now offline
[  436.414717] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  436.416328] smpboot: CPU 6 is now offline
[  436.432271] numa_remove_cpu cpu 7 node 0: mask now 0
[  436.433495] smpboot: CPU 7 is now offline
[  436.439414] ACPI: PM: Low-level resume complete
[  436.439485] ACPI: EC: EC started
[  436.439489] ACPI: PM: Restoring platform NVS memory
[  436.442547] Enabling non-boot CPUs ...
[  436.444455] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  436.447623] numa_add_cpu cpu 1 node 0: mask now 0-1
[  436.467169] ACPI: \_PR_.PR01: Found 3 idle states
[  436.472281] CPU1 is up
[  436.472879] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  436.475659] numa_add_cpu cpu 2 node 0: mask now 0-2
[  436.491782] ACPI: \_PR_.PR02: Found 3 idle states
[  436.496543] CPU2 is up
[  436.497070] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  436.499544] numa_add_cpu cpu 3 node 0: mask now 0-3
[  436.513984] ACPI: \_PR_.PR03: Found 3 idle states
[  436.519215] CPU3 is up
[  436.519764] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  436.520142] numa_add_cpu cpu 4 node 0: mask now 0-4
[  436.534863] ACPI: \_PR_.PR04: Found 3 idle states
[  436.541073] CPU4 is up
[  436.541683] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  436.542033] numa_add_cpu cpu 5 node 0: mask now 0-5
[  436.556703] ACPI: \_PR_.PR05: Found 3 idle states
[  436.562850] CPU5 is up
[  436.563416] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  436.563765] numa_add_cpu cpu 6 node 0: mask now 0-6
[  436.578266] ACPI: \_PR_.PR06: Found 3 idle states
[  436.584745] CPU6 is up
[  436.585297] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  436.585645] numa_add_cpu cpu 7 node 0: mask now 0-7
[  436.600021] ACPI: \_PR_.PR07: Found 3 idle states
[  436.606887] CPU7 is up
[  436.610476] ACPI: PM: Waking up from system sleep state S3
[  437.337583] ACPI: EC: interrupt unblocked
[  437.338636] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  437.338705] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  437.338728] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  437.338758] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  438.515937] ACPI: EC: event unblocked
[  438.522533] xhci_hcd 0000:00:14.0: xHC error in resume, USBSTS 0x411, Reinit
[  438.522541] usb usb1: root hub lost power or was reset
[  438.522545] usb usb2: root hub lost power or was reset
[  438.552776] nvme nvme0: 8/0/0 default/read/poll queues
[  438.827261] usb 1-9: reset full-speed USB device number 2 using xhci_hcd
[  439.038295] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  439.038325] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  439.043882] OOM killer enabled.
[  439.044697] Restarting tasks ... done.
[  439.048186] random: crng reseeded on system resumption
[  439.060734] PM: suspend exit
[  439.242335] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  439.242445] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  439.446451] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  439.447497] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  439.655148] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  439.656212] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  439.860878] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  439.861960] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  440.069744] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  440.070954] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  440.276286] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  440.280471] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  440.486133] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  440.487255] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  440.690871] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  440.691930] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  441.337192] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  449.061525] rtcwake test 31
[  449.176854] PM: suspend entry (deep)
[  449.179072] Filesystems sync: 0.002 seconds
[  632.961545] loop0: detected capacity change from 0 to 8
[  637.003835] gpu-manager (6735) used greatest stack depth: 23808 bytes left
[  738.799026] kworker/dying (87) used greatest stack depth: 23488 bytes left
[  932.951032] loop0: detected capacity change from 0 to 8
[ 1232.962610] loop0: detected capacity change from 0 to 8


Return-Path: <linux-pm+bounces-20386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8DEA0C3B0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 22:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507A0162C89
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BB1D5145;
	Mon, 13 Jan 2025 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="seJLprL/"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFF1D3576
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803735; cv=none; b=N6IKHUrplo32IT6LPx807MqgFeWNHj3GdLZLoROarlE+2nV20LrFwHnDi7KQimqWI2cqZUs1Nsy5VF6hEVNJ7ka+PtI1u8ke0gKYxl+6KL4LhxLPLExP+konIlCZ2oJ50nrSsla5JgDUBV9tRvgm58B29CUsfMDGoTnuEsYcMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803735; c=relaxed/simple;
	bh=pGoMH/hwDdIJYsX1bvh568QW8EVJMIpQy41YTZBGvWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YiSMjJkwAZ80F9jvTb6+ve/gv6VAZqETty8sWwmWfING+1sXWnbfoMQ/th+MdcCxpL/YRzLE849PAsfCgq8H8jrx1LXF3v3vIciEDwao+ASPgJrBXrs90ygSBywEs8MuyvUb35UGHyC5smOMxsVSv4qH7f1Dcg3zFyr8O2cseQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=seJLprL/; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Mon, 13 Jan 2025 22:28:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736803728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=80qZXOdgGrL8Jm5xXofGCRM3MB/t7+shD9tCNhzcYhk=;
	b=seJLprL/jZaTwc1fvvIfVLh5hlr2Z5fesRsTuyObvOW7PFW3nVGsZ553+e8+xs2P2UuRhb
	qTyaBjFu5FQNYk6tEIIaEe8Wd5a73Ud01Z6PLU41tL33BflLbT7B6V6s2qXO9tVEc6tatF
	e79FZocYBybwXbOgzG2+ulemv+2dKotSbb2uQqyT8CqYpH5iqun0EORhOJb5YXX9Vjxq5A
	k8qwOPtm+PAmdWnGAv9oeYMvpm02AQZ+mxO68LbPbHLXDeiadUb87TYSSjHaBdwcZsbSXX
	N2CcCGxdcc5+m+FRJVzRqzsvqDlc/ghIqCXhrG/A5qz72k7GvMyweqcaLXgROw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com
Cc: kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
Message-ID: <Z4WFjBVHpndct7br@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

After rebooting the system via kexec, hibernating and rebooting the machine, this oops occurs:

```
[   88.485216] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000940: 0000 [#1] PREEMPT SMP KASAN PTI
[   88.485233] KASAN: probably user-memory-access in range [0x0000000000004a00-0x0000000000004a07]
[   88.485240] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 6.13.0-rc7_ricci #1
[   88.485245] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   88.485252] RIP: 0010:next_zone (mm/mmzone.c:20 mm/mmzone.c:37)
[ 88.485270] Code: 73 10 48 05 c0 06 00 00 48 83 c4 08 5b c3 cc cc cc cc 48 8d bb 00 4a 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 9d 00 00 00 8b 8b 00 4a 00 00
All code
========
   0:	73 10                	jae    0x12
   2:	48 05 c0 06 00 00    	add    $0x6c0,%rax
   8:	48 83 c4 08          	add    $0x8,%rsp
   c:	5b                   	pop    %rbx
   d:	c3                   	ret
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	48 8d bb 00 4a 00 00 	lea    0x4a00(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df 
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 9d 00 00 00    	jle    0xd7
  3a:	8b 8b 00 4a 00 00    	mov    0x4a00(%rbx),%ecx

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 08                	je     0x10
   8:	3c 03                	cmp    $0x3,%al
   a:	0f 8e 9d 00 00 00    	jle    0xad
  10:	8b 8b 00 4a 00 00    	mov    0x4a00(%rbx),%ecx
[   88.485275] RSP: 0018:ffffffffa4807ce8 EFLAGS: 00010002
[   88.485279] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11027fff565
[   88.485281] RDX: 0000000000000940 RSI: ffffffffa3a89b80 RDI: 0000000000004a00
[   88.485283] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed10234c82c8
[   88.485285] R10: ffff88811a641647 R11: ffff88811a635e30 R12: 0000000000000000
[   88.485287] R13: 1ffffffff4839048 R14: 0000000000000000 R15: 000000000000003d
[   88.485290] FS:  0000000000000000(0000) GS:ffff88811a600000(0000) knlGS:0000000000000000
[   88.485292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.485294] CR2: 000055e8c586c300 CR3: 0000000106eb0000 CR4: 00000000000006f0
[   88.485299] Call Trace:
[   88.485301]  <TASK>
[   88.485306] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460)
[   88.485313] ? exc_general_protection (arch/x86/kernel/traps.c:751 arch/x86/kernel/traps.c:693)
[   88.485319] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:617)
[   88.485324] ? next_zone (mm/mmzone.c:20 mm/mmzone.c:37)
[   88.485336] ? calc_load_nohz_start (kernel/sched/loadavg.c:251 (discriminator 2))
[   88.485341] need_update (mm/vmstat.c:2032 (discriminator 2))
[   88.485366] quiet_vmstat (mm/vmstat.c:2065 (discriminator 2))
[   88.485369] tick_nohz_stop_tick (./include/linux/hrtimer.h:135 kernel/time/tick-sched.c:1044)
[   88.485373] ? __pfx_tick_nohz_stop_tick (kernel/time/tick-sched.c:970)
[   88.485376] ? tick_nohz_next_event (kernel/time/tick-sched.c:952 (discriminator 2))
[   88.485379] ? __pfx_tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:51)
[   88.485396] tick_nohz_idle_stop_tick (kernel/time/tick-sched.c:1229)
[   88.485399] do_idle (kernel/sched/idle.c:185 kernel/sched/idle.c:325)
[   88.485403] ? __pfx_do_idle (kernel/sched/idle.c:253)
[   88.485406] cpu_startup_entry (kernel/sched/idle.c:422)
[   88.485409] rest_init (init/main.c:720)
[   88.485413] ? acpi_subsystem_init (drivers/acpi/bus.c:1314)
[   88.485417] start_kernel (init/main.c:1000)
[   88.485422] x86_64_start_reservations (arch/x86/kernel/head64.c:495)
[   88.485426] x86_64_start_kernel (??:?)
[   88.485432] common_startup_64 (arch/x86/kernel/head_64.S:415)
[   88.485437]  </TASK>
[   88.485439] Modules linked in: cfg80211 8021q garp stp mrp llc ppdev evdev input_leds intel_agp e1000 mac_hid intel_gtt pcspkr i2c_piix4 agpgart i2c_smbus parport_pc parport tiny_power_button button rfkill vhost_vsock vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost_iotlb tap vfio_iommu_type1 vfio iommufd uhid hid dm_mod uinput userio ppp_generic slhc tun loop cuse fuse ext4 crc32c_generic crc16 mbcache jbd2 bochs drm_client_lib drm_shmem_helper sd_mod drm_kms_helper ata_generic pata_acpi ata_piix libata drm scsi_mod serio_raw scsi_common qemu_fw_cfg
```

I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
running Void Linux, with the following commands:

```
# kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
# reboot
# printf reboot >/sys/power/disk
# printf disk >/sys/power/state
```

If kexec is not used, hibernation works fine.

This started happening since the 6.8 series; 6.7 works fine.
I performed a bisection and it pointed to
18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()").

#regzbot introduced: 18d565ea95fe553f442c5bbc5050415bab3c3fa4

I will send the kernel config and dmesg in replies to this email.


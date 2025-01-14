Return-Path: <linux-pm+bounces-20396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C7A0FFA7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 04:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34207A14CC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66494231C9F;
	Tue, 14 Jan 2025 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWixnnKK"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE838230984
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826181; cv=none; b=b5sfZ41I91g2gkKrFCw0beR5krSjZghKqlFe4WmSinhHcR24ABaWkDM2OgfXEBrdcYdgmldy5sgGkRlVYwYV3FijmCX++maX0ifUQznjtbEoiI7vGtZAXPkgmNLxkHA4Ew5SaYJMUOJdIuoE0HAAWtVKN9NP3cd4Ah74OzWGwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826181; c=relaxed/simple;
	bh=n/NVH8+N6yzwcIDq9FPXWJ28s+DN3p2T232gdhB9LEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei2SVX6E9pwXtePXTvo2byNUw38FBmnEggZLHQtHqzRfgB29+KE3rhSYWNyY+z4SIuVIIcobophEpRQBR2cwczDgXq9qgmZjgxoxu/r3DC3d/r6PfM8EeZUrimb8dIQutbAsv7Nfq5Sblpq2AZroWqPCXZTck3b37uYWOAJG3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWixnnKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736826178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GSW4oy9jnxLr2pA/3ti78V9yiawCQ3o1yEEVBM2/WTQ=;
	b=TWixnnKK2n2nGjHBZ9/8vqGqOCel8tBt1Mzm3bu2Ec8RplzgBsM8qelfU9dgnoqcsWy6aW
	ZgZefTQrpRGX9r6pdDIDj/w5u9M0uWhxkWZN0nAfkiWZGfQjwo7kafIFVGIQm8lyhEuO7Y
	qrIACDdhSn0wCdxyYtsex396ImPbxNs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-1t_4m890NjelwhNyI0K33w-1; Mon,
 13 Jan 2025 22:42:55 -0500
X-MC-Unique: 1t_4m890NjelwhNyI0K33w-1
X-Mimecast-MFC-AGG-ID: 1t_4m890NjelwhNyI0K33w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5789519560AA;
	Tue, 14 Jan 2025 03:42:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C10A19560AD;
	Tue, 14 Jan 2025 03:42:49 +0000 (UTC)
Date: Tue, 14 Jan 2025 11:42:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4XdNTRTyKB+J175@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4WGSMdF6seQm9GV@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4WGSMdF6seQm9GV@desktop0a>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/13/25 at 10:31pm, Roberto Ricci wrote:
...... 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
>    4:	84 c0                	test   %al,%al
>    6:	74 08                	je     0x10
>    8:	3c 03                	cmp    $0x3,%al
>    a:	0f 8e 9d 00 00 00    	jle    0xad
>   10:	8b 8b 00 4a 00 00    	mov    0x4a00(%rbx),%ecx
> [   88.485275] RSP: 0018:ffffffffa4807ce8 EFLAGS: 00010002
> [   88.485279] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11027fff565
> [   88.485281] RDX: 0000000000000940 RSI: ffffffffa3a89b80 RDI: 0000000000004a00
> [   88.485283] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed10234c82c8
> [   88.485285] R10: ffff88811a641647 R11: ffff88811a635e30 R12: 0000000000000000
> [   88.485287] R13: 1ffffffff4839048 R14: 0000000000000000 R15: 000000000000003d
> [   88.485290] FS:  0000000000000000(0000) GS:ffff88811a600000(0000) knlGS:0000000000000000
> [   88.485292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   88.485294] CR2: 000055e8c586c300 CR3: 0000000106eb0000 CR4: 00000000000006f0
> [   88.485299] Call Trace:
> [   88.485301]  <TASK>
> [   88.485306] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460)
> [   88.485313] ? exc_general_protection (arch/x86/kernel/traps.c:751 arch/x86/kernel/traps.c:693)
> [   88.485319] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:617)
> [   88.485324] ? next_zone (mm/mmzone.c:20 mm/mmzone.c:37)
> [   88.485336] ? calc_load_nohz_start (kernel/sched/loadavg.c:251 (discriminator 2))
> [   88.485341] need_update (mm/vmstat.c:2032 (discriminator 2))
> [   88.485366] quiet_vmstat (mm/vmstat.c:2065 (discriminator 2))
> [   88.485369] tick_nohz_stop_tick (./include/linux/hrtimer.h:135 kernel/time/tick-sched.c:1044)
> [   88.485373] ? __pfx_tick_nohz_stop_tick (kernel/time/tick-sched.c:970)
> [   88.485376] ? tick_nohz_next_event (kernel/time/tick-sched.c:952 (discriminator 2))
> [   88.485379] ? __pfx_tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:51)
> [   88.485396] tick_nohz_idle_stop_tick (kernel/time/tick-sched.c:1229)

It's weird, how come the change in kexec will impact this tick-sched
code. I will try to reproduce and investigate today.

> [   88.485399] do_idle (kernel/sched/idle.c:185 kernel/sched/idle.c:325)
> [   88.485403] ? __pfx_do_idle (kernel/sched/idle.c:253)
> [   88.485406] cpu_startup_entry (kernel/sched/idle.c:422)
> [   88.485409] rest_init (init/main.c:720)
> [   88.485413] ? acpi_subsystem_init (drivers/acpi/bus.c:1314)
> [   88.485417] start_kernel (init/main.c:1000)
> [   88.485422] x86_64_start_reservations (arch/x86/kernel/head64.c:495)
> [   88.485426] x86_64_start_kernel (??:?)
> [   88.485432] common_startup_64 (arch/x86/kernel/head_64.S:415)
> [   88.485437]  </TASK>
> [   88.485439] Modules linked in: cfg80211 8021q garp stp mrp llc ppdev evdev input_leds intel_agp e1000 mac_hid intel_gtt pcspkr i2c_piix4 agpgart i2c_smbus parport_pc parport tiny_power_button button rfkill vhost_vsock vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost_iotlb tap vfio_iommu_type1 vfio iommufd uhid hid dm_mod uinput userio ppp_generic slhc tun loop cuse fuse ext4 crc32c_generic crc16 mbcache jbd2 bochs drm_client_lib drm_shmem_helper sd_mod drm_kms_helper ata_generic pata_acpi ata_piix libata drm scsi_mod serio_raw scsi_common qemu_fw_cfg
> 



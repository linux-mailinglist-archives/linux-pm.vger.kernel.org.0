Return-Path: <linux-pm+bounces-40358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99579CFD42A
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 11:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB0CD300CF0E
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9F322B71;
	Wed,  7 Jan 2026 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i/z5UE9Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E0C13B;
	Wed,  7 Jan 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783044; cv=none; b=cEQ49po69wms6Cwl7c7VUiws1i2BD2uzp71NANnxUYL1xsydw+2Vr6IUsMzk+//1d07AbLWFSBXs4ptfkuj2ZEzLGmp3AOcBfE2aTC0cGBaEwcqJOtdXxWj627p7Q/DCJm4+6vRAMPlrzLB/+N0IK9RC7dxUWwu/m3l2TH42dbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783044; c=relaxed/simple;
	bh=OOEM2V7wmBUmKVTf01wtGZkc6rmxQefZn7h4q+ROt8g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=sqKB0KDxYd4ia9Ih7Qr6vLxrs7riKkpO0C8AHpgPib8rqB/NlXKhhWhbJp39gcjDgHVSUOjXjTJXFy/nMcd7GpoePpnwjWZdEHB+yTLLSD82D1pOpiElu4afGFe77SSdK6JMqBv5bL05OSDV+sOpGiHkbBj35AZW1p3HztSJu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i/z5UE9Y; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DAB28C1EC8A;
	Wed,  7 Jan 2026 10:50:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D0289606F8;
	Wed,  7 Jan 2026 10:50:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA1F4103C8685;
	Wed,  7 Jan 2026 11:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767783035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GA/hu2RLtmCfSA+ycqCvVPt72H5xnCs3qPPLfl8kPqM=;
	b=i/z5UE9YECDQqMK7d5an++SeTsCHx3gjfks4pomP/GxKN/tPNpOjhvRgnfa/EW35WPie3P
	hJqNuIOiREFI9fTYnDY4XVSO48rsGN9H/qsF83ONpserb6SgyyUaDsvsdwjNxv8/7Vp6xM
	zZsAUgeLh+aypgccu+LxtRjKUR7RsK1Sf94MZHIqYIwdhp3WuRY6ULtXkPgcB3LbUWPD35
	qbKPpsoal32oywF601Kmbo4+/bxnVUSaQFUCux/tGgXfhtlmgzrk/M25wLSYAq08tJ54+b
	qLuyBsSWWUDBDj5ieJt/hVi6ZTz7fdppdesod5o3QWN0I/Zzm9udxZtB9x/Y/Q==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Jan 2026 11:50:28 +0100
Message-Id: <DFIAS83MXT6G.VF4EDD56MNOR@bootlin.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Len Brown" <len.brown@intel.com>, "Michael
 Turquette" <mturquette@baylibre.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Pavel Machek" <pavel@ucw.cz>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>, "Chen-Yu Tsai"
 <wenst@chromium.org>, "Lucas Stach" <l.stach@pengutronix.de>, "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>, "Marek Vasut"
 <marex@denx.de>, "Ulf Hansson" <ulf.hansson@linaro.org>, "Kevin Hilman"
 <khilman@kernel.org>, "Fabio Estevam" <festevam@denx.de>, "Jacky Bai"
 <ping.bai@nxp.com>, "Peng Fan" <peng.fan@nxp.com>, "Shawn Guo"
 <shawnguo@kernel.org>, "Shengjiu Wang" <shengjiu.wang@nxp.com>,
 <linux-imx@nxp.com>, "Ian Ray" <ian.ray@gehealthcare.com>,
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, "Saravana Kannan"
 <saravanak@google.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Stephen Boyd"
 <sboyd@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH RFC 00/10] Fix the ABBA locking situation between clk
 and runtime PM
X-Mailer: aerc 0.20.1
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
 <8dfe4bfff1256c1ceffeab81cd587d0d@kernel.org>
 <20251003182407.70d495ba@booty>
In-Reply-To: <20251003182407.70d495ba@booty>
X-Last-TLS-Session-Version: TLSv1.3

Hello Stephen, all,

On Fri Oct 3, 2025 at 6:24 PM CEST, Luca Ceresoli wrote:
> Hello Stephen, all,
>
> On Mon, 14 Apr 2025 18:00:15 -0700
> Stephen Boyd <sboyd@kernel.org> wrote:
>
>> Quoting Miquel Raynal (2025-03-26 11:26:15)
>> > As explained in the following thread, there is a known ABBA locking
>> > dependency between clk and runtime PM.
>> > Link: https://lore.kernel.org/linux-clk/20240527181928.4fc6b5f0@xps-13=
/
>> >
>> > The problem is that the clk subsystem uses a mutex to protect concurre=
nt
>> > accesses to its tree structure, and so do other subsystems such as
>> > generic power domains. While it holds its own mutex, the clk subsystem
>> > performs runtime PM calls which end up executing callbacks from other
>> > subsystems (again, gen PD is in the loop). But typically power domains
>> > may also need to perform clock related operations, and thus the
>> > following two situations may happen:
>> >
>> > mutex_lock(clk);
>> > mutex_lock(genpd);
>> >
>> > or
>> >
>> > mutex_lock(genpd);
>> > mutex_lock(clk);
>> >
>> > As of today I know that at least NXP i.MX8MP and MediaTek MT8183 SoCs
>> > are complex enough to face this kind of issues.
>> >
>> > There's been a first workaround to "silence" lockdep with the most
>> > obvious case triggering the warning: making sure all clocks are RPM
>> > enabled before running the clk_disable_unused() work, but this is just
>> > addressing one situation among many other potentially problematic
>> > situations. In the past, both Laurent Pinchart and Marek Vasut have
>> > experienced these issues when enabling HDMI and audio support,
>> > respectively.
>> >
>> > Following a discussion we had at last Plumbers with Steven, I am
>> > proposing to decouple both locks by changing a bit the clk approach:
>> > let's always runtime resume all clocks that we *might* need before
>> > taking the clock lock. But how do we know the list? Well, depending on
>> > the situation we may either need to wake up:
>> > - the upper part of the tree during prepare/unprepare operations.
>> > - the lower part of the tree during (read) rate operations.
>> > - the upper part and the lower part of the tree otherwise (especially
>> >   during rate changes which may involve reparenting).
>>
>> Thanks for taking on this work. This problem is coming up more and more
>> often.
>
> Reviving this thread after today I had a very rare occurrence of
> apparently this same issue:
>
>   WARNING: possible circular locking dependency detected

I just had another occurrence, this time on 6.19-rc4:

[    0.000000][    T0] Booting Linux on physical CPU 0x0000000000 [0x410fd0=
34]
[    0.000000][    T0] Linux version 6.19.0-rc4+ (murray@booty) (aarch64-li=
nux-gcc.br_real (Buildroot 2021.11-12449-g1bef613319) 13.3.0, GNU ld (GNU B=
inutils) 2.41) #1 SMP PREEMPT Wed Jan  7 11:20:58 CET 2026

[    0.000912][    T0] Lock dependency validator: Copyright (c) 2006 Red Ha=
t, Inc., Ingo Molnar
[    0.000917][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000922][    T0] ... MAX_LOCK_DEPTH:          48
[    0.000926][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    0.000931][    T0] ... CLASSHASH_SIZE:          4096
[    0.000935][    T0] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000939][    T0] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000944][    T0] ... CHAINHASH_SIZE:          32768
[    0.000948][    T0]  memory used by lock dependency info: 6429 kB
[    0.000952][    T0]  memory used for stack traces: 4224 kB
[    0.000956][    T0]  per task-struct memory footprint: 1920 bytes

[    5.034910][   T78] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    5.041795][   T78] WARNING: possible circular locking dependency detect=
ed
[    5.048677][   T78] 6.19.0-rc4+ #1 Not tainted
[    5.053131][   T78] ----------------------------------------------------=
--
[    5.060010][   T78] kworker/u16:7/78 is trying to acquire lock:
[    5.065936][   T78] ffff800081976c50 (prepare_lock){+.+.}-{4:4}, at: clk=
_prepare_lock+0x58/0xc0
[    5.074671][   T78]
[    5.074671][   T78] but task is already holding lock:
[    5.081895][   T78] ffff000001aab740 (&genpd->mlock){+.+.}-{4:4}, at: ge=
npd_lock_mtx+0x20/0x38
[    5.090534][   T78]
[    5.090534][   T78] which lock already depends on the new lock.
[    5.090534][   T78]
[    5.100796][   T78]
[    5.100796][   T78] the existing dependency chain (in reverse order) is:
[    5.109671][   T78]
[    5.109671][   T78] -> #1 (&genpd->mlock){+.+.}-{4:4}:
[    5.116995][   T78]        __mutex_lock+0xa8/0x830
[    5.121794][   T78]        mutex_lock_nested+0x2c/0x40
[    5.126939][   T78]        genpd_lock_mtx+0x20/0x38
[    5.131824][   T78]        genpd_runtime_resume+0x118/0x298
[    5.137404][   T78]        __rpm_callback+0x50/0x200
[    5.142380][   T78]        rpm_callback+0x7c/0x90
[    5.147089][   T78]        rpm_resume+0x53c/0x720
[    5.151801][   T78]        __pm_runtime_resume+0x58/0xa8
[    5.157120][   T78]        clk_pm_runtime_get.part.0.isra.0+0x24/0x98
[    5.163570][   T78]        __clk_register+0x574/0x9c8
[    5.168631][   T78]        devm_clk_hw_register+0x64/0xe8
[    5.174036][   T78]        imx8mp_hsio_blk_ctrl_probe+0xa0/0xf8
[    5.179964][   T78]        imx8mp_blk_ctrl_probe+0x358/0x568
[    5.185633][   T78]        platform_probe+0x64/0xa8
[    5.190520][   T78]        really_probe+0xc4/0x2b8
[    5.195319][   T78]        __driver_probe_device+0x80/0x140
[    5.200899][   T78]        driver_probe_device+0xe0/0x170
[    5.206305][   T78]        __device_attach_driver+0xc0/0x148
[    5.211972][   T78]        bus_for_each_drv+0x90/0xf8
[    5.217030][   T78]        __device_attach+0xa8/0x1a0
[    5.222089][   T78]        device_initial_probe+0x58/0x68
[    5.227496][   T78]        bus_probe_device+0x40/0xb8
[    5.232554][   T78]        deferred_probe_work_func+0x90/0xd8
[    5.238306][   T78]        process_one_work+0x214/0x608
[    5.243542][   T78]        worker_thread+0x1b4/0x368
[    5.248513][   T78]        kthread+0x14c/0x230
[    5.252966][   T78]        ret_from_fork+0x10/0x20
[    5.257765][   T78]
[    5.257765][   T78] -> #0 (prepare_lock){+.+.}-{4:4}:
[    5.265002][   T78]        __lock_acquire+0x132c/0x1f48
[    5.270236][   T78]        lock_acquire+0x1c4/0x338
[    5.275120][   T78]        __mutex_lock+0xa8/0x830
[    5.279918][   T78]        mutex_lock_nested+0x2c/0x40
[    5.285062][   T78]        clk_prepare_lock+0x58/0xc0
[    5.290121][   T78]        clk_prepare+0x28/0x58
[    5.294747][   T78]        clk_bulk_prepare+0x54/0xe8
[    5.299804][   T78]        imx_pgc_power_up+0x7c/0x348
[    5.304950][   T78]        _genpd_power_on+0xa0/0x168
[    5.310010][   T78]        genpd_power_on+0xd8/0x248
[    5.314978][   T78]        genpd_runtime_resume+0x12c/0x298
[    5.320557][   T78]        __rpm_callback+0x50/0x200
[    5.325528][   T78]        rpm_callback+0x7c/0x90
[    5.330239][   T78]        rpm_resume+0x53c/0x720
[    5.334951][   T78]        __pm_runtime_resume+0x58/0xa8
[    5.340270][   T78]        imx8mp_blk_ctrl_power_on+0x3c/0x260
[    5.346111][   T78]        _genpd_power_on+0xa0/0x168
[    5.351171][   T78]        genpd_power_on+0xd8/0x248
[    5.356139][   T78]        genpd_runtime_resume+0x12c/0x298
[    5.361718][   T78]        __rpm_callback+0x50/0x200
[    5.366687][   T78]        rpm_callback+0x7c/0x90
[    5.371399][   T78]        rpm_resume+0x53c/0x720
[    5.376110][   T78]        __pm_runtime_resume+0x58/0xa8
[    5.381430][   T78]        pm_runtime_get_suppliers+0x6c/0xa0
[    5.387185][   T78]        __driver_probe_device+0x50/0x140
[    5.392765][   T78]        driver_probe_device+0xe0/0x170
[    5.398171][   T78]        __device_attach_driver+0xc0/0x148
[    5.403838][   T78]        bus_for_each_drv+0x90/0xf8
[    5.408896][   T78]        __device_attach+0xa8/0x1a0
[    5.413955][   T78]        device_initial_probe+0x58/0x68
[    5.419361][   T78]        bus_probe_device+0x40/0xb8
[    5.424419][   T78]        deferred_probe_work_func+0x90/0xd8
[    5.430172][   T78]        process_one_work+0x214/0x608
[    5.435406][   T78]        worker_thread+0x1b4/0x368
[    5.440380][   T78]        kthread+0x14c/0x230
[    5.444829][   T78]        ret_from_fork+0x10/0x20
[    5.449627][   T78]
[    5.449627][   T78] other info that might help us debug this:
[    5.449627][   T78]
[    5.459716][   T78]  Possible unsafe locking scenario:
[    5.459716][   T78]
[    5.467024][   T78]        CPU0                    CPU1
[    5.472250][   T78]        ----                    ----
[    5.477478][   T78]   lock(&genpd->mlock);
[    5.481582][   T78]                                lock(prepare_lock);
[    5.488117][   T78]                                lock(&genpd->mlock);
[    5.494740][   T78]   lock(prepare_lock);
[    5.498755][   T78]
[    5.498755][   T78]  *** DEADLOCK ***
[    5.498755][   T78]
[    5.506761][   T78] 6 locks held by kworker/u16:7/78:
[    5.511816][   T78]  #0: ffff00000001cd48 ((wq_completion)events_unbound=
#2){+.+.}-{0:0}, at: process_one_work+0x198/0x608
[    5.522802][   T78]  #1: ffff800082c8bd80 (deferred_probe_work){+.+.}-{0=
:0}, at: process_one_work+0x1c0/0x608
[    5.532746][   T78]  #2: ffff000000c320f8 (&dev->mutex){....}-{4:4}, at:=
 __device_attach+0x44/0x1a0
[    5.541819][   T78]  #3: ffff80008199b220 (device_links_srcu){.+.+}-{0:0=
}, at: device_links_read_lock+0x8/0x80
[    5.551846][   T78]  #4: ffff000006fb87c0 (&blk_ctrl_genpd_lock_class){+=
.+.}-{4:4}, at: genpd_lock_mtx+0x20/0x38
[    5.562048][   T78]  #5: ffff000001aab740 (&genpd->mlock){+.+.}-{4:4}, a=
t: genpd_lock_mtx+0x20/0x38
[    5.571120][   T78]
[    5.571120][   T78] stack backtrace:
[    5.576872][   T78] CPU: 1 UID: 0 PID: 78 Comm: kworker/u16:7 Not tainte=
d 6.19.0-rc4+ #1 PREEMPT
[    5.585751][   T78] Hardware name: GE HealthCare Supernova Patient Hub v=
1 (DT)
[    5.592977][   T78] Workqueue: events_unbound deferred_probe_work_func
[    5.599516][   T78] Call trace:
[    5.602661][   T78]  show_stack+0x20/0x38 (C)
[    5.607026][   T78]  dump_stack_lvl+0x8c/0xd0
[    5.611392][   T78]  dump_stack+0x18/0x28
[    5.615410][   T78]  print_circular_bug+0x28c/0x370
[    5.620298][   T78]  check_noncircular+0x170/0x188
[    5.625099][   T78]  __lock_acquire+0x132c/0x1f48
[    5.629818][   T78]  lock_acquire+0x1c4/0x338
[    5.634185][   T78]  __mutex_lock+0xa8/0x830
[    5.638463][   T78]  mutex_lock_nested+0x2c/0x40
[    5.643089][   T78]  clk_prepare_lock+0x58/0xc0
[    5.647628][   T78]  clk_prepare+0x28/0x58
[    5.651735][   T78]  clk_bulk_prepare+0x54/0xe8
[    5.656274][   T78]  imx_pgc_power_up+0x7c/0x348
[    5.660901][   T78]  _genpd_power_on+0xa0/0x168
[    5.665445][   T78]  genpd_power_on+0xd8/0x248
[    5.669896][   T78]  genpd_runtime_resume+0x12c/0x298
[    5.674953][   T78]  __rpm_callback+0x50/0x200
[    5.679405][   T78]  rpm_callback+0x7c/0x90
[    5.683597][   T78]  rpm_resume+0x53c/0x720
[    5.687791][   T78]  __pm_runtime_resume+0x58/0xa8
[    5.692591][   T78]  imx8mp_blk_ctrl_power_on+0x3c/0x260
[    5.697910][   T78]  _genpd_power_on+0xa0/0x168
[    5.702453][   T78]  genpd_power_on+0xd8/0x248
[    5.706902][   T78]  genpd_runtime_resume+0x12c/0x298
[    5.711961][   T78]  __rpm_callback+0x50/0x200
[    5.716414][   T78]  rpm_callback+0x7c/0x90
[    5.720608][   T78]  rpm_resume+0x53c/0x720
[    5.724803][   T78]  __pm_runtime_resume+0x58/0xa8
[    5.729605][   T78]  pm_runtime_get_suppliers+0x6c/0xa0
[    5.734840][   T78]  __driver_probe_device+0x50/0x140
[    5.739903][   T78]  driver_probe_device+0xe0/0x170
[    5.744790][   T78]  __device_attach_driver+0xc0/0x148
[    5.749937][   T78]  bus_for_each_drv+0x90/0xf8
[    5.754478][   T78]  __device_attach+0xa8/0x1a0
[    5.759019][   T78]  device_initial_probe+0x58/0x68
[    5.763908][   T78]  bus_probe_device+0x40/0xb8
[    5.768447][   T78]  deferred_probe_work_func+0x90/0xd8
[    5.773683][   T78]  process_one_work+0x214/0x608
[    5.778398][   T78]  worker_thread+0x1b4/0x368
[    5.782854][   T78]  kthread+0x14c/0x230
[    5.786786][   T78]  ret_from_fork+0x10/0x20

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


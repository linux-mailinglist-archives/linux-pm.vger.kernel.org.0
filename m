Return-Path: <linux-pm+bounces-35693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD65BB786F
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8961319C6C7F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933DB28DB56;
	Fri,  3 Oct 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ApTwfYwE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B010F1;
	Fri,  3 Oct 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508679; cv=none; b=BYgYhBi472HdG8f1OVvxz7rkKLa4eiiDXVTXK+8nN6ZQoRxa2ObcGujWr0zizBEg14ADhed3iVQ+IbUEogO7lCBYERpVK6AxShc4c1A3JGyjO6X4W4TV63QrIgmGkNtCLMlszSJLyttJ2hOcMZZ8zz7QEqFeSed+7ztG4ESnkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508679; c=relaxed/simple;
	bh=jIZXaNmpWWgvHIyai6q9Q0BZbid+uvba2yGiZcC870w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlH400VQBDiDzbclXMA/6YMoyb2W9u1+VgMzw7rEwaW0EzYtHGH9KCrtzA3jmkrBOe7WT9WiZ2vEim2EqyTFvkDsBUHe4VTnQAyfsRUhyOXwvd7ZBW+QMXGzustMtJOV1mOe3vDokqlxaKyPl5p3mrNTTS7JhQwka1B3j4iLyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ApTwfYwE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 602391A10E2;
	Fri,  3 Oct 2025 16:24:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F7F760683;
	Fri,  3 Oct 2025 16:24:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC7A5102F17C4;
	Fri,  3 Oct 2025 18:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759508672; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t0z9rVA4Bbaos+lPei5By5DvA81uXIdhctj/bYBzd24=;
	b=ApTwfYwEfaylNn54JPgvW3lrfSWISYTRMm+0gPREryEtunc05b67wXCWNUTJ4GjZHxI6DL
	VZ1nCYtwEp8D4uh3IZrzyGCOt+EOS1vTEoLyr38s8ocVwjfdwsg0D0ePuHErFC6JdXEOqi
	zYS5XXDJ0iFCHpWW++Q3gyo0MjIuN+J5e8G8wVYnRJ7dHxpLVLGCD9Y4JjYe06ce4UqJDz
	zwYukeMnKeuzyiVb8DN9i85blpXYUt7OwUVqqaaE3pljuuiWnG3bkzb3Ps37cIm0EjZksz
	rugDUCPiwDrS/8NkcHotHt05sjbOmMq1VGnGqmEVYMKlJSmBH1qpTAmQ7Lo/qw==
Date: Fri, 3 Oct 2025 18:24:07 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Michael
 Turquette <mturquette@baylibre.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Chen-Yu Tsai
 <wenst@chromium.org>, Lucas Stach <l.stach@pengutronix.de>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Jacky Bai <ping.bai@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, linux-imx@nxp.com, Ian Ray
 <ian.ray@gehealthcare.com>, =?UTF-8?B?SGVydsOp?= Codina
 <herve.codina@bootlin.com>, Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH RFC 00/10] Fix the ABBA locking situation between clk
 and runtime PM
Message-ID: <20251003182407.70d495ba@booty>
In-Reply-To: <8dfe4bfff1256c1ceffeab81cd587d0d@kernel.org>
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
	<8dfe4bfff1256c1ceffeab81cd587d0d@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Stephen, all,

On Mon, 14 Apr 2025 18:00:15 -0700
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Miquel Raynal (2025-03-26 11:26:15)
> > As explained in the following thread, there is a known ABBA locking
> > dependency between clk and runtime PM.
> > Link: https://lore.kernel.org/linux-clk/20240527181928.4fc6b5f0@xps-13/
> > 
> > The problem is that the clk subsystem uses a mutex to protect concurrent
> > accesses to its tree structure, and so do other subsystems such as
> > generic power domains. While it holds its own mutex, the clk subsystem
> > performs runtime PM calls which end up executing callbacks from other
> > subsystems (again, gen PD is in the loop). But typically power domains
> > may also need to perform clock related operations, and thus the
> > following two situations may happen:
> > 
> > mutex_lock(clk);
> > mutex_lock(genpd);
> > 
> > or
> > 
> > mutex_lock(genpd);
> > mutex_lock(clk);
> > 
> > As of today I know that at least NXP i.MX8MP and MediaTek MT8183 SoCs
> > are complex enough to face this kind of issues.
> > 
> > There's been a first workaround to "silence" lockdep with the most
> > obvious case triggering the warning: making sure all clocks are RPM
> > enabled before running the clk_disable_unused() work, but this is just
> > addressing one situation among many other potentially problematic
> > situations. In the past, both Laurent Pinchart and Marek Vasut have
> > experienced these issues when enabling HDMI and audio support,
> > respectively.
> > 
> > Following a discussion we had at last Plumbers with Steven, I am
> > proposing to decouple both locks by changing a bit the clk approach:
> > let's always runtime resume all clocks that we *might* need before
> > taking the clock lock. But how do we know the list? Well, depending on
> > the situation we may either need to wake up:
> > - the upper part of the tree during prepare/unprepare operations.
> > - the lower part of the tree during (read) rate operations.
> > - the upper part and the lower part of the tree otherwise (especially
> >   during rate changes which may involve reparenting).  
> 
> Thanks for taking on this work. This problem is coming up more and more
> often.

Reviving this thread after today I had a very rare occurrence of
apparently this same issue:

  WARNING: possible circular locking dependency detected

It happened on imx8mp, on a board and with a setup that I'm using since
many months to do unrelated development (mostly DRM). It was a very rare
occurrence because I always have clk_ignore_unused in my kernel cmdline.

On my setup that warning appeared exactly once in thousands of boots
I've done in several months. Just rebooting without changing anything
and it didn't show up again.

Here's the full warning message:

[    5.077473] ======================================================
[    5.083658] WARNING: possible circular locking dependency detected
[    5.089845] 6.17.0-rc4+ #2 Tainted: G                T  
[    5.095164] ------------------------------------------------------
[    5.101346] kworker/u16:4/52 is trying to acquire lock:
[    5.106576] ffff0000016ae740 (&genpd->mlock){+.+.}-{4:4}, at: genpd_lock_mtx+0x20/0x38
[    5.114533] 
[    5.114533] but task is already holding lock:
[    5.120368] ffff800084eb5258 (prepare_lock){+.+.}-{4:4}, at: clk_prepare_lock+0x38/0xc0
[    5.128404] 
[    5.128404] which lock already depends on the new lock.
[    5.128404] 
[    5.136583] 
[    5.136583] the existing dependency chain (in reverse order) is:
[    5.144070] 
[    5.144070] -> #1 (prepare_lock){+.+.}-{4:4}:
[    5.149924]        __mutex_lock+0xb8/0x7f0
[    5.154034]        mutex_lock_nested+0x2c/0x40
[    5.158487]        clk_prepare_lock+0x58/0xc0
[    5.162849]        clk_prepare+0x28/0x58
[    5.166780]        clk_bulk_prepare+0x54/0xe8
[    5.171141]        imx_pgc_power_up+0x80/0x378
[    5.175592]        _genpd_power_on+0xa0/0x168
[    5.179955]        genpd_power_on+0xd8/0x248
[    5.184234]        genpd_runtime_resume+0x12c/0x298
[    5.189121]        __rpm_callback+0x50/0x200
[    5.193400]        rpm_callback+0x7c/0x90
[    5.197414]        rpm_resume+0x534/0x718
[    5.201432]        __pm_runtime_resume+0x58/0xa8
[    5.206056]        pm_runtime_get_suppliers+0x6c/0xa0
[    5.211117]        __driver_probe_device+0x50/0x140
[    5.216002]        driver_probe_device+0xe0/0x170
[    5.220710]        __driver_attach+0xa0/0x1c0
[    5.225074]        bus_for_each_dev+0x90/0xf8
[    5.229436]        driver_attach+0x2c/0x40
[    5.233538]        bus_add_driver+0xec/0x218
[    5.237816]        driver_register+0x64/0x138
[    5.242178]        __platform_driver_register+0x2c/0x40
[    5.247411]        hotplug_bridge_dynconn_get_modes+0x28/0x48 [hotplug_bridge]
[    5.254654]        do_one_initcall+0x84/0x358
[    5.259020]        do_init_module+0x60/0x268
[    5.263298]        load_module+0x1fc4/0x2108
[    5.267574]        init_module_from_file+0x90/0xe0
[    5.272372]        idempotent_init_module+0x1f8/0x300
[    5.277432]        __arm64_sys_finit_module+0x6c/0xb8
[    5.282491]        invoke_syscall+0x50/0x120
[    5.286771]        el0_svc_common.constprop.0+0x48/0xf0
[    5.292004]        do_el0_svc+0x24/0x38
[    5.295848]        el0_svc+0x4c/0x160
[    5.299519]        el0t_64_sync_handler+0xa0/0xe8
[    5.304229]        el0t_64_sync+0x198/0x1a0
[    5.308420] 
[    5.308420] -> #0 (&genpd->mlock){+.+.}-{4:4}:
[    5.314359]        __lock_acquire+0x1338/0x1f50
[    5.318897]        lock_acquire+0x1c4/0x350
[    5.323089]        __mutex_lock+0xb8/0x7f0
[    5.327194]        mutex_lock_nested+0x2c/0x40
[    5.331645]        genpd_lock_mtx+0x20/0x38
[    5.335834]        genpd_runtime_resume+0x118/0x298
[    5.340721]        __rpm_callback+0x50/0x200
[    5.344997]        rpm_callback+0x7c/0x90
[    5.349013]        rpm_resume+0x534/0x718
[    5.353029]        __pm_runtime_resume+0x58/0xa8
[    5.357653]        clk_pm_runtime_get.part.0.isra.0+0x24/0x98
[    5.363408]        __clk_register+0x51c/0x970
[    5.367771]        devm_clk_hw_register+0x64/0xe8
[    5.372481]        imx8mp_hsio_blk_ctrl_probe+0xa0/0xf8
[    5.377712]        imx8mp_blk_ctrl_probe+0x358/0x568
[    5.382684]        platform_probe+0x64/0xa8
[    5.386875]        really_probe+0xc4/0x2b8
[    5.390976]        __driver_probe_device+0x80/0x140
[    5.395860]        driver_probe_device+0xe0/0x170
[    5.400571]        __device_attach_driver+0xc0/0x148
[    5.405542]        bus_for_each_drv+0x9c/0x108
[    5.409991]        __device_attach+0xa8/0x1a0
[    5.414354]        device_initial_probe+0x1c/0x30
[    5.419065]        bus_probe_device+0xb4/0xc0
[    5.423428]        deferred_probe_work_func+0x90/0xd8
[    5.428485]        process_one_work+0x214/0x618
[    5.433027]        worker_thread+0x1b4/0x368
[    5.437305]        kthread+0x150/0x238
[    5.441062]        ret_from_fork+0x10/0x20
[    5.445165] 
[    5.445165] other info that might help us debug this:
[    5.445165] 
[    5.453171]  Possible unsafe locking scenario:
[    5.453171] 
[    5.459091]        CPU0                    CPU1
[    5.463622]        ----                    ----
[    5.468151]   lock(prepare_lock);
[    5.471476]                                lock(&genpd->mlock);
[    5.477405]                                lock(prepare_lock);
[    5.483248]   lock(&genpd->mlock);
[    5.486655] 
[    5.486655]  *** DEADLOCK ***
[    5.486655] 
[    5.492577] 4 locks held by kworker/u16:4/52:
[    5.496937]  #0: ffff000000030948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x198/0x618
[    5.507051]  #1: ffff800086e3bd70 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1c0/0x618
[    5.516299]  #2: ffff000000c608f8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x44/0x1a0
[    5.524680]  #3: ffff800084eb5258 (prepare_lock){+.+.}-{4:4}, at: clk_prepare_lock+0x38/0xc0
[    5.533150] 
[    5.533150] stack backtrace:
[    5.537512] CPU: 2 UID: 0 PID: 52 Comm: kworker/u16:4 Tainted: G                T   6.17.0-rc4+ #2 PREEMPT 
[    5.547262] Tainted: [T]=RANDSTRUCT
[    5.550752] Hardware name: ...
[    5.557284] Workqueue: events_unbound deferred_probe_work_func
[    5.563128] Call trace:
[    5.565578]  show_stack+0x20/0x38 (C)
[    5.569251]  dump_stack_lvl+0x8c/0xd0
[    5.572919]  dump_stack+0x18/0x28
[    5.576239]  print_circular_bug+0x28c/0x370
[    5.580431]  check_noncircular+0x178/0x190
[    5.584537]  __lock_acquire+0x1338/0x1f50
[    5.588558]  lock_acquire+0x1c4/0x350
[    5.592231]  __mutex_lock+0xb8/0x7f0
[    5.595815]  mutex_lock_nested+0x2c/0x40
[    5.599750]  genpd_lock_mtx+0x20/0x38
[    5.603418]  genpd_runtime_resume+0x118/0x298
[    5.607786]  __rpm_callback+0x50/0x200
[    5.611543]  rpm_callback+0x7c/0x90
[    5.615041]  rpm_resume+0x534/0x718
[    5.618539]  __pm_runtime_resume+0x58/0xa8
[    5.622644]  clk_pm_runtime_get.part.0.isra.0+0x24/0x98
[    5.627876]  __clk_register+0x51c/0x970
[    5.631717]  devm_clk_hw_register+0x64/0xe8
[    5.635909]  imx8mp_hsio_blk_ctrl_probe+0xa0/0xf8
[    5.640622]  imx8mp_blk_ctrl_probe+0x358/0x568
[    5.645071]  platform_probe+0x64/0xa8
[    5.648743]  really_probe+0xc4/0x2b8
[    5.652326]  __driver_probe_device+0x80/0x140
[    5.656693]  driver_probe_device+0xe0/0x170
[    5.660886]  __device_attach_driver+0xc0/0x148
[    5.665339]  bus_for_each_drv+0x9c/0x108
[    5.669269]  __device_attach+0xa8/0x1a0
[    5.673115]  device_initial_probe+0x1c/0x30
[    5.677308]  bus_probe_device+0xb4/0xc0
[    5.681152]  deferred_probe_work_func+0x90/0xd8
[    5.685691]  process_one_work+0x214/0x618
[    5.689713]  worker_thread+0x1b4/0x368
[    5.693471]  kthread+0x150/0x238
[    5.696709]  ret_from_fork+0x10/0x20

You're welcome to ask for more info, even though I'm afraid I might be
unable to provide them given how rare this event is.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


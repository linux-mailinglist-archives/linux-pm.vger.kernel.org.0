Return-Path: <linux-pm+bounces-40886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76006D21221
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F29D7300B379
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B54354AEB;
	Wed, 14 Jan 2026 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DSHzUkJA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC285352FB6
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421426; cv=none; b=Xz7lEA47QSZAxAQRCRQtVBz3tz/6JRGJdWZTqpqkv64IpvLevSBr0lKwr13BF99BgxyGFkMW1IbUa3gARaKnGgAudu5D5HApU0uGXkM4s31tgByOPqzb4Sdm2TTe5Tv/F+J+B6catckz1t7gE/pAf3SCwncSvcjgwX4XNge3cMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421426; c=relaxed/simple;
	bh=rqdSaDxJvIhD868na2QQi1x9fDimCPeEnrYFmEOGcHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbFHssBh6MdqkE8zgN39Q5YWobWcPxmCXs06zWF14cR0vARGBGwEVIbSNZmEqg6SUDB1JmUFm6+Fjk1F2RT792GnBZWCIygk0GesYzZ9uyDmZP9GeY+EaUZHLhtS3W51jUQMEPXAsrncpnuXo4DolNmeohzkkHNl3GodWUCkr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DSHzUkJA; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so579833eec.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 12:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768421423; x=1769026223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V1V5FWY2m8ktrGGsFfOltSsRWcRmuumQc8l2vYL2t90=;
        b=DSHzUkJAXSZv2Sf7ohkgGdi5aCuDLFMqEkIJhqDs8Em59mkeCit2Hjclbv90NMotds
         VACcYDyRsnw0jHapcagNZRJpUea/u0julLg/nOkmq8sK4AaGKPJyEAaCzAze2RIOEHAJ
         hvvOH32Z7ogpyG04BJcMFEmQvVqGuE6NtCxMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768421423; x=1769026223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1V5FWY2m8ktrGGsFfOltSsRWcRmuumQc8l2vYL2t90=;
        b=ar5omSc2zjDr9C983Vht4ZZjduhl4R240h72uMeKbuUyk4aQWD2NTW0UIeG21OV0ot
         AOncqnGt/08WDvGhUBfy2DJuj5ACougHnUI9NRfam5CTP9WmUL96kkwVVJdZR9RuPmVI
         8VqrNceRZzEzn2LhkmOkXA9CW9h1p55wmvI8LRQEQvEm1RUSHz16iEy7oamly2OHmk8E
         r8AORRH5D6uZH2pS293bZ7Q4SM/LZ+9uqO7KuAAknAzxy1+I2oTLbVfPEbakcI0sjuHn
         xloibq14fIdwfe/gXdKkOv9FoWtjbkj1VUY2b0VvETdgxIZcD/4AtCa2nKLpiNnycP2i
         gWbw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5cXZTZ62f4LTceelUokLLliqmyGtkjN2R9Ni2y/rBsvwtzP+Efr/oGVWexGyXuRlGJjzLNet/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RI6IM7l+XJi4nZydmUDQbZGctVWq7vQei/g7pOi1lORZaj7R
	rN67GkJyk1w2muL6pfr11e336yMMOpGPxO8dMFyt1Fd8FNL/3JbyVFcpysXXUolAwA==
X-Gm-Gg: AY/fxX7HU/M/ZN+29kp9pKPJl6HGy/7RnrE46Cxb5/FrxsbzkEeOGenEMbaXoaybVxp
	mHVFHY7pqvliUDL39GTm/oGbd+jJXbnrci2tLBofRJU4wW1Md1b2GYHX6P1/XcxiYjm0QQxYsRR
	1rb/fpBJoYvMZg64E3Z3wnLUixeg8RjPL1+TLFrCqrN4BEHM+ZGlPE9jurruZqCK/fUld38QMxH
	3EyvKjJJYPt3T7n8LtnF0Vr6pucc4/T/ynz5PG7R+GYwffiaBmU2wUTlZyzwrGA99fbFHctMsol
	RGNy2Lbb5lIqac6S/tvWkBhmVGC2DlhkdWPDhkleXxt60RR0lChQrp+rozjjRKao+KQ7LT5li4P
	1wQrKet/rTWKxe0w3NQLBZPb17Vte2/uDBZ65UJQRC14DHilwm9gEmi5Wt4EB78ozoO0ajAP1Y3
	prYDYg0RrLmf8XKEHMitw+hojFNPGiZU9JblBRefA+rP/TJzU7WA==
X-Received: by 2002:a05:7301:1901:b0:2b0:4902:c0a3 with SMTP id 5a478bee46e88-2b4870bcd18mr4343716eec.20.1768421422436;
        Wed, 14 Jan 2026 12:10:22 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ae4d:1d26:39a5:d7ab])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b170673266sm21009848eec.1.2026.01.14.12.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 12:10:21 -0800 (PST)
Date: Wed, 14 Jan 2026 12:10:19 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aWf4KyTSIocWTmXw@google.com>
References: <20260106222715.GA381397@bhelgaas>
 <CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
 <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>

Hi Marek,

On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
> On 06.01.2026 23:27, Bjorn Helgaas wrote:
> > On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> >> Today, it's possible for a PCI device to be created and
> >> runtime-suspended before it is fully initialized. When that happens, the
> >> device will remain in D0, but the suspend process may save an
> >> intermediate version of that device's state -- for example, without
> >> appropriate BAR configuration. When the device later resumes, we'll
> >> restore invalid PCI state and the device may not function.
> >>
> >> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> >> until we've fully initialized the device.
...

> This patch landed recently in linux-next as commit c796513dc54e 
> ("PCI/PM: Prevent runtime suspend until devices are fully initialized"). 
> In my tests I found that it sometimes causes the "pci 0000:01:00.0: 
> runtime PM trying to activate child device 0000:01:00.0 but parent 
> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board 
> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a 
> lockdep warning about console lock, but this is just a consequence of 
> the runtime pm warning. Reverting $subject patch on top of current 
> linux-next hides this warning.
> 
> Here is a kernel log:
> 
> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 
> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s 
> PCIe x1 link)
> pci 0000:01:00.0: Adding to iommu group 13
> pci 0000:01:00.0: ASPM: default states L0s L1
> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: assigned
> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
> pci 0000:01:00.0: runtime PM trying to activate child device 
> 0000:01:00.0 but parent (0000:00:00.0) is not active

Thanks for the report. I'll try to look at reproducing this, or at least
getting a better mental model of exactly why this might fail (or,
"warn") this way. But if you have the time and desire to try things out
for me, can you give v1 a try?

https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/

I'm pretty sure it would not invoke the same problem. I also suspect v3
might not, but I'm less sure:

https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/

> ======================================================
> WARNING: possible circular locking dependency detected
> 6.19.0-rc1+ #16398 Not tainted
> ------------------------------------------------------
> kworker/3:0/33 is trying to acquire lock:
> ffffcd182ff1ae98 (console_owner){..-.}-{0:0}, at: 
> console_lock_spinning_enable+0x44/0x78
> 
> but task is already holding lock:
> ffff0000835c5238 (&dev->power.lock/1){....}-{3:3}, at: 
> __pm_runtime_set_status+0x240/0x384
> 
> which lock already depends on the new lock.

The lockdep warning is a bit messier, and I'd also have to take some
more time to be sure, but in principle, this sounds like a totally
orthogonal problem. It seems like simply performing printk() to a qcom
UART in the "wrong" context is enough to cause this. If so, that's
definitely a console/UART bug (or maybe a lockdep false positive) and
not a PCI/runtime-PM bug.

> the existing dependency chain (in reverse order) is:
> 
> -> #3 (&dev->power.lock/1){....}-{3:3}:
>         _raw_spin_lock_nested+0x44/0x5c
>         __pm_runtime_set_status+0x240/0x384
>         arm_smmu_device_probe+0xbe0/0xe5c
>         platform_probe+0x5c/0xac
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0x40/0x164
>         __driver_attach+0x9c/0x1ac
>         bus_for_each_dev+0x74/0xd0
>         driver_attach+0x24/0x30
>         bus_add_driver+0xe4/0x208
>         driver_register+0x60/0x128
>         __platform_driver_register+0x24/0x30
>         arm_smmu_driver_init+0x20/0x2c
>         do_one_initcall+0x64/0x308
>         kernel_init_freeable+0x284/0x500
>         kernel_init+0x20/0x1d8
>         ret_from_fork+0x10/0x20
> 
> -> #2 (&dev->power.lock){-...}-{3:3}:
>         _raw_spin_lock_irqsave+0x60/0x88
>         __pm_runtime_resume+0x4c/0xbc
>         __uart_start+0x4c/0x114
>         uart_write+0x98/0x278
>         n_tty_write+0x1dc/0x4f0
>         file_tty_write.constprop.0+0x12c/0x2bc
>         redirected_tty_write+0xc0/0x108
>         do_iter_readv_writev+0xdc/0x1c0
>         vfs_writev+0xf0/0x280
>         do_writev+0x74/0x13c
>         __arm64_sys_writev+0x20/0x2c
>         invoke_syscall+0x48/0x10c
>         el0_svc_common.constprop.0+0x40/0xe8
>         do_el0_svc+0x20/0x2c
>         el0_svc+0x50/0x2e8
>         el0t_64_sync_handler+0xa0/0xe4
>         el0t_64_sync+0x198/0x19c
> 
> -> #1 (&port_lock_key){-.-.}-{3:3}:
>         _raw_spin_lock_irqsave+0x60/0x88
>         qcom_geni_serial_console_write+0x50/0x344
>         console_flush_one_record+0x33c/0x474
>         console_unlock+0x80/0x14c
>         vprintk_emit+0x258/0x3d0
>         vprintk_default+0x38/0x44
>         vprintk+0x28/0x34
>         _printk+0x5c/0x84
>         register_console+0x278/0x510
>         serial_core_register_port+0x6cc/0x79c
>         serial_ctrl_register_port+0x10/0x1c
>         uart_add_one_port+0x10/0x1c
>         qcom_geni_serial_probe+0x2c0/0x448
>         platform_probe+0x5c/0xac
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0x40/0x164
>         __device_attach_driver+0xb8/0x138
>         bus_for_each_drv+0x80/0xdc
>         __device_attach+0xa8/0x1b0
>         device_initial_probe+0x50/0x54
>         bus_probe_device+0x38/0xa8
>         device_add+0x540/0x720
>         of_device_add+0x44/0x60
>         of_platform_device_create_pdata+0x90/0x11c
>         of_platform_bus_create+0x17c/0x394
>         of_platform_populate+0x58/0xf8
>         devm_of_platform_populate+0x58/0xbc
>         geni_se_probe+0xdc/0x164
>         platform_probe+0x5c/0xac
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0x40/0x164
>         __device_attach_driver+0xb8/0x138
>         bus_for_each_drv+0x80/0xdc
>         __device_attach+0xa8/0x1b0
>         device_initial_probe+0x50/0x54
>         bus_probe_device+0x38/0xa8
>         deferred_probe_work_func+0x8c/0xc8
>         process_one_work+0x208/0x604
>         worker_thread+0x244/0x388
>         kthread+0x150/0x228
>         ret_from_fork+0x10/0x20
> 
> -> #0 (console_owner){..-.}-{0:0}:
>         __lock_acquire+0x1408/0x2254
>         lock_acquire+0x1c8/0x354
>         console_lock_spinning_enable+0x68/0x78
>         console_flush_one_record+0x300/0x474
>         console_unlock+0x80/0x14c
>         vprintk_emit+0x258/0x3d0
>         dev_vprintk_emit+0xd8/0x1a0
>         dev_printk_emit+0x58/0x80
>         __dev_printk+0x3c/0x88
>         _dev_err+0x60/0x88
>         __pm_runtime_set_status+0x28c/0x384
>         pci_bus_add_device+0xa4/0x18c
>         pci_bus_add_devices+0x3c/0x88
>         pci_bus_add_devices+0x68/0x88
>         pci_rescan_bus+0x30/0x44
>         rescan_work_func+0x28/0x3c
>         process_one_work+0x208/0x604
>         worker_thread+0x244/0x388
>         kthread+0x150/0x228
>         ret_from_fork+0x10/0x20
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    console_owner --> &dev->power.lock --> &dev->power.lock/1
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&dev->power.lock/1);
>                                 lock(&dev->power.lock);
> lock(&dev->power.lock/1);
>    lock(console_owner);
> 
>   *** DEADLOCK ***
> 
> 7 locks held by kworker/3:0/33:
>   #0: ffff00008000d948 ((wq_completion)events){+.+.}-{0:0}, at: 
> process_one_work+0x18c/0x604
>   #1: ffff8000802a3de0 ((work_completion)(&pwrctrl->work)){+.+.}-{0:0}, 
> at: process_one_work+0x1b4/0x604
>   #2: ffffcd18301138e8 (pci_rescan_remove_lock){+.+.}-{4:4}, at: 
> pci_lock_rescan_remove+0x1c/0x28
>   #3: ffff00008ac8a238 (&dev->power.lock){-...}-{3:3}, at: 
> __pm_runtime_set_status+0x1d4/0x384
>   #4: ffff0000835c5238 (&dev->power.lock/1){....}-{3:3}, at: 
> __pm_runtime_set_status+0x240/0x384
>   #5: ffffcd182ff1ac78 (console_lock){+.+.}-{0:0}, at: 
> dev_vprintk_emit+0xd8/0x1a0
>   #6: ffffcd182ff1acd8 (console_srcu){....}-{0:0}, at: 
> console_flush_one_record+0x0/0x474
> 
> stack backtrace:
> CPU: 3 UID: 0 PID: 33 Comm: kworker/3:0 Not tainted 6.19.0-rc1+ #16398 
> PREEMPT
> Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> Workqueue: events rescan_work_func
> Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0x90/0xd0
>   dump_stack+0x18/0x24
>   print_circular_bug+0x298/0x37c
>   check_noncircular+0x15c/0x170
>   __lock_acquire+0x1408/0x2254
>   lock_acquire+0x1c8/0x354
>   console_lock_spinning_enable+0x68/0x78
>   console_flush_one_record+0x300/0x474
>   console_unlock+0x80/0x14c
>   vprintk_emit+0x258/0x3d0
>   dev_vprintk_emit+0xd8/0x1a0
>   dev_printk_emit+0x58/0x80
>   __dev_printk+0x3c/0x88
>   _dev_err+0x60/0x88
>   __pm_runtime_set_status+0x28c/0x384
>   pci_bus_add_device+0xa4/0x18c
>   pci_bus_add_devices+0x3c/0x88
>   pci_bus_add_devices+0x68/0x88
>   pci_rescan_bus+0x30/0x44
>   rescan_work_func+0x28/0x3c
>   process_one_work+0x208/0x604
>   worker_thread+0x244/0x388
>   kthread+0x150/0x228
>   ret_from_fork+0x10/0x20
> 
> This looks a bit similar to the issue reported some time ago on a 
> different board:
> 
> https://lore.kernel.org/all/6d438995-4d6d-4a21-9ad2-8a0352482d44@samsung.com/

Huh, yeah, the lockdep warning is rather similar looking. So that bug
(whether real or false positive) may have been around a while.

And the "Enabling runtime PM for inactive device with active children"
log is similar, but it involves a different set of devices -- now we're
dealing with the PCIe port and child device, whereas that report was
about the host bridge/controller device.

Brian

> Let me know if I can somehow help debugging this.
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 


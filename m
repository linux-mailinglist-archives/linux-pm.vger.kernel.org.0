Return-Path: <linux-pm+bounces-23836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B729A5BEE2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 12:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DD51888879
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582E9253F3A;
	Tue, 11 Mar 2025 11:25:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804B1EBA09;
	Tue, 11 Mar 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692325; cv=none; b=vDVqxh99ijoKA4cv7JiE4ES90I+TvlfYfPbaZcgIh9mwLJHBj0nQxMu+kyHEgrYOpiypcB6tr44bxle7jqcaDbzUgdf3YDhkvr47+l+PNuDk3OGBubt2K7h/oVviyM22zbpvYsZHocDaY7nNeMKPmxe2ZJ2y8fLQvOl+LPbQDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692325; c=relaxed/simple;
	bh=mZMgvScT/F5/AVaa3dXW55dwFTsewaMaJFehCC1Ci0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHQS5/Q/0amFPPaFGaMD0IXbN9L64FvFkT++F+YJ6kxCT88Z1vuKXIrbiB3nPupYICACmF+v3aZ+R0nBL5xLSBxB1v7rH65VuFL+INQzPhYjbWUo2XZy4OHJZdfQrZCATcxHQDPGnoACRX+Gdh7GlR56ifd/sf5uZ40Mx0gnd/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86b9b1def28so4848018241.3;
        Tue, 11 Mar 2025 04:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741692320; x=1742297120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMRhXnvTN8Y1W6ZynZ2LEcKu5slyzFWT8bKSIuRbaWU=;
        b=V48xbEq6CSq626qhinG62iPkWruYJx44yIt3i+GFeeAulP9I+hs/f2C4O1vIsP2o0l
         OJ/00cgmxPpOZvXO273KazbQn41rJ16o0Mb59VnBQCmKastiGWN+m0eAncS9w+RJPjM6
         FuYB4NA1tPzZy9x1YCk1v6q3/wPwXX33o/X5GWbOnt8LBhiA6JmvFt/QJVKVus/ONlb1
         LhA/KSbRwdb4pSEN8Hi+4HZL58YJ8fBLwFDsMcCQnilRyNQLZtMxQh4Cc2iA4r7hWm3B
         gv8HinTqxasWBq+q+Cf5MyYC+jE+h36bYqX402cgzPbInnzTYBJlV8G+UKz7wg1SOWJw
         YBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpj+Jh1wcnouaDCHwO0vNf697m63mbo8D4NlmtEV1GntTxCjWtfgat5J32X2BqKS2w8uwbdHwlff+6ScM=@vger.kernel.org, AJvYcCX4VLU19eF+CTvR5t71Klev6oy+3YcxYIhcL99SmZwbib6k3Eg+IFgUqjCGIDUrRLQwA++kuLZGz78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYy8Njx4QS78iuZDKSZKq4eMhZvbJRL+xcf4yRo5utXJ+BwQ5
	LUq2nA43vWKMj2ohLOJEGr6nept/AcIe8M8DxWDhyIy4Qi5q9p6SHcty3imS
X-Gm-Gg: ASbGnctVph5WYfIDHwm0wbIq9E8rjbsqxvK1flZumwhkr7hG7edM8F1m68sQfqtxjo9
	LOUgcxzSZQFofHbBvmwsiXmynhhh0d2xbpkUSbAnqqBOQ68LnXE5ucS1I+pNnUVIF4zIZjJjI3/
	hgR+10Lxn4YMKjX6gfcRmTGXJyJlZrgahy+AeTkoDWrD6SAJIydJg9XBsOepmMG6RayFd8Up9MB
	3GBjX+g1uE58hkyPXVwBc+akcAfvbXDfc/OAq+/RC/ZbXpMFLjyPU7lUzhO8nu4n1lc570ZAG24
	Jwax9XnUUToY4JQwcSzFDGVoCxI17X6kygpOsLZ8RtHoakBRcEzzDsrupko6EUrorvBVOKmQMAb
	i+Ls1gVJr9Gc=
X-Google-Smtp-Source: AGHT+IFyebfh7zTsa2UgaJzfXd0Ed37rl9GDCCEM63vakNWcbCtsh+gtmp2d65CLJ6URC4Dabxx0Iw==
X-Received: by 2002:a05:6102:1614:b0:4bb:c8e5:aa6d with SMTP id ada2fe7eead31-4c34d31bbecmr2154533137.17.1741692320178;
        Tue, 11 Mar 2025 04:25:20 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fbcde6a7sm2289625137.28.2025.03.11.04.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 04:25:19 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523ffbe0dbcso2531832e0c.0;
        Tue, 11 Mar 2025 04:25:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkBwBbhFQWcRuL3BvzfYXYcpNxmAnka9zOOv2VH5OHtunG05EoKCvAHEJSHbaKLa25Trh9B4HHyTz0k3g=@vger.kernel.org, AJvYcCXQL3ovL2CfLxQ4QQN70xT9mrzC1B47aJuSnOJHQuDieizb2G553kzIFotkM9I8JhVosHlVDfx0IHg=@vger.kernel.org
X-Received: by 2002:a05:6102:4186:b0:4c3:881:1a8e with SMTP id
 ada2fe7eead31-4c34d340313mr2181452137.24.1741692319423; Tue, 11 Mar 2025
 04:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com> <20241114220921.2529905-5-saravanak@google.com>
In-Reply-To: <20241114220921.2529905-5-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2025 12:25:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWq9s3xn2eDebAfBj6ieLqwHhVhr0UuyQCtiBXz1eFnsw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo_QHQBYpAcxoS5Og2V2ORgfCZXfzx6vZG5SXk5i7_bBnXQ7K6tDcZPt7M
Message-ID: <CAMuHMdWq9s3xn2eDebAfBj6ieLqwHhVhr0UuyQCtiBXz1eFnsw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] PM: sleep: Do breadth first suspend/resume for
 async suspend/resume
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Marek Vasut <marex@denx.de>, Bird@google.com, 
	Tim <Tim.Bird@sony.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Saravana,

On Thu, 14 Nov 2024 at 23:09, Saravana Kannan <saravanak@google.com> wrote:
> The dpm_list used for suspend/resume ensures that all superior devices
> (parents and suppliers) precede subordinate devices (children and
> consumers).
>
> Current async resume logic:
> -------------------------------
> * For each resume phase (except the "complete" phase, which is always
>   serialized), the resume logic first queues all async devices in the
>   dpm_list. It then loops through the dpm_list again to resume the sync
>   devices one by one.
>
> * Async devices wait for all their superior devices to resume before
>   starting their own resume operation.
>
> * This process results in multiple sleep and wake-up cycles before an
>   async device actually resumes. This sleeping also causes kworker
>   threads to stall with work for a period. Consequently, the workqueue
>   framework spins up more kworker threads to handle the other async
>   devices.
>
> * The end result is excessive thread creation, wake-ups, sleeps, and
>   context switches for every async device. This overhead makes a full
>   async resume (with all devices marked as async-capable) much slower
>   than a synchronous resume.
>
> Current async suspend logic:
> --------------------------------
> * The async suspend logic differs from the async resume logic. The
>   suspend logic loops through the dpm_list. When it finds an async
>   device, it queues the work and moves on. However, if it encounters a
>   sync device, it waits until the sync device (and all its subordinate
>   devices) have suspended before proceeding to the next device.
>   Therefore, an async suspend device can be left waiting on an
>   unrelated device before even being queued.
>
> * Once queued, an async device experiences the same inefficiencies as
>   in the resume logic (thread creation, wake-ups, sleeps, and context
>   switches).
>
> On a Pixel 6, averaging over 100 suspend/resume cycles, the data is as
> follows:
>
> +---------------------------+-----------+------------+----------+
> | Phase                     | Full sync | Full async | % change |
> +---------------------------+-----------+------------+----------+
> | Total dpm_suspend*() time |    107 ms |      72 ms |     -33% |
> +---------------------------+-----------+------------+----------+
> | Total dpm_resume*() time  |     75 ms |      90 ms |     +20% |
> +---------------------------+-----------+------------+----------+
> | Sum                       |    182 ms |     162 ms |     -11% |
> +---------------------------+-----------+------------+----------+
>
> This shows that full async suspend/resume is not a viable option. It
> makes the user-visible resume phase slower and only improves the
> overall time by 11%.
>
> To fix all this, this patches introduces a new async suspend/resume
> logic.
>
> New suspend/resume logic:
> -------------------------
> * For each suspend/resume phase (except "complete" and "prepare,"
>   which are always serialized), the logic first queues only the async
>   devices that don't have to wait for any subordinates (for suspend)
>   or superiors (for resume). It then loops through the dpm_list again
>   to suspend/resume the sync devices one by one.
>
> * When a device (sync or async) successfully suspends/resumes, it
>   examines its superiors/subordinates and queues only the async
>   devices that don't need to wait for any subordinates/superiors.
>
> With this new logic:
>
> * Queued async devices don't have to wait for completion and are
>   always ready to perform their suspend/resume operation.
>
> * The queue of async devices remains short.
>
> * kworkers never sleep for extended periods, and the workqueue
>   framework doesn't spin up many new threads to handle a backlog of
>   async devices.
>
> * The result is approximately NCPU kworker threads running in parallel
>   without sleeping until all async devices finish.
>
> On a Pixel 6, averaging over 100 suspend/resume cycles, the new logic
> yields improved results:
> +---------------------------+-----------+------------+------------------+
> | Phase                     | Old full sync | New full async | % change |
> +---------------------------+-----------+------------+------------------+
> | Total dpm_suspend*() time |        107 ms |          60 ms |     -44% |
> +---------------------------+-----------+------------+------------------+
> | Total dpm_resume*() time  |         75 ms |          74 ms |      -1% |
> +---------------------------+-----------+------------+------------------+
> | Sum                       |        182 ms |         134 ms |     -26% |
> +---------------------------+-----------+------------+------------------+
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch!

On Renesas Gray Hawk Single (R-Car V4M) during s2idle:

PM: suspend entry (s2idle)
Filesystems sync: 0.055 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.004 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.003 seconds)

================================
WARNING: inconsistent lock state
6.14.0-rc5-rcar3-05904-g1ec95427acf9 #261 Tainted: G        W
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
s2idle/764 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffffff844392c190 (&dev->power.lock){?.-.}-{3:3}, at: dpm_async_fn+0x24/0xa8
{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0x26c/0x2c4
  _raw_spin_lock_irqsave+0x54/0x70
  pm_suspend_timer_fn+0x20/0x78
  __hrtimer_run_queues+0x204/0x330
  hrtimer_interrupt+0xa8/0x1b0
  arch_timer_handler_virt+0x28/0x3c
  handle_percpu_devid_irq+0x64/0x110
  handle_irq_desc+0x3c/0x50
  generic_handle_domain_irq+0x18/0x20
  gic_handle_irq+0x50/0xbc
  call_on_irq_stack+0x24/0x34
  do_interrupt_handler+0x60/0x88
  el1_interrupt+0x30/0x48
  el1h_64_irq_handler+0x14/0x1c
  el1h_64_irq+0x70/0x74
  cpuidle_enter_state+0x1a4/0x2d0
  cpuidle_enter+0x34/0x48
  do_idle+0x21c/0x240
  cpu_startup_entry+0x30/0x34
  kernel_init+0x0/0x124
  console_on_rootfs+0x0/0x64
  __primary_switched+0x88/0x90
irq event stamp: 17055
hardirqs last  enabled at (17055): [<ffffffc080a0782c>]
_raw_spin_unlock_irqrestore+0x34/0x54
hardirqs last disabled at (17054): [<ffffffc080a075a4>]
_raw_spin_lock_irqsave+0x28/0x70
softirqs last  enabled at (14360): [<ffffffc080096bcc>]
handle_softirqs+0x1b0/0x3b4
softirqs last disabled at (14355): [<ffffffc080010168>] __do_softirq+0x10/0x18

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->power.lock);
  <Interrupt>
    lock(&dev->power.lock);

 *** DEADLOCK ***

5 locks held by s2idle/764:
 #0: ffffff84400983f0 (sb_writers#5){.+.+}-{0:0}, at:
file_start_write.isra.0+0x24/0x30
 #1: ffffff8446802288 (&of->mutex#2){+.+.}-{4:4}, at:
kernfs_fop_write_iter+0xf8/0x180
 #2: ffffff8440d016e8 (kn->active#39){.+.+}-{0:0}, at:
kernfs_fop_write_iter+0x100/0x180
 #3: ffffffc0812f4780 (system_transition_mutex){+.+.}-{4:4}, at:
pm_suspend+0x84/0x248
 #4: ffffffc084bb7f78 (dpm_list_mtx){+.+.}-{4:4}, at: dpm_suspend+0x84/0x1a8

stack backtrace:
CPU: 0 UID: 0 PID: 764 Comm: s2idle Tainted: G        W
6.14.0-rc5-rcar3-05904-g1ec95427acf9 #261
Tainted: [W]=WARN
Hardware name: Renesas Gray Hawk Single board based on r8a779h0 (DT)
Call trace:
 show_stack+0x14/0x1c (C)
 dump_stack_lvl+0x78/0xa8
 dump_stack+0x14/0x1c
 print_usage_bug+0x1dc/0x1f8
 mark_lock+0x1c4/0x3a4
 __lock_acquire+0x560/0x1038
 lock_acquire+0x26c/0x2c4
 _raw_spin_lock+0x40/0x54
 dpm_async_fn+0x24/0xa8
 dpm_async_queue_suspend_ready_fn+0x40/0x50
 dpm_async_suspend_loop+0x48/0x50
 dpm_suspend+0x94/0x1a8
 dpm_suspend_start+0x68/0x70
 suspend_devices_and_enter+0xd8/0x59c
 pm_suspend+0x214/0x248
 state_store+0xa8/0xe8
 kobj_attr_store+0x14/0x24
 sysfs_kf_write+0x4c/0x64
 kernfs_fop_write_iter+0x138/0x180
 vfs_write+0x148/0x1b4
 ksys_write+0x78/0xe0
 __arm64_sys_write+0x14/0x1c
 invoke_syscall+0x68/0xf0
 el0_svc_common.constprop.0+0xb0/0xcc
 do_el0_svc+0x18/0x20
 el0_svc+0x38/0x90
 el0t_64_sync_handler+0x80/0x130
 el0t_64_sync+0x158/0x15c


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


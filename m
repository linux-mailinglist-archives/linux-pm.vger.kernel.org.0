Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA417ACE7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCERXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 12:23:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41252 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgCERXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 12:23:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so3063135pgm.8;
        Thu, 05 Mar 2020 09:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+bkKk7iqoi5S/dJdHL0QBNekmkV769PZZtmx/GwHqBo=;
        b=eys7fdE1n2U1j26tUKuWBHshY3aZK0tSN4hWFCgB/QtOQdGdLf1ibb914YTCSvS9zQ
         KBUCP1hUxGH2ylh0nC5IntewaSuMaFs0ycxIcQtgu2p8rFVrCcP+2ofTSCllsP9FirMj
         dR3n7P+BPwwLJop/FIFtLmw5p5jrY2rgf3cPcuJSHjwgCGqluu82txU1eSCCPm/rKVK7
         KrFt9DpwwZNqPm/PVYnWWjpkefCUYVzRHY3RVWTfKukiE3s9cGQbqR9/RyV7N+eYuUzE
         GYLEGl+gXduG0ciASI8MuarnzVbMKJWS3Dnuh84RXh85A0v/jd5VDCxMOMw1/xqGD6yZ
         eYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+bkKk7iqoi5S/dJdHL0QBNekmkV769PZZtmx/GwHqBo=;
        b=SijzvfKmINOysgQuFsAH/aQAjuQfaOKQyb6NVaY2UYJv23LSgN9YfNJTtW5PTKE7xf
         M0GhO73uQhBuC0DwgnGFyXB/2Qs80J2WWhzt2Nbv5k/2z+wXC1yXpguxD2G2fp+BgwAX
         tSpkw/SFagYzyXbvrTQ7RTJ8s3yepr7wJefhAKS8YxqNAGhFFy/+Qh1xfr0m4D1M+0eM
         nthShIL/1ysMKF8pEgkU7nCu58+cbzSIDdEaARZuV/+v+3nGeD0TlAPXKMvswFRbQ11C
         ByXKoj4I8tMqB2FifJq13p2/NiQYk36oQkoimh6JKdhBATPaby/fhc295f7WREksyRcM
         9pTw==
X-Gm-Message-State: ANhLgQ14XEc7WBes6rr5cPzr+/tcUNlvMGC5bnFeMpo+QwvtJe9SNg7d
        tc5DkvsHmy0Y5DFf+O+DkQ==
X-Google-Smtp-Source: ADFU+vu4j+inyYadCyilJ3hXHI8AzN8fyupEmSz2mx28zb9hg7p6jbB0rnTFeXepS6BdYfqfBbNrbg==
X-Received: by 2002:a63:5251:: with SMTP id s17mr8678269pgl.160.1583428996112;
        Thu, 05 Mar 2020 09:23:16 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee0:fa4c:45f1:8421:bfd8:b0fb])
        by smtp.gmail.com with ESMTPSA id p94sm7065663pjp.15.2020.03.05.09.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 09:23:15 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 5 Mar 2020 22:53:00 +0530
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     madhuparnabhowmik10@gmail.com, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] Default enable RCU list lockdep debugging with PROVE_RCU
Message-ID: <20200305172300.GA9915@madhuparna-HP-Notebook>
References: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
 <CGME20200305105038eucas1p1bad0e1bd4b12a28e05ecd14615b31af2@eucas1p1.samsung.com>
 <59f5554c-3343-7bf6-d7d8-bba53710afae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59f5554c-3343-7bf6-d7d8-bba53710afae@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 05, 2020 at 11:50:37AM +0100, Marek Szyprowski wrote:
> Dear All,
> 
> On 28.02.2020 10:24, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> > This patch default enables CONFIG_PROVE_RCU_LIST option with
> > CONFIG_PROVE_RCU for RCU list lockdep debugging.
> >
> > With this change, RCU list lockdep debugging will be default
> > enabled in CONFIG_PROVE_RCU=y kernels.
> >
> > Most of the RCU users (in core kernel/, drivers/, and net/
> > subsystem) have already been modified to include lockdep
> > expressions hence RCU list debugging can be enabled by
> > default.
> >
> > However, there are still chances of enountering
> > false-positive lockdep splats because not everything is converted,
> > in case RCU list primitives are used in non-RCU read-side critical
> > section but under the protection of a lock. It would be okay to
> > have a few false-positives, as long as bugs are identified, since this
> > patch only affects debugging kernels.
> >
> > Co-developed-by: Amol Grover <frextrite@gmail.com>
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch landed in today's linux-next (20200305) as commit 
> c9af03c14bfdfd21515e556c3a90ffe2aadc964d. It causes the following kernel 
> warning during system suspend/resume cycle on all ARM 32bit Samsung 
> Exynos-based boards (kernel compiled from exynos_defconfig):
> 
> # rtcwake -s 10 -m mem
> rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Jan  1 00:01:13 2000
> PM: suspend entry (deep)
> Filesystems sync: 0.008 seconds
> Freezing user space processes ... (elapsed 0.003 seconds) done.
> OOM killer disabled.
> Freezing remaining freezable tasks ... (elapsed 0.013 seconds) done.
> printk: Suspending console(s) (use no_console_suspend to debug)
>
Hi,

These warnings in power/main.c and power/wakeup.c  are already
addressed.
Check this https://lore.kernel.org/patchwork/patch/1204515/
Thank you,
Madhuparna
> =============================
> WARNING: suspicious RCU usage
> 5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
> -----------------------------
> drivers/base/power/main.c:326 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 5 locks held by rtcwake/1452:
>   #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
>   #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
>   #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
>   #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
>   #4: c1285d98 (device_links_srcu){....}, at: 
> device_links_read_lock+0x0/0x50
> 
> stack backtrace:
> CPU: 7 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
> #7728
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
> [<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
> [<c0b5c50c>] (dump_stack) from [<c061ea2c>] 
> (dpm_wait_for_subordinate+0xf4/0xfc)
> [<c061ea2c>] (dpm_wait_for_subordinate) from [<c061f578>] 
> (__device_suspend+0x20/0x838)
> [<c061f578>] (__device_suspend) from [<c0622e1c>] (dpm_suspend+0x188/0x57c)
> [<c0622e1c>] (dpm_suspend) from [<c0623bfc>] (dpm_suspend_start+0x98/0xa0)
> [<c0623bfc>] (dpm_suspend_start) from [<c0197e20>] 
> (suspend_devices_and_enter+0xec/0xc74)
> [<c0197e20>] (suspend_devices_and_enter) from [<c0198da0>] 
> (pm_suspend+0x3f8/0x480)
> [<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
> [<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
> [<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
> [<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
> [<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
> [<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xeac89fa8 to 0xeac89ff0)
> 9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
> 00000000
> 9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
> 00028160
> 9fe0: 0000006c be980ac8 b6eae000 b6f0b634
> 
> =============================
> WARNING: suspicious RCU usage
> 5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
> -----------------------------
> drivers/base/power/main.c:1698 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 6 locks held by rtcwake/1452:
>   #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
>   #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
>   #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
>   #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
>   #4: ebecd984 (&dev->mutex){....}, at: __device_suspend+0xf8/0x838
>   #5: c1285d98 (device_links_srcu){....}, at: 
> device_links_read_lock+0x0/0x50
> 
> stack backtrace:
> CPU: 7 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
> #7728
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
> [<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
> [<c0b5c50c>] (dump_stack) from [<c061f8bc>] (__device_suspend+0x364/0x838)
> [<c061f8bc>] (__device_suspend) from [<c0622e1c>] (dpm_suspend+0x188/0x57c)
> [<c0622e1c>] (dpm_suspend) from [<c0623bfc>] (dpm_suspend_start+0x98/0xa0)
> [<c0623bfc>] (dpm_suspend_start) from [<c0197e20>] 
> (suspend_devices_and_enter+0xec/0xc74)
> [<c0197e20>] (suspend_devices_and_enter) from [<c0198da0>] 
> (pm_suspend+0x3f8/0x480)
> [<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
> [<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
> [<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
> [<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
> [<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
> [<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xeac89fa8 to 0xeac89ff0)
> 9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
> 00000000
> 9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
> 00028160
> 9fe0: 0000006c be980ac8 b6eae000 b6f0b634
> wake enabled for irq 160
> wake enabled for irq 164
> samsung-pinctrl 13400000.pinctrl: Setting external wakeup interrupt 
> mask: 0xffffffe7
> 
> =============================
> WARNING: suspicious RCU usage
> 5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
> -----------------------------
> drivers/base/power/wakeup.c:408 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 5 locks held by rtcwake/1452:
>   #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
>   #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
>   #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
>   #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
>   #4: c128722c (wakeup_srcu){....}, at: 
> device_wakeup_arm_wake_irqs+0x0/0x124
> 
> stack backtrace:
> CPU: 5 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
> #7728
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
> [<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
> [<c0b5c50c>] (dump_stack) from [<c0625740>] 
> (device_wakeup_arm_wake_irqs+0xdc/0x124)
> [<c0625740>] (device_wakeup_arm_wake_irqs) from [<c0622120>] 
> (dpm_suspend_noirq+0x1c/0x5a0)
> [<c0622120>] (dpm_suspend_noirq) from [<c019805c>] 
> (suspend_devices_and_enter+0x328/0xc74)
> [<c019805c>] (suspend_devices_and_enter) from [<c0198da0>] 
> (pm_suspend+0x3f8/0x480)
> [<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
> [<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
> [<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
> [<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
> [<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
> [<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xeac89fa8 to 0xeac89ff0)
> 9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
> 00000000
> 9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
> 00028160
> 9fe0: 0000006c be980ac8 b6eae000 b6f0b634
> 
> =============================
> WARNING: suspicious RCU usage
> 5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
> -----------------------------
> drivers/base/power/main.c:1238 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 5 locks held by rtcwake/1452:
>   #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
>   #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
>   #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
>   #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
>   #4: c1285d98 (device_links_srcu){....}, at: 
> device_links_read_lock+0x0/0x50
> 
> stack backtrace:
> CPU: 5 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
> #7728
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
> [<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
> [<c0b5c50c>] (dump_stack) from [<c06202d4>] 
> (__device_suspend_noirq+0x234/0x304)
> [<c06202d4>] (__device_suspend_noirq) from [<c0622284>] 
> (dpm_suspend_noirq+0x180/0x5a0)
> [<c0622284>] (dpm_suspend_noirq) from [<c019805c>] 
> (suspend_devices_and_enter+0x328/0xc74)
> [<c019805c>] (suspend_devices_and_enter) from [<c0198da0>] 
> (pm_suspend+0x3f8/0x480)
> [<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
> [<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
> [<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
> [<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
> [<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
> [<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xeac89fa8 to 0xeac89ff0)
> 9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
> 00000000
> 9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
> 00028160
> 9fe0: 0000006c be980ac8 b6eae000 b6f0b634
> Disabling non-boot CPUs ...
> IRQ 51: no longer affine to CPU1
> IRQ 52: no longer affine to CPU2
> IRQ 53: no longer affine to CPU3
> IRQ 54: no longer affine to CPU4
> IRQ 55: no longer affine to CPU5
> IRQ 56: no longer affine to CPU6
> IRQ 57: no longer affine to CPU7
> Enabling non-boot CPUs ...
> CPU1 is up
> CPU2 is up
> CPU3 is up
> CPU4: detected I-Cache line size mismatch, workaround enabled
> CPU4 is up
> CPU5: detected I-Cache line size mismatch, workaround enabled
> CPU5 is up
> CPU6: detected I-Cache line size mismatch, workaround enabled
> CPU6 is up
> CPU7: detected I-Cache line size mismatch, workaround enabled
> CPU7 is up
> 
> =============================
> WARNING: suspicious RCU usage
> 5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
> -----------------------------
> drivers/base/power/main.c:269 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 5 locks held by rtcwake/1452:
>   #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
>   #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
>   #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
>   #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
>   #4: c1285d98 (device_links_srcu){....}, at: 
> device_links_read_lock+0x0/0x50
> 
> stack backtrace:
> CPU: 0 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
> #7728
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
> [<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
> [<c0b5c50c>] (dump_stack) from [<c061ebf0>] 
> (dpm_wait_for_superior+0x114/0x12c)
> [<c061ebf0>] (dpm_wait_for_superior) from [<c061fe98>] 
> (device_resume_noirq+0x74/0x238)
> [<c061fe98>] (device_resume_noirq) from [<c0620a34>] 
> (dpm_resume_noirq+0x160/0x53c)
> [<c0620a34>] (dpm_resume_noirq) from [<c01983c8>] 
> (suspend_devices_and_enter+0x694/0xc74)
> [<c01983c8>] (suspend_devices_and_enter) from [<c0198da0>] 
> (pm_suspend+0x3f8/0x480)
> [<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
> [<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
> [<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
> [<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
> [<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
> [<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xeac89fa8 to 0xeac89ff0)
> 9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
> 00000000
> 9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
> 00028160
> 9fe0: 0000006c be980ac8 b6eae000 b6f0b634
> s3c-i2c 12c80000.i2c: slave address 0x00
> s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
> 
> =============================
> WARNING: suspicious RCU usage
> 5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
> -----------------------------
> drivers/base/power/wakeup.c:424 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 5 locks held by rtcwake/1452:
>   #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
>   #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
>   #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
>   #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
>   #4: c128722c (wakeup_srcu){....}, at: 
> device_wakeup_disarm_wake_irqs+0x0/0x124
> 
> stack backtrace:
> CPU: 0 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
> #7728
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
> [<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
> [<c0b5c50c>] (dump_stack) from [<c0625864>] 
> (device_wakeup_disarm_wake_irqs+0xdc/0x124)
> [<c0625864>] (device_wakeup_disarm_wake_irqs) from [<c0620b84>] 
> (dpm_resume_noirq+0x2b0/0x53c)
> [<c0620b84>] (dpm_resume_noirq) from [<c01983c8>] 
> (suspend_devices_and_enter+0x694/0xc74)
> [<c01983c8>] (suspend_devices_and_enter) from [<c0198da0>] 
> (pm_suspend+0x3f8/0x480)
> [<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
> [<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
> [<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
> [<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
> [<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
> [<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xeac89fa8 to 0xeac89ff0)
> 9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
> 00000000
> 9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
> 00028160
> 9fe0: 0000006c be980ac8 b6eae000 b6f0b634
> 
> I can help debugging this issue.
> 
> > ---
> >   kernel/rcu/Kconfig.debug | 11 +++--------
> >   1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index 4aa02eee8f6c..ec4bb6c09048 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -9,15 +9,10 @@ config PROVE_RCU
> >   	def_bool PROVE_LOCKING
> >   
> >   config PROVE_RCU_LIST
> > -	bool "RCU list lockdep debugging"
> > -	depends on PROVE_RCU && RCU_EXPERT
> > -	default n
> > +	def_bool PROVE_RCU
> >   	help
> > -	  Enable RCU lockdep checking for list usages. By default it is
> > -	  turned off since there are several list RCU users that still
> > -	  need to be converted to pass a lockdep expression. To prevent
> > -	  false-positive splats, we keep it default disabled but once all
> > -	  users are converted, we can remove this config option.
> > +	  Enable RCU lockdep checking for list usages. It is default
> > +	  enabled with CONFIG_PROVE_RCU.
> >   
> >   config TORTURE_TEST
> >   	tristate
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

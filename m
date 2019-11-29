Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0AF10D537
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 12:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfK2LxR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 06:53:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46552 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfK2LxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 06:53:17 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id eb27ea56cf9eb12a; Fri, 29 Nov 2019 12:53:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Add missing locking while setting suspend_freq
Date:   Fri, 29 Nov 2019 12:53:12 +0100
Message-ID: <1608436.tOKWp43cha@kreacher>
In-Reply-To: <1d992c15-66bd-4d53-114f-66e3105e5fae@samsung.com>
References: <CGME20191112104809eucas1p14d5d364021a359861788472b513e43e5@eucas1p1.samsung.com> <20191112104734.31074-1-m.szyprowski@samsung.com> <1d992c15-66bd-4d53-114f-66e3105e5fae@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, November 13, 2019 3:17:17 AM CET Chanwoo Choi wrote:
> Dear Rafael,
> 
> Could you take this patch directly into linux-pm.git for v5.5-rc1?
> 
> Because the devfreq pull-request for v5.5-rc1 contained issue. This patch
> fix the issue of following patch[1].
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=2abb0d5268ae7b5ddf82099b1f8d5aa8414637d4

I missed this previously, sorry.

Now applied as a fix for 5.5, thanks!


> ---
> Hi Marek,
> 
> Thanks for the fixup.
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Regards,
> Chanwoo Choi
> 
> 
> On 11/12/19 7:47 PM, Marek Szyprowski wrote:
> > Commit 2abb0d5268ae ("PM / devfreq: Lock devfreq in trans_stat_show")
> > revealed a missing locking while calling devfreq_update_status() function
> > during suspend/resume cycle.
> > 
> > Code analysis revealed that devfreq_set_target() function was called
> > without needed locks held for setting device specific suspend_freq if such
> > has been defined. This patch fixes that by adding the needed locking, what
> > fixes following kernel warning on Exynos4412-based OdroidU3 board during
> > system suspend:
> > 
> > PM: suspend entry (deep)
> > Filesystems sync: 0.002 seconds
> > Freezing user space processes ... (elapsed 0.001 seconds) done.
> > OOM killer disabled.
> > Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > ------------[ cut here ]------------
> > WARNING: CPU: 2 PID: 1385 at drivers/devfreq/devfreq.c:204 devfreq_update_status+0xc0/0x188
> > Modules linked in:
> > CPU: 2 PID: 1385 Comm: rtcwake Not tainted 5.4.0-rc6-next-20191111 #6848
> > Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > [<c0112588>] (unwind_backtrace) from [<c010e070>] (show_stack+0x10/0x14)
> > [<c010e070>] (show_stack) from [<c0afb010>] (dump_stack+0xb4/0xe0)
> > [<c0afb010>] (dump_stack) from [<c01272e0>] (__warn+0xf4/0x10c)
> > [<c01272e0>] (__warn) from [<c01273a8>] (warn_slowpath_fmt+0xb0/0xb8)
> > [<c01273a8>] (warn_slowpath_fmt) from [<c07d105c>] (devfreq_update_status+0xc0/0x188)
> > [<c07d105c>] (devfreq_update_status) from [<c07d2d70>] (devfreq_set_target+0xb0/0x15c)
> > [<c07d2d70>] (devfreq_set_target) from [<c07d3598>] (devfreq_suspend+0x2c/0x64)
> > [<c07d3598>] (devfreq_suspend) from [<c05de0b0>] (dpm_suspend+0xa4/0x57c)
> > [<c05de0b0>] (dpm_suspend) from [<c05def74>] (dpm_suspend_start+0x98/0xa0)
> > [<c05def74>] (dpm_suspend_start) from [<c0195b58>] (suspend_devices_and_enter+0xec/0xc74)
> > [<c0195b58>] (suspend_devices_and_enter) from [<c0196a20>] (pm_suspend+0x340/0x410)
> > [<c0196a20>] (pm_suspend) from [<c019480c>] (state_store+0x6c/0xc8)
> > [<c019480c>] (state_store) from [<c033fc50>] (kernfs_fop_write+0x10c/0x228)
> > [<c033fc50>] (kernfs_fop_write) from [<c02a6d3c>] (__vfs_write+0x30/0x1d0)
> > [<c02a6d3c>] (__vfs_write) from [<c02a9afc>] (vfs_write+0xa4/0x180)
> > [<c02a9afc>] (vfs_write) from [<c02a9d58>] (ksys_write+0x60/0xd8)
> > [<c02a9d58>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> > Exception stack(0xed3d7fa8 to 0xed3d7ff0)
> > ...
> > irq event stamp: 9667
> > hardirqs last  enabled at (9679): [<c0b1e7c4>] _raw_spin_unlock_irq+0x20/0x58
> > hardirqs last disabled at (9698): [<c0b16a20>] __schedule+0xd8/0x818
> > softirqs last  enabled at (9694): [<c01026fc>] __do_softirq+0x4fc/0x5fc
> > softirqs last disabled at (9719): [<c012fe68>] irq_exit+0x16c/0x170
> > ---[ end trace 41ac5b57d046bdbc ]---
> > ------------[ cut here ]------------
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/devfreq/devfreq.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 94fb8e821e12..65a4b6cf3fa5 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -957,7 +957,9 @@ int devfreq_suspend_device(struct devfreq *devfreq)
> >  	}
> >  
> >  	if (devfreq->suspend_freq) {
> > +		mutex_lock(&devfreq->lock);
> >  		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
> > +		mutex_unlock(&devfreq->lock);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -985,7 +987,9 @@ int devfreq_resume_device(struct devfreq *devfreq)
> >  		return 0;
> >  
> >  	if (devfreq->resume_freq) {
> > +		mutex_lock(&devfreq->lock);
> >  		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
> > +		mutex_unlock(&devfreq->lock);
> >  		if (ret)
> >  			return ret;
> >  	}
> > 
> 
> 
> 





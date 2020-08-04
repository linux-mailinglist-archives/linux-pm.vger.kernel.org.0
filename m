Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F5023B736
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 11:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgHDJFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 05:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgHDJFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 05:05:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81722C06174A;
        Tue,  4 Aug 2020 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0NFSpoMwONDCV/sQ14wSOzrHa0WLlD9ZjKv0WvWFeuk=; b=Xk99eCGzN6kn7BDG+uXqaJw913
        /PJvWjaHMVTOrlHkDkRyj38uN9BXF4EMwANxLLlbyUE2nzORtiN3etWCykNU4OsI2WaMZJ/93tUDH
        UR7Zr2JHy8xLChiFQAcTBNBxYvdq1kFN9+i8ZlkmY6uQNb9r3mcykWZfrk19olNhtzn/JYYhn+pAO
        VZOC7PD0WEr4bmD3KSeOtKoizQAFkqKLy7NaBiMxK9XT2lO4zzRVrrhSJtgQUHKMGrchldD6bcMsj
        hiokG3dxD1NUf48m2PWI5yi51gdmkj4M0s0GVjl+iQzBYoFAFJCCJOxqdXt+CXBfXtbLmR+9XGvDi
        h3fGcb4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2ssi-0007S3-PT; Tue, 04 Aug 2020 09:05:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93DCC301E02;
        Tue,  4 Aug 2020 11:05:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43ED82B94E745; Tue,  4 Aug 2020 11:05:08 +0200 (CEST)
Date:   Tue, 4 Aug 2020 11:05:08 +0200
From:   peterz@infradead.org
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
Subject: Re: [PATCH v4] sched: Provide USF for the portable equipment.
Message-ID: <20200804090508.GH2674@hirez.programming.kicks-ass.net>
References: <cover.1596526941.git.yangdongdong@xiaomi.com>
 <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 03:50:35PM +0800, Dongdong Yang wrote:

> +What:		/sys/devices/system/cpu/sched_usf
> +		/sys/devices/system/cpu/sched_usf/sched_usf_non_ux_r
> +		/sys/devices/system/cpu/sched_usf/sched_usf_up_l0_r
> +		/sys/devices/system/cpu/sched_usf/sched_usf_down_r
> +Date:		Aug 2020
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	User Sensitive Feedback factor auxiliary scheduling which
> +		is providing more utils adjustment settings to the high level
> +		by scenario identification.
> +		sched_usf_non_ux_r:
> +			The ratio of utils is cut down on screen off. The
> +			default value is 0, which no util is adjusted on sugov
> +			calculating utils to select cpufreq. Its range is
> +			[-100 , 0]. If its value falls into [-50, 0), the half
> +			of utils, which	calculates cpufreq, shall be  cut down.
> +			If its value falls into [-100, -50), only a quarter of
> +			utils are left to continue to calculate cpufreq.
> +			It is expected to be set [-100, 0) once enter into the
> +			identificated scenario, such as listen to music on
> +			screen off, and recover to 0 on out of the scenario,
> +			such as	screen on.
> +
> +		sched_usf_up_l0_r:
> +			The ratio of utils is boost up on screen on. The
> +			default value is 0, which no util is adjusted on sugov
> +			calculates utils to select cpufreq. Its range is [0 , 100].
> +			If its value falls into (0, 50], a quarter of extra utils,
> +			which calculate cpufreq, shall be added. If its value
> +			falls into (50, 100], the half of extra utils are added
> +			to continue to	calculate cpufreq.
> +			It is expected to be set (0, 100] once enter into the
> +			identificated scenario, such as browsing videolet on
> +			screen on, and recover to 0 on out of the scenario,
> +			such as screen off or videolet into background.
> +
> +		sched_usf_down_r:
> +			The ratio of utils is cut down on screen on. The
> +			default	value is 0, which no util is adjusted on sugov
> +			calculating utils to select cpufreq. Its range is
> +			[-100 , 0]. If its value falls into [-50, 0), the half
> +			of utils, which	calculate cpufreq, shall be  cut down.
> +			If its value falls into [-100, -50), only a quarter of
> +			utils are left to continue to calculate cpufreq.
> +			It is expected to be set [-100, 0) once enter into the
> +			identificated scenario, such as browsing videolet on
> +			screen on, and recover to 0 on	out of the scenario,
> +			such as screen off or vidolet into background.

I hate the names, they're a bunch of random letters. Maybe if you strip
the 'sched_usf' prefix, on account on these files being in a directory
by the same name, you'll have additional budget for readable names?

Also, I detest 100, 100 sucks. Use something sane, like 128.

Also, I'm not at all sure I understand the text.

Also, nothing explains how any of this is supposed to be working on an
SMP system. Please advice how this makes sense if you have 64 CPUs. My
desktop has a screen, so giving feedback should work, no?

> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index e917501..a21c6ad 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -224,6 +224,17 @@ config CPUFREQ_DT_PLATDEV
>  
>  	  If in doubt, say N.
>  
> +config SCHED_USF
> +	bool "User Sensitive Factors for Scheduler"

'bool' means this cannot be a module, yet see below.

> +	depends on CPU_FREQ_GOV_SCHEDUTIL && FB

I really hate how this is a special purpose hack for framebuffer. We
don't do special purpose hacks like that.

So you have something that only 'works' for small machines, small number
of tasks, and requires FB.

NAK, we don't do that upstream.

> +	help
> +	  Select this option to enable the adjustment on the cpufreq with
> +	  the user sensitive factors on schedule. It is special for mobile
> +	  devices which more power care and quick response requirement on
> +	  screen on.
> +
> +	  If unsure, say N.
> +
>  if X86
>  source "drivers/cpufreq/Kconfig.x86"
>  endif
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index ed168b0..d5e20b7 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -488,6 +488,41 @@ TRACE_EVENT(sched_process_hang,
>  #endif /* CONFIG_DETECT_HUNG_TASK */
>  
>  /*
> + * Tracepoint for tracking tuils be adjusted by USF:

I can't find 'tuils' in my local dictionary, did you mean tools?

And what does the comment try to day? Are USF users supposed to use this
tracepoint to close a feedback loop or what?

> + */
> +#ifdef CONFIG_SCHED_USF
> +TRACE_EVENT(sched_usf_adjust_utils,
> +
> +	TP_PROTO(int cpu_id, int up, int down, int nonux, unsigned long utils),

You're using tracepoints wrong, pass in that usf_dev pointer and have
the assign do all the work.

> +
> +	TP_ARGS(cpu_id, up, down, nonux, utils),
> +
> +	TP_STRUCT__entry(
> +		__field(int, cpu_id)
> +		__field(int, up)
> +		__field(int, down)
> +		__field(int, nonux)
> +		__field(unsigned long, utils)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu_id	= cpu_id;
> +		__entry->up	= up;
> +		__entry->down	= down;
> +		__entry->nonux	= nonux;
> +		__entry->utils	= utils;
> +	),
> +
> +	TP_printk("cpu_id=%d up=%d down=%d nonux=%d utils=%lu",
> +		  __entry->cpu_id,
> +		  __entry->up,
> +		  __entry->down,
> +		  __entry->nonux,
> +		  __entry->utils)
> +);
> +#endif /* CONFIG_SCHED_USF */
> +
> +/*
>   * Tracks migration of tasks from one runqueue to another. Can be used to
>   * detect if automatic NUMA balancing is bouncing between nodes.
>   */
> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index 5fc9c9b..58a0e7b 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -36,3 +36,4 @@ obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
>  obj-$(CONFIG_MEMBARRIER) += membarrier.o
>  obj-$(CONFIG_CPU_ISOLATION) += isolation.o
>  obj-$(CONFIG_PSI) += psi.o
> +obj-$(CONFIG_SCHED_USF) += usf.o
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7fbaee2..79a0040 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -289,12 +289,15 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>  	return min(max, util);
>  }
>  
> +DEFINE_STATIC_KEY_FALSE(adjust_task_pred_set);

Missing whitespace, bad name. Also wrong file, all the actual control is
in that usf nonsense.

>  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
>  	unsigned long util = cpu_util_cfs(rq);
>  	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
>  
> +	if (static_branch_unlikely(&adjust_task_pred_set))
> +		adjust_task_pred_demand(sg_cpu->cpu, &util, rq);

Missing whitespace, horrible naming, there is nothing task here,

Please explain how it makes sense to have that static branch when
!SCHED_USF.

>  	sg_cpu->max = max;
>  	sg_cpu->bw_dl = cpu_bw_dl(rq);
>  
> diff --git a/kernel/sched/usf.c b/kernel/sched/usf.c
> new file mode 100644
> index 0000000..d4d7998
> --- /dev/null
> +++ b/kernel/sched/usf.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 XiaoMi Inc.
> + * Author: Yang Dongdong <yangdongdong@xiaomi.com>
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * See http://www.gnu.org/licenses/gpl-2.0.html for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/kthread.h>
> +#include <linux/cpu.h>
> +#include <linux/sysfs.h>
> +#include <linux/kthread.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/kallsyms.h>
> +#include <linux/fb.h>
> +#include <linux/notifier.h>
> +#include <trace/events/sched.h>
> +#include "sched.h"
> +
> +#define BOOST_MIN_V -100
> +#define BOOST_MAX_V 100
> +#define LEVEL_TOP 3
> +
> +#define USF_TAG	"[usf_sched]"
> +
> +DEFINE_PER_CPU(unsigned long[PID_MAX_DEFAULT], task_hist_nivcsw);

Hahahaha, I think not.

> +
> +static struct {
> +	bool is_sched_usf_enabled;
> +	bool is_screen_on;
> +	int sysctl_sched_usf_up_l0;
> +	int sysctl_sched_usf_down;
> +	int sysctl_sched_usf_non_ux;

They're not sysctl's. Also letter soup.

> +	int usf_up_l0;
> +	int usf_down;
> +	int usf_non_ux;
> +} usf_vdev;
> +
> +void adjust_task_pred_demand(int cpuid,
> +			     unsigned long *util,
> +			     struct rq *rq)

Still a horrible name.

> +{
> +	/* sysctl_sched_latency/sysctl_sched_min_granularity */

What does this comment want to tell us?

> +	u32 bl_sw_num = 3;
> +
> +	if (!usf_vdev.is_sched_usf_enabled || !rq || !rq->curr ||
> +		(rq->curr->pid >= PID_MAX_DEFAULT))

Everything after is_sched_usf_enable is nonsense. And even that is dodgy
since you had that static branch. You shouldn't be getting here if
you're not enabled.

> +		return;
> +
> +	if (usf_vdev.is_screen_on) {
> +		if (rq->curr->nivcsw >
> +		    (per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid]
> +		     + bl_sw_num + 1)) {

That's horrible style, if you'd made a helper function with a
descriptive name, you'd have readable code.

> +			(*util) += (*util) >> usf_vdev.usf_up_l0;

So when 'current' has more non-voluntary context switches than it last
had on this cpu, we add something to the util.

That's dodgy as heck. Esp. without comments.

This util is not for current. The best you can say is that current
contributes to it.

> +		} else if (rq->curr->nivcsw <
> +			   (per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid]
> +			    + bl_sw_num - 1) && (rq->nr_running < bl_sw_num)) {

Another unreadable expression with style issues, and how we're reducing util.

> +			(*util) >>= usf_vdev.usf_down;
> +		}
> +		per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid] =
> +		    rq->curr->nivcsw;

That's hardly a histogram is it. Or did you mean history?

> +	} else if (rq->curr->mm) {
> +		(*util) >>= usf_vdev.usf_non_ux;
> +	}
> +
> +	trace_sched_usf_adjust_utils(cpuid, usf_vdev.usf_up_l0,
> +				     usf_vdev.usf_down,
> +				     usf_vdev.usf_non_ux, *util);
> +}
> +
> +static int usf_lcd_notifier(struct notifier_block *nb,
> +			    unsigned long val, void *data)
> +{
> +	struct fb_event *evdata = data;
> +	unsigned int blank;
> +
> +	if (!evdata)
> +		return 0;
> +
> +	if (val != FB_EVENT_BLANK)
> +		return 0;
> +
> +	if (evdata->data && val == FB_EVENT_BLANK) {
> +		blank = *(int *)(evdata->data);
> +
> +		switch (blank) {
> +		case FB_BLANK_POWERDOWN:
> +			usf_vdev.is_screen_on = false;
> +			if (usf_vdev.sysctl_sched_usf_non_ux != 0)
> +				static_branch_enable(&adjust_task_pred_set);
> +			else
> +				static_branch_disable(&adjust_task_pred_set);
> +
> +			break;
> +
> +		case FB_BLANK_UNBLANK:
> +			usf_vdev.is_screen_on = true;
> +			if (usf_vdev.sysctl_sched_usf_up_l0 != 0 ||
> +			    usf_vdev.sysctl_sched_usf_down != 0)
> +				static_branch_enable(&adjust_task_pred_set);
> +			else
> +				static_branch_disable(&adjust_task_pred_set);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		usf_vdev.is_sched_usf_enabled = true;
> +		pr_info("%s : usf_vdev.is_screen_on:%b\n",
> +				     __func__, usf_vdev.is_screen_on);
> +	}
> +	return NOTIFY_OK;
> +}

*groan*...  this is horrific. Flipping the static branch is _very_
expensive.

> +

> +static int __init intera_monitor_init(void)
> +{
> +	int res = -1;
> +	struct device *dev;
> +
> +	res = fb_register_client(&usf_lcd_nb);
> +	if (res < 0) {
> +		pr_err("Failed to register usf_lcd_nb!\n");
> +		return res;
> +	}
> +
> +	/*
> +	 * create a sched_usf in cpu_subsys:
> +	 * /sys/devices/system/cpu/sched_usf/...
> +	 */
> +	dev = cpu_subsys.dev_root;
> +	res = sysfs_create_group(&dev->kobj, &sched_attr_group);
> +	if (res) {
> +		fb_unregister_client(&usf_lcd_nb);
> +		return res;
> +	}
> +	static_branch_disable(&adjust_task_pred_set);

You used DEFINE_STATIC_BRANCH_FALSE, it is already disabled.

> +
> +	return res;
> +}
> +
> +module_init(intera_monitor_init);
> +
> +static void __exit intera_monitor_exit(void)
> +{
> +	struct device *dev;
> +
> +	dev = cpu_subsys.dev_root;
> +	sysfs_remove_group(&dev->kobj, &sched_attr_group);
> +	fb_unregister_client(&usf_lcd_nb);
> +	static_branch_disable(&adjust_task_pred_set);
> +}
> +
> +module_exit(intera_monitor_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("XiaoMi USF SCHED");
> +MODULE_AUTHOR("Yang Dongdong <yangdongdong@xiaomi.com>");

-ENOTAMODULE

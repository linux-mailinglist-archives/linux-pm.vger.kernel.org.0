Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DFA233B3A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgG3WWC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 18:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbgG3WWB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 18:22:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67DCD20809;
        Thu, 30 Jul 2020 22:21:59 +0000 (UTC)
Date:   Thu, 30 Jul 2020 18:21:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
Subject: Re: [PATCH] sched: Provide USF for the portable equipment.
Message-ID: <20200730182157.110a5cf0@oasis.local.home>
In-Reply-To: <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
References: <cover.1596101307.git.yangdongdong@xiaomi.com>
        <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Jul 2020 21:35:43 +0800
Dongdong Yang <contribute.kernel@gmail.com> wrote:

I'll let others decide the value of this, but I have some comments.

> 
> Signed-off-by: Dongdong Yang <yangdongdong@xiaomi.com>
> Signed-off-by: Jun Tao <taojun@xiaomi.com>
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> Signed-off-by: Geliang Tang <tanggeliang@xiaomi.com>
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>

Why all the signed-off-bys? All of you worked on it?



> +	if (evdata->data && val == FB_EVENT_BLANK) {
> +		blank = *(int *)(evdata->data);
> +
> +		switch (blank) {
> +		case FB_BLANK_POWERDOWN:
> +			usf_vdev.is_screen_on = 0;
> +			if (usf_vdev.sysctl_sched_usf_non_ux != 0)
> +				adjust_task_pred_demand =
> +				    &adjust_task_pred_demand_impl;
> +			else
> +				adjust_task_pred_demand = NULL;

So sysctl can enable and disable this?

> +
> +			break;
> +

> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7fbaee2..7bc3429 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -289,12 +289,21 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>  	return min(max, util);
>  }
>  
> +#ifdef CONFIG_SCHED_USF
> +void (*adjust_task_pred_demand)(int cpuid, unsigned long *util,
> +	struct rq *rq) = NULL;
> +EXPORT_SYMBOL(adjust_task_pred_demand);
> +#endif
> +
>  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
>  	unsigned long util = cpu_util_cfs(rq);
>  	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> -
> +#ifdef CONFIG_SCHED_USF
> +	if (adjust_task_pred_demand)
> +		adjust_task_pred_demand(sg_cpu->cpu, &util, rq);

The above is racy. Nothing stops adjust_task_pred_demand from being
non-null at the if condition, then becoming NULL before it is called.

Instead I would have the following:

DEFINE_STATIC_KEY_FALSE(adjust_task_pred_set);

#ifdef CONFIG_SCHED_USF
void adjust_task_pred_demand(int cpuid, unsigned long *util,
				struct rq *rq);
#else
static inline void adjust_task_pred_demand(int cpuid,
		unsigned long *util, struct rq *rq)
{ }
#endif


	if (static_key_unlikely(adjust_task_pred_set))
		adjust_task_pred_demand(sg_cpu->cpu, &util, rq);

And hopefully the compiler will just remove all of it if it's not
enabled.

Then you set the static branch when you want it to be called, and do
not use a racy function pointer.

-- Steve



> +#endif
>  	sg_cpu->max = max;
>  	sg_cpu->bw_dl = cpu_bw_dl(rq);
>  


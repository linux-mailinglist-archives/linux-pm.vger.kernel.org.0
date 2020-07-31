Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00BC234C7D
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGaUu1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 16:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgGaUu1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 16:50:27 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50178208E4;
        Fri, 31 Jul 2020 20:50:25 +0000 (UTC)
Date:   Fri, 31 Jul 2020 16:50:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     Dongdong Yang <contribute.kernel@gmail.com>,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-pm@vger.kernel.org,
        yangdongdong@xiaomi.com, tanggeliang@xiaomi.com, taojun@xiaomi.com,
        huangqiwu@xiaomi.com, rocking@linux.alibaba.com,
        fengwei@xiaomi.com, zhangguoquan@xiaomi.com, gulinghua@xiaomi.com,
        duhui@xiaomi.com
Subject: Re: [PATCH] sched: Provide USF for the portable equipment.
Message-ID: <20200731165023.11eb5d5b@oasis.local.home>
In-Reply-To: <20200731181538.GB2674@hirez.programming.kicks-ass.net>
References: <cover.1596101307.git.yangdongdong@xiaomi.com>
        <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
        <20200731181538.GB2674@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 Jul 2020 20:15:38 +0200
peterz@infradead.org wrote:

> On Thu, Jul 30, 2020 at 09:35:43PM +0800, Dongdong Yang wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 7fbaee2..7bc3429 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -289,12 +289,21 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> >  	return min(max, util);
> >  }
> >  
> > +#ifdef CONFIG_SCHED_USF
> > +void (*adjust_task_pred_demand)(int cpuid, unsigned long *util,
> > +	struct rq *rq) = NULL;
> > +EXPORT_SYMBOL(adjust_task_pred_demand);
> > +#endif
> > +
> >  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> >  {
> >  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> >  	unsigned long util = cpu_util_cfs(rq);
> >  	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> > -
> > +#ifdef CONFIG_SCHED_USF
> > +	if (adjust_task_pred_demand)
> > +		adjust_task_pred_demand(sg_cpu->cpu, &util, rq);
> > +#endif
> >  	sg_cpu->max = max;
> >  	sg_cpu->bw_dl = cpu_bw_dl(rq);  
> 
> NAK

Peter,

It's more informative if you include rational with a NAK.

-- Steve


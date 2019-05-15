Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9081F8A7
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEOQ3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 12:29:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEOQ3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 12:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yl9Y/zoi19BRHXS+ywGrgM0dKPjn9u9fcXYB1avLYko=; b=dZVfIJ0OEjo78QscT/PjJSi8j
        ylXXPJ4ZeLOLvq90UH/GFLZEp9qW2Ap03bFyFPjMdNn5tYfPyXLSHS3Ro9+o93g27s4x52dE9SB9X
        pUA619BmF39xkt1JMBeH5hWNzmzRWSDkdDLeGO6+zu05OYoHYuhK7h3p6Dr+LH5Cs9yXHHKy73bxm
        oIIbnhWhU1ZLSgPKt7vWlM/u4L6EBl2d7752/Fg4wecLtckgUQUQNlaDNN3xMsZ0ln8yqoFiXTJBJ
        IB0yonS+SmDvKxmVDnzXb6E9V997UD0nBNfy91oJTJM0DttaAnts2MJVPhU+rZcjKMlZEDPOgQecV
        cNfLoH2Vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQwmT-0002JO-LH; Wed, 15 May 2019 16:29:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27EEF2029906B; Wed, 15 May 2019 18:29:24 +0200 (CEST)
Date:   Wed, 15 May 2019 18:29:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
Subject: Re: [RFCv2 1/6] sched/core: Add manual jitter classification from
 cgroup interface
Message-ID: <20190515162924.GT2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-2-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-2-parth@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:17PM +0530, Parth Shah wrote:

> Subject: [RFCv2 1/6] sched/core: Add manual jitter classification from cgroup interface

How can this be v2 ?! I've never seen v1.

> Jitter tasks are usually of less important in terms of performance
> and are short/bursty in characteristics. TurboSched uses this jitter
> classification to pack jitters into the already running busy cores to
> keep the total idle core count high.
> 
> The patch describes the use of UCLAMP mechanism to classify tasks. Patrick
> Bellasi came up with a mechanism to classify tasks from the userspace
> https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com/

The canonical form is:

	https://lkml.kernel.org/r/$MSGID

> This UCLAMP mechanism can be useful in classifying tasks as jitter. Jitters
> can be classified for the cgroup by keeping util.max of the tasks as the
> least(=0). This also provides benefit of giving the least frequency to
> those jitter tasks, which is useful if all jitters are packed onto a
> separate core.
> 
> Use Case with UCLAMP
> ===================
> To create a cgroup with all the tasks classified as jitters;
> 
> ```
> mkdir -p /sys/fs/cgroup/cpu/jitter
> echo 0 > /proc/sys/kernel/sched_uclamp_util_min;
> echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.min;
> echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.max;
> i=8;
> ./turbo_bench -t 30 -h $i -n $i &
> ./turbo_bench -t 30 -h 0 -n $i &
> echo $! > /sys/fs/cgroup/cpu/jitter/cgroup.procs;
> ```
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> ---
>  kernel/sched/core.c  | 9 +++++++++
>  kernel/sched/sched.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d42c0f5eefa9..77aa4aee4478 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7192,6 +7192,15 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
>  	tg->uclamp_req[UCLAMP_MAX].value = max_value;
>  	tg->uclamp_req[UCLAMP_MAX].bucket_id = uclamp_bucket_id(max_value);
>  
> +	/*
> +	 * Classify the tasks belonging to the last bucket of MAX UCLAMP as
> +	 * jitters
> +	 */
> +	if (uclamp_bucket_id(max_value) == 0)
> +		tg->turbo_sched_enabled = 1;
> +	else if (tg->turbo_sched_enabled)
> +		tg->turbo_sched_enabled = 0;
> +
>  	/* Update effective clamps to track the most restrictive value */
>  	cpu_util_update_eff(css, UCLAMP_MAX);
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b4019012d84b..e75ffaf3ff34 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -407,6 +407,7 @@ struct task_group {
>  	struct uclamp_se	uclamp[UCLAMP_CNT];
>  #endif
>  
> +	bool			turbo_sched_enabled;
>  };

Your simple patch has 3 problems:

 - it limits itself; for no apparent reason; to the cgroup interface.

 - it is inconsistent in the terminology; pick either jitter or
   turbo-sched, and I think the latter is a horrid name, it wants to be
   'pack' or something similar. Also, jitter really doesn't make sense
   given the classification.

 - you use '_Bool' in a composite type.


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27521FDEE2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 14:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKON0K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 08:26:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60420 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKON0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 08:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TEb8/WL8bVEd71NxHtR37phcRaSkhErXkR9FY07ytKA=; b=MFS84Rnk/sNo2sMW8vd28u7TU
        /mToQ7X8C0NTmOEo0KhSE5Z/eEkVZjDiZwQQNKu4v/X4DEL9sVD179YU+CqIHmixrTWgzGv+As0HE
        /XBRfuy0vZOn6xH1CBQrVuXKja2BtBvFECm7vj4ekKNrPNNL/e/tPeiOS+DOJ+IQyY6UgUN8S/ikL
        X9F3N+N0gxcbtJ6U2fsAjgMLjD4v/nZCNxoEjIeB50NzAESO8N1oZw1mWzbSF+epLOK6Mse/ZVImf
        bybfcAQV4mkg9LTir4EL/eVyyR6Np9d2yp/mPmmyrLYo00/fU413tq5fr29I0JwawlM7TzYS2bFoQ
        pyO4zWNaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVbbI-00087O-Vm; Fri, 15 Nov 2019 13:25:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD13D3006FB;
        Fri, 15 Nov 2019 14:24:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA5DF2B12DAAB; Fri, 15 Nov 2019 14:25:20 +0100 (CET)
Date:   Fri, 15 Nov 2019 14:25:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, mgorman@suse.de, dsmythies@telus.net,
        linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115132520.GJ4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69a81a5..3be44e1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3504,9 +3504,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  	cfs_rq->load_last_update_time_copy = sa->last_update_time;
>  #endif
>  
> -	if (decayed)
> -		cfs_rq_util_change(cfs_rq, 0);
> -
>  	return decayed;
>  }

This removes the call from the for_each_leaf_cfs_rq_safe() loop.

> @@ -7543,18 +7544,19 @@ static void update_blocked_averages(int cpu)
>  	const struct sched_class *curr_class;
>  	struct rq_flags rf;
>  	bool done = true;
> +	int decayed;
>  
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
>  
>  	/*
> -	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> -	 * that RT, DL and IRQ signals have been updated before updating CFS.
> +	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
> +	 * DL and IRQ signals have been updated before updating CFS.
>  	 */
>  	curr_class = rq->curr->sched_class;
> -	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -	update_irq_load_avg(rq, 0);
> +	decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> +	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> +	decayed |= update_irq_load_avg(rq, 0);

Should not all 3 have their windows aligned and thus alway return the
exact same value?

>  
>  	/* Don't need periodic decay once load/util_avg are null */
>  	if (others_have_blocked(rq))
> @@ -7567,9 +7569,13 @@ static void update_blocked_averages(int cpu)
>  	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
>  		struct sched_entity *se;
>  
> -		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> +		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
>  			update_tg_load_avg(cfs_rq, 0);
>  
> +			if (cfs_rq == &rq->cfs)
> +				decayed = 1;

And that restores it.

But should not also rq->cfs's window be aligned with the above 3?
Meaning that this one, with exception of the list_del, covers all 4.

> +		}
> +
>  		/* Propagate pending load changes to the parent, if any: */
>  		se = cfs_rq->tg->se[cpu];
>  		if (se && !skip_blocked_update(se))
> @@ -7588,6 +7594,9 @@ static void update_blocked_averages(int cpu)
>  	}
>  
>  	update_blocked_load_status(rq, !done);
> +
> +	if (decayed)
> +		cpufreq_update_util(rq, 0);
>  	rq_unlock_irqrestore(rq, &rf);
>  }
>  
> @@ -7644,22 +7653,22 @@ static inline void update_blocked_averages(int cpu)
>  	struct cfs_rq *cfs_rq = &rq->cfs;
>  	const struct sched_class *curr_class;
>  	struct rq_flags rf;
> +	int decayed;
>  
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
>  
> -	/*
> -	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> -	 * that RT, DL and IRQ signals have been updated before updating CFS.
> -	 */
>  	curr_class = rq->curr->sched_class;
> -	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -	update_irq_load_avg(rq, 0);
> +	decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> +	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> +	decayed |= update_irq_load_avg(rq, 0);
>  
> -	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +	decayed |= update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);

And that thus this one makes all 3 above redundant.

>  
>  	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
> +
> +	if (decayed)
> +		cpufreq_update_util(rq, 0);
>  	rq_unlock_irqrestore(rq, &rf);
>  }

That is, I'm almost tempted to prefer a variant of your initial hack,
that refuses to remove rq->cfs from the list.

That avoids having to care about the rt,dl,irq decays (their windows
align with rq->cfs) and makes smp/up similar.


I still don't actually understand how any of this makes intel_pstate
happy though.

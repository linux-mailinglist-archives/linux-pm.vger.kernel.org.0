Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3DA4EA1C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUOCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 10:02:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUOCC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 10:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V+UWa912wmx+/lMg7vn6RvLW3wLYid8k0rOU2aGJZBs=; b=wxqCPnHbDdrC9+hqfs4NEmJdx
        +j9KcH7tz9gtLXN73MaDBjZnoD5mx9da/M1SCKtyaQ7I2FUG8G70w0pRMJGBy62FRlV5HrL2R1h6+
        54Y3jp3Exx/Xwdohye7bE8Y3aLr4BAOVgU4dnRZzFOPr01yNq7GsPZvQgSX24SrzTthlCMDDuzMP6
        68ocd/yR8yaTtJuDH2arGa5ZzrGZ2wYP1q4Ev8FxSQVXDtoGNYn7Cnpl+aLOC9RRR8juBThWnQIbu
        s4TYCk62xvzcVRr3jOt04yrv4KqHTDTzNK0e3SkJ6Vyz+XurnLtwWa7wE+zNKS+kLDHI5JEiINw51
        2bi7etQ2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heK6d-0000tt-Gi; Fri, 21 Jun 2019 14:01:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4D90209FCA1F; Fri, 21 Jun 2019 16:01:28 +0200 (CEST)
Date:   Fri, 21 Jun 2019 16:01:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v10 11/16] sched/fair: uclamp: Add uclamp support to
 energy_compute()
Message-ID: <20190621140128.GL3436@hirez.programming.kicks-ass.net>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-12-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621084217.8167-12-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 21, 2019 at 09:42:12AM +0100, Patrick Bellasi wrote:

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ce2da8b9ff8c..f81e8930ff19 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2322,7 +2322,6 @@ static inline unsigned long capacity_orig_of(int cpu)
>  }
>  #endif
>  
> -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
>  /**
>   * enum schedutil_type - CPU utilization type
>   * @FREQUENCY_UTIL:	Utilization used to select frequency
> @@ -2338,15 +2337,11 @@ enum schedutil_type {
>  	ENERGY_UTIL,
>  };
>  
> -unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> -				  unsigned long max, enum schedutil_type type);
> -
> -static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
> -{
> -	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);

That conflicts with the patch I have removing that NULL argument, fixed
it up.

> +#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
>  
> -	return schedutil_freq_util(cpu, cfs, max, ENERGY_UTIL);
> -}
> +unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> +				 unsigned long max, enum schedutil_type type,
> +				 struct task_struct *p);
>  
>  static inline unsigned long cpu_bw_dl(struct rq *rq)
>  {
> @@ -2375,11 +2370,8 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
>  	return READ_ONCE(rq->avg_rt.util_avg);
>  }
>  #else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
> -static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
> -{
> -	return cfs;
> -}
> -#endif
> +#define schedutil_cpu_util(cpu, util_cfs, max, type, p) 0

Was there a good reason for this to be a macro and not an inline
function? I've changed it, if it explodes in 0day, it's all my fault ;-)

> +#endif /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */

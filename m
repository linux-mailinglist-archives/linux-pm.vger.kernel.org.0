Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943CCF939C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 16:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLPFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 10:05:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37688 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKLPFw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 10:05:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so3325297wmj.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 07:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+tyvV/5E996LDIHsndVKgQTT2nmYBAp+8tJn3tDeXsQ=;
        b=f78JwAVh8m3qh6NShS2kfGB+l5WgYxgRHV35SHkXE1PklwA5nVSF4r5xxM8FTSxf1J
         4+/53rGDs9v5RZ8stsxDWZHQw1eO248RJU7v06AY9MBn7nbzMvH4BEyYypbED4ba/lLK
         RqvuzsrzI0DkdUsw5r0tD2d8uZ2D3ChhszQjyT9Znem7nAwJRgznP128qlZtOSCA4wPF
         bSxoEWIv6wkL2USXfRcIq6Y7OCtfNXgYTbAo66X0W/LtY1VDYGgtlciDHIdkKpjPwICZ
         K1miVosbXCkopdxsGsch5Ua0Z08/8iXeORvuL35FMSRhA7wiiG16qJqyjPEnoy8m4HM1
         98Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+tyvV/5E996LDIHsndVKgQTT2nmYBAp+8tJn3tDeXsQ=;
        b=loCsclbCK523k1ToYV7kBU+xPnD73OwT0cZPAva+Ad/Zp3CmPmooVUhUpddUO8Z8Hl
         rKHxs60WRgJcXVil7YC6I/6C30MzHSGW2GmaDDjPXW92lUzHsiDbhWUZJIc2qqbpRPf5
         5nFIRYjVLd0m2Im6Ir5i/YdBK85JrYSgt5TW9kDBZoMc/Twg2NcnIrCVr51+jeMAh1/N
         SPNsrbHLaOxNz7nuzHxmxM0Cne/lrEM9SNzZLKHE88QxNyow/wN/4Nsev4iEfr0Po0g7
         6dVi+1SBdHud8XDWt6owCLV8wonmwe1s8LvXaGDuqQXgSC5z4bIx0CJceOJE6vfyo+R5
         b87g==
X-Gm-Message-State: APjAAAWBQraW+8AYtsl1HPEgTzGBgA9IY1zEaAnQUe17Q6MSsCrb+rZd
        xwraR5Sd5EGoNY2ytbMfk97Xxg==
X-Google-Smtp-Source: APXvYqxa+x5eG33cvaM0b8URg3VOtBVZUa/SJNjueQfR6wOQzh2Lw1y4I/Q0+z7SMr3SnUkHaW17Aw==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr4557023wml.149.1573571147460;
        Tue, 12 Nov 2019 07:05:47 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:e45f:4180:5590:a312])
        by smtp.gmail.com with ESMTPSA id r15sm42364990wrc.5.2019.11.12.07.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:05:46 -0800 (PST)
Date:   Tue, 12 Nov 2019 16:05:44 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v2] sched/freq: move call to cpufreq_update_util
Message-ID: <20191112150544.GA3664@linaro.org>
References: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le Tuesday 12 Nov 2019 à 15:48:13 (+0100), Vincent Guittot a écrit :
> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> which might be inefficient when cpufreq driver has rate limitation.
> 
> When a task is attached on a CPU, we have call path:
> 
> update_blocked_averages()
>   update_cfs_rq_load_avg()
>     cfs_rq_util_change -- > trig frequency update
>   attach_entity_load_avg()
>     cfs_rq_util_change -- > trig frequency update
> 
> The 1st frequency update will not take into account the utilization of the
> newly attached task and the 2nd one might be discard because of rate
> limitation of the cpufreq driver.
> 
> update_cfs_rq_load_avg() is only called by update_blocked_averages()
> and update_load_avg() so we can move the call to
> {cfs_rq,cpufreq}_util_change() into these 2 functions. It's also
> interesting to notice that update_load_avg() already calls directly
> cfs_rq_util_change() for !SMP case.
> 
> This changes will also ensure that cpufreq_update_util() is called even
> when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> irq, rt or dl pelt signals.
> 
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> ---
> 
> I have just rebased the patch on latest tip/sched/core and made it a proper
> patchset after Doug reported that the problem has diseappeared according to
> his 1st results but tests results are not all based on the same v5.4-rcX
> and with menu instead of teo governor.
> 
>  kernel/sched/fair.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e458f52..c93d534 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3508,9 +3508,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  	cfs_rq->load_last_update_time_copy = sa->last_update_time;
>  #endif
>  
> -	if (decayed)
> -		cfs_rq_util_change(cfs_rq, 0);
> -
>  	return decayed;
>  }
>  
> @@ -3620,8 +3617,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
>  		update_tg_load_avg(cfs_rq, 0);
>  
> -	} else if (decayed && (flags & UPDATE_TG))
> -		update_tg_load_avg(cfs_rq, 0);
> +	} else if (decayed) {
> +		cfs_rq_util_change(cfs_rq, 0);
> +
> +		if (flags & UPDATE_TG)
> +			update_tg_load_avg(cfs_rq, 0);
> +	}
>  }
>  
>  #ifndef CONFIG_64BIT
> @@ -7484,6 +7485,7 @@ static void update_blocked_averages(int cpu)
>  	const struct sched_class *curr_class;
>  	struct rq_flags rf;
>  	bool done = true;
> +	int decayed = 0;
>  
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
> @@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
>  	 * that RT, DL and IRQ signals have been updated before updating CFS.
>  	 */
>  	curr_class = rq->curr->sched_class;
> -	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -	update_irq_load_avg(rq, 0);
> +	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> +	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> +	decayed |= update_irq_load_avg(rq, 0);
>  
>  	/* Don't need periodic decay once load/util_avg are null */
>  	if (others_have_blocked(rq))
> @@ -7529,6 +7531,9 @@ static void update_blocked_averages(int cpu)
>  	}
>  
>  	update_blocked_load_status(rq, !done);
> +
> +	if (decayed)
> +		cpufreq_update_util(rq, 0);
>  	rq_unlock_irqrestore(rq, &rf);
>  }
>  
> @@ -7585,6 +7590,7 @@ static inline void update_blocked_averages(int cpu)
>  	struct cfs_rq *cfs_rq = &rq->cfs;
>  	const struct sched_class *curr_class;
>  	struct rq_flags rf;
> +	int decayed = 0;
>  
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
> @@ -7594,13 +7600,16 @@ static inline void update_blocked_averages(int cpu)
>  	 * that RT, DL and IRQ signals have been updated before updating CFS.
>  	 */
>  	curr_class = rq->curr->sched_class;
> -	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -	update_irq_load_avg(rq, 0);
> +	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> +	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> +	decayed |= update_irq_load_avg(rq, 0);
>  
> -	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +	decayed |= update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
>  
>  	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
> +
> +	if (decayed)
> +		cpufreq_update_util(rq, 0);
>  	rq_unlock_irqrestore(rq, &rf);
>  }
>  
> -- 
> 2.7.4
> 

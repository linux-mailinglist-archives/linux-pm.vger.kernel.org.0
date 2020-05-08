Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3881CA2AA
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgEHFbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 01:31:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:39813 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbgEHFbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 01:31:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588915871; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=yBlsnDa9mB7yVmBNrfzU9ebqr5YvNXeZgf6sXTZor6k=; b=ZBaKcMHhcXql44qPYwPwqZ9RAVpAaaQSJrs6A+N0XGWsyT1OZObOKZOUgxTfgeyncutaWMUw
 1fttH27zdQWuDNF9holnNjw9I3boBJ8u6En+7xKNVNnFjzVfhiKlVdaasLhFKUg1/9zP/Gci
 yzfoh+2vKpd2+C8yH62L+R6EUUs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb4ee9c.7efc26e3f8f0-smtp-out-n04;
 Fri, 08 May 2020 05:31:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E12BBC44798; Fri,  8 May 2020 05:31:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57574C433D2;
        Fri,  8 May 2020 05:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57574C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 8 May 2020 11:00:53 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 13/14] sched: cpufreq: Use IS_ENABLED() for schedutil
Message-ID: <20200508053053.GG19464@codeaurora.org>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-14-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507181012.29791-14-qperret@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Quentin

On Thu, May 07, 2020 at 07:10:11PM +0100, Quentin Perret wrote:
> The IS_ENABLED() macro evaluates to true when an option is set to =y or
> =m. As such, it is a good fit for tristate options.
> 
> In preparation for modularizing schedutil, change all the related ifdefs
> to use IS_ENABLED().
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  include/linux/cpufreq.h      | 2 +-
>  include/linux/sched/sysctl.h | 2 +-
>  kernel/sched/sched.h         | 4 ++--
>  kernel/sched/topology.c      | 4 ++--
>  kernel/sysctl.c              | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 267cc3b624da..c1176b8a0f61 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -983,7 +983,7 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
>  }
>  #endif
>  
> -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
>  			struct cpufreq_governor *old_gov);
>  #else
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index d4f6215ee03f..704d971f204f 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -94,7 +94,7 @@ extern int sysctl_schedstats(struct ctl_table *table, int write,
>  				 void __user *buffer, size_t *lenp,
>  				 loff_t *ppos);
>  
> -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  extern unsigned int sysctl_sched_energy_aware;
>  extern int sched_energy_aware_handler(struct ctl_table *table, int write,
>  				 void __user *buffer, size_t *lenp,
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 60592cde80e8..087508723e58 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -217,7 +217,7 @@ static inline void update_avg(u64 *avg, u64 sample)
>  
>  static inline bool dl_entity_is_special(struct sched_dl_entity *dl_se)
>  {
> -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> +#if IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  	return unlikely(dl_se->flags & SCHED_FLAG_SUGOV);
>  #else
>  	return false;
> @@ -2459,7 +2459,7 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
>  }
>  #endif
>  
> -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  
>  #define perf_domain_span(pd) (to_cpumask(((pd)->em_pd->cpus)))
>  
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b905f2e8d9b2..5f49d25730bd 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -201,7 +201,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
>  	return 1;
>  }
>  
> -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  DEFINE_STATIC_KEY_FALSE(sched_energy_present);
>  unsigned int sysctl_sched_energy_aware = 1;
>  DEFINE_MUTEX(sched_energy_mutex);
> @@ -2287,7 +2287,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>  		;
>  	}
>  
> -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  	/* Build perf. domains: */
>  	for (i = 0; i < ndoms_new; i++) {
>  		for (j = 0; j < n && !sched_energy_update; j++) {

Now that scheduler does not have any references to schedutil_gov and cpufreq
has want_eas flag, do we need this CONFIG_CPU_FREQ_GOV_SCHEDUTIL checks here?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

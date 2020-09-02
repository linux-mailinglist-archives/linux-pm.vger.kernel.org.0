Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C3025B00D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgIBPsm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 11:48:42 -0400
Received: from foss.arm.com ([217.140.110.172]:38028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBN2y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 09:28:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B637711B3;
        Wed,  2 Sep 2020 06:28:43 -0700 (PDT)
Received: from bogus (unknown [10.57.4.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B95723F68F;
        Wed,  2 Sep 2020 06:28:41 -0700 (PDT)
Date:   Wed, 2 Sep 2020 14:28:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200902132838.GF25462@bogus>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200901205549.30096-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901205549.30096-4-ionela.voinescu@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 09:55:47PM +0100, Ionela Voinescu wrote:
> Now that the update of the FI scale factor is done in cpufreq core for
> selected functions - target(), target_index() and fast_switch(),
> we can provide feedback to the task scheduler and architecture code
> on whether cpufreq supports FI.
> 
> For this purpose provide an external function to expose whether the
> cpufreq drivers support FI, by using a static key.
> 
> The logic behind the enablement of cpufreq-based invariance is as
> follows:
>  - cpufreq-based invariance is disabled by default
>  - cpufreq-based invariance is enabled if any of the callbacks
>    above is implemented while the unsupported setpolicy() is not
> 
> The cpufreq_supports_freq_invariance() function only returns whether
> cpufreq is instrumented with the arch_set_freq_scale() calls that
> result in support for frequency invariance. Due to the lack of knowledge
> on whether the implementation of arch_set_freq_scale() actually results
> in the setting of a scale factor based on cpufreq information, it is up
> to the architecture code to ensure the setting and provision of the
> scale factor to the scheduler.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++++++
>  include/linux/cpufreq.h   |  5 +++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4d5fe777184a..570bf2ebe9d4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -61,6 +61,12 @@ static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>  
> +static DEFINE_STATIC_KEY_FALSE(cpufreq_freq_invariance);
> +bool cpufreq_supports_freq_invariance(void)
> +{
> +	return static_branch_likely(&cpufreq_freq_invariance);
> +}
> +
>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
>  
> @@ -2720,6 +2726,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  	cpufreq_driver = driver_data;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
> +	/*
> +	 * Mark support for the scheduler's frequency invariance engine for
> +	 * drivers that implement target(), target_index() or fast_switch().
> +	 */
> +	if (!cpufreq_driver->setpolicy) {
> +		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
> +		pr_debug("supports frequency invariance");
> +	}
> +
>  	if (driver_data->setpolicy)

[super nit] while I understand cpufreq_driver = driver_data, it looks odd
if 2 consecutive statements refer it with different variables. Or am I
confusing myself hugely.

-- 
Regards,
Sudeep

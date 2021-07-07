Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696833BE654
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhGGK0w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 06:26:52 -0400
Received: from foss.arm.com ([217.140.110.172]:33842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231397AbhGGK0w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 06:26:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D3E4ED1;
        Wed,  7 Jul 2021 03:24:12 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DCCE3F694;
        Wed,  7 Jul 2021 03:24:12 -0700 (PDT)
Date:   Wed, 7 Jul 2021 11:24:10 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>, zhongkaihua@huawei.com
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
Message-ID: <20210707102410.GA4357@arm.com>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thursday 21 Jan 2021 at 16:47:43 (+0530), Viresh Kumar wrote:
> The dev_pm_opp_set_rate() helper needs to know the currently programmed
> OPP to make few decisions and currently we try to find it on every
> invocation of this routine.
> 
> Lets start keeping track of the current_opp programmed for the devices
> of the opp table, that will be quite useful going forward.
> 
> If we fail to find the current OPP, we pick the first one available in
> the list, as the list is in ascending order of frequencies, level, or
> bandwidth and that's the best guess we can make anyway.
> 
> Note that we used to do the frequency comparison a bit early in
> dev_pm_opp_set_rate() previously, and now instead we check the target
> opp, which shall be more accurate anyway.
> 
> We need to make sure that current_opp's memory doesn't get freed while
> it is being used and so we keep a reference of it until the time it is
> used.
> 
> Now that current_opp will always be set, we can drop some unnecessary
> checks as well.
> 

I'm seeing some intermittent issues on Hikey960 after this patch,
which reproduces as follows. I've used v5.13 for my testing.


root@buildroot:~# while true; do \
>     cd /sys/devices/system/cpu/cpufreq/; \
>     for policy in policy*; do \
>            cd /sys/devices/system/cpu/cpufreq/$policy; \
>            for freq in $(cat scaling_available_frequencies); do \
>                 echo "userspace" > scaling_governor; \
>                 sleep 1; \
>                 echo $freq > scaling_setspeed; \
>                 sleep 1; \
>                 cpu="${policy: -1}"; \
>                 mask="0x$(printf '%x\n' $((1 << $cpu)))"; \
>                 sysev=$(~/taskset $mask ~/sysbench run --test=cpu --max-time=1 | grep "total number of events"); \
>                 delivered=$(cat cpuinfo_cur_freq); \
>                 if [ "$freq" != "$delivered" ]; then \
>                         echo "CPU$cpu - $freq setting failed: delivered $delivered, sysevents: $sysev"; \
>                 else \
>                         echo "CPU$cpu - $freq setting succeeded: delivered $delivered, sysevents: $sysev"; \
>                 fi; \
>                 echo "schedutil" > scaling_governor; \
>                 sleep 1; \
>                 done; done; done;

CPU0 - 533000 setting succeeded: delivered 533000, sysevents:     total number of events:              112
CPU0 - 999000 setting succeeded: delivered 999000, sysevents:     total number of events:              209
CPU0 - 1402000 setting succeeded: delivered 1402000, sysevents:     total number of events:              293
CPU0 - 1709000 setting succeeded: delivered 1709000, sysevents:     total number of events:              357
CPU0 - 1844000 setting succeeded: delivered 1844000, sysevents:     total number of events:              385
CPU4 - 903000 setting succeeded: delivered 903000, sysevents:     total number of events:              249
CPU4 - 1421000 setting succeeded: delivered 1421000, sysevents:     total number of events:              395
CPU4 - 1805000 setting succeeded: delivered 1805000, sysevents:     total number of events:              502
CPU4 - 2112000 setting succeeded: delivered 2112000, sysevents:     total number of events:              588
CPU4 - 2362000 setting succeeded: delivered 2362000, sysevents:     total number of events:              657

This is an example of good behavior of changing frequencies. I'm putting
this here first to show the sysbench results for each frequency, which is
helping me make sure that the performance matches the new set frequency.

Notes: the change to the schedutil governor after each userspace driven
frequency change was added because if the change is always to higher
frequencies, the issue does not reproduce as easily; the sleep commands
are added just to make sure the change gets the time to take effect.

From time to time (7/400 fail rate), I get the following failures:

CPU0 - 533000 setting failed: delivered 1402000, sysevents:     total number of events:              293
CPU0 - 1402000 setting failed: delivered 533000, sysevents:     total number of events:              112
CPU0 - 1402000 setting failed: delivered 533000, sysevents:     total number of events:              112
CPU4 - 903000 setting failed: delivered 1421000, sysevents:     total number of events:              394
CPU4 - 1805000 setting failed: delivered 903000, sysevents:     total number of events:              249
CPU0 - 533000 setting failed: delivered 1402000, sysevents:     total number of events:              293
CPU4 - 1805000 setting failed: delivered 903000, sysevents:     total number of events:              251

Now comes the interesting part: what seems to fix it is a call to
clk_get_rate(opp_table->clk) in _set_opp(), which is what basically
happened before this patch, as _find_current_opp() was always called.
I do not need to do anything with the returned frequency.

Therefore, by adding:
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e366218d6736..2fdaf97f7ded 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -987,6 +987,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 {
        struct dev_pm_opp *old_opp;
        int scaling_down, ret;
+       unsigned long cur_freq;

        if (unlikely(!opp))
                return _disable_opp_table(dev, opp_table);
@@ -994,6 +995,13 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
        /* Find the currently set OPP if we don't know already */
        if (unlikely(!opp_table->current_opp))
                _find_current_opp(dev, opp_table);
+       else if (!IS_ERR(opp_table->clk)) {
+                       cur_freq = clk_get_rate(opp_table->clk);
+                       if (opp_table->current_rate != cur_freq)
+                               pr_err("OPP mismatch: %lu vs %lu!",
+                                      opp_table->current_rate,
+                                      cur_freq);
+               }

        old_opp = opp_table->current_opp;

.. it does seem to solve the problem (no failures in 1000 frequency changes),
although I do get a few OPP mismatch logs:

[  667.495112] core: OPP mismatch: 1709000000 vs 1402000000!
[ 7260.656154] core: OPP mismatch: 1421000000 vs 903000000!
[ 7260.727717] core: OPP mismatch: 903000000 vs 1421000000!
[ 8847.304323] core: OPP mismatch: 1709000000 vs 1402000000!


I'm not sure what is happening here so I'm hoping you guys have more
knowledge to steer debugging in the right direction.

To be noted that I'm running an equivalent variant of this test on
multiple boards, and none of them have issues, except for Hikey960.

Thanks,
Ionela.


> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 83 +++++++++++++++++++++++++++++-----------------
>  drivers/opp/opp.h  |  2 ++
>  2 files changed, 55 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index cb5b67ccf5cf..4ee598344e6a 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -788,8 +788,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
>  			__func__, old_freq);
>  restore_voltage:
>  	/* This shouldn't harm even if the voltages weren't updated earlier */
> -	if (old_supply)
> -		_set_opp_voltage(dev, reg, old_supply);
> +	_set_opp_voltage(dev, reg, old_supply);
>  
>  	return ret;
>  }
> @@ -839,10 +838,7 @@ static int _set_opp_custom(const struct opp_table *opp_table,
>  
>  	data->old_opp.rate = old_freq;
>  	size = sizeof(*old_supply) * opp_table->regulator_count;
> -	if (!old_supply)
> -		memset(data->old_opp.supplies, 0, size);
> -	else
> -		memcpy(data->old_opp.supplies, old_supply, size);
> +	memcpy(data->old_opp.supplies, old_supply, size);
>  
>  	data->new_opp.rate = freq;
>  	memcpy(data->new_opp.supplies, new_supply, size);
> @@ -943,6 +939,31 @@ int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
>  
> +static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
> +{
> +	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
> +	unsigned long freq;
> +
> +	if (!IS_ERR(opp_table->clk)) {
> +		freq = clk_get_rate(opp_table->clk);
> +		opp = _find_freq_ceil(opp_table, &freq);
> +	}
> +
> +	/*
> +	 * Unable to find the current OPP ? Pick the first from the list since
> +	 * it is in ascending order, otherwise rest of the code will need to
> +	 * make special checks to validate current_opp.
> +	 */
> +	if (IS_ERR(opp)) {
> +		mutex_lock(&opp_table->lock);
> +		opp = list_first_entry(&opp_table->opp_list, struct dev_pm_opp, node);
> +		dev_pm_opp_get(opp);
> +		mutex_unlock(&opp_table->lock);
> +	}
> +
> +	opp_table->current_opp = opp;
> +}
> +
>  static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
>  {
>  	int ret;
> @@ -1004,16 +1025,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  	if ((long)freq <= 0)
>  		freq = target_freq;
>  
> -	old_freq = clk_get_rate(opp_table->clk);
> -
> -	/* Return early if nothing to do */
> -	if (opp_table->enabled && old_freq == freq) {
> -		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
> -			__func__, freq);
> -		ret = 0;
> -		goto put_opp_table;
> -	}
> -
>  	/*
>  	 * For IO devices which require an OPP on some platforms/SoCs
>  	 * while just needing to scale the clock on some others
> @@ -1026,12 +1037,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		goto put_opp_table;
>  	}
>  
> -	temp_freq = old_freq;
> -	old_opp = _find_freq_ceil(opp_table, &temp_freq);
> -	if (IS_ERR(old_opp)) {
> -		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
> -			__func__, old_freq, PTR_ERR(old_opp));
> -	}
> +	/* Find the currently set OPP if we don't know already */
> +	if (unlikely(!opp_table->current_opp))
> +		_find_current_opp(dev, opp_table);
>  
>  	temp_freq = freq;
>  	opp = _find_freq_ceil(opp_table, &temp_freq);
> @@ -1039,7 +1047,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		ret = PTR_ERR(opp);
>  		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
>  			__func__, freq, ret);
> -		goto put_old_opp;
> +		goto put_opp_table;
> +	}
> +
> +	old_opp = opp_table->current_opp;
> +	old_freq = old_opp->rate;
> +
> +	/* Return early if nothing to do */
> +	if (opp_table->enabled && old_opp == opp) {
> +		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
> +		ret = 0;
> +		goto put_opp;
>  	}
>  
>  	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
> @@ -1054,11 +1072,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  
>  	if (opp_table->set_opp) {
>  		ret = _set_opp_custom(opp_table, dev, old_freq, freq,
> -				      IS_ERR(old_opp) ? NULL : old_opp->supplies,
> -				      opp->supplies);
> +				      old_opp->supplies, opp->supplies);
>  	} else if (opp_table->regulators) {
>  		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
> -						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
> +						 old_opp->supplies,
>  						 opp->supplies);
>  	} else {
>  		/* Only frequency scaling */
> @@ -1074,15 +1091,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  
>  	if (!ret) {
>  		ret = _set_opp_bw(opp_table, opp, dev, false);
> -		if (!ret)
> +		if (!ret) {
>  			opp_table->enabled = true;
> +			dev_pm_opp_put(old_opp);
> +
> +			/* Make sure current_opp doesn't get freed */
> +			dev_pm_opp_get(opp);
> +			opp_table->current_opp = opp;
> +		}
>  	}
>  
>  put_opp:
>  	dev_pm_opp_put(opp);
> -put_old_opp:
> -	if (!IS_ERR(old_opp))
> -		dev_pm_opp_put(old_opp);
>  put_opp_table:
>  	dev_pm_opp_put_opp_table(opp_table);
>  	return ret;
> @@ -1276,6 +1296,9 @@ static void _opp_table_kref_release(struct kref *kref)
>  	list_del(&opp_table->node);
>  	mutex_unlock(&opp_table_lock);
>  
> +	if (opp_table->current_opp)
> +		dev_pm_opp_put(opp_table->current_opp);
> +
>  	_of_clear_opp_table(opp_table);
>  
>  	/* Release clk */
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 4408cfcb0f31..359fd89d5770 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -135,6 +135,7 @@ enum opp_table_access {
>   * @clock_latency_ns_max: Max clock latency in nanoseconds.
>   * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
>   * @shared_opp: OPP is shared between multiple devices.
> + * @current_opp: Currently configured OPP for the table.
>   * @suspend_opp: Pointer to OPP to be used during device suspend.
>   * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
>   * @genpd_virt_devs: List of virtual devices for multiple genpd support.
> @@ -183,6 +184,7 @@ struct opp_table {
>  
>  	unsigned int parsed_static_opps;
>  	enum opp_table_access shared_opp;
> +	struct dev_pm_opp *current_opp;
>  	struct dev_pm_opp *suspend_opp;
>  
>  	struct mutex genpd_virt_dev_lock;
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
> 

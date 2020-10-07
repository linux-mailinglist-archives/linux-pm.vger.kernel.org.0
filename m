Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB772861E0
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgJGPM2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 11:12:28 -0400
Received: from foss.arm.com ([217.140.110.172]:45312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgJGPM2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 11:12:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4919A106F;
        Wed,  7 Oct 2020 08:12:27 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4AD3F66B;
        Wed,  7 Oct 2020 08:12:26 -0700 (PDT)
Date:   Wed, 7 Oct 2020 16:12:25 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amit.kucheria@verdurent.com,
        airlied@linux.ie, daniel.lezcano@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, rui.zhang@intel.com,
        orjan.eide@arm.com
Subject: Re: [PATCH 4/5] thermal: devfreq_cooling: remove old power model and
 use EM
Message-ID: <20201007151225.GB15063@arm.com>
References: <20200921122007.29610-1-lukasz.luba@arm.com>
 <20200921122007.29610-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921122007.29610-5-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Monday 21 Sep 2020 at 13:20:06 (+0100), Lukasz Luba wrote:
[..]
>  /**
> - * freq_get_state() - get the cooling state corresponding to a frequency
> + * freq_get_state() - get the performance index corresponding to a frequency

If we change the meaning of the return value, I think the function needs
a name change as well.

Also, we do treat this as a cooling state when we do validation and
compare it to THERMAL_CSTATE_INVALID,  but it's not actually a cooling
state (it's max_state - state). It does create confusion if we name
"state" both a performance index and a cooling state.

Given that the only user is devfreq_cooling_get_requested_power(),
might be good to collapse freq_get_state() in that function and rename
the "state" variable in there to "em_perf_idx".

>   * @dfc:	Pointer to devfreq cooling device
> - * @freq:	frequency in Hz
> + * @freq:	frequency in kHz
>   *
> - * Return: the cooling state associated with the @freq, or
> + * Return: the performance index associated with the @freq, or
>   * THERMAL_CSTATE_INVALID if it wasn't found.
>   */
>  static unsigned long
> @@ -128,8 +130,8 @@ freq_get_state(struct devfreq_cooling_device *dfc, unsigned long freq)
>  {
>  	int i;
>  
> -	for (i = 0; i < dfc->freq_table_size; i++) {
> -		if (dfc->freq_table[i] == freq)
> +	for (i = 0; i <= dfc->max_state; i++) {
> +		if (dfc->em->table[i].frequency == freq)
>  			return i;
>  	}
>  
> @@ -164,71 +166,15 @@ static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
>  	return voltage;
>  }
>  
> -/**
> - * get_static_power() - calculate the static power
> - * @dfc:	Pointer to devfreq cooling device
> - * @freq:	Frequency in Hz
> - *
> - * Calculate the static power in milliwatts using the supplied
> - * get_static_power().  The current voltage is calculated using the
> - * OPP library.  If no get_static_power() was supplied, assume the
> - * static power is negligible.
> - */
> -static unsigned long
> -get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
> +static void dfc_em_get_requested_power(struct em_perf_domain *em,
> +				       struct devfreq_dev_status *status,
> +				       u32 *power, int em_perf_idx)

Is there a reason for not directly returning the power value in this
function? Also, this only does a few arithmetic operations and it's only
called in one place. Is it worth to have this in a separate function?

[..]
> @@ -345,11 +279,8 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>  	struct devfreq_cooling_device *dfc = cdev->devdata;
>  	struct devfreq *df = dfc->devfreq;
>  	struct devfreq_dev_status status;
> -	unsigned long busy_time;
> +	u32 est_power = power;

Nit: You could use power directly and remove est_power as well.

>  	unsigned long freq;
> -	s32 dyn_power;
> -	u32 static_power;
> -	s32 est_power;
>  	int i;
>  
>  	mutex_lock(&df->lock);
> @@ -358,31 +289,26 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>  
>  	freq = status.current_frequency;
>  
> -	if (dfc->power_ops->get_real_power) {
> +	if (dfc->power_ops && dfc->power_ops->get_real_power) {
>  		/* Scale for resource utilization */
>  		est_power = power * dfc->res_util;
>  		est_power /= SCALE_ERROR_MITIGATION;
>  	} else {
> -		static_power = get_static_power(dfc, freq);
> -
> -		dyn_power = power - static_power;
> -		dyn_power = dyn_power > 0 ? dyn_power : 0;
> -
> -		/* Scale dynamic power for utilization */
> -		busy_time = status.busy_time ?: 1;
> -		est_power = (dyn_power * status.total_time) / busy_time;
> +		_normalize_load(&status);
> +		est_power *= status.total_time;
> +		est_power /= status.busy_time;
>  	}
>  
>  	/*
>  	 * Find the first cooling state that is within the power
> -	 * budget for dynamic power.
> +	 * budget. The EM power table is sorted ascending.
>  	 */
> -	for (i = 0; i < dfc->freq_table_size - 1; i++)
> -		if (est_power >= dfc->power_table[i])
> +	for (i = dfc->max_state; i > 0; i--)
> +		if (est_power >= dfc->em->table[i].power)
>  			break;
>  
> -	*state = i;
> -	dfc->capped_state = i;
> +	*state = dfc->max_state - i;
> +	dfc->capped_state = *state;
>  	trace_thermal_power_devfreq_limit(cdev, freq, *state, power);
>  	return 0;
>  }
[..]
>  /**
> @@ -503,7 +381,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  	struct thermal_cooling_device *cdev;
>  	struct devfreq_cooling_device *dfc;
>  	char dev_name[THERMAL_NAME_LENGTH];
> -	int err;
> +	int err, num_opps;
>  
>  	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
>  	if (!dfc)
> @@ -511,28 +389,45 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  
>  	dfc->devfreq = df;
>  
> -	if (dfc_power) {
> -		dfc->power_ops = dfc_power;
> -
> +	dfc->em = em_pd_get(df->dev.parent);
> +	if (dfc->em) {
>  		devfreq_cooling_ops.get_requested_power =
>  			devfreq_cooling_get_requested_power;
>  		devfreq_cooling_ops.state2power = devfreq_cooling_state2power;
>  		devfreq_cooling_ops.power2state = devfreq_cooling_power2state;
> +
> +		dfc->power_ops = dfc_power;
> +
> +		num_opps = em_pd_nr_perf_states(dfc->em);
> +	} else {
> +		/* Backward compatibility for drivers which do not use IPA */
> +		dev_dbg(df->dev.parent, "missing EM for cooling device\n");
> +
> +		num_opps = dev_pm_opp_get_opp_count(df->dev.parent);
> +
> +		err = devfreq_cooling_gen_tables(dfc, num_opps);
> +		if (err)
> +			goto free_dfc;
>  	}
>  
> -	err = devfreq_cooling_gen_tables(dfc);
> -	if (err)
> +	if (num_opps <= 0) {
> +		err = -EINVAL;
>  		goto free_dfc;
> +	}
> +
> +	/* max_state is an index, not a counter */

Nit: Might be more clear to replace "index" with cooling state. Then
knowledge about cooling states would make this more clear.

Regards,
Ionela.

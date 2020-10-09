Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7512887BF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbgJILTR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 07:19:17 -0400
Received: from foss.arm.com ([217.140.110.172]:48404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgJILTR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 07:19:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 021A5D6E;
        Fri,  9 Oct 2020 04:19:16 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970063F66B;
        Fri,  9 Oct 2020 04:19:15 -0700 (PDT)
Date:   Fri, 9 Oct 2020 12:19:14 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH v2 2/2] thermal: power allocator: change how estimation
 code is called
Message-ID: <20201009111906.GA5207@arm.com>
References: <20201008170426.465-1-lukasz.luba@arm.com>
 <20201008170426.465-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008170426.465-3-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Thursday 08 Oct 2020 at 18:04:26 (+0100), Lukasz Luba wrote:
> The sustainable power value might come from the Device Tree or can be
> estimated in run time. There is no need to estimate every time when the
> governor is called and temperature is high. Instead, store the estimated
> value and make it available via standard sysfs interface so it can be
> checked from the user-space. Re-invoke the estimation only in case the
> sustainable power was set to 0. Apart from that the PID coefficients
> are not going to be force updated thus can better handle sysfs settings.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 56 +++++++++++++--------------
>  1 file changed, 26 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index aa35aa6c561c..1ad8d9c2685f 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -96,6 +96,9 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
>  		if (instance->trip != params->trip_max_desired_temperature)
>  			continue;
>  
> +		if (!cdev_is_power_actor(cdev))
> +			continue;
> +
>  		if (cdev->ops->state2power(cdev, tz, instance->upper,
>  					   &min_power))
>  			continue;
> @@ -109,31 +112,28 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
>  /**
>   * estimate_pid_constants() - Estimate the constants for the PID controller
      ^^^^^^^^^^^^^^^^^^^^^^
      estimate_tzp_constants()?

When called in pid_controller() it feels strange that we check for
sustainable_power, then we call estimate_pid_constants() and then we
magically have an non-zero sustainable_power. Therefore, it would be
good to change the name to indicate it's not only the PID constants that
are estimated.

>   * @tz:		thermal zone for which to estimate the constants
> - * @sustainable_power:	sustainable power for the thermal zone
>   * @trip_switch_on:	trip point number for the switch on temperature
>   * @control_temp:	target temperature for the power allocator governor
> - * @force:	whether to force the update of the constants
>   *
>   * This function is used to update the estimation of the PID
>   * controller constants in struct thermal_zone_parameters.

How about replacing this with: 

"""
 * This function is used to estimate the sustainable power and PID controller
 * constants in struct thermal_zone_parameters. These estimations will then be
 * available in sysfs.
"""

> - * Sustainable power is provided in case it was estimated.  The
> - * estimated sustainable_power should not be stored in the
> - * thermal_zone_parameters so it has to be passed explicitly to this
> - * function.
> - *
> - * If @force is not set, the values in the thermal zone's parameters
> - * are preserved if they are not zero.  If @force is set, the values
> - * in thermal zone's parameters are overwritten.
> + * Sustainable power is going to be estimated in case it is 0.
>   */
>  static void estimate_pid_constants(struct thermal_zone_device *tz,
> -				   u32 sustainable_power, int trip_switch_on,
> -				   int control_temp, bool force)
> +				   int trip_switch_on, int control_temp)
>  {
> -	int ret;
> -	int switch_on_temp;
> +	u32 sustainable_power = tz->tzp->sustainable_power;
>  	u32 temperature_threshold;
> +	int switch_on_temp;
> +	int ret;
>  	s32 k_i;
>  
> +	if (!sustainable_power) {
> +		sustainable_power = estimate_sustainable_power(tz);
> +		/* Make the estimation available in sysfs */

I would remove this comment from here. The reason is that this is not a
special case. This will happen for all the tzp parameters set below.
That's why I suggested adding this to the overall function comment above.

> +		tz->tzp->sustainable_power = sustainable_power;
> +	}
> +
>  	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
>  	if (ret)
>  		switch_on_temp = 0;
> @@ -150,15 +150,15 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  	if (!temperature_threshold)
>  		return;
>  
> -	if (!tz->tzp->k_po || force)
> +	if (!tz->tzp->k_po)
>  		tz->tzp->k_po = int_to_frac(sustainable_power) /
>  			temperature_threshold;
>  
> -	if (!tz->tzp->k_pu || force)
> +	if (!tz->tzp->k_pu)
>  		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
>  			temperature_threshold;
>  
> -	if (!tz->tzp->k_i || force) {
> +	if (!tz->tzp->k_i) {
>  		k_i = tz->tzp->k_pu / 10;
>  		tz->tzp->k_i = k_i > 0 ? k_i : 1;
>  	}

(Possibly judgement call)

I agree we don't need the force argument to this function, but I would
still keep an internal force variable (default false) to be set to true
when we estimate and set the sustainable power.

The reason for this is that there is no guarantee that when
sustainable_power is found to be 0 and estimated, we'll then find all of
the PID constants 0 as well in order to set them to a sane default.
Basically my worry is that we'll end up with a combination of PID
constants and sustainable power (some estimated and some not) that is not
quite sane.

But I understand a potential usecase in which a user might want to set
it's own PID constants while wanting an estimated sustainable_power.
But for this do you think it might be worth just having a pr_info
message saying that "Sustainable power is 0; will estimate sustainable
power and PID constants."? For this the user would only have to know
that they need to set the sustainable_power to 0 first and then
populate its own PID constants if they want to.

> @@ -198,14 +198,11 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>  
>  	max_power_frac = int_to_frac(max_allocatable_power);
>  
> -	if (tz->tzp->sustainable_power) {
> -		sustainable_power = tz->tzp->sustainable_power;
> -	} else {
> -		sustainable_power = estimate_sustainable_power(tz);
> -		estimate_pid_constants(tz, sustainable_power,
> -				       params->trip_switch_on, control_temp,
> -				       true);
> -	}
> +	if (!tz->tzp->sustainable_power)
> +		estimate_pid_constants(tz, params->trip_switch_on,
> +				       control_temp);
> +
> +	sustainable_power = tz->tzp->sustainable_power;
>  

(Nit)

This is only used once below in:
power_range = sustainable_power + frac_to_int(power_range);

I think we can use tz->tzp->sustainable_power directly there and
completely remove sustainable_power.

Thank you,
Ionela.

>  	err = control_temp - tz->temperature;
>  	err = int_to_frac(err);
> @@ -603,20 +600,19 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>  
>  	get_governor_trips(tz, params);
>  
> +	tz->governor_data = params;
> +
>  	if (tz->trips > 0) {
>  		ret = tz->ops->get_trip_temp(tz,
>  					params->trip_max_desired_temperature,
>  					&control_temp);
>  		if (!ret)
> -			estimate_pid_constants(tz, tz->tzp->sustainable_power,
> -					       params->trip_switch_on,
> -					       control_temp, false);
> +			estimate_pid_constants(tz, params->trip_switch_on,
> +					       control_temp);
>  	}
>  
>  	reset_pid_controller(params);
>  
> -	tz->governor_data = params;
> -
>  	return 0;
>  
>  free_params:
> -- 
> 2.17.1
> 

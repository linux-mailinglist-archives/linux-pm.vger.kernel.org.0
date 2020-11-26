Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91CD2C58EC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 17:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391437AbgKZP7v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 10:59:51 -0500
Received: from foss.arm.com ([217.140.110.172]:37862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391429AbgKZP7v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 10:59:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DBAA31B;
        Thu, 26 Nov 2020 07:59:50 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F17E3F23F;
        Thu, 26 Nov 2020 07:59:49 -0800 (PST)
Date:   Thu, 26 Nov 2020 15:59:48 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH v4 2/3] thermal: power allocator: refactor sustainable
 power estimation
Message-ID: <20201126155948.GA25966@arm.com>
References: <20201124161025.27694-1-lukasz.luba@arm.com>
 <20201124161025.27694-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124161025.27694-3-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey,

Mostly trivial nits (added in case you want to consider them for this code
or future changes).

On Tuesday 24 Nov 2020 at 16:10:24 (+0000), Lukasz Luba wrote:
> The sustainable power value might come from the Device Tree or can be
> estimated in run time. The sustainable power might be updated by the user
> via sysfs interface, which should trigger new estimation of PID
> coefficients. There is no need to estimate it every time when the
> governor is called and temperature is high. Instead, store the estimated
> value and make it available via standard sysfs interface, so it can be
> checked from the user-space.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 52 ++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 2e20085ed217..d7e4b9f6af60 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -63,6 +63,8 @@ static inline s64 div_frac(s64 x, s64 y)
>   * @trip_max_desired_temperature:	last passive trip point of the thermal
>   *					zone.  The temperature we are
>   *					controlling for.
> + * @sustainable_power:	Sustainable power (heat) that this thermal zone can
> + *			dissipate
>   */
>  struct power_allocator_params {
>  	bool allocated_tzp;
> @@ -70,6 +72,7 @@ struct power_allocator_params {
>  	s32 prev_err;
>  	int trip_switch_on;
>  	int trip_max_desired_temperature;
> +	u32 sustainable_power;
>  };
>  
>  /**
> @@ -118,10 +121,6 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
>   *
>   * This function is used to update the estimation of the PID
>   * controller constants in struct thermal_zone_parameters.
> - * Sustainable power is provided in case it was estimated.  The
> - * estimated sustainable_power should not be stored in the
> - * thermal_zone_parameters so it has to be passed explicitly to this
> - * function.
>   *
>   * If @force is not set, the values in the thermal zone's parameters
>   * are preserved if they are not zero.  If @force is set, the values
> @@ -171,6 +170,42 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  	 */
>  }
>  
> +/**
> + * get_sustainable_power() - Get the right sustainable power
                                    ^^^^^^^^^
Nit: I would not say there is a right sustainable power. I would remove
this.

> + * @tz:		thermal zone for which to estimate the constants
> + * @params:	parameters for the power allocator governor
> + * @control_temp:	target temperature for the power allocator governor
> + *
> + * This function is used for getting the proper sustainable power value based
> + * on variables which might be updated by the user sysfs interface. If that
                                          ^^
					  through
> + * happen the new value is going to be estimated and updated. It is also used

Nit: "If that happens, the new.."

> + * after thermal zone binding, where the initial values where set to 0.
                                                    ^^^^^^^^^^^^^^^^^^^^^
						    value could be 0.
> + */

Nit: I think the code is self explanatory so you might not need to go
into so many details in the description.

> +static u32 get_sustainable_power(struct thermal_zone_device *tz,
> +				 struct power_allocator_params *params,
> +				 int control_temp)
> +{
> +	u32 sustainable_power;
> +

Given that we call this every time the controller kicks in, it might
help to add unlikely to both conditions. I think the most likely
scenario is for our stored params->sustainable_power and
tz->tzp->sustainable_power to match.

> +	if (!tz->tzp->sustainable_power)
> +		sustainable_power = estimate_sustainable_power(tz);
> +	else
> +		sustainable_power = tz->tzp->sustainable_power;
> +
> +	/* Check if it's init value 0 or there was update via sysfs */
> +	if (sustainable_power != params->sustainable_power) {
> +		estimate_pid_constants(tz, sustainable_power,
> +				       params->trip_switch_on, control_temp,
> +				       true);
> +
> +		/* Do the estimation only once and make available in sysfs */
> +		tz->tzp->sustainable_power = sustainable_power;
> +		params->sustainable_power = sustainable_power;
> +	}
> +
> +	return sustainable_power;
> +}
> +
>  /**
>   * pid_controller() - PID controller
>   * @tz:	thermal zone we are operating in
> @@ -200,14 +235,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
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
> +	sustainable_power = get_sustainable_power(tz, params, control_temp);
>  
>  	err = control_temp - tz->temperature;
>  	err = int_to_frac(err);
> -- 

The logic seems sane so:

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thank you,
Ionela.

> 2.17.1
> 

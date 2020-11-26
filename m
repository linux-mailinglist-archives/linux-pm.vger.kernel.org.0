Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34822C58F3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 17:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391467AbgKZQA3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 11:00:29 -0500
Received: from foss.arm.com ([217.140.110.172]:37916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391518AbgKZQA3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 11:00:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E259131B;
        Thu, 26 Nov 2020 08:00:28 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847EE3F23F;
        Thu, 26 Nov 2020 08:00:28 -0800 (PST)
Date:   Thu, 26 Nov 2020 16:00:27 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH v4 3/3] thermal: power allocator: change the 'k_*' always
 in estimate_pid_constants()
Message-ID: <20201126160027.GA28582@arm.com>
References: <20201124161025.27694-1-lukasz.luba@arm.com>
 <20201124161025.27694-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124161025.27694-4-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 24 Nov 2020 at 16:10:25 (+0000), Lukasz Luba wrote:
> The PID coefficients should be estimated again when there was a change to
> sustainable power value made by user. This change removes unused argument
> 'force' and makes the function ready for such updates.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 28 +++++++++------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index d7e4b9f6af60..7a4170a0b51f 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -117,18 +117,13 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
>   * @sustainable_power:	sustainable power for the thermal zone
>   * @trip_switch_on:	trip point number for the switch on temperature
>   * @control_temp:	target temperature for the power allocator governor
> - * @force:	whether to force the update of the constants
>   *
>   * This function is used to update the estimation of the PID
>   * controller constants in struct thermal_zone_parameters.
> - *
> - * If @force is not set, the values in the thermal zone's parameters
> - * are preserved if they are not zero.  If @force is set, the values
> - * in thermal zone's parameters are overwritten.
>   */
>  static void estimate_pid_constants(struct thermal_zone_device *tz,
>  				   u32 sustainable_power, int trip_switch_on,
> -				   int control_temp, bool force)
> +				   int control_temp)
>  {
>  	int ret;
>  	int switch_on_temp;
> @@ -151,18 +146,14 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  	if (!temperature_threshold)
>  		return;
>  
> -	if (!tz->tzp->k_po || force)
> -		tz->tzp->k_po = int_to_frac(sustainable_power) /
> -			temperature_threshold;
> +	tz->tzp->k_po = int_to_frac(sustainable_power) /
> +		temperature_threshold;
>  
> -	if (!tz->tzp->k_pu || force)
> -		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
> -			temperature_threshold;
> +	tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
> +		temperature_threshold;
>  
> -	if (!tz->tzp->k_i || force) {
> -		k_i = tz->tzp->k_pu / 10;
> -		tz->tzp->k_i = k_i > 0 ? k_i : 1;
> -	}
> +	k_i = tz->tzp->k_pu / 10;
> +	tz->tzp->k_i = k_i > 0 ? k_i : 1;
>  
>  	/*
>  	 * The default for k_d and integral_cutoff is 0, so we can
> @@ -195,8 +186,7 @@ static u32 get_sustainable_power(struct thermal_zone_device *tz,
>  	/* Check if it's init value 0 or there was update via sysfs */
>  	if (sustainable_power != params->sustainable_power) {
>  		estimate_pid_constants(tz, sustainable_power,
> -				       params->trip_switch_on, control_temp,
> -				       true);
> +				       params->trip_switch_on, control_temp);
>  
>  		/* Do the estimation only once and make available in sysfs */
>  		tz->tzp->sustainable_power = sustainable_power;
> @@ -640,7 +630,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>  		if (!ret)
>  			estimate_pid_constants(tz, tz->tzp->sustainable_power,
>  					       params->trip_switch_on,
> -					       control_temp, false);
> +					       control_temp);
>  	}
>  
>  	reset_pid_controller(params);
> -- 

I was actually wondering why we still need force, while reading 2/3.

It looks good!

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

> 2.17.1
> 

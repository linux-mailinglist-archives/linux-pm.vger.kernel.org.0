Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6558228898D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 15:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbgJINFm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 09:05:42 -0400
Received: from foss.arm.com ([217.140.110.172]:50840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbgJINFl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 09:05:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BAC21063;
        Fri,  9 Oct 2020 06:05:41 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0F0E3F70D;
        Fri,  9 Oct 2020 06:05:40 -0700 (PDT)
Date:   Fri, 9 Oct 2020 14:05:39 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH v2 1/2] thermal: power allocator: change the 'k_i'
 coefficient estimation
Message-ID: <20201009130539.GB5207@arm.com>
References: <20201008170426.465-1-lukasz.luba@arm.com>
 <20201008170426.465-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008170426.465-2-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 08 Oct 2020 at 18:04:25 (+0100), Lukasz Luba wrote:
> Intelligent Power Allocation (IPA) is built around the PID controller
> concept. The initialization code tries to setup the environment based on
> the information available in DT or estimate the value based on minimum
> power reported by each of the cooling device. The estimation will have an
> impact on the PID controller behaviour via the related 'k_po', 'k_pu',
> 'k_i' coefficients and also on the power budget calculation.
> 
> This change prevents the situation when 'k_i' is relatively big compared
> to 'k_po' and 'k_pu' values. This might happen when the estimation for
> 'sustainable_power' returned small value, thus 'k_po' and 'k_pu' are
> small.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index e566806f1550..aa35aa6c561c 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -132,6 +132,7 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  	int ret;
>  	int switch_on_temp;
>  	u32 temperature_threshold;
> +	s32 k_i;
>  
>  	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
>  	if (ret)
> @@ -157,8 +158,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
>  			temperature_threshold;
>  
> -	if (!tz->tzp->k_i || force)
> -		tz->tzp->k_i = int_to_frac(10) / 1000;
> +	if (!tz->tzp->k_i || force) {
> +		k_i = tz->tzp->k_pu / 10;
> +		tz->tzp->k_i = k_i > 0 ? k_i : 1;
> +	}

I spent some time to understand how smaller or bigger values here impact
the stability of the output and its closeness to the control temperature
so I could give you and informed review :).

I did observed that if the k_i value has the same order of magnitude as
k_p, the output oscillates more, so I do believe this is a good change
to have.

What I also observed is that a small k_d value could be very beneficial
in quicker stabilising the oscillation and saw that it's recommended to
have for temperature, or in general for systems with measurement lag.

It's probably worth experimenting with some real systems first, but I
wonder if setting k_d to 1 as well is a good default. The risk is that
we will end up too conservative and not take advantage of some power
budget that's actually still left on the table. In any case, this is a
story for another time :).

For these changes:

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Regards,
Ionela.

> +
>  	/*
>  	 * The default for k_d and integral_cutoff is 0, so we can
>  	 * leave them as they are.
> -- 
> 2.17.1
> 




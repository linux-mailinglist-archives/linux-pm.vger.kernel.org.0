Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00D2C58EE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 17:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390021AbgKZQAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 11:00:06 -0500
Received: from foss.arm.com ([217.140.110.172]:37888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbgKZQAG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 11:00:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A1131B;
        Thu, 26 Nov 2020 08:00:05 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 864173F23F;
        Thu, 26 Nov 2020 08:00:05 -0800 (PST)
Date:   Thu, 26 Nov 2020 16:00:04 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH v4 1/3] thermal: power allocator: change the 'k_i'
 coefficient estimation
Message-ID: <20201126160004.GB25966@arm.com>
References: <20201124161025.27694-1-lukasz.luba@arm.com>
 <20201124161025.27694-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124161025.27694-2-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Tuesday 24 Nov 2020 at 16:10:23 (+0000), Lukasz Luba wrote:
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
> index b29e21c56a4f..2e20085ed217 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -134,6 +134,7 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  	int ret;
>  	int switch_on_temp;
>  	u32 temperature_threshold;
> +	s32 k_i;
>  
>  	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
>  	if (ret)
> @@ -159,8 +160,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
>  			temperature_threshold;
>  
> -	if (!tz->tzp->k_i || force)
> -		tz->tzp->k_i = int_to_frac(10) / 1000;
> +	if (!tz->tzp->k_i || force) {
> +		k_i = tz->tzp->k_pu / 10;
> +		tz->tzp->k_i = k_i > 0 ? k_i : 1;
> +	}
> +
>  	/*
>  	 * The default for k_d and integral_cutoff is 0, so we can
>  	 * leave them as they are.
> -- 

I see this patch did not change so:

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

> 2.17.1
> 

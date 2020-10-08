Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D71287250
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 12:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgJHKOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 06:14:37 -0400
Received: from foss.arm.com ([217.140.110.172]:48508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgJHKOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 06:14:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C9631B;
        Thu,  8 Oct 2020 03:14:36 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE4CD3F70D;
        Thu,  8 Oct 2020 03:14:35 -0700 (PDT)
Date:   Thu, 8 Oct 2020 11:14:34 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 2/2] thermal: power allocator: estimate sustainable power
 only once
Message-ID: <20201008101434.GA23491@arm.com>
References: <20201002122416.13659-1-lukasz.luba@arm.com>
 <20201002122416.13659-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002122416.13659-3-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Friday 02 Oct 2020 at 13:24:16 (+0100), Lukasz Luba wrote:
> The sustainable power value might come from the Device Tree or can be
> estimated in run time. There is no need to estimate every time when the
> governor is called and temperature is high. Instead, store the estimated
> value and make it available via standard sysfs interface so it can be
> checked from the user-space.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index f69fafe486a5..dd59085f38f5 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -204,6 +204,8 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>  		estimate_pid_constants(tz, sustainable_power,
>  				       params->trip_switch_on, control_temp,
>  				       true);
> +		/* Do the estimation only once and make available in sysfs */
> +		tz->tzp->sustainable_power = sustainable_power;

After looking over the code, it does seems mostly useless to do the
estimation every time the controller kicks in.

But I have two comments in this regard:

 - The estimation is dependent on the temperature we control for which
   can be changed from sysfs. While I don't see that as a big worry,
   (sustainable power is an estimation anyway), it might be worth a
   more detailed comment on why we don't expect this to be a problem,
   or what we expect the consequences of computing sustainable power
   only once could be.

 - In the function comment for estimate_pid_constants() there is a
   mention of sustainable power:
   """
    * Sustainable power is provided in case it was estimated.  The
    * estimated sustainable_power should not be stored in the
    * thermal_zone_parameters so it has to be passed explicitly to this
    * function.
   """
   If we are going to compute the sustainable power estimation only once,
   this comment should be removed, the estimated value should be added to
   the trip point parameters before estimate_pid_constants(), and the
   sustainable_power argument should be removed.
   Otherwise we end up with conflicting information in the code.

Regards,
Ionela.

>  	}
>  
>  	err = control_temp - tz->temperature;
> -- 
> 2.17.1
> 

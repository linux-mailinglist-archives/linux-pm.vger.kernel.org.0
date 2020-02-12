Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94815A58F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgBLKCB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:02:01 -0500
Received: from foss.arm.com ([217.140.110.172]:58362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgBLKCB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:02:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 516BF30E;
        Wed, 12 Feb 2020 02:02:00 -0800 (PST)
Received: from [10.37.12.187] (unknown [10.37.12.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCACC3F68F;
        Wed, 12 Feb 2020 02:01:56 -0800 (PST)
Subject: Re: [PATCH v3 7/7] clocksource/drivers/arm_arch_timer: validate
 arch_timer_rate
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        valentin.schneider@arm.com, rjw@rjwysocki.net
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-8-ionela.voinescu@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <89339501-5ee4-e871-3076-c8b02c6fbf6e@arm.com>
Date:   Wed, 12 Feb 2020 10:01:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200211184542.29585-8-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela, Valentin

On 2/11/20 6:45 PM, Ionela Voinescu wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
> 
> Using an arch timer with a frequency of less than 1MHz can result in an
> incorrect functionality of the system which assumes a reasonable rate.
> 
> One example is the use of activity monitors for frequency invariance
> which uses the rate of the arch timer as the known rate of the constant
> cycle counter in computing its ratio compared to the maximum frequency
> of a CPU. For arch timer frequencies less than 1MHz this ratio could
> end up being 0 which is an invalid value for its use.
> 
> Therefore, warn if the arch timer rate is below 1MHz which contravenes
> the recommended architecture interval of 1 to 50MHz.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/clocksource/arm_arch_timer.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9a5464c625b4..4faa930eabf8 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -885,6 +885,17 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>   	return 0;
>   }
>   
> +static int validate_timer_rate(void)
> +{
> +	if (!arch_timer_rate)
> +		return -EINVAL;
> +
> +	/* Arch timer frequency < 1MHz can cause trouble */
> +	WARN_ON(arch_timer_rate < 1000000);

I don't see a big value of having a patch just to add one extra warning,
in a situation which we handle in our code with in 6/7 with:

+	if (!ratio) {
+		pr_err("System timer frequency too low.\n");
+		return -EINVAL;
+	}

Furthermore, the value '100000' here is because of our code and
calculation in there, so it does not belong to arch timer. Someone
might ask why it's not 200000 or a define in our header...
Or questions asking why do you warn when that arch timer and cpu is not
AMU capable...

> +
> +	return 0;
> +}
> +
>   /*
>    * For historical reasons, when probing with DT we use whichever (non-zero)
>    * rate was probed first, and don't verify that others match. If the first node
> @@ -900,7 +911,7 @@ static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
>   		arch_timer_rate = rate;
>   
>   	/* Check the timer frequency. */
> -	if (arch_timer_rate == 0)
> +	if (validate_timer_rate())
>   		pr_warn("frequency not available\n");
>   }
>   
> @@ -1594,9 +1605,10 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>   	 * CNTFRQ value. This *must* be correct.
>   	 */
>   	arch_timer_rate = arch_timer_get_cntfrq();
> -	if (!arch_timer_rate) {
> +	ret = validate_timer_rate();
> +	if (ret) {
>   		pr_err(FW_BUG "frequency not available.\n");
> -		return -EINVAL;
> +		return ret;
>   	}
>   
>   	arch_timer_uses_ppi = arch_timer_select_ppi();
> 

Lastly, this is arch timer.
To increase chances of getting merge soon, I would recommend to drop
the patch from this series.

Regards,
Lukasz

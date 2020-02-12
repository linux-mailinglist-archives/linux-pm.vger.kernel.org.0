Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F25C15A5DD
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBLKMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgBLKMg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:12:36 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50B852082F;
        Wed, 12 Feb 2020 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581502354;
        bh=QElDy3sBZHFeK5CVxW0BW75mIV/Lc9hIMiRuNMALm1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pdoYsYGa+dyfJlc3GKvA65vI2/cS4ruqbsyp74Be6IKzXnpcxBHantm3Y29od4qit
         1W57ysC1upee7XAXXojVzieOkHkR21LArLqf7YKfrw5DcC4yp8+jFAZIKCpVMazoMo
         5JzGH/bzQoaJlYUGRMlQ1A7AHvDJ9yhdy/fPpsFE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j1p0S-004YUt-AC; Wed, 12 Feb 2020 10:12:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Feb 2020 10:12:32 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        sudeep.holla@arm.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clocksource/drivers/arm_arch_timer: validate
 arch_timer_rate
In-Reply-To: <89339501-5ee4-e871-3076-c8b02c6fbf6e@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-8-ionela.voinescu@arm.com>
 <89339501-5ee4-e871-3076-c8b02c6fbf6e@arm.com>
Message-ID: <a24aa6c86e7a565b6269f48d4026bca2@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lukasz.luba@arm.com, ionela.voinescu@arm.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com, sudeep.holla@arm.com, valentin.schneider@arm.com, rjw@rjwysocki.net, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-02-12 10:01, Lukasz Luba wrote:
> Hi Ionela, Valentin
> 
> On 2/11/20 6:45 PM, Ionela Voinescu wrote:
>> From: Valentin Schneider <valentin.schneider@arm.com>
>> 
>> Using an arch timer with a frequency of less than 1MHz can result in 
>> an
>> incorrect functionality of the system which assumes a reasonable rate.
>> 
>> One example is the use of activity monitors for frequency invariance
>> which uses the rate of the arch timer as the known rate of the 
>> constant
>> cycle counter in computing its ratio compared to the maximum frequency
>> of a CPU. For arch timer frequencies less than 1MHz this ratio could
>> end up being 0 which is an invalid value for its use.
>> 
>> Therefore, warn if the arch timer rate is below 1MHz which contravenes
>> the recommended architecture interval of 1 to 50MHz.
>> 
>> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/clocksource/arm_arch_timer.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/clocksource/arm_arch_timer.c 
>> b/drivers/clocksource/arm_arch_timer.c
>> index 9a5464c625b4..4faa930eabf8 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -885,6 +885,17 @@ static int arch_timer_starting_cpu(unsigned int 
>> cpu)
>>   	return 0;
>>   }
>>   +static int validate_timer_rate(void)
>> +{
>> +	if (!arch_timer_rate)
>> +		return -EINVAL;
>> +
>> +	/* Arch timer frequency < 1MHz can cause trouble */
>> +	WARN_ON(arch_timer_rate < 1000000);
> 
> I don't see a big value of having a patch just to add one extra 
> warning,
> in a situation which we handle in our code with in 6/7 with:
> 
> +	if (!ratio) {
> +		pr_err("System timer frequency too low.\n");
> +		return -EINVAL;
> +	}
> 
> Furthermore, the value '100000' here is because of our code and
> calculation in there, so it does not belong to arch timer. Someone
> might ask why it's not 200000 or a define in our header...
> Or questions asking why do you warn when that arch timer and cpu is not
> AMU capable...

Because, as the commit message outlines it, such a frequency is terribly
out of spec?

> 
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * For historical reasons, when probing with DT we use whichever 
>> (non-zero)
>>    * rate was probed first, and don't verify that others match. If the 
>> first node
>> @@ -900,7 +911,7 @@ static void arch_timer_of_configure_rate(u32 rate, 
>> struct device_node *np)
>>   		arch_timer_rate = rate;
>>     	/* Check the timer frequency. */
>> -	if (arch_timer_rate == 0)
>> +	if (validate_timer_rate())
>>   		pr_warn("frequency not available\n");
>>   }
>>   @@ -1594,9 +1605,10 @@ static int __init arch_timer_acpi_init(struct 
>> acpi_table_header *table)
>>   	 * CNTFRQ value. This *must* be correct.
>>   	 */
>>   	arch_timer_rate = arch_timer_get_cntfrq();
>> -	if (!arch_timer_rate) {
>> +	ret = validate_timer_rate();
>> +	if (ret) {
>>   		pr_err(FW_BUG "frequency not available.\n");
>> -		return -EINVAL;
>> +		return ret;
>>   	}
>>     	arch_timer_uses_ppi = arch_timer_select_ppi();
>> 
> 
> Lastly, this is arch timer.
> To increase chances of getting merge soon, I would recommend to drop
> the patch from this series.

And? It seems to address a potential issue where the time frequency
is out of spec, and makes sure we don't end up with additional problems
in the AMU code.

On its own, it is perfectly sensible and could be merged as part of this
series with my

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...

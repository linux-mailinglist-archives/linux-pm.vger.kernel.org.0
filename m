Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885C415A762
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 12:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBLLKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 06:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBLLKy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 06:10:54 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C267220848;
        Wed, 12 Feb 2020 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581505852;
        bh=LlIyVq7WjPeyLskoujzf/DfkF5Lzbz51INctcfhm79E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RDDWxK80jCu8hM2zS0GMo7uXnqEmx0Rv+dXEG71zMiZJm/Y2BjTUA+9b0VhNEjBZg
         ubnSDKtg1FmUuDLeSRNfYQc6TRDT4Udw9UOezOi4nbMOryoAIIX6VdHQS4CCBTwPs9
         LoX9tPVnLqYXTnyCFA4kniVQISYJPT4RDffbRrcs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j1put-004ZNr-3U; Wed, 12 Feb 2020 11:10:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 12 Feb 2020 11:10:51 +0000
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
In-Reply-To: <289c6110-b7ea-1d61-d795-551723263803@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-8-ionela.voinescu@arm.com>
 <89339501-5ee4-e871-3076-c8b02c6fbf6e@arm.com>
 <a24aa6c86e7a565b6269f48d4026bca2@kernel.org>
 <289c6110-b7ea-1d61-d795-551723263803@arm.com>
Message-ID: <f01a6384e7297de87a434e83bd1479d8@kernel.org>
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

On 2020-02-12 10:55, Lukasz Luba wrote:
> On 2/12/20 10:12 AM, Marc Zyngier wrote:
>> On 2020-02-12 10:01, Lukasz Luba wrote:
>>> Hi Ionela, Valentin
>>> 
>>> On 2/11/20 6:45 PM, Ionela Voinescu wrote:
>>>> From: Valentin Schneider <valentin.schneider@arm.com>
>>>> 
>>>> Using an arch timer with a frequency of less than 1MHz can result in 
>>>> an
>>>> incorrect functionality of the system which assumes a reasonable 
>>>> rate.
>>>> 
>>>> One example is the use of activity monitors for frequency invariance
>>>> which uses the rate of the arch timer as the known rate of the 
>>>> constant
>>>> cycle counter in computing its ratio compared to the maximum 
>>>> frequency
>>>> of a CPU. For arch timer frequencies less than 1MHz this ratio could
>>>> end up being 0 which is an invalid value for its use.
>>>> 
>>>> Therefore, warn if the arch timer rate is below 1MHz which 
>>>> contravenes
>>>> the recommended architecture interval of 1 to 50MHz.
>>>> 
>>>> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>> ---
>>>>   drivers/clocksource/arm_arch_timer.c | 18 +++++++++++++++---
>>>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/drivers/clocksource/arm_arch_timer.c 
>>>> b/drivers/clocksource/arm_arch_timer.c
>>>> index 9a5464c625b4..4faa930eabf8 100644
>>>> --- a/drivers/clocksource/arm_arch_timer.c
>>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>>> @@ -885,6 +885,17 @@ static int arch_timer_starting_cpu(unsigned int 
>>>> cpu)
>>>>       return 0;
>>>>   }
>>>>   +static int validate_timer_rate(void)
>>>> +{
>>>> +    if (!arch_timer_rate)
>>>> +        return -EINVAL;
>>>> +
>>>> +    /* Arch timer frequency < 1MHz can cause trouble */
>>>> +    WARN_ON(arch_timer_rate < 1000000);
>>> 
>>> I don't see a big value of having a patch just to add one extra 
>>> warning,
>>> in a situation which we handle in our code with in 6/7 with:
>>> 
>>> +    if (!ratio) {
>>> +        pr_err("System timer frequency too low.\n");
>>> +        return -EINVAL;
>>> +    }
>>> 
>>> Furthermore, the value '100000' here is because of our code and
>>> calculation in there, so it does not belong to arch timer. Someone
>>> might ask why it's not 200000 or a define in our header...
>>> Or questions asking why do you warn when that arch timer and cpu is 
>>> not
>>> AMU capable...
>> 
>> Because, as the commit message outlines it, such a frequency is 
>> terribly
>> out of spec?
> 
> I don't see in the RM that < 1MHz is terribly out of spec.
> 'Frequency
> Increments at a fixed frequency, typically in the range 1-50MHz.
> Can support one or more alternative operating modes in which it
> increments by larger amounts at a
> lower frequency, typically for power-saving.'

Hint: constant apparent frequency.

> There is even an example how to operate at 20kHz and increment by 500.
> 
> I don't know the code if it's supported, thought.

You're completely missing the point, I'm afraid. Nobody has to know that
this is happening. For all intent and purposes, the counter has always
the same frequency, even if the HW does fewer ticks of larger 
increments.


[...]

>>> Lastly, this is arch timer.
>>> To increase chances of getting merge soon, I would recommend to drop
>>> the patch from this series.
>> 
>> And? It seems to address a potential issue where the time frequency
>> is out of spec, and makes sure we don't end up with additional 
>> problems
>> in the AMU code.
> 
> This patch just prints warning, does not change anything in booting or
> in any code related to AMU.

It seems to solve an issue with an assumption made in the AMU driver,
and would help debugging the problem on broken systems. Are you saying
that this is not the case and that the AMU code can perfectly cope with
the frequency being less than 1MHz?

         M.
-- 
Jazz is not dead. It just smells funny...

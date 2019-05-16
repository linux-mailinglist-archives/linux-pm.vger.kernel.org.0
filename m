Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE66120792
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 15:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfEPNGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 09:06:12 -0400
Received: from foss.arm.com ([217.140.101.70]:45086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfEPNGM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 09:06:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1668D1715;
        Thu, 16 May 2019 06:06:12 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 865633F703;
        Thu, 16 May 2019 06:06:10 -0700 (PDT)
Subject: Re: [RFC PATCH 1/7] PM: Introduce em_pd_get_higher_freq()
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-2-douglas.raillard@arm.com>
 <20190516124200.opxczohjelhvrzmo@e110439-lin>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <046bfab7-bf28-bbfe-2bff-09881d537fb1@arm.com>
Date:   Thu, 16 May 2019 14:06:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516124200.opxczohjelhvrzmo@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Patrick,

On 5/16/19 1:42 PM, Patrick Bellasi wrote:
> On 08-May 18:42, douglas.raillard@arm.com wrote:
>> From: Douglas RAILLARD <douglas.raillard@arm.com>
>>
>> em_pd_get_higher_freq() returns a frequency greater or equal to the
>> provided one while taking into account a given cost margin. It also
>> skips inefficient OPPs that have a higher cost than another one with a
>> higher frequency.
> 
> It's worth to add a small description and definition of what we mean by
> "OPP efficiency". Despite being just an RFC, it could help to better
> understand what we are after.

Right, here efficiency=capacity/power.

> 
> [...]
> 
>> +/** + * em_pd_get_higher_freq() - Get the highest frequency that
>> does not exceed the
>> + * given cost margin compared to min_freq
>> + * @pd		: performance domain for which this must be done
>> + * @min_freq	: minimum frequency to return
>> + * @cost_margin	: allowed margin compared to min_freq, as a per-1024 value.
>                                                                      ^^^^^^^^
> here...
> 
>> + *
>> + * Return: the chosen frequency, guaranteed to be at least as high as min_freq.
>> + */
>> +static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
>> +	unsigned long min_freq, unsigned long cost_margin)
>> +{
>> +	unsigned long max_cost = 0;
>> +	struct em_cap_state *cs;
>> +	int i;
>> +
>> +	if (!pd)
>> +		return min_freq;
>> +
>> +	/* Compute the maximum allowed cost */
>> +	for (i = 0; i < pd->nr_cap_states; i++) {
>> +		cs = &pd->table[i];
>> +		if (cs->frequency >= min_freq) {
>> +			max_cost = cs->cost + (cs->cost * cost_margin) / 1024;
>                                                                           ^^^^
> ... end here we should probably better use SCHED_CAPACITY_SCALE
> instead of hard-coding in values, isn't it?

"cs->cost*cost_margin/1024" is not a capacity, it's a cost as defined here:
https://elixir.bootlin.com/linux/latest/source/include/linux/energy_model.h#L17

Actually, it's in milliwatts, but it's not better the better way to look at
it to understand it IMHO.

The margin is expressed as a "per-1024" value just like we use percents'
in everyday life, so it has no unit. If we want to avoid hard-coded values
here, I can introduce an ENERGY_COST_MARGIN_SCALE macro.

>> +			break;
>> +		}
>> +	}
>> +
> 
> [...]
> 
> Best,
> Patrick

Thanks,
Douglas

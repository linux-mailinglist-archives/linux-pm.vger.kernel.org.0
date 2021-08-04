Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081DF3DFFA2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhHDKwN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 06:52:13 -0400
Received: from foss.arm.com ([217.140.110.172]:59158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237593AbhHDKwM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Aug 2021 06:52:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 648A513A1;
        Wed,  4 Aug 2021 03:52:00 -0700 (PDT)
Received: from [10.57.10.145] (unknown [10.57.10.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843893F719;
        Wed,  4 Aug 2021 03:51:58 -0700 (PDT)
Subject: Re: [PATCH v2] cpufreq: arm_scmi: Fix error path when allocation
 failed
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com, rjw@rjwysocki.net,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20210803090744.12143-1-lukasz.luba@arm.com>
 <20210804040237.ssrba26jpe572mjf@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c0679032-6405-1eab-9e2c-ae58faa88e6b@arm.com>
Date:   Wed, 4 Aug 2021 11:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210804040237.ssrba26jpe572mjf@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/4/21 5:02 AM, Viresh Kumar wrote:
> On 03-08-21, 10:07, Lukasz Luba wrote:
>> Stop the initialization when cpumask allocation failed and return an
>> error.
>>
>> Fixes: 80a064dbd556 ("scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM")
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> changes:
>> v2:
>> - removed dev_warn() since it's not needed in this case
>> - adjusted the patch description
>>
>>   drivers/cpufreq/scmi-cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index ec9a87ca2dbb..75f818d04b48 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -134,7 +134,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   	}
>>   
>>   	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
>> -		ret = -ENOMEM;
>> +		return -ENOMEM;
>>   
>>   	/* Obtain CPUs that share SCMI performance controls */
>>   	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
> 
> Applied. Thanks.
> 

Thank you for taking it.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BBE54ADC1
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 11:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354623AbiFNJvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355067AbiFNJvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 05:51:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AE0A46664;
        Tue, 14 Jun 2022 02:50:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A9123A;
        Tue, 14 Jun 2022 02:50:58 -0700 (PDT)
Received: from [10.57.41.45] (unknown [10.57.41.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391D63F792;
        Tue, 14 Jun 2022 02:50:56 -0700 (PDT)
Message-ID: <8325cebd-ddf5-c6aa-16b9-c7c4282d790f@arm.com>
Date:   Tue, 14 Jun 2022 10:50:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/4] thermal: cpufreq_cooling: Use private callback ops
 for each cooling device
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        mingo@redhat.com
References: <20220613124327.30766-1-lukasz.luba@arm.com>
 <20220613124327.30766-2-lukasz.luba@arm.com>
 <20220614022448.pqld3zhqucsfofss@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220614022448.pqld3zhqucsfofss@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/14/22 03:24, Viresh Kumar wrote:
> On 13-06-22, 13:43, Lukasz Luba wrote:
>> It is very unlikely that one CPU cluster would have the EM and some other
>> won't have it (because EM registration failed or DT lacks needed entry).
>> Although, we should avoid modifying global variable with callbacks anyway.
>> Redesign this and add safety for such situation.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/cpufreq_cooling.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
>> index b8151d95a806..ad8b86f5281b 100644
>> --- a/drivers/thermal/cpufreq_cooling.c
>> +++ b/drivers/thermal/cpufreq_cooling.c
>> @@ -59,6 +59,7 @@ struct time_in_idle {
>>    * @cdev: thermal_cooling_device pointer to keep track of the
>>    *	registered cooling device.
>>    * @policy: cpufreq policy.
>> + * @cooling_ops: cpufreq callbacks to thermal cooling device ops
>>    * @idle_time: idle time stats
>>    * @qos_req: PM QoS contraint to apply
>>    *
>> @@ -71,6 +72,7 @@ struct cpufreq_cooling_device {
>>   	unsigned int max_level;
>>   	struct em_perf_domain *em;
>>   	struct cpufreq_policy *policy;
>> +	struct thermal_cooling_device_ops cooling_ops;
>>   #ifndef CONFIG_SMP
>>   	struct time_in_idle *idle_time;
>>   #endif
>> @@ -485,14 +487,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>   	return ret;
>>   }
>>   
>> -/* Bind cpufreq callbacks to thermal cooling device ops */
>> -
>> -static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
>> -	.get_max_state		= cpufreq_get_max_state,
>> -	.get_cur_state		= cpufreq_get_cur_state,
>> -	.set_cur_state		= cpufreq_set_cur_state,
>> -};
>> -
>>   /**
>>    * __cpufreq_cooling_register - helper function to create cpufreq cooling device
>>    * @np: a valid struct device_node to the cooling device device tree node
>> @@ -554,7 +548,10 @@ __cpufreq_cooling_register(struct device_node *np,
>>   	/* max_level is an index, not a counter */
>>   	cpufreq_cdev->max_level = i - 1;
>>   
>> -	cooling_ops = &cpufreq_cooling_ops;
>> +	cooling_ops = &cpufreq_cdev->cooling_ops;
>> +	cooling_ops->get_max_state = cpufreq_get_max_state;
>> +	cooling_ops->get_cur_state = cpufreq_get_cur_state;
>> +	cooling_ops->set_cur_state = cpufreq_set_cur_state;
>>   
>>   #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>>   	if (em_is_sane(cpufreq_cdev, em)) {
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 


Thank you Viresh for the ACK!

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70FD1D433A
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 03:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOBtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 21:49:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgEOBtN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 21:49:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E464DE8851E4BA132951;
        Fri, 15 May 2020 09:49:10 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 09:49:03 +0800
Subject: Re: [RFC PATCH 2/3] cpufreq: Add SW BOOST support for drivers without
 frequency table
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <viresh.kumar@linaro.org>, <Souvik.Chakravarty@arm.com>,
        <Thanu.Rangarajan@arm.com>, <Sudeep.Holla@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com>
 <1588929064-30270-3-git-send-email-wangxiongfeng2@huawei.com>
 <5858421.kfVlu25t0p@kreacher>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <7325b64c-85f7-21fe-3860-faa10ab1cf21@huawei.com>
Date:   Fri, 15 May 2020 09:49:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5858421.kfVlu25t0p@kreacher>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2020/5/14 22:16, Rafael J. Wysocki wrote:
> On Friday, May 8, 2020 11:11:03 AM CEST Xiongfeng Wang wrote:
>> Software-managed BOOST get the boost frequency by check the flag
>> CPUFREQ_BOOST_FREQ at driver's frequency table. But some cpufreq driver
>> don't have frequency table and use other methods to get the frequency
>> range, such CPPC cpufreq driver.
>>
>> To add SW BOOST support for drivers without frequency table, we add
>> members in 'cpufreq_policy.cpufreq_cpuinfo' to record the max frequency
>> of boost mode and non-boost mode. The cpufreq driver initialize these two
>> members when probing.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
>>  include/linux/cpufreq.h   |  2 ++
>>  2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 475fb1b..a299426 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2508,15 +2508,22 @@ static int cpufreq_boost_set_sw(int state)
>>  	int ret = -EINVAL;
>>  
>>  	for_each_active_policy(policy) {
>> -		if (!policy->freq_table)
>> -			continue;
>> -
>> -		ret = cpufreq_frequency_table_cpuinfo(policy,
>> +		if (policy->freq_table) {
>> +			ret = cpufreq_frequency_table_cpuinfo(policy,
>>  						      policy->freq_table);
>> -		if (ret) {
>> -			pr_err("%s: Policy frequency update failed\n",
>> -			       __func__);
>> -			break;
>> +			if (ret) {
>> +				pr_err("%s: Policy frequency update failed\n",
>> +				       __func__);
>> +				break;
>> +			}
>> +		} else if (policy->cpuinfo.boost_max_freq) {
>> +			if (state)
>> +				policy->max = policy->cpuinfo.boost_max_freq;
>> +			else
>> +				policy->max = policy->cpuinfo.nonboost_max_freq;
>> +			policy->cpuinfo.max_freq = policy->max;
>> +		} else {
>> +			continue;
>>  		}
> 
> Why do you need to update this function?

My original thought is to reuse the current SW BOOST code as possible, but this
seems to change the cpufreq core too much.

> 
> The driver should be able to provide its own ->set_boost callback just fine,
> shouldn't it?

Thanks for your advice. This is better. I will provide a '->set_boost' callback
for CPPC driver. But I will need to export 'cpufreq_policy_list' and make the
macro 'for_each_active_policy' public.

Thanks,
Xiongfeng

> 
>>  
>>  		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 018dce8..c3449e6 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -43,6 +43,8 @@ enum cpufreq_table_sorting {
>>  struct cpufreq_cpuinfo {
>>  	unsigned int		max_freq;
>>  	unsigned int		min_freq;
>> +	unsigned int		boost_max_freq;
>> +	unsigned int		nonboost_max_freq;
>>  
>>  	/* in 10^(-9) s = nanoseconds */
>>  	unsigned int		transition_latency;
>>
> 
> 
> 
> 
> 
> .
> 


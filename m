Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD061D3C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfGHKrf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 06:47:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729370AbfGHKrf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 06:47:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26D2D761AC978FF7A392;
        Mon,  8 Jul 2019 18:47:33 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 18:47:31 +0800
Subject: Re: [PATCH] cpufreq: schedutil: Fix covert rate_limit_us to
 freq_update_delay_ns overflow
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-pm@vger.kernel.org>
References: <1562575583-99575-1-git-send-email-zhangxiaoxu5@huawei.com>
 <20190708093740.pbcnl7ytjmmpy3bz@vireshk-i7>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <c7617270-3659-8320-a605-1c2dc3ffdf1f@huawei.com>
Date:   Mon, 8 Jul 2019 18:47:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190708093740.pbcnl7ytjmmpy3bz@vireshk-i7>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



ÔÚ 2019/7/8 17:37, Viresh Kumar Ð´µÀ:
> On 08-07-19, 16:46, ZhangXiaoxu wrote:
>> When covert rate_limit_us to freq_update_delay_ns, it maybe overflow
>> and lead an undefined behavior.
> 
> freq_update_delay_ns is s64, still overflow can happen ?
It will not happened. sorry for my misunderstander :(
> 
>> So, limit the rate_limit_us to UINT_MAX / NSEC_PER_USEC.
>>
>> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index 962cf34..01e05f3 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -590,6 +590,9 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
>>   	if (kstrtouint(buf, 10, &rate_limit_us))
>>   		return -EINVAL;
>>   
>> +	if (rate_limit_us > UINT_MAX / NSEC_PER_USEC)
>> +		return -EINVAL;
>> +
>>   	tunables->rate_limit_us = rate_limit_us;
>>   
>>   	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
>> -- 
>> 2.7.4
> 


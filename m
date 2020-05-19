Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF91D8CF3
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 03:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgESBMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 21:12:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbgESBMy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 21:12:54 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8C4B9BAC60E6982DA677;
        Tue, 19 May 2020 09:12:52 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 09:12:46 +0800
Subject: Re: [RFC PATCH v2 1/3] cpufreq: handle the return value of
 '.set_boost()' properly
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <Souvik.Chakravarty@arm.com>,
        <Thanu.Rangarajan@arm.com>, <Sudeep.Holla@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1589785808-12138-1-git-send-email-wangxiongfeng2@huawei.com>
 <1589785808-12138-2-git-send-email-wangxiongfeng2@huawei.com>
 <20200518074619.yznopcgqmoq6ds7t@vireshk-i7>
 <20200518114348.z55kpbhgbfxenrhm@vireshk-i7>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <115bf0d2-8f23-d82b-3d2a-41dd3f124343@huawei.com>
Date:   Tue, 19 May 2020 09:12:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200518114348.z55kpbhgbfxenrhm@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 2020/5/18 19:43, Viresh Kumar wrote:
> On 18-05-20, 13:16, Viresh Kumar wrote:
>> On 18-05-20, 15:10, Xiongfeng Wang wrote:
>>> 'freq_qos_update_request()' called by 'cpufreq_boost_set_sw()' reutrns 1
>>> when the effective constraint value of frequency QoS has changed. It's
>>> not an error code. So handle the return value 1 of '.set_boost()' in
>>> 'cpufreq_boost_trigger_state()' properly.
>>>
>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>>> ---
>>>  drivers/cpufreq/cpufreq.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 4adac3a..bb6746e 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -2540,7 +2540,10 @@ int cpufreq_boost_trigger_state(int state)
>>>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>>>  
>>>  	ret = cpufreq_driver->set_boost(state);
>>> -	if (ret) {
>>> +	if (ret == 1) {
>>> +		pr_debug("The effective constraint value of frequency QoS has changed.\n");
>>> +		return 0;
>>> +	} else if (ret) {
>>
>> Rafael, IMO it is better to pick patch from Sergey for this as this is
>> implementation detail.
>>
>>>  		write_lock_irqsave(&cpufreq_driver_lock, flags);
>>>  		cpufreq_driver->boost_enabled = !state;
>>>  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> This is already fixed in the PM tree with a different patch Xiongfeng.

Thanks for telling me. I will drop it in the next version.

Thanks,
Xiongfeng

> 


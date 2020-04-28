Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9FA1BB425
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 04:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgD1CsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 22:48:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbgD1CsG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 22:48:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1FFA54FBEE824FCC9C87;
        Tue, 28 Apr 2020 10:48:01 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 10:47:56 +0800
Subject: Re: [RFC PATCH] cpuidle: Make cpuidle governor switchable to be the
 default behaviour
To:     Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
References: <1587982637-33618-1-git-send-email-guohanjun@huawei.com>
 <06ff344e-7abf-9eb6-9664-0e9f9d8d6bc7@linaro.org>
 <000401d61ca1$f684f7b0$e38ee710$@net>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0fbf3fc3-fabf-c9cb-b582-8dc6e2d5b7de@huawei.com>
Date:   Tue, 28 Apr 2020 10:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <000401d61ca1$f684f7b0$e38ee710$@net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/4/27 22:41, Doug Smythies wrote:
> I very much support this RFC.
> I have been running only with "cpuidle_sysfs_switch" for about 2 years.

Thanks, glad to hear that switch cpuidle governor at
runtime works for years.

> 
> Some changes would be required for the documentation files also.

I will update them in next version.

> 
> On 2020.04.27 06:37 Daniel Lezcano wrote:
>> On 27/04/2020 12:17, Hanjun Guo wrote:
>>> For now cpuidle governor can be switched via sysfs only when the
>>> boot option "cpuidle_sysfs_switch" is passed, but it's important
>>> to switch the governor to adapt to different workloads, especially
>>> after TEO and haltpoll governor were introduced.
>>>
>>> Introduce a CONFIG option to make cpuidle governor switchable to be
>>> the default behaviour, which will not break the boot option behaviour.
>>>
>>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>>> ---
>>>   drivers/cpuidle/Kconfig | 9 +++++++++
>>>   drivers/cpuidle/sysfs.c | 2 +-
>>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>>> index c0aeedd..c40cb40 100644
>>> --- a/drivers/cpuidle/Kconfig
>>> +++ b/drivers/cpuidle/Kconfig
>>> @@ -47,6 +47,15 @@ config CPU_IDLE_GOV_HALTPOLL
>>>   config DT_IDLE_STATES
>>>   	bool
>>>   
>>> +config CPU_IDLE_SWITCH_GOV_IN_DEFAULT
>>> +	bool "Switch the CPU idle governor via sysfs at runtime in default behaviour"
>>> +	help
>>> +	  Make the CPU idle governor switchable at runtime, and make it as the
>>> +	  default behaviour even the boot option "cpuidle_sysfs_switch" is not
>>> +	  passed in cmdline.
>>> +
>>> +	  Say N if you unsure about this.
>>
>> Well I wouldn't make this optional but just remove the sysfs_switch.
> 
> Agree.
> 
>> However, there is the '_ro' suffix when the option is not set. In order
>> to not break the existing tools, may be let both files co-exist and add
>> in the ABI/obselete the '_ro' file as candidate for removal ?
> 
> I do not like this _ro thing, and got hit by it with turbostat one time.
> Agree it should be made a candidate for removal.

OK, I will prepare another RFC patch set to remove sysfs_switch.

Thanks
Hanjun


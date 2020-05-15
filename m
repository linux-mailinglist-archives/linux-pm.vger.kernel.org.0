Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034921D4601
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 08:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgEOGiH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 02:38:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbgEOGiG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 May 2020 02:38:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B30272329E61C70F938;
        Fri, 15 May 2020 14:38:05 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 14:38:01 +0800
Subject: Re: [PATCH] cpuidle: Delete unused define_one_ro/rw macros
To:     Pascal Terjan <pterjan@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20200513101751.111907-1-pterjan@google.com>
 <CAJZ5v0hSGYCwAED6TWq=dPv+W=YSZ3p+3T1tbkfbhL5pWnOO8A@mail.gmail.com>
 <CAANdO=LoeMxhVM4_H6v0r2Qdn04x1VcTnD7Y3e7BsXBemaR+Mw@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <1ecf0238-6cff-147a-6b61-cbd308d87883@huawei.com>
Date:   Fri, 15 May 2020 14:38:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAANdO=LoeMxhVM4_H6v0r2Qdn04x1VcTnD7Y3e7BsXBemaR+Mw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/5/15 2:07, Pascal Terjan wrote:
> On Thu, 14 May 2020 at 12:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, May 13, 2020 at 12:18 PM Pascal Terjan <pterjan@google.com> wrote:
>>>
>>> They were already unused when cpuidle was introduced.
>>>
>>> Signed-off-by: Pascal Terjan <pterjan@google.com>
>>> ---
>>>   drivers/cpuidle/sysfs.c | 5 -----
>>>   1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
>>> index cdeedbf02646..7729cf622d1e 100644
>>> --- a/drivers/cpuidle/sysfs.c
>>> +++ b/drivers/cpuidle/sysfs.c
>>> @@ -167,11 +167,6 @@ struct cpuidle_attr {
>>>          ssize_t (*store)(struct cpuidle_device *, const char *, size_t count);
>>>   };
>>>
>>> -#define define_one_ro(_name, show) \
>>> -       static struct cpuidle_attr attr_##_name = __ATTR(_name, 0444, show, NULL)
>>> -#define define_one_rw(_name, show, store) \
>>> -       static struct cpuidle_attr attr_##_name = __ATTR(_name, 0644, show, store)
>>> -
>>>   #define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
>>>
>>>   struct cpuidle_device_kobj {
>>> --
>>
>> This patch doesn't apply on top of the cpuidle material for 5.8
>> present in linux-next, thanks!
> 
> Funny timing, it was actually already done a few weeks ago after all
> those years :)
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=2f516e7cbe88f05023b6cc458d3a22b7dc56af99

It is :)

I spotted it when trying to make cpudile governor switchable to
be the default behaviour [0].

[0]: https://patchwork.kernel.org/cover/11519511/

Thanks
Hanjun


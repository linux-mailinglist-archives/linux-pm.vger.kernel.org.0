Return-Path: <linux-pm+bounces-16203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EAF9A9F20
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE257B21B07
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381FE1991B6;
	Tue, 22 Oct 2024 09:49:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50714196DA2
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590566; cv=none; b=DbX98m6/fG8MXg3SOPsAlSolhKZhbPnd8lC79C84RF6gkas88GC28pX2ZhRTT9wIEk03a04bxqifTxzyAWE/C/0iMe0Lk0hBtqdmI0p+m4Gl8QHhpBYiTbTvcsQtzgBYAdZo0samyJ2B27f94jlhhA9YdGnD4IkwVPJcTnkBxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590566; c=relaxed/simple;
	bh=LS5gpsKbr41R4tR9O98tyKZZxzagXfF4s1EDRPDS3Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCEuT66+vn+k8KCUVrmcZhlg+linWDhj6J/MrN4PsauElI1G0yZiPxahrlNo6/FasGPKAxkG4rHEEOnu6AfOvNL503wCDDmT47TFQFrNRwKwcfjdSmR0YnrQK0qPn3JWQ0RxPJtXIXCrKRTEPXqG4MBOKppiF+o4SCzG+AP/YZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DBB2497;
	Tue, 22 Oct 2024 02:49:53 -0700 (PDT)
Received: from [10.57.65.67] (unknown [10.57.65.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 010193F73B;
	Tue, 22 Oct 2024 02:49:22 -0700 (PDT)
Message-ID: <e7fcd734-53a2-4650-8657-2eadd58fbf92@arm.com>
Date: Tue, 22 Oct 2024 10:50:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] tools/lib/thermal: Add the threshold netlink ABI
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-4-daniel.lezcano@linaro.org>
 <eedddb6e-fe0b-4785-9590-4b607d775769@arm.com>
 <b648f0b6-2df3-43ca-880e-a5290d0b8381@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <b648f0b6-2df3-43ca-880e-a5290d0b8381@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/22/24 08:49, Daniel Lezcano wrote:
> On 21/10/2024 22:47, Lukasz Luba wrote:
>>
>>
>> On 10/14/24 10:43, Daniel Lezcano wrote:
>>> The thermal framework supports the thresholds and allows the userspace
>>> to create, delete, flush, get the list of the thresholds as well as
>>> getting the list of the thresholds set for a specific thermal zone.
>>>
>>> Add the netlink abstraction in the thermal library to take full
>>> advantage of thresholds for the userspace program.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   tools/lib/thermal/commands.c        | 128 +++++++++++++++++++++++++++-
>>>   tools/lib/thermal/events.c          |  55 +++++++++---
>>>   tools/lib/thermal/include/thermal.h |  40 +++++++++
>>>   tools/lib/thermal/libthermal.map    |   5 ++
>>>   tools/lib/thermal/thermal.c         |  17 ++++
>>>   tools/thermal/lib/Makefile          |   2 +-
>>>   6 files changed, 232 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
>>> index a9223df91dcf..9d5e3e891628 100644
>>> --- a/tools/lib/thermal/commands.c
>>> +++ b/tools/lib/thermal/commands.c
>>> @@ -5,6 +5,7 @@
>>>   #include <stdio.h>
>>>   #include <stdlib.h>
>>>   #include <unistd.h>
>>> +#include <limits.h>
>>>   #include <thermal.h>
>>>   #include "thermal_nl.h"
>>> @@ -33,6 +34,11 @@ static struct nla_policy 
>>> thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
>>>       [THERMAL_GENL_ATTR_CDEV_CUR_STATE]      = { .type = NLA_U32 },
>>>       [THERMAL_GENL_ATTR_CDEV_MAX_STATE]      = { .type = NLA_U32 },
>>>       [THERMAL_GENL_ATTR_CDEV_NAME]           = { .type = NLA_STRING },
>>> +
>>> +        /* Thresholds */
>>> +        [THERMAL_GENL_ATTR_THRESHOLD]          = { .type = 
>>> NLA_NESTED },
>>> +        [THERMAL_GENL_ATTR_THRESHOLD_TEMP]      = { .type = NLA_U32 },
>>> +        [THERMAL_GENL_ATTR_THRESHOLD_DIRECTION] = { .type = NLA_U32 },
>>>   };
>>>   static int parse_tz_get(struct genl_info *info, struct thermal_zone 
>>> **tz)
>>> @@ -182,6 +188,38 @@ static int parse_tz_get_gov(struct genl_info 
>>> *info, struct thermal_zone *tz)
>>>       return THERMAL_SUCCESS;
>>>   }
>>> +static int parse_threshold_get(struct genl_info *info, struct 
>>> thermal_zone *tz)
>>> +{
>>> +    struct nlattr *attr;
>>> +    struct thermal_threshold *__tt = NULL;
>>> +    size_t size = 0;
>>
>> why not simply 'int' ?
> 
> Because it is used with realloc where the function definition is:
> 
> void *realloc(void *_Nullable ptr, size_t size);
> 
> and sizeof() return a size_t type.
> 
> So in order to not mix the types, size_t is used which I believe is a 
> good practice :)
> 
>> also: size=0 which has some impact mentioned below.
>>
>>> +    int rem;
>>
>> I would make them a descending order, those lines.
>>
>>> +
>>> +    nla_for_each_nested(attr, info- 
>>> >attrs[THERMAL_GENL_ATTR_THRESHOLD], rem) {
>>> +
>>> +        if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_TEMP) {
>>> +
>>> +            size++;
>>> +
>>> +            __tt = realloc(__tt, sizeof(*__tt) * (size + 2));
>>> +            if (!__tt)
>>> +                return THERMAL_ERROR;
>>> +
>>> +            __tt[size - 1].temperature = nla_get_u32(attr);
>>> +        }
>>> +
>>> +        if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_DIRECTION)
>>> +            __tt[size - 1].direction = nla_get_u32(attr);
>>
>> We probably relay on some order here, because the 'size -1' needs to be
>> done after first 'size++'.
>> If that the case then maybe it's worth a comment. Or if it wasn't
>> intended and there are no strong guarantees, then this needs a fix.
> 
> The size contains the size of the array and we want to access the last 
> element, size - 1
> 
> I will add this sentence above as a comment if it is ok for you

Yes, please add some comment e.g. that size=0 will be then
first modified by the 1st 'if()' so 'size++' will happen
and there is no way that the 2nd 'if()' will trigger before that.
Those 2 'if()' are kind of independent in the code and it's
not obvious from that part of code, why the 2nd 'if()' won't
run at the beginning. The dangerous situation would be:
'__tt[0 - 1].direction = ' assignment, which is due to
'size=0' init value.

> 
>>> +    }
>>> +
>>> +    if (__tt)
>>> +        __tt[size].temperature = INT_MAX;
>>> +
>>> +    tz->thresholds = __tt;
>>
>> I wonder what would happen to the previous 'tz->thresholds' when
>> we just put new one here... I cannot find other place when it's set.
>>
>> Since we have '*__tt = NULL' then one of the solutions would be
>> to simply call:
>>      free(tz->thresholds);
>>      tz->thresholds = __tt;
>>
>> Am I missing something, when it might be cleaned in different place?
> 
> The caller is supposed to pass a clean empty structure.
> 
> Usually, this function is to discover the current configuration, so it 
> is a one shot call keeping the structure in memory for the libthermal 
> lifecycle.
> 
> The events sends updates of the thermal zones. So with the events and 
> the initial configuration from the discovery, the userspace is always 
> up-to-date with the thermal setup.

So we cannot receive that we have new thresholds?
I thought we will get that information, even in runtime, so the old
memory should be just freed.

> 
> 
>>> +
>>> +    return THERMAL_SUCCESS;
>>> +}
>>> +
>>>   static int handle_netlink(struct nl_cache_ops *unused,
>>>                 struct genl_cmd *cmd,
>>>                 struct genl_info *info, void *arg)
>>> @@ -210,6 +248,10 @@ static int handle_netlink(struct nl_cache_ops 
>>> *unused,
>>>           ret = parse_tz_get_gov(info, arg);
>>>           break;
>>> +    case THERMAL_GENL_CMD_THRESHOLD_GET:
>>> +        ret = parse_threshold_get(info, arg);
>>> +        break;
>>> +
>>
>> I can see in the kernel part in the funciton:
>> thermal_genl_cmd_doit()
>> that there add, delete, flush also send a response
>> message. Shouldn't be handled here gently, otherwise
> 
> No, those are commands and the transaction is done at the netlink level 
> to say if the command was successful or not.

Thanks, I see.

> 
>>>       default:
>>>           return THERMAL_ERROR;
>>
>> that 'default' might capture them?
> 
> [ ... ]
> 
>>>   int for_each_thermal_cdev(struct thermal_cdev *cdev, cb_tc_t cb, 
>>> void *arg)
>>>   {
>>>       int i, ret = 0;
>>> @@ -80,6 +94,9 @@ static int __thermal_zone_discover(struct 
>>> thermal_zone *tz, void *th)
>>>       if (thermal_cmd_get_trip(th, tz) < 0)
>>>           return -1;
>>> +    if (thermal_cmd_threshold_get(th, tz) < 0)
>>
>> There are only 2 definitions in the enum thermal_error_t.
>> I would just simply checked if it's not 0:
> 
> 
> Ok
> 
> Thanks for the review
> 

We're welcome.


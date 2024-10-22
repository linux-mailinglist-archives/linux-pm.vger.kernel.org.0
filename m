Return-Path: <linux-pm+bounces-16192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8439A9B73
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA72E28269D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32D146D76;
	Tue, 22 Oct 2024 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRdjy3Ey"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EC146D68
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583351; cv=none; b=ZRSY34Qk6vfKhFKzZmQK1FkZ42C+St7rLw72tQ8vn6GzVGz2I6jP6Fohmb90ZRmc3Ax+K9LPnmzDPLuXIUbP/+GS8IJaEVL4bvC/WQInWvvgZQ7pKadPj9CjMt36n8NhZwR8tzZHDwEjyJcCBAcDkOu8ulR821xG8ymJNDrcWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583351; c=relaxed/simple;
	bh=Os3sBjw6O/qfN+e6f+wmyInOA73y2FqJs1xMTzzisSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkB8hnHbb9avU+AB05dyxlhLEkxWFJ412wo7WZtJJP4pWqd6qGZdxGcl+jXUxt8u2QRIHOw78EmAR2pS1s9k4fz7yNLvMnnPUqS7fApCmguJGiL9Kk+YXND71TXNRyjfJujAL75BXMs0Jk1kv+LILy8cpSmK6/2n3CeXa4uN244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IRdjy3Ey; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a850270e2so477946066b.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729583347; x=1730188147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwGRDDDofs0tVQxLtm45RAQmzhuGfydwRGPyCgbAQCE=;
        b=IRdjy3EyomgN7Mz6rPmpPkqOhKVVGEGXDhXMYetVDORLqj4HF2qqL5VSVwHQUx9OY5
         NyLFk1HProCI7iDBOyqD1fo2jmUObyPCCWVjiA99QziLrlhH3ZUxh1TfmjHKqK913v3U
         KSHuvbPVTwFiv36hy53wFNLxIVioLba+chl+3qHME8lsImSuIDkWSgFAxbz80KN5sirE
         ZT9dCYmduYXb4pBALj44v8frilZ3LwYjmzCsH+dox5/EVgjQ+unXF9ncIf6WLJtjnF3n
         3Vn3YAfHzt2IYy9pu3qaTws5T2UcXK48z95F3UI2PIn76BFTG7dJqQF2RnuCPRNHCDlv
         Sjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583347; x=1730188147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwGRDDDofs0tVQxLtm45RAQmzhuGfydwRGPyCgbAQCE=;
        b=PkEEvJqrep1daUK1ktf4cGpWKOVIkNiA1bQ1btXwN/X/ZyDlSPGBuQ/c0MZtLg+OD3
         YozKPNw/rmjCDGH6xDamU5yDG5TqJVFb3B4i2U7Aw4ZkRjY6KanznXqwdSs6xMzZ93/y
         L5lvXLuXb6ZDYdqp7Ro1DtYEMIH7XLRTs6JwYm16IziP9f0E1gB+RDqGhI509JjUOR56
         xbk6RiK7cajtrXa0KhDHIAGOlthFS+oT8/UKyKMjVPAGlMzUUwzuhJYMcGfcDVvJJIcT
         R8q3cx/FE0E7zLSMgAsGoLzde73PQ+x9jxXBC7tuLoRqggVLHxwud4p8JBKLRgFdoo27
         FqYQ==
X-Gm-Message-State: AOJu0YyWE/sy60W/Bxvbda0tOjw7vLk6otJ0MgyJsN83U6gOvpQqBmKk
	1V3kKxRCWDeUhihGZWQQ7K2SDj8mH3283u7LUKdNXki0Fp3VVOfQ3hOGyaPtTZ4eYPByh3gVEVv
	w
X-Google-Smtp-Source: AGHT+IEPUqL2W/cH39RKCXidf6MG8tWgv/iNZgq3QaQaOX63nzR++teVEWtIgITUkqvzxm+sBGi//w==
X-Received: by 2002:a17:907:6d15:b0:a99:e619:260e with SMTP id a640c23a62f3a-a9a69bab0e7mr1353632566b.28.1729583347245;
        Tue, 22 Oct 2024 00:49:07 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a912d63bcsm306272666b.12.2024.10.22.00.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:49:06 -0700 (PDT)
Message-ID: <b648f0b6-2df3-43ca-880e-a5290d0b8381@linaro.org>
Date: Tue, 22 Oct 2024 09:49:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] tools/lib/thermal: Add the threshold netlink ABI
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-4-daniel.lezcano@linaro.org>
 <eedddb6e-fe0b-4785-9590-4b607d775769@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <eedddb6e-fe0b-4785-9590-4b607d775769@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2024 22:47, Lukasz Luba wrote:
> 
> 
> On 10/14/24 10:43, Daniel Lezcano wrote:
>> The thermal framework supports the thresholds and allows the userspace
>> to create, delete, flush, get the list of the thresholds as well as
>> getting the list of the thresholds set for a specific thermal zone.
>>
>> Add the netlink abstraction in the thermal library to take full
>> advantage of thresholds for the userspace program.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   tools/lib/thermal/commands.c        | 128 +++++++++++++++++++++++++++-
>>   tools/lib/thermal/events.c          |  55 +++++++++---
>>   tools/lib/thermal/include/thermal.h |  40 +++++++++
>>   tools/lib/thermal/libthermal.map    |   5 ++
>>   tools/lib/thermal/thermal.c         |  17 ++++
>>   tools/thermal/lib/Makefile          |   2 +-
>>   6 files changed, 232 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
>> index a9223df91dcf..9d5e3e891628 100644
>> --- a/tools/lib/thermal/commands.c
>> +++ b/tools/lib/thermal/commands.c
>> @@ -5,6 +5,7 @@
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <unistd.h>
>> +#include <limits.h>
>>   #include <thermal.h>
>>   #include "thermal_nl.h"
>> @@ -33,6 +34,11 @@ static struct nla_policy 
>> thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
>>       [THERMAL_GENL_ATTR_CDEV_CUR_STATE]      = { .type = NLA_U32 },
>>       [THERMAL_GENL_ATTR_CDEV_MAX_STATE]      = { .type = NLA_U32 },
>>       [THERMAL_GENL_ATTR_CDEV_NAME]           = { .type = NLA_STRING },
>> +
>> +        /* Thresholds */
>> +        [THERMAL_GENL_ATTR_THRESHOLD]          = { .type = NLA_NESTED },
>> +        [THERMAL_GENL_ATTR_THRESHOLD_TEMP]      = { .type = NLA_U32 },
>> +        [THERMAL_GENL_ATTR_THRESHOLD_DIRECTION] = { .type = NLA_U32 },
>>   };
>>   static int parse_tz_get(struct genl_info *info, struct thermal_zone 
>> **tz)
>> @@ -182,6 +188,38 @@ static int parse_tz_get_gov(struct genl_info 
>> *info, struct thermal_zone *tz)
>>       return THERMAL_SUCCESS;
>>   }
>> +static int parse_threshold_get(struct genl_info *info, struct 
>> thermal_zone *tz)
>> +{
>> +    struct nlattr *attr;
>> +    struct thermal_threshold *__tt = NULL;
>> +    size_t size = 0;
> 
> why not simply 'int' ?

Because it is used with realloc where the function definition is:

void *realloc(void *_Nullable ptr, size_t size);

and sizeof() return a size_t type.

So in order to not mix the types, size_t is used which I believe is a 
good practice :)

> also: size=0 which has some impact mentioned below.
> 
>> +    int rem;
> 
> I would make them a descending order, those lines.
> 
>> +
>> +    nla_for_each_nested(attr, info- 
>> >attrs[THERMAL_GENL_ATTR_THRESHOLD], rem) {
>> +
>> +        if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_TEMP) {
>> +
>> +            size++;
>> +
>> +            __tt = realloc(__tt, sizeof(*__tt) * (size + 2));
>> +            if (!__tt)
>> +                return THERMAL_ERROR;
>> +
>> +            __tt[size - 1].temperature = nla_get_u32(attr);
>> +        }
>> +
>> +        if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_DIRECTION)
>> +            __tt[size - 1].direction = nla_get_u32(attr);
> 
> We probably relay on some order here, because the 'size -1' needs to be
> done after first 'size++'.
> If that the case then maybe it's worth a comment. Or if it wasn't
> intended and there are no strong guarantees, then this needs a fix.

The size contains the size of the array and we want to access the last 
element, size - 1

I will add this sentence above as a comment if it is ok for you

>> +    }
>> +
>> +    if (__tt)
>> +        __tt[size].temperature = INT_MAX;
>> +
>> +    tz->thresholds = __tt;
> 
> I wonder what would happen to the previous 'tz->thresholds' when
> we just put new one here... I cannot find other place when it's set.
> 
> Since we have '*__tt = NULL' then one of the solutions would be
> to simply call:
>      free(tz->thresholds);
>      tz->thresholds = __tt;
> 
> Am I missing something, when it might be cleaned in different place?

The caller is supposed to pass a clean empty structure.

Usually, this function is to discover the current configuration, so it 
is a one shot call keeping the structure in memory for the libthermal 
lifecycle.

The events sends updates of the thermal zones. So with the events and 
the initial configuration from the discovery, the userspace is always 
up-to-date with the thermal setup.


>> +
>> +    return THERMAL_SUCCESS;
>> +}
>> +
>>   static int handle_netlink(struct nl_cache_ops *unused,
>>                 struct genl_cmd *cmd,
>>                 struct genl_info *info, void *arg)
>> @@ -210,6 +248,10 @@ static int handle_netlink(struct nl_cache_ops 
>> *unused,
>>           ret = parse_tz_get_gov(info, arg);
>>           break;
>> +    case THERMAL_GENL_CMD_THRESHOLD_GET:
>> +        ret = parse_threshold_get(info, arg);
>> +        break;
>> +
> 
> I can see in the kernel part in the funciton:
> thermal_genl_cmd_doit()
> that there add, delete, flush also send a response
> message. Shouldn't be handled here gently, otherwise

No, those are commands and the transaction is done at the netlink level 
to say if the command was successful or not.

>>       default:
>>           return THERMAL_ERROR;
> 
> that 'default' might capture them?

[ ... ]

>>   int for_each_thermal_cdev(struct thermal_cdev *cdev, cb_tc_t cb, 
>> void *arg)
>>   {
>>       int i, ret = 0;
>> @@ -80,6 +94,9 @@ static int __thermal_zone_discover(struct 
>> thermal_zone *tz, void *th)
>>       if (thermal_cmd_get_trip(th, tz) < 0)
>>           return -1;
>> +    if (thermal_cmd_threshold_get(th, tz) < 0)
> 
> There are only 2 definitions in the enum thermal_error_t.
> I would just simply checked if it's not 0:


Ok

Thanks for the review

>      if (thermal_cmd_threshold_get(th, tz))
>          return -1;
> 
> Although, it's a minor thing, not affecting the end result.
> 
>> +        return -1;
>> +
>>       if (thermal_cmd_get_governor(th, tz))
>>           return -1;
>> diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
>> index 82db451935c5..f2552f73a64c 100644
>> --- a/tools/thermal/lib/Makefile
>> +++ b/tools/thermal/lib/Makefile
>> @@ -3,7 +3,7 @@
>>   LIBTHERMAL_TOOLS_VERSION = 0
>>   LIBTHERMAL_TOOLS_PATCHLEVEL = 0
>> -LIBTHERMAL_TOOLS_EXTRAVERSION = 1
>> +LIBTHERMAL_TOOLS_EXTRAVERSION = 2
>>   MAKEFLAGS += --no-print-directory


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A933D3602EA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhDOHDX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 03:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOHDX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 03:03:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A77C061574
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 00:02:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e2so7225024plh.8
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3h1oZj4WXJcD7rrU5t6VWEUyKsHQVqefREWaa7aXCeU=;
        b=BQ+tErL5UkP+tV5fKgxs+GVDMlLOPM8MUQsJFM1zoC7nnMzTVtpVkEoPizFOEF1c7R
         v/MqexDmeTHj2vXODoZctza0dWfPtp+mnRmB5T/qaNdec9H17Qs2zo3rnDUBM0e+VzlZ
         spKXrJtsFJxQMbMG4wYRHQyEng4GQ+sHtvKcBZ3EIt+NAemYcOywrEKrEmzP9y3MNJO8
         nPEu/938GftARk8MQu9xAUh/VjqVi+DNLDfR7hA+NpMQsggqGSPUUNZIRvjsMN2epWJb
         T3C2eGN6H4/tvMYvBAJzdaM9fS/IPx2+Br0V9CZ+pirtWLHFiF4+6+pnKGo6bW9n5Mbm
         Gk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3h1oZj4WXJcD7rrU5t6VWEUyKsHQVqefREWaa7aXCeU=;
        b=KnHRk5LLGtgKCNBsbMWhH7P/cRdvf5yedXWAzJtQ8+aTIuKb5o/pWKvXSYGx6dalkn
         +Lrg2eQ71h7t4LX/HzQaYtnb3ODR4yH+YBcUnwmU7EMpn/pM5lXVu6Z6HCbAhp7P1Tfs
         njh5sWWaFJief46Qh0nejNIvtHXs+gjv4QokrmKnDXZWPCsoFU4OaGRqouOoCglIhFfT
         QBj3P8uV2pa6+DtCgXlJJ9bknjbL5DyBmCyTzLQiupL07BVIna6uMnW/eN4Ks8Nnup5K
         bOTbq0O7MV8O40JYyRZsXsH3scHFvayQ7XcOGZmJPheL4XZX8fG66ONQj5BjeQQpWiYd
         QOdQ==
X-Gm-Message-State: AOAM532FbcHO+aqOn1qIC5pIvSsOPf0QgC+zgCc8HwNBMG2I1GRQai6j
        GgFlGQxM2NrsjBy2WjORqb4=
X-Google-Smtp-Source: ABdhPJxPJW5pLuIx6BmQfyP+mpGL7yIoKMnF9rsm889Cyz3ojQjPuR2R6FJwwQhajAXYQVJRUadisw==
X-Received: by 2002:a17:902:b117:b029:e6:81ed:8044 with SMTP id q23-20020a170902b117b02900e681ed8044mr2311986plr.13.1618470179101;
        Thu, 15 Apr 2021 00:02:59 -0700 (PDT)
Received: from MacBook-Pro.local ([122.10.101.142])
        by smtp.gmail.com with ESMTPSA id z18sm1219851pfa.39.2021.04.15.00.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 00:02:58 -0700 (PDT)
Subject: [PATCH v2 2/2] cpupower: fix amd cpu (family >= 0x17) active state
 issue
From:   xufuhai <xufuhai1992@gmail.com>
To:     Thomas Renninger <trenn@suse.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, linux-pm@vger.kernel.org,
        xufuhai <xufuhai@kuaishou.com>
Cc:     lishujin@kuaishou.com
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
 <20210324082838.41462-2-xufuhai1992@gmail.com> <1717786.6COvnHc5Zm@c100>
 <20df509c-5a2d-3bfc-f08f-142b18c896ed@gmail.com>
 <6de2b9d1-435d-99a2-c733-4f49483f8f57@gmail.com>
Message-ID: <79f26f6b-f9f8-36ac-6f43-6329935ba9e4@gmail.com>
Date:   Thu, 15 Apr 2021 15:02:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <6de2b9d1-435d-99a2-c733-4f49483f8f57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: xufuhai <xufuhai@kuaishou.com>

If the read_msr function is executed by a non-root user, the function returns 
-1, which means that there is no permission to access /dev/cpu/%d/msr, but 
cpufreq_has_boost_support should also return -1 immediately, and should not
follow the original logic to return 0, which will cause amd The cpupower tool
returns the boost active state as 0.

Reproduce procedure:
        cpupower frequency-info

Signed-off-by: xufuhai <xufuhai@kuaishou.com>
Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
Signed-off-by: lishujin <lishujin@kuaishou.com>
Reviewed-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..565f8c414396 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -16,7 +16,7 @@
 int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
                        int *states)
 {
-       int ret;
+       int ret = 0;
        unsigned long long val;

        *support = *active = *states = 0;
@@ -30,18 +30,21 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
                 */

                if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
-                       if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
+                       /*
+                        * no permission to access /dev/cpu/%d/msr, return -1 immediately,
+                        * and should not follow the original logic to return 0
+                        */
+                       ret = read_msr(cpu, MSR_AMD_HWCR, &val);
+                       if (!ret) {
                                if (!(val & CPUPOWER_AMD_CPBDIS))
                                        *active = 1;
                        }
                } else {
                        ret = amd_pci_get_num_boost_states(active, states);
-                       if (ret)
-                               return ret;
                }
        } else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
                *support = *active = 1;
-       return 0;
+       return ret;
 }

在 2021/4/8 上午10:21, xufuhai 写道:
> Any reply? Thomas
> 
> 在 2021/3/30 上午10:46, xufuhai 写道:
>> Thanks for your review, Thomas～
>> as you suggested, I have updated my patch as your advice.
>> Please help me review the patch again. thanks
>>
>>
>> ----------------------------------------------------------------------------------------------------
>>
>> From: xufuhai <xufuhai@kuaishou.com>
>>
>> If the read_msr function is executed by a non-root user, the function returns 
>> -1, which means that there is no permission to access /dev/cpu/%d/msr, but 
>> cpufreq_has_boost_support should also return -1 immediately, and should not
>> follow the original logic to return 0, which will cause amd The cpupower tool
>> returns the boost active state as 0.
>>
>> Reproduce procedure:
>>         cpupower frequency-info
>>
>> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
>> Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
>> Signed-off-by: lishujin <lishujin@kuaishou.com>
>> Reviewed-by: Thomas Renninger <trenn@suse.com>
>> ---
>>  tools/power/cpupower/utils/helpers/misc.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
>> index fc6e34511721..565f8c414396 100644
>> --- a/tools/power/cpupower/utils/helpers/misc.c
>> +++ b/tools/power/cpupower/utils/helpers/misc.c
>> @@ -16,7 +16,7 @@
>>  int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>>                         int *states)
>>  {
>> -       int ret;
>> +       int ret = 0;
>>         unsigned long long val;
>>
>>         *support = *active = *states = 0;
>> @@ -30,18 +30,21 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>>                  */
>>
>>                 if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
>> -                       if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
>> +                       /*
>> +                        * no permission to access /dev/cpu/%d/msr, return -1 immediately,
>> +                        * and should not follow the original logic to return 0
>> +                        */
>> +                       ret = read_msr(cpu, MSR_AMD_HWCR, &val);
>> +                       if (!ret) {
>>                                 if (!(val & CPUPOWER_AMD_CPBDIS))
>>                                         *active = 1;
>>                         }
>>                 } else {
>>                         ret = amd_pci_get_num_boost_states(active, states);
>> -                       if (ret)
>> -                               return ret;
>>                 }
>>         } else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>>                 *support = *active = 1;
>> -       return 0;
>> +       return ret;
>>  }
>>
>>  int cpupower_intel_get_perf_bias(unsigned int cpu)
>> --
>> 2.24.3 (Apple Git-128)
>>
>> 在 2021/3/29 下午6:58, Thomas Renninger 写道:
>>> Hi,
>>>
>>> Am Mittwoch, 24. März 2021, 09:28:38 CEST schrieb xufuhai:
>>>> From: xufuhai <xufuhai@kuaishou.com>
>>>>
>>>> If the read_msr function is executed by a non-root user, the function
>>>> returns -1, which means that there is no permission to access
>>>> /dev/cpu/%d/msr, but cpufreq_has_boost_support should also return -1
>>>> immediately, and should not follow the original logic to return 0, which
>>>> will cause amd The cpupower tool returns the turbo active status as 0.
>>>
>>> Yes, this seem to be buggy.
>>> Can you clean this up a bit more, please:
>>>
>>>> Reproduce procedure:
>>>>         cpupower frequency-info
>>>>
>>>> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
>>>> ---
>>>>  tools/power/cpupower/utils/helpers/misc.c | 9 +++++++--
>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/power/cpupower/utils/helpers/misc.c
>>>> b/tools/power/cpupower/utils/helpers/misc.c index
>>>> fc6e34511721..be96f9ce18eb 100644
>>>> --- a/tools/power/cpupower/utils/helpers/misc.c
>>>> +++ b/tools/power/cpupower/utils/helpers/misc.c
>>>> @@ -30,10 +30,15 @@ int cpufreq_has_boost_support(unsigned int cpu, int
>>>> *support, int *active, */
>>>>
>>>>  		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
>>>> -			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
>>>> +			ret = read_msr(cpu, MSR_AMD_HWCR, &val);
>>>> +			if (!ret) {
>>> ret should be initialized. I would initialize it with -1, but as Intel case
>>> is always "good"/zero, it may make sense here to set:
>>>
>>> ret = 0
>>> at the beginning of the func already.
>>> At the end of the func, unconditionally returning zero:
>>>         return 0;
>>> should be replace by:
>>>         return ret;
>>>
>>>>  				if (!(val & CPUPOWER_AMD_CPBDIS))
>>>>  					*active = 1;
>>>> -			}
>>>> +			} else
>>>> +				/* no permission to access /dev/cpu/%d/msr, return -1 immediately,
>>>> +				 * and should not follow the original logic to return 0
>>>> +				 */
>>>> +				return ret;
>>>
>>> Then this part is not needed anymore, right?
>>> Still the comment would be nice to show up, maybe slightly modified
>>> in the if condition?
>>> Afaik 100% correct comment would be:
>>> /* ... */
>>> for one line comment and:
>>> /*
>>> * ...
>>> * ...
>>> */
>>> for multiline comment (one more line..).
>>>
>>>>  		} else {
>>>>  			ret = amd_pci_get_num_boost_states(active, states);
>>>>  			if (ret)
>>> and these 2 lines can vanish as well at this point:
>>>                         if (ret)
>>>                                 return ret;
>>>
>>> What do you think?
>>>
>>> Thanks for spotting this,
>>>
>>>           Thomas
>>>
>>>

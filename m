Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC7357A43
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 04:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhDHCVr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 22:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhDHCVr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 22:21:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED2C061760
        for <linux-pm@vger.kernel.org>; Wed,  7 Apr 2021 19:21:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4017020pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Apr 2021 19:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DObpaypk4J61tlmIju1rXK3u1wbmhpmNH58X5jLNjmA=;
        b=dukf8hAsxeLwWXj8wcgOQRiXUw9/cMDm6E6ZuGgqnWZFY0K1SF0RbwOe5OBTc0fEZx
         5/onWaAGog91DZTP0CWBqqsCOaN4ywH3E5ggRi+hlz6NtY1HEbeiKzTD2qciqsKeTdcg
         UXIFoFK5nY88R+h/HHw+9EUjNwdVqh7AH57QiNELwTsBlkiYAxiQLHc+AV38VJrD3OtK
         9c/41Q+MY5Wtzk5fMBBNUaL9GzOBiUbC2aXWNf7BQl3gP6JBzRq5k+KMn8lXKQ+bexnR
         MPC90UJNcdtafOzqCzE8CogSg4T2CdOzm61evuDiien/Vi8bMIDq2iITf2bZRJad1OjU
         p3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DObpaypk4J61tlmIju1rXK3u1wbmhpmNH58X5jLNjmA=;
        b=E3snTCf1g35G3gnRCdPzlePKbDTwDIaRjpullJoiC9FfXW5s7SJyZZ6dgmvfapwV5T
         ye8t08y9XouAYu4fYOZfaX+D4vxv0jox61r3ZBk6xdfXIF5PA4NrZi8HDT+d1A3rTR/z
         XIp2tobwwu2lMRpKzFRGD1t+nPxlO5BFmdN68iAP5kDNfPgQXBtRJkRj9k9koVUq71sx
         3UphX9M6ssNPB4V1p982gfk/rNeJq+gac5MUlLF7ysq6Ppx703qO/Qk+czMQAPLoat4g
         TJnyeUwmd5N2sHqgbJmulIbYM9wsyskSm+sL7D0EEYuVSKPTjpfX3d4vTqbzK5XWbuDG
         cf/w==
X-Gm-Message-State: AOAM530J5LTXigKyNHdoxI+OR7+ah6J5rsLdCIQYEAxmNso1LYYn8FDp
        rRdud6DWOgEo8jBPWg39JqVUlkIBodHOBjjG
X-Google-Smtp-Source: ABdhPJzWHxJnTsEW+++Dd7M7wHplqjLvKyJp+Io4TVDG7U/bCFXtfiq4oz2AmRJR+hezVBd9dWB2LA==
X-Received: by 2002:a17:90a:a513:: with SMTP id a19mr6430518pjq.210.1617848495074;
        Wed, 07 Apr 2021 19:21:35 -0700 (PDT)
Received: from MacBook-Pro.local ([154.48.252.70])
        by smtp.gmail.com with ESMTPSA id e7sm22190807pfc.88.2021.04.07.19.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 19:21:34 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpupower: fix amd cpu (family >= 0x17) active state
 issue
From:   xufuhai <xufuhai1992@gmail.com>
To:     Thomas Renninger <trenn@suse.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, linux-pm@vger.kernel.org,
        xufuhai <xufuhai@kuaishou.com>
Cc:     lishujin@kuaishou.com
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
 <20210324082838.41462-2-xufuhai1992@gmail.com> <1717786.6COvnHc5Zm@c100>
 <20df509c-5a2d-3bfc-f08f-142b18c896ed@gmail.com>
Message-ID: <6de2b9d1-435d-99a2-c733-4f49483f8f57@gmail.com>
Date:   Thu, 8 Apr 2021 10:21:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20df509c-5a2d-3bfc-f08f-142b18c896ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Any reply? Thomas

在 2021/3/30 上午10:46, xufuhai 写道:
> Thanks for your review, Thomas～
> as you suggested, I have updated my patch as your advice.
> Please help me review the patch again. thanks
> 
> 
> ----------------------------------------------------------------------------------------------------
> 
> From: xufuhai <xufuhai@kuaishou.com>
> 
> If the read_msr function is executed by a non-root user, the function returns 
> -1, which means that there is no permission to access /dev/cpu/%d/msr, but 
> cpufreq_has_boost_support should also return -1 immediately, and should not
> follow the original logic to return 0, which will cause amd The cpupower tool
> returns the boost active state as 0.
> 
> Reproduce procedure:
>         cpupower frequency-info
> 
> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
> Signed-off-by: lishujin <lishujin@kuaishou.com>
> Reviewed-by: Thomas Renninger <trenn@suse.com>
> ---
>  tools/power/cpupower/utils/helpers/misc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index fc6e34511721..565f8c414396 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -16,7 +16,7 @@
>  int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>                         int *states)
>  {
> -       int ret;
> +       int ret = 0;
>         unsigned long long val;
> 
>         *support = *active = *states = 0;
> @@ -30,18 +30,21 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>                  */
> 
>                 if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
> -                       if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
> +                       /*
> +                        * no permission to access /dev/cpu/%d/msr, return -1 immediately,
> +                        * and should not follow the original logic to return 0
> +                        */
> +                       ret = read_msr(cpu, MSR_AMD_HWCR, &val);
> +                       if (!ret) {
>                                 if (!(val & CPUPOWER_AMD_CPBDIS))
>                                         *active = 1;
>                         }
>                 } else {
>                         ret = amd_pci_get_num_boost_states(active, states);
> -                       if (ret)
> -                               return ret;
>                 }
>         } else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>                 *support = *active = 1;
> -       return 0;
> +       return ret;
>  }
> 
>  int cpupower_intel_get_perf_bias(unsigned int cpu)
> --
> 2.24.3 (Apple Git-128)
> 
> 在 2021/3/29 下午6:58, Thomas Renninger 写道:
>> Hi,
>>
>> Am Mittwoch, 24. März 2021, 09:28:38 CEST schrieb xufuhai:
>>> From: xufuhai <xufuhai@kuaishou.com>
>>>
>>> If the read_msr function is executed by a non-root user, the function
>>> returns -1, which means that there is no permission to access
>>> /dev/cpu/%d/msr, but cpufreq_has_boost_support should also return -1
>>> immediately, and should not follow the original logic to return 0, which
>>> will cause amd The cpupower tool returns the turbo active status as 0.
>>
>> Yes, this seem to be buggy.
>> Can you clean this up a bit more, please:
>>
>>> Reproduce procedure:
>>>         cpupower frequency-info
>>>
>>> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
>>> ---
>>>  tools/power/cpupower/utils/helpers/misc.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/power/cpupower/utils/helpers/misc.c
>>> b/tools/power/cpupower/utils/helpers/misc.c index
>>> fc6e34511721..be96f9ce18eb 100644
>>> --- a/tools/power/cpupower/utils/helpers/misc.c
>>> +++ b/tools/power/cpupower/utils/helpers/misc.c
>>> @@ -30,10 +30,15 @@ int cpufreq_has_boost_support(unsigned int cpu, int
>>> *support, int *active, */
>>>
>>>  		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
>>> -			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
>>> +			ret = read_msr(cpu, MSR_AMD_HWCR, &val);
>>> +			if (!ret) {
>> ret should be initialized. I would initialize it with -1, but as Intel case
>> is always "good"/zero, it may make sense here to set:
>>
>> ret = 0
>> at the beginning of the func already.
>> At the end of the func, unconditionally returning zero:
>>         return 0;
>> should be replace by:
>>         return ret;
>>
>>>  				if (!(val & CPUPOWER_AMD_CPBDIS))
>>>  					*active = 1;
>>> -			}
>>> +			} else
>>> +				/* no permission to access /dev/cpu/%d/msr, return -1 immediately,
>>> +				 * and should not follow the original logic to return 0
>>> +				 */
>>> +				return ret;
>>
>> Then this part is not needed anymore, right?
>> Still the comment would be nice to show up, maybe slightly modified
>> in the if condition?
>> Afaik 100% correct comment would be:
>> /* ... */
>> for one line comment and:
>> /*
>> * ...
>> * ...
>> */
>> for multiline comment (one more line..).
>>
>>>  		} else {
>>>  			ret = amd_pci_get_num_boost_states(active, states);
>>>  			if (ret)
>> and these 2 lines can vanish as well at this point:
>>                         if (ret)
>>                                 return ret;
>>
>> What do you think?
>>
>> Thanks for spotting this,
>>
>>           Thomas
>>
>>

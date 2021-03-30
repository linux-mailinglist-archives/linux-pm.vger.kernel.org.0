Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E813734DEAD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 04:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhC3Cqu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 22:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhC3CqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 22:46:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B643C061762
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 19:46:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v10so5798597pfn.5
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 19:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=N1lbOxp/DtqhG49ERwgJCdQes8y1LFDMqK4IumGuOPw=;
        b=SjFh8ZnWd/PkKBCtJZBPEx8s5ddtZO6r7HPBclyfmuxB/v6/zYpHXFSjFZHvqSjOQ9
         iq1EGzjbv/LhcH9qfyrigdKaJVNK5Tjcn+04loRAxX2AYPgr0NeXzijAfuSW9QkL0tOb
         pRvhs/pYuCdax8wsZ3+6fKy+1XzwcKpTJtv2CpkXd3EX86r8nmwyHPtsbM9XtQ8SURnc
         Rg5lK5WHwRuFmMm24bpYTQfOTxQgfrJrC4AkLj/IO9y2weCY3j4rBXVwX/IkiDv4yHYw
         xPyTlokv9y4/dF+2JRzpBK1nAdAX0ns3ov0cwtAWY3aozjm3fymJrHCMXnSaUkbJLv/s
         amlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=N1lbOxp/DtqhG49ERwgJCdQes8y1LFDMqK4IumGuOPw=;
        b=hk0Xmc1mokIOt7z+iH/12X+okWiqMe0r5DaMrr4MdMGY8Dh5RNZ+zs43aG+SoN/pqK
         KxNfsTmmzMY1RSheYXZAQIklx8xgb49AGp/T1ADSCa8lvftiKeRU8xgwspr8FGBXGt/U
         /+mlsheWY0QVWC7qryIACa4pfRpbBguNRgwGuegE80CLjz7Z1p3mg2oA85cL3yZY6tlQ
         U3AKFfKyYmXphV3Lh1lH6B6brbMYV9a6hLJmp89bbBwT49smzyd1eAZAf92yG8ywxeJ/
         VWzSb6sX9bm7rJV6oYepXOcKrFmXeltUomFXnXwS6UP6TuzmlukkX+fmIqj9kOpRq6Mj
         PAfA==
X-Gm-Message-State: AOAM530tE3nSfCJ2iPvPxbe1hTsw0GN07BAw1BsfqpYJOf6hRJfZaiAx
        xM9JBcqQRI8TGE+yb9WFVJA=
X-Google-Smtp-Source: ABdhPJxOTmv4r6US9EgSLI7MoKJ9HOm8eAZK/0AqBdOWq4Tp+NLcNMiEnbwTEOwSYThcv7mem6dOQA==
X-Received: by 2002:aa7:848b:0:b029:1ef:4e98:6bb6 with SMTP id u11-20020aa7848b0000b02901ef4e986bb6mr27810208pfn.58.1617072375935;
        Mon, 29 Mar 2021 19:46:15 -0700 (PDT)
Received: from MacBook-Pro.local ([154.48.252.70])
        by smtp.gmail.com with ESMTPSA id d2sm1002489pjx.42.2021.03.29.19.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 19:46:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpupower: fix amd cpu (family >= 0x17) active state
 issue
To:     Thomas Renninger <trenn@suse.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, linux-pm@vger.kernel.org,
        xufuhai <xufuhai@kuaishou.com>
Cc:     lishujin@kuaishou.com
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
 <20210324082838.41462-2-xufuhai1992@gmail.com> <1717786.6COvnHc5Zm@c100>
From:   xufuhai <xufuhai1992@gmail.com>
Message-ID: <20df509c-5a2d-3bfc-f08f-142b18c896ed@gmail.com>
Date:   Tue, 30 Mar 2021 10:46:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1717786.6COvnHc5Zm@c100>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for your review, Thomas～
as you suggested, I have updated my patch as your advice.
Please help me review the patch again. thanks


----------------------------------------------------------------------------------------------------

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

 int cpupower_intel_get_perf_bias(unsigned int cpu)
--
2.24.3 (Apple Git-128)

在 2021/3/29 下午6:58, Thomas Renninger 写道:
> Hi,
> 
> Am Mittwoch, 24. März 2021, 09:28:38 CEST schrieb xufuhai:
>> From: xufuhai <xufuhai@kuaishou.com>
>>
>> If the read_msr function is executed by a non-root user, the function
>> returns -1, which means that there is no permission to access
>> /dev/cpu/%d/msr, but cpufreq_has_boost_support should also return -1
>> immediately, and should not follow the original logic to return 0, which
>> will cause amd The cpupower tool returns the turbo active status as 0.
> 
> Yes, this seem to be buggy.
> Can you clean this up a bit more, please:
> 
>> Reproduce procedure:
>>         cpupower frequency-info
>>
>> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
>> ---
>>  tools/power/cpupower/utils/helpers/misc.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/power/cpupower/utils/helpers/misc.c
>> b/tools/power/cpupower/utils/helpers/misc.c index
>> fc6e34511721..be96f9ce18eb 100644
>> --- a/tools/power/cpupower/utils/helpers/misc.c
>> +++ b/tools/power/cpupower/utils/helpers/misc.c
>> @@ -30,10 +30,15 @@ int cpufreq_has_boost_support(unsigned int cpu, int
>> *support, int *active, */
>>
>>  		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
>> -			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
>> +			ret = read_msr(cpu, MSR_AMD_HWCR, &val);
>> +			if (!ret) {
> ret should be initialized. I would initialize it with -1, but as Intel case
> is always "good"/zero, it may make sense here to set:
> 
> ret = 0
> at the beginning of the func already.
> At the end of the func, unconditionally returning zero:
>         return 0;
> should be replace by:
>         return ret;
> 
>>  				if (!(val & CPUPOWER_AMD_CPBDIS))
>>  					*active = 1;
>> -			}
>> +			} else
>> +				/* no permission to access /dev/cpu/%d/msr, return -1 immediately,
>> +				 * and should not follow the original logic to return 0
>> +				 */
>> +				return ret;
> 
> Then this part is not needed anymore, right?
> Still the comment would be nice to show up, maybe slightly modified
> in the if condition?
> Afaik 100% correct comment would be:
> /* ... */
> for one line comment and:
> /*
> * ...
> * ...
> */
> for multiline comment (one more line..).
> 
>>  		} else {
>>  			ret = amd_pci_get_num_boost_states(active, states);
>>  			if (ret)
> and these 2 lines can vanish as well at this point:
>                         if (ret)
>                                 return ret;
> 
> What do you think?
> 
> Thanks for spotting this,
> 
>           Thomas
> 
> 

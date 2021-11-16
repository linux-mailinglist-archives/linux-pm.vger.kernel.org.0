Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A671A4535BF
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 16:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhKPPaf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 10:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbhKPPad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 10:30:33 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53642C061746
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 07:27:35 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id g1so12365582qvd.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 07:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aIR+6SGDsBIdvPmIidBVFrt2gkfBA8dAwyBdKNZqHWw=;
        b=XdAq18HqT3EbhBXUlxrtfVFuucegkjZpFGAHqIihs50oSdNtQ6OtlkfjqUkt8Jn5I8
         nzcWUYJALeVwCDOjAJKF+duSnwblNR+u39AuwLi17ZJ4XJUYUy6V6k3XJ/y/ejcNzRls
         +8/orDG4K+ljPKryCqwqblcJ+N2Irb7XrQxZK9mFgUDN3WNy0ZdUf74VhD/k84omYfl0
         iZROc1uFpGIoZcU7KE1mEzZ65/dVX/U2rHicw2MXcxWs6BbPY20Xj5GS6bHs0SK48Gha
         ipR1sx3sCjJtDa2ZVbRCwo/pEmQmwHzGMbv27Bq5hPsIEkjTAcQ8VDelYcKqA2qxQ/NU
         ToqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aIR+6SGDsBIdvPmIidBVFrt2gkfBA8dAwyBdKNZqHWw=;
        b=ftEZdWZ7qbYn7GbDO8MhWYNXr87u4aHr1jJn/pjlijKgxdERQD9shWTTfOk9eOS+y3
         GsfdLvPI9tR/5Yn8E1M5/3naBNV4ITZy1oFcZYg+BXaFbBGeFG1P/nQRAJI30cOLZMnr
         v96cNzaXDDZ/SmPEVQzFHirg/3kV1NzeFrTrfu5WTiLKFJfxRVXjAfIkOXJnoSQJAX//
         QHNvs+ya8H5qPUfGxkPXLNWHff67eNx8cp9BClRwSSlo6e4UeW5UaoqSxIysUIjavkjn
         CH9Kqs885sqHUg2IWcL4cVj0SXR3R9inDfW3W9SQ/zj5j4CYEyCZwkpsYB48ig16n1ob
         bcbw==
X-Gm-Message-State: AOAM532c3k7MO/1+rxo1yf0v7sJVYpvjnYLhThxmmo7IgZtm/We4d93S
        rNTKtm5aPnD7O3B88gRA0wofWKuu7BW3Xg==
X-Google-Smtp-Source: ABdhPJzPGtn8z2/uvb42fjIpYlSwhf/BFtetEKiM5RTkPesV1zDtM7BTk53pbcVTRx78B2tpvRp/PQ==
X-Received: by 2002:a05:6214:29c3:: with SMTP id gh3mr19606948qvb.30.1637076454395;
        Tue, 16 Nov 2021 07:27:34 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id c13sm9524138qtx.51.2021.11.16.07.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 07:27:33 -0800 (PST)
Subject: Re: [PATCH] cpufreq: freq_table: Initialize cpuinfo.max_freq to
 correct max frequency.
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     rafael@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20211115195011.52999-1-thara.gopinath@linaro.org>
 <5ae2c644-4743-c62c-b17c-96945a0e6a01@kali.org>
 <20211116035935.wmazontuznhys6qu@vireshk-i7>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <fd153d84-411a-c843-eab9-2dc66940a3d3@linaro.org>
Date:   Tue, 16 Nov 2021 10:27:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211116035935.wmazontuznhys6qu@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/15/21 10:59 PM, Viresh Kumar wrote:
> On 15-11-21, 19:23, Steev Klimaszewski wrote:
>> Hi Thara,
>>
>> On 11/15/21 1:50 PM, Thara Gopinath wrote:
>>> cpuinfo.max_freq reflects the maximum supported frequency of cpus in a
>>> cpufreq policy. When cpus support boost frequency and if boost is disabled
>>> during boot up (which is the default), cpuinfo.max_freq does not reflect
>>> boost frequency as the maximum supported frequency till boost is explicitly
>>> enabled via sysfs interface later. This also means that policy reports two
>>> different cpuinfo.max_freq before and after turning on boost.  Fix this by
>>> separating out setting of policy->max and cpuinfo.max_freq in
>>> cpufreq_frequency_table_cpuinfo.
>>>
>>> e.g. of the problem. Qualcomm sdm845 supports boost frequency for gold
>>> cluster (cpus 4-7). After boot up (boost disabled),
>>>
>>> 1.  cat /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq 2649600
>>> <- This is wrong because boost frequency is
>>>
>>> 2.  echo 1 > /sys/devices/system/cpu/cpufreq/boost  <- Enable boost cat
>>> /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq 2803200	<-
>>> max freq reflects boost freq.
>>>
>>> 3.  echo 0 > /sys/devices/system/cpu/cpufreq/boost <- Disable boost cat
>>> /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq 2803200	<-
>>> Discrepancy with step 1 as in both cases boost is disabled.
>>>
>>> Note that the other way to fix this is to set cpuinfo.max_freq in Soc
>>> cpufreq driver during initialization. Fixing it in
>>> cpufreq_frequency_table_cpuinfo seems more generic solution
>>>
>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>> ---
>>>    drivers/cpufreq/freq_table.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
>>> index 67e56cf638ef..6784f94124df 100644
>>> --- a/drivers/cpufreq/freq_table.c
>>> +++ b/drivers/cpufreq/freq_table.c
>>> @@ -35,11 +35,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>>>    	struct cpufreq_frequency_table *pos;
>>>    	unsigned int min_freq = ~0;
>>>    	unsigned int max_freq = 0;
>>> +	unsigned int cpuinfo_max_freq = 0;
>>>    	unsigned int freq;
>>>    	cpufreq_for_each_valid_entry(pos, table) {
>>>    		freq = pos->frequency;
>>> +		if (freq > cpuinfo_max_freq)
>>> +			cpuinfo_max_freq = freq;
>>> +
>>>    		if (!cpufreq_boost_enabled()
>>>    		    && (pos->flags & CPUFREQ_BOOST_FREQ))
>>>    			continue;
>>> @@ -57,8 +61,8 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>>>    	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>>>    	 * it as is.
>>>    	 */
>>> -	if (policy->cpuinfo.max_freq < max_freq)
>>> -		policy->max = policy->cpuinfo.max_freq = max_freq;
>>> +	if (policy->cpuinfo.max_freq < cpuinfo_max_freq)
>>> +		policy->cpuinfo.max_freq = cpuinfo_max_freq;
> 
> You need to keep the check of policy->max here and update policy->max,
> else you will never run at boost freq. I think this is what Steev
> reported as well ?

Hi Viresh,
	policy->max is unconditionally set to max_freq in the line before "if 
(policy->cpuinfo.max_freq < max_freq)". So this is not the issue Steev 
is reporting.
	policy->max = max_freq


> 
> So basically something like this:
> 
> 	if (policy->max < max_freq)
> 		policy->max = max_freq;
> 
> 	if (policy->cpuinfo.max_freq < cpuinfo_max_freq)
> 		policy->cpuinfo.max_freq = cpuinfo_max_freq;
> 

-- 
Warm Regards
Thara (She/Her/Hers)

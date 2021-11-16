Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53FD453717
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 17:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhKPQSo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 11:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhKPQSS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 11:18:18 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDBDC061766
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 08:15:21 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso20860242otr.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u8ODN0+4ZsZI21CDbjGHvdgsAbFs7DziYyrEY5d6/hE=;
        b=G1jAkmt7+aa4ykLjvXi8qFpGp96hjrkI/wz1mCqdEs5m2U2pD7jC/w03uhzLgVukro
         dzAAHUCFJr7N+Hyse6cKOL7duDDdqDlezxd3hwWDMnIW0UQSd+ixeGZKKS4vuQG9g40V
         ehTH/M6SbMzwHJdFPNuc9870p8kbXHyrvTAxYgaCccsMqKIPQOG0v6HmV2Zpc/TLMvge
         vxZ7daoUgILZA3yjFpwkO2nAhucN7SHw3kW4HsCVDLjhxPsk4k+UpbbcGhDoXw2ZLvKp
         ZCgVrHxhYgex1hrsjC6W1JibJB6bqzLvF/ZHNQuyeTHWW1RI1bH0O4XBxhiZdb6okng3
         1mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u8ODN0+4ZsZI21CDbjGHvdgsAbFs7DziYyrEY5d6/hE=;
        b=12Cav3Zqpvdcvz0QiY8FAONgE0DfDMrHxaOzGD2OhsZuW+jwklOxh+qzGrrCUmfCka
         ZHCGfnp/TRc1MCf/YzGe1dtfYvpvtCHDEyaC+rV1PJVWMH8jqg6DSuH94sIaCvRNah99
         rrDzvTPDfIIhbCnxhYSfnBd91BVXM442khmDgheX4LIJ2UvzlnEWYI21Fb72zz2ox7dI
         HEY1Puwlr4IWmDRTr+KSjUPHJmADKZgmeoXJxBGaZ3T9TDmMyleyFtiRwiSndVgbDu6a
         2X4mHaXHOoLsNZFep1sYsPedjx0ax3Rs8FQ8+kyMpK5r4QXmJ/eGHPHpHnAMVb5a30Nn
         lLuw==
X-Gm-Message-State: AOAM532r/hUhTmyKpKE0dvD5aK1aP0FBBAEbpHdOV0l9+MXEFYbZHSbt
        Qj4sj8QRu2C3DZePX6jVZHP0GQ==
X-Google-Smtp-Source: ABdhPJwfI5gxK4Wsb/24YL5rwx1Ho3QfHYo8lqtLJt5Q0y8LegTdikaa+/ftPZU9vxA2REgsKl46NA==
X-Received: by 2002:a05:6830:19c8:: with SMTP id p8mr7366091otp.111.1637079320156;
        Tue, 16 Nov 2021 08:15:20 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id t14sm836630oth.81.2021.11.16.08.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 08:15:19 -0800 (PST)
Message-ID: <7b440c0f-57eb-e367-bcc7-91c731d360d5@kali.org>
Date:   Tue, 16 Nov 2021 10:15:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] cpufreq: freq_table: Initialize cpuinfo.max_freq to
 correct max frequency.
Content-Language: en-US
To:     Thara Gopinath <thara.gopinath@linaro.org>, rafael@kernel.org,
        viresh.kumar@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20211115195011.52999-1-thara.gopinath@linaro.org>
 <5ae2c644-4743-c62c-b17c-96945a0e6a01@kali.org>
 <1ceb5a9b-817b-a9ef-c378-be3bd0f7ff17@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <1ceb5a9b-817b-a9ef-c378-be3bd0f7ff17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 11/16/21 9:31 AM, Thara Gopinath wrote:
> Hi Steev,
>
> Thanks for testing this.
>
> On 11/15/21 8:23 PM, Steev Klimaszewski wrote:
>
> --- snip
>>>
>>> diff --git a/drivers/cpufreq/freq_table.c 
>>> b/drivers/cpufreq/freq_table.c
>>> index 67e56cf638ef..6784f94124df 100644
>>> --- a/drivers/cpufreq/freq_table.c
>>> +++ b/drivers/cpufreq/freq_table.c
>>> @@ -35,11 +35,15 @@ int cpufreq_frequency_table_cpuinfo(struct 
>>> cpufreq_policy *policy,
>>>       struct cpufreq_frequency_table *pos;
>>>       unsigned int min_freq = ~0;
>>>       unsigned int max_freq = 0;
>>> +    unsigned int cpuinfo_max_freq = 0;
>>>       unsigned int freq;
>>>       cpufreq_for_each_valid_entry(pos, table) {
>>>           freq = pos->frequency;
>>> +        if (freq > cpuinfo_max_freq)
>>> +            cpuinfo_max_freq = freq;
>>> +
>>>           if (!cpufreq_boost_enabled()
>>>               && (pos->flags & CPUFREQ_BOOST_FREQ))
>>>               continue;
>>> @@ -57,8 +61,8 @@ int cpufreq_frequency_table_cpuinfo(struct 
>>> cpufreq_policy *policy,
>>>        * If the driver has set its own cpuinfo.max_freq above 
>>> max_freq, leave
>>>        * it as is.
>>>        */
>>> -    if (policy->cpuinfo.max_freq < max_freq)
>>> -        policy->max = policy->cpuinfo.max_freq = max_freq;
>>> +    if (policy->cpuinfo.max_freq < cpuinfo_max_freq)
>>> +        policy->cpuinfo.max_freq = cpuinfo_max_freq;
>>>       if (policy->min == ~0)
>>>           return -EINVAL;
>>
>>
>> Something still isn't quite right...
>>
>> The setup is that I have an rc.local of
>>
>> #!/bin/sh
>>
>> echo 1 > /sys/devices/system/cpu/cpufreq/boost
>>
>> exit 0
>>
>>
>> After booting and logging in:
>>
>> steev@limitless:~$ cat 
>> /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
>> 825600 2499
>> <snip>
>> 2649600 38
>> 2745600 31
>> 2841600 1473
>> 2956800 0
>
> Did you try debugging this ? As in did you read back boost and 
> cpuinfo_max_freq at this point to ensure that everything is as expected ?
>
>
Hi Thara,

I did - sorry I forgot to mention that boost does show 1 for enabled and 
cpuinfo_max_freq is set to 2956800.  However, scaling_max_freq is still 
listed as 2841600 and scaling_available_frequencies still shows 2841600 
as the max available. scaling_boost_freqencies does also list 2956800.

steev@limitless:~$ grep . /sys/devices/system/cpu/cpufreq/policy4/*
/sys/devices/system/cpu/cpufreq/policy4/affected_cpus:4 5 6 7
grep: /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_cur_freq: 
Permission denied
/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq:2956800
/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_min_freq:825600
/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpufreq/policy4/related_cpus:4 5 6 7
/sys/devices/system/cpu/cpufreq/policy4/scaling_available_frequencies:825600 
902400 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 
1689600 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 
2400000 2476800 2553600 2649600 2745600 2841600
/sys/devices/system/cpu/cpufreq/policy4/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies:2956800
/sys/devices/system/cpu/cpufreq/policy4/scaling_cur_freq:1920000
/sys/devices/system/cpu/cpufreq/policy4/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpufreq/policy4/scaling_governor:schedutil
/sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq:2841600
/sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq:825600
/sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed:<unsupported>


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAEB449E10
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 22:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbhKHVZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 16:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbhKHVZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 16:25:52 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE3C061714
        for <linux-pm@vger.kernel.org>; Mon,  8 Nov 2021 13:23:07 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j9so12788346qvm.10
        for <linux-pm@vger.kernel.org>; Mon, 08 Nov 2021 13:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4SKcoo0lkoTFwqwoPK2C06hU0WWJJEw7eZhBKrffPUs=;
        b=uYVa6n/+HMqiX97UVrg6rGsHLVd/IfQ7a9mffA5FhKFrcDI298PaV3Ab1ensnTIoou
         Z662Szdc7FG8vhcKjB8O8yTw6HLFDzuZ2k3T969MD4qfDsh7oSU21xhOg5trs/ebJ8if
         4yWnoB1M7GHRtM9HCNjEk2OBt+xtMfTzNQhYyoeErNJeu5+pVY09BPSxYEpEDFMUmaue
         ZDH8aAHFGuMHi6B71gP73VHXZrkJeamof1HWU/MVJa8PdVYM3tkrCnwGZLb6G+dSlCr5
         1J2c+UqMWQnnvVbvfSbRGNUPdQCOHVVRK1OJGBSmzbMAXjh9UApioU41P7XPfCxPq6hf
         2Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4SKcoo0lkoTFwqwoPK2C06hU0WWJJEw7eZhBKrffPUs=;
        b=tAShJf0rHPRjsiatoDCAn+xOFSboDvj/VWIeTje1sOAdkhHWQ4fGtQRwG4C1/p5CK3
         Ubv56Kk60ueA0JSNOgqcR6pC1EtG/HKgUckwbi2+Y5CjbQ+j7qSSNYix4OyonICCR+XA
         19+WHNdipnwNpD9WceM22BB9ZLdWzxoNJgWNWhJfbzVFAeNJuDg4WwVOzwJLYc7qWx6H
         5R+ehwrOslDZ2DouBFzRk+2TGDhst6E65mPnQlGanCGiPVvKJmgnv2rNZtldPjaM6q10
         253hwUYULqW0/sy/qTF3h3n/CXyh4vk5HJ9e5jGWjMAEw7y61O/+EYxtQ3dTzUAo0O/j
         ms7Q==
X-Gm-Message-State: AOAM530mR1ksv55yl4AgVUJUSwx/OakJo3pSRRHA+RtDl7KmMQ0JAvXN
        z5Ncv1A9T5G96tkz4O4UjMIdKg==
X-Google-Smtp-Source: ABdhPJylaI/WDLHxydCZIXl5yw3Xo8Hz/ksEn1jVyB58NKa+TRAjC41SlTuSIdyDWnztdbdRRXa9WA==
X-Received: by 2002:ad4:5c67:: with SMTP id i7mr2335799qvh.37.1636406586327;
        Mon, 08 Nov 2021 13:23:06 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id y73sm1900016qkb.113.2021.11.08.13.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 13:23:05 -0800 (PST)
Subject: Re: [PATCH v3 4/5] cpufreq: qcom-cpufreq-hw: Use new thermal pressure
 update function
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        Steev Klimaszewski <steev@kali.org>
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <20211103161020.26714-5-lukasz.luba@arm.com>
 <c4a2618f-71ee-b688-6268-08256a8edf10@linaro.org>
 <02468805-f626-1f61-7f7f-73ed7dfad034@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <af73cc0a-4dd2-832f-13b0-08807df64ce2@linaro.org>
Date:   Mon, 8 Nov 2021 16:23:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <02468805-f626-1f61-7f7f-73ed7dfad034@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/8/21 9:12 AM, Lukasz Luba wrote:
...snip

>>
>>
> 
> Well, I think the issue is broader. Look at the code which
> calculate this 'capacity'. It's just a multiplication & division:
> 
> max_capacity = arch_scale_cpu_capacity(cpu); // =1024 in our case
> capacity = mult_frac(max_capacity, throttled_freq,
>          policy->cpuinfo.max_freq);
> 
> In the reported by Steev output from sysfs cpufreq we know
> that the value of 'policy->cpuinfo.max_freq' is:
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:2956800
> 
> so when we put the values to the equation we get:
> capacity = 1024 * 2956800 / 2956800; // =1024
> The 'capacity' will be always <= 1024 and this check won't
> be triggered:
> 
> /* Don't pass boost capacity to scheduler */
> if (capacity > max_capacity)
>      capacity = max_capacity;
> 
> 
> IIUC you original code, you don't want to have this boost
> frequency to be treated as 1024 capacity. The reason is because
> the whole capacity machinery in arch_topology.c is calculated based
> on max freq value = 2841600,
> so the max capacity 1024 would be pinned to that frequency
> (according to Steeve's log:
> [   22.552273] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
> CPUs [4-7] )

Hi Lukasz,

Yes you are right in that I was using policy->cpuinfo.max_freq where as 
I should have used freq_factor. So now that you are using freq_factor, 
it makes sense to cap the capacity at the max capacity calulated by the 
scheduler.

I agree that the problem is complex because at some point we should look 
at rebuilding the topology based on changes to policy->cpuinfo.max_freq.

> 
> 
> Having all this in mind, the multiplication and division in your
> original code should be done:
> 
> capacity = 1024 * 2956800 / 2841600; // = 1065
> 
> then clamped to 1024 value.
> 
> My change just unveiled this division issue.
> 
> With that in mind, I tend to agree that I should have not
> rely on passed boost freq value and try to apply your suggestion check.
> Let me experiment with that...
> 
> Regards,
> Lukasz

-- 
Warm Regards
Thara (She/Her/Hers)

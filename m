Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791B8449E43
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 22:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbhKHVec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 16:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbhKHVeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 16:34:31 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4CC061570
        for <linux-pm@vger.kernel.org>; Mon,  8 Nov 2021 13:31:46 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id bj27so15228799qkb.11
        for <linux-pm@vger.kernel.org>; Mon, 08 Nov 2021 13:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s5tMJEcudqXsuhh1EA1Zp+nQ88xePj20Hc2KkNUWDsU=;
        b=Ae8kkXgDrDFP/odEz71AJTjhaFNsH4u+OGlS3nZDJX5cldhY6nkQcUO3QoqEnqCzFa
         BQht6SE35qyia0jMOtiC2IebnWiVKLTwQ5UQI9+/YyOERDE5mEaV/BGgEJt4haOdcGt4
         QTxe+hsOLit51eifZGmv/JTxbGLaMOVFw3YcaZ4j36SZirauQ/NMEidMBHYWXxJMq87H
         GIsHQ3fylNSRLGhvcHnIg7MU3g8AP6TFXK7ijyiBcFvAMeibXy9j1UNKFUWe5WBj+Duc
         oifkKHgZeOaumPR1+i6Z///GQfUn/sybjkp04JEGf93BdNljICpBsVV1SGIrCv92sZOC
         J/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s5tMJEcudqXsuhh1EA1Zp+nQ88xePj20Hc2KkNUWDsU=;
        b=sTwFsyZ5N7uOBY6mCeUwheSn3r5jGrgtSII2QcWvBoQUjC1GLXUGlT7iIuscWz+5ab
         HDxKdPCoRVhW5x93XFZQLH7/wVp6piRDurzZLFG0mNcxzIRaVLH/fiThfluoL3IkxMo9
         3NgY5CDZcrlkxjM9my1CNC1ntxlwntIEIP4XmZUlEk7hZy25iitUae9EqevxK6jVZaDr
         Dk8KHBQrG3sLT7ikoNP9LPueiv+RGY84LfvLRyKpT0c6okEtWNJ2hj/1/IiJHX2fKiI/
         BTn4iWMeqFEJepSWLarUQJctk78q39an9XofAtS5Dzrzuib2FNlMQ7Q5UXLtMnoL0DLR
         Idqw==
X-Gm-Message-State: AOAM53125GUi7uJztRfwgbfSW5UMW0FIupNVx5TBDpc8PtOeLM+qOoJ3
        i4ihDBo+b5saKxjTuM/+0gFwJg==
X-Google-Smtp-Source: ABdhPJxLupCh0ogEwzGIg4W2cCTY25wrbd/qb1d2CFGSDvrqEWvp4py1sjwaDa/6e8fqENI6AyZOsA==
X-Received: by 2002:a05:620a:2a14:: with SMTP id o20mr1830012qkp.221.1636407105343;
        Mon, 08 Nov 2021 13:31:45 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id w19sm2033209qkw.49.2021.11.08.13.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 13:31:44 -0800 (PST)
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
To:     Steev Klimaszewski <steev@kali.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
 <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
 <9d533b6e-a81c-e823-fa6f-61fdea92fa65@kali.org>
 <74ea027b-b213-42b8-0f7d-275f3b84712e@linaro.org>
 <74603569-2ff1-999e-9618-79261fdb0ee4@kali.org>
 <b7e76c2a-ceac-500a-ff75-535a3f0d51d6@linaro.org>
 <f955a2aa-f788-00db-1ed8-dc9c7a1b2572@kali.org>
 <59054c90-c1cd-85bf-406e-579df668d7b4@linaro.org>
 <eac00041-a1b8-0780-931d-52249d538800@kali.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2c54dbbd-2ecb-fb76-fa9f-9752f429c20e@linaro.org>
Date:   Mon, 8 Nov 2021 16:31:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eac00041-a1b8-0780-931d-52249d538800@kali.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/8/21 10:22 AM, Steev Klimaszewski wrote:
> 
>> Hi Steev,
>>
>> So this depends on the cpufreq governor you are using. By-default arm 
>> systems have sched-util governor enabled. This means you will scale up 
>> to boost depending on cpu load and not always. If you want to ensure 
>> you are always hitting boost frequency, you should enable performance 
>> governor for cpufreq and try.
>>
>> Also since the defconfig has by default CPU_FREQ_STAT enabled, you 
>> should be able to get statistics out of cpufreq to see the time spent 
>> by a cpu in each frequency. I think cpufreq-info -s should give you 
>> this info. If not, you can explicitly get it for each cpu from
>>
>> cat /sys/devices/system/cpu/cpu<X>/cpufreq/stats/time_in_state
>>
>> Regarding temperature, if you have applied all the patches in the 
>> sdm845 LMh series and have LMh enabled, cpu throttling starts around 
>> 95 degree C.
>>
> Hi Thara,
> 
> Indeed, I ended up finding the time_in_state when I was doing more 
> digging after my last mail.  I do have the sdm845 LMh series and LMh 
> enabled, however I don't think I've ever seen my system go above 90C here.
> 
> So a quick look, and... we are simply almost never getting the 2.95GHz 
> at all, regardless of workload.  I saw Lukasz response as well about the 
> math possibly being wrong, but I haven't had a chance.
> 
> Regarding the time in state - I went with policy4 instead of per cpu 
> (for brevity sake) and it's here:
> 
> c630:~$ cat /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
> 825600 225037
> 902400 92
> 979200 205
> 1056000 96
> 1209600 902
> 1286400 386
> 1363200 396
> 1459200 217
> 1536000 101
> 1612800 75
> 1689600 95
> 1766400 130
> 1843200 255
> 1920000 318
> 1996800 92
> 2092800 87
> 2169600 66
> 2246400 60
> 2323200 58
> 2400000 54
> 2476800 47
> 2553600 50
> 2649600 69
> 2745600 58
> 2841600 54619
> 2956800 5
> 
> So we spend *very* little time in 2.96GHz and this is after almost 14 
> hours of uptime on the C630.  By comparison, on a Pinebook Pro where 
> I've added in 2GHz as a boost frequency :

Hi Steev,

IIUC, PineBook Pro has Rockchip RK3399 which has 2 Cortex A-72 and 4 
Cortex A-52 where as C630 has Qualcomm sdm845 which has 4 Cortex A-75 
and 4 Cortex A-55. Task placements and subsequently cpu load will be 
different for both the platforms. With the same workload, I will expect 
Rockchip to system to be more loaded than sdm845. Having said that, what 
cpu-freq governor are you using on both the systems.


> 
> pinebook-pro:~$ cat 
> /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
> 408000 16084466
> 600000 27212
> 816000 32487
> 1008000 11331
> 1200000 13268
> 1416000 75078
> 1608000 18392
> 1800000 207266
> 2016000 648612
> 
> With the Pinebook Pro, which doesn't even come close to getting to 95C, 
> we spend a lot more time in 2GHz.
> 
> -- steev
> 

-- 
Warm Regards
Thara (She/Her/Hers)

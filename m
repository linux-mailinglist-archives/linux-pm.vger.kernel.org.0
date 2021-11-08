Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0F448104
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 15:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhKHOOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 09:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbhKHOOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 09:14:24 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE69C061714
        for <linux-pm@vger.kernel.org>; Mon,  8 Nov 2021 06:11:39 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id bj27so13870215qkb.11
        for <linux-pm@vger.kernel.org>; Mon, 08 Nov 2021 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7pApxpdYsXub2Klb9AGksL2WOu4t7V/pprHcy+kutRA=;
        b=gxurOgF0ZED/icjZMZbuA+q+02/HP2WNpNCS6vBO+97Y93C2rS0IDh9CHrdHxYlavI
         z7IUjHhqEY+DQ+o3corur9IdfZjHEc5OK7KYR3cMWkZPqGhHR0Bmzs1AXgNPnfBjRVAx
         MnWN1sbQ9vltyIhKJ6VGIkjXaOL0XoDan7TxaGypnmRP4z3ynz2I78CG3jEebiJw0qKd
         MJPGKcXyThiVdU4sw92I5NDYCMKpFPxSR5FRDYq9fKG02EeKAV5Qb+HZNVQP+3CbSxpL
         fUcj2/4jii0pUwKzUKjxgijWVQd6FD7LsBKd4sV4gcDDQyT8gZs2PRPsLkpSmb1S1Rx0
         mdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7pApxpdYsXub2Klb9AGksL2WOu4t7V/pprHcy+kutRA=;
        b=DmJA4lWjVyDMyvqqU6IjpGNEHFjPfnNL5E7ZV9pf5Qb5rmNIEnSai+P5VD/sM4Jv9s
         yW7RwcerxpErfamroFy7r+HEhVssnY8adpjz1b+hzqwBOMBC4ueftyThP2Cy0K7y8r6J
         2I4KawG5RG+nw7QSvr2pPp+Xn/Mx5hSFwrSNrTYML6NdttF2+ClGBbGCwJT40OM3rEe6
         PScD/HF/SQNjklPQZCa/hXElHcYat8/WX6cFIu12dNstVIdKQqmui3x2z1Xs0uUlC7f7
         UBdfHMdhSpO6Hic7g239wjM+6NRUQWZmY9i2ywBtgbyVtASNQQGZAhhv2E+2ZHxJsYxI
         2obw==
X-Gm-Message-State: AOAM530g+MwfJu7QCGU2s9SB1bh9l+R5WDjksLHneQipsjlTMvOqG3LQ
        TfkPIMOUvcA1Y4je+GIuk08E0g==
X-Google-Smtp-Source: ABdhPJww1CfOR1qBIq+Iby3R1s0yC0dwZpJoshYTS3+Ya+kObszITj3xlfXOuVgHLE/v423f2KK9xg==
X-Received: by 2002:a05:620a:319d:: with SMTP id bi29mr5038172qkb.92.1636380698435;
        Mon, 08 Nov 2021 06:11:38 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id w11sm6302444qtk.62.2021.11.08.06.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 06:11:38 -0800 (PST)
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
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <59054c90-c1cd-85bf-406e-579df668d7b4@linaro.org>
Date:   Mon, 8 Nov 2021 09:11:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f955a2aa-f788-00db-1ed8-dc9c7a1b2572@kali.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/5/21 6:46 PM, Steev Klimaszewski wrote:
> 
>> [snip]
>> Hi,
>>
>> So IIUC the below logs correctly, you are never hitting boost 
>> frequency (with or without this patch series). Is that correct ?
>>
>> w.r.t temperature , how are you measuring it? Do you have LMh enabled 
>> or are you using tsens to mitigate cpu temperature ?
> 
> 
> Hi,
> 
> I was wrong - it does indeed go boost with the patchset applied, it's 
> just that it doesn't boost up to 2.96GHz very often at all. As noted by 
> the 0.03% when i ran it while compiling zellij; I reapplied the patches 
> (and the 6th patch from Lukasz's email) and after boot, 2.96GHz was 
> showing at 0.39%.
> 
> Most tools that read the cpu frequency don't really seem to be well 
> suited for big.LITTLE, and seem to throw an average of the speed, so 
> cpufreq-info was the best I have.  We're apparently supposed to be using 
> cpupower these days, but it doesn't seem to know anything about arm64 
> devices.
> 
> Temperature wise, I'm just getting from the sensors, and I am using LMh.
> 
> Now, I have to admit, while I've thrown a patch here or there, I'm not 
> exactly a kernel developer, just enough knowledge to be somewhat 
> dangerous and know how to backport things.  In my mind, and my line of 
> thinking, I would expect with boost enabled, that the cpu would boost up 
> to that as often as possible, not require a specific workload to 
> actually hit it.  But then again, I would expect multiple compilation 
> jobs to be one of the workloads that would?

Hi Steev,

So this depends on the cpufreq governor you are using. By-default arm 
systems have sched-util governor enabled. This means you will scale up 
to boost depending on cpu load and not always. If you want to ensure you 
are always hitting boost frequency, you should enable performance 
governor for cpufreq and try.

Also since the defconfig has by default CPU_FREQ_STAT enabled, you 
should be able to get statistics out of cpufreq to see the time spent by 
a cpu in each frequency. I think cpufreq-info -s should give you this 
info. If not, you can explicitly get it for each cpu from

cat /sys/devices/system/cpu/cpu<X>/cpufreq/stats/time_in_state

Regarding temperature, if you have applied all the patches in the sdm845 
LMh series and have LMh enabled, cpu throttling starts around 95 degree C.

> 
> So I think, the part about never hitting 2.96GHz can be dismissed, and 
> was simply my lack of knowledge about the cpufreq-info tool's averages. 
> It does seem however to rarely ever hit 2.96GHz and I would actually 
> expect it to hit it far more often.
> 

-- 
Warm Regards
Thara (She/Her/Hers)

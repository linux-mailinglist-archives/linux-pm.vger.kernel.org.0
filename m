Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4A1EBED
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEOKQi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 06:16:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42101 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfEOKQi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 06:16:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so1997536wrb.9
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S/9jRohC0YkB1EkAIcCPuCB+iLIg4aRciSB21aigTqM=;
        b=T6kcFRLd4JJNo1RNjJ/P2EH1opLK6UrZasP02reNxcgFl+5LtIvmscmKSJaCQ+FwG9
         kmZ1XbYsEX/rYN64gYks2lLJuOYctJ4S95cKi8Rqpqy4/8RrjUQrlTBtwxxKFK5Bmrzt
         A9MwKbYaP6TvjLiUSfobpiQlesVjxZUiXkHVbZyHwCaQyC+9ZBB4FG3YDCWfes5PVN4K
         GFuRak6iKYztyqgi224FbbL6pEdDXYxG7zlJcBAUuKczQ8XoODPnrsbsYEqdtfTpJFao
         Ycq6nKCtDVRnpFiwZkVsxD90YC5DJiGDj2lT8IAduoXF1qrtCLf0paUL5KOAgnEuwBsX
         ckpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S/9jRohC0YkB1EkAIcCPuCB+iLIg4aRciSB21aigTqM=;
        b=IbAnX2KGOJhi2sPVcoerNiWvRIch7Qr1NJPH/3MJXYyV+3gHZBIk1LYp+dvoNoTBTC
         AQ4U7d1px9zrieix7JDDWyH7APHXkngcLb5TF5aYaqrZirOMr8uK/FwkoGtsSj0wJymV
         IamrxOE4b4ULsS1ILjbVArk9zobWBlesK0a+QmaW96SY/zXr+hmhgcYC5LEISnHa7eSn
         h2Yu6kophCTbQtxL+PqlctdFTeEmn/BXyECj5PRod+oXklnn97VaM+ex5HzE6r6nd3T6
         OkkM7JKOXCwCHSvBF7oliwfKabb8z7wfb9ALB/2yAxryYinu57Vhs7/fI83/laOHprzh
         ISIg==
X-Gm-Message-State: APjAAAVbevBH/G7Vfsjaw66gwTizeiQpHw2bXg4rLOQPd/FXs99WMhFv
        y1HY9jkmWSHTYAH7aUnThkqsDQ==
X-Google-Smtp-Source: APXvYqzgasfAM4L2+hLYnGfh5HtrNS+duN6uO0OQG+6hKeYA0zvsxpwlYhwIxxREJrdqVU2YS1A82w==
X-Received: by 2002:adf:b456:: with SMTP id v22mr23101764wrd.55.1557915396524;
        Wed, 15 May 2019 03:16:36 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id w185sm2406511wma.39.2019.05.15.03.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:16:35 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
Date:   Wed, 15 May 2019 12:16:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2019 12:07, Quentin Perret wrote:
> On Wednesday 15 May 2019 at 11:56:30 (+0200), Daniel Lezcano wrote:
>> On 15/05/2019 11:17, Quentin Perret wrote:
>>> Hi Daniel,
>>>
>>> On Wednesday 15 May 2019 at 11:06:18 (+0200), Daniel Lezcano wrote:
>>>> On 15/05/2019 10:23, Quentin Perret wrote:
>>>>> In the current state, the perf_domain struct is fully defined only when
>>>>> CONFIG_ENERGY_MODEL=y. Since we need to write code that compiles both
>>>>> with or without that option in the thermal framework, make sure to
>>>>> actually define the struct regardless of the config option. That allows
>>>>> to avoid using stubbed accessor functions all the time in code paths
>>>>> that use the EM.
>>>>>
>>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
>>>>
>>>> This patch implies the cpu cooling device can be set without the energy
>>>> model.
>>>>
>>>> Isn't it possible to make a strong dependency for the cpu cooling device
>>>> on the energy model option, add the energy model as default on arm arch
>>>> and drop this patch?
>>>
>>> Right, that should work too.
>>>
>>>> After all, the cpu cooling is using the em framework.
>>>
>>> The reason I did it that way is simply to keep things flexible. If you
>>> don't compile in THERMAL_GOV_POWER_ALLOCATOR, you will never use the EM
>>> for CPU thermal. So I thought it would be good to not mandate compiling
>>> in ENERGY_MODEL in this case -- that should save a bit of space.
>>>
>>> But TBH I don't have a strong opinion on this one, so if everybody
>>> agrees it's fine to just make CPU_THERMAL depend on ENERGY_MODEL, I'm
>>> happy to drop this patch and fix patch 3/3. That would indeed simplify
>>> things a bit.
>>
>> Ok in this case it will be better to drop the 2/3 and add a small series
>> doing for the cpu_cooling.c
>>
>> #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>>
>> /* structure freq */
>>
>> /* power2state */
>>
>> /* state2power*/
>>
>> /* getrequestedpower */
>>
>> /* All functions needed for the above */
>>
>> #endif
>>
>> static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
>>         .get_max_state          = cpufreq_get_max_state,
>>         .get_cur_state          = cpufreq_get_cur_state,
>>         .set_cur_state          = cpufreq_set_cur_state,
>> #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>>         .get_requested_power    = cpufreq_get_requested_power,
>>         .state2power            = cpufreq_state2power,
>>         .power2state            = cpufreq_power2state,
>> #endif
>> };
>>
>> So you don't have to care about ENERGY_MODEL to be set as
>> THERMAL_GOV_POWER_ALLOCATOR depends on it.
>>
>> I think the result for cpu_cooling.c will be even more cleaner with the
>> em change.
> 
> OK, that works for me. I'll give it a go in v5.

Viresh what do you think ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


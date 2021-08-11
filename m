Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB8F3E9B00
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 00:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhHKWmK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 18:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhHKWmK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 18:42:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CBCC0613D3;
        Wed, 11 Aug 2021 15:41:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z20so9255202lfd.2;
        Wed, 11 Aug 2021 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TTWSxJwqE8XcUGGJwn5DjreBR5Wsid1NT/+Qq2y1jME=;
        b=uq3WLddc+eYweWcAgLLyxDulmf2ABiaAwnbp/AD0NexQEO4mWvUUgFJcD0lopnV09o
         ++PKkdflSR/icIXPatbNuVePIwewbXf5H8dUmPDllNXSLK98hrJByjYI936UvrKUknj5
         VXSBFnEmbyImaF8+ROIjuuJ9a44nFQajHQ5b8vtza3dzst6y6uKXvi/2AAxTUfEBokkW
         oJ1QzoFk/YoSfTNs9+SmAY2BKrm4GaVJKBnNCZrA46CZPkX3RVL5LKxiUgUZSzxkGxpB
         KRhYNOJQouKV4rIQgoB9OxCKF0yK3mpIgNZCKEkBh7BsKedvZN//E1bmQbac4IqX9wCd
         7Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TTWSxJwqE8XcUGGJwn5DjreBR5Wsid1NT/+Qq2y1jME=;
        b=BC7x/JG1gzK+dqPsYZYDBsCkacsKfrRxd+SiXw5cpRd6UOhDawze6LW+NFZU8RKb3w
         LulMMbmOVFSdeLx/7VemrQhchVV0m+gjHRjV5FNyH0wRicLB7o0zuLbuL8E8A+/qfj4A
         iN7Q8LnG5MfZYvwTXB/SCjiYJg9q1pHCDUZcEnB5MxjsxnaFbsa0OeYH1oDOJIdqYaBR
         m3aVKqzJdX9v2k4XqbyKay6UHlrFxq9GbWltE76xyLuJYULw5Spoj6agY/3tUcVHxP9N
         bp8ZhkFP745tv1cRgJBpg/BbFuqi4LYAHGFMSLZymLjL7kMD7nVPi7CfzBKs6sCeBTaw
         gnmQ==
X-Gm-Message-State: AOAM530wtE3ybeFCd9zF2bpNEbY1Er+0CYtjXASk29Wp7QpDV8qqP2UD
        4AlpCjFm+GwhOcKJfWzltJBRoFP0Jjw=
X-Google-Smtp-Source: ABdhPJys4zY/v5mSZyX+RTbpGiGCb0kjO53qxuijpObgTRsQoRqe1DMv9EzSACCR/ku0L1jI0tcvvw==
X-Received: by 2002:a05:6512:4019:: with SMTP id br25mr316290lfb.494.1628721703984;
        Wed, 11 Aug 2021 15:41:43 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id m14sm70458lfb.170.2021.08.11.15.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 15:41:43 -0700 (PDT)
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210701232728.23591-1-digetx@gmail.com>
 <20210701232728.23591-3-digetx@gmail.com>
 <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com>
 <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com>
 <CAPDyKFoafAk72Kw6X7626Niduaii0V5VM4dGSWmq+e3JTh7VRg@mail.gmail.com>
 <a5dfdf59-f5b5-d28e-6b02-b0c860ba8d80@gmail.com>
 <CAPDyKFq+ExjbGrN=yUUXPKfN_fGrwY6EAYn9a6VUFFU_VjhC=g@mail.gmail.com>
 <6741262b-386b-7635-fd42-ebd4f877fddd@gmail.com>
 <CAPDyKFpJhX51rOnvbYTmj9Akd+xX+b7xcSWt87UDrvMEfYOZ7Q@mail.gmail.com>
 <aab38f90-f7b2-900f-897b-470b81d473f2@gmail.com>
Message-ID: <8e110e08-1268-464c-6edb-0a3f640d43d6@gmail.com>
Date:   Thu, 12 Aug 2021 01:41:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aab38f90-f7b2-900f-897b-470b81d473f2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.08.2021 22:30, Dmitry Osipenko пишет:
> 10.08.2021 13:51, Ulf Hansson пишет:
> ...
>>> +               if (power_on) {
>>> +                       ret = dev_pm_genpd_set_performance_state(dev, default_pstate);
>>
>> However, this is more questionable to me.
>>
>> First, I don't think we should care about whether this is "power_on"
>> or not. At this point, performance states are treated orthogonal to
>> idle states in genpd. We may decide to change that in some way, but
>> that deserves a different change.
> 
> Okay
> 
>> Second, I don't think we should call
>> dev_pm_genpd_set_performance_state() from here. It's probably better
>> handled from the genpd callback itself, if/when needed.
> Indeed
> 
>> That said, perhaps the new callback should just return a regular error
>> code and zero on success, rather than the current performance state.
>> See more below.
>>
>>> +                       if (ret) {
>>> +                               dev_err(dev, "failed to set default performance state %u for PM domain %s: %d\n",
>>> +                                       default_pstate, pd->name, ret);
>>> +                               goto out;
>>> +                       }
>>> +               } else {
>>> +                       dev_gpd_data(dev)->rpm_pstate = default_pstate;
>>
>> No, this isn't the right thing to do.
>>
>> It looks like you are trying to use the ->rpm_pstate for
>> synchronization with runtime PM for consumer drivers. This is fragile
>> as it depends on the runtime PM deployment in the consumer driver. I
>> think you should look at ->rpm_pstate as a variable solely for
>> managing save/restore of the performance state for the device, during
>> runtime suspend/resume in genpd.
>>
>> Synchronization of a vote for a performance state for a device, needs
>> to be managed by calling dev_pm_genpd_set_performance_state() - or by
>> calling an OPP function that calls it, like dev_pm_opp_set_rate(), for
>> example.
> 
> The !power_on case should be skipped at all because common core code
> can't handle it properly, hence rpm_pstate shouldn't be touched. I
> realized it only after sending out this email.
> 
> ...
>>>> Rather than doing the OF parsing above to find out the current state
>>>> for the device, why can't you just call dev_pm_opp_set_rate() to
>>>> initialize a proper vote instead?
>>>>
>>>
>>> For some devices clock rate is either preset by bootloader, or by clk driver, or by assigned-clocks in a device-tree. And then I don't see what's the difference in comparison to initialization for the current rate.
>>>
>>> For some devices, like memory controller, we can't just change the clock rate because it's a complex procedure and some boards will use fixed rate, but the power vote still must be initialized.
>>
>> I am not saying you should change the clock rate. The current code
>> path that runs via devm_tegra_core_dev_init_opp_table() just calls
>> clk_get_rate and then dev_pm_opp_set_rate() with the current rate to
>> vote for the corresponding OPP level. Right?
>>
>> Isn't this exactly what you want? No?
> 
> I see now what you meant, it's actually a simpler variant and it works
> too. Thank you for the suggestion, I'll prepare v8.
> 

My bad, it doesn't work at all. I actually need to use the rpm_pstate or
something else because performance state is coupled with the enable
state of the device. If device is never rpm-suspended by consumer
driver, then the initialized performance state is never dropped. Hence I
want to initialize the state which is set only when device is resumed.

I'll need to think more about it.

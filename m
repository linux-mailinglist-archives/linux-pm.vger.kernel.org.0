Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7F23A9810
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhFPKtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhFPKts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 06:49:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E34C061574;
        Wed, 16 Jun 2021 03:47:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j2so3556874lfg.9;
        Wed, 16 Jun 2021 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M8RbiCOq83IbnSA8G848uSB8CbMVC8ioIh0DaNZa9vc=;
        b=m0+aLL36GaHNEjSSDDcmlxsML6+AeRiAhb+BmyBDrsanZORVU7IFdQvyNNWt34OjYQ
         fRxAL1xbVx4pgLFlZqB8eGKklb3XqNxPR5YzyM7HG245bP2FtgV0yewdFAdf1aIte+j4
         dmTxJp1AyWCUvbdmw5+r/kybXHdgxI0P57XNIzpxzWaP3BGEfcdmOQ8MC5niEfrRb+Vn
         Etq4qmod4kKq1J3lwgiqGmtH6MpccArW0XGbg3rMNKK5Q1u6hFqKU4fRwClS3/Ealn6I
         2VRkkpRpuqiDIFFJrNWBt+rJcoDL8/g3gRVi9rNLlRGzuluvRFfPZeoxZuL08TKE/u/1
         XceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M8RbiCOq83IbnSA8G848uSB8CbMVC8ioIh0DaNZa9vc=;
        b=fKhtepC2msJ36HIIfEfxaCSBgMpUJcOIZP0ZncCGOhWXttctYBbiPkYH/cprUgPoYL
         EeimqvqNBxA+WV7AjACem/PSARjkMIZDRC5xmJsfbttiG1tF5nB0B10QLYnoJNPQPPvb
         6AUyUptdMWDCnRffzHy7kPUIdRB86Qffr3FuSsW296OG3qsO3FJjzCjFCNDmYQRt0kBp
         +9/yDWgJkq4hiASX8sN8iKQHANh+anoPH3YNhWxTThsaaGqfeu/fAoPtkYY3D/SCMBXp
         tQ0Vrq/351k7Ue0DvdY9jkRSfIWt6cQWGNj9gdkDPT5a+V/OP8FJIbT2h/Zw5BSnwUFW
         B82Q==
X-Gm-Message-State: AOAM533XXBgSSiSUYSvJif9qyDJ45KpcArFqGvsnFFTthlhwInNdYqwy
        1UEu8yQjB4Nwp6f7zsJwlHGEWyQj5LY=
X-Google-Smtp-Source: ABdhPJz+0Zz9WG1zeE/j95jNz5K1F/ytl7qbFbKxW4oVKx0aC5XmOSp9HDSQN0heEC/zEiU0hkhcrg==
X-Received: by 2002:ac2:4a6b:: with SMTP id q11mr3292061lfp.321.1623840460086;
        Wed, 16 Jun 2021 03:47:40 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id h4sm209060lft.184.2021.06.16.03.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 03:47:39 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210529170955.32574-1-digetx@gmail.com>
 <20210529170955.32574-5-digetx@gmail.com>
 <6f2b6290-095a-bd39-c160-1616a0ff89b1@linaro.org>
 <20210615102626.dja3agclwzxv2sj4@vireshk-i7>
 <595f5e53-b872-bcc6-e886-ed225e26e9fe@gmail.com>
 <fbdc3b56-4465-6d3e-74db-1d5082813b9c@linaro.org>
 <4c7b23c4-cf6a-0942-5250-63515be4a219@gmail.com>
 <545974aa-bb0f-169b-6f31-6e8c2461343f@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f06370e0-bfde-87d0-03b4-93c667f81817@gmail.com>
Date:   Wed, 16 Jun 2021 13:47:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <545974aa-bb0f-169b-6f31-6e8c2461343f@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.06.2021 05:50, Thara Gopinath пишет:
...
> 
> Hi,
> 
> Thermal pressure is letting scheduler know that the max capacity
> available for a cpu to schedule tasks is reduced due to a thermal event.
> So you cannot have a h/w thermal pressure and s/w thermal pressure.
> There is eventually only one capping applied at h/w level and the
> frequency corresponding to this capping should be used for thermal
> pressure.
> 
> Ideally you should not be having both s/w and h/w trying to throttle at
> the same time. Why is this a scenario and what prevents you from
> disabling s/w throttling when h/w throttling is enabled. Now if there
> has to a aggregation for whatever reason this should be done at the
> thermal driver level and passed to scheduler.

Hello,

The h/w mitigation is much more reactive than software, in the same time
it's much less flexible than software. It should provide additional
protection in a cases where software isn't doing a good job. Ideally h/w
mitigation should stay inactive all the time, nevertheless it should be
modeled properly by the driver.

>>>
>>> That is a good question. IMO, first step would be to call
>>> cpufreq_update_limits().
>>
>> Right
>>
>>> [ Cc Thara who implemented the thermal pressure ]
>>>
>>> May be Thara has an idea about how to aggregate both? There is another
>>> series floating around with hardware limiter [1] and the same
>>> problematic.
>>>
>>>   [1] https://lkml.org/lkml/2021/6/8/1791
>>
>> Thanks, it indeed looks similar.
>>
>> I guess the common thermal pressure update code could be moved out into
>> a new special cpufreq thermal QoS handler (policy->thermal_constraints),
>> where handler will select the frequency constraint and set up the
>> pressure accordingly. So there won't be any races in the code.
>>
> It was a conscious decision to keep thermal pressure update out of qos
> max freq update because there are platforms that don't use the qos
> framework. For eg acpi uses cpufreq_update_policy.
> But you are right. We have two platforms now applying h/w throttling and
> cpufreq_cooling applying s/w throttling. So it does make sense to have
> one api doing all the computation to update thermal pressure. I am not
> sure how exactly/where exactly this will reside.

The generic cpufreq_cooling already uses QoS for limiting the CPU
frequency. It could be okay to use QoS for the OF drivers, this needs a
closer look.

We have the case where CPU frequency is changed by the thermal event and
the thermal pressure equation is the same for both s/w cpufreq_cooling
and h/w thermal driver. The pressure is calculated based on the QoS
cpufreq constraint that is already aggregated.

Hence what we may need to do on the thermal event is:

1. Update the QoS request
2. Update the thermal pressure
3. Ensure that updates are not racing

> So for starters, I think you should replicate the update of thermal
> pressure in your h/w driver when you know that h/w is
> throttling/throttled the frequency. You can refer to cpufreq_cooling.c
> to see how it is done.
> 
> Moving to a common api can be done as a separate patch series.
> 

Thank you for the clarification and suggestion.

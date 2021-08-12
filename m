Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C883EA87E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 18:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhHLQY7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 12:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLQY6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 12:24:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C6DC061756;
        Thu, 12 Aug 2021 09:24:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c24so14433345lfi.11;
        Thu, 12 Aug 2021 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JfjRt23sWV2lqaXvpl990G0yCZxuQFU1QAX/YZyxnf0=;
        b=CLGQBJ7UF455CW+Q2Heb9qGA4ngD1epBzx33MmovxhQspf/Nr3LGBgPa09ZmzZtUKN
         3tdTlC442x6ciRdxrSb0sEScPF1RDJlgJS8Yy/+bNttWoH1+Ke447jc0s3seV1gm4ZT+
         IvY8BaLBQrpB/8LD2kp9G2pGd3EGf9hXm27UebF7UKADlvICNymv3mjWP9qT0jqtzs86
         bkvQ4XoWNvq1rwDSVkudNhWvvLVhiMidOtgVx0xpp53E9q99c7WOMy5rIJDlpmsOLXQ4
         r3nF0g8qu1XLNci6/r/SCQA/FJCk2O4KwF8CeUop5jKwqmyIMBK9wM7tbtkTf9U/GY8Y
         L9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JfjRt23sWV2lqaXvpl990G0yCZxuQFU1QAX/YZyxnf0=;
        b=tLqxGgs94cbD+5JlOtfFVlLEq4nLebsvNleGRkb4dzfspXpPedRNCS2ZXDvJu4FgGU
         BWgfaoMPouVXda5WsZCf3CL3wxcWEtDLHDIqyLHz0FhzPMaF/mYkOBNPUpjZb32FWz7+
         89qRdqPGyqXse7X0orNJcJ32nzdEW7e0ILNCiGPEzDVr3snC4VEsQZAhsibYP9tDFJ40
         cLIfoJlodcIg4xvBY/eabaE4MHrziWOCVFOWGy0DMlJP0wHgqvTcpMNUltU0GyDEwV50
         CY4FgoB7xRkfKQhnAt+bBWJADQDyfvwqJkUn3LD9wHn5Ia3HMfb938rn5o36D9iZIKmJ
         goJA==
X-Gm-Message-State: AOAM5323425vsk24StdeLIQ0LMPxqc0w3torRTzOgFgBFVP5HZLmZ98K
        LK6SzZgTEdlI6CQwrZ5TE2gINr5v5o8=
X-Google-Smtp-Source: ABdhPJzQaIt36WqBlaQ8sP9BP1GtVdRtFl+PsuIi3z5BlibHuKasVw/o8VDojoMjBkkUqMP3Fn7tEw==
X-Received: by 2002:a19:e002:: with SMTP id x2mr3092401lfg.84.1628785471402;
        Thu, 12 Aug 2021 09:24:31 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id e7sm384080ljq.9.2021.08.12.09.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:24:30 -0700 (PDT)
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
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
 <8e110e08-1268-464c-6edb-0a3f640d43d6@gmail.com>
 <e21106ab-95ef-fc97-1744-dc58180e321a@gmail.com>
 <CAPDyKFpgoBsFOiCGEpgAyeYJyEZQAXSN_2iEJcVJbfV+7rvdMw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c412f7e2-9f02-5cf6-e094-b5fa9a44169a@gmail.com>
Date:   Thu, 12 Aug 2021 19:24:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpgoBsFOiCGEpgAyeYJyEZQAXSN_2iEJcVJbfV+7rvdMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.08.2021 14:17, Ulf Hansson пишет:
> On Thu, 12 Aug 2021 at 03:40, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 12.08.2021 01:41, Dmitry Osipenko пишет:
>>>>> I am not saying you should change the clock rate. The current code
>>>>> path that runs via devm_tegra_core_dev_init_opp_table() just calls
>>>>> clk_get_rate and then dev_pm_opp_set_rate() with the current rate to
>>>>> vote for the corresponding OPP level. Right?
>>>>>
>>>>> Isn't this exactly what you want? No?
>>>> I see now what you meant, it's actually a simpler variant and it works
>>>> too. Thank you for the suggestion, I'll prepare v8.
>>>>
>>> My bad, it doesn't work at all. I actually need to use the rpm_pstate or
>>> something else because performance state is coupled with the enable
>>> state of the device. If device is never rpm-suspended by consumer
>>> driver, then the initialized performance state is never dropped. Hence I
>>> want to initialize the state which is set only when device is resumed.
>>>
>>> I'll need to think more about it.
>>
>> GENPD core has these false assumptions:
>>
>> 1. It assumes that by default all devices are at zero performance level
>> at a boot time. This is not true for Tegra because hardware is
>> pre-initialized independently from GENPD.
> 
> Right, which is similar to other SoCs.
> 
>>
>> 2. It assumes that nothing depends on performance level and devices can
>> operate at any level at any time. Not true for Tegra and other platforms
>> where performance level is coupled with clocks state of attached
>> devices. OPP framework glues clock and performance level together for
>> us, which works good so far.
> 
> Right, OPPs need to be managed differently depending on the SoC.
> That's why genpd is there to help and to model this as "performance
> states" and to allow operations to be set through SoC specific
> callabacks, for example.
> 
> More importantly, the assumption is that in general, consumer drivers
> should use the OPP library to vote/set OPP levels, they shouldn't call
> dev_pm_genpd_set_performance_state() - unless they know exactly what
> they are doing.
> 
>>
>> Hence I either need to patch every driver to use dev_pm_opp_set_rate in
>> order to sync clk rate with the perf level at device runtime, or I need
>> to preset the rpm perf level to allow GENPD core to set the level before
>> device is resumed.
> 
> When the device is getting attached to its genpd (during the probe
> sequence and for a single PM domain case), runtime PM is disabled for
> the device. If you would call dev_pm_opp_set_rate() from a genpd
> callback during attach (without changing the rate), this means you
> would update/synchronize the vote. In this way, the vote is set before
> the device is runtime resumed by the driver, right?

I was doing that previously, but then realized that for some devices the
state needs to be synced only once device is rpm-resumed. Making RPM
driver to perform the syncing worked well.

> On the other hand, patching the driver should also be quite simple and
> you need to do that anyways, don't you?

It will be extra boilerplate code in the drivers, but perhaps it's the
best option for today, I'll consider it for v8. Thank you for helping
with the review.

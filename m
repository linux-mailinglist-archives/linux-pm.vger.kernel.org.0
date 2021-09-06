Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC23402068
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 21:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhIFTef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 15:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhIFTee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 15:34:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF26C061575;
        Mon,  6 Sep 2021 12:33:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j12so12815724ljg.10;
        Mon, 06 Sep 2021 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z/mU7ZTny5JnC2UE3lGGBUWEw5TvasZB+QO6SG1MCGs=;
        b=TiYbIgsx0V050p9o+tDPXbcrEgnJOkryGEOAYjBN2krSbJZXyHyozKyF9y6VCpNpdS
         orFZ9eySJPUHtiiQ1Af5R5W5QZ6iL+5GcDL+9yeCRFQ0JiO/Tphc9CEOrdnpuX6iV2z7
         HADJPJRdyQFgAqTC/02BY+dmgwA0QSyG2UmTHYTNzKeoaQNLretR4UvQYjW1r1hryBPh
         2JjulXyiN0u0sZZF+02w4beoU75btRntzFm4PhwbXs3KDBFhmMO5tFIiSJp/Wv5jlV3g
         v8CKNwIawIq4CZbrxki1wFLAdVPCrTtihOllPw7S6slYJBcDbD9WMywgubaTC68k1QYH
         ObAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z/mU7ZTny5JnC2UE3lGGBUWEw5TvasZB+QO6SG1MCGs=;
        b=IUeWayyfy5EBR+hfS5Mf5QNzFrkeKCxg8ucf/pW6fHsyKC4gZx3Iqd04ayD0xTXh49
         E5me64BExIMkSYENc42qiyB3QIlK7O4EV99vMxOMk8gdYfJ4Qn2oLZFSA0ISF2m4CxG6
         8oYvyqCYdrh/sT/+72CFXh04pu9KiyQCevlJSRNIjjig10/zcezst8KIkXBab536XIxV
         lDLDhgotTdQBk/wYNKID8NXHzp+LGqZfxa6V6aqR55xuQDNAr6doid/3jhIuG/FfFFvy
         AuL2u7gv+ODkTw6JpJetJimb5GKAuyS2jzOhzLLcj0tjLBwcCBfDmhwLyKmmJGeGoUO2
         wkag==
X-Gm-Message-State: AOAM530SydPl4v0fz9ImFlOIX2Pj13Nb3A0nDfP6DXwsZPxnKVHTqAmU
        1L16gRZxC7ifJyEi7AUaTWJQHtl+QNM=
X-Google-Smtp-Source: ABdhPJxVJMdiokrrTDwyhv99ACVlXJgbdwy+GXg7QPlvbB8Ux2CsCxa0UjBOltqFe9M4CF2fN6SPdQ==
X-Received: by 2002:a2e:90ca:: with SMTP id o10mr12168334ljg.67.1630956807540;
        Mon, 06 Sep 2021 12:33:27 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id y16sm810359lfs.145.2021.09.06.12.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 12:33:26 -0700 (PDT)
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org>
 <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
 <b597c805-e346-8c23-5014-cbb116e88075@gmail.com>
 <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
 <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com>
 <CAPDyKFoyszG2Wo3jbXK562XgpqXns_GPqm7nNu8WOdMCXYUOMQ@mail.gmail.com>
 <66fbbc69-3e16-e07c-4e25-48d59d69fd3c@gmail.com>
 <CAPDyKFqqdgr2DHf1Fidj3ksPHe3XgwvCo8SbQ2Cmnc5y1PDvMw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7ee1a2eb-67d7-dcad-6039-05129d3822ec@gmail.com>
Date:   Mon, 6 Sep 2021 22:33:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqqdgr2DHf1Fidj3ksPHe3XgwvCo8SbQ2Cmnc5y1PDvMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

06.09.2021 20:34, Ulf Hansson пишет:
> On Mon, 6 Sept 2021 at 16:11, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 06.09.2021 13:24, Ulf Hansson пишет:
>>> On Sun, 5 Sept 2021 at 10:26, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 03.09.2021 17:03, Ulf Hansson пишет:
>>>>> On Fri, 3 Sept 2021 at 11:58, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>
>>>>>> 03.09.2021 11:22, Ulf Hansson пишет:
>>>>>>> On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>>>
>>>>>>>> 02.09.2021 13:16, Ulf Hansson пишет:
>>>>>>>>> When a device is detached from its genpd, genpd loses track of the device,
>>>>>>>>> including its performance state vote that may have been requested for it.
>>>>>>>>>
>>>>>>>>> Rather than relying on the consumer driver to drop the performance state
>>>>>>>>> vote for its device, let's do it internally in genpd when the device is
>>>>>>>>> getting detached. In this way, we makes sure that the aggregation of the
>>>>>>>>> votes in genpd becomes correct.
>>>>>>>>
>>>>>>>> This is a dangerous behaviour in a case where performance state
>>>>>>>> represents voltage. If hardware is kept active on detachment, say it's
>>>>>>>> always-on, then it may be a disaster to drop the voltage for the active
>>>>>>>> hardware.
>>>>>>>>
>>>>>>>> It's safe to drop performance state only if you assume that there is a
>>>>>>>> firmware behind kernel which has its own layer of performance management
>>>>>>>> and it will prevent the disaster by saying 'nope, I'm not doing this'.
>>>>>>>>
>>>>>>>> The performance state should be persistent for a device and it should be
>>>>>>>> controlled in a conjunction with runtime PM. If platform wants to drop
>>>>>>>> performance state to zero on detachment, then this behaviour should be
>>>>>>>> specific to that platform.
>>>>>>>
>>>>>>> I understand your concern, but at this point, genpd can't help to fix this.
>>>>>>>
>>>>>>> Genpd has no information about the device, unless it's attached to it.
>>>>>>> For now and for these always on HWs, we simply need to make sure the
>>>>>>> device stays attached, in one way or the other.
>>>>>>
>>>>>> This indeed requires to redesign GENPD to make it more coupled with a
>>>>>> device, but this is not a real problem for any of the current API users
>>>>>> AFAIK. Ideally the state should be persistent to make API more universal.
>>>>>
>>>>> Right. In fact this has been discussed in the past. In principle, the
>>>>> idea was to attach to genpd at device registration, rather than at
>>>>> driver probe.
>>>>>
>>>>> Although, this is not very easy to implement - and it seems like the
>>>>> churns to do, have not been really worth it. At least so far.
>>>>>
>>>>>>
>>>>>> Since for today we assume that device should be suspended at the time of
>>>>>> the detachment (if the default OPP state isn't used), it may be better
>>>>>> to add a noisy warning message if pstate!=0, keeping the state untouched
>>>>>> if it's not zero.
>>>>>
>>>>> That would just be very silly in my opinion.
>>>>>
>>>>> When the device is detached (suspended or not), it may cause it's PM
>>>>> domain to be powered off - and there is really nothing we can do about
>>>>> that from the genpd point of view.
>>>>>
>>>>> As stated, the only current short term solution is to avoid detaching
>>>>> the device. Anything else, would just be papering of the issue.
>>>>
>>>> What about to re-evaluate the performance state of the domain after
>>>> detachment instead of setting the state to zero?
>>>
>>> I am not suggesting to set the performance state of the genpd to zero,
>>> but to drop a potential vote for a performance state for the *device*
>>> that is about to be detached.
>>
>> By removing the vote of the *device*, you will drop the performance
>> state of the genpd. If device is active and it's wrong to drop its
>> state, then you may cause the damage.
>>
>>> Calling genpd_set_performance_state(dev, 0), during detach will have
>>> the same effect as triggering a re-evaluation of the performance state
>>> for the genpd, but after the detach.
>>
>> Yes
>>
>>>> This way PD driver may
>>>> take an action on detachment if performance isn't zero, before hardware
>>>> is crashed, for example it may emit a warning.
>>>
>>> Not sure I got that. Exactly when do you want to emit a warning and
>>> for what reason?
>>>
>>> Do you want to add a check somewhere to see if
>>> 'gpd_data->performance_state' is non zero - and then print a warning?
>>
>> I want to check the 'gpd_data->performance_state' from the detachment
>> callback and emit the warning + lock further performance changes in the
>> PD driver since it's a error condition.
> 
> Alright, so if I understand correctly, you intend to do the check for
> the "error condition" of the device in the genpd->detach_dev()
> callback?

Yes

> What exactly do you intend to do beyond this point, if you detect the
> "error condition"? Locking further changes of the performance state
> seems fragile too, especially if some other device/driver requires the
> performance state to be raised. It sounds like you simply need to call
> BUG_ON() then?

I can lock it to high performance state.

> Also note that a very similar problem exists, *before* the device gets
> attached in the first place. More precisely, nothing prevents the
> performance state from being set to a non-compatible value for an
> always-on HW/device that hasn't been attached yet. So maybe you need
> to set the maximum performance state at genpd initializations, then
> use the ->sync_state() callback to very that all consumers have been
> attached to the genpd provider, before allowing the state to be
> changed/lowered?

That is already done by the PD driver.

https://elixir.bootlin.com/linux/latest/source/drivers/soc/tegra/pmc.c#L3790

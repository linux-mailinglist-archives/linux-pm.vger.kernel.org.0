Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F113B6959
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbhF1T55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 15:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbhF1T55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 15:57:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BABC061760
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 12:55:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x20so20720583ljc.5
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ku4iTgeK6Xjj0yanjIzQMw08wHZgQNbkjae0X6i2vzM=;
        b=JfKqO5zmBhGRkrwTiSshl0RJndtwXIq085K+lspTtIe19J1/UyC+CcijmTLz610mhz
         s6dBuomcQG6ykbYh8c6stKjfr/095cPgQH7X3+eEHAXxRgzdqkJHzsrKq8YZ78Joqby3
         G/Gi7RCY55qbnSkZ2mXYTqx1RwsrC96EhpuAP+DKodZ8W0KqrKyXe2rN9xaQcnWcVzgw
         MjorHwH8eE2Ze+L2vMjC7bGyaZZc6vp4R31NzRjTeeHNJ+09igZw1mgre9LRK2ATuzWd
         PRi9UxPGUzSSr1wGaliV2Rro29RRLvxEyXHb8/xjUED7vcT8ro6Ve1U9dJEvLTGDt2qJ
         Hevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ku4iTgeK6Xjj0yanjIzQMw08wHZgQNbkjae0X6i2vzM=;
        b=Hzw+GTwJ/IwaoONU3bBSWjncOu+mDhEV3lkv5LKuzTizQovH9eSdivsZBbD1fm7GSQ
         rffBdhGdh98WeEqX7OuxMTm9KYX7jxoAOxmM0UWhTcDV1uTrUKUaixIyQd1lDzzYJK4A
         myjRGJfk7F0XZYbKJg7vrd3qn4IxYCik2ohQDwNWXlSReowC+j9u/nDHpSUg3UwbB4Nt
         PCp94Vi089/hxOb9rKsKw7dOXUBrPuTJ9nbLKyTtBFqgb1z+dBXXo4Cc7BtyHLv3mik2
         2KqmSlCHtk46tuioCgwOXs3eDrhTv36wX3vv7zd0YVd0I1PmflBE5rKO5oeJzp147vc2
         fmuQ==
X-Gm-Message-State: AOAM530jXcCBuYE4YyDcu4SniLijwygmchG50Wcv8Elf5rBM5qMUOuJq
        JUDszzpqJGQ7MH3gfmd8vl/cOA==
X-Google-Smtp-Source: ABdhPJzx7qWD5LaRlEZZ/zyKStbUuBS/+hiNmSTFekHFMOWY1FHLHMrkBttaPIP0/8Zw0pg2vDxB7A==
X-Received: by 2002:a2e:5352:: with SMTP id t18mr629176ljd.420.1624910128099;
        Mon, 28 Jun 2021 12:55:28 -0700 (PDT)
Received: from [192.168.43.7] ([188.162.64.209])
        by smtp.gmail.com with ESMTPSA id d22sm1666695ljc.55.2021.06.28.12.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:55:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org>
 <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <YMjNaM0z+OzhAeO/@yoga>
 <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <c6e99362-56c1-f2bd-7170-7b001e0f96fe@linaro.org>
Date:   Mon, 28 Jun 2021 22:55:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 17/06/2021 12:07, Ulf Hansson wrote:
> + Rajendra
> 
> On Tue, 15 Jun 2021 at 17:55, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>>
>> On Tue 15 Jun 05:17 CDT 2021, Ulf Hansson wrote:
>>
>>> + Mark
>>>
>>> On Fri, 11 Jun 2021 at 16:34, Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>> Added Stephen to Cc list
>>>>
>>>> On Fri, 11 Jun 2021 at 16:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>
>>>>> On Fri, 11 Jun 2021 at 12:15, Dmitry Baryshkov
>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>
>>>>>> In case of nested genpds it is easy to get the following warning from
>>>>>> lockdep, because all genpd's mutexes share same locking class. Use the
>>>>>> per-genpd locking class to stop lockdep from warning about possible
>>>>>> deadlocks. It is not possible to directly use genpd nested locking, as
>>>>>> it is not the genpd code calling genpd. There are interim calls to
>>>>>> regulator core.
>>>>>>
>>>>>> [    3.030219] ============================================
>>>>>> [    3.030220] WARNING: possible recursive locking detected
>>>>>> [    3.030221] 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480 Not tainted
>>>>>> [    3.030222] --------------------------------------------
>>>>>> [    3.030223] kworker/u16:0/7 is trying to acquire lock:
>>>>>> [    3.030224] ffffde0eabd29aa0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
>>>>>> [    3.030236]
>>>>>> [    3.030236] but task is already holding lock:
>>>>>> [    3.030236] ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
>>>>>> [    3.030240]
>>>>>> [    3.030240] other info that might help us debug this:
>>>>>> [    3.030240]  Possible unsafe locking scenario:
>>>>>> [    3.030240]
>>>>>> [    3.030241]        CPU0
>>>>>> [    3.030241]        ----
>>>>>> [    3.030242]   lock(&genpd->mlock);
>>>>>> [    3.030243]   lock(&genpd->mlock);
>>>>>> [    3.030244]
>>>>>> [    3.030244]  *** DEADLOCK ***
>>>>>> [    3.030244]
>>>>>> [    3.030244]  May be due to missing lock nesting notation
>>>>>> [    3.030244]
>>>>>> [    3.030245] 6 locks held by kworker/u16:0/7:
>>>>>> [    3.030246]  #0: ffff6cca00010938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
>>>>>> [    3.030252]  #1: ffff8000100c3db0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
>>>>>> [    3.030255]  #2: ffff6cca00ce3188 (&dev->mutex){....}-{3:3}, at: __device_attach+0x3c/0x184
>>>>>> [    3.030260]  #3: ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
>>>>>> [    3.030264]  #4: ffff8000100c3968 (regulator_ww_class_acquire){+.+.}-{0:0}, at: regulator_lock_dependent+0x6c/0x1b0
>>>>>> [    3.030270]  #5: ffff6cca00a59158 (regulator_ww_class_mutex){+.+.}-{3:3}, at: regulator_lock_recursive+0x94/0x1d0
>>>>>> [    3.030273]
>>>>>> [    3.030273] stack backtrace:
>>>>>> [    3.030275] CPU: 6 PID: 7 Comm: kworker/u16:0 Not tainted 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480
>>>>>> [    3.030276] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>>>>>> [    3.030278] Workqueue: events_unbound deferred_probe_work_func
>>>>>> [    3.030280] Call trace:
>>>>>> [    3.030281]  dump_backtrace+0x0/0x1a0
>>>>>> [    3.030284]  show_stack+0x18/0x24
>>>>>> [    3.030286]  dump_stack+0x108/0x188
>>>>>> [    3.030289]  __lock_acquire+0xa20/0x1e0c
>>>>>> [    3.030292]  lock_acquire.part.0+0xc8/0x320
>>>>>> [    3.030294]  lock_acquire+0x68/0x84
>>>>>> [    3.030296]  __mutex_lock+0xa0/0x4f0
>>>>>> [    3.030299]  mutex_lock_nested+0x40/0x50
>>>>>> [    3.030301]  genpd_lock_mtx+0x18/0x2c
>>>>>> [    3.030303]  dev_pm_genpd_set_performance_state+0x94/0x1a0
>>>>>> [    3.030305]  reg_domain_enable+0x28/0x4c
>>>>>> [    3.030308]  _regulator_do_enable+0x420/0x6b0
>>>>>> [    3.030310]  _regulator_enable+0x178/0x1f0
>>>>>> [    3.030312]  regulator_enable+0x3c/0x80
>>>>>
>>>>> At a closer look, I am pretty sure that it's the wrong code design
>>>>> that triggers this problem, rather than that we have a real problem in
>>>>> genpd. To put it simply, the code in genpd isn't designed to work like
>>>>> this. We will end up in circular looking paths, leading to deadlocks,
>>>>> sooner or later if we allow the above code path.
>>>>>
>>>>> To fix it, the regulator here needs to be converted to a proper PM
>>>>> domain. This PM domain should be assigned as the parent to the one
>>>>> that is requested to be powered on.
>>>>
>>>> This more or less resembles original design, replaced per review
>>>> request to use separate regulator
>>>> (https://lore.kernel.org/linux-arm-msm/160269659638.884498.4031967462806977493@swboyd.mtv.corp.google.com/,
>>>> https://lore.kernel.org/linux-arm-msm/20201023131925.334864-1-dmitry.baryshkov@linaro.org/).
>>>
>>> Thanks for the pointers. In hindsight, it looks like the
>>> "regulator-fixed-domain" DT binding wasn't the right thing.
>>>
>>> Fortunately, it looks like the problem can be quite easily fixed, by
>>> moving to a correct model of the domain hierarchy.
>>>
>>
>> Can you give some pointers to how we actually fix this?
>>
>> The problem that lead us down this path is that drivers/clk/qcom/gdsc.c
>> describes power domains, which are parented by domains provided by
>> drivers/soc/qcom/rpmhpd.c.
>>
>> But I am unable to find a way for the gdsc driver to get hold of the
>> struct generic_pm_domain of the resources exposed by the rpmhpd driver.
> 
> You don't need a handle to the struct generic_pm_domain, to assign a
> parent/child domain. Instead you can use of_genpd_add_subdomain(),
> which takes two "struct of_phandle_args*" corresponding to the
> parent/child device nodes of the genpd providers and then let genpd
> internally do the look up.

I've taken a look onto of_genpd_add_subdomain. Please correct me if I'm 
wrong, I have the feeling that this function is badly designed. It 
provokes to use the following sequence:
- register child domain
- register child's domain provider
- mark child as a subdomain of a parent.

So we have a (short) timeslice when users can get hold of child domain, 
but the system knows about a child domain, but does not about a 
parent/child relationship.

I think this function should be changed to take struct generic_pm_domain 
as a second argument. I will attempt refactoring cpuidle-psci-domain to 
follow this, let's see if this will work.

Another option would be to export genpd_get_from_provider() and to use 
genpd_add_subdomain() directly.

I think I'd need this function anyway for the gdsc code. During 
gdsc_init() we check gdsc status and this requires register access (and 
thus powering on the parent domain) before the gdsc is registered itself 
as a power domain.

-- 
With best wishes
Dmitry

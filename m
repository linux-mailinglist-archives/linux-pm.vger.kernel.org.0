Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49D3AB96C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhFQQVQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhFQQVP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 12:21:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBACC061574
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 09:19:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r16so9802637ljk.9
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UIwDw5It67gtmh1VzMKodpZv7Vdx72o6JvpV1IeQnOg=;
        b=JF84FlMYzrgpsHqrEnua1qeDPPUmo4iEY1m1KI3nMy4BtYk4nt8BpgbzIY2AI+oVrM
         ylPmtmacWTin/4AMe1HKaQCim3OsL5UGKNoQpuS/lWDLHkqgj8OcstirEQPq6ziU/nXf
         h1yYDTc+GGpusnTSWfdp8lT17VTE4LSRx4hF/QKG5uwZBaY0vGJKPlUmHj6MVdZCyQY3
         X59TgiB25zbg94Sp8HU3Cfab518FEnfgQsE2YUb3neUs57NWxTpkR3HrI4WvwF7td3Er
         b3Ir+mCvSNQpLiBDnT9Iv20K7DQgyBLtSi0W0rtIk2pIa+iPV69lOUN3WwEJ5xKYHZrO
         XD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UIwDw5It67gtmh1VzMKodpZv7Vdx72o6JvpV1IeQnOg=;
        b=Ia6lFldhpla3c/JiAvkqROvzTaYFAqwN3hd6pTj3gkB+eMDoNzeGMSzZM+y+McXSmA
         PZyc5qLVja1EpBiriO7C7O9BY5yhh/QV+djj3Ag4UX1tUXqWGzXJryIZIqFZ3h3avVIk
         KrhmY4pDLm/+BOH/3IFMv5qYM4kYSvjuZ+hmvhOirbCP3u3YrrpMfwtvUVx6/13qkVOZ
         4EpsGG4CraIWXNR4S6Zd8xyEM+PR524Nn/TSD4EE7Et6sJNBkYdVmJTK7lzHKZp6A1wo
         diRlQRQlXJaLAAL6BzvbDeWUP09VnFFVagp3fl9/9TWbVL/D/VVor71SWTP0ChgleWlb
         uOvA==
X-Gm-Message-State: AOAM5332pWfUJI1TcUTkhjho39N0JL58m96/r9ufaByChQepyycB99FI
        qomjQtiYQcHgT//gAygrrg2I8A==
X-Google-Smtp-Source: ABdhPJxB3XkzzdmKgJC169TaqXU6SXuPvGZ+e8N8N/yZe7IC73usH961/S8Ij1xhAshPRyQ1XggmjA==
X-Received: by 2002:a2e:8802:: with SMTP id x2mr5422195ljh.245.1623946745144;
        Thu, 17 Jun 2021 09:19:05 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j16sm623312lfk.155.2021.06.17.09.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 09:19:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org>
 <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <YMjNaM0z+OzhAeO/@yoga>
 <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <9136597d-f30b-bf75-77c3-b42533d822fa@linaro.org>
Date:   Thu, 17 Jun 2021 19:19:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
> 
> As an example, you may have a look at how the PM domain topology in
> drivers/cpuidle/cpuidle-psci-domain.c are being created.
> 
>>
>>
>> The second thing that Dmitry's regulator driver does is to cast the
>> appropriate performance state vote on the rpmhpd resource, but I _think_
>> we can do that using OPP tables in the gdsc client's node...
> 
> Yes, it looks like using an OPP table and to specify a
> "required-opps", at some device node is the right thing to do.
> 
> In this case, I wonder if the "required-opps" belongs to the genpd
> provider node of the new power-domain (as it seems like it only
> supports one fixed performance state when it's powered on). On the
> other hand, specifying this at the consumer node should work as well,
> I think.
> 
> Actually, this relates to the changes [1] that Rajendra is working on
> with "assigned-performance-state" (that we agreed to move to
> OPP/required-opps) for genpd.

What about the following dts snippet?
I do not want to add power-domains directly to the dispcc node (as it's 
not a device's power domain, just gdsc's parent power domain).


dispcc: clock-controller@af00000 {
	compatible = "qcom,sm8250-dispcc";
	[....]
	#power-domain-cells = <1>;

	mmss_gdsc {
		power-domains = <&rpmhpd SM8250_MMCX>;
                 required-opps = <&rpmhpd_opp_low_svs>;
	};
};

> 
>>
>>> Beyond this, perhaps we should consider removing the
>>> "regulator-fixed-domain" DT property, as to avoid similar problems
>>> from cropping up?
>>>
>>
>> Currently there's a single user upstream, but we have the exact same
>> problem in at least 3-4 platforms with patches in the pipeline.
>>
>> In order to avoid breakage with existing DT I would prefer to see
>> regulator-fixed-domain to live for at least one kernel release beyond
>> the introduction of the other model.
> 
> Yes, this seems reasonable to me.
> 
> As Mark suggested, let's mark the regulator-fixed-domain DT property
> as deprecated and remove it once we have the new solution in place.
> 
> [...]
> 
> Kind regards
> Uffe
> 


-- 
With best wishes
Dmitry

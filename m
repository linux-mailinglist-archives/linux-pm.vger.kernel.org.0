Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8928DFBD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 13:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgJNLXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 07:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbgJNLXF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 07:23:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E504C061755
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 04:23:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f21so1928365wml.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oWaGuo9LskuZ4hXwW4a3zf/hlKac3ATy+u6gonh1b2Q=;
        b=V1B4ZhetUpahJXmCc8Nl/G16fbmvRO9QjhujCBD8MrohGV6HWWErpum53RILt21/xW
         jgLYOxZXMSKZz7AI38yPWU+kNk8ZDQAnjjhFEnb7mif+oSZjVbQNhDFcYKwLePNqlcVu
         m9VLQQMV/saSgEDp4nZJE8A2jt6C9V2vgkLHwlSwK730iEF8B+3qxQcl1bZ/qmVcxz2T
         Dw/Zz8UFdyPv+vkbvYZRoLfr8dKDjJx+7C/AFseaBLWsTBaWb51mGYQafD0aCXtWr+py
         OohFL+Y24rRJuj//F6EUb4NZ7jO6cr7fSske3WjM+WNFZez9Q+/fdWRdAs4w+SQgtOpv
         x+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oWaGuo9LskuZ4hXwW4a3zf/hlKac3ATy+u6gonh1b2Q=;
        b=pgR/HDWMi/SRmoJfuhWFjNsTG7H68i+xrPvOI989ZFALPbBLJbxmISggI365kmZ27m
         FcnLesRPRNzLd7aqvrGQjyoco+b6wbmLdLI4w3dIzJ0+IWQGRgEhTBIsmgcJr6qn7Ikv
         b1W65o9ILx5rakJAaErEx6wXbrYqG8d3yny+e7Gq/izqTHYuWswC5KD6/jVGzHWeQmob
         Qn6L4nlznLvLWoi2Vmi5fQswgoOPTxuhGftsYfFeng+cGG7IZSgeutKjZuBVJmD92Wny
         nzUfk23xu6be+Im8ZemmdcJK1MOrN3n2mvAhMa0EX4W5K0EkumW83Q6rDLJv7CntPH0X
         zvtQ==
X-Gm-Message-State: AOAM530UUvazVVGn0awpX6vQS0xU6TjyjCsPZwhqU8FpUkADLqoYb8df
        QXbCudQoSOyIecW/PVIEmebxWQ==
X-Google-Smtp-Source: ABdhPJzq2JW0akPdDmOzMbu3G9f8P99qjock5GWOa+k7jyBd/FreW1zPU+oD5RPP9LYdFSjfK6i28g==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr3087165wmi.66.1602674583733;
        Wed, 14 Oct 2020 04:23:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f? ([2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f])
        by smtp.googlemail.com with ESMTPSA id v3sm4621066wre.17.2020.10.14.04.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:23:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, amitk@kernel.org,
        corbet@lwn.net, Dietmar.Eggemann@arm.com, qperret@google.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org>
 <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
Date:   Wed, 14 Oct 2020 13:23:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2020 11:08, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 10/14/20 9:22 AM, Daniel Lezcano wrote:
>>
>> Hi Lukasz,
>>
>> On 09/10/2020 11:16, Lukasz Luba wrote:
>>> Hi Rafael,
>>>
>>> On 10/2/20 12:44 PM, Lukasz Luba wrote:
>>>> Hi all,
>>>>
>>>> The Energy Model supports power values expressed in an abstract scale.
>>>> This has an impact on Intelligent Power Allocation (IPA) and should be
>>>> documented properly. There is also a need to update the DT binding for
>>>> the
>>>> 'sustainable-power' and allow it to have abstract scale as well.
>>>>
>>>> Changes:
>>>> v2:
>>>> - updated sustainable power section in IPA documentation
>>>> - updated DT binding for the 'sustainable-power'
>>>>
>>>> The v1 of the patch set and related discussion can be found in [1].
>>>>
>>>> Regards,
>>>> Lukasz Luba
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-doc/20200929121610.16060-1-lukasz.luba@arm.com/
>>>>
>>>>
>>>>
>>>> Lukasz Luba (3):
>>>>     docs: Clarify abstract scale usage for power values in Energy Model
>>>>     PM / EM: update the comments related to power scale
>>>>     dt-bindings: thermal: update sustainable-power with abstract scale
>>>>
>>>>    .../devicetree/bindings/thermal/thermal-zones.yaml  | 13
>>>> +++++++++----
>>>>    .../driver-api/thermal/power_allocator.rst          | 13
>>>> ++++++++++++-
>>>>    Documentation/power/energy-model.rst                | 13
>>>> +++++++++++++
>>>>    Documentation/scheduler/sched-energy.rst            |  5 +++++
>>>>    include/linux/energy_model.h                        | 11 +++++------
>>>>    kernel/power/energy_model.c                         |  2 +-
>>>>    6 files changed, 45 insertions(+), 12 deletions(-)
>>>>
>>>
>>> Could you take patch 1/3 and patch 2/3 via your PM tree,
>>> please? I will be very grateful.
>>>
>>> These patches just update the documentation and comments regarding
>>> an issue that we can have: bogoWatts in the Energy Model (and we
>>> already have). One of the drawbacks is that we cannot derive real energy
>>> from these numbers. Will see how this would evolve.
>>
>> The purpose of the energy model is to provide these power numbers.
>>
>> If the SoC vendors do not want to share those numbers, then better to
>> not use the energy model at all.
>>
>> If they want to use the EAS and the IPA at all costs without sharing the
>> power numbers, then it is up to them to take responsibility of providing
>> consistent numbers, not the community to document how to hack the energy
>> model.
>>
>> And that is even more true as mentioned by Doug: the power numbers are
>> not impossible to measure.
>>
>> Documenting the scale values give the opportunity to the SoC vendor to
>> never share the power numbers, and even worst, that implies all the
>> existing and future frameworks based on the energy model (and its
>> evolution) *must* comply with these dummy values. That is the promise of
>> a real pain.
>>
>> IMO, we must keep a strong constraint on the power values for the energy
>> model.
>>
>> However, nothing prevents to write a recipe on a website explaining how
>> to use the energy model without the power numbers with a big warning
>> that could not work in the future if the energy model evolves or it
>> could be incompatible with the IPA.
>>
>> I suggest to solve the energy model main issue: the SoC vendor do not
>> want to share the power numbers. Why not give the opportunity to load a
>> firmware where the power numbers will be ? The firmware could be in a
>> vendor partition for example.
>>
>>
> 
> I understand your concerns. Unfortunately, the reality is that the
> bogoWatts are there. I had discussion about it a few days ago with
> Rajendra and Doug [1], where I was also opposed to allow bogoValue
> coming from DT 'dynamic-power-coefficient'. But I have discussed it
> internally and we allow, because developers would do it anyway.

With all respects, 'internal discussions' is like out of tree kernels:
for the community, they don't exist :)

The development process in opensource is, by essence, public.

That said, if the developers want to use abstract values, up to them to
make sure it is consistent with the existing framework.

Why do you need to document that and involve the community
responsibility by adding these information in the Documentation even if
you know different frameworks could be incompatible ?


> Regarding your question with firmware where the power numbers can be
> stored. Unfortunately, it is quite opposite, FW might want to hide it.

No, I meant a firmware file, called by request_firmware(). So instead of
having the power numbers in the DT, so published with the kernel, they
are in the SoC vendor's partition in the firmware file, like
'energy_model.bin'.

Then when the energy model is initialized, it will try to request an
energy model firmware file.

That gives the opportunity to the SoC vendor to put the power numbers in
the file and distribute it with the product.

> We even allow bogoWatts to come from firmware, the SCMI spec:
> (4.5.1 Performance domain management protocol background)
> 'The power can be expressed in mW or in an abstract scale. Vendors are
> not obliged to reveal power costs if it is undesirable, but a linear
> scale is required.'
> The callback which does this is not able to check if the value is a
> bogoWatt [2].

So the definition is clear: '... linear scale is required'. So that
implies *all* power numbers for all devices defined in the SCMI. It is
up to the SoC vendor to provide the right numbers.

The EM / IPA / EAS do not have to care about the values.

> EAS can handle EM with bogoWatts, as I described in the patch.
> IPA has some issues: 'sustainable-power' in DT (which shouldn't be used
> when EM devices use abstract scale) but sysfs interface can be used.

Here the platform is mixing the numbers from different firmwares with
different units.

Why not make things consistent ? If the power numbers are coming from
the SCMI, then ignore the ones coming from the DT, no? That should be
simpler now that we have the energy model used for devfreq and cpufreq.

May be add a flag in the energy model giving the origin of the data?

> This patch set just align the SCMI spec with EM, EAS, IPA
> documentation and already present platforms which use it.

Actually, it is the opposite, the patch aligns EAS and EM to the SCMI
spec, but we end up with IPA based on the EM/SCMI & DT and EAS based on
EM/SCMI, right ?

That is the root cause of the incompatibility.

> I hope that the real milliWatts would come to EM via the DT
> 'dynamic-power-coefficient' and function dev_pm_opp_of_register_em().
> But no guaranties as you can see in [1].

It is not a kernel problem if inconsistent values are specified in the DT.

May be make developer life easier by submitting a script which will take
a device tree, check all power numbers, and consistently abstract them.
The developer will write the real values in the DT, test everything is
working fine, then run the script which will make the 'linear scale' of
all the power numbers and convert them to bogoWatt (with different
properties name, so watt and bogowatt mix can be detected).

In any case, if the DT is specifying real numbers, and SCMI abstract
numbers or the opposite, obviously there is a conflict if we are using both.

I suggest to fix the conflict first and provide the features to make the
numbers more easy to share (like the script described above and/or the
firmware file).

Then with the right tools, everything can be documented.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54928D199
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgJMP4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 11:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbgJMP4k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 11:56:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66418C0613D0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 08:56:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y12so19306757wrp.6
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1QiOXawpEW/baUUCnHfNnDJvAVS6kigOm0sC2Uhuv+Y=;
        b=W88yhCzzRjNPmZJ6htj7Wuq+3b0t3MZhyBeswQHhr5fQXjDodedcSLiS3kjebSSidq
         Bn7NofYW7e1NFcb2sTAxC6l4q0vhySMEV0ZbtQeVqPoeAVIexaHWunkMFSjiG6AEfeZg
         V0gVQicR9eCsxK7U1I+7kPvlMsRxTaU+52f2Ul3smqU5blNcscLUKIrkPZa8q56nDR4h
         8xXjvulaNRv55P46qTW/nh2XW6ky/MTvNpHdExK3bDt1ySSWM+2O3wkwqzI7rT5y+NIB
         6EEy8x7e8xHnoTaBVU1MHmI0hq+I/rZI0MNaAUAjFDXYW6mrfBzB3gH75P7ySEBpr9hU
         tzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1QiOXawpEW/baUUCnHfNnDJvAVS6kigOm0sC2Uhuv+Y=;
        b=pMfoP6+BJ5qEmrj1Oahg/KrdCeF4gaZV04LyABKMUXYXdSX7BhJ0i4tKpx0tFSGO7A
         wtxkZtpO+enntxP01Lwq6YyZncZLwbKp0AWFRHhGxuaxCLy+GO2K80kz50w8gj3/wr2p
         PuH9MJZy52lM9b2tQ8h840MvjFry/gwCSthHhdmEpZKAi5sndg5LSz/NZP18OWKKspzz
         GxaH8ezMO+G7VE8K8yxF2eiwtcYqlZvuc2opTe+LlbuIQEZgoNMbF0J1TlamQfm2sLnN
         dRE3z3OyAQeJzgB13nEEwpCI8FRZZgB0sxOj/gviZFCqc6mi7vQ84qj7I4vZcBRPhg5m
         kJqQ==
X-Gm-Message-State: AOAM533aYmeTXdHm+iWvKw825A5SODddbPZleheuQOcxtnqVg1fd9Yug
        xKb7FmbdaEKoxvrK5se1BC5EKw==
X-Google-Smtp-Source: ABdhPJx72aO+b4x1mizhzQqJ121ueQuCK3wusa+iNuG93K6OvAocgvXEqxvYZG+ZDUTxyyMS4UjfbA==
X-Received: by 2002:adf:92a1:: with SMTP id 30mr313839wrn.269.1602604597798;
        Tue, 13 Oct 2020 08:56:37 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f? ([2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f])
        by smtp.googlemail.com with ESMTPSA id e13sm34618wre.60.2020.10.13.08.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 08:56:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power allocator: change the 'k_i'
 coefficient estimation
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, Dietmar.Eggemann@arm.com
References: <20201002122416.13659-1-lukasz.luba@arm.com>
 <20201002122416.13659-2-lukasz.luba@arm.com>
 <cc0e6d85-28ad-3cfc-e5b8-75820552b716@linaro.org>
 <5f682bbb-b250-49e6-dbb7-aea522a58595@arm.com>
 <326a84b4-1782-9e6b-2b95-9627767dd2f8@linaro.org>
 <42360f0f-5d53-085b-536f-33df93b787ca@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4eab17d6-4232-3b8b-b096-835b13e889c1@linaro.org>
Date:   Tue, 13 Oct 2020 17:56:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <42360f0f-5d53-085b-536f-33df93b787ca@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/10/2020 14:04, Lukasz Luba wrote:
> 
> 
> On 10/13/20 12:22 PM, Daniel Lezcano wrote:
>> On 13/10/2020 12:59, Lukasz Luba wrote:
>>> Hi Daniel,
>>>
>>> On 10/13/20 11:21 AM, Daniel Lezcano wrote:
>>>>
>>>> Hi Lukasz,
>>>>
>>>> On 02/10/2020 14:24, Lukasz Luba wrote:
>>>>> Intelligent Power Allocation (IPA) is built around the PID controller
>>>>> concept. The initialization code tries to setup the environment
>>>>> based on
>>>>> the information available in DT or estimate the value based on minimum
>>>>> power reported by each of the cooling device. The estimation will
>>>>> have an
>>>>> impact on the PID controller behaviour via the related 'k_po', 'k_pu',
>>>>> 'k_i' coefficients and also on the power budget calculation.
>>>>>
>>>>> This change prevents the situation when 'k_i' is relatively big
>>>>> compared
>>>>> to 'k_po' and 'k_pu' values. This might happen when the estimation for
>>>>> 'sustainable_power' returned small value, thus 'k_po' and 'k_pu' are
>>>>> small.
>>>>>
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---

[ ... ]

>>> Yes, I strongly believe that vendor engineers will make experiments with
>>> these values and not go with default. Then they will store the k_pu,
>>> k_po, k_i via sysfs interface, with also sustainable_power.
>>
>> IMHO it is the opposite. For what I've seen, the IPA is not used or the
>> k_* are misunderstood, thus not changed. The PID regulation loop
>> technique is not quite used and known by everyone.
> 
> There is quite a few DT entries of 'sustainable-power' so I assumed
> it is known, but you might be right.

Yes, and if you do not count the Linaro contributions, there are even
less entries.

That may imply the sustainable power is estimated in most of the case if
the vendors are specifying the ipa governor. This series may change the
default behavior, but I guess this is not a problem without the right
k_* in any case.

>>> But I have to also fix the hard-coded k_i in the estimation. As
>>> described above, when we have small power values from abstract scale,
>>> the k_i stays too big.
>>
>> May be it is preferable to adjust the k_* dynamically given the
>> undershot and overshot results? And then add a set of less opaque
>> parameters for the user, like the time or watts, no?
>>
> 
> Hmmmm, this is interesting, I haven't thought about it. Thank you
> for this idea.
> That would require a re-design of current IPA. IPA trying to figure
> out better k_* values... I will discuss it internally.

[ ... ]

> It would take time, definitely more than the proposed small fix
> addressing abstract scale and hard-coded 'k_i'.
> Do you think that this fix can be applied and then I can experiment
> on what you suggested?

Yes, sure. Let me review the patch 2/2.

Thanks

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

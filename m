Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2EDD11230B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 07:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDGuS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 01:50:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34185 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfLDGuS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 01:50:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id f4so4065331wmj.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 22:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VMtFfNaDx2oQbuDbsEhYc0lGTSp37MnP2fz0v39AX38=;
        b=ubAR+keAfnqKsKRDax35KDypRtW1p4omzCQbjDV0j6l5ZWClhQonZQ3XJZ6+WJPigv
         JR57d2F9hBaspWrC7wXL3RtPnKSBzz6sOtSRVN/77+c+0BLe9q+2Byl16C35ykFdLa9F
         6Z/zvGFvmPrYD17rtWxc/+Qgk8v24ivMiCz0ViX6mj581M6ACT4mY9ORLPirq4y72iXY
         fMwqrB98LQ4iKFTfxm6u1K3SKdf4TtAzWW/NVTjf8BKyAzPWuawNBFXIIjS073kUy6Z8
         sSz8HYgeTN/BkiUAbe1fpV97JhSMyKyZQALPzTWNsZ2kBqAVRr/7xC8SSynPoMwntVKI
         nBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VMtFfNaDx2oQbuDbsEhYc0lGTSp37MnP2fz0v39AX38=;
        b=hjgvYujrzP8WxkMClZxYUooOVamy/kDk4gzv/zpebPz3wWAinmTwsUrKoi7V4tE6eG
         CipiaJX+lT6zRtwzj4gELHxYKVYc09Y1qa0DiYqG68Xb/RV5XaSqj8d/OfHUBSjpCAUA
         6c4HOiWw1p53xLBMD9505IDJCwyH+f6YrOquc39mzgp+bQXAMWfRS25H/lXYvYH6g0J9
         4dB2peMXgFvAuJemswpo33eHetxgDzrLl1pOG4V9QOQimTwJ7fMXFv73tE8+QJVIRwzY
         iYsBO7VZSGV4si8d2w0vqkPQsEd4ilL4VM/QD4POmKOfOpoCgOlH291hJrakECuEaBOa
         I1oQ==
X-Gm-Message-State: APjAAAWdQepnnILHwE8tILTe0s6BYNgBC+asnvqY/4a25aQMQABOSQDV
        +IkyVTzKm1rfNUvd6HhCf+OhDayg8ig=
X-Google-Smtp-Source: APXvYqzODzsaM1aq4feIQfYsxRLRXvV+5Nl/RsGmQqd9AUtp5aYNvfTSQD6LHYKGokZZMY4/NYOYQg==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr40539160wmh.161.1575442216099;
        Tue, 03 Dec 2019 22:50:16 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b5a4:1c65:b54:363a? ([2a01:e34:ed2f:f020:b5a4:1c65:b54:363a])
        by smtp.googlemail.com with ESMTPSA id n14sm5529954wmi.26.2019.12.03.22.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 22:50:15 -0800 (PST)
Subject: Re: [PATCH V3 2/4] thermal/drivers/cpu_cooling: Add idle cooling
 device documentation
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191203093704.7037-1-daniel.lezcano@linaro.org>
 <20191203093704.7037-2-daniel.lezcano@linaro.org>
 <CAP245DV=kd=LdvgZ2x1Q8-ZahpS3423Z9vHXw91N20aQ6DKxAQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7e851d43-ecb5-179a-ebfd-847dffd29636@linaro.org>
Date:   Wed, 4 Dec 2019 07:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAP245DV=kd=LdvgZ2x1Q8-ZahpS3423Z9vHXw91N20aQ6DKxAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Amit,

thanks for the review.


On 04/12/2019 05:24, Amit Kucheria wrote:

[ ... ]

>> +the CPUs will have to wakeup from a deep sleep state.
>> +
>> +     ^
>> +     |
>> +     |
>> +     |-------       -------       -------
>> +     |_______|_____|_______|_____|_______|___________
>> +
>> +      <----->
>> +       idle  <---->
>> +              running
>> +
>> +With the fixed idle injection duration, we can give a value which is
>> +an acceptable performance drop off or latency when we reach a specific
>> +temperature and we begin to mitigate by varying the Idle injection
>> +period.
>> +
> 
> I'm not sure what it the purpose of this statement. You've described
> how the period value starts at a maximum and is adjusted dynamically
> below.

We can have different way to inject idle periods. We can increase the
idle duration and/or keep this duration constant but make a variation of
the period. This statement clarify the method which is the latter
because we want to have a constant latency per period easier to deal with.

>> +The mitigation begins with a maximum period value which decrease when
> 
> Shouldn't the idle injection period increase to get more cooling effect?

The period is the opposite of the frequency. The highest the period, the
lowest the frequency, thus less idle cycles and lesser cooling effect.

>> +more cooling effect is requested. When the period duration is equal to
>> +the idle duration, then we are in a situation the platform can’t
>> +dissipate the heat enough and the mitigation fails. In this case the
>> +situation is considered critical and there is nothing to do. The idle
>> +injection duration must be changed by configuration and until we reach
>> +the cooling effect, otherwise an additionnal cooling device must be
> 
> typo: additional
> 
>> +used or ultimately decrease the SoC performance by dropping the
>> +highest OPP point of the SoC.
>> +
>> +The idle injection duration value must comply with the constraints:
>> +
>> +- It is lesser or equal to the latency we tolerate when the mitigation
> 
> s/lesser/less than/
> 
>> +  begins. It is platform dependent and will depend on the user
>> +  experience, reactivity vs performance trade off we want. This value
>> +  should be specified.
>> +
>> +- It is greater than the idle state’s target residency we want to go
>> +  for thermal mitigation, otherwise we end up consuming more energy.
>> +
>> +Minimum period
>> +--------------
>> +
>> +The idle injection duration being fixed, it is obvious the minimum
> 
> Change to:
> When the idle injection duration is fixed,
> 

The idle duration is always fixed in the cpuidle cooling device, why do
you want to add the sentence above?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


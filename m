Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5182149C99F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 13:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiAZM0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 07:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiAZM0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 07:26:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B23C06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 04:26:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h21so7942221wrb.8
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RTTc+tIxboDX1aAp6zIcb8nku1+Z0jGEe/zvj/3GVws=;
        b=ifdoWnIM4+DPkoukaQV9D4X0bFzOCYQiemnycFMl7Fr6vLCDMvG8RcLtoG3Q4v6M8u
         9gqXE/wlJh4yHZ46KHrf4pjUk6nA6v+ei1qBKCq7m+4LlIE5K84VHb5isEinaKeMPA6e
         xuu8Ij9jLHWTDdIMqGnfAzfRCgSTumD8UYb3OTsfSb4Pgcv1LnGtQPvbJqqUXhcjW1I2
         S9EcEPVn6/hx4UeaHzvZRuf/X6qGoyXHpDv1pDDm2ohOZwdUaDaH4tbeZl6wN5ttRa6x
         fZFTNQ4S6XF+56g65PEHdTQNsTEP8lZJ6HOIDq4aRUkADyWdvE0F64YUW4aqXHLoljFa
         hlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RTTc+tIxboDX1aAp6zIcb8nku1+Z0jGEe/zvj/3GVws=;
        b=c8m98gsWa05soQvb49xPxG/IeZOFk00TjukMUN+OsIP166YKqd8SOpXGyPFuzgdEyb
         lkzGy/mMRPUNpjkkU/QKVXHVJqFOJ7N+dj2inKIBbXOmVmEy+WWSLfrymsch6u6MQE4u
         sY644L/Nzl5RO8rju3ptRr8Ia+F1vaMnwTlec8qaYgzad4Ro0SOaZBSLoSIsyzgo528c
         OkwX5EPOjCyqbalpTGpDvZtHr6O5ijUls82B9z6OjEDCC6yvh7aLEv0Lu9eSs545Oe6X
         CY8RIkSvMaeY7QYacqGC66irLjrw/IXJOhhWGeA2kY+eP8tZ917/gw+jg6FMwNimi5Li
         cEfA==
X-Gm-Message-State: AOAM530Tqvdc2TKQcx77jl9IL+jMm1faFEwO9Yw+DacRpsh+Mqdl0zNg
        +wNMMJRw5lyw5ad2VQPZ02HL4w==
X-Google-Smtp-Source: ABdhPJxbZEHuj6ajYtjPTlbiEw4+WdhYMQwvbBKCrW7Ge5qMW7KY/m/LBunO3t7fUhjHvvf9aIM/NQ==
X-Received: by 2002:adf:9e49:: with SMTP id v9mr20989963wre.469.1643200004873;
        Wed, 26 Jan 2022 04:26:44 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e? ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.googlemail.com with ESMTPSA id g7sm4009602wmq.28.2022.01.26.04.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 04:26:44 -0800 (PST)
Subject: Re: (subset) [PATCH 1/3] ARM: dts: exynos: drop old thermal
 properties from Exynos4210
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
 <164313029072.79782.14492454091056440886.b4-ty@canonical.com>
 <c4a6d5a4-647a-f80c-e487-a5434e744bae@linaro.org>
 <CA+Eumj6rUZ=e6oOZyRMEEoXn2uh0FpuUQbJaT3rsX3rhXT67pQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8fba22fc-3fc1-a55e-9926-7f008ac24925@linaro.org>
Date:   Wed, 26 Jan 2022 13:26:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CA+Eumj6rUZ=e6oOZyRMEEoXn2uh0FpuUQbJaT3rsX3rhXT67pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/01/2022 13:20, Krzysztof Kozlowski wrote:
> On Wed, 26 Jan 2022 at 12:57, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 25/01/2022 18:04, Krzysztof Kozlowski wrote:
>>> On Sat, 22 Jan 2022 14:25:52 +0100, Krzysztof Kozlowski wrote:
>>>> The samsung,tmu_gain and samsung,tmu_reference_voltage properties of
>>>> Exynos Thermal Management Unit driver are not used since April 2018.
>>>> They were removed with commit fccfe0993b5d ("thermal: exynos: remove
>>>> parsing of samsung,tmu_gain property") and commit 61020d189dbc
>>>> ("thermal: exynos: remove parsing of samsung, tmu_reference_voltage
>>>> property"), so drop them also from Exynos4210 DTS.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/3] ARM: dts: exynos: drop old thermal properties from Exynos4210
>>>       commit: e20bd06fc421fba4099be51d3f56b9b1741b499b
>>>
>>
>> I guess up to me to pick 2 and 3
> 
> Yes, please.

Ok, I'll wait for Rob's ack

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

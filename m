Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0903F4DDE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhHWP5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhHWP5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 11:57:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5B2C061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 08:57:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h13so27009062wrp.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+FLR6Z8/mDAczEMpEGS5kn4L3ds8qzE/r6tJ5Ts7c48=;
        b=RgMiY/yz7J1NIo6n25Nsp/G0+34xdlTC3cItRtlYPa5bZ1YMR3QsyZtfgDApkvKKG4
         OXPmDfUltBnNGrqmrFGseDz0DsKEHVtlkzkSHzjI1NeW+8rDSs5Tmz5qCiXxmoXYi++C
         NNc6+hphK7QoqfYfqR9IP6jdk/59R43qtx54hCpp/gQ1KfIwqOS3SuHG9CTR2uByFY9N
         Jwdvjsg7CJw95V/+2kONM0jr0T0qj6NJx2a6NAqZbtrHWuLnMFNYvZj/3T7a4tYtpwXE
         lueV9Qy0/cRwZDDrYlxtgKoiUBO/1UuYxsStc/+BeADJWbznQ5f6qke+iS/aFBUrOFTd
         5kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+FLR6Z8/mDAczEMpEGS5kn4L3ds8qzE/r6tJ5Ts7c48=;
        b=CVOnmYN2qDKufAQ2qdhfTMjTwa2Vltd/pVHfWQzku9q5A0w+lObG+WJ7EfsCn0I+ZG
         T68k0yPo9ltFiUppvgi4K1s8+CyDYW2EjN8wE3cVaVXehuhWqIyAeemIS7DeAwsaUWpB
         S2HR1yjldCFuMzcygtKchlltw4ZqghwtDFJmFiN68Y6fKuuIOHuLt0w650iQVE8oQHRk
         s62hsRGBRE5Am/xHAHnbBKpHIObnMHhtC8Oz0VIdPTiBrDCfQiMbNG5RYfjK3qGsuQpM
         Du3kM4g/iOxT2K9PpQ5iBxf/7M8ptSWJ6KJi99mP4t+enmNDha35LRQqh5UpV5tz+7bE
         VU3g==
X-Gm-Message-State: AOAM530EU6lk1+tvwfxtec3R65KWRHYtL1kLQuAN1TJTpT9WPsDOYLsr
        kA/mZTgrnkDiOd2fIjIM6eWqJw==
X-Google-Smtp-Source: ABdhPJyEiMZ8I45+i9M5hEIBjY9DhfcLS2W27AjdGlKqHppruxwsdc7R3k+VNNPQ1WD/5y6thnGWAg==
X-Received: by 2002:adf:dcc5:: with SMTP id x5mr14267099wrm.385.1629734224261;
        Mon, 23 Aug 2021 08:57:04 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:fe2d:133f:1574:bbe? ([2a01:e34:ed2f:f020:fe2d:133f:1574:bbe])
        by smtp.googlemail.com with ESMTPSA id l2sm15100915wrx.2.2021.08.23.08.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 08:57:03 -0700 (PDT)
Subject: Re: [Patch v5 2/6] thermal: qcom: Add support for LMh driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        rui.zhang@intel.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        robh+dt@kernel.org, steev@kali.org, tdas@codeaurora.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-3-thara.gopinath@linaro.org>
 <fcbb6d64-7e39-7f03-e76c-512946124777@linaro.org> <YSO5Njg3DXo64InF@ripper>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a216c89d-6cd5-326d-f203-f48caaf2a096@linaro.org>
Date:   Mon, 23 Aug 2021 17:57:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSO5Njg3DXo64InF@ripper>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Bjorn,

On 23/08/2021 17:05, Bjorn Andersson wrote:
> On Sat 21 Aug 02:41 PDT 2021, Daniel Lezcano wrote:
> 
>>
>> Hi Thara,
>>
>> On 09/08/2021 21:16, Thara Gopinath wrote:
>>> Driver enabling various pieces of Limits Management Hardware(LMh) for cpu
>>> cluster0 and cpu cluster1 namely kick starting monitoring of temperature,
>>> current, battery current violations, enabling reliability algorithm and
>>> setting up various temperature limits.
>>>
>>> The following has been explained in the cover letter. I am including this
>>> here so that this remains in the commit message as well.
>>>
>>> LMh is a hardware infrastructure on some Qualcomm SoCs that can enforce
>>> temperature and current limits as programmed by software for certain IPs
>>> like CPU. On many newer LMh is configured by firmware/TZ and no programming
>>> is needed from the kernel side. But on certain SoCs like sdm845 the
>>> firmware does not do a complete programming of the h/w. On such soc's
>>> kernel software has to explicitly set up the temperature limits and turn on
>>> various monitoring and enforcing algorithms on the hardware.
>>>
>>> Tested-by: Steev Klimaszewski <steev@kali.org> # Lenovo Yoga C630
>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>
>> Is it possible to have an option to disable/enable the LMh driver at
>> runtime, for instance with a module parameter ?
>>
> 
> Are you referring to being able to disable the hardware throttling, or
> the driver's changes to thermal pressure?

The former.

> I'm not aware of any way to disable the hardware. I do remember that
> there was some experiments done (with a hacked up boot chain) early on
> and iirc it was concluded that it's not a good idea.

My objective was to test the board with the thermal framework handling
the mitigation instead of the hardware.

I guess I can set the hardware temperature higher than the thermal zone
temperature.

On which sensor the lmh does refer to ? The cluster one ?

(by the way the thermal zone temperatures per core are lower by 5°C than
the hardware mitigation ? is it done on purpose ?)

> Either way, if there is a way and there is a use for it, we can always
> add such parameter incrementally. So I suggest that we merge this as is.

Yes, that was for my information. It is already merged.

Thanks

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

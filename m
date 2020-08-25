Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962882515AE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 11:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgHYJoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 05:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbgHYJof (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 05:44:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7FFC061574
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 02:44:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h15so5288143wrt.12
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ujkEUSo+hKd0F+n+n+4eow5fQiAPWkhZFl/qY+hEm7I=;
        b=rXlaG4lBk/9ZFQ80LD+zjXCgcILpe2q3j7aSpFOOGyjedptgjQU5mRZrzy6a23UqiI
         bnM4EzVnnxX90gRM6vUv2uga1xs3JH3eXF+My1IkgkO5PR7XUki0KTgOHXQBPBoZON01
         6wPPHiMKU7a2l1F1ZU0T63cr8N908vdaFBBKmpSuf7nmcI1gkdfeM4AfJB+qFW8P0bMM
         lTuNAH9Csf5IeDvgHVHClgVHGNIHDQRvMPYoI3MSFBFun8+oUAU3tv+5pj8m7LnQvig0
         kFrauL6FQC6Z9r25I0NbgRbrNjlHCBlQdUkGyf096c+NA6ai0+EGhV4+PDy0ZteQdrFh
         AsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ujkEUSo+hKd0F+n+n+4eow5fQiAPWkhZFl/qY+hEm7I=;
        b=PaQta5K7BlpNhVwqdr+PwraDI6A7vJHEjX0u0mE0WOSSsxT3vpV7eV5lWXDw6JoYQo
         AWuVvCCy3yMaZuwKieX8OnR/hiZ2jijxQFlEfTLRju3o0LcxXtIvuF4rQNEnF9Jr75GV
         P4O2WyA+pI/kPEij4h3I7Lg4tZekOPFl9mMSRCD9JPBa3tkEPbUmYoiQ5Ztvb/s3casW
         OgNnng9ocssHBX1VY5V10cP7kMuBH1QOrNAJLlw07//GrgHGDm4okdiV9T1NJ1ZQ5STM
         1+MytJ8IuEa04wU3CLlWzgSyylgrl9wS7vc/yCIB56a5L+il4Six28gSd2IgdcRnpevj
         8gAw==
X-Gm-Message-State: AOAM5309co6BcTk3vIPqgpv1U7q+MV5u3yyQ/Zz1iRR0x9WhjUHBi0AW
        k897hnxRMRvAC2AQH2cHyyTiXA==
X-Google-Smtp-Source: ABdhPJz7G7kxb5c0oWnqP8sVrGmfNv6GBtMKj9praqksNl3MmSemmfB6dRZWvkyjd6gM3062nySHqw==
X-Received: by 2002:a05:6000:124f:: with SMTP id j15mr9545856wrx.287.1598348673000;
        Tue, 25 Aug 2020 02:44:33 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:30ce:e04c:9454:bbf8? ([2a01:e34:ed2f:f020:30ce:e04c:9454:bbf8])
        by smtp.googlemail.com with ESMTPSA id z8sm4516749wmf.10.2020.08.25.02.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 02:44:32 -0700 (PDT)
Subject: Re: [PATCH v1] thermal/of: Introduce k-po, k-pu and k-i for a thermal
 zone
To:     Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>
Cc:     Finley Xiao <finley.xiao@rock-chips.com>, heiko@sntech.de,
        rui.zhang@intel.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, huangtao@rock-chips.com,
        tony.xie@rock-chips.com, cl@rock-chips.com
References: <20200811123115.8144-1-finley.xiao@rock-chips.com>
 <20200824230956.GA3500214@bogus>
 <c3f54e18-8683-8bd9-90fa-e3465cddf8e8@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <13b84e7e-adfe-5939-e78d-0a20fce0a92e@linaro.org>
Date:   Tue, 25 Aug 2020 11:44:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c3f54e18-8683-8bd9-90fa-e3465cddf8e8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/08/2020 10:25, Lukasz Luba wrote:
> Hi Rob,
> 
> On 8/25/20 12:09 AM, Rob Herring wrote:
>> On Tue, Aug 11, 2020 at 08:31:15PM +0800, Finley Xiao wrote:
>>> The default value for k_pu is:
>>>      2 * sustainable_power / (desired_temperature - switch_on_temp)
>>> The default value for k_po is:
>>>      sustainable_power / (desired_temperature - switch_on_temp)
>>> The default value for k_i is 10.
>>>
>>> Even though these parameters of the PID controller can be changed
>>> by the following sysfs files:
>>>      /sys/class/thermal/thermal_zoneX/k_pu
>>>      /sys/class/thermal/thermal_zoneX/k_po
>>>      /sys/class/thermal/thermal_zoneX/k_i
>>>
>>> But it's still more convenient to change the default values by
>>> devicetree,
>>> so introduce these three optional properties. If provided these
>>> properties,
>>> they will be parsed and associated with the thermal zone via the thermal
>>> zone parameters.
>>>
>>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>>> ---
>>>   Documentation/devicetree/bindings/thermal/thermal.txt | 14
>>> ++++++++++++++
>>
>> Bindings should be a separate file and this one is a DT schema now.
>>
>>>   drivers/thermal/thermal_of.c                          |  7 +++++++
>>>   2 files changed, 21 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt
>>> b/Documentation/devicetree/bindings/thermal/thermal.txt
>>> index f78bec19ca35..ebe936b57ded 100644
>>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>>> @@ -165,6 +165,20 @@ Optional property:
>>>               2000mW, while on a 10'' tablet is around
>>>               4500mW.
>>>   +- k-po:            Proportional parameter of the PID controller when
>>> +            current temperature is above the target.
>>> +  Type: signed
>>> +  Size: one cell
>>> +
>>> +- k-pu:            Proportional parameter of the PID controller when
>>> +            current temperature is below the target.
>>> +  Type: signed
>>> +  Size: one cell
>>> +
>>> +- k-i:            Integral parameter of the PID controller.
>>> +  Type: signed
>>> +  Size: one cell
>>
>> What's PID?
>>
>> I know nothing about the sysfs params, but the binding needs to stand on
>> it's own and needs enough detail to educate me.
> Sorry for the delay, I missed that patch.
> These parameters are the coefficients for the
> Proportional-Integral-Derivative (PID) controller [1], which is the
> core of the Intelligent Power Allocation (IPA) thermal governor.

Just a few words to elaborate a bit for Rob who may not have time to
digest the whole concept from Wikipedia :)

The PID is an regulation loop where the input is compared to the output.

For example when driving a car and you aim a speed cruise of 90km/h. You
press the accelerator and watch the current speed. The smaller the
current speed is, the stronger you will push the accelerator. And the
closer to the cruise speed the car is, the lesser you push the
accelerator until the car stabilize to the cruise to speed.

The k-* describes how strong you push the accelerator and release it.

In the thermal framework, that has an impact on how brutal the
mitigation acts and depending on them it results in a flat temperature
curve or a sawtooth aspect.

These coefficient depends on the ambient temperature (casing, room
temperature), the heat sink and the load. Depending on the use cases,
you may want to change their values at runtime.

From my POV, setting these values in the DT does not really make sense.

It would make much more sense to have the thermal specifications of the
board (heat sink capacity, resistivity, max temperature or TDP), so from
there we should be able to compute anything related to the thermal
profile and configure from the kernel.


> Only IPA uses them, thus I don't think the governors parameters:
> k-po, k-pu, k-i
> should be part of the DeviceTree. I haven't seen such governors
> tunnables in the DT, please point me if they exist somewhere.
> 
> Do you think Rob they might be specified in the DT?
> 
> Regards,
> Lukasz
> 
> [1] https://en.wikipedia.org/wiki/PID_controller


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

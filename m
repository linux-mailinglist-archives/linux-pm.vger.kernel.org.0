Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1072CDADD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 17:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgLCQKc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 11:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLCQKa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 11:10:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDCC061A4F
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 08:09:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 64so2405942wra.11
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 08:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Egp56+bWfac+3k12p/dmisOXz1k0Ww/MYP5K1gwdQ58=;
        b=IbKIdizWv0uaVk1vhtYurj8fNhCBBnAN4q2j0WS9KRqrF2U6oz3IrfaUHX1Qtrfx3i
         ogaKErJH4njzq3nwtbFQAWMx40OAREHKSdnaxxaEDqG2eqlKRM9i4+OYUz8q0pdywmzJ
         Y+u4VUxK5hAvJpJOhlVNgAbvhzDCmnJAWDGkOUq5QOCsK5EAzxttQ+a5nGdZch+09os6
         py9ikEmpyXVadNtvdOOw/LGKP7EbI0dnf75bFCMvS+ePPdg7udWoXco1Ux1VHxt9CuOW
         v5phtZ8cA4Ye1+BWlVYKx+U7T0+l9yZAAsPVaAEbXQiHo6AFEmiNfFlwvufw2ewYAap8
         Z71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Egp56+bWfac+3k12p/dmisOXz1k0Ww/MYP5K1gwdQ58=;
        b=XL7ntC2+PAG5DQ+AHH+FYUeOFrghmTCnDPUDq74PujORsS03REpdUYBvcHW+KDgUa9
         2ccZMG++16AVtAiLctBSGFJDAnGa723FBP2vM68tkZn8NAN9fsSOFl/A6qXRiAGG9G/A
         0RlUsfjLKHuU4S56VeRrOxEaxrl/PX6CruavybhCm0KF39wbfc9KyvWOUiqAJxRM+KPb
         otevbwpQB8x1tcbfEU40q3J4pGhALONworZBBf1J1Ko/UdUzkHGd8FM99+/I7XkJx8eE
         hvd/LCDynvrsPaYhAgMdXqoJbB2STbdSZ+1ILST5RvIAYb0d01g2Zuyy+zk4MH8jQhg8
         Mfeg==
X-Gm-Message-State: AOAM533ta72ZzxAASo+XVroY7V/FdYW4dUmDtT65/uy8hC08snTQkzae
        eKehlY4jTujb6o2Bem+4Ev4QMQ==
X-Google-Smtp-Source: ABdhPJx+gI/bhjY3qusZeY90Fqj3HltB+Pt0HmNnq6N7kRujX0WWTNyi+4zTbYCRxzLDMVulGuZCyA==
X-Received: by 2002:a5d:5689:: with SMTP id f9mr4547592wrv.181.1607011788834;
        Thu, 03 Dec 2020 08:09:48 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9cff:9584:adb2:6288? ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.googlemail.com with ESMTPSA id o83sm2009235wme.21.2020.12.03.08.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:09:48 -0800 (PST)
Subject: Re: [PATCH v2 2/5] thermal: devfreq_cooling: get a copy of device
 status
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, ionela.voinescu@arm.com
References: <20201118120358.17150-1-lukasz.luba@arm.com>
 <20201118120358.17150-3-lukasz.luba@arm.com>
 <5d4743b9-5b2f-8494-8d10-6a5fd2c0fdfd@linaro.org>
 <d9906ed8-e3bf-5e42-2e43-09071848ae48@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <224c6b9b-977a-d553-f22b-2056223a84bc@linaro.org>
Date:   Thu, 3 Dec 2020 17:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d9906ed8-e3bf-5e42-2e43-09071848ae48@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/12/2020 16:38, Lukasz Luba wrote:
> 
> 
> On 12/3/20 1:09 PM, Daniel Lezcano wrote:
>> On 18/11/2020 13:03, Lukasz Luba wrote:
>>> Devfreq cooling needs to now the correct status of the device in order
>>> to operate. Do not rely on Devfreq last_status which might be a stale
>>> data
>>> and get more up-to-date values of the load.
>>>
>>> Devfreq framework can change the device status in the background. To
>>> mitigate this situation make a copy of the status structure and use it
>>> for internal calculations.
>>>
>>> In addition this patch adds normalization function, which also makes
>>> sure
>>> that whatever data comes from the device, it is in a sane range.
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>   drivers/thermal/devfreq_cooling.c | 52 +++++++++++++++++++++++++------
>>>   1 file changed, 43 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/thermal/devfreq_cooling.c
>>> b/drivers/thermal/devfreq_cooling.c
>>> index 659c0143c9f0..925523694462 100644
>>> --- a/drivers/thermal/devfreq_cooling.c
>>> +++ b/drivers/thermal/devfreq_cooling.c
>>> @@ -227,20 +227,46 @@ static inline unsigned long
>>> get_total_power(struct devfreq_cooling_device *dfc,
>>>                                      voltage);
>>>   }
>>>   +static void _normalize_load(struct devfreq_dev_status *status)
>>> +{
>>> +    /* Make some space if needed */
>>> +    if (status->busy_time > 0xffff) {
>>> +        status->busy_time >>= 10;
>>> +        status->total_time >>= 10;
>>> +    }
>>> +
>>> +    if (status->busy_time > status->total_time)
>>> +        status->busy_time = status->total_time;
>>
>> How the condition above is possible?
> 
> They should, be checked by the driver, but I cannot trust
> and have to check for all corner cases: (div by 0, overflow
> one of them, etc). The busy_time and total_time are unsigned long,
> which means 4B on 32bit machines.
> If these values are coming from device counters, which count every
> busy cycle and total cycles of a clock of a device running at e.g.
> 1GHz they would overflow every ~4s.

I don't think it is up to this routine to check the driver is correctly
implemented, especially at every call to get_requested_power.

If the normalization ends up by doing this kind of thing, there is
certainly something wrong in the 'status' computation to be fixed before
submitting this series.


> Normally IPA polling are 1s and 100ms, it's platform specific. But there
> are also 'empty' periods when IPA sees temperature very low and does not
> even call the .get_requested_power() callbacks for the cooling devices,
> just grants max freq to all. This is problematic. I am investigating it
> and will propose a solution for IPA soon.
> 
> I would avoid all of this if devfreq core would have default for all
> devices a reliable polling timer... Let me check some possibilities also
> for this case.

Ok, may be create an API to compute the 'idle,busy,total times' to be
used by the different the devfreq drivers and then fix the overflow in
this common place.

>>> +    status->busy_time *= 100;
>>> +    status->busy_time /= status->total_time ? : 1;
>>> +
>>> +    /* Avoid division by 0 */
>>> +    status->busy_time = status->busy_time ? : 1;
>>> +    status->total_time = 100;
>>
>> Why not base the normalization on 1024? and use an intermediate u64.
> 
> You are the 2nd reviewer who is asking this. I tried to keep 'load' as
> in range [0, 100] since we also have 'load' in cpufreq cooling in this
> range. Maybe I should switch to 1024 (Ionela was also asking for this).

Well it is common practice to compute normalization with 1024 because
the division is a bit shift and the compiler optimize the code very well
with that value.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

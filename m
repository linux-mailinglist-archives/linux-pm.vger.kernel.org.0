Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3767832D820
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhCDQyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbhCDQyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 11:54:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2815C061760
        for <linux-pm@vger.kernel.org>; Thu,  4 Mar 2021 08:53:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a18so20201560wrc.13
        for <linux-pm@vger.kernel.org>; Thu, 04 Mar 2021 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YnxlDtU5po5D1M53NldIE72sMInCUbrZRLnykBeu2V8=;
        b=Ewxi+OReE6dJAiv1zXYkq05geSl/fq+jZkRgzrMwoyzv7/mX7eQzNkoXLfZA/H4WjA
         dLxCRUQXjLaUaurQNnE2V1uuSVtL1ssUBtAdfk47+VjVE3TodqBAoyI+HNZr9jaugwih
         QozPefxrDjjzljWSRoqtM5xVlGU9Pye4vHHgjW0WwQ5jmtTxzIbIessoty315fsV3Pto
         3rUuogs9lyEX7c3FT883rgCuhQlAV95l3Ki/0K1GkqZhT2pUmINFxC/lBZLVmiOR6r0I
         /mSml0hG8PHwm/dAmJQhv/t8QNpecklP1K6I1reeFu194Rh1icR2BB1MMK/v7koexmb3
         k6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YnxlDtU5po5D1M53NldIE72sMInCUbrZRLnykBeu2V8=;
        b=fPHtzJYfe/t97e5bGfz21MSYt6sguoK83IuaRiNz1910GkwPxZLCbhp8lBOED6i6nL
         2+dX/4yWa4iFLGR1w1wem3sit4SLLCUaqe/QHhraciLByVSVPhXNGxF+WUY7MpqxoKD2
         0G5nesBVMEMLXOIk+02hzzB00CqaT9aBxcR981ehpTh54zruwa4w4wHdOydrCTybOgJX
         rMJ9T2/tTwuNN7IZ5Dn2QS6sU6DTSlKawZwtIPPESJCwhXc7s2lrVKnGAOYziPyvAxI9
         yOoszpigWh1DCVzJgSSDU4p+EggypSQe9HNXOXnCbtBxMZTM+M/dqCnWtp81ISo/pNWI
         XuvQ==
X-Gm-Message-State: AOAM53336HE3ZIGOyg2DMUzJetXPiPcDsQLN1KNCsIiYaoPKFm2/x3eI
        CJ/3s3yZ2YRYECG//yENkINcUQ==
X-Google-Smtp-Source: ABdhPJxucLioKZo95wCuntF7BE0hNv7s/6tGhLvI6FsbewLBgkboHJnD6mezrJaZmVK15Kbq98zepg==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr4922891wrd.424.1614876808222;
        Thu, 04 Mar 2021 08:53:28 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id b15sm36807595wrr.47.2021.03.04.08.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 08:53:27 -0800 (PST)
Subject: Re: [PATCH] devfreq: Register devfreq as a cooling device
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     cwchoi00@gmail.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:DRM DRIVERS FOR LIMA" <dri-devel@lists.freedesktop.org>,
        "moderated list:DRM DRIVERS FOR LIMA" <lima@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
References: <20210304125034.28404-1-daniel.lezcano@linaro.org>
 <5f06e0c5-b2d9-5e11-01b6-fdd0dac635a7@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8d153937-c5fc-1de2-d510-d3f91f7a9724@linaro.org>
Date:   Thu, 4 Mar 2021 17:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f06e0c5-b2d9-5e11-01b6-fdd0dac635a7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,

thanks for commenting this patch,

On 04/03/2021 14:47, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 3/4/21 12:50 PM, Daniel Lezcano wrote:
>> Currently the default behavior is to manually having the devfreq
>> backend to register themselves as a devfreq cooling device.
>>
>> There are no so many and actually it makes more sense to register the
>> devfreq device when adding it.
>>
>> Consequently, every devfreq becomes a cooling device like cpufreq is.
>>
>> Having a devfreq being registered as a cooling device can not mitigate
>> a thermal zone if it is not bound to this one. Thus, the current
>> configurations are not impacted by this change.
> 
> There are also different type of devices, which register into devfreq
> framework like NoC buses, UFS/eMMC, jpeg and video accelerators, ISP,
> etc.
> In some platforms there are plenty of those devices and they all would
> occupy memory due to private freq_table in devfreq_cooling, function:
> devfreq_cooling_gen_tables().
> 
> IIRC in OdroidXU4 there are ~20 devfreq devs for NoC buses.

I'm curious, do you have a pointer to such kernels having all those
devfreq ?

> It's true that they will not affect thermal zones, but unnecessarily,
> they all will show up in the /sys/class/thermal/ as
> thermal-devfreq-X
>
>
> IMO the devfreq shouldn't be tight with devfreq cooling thermal.

The energy model is tied with a cooling device initialization.

So if we want to do power limitation, the energy model must be
initialized with the device, thus the cooling device also.

That is the reason why I'm ending up with this change. Chanwoo
suggestion makes sense and that will allow to move the initialization to
devfreq which is more sane but it does not solve the initial problem
with the energy model.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

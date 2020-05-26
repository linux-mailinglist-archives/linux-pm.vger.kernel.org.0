Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1324B1E2579
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgEZPaB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgEZPaA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 11:30:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076EEC03E96D;
        Tue, 26 May 2020 08:30:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so6747740wru.6;
        Tue, 26 May 2020 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5BPymIBZxiXUqqTT3U9Z1NeZW1/IDkJhQmzDdmvJt0I=;
        b=BoN2nxXuqeOcT3KmiqCiW7UQMyQSLNw99rEXvwyx+Zod2+GM4/HoJCCD953KdicI8j
         JOizdLhJDvy/zf1N9Nht7gLUTjU0OjsTX3ksW45NoczGgL/032dd0KCIeugh/hI9hLYP
         mwJlY7z/3LRvEVs7ea0bIRxAXX6aJqBcZ0hlk2anJe64b2YXTZaHDi1dQ1i65wSBrbAn
         iqRxtQcSvlEpP8XvIm1UZvXN/mM3eZsSBrLF5JWbd4vevPZkS/zWq0qMTfNXdmhy4gem
         xPaBHYZ8DAsCf2OT8/LpDmOvw6R65etEt8OFHKae6IMLZ1eMeiYIRsnn5aoa3TkIYxSg
         jB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5BPymIBZxiXUqqTT3U9Z1NeZW1/IDkJhQmzDdmvJt0I=;
        b=GZslCP0IwKjL8eVgNfc0JeM/20YG+dJvL04mWVqfSkAPL+2mC7DmQZXNHEz9qcjVXw
         tPxXetVpBSTWVYuLrue6IPhDhP6CyZV2g+DBMrOWDuR/Ol/9Bh84V1Cf/6+YArGobIdv
         3g2T4HXoocDY2haoqLW6jMxlHAk+euJwBB5WW7NDP4Uobq5o7nEDIMc1mDKSthUdbwm5
         sx2MEQQAWgy7PVFRBjMRO2brXgampObt8kC3/jeI63sBHAC4P0RudFYl0vYuztHqsjkT
         nVnNgo3EPiJ3NqZ0wB5vpzsvnVDO+bO3NI1Gsz3zdLz2IIgEqx5/YhVDpzAB4m9bu7cY
         VBsQ==
X-Gm-Message-State: AOAM531qkAl85EYtHOko36BjESIbK2Aa6nHRomfw+xMaonGwpbg70/PZ
        pEQYrZH8/rNjuhvUZqgR2+A=
X-Google-Smtp-Source: ABdhPJyHaM3mUoTord+k9hozkTkhWW6QO/90O4G2+ygztlGLXkjqJSf8bitdmX7pYqgCRTttGThsDg==
X-Received: by 2002:adf:a407:: with SMTP id d7mr11389219wra.368.1590506998679;
        Tue, 26 May 2020 08:29:58 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id n19sm4290wmi.33.2020.05.26.08.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 08:29:58 -0700 (PDT)
Subject: Re: [PATCH v8 3/3] PM / AVS: SVS: Introduce SVS engine
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Angus Lin <Angus.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20200518092403.22647-1-roger.lu@mediatek.com>
 <20200518092403.22647-4-roger.lu@mediatek.com>
 <CAFqH_527ZJEmsvrk-n-uNSc+Bx87ZVppn=rNKDWPGYUuf+gvPA@mail.gmail.com>
 <1590140434.4392.22.camel@mtksdaap41>
 <3b810588-ac4a-7fec-2163-38555dd83928@gmail.com>
 <1590484328.4392.44.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2566c070-1f7c-6c28-81ed-fd3edbc865cc@gmail.com>
Date:   Tue, 26 May 2020 17:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590484328.4392.44.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 26/05/2020 11:12, Roger Lu wrote:
> Hi Matthias,
> 
> Thanks for the feedback.
> 
> On Fri, 2020-05-22 at 17:38 +0200, Matthias Brugger wrote:
>>
>> On 22/05/2020 11:40, Roger Lu wrote:
>>>
>>> Hi Enric,
>>>
>>> On Tue, 2020-05-19 at 17:30 +0200, Enric Balletbo Serra wrote:
>>>> Hi Roger,
>>>>
>>>> Thank you for your patch. I have the feeling that this driver is
>>>> complex and difficult to follow and I am wondering if it wouldn't be
>>>> better if you can send a version that simply adds basic functionality
>>>> for now. Some comments below.
>>>
>>> Thanks for the advices. I'll submit SVS v9 with basic functionality
>>> patch + step by step functionalities' patches. 
>>>
>>>>
>>>> Missatge de Roger Lu <roger.lu@mediatek.com> del dia dl., 18 de maig
>>>> 2020 a les 11:25:
>>>>>
>>>>> The SVS (Smart Voltage Scaling) engine is a piece
>>>>> of hardware which is used to calculate optimized
>>>>> voltage values of several power domains,
>>>>> e.g. CPU/GPU/CCI, according to chip process corner,
>>>>> temperatures, and other factors. Then DVFS driver
>>>>> could apply those optimized voltage values to reduce
>>>>> power consumption.
>>>>>
>>>>> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
>>>>> ---
>>>>>  drivers/power/avs/Kconfig     |   10 +
>>>>>  drivers/power/avs/Makefile    |    1 +
>>>>>  drivers/power/avs/mtk_svs.c   | 2119 +++++++++++++++++++++++++++++++++
>>>>>  include/linux/power/mtk_svs.h |   23 +
>>>>>  4 files changed, 2153 insertions(+)
>>>>>  create mode 100644 drivers/power/avs/mtk_svs.c
>>>>>  create mode 100644 include/linux/power/mtk_svs.h
>>>>>
>>>>> diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
>>>>> index cdb4237bfd02..67089ac6040e 100644
>>>>> --- a/drivers/power/avs/Kconfig
>>>>> +++ b/drivers/power/avs/Kconfig
>>>>> @@ -35,3 +35,13 @@ config ROCKCHIP_IODOMAIN
>>>>>           Say y here to enable support io domains on Rockchip SoCs. It is
>>>>>           necessary for the io domain setting of the SoC to match the
>>>>>           voltage supplied by the regulators.
>>>>> +
>>>>> +config MTK_SVS
>>>>> +       bool "MediaTek Smart Voltage Scaling(SVS)"
>>>>
>>>> Can't be this a module? Why? In such case, you should use tristate option
>>>
>>> Generally, MTK_SVS is needed in MTK SoC(mt81xx) products. So, we don't provide
>>> module option in config. If, somehow, SVS isn't needed, we suggest
>>> CONFIG_MTK_SVS=n to be set.
>>>
>>
>> The question here is if it needs to be probed before we probe the modules. If
>> not, we should add a Kconfig option for MT81xx SoCs to select MTK_SVS.
> 
> Excuse me to make you confuse. MT81xx SoCs is the subset MTK ICs that
> will use CONFIG_MTK_SVS. In other words, CONFIG_MTK_SVS will be used
> with other MTK ICs as well. So, MTK_SVS is the general naming for MTK IC
> to enable SVS power feature. Anyway, back to Enric's question, I'll make
> MTK_SVS become a tristate feature in the next patch. Thanks.
> 
>>
[...]
>>>>> +
>>>>> +static const u32 svs_regs_v2[] = {
>>>>
>>>> Is this SoC specific or shared between SoCs?
>>>
>>> Shared between SoCs. Some SVS in MTK SoCs use v2 register map.
>>>
>>
>> And which silicon uses v1 then? Is v2 a MediaTek internal naming you want to keep?
> 
> 1. MT8173 IC uses v1 register map. 
> 2. Yes, I'll keep v2 postfix.
> 

Sounds good, thanks for clarification.

Regards,
Matthias

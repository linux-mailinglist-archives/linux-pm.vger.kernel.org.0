Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B616E34D420
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhC2Pjb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC2PjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 11:39:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD3C061574;
        Mon, 29 Mar 2021 08:38:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j9so11603437wrx.12;
        Mon, 29 Mar 2021 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S1lZrYa4RgkGtFeObfBwaH9rh2684UNbDqMBiRRBdv8=;
        b=odZbbv5rUQgy7f+7QYYAnbvqRWxOrNggdNRJaRcxvSBFtdAP0l3Efa7CY2YrLQREba
         06oUdKMVlKGELOWCJG/zQendxvtiLaXqHp1tQhetrGnCyPhsnzqccznG7mNIUaasgM0a
         I2X44glX8CM6VUZ1NWnJRlx8dmMyJ31mvti/HH56/OLbpWwheX1y+6d2pfGp0SQdcT1c
         oxuE9/W9tpDT7/zdB/KFhBtyzIpi6E56HOYO9u9YZpz+1IvahHkH+YOW3Y1/gnCOPzcW
         fzU/tUv0vnwvjXJnHeF73IiKs8lvJwEdCKPNzFYK8do1GD4cxfabJ1YTW3VC+IB9Z3gd
         GBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S1lZrYa4RgkGtFeObfBwaH9rh2684UNbDqMBiRRBdv8=;
        b=DxhB+FzYmN5QyXejEVTEWo2cCHQh+wiJd0eemICuIis1Zh0NiIvaliaEvRffEtYa9P
         vqkAe5U4bXuMSlKMVwjxl3fNj8msF9SPTqMjGBAhkX4poraFMCOtgd8wttGl522l8siA
         PQBYJXjWuruEb8EAkkbDvtA3AE1I8gx2+860RnSB3ECgF8eKOT8VWK5TU2c0C6l5sWB9
         svyiMyWrrDlEZ0x827SYNyjJgATLLAiuFajeWB39+6Yl1Czwj9sVh1H+UyhqbZ6fZtVG
         kEOlM47Me9jVRWxsg6K+5FyUpX7RqGLwPxM5nhxgQIysdwGMPtg1kVjueXlrc+XN/0vD
         kAyg==
X-Gm-Message-State: AOAM531UtPcP+a8WoUy8SgC2hgYWdAeAfSgx0eQkJG+YInTlCNrPN9Xn
        njCGTEPZxDE0k+81P+THbpM=
X-Google-Smtp-Source: ABdhPJyya11CowoA7VEiWPCnbakkjzZDIiLpDg04ysh56Z7tU0L0hIE/aPfdwMl/6YmU2Gjo2Shg0Q==
X-Received: by 2002:adf:8523:: with SMTP id 32mr15610137wrh.375.1617032338241;
        Mon, 29 Mar 2021 08:38:58 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id p16sm34875137wrt.54.2021.03.29.08.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 08:38:57 -0700 (PDT)
Subject: Re: [PATCH v7 04/11] mfd: mt6360: Combine mt6360 pmic/ldo resources
 into mt6360 regulator resources
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     sre@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
 <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com>
 <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
 <20210115073241.GC3975472@dell>
 <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <496b647d-35e4-59c1-71ad-f3cc6ffee287@gmail.com>
Date:   Mon, 29 Mar 2021 17:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 02/03/2021 08:16, Gene Chen wrote:
> Lee Jones <lee.jones@linaro.org> 於 2021年1月15日 週五 下午3:32寫道：
>>
>> On Fri, 15 Jan 2021, Gene Chen wrote:
>>
>>> Matthias Brugger <matthias.bgg@gmail.com> 於 2021年1月12日 週二 下午8:32寫道：
>>>>
>>>>
>>>>
>>>> On 12/11/2020 11:39, Gene Chen wrote:
>>>>> From: Gene Chen <gene_chen@richtek.com>
>>>>>
>>>>> Combine mt6360 pmic/ldo resources into mt6360 regulator resources
>>>>> to simplify the similar resources object.
>>>>>
>>>>> Signed-off-by: Gene Chen <gene_chen@richtek.com>
>>>>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>>>> ---
>>>>>  drivers/mfd/mt6360-core.c | 11 +++--------
>>>>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
>>>>> index 692e47b..5119e51 100644
>>>>> --- a/drivers/mfd/mt6360-core.c
>>>>> +++ b/drivers/mfd/mt6360-core.c
>>>>> @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
>>>>>  };
>>>>>
>>>>> -static const struct resource mt6360_pmic_resources[] = {
>>>>> +static const struct resource mt6360_regulator_resources[] = {
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
>>>>> @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
>>>>> -};
>>>>> -
>>>>> -static const struct resource mt6360_ldo_resources[] = {
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
>>>>>       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
>>>>> @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
>>>>>                   NULL, 0, 0, "mediatek,mt6360-chg"),
>>>>>       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
>>>>>                   NULL, 0, 0, "mediatek,mt6360-led"),
>>>>> -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
>>>>> -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
>>>>> -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
>>>>> -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
>>>>> +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
>>>>> +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
>>>>
>>>> As discussed with the MFD maintainer [1], the regulator (and probably all cells)
>>>> shouldn't have a DT binding.
>>>>
>>>> So please send a new version which fixes that.
>>>>
>>>> Regards,
>>>> Matthias
>>>>
>>>> [1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@sirena.org.uk/
>>
>> I don't think Mark is correct here.
>>
>> We usually do implement compatible strings for sub-devices and they do
>> tend to have their own device nodes.
>>
>> It's a very long time ago since I coded this up myself, but from
>> memory, you can't have 2 devices share a compatible string.
>>
> 
> Either Mark or Lee suggestion is work.
> Is there a conclusion that we can apply it?
> If MFD is already supported of_compatible, we prefer use of_compatible mapping.
> 

For regulator on PMIC you should add the regulator to the pmic node directly.
Please see the series from Hsin-Hsiung for referece:
https://lore.kernel.org/linux-mediatek/1615829757-3223-6-git-send-email-hsin-hsiung.wang@mediatek.com/T/#u

Regards,
Matthias

>>> Should I use parent's device to find sub-devices of_node if without
>>> compatible name?
>>> I trace the function mfd_add_device,
>>>
>>> if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
>>>     .....
>>>     ret = mfd_match_of_node_to_dev(pdev, np, cell);
>>>     .....
>>> }
>>>
>>> which is binding mfd sub-device with compatible. Does it be removed in
>>> the feature?
>>>
>>>>>       OF_MFD_CELL("mt6360-tcpc", NULL,
>>>>>                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
>>>>>  };
>>>>>
>>
>> --
>> Lee Jones [李琼斯]
>> Senior Technical Lead - Developer Services
>> Linaro.org │ Open source software for Arm SoCs
>> Follow Linaro: Facebook | Twitter | Blog

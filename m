Return-Path: <linux-pm+bounces-17068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC59BE58C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED651C215F5
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EB1DDC3A;
	Wed,  6 Nov 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjXFF7fY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C742AB0;
	Wed,  6 Nov 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892628; cv=none; b=GLvcOxd0fImty+WcxkNdIWcVDbkgBrnG3duySvK4ydSfjTxeYFNLBCQMdQD0lEZxjjm7ft9iZorW/ORV+CLrCaTNaTxmC1BQNan+bqGMjsYmCu+LFJSH/ZFT8ptfjnx8zcEckwLuiPJJoJbiY+rA5bxeiVbbSrLNBFukKrPWcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892628; c=relaxed/simple;
	bh=RrJ056gtMY4jFxKNLLIsRc0rAcwOsaSvAg5xHI5N3BA=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6y4CBcdFajqpqvls6lK7l+aJg2glSFRx7+OlRb0q8W7O87pzg69qFR5eJq/so1X9wu8RkmNY6ITww3NrCaTNUgpSO1R/BxotmmCqAZxLo3YqBNBlcXjwrrPnr7VGvoADvi5o97TFsGi1F6cp0H7hkpNM5OlbVmh7dTU8/+yLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjXFF7fY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9eaf93e40dso334508966b.0;
        Wed, 06 Nov 2024 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730892625; x=1731497425; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZVcBoQ6lm040OAZw+4Mt8FOdcWP0sToZEiJCYG23Sg=;
        b=PjXFF7fY9FmLbQteFAMwd7g95119Uf3eUpKbkunHDT7DPKR5Clu6l2teNaanRY/Ucn
         N2tR2pmEbkxUVtPJhHqp/vpAIl9pbjmdFtyjl5ZT1cwET8U2P1N+8+HL+CEDjzmsalZP
         1nz32WRzVlQY4nZlIjWBHybtejIDHvUgBB72gTghWm5NWSDlwfYG9yK/so7yrspDcJAf
         aABdPEN4vHeWlh39HTf1TJh9tZw2d8HPzThN70rBm875KIbimqq/ePhoMdLuNfEpQ0Pi
         EAcVG2TE0/8m92j5bPRb0s9CV1aGpSrQXjLYynVb7f4QW35xuTV9zVrz1Q59Oklvw28m
         WB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730892625; x=1731497425;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZVcBoQ6lm040OAZw+4Mt8FOdcWP0sToZEiJCYG23Sg=;
        b=itdQWxZcu23hzEK1JgUUYrCPtvN463hVI4GGPqvv0572AwChE66tpZWE2pKwqd4h3l
         /VUykKmuqD66xjrXGglnxL3+fQDlS5JXEtkuymmeSf+Oa2ymTbnBrnGQJmb9p2PylH02
         xLgGCtJIcbZ2M2e+IBfH+1xZF0uGGS7RSJzzbiAVpUZeFILaN4HSKxgWrkPtBsZ+rHlp
         Fpq+78kFb60N7QQKNeo5YMO/hLlea/u6S4JscuNe6OUoVbv8xkx/jqe5khJS7Yt8r7XB
         knZluDyAcvrE2v5bX5YejsTTG8kYaMpkXE/0JSfgcg6AbpV9vilGtSIKNp/Qzc4NbGvG
         UBZg==
X-Forwarded-Encrypted: i=1; AJvYcCUcWELOKpBsWLRJNZ61VDz5Thky3TrfEIMV7Z76/TvwQdvu/X/iO5iLIMx0YHq96v4Cqs7x4mCPZstR0W8=@vger.kernel.org, AJvYcCUip5Ed3W01Uy8D2utEeOD+JFeZZ69QZ5u7WI50FHN5WeeVVm0ggj/Bhn/nGrQ2Le+Vk2fkcuo++kQ=@vger.kernel.org, AJvYcCVKQws1IVTuOfwdPAecUCyiuQVE7ldL+KFnNKz77FtFoybJA36DlHA3vRUmnRVtrpcgPtTw7DHdzgT1@vger.kernel.org, AJvYcCWwA/b59tkGR7LWrZTNZc/QAG+MPPdwIn/pw/7K1mfBPDjVrsWVQk4xq5QSfyTa4U6OZbnQMwqOm7SQ/mNv@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXAnhaV56dI6BSoK9Jf6ulUfI1TbK08ZfTfWTEemfNEFrUUR+
	Xn+FmVuvNDKZZ8NtSyvZ10fSxwYV/AQNB4fpxarwTO/vfRipjJ9K
X-Google-Smtp-Source: AGHT+IHvU2Uae5i8h8nwHHV11pWuGal0zqGEf/SFEAtEDcUc0PhneUzPN4JW2VIwF8CisEQvdATb6A==
X-Received: by 2002:a17:907:7f07:b0:a9a:17f5:79a8 with SMTP id a640c23a62f3a-a9de5d6fad3mr3949625966b.13.1730892624183;
        Wed, 06 Nov 2024 03:30:24 -0800 (PST)
Received: from [10.30.1.160] ([95.183.227.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181335dsm261338866b.176.2024.11.06.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:30:23 -0800 (PST)
Date: Wed, 06 Nov 2024 14:30:13 +0300
From: Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 3/6] soc: mediatek: pwrap: Add support for MT6735 and
 MT6328 SoC/PMIC pair
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones
	<lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, jason-ch chen
	<Jason-ch.Chen@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>, Flora Fu
	<flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Message-Id: <DA1JMS.JREL9T5RHOOO2@gmail.com>
In-Reply-To: <1501dac5-ec1a-4a06-be8c-c222017e0a62@collabora.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
	<20241018081050.23592-4-y.oudjana@protonmail.com>
	<b24d984f-c944-4faf-bce9-96052abb085b@collabora.com>
	<HSNPLS.P9M4WFJGIA0V2@gmail.com>
	<1501dac5-ec1a-4a06-be8c-c222017e0a62@collabora.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed


On Tue, Oct 22 2024 at 11:44:46 +02:00:00, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 21/10/24 16:48, Yassine Oudjana ha scritto:
>> 
>> On Mon, Oct 21 2024 at 15:25:00 +02:00:00, AngeloGioacchino Del 
>> Regno <angelogioacchino.delregno@collabora.com> wrote:
>>> Il 18/10/24 10:10, Yassine Oudjana ha scritto:
>>>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>> 
>>>> Add register definitions and configuration for the MT6735 SoC and 
>>>> the
>>>> MT6328 PMIC which are commonly paired and communicate through the 
>>>> PMIC
>>>> wrapper.
>>>> 
>>>> Note that the PMIC wrapper on MT6735M has a slightly different 
>>>> register
>>>> map and is therefore NOT compatible with MT6735.
>>>> 
>>>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>> ---
>>>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 251 
>>>> ++++++++++++++++++++++++++-
>>>>   1 file changed, 248 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c 
>>>> b/drivers/soc/mediatek/mtk- pmic-wrap.c
>>>> index 9fdc0ef792026..b9e8dd2a5999d 100644
>>>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>>>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>>> @@ -3,6 +3,7 @@
>>>>    * Copyright (c) 2014 MediaTek Inc.
>>>>    * Author: Flora Fu, MediaTek
>>>>    */
>>>> +
>>>>   #include <linux/clk.h>
>>>>   #include <linux/interrupt.h>
>>>>   #include <linux/io.h>
>>>> @@ -100,7 +101,7 @@ enum dew_regs {
>>>>       PWRAP_DEW_CIPHER_MODE,
>>>>       PWRAP_DEW_CIPHER_SWRST,
>>>>   -    /* MT6323 only regs */
>>>> +    /* MT6323 and MT6328 only regs */
>>>>       PWRAP_DEW_CIPHER_EN,
>>>>       PWRAP_DEW_RDDMY_NO,
>>>>   @@ -121,8 +122,10 @@ enum dew_regs {
>>>>       PWRAP_RG_SPI_CON13,
>>>>       PWRAP_SPISLV_KEY,
>>>>   -    /* MT6359 only regs */
>>>> +    /* MT6359 and MT6328 only regs */
>>>>       PWRAP_DEW_CRC_SWRST,
>>>> +
>>>> +    /* MT6359 only regs */
>>>>       PWRAP_DEW_RG_EN_RECORD,
>>>>       PWRAP_DEW_RECORD_CMD0,
>>>>       PWRAP_DEW_RECORD_CMD1,
>>>> @@ -171,6 +174,23 @@ static const u32 mt6323_regs[] = {
>>>>       [PWRAP_DEW_RDDMY_NO] =        0x01a4,
>>>>   };
>>>>   +static const u32 mt6328_regs[] = {
>>>> +    [PWRAP_DEW_DIO_EN] =        0x02d4,
>>>> +    [PWRAP_DEW_READ_TEST] =        0x02d6,
>>>> +    [PWRAP_DEW_WRITE_TEST] =    0x02d8,
>>>> +    [PWRAP_DEW_CRC_SWRST] =        0x02da,
>>>> +    [PWRAP_DEW_CRC_EN] =        0x02dc,
>>>> +    [PWRAP_DEW_CRC_VAL] =        0x02de,
>>>> +    [PWRAP_DEW_MON_GRP_SEL] =    0x02e0,
>>>> +    [PWRAP_DEW_CIPHER_KEY_SEL] =    0x02e2,
>>>> +    [PWRAP_DEW_CIPHER_IV_SEL] =    0x02e4,
>>>> +    [PWRAP_DEW_CIPHER_EN] =        0x02e6,
>>>> +    [PWRAP_DEW_CIPHER_RDY] =    0x02e8,
>>>> +    [PWRAP_DEW_CIPHER_MODE] =    0x02ea,
>>>> +    [PWRAP_DEW_CIPHER_SWRST] =    0x02ec,
>>>> +    [PWRAP_DEW_RDDMY_NO] =        0x02ee,
>>>> +};
>>>> +
>>>>   static const u32 mt6331_regs[] = {
>>>>       [PWRAP_DEW_DIO_EN] =        0x018c,
>>>>       [PWRAP_DEW_READ_TEST] =        0x018e,
>>>> @@ -394,7 +414,7 @@ enum pwrap_regs {
>>>>       PWRAP_ADC_RDATA_ADDR1,
>>>>       PWRAP_ADC_RDATA_ADDR2,
>>>>   -    /* MT7622 only regs */
>>>> +    /* MT7622 and MT6735 only regs */
>>>>       PWRAP_STA,
>>>>       PWRAP_CLR,
>>>>       PWRAP_DVFS_ADR8,
>>>> @@ -417,6 +437,8 @@ enum pwrap_regs {
>>>>       PWRAP_ADC_RDATA_ADDR,
>>>>       PWRAP_GPS_STA,
>>>>       PWRAP_SW_RST,
>>>> +
>>>> +    /* MT7622 only regs */
>>>>       PWRAP_DVFS_STEP_CTRL0,
>>>>       PWRAP_DVFS_STEP_CTRL1,
>>>>       PWRAP_DVFS_STEP_CTRL2,
>>>> @@ -481,6 +503,50 @@ enum pwrap_regs {
>>>>       /* MT8516 only regs */
>>>>       PWRAP_OP_TYPE,
>>>>       PWRAP_MSB_FIRST,
>>>> +
>>>> +    /* MT6735 only regs */
>>>> +    PWRAP_WACS3_EN,
>>>> +    PWRAP_INIT_DONE3,
>>>> +    PWRAP_WACS3_CMD,
>>>> +    PWRAP_WACS3_RDATA,
>>>> +    PWRAP_WACS3_VLDCLR,
>>> 
>>> Are you sure that you need the PWRAP_MD_ADC_xxxx registers in here?
>>> 
>>> Since MD is relatively big on its own, I'm not sure how to proceed 
>>> here.. it may
>>> make sense to split the MD part to a different array, or it may 
>>> not... I do need
>>> to understand what's going on.
>>> 
>>> Can you please point me at some reference code to look at, so that 
>>> I can understand
>>> the situation a bit?
>>> 
>>> Besides, I'm noticing that the "MD_ADC_RDATA_ADDR_R(x)" are 
>>> sequential registers
>>> and that's on more than just MT6735: instead of having 32 more 
>>> entries, it might
>>> make more sense to set only the first and declare the number (or 
>>> size) of regs...
>>> 
>>> Something like:
>>> 
>>> enum pwrap_regs {
>>>     .....
>>>     PWRAP_MD_ADC_RDATA_ADDR_LATEST,
>>>     PWRAP_MD_ADC_RDATA_ADDR_WP,
>>>     PWRAP_MD_ADC_RDATA_ADDR_R0,
>>>     PWRAP_MD_ADC_STA0,
>>>     PWRAP_MD_ADC_STA1,
>>>     PWRAP_MD_ADC_STA2
>>> };
>>> 
>>> static const struct pmic_wrapper_type pwrap_mt6735 = {
>>>     .regs = mt6735_regs,
>>>     .num_md_addr = 32,
>>>     [other stuff]
>>> };
>>> 
>>> ...but again, please, if you can point me at an implementation that 
>>> actually
>>> uses the R(x) registers, that'd be better ... so that we can choose 
>>> the best
>>> option to add those in there.
>>> 
>>> Everything else is great: good job :-)
>>> 
>>> Cheers,
>>> Angelo
>> 
>> I just defined all the registers I could find. We aren't using them 
>> for anything yet so it's also fine to keep them out for now.
>> 
>> It seems that in the downstream kernel they are only initialized 
>> once and never accessed again. This is the only place I could find 
>> where they are accessed:
>> https://gitlab.com/Tooniis/linux-samsung-grandpplte/-/blob/master/drivers/misc/ 
>> mediatek/pmic_wrap/mt6735/pwrap_hal.c#L1254-1290
>> 
>> 
> 
> Thanks for pointing me at that reference.
> 
> Yeah, looks like they're getting statically initialized to some 
> value, and then
> nothing else... I wonder if the values that they're writing are just 
> the register
> defaults, or if they're actually overriding anything for real...
> 
> ...that's because, in case those are the defaults, we may get them 
> set by just
> resetting the MD, catching two birds with one stone.
> That'd be easy to check, anyway, as you can just read them out and 
> see if the
> values are these...

The values aren't defaults. The registers all default to 0 and these 
values are PMIC registers.

Anyway, I'll just remove the registers since I won't need them any time 
soon.





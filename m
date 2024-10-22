Return-Path: <linux-pm+bounces-16202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B389A9ED8
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577FB1F22D20
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63541990CE;
	Tue, 22 Oct 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qATbdFX+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7764157487;
	Tue, 22 Oct 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590291; cv=none; b=pw2y+TTXVU/iysk/+N/GVLtuDiHfhYhT+bi3KEiOuifHzM1ATERRuImtGgHM7wcz1BD1vO0xJ6XudRYWQpJW5mNZYveo1WtOF1JIDxbK92tuPX/onnANj6BGZI+PcNeic0G2TVrUJmnj4DPu3XIFqNYO2y4sudRn0dLgReIDLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590291; c=relaxed/simple;
	bh=QPzrRi2QBm2XsfrXPyyYvDkH3lBQyHhb8fQzKfGDIuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1cL83JxpEP7gYcXJdLF8dtAR4FVeZD+r7tAA7kKh8IlF9QdSvjIHKG//gQG/WPiTXJARvOKb9edinMDCZ15C8ipUxwvO00qgYXg3DSys2mRY1F8hbtWG+486+QAxmHQ8kAmdCIC7P2uE4w3xSBtU4KMyuuJrWL98WdWLA2LT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qATbdFX+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729590288;
	bh=QPzrRi2QBm2XsfrXPyyYvDkH3lBQyHhb8fQzKfGDIuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qATbdFX+U7jUdJdHkD7m+V7g3o/D5Kfl+JWblE6o7mw7X92U94OG/vB3lAgMhXlbH
	 LWvc1brJ1kXVBsopjtCHWiMF+v+aphNSQAUYoLMr9zUFQXN+Dr5Z9af/kyEp8Pt6s+
	 oiKkHtYgtt24Dr2jgezkHECRoPVMBK6JlJFElT+5NoJv7Zg6thErvydQ5kqjEps8Qq
	 afja9qbOCELpo7iVFOFa0K8h28i1bG8D0lXtzTlTb1C7XgDkYcaxcfAJT6CBn5AlQb
	 dsBuHISeJ06WV3N031cg81619Wn37dZPUiDirF0UmSmkYphxz+/k9VuqSlDREgS19C
	 ockJi5Wmse/kg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4876817E1395;
	Tue, 22 Oct 2024 11:44:47 +0200 (CEST)
Message-ID: <1501dac5-ec1a-4a06-be8c-c222017e0a62@collabora.com>
Date: Tue, 22 Oct 2024 11:44:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] soc: mediatek: pwrap: Add support for MT6735 and
 MT6328 SoC/PMIC pair
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Chen Zhong <chen.zhong@mediatek.com>, Flora Fu <flora.fu@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-4-y.oudjana@protonmail.com>
 <b24d984f-c944-4faf-bce9-96052abb085b@collabora.com>
 <HSNPLS.P9M4WFJGIA0V2@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <HSNPLS.P9M4WFJGIA0V2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/10/24 16:48, Yassine Oudjana ha scritto:
> 
> On Mon, Oct 21 2024 at 15:25:00 +02:00:00, AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 18/10/24 10:10, Yassine Oudjana ha scritto:
>>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>> Add register definitions and configuration for the MT6735 SoC and the
>>> MT6328 PMIC which are commonly paired and communicate through the PMIC
>>> wrapper.
>>>
>>> Note that the PMIC wrapper on MT6735M has a slightly different register
>>> map and is therefore NOT compatible with MT6735.
>>>
>>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>> ---
>>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 251 ++++++++++++++++++++++++++-
>>>   1 file changed, 248 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk- 
>>> pmic-wrap.c
>>> index 9fdc0ef792026..b9e8dd2a5999d 100644
>>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> @@ -3,6 +3,7 @@
>>>    * Copyright (c) 2014 MediaTek Inc.
>>>    * Author: Flora Fu, MediaTek
>>>    */
>>> +
>>>   #include <linux/clk.h>
>>>   #include <linux/interrupt.h>
>>>   #include <linux/io.h>
>>> @@ -100,7 +101,7 @@ enum dew_regs {
>>>       PWRAP_DEW_CIPHER_MODE,
>>>       PWRAP_DEW_CIPHER_SWRST,
>>>   -    /* MT6323 only regs */
>>> +    /* MT6323 and MT6328 only regs */
>>>       PWRAP_DEW_CIPHER_EN,
>>>       PWRAP_DEW_RDDMY_NO,
>>>   @@ -121,8 +122,10 @@ enum dew_regs {
>>>       PWRAP_RG_SPI_CON13,
>>>       PWRAP_SPISLV_KEY,
>>>   -    /* MT6359 only regs */
>>> +    /* MT6359 and MT6328 only regs */
>>>       PWRAP_DEW_CRC_SWRST,
>>> +
>>> +    /* MT6359 only regs */
>>>       PWRAP_DEW_RG_EN_RECORD,
>>>       PWRAP_DEW_RECORD_CMD0,
>>>       PWRAP_DEW_RECORD_CMD1,
>>> @@ -171,6 +174,23 @@ static const u32 mt6323_regs[] = {
>>>       [PWRAP_DEW_RDDMY_NO] =        0x01a4,
>>>   };
>>>   +static const u32 mt6328_regs[] = {
>>> +    [PWRAP_DEW_DIO_EN] =        0x02d4,
>>> +    [PWRAP_DEW_READ_TEST] =        0x02d6,
>>> +    [PWRAP_DEW_WRITE_TEST] =    0x02d8,
>>> +    [PWRAP_DEW_CRC_SWRST] =        0x02da,
>>> +    [PWRAP_DEW_CRC_EN] =        0x02dc,
>>> +    [PWRAP_DEW_CRC_VAL] =        0x02de,
>>> +    [PWRAP_DEW_MON_GRP_SEL] =    0x02e0,
>>> +    [PWRAP_DEW_CIPHER_KEY_SEL] =    0x02e2,
>>> +    [PWRAP_DEW_CIPHER_IV_SEL] =    0x02e4,
>>> +    [PWRAP_DEW_CIPHER_EN] =        0x02e6,
>>> +    [PWRAP_DEW_CIPHER_RDY] =    0x02e8,
>>> +    [PWRAP_DEW_CIPHER_MODE] =    0x02ea,
>>> +    [PWRAP_DEW_CIPHER_SWRST] =    0x02ec,
>>> +    [PWRAP_DEW_RDDMY_NO] =        0x02ee,
>>> +};
>>> +
>>>   static const u32 mt6331_regs[] = {
>>>       [PWRAP_DEW_DIO_EN] =        0x018c,
>>>       [PWRAP_DEW_READ_TEST] =        0x018e,
>>> @@ -394,7 +414,7 @@ enum pwrap_regs {
>>>       PWRAP_ADC_RDATA_ADDR1,
>>>       PWRAP_ADC_RDATA_ADDR2,
>>>   -    /* MT7622 only regs */
>>> +    /* MT7622 and MT6735 only regs */
>>>       PWRAP_STA,
>>>       PWRAP_CLR,
>>>       PWRAP_DVFS_ADR8,
>>> @@ -417,6 +437,8 @@ enum pwrap_regs {
>>>       PWRAP_ADC_RDATA_ADDR,
>>>       PWRAP_GPS_STA,
>>>       PWRAP_SW_RST,
>>> +
>>> +    /* MT7622 only regs */
>>>       PWRAP_DVFS_STEP_CTRL0,
>>>       PWRAP_DVFS_STEP_CTRL1,
>>>       PWRAP_DVFS_STEP_CTRL2,
>>> @@ -481,6 +503,50 @@ enum pwrap_regs {
>>>       /* MT8516 only regs */
>>>       PWRAP_OP_TYPE,
>>>       PWRAP_MSB_FIRST,
>>> +
>>> +    /* MT6735 only regs */
>>> +    PWRAP_WACS3_EN,
>>> +    PWRAP_INIT_DONE3,
>>> +    PWRAP_WACS3_CMD,
>>> +    PWRAP_WACS3_RDATA,
>>> +    PWRAP_WACS3_VLDCLR,
>>
>> Are you sure that you need the PWRAP_MD_ADC_xxxx registers in here?
>>
>> Since MD is relatively big on its own, I'm not sure how to proceed here.. it may
>> make sense to split the MD part to a different array, or it may not... I do need
>> to understand what's going on.
>>
>> Can you please point me at some reference code to look at, so that I can understand
>> the situation a bit?
>>
>> Besides, I'm noticing that the "MD_ADC_RDATA_ADDR_R(x)" are sequential registers
>> and that's on more than just MT6735: instead of having 32 more entries, it might
>> make more sense to set only the first and declare the number (or size) of regs...
>>
>> Something like:
>>
>> enum pwrap_regs {
>>     .....
>>     PWRAP_MD_ADC_RDATA_ADDR_LATEST,
>>     PWRAP_MD_ADC_RDATA_ADDR_WP,
>>     PWRAP_MD_ADC_RDATA_ADDR_R0,
>>     PWRAP_MD_ADC_STA0,
>>     PWRAP_MD_ADC_STA1,
>>     PWRAP_MD_ADC_STA2
>> };
>>
>> static const struct pmic_wrapper_type pwrap_mt6735 = {
>>     .regs = mt6735_regs,
>>     .num_md_addr = 32,
>>     [other stuff]
>> };
>>
>> ...but again, please, if you can point me at an implementation that actually
>> uses the R(x) registers, that'd be better ... so that we can choose the best
>> option to add those in there.
>>
>> Everything else is great: good job :-)
>>
>> Cheers,
>> Angelo
> 
> I just defined all the registers I could find. We aren't using them for anything 
> yet so it's also fine to keep them out for now.
> 
> It seems that in the downstream kernel they are only initialized once and never 
> accessed again. This is the only place I could find where they are accessed:
> https://gitlab.com/Tooniis/linux-samsung-grandpplte/-/blob/master/drivers/misc/ 
> mediatek/pmic_wrap/mt6735/pwrap_hal.c#L1254-1290
> 
> 

Thanks for pointing me at that reference.

Yeah, looks like they're getting statically initialized to some value, and then
nothing else... I wonder if the values that they're writing are just the register
defaults, or if they're actually overriding anything for real...

...that's because, in case those are the defaults, we may get them set by just
resetting the MD, catching two birds with one stone.
That'd be easy to check, anyway, as you can just read them out and see if the
values are these...

Anyway, if the MD is still unused, I would - at this point - suggest to just get
everything else that is important right now upstreamed in the pwrap driver, and
delay the addition of the PWRAP_MD registers to when MD support will be upstreamed.

That - unless you want to go deep into that MD rabbithole now... but again, I
would suggest to do that in small steps: at least you get the main components
of the platform working upstream sooner than later! :-)

Cheers,
Angelo


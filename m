Return-Path: <linux-pm+bounces-16109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B69A6CA5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EE01F2126C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D61F8936;
	Mon, 21 Oct 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVhytjJH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A11B59A;
	Mon, 21 Oct 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522112; cv=none; b=cceZtc+nsnQkAS4g6gTJ3FyuWJ7B9gYJN/IW6bkhqCFKvwzNoJNgk/42NtoRcvXCaXfuD1Sj6g1k9Dui9A/E6hHnJ9hu03+KWRGjgld/sdAyJiscXWi7hXCBoUheTPA1xWoya7GFNVH0d6/77CCmIW7yYnWjLS4tOus0nB21YOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522112; c=relaxed/simple;
	bh=zIByhMEAx5If2NvyEt2jX/Ijtg3nnJpuFNjBMIvkj/4=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+YS3Cdg6fqzZ7rxZ12IsTnBWG3Df+G2hyWEjj0GBmAXv/N8hTZNjwb71YFRMiUv9uL8u/eqUYXxgaTjoB9LZ26xGPSlKTYKUnfs3E+EUWQhtTp55xFUH/gP+Sh9Vkix3uDCvueb7sNNB+uFsQlCKNw7gMCp+1ZiKQLDJYzAOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVhytjJH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so5906543a12.1;
        Mon, 21 Oct 2024 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729522108; x=1730126908; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lqNfiZEfyDg/Xzyd/wdhSFkCd9cWx8IKi4PXqxUx9iE=;
        b=OVhytjJH+tXth9wku+K9rRO5mv6mRdaUY5Yd1PrnEFUz2OOCbfPVBGCshMoH4pZO3S
         dotRbVgOGKeSlEL59WXcgJIlN0o4gB0PqlB/kiNXH/VE+Dv7+j5b8vDKNyL+wTO0eLsM
         MjafFLOLZwEAxAgHxrt8GP3C7xwTjKX0wTy1k553o4/5kYGDCpFsrvEiDlsBF+eHN8dy
         fZKZxSJktEyyTXYTcXEa3k44S+Mc7Wb2dJqBqvoMO3/aEd6yJQSoyzo6W+nkVheZ73j2
         sVkJmttLP7V0ZIi0eT+1Z3+2Jl45Rma+TX46WyExOrDE3OXGI0ixPUfigeGSsB1bykQh
         DuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522108; x=1730126908;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqNfiZEfyDg/Xzyd/wdhSFkCd9cWx8IKi4PXqxUx9iE=;
        b=O5i5PEEwItICJRJ/BpcepBZichCBh4DZmZaszIAu2wChEuKLzmLQrB3uleO5gUCL+k
         zzVQxdAq4VAZkWzFrdN/YXUiRg0hGQWrw+owA8LkgqAzMjt1bbHzW9l5eufuVlaXMwn4
         lytRC+FHisBS5vU62l2zj53XsXpt5pgP65C36TrleTfYmQyTgMboeE2KXH/BJ2n30IQh
         zi6Nh2GDNMPCaGZPQX0eBg9Rse3+fGR3dHofH3HUfeI2Y5hj8Dea+QGWE93JJxheVEtR
         P1ZireL3lWJfV1j8SpXD3BVA0JwEgN69tXjK/Ttzot3xm+VCO3igXE5KPI3LrEUe9Ilm
         W4QA==
X-Forwarded-Encrypted: i=1; AJvYcCUBd9YnX49RsHDj/osbQST4e2aJ/1RbPj8JsgD0GRsudO5nYxJwG2gkFVu5H9oOiU/y4h32ZSjXNew=@vger.kernel.org, AJvYcCVXA6Pu4X/8FQp+DVZnYNNM9FaR73PVDiu+FYfOO9rItsmePoZeA3gsTxE5xC2ttyr8/Wf8EjtTnoQ3ZJs=@vger.kernel.org, AJvYcCWwYa6EwyAQSnamcEkGusOvWcWkznCqA4p3czEE2bpuw9H2WzwacQ4zBe1FiP/0vKrHwpl8FoPmDxva@vger.kernel.org, AJvYcCX9Agq1D3ApoaWboH6vezE+mV2uBvxh3DB7BgAQPFzzo5ctgeo8Bn8/8jnmtNQgUfb70lfRNV8SXkuQ0+Tz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/g50aRhuVloUWxPhCnlTU3OgG2byySGpMr+y+wsbQAW8QjFpk
	U6juZpE9ZnDEP8403FgJ/A7nPgvkrjY4iW60BCHElby4BdLhQ72p
X-Google-Smtp-Source: AGHT+IH4U3SXhrAaQiY7SVXU0+/eI8eKxa5cP+eHUn6309fKUSYC/NaCMjDZs7vXcbpGn1PYh18A5w==
X-Received: by 2002:a17:907:2cc6:b0:a99:89bd:d84a with SMTP id a640c23a62f3a-a9a69a68f50mr1250232866b.25.1729522108334;
        Mon, 21 Oct 2024 07:48:28 -0700 (PDT)
Received: from [10.50.4.74] ([95.183.227.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9159a231sm210780966b.210.2024.10.21.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:48:26 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:48:17 +0300
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
Message-Id: <HSNPLS.P9M4WFJGIA0V2@gmail.com>
In-Reply-To: <b24d984f-c944-4faf-bce9-96052abb085b@collabora.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
	<20241018081050.23592-4-y.oudjana@protonmail.com>
	<b24d984f-c944-4faf-bce9-96052abb085b@collabora.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed


On Mon, Oct 21 2024 at 15:25:00 +02:00:00, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 18/10/24 10:10, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> Add register definitions and configuration for the MT6735 SoC and the
>> MT6328 PMIC which are commonly paired and communicate through the 
>> PMIC
>> wrapper.
>> 
>> Note that the PMIC wrapper on MT6735M has a slightly different 
>> register
>> map and is therefore NOT compatible with MT6735.
>> 
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 251 
>> ++++++++++++++++++++++++++-
>>   1 file changed, 248 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c 
>> b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> index 9fdc0ef792026..b9e8dd2a5999d 100644
>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2014 MediaTek Inc.
>>    * Author: Flora Fu, MediaTek
>>    */
>> +
>>   #include <linux/clk.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> @@ -100,7 +101,7 @@ enum dew_regs {
>>   	PWRAP_DEW_CIPHER_MODE,
>>   	PWRAP_DEW_CIPHER_SWRST,
>>   -	/* MT6323 only regs */
>> +	/* MT6323 and MT6328 only regs */
>>   	PWRAP_DEW_CIPHER_EN,
>>   	PWRAP_DEW_RDDMY_NO,
>>   @@ -121,8 +122,10 @@ enum dew_regs {
>>   	PWRAP_RG_SPI_CON13,
>>   	PWRAP_SPISLV_KEY,
>>   -	/* MT6359 only regs */
>> +	/* MT6359 and MT6328 only regs */
>>   	PWRAP_DEW_CRC_SWRST,
>> +
>> +	/* MT6359 only regs */
>>   	PWRAP_DEW_RG_EN_RECORD,
>>   	PWRAP_DEW_RECORD_CMD0,
>>   	PWRAP_DEW_RECORD_CMD1,
>> @@ -171,6 +174,23 @@ static const u32 mt6323_regs[] = {
>>   	[PWRAP_DEW_RDDMY_NO] =		0x01a4,
>>   };
>>   +static const u32 mt6328_regs[] = {
>> +	[PWRAP_DEW_DIO_EN] =		0x02d4,
>> +	[PWRAP_DEW_READ_TEST] =		0x02d6,
>> +	[PWRAP_DEW_WRITE_TEST] =	0x02d8,
>> +	[PWRAP_DEW_CRC_SWRST] =		0x02da,
>> +	[PWRAP_DEW_CRC_EN] =		0x02dc,
>> +	[PWRAP_DEW_CRC_VAL] =		0x02de,
>> +	[PWRAP_DEW_MON_GRP_SEL] =	0x02e0,
>> +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x02e2,
>> +	[PWRAP_DEW_CIPHER_IV_SEL] =	0x02e4,
>> +	[PWRAP_DEW_CIPHER_EN] =		0x02e6,
>> +	[PWRAP_DEW_CIPHER_RDY] =	0x02e8,
>> +	[PWRAP_DEW_CIPHER_MODE] =	0x02ea,
>> +	[PWRAP_DEW_CIPHER_SWRST] =	0x02ec,
>> +	[PWRAP_DEW_RDDMY_NO] =		0x02ee,
>> +};
>> +
>>   static const u32 mt6331_regs[] = {
>>   	[PWRAP_DEW_DIO_EN] =		0x018c,
>>   	[PWRAP_DEW_READ_TEST] =		0x018e,
>> @@ -394,7 +414,7 @@ enum pwrap_regs {
>>   	PWRAP_ADC_RDATA_ADDR1,
>>   	PWRAP_ADC_RDATA_ADDR2,
>>   -	/* MT7622 only regs */
>> +	/* MT7622 and MT6735 only regs */
>>   	PWRAP_STA,
>>   	PWRAP_CLR,
>>   	PWRAP_DVFS_ADR8,
>> @@ -417,6 +437,8 @@ enum pwrap_regs {
>>   	PWRAP_ADC_RDATA_ADDR,
>>   	PWRAP_GPS_STA,
>>   	PWRAP_SW_RST,
>> +
>> +	/* MT7622 only regs */
>>   	PWRAP_DVFS_STEP_CTRL0,
>>   	PWRAP_DVFS_STEP_CTRL1,
>>   	PWRAP_DVFS_STEP_CTRL2,
>> @@ -481,6 +503,50 @@ enum pwrap_regs {
>>   	/* MT8516 only regs */
>>   	PWRAP_OP_TYPE,
>>   	PWRAP_MSB_FIRST,
>> +
>> +	/* MT6735 only regs */
>> +	PWRAP_WACS3_EN,
>> +	PWRAP_INIT_DONE3,
>> +	PWRAP_WACS3_CMD,
>> +	PWRAP_WACS3_RDATA,
>> +	PWRAP_WACS3_VLDCLR,
> 
> Are you sure that you need the PWRAP_MD_ADC_xxxx registers in here?
> 
> Since MD is relatively big on its own, I'm not sure how to proceed 
> here.. it may
> make sense to split the MD part to a different array, or it may 
> not... I do need
> to understand what's going on.
> 
> Can you please point me at some reference code to look at, so that I 
> can understand
> the situation a bit?
> 
> Besides, I'm noticing that the "MD_ADC_RDATA_ADDR_R(x)" are 
> sequential registers
> and that's on more than just MT6735: instead of having 32 more 
> entries, it might
> make more sense to set only the first and declare the number (or 
> size) of regs...
> 
> Something like:
> 
> enum pwrap_regs {
> 	.....
> 	PWRAP_MD_ADC_RDATA_ADDR_LATEST,
> 	PWRAP_MD_ADC_RDATA_ADDR_WP,
> 	PWRAP_MD_ADC_RDATA_ADDR_R0,
> 	PWRAP_MD_ADC_STA0,
> 	PWRAP_MD_ADC_STA1,
> 	PWRAP_MD_ADC_STA2
> };
> 
> static const struct pmic_wrapper_type pwrap_mt6735 = {
> 	.regs = mt6735_regs,
> 	.num_md_addr = 32,
> 	[other stuff]
> };
> 
> ...but again, please, if you can point me at an implementation that 
> actually
> uses the R(x) registers, that'd be better ... so that we can choose 
> the best
> option to add those in there.
> 
> Everything else is great: good job :-)
> 
> Cheers,
> Angelo

I just defined all the registers I could find. We aren't using them for 
anything yet so it's also fine to keep them out for now.

It seems that in the downstream kernel they are only initialized once 
and never accessed again. This is the only place I could find where 
they are accessed:
https://gitlab.com/Tooniis/linux-samsung-grandpplte/-/blob/master/drivers/misc/mediatek/pmic_wrap/mt6735/pwrap_hal.c#L1254-1290




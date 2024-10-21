Return-Path: <linux-pm+bounces-16102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263DB9A6A16
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E5C1C221E7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7B1F708F;
	Mon, 21 Oct 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B1TtMsZQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565611CAF;
	Mon, 21 Oct 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517106; cv=none; b=HGyfRt02Ik3W8+NnjbtVSIwNXD3Yo3se+iMbvpvkifkbwRiPQUPb3DBz+E6GUlNy9dpDG4Jk4/a49ZLYomQcF9N7cJW7emrEHrE2B8EqIsR42ByV5v/pbO6su/YEEu+JbLwZNNnGXtWIVH2MLrIBLY+Xw34SkYV+hbqBeTzMhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517106; c=relaxed/simple;
	bh=AUAhAgskxThRMePyyMce4M7UR6fLNXfYYQVzhMdRuKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndmHZJZaS4BV1zyNdwjZZiSQHRaP6x9bRDq6TPiiJYsSUzzepBV1gFMgImc6xO8j0zWbucekiRkir1PH+g+QXCPp3GfkQNm9XynnqIAcV4pC6R5VriGRA3kpqPIOQ/cKQKeUwmcX9VfUF99EghQQnF0XGLHmGNWZhb5rs2hWI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B1TtMsZQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729517102;
	bh=AUAhAgskxThRMePyyMce4M7UR6fLNXfYYQVzhMdRuKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B1TtMsZQ8sHZ188gbXwS2WXJ33vpZx+YyJf04Vp8O/iflRVQ8nPAO1uTMWfv2FYpA
	 p4msJ2C9PcNSKxiuLcMyU9268WhfQzgFRvQsSwI6W0EcDUUIGszKkXuXkwgx//dNCk
	 FnvtSjwbLgnT1aQi0ScGUupWB48mbgQlP37o73mhUdw5Us4F9xQKVZTKO+qL/MdufN
	 w6kESLEsaqN1F0NDk93vjW066EjG4/qGN7I/q4D9JbMzl0Z3l50gnQIZ1kXpombLa0
	 /J6xlqv+s8XGAX53YAQnkalid+IEg0NNgqaJP2t2zH7leGg9K/NjqrJzuRiQy+Z3Hl
	 uR8GdLxiOcVOg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5378B17E3616;
	Mon, 21 Oct 2024 15:25:01 +0200 (CEST)
Message-ID: <b24d984f-c944-4faf-bce9-96052abb085b@collabora.com>
Date: Mon, 21 Oct 2024 15:25:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] soc: mediatek: pwrap: Add support for MT6735 and
 MT6328 SoC/PMIC pair
To: Yassine Oudjana <yassine.oudjana@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Chen Zhong <chen.zhong@mediatek.com>, Flora Fu <flora.fu@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-4-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018081050.23592-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 10:10, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add register definitions and configuration for the MT6735 SoC and the
> MT6328 PMIC which are commonly paired and communicate through the PMIC
> wrapper.
> 
> Note that the PMIC wrapper on MT6735M has a slightly different register
> map and is therefore NOT compatible with MT6735.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 251 ++++++++++++++++++++++++++-
>   1 file changed, 248 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 9fdc0ef792026..b9e8dd2a5999d 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2014 MediaTek Inc.
>    * Author: Flora Fu, MediaTek
>    */
> +
>   #include <linux/clk.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> @@ -100,7 +101,7 @@ enum dew_regs {
>   	PWRAP_DEW_CIPHER_MODE,
>   	PWRAP_DEW_CIPHER_SWRST,
>   
> -	/* MT6323 only regs */
> +	/* MT6323 and MT6328 only regs */
>   	PWRAP_DEW_CIPHER_EN,
>   	PWRAP_DEW_RDDMY_NO,
>   
> @@ -121,8 +122,10 @@ enum dew_regs {
>   	PWRAP_RG_SPI_CON13,
>   	PWRAP_SPISLV_KEY,
>   
> -	/* MT6359 only regs */
> +	/* MT6359 and MT6328 only regs */
>   	PWRAP_DEW_CRC_SWRST,
> +
> +	/* MT6359 only regs */
>   	PWRAP_DEW_RG_EN_RECORD,
>   	PWRAP_DEW_RECORD_CMD0,
>   	PWRAP_DEW_RECORD_CMD1,
> @@ -171,6 +174,23 @@ static const u32 mt6323_regs[] = {
>   	[PWRAP_DEW_RDDMY_NO] =		0x01a4,
>   };
>   
> +static const u32 mt6328_regs[] = {
> +	[PWRAP_DEW_DIO_EN] =		0x02d4,
> +	[PWRAP_DEW_READ_TEST] =		0x02d6,
> +	[PWRAP_DEW_WRITE_TEST] =	0x02d8,
> +	[PWRAP_DEW_CRC_SWRST] =		0x02da,
> +	[PWRAP_DEW_CRC_EN] =		0x02dc,
> +	[PWRAP_DEW_CRC_VAL] =		0x02de,
> +	[PWRAP_DEW_MON_GRP_SEL] =	0x02e0,
> +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x02e2,
> +	[PWRAP_DEW_CIPHER_IV_SEL] =	0x02e4,
> +	[PWRAP_DEW_CIPHER_EN] =		0x02e6,
> +	[PWRAP_DEW_CIPHER_RDY] =	0x02e8,
> +	[PWRAP_DEW_CIPHER_MODE] =	0x02ea,
> +	[PWRAP_DEW_CIPHER_SWRST] =	0x02ec,
> +	[PWRAP_DEW_RDDMY_NO] =		0x02ee,
> +};
> +
>   static const u32 mt6331_regs[] = {
>   	[PWRAP_DEW_DIO_EN] =		0x018c,
>   	[PWRAP_DEW_READ_TEST] =		0x018e,
> @@ -394,7 +414,7 @@ enum pwrap_regs {
>   	PWRAP_ADC_RDATA_ADDR1,
>   	PWRAP_ADC_RDATA_ADDR2,
>   
> -	/* MT7622 only regs */
> +	/* MT7622 and MT6735 only regs */
>   	PWRAP_STA,
>   	PWRAP_CLR,
>   	PWRAP_DVFS_ADR8,
> @@ -417,6 +437,8 @@ enum pwrap_regs {
>   	PWRAP_ADC_RDATA_ADDR,
>   	PWRAP_GPS_STA,
>   	PWRAP_SW_RST,
> +
> +	/* MT7622 only regs */
>   	PWRAP_DVFS_STEP_CTRL0,
>   	PWRAP_DVFS_STEP_CTRL1,
>   	PWRAP_DVFS_STEP_CTRL2,
> @@ -481,6 +503,50 @@ enum pwrap_regs {
>   	/* MT8516 only regs */
>   	PWRAP_OP_TYPE,
>   	PWRAP_MSB_FIRST,
> +
> +	/* MT6735 only regs */
> +	PWRAP_WACS3_EN,
> +	PWRAP_INIT_DONE3,
> +	PWRAP_WACS3_CMD,
> +	PWRAP_WACS3_RDATA,
> +	PWRAP_WACS3_VLDCLR,

Are you sure that you need the PWRAP_MD_ADC_xxxx registers in here?

Since MD is relatively big on its own, I'm not sure how to proceed here.. it may
make sense to split the MD part to a different array, or it may not... I do need
to understand what's going on.

Can you please point me at some reference code to look at, so that I can understand
the situation a bit?

Besides, I'm noticing that the "MD_ADC_RDATA_ADDR_R(x)" are sequential registers
and that's on more than just MT6735: instead of having 32 more entries, it might
make more sense to set only the first and declare the number (or size) of regs...

Something like:

enum pwrap_regs {
	.....
	PWRAP_MD_ADC_RDATA_ADDR_LATEST,
	PWRAP_MD_ADC_RDATA_ADDR_WP,
	PWRAP_MD_ADC_RDATA_ADDR_R0,
	PWRAP_MD_ADC_STA0,
	PWRAP_MD_ADC_STA1,
	PWRAP_MD_ADC_STA2
};

static const struct pmic_wrapper_type pwrap_mt6735 = {
	.regs = mt6735_regs,
	.num_md_addr = 32,
	[other stuff]
};

...but again, please, if you can point me at an implementation that actually
uses the R(x) registers, that'd be better ... so that we can choose the best
option to add those in there.

Everything else is great: good job :-)

Cheers,
Angelo




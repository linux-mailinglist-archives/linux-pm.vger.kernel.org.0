Return-Path: <linux-pm+bounces-37612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DF5C3F830
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 11:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7907C4F03CA
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D047132BF2F;
	Fri,  7 Nov 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pYufGIN7"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64B290D81;
	Fri,  7 Nov 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511811; cv=none; b=n1ETVLEnptwYDjhQ2DX1nSFfygCzw7kH6xR9FSJs/0E7Eb+ELyzWM+OkDLTT7Od8OSCjx3KS9vdaU5QciIFRTGc0rhCfqQzzBvx8OeWKJLdu4pEj7JOtK7E4ClVHi3QyC2X22mBlfL7SSB4oQpkt+FUKBg+9hCRkD6VYps6S5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511811; c=relaxed/simple;
	bh=W3XA4O4boMpqyIDRv4Vw7fYsHQbOO+0xJ0SlKyYcqI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJeLeR27aFLRANU692wfcH0K3PKE8y8+Zq1Ps0H/d3njU4W3QN83UyYLCwa/g+FPGrEL/sQsEOkAujqdbwlT4W78lyuPjGvSJy72Tnc/rlKkMdYg18BrDO6jRlww8xyA/ITn68YGVtZtdgG3Fmj7MqV87iatEmvER9NHY1ro2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pYufGIN7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762511806;
	bh=W3XA4O4boMpqyIDRv4Vw7fYsHQbOO+0xJ0SlKyYcqI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pYufGIN7RYAeRlellj6N2gZSHDdPM/SyGPzwncHtmDa3CybeRRFucgw8OAIhNnmLo
	 /9gukKEt1mLLCxvDb964d14ur0TsHUks6z6L/+6Eq/w+VNenF3jWckg3RG1MDOLTq6
	 GqpHMmLKrT/yzbcd2Qip7j4u7wdher+hX1WDr6Q6oIStNzkz5IzWcPDMrWHXEKi0/X
	 gywJc5QADo3ZfucXonoeoilwp9h/oVkhmbXD+XfhQFokN1FF/ioQAnXCjrOAxovXfe
	 iPtuh3bWr8GTf6q9vPLEs36wxgqk7YBUaVglgujSp+L8HyAnUviL1kgNRGk+s19XGU
	 ydOsrMZath9dw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BC34A17E0364;
	Fri,  7 Nov 2025 11:36:45 +0100 (CET)
Message-ID: <6f1bbbc7-ca54-43f9-953d-725902af7b10@collabora.com>
Date: Fri, 7 Nov 2025 11:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/21] pmdomain: mediatek: Add bus protect control flow
 for MT8189
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
 <20251106124330.1145600-21-irving-ch.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251106124330.1145600-21-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/11/25 13:42, irving.ch.lin ha scritto:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> In MT8189 mminfra power domain, the bus protect policy separates
> into two parts, one is set before subsys clocks enabled, and another
> need to enable after subsys clocks enable.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 31 ++++++++++++++++++----
>   drivers/pmdomain/mediatek/mtk-pm-domains.h |  5 ++++
>   2 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 164c6b519af3..222846e52daf 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -250,7 +250,7 @@ static int scpsys_bus_protect_set(struct scpsys_domain *pd,
>   					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   }
>   
> -static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
> +static int scpsys_bus_protect_enable(struct scpsys_domain *pd, u8 flags)
>   {
>   	for (int i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
>   		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
> @@ -259,6 +259,10 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>   		if (!bpd->bus_prot_set_clr_mask)
>   			break;
>   
> +		if ((bpd->flags & BUS_PROT_IGNORE_SUBCLK) !=
> +		    (flags & BUS_PROT_IGNORE_SUBCLK))
> +			continue;
> +
>   		if (bpd->flags & BUS_PROT_INVERTED)
>   			ret = scpsys_bus_protect_clear(pd, bpd);
>   		else
> @@ -270,7 +274,7 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>   	return 0;
>   }
>   
> -static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> +static int scpsys_bus_protect_disable(struct scpsys_domain *pd, u8 flags)
>   {
>   	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
>   		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
> @@ -279,6 +283,10 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>   		if (!bpd->bus_prot_set_clr_mask)
>   			continue;
>   
> +		if ((bpd->flags & BUS_PROT_IGNORE_SUBCLK) !=

Is that the right name for this flag?

As far as I understand, you have to set bus protection in two steps, right?
So in the first step you're setting bus protection for the MM_INFRA and for
MM_INFRA_2ND - and in the second step you're setting MM_INFRA_IGN and 2_IGN.

So the first step (the prots with BUS_PROT_IGNORE_SUBCLK) unlocks SUBSYS clks
and SRAM ISO access, the second one does the rest.

I think that a better name for this, at this point would be...

if ((bpd->flags & local_flags) & BUS_PROT_SRAM_PROTECTION)
	continue;

What do you think?

Regards,
Angelo

> +		    (flags & BUS_PROT_IGNORE_SUBCLK))
> +			continue;
> +
>   		if (bpd->flags & BUS_PROT_INVERTED)
>   			ret = scpsys_bus_protect_set(pd, bpd);
>   		else
> @@ -632,6 +640,15 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	if (ret)
>   		goto err_pwr_ack;
>   
> +	/*
> +	 * In MT8189 mminfra power domain, the bus protect policy separates
> +	 * into two parts, one is set before subsys clocks enabled, and another
> +	 * need to enable after subsys clocks enable.
> +	 */
> +	ret = scpsys_bus_protect_disable(pd, BUS_PROT_IGNORE_SUBCLK);
> +	if (ret < 0)
> +		goto err_pwr_ack;
> +
>   	/*
>   	 * In few Mediatek platforms(e.g. MT6779), the bus protect policy is
>   	 * stricter, which leads to bus protect release must be prior to bus
> @@ -648,7 +665,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	if (ret < 0)
>   		goto err_disable_subsys_clks;
>   
> -	ret = scpsys_bus_protect_disable(pd);
> +	ret = scpsys_bus_protect_disable(pd, 0);
>   	if (ret < 0)
>   		goto err_disable_sram;
>   
> @@ -662,7 +679,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	return 0;
>   
>   err_enable_bus_protect:
> -	scpsys_bus_protect_enable(pd);
> +	scpsys_bus_protect_enable(pd, 0);
>   err_disable_sram:
>   	scpsys_sram_disable(pd);
>   err_disable_subsys_clks:
> @@ -683,7 +700,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	bool tmp;
>   	int ret;
>   
> -	ret = scpsys_bus_protect_enable(pd);
> +	ret = scpsys_bus_protect_enable(pd, 0);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -697,6 +714,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   
>   	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>   
> +	ret = scpsys_bus_protect_enable(pd, BUS_PROT_IGNORE_SUBCLK);
> +	if (ret < 0)
> +		return ret;
> +
>   	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
>   		scpsys_modem_pwrseq_off(pd);
>   	else
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
> index f608e6ec4744..a5dca24cbc2f 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
> @@ -56,6 +56,7 @@ enum scpsys_bus_prot_flags {
>   	BUS_PROT_REG_UPDATE = BIT(1),
>   	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
>   	BUS_PROT_INVERTED = BIT(3),
> +	BUS_PROT_IGNORE_SUBCLK = BIT(4),
>   };
>   
>   enum scpsys_bus_prot_block {
> @@ -95,6 +96,10 @@ enum scpsys_bus_prot_block {
>   		_BUS_PROT(_hwip, _mask, _set, _clr, _mask, _sta,	\
>   			  BUS_PROT_REG_UPDATE)
>   
> +#define BUS_PROT_WR_IGN_SUBCLK(_hwip, _mask, _set, _clr, _sta)		\
> +		_BUS_PROT(_hwip, _mask, _set, _clr, _mask, _sta,	\
> +			  BUS_PROT_IGNORE_CLR_ACK | BUS_PROT_IGNORE_SUBCLK)
> +
>   #define BUS_PROT_INFRA_UPDATE_TOPAXI(_mask)			\
>   		BUS_PROT_UPDATE(INFRA, _mask,			\
>   				INFRA_TOPAXI_PROTECTEN,		\




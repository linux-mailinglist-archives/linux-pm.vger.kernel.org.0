Return-Path: <linux-pm+bounces-42105-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iARqDg+Gg2niowMAu9opvQ
	(envelope-from <linux-pm+bounces-42105-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 18:46:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52578EB1D9
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 18:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BF6C3008473
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690C34BA49;
	Wed,  4 Feb 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL1dfEC4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31602348479
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227168; cv=none; b=fuasASOLBY1UCx+PYkb38fizf7YX4/1FwH0WgKX9AD0wCRLBOapC2mMlTU/Yl/pUS6h+VGED3k50Fevo7zpYunygbVUih6/pq4fuEk9jHKgmpblv9LvU1yz0e31Qu4g0LQ3Y4uMf1rzpqEucs40PqGrdvZdBkuWIEzrKk1LIe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227168; c=relaxed/simple;
	bh=Gp5/Ct/MxlJJafsZo/VCRo5XfdIIa2rVc1XAaZnmef8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akvdJ0Mo7IyL1NV9r2rmh9nUqAjIwMP6OE95uQcrRcBdXDuWxVnziBxSwLm28EOonzwW/2m9E5metzJ3EU+HmDod5hFnw8/vLHq2D7901ac+/MVuwGxkDka1Ww1eLPnZowCG2yAXeb0xufyFYxPTh1LmuBxx3q1F5HXMf1JlkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL1dfEC4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so106567f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 09:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770227166; x=1770831966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zdn9VkAm3vurRCCFrd3t8vXr0fJB5Ku03TcZ3ClNuDk=;
        b=nL1dfEC4WLulp3XHlw9hVGZBZ8nDmhsQxgRi5JD9VA3A48JKipeEqR63AZFRlR2Dz+
         LXwMUMEeaKldzf9KBXUZbM+7IvU8gWgcsqOetGRByf4j6z7fjkWzDOYkze9p5pOAuY1H
         UxBdztlnjTduSMks4qtnFf8pleRMwSxKT+fkghcC2QboHbX85BKqAN5HXf2iZLqyGzr3
         2VL6FwPXcQOmVLlGBe9UXtEX9KglnOsR+B65SHAS4qV2z9AM243AaWULYKCZnt5W5lD7
         6nt9cNFPp1gvzujeLYxtIB/gjujXX/ky70gv/OJiaNdef+zewe0Y0eK7wQ4NdllBE4uj
         Lm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227166; x=1770831966;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdn9VkAm3vurRCCFrd3t8vXr0fJB5Ku03TcZ3ClNuDk=;
        b=p7tfL4WAuL+ou7710umy4itxr/o7T9PcejtTYLIaSALTRC9TPd840pWkoaG7RYVDiv
         nGBvqyRMUoRBKRgLdRx12g7QmXqBMNOc1/M0C3M0VqOqwA9o+dMGzY6Q12R1Ut+jKtek
         QBhUP4GKezL6nkSuHiZVTogaHuYUfMGiqUhnjDeNXOUDEDvZtDC1CMR58fjHRMuQpAya
         2AuA1Iyq41NEafmBYNGNM9vqq36jMlg4qPCC3oAo/Qy5EHD/3pfClMSejHwsDADTp7Lh
         wzmNicESchgYvnXrGluIP/9/g3OFYPYjMV+xnbYJMLzjrCuIiMTJV2FJAbVOh3vHGK4y
         oaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVbeU6dmrxvjrNtUPWUdKPyfklSBUctIuCD8igTrG5OPaSJSvpcvQDsQFAiwo0ipzFn6mjXcH5zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbULNfgXSkZ3L/4iItpLQPxxXsyQvT0XTZopHhG7HRDX7Vw0o
	57hVjrSkEQx+h96uy9lLSEU4bVRNOKdwAAU3ModbYAu6Zvg9is/aQbtl
X-Gm-Gg: AZuq6aI1OktFPEWAEDxVDmsvtrLqj2BgEL8tP/aymMvkVv0XcYDn9eUHfM9OHa3zrTF
	AgWUZI7IUJ2MjJo+Ws6bvR1jAhUZi73FIIzce56MWqplnWxMvdjvMj1pYWaKJLWkyEKffSWlQfb
	BfQ1tFxw+HlUZpvm0dWc4wO3Vrx57kiTHdOIwJEramQDHHtQ0o7hLWmdI6FWUwe1P4s7X0+drgO
	GV6Vb6ncMYyXz47ITUZBL9eGeUO6dFYgfOyJWl3egxYPm4nsZfq30s1cU48Owhxw5ltl7vtS4U7
	noLwmKKsOoiCt+X5+1u2OR46dxUp1bVSD+lIGGEQachxA8Ps96jCfgOU//v7O1DtPaeG1gNZTCL
	aNrgT+AEVCsIcB6Sxw+TPU7vcO2jNjMcEXWGzmFweSS3cGiP39fWDqEX35vPr2SoO1Hn+pCL1kt
	zz1hRofgDTOJVkKpKKujQFYBKHvxVSmrcv5XqvO3jSno3sI2NYQPq2LBd9KECH
X-Received: by 2002:a05:6000:2207:b0:430:fc63:8c8 with SMTP id ffacd0b85a97d-43618055383mr5643157f8f.35.1770227166263;
        Wed, 04 Feb 2026 09:46:06 -0800 (PST)
Received: from [192.168.0.29] (static-95-59-231-77.ipcom.comunitel.net. [77.231.59.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a486sm8256763f8f.16.2026.02.04.09.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 09:46:05 -0800 (PST)
Message-ID: <ba86661d-3016-4205-8515-5e9ab2fa309b@gmail.com>
Date: Wed, 4 Feb 2026 18:46:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pmdomain: mediatek: Add bus protect control flow for
 MT8189
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
 <20260202064820.347550-3-irving-ch.lin@mediatek.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20260202064820.347550-3-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42105-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,linaro.org,gmail.com,collabora.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthiasbgg@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52578EB1D9
X-Rspamd-Action: no action



On 02/02/2026 07:48, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> In MT8189 mminfra power domain, the bus protect policy separates
> into two parts, one is set before subsys clocks enabled, and another
> need to enable after subsys clocks enable.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 31 ++++++++++++++++++----
>   drivers/pmdomain/mediatek/mtk-pm-domains.h |  5 ++++
>   2 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 0f0662676c07..3eeb0dabf7d7 100644
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



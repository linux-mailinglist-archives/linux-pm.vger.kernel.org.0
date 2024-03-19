Return-Path: <linux-pm+bounces-5107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DD087FD1D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 12:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EABB1F22BBC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30B87EF18;
	Tue, 19 Mar 2024 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qk9MpCnK"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33B1CD13;
	Tue, 19 Mar 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848739; cv=none; b=ag+M9QhDiizE49ScM20JfQfgRGgJQkvbxeEUBW0lkMj2khSgZ/pNtKm+NiaSP9SyWB5TwNi2MsylUhICipokD1F6zvFPum21+Q3uvOiL1GjDs3wMGhu8g0a+jgteuVxBGnVjwiFn3YwQ6Rx2zdn6cmS9ChuMOYYf33Sw8P+kpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848739; c=relaxed/simple;
	bh=SIo2d1ljVYB5EMmdSQcrmw9C1nugoNVXDIRv6Tk/p3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y93CXhECApuwgu7QdvobCiD+ZmCbXfv3975wx+sKacrh+SSxZj6dBhabX+RhfAfsrdONKhb97j7n6Ni8ZWP4eOX2tsxqrIwwYBH5A8IsMvZrYnma+E1IQIKI55n51xbuVtzBcXc2sB1mStr/V0O8I2lGlx5rGxg7op+sCHw0JOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qk9MpCnK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710848736;
	bh=SIo2d1ljVYB5EMmdSQcrmw9C1nugoNVXDIRv6Tk/p3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qk9MpCnKMMB7IwU4BQ0fW+qn96/bc1NLexm35yovBUEN3LyEZEnvErwVu/uM5syqQ
	 cHwBiHPvrWYfDyqqHg/JW6cX3UJLcDa34FiiFbcbsNHZGw5MlkZpd/w7zatRDeVm6x
	 nZWQBzljQ3BSn6x1aMLWxWf1GkorwYyRAsJ45CADoNncaobz4rKabiWOQQpja4tXRE
	 9z+B85KTssxywHVTXaWK+tNXDFjJXycjM32U4/va4jny6sckcmA+jy69mKw4vAHj8H
	 iCbXM3sCD+/kdA/kvJVP0VsotfkylH9cSFRSXmVWJpKvwaW78G16oCgDrw7j++cnpp
	 d7qtmXHCbGpsA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E785378203E;
	Tue, 19 Mar 2024 11:45:36 +0000 (UTC)
Message-ID: <9d79cd4b-b26c-46ea-9173-2df88f4abaa2@collabora.com>
Date: Tue, 19 Mar 2024 12:45:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] dt-bindings: thermal: mediatek: Add LVTS thermal
 controller definition for MT8186
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240318212428.3843952-1-nico@fluxnic.net>
 <20240318212428.3843952-6-nico@fluxnic.net>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240318212428.3843952-6-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/03/24 22:22, Nicolas Pitre ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Add LVTS thermal controller definition for MT8186.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   .../bindings/thermal/mediatek,lvts-thermal.yaml        |  2 ++
>   include/dt-bindings/thermal/mediatek,lvts-thermal.h    | 10 ++++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> index e6665af52e..4173bae530 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -19,6 +19,7 @@ properties:
>     compatible:
>       enum:
>         - mediatek,mt7988-lvts-ap
> +      - mediatek,mt8186-lvts
>         - mediatek,mt8192-lvts-ap
>         - mediatek,mt8192-lvts-mcu
>         - mediatek,mt8195-lvts-ap
> @@ -75,6 +76,7 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - mediatek,mt8186-lvts
>                 - mediatek,mt8195-lvts-ap
>                 - mediatek,mt8195-lvts-mcu
>       then:
> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> index 997e2f5512..3197ca6087 100644
> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -16,6 +16,16 @@
>   #define MT7988_ETHWARP_0	6
>   #define MT7988_ETHWARP_1	7
>   
> +#define MT8186_TS1_0		0

TSx_y makes no sense: the LVTS sensors are SoC internal and will never change
what they actually measure.

This comment was repeated on literally all of the definitions that you can
currently see in this file - and I'm repeating that again: please follow what
was already done for all SoCs in this binding and use a meaningful name.

#define SOC_{LVTS_INSTANCE(ap/mcu)}_SENSINGPOINT	0
.....							n+1

Regards,
Angelo

> +#define MT8186_TS1_1		1
> +#define MT8186_TS1_2		2
> +#define MT8186_TS1_3		3
> +#define MT8186_TS2_0		4
> +#define MT8186_TS2_1		5
> +#define MT8186_TS3_0		6
> +#define MT8186_TS3_1		7
> +#define MT8186_TS3_2		8
> +
>   #define MT8195_MCU_BIG_CPU0     0
>   #define MT8195_MCU_BIG_CPU1     1
>   #define MT8195_MCU_BIG_CPU2     2



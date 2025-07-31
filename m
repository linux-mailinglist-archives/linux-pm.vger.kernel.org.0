Return-Path: <linux-pm+bounces-31665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA4B16CC0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 09:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2AC5620E0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48FA23F271;
	Thu, 31 Jul 2025 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fmba4iSm"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AAE187FEC;
	Thu, 31 Jul 2025 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947065; cv=none; b=iETBDpeIQUDyL9TRKaczqfWxmkp8ZAO/28aCgXEsWhPO++uWvE64D/JynNQdNmXMD/+zeCNxNeBKloRBoOXzlvjGkfXTYWIobUxMxCt6x2QZaDzAcCSST7jFUFldXzR7rItVDNnmtrulIYMpEcG7VKPOmKeRjz9lQz/+unotNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947065; c=relaxed/simple;
	bh=ErjQ47ZFmrUB+6AgCPEt2uAQFQd2rCBgVrhD5uTl65w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDRfR0olHJxT9lBlv7TnFijaNivf6I8XavGC3fkT6kqc3qJ4G7TsxrOMEdIcylk9TY+RRgUq+eqrG/Qc/z4K7NaajVgebz59KYWs6nPL71XzJDmCuoYdhFeQ1aWOU7T5VLEU+EheAxzRFxus3xLGH6EGWf7mIAjdkoMnTMhYwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fmba4iSm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753947061;
	bh=ErjQ47ZFmrUB+6AgCPEt2uAQFQd2rCBgVrhD5uTl65w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fmba4iSmh0us7h4tkqeW8Kz2Xhjy7f0Inj2joxQrEOopNR4/ibo5OuM+Xz3wIeG3W
	 audj9JZc3IYMm7j/RTw2r8VWxj/lQjemHmdrfFgacHRswJQ/GCPVHKVDkqIkBj+xeD
	 QJEVqwS5jHg8k0HHx8iDDFs5hk4QTJvrTXyJ/gO5JkiN0ner/muifOGVqb9YQky6FO
	 e6+qqHRkgj4tzjW9OjHJNrIGiRVbezsX6vaM17aXIExumIcSwkryXL28i9+B6sItzX
	 s+GuQBQXf/sOJeKNdd61nq4qhbsJtyRsKwzxNA8C20dusdMMVDU+b3jg3sd8ojbvrK
	 4QwlrBStxLqEg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C3D917E088C;
	Thu, 31 Jul 2025 09:31:00 +0200 (CEST)
Message-ID: <9a369599-d0cf-4a17-8667-fa2d7adf63d9@collabora.com>
Date: Thu, 31 Jul 2025 09:31:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: thermal: mediatek: Add LVTS thermal
 controller support for MT8196
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: wenst@chromium.org, nfraprado@collabora.com, arnd@arndb.de,
 colin.i.king@gmail.com, u.kleine-koenig@baylibre.com,
 andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, bchihi@baylibre.com,
 frank-w@public-files.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250730152128.311109-1-laura.nao@collabora.com>
 <20250730152128.311109-2-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-2-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> Add LVTS thermal controller binding for MediaTek MT8196.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../thermal/mediatek,lvts-thermal.yaml        |  2 ++
>   .../thermal/mediatek,lvts-thermal.h           | 26 +++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> index 0259cd3ce9c5..beccdabe110b 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -26,6 +26,8 @@ properties:
>         - mediatek,mt8192-lvts-mcu
>         - mediatek,mt8195-lvts-ap
>         - mediatek,mt8195-lvts-mcu
> +      - mediatek,mt8196-lvts-ap
> +      - mediatek,mt8196-lvts-mcu
>   
>     reg:
>       maxItems: 1
> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> index ddc7302a510a..0ec8ad184d47 100644
> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -80,4 +80,30 @@
>   #define MT8192_AP_MD1   15
>   #define MT8192_AP_MD2   16
>   
> +#define MT8196_MCU_MEDIUM_CPU6_0        0
> +#define MT8196_MCU_MEDIUM_CPU6_1        1
> +#define MT8196_MCU_DSU2                 2
> +#define MT8196_MCU_DSU3                 3
> +#define MT8196_MCU_LITTLE_CPU3          4
> +#define MT8196_MCU_LITTLE_CPU0          5
> +#define MT8196_MCU_LITTLE_CPU1          6
> +#define MT8196_MCU_LITTLE_CPU2          7
> +#define MT8196_MCU_MEDIUM_CPU4_0        8
> +#define MT8196_MCU_MEDIUM_CPU4_1        9
> +#define MT8196_MCU_MEDIUM_CPU5_0        10
> +#define MT8196_MCU_MEDIUM_CPU5_1        11
> +#define MT8196_MCU_DSU0                 12
> +#define MT8196_MCU_DSU1                 13
> +#define MT8196_MCU_BIG_CPU7_0           14
> +#define MT8196_MCU_BIG_CPU7_1           15
> +
> +#define MT8196_AP_TOP0                  0
> +#define MT8196_AP_TOP1                  1
> +#define MT8196_AP_TOP2                  2
> +#define MT8196_AP_TOP3                  3
> +#define MT8196_AP_BOT0                  4
> +#define MT8196_AP_BOT1                  5
> +#define MT8196_AP_BOT2                  6
> +#define MT8196_AP_BOT3                  7
> +
>   #endif /* __MEDIATEK_LVTS_DT_H */



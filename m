Return-Path: <linux-pm+bounces-30263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B8AFB0D5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF511736EA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3300D292B31;
	Mon,  7 Jul 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J+tt0Hsh"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0626057F;
	Mon,  7 Jul 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883133; cv=none; b=G3pwzrQXI8KwJAz1bE5FTrusB8m044/R2OaF6fkv6rxBZ3LJSvlq9wJg4W8b6mxBLyykQ9BBrU1nJIiGVyelLUDxqcGViZUwnsfvEk6E2iaSVtZtE1uQ/NSQHZMxmg7wIaj62FSWpOCRfIOS4BJrY78iThkWbs4b0RD4myZR4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883133; c=relaxed/simple;
	bh=MMB6K1mW7gUPZXcwKZJCapVE2TYR11szvBkVxUwZw/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWxWjfkBRK8lqzWpy+dZFw7Zhii1q0QUtalsSSWfBp7mT75CtrOajqOgwatsDLc6INHcdS4V3/WIkfeIC9w1eHdUj77xxalwSNi3VmhUcKPL+3SzL7q2icdVu5UHN226GOyTHj8UcMwCFsnetc5qjuN1OEIBpDCYjdPBLrzgVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J+tt0Hsh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751883129;
	bh=MMB6K1mW7gUPZXcwKZJCapVE2TYR11szvBkVxUwZw/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J+tt0HshewHKye4oVFeYX65dnXG5fwzFdXq9CY8y7Rzmkj8CKkoDGs+4IWFMEzX/u
	 ujj927Kl/dS80B2JQc1LCgY3EdaOInZH9X8UYcO25a0pKdW4BrzNIx4gXHn7PpWRM/
	 2zL9m7cT9kuwFveuHiWXoTl4Fj/lRcoSiZqePxKMVR3JH43xB4jPXCZfxeynZIscr5
	 RP9r1CDj7lNuP6PjE6/pdKgoIJoa3BPDx3qhIFqh7YdXLUjK+H+yB2BWJHbu2PHSqy
	 zolNGX5aktB8qQlAyvnBE0PIIvpyL2bjzy4cN9PxtLbmcxV13hPHF/yF6gfYdaWBdL
	 7/AjVEOGiO6EQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BFA0217E0523;
	Mon,  7 Jul 2025 12:12:07 +0200 (CEST)
Message-ID: <e6ab043d-3777-4a44-8f25-89da1d6f61c4@collabora.com>
Date: Mon, 7 Jul 2025 12:12:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/16] dt-bindings: net: mediatek,net: allow irq names
To: Frank Wunderlich <linux@fw-web.de>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>
Cc: Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250706132213.20412-1-linux@fw-web.de>
 <20250706132213.20412-4-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250706132213.20412-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/07/25 15:21, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> In preparation for MT7988 and RSS/LRO allow the interrupt-names
> property.
> In this way driver can request the interrupts by name which is much
> more readable in the driver code and SoC's dtsi than relying on a
> specific order.
> 
> Frame-engine-IRQs (fe0..3):
> MT7621, MT7628: 1 IRQ
> MT7622, MT7623: 3 IRQs (only two used by the driver for now)
> MT7981, MT7986: 4 IRQs (only two used by the driver for now)
> 
> RSS/LRO IRQs (pdma0..3) only on Filogic (MT798x) with count of 4.
> 
> Set boundaries for all compatibles same as irq count.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

I'm fine with that, as long as you don't break the driver's ability to keep
getting the interrupts without any interrupt-names, at least for the currently
supported interrupts.

This commit ain't touching any driver, anyway, and the change is valid IMO, so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> v8:
>    - fixed typo in mt7621 section "interrupt-namess"
>    - separated interrupt count from interrupt-names
>    - rephrased description a bit to explain the "why"
> v7: fixed wrong rebase
> v6: new patch splitted from the mt7988 changes
> ---
>   .../devicetree/bindings/net/mediatek,net.yaml | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index 766224e4ed86..da7bda20786a 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -42,6 +42,18 @@ properties:
>       minItems: 1
>       maxItems: 8
>   
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: fe0
> +      - const: fe1
> +      - const: fe2
> +      - const: fe3
> +      - const: pdma0
> +      - const: pdma1
> +      - const: pdma2
> +      - const: pdma3
> +
>     power-domains:
>       maxItems: 1
>   
> @@ -135,6 +147,10 @@ allOf:
>             minItems: 3
>             maxItems: 3
>   
> +        interrupt-names:
> +          minItems: 3
> +          maxItems: 3
> +
>           clocks:
>             minItems: 4
>             maxItems: 4
> @@ -166,6 +182,9 @@ allOf:
>           interrupts:
>             maxItems: 1
>   
> +        interrupt-names:
> +          maxItems: 1
> +
>           clocks:
>             minItems: 2
>             maxItems: 2
> @@ -192,6 +211,10 @@ allOf:
>             minItems: 3
>             maxItems: 3
>   
> +        interrupt-names:
> +          minItems: 3
> +          maxItems: 3
> +
>           clocks:
>             minItems: 11
>             maxItems: 11
> @@ -232,6 +255,10 @@ allOf:
>             minItems: 3
>             maxItems: 3
>   
> +        interrupt-names:
> +          minItems: 3
> +          maxItems: 3
> +
>           clocks:
>             minItems: 17
>             maxItems: 17
> @@ -274,6 +301,9 @@ allOf:
>           interrupts:
>             minItems: 4
>   
> +        interrupt-names:
> +          minItems: 4
> +
>           clocks:
>             minItems: 15
>             maxItems: 15
> @@ -312,6 +342,9 @@ allOf:
>           interrupts:
>             minItems: 4
>   
> +        interrupt-names:
> +          minItems: 4
> +
>           clocks:
>             minItems: 15
>             maxItems: 15
> @@ -350,6 +383,9 @@ allOf:
>           interrupts:
>             minItems: 4
>   
> +        interrupt-names:
> +          minItems: 4
> +
>           clocks:
>             minItems: 24
>             maxItems: 24




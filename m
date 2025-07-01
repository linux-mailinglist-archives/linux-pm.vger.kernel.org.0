Return-Path: <linux-pm+bounces-29871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D791AEEF0A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 08:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA016A560
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6025B309;
	Tue,  1 Jul 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh025Qaq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5C248F42;
	Tue,  1 Jul 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352246; cv=none; b=BSKHuGTAEnUlGJWCAZsNg010RwXfR0TP4DAYSf6EgtZAV28DWt/1sssSQ8vXFovvhR2VqZ3oNjEo1nh+JzptoO94P6Gj2Xqh53nsi0VfBMoOycSESEk88vBXPArXqPiX6dvyRSJXLNVNB4ilLN4aOHFC+apTbndf7gUZxGYeJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352246; c=relaxed/simple;
	bh=tL9Chr28UTYs0r/wuqu9zvyT99diInJK0WfEdylmUj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IykBrDz91NIimAft/j/nfo+HaZWXf2b4F1b+Q4gzUQXSgZEfADqZ0i5BHBXiv96FkvbYi5/aZFB7x8tHXwD/Em7IaQSdK+HnGfeFHo6D86TostdtsoPmMQwT8Bt1N12KBLE3pig3Y/z2sRQfYegg7oPMIrShX3c7EE1HCtESRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh025Qaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD05C4CEEB;
	Tue,  1 Jul 2025 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751352246;
	bh=tL9Chr28UTYs0r/wuqu9zvyT99diInJK0WfEdylmUj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lh025Qaq+S/Muo2dNV1h0GhM3fKgnEA6JLKYH+/HHtYhv/B5VBjpTMwZQJyppnPgZ
	 euWtE13Qw+4ccgs71DJwBCX2GCPhqCCOHYQfMujIdPXDRD6gwsag4MANNdCy16MNh3
	 3ih7MkdpVbqCUJII6mJKLC9+a8LluTyvVmb2WqLHTiwle7mmCBqUZ6kE0/0Wg4Whx9
	 /RwXepHdfZ19iFXj1crWKN1MnCJXeoo5+mGyGTYsReZhT4laWRXidEUcbXjc6ani9K
	 5twV9IY+3JYFDA13b8N0GcsGzFuDB8NGl85UrSXPhOhCGiaecpTD8rNU6hHK+QRFYD
	 nnKLErJA479ZA==
Date: Tue, 1 Jul 2025 08:44:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Wunderlich <frank-w@public-files.de>, 
	Johnson Wang <johnson.wang@mediatek.com>, =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 01/14] dt-bindings: net: mediatek,net: allow irq names
Message-ID: <20250701-wisteria-walrus-of-perfection-bdfbec@krzk-bin>
References: <20250628165451.85884-1-linux@fw-web.de>
 <20250628165451.85884-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250628165451.85884-2-linux@fw-web.de>

On Sat, Jun 28, 2025 at 06:54:36PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> In preparation for MT7988 and RSS/LRO allow the interrupt-names

Why? What preparation, what is the purpose of adding the names, what do
they solve?

> property. Also increase the maximum IRQ count to 8 (4 FE + 4 RSS),

Why? There is no user of 8 items.

> but set boundaries for all compatibles same as irq count.

Your patch does not do it.

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v7: fixed wrong rebase
> v6: new patch splitted from the mt7988 changes
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 38 ++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index 9e02fd80af83..6672db206b38 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -40,7 +40,19 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 8
> +
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
>  
>    power-domains:
>      maxItems: 1
> @@ -135,6 +147,10 @@ allOf:
>            minItems: 3
>            maxItems: 3
>  
> +        interrupt-names:
> +          minItems: 3
> +          maxItems: 3
> +
>          clocks:
>            minItems: 4
>            maxItems: 4
> @@ -166,6 +182,9 @@ allOf:
>          interrupts:
>            maxItems: 1
>  
> +        interrupt-namess:
> +          maxItems: 1
> +
>          clocks:
>            minItems: 2
>            maxItems: 2
> @@ -192,6 +211,10 @@ allOf:
>            minItems: 3
>            maxItems: 3
>  
> +        interrupt-names:
> +          minItems: 3
> +          maxItems: 3
> +
>          clocks:
>            minItems: 11
>            maxItems: 11
> @@ -232,6 +255,10 @@ allOf:
>            minItems: 3
>            maxItems: 3
>  
> +        interrupt-names:
> +          minItems: 3
> +          maxItems: 3
> +
>          clocks:
>            minItems: 17
>            maxItems: 17
> @@ -274,6 +301,9 @@ allOf:
>          interrupts:
>            minItems: 4
>  
> +        interrupt-names:
> +          minItems: 4
> +
>          clocks:
>            minItems: 15
>            maxItems: 15
> @@ -312,6 +342,9 @@ allOf:
>          interrupts:
>            minItems: 4
>  
> +        interrupt-names:
> +          minItems: 4

8 interrupts is now valid?

> +
>          clocks:
>            minItems: 15
>            maxItems: 15
> @@ -350,6 +383,9 @@ allOf:
>          interrupts:
>            minItems: 4
>  
> +        interrupt-names:
> +          minItems: 4

So why sudenly this device gets 8 interrupts? This makes no sense,
nothing explained in the commit msg.

I understand nothing from this patch and I already asked you to clearly
explain why you are doing things. This patch on its own makes no sense.

Best regards,
Krzysztof



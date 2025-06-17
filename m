Return-Path: <linux-pm+bounces-28912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F511ADD123
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B03C3A4BD0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D32E92DE;
	Tue, 17 Jun 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h56s71rz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B12E54A9;
	Tue, 17 Jun 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173241; cv=none; b=doUDiv6qBudSHHGN4/idXrVH37XtKFzIpp+oA/CIUT+fq+AZOT6vhO/ql1k65T8+3eedzptpeVzoWkJq3QRGmSjDnGmaqLlnbwKQAq9JXZGNyb+UnR8kYJ3NP5+RjZmXIT2vVuWdLDy//TI3SmXmd1u1v8zHkMGyi9TZEnW9sI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173241; c=relaxed/simple;
	bh=VzacSK8CHt4963WLrZki0L0yVFovLxHcIRT7RHBkl5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGe6CBaLr6Kvn71rrNUnkK3K1k0QggwnqstIUfgn0Y+8G0SUojVK5+HR95IE2wxx91ee4GhG6UZclp2lK4wuwuIRljEqSM836tQWwIf/ylYuKBAEq2qwAS4mOCDxwEc7faJ7+4Zjxe9jyyLvSS8nq3jtvsxTzkbvY58xEWqYWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h56s71rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F4EC4CEE7;
	Tue, 17 Jun 2025 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750173240;
	bh=VzacSK8CHt4963WLrZki0L0yVFovLxHcIRT7RHBkl5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h56s71rzs/udGDVL1EShezKp0igc+0Rne8OItAUMPt/V+imFOpByZva5b6rNSPCPz
	 x10s7tra/R4mERRgf1U6LZdeQuS0OjGghdedHAzChpkjI4cmakcBFle+SkXx+xKxO3
	 fQEQ6CsdJ0QtyeRFsfnzAkg34fORkchNKKRSmoBWH6E1VgFnVavZK75gAUYGoE0sms
	 KN0t3zoB/6qZ2Qm+4xkeFhn8DBLPh4Y5NLk0NUNI2c5YktuwVjsmUFIaAoxRA9pFKF
	 WMuWczHQy+H+fLL+0dnlFXqnt0zphLrMZa092gk7WuVwIhvxN7cNTHhHH/0/fPX3Xd
	 jtgAQcoYn0Yhg==
Date: Tue, 17 Jun 2025 10:13:54 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 01/13] dt-bindings: net: mediatek,net: update for
 mt7988
Message-ID: <20250617151354.GA2392458-robh@kernel.org>
References: <20250616095828.160900-1-linux@fw-web.de>
 <20250616095828.160900-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616095828.160900-2-linux@fw-web.de>

On Mon, Jun 16, 2025 at 11:58:11AM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Update binding for mt7988 which has 3 gmac and 2 reg items.
> 
> With RSS-IRQs the interrupt max-items is now 6. Add interrupt-names
> to make them accessible by name.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4:
> - increase max interrupts to 8 because of RSS/LRO interrupts

But the schema says 6?

> - dropped Robs RB due to this change
> - allow interrupt names
> - add interrupt-names without reserved IRQs on mt7988
>   this requires mtk driver patch:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20250616080738.117993-2-linux@fw-web.de/
> 
> v2:
> - change reg to list of items
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 28 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index 9e02fd80af83..f8025f73b1cb 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -28,7 +28,10 @@ properties:
>        - ralink,rt5350-eth
>  
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: Register for accessing the MACs.
> +      - description: SoC internal SRAM used for DMA operations.
> +    minItems: 1
>  
>    clocks:
>      minItems: 2
> @@ -40,7 +43,11 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 6
>  
>    power-domains:
>      maxItems: 1
> @@ -348,7 +355,17 @@ allOf:
>      then:
>        properties:
>          interrupts:
> -          minItems: 4
> +          minItems: 2
> +
> +        interrupt-names:
> +          minItems: 2
> +          items:
> +            - const: tx
> +            - const: rx
> +            - const: rx-ring0
> +            - const: rx-ring1
> +            - const: rx-ring2
> +            - const: rx-ring3
>  
>          clocks:
>            minItems: 24
> @@ -381,8 +398,11 @@ allOf:
>              - const: xgp2
>              - const: xgp3
>  
> +        reg:
> +          minItems: 2
> +
>  patternProperties:
> -  "^mac@[0-1]$":
> +  "^mac@[0-2]$":
>      type: object
>      unevaluatedProperties: false
>      allOf:
> -- 
> 2.43.0
> 


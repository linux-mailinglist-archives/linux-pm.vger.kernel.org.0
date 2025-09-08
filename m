Return-Path: <linux-pm+bounces-34174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B448CB49A60
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 21:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A7E1B27763
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36B12D5A01;
	Mon,  8 Sep 2025 19:52:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB672D541B
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361152; cv=none; b=h3jLRxSJtVt4XtKi3ErNW7EwvFP9m0/BxAAxMRwGIx8qrkC13akm5oKdAs8jhOSa6DEBC1k63IrAeKys3gYSRMJqcdu15VOBCZuAeSNWgFujpTkL5Y4qouf+ekjadxo9ldLOoPefI3dTu+KHG1UCL1zJ98Hi7aezzCI2z644Ijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361152; c=relaxed/simple;
	bh=KG/wZiINb4q+y6OBOElz2J9sgATSOMqPoUnV+iOCiIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQyTivjUaePeEzDKbwzHX3k4vRAlFwsHQmRSwqyHdLmoq5G9o4gG99rWaxGBvSbz3P4ZGGXPhvXXEppzselh/6Q0uGZ7CcEzK+PhGBj9osJtlNZnbs0VwKEPx6nrSTU4MhFmBvFjBASBE19JLMLIxnszqv8uvIvJxEgkakmgUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E5851692
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 12:52:22 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 775933F694
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 12:52:30 -0700 (PDT)
Date: Mon, 8 Sep 2025 20:51:58 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Message-ID: <aL8z3go1ece81LQj@e110455-lin.cambridge.arm.com>
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
 <20250905-mt8196-gpufreq-v1-1-7b6c2d6be221@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250905-mt8196-gpufreq-v1-1-7b6c2d6be221@collabora.com>

On Fri, Sep 05, 2025 at 12:22:57PM +0200, Nicolas Frattaroli wrote:
> The Mali-based GPU on the MediaTek MT8196 SoC is shackled to its concept
> of "MFlexGraphics", which in this iteration includes an embedded MCU
> that needs to be poked to power on the GPU, and is in charge of
> controlling all the clocks and regulators.
> 
> In return, it lets us omit the OPP tables from the device tree, as those
> can now be enumerated at runtime from the MCU.
> 
> Add the mediatek,mt8196-mali compatible, and a performance-controller
> property which points to a node representing such setups. It's required
> on mt8196 devices.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 36 +++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index a5b4e00217587c5d1f889094e2fff7b76e6148eb..6df802e900b744d226395c29f8d87fb6d3282d26 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -19,6 +19,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,rk3588-mali
> +              - mediatek,mt8196-mali
>            - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
>  
>    reg:
> @@ -53,6 +54,13 @@ properties:
>    opp-table:
>      type: object
>  
> +  performance-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle of a device that controls this GPU's power and frequency,
> +      if any. If present, this is usually in the form of some specialised
> +      embedded MCU.
> +
>    power-domains:
>      minItems: 1
>      maxItems: 5
> @@ -91,7 +99,6 @@ required:
>    - interrupts
>    - interrupt-names
>    - clocks
> -  - mali-supply
>  
>  additionalProperties: false
>  
> @@ -105,9 +112,24 @@ allOf:
>        properties:
>          clocks:
>            minItems: 3
> +        performance-controller: false
>          power-domains:
>            maxItems: 1
>          power-domain-names: false
> +      required:
> +        - mali-supply
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,mt8196-mali

s/rockchip/mediatek/

Best regards,
Liviu

> +    then:
> +      properties:
> +        mali-supply: false
> +        sram-supply: false
> +        operating-points-v2: false
> +      required:
> +        - performance-controller
>  
>  examples:
>    - |
> @@ -143,5 +165,17 @@ examples:
>              };
>          };
>      };
> +  - |
> +    gpu2: gpu@48000000 {
> +        compatible = "mediatek,mt8196-mali", "arm,mali-valhall-csf";
> +        reg = <0x48000000 0x480000>;
> +        clocks = <&mfgpll 0>;
> +        clock-names = "core";
> +        interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
> +        interrupt-names = "job", "mmu", "gpu";
> +        performance-controller = <&gpufreq>;
> +    };
>  
>  ...
> 
> -- 
> 2.51.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯


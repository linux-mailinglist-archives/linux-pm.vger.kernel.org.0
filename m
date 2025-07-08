Return-Path: <linux-pm+bounces-30408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E3BAFD9F9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 23:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B2189D507
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A3246794;
	Tue,  8 Jul 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGVcmEvm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB178246783;
	Tue,  8 Jul 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010266; cv=none; b=apOSLLDmqEgv5dBgfpccBT4Y+4ENwQrprhkCQRk3KbLnXYiHM1HJZ0UAOxmmStxmmElebIpT3k4kFYKL0WVFC1JXj7zBC3PA+T9tiOArkz9xBex/LAJ6hxh/wjyHEhaK+1Tjl+GMwxsnbEzt1fXe95RMqDXIeHweEGChZxpWPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010266; c=relaxed/simple;
	bh=muHKFMk3+FAqjA0IzFbxIYjKJ0jfprPa6PDJaUth2bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDGMJ8qzpWf5GKyRjLDgSJDFXujo45LAXV8gJxIhbzjv0Rj3Z4zHQYcX3JuX8YS+MNPD5a268lULd73zBarmTOykckWKfs+8tgdC2V1yya/SvcWOKfkAi0rENI1YamWuSag5RTlbU1nK16YAKtdO9/6xMdJueTEDcTupbxZlGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGVcmEvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F5C4CEED;
	Tue,  8 Jul 2025 21:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752010266;
	bh=muHKFMk3+FAqjA0IzFbxIYjKJ0jfprPa6PDJaUth2bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGVcmEvmklitC/oRvIIlzZDODGrxGHGZMrPtrgRGSFM4SODotqhCuqlMpYIaMZTd8
	 oAq0yve0BQTlIu+xdjj0pDceX0WMK/IAwinjabWbHUp9n0rqXL2XWbl2advUAWFdFQ
	 KLRHLRDy7tn1GtMOMk+rkqnbwQ8R1DNJmNDOzpKnJi2FR5CK11s8qQod+3dUbRoOXn
	 aAk6+sRmRRENypWzalxuvmE3SWwpfzj49366mHzVCtedI+CtjurXdkou89KYFBm934
	 vad1SKWyOf3050iK9v3LZ9HU45NoX0coAkK+GgQhfbRpyiX5lcgBZ1gD01C3AsPL1r
	 6wyjO1oLjv++g==
Date: Tue, 8 Jul 2025 16:31:05 -0500
From: Rob Herring <robh@kernel.org>
To: iuncuim <iuncuim@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers
Message-ID: <20250708213105.GA1082606-robh@kernel.org>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
 <20250703151132.2642378-3-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703151132.2642378-3-iuncuim@gmail.com>

On Thu, Jul 03, 2025 at 11:11:26PM +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Add a binding for D1/T113s thermal sensor controller. Add dt-bindings
> description of the thermal sensors in the A523 processor.
> The controllers require activation of the additional frequency of the
> associated gpadc controller, so a new clock property has been added.
> 
> The calibration data is split into two cells that are in different areas
> of nvmem. Both controllers require access to both memory cell, so a new
> property nvmem-cells has been added. To maintain backward compatibility,
> the name of the old cell remains the same and the new nvmem-cell-names is
> called calibration-second-part
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 49 +++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index 3e61689f6..80657435a 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -24,18 +24,22 @@ properties:
>        - allwinner,sun50i-h5-ths
>        - allwinner,sun50i-h6-ths
>        - allwinner,sun50i-h616-ths
> +      - allwinner,sun55i-a523-ths0
> +      - allwinner,sun55i-a523-ths1
>  
>    clocks:
>      minItems: 1
>      items:
>        - description: Bus Clock
>        - description: Module Clock
> +      - description: GPADC Clock

You add a 3rd clock for everyone, but I don't see a conditional schema 
keeping the existing users at 2 clocks (maxItems: 2).

>  
>    clock-names:
>      minItems: 1
>      items:
>        - const: bus
>        - const: mod
> +      - const: gpadc
>  
>    reg:
>      maxItems: 1
> @@ -47,11 +51,16 @@ properties:
>      maxItems: 1
>  
>    nvmem-cells:
> -    maxItems: 1
> -    description: Calibration data for thermal sensors
> +    minItems: 1
> +    items:
> +      - description: Calibration data for thermal sensors
> +      - description: Additional cell in case of separate calibration data
>  
>    nvmem-cell-names:
> -    const: calibration
> +    minItems: 1
> +    items:
> +      - const: calibration
> +      - const: calibration-second-part
>  
>    allwinner,sram:
>      maxItems: 1
> @@ -107,6 +116,7 @@ allOf:
>              enum:
>                - allwinner,sun8i-h3-ths
>                - allwinner,sun20i-d1-ths
> +              - allwinner,sun55i-a523-ths0
>  
>      then:
>        properties:
> @@ -132,6 +142,26 @@ allOf:
>          - clock-names
>          - resets
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun55i-a523-ths0
> +              - allwinner,sun55i-a523-ths1
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: gpadc

But if there's really still just 2 clocks, you need the last entry to be 
'enum: [ mod, gpadc ]'

Though really, how can this h/w now not have a clock for itself? 


> +        nvmem-cells:
> +          minItems: 2
> +        nvmem-cell-names:
> +          minItems: 2

Everyone else needs 'maxItems: 1'

> +
>  required:
>    - compatible
>    - reg
> @@ -176,4 +206,17 @@ examples:
>          #thermal-sensor-cells = <1>;
>      };
>  
> +  - |
> +    thermal-sensor@2009400 {
> +      compatible = "allwinner,sun55i-a523-ths1";
> +      reg = <0x02009400 0x400>;
> +      interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
> +      clock-names = "bus", "gpadc";
> +      resets = <&ccu RST_BUS_THS>;
> +      nvmem-cells = <&ths_calibration0>, <&ths_calibration1>;
> +      nvmem-cell-names = "calibration",
> +             "calibration-second-part";
> +      #thermal-sensor-cells = <1>;
> +    };
>  ...
> -- 
> 2.49.0
> 


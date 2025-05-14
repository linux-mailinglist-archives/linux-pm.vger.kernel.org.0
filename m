Return-Path: <linux-pm+bounces-27160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA27DAB7762
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 22:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08CD7A53AC
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D4296172;
	Wed, 14 May 2025 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO40+DZZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079EC292901;
	Wed, 14 May 2025 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256103; cv=none; b=nMKajhI8nfMpsu5Ui44R9oHpy7Thp/9f8K5IL9ngrRMWd/1TxjFc+K9G+GTgzB3g5MjI7UswQlBpf/JdRbqfz7Z0eK7+JAYB5IPQCqDYN/S56lacQ9ps9qQB2ScHEnSYptcMzAgtBBAdUQMIB6M50Sv+2tLiWUMa8c73v0wRmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256103; c=relaxed/simple;
	bh=WxZ0hu8pwhaWeDuz2BpgcUbSog65VNpAS6OHgv+6y+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMM8Qo6t6rq2q1SQqVS7gBFsdcYqiJgBBwZ2d0shaGrG1NKvu6CkMpdcgraqCdkRTmjo80CvIuUiTf8BJuZ/bwq7p483vgNGGfkP4uM7qyR8wB/6cn43hG+mkZcskz7NBDZsJY4Jd3zdbvZIJrTCuDY42Puml9qMKhPXvzZNpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO40+DZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB4AC4CEE3;
	Wed, 14 May 2025 20:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747256102;
	bh=WxZ0hu8pwhaWeDuz2BpgcUbSog65VNpAS6OHgv+6y+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WO40+DZZZcN5EaXCYFM2I7IBDgFCCxzyphVbVqRnK2ii63t165oYoIC25f9v7nei6
	 u5vsR/ZGPNEEnlhCg/AOS4PdYzVMZaTXWw7oAPidek0hSuqcBZPreSRcoG29ufV3Cn
	 3npxU6Itw1qAeAhQqe/BWpTa28aLMs3gRwblfuyYMrfyaWolUCKpcwuvPhwBLKuLXd
	 y3nNiAMPks2aj+Xbc0Q2ILAdn3XAy4owXCgOJA6gAPEBTSAMQ2mB8MzrYOvM7CcJNS
	 Kq64ahJOq8g2vlGEJ3uGcAE+rwTX5RG2ptYVhThCl5hzoTs9Yd7R8ryxWknIZ1Znea
	 4gnatXnxhjrCA==
Date: Wed, 14 May 2025 15:55:00 -0500
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 03/10] dt-bindings: mfd: Add Apple Mac System
 Management Controller
Message-ID: <20250514205500.GA3001472-robh@kernel.org>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
 <20250511-smc-6-15-v5-3-f5980bdb18bd@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511-smc-6-15-v5-3-f5980bdb18bd@svenpeter.dev>

On Sun, May 11, 2025 at 08:18:38AM +0000, Sven Peter wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Add a DT binding for the Apple Mac System Management Controller.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../devicetree/bindings/mfd/apple,smc.yaml         | 71 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 72 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/apple,smc.yaml b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..9f1058c15bbf62d84f8a72fdaa354909b02e2801
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/apple,smc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Mac System Management Controller
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +description:
> +  Apple Mac System Management Controller implements various functions
> +  such as GPIO, RTC, power, reboot.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t6000-smc
> +          - apple,t8103-smc
> +          - apple,t8112-smc
> +      - const: apple,smc
> +
> +  reg:
> +    items:
> +      - description: SMC area
> +      - description: SRAM area
> +
> +  reg-names:
> +    items:
> +      - const: smc
> +      - const: sram
> +
> +  mboxes:
> +    maxItems: 1
> +
> +  gpio:
> +    $ref: /schemas/gpio/apple,smc-gpio.yaml
> +
> +  reboot:
> +    $ref: /schemas/power/reset/apple,smc-reboot.yaml
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - mboxes
> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      smc@23e400000 {
> +        compatible = "apple,t8103-smc", "apple,smc";
> +        reg = <0x2 0x3e400000 0x0 0x4000>,
> +               <0x2 0x3fe00000 0x0 0x100000>;
> +        reg-names = "smc", "sram";
> +        mboxes = <&smc_mbox>;
> +
> +        smc_gpio: gpio {
> +          compatible = "apple,smc-gpio";
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +        };
> +      };

If there's another version, please make the example here complete and 
drop the other incomplete examples in the child bindings.

Rob


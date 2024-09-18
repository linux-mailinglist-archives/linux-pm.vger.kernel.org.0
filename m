Return-Path: <linux-pm+bounces-14405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57D97BB0E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 12:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74981F22BB8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA717D8A2;
	Wed, 18 Sep 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtqGAr3O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819717BB25;
	Wed, 18 Sep 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656371; cv=none; b=Z8sIq/soPTjkjVadYfGS23YQOKI4MF9dOLQ2gyyzW5Ppb64j0yHu6L/wRu3Tiuu72p+cdBkMHL1kUYemkvt+b/mWBVnO6syDLOFpRfc7xjUSyyOQ735cPMzXM6YDHimu5b6twtKpgENLfPxfS5OzCLMG/NyhmDwQ3cAanTlDbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656371; c=relaxed/simple;
	bh=Qnppz8lfqtx1saJh/hYNgsjBVMxARtwGX6DimFRp+tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EavhyuB5FYjXTX+MD8FN9R5xoJEbEBOjjBcSZAUYYYFqYIukt/+ZxtQc8H5anaLeOOGPmtQm7V2xAwLDakq5JWUUQhFzNgBTbhTmuyIZT6Y8jGI6wOBfGro90EO7WJr0N9dic8dX63Jhz7cy+l8rP36XCaBS8p3xDv+TMnQ/zis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtqGAr3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B25C4CEC3;
	Wed, 18 Sep 2024 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726656369;
	bh=Qnppz8lfqtx1saJh/hYNgsjBVMxARtwGX6DimFRp+tI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qtqGAr3OKlzRxwhZOwjnfH1a6sZH1gy5TUNJ7FQ1BvtHCdrDpChObKblx6qi7jxPS
	 yE4w/ECmrHmeD73HEsyGqyAAvT7OTAouiJiv6apaVVviDmqWKh4DrZbUlbV7iAsiGZ
	 qYdPKc5Weq/h8SeXsePqYm61JM7ahPzEF2fhiXUZwwgTuQtEJrnJNmWaCToq9e9epU
	 +UR7/HMdx8iUjpA3cYPNba8FpDunJJ9Xgu01vDX1NzmzvVUjyM9qSGrWMbZHeAdRZw
	 gsPzQFqgtlAkSaFjzDSlAkqDgLKsY045grcKPi4IYieiK3RGMaVOYzHPNQiyZ/MeiD
	 qSYjsObSWj/hw==
Message-ID: <d27d7439-bd8d-4e89-b940-cb1cebba2fb8@kernel.org>
Date: Wed, 18 Sep 2024 12:46:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: Add TI TWL603X charger
To: Andreas Kemnade <andreas@kemnade.info>, tony@atomide.com,
 Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 linux-pm@vger.kernel.org
References: <20240918084132.928295-1-andreas@kemnade.info>
 <20240918084132.928295-2-andreas@kemnade.info>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240918084132.928295-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2024 10:41, Andreas Kemnade wrote:
> Use a fallback compatible since for especially for generic
> defensive setup of parameters, both 6030 and 6032 are the same and
> U-Boot actually uses a generic 6030/32 function to enable the
> charger.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../power/supply/ti,twl6030-charger.yaml      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml b/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
> new file mode 100644
> index 0000000000000..fe0fe9a78761c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license. See checkpatch.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/ti,twl6030-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TWL6030/32 BCI (Battery Charger Interface)
> +
> +description: |

Do not need '|' unless you need to preserve formatting.


> +  The battery charger needs to be configured to do any charging besides of
> +  precharging. The GPADC in the PMIC has to be used to get the related
> +  voltages.
> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

No need for items here. Just const directly.

> +          - const: "ti,twl6030-charger"

Not tested.

Drop ""

> +      - items:
> +          - const: "ti,twl6032-charger"
> +          - const: "ti,twl6030-charger"
> +
> +  interrupts:
> +    minItems: 2

Drop minItems

> +    maxItems: 2

... and actually drop both and instead list items with description
(items: -descriptio: ... - description: ....)

> +
> +  io-channels:
> +    items:
> +      - description: VBUS Voltage Channel
> +
> +  io-channel-names:
> +    items:
> +      - const: vusb
> +
> +  monitored-battery:

Just : true

> +    description:
> +      phandle of battery characteristics devicetree node

That's redundant, you do no say anything useful here.

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - monitored-battery
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {

Drop... or this is supposed to be part of parent schema?

> +      bci {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

e.g. charger

> +        compatible = "ti,twl6032-charger", "ti,twl6030-charger";
> +        interrupts = <2>, <5>;
> +        io-channels = <&gpadc 10>;
> +        io-channel-names = "vusb";
> +        monitored-battery = <&bat>;
> +      };
> +    };

Best regards,
Krzysztof



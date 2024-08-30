Return-Path: <linux-pm+bounces-13252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A7D9666F7
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 18:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01900B245CD
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1012F1BA29A;
	Fri, 30 Aug 2024 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrxWumWS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E31B5EBF;
	Fri, 30 Aug 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035445; cv=none; b=lx7PzS7xwY5GVN4JFfmZlYTBo1v306f+KM6m3OyblrsiGJbNxJzhL1iEjEp3IkGodJAczduSCAimmqI4KDDzc/v5xG5/rpwBLQj87Y88A+2XjW8r1T5sRC2If926ojtevwr9t+Ft9yls7wAiePUZg+LszsoDZCe4k/psQaBafdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035445; c=relaxed/simple;
	bh=qCzga63KeKGmhvUCRSLeRGpmKyn6xKlZmu6N8oyL0m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPMusTrADzLdLtO0TAJ7CtTzL9+uhET+H+NbOMIDoLNSnoofNiDEMMOyxGwvyC3BoCyoPbfgxpK3DZ5xyOjXd2lGJqwa8jQydOFtXXBIpJppf64sxcBQaYwEPWsBui5laj3jzd8JD6Ob/Y04R5rAn0BDm7PYxJpo4efYgb/MsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrxWumWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319FBC4CECA;
	Fri, 30 Aug 2024 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725035444;
	bh=qCzga63KeKGmhvUCRSLeRGpmKyn6xKlZmu6N8oyL0m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrxWumWSVwLYlagAu2K/NmFbfGMjx5te98wy5Qth7GqZEgf6kjjpyCaVAUC0ezljE
	 AA6DHBSsm3Eqlz2PS6mWkAApCYuWaLdP0TDmPCqNLFc/FlOOQ8ebKEXJKQATkRJmUW
	 hfsOTjwXhDUfc7ZHfeW/RwGRXA0QZePcaE+oFSAZwFr5pafkl8FgBYdeLOIcWH6jAn
	 h4u4GUF7mhLLlsq3JHto358x2bh9SYeGetfK3oUsWdddjT3cySqI4Wxny0mW0dh5Nl
	 dm4LMdr7o9+T4GKiaE7Ca83Lgm4HZq7CXFWS9EXtC3t22j+IxGbfSw9RVCAdD66UQj
	 qmB3a+FlV2mrQ==
Date: Fri, 30 Aug 2024 11:30:42 -0500
From: Rob Herring <robh@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Message-ID: <20240830163042.GA319200-robh@kernel.org>
References: <20240829213102.448047-1-macroalpha82@gmail.com>
 <20240829213102.448047-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829213102.448047-2-macroalpha82@gmail.com>

On Thu, Aug 29, 2024 at 04:30:58PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Document the Texas instruments BQ25703 series of charger managers/
> buck/boost regulators.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> new file mode 100644
> index 000000000000..e555aa60f9ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BQ25703 Charger Manager/Buck/Boost Converter

BQ25703A?

> +
> +maintainers:
> +  - Chris Morgan <macromorgan@hotmail.com>
> +
> +properties:
> +  compatible:
> +    const: ti,bq25703a
> +
> +  reg:
> +    const: 0x6b
> +    description: I2C slave address

Drop description.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-supplies:
> +    description:
> +      phandle of the power supply that provides input power
> +    $ref: /schemas/types.yaml#/definitions/phandle

Already has a type. You need a reference to power-supply.yaml at the 
top level and 'maxItems: 1' here.

> +
> +  ti,charge-current:
> +    description:
> +      maximum current to apply to charging the battery
> +    minimum: 0
> +    maximum: 8128000
> +    $ref: /schemas/types.yaml#/definitions/uint32

I guess this is copied from other TI parts, but really this should move 
to a property with a unit suffix. Or these shared properties moved to a 
shared schema so we aren't redefining the type multiple times.

Same for the others here.

> +
> +  ti,current-limit:
> +    description:
> +      maximum total input current allowed
> +    minimum: 50000
> +    maximum: 6400000
> +    default: 3250000
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  ti,max-charge-voltage:
> +    description:
> +      maximum voltage to apply to charging the battery
> +    minimum: 1024000
> +    maximum: 19200000
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  ti,minimum-sys-voltage:
> +    description:
> +      minimum system voltage while on battery power, with default value
> +      depending based on cell configuration
> +    minimum: 1024000
> +    maximum: 16128000
> +    default:
> +      enum: [3584000, 6144000, 9216000, 16128000]
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Boost converter regulator output of bq257xx

Doesn't this apply to "usb-otg-vbus"?

Really, only one regulator, so you don't need a container node.

> +
> +    properties:
> +      "usb-otg-vbus":

Don't need quotes.

> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml
> +
> +        properties:
> +          regulator-name: true
> +          regulator-min-microamp:
> +            minimum: 0
> +            maximum: 6350000
> +          regulator-max-microamp:
> +            minimum: 0
> +            maximum: 6350000
> +          regulator-min-microvolt:
> +            minimum: 4480000
> +            maximum: 20800000
> +          regulator-max-microvolt:
> +            minimum: 4480000
> +            maximum: 20800000
> +          enable-gpios:
> +            description:
> +              The BQ25703 may require both a register write and a GPIO
> +              toggle to enable the boost regulator.
> +
> +        additionalProperties: true

Nope.

> +
> +        required:
> +          - regulator-name
> +          - regulator-min-microamp
> +          - regulator-max-microamp
> +          - regulator-min-microvolt
> +          - regulator-max-microvolt
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-supplies
> +  - ti,charge-current
> +  - ti,current-limit
> +  - ti,max-charge-voltage
> +  - ti,minimum-sys-voltage
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bq25703: bq25703@6b {

charger@6b

> +            compatible = "ti,bq25703a";
> +            reg = <0x6b>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <RK_PD5 IRQ_TYPE_LEVEL_LOW>;
> +            power-supplies = <&fusb302>;
> +            ti,charge-current = <2500000>;
> +            ti,current-limit = <5000000>;
> +            ti,max-charge-voltage = <8750000>;
> +            ti,minimum-sys-voltage = <7400000>;
> +
> +            regulators {
> +                usb_otg_vbus: usb-otg-vbus {
> +                    enable-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
> +                    regulator-max-microamp = <960000>;
> +                    regulator-max-microvolt = <5088000>;
> +                    regulator-min-microamp = <512000>;
> +                    regulator-min-microvolt = <4992000>;
> +                    regulator-name = "usb_otg_vbus";
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.34.1
> 


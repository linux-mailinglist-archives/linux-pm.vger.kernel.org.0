Return-Path: <linux-pm+bounces-36930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87AC117F1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 22:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9605B1A285C2
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 21:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A440D32AAB9;
	Mon, 27 Oct 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWpOCFtb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC30329C7E;
	Mon, 27 Oct 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599633; cv=none; b=FgZ3gAb4k1gDovz+EHQemkAVdHRs5uLeBhgVY134eCS7lQujB4wsdrbyjj8ohv4egmMck0CrYG7q3HX/y2eCuiD/71bxwQ/E+7caajMS0T1n+auIOBfRvHWsGhZ1wmOntY4xCUl4msPrqT85g6twa6GlDWts6PTtmn8pTrs2hJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599633; c=relaxed/simple;
	bh=Z2f2s6Vx/ME2R1INYuqFan+qX6ijIZlGUXiT7rj2KSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVNQiP7szEz0kdfrN4LuYFtbmgX9vcicf69AEsmOqfWTVJn2MA+LHg46qt60NhmyJLYUzW3oO+Uj4ZqFTi6ArxZTbjgix9y0S8P7nxiJukp/NKyX9YlEXYCjI84iOHW0zx5ICiX2uCSR1WbnvIPfoMIjYj86F9hdgYXYOtbR5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWpOCFtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADFEC113D0;
	Mon, 27 Oct 2025 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761599632;
	bh=Z2f2s6Vx/ME2R1INYuqFan+qX6ijIZlGUXiT7rj2KSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWpOCFtbpGNKYYb9YDxymOO1zXBoD7uCbSiz3rrDCXfMRpj9l7+3drtnBdOAk6bAD
	 kNHccLsFJw3ETR+oBPBvkan9Mm9DAncirjkOgiBBYjVORGMC4/21DdPJO/zn6lbXTA
	 qbBwZSQ5hlLkgP03AqUI5j15XlGk70yA92z4B8hHhlhOCEJkLpQewkhx8OEY1l19mr
	 Em5CAWjQe8r0qjYhMSryJRcNx2lPrz2zZOw1hX0AsMuALBzPma/QxTq6MsuXBIJg3B
	 islSq6FxpuMNkSA+UGoNvtJUaR8XAisCId06wZXWYrxNPYzoOMVVR7t230QmSjtwxQ
	 V46+hf/MgpBpQ==
Date: Mon, 27 Oct 2025 16:13:51 -0500
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 04/15] dt-bindings: mfd: ROHM BD72720
Message-ID: <20251027211351.GC1565353-robh@kernel.org>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>

On Mon, Oct 27, 2025 at 01:45:46PM +0200, Matti Vaittinen wrote:
> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
> charger, LEDs, RTC and a clock gate.
> 
> Add dt-binding doc for ROHM BD72720.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  RFCv1 => v2:
>  - Typofixes
> ---
>  .../bindings/mfd/rohm,bd72720-pmic.yaml       | 269 ++++++++++++++++++
>  1 file changed, 269 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
> new file mode 100644
> index 000000000000..b0d4bc01d199
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
> @@ -0,0 +1,269 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/rohm,bd72720-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD72720 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> +
> +description: |
> +  BD72720 is a single-chip power management IC for battery-powered portable
> +  devices. The BD72720 integrates 10 bucks and 11 LDOs, and a 3000 mA
> +  switching charger. The IC also includes a Coulomb counter, a real-time
> +  clock (RTC), GPIOs and a 32.768 kHz clock gate.
> +
> +# In addition to the properties found from the charger node, the ROHM BD72720
> +# uses properties from a static battery node. Please see the:
> +# Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml

Why is all of this a comment?

> +#
> +# Following properties are used
> +# when present:
> +#
> +# charge-full-design-microamp-hours: Battry capacity in mAh
> +# voltage-max-design-microvolt:      Maximum voltage
> +# voltage-min-design-microvolt:      Minimum voltage system is still operating.
> +# degrade-cycle-microamp-hours:      Capacity lost due to aging at each full
> +#                                    charge cycle.
> +# ocv-capacity-celsius:              Array of OCV table temperatures. 1/table.
> +# ocv-capacity-table-<N>:            Table of OCV voltage/SOC pairs. Corresponds
> +#                                    N.th temperature in ocv-capacity-celsius
> +#
> +# ROHM specific properties:
> +# rohm,voltage-vdr-thresh-microvolt: Threshold for starting the VDR correction
> +# rohm,volt-drop-soc:                Table of capacity values matching the
> +#                                    values in VDR tables.
> +# rohm,volt-drop-high-temp-microvolt: VDR table for high temperature
> +# rohm,volt-drop-normal-temp-microvolt: VDR table for normal temperature
> +# rohm,volt-drop-low-temp-microvolt:  VDR table for low temperature
> +# rohm,volt-drop-very-low-temp-microvolt: VDR table for very low temperature
> +#
> +# VDR tables are (usually) determined for a specific battery by ROHM.
> +# The battery node would then be referred from the charger node:
> +#
> +# monitored-battery = <&battery>;
> +
> +properties:
> +  compatible:
> +    const: rohm,bd72720
> +
> +  reg:
> +    description:
> +      I2C slave address.
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: |

Don't need '|'

> +      The first cell is the pin number and the second cell is used to specify
> +      flags. See ../gpio/gpio.txt for more information.

Don't add new references to old .txt bindings.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    const: bd71828-32k-out
> +
> +  rohm,clkout-open-drain:
> +    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0

0 is already the minimum for unsigned.

> +    maximum: 1
> +
> +  rohm,charger-sense-resistor-milli-ohms:
> +    minimum: 10
> +    maximum: 50
> +    description: |

Don't need '|'

> +      BD72720 has a SAR ADC for measuring charging currents. External sense
> +      resistor (RSENSE in data sheet) should be used. If some other but
> +      30 mOhm resistor is used the resistance value should be given here in
> +      milli Ohms.
> +
> +  regulators:
> +    $ref: ../regulator/rohm,bd77270-regulator.yaml

/schemas/regulator/...

> +    description:
> +      List of child nodes that specify the regulators.
> +
> +  leds:
> +    $ref: ../leds/rohm,bd71828-leds.yaml

/schemas/leds/...

> +
> +  rohm,pin-dvs0:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      BD72720 has 4 different OTP options to determine the use of dvs0-pin.
> +      OTP0 - regulator RUN state control.
> +      OTP1 - GPI.
> +      OTP2 - GPO.
> +      OTP3 - Power sequencer output.
> +      This property specifies the use of the pin.
> +    enum:
> +      - dvs-input
> +      - gpi
> +      - gpo
> +
> +  rohm,pin-dvs1:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      see rohm,pin-dvs0
> +    enum:
> +      - dvs-input
> +      - gpi
> +      - gpo

These 2 could be combined into a single entry in patternProperties.

> +
> +  rohm,pin-exten0:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: BD72720 has an OTP option to use exten0-pin for different
> +      purposes. Set this property accordingly.
> +    const: gpo
> +
> +  rohm,pin-exten1:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: BD72720 has an OTP option to use exten1-pin for different
> +      purposes. Set this property accordingly.
> +    const: gpo

And these 2 also.

> +
> +  rohm,pin-fault_b:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: BD72720 has an OTP option to use fault_b-pin for different
> +      purposes. Set this property accordingly.
> +    const: gpo

Seems like different purposes would have more than 1 option.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - "#clock-cells"
> +  - regulators
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/leds/common.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pmic: pmic@4b {
> +            compatible = "rohm,bd71828";
> +            reg = <0x4b>;

Just 1 complete example in the mfd schema and drop this example.

> +
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> +
> +            clocks = <&osc 0>;
> +            #clock-cells = <0>;
> +            clock-output-names = "bd71828-32k-out";
> +
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            gpio-reserved-ranges = <0 1>, <2 1>;
> +
> +            rohm,charger-sense-resistor-ohms = <10000000>;
> +
> +            regulators {
> +                buck1: BUCK1 {
> +                    regulator-name = "buck1";
> +                    regulator-min-microvolt = <500000>;
> +                    regulator-max-microvolt = <2000000>;
> +                    regulator-ramp-delay = <2500>;
> +                };
> +                buck2: BUCK2 {
> +                    regulator-name = "buck2";
> +                    regulator-min-microvolt = <500000>;
> +                    regulator-max-microvolt = <2000000>;
> +                    regulator-ramp-delay = <2500>;
> +                };
> +                buck3: BUCK3 {
> +                    regulator-name = "buck3";
> +                    regulator-min-microvolt = <1200000>;
> +                    regulator-max-microvolt = <2000000>;
> +                };
> +                buck4: BUCK4 {
> +                    regulator-name = "buck4";
> +                    regulator-min-microvolt = <1000000>;
> +                    regulator-max-microvolt = <1800000>;
> +                };
> +                buck5: BUCK5 {
> +                    regulator-name = "buck5";
> +                    regulator-min-microvolt = <2500000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +                buck6: BUCK6 {
> +                    regulator-name = "buck6";
> +                    regulator-min-microvolt = <500000>;
> +                    regulator-max-microvolt = <2000000>;
> +                    regulator-ramp-delay = <2500>;
> +                };
> +                buck7: BUCK7 {
> +                    regulator-name = "buck7";
> +                    regulator-min-microvolt = <500000>;
> +                    regulator-max-microvolt = <2000000>;
> +                    regulator-ramp-delay = <2500>;
> +                };
> +                ldo1: LDO1 {
> +                    regulator-name = "ldo1";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +                ldo2: LDO2 {
> +                    regulator-name = "ldo2";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +                ldo3: LDO3 {
> +                    regulator-name = "ldo3";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +                ldo4: LDO4 {
> +                    regulator-name = "ldo4";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +                ldo5: LDO5 {
> +                    regulator-name = "ldo5";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +                ldo6: LDO6 {
> +                    regulator-name = "ldo6";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                };
> +                ldo7_reg: LDO7 {
> +                    regulator-name = "ldo7";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +            };
> +
> +            leds {
> +                compatible = "rohm,bd71828-leds";
> +
> +                led-1 {
> +                    rohm,led-compatible = "bd71828-grnled";
> +                    function = LED_FUNCTION_INDICATOR;
> +                    color = <LED_COLOR_ID_GREEN>;
> +                };
> +                led-2 {
> +                    rohm,led-compatible = "bd71828-ambled";
> +                    function = LED_FUNCTION_CHARGING;
> +                    color = <LED_COLOR_ID_AMBER>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.51.0
> 




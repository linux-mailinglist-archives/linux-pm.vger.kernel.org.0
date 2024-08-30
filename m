Return-Path: <linux-pm+bounces-13248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6069665C0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662231F21C32
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40A1BDA92;
	Fri, 30 Aug 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9qaZLeM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0661BD51C;
	Fri, 30 Aug 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032025; cv=none; b=aHHgI6kcGADiCCMD0Mpts77g+pDrSMPap5G5rBkrFqF8XEXoVg8PA/vxUVT1bskZLYYUwHaJ676Z7Deu6Kd53+49mFqBRPbLhXGyopYUKw57F42QmLAoJIKLBdQ/IAjCAV3ApdTKCmV64KfqZUvQqBMLUDAqcD86z+zK3KYNATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032025; c=relaxed/simple;
	bh=4I1SF9MlKPLJEAdurQCU+q1uEFvlwjJbG9qMUIIDxvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO0Q6YOoPnOpm0ljsJ0nFKwUOn6hpEKANaUSqwWTZwEITfixGnq0CV+nKoCXGs2wr3CWO5MojXBlXTF+IzBx95TQwdBYpwPeB3HhC9ogZD9rdmPcV2owZA0dp94/8/mQRInRG8Pgid+dIdGVA6yaCCoGlsB4joZjRl0Kt4LNKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9qaZLeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0043C4CEC5;
	Fri, 30 Aug 2024 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032025;
	bh=4I1SF9MlKPLJEAdurQCU+q1uEFvlwjJbG9qMUIIDxvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9qaZLeMzRtO4nSWAaulicPoRXBOiYa0PuN9kGLl1fjH13XCgNavYSxe5CILoZ6N7
	 OA5TXnbxcdlR3SgCd2w9sYHQ3y9hHKAfxtei1fVHBGZzf879Px6qy5PNimRdlAuA1l
	 9mKTqLYG6MrR1qyNMtiCRcyTZaMSiTUTLTuXODkaX3cGikMMli/8BgUsrPrgx/cHsc
	 3Supb1AWFrc0AGsWxFAxZTcp4zwgdiawvKVvGWNHWsipwj4G2UEQ0zOit23064NL5i
	 egv3vBfBXxc0WGo+qoNhUWLfTFInfJVi1rMAaSr2ZYvD13MT2QdHbvmX3hbiPvr19t
	 D7IWVRtp58OtA==
Date: Fri, 30 Aug 2024 10:33:43 -0500
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Sean Wang <sean.wang@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <20240830153343.GA4175444-robh@kernel.org>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
 <20240830110732.30080-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110732.30080-2-macpaul.lin@mediatek.com>

On Fri, Aug 30, 2024 at 07:07:27PM +0800, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> MT6323/MT6358/MT6397 are PMIC devices with multiple function of
> subdevices. They have some variant of the combinations of subdevices
> but share a common PMIC design.
> 
> New updates in this conversion:
>  - RTC:
>   - Convert rtc-mt6397.txt and add it into parent's mt6397 PMIC DT schema.
>  - regulators:
>   - Align generic names "regulators" instead of origin names.
>   - mt6323-regulator: Replace "txt" reference with mt6323-regulaotr.yaml
>   - mt6358-regulator: Replace "txt" reference with mt6358-regulator.yaml
>   - mt6397-regulator: Replace "txt" reference with mt6397-reuglator.yaml
>  - audio-codec:
>   - Align generic name "audio-codec" for codec and sound subdevices.
>   - Add "mediatek,dmic-mode" and "Avdd-supply".
>  - clocks:
>   - Align generic name "clocks" for clockbuffer subdevices.
>  - leds:
>   - Convert leds-mt6323.txt and add it into parent's mt6397 PMIC DT schema.
>  - keys:
>   - Add more specific descriptions for power and home keys.
>   - Add compatible: mediatek,mt6358-keys
>  - power-controller:
>   - Add property #power-domain-cells for fixing dt-binding check error.
>   - Add "Baseband power up" as the explaination of abbrevitation "BBPU".
>  - pinctrl:
>   - Align generic name "pinctrl" instead of "pin-controller".
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt6397.yaml         | 1026 +++++++++++++++++
>  .../devicetree/bindings/mfd/mt6397.txt        |  110 --
>  2 files changed, 1026 insertions(+), 110 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
> 
> Changes for v1:
>  - This patch depends on conversion of mediatek,mt6397-regulator.yaml
>    [1] https://lore.kernel.org/lkml/20240807091738.18387-1-macpaul.lin@mediatek.com/T/
> 
> Changes for v2:
>  - This patch has been made base on linux-next/master git repo.
>  - Keep the parent and child relationship with mediatek,pwrap in description.
>    [2] https://lore.kernel.org/all/20240826-slurp-earphone-0d5173923ae8@spud/
>  - Keep the $ref for regulators since dt_binding_check didn't report any issue
>    based on linux-next/master repo.  
>  - Fix description of mt6397/mt6323 devices, use "power management chip"
>    instead of "multifunction device"
>  - Drop unnecessary comments or description according to the review.
>  - Convert sub-modules to DT Schema:
>   - RTC, LEDs, power-controllers, regulators
>  - Drop duplicate sub node name and description for sub-modules
>   - RTC, Keys
>  - examples: 
>   - drop parent pwrap node
>   - Add examples from mediatek,mt6323-regulator.yaml
>   - Add examples from mediatek,mt6358-regulator.yaml
>   - Add examples from mediatek,mt6397-regulator.yaml
>   - Complete the examples as could as possible.
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> new file mode 100644
> index 0000000..f5bea33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -0,0 +1,1026 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6397/MT6323 Multifunction Device (PMIC)
> +
> +maintainers:
> +  - Sen Chu <sen.chu@mediatek.com>
> +  - Macpaul Lin <macpaul.lin@mediatek.com>
> +
> +description: |
> +  MT6397/MT6323 is a power management system chip.
> +  Please see the sub-modules below for supported features.
> +
> +  MT6397/MT6323 is a multifunction device with the following sub modules:
> +  - Regulators
> +  - RTC
> +  - Audio codec
> +  - GPIO
> +  - Clock
> +  - LED
> +  - Keys
> +  - Power controller
> +
> +  It is interfaced to host controller using SPI interface by a proprietary hardware
> +  called PMIC wrapper or pwrap. MT6397/MT6323 PMIC is a child device of pwrap.
> +  See the following for pwrap node definitions:
> +  Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt6323
> +          - mediatek,mt6331 # "mediatek,mt6331" for PMIC MT6331 and MT6332.
> +          - mediatek,mt6357
> +          - mediatek,mt6358
> +          - mediatek,mt6359
> +          - mediatek,mt6397
> +      - items:
> +          - enum:
> +              - mediatek,mt6366
> +          - const: mediatek,mt6358
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  rtc:
> +    type: object
> +    $ref: /schemas/rtc/rtc.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      MT6397 Real Time Clock.

Blank line

> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - mediatek,mt6323-rtc
> +              - mediatek,mt6331-rtc
> +              - mediatek,mt6358-rtc
> +              - mediatek,mt6397-rtc
> +          - items:
> +              - enum:
> +                  - mediatek,mt6366-rtc
> +              - const: mediatek,mt6358-rtc

Blank line between DT properties

> +      start-year: true
> +    required:
> +      - compatible
> +
> +  regulators:
> +    type: object
> +    oneOf:
> +      - $ref: /schemas/regulator/mediatek,mt6323-regulator.yaml
> +      - $ref: /schemas/regulator/mediatek,mt6358-regulator.yaml
> +      - $ref: /schemas/regulator/mediatek,mt6397-regulator.yaml
> +    unevaluatedProperties: false
> +    description:
> +      List of child nodes that specify the regulators.
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - mediatek,mt6323-regulator
> +              - mediatek,mt6358-regulator
> +              - mediatek,mt6397-regulator
> +          - items:
> +              - enum:
> +                  - mediatek,mt6366-regulator
> +              - const: mediatek,mt6358-regulator

You need the references or compatible, but not both. It's more efficient 
if you list the compatibles along with a 'additionalProperties: true'. 
Otherwise, the referenced schemas have to all be applied and the 
matching one will be applied twice.

Also, for compatible here, just use 'contains' and list all possible 
compatibles. The exact combinations are enforced in the regulator 
schemas.


> +
> +  audio-codec:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Audio codec support with MT6397 and MT6358.
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - mediatek,mt6397-codec
> +              - mediatek,mt6358-sound
> +          - items:
> +              - enum:
> +                  - mediatek,mt6366-sound
> +              - const: mediatek,mt6358-sound
> +
> +      mediatek,dmic-mode:
> +        description: |
> +          Indicates how many data pins are used to transmit two channels of PDM
> +          signal.
> +          0 - two wires;
> +          1 - one wire;
> +          Default value is 0.
> +        enum: [0, 1]
> +        default: 0
> +
> +      Avdd-supply:
> +        description: Power source of AVDD.
> +
> +    required:
> +      - compatible
> +
> +  clocks:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      This is a clock buffer node for mt6397. However, there are no sub nodes
> +      or any public document exposed in public.
> +    properties:
> +      compatible:
> +        const: mediatek,mt6397-clk
> +      '#clock-cells':
> +        const: 1
> +    required:
> +      - compatible
> +
> +  leds:
> +    type: object
> +    additionalProperties: false
> +    description:

You need '|' or '>' to preserve line breaks.

> +      MT6323 LED controller is subfunction provided by MT6323 PMIC, so the LED
> +      controllers are defined as the subnode of the function node provided by MT6323
> +      PMIC controller that is being defined as one kind of Muti-Function Device (MFD)
> +      using shared bus called PMIC wrapper for each subfunction to access remote
> +      MT6323 PMIC hardware.
> +
> +      Each led is represented as a child node of the mediatek,mt6323-led that
> +      describes the initial behavior for each LED physically and currently only four
> +      LED child nodes can be supported.
> +
> +    properties:
> +      compatible:
> +        oneOf:

Only 1 entry, don't need oneOf.

> +          - enum:
> +              - mediatek,mt6323-led
> +              - mediatek,mt6331-led
> +              - mediatek,mt6332-led
> +      "#address-cells":
> +        const: 1

blank line

> +      "#size-cells":
> +        const: 0

blank line. And so on...

> +      reg:
> +        description:
> +          LED channel number (0..3)
> +        minimum: 0
> +        maximum: 3

Doesn't use the led binding?

> +
> +  keys:
> +    type: object
> +    $ref: /schemas/input/mediatek,pmic-keys.yaml
> +    unevaluatedProperties: false
> +    description:
> +      Power and Home keys.
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - mediatek,mt6323-keys
> +              - mediatek,mt6331-keys
> +              - mediatek,mt6358-keys
> +              - mediatek,mt6397-keys
> +
> +  power-controller:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      The power controller which could be found on PMIC is responsible for
> +      externally powering off or on the remote MediaTek SoC through the
> +      circuit BBPU (baseband power up).
> +    properties:
> +      compatible:
> +        const: mediatek,mt6323-pwrc
> +      '#power-domain-cells':
> +        const: 0
> +
> +  pinctrl:
> +    type: object
> +    $ref: /schemas/pinctrl/mediatek,mt65xx-pinctrl.yaml
> +    unevaluatedProperties: false
> +    description:
> +      Pin controller
> +    properties:
> +      compatible:
> +        const: mediatek,mt6397-pinctrl
> +
> +required:
> +  - compatible
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mt6323_pmic: pmic {

Drop unused labels.

> +        compatible = "mediatek,mt6323";
> +        interrupt-parent = <&pio>;
> +        interrupts = <150 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        mt6323_leds: leds {
> +                compatible = "mediatek,mt6323-led";
> +                #address-cells = <1>;
> +                status = "disabled";

Examples shouldn't be disabled.

> +        };
> +
> +        mt6323_regulator: regulators {
> +            compatible = "mediatek,mt6323-regulator";
> +            mt6323_vproc_reg: buck_vproc {
> +                regulator-name = "vproc";
> +                regulator-min-microvolt = < 700000>;
> +                regulator-max-microvolt = <1350000>;
> +                regulator-ramp-delay = <12500>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };


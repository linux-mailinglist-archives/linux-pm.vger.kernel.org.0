Return-Path: <linux-pm+bounces-14322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2680979CF7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 10:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B640C281FBE
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F086148FF6;
	Mon, 16 Sep 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEtV6M4B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C014885B;
	Mon, 16 Sep 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475930; cv=none; b=EGzUuHy0n11xB8o28T0lVi47tt9Y1L8t3YUgt4E8hr/zLR4uEfPQJK7XBlg8IvEGuGN47KWSqcqEaQ5WxLV70fIwwOQVg+68921uVqfBcHfV6myX6AXwzMKHlckstsJzpN8ebDSfuFhAEcioLNuHy0DLfCPrDbhBImqvb/x1CX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475930; c=relaxed/simple;
	bh=CdpVBfk41BeGQA2hFTIaHx5RVS7ilCziIa40PArZJlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk1bPGt5ngxbUtnHS8r3kzF27UsNllqOcyCgOaLPMzTVqMYUrqXv/NiL7vlwhWBj9C7sWnFXQ9Q9j7jgLnVH1gnkHol/xbWspRekQl4M3veBHXra8R/CJDgt0pvtgKnWBKrSj3+kDXg7UnDPL+t8GvGaQU7eFoT9yL1a+Js4RU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEtV6M4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B329AC4CECD;
	Mon, 16 Sep 2024 08:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726475929;
	bh=CdpVBfk41BeGQA2hFTIaHx5RVS7ilCziIa40PArZJlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEtV6M4BB7qzsg5ILp347u3YL3JI9wFjMRly5tQrTc6B8ajSG0bMPU6O5+Ymb9Vv2
	 92AXl7VbnwGOGqQLc8WSg9A1lCMt56wcs3B/S2PA7UzvGoNNFFJ3A+a7aHg7MX7H6c
	 dqj1vNTdmZ3JeR3/kyoH3hhGh6cCgHLY/zwIGUia/ZGfXjJv3Xg/8C9WAiu2X+817i
	 bDTlcY3iSwhaaaoHlCkKmcCyklin1QX26iAodOTfhnVLtIoxPQ19a6fsPzFDk++k/+
	 a0X3KLQf1Ps2LvMFSX4uA7XOLDVf0AShb9yHBgtLPDjRTUOB0BZyMVNlZPK4/DC054
	 8TS7EHRgsL9wQ==
Date: Mon, 16 Sep 2024 10:38:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-sound@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>, 
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <a6ufiqp4g7cbryggha3q5fnfr4deuf6abvxy24ttjoigadcgvm@h4xnbuxsv2hi>
References: <20240914132811.9637-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914132811.9637-1-macpaul.lin@mediatek.com>

On Sat, Sep 14, 2024 at 09:28:11PM +0800, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> subdevices. They share a common PMIC design but have variations in
> subdevice combinations.
> 
> Key updates in this conversion:
> 
> 1. RTC:
>    - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.
> 
> 2. Regulators:
>    - Align to generic name "regulators".
>    - Update references from .txt to .yaml for mt6323, mt6358, and mt6397
>      regulators.
>    - Simplify regulator name labels in device tree examples.
> 
> 3. Audio Codec:
>    - Convert sound/mt6358.txt and merge into parent MT6397 PMIC DT schema.
>    - Align to generic name "audio-codec" for codec and sound subdevices.
>    - Add "mediatek,dmic-mode" and "Avdd-supply" properties.
> 
> 4. Clocks:
>    - Align to generic name "clocks" for clockbuffer subdevices.
> 
> 5. LEDs:
>    - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schema.
>    - Update LED binding.
> 
> 6. Keys:
>    - Add detailed descriptions for power and home keys.
>    - Add compatible: mediatek,mt6358-keys.
> 
> 7. Power Controller:
>    - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
>      schema.
>    - Add #power-domain-cells property to fix dt-binding check error.
>    - Clarify "BBPU" as "Baseband power up".
> 
> 8. Pinctrl:
>    - Align to generic name "pinctrl" instead of "pin-controller".
> 
> 9. Compatible:
>    - Drop "mediatek,mt6357" since there is a separated DT Schema
>      for PMIC MT6357.
> 
> Additional updates:
> - MAINTAINERS: Add co-maintainers and reference to
>   mfd/mediatek,mt6397.yaml for LED and power-controller drivers.
> - input/mediatek,pmic-keys.yaml: Update reference to
>   mfd/mediatek,mt6397.yaml.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>


Limited review since this fails tests.

> ---
>  .../bindings/input/mediatek,pmic-keys.yaml    |    2 +-
>  .../devicetree/bindings/leds/leds-mt6323.txt  |   63 -
>  .../bindings/mfd/mediatek,mt6397.yaml         | 1077 +++++++++++++++++
>  .../devicetree/bindings/mfd/mt6397.txt        |  110 --
>  .../bindings/power/reset/mt6323-poweroff.txt  |   20 -
>  .../devicetree/bindings/rtc/rtc-mt6397.txt    |   31 -
>  .../devicetree/bindings/sound/mt6358.txt      |   26 -
>  MAINTAINERS                                   |    8 +-
>  8 files changed, 1084 insertions(+), 253 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
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
> Changes for v3:
>  - Rebased on linux-next/master git repo near next-20240906.
>  - Revise commit message.
>  - Regulators:
>   - Use "additionalProperties: true" and add "contains" for matching
>     $ref DT bindings.
>   - Simplify regulator name labels in device tree examples.
>  - LEDs:
>   - Use LED bindings.
>  - Squash following patches in v2 for removing old text format DT bindings
>    into this patch, includes:
>   - leds-mt6323.txt, mt6323-poweroff.txt, rtc-mt6397.txt, sound/mt6358.txt.
>  - Fix file format of DT schemas, add blank between properties.
>  - Fix 'make checkrefdoc' errors, update reference in mediatek,pmic-keys.yaml.
> 
> Changes for v4:
>  - Remove "mediatek,mt6357" from PMIC's compatible string since there is a
>    seperated DT schema for PMIC mt6357.
> 

...

> +$id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6397/MT6323 Multifunction Device (PMIC)

s/Multifunction Device/PMIC/

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
> +
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
> +
> +      start-year: true

Drop

> +
> +    required:
> +      - compatible
> +
> +  regulators:
> +    type: object
> +    description:
> +      List of child nodes that specify the regulators.
> +    additionalProperties: true


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
> +
> +    required:
> +      - compatible
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: mediatek,mt6323-regulator
> +
> +        then:
> +          $ref: /schemas/regulator/mediatek,mt6323-regulator.yaml
> +
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: mediatek,mt6358-regulator
> +
> +        then:
> +          $ref: /schemas/regulator/mediatek,mt6358-regulator.yaml
> +
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: mediatek,mt6397-regulator
> +
> +        then:
> +          $ref: /schemas/regulator/mediatek,mt6397-regulator.yaml

Drop this entire allOf. Not really needed.

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
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      This is a clock buffer node for mt6397. However, there are no sub nodes
> +      or any public document exposed in public.

Blank line

> +    properties:
> +      compatible:
> +        const: mediatek,mt6397-clk
> +      '#clock-cells':
> +        const: 1

Blank line

> +    required:
> +      - compatible
> +
> +  leds:
> +    type: object
> +    additionalProperties: false
> +    description: |
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
> +        enum:
> +          - mediatek,mt6323-led
> +          - mediatek,mt6331-led
> +          - mediatek,mt6332-led
> +
> +      reg:
> +        maxItems: 1
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^led@[0-3]$":
> +        type: object
> +        $ref: /schemas/leds/common.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            description:
> +              LED channel number (0..3)
> +            minimum: 0
> +            maximum: 3
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - compatible
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +  keys:
> +    type: object
> +    $ref: /schemas/input/mediatek,pmic-keys.yaml
> +    unevaluatedProperties: false
> +    description:
> +      Power and Home keys.
> +    properties:
> +      compatible:
> +        enum:
> +          - mediatek,mt6323-keys
> +          - mediatek,mt6331-keys
> +          - mediatek,mt6358-keys
> +          - mediatek,mt6397-keys

You have $ref so lisitng properties is confusing. What do you want to
achieve here?

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
> +
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

Also confusing. I don't think you got my point from previous review.

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
> +    #include <dt-bindings/leds/common.h>
> +
> +    pmic {
> +        compatible = "mediatek,mt6323";
> +        interrupt-parent = <&pio>;
> +        interrupts = <150 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        leds {
> +                compatible = "mediatek,mt6323-led";
> +                #address-cells = <1>;
> +                #size-cells = <0>;

Messed indentation.

> +        };

Best regards,
Krzysztof



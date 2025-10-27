Return-Path: <linux-pm+bounces-36929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA80C1179E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 22:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59291A605E8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5435D3254B1;
	Mon, 27 Oct 2025 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl7iaCs8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E131062D;
	Mon, 27 Oct 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599298; cv=none; b=s01HyFu3LQeTpRgUat/Ve4j2OucdMNso0sGuDTxh0A9234Jx8fqYbv8pthu/qYZP7MI4FyxoFAjhVOX+Po2fzri7IY2t+MLCQ5k0bMuc18OIVIUCjvgnir4ipYQ1Xi/K3a99NwgyR9ULhk8PrutCQGrPA4ri46fXv9ptguJhMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599298; c=relaxed/simple;
	bh=ma+k8nldqJngQini1R8j787y6UpbAMZD6PHdP4b+ilU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp8Gkvx0hCKjhreYlGa2mBQD+M/mUiTKi3pgRCavAZcvOTp2JU0YAM/dMGnnY4zgW4lN7C/wzP9h4J8ksa60GxNyuHNFuxbXz3SzY35i092o0c/1o8W5Awvz1tgn9OQLMNU9B65BZd1g7fnYpDdl+G6PxROALyMI1o6m3qdJJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl7iaCs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEFAC4CEF1;
	Mon, 27 Oct 2025 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761599297;
	bh=ma+k8nldqJngQini1R8j787y6UpbAMZD6PHdP4b+ilU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jl7iaCs8Q/W05FCWMpt5JBolxcz4wFF64dKoBRAh5fVrVlJ+/EsrIOf7ioNgK1QXc
	 WdsZjLMaZ0/yDnCatimSNRhdvrt3r2AzuVhFZIQnUPpZXLUNvwByaqCEv0IeBjJ71k
	 kyn2W5Ic6Kr88x/f01dOPrd/RdxHPh6q33grRot0gbXArIUJn+9KXJcflzJa0dnXnL
	 OymRKx4LXpUm/4+s9CMYLqnIATkp6Ci2GtCKPEGlOA+5cl6UY4rTNMLzob3nNgY92y
	 JoJNv5RBsTCVSem6xmtAxyqx3doHWQNMuEGkB3/6HcRveaMrV96oKbhGC8oKLPx6ma
	 cknD2Iobo5lpA==
Date: Mon, 27 Oct 2025 16:08:16 -0500
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
Subject: Re: [PATCH v2 03/15] dt-bindings: power: supply: BD72720 managed
 battery
Message-ID: <20251027210816.GB1565353-robh@kernel.org>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <e8d0273bcf0ac67382e17c40be87d345e28ac06c.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d0273bcf0ac67382e17c40be87d345e28ac06c.1761564043.git.mazziesaccount@gmail.com>

On Mon, Oct 27, 2025 at 01:45:23PM +0200, Matti Vaittinen wrote:
> The BD72720 PMIC has a battery charger + coulomb counter block. These
> can be used to manage charging of a lithium-ion battery and to do fuel
> gauging.
> 
> ROHM has developed a so called "zero-correction" -algorithm to improve
> the fuel-gauging accuracy close to the point where battery is depleted.
> This relies on battery specific "VDR" tables, which are measured from
> the battery, and which describe the voltage drop rate. More thorough
> explanation about the "zero correction" and "VDR" parameters is here:
> https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com/
> 
> Document the VDR zero-correction specific battery properties used by the
> BD72720 and some other ROHM chargers.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
>  RFCv1 => v2:
>  - Add units to rohm,volt-drop-soc (tenths of %)
>  - Give real temperatures matching the VDR tables, instead of vague
>    'high', 'normal', 'low', 'very low'. (Add table of temperatures and
>    use number matching the right temperature index in the VDR table name).
>  - Fix typoed 'algorithm' in commit message.
> 
> The parameters are describing the battery voltage drop rates - so they
> are properties of the battery, not the charger. Thus they do not belong
> in the charger node.
> 
> The right place for them is the battery node, which is described by the
> generic "battery.yaml". I was not comfortable with adding these
> properties to the generic battery.yaml because they are:
>   - Meaningful only for those charger drivers which have the VDR
>     algorithm implemented. (And even though the algorithm is not charger
>     specific, AFAICS, it is currently only used by some ROHM PMIC
>     drivers).
>   - Technique of measuring the VDR tables for a battery is not widely
>     known. AFAICS, only folks at ROHM are measuring those for some
>     customer products. We do have those tables available for some of the
>     products though (Kobo?).
> ---
>  .../power/supply/rohm,vdr-battery.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml b/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
> new file mode 100644
> index 000000000000..1ab3418d4338
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/rohm,vdr-battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery managed by the BD72720 PMIC
> +
> +maintainers:
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> +
> +description:
> +  A battery which has VDR parameters measuerd for ROHM chargers.
> +
> +allOf:
> +  - $ref: battery.yaml#
> +
> +properties:
> +  rohm,voltage-vdr-thresh-microvolt:
> +    description: Threshold for starting the VDR correction

No constraints? Is 4000V okay?

> +
> +  rohm,volt-drop-soc:
> +    description: Table of capacity values matching the values in VDR tables.
> +      The value should be given as tenths of a percentage.

We have a standard unit for this too. '-bp' or basis points (1/100 of 
percent).

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  rohm,volt-drop-temperatures-millicelsius:
> +    description: An array containing the temperature in milli celsius, for each
> +      of the VDR lookup table.
> +
> +patternProperties:
> +  '^rohm,volt-drop-[0-9]-microvolt':
> +    description: Table of the voltage drop rate (VDR) values. Each entry in the
> +      table should match a capacity value in the rohm,volt-drop-soc table.
> +      Furthermore, the values should be obtained for the temperature given in
> +      rohm,volt-drop-temperatures-millicelsius table at index matching the
> +      number in this table's name.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    power {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      battery: battery {
> +        compatible = "simple-battery";
> +
> +        ocv-capacity-celsius = <25>;
> +        ocv-capacity-table-0 = <4200000 100 4184314 100 4140723 95 4099487 90
> +          4060656 85 4024350 80 3991121 75 3954379 70 3913265 65 3877821 60
> +          3855577 55 3837466 50 3822194 45 3809012 40 3795984 35 3780647 30
> +          3760505 25 3741532 20 3718837 15 3696698 10 3690594 5 3581427 0>;
> +
> +        rohm,volt-drop-soc = <1000 1000 950 900 850 800 750 700 650 600 550 500
> +          450 400 350 300 250 200 150 100 50 00 (-50)>;
> +
> +        rohm,volt-drop-temperatures-millicelsius = <45000 25000 5000 0>;
> +
> +        rohm,volt-drop-0-microvolt =  <100 100 102 104 106 109 114 124
> +          117 107 107 109 112 116 117 108 109 109 108 109 122 126 130>;
> +
> +        rohm,volt-drop-1-microvolt = <100 100 102 105 98 100 105 102
> +          101 99 98 100 103 105 109 117 111 109 110 114 128 141 154>;
> +
> +        rohm,volt-drop-2-microvolt = <100 100 98 107 112 114 118 118 112
> +          108 108 110 111 113 117 123 131 144 157 181 220 283 399>;
> +
> +        rohm,volt-drop-3-temp-microvolt = <86 86 105 109 114 110 115 115
> +          110 108 110 112 114 118 124 134 136 160 177 201 241 322 403>;
> +
> +        rohm,voltage-vdr-thresh-microvolt = <4150000>;
> +
> +        charge-full-design-microamp-hours = <1799000>;
> +        voltage-max-design-microvolt = <4200000>;
> +        voltage-min-design-microvolt = <3500000>;
> +        degrade-cycle-microamp-hours = <131>;
> +      };
> +    };
> -- 
> 2.51.0
> 




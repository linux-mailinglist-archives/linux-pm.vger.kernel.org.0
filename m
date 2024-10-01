Return-Path: <linux-pm+bounces-14987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9398B44A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 08:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3741C23313
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650F1BC08D;
	Tue,  1 Oct 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClxzX++Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473C1BC077;
	Tue,  1 Oct 2024 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764152; cv=none; b=rS5/21JNrSaVU4L3AXZPL00VTHWpsuJ380vHuqYLvZWSSIjdhtYEGU8J8cjnS4t9HxjKlOTvCAJesSRsGvzPRtxZ2/QHU6hbXX8YdGpVBhgNITTIEJUe77hd/l90MomCtYXBu0MfHxeFplbg27k9aBMVlw69TI/LpW9ApBwZ4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764152; c=relaxed/simple;
	bh=0XqIWLSy+r1tAJqu9dtKMYNrWWKnDsQbZXqh+mGvbpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGq77sTHF0tmIm7K2sadKNo1x8YP8IHHvgT2iQEnkL3psWptX0/jGTloq4goippPlKkCUiPNq2IVyAXJjr+GkLZ2aG9PQ0N4y6exb/X4gZyPdbOaLbnbDbPmlaFt4qck5iC5BIZAB01qdK7gC/5mZaW4fqcsdx9gsO0pf0U9AHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClxzX++Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC49C4CEC6;
	Tue,  1 Oct 2024 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727764151;
	bh=0XqIWLSy+r1tAJqu9dtKMYNrWWKnDsQbZXqh+mGvbpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClxzX++YUuvJ3p1LbcwvLLoR0bG747zASAaHUnYOKQfMNbz77FvcrcInkXxyvHPxc
	 1zrLnUepPkjPAzv7ZWA00nln6ZIlLG8mO2Boz4yYxAugcfg7mqR/tuP99spZABoZij
	 4aWJCT2dslclOzQ57GloMaQ3OHBKCFzCAn18Yef4TohxqHrZ+GB+na9Kk7vVquPiG7
	 R/4ANhqGbhioQMljr/59MmgeN+Q760Y1wNEnrISrAKzcHqqe1nWU7gF/i1rczTmPG8
	 7AM+HkxTDZOU8RBJRgZTMmfvoqriNEWkdoRYZwDn3gW+3QFJO0RNVFdwdVK/gTtUxL
	 x9cZAl4+cTIgQ==
Date: Tue, 1 Oct 2024 08:29:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v7 3/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <psjwbo2vecr54vmz5ib2eurhpcaynpc67rc2nwuj2gtej6gqiu@4ysahn2ghthf>
References: <20240930073311.1486-1-macpaul.lin@mediatek.com>
 <20240930073311.1486-3-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930073311.1486-3-macpaul.lin@mediatek.com>

On Mon, Sep 30, 2024 at 03:33:11PM +0800, Macpaul Lin wrote:
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
>    - Add a new 'mt6359-regulator' to the compatibles of regulators.

Why?

>      Merge from the other patch [1].
> 
> 3. ADC:
>    - Add a new 'adc' property and include a $ref for sub-device node of
>      MT6359 PMIC AUXADC: 'mediatek,mt6359-auxadc'.
>      Merge from the other patch [1].
> 
> 4. Audio Codec:
>    - Simplify Audio Codec part with updating compatible items.
>    - Add 'mt6359-codec' to the compatible

Why?
.
> 
> 5. Clocks:
>    - Align to generic name "clocks" for clockbuffer subdevices.
> 
> 6. LEDs:
>    - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schema.
>    - Update LED binding.
> 
> 7. Keys:
>    - Add detailed descriptions for power and home keys.
>    - Add compatible: mediatek,mt6358-keys.
> 
> 8. Power Controller:
>    - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
>      schema.
>    - Add #power-domain-cells property to fix dt-binding check error.
>    - Clarify "BBPU" as "Baseband power up".
> 
> 9. Pinctrl:
>    - Align to generic name "pinctrl" instead of "pin-controller".
> 
> 10. Compatible:
>    - Drop "mediatek,mt6357" since there is a separated DT Schema
>      for PMIC MT6357.
> 
> 11. Examples:
>    - MT6323: Retain complete examples for this PMIC.
>    - MT6358 and MT6397: simplify settings in regulators.
>     - Preserve "audio-codec", "clocks", "pinctrl", "rtc", and "keys"
>       sections as they contain typical settings for different PMICs.
> 
> Additional updates:
> - MAINTAINERS: Add co-maintainers and reference to
>   mfd/mediatek,mt6397.yaml for LED and power-controller drivers.
> - input/mediatek,pmic-keys.yaml: Update reference to
>   mfd/mediatek,mt6397.yaml.
> 
> References:
> [1] https://lore.kernel.org/all/20240925171156.9115-1-macpaul.lin@mediatek.com/
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---

> +
> +  adc:
> +    type: object
> +    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
> +    unevaluatedProperties: false
> +
> +  audio-codec:
> +    type: object
> +    description:
> +      Audio codec support with MT6358, MT6359, and MT6397.
> +    additionalProperties: true

No, this cannot be true. Schema is incomplete for listed compatibles.

> +
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - mediatek,mt6358-sound
> +              - mediatek,mt6359-codec

There was no such compatible.

Why do you add non-existing compatibles during conversion?



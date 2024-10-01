Return-Path: <linux-pm+bounces-14991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147298B48E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 08:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18502281317
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 06:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6301BBBF1;
	Tue,  1 Oct 2024 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM9Qze3j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311929CFE;
	Tue,  1 Oct 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764574; cv=none; b=fvTmESArucLk5UFqfKNIb0Y+fBlvdQRcbQSSLPEeqJTxa9VNTAhjN+x+rem9DTXkU4pJ1L4OMYemZmoffjODAmVFuoobYRJysafBhow7VNdUAb+oAgcEDVl5RKSY4/lWKNLYWNqO+jn0Zczkmw+gbIY7nW87ovf4St+xCuSBbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764574; c=relaxed/simple;
	bh=5Ftd+dqk4Q7g8teiLXmA8zMoEEKce8VYjntmh5RA21Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ETN7E/ndGAQ7urxqxPHG+8h4gUCi/bsD90CdmarINIrbig9O6cBrrf3/7Ky5DI59JaYAxnThd63SR53kzXtH+chNICBpmhAlmk2nCKxFRtq/GkW6hAevjv0OGAFlrm6NPMa/5fIE4sPWayLvqX0PPdoRQZvMFKLGbSMYkt8jtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM9Qze3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748BDC4CEC6;
	Tue,  1 Oct 2024 06:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727764574;
	bh=5Ftd+dqk4Q7g8teiLXmA8zMoEEKce8VYjntmh5RA21Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=PM9Qze3jU1wFIGvbMOQnkpo8wL0ULtzBax6XZdO0xUhXWApbARa4HS9lpthniFfMD
	 5fnKPYGlNgJpRusb7KlCBSv60EY/8WjjnHRJ1vIKMKBANPdpI3BP+wErV4cljs1b6B
	 xB9L3Y5+YVSM9ALU7OoUJ93Q5YPhcdNoEwHenE9YaUCE4MYANJzBX9zBIL9R794Oqw
	 4TMHGx15inhdwd0fNJ1H4wz/apd0qma7EMUbVpT4qGAPCbnxXakLCwCgGav2v8bbhU
	 CcisU0oNrIMx3qmD0rBpar7hg6NNcKfQva85fDhnUC5IX3206T/dtYByYLeI1f0NT1
	 buHbDIOJwKlZw==
Message-ID: <5a29ddaf-cc01-498c-943c-b65736e2899e@kernel.org>
Date: Tue, 1 Oct 2024 08:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-sound@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>,
 Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240930073311.1486-1-macpaul.lin@mediatek.com>
 <20240930073311.1486-3-macpaul.lin@mediatek.com>
 <psjwbo2vecr54vmz5ib2eurhpcaynpc67rc2nwuj2gtej6gqiu@4ysahn2ghthf>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <psjwbo2vecr54vmz5ib2eurhpcaynpc67rc2nwuj2gtej6gqiu@4ysahn2ghthf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2024 08:29, Krzysztof Kozlowski wrote:
> On Mon, Sep 30, 2024 at 03:33:11PM +0800, Macpaul Lin wrote:
>> Convert the mfd: mediatek: mt6397 binding to DT schema format.
>>
>> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
>> subdevices. They share a common PMIC design but have variations in
>> subdevice combinations.
>>
>> Key updates in this conversion:
>>
>> 1. RTC:
>>    - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.
>>
>> 2. Regulators:
>>    - Align to generic name "regulators".
>>    - Update references from .txt to .yaml for mt6323, mt6358, and mt6397
>>      regulators.
>>    - Simplify regulator name labels in device tree examples.
>>    - Add a new 'mt6359-regulator' to the compatibles of regulators.
> 
> Why?
> 
>>      Merge from the other patch [1].
>>
>> 3. ADC:
>>    - Add a new 'adc' property and include a $ref for sub-device node of
>>      MT6359 PMIC AUXADC: 'mediatek,mt6359-auxadc'.
>>      Merge from the other patch [1].
>>
>> 4. Audio Codec:
>>    - Simplify Audio Codec part with updating compatible items.
>>    - Add 'mt6359-codec' to the compatible
> 
> Why?
> .
>>
>> 5. Clocks:
>>    - Align to generic name "clocks" for clockbuffer subdevices.
>>
>> 6. LEDs:
>>    - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schema.
>>    - Update LED binding.
>>
>> 7. Keys:
>>    - Add detailed descriptions for power and home keys.
>>    - Add compatible: mediatek,mt6358-keys.
>>
>> 8. Power Controller:
>>    - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
>>      schema.
>>    - Add #power-domain-cells property to fix dt-binding check error.
>>    - Clarify "BBPU" as "Baseband power up".
>>
>> 9. Pinctrl:
>>    - Align to generic name "pinctrl" instead of "pin-controller".
>>
>> 10. Compatible:
>>    - Drop "mediatek,mt6357" since there is a separated DT Schema
>>      for PMIC MT6357.
>>
>> 11. Examples:
>>    - MT6323: Retain complete examples for this PMIC.
>>    - MT6358 and MT6397: simplify settings in regulators.
>>     - Preserve "audio-codec", "clocks", "pinctrl", "rtc", and "keys"
>>       sections as they contain typical settings for different PMICs.
>>
>> Additional updates:
>> - MAINTAINERS: Add co-maintainers and reference to
>>   mfd/mediatek,mt6397.yaml for LED and power-controller drivers.
>> - input/mediatek,pmic-keys.yaml: Update reference to
>>   mfd/mediatek,mt6397.yaml.
>>
>> References:
>> [1] https://lore.kernel.org/all/20240925171156.9115-1-macpaul.lin@mediatek.com/
>>
>> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
> 
>> +
>> +  adc:
>> +    type: object
>> +    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
>> +    unevaluatedProperties: false
>> +
>> +  audio-codec:
>> +    type: object
>> +    description:
>> +      Audio codec support with MT6358, MT6359, and MT6397.
>> +    additionalProperties: true
> 
> No, this cannot be true. Schema is incomplete for listed compatibles.

I saw now your patch for ASoC, so this is fine.

All my other questions stay valid - why are you adding new devices in
patch which is supposed to be ONLY conversion.

> 
>> +
>> +    properties:
>> +      compatible:
>> +        oneOf:
>> +          - enum:
>> +              - mediatek,mt6358-sound
>> +              - mediatek,mt6359-codec
> 
> There was no such compatible.
> 
> Why do you add non-existing compatibles during conversion?
> 

Best regards,
Krzysztof



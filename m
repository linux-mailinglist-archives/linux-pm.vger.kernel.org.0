Return-Path: <linux-pm+bounces-14874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D49883F0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 14:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451E0B2289C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7D918B497;
	Fri, 27 Sep 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO+8I2j4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE818B473;
	Fri, 27 Sep 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439022; cv=none; b=nHAByxD5NqVnQVXV96RVoaHUYIKAkGL0oi6MzMtfIbSrv8zpd5OMOBodaiCYgQbpxGyvb5vz50fLIt4c+pYzTZ2vl7S3kHF/uZVbIy6tn9Ka0P/n2vPBiKu+zqJas6u66tRalmNGAp0LAZxx6EOAfZEaGwNLjcQICRvyTttEFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439022; c=relaxed/simple;
	bh=a1fb3/2UBZXmhRqkIlt5AG6kKqQh2OSO3zovzQzaBPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhFzTfryXS1Nc2yP2vu2uDcFh99DYvRFo7yb+PejBTizHTTIJRWx1gqy22B5Pg0tCVeYdmXMNj4hjehI3SGx0m//ST3h7Ad+W6nvX/+aFHmHajt9R1hu3K0Fzl5ZOqRcoPgMq79LdQslNO4/CjYCtJyU0IIMQbBqkOjEi50j1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO+8I2j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCC5C4CEC4;
	Fri, 27 Sep 2024 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727439021;
	bh=a1fb3/2UBZXmhRqkIlt5AG6kKqQh2OSO3zovzQzaBPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kO+8I2j40xsiiyXCc7khquyhhR3bn7x+jnoITvV8beHU95AhRoeySBj5YHbg2k6FA
	 W4txv3lCvYsw19L/hzS2LEMjjLk4eO9mURhhRlKuhRD+pREaxkWtxStgEau1tPgWxt
	 90h1n8PutJqjK/+YIdP1cq5iRMZGCFkcNXL+QIyaddlhlim95hrnQ2vUDArsZkJp0F
	 koAmSRBE1+rW3aHu7jrN+f5BSdZZP1KrArTLq/5HLPIWCyO0QL8INp2qHAPn/X8zx/
	 z+AleBsbaElWvMpPIjP7rC20hgQ/6Hk+x0xb7/HiUXvB8K/a1VP3zmv1f07w6Gj0CK
	 fW34w6BaYezOA==
Message-ID: <6d3d58c8-18ed-4832-ba2c-09b90641cb7d@kernel.org>
Date: Fri, 27 Sep 2024 14:10:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
To: Macpaul Lin <macpaul.lin@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sean Wang <sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240918064955.6518-1-macpaul.lin@mediatek.com>
 <20240918064955.6518-2-macpaul.lin@mediatek.com>
 <339b4c83-201c-4f63-85d0-b0aa1eb164b0@kernel.org>
 <df270bf2-07f3-71a8-1f67-b8417f7a0719@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <df270bf2-07f3-71a8-1f67-b8417f7a0719@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/09/2024 12:41, Macpaul Lin wrote:
> 
> 
> On 9/27/24 17:45, Krzysztof Kozlowski wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you 
>> have verified the sender or the content.
>>
>> On 18/09/2024 08:49, Macpaul Lin wrote:
>>> Convert the mfd: mediatek: mt6397 binding to DT schema format.
>>>
>>> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
>>> subdevices. They share a common PMIC design but have variations in
>>> subdevice combinations.
>>>
>>> Key updates in this conversion:
>>>
>>> 1. RTC:
>>>    - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.
>>>
>>> 2. Regulators:
>>>    - Align to generic name "regulators".
>>>    - Update references from .txt to .yaml for mt6323, mt6358, and mt6397
>>>      regulators.
>>>    - Simplify regulator name labels in device tree examples.
>>>
>>> 3. Audio Codec:
>>>    - Convert sound/mt6358.txt and merge into parent MT6397 PMIC DT schema.
>>>    - Align to generic name "audio-codec" for codec and sound subdevices.
>>>    - Add "mediatek,dmic-mode" and "Avdd-supply" properties.
>>>
>>> 4. Clocks:
>>>    - Align to generic name "clocks" for clockbuffer subdevices.
>>>
>>> 5. LEDs:
>>>    - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schema.
>>>    - Update LED binding.
>>>
>>> 6. Keys:
>>>    - Add detailed descriptions for power and home keys.
>>>    - Add compatible: mediatek,mt6358-keys.
>>>
>>> 7. Power Controller:
>>>    - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
>>>      schema.
>>>    - Add #power-domain-cells property to fix dt-binding check error.
>>>    - Clarify "BBPU" as "Baseband power up".
>>>
>>> 8. Pinctrl:
>>>    - Align to generic name "pinctrl" instead of "pin-controller".
>>>
>>> 9. Compatible:
>>>    - Drop "mediatek,mt6357" since there is a separated DT Schema
>>>      for PMIC MT6357.
>>>
>>> 10. Examples:
>>>    - MT6323: Retain complete examples for this PMIC.
>>>    - MT6358 and MT6397: simplify settings in regulators.
>>>     - Preserve "audio-codec", "clocks", "pinctrl", "rtc", and "keys"
>>>       sections as they contain typical settings for different PMICs.
>>>
>>> Additional updates:
>>> - MAINTAINERS: Add co-maintainers and reference to
>>>   mfd/mediatek,mt6397.yaml for LED and power-controller drivers.
>>> - input/mediatek,pmic-keys.yaml: Update reference to
>>>   mfd/mediatek,mt6397.yaml.
>>>
>>> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>
>> NAK
>>
>> Follow up patch pointed out this is incorrect. I don't understand this
>> concept of sending knowingly incorrect code, so please sort it out at v7.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Sorry I didn't know mt6359-codec and mt6358-sound are similar device
> until Sept 26 (just yesterday) when I was reviewing the DT
> bindings. Until I've found the previous DT Schema of mt6359-codec 
> incorrect.
> See [1] 
> https://lore.kernel.org/linux-arm-kernel/20240926092519.6556-3-macpaul.lin@mediatek.com/T/
> and [2] 
> https://lore.kernel.org/all/20240926092519.6556-2-macpaul.lin@mediatek.com/
> 
> And.. I don't understand, the origin this patch v6 should be a text file
> conversion, shouldn't we keep the origin content just a conversion and
> trying not to broken other relate modules?

The conversion should be correct. Correct means each compatible has a
schema ending with additional/unevaluatedProperties: false.

If you need to change this binding to "true", it means above statement
was not fulfilled. You did not write proper conversion.

... or I do not understand what you wanted to achieve with the other patch.

> 
> Please help to indicates what is a better approach here:
> 
> Should I merge the properties of mt6359-codec, mt6358-sound, and 
> mt6397-codec
> together and put them all into to mt6359.yaml and redo the converting of 
> mfd/medaitek,mt6397.yaml?

Not sure, I don't know. Are these different devices? How are they
related? I expect you to know this, not me.

The problem is that you send a patch having a finished schema for child
node and then - in next patch in different patchset (!!!) - immediately
change it to false.

So the first code, which was not even merged, is incorrect. This is
heavily misleading.

> 
> That will be much simpler for the audio-codec node for mediatek,mt6397.yaml.
> However there will be a little mismatch from the origin text file.
> 
> Thanks
> Macpaul Lin

Best regards,
Krzysztof



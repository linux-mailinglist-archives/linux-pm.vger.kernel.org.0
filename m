Return-Path: <linux-pm+bounces-14557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A7997E91C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 11:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594CF281B02
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858D194AFE;
	Mon, 23 Sep 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MZ+hq6OI"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EE8479;
	Mon, 23 Sep 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085191; cv=none; b=LeTCLeYw4/vxkRyqI3nbPsIHUNSonuTIBYdT3KhUOwGhOLaxBl1s6w15YhR44Q3RD1CzI+bbhDvAF562SPnSRcLmbwIYOOD3DINYRMev2uP+ajECrTh7AU2rrwZ/mR86jZYBHwUyzNIQ2Zc6o6spsHuWu6kGZ8mNDFUes3bxw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085191; c=relaxed/simple;
	bh=oZq/tJZEKhLPOMgfoJYimVhT73cmX0YvXhNZwch10fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1Qu7lqr6AZUaNEsGMu9lNPVfB1qH2i3KYsNQz5wFFGTAf2GoX0QhYr9/bA1hQpwMNG1IgSmhL2tHXST+TXNZpTvcm4xEvDDzuapTf7t1Uh0dg5ocg7fcQYW/WEhkqUs6X2dehiS6eDoGhiYM/1GlOkO/yY4edHrspZBv5jNHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MZ+hq6OI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727085187;
	bh=oZq/tJZEKhLPOMgfoJYimVhT73cmX0YvXhNZwch10fw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MZ+hq6OINW90+WpTkHHmPOoq2HKPAuvI+1xkqbswtdYsklz/MSFzr68+Q+giSL+I5
	 OzP9T9Zr4wDKneB6nMIYOUVE4Fm3bAbN3ouV21gTJTi2xXnyp7DzwK9oRCcafr5ody
	 WFj5GYNdLHfbZbXWSmPRUUGE0etUK0yOuZdYIbdXxTfyrvzezFQV8LHaNU197eITR9
	 +c9hdBh2po9xsq8ZwmGclZ597SEZhcqwtqv3bVRGUxKmfMJ8PQbFuYjZBdEa1LsKZB
	 wydLnlk5Im0F2Q9H+qjKlLAFoanlLXpwwrXA2ndHDXHHaqAx/wicl937ots20axw9F
	 cIAGwuzXBkXfA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 57D9417E10C2;
	Mon, 23 Sep 2024 11:53:06 +0200 (CEST)
Message-ID: <122e5099-4f0b-41cc-93c9-7ccdfc0207ad@collabora.com>
Date: Mon, 23 Sep 2024 11:53:06 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240918064955.6518-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/09/24 08:49, Macpaul Lin ha scritto:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> subdevices. They share a common PMIC design but have variations in
> subdevice combinations.
> 
> Key updates in this conversion:
> 
> 1. RTC:
>     - Convert rtc-mt6397.txt and merge into parent MT6397 PMIC DT schema.
> 
> 2. Regulators:
>     - Align to generic name "regulators".
>     - Update references from .txt to .yaml for mt6323, mt6358, and mt6397
>       regulators.
>     - Simplify regulator name labels in device tree examples.
> 
> 3. Audio Codec:
>     - Convert sound/mt6358.txt and merge into parent MT6397 PMIC DT schema.
>     - Align to generic name "audio-codec" for codec and sound subdevices.
>     - Add "mediatek,dmic-mode" and "Avdd-supply" properties.
> 
> 4. Clocks:
>     - Align to generic name "clocks" for clockbuffer subdevices.
> 
> 5. LEDs:
>     - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schema.
>     - Update LED binding.
> 
> 6. Keys:
>     - Add detailed descriptions for power and home keys.
>     - Add compatible: mediatek,mt6358-keys.
> 
> 7. Power Controller:
>     - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
>       schema.
>     - Add #power-domain-cells property to fix dt-binding check error.
>     - Clarify "BBPU" as "Baseband power up".
> 
> 8. Pinctrl:
>     - Align to generic name "pinctrl" instead of "pin-controller".
> 
> 9. Compatible:
>     - Drop "mediatek,mt6357" since there is a separated DT Schema
>       for PMIC MT6357.
> 
> 10. Examples:
>     - MT6323: Retain complete examples for this PMIC.
>     - MT6358 and MT6397: simplify settings in regulators.
>      - Preserve "audio-codec", "clocks", "pinctrl", "rtc", and "keys"
>        sections as they contain typical settings for different PMICs.
> 
> Additional updates:
> - MAINTAINERS: Add co-maintainers and reference to
>    mfd/mediatek,mt6397.yaml for LED and power-controller drivers.
> - input/mediatek,pmic-keys.yaml: Update reference to
>    mfd/mediatek,mt6397.yaml.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




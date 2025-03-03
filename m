Return-Path: <linux-pm+bounces-23324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A1A4C540
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 16:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274B11897FB1
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88E215079;
	Mon,  3 Mar 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LtM/BmdP"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFD1F17E5;
	Mon,  3 Mar 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016034; cv=none; b=VWE7QKZLWCJhuLNf+jV5aN8L+TQQjxYaKsg5cuwxf9JdnIEryFDGdRJegtrackuMbxOe6bNsiKz3T9ho8R2Qrhd+f0k8QaLeIeCUrT5BmYiPFH/nEEuaKFcbcUAb37J8jPGYqgsPZIcLm3/81mj5jn4b/AOS+ZjSodrB8Da4fn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016034; c=relaxed/simple;
	bh=jI58B/1xW047HSrQ6NfVLx7fR7HzmQWZHI4E46AshJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB1sgZqSJjAlBkfTr+QjqEjQV47vBZu7jGItX92CZyxnPTbsK634NRpGzHbB0luoVnUJizmzN7uxBce1DQgZQXAK+d6ImOsU80gkUhKxWgrWdAVquDj0xiR5ojYboBaTTX5WYkUbKzyFOmuRJVXYprfWy+T9hNpF3FH4behk8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LtM/BmdP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741016030;
	bh=jI58B/1xW047HSrQ6NfVLx7fR7HzmQWZHI4E46AshJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LtM/BmdP/EpF5iPUTB3zizv0GxX/OyA8rb1G/dB0OPmMYpvTnCr1l8kIEOOPvH6i5
	 9kdIM2i3T1IZOSNTDEY4Hqgq3BTy2wQJZ5RUilr0N8wIkFuHomPYLRM5aMLA9pHJuO
	 e18FZpjrukpQN0QaIorVdzzO4wMP22z8vQnsUhf1rNcO71r5NIvXj5q9JheDgGe3Vu
	 S5eUrMd01cA07FX5hJXwpFgMkDRPaX7d12BLWFYDpKFbwI+PaLjkjPtcCl+Ybgkib/
	 eaWcrV7iD3Cw/rHY06IMD9Hb6odEvJMryQVMcgP4jAc6K7gFPfXo/+xObfo1vpOVYZ
	 pzCiV3L8+wI0Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 94A0517E05A6;
	Mon,  3 Mar 2025 16:33:49 +0100 (CET)
Message-ID: <24d3713c-026a-4ef7-bb7f-19150e06f395@collabora.com>
Date: Mon, 3 Mar 2025 16:33:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] ASoC: dt-bindings: Add document for
 mt6359-accdet
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, kernel@collabora.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-1-5bd633ee0d47@collabora.com>
 <628a81c5-b9f1-4be9-84ec-90022a3526da@collabora.com>
 <0120fe30-43c4-4fec-8b5e-fdb6b382fc2a@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <0120fe30-43c4-4fec-8b5e-fdb6b382fc2a@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 03/03/25 15:45, Nícolas F. R. A. Prado ha scritto:
> On Mon, Mar 03, 2025 at 12:14:51PM +0100, AngeloGioacchino Del Regno wrote:
>> Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
>>> Add dt-binding for the MT6359 ACCDET hardware block.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>>    .../bindings/sound/mediatek,mt6359-accdet.yaml     | 42 ++++++++++++++++++++++
>>>    1 file changed, 42 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..d08a79301409374714c76135b061e20e8e8acfaf
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
>>> @@ -0,0 +1,42 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/mediatek,mt6359-accdet.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MT6359 Accessory Detection
>>> +
>>> +maintainers:
>>> +  - Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> +
>>> +description: |
>>> +  The MT6359 Accessory Detection block is part of the MT6359 PMIC and allows
>>> +  detecting audio jack insertion and removal, as well as identifying the type of
>>> +  events connected to the jack.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,mt6359-accdet
>>> +
>>> +  mediatek,hp-eint-high:
>>> +    type: boolean
>>> +    description:
>>> +      By default, the HP_EINT pin is assumed to be pulled high and connected to
>>
>> Just to be clearer about this pin being an internal one and not externally sourced,
>> so, *not* a SoC GPIO, but somehing that is completely provided and handled by the
>> accdet IP...
>>
>> "By default, the accdet IP's internal HP_EINT pin is assumed to be pulled ..."
> 
> The HP_EINT is an external, not internal, pin of the MT6359 PMIC. It is an input
> pin of the MT6359 IC that gets wired to the tip (left channel) of a 3.5mm audio
> jack to allow for detecting when a plug is connected.
> 
> Since this dt-binding is about an IP in the MT6359 PMIC, I think when saying
> "HP_EINT pin" it is already clear that the pin is on the MT6359 IC, but if you
> think it's necessary I could make it "MT6359's HP_EINT pin".
> 

Eh I should've better clarified - I was meaning that the pin is managed internally,
so we're not managing an external SoC pin.

"MT6359's HP_EINT pin" looks good to me, btw.

Cheers!
Angelo




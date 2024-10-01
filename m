Return-Path: <linux-pm+bounces-15004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74D98B643
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 09:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F921C21EDE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF71BDAA8;
	Tue,  1 Oct 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ixsN0XFA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833642BAF1;
	Tue,  1 Oct 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769414; cv=none; b=E++KXc5ZSfYy8sfRVIUTuyF1PiLXA8IZnhxz6uFBwq9XtCk60aTX60tldDulxGtiIWjBK3l1Vm7Pona/I/0IVXgf7Mc6vSZCqLvzluUteubQc07n5fOEXSlRt9qiFJMcaEL2eiMiakx41NGzvpeLC689Q6f0RWb8fy48VA3TyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769414; c=relaxed/simple;
	bh=kqtCwrNQyrsCPH14IeF49CkrTD3Sxwt2LYZ89HY0hjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sFxjQ9sinNe+sphtTEdv+idoiP4CdKoQTVdFtdkWnSjat1KS6DhDE1s4GnuDWdCvkJiFeETj5HjhDRrOEZJHSbmOcM5iJo6k6T9DzIbLtyWs2ai13yCNGZ97vO3SPuqLqWDGFrFMPw96i3zmRTdrbXckw8ep4y9rSpYZHfkMNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ixsN0XFA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b47bc4707fca11efb66947d174671e26-20241001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=TjMavNplUZELeajR9FcsG6MetaDg0Rbfa8IeC3xIwEU=;
	b=ixsN0XFAJsan5Ev6vc+tKGXpJIGcjVl1HX9AIgoj+lxKnrbYXc6ny+CWdptP/KZUo+YTJdKx2AjVz71BCgkOE360jJOM1VzIj8JAjHytnTY1Nqp2ePMmpK82UbmpnOhd5DoAoAwoCytFOfr+fOvhtu0u28b8JOZp3i6TfD5wZ9I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:42482f59-f8ee-4621-8c1a-6436a83ad0d4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:5b18d79e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: b47bc4707fca11efb66947d174671e26-20241001
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 462655724; Tue, 01 Oct 2024 15:56:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 15:56:44 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 1 Oct 2024 15:56:43 +0800
Message-ID: <52f8b482-cf53-cace-5942-728dcb50ff13@mediatek.com>
Date: Tue, 1 Oct 2024 15:56:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 3/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones
	<lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu
	<sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
	<olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <linux-input@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20240930073311.1486-1-macpaul.lin@mediatek.com>
 <20240930073311.1486-3-macpaul.lin@mediatek.com>
 <psjwbo2vecr54vmz5ib2eurhpcaynpc67rc2nwuj2gtej6gqiu@4ysahn2ghthf>
 <5a29ddaf-cc01-498c-943c-b65736e2899e@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <5a29ddaf-cc01-498c-943c-b65736e2899e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 10/1/24 14:35, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 01/10/2024 08:29, Krzysztof Kozlowski wrote:
>> On Mon, Sep 30, 2024 at 03:33:11PM +0800, Macpaul Lin wrote:
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
>>>    - Add a new 'mt6359-regulator' to the compatibles of regulators.
>> 
>> Why?
>> 
>>>      Merge from the other patch [1].
>>>
>>> 3. ADC:
>>>    - Add a new 'adc' property and include a $ref for sub-device node of
>>>      MT6359 PMIC AUXADC: 'mediatek,mt6359-auxadc'.
>>>      Merge from the other patch [1].
>>>
>>> 4. Audio Codec:
>>>    - Simplify Audio Codec part with updating compatible items.
>>>    - Add 'mt6359-codec' to the compatible
>> 
>> Why?
>> .
>>>
>>> 5. Clocks:
>>>    - Align to generic name "clocks" for clockbuffer subdevices.
>>>
>>> 6. LEDs:
>>>    - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schema.
>>>    - Update LED binding.
>>>
>>> 7. Keys:
>>>    - Add detailed descriptions for power and home keys.
>>>    - Add compatible: mediatek,mt6358-keys.
>>>
>>> 8. Power Controller:
>>>    - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
>>>      schema.
>>>    - Add #power-domain-cells property to fix dt-binding check error.
>>>    - Clarify "BBPU" as "Baseband power up".
>>>
>>> 9. Pinctrl:
>>>    - Align to generic name "pinctrl" instead of "pin-controller".
>>>
>>> 10. Compatible:
>>>    - Drop "mediatek,mt6357" since there is a separated DT Schema
>>>      for PMIC MT6357.
>>>
>>> 11. Examples:
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
>>> References:
>>> [1] https://lore.kernel.org/all/20240925171156.9115-1-macpaul.lin@mediatek.com/
>>>
>>> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>> 
>>> +
>>> +  adc:
>>> +    type: object
>>> +    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
>>> +    unevaluatedProperties: false
>>> +
>>> +  audio-codec:
>>> +    type: object
>>> +    description:
>>> +      Audio codec support with MT6358, MT6359, and MT6397.
>>> +    additionalProperties: true
>> 
>> No, this cannot be true. Schema is incomplete for listed compatibles.
> 
> I saw now your patch for ASoC, so this is fine.
> 
> All my other questions stay valid - why are you adding new devices in
> patch which is supposed to be ONLY conversion.
> 

Ok, I'll drop adding new devices from other reviewed patch for this ONLY
conversion.

>> 
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        oneOf:
>>> +          - enum:
>>> +              - mediatek,mt6358-sound
>>> +              - mediatek,mt6359-codec
>> 
>> There was no such compatible.
>> 
>> Why do you add non-existing compatibles during conversion?
>> 

Same here, will drop it in this conversion.


> Best regards,
> Krzysztof
> 
> 

Thanks
Macpaul Lin


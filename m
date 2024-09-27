Return-Path: <linux-pm+bounces-14865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F239882B6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA40B23E81
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6618950A;
	Fri, 27 Sep 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cNvJQPby"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBC13698F;
	Fri, 27 Sep 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433687; cv=none; b=U4aHf2J2j2jKN64VBwWUBzcDe4SOVgTS7J2MVj2h1Rm6s799V0omDGbAm9cskmTNwDzGZfu5Mx0KhLUCDe5A9PBeuUVN8SCAZCdDTaP4l7VDzFLVOXkw3x9wRMJIwCuzCHZA0U3UqyuCzYs15vAuTLGT0i0QYoclsplljIQPX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433687; c=relaxed/simple;
	bh=KoZaEI3JS55lBiC+OYgLUGIMIHYdubCt/PR1wyVVYdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RjXT0BycXQf6eFx3agiSNwJ2eccbwYkrSPF9N3fKQO0MmnJYcfc8tdv1GL46sziJ8/PwVoQrfvI/WCVtEafzPeDZLCMiNwXj1UULzmLP2ZmAnwmj55J4dK5dvYxp+wNY+4woXiVVcjGNHPm5ITP42Bi2tTrA6KI54qanFTSDSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cNvJQPby; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 073f6b8c7cbd11efb66947d174671e26-20240927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=d2ip2mdxnBklx0orvnPYOI2t7UUGH6wKZQCQEfSWN/M=;
	b=cNvJQPbyJ6oFPLgZyt/1g0EYfq8n3VH+y4XXUJZIB+r2wX2taVtwRXxIE531/RmUuT3BCcTY7MfQrx88Z+0CI2lIyGoSskhY6zGcnIGngCvVVQ4ceGQz1ScrT0G4CnJHcleh08BT3G9ai7Xf9DP0FcuIIocfI/daNvJesCthVR0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:64f08183-e24a-4257-8530-75b5f9675b25,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:1353aa9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 073f6b8c7cbd11efb66947d174671e26-20240927
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1432560207; Fri, 27 Sep 2024 18:41:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Sep 2024 18:41:17 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 27 Sep 2024 18:41:16 +0800
Message-ID: <df270bf2-07f3-71a8-1f67-b8417f7a0719@mediatek.com>
Date: Fri, 27 Sep 2024 18:41:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 2/2] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sean Wang
	<sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones
	<lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Chen Zhong <chen.zhong@mediatek.com>,
	<linux-input@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20240918064955.6518-1-macpaul.lin@mediatek.com>
 <20240918064955.6518-2-macpaul.lin@mediatek.com>
 <339b4c83-201c-4f63-85d0-b0aa1eb164b0@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <339b4c83-201c-4f63-85d0-b0aa1eb164b0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 9/27/24 17:45, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 18/09/2024 08:49, Macpaul Lin wrote:
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
>> 
>> 3. Audio Codec:
>>    - Convert sound/mt6358.txt and merge into parent MT6397 PMIC DT schema.
>>    - Align to generic name "audio-codec" for codec and sound subdevices.
>>    - Add "mediatek,dmic-mode" and "Avdd-supply" properties.
>> 
>> 4. Clocks:
>>    - Align to generic name "clocks" for clockbuffer subdevices.
>> 
>> 5. LEDs:
>>    - Convert leds-mt6323.txt and merge into parent MT6397 PMIC DT schema.
>>    - Update LED binding.
>> 
>> 6. Keys:
>>    - Add detailed descriptions for power and home keys.
>>    - Add compatible: mediatek,mt6358-keys.
>> 
>> 7. Power Controller:
>>    - Convert mt6323-poweroff.txt and merge into parent MT6397 PMIC DT
>>      schema.
>>    - Add #power-domain-cells property to fix dt-binding check error.
>>    - Clarify "BBPU" as "Baseband power up".
>> 
>> 8. Pinctrl:
>>    - Align to generic name "pinctrl" instead of "pin-controller".
>> 
>> 9. Compatible:
>>    - Drop "mediatek,mt6357" since there is a separated DT Schema
>>      for PMIC MT6357.
>> 
>> 10. Examples:
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
>> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> 
> NAK
> 
> Follow up patch pointed out this is incorrect. I don't understand this
> concept of sending knowingly incorrect code, so please sort it out at v7.
> 
> Best regards,
> Krzysztof
> 

Sorry I didn't know mt6359-codec and mt6358-sound are similar device
until Sept 26 (just yesterday) when I was reviewing the DT
bindings. Until I've found the previous DT Schema of mt6359-codec 
incorrect.
See [1] 
https://lore.kernel.org/linux-arm-kernel/20240926092519.6556-3-macpaul.lin@mediatek.com/T/
and [2] 
https://lore.kernel.org/all/20240926092519.6556-2-macpaul.lin@mediatek.com/

And.. I don't understand, the origin this patch v6 should be a text file
conversion, shouldn't we keep the origin content just a conversion and
trying not to broken other relate modules?

Please help to indicates what is a better approach here:

Should I merge the properties of mt6359-codec, mt6358-sound, and 
mt6397-codec
together and put them all into to mt6359.yaml and redo the converting of 
mfd/medaitek,mt6397.yaml?

That will be much simpler for the audio-codec node for mediatek,mt6397.yaml.
However there will be a little mismatch from the origin text file.

Thanks
Macpaul Lin


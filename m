Return-Path: <linux-pm+bounces-14387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C6B97B819
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8F11F22B51
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 06:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486116A940;
	Wed, 18 Sep 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eatpWrAZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5313AA2D;
	Wed, 18 Sep 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641932; cv=none; b=PV8E2rHoTmvIcky6BxWSK9U87nhWSLtN2fWuPZ7oiPZoycJUJwXGjriBO5/d4LGIGpHvagcKEdgseYrUZnlsTOT8b5dJM3tTvqoXAgXrFO/o82H9em0sRvIUfnWTFU3kgOr6aGnj1RBMwG1pRV0ONcV0He+0iCh58HL3Ge+nAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641932; c=relaxed/simple;
	bh=HKwxK8Mra+ZUj8lforK7epZXztfqRhaHwODzzj+0LRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NRzzGVZNN4KHRriktiGCEp/mkMTgJy4P+FolvQJZ0ypz9/VwyhliIjRaayuozde1ityvodPwrEX7X2PsPyoPmJwuHTJgtpPskSw/fcaOUs2pVCAlv4UnvgWftE6P85JBmL5ojzj1rZygjas7HgiZpgnkDgBsqUwWlOVjntBuVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eatpWrAZ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 95ed20c6758911efb66947d174671e26-20240918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=OYO2EcO+MX0CfxoS7F4jWIet58CD9M/3WWGPyCM7GRs=;
	b=eatpWrAZ6iU3UHGRLcOQGAL6rG1190ywtXeR5edkqo273N9t88Ihej4V4vAuB8oKQ1/rCmK5YFhT1zrUBGRELo0T4N71k8vqYpRbY/1YqAm8fqxqrMUdQueXEwVjMJuJI++39QHxYUO2LE+TkBDo7kEqL5FVzMMb+ctIB8LqxDQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:125f8b77-2f9c-4264-b549-bc3844910a59,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:021c5ed0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 95ed20c6758911efb66947d174671e26-20240918
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1041043135; Wed, 18 Sep 2024 14:45:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 18 Sep 2024 14:45:22 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 18 Sep 2024 14:45:20 +0800
Message-ID: <a0a16c7a-0469-d880-532a-2bb69f5ea347@mediatek.com>
Date: Wed, 18 Sep 2024 14:45:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sean Wang
	<sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones
	<lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Chen Zhong <chen.zhong@mediatek.com>,
	<linux-input@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20240916151132.32321-1-macpaul.lin@mediatek.com>
 <20240916151132.32321-2-macpaul.lin@mediatek.com>
 <iudkiamza3lsl33tsby3sghfy66rj2tgg3kqjjwzeba46oxtpi@yrri5m5skjld>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <iudkiamza3lsl33tsby3sghfy66rj2tgg3kqjjwzeba46oxtpi@yrri5m5skjld>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.205300-8.000000
X-TMASE-MatchedRID: QfHZjzml1E8OwH4pD14DsAPZZctd3P4BC/ExpXrHizxV1lQ/Hn0TOpm3
	CkZsyRGFGAs04whSQKmxN81bhpHVXyiETuGglu04Bu2zRCSrLjbXAvRa0tfJGg6QlBHhBZuw5gc
	Q9o9yjpueQqC+u+jOSA6JWCjkElGt0g+iOlrNCJM1yhbbA7We0+Tv34VGGbNIWltirZ/iPP6tBF
	nLFqDVm8IgA/magxYucQfBx409I+hgZ3QS6Zzlz+v8QGaI25e3nophrTcsI7abKItl61J/ycnjL
	TA/UDoAA6QGdvwfwZZWRVlrjsKO8N0H8LFZNFG7bkV4e2xSge6L7+/PK9Vdww4apptB4u3+6SFU
	bUyOTorfjtkGwm07arAUyUg9ogFt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.205300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E8DAA0D017FE1404BF14FCB32DAF0E99A46CD1524B4ED9644550D353E64B24CD2000:8


On 9/17/24 15:00, Krzysztof Kozlowski wrote:

...

> 
> On Mon, Sep 16, 2024 at 11:11:31PM +0800, Macpaul Lin wrote:
>> Convert the mfd: mediatek: mt6397 binding to DT schema format.
>> 
>> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
>> subdevices. They share a common PMIC design but have variations in
>> subdevice combinations.
>> 
>> Key updates in this conversion:
> 
> ...

[snip]

>> +
>> +            ldo_vcamio {
>> +                regulator-name = "vcamio";
>> +                regulator-min-microvolt = <1800000>;
>> +                regulator-max-microvolt = <1800000>;
>> +                regulator-enable-ramp-delay = <216>;
>> +            };
>> +        };
>> +
>> +        keys {
>> +            compatible = "mediatek,mt6323-keys";
>> +            mediatek,long-press-mode = <1>;
>> +            power-off-time-sec = <0>;
>> +
>> +            power {
>> +                    linux,keycodes = <116>;
> 
> Messed indentation.

OOPS, I didn't find this during editing.
Will fix it in next version.

>> +
>> +        power-controller {
>> +            compatible = "mediatek,mt6323-pwrc";
>> +            #power-domain-cells = <0>;
>> +        };
>> +
>> +        rtc {
>> +            compatible = "mediatek,mt6323-rtc";
>> +        };
>> +    };
> 
> Keep one complete example. Maybye two if they are significantly
> different, but I don't see these differences.
> 

Okay, will keep complete example for mt6323.
Trimmed most similar part of mt6358 and mt6397.
Since there are some typical usage in other nodes.
Just keep these smaller nodes for mt6358 and mt6397.
Will also add a note of this in commit message.

>> +
>> +  - |
>> +    #include <dt-bindings/input/input.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    pmic {
>> +        compatible = "mediatek,mt6358">
> 
> 
> ....
> 
>> -Required properties:
>> -- compatible: "mediatek,mt6397-pinctrl"
>> -For details, see ../pinctrl/pinctrl-mt65xx.txt
> 
> Best regards,
> Krzysztof
> 
>

Thanks!

Best regardsMacpaul Lin


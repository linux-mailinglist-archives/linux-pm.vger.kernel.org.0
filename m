Return-Path: <linux-pm+bounces-14999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4C698B53B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 09:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C80B20B07
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A42A1BD03B;
	Tue,  1 Oct 2024 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZauCsIRg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86261BC9F9;
	Tue,  1 Oct 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766369; cv=none; b=FpEoGiPUoKx1fQm4+MzTE/5DWSzck0p2C+gzdEcxHx35V6/w3w3E/T8nfgVLpDnDefjlZNKXTy3mNix3OqTtK7gb7Z4fXT4RAuBHycjGKwxfSNo1Y2XGa/MyaeAhqj38/cdRq47ZOpfTwtkUcC2NVNWpdDZPd8zg0l/5+3/VVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766369; c=relaxed/simple;
	bh=uzy4br8jBpl8hKCqGAs/5rzn7+NYl8MRI9B594xPtqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DaIVklF4PgfNuTTyvInpe2jOWXIdNktwbCV5TN0c5I+avJtOQ9fklgDAqK+jNiM1hz8qin7oycPfVq675deNB6rWjopKdMSoLsv3cppSdi3d/Qk+LTBgwudmSoeouPwM56RJkk71nF/fgJb2uhLdHek6Ke/B1Gu2emhIc5HnFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZauCsIRg; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9a8dbd687fc311efb66947d174671e26-20241001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=7maMI3JrfgulMF11preQuttN86aApnHvjFdQ3y6oNrQ=;
	b=ZauCsIRgzA4zsRHwG61UR1disZQf77l7l/xKgMK+ZqcXv1iKQAaDo6Tgv8Fn7XiPaEgVnRK+d/0+6cbK8A4TcJrrUIl5M8BJtk0v6sgA3g6v/4EE8MykhsvyF2T59oR0F5cYW1p2P1AZXCWXRtVN4JuS0K/Pl4eT/C6lrZOy+qc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:9732fa5b-b768-470c-9782-e7eef0324e7d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:f94b0ad1-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9a8dbd687fc311efb66947d174671e26-20241001
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 35394258; Tue, 01 Oct 2024 15:05:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 15:05:53 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 1 Oct 2024 15:05:52 +0800
Message-ID: <42dc4e9a-efcd-e166-b4fd-d4fe0dcd3c77@mediatek.com>
Date: Tue, 1 Oct 2024 15:05:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/3] ASoC: dt-bindings: mt6358: Convert to DT Schema
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones
	<lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	"AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, Sen
 Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Andrew Lunn
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
 <20240930073311.1486-2-macpaul.lin@mediatek.com>
 <6l6hb264yvhd6e6neurd5t4gmv5z5c5gpg27icijif3hq4cuu7@pbhfkdxb2eam>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <6l6hb264yvhd6e6neurd5t4gmv5z5c5gpg27icijif3hq4cuu7@pbhfkdxb2eam>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.101800-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQOwH4pD14DsF2036HHwFm/C/ExpXrHizxYJGLp3WXzKpWp
	knTQ1+q/T+8v17QjdI1rQ015tgQBDTLCC/YZrQrUMN+B8zdlz9FMK/nxnH1Imt9zZd3pUn7Kakq
	BCNYGwQ2ycWeoQW7ios4k/G1If2CrCLTFoW0rIaq4jAucHcCqnQXXmzqmsIi7yWCL+8tLbvYDkd
	7WQNL44uLzNWBegCW2RYvisGWbbS8TEC0P9PvYRt0H8LFZNFG7bkV4e2xSge73SwlEUO9gdk5Ph
	/E0lnHtrz/DYYLZZVaW2ciTighMcL7rweoAIK8o
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.101800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8213473620506FBC013195E018B92A6C2C331F6E40BA18E9D76B871E9094E6BB2000:8

On 10/1/24 14:34, Krzysztof Kozlowski wrote:

[snip]

>> +description: |
>> +  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
>> +  For more detail, please visit Mediatek PMIC wrapper documentation.
>> +  Must be a child node of PMIC wrapper.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt6366-sound
>> +      - mediatek,mt6358-sound
>> +    const: mediatek,mt6358-sound
> 
> This wasn't ever tested.

Hum, I have indeed tested it with linux-next/master branch.
Ran dt_binding_check with dtschema trunk with this single file
but didn't get any warning or errors.
'make dt_binding_check DT_SCHEMA_FILES=mt6358.yaml'

Could you please help to paste the error log for me?
If there are new errors, I need to check if there is any
environment issue.

> Do not send untested code, it's a waste of reviewers' time.
> 
> Best regards,
> Krzysztof
> 
> 
Thanks
Macpaul Lin


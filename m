Return-Path: <linux-pm+bounces-15002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1AA98B61F
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C88280EF5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D751BDA83;
	Tue,  1 Oct 2024 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qyHtKOEu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991DD63D;
	Tue,  1 Oct 2024 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769025; cv=none; b=ULXbIAQLLrdPJCz3oakoRgr0awQsJBMNgE3/sKlqaxlIfRw4hSnMwPgiRkwcOt2paGsZxbV5SXkKULqY4uucIFoZSdsYUBPXE0TAglHNMkqRu0E/bTNejks21uiYuHgm+y6flMacYDsoUn72dKS4gV5iGE/NJ/LqB8TwpCIl3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769025; c=relaxed/simple;
	bh=H8GT7CQPQCP0iqDT0akwe9NghW+v/5sAgRRAbcbb5Wo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=YAcLIo74mrIfQAvGzYPqFtJF88U6v3vSmN5ciGW6zaSk4BJSfslUDPpJk1PPTL+VnqfdVmgC+qO4KZplKeGUrZvddBd3F6P9HdmItyWVOheIcKfq6orzqwYYPVJ6fIiDLg/8nKcQowU7buhOdkLXE9WRW4oSI0/KpAhsOzDqwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qyHtKOEu; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ccdfc1c07fc911efb66947d174671e26-20241001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:CC:To:From:Subject:MIME-Version:Date:Message-ID; bh=FlXzrXpPCzLcSODdsG8c3PiQzj81rbhZ9JEiAPkX18g=;
	b=qyHtKOEuOk6q6+jzGD1iSnaFQHlFcBrsieaxCfeRvA4W8KDlpk926lBA2sxf4FRJXNE4kxdX+/3t5NZhVbS+EbjFGG7HudBW8762A5ZXLyChg9v78v3HH8Ee+ohLNkbFr3+Z1ICpJ4lePfo5K0vLYoxIKYgRZfm/jXekpou276c=;
X-CID-CACHE: Type:Local,Time:202410011505+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f4145b70-66da-4fe0-ad2c-5b0a2bbc4e74,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:f94b0ad1-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ccdfc1c07fc911efb66947d174671e26-20241001
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1105446460; Tue, 01 Oct 2024 15:50:17 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 15:50:16 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 1 Oct 2024 15:50:14 +0800
Message-ID: <c2fb40cc-491f-1c1a-7343-c70a60b3a031@mediatek.com>
Date: Tue, 1 Oct 2024 15:50:12 +0800
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
From: Macpaul Lin <macpaul.lin@mediatek.com>
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
 <20240930073311.1486-2-macpaul.lin@mediatek.com>
 <6l6hb264yvhd6e6neurd5t4gmv5z5c5gpg27icijif3hq4cuu7@pbhfkdxb2eam>
 <42dc4e9a-efcd-e166-b4fd-d4fe0dcd3c77@mediatek.com>
In-Reply-To: <42dc4e9a-efcd-e166-b4fd-d4fe0dcd3c77@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 10/1/24 15:05, Macpaul Lin wrote:
> On 10/1/24 14:34, Krzysztof Kozlowski wrote:
> 
> [snip]
> 
>>> +description: |
>>> +  The communication between MT6358 and SoC is through Mediatek PMIC 
>>> wrapper.
>>> +  For more detail, please visit Mediatek PMIC wrapper documentation.
>>> +  Must be a child node of PMIC wrapper.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,mt6366-sound
>>> +      - mediatek,mt6358-sound
>>> +    const: mediatek,mt6358-sound
>>
>> This wasn't ever tested.
> 
> Hum, I have indeed tested it with linux-next/master branch.
> Ran dt_binding_check with dtschema trunk with this single file
> but didn't get any warning or errors.
> 'make dt_binding_check DT_SCHEMA_FILES=mt6358.yaml'
> 
> Could you please help to paste the error log for me?
> If there are new errors, I need to check if there is any
> environment issue.

I've both tested both of the following format pass dt_binding_check.
#1.
properties:
   compatible:
     items:
       - enum:
           - mediatek,mt6366-sound
           - mediatek,mt6358-sound
       - const: mediatek,mt6358-sound

#2.
properties:
   compatible:
     enum:
       - mediatek,mt6366-sound
       - mediatek,mt6358-sound
     const: mediatek,mt6358-sound

>> Do not send untested code, it's a waste of reviewers' time.
>>
>> Best regards,
>> Krzysztof
>>
>>
> Thanks
> Macpaul Lin

Should I update it with format #1?

Thanks
Macpaul Lin


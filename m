Return-Path: <linux-pm+bounces-14567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD097EA09
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 12:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8611C20D92
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D84195FEF;
	Mon, 23 Sep 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EmzD1NEH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA317543;
	Mon, 23 Sep 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088218; cv=none; b=fT06AN14CJrcymwCfJiiI64+GGhUU01l8NaRC7Zk0kFkvKwmVo34icrSNqIq3Xp9VHphLpRMrDJ90h0yH3OBjQWZYAQ10x6NU1K/hALNfM777FbWyx1UvsuFHkvsRFTpGo9wzG3ARmvS44L2SerDCr2GMQxCyaRL+0c1CYqGNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088218; c=relaxed/simple;
	bh=+xoSspNKJ5MEUo0tLVZmeEuaK5ipmpy6ZXvedGMFkMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cfwOW5pXUue36+6uNd7cdsBfwTIhajLzFxSkS1YbHsDpfKfnsc9h85Z2UzKGabazYbQznQkqil2kwSqfSHg4H4oCURl7hfsrHhNhOEXHB3Ss4ahxu4McF8EYd89Ll2/CYjq/psOmfK4dPtYtOVctJaydIyyyKcxtmQIZNS5e7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EmzD1NEH; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ac46e808799811efb66947d174671e26-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=lxJ2u/FvugU1hQiGyVxAGg7yfWlaUL7i8/K8f/CODxM=;
	b=EmzD1NEHc00QO3MhkzE01AetGGypiXlLNuFwDv/+mf5KzfgIHWm/GRroijcpnlxvaLExCyYaymWknRde/ShztiAIRnciqIbjRd85HhxVq4xrQ3ME3gvh2juN95PR8QysuigX32l0+1Dx/TeOj7mQkDZzdprO1JdIDSzlOfOiRhI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ab14257d-9121-42ff-9bcd-a013a3e0b8b0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c9ca9fd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ac46e808799811efb66947d174671e26-20240923
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1160707181; Mon, 23 Sep 2024 18:43:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 18:43:27 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 23 Sep 2024 18:43:26 +0800
Message-ID: <637aca9a-5d1e-6726-4b97-4d5db0ee30a3@mediatek.com>
Date: Mon, 23 Sep 2024 18:43:23 +0800
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
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sean Wang
	<sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones
	<lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen Zhong
	<chen.zhong@mediatek.com>, <linux-input@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-sound@vger.kernel.org>, Alexandre Mergnat
	<amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, Pablo Sun
	<pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20240918064955.6518-1-macpaul.lin@mediatek.com>
 <20240918064955.6518-2-macpaul.lin@mediatek.com>
 <20240918115151c896f33f@mail.local> <20240918115651c1475d36@mail.local>
 <2af0621d-14ac-b7f3-b28d-2df698931121@mediatek.com>
 <d8b90ddf-efbc-4434-9ad0-4be6942d51a5@collabora.com>
 <202409201337500284902d@mail.local>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <202409201337500284902d@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.104600-8.000000
X-TMASE-MatchedRID: QW5G6BKkLToOwH4pD14DsF2036HHwFm/C/ExpXrHizwJmdXzOhEMdq1X
	iPUpd5urvhH72H3yPfRl52ofpDGzAUER5ddgnEDec2k2agnXN3xMkOX0Uoduuf5Ndkm9jGh5+k9
	OmImxseHdNZBjAe+TD5j4oSfJftZ+Gmdo3OL/XyN17gHAyAFr0z49+ukeLY9133Nl3elSfspkDy
	hB8FZCo0saY8ROPM6fB++TmiSdVlO6de0YULw0FnuTVkeYosXtYY0tNGdvli3qLnOUXH9QdIcqr
	S3ZaIiqCEuVF6nuSDFftuJwrFEhTbew1twePJJB3QfwsVk0UbtuRXh7bFKB7n0Bw/xUOCRaQob8
	Aj73RQ4BdZxBcFC/afKV0PghFKiIHIV02d1rpG8=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.104600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 29BBBD91297B46FCBF23EA27127FA88C925FF1F3A72ACB71CB857985D524E1632000:8


On 9/20/24 21:37, Alexandre Belloni wrote:

[snip]

>> > > > >  - RTC:
>> > > > >   - Drop "start-year"
>> > > > 

[snip]

>> > 
>> 
>> Alexandre, I definitely agree with you on the fact that the MTK PMIC RTC driver
>> can (and needs to) be improved, and that it can make use of some nice cleanup...
>> 
>> ... but!
>> 
>> This series performs a conversion to schema, and the previous txt file didn't
>> say anything about the start-year property - which was not mandatory to support
>> at that time (nor now, afaik?), so adding support for that is out of scope for
>> this series.
> 
> It is mandatory now. I agree this can be done in a subsequent series.
> 

Thanks you all for helping with the review and kindly understanding the
situation. I see that Angelo has already submitted the RTC patch set.
I'll check it with the internal driver owner. It seems okay with a quick 
glance.

>> 
>> Eventually, that can come as a series on top, adding support for that in the
>> binding (and, of course, in the driver).
>> 
>> I should be able to tackle that... most probably next week - but still, the
>> improvements would come as a series on top of this one.
>> 
>> Cheers,
>> Angelo
> 

Thanks
Macpaul Lin


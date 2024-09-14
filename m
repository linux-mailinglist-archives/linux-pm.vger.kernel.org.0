Return-Path: <linux-pm+bounces-14252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F7978F96
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9111F236B5
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D971CDFD4;
	Sat, 14 Sep 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dCTCFO0L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206E13342F;
	Sat, 14 Sep 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307152; cv=none; b=D8rwPPkYzZOxIKVPFDuNC+dNQaVD5YIMXkJ4fuCJjnsevLq3BwDgarasK6DZTZPI5tOVkbHiwx2Mm7+2LxGcexsSkpF4EDy3Fdh+CbVBYrettObcLe/9ov/a6mUrK4ylcvy2OZrlWndp+HJNi9z5E+lWctIGQSbQkuLRIT+THks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307152; c=relaxed/simple;
	bh=IQt8YvLdgZK2Ul2Fo05K3SidoxgzyxbCVIohz8TUv3M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rh373Bs1XEQZvNrTypdXd1c/14lUxEOb4wbDJ2PtVZ29g/mBaWCr65tn+ciqfG67RlrQWu1Hvowk2wCPW7eIX5Xi6zeu6dMcNkeK712wjKcaIwkAUfDs90HsyIq9baKoCVvpHdv1TshaiDA20IcNZqU52VBfJGgWdKvptMWuau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dCTCFO0L; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1ade62d6727e11ef8b96093e013ec31c-20240914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:CC:To:From:Subject:MIME-Version:Date:Message-ID; bh=td6W5BqS/w7GJGWIguOqNkiPUX+ROKcwQb3R/eDFAI0=;
	b=dCTCFO0L1H0bx1lR4E4FH4Mbf5IxigQ5QTIMahA90uYSzPP/Ln24ubkmDOboP2skNe0A4e61h/88mPd18zRiOamP+uPZcQxv8+LDCLOmYX4ILPaMeX2k+r4bIR2TdwS/btNt8SqQe32H/uH//FG9INiCeQsRPKgK/jLz1YAI/50=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:967cd962-b5cf-4726-8a0d-fff50ef6ada8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:ffd7f5bf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1ade62d6727e11ef8b96093e013ec31c-20240914
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 546005059; Sat, 14 Sep 2024 17:45:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 14 Sep 2024 17:45:38 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Sat, 14 Sep 2024 17:45:38 +0800
Message-ID: <9a120bc4-f671-dd35-a1f9-b9ae7031bdd1@mediatek.com>
Date: Sat, 14 Sep 2024 17:45:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Content-Language: en-US
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen Zhong
	<chen.zhong@mediatek.com>, <linux-leds@vger.kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, Lee Jones
	<lee@kernel.org>, <linux-mediatek@lists.infradead.org>, Macpaul Lin
	<macpaul@gmail.com>, Mark Brown <broonie@kernel.org>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, <linux-input@vger.kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, <linux-rtc@vger.kernel.org>, "MediaTek
 Chromebook Upstream" <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, "Sebastian
 Reichel" <sre@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
	<devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sound@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Pablo Sun <pablo.sun@mediatek.com>
References: <20240913175926.7443-1-macpaul.lin@mediatek.com>
 <172625540069.478205.2893721075637493498.robh@kernel.org>
 <099c4f3e-0772-3d30-79f7-8b996142cd7c@mediatek.com>
 <4a396c65-2353-da09-4dd2-71b822237920@mediatek.com>
In-Reply-To: <4a396c65-2353-da09-4dd2-71b822237920@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.448200-8.000000
X-TMASE-MatchedRID: 6otD/cJAac0OwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0r/bIpz2qRIjbvjKWK1iQnHSHCU59h5KrHWSrKtwxqWpU+u3rM3lFPnCkE
	raFSKEBfgwC+tMY7byJTQ/2UxBcQVxAFMYEMzeR2+dJWHbg4ITpPFJV0Myxm8BUe+Zw5ql5RljC
	/GdRjZi6wHHwdmt++AY44xtvjJ5nioB6BkKpx1kfSG/+sPtZVk4mC51qavDrQ2ANpk6Ruu/cJ0s
	YMUJ2E10s4PPEfk7xPV55op6HGBQmyeGFxbrq7l5gCHftmwEMJ9LQinZ4QefL6qvLNjDYTwsuf7
	RWbvUtyrusVRy4an8SAHAopEd76vF7r821BSEoHux3p95mrDUygbh3X/XOfuagda0wu3hd8CCEh
	VFxWr8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.448200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F43395B9D1A6CB275AE5AF30E52C01AC9CD434BD27F2C2F01DD624AA796E78802000:8


On 9/14/24 15:25, Macpaul Lin wrote:
> On 9/14/24 15:06, Macpaul Lin wrote:
>>
>>
>> On 9/14/24 03:23, Rob Herring (Arm) wrote:
>>>
>>>
>>> External email : Please do not click links or open attachments until 
>>> you have verified the sender or the content.
>>>
>>> On Sat, 14 Sep 2024 01:59:26 +0800, Macpaul Lin wrote:
>>>> Convert the mfd: mediatek: mt6397 binding to DT schema format.
>>>>
>>
>> [snip]
>>
>>>>
>>>
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> Warning: Duplicate compatible "mediatek,mt6357" found in schemas 
>>> matching "$id":
>>
>> I'm using dtschema 2024.09 and the dt_bindings_check didn't report 
>> this issue even the full check has been run.
> 
> Hopefully I've found a way to update latest dtschema without bothering 
> IT. ;)
> 
> pip3 install -U git+https://github.com/devicetree-org/dt-schema.git@main
> 
> I'll run latest dt_bindings_check for v4 version.
> 
Dear Rob,

Just want to leave a note here.

After I've updated to dtschema 2024.10.dev3+gdc4787b,
the 'make dt_bindings_check' still reported no error with this patch v3.

pip show dtschema

Name: dtschema
Version: 2024.10.dev3+gdc4787b
Summary: DeviceTree validation schema and tools
Home-page: https://github.com/devicetree-org/dt-schema

python: 3.10
pip: 24.2

If you have any clue about root cause or any other dependencies
of this environment issue, please let me know. I'll try to check if
there is a fix. Thanks.

Regards,
Macpaul Lin


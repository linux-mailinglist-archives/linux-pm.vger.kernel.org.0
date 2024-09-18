Return-Path: <linux-pm+bounces-14382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF1E97B6DE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 04:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04CF1F232AC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C67A15B;
	Wed, 18 Sep 2024 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DC5q6J7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD359443;
	Wed, 18 Sep 2024 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726627467; cv=none; b=DiA52yepS2boZVsXe8GX86ae8PZHfLOHzLOAldwz9XkWQHxagRpTtswh4Bg8GBiXiT9JYtAD+qqoTHCUbVSHdUwYVD3CQBxiXvgSOM7iyMmk6yeISLGELATisGxYuEjgS/ThdeqUmLuUuAWCv4FbjnkWtJhV8yKucHVIhj9Gr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726627467; c=relaxed/simple;
	bh=gUf+bO349HypZdQuDEBPLI9WPsgqDVm+lcuiUQhUEL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pQIG+0Sxkl2Jz+KmocdwwDY1a2efTE4jHPxzzdPZYMSo6aekRPzUh4xRDq2GUsjdI6m9KFHhT+jSTfyedKTteBvU0r3IFrQUPGBxOYomZ2hq4vTrYHdqzGxrwnTmNxSMDyF4kZueVKTdnl6LciPVkb1avoMruIIa9nkS+czeZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DC5q6J7Y; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e66e2080756711ef8b96093e013ec31c-20240918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=ZBNvO1VXvf6r4zj/Yom0yxKi6CLuHylMg/ERkYUCU1s=;
	b=DC5q6J7YdjWtksDTcMuXLY60dZ2U1BH7tGcfJORXYW2sl7hv8BdtHrsQFrjN9L2kownijtRXfKrXTdLqZb+0BSkcDhB46H4LrMQNcwuiwgFzm3PbKH9F4LXZVbuupGYbQMgx5GSziMP/wmiSNI4YV29IWHGKdYt2xnSpF6u20Yw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:53a19405-38ed-4346-9670-25a95d397bb6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:bdf41bc0-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e66e2080756711ef8b96093e013ec31c-20240918
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1160952256; Wed, 18 Sep 2024 10:44:17 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 18 Sep 2024 10:44:15 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 18 Sep 2024 10:44:10 +0800
Message-ID: <9caff3d5-22af-3481-d2af-6afb4abd49d7@mediatek.com>
Date: Wed, 18 Sep 2024 10:44:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/3] regulator: dt-bindings: mt6397: move examples to
 parent PMIC mt6397
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
 <20240916151132.32321-3-macpaul.lin@mediatek.com>
 <ev4kqtbjwglrti3mk2cnayilj4muy7ll7ux2uwlekcwu73dy5e@h4wvpucmyepw>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <ev4kqtbjwglrti3mk2cnayilj4muy7ll7ux2uwlekcwu73dy5e@h4wvpucmyepw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.937100-8.000000
X-TMASE-MatchedRID: 9zTThWtzImsOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rgeVsWtxJp0U/qpx4DtjGJU+OjsPhIWDjBktdLSE3ynT6IXkgHUCXL+Hm
	BPyReSgy7Npc3la9ezKmHQUK9UMGAvRezSnFjJZVQ1o+KC+IpH54IbsXmum7GmyiLZetSf8nJ4y
	0wP1A6AAOkBnb8H8GWDV8DVAd6AO/dB/CxWTRRu4as+d5/8j56+yCiKOZBNSTBl6oIRYjdQ0gBO
	bHRHd/EzDPL9QjVnyFW4YAcfB4u2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.937100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	298EDE46A95067340BB747C06C83C35738F004CAE18886807EF42ECC803D897E2000:8


On 9/17/24 15:01, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Mon, Sep 16, 2024 at 11:11:32PM +0800, Macpaul Lin wrote:
>> Since the DT schema of multiple function PMIC mt6397 has been converted,
>> move the examples in "mediatek,mt6397-regulator.yaml" to the parent schema
>> "mediatek,mt6397.yaml".
> 
> Is there any error otherwise? Why this cannot stay here, since it is
> already there?
> 
> Best regards,
> Krzysztof
> 

I previously thought that all regulator examples needed to have a 
complete version placed centrally in the main MFD. In that case, this 
patch 3/3 should not need to be required. This will be dropped in the 
next version.

Best regards,
Macpaul Lin




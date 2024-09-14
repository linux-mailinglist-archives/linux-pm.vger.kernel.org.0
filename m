Return-Path: <linux-pm+bounces-14240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F98978EC5
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 09:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6544CB22D5D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCAF1CDFCC;
	Sat, 14 Sep 2024 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C0iM3a/U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BE1CDFC9;
	Sat, 14 Sep 2024 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726297580; cv=none; b=cPS9ygjhqcxatvgzOf+n379aTraE6fF7HcXN+QQF9nXBojLAjrHWJLgX52ufih8BPy1theM+damLq4KAshVqzk+h7w5ShNMIiLCnzYlmNyxDG8RMLnnfPLypLTX3SVsfwxcuox7PYFPfUUuVICIEkowFJHzTkVvQzoPPXMPeRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726297580; c=relaxed/simple;
	bh=A4pR3u/T6SMTPpu/b2HQXK80EWeF9lXXT9d4NrBgJzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NLiNkZQkirY6zOUTZivAY/A0h3n0Nyu5cPt41ziI7XvQTq9G0U04fMB6fOpMqdlEDge+aTaducLPtcTv80JBP5SD4WI8tCYqBYSvMsES2Tlz3uOyDbVkdac0HqP6MirnoDHfzDjT5SXzeCMYxUGvI8e2Z24kVKR++L0zu622uuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=C0iM3a/U; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d3b738b2726711efb66947d174671e26-20240914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=gOzS1fYuXawLqEdeQfCslk8qImk6u8m0BOnVeqEnmrY=;
	b=C0iM3a/UMwwJ2Ra1cmkHaoVgIIiOqgHjJPmOV2r9ovIFLRV7F8E6hG7aWp8fQoEhE3vh4qEKS98hq5Wb3evHZnAGHonRobXwo/ztiC+T9246ZnYKw/K1xgoamlZcbD43j/kvuSFNa6mHqeBb0y4CmrlKwaumPpTu7Z7EuInwSBI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:64c5cd36-aec3-4925-9237-805e722419c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:27bc01b7-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: d3b738b2726711efb66947d174671e26-20240914
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1803344272; Sat, 14 Sep 2024 15:06:13 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 14 Sep 2024 15:06:11 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Sat, 14 Sep 2024 15:06:11 +0800
Message-ID: <099c4f3e-0772-3d30-79f7-8b996142cd7c@mediatek.com>
Date: Sat, 14 Sep 2024 15:06:08 +0800
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
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen Zhong
	<chen.zhong@mediatek.com>, <linux-leds@vger.kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, Lee Jones
	<lee@kernel.org>, <linux-mediatek@lists.infradead.org>, Macpaul Lin
	<macpaul@gmail.com>, Mark Brown <broonie@kernel.org>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, <linux-input@vger.kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, <linux-rtc@vger.kernel.org>, MediaTek Chromebook
 Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, Sebastian
 Reichel <sre@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
	<devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sound@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Pablo Sun <pablo.sun@mediatek.com>
References: <20240913175926.7443-1-macpaul.lin@mediatek.com>
 <172625540069.478205.2893721075637493498.robh@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <172625540069.478205.2893721075637493498.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/24 03:23, Rob Herring (Arm) wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Sat, 14 Sep 2024 01:59:26 +0800, Macpaul Lin wrote:
>> Convert the mfd: mediatek: mt6397 binding to DT schema format.
>> 

[snip]

>> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Warning: Duplicate compatible "mediatek,mt6357" found in schemas matching "$id":

I'm using dtschema 2024.09 and the dt_bindings_check didn't report this 
issue even the full check has been run.
However, the compatible "mediatek,mt6357" indeed existed in the old 
bindings. Since it is a independent DT schema now, I'll remove this line
and update v4 version to see if it will help.

Is there new version of dtschema used by bot? I guess the base shouldn't 
affect this duplicate detection whether using rc-1 or next-20240906.

[snip]

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240913175926.7443-1-macpaul.lin@mediatek.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch
The base of this patch set is based on next-20240906 with linux-next/master.

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Thanks
Macpaul Lin


Return-Path: <linux-pm+bounces-15131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE7498FC7D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 05:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7091C22561
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 03:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E53CF65;
	Fri,  4 Oct 2024 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ulEN/Oui"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335A374D1;
	Fri,  4 Oct 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728011397; cv=none; b=fZtkzTur6tPgSmlfjcox+9fidiadzTVfEk2BVDZD3RmBoDPrtiQmYXt4qSgQbSCb2JGafO5QC/rQG0AGcJSSTL9OrFa8Q+ZgrnUuGTYhmInyf1gZ50HjVSYQgb/27ub86uoV9yU8kaH4AtnzUcUwey6J47LALHq957z2qq0dS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728011397; c=relaxed/simple;
	bh=TakFGvtVJzmBRexHftyc2Tev3KJSy9KNVE0p6Xlr594=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Z1bjYvNBFJb3ZTlw0KPdbjpSpid+GrjEfRRKk2bwaW0RRYAV2iCzOWuHGtC3iHsuroxZIb64xYHOe30h3owtB4wByz1YIZ0yIK7qnzsoOMX8Es/Nv4CpSzfjRCuo2hgvMCuD1dM4vjEUw70KMMhNFjpKD2P8EtoKOwv/aYrAk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ulEN/Oui; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1ebf174481fe11efb66947d174671e26-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:CC:To:From:Subject:MIME-Version:Date:Message-ID; bh=FCUbhenGMf5+wIxJ4JWL1bgoO1/T6c4+0JMhIL3Tzh0=;
	b=ulEN/OuimOcgB0b9XoKJLbkQyPoPM8fTE3lDVpnUMKVjr+dhtyra98dUNgbzdX55cq141b6cKj/MAJlT75yi2znK3E2jjV1LSeE2kFDAQngit8LIG5uYBXtZrWCRE1cVxtSN8i/MWpRoTcfmti+7XvvFlrZyfTqS6m3+C0MZmK8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:530f634c-5443-4f95-8eff-879c3814e4ee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:875bba40-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1ebf174481fe11efb66947d174671e26-20241004
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1417756100; Fri, 04 Oct 2024 11:09:50 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Oct 2024 11:09:48 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 4 Oct 2024 11:09:47 +0800
Message-ID: <ced5e434-c2f8-9900-5a00-1808540ab2d7@mediatek.com>
Date: Fri, 4 Oct 2024 11:09:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: add adc and
 regulators for mt6359
Content-Language: en-US
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Pablo Sun <pablo.sun@mediatek.com>, Alexandre Mergnat
	<amergnat@baylibre.com>, Sean Wang <sean.wang@mediatek.com>, Sen Chu
	<sen.chu@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, "MediaTek
 Chromebook Upstream" <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-pm@vger.kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>, Bear Wang
	<bear.wang@mediatek.com>
References: <20240925171156.9115-1-macpaul.lin@mediatek.com>
 <172731883694.2430476.10157265874067724564.robh@kernel.org>
 <bd6376df-baea-d29d-6b74-68d350cbf797@mediatek.com>
In-Reply-To: <bd6376df-baea-d29d-6b74-68d350cbf797@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.508200-8.000000
X-TMASE-MatchedRID: 7ySqCuYCpfgOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0qOGmN9nEzx3i2W7Y+Npd9RqWsZCJMnBwQmlwEyKUIIaFwpnAAvAwaz8Sd
	VWKPY/enHIiXypGH+EHXdOQc5s1eB9ZRkVakSSW2eAiCmPx4NwFkMvWAuahr8+gD2vYtOFhgqtq
	5d3cxkNeZmFbgdmZJSvU+7a+iFp4LJ+ob9w+Cdu3jDsGn4QLiDwUyMN90/km4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.508200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BA7F69DBC496223544DAB2C3B492BC27F1AD1D744F94D11AD6B13F73221C96B02000:8



On 9/30/24 13:53, Macpaul Lin wrote:
> 
> 
> On 9/26/24 10:47, Rob Herring (Arm) wrote:
>>
>>
>> External email : Please do not click links or open attachments until 
>> you have verified the sender or the content.
>>
>> On Thu, 26 Sep 2024 01:11:55 +0800, Macpaul Lin wrote:
>>> Since MT6359 PMIC has been added as one of the compatibles of
>>> "mediatek,mt6397.yaml", the sub-device node of "MT6359 PMIC AUXADC" and
>>> "MT6359 PMIC Regulators" should also be contained in this DT Schema as
>>> well.
>>>
>>> This patch includes:
>>>  - add 'adc' property and $ref for 'mediatek,mt6359-auxadc'.
>>>  - add 'mt6359-regulator' to the compatibles of regulators.
>>>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>
> 
> Thanks for the review. This patch will be merged into v7 patch of
> the conversion of
> Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml'
> 
> Thanks!
> Macpaul Lin
> 

Updated:
Since the nearly the final version patch of v8 of 
'mfd/mediatek,mt6397.yaml' is without adc, audio-codec, and regulator
of mt6359
([1] 
https://lore.kernel.org/all/20241001104145.24054-3-macpaul.lin@mediatek.com/),
a patchset v2 has been send.
[2] 
https://lore.kernel.org/all/20241004030148.13366-1-macpaul.lin@mediatek.com/

Thanks
Macpaul Lin


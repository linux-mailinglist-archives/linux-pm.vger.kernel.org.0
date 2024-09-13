Return-Path: <linux-pm+bounces-14186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF3A9785D7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746BD28B211
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F378281;
	Fri, 13 Sep 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fNRELFfx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32B770FD;
	Fri, 13 Sep 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245276; cv=none; b=eSVAd2U1hYcpFJTxI+A3nJHdxURQMv+F8LnTWKyiV/ECQhuki93Opv5l+QIxtNJyELtfmSANO3i3usUM3+aIZXTziLPrEqaKBCo4B0utoTE6Yen2AtSdQbolgE6joPKp0ntP3xD2RZTOrNkiZGRN0/sk5qcJsxUoEIrPr/r5oPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245276; c=relaxed/simple;
	bh=Be6x5np/IeA3dgRmH96GURLhTJOHsiRBhHXBpLMv29k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=owK1UttuU0tYqWyNNbk39pqftFO+Tips5UjtDK1ew0SE34j7KQB65vSHsq8Ses7OVlD77pNawzPpciiPASYqIZ5PasqeqT+tbso878ix+Z1PSLLb9N8CrVsn3rI4nHWqUYutYcY1Oyh6nd3zH6KKENVez2d0gu4AAzYPvJ53O8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fNRELFfx; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0855b4c471ee11ef8b96093e013ec31c-20240914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Gvl9lrny6mvsK5Tak3zaIUvWCax7srnhKft2K/5hlG8=;
	b=fNRELFfxUrdIlFmeG6ikL9MmcgsFOQk2ObS4OMyFk1Zc5iLi8fE6Rgf1JyzJbHB85l/4bLNCOoGnPlh+5E7s2qKsdM+TGcO2ESyyNQooKH2TbGVGjqqPk119MKg46obgnQdvoRXFC+4B6wBACZqP+tMdc3TJRew9ovZObtpO+nc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:1648f991-874b-4100-b3a4-e24d46d15c13,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:225defbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0855b4c471ee11ef8b96093e013ec31c-20240914
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 303505856; Sat, 14 Sep 2024 00:34:22 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Sep 2024 09:34:20 -0700
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Sat, 14 Sep 2024 00:33:24 +0800
Message-ID: <117a6f04-4228-8ff5-5b19-766cfbbf0771@mediatek.com>
Date: Sat, 14 Sep 2024 00:33:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 6/7] dt-bindings: power: reset: mt6323: merge to MFD
 mediatek,mt6397 DT schema
Content-Language: en-US
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-leds@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Sean Wang
	<sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>, Alexandre Mergnat
	<amergnat@baylibre.com>, Flora Fu <flora.fu@mediatek.com>, Bear Wang
	<bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin
	<macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
 <20240830110732.30080-6-macpaul.lin@mediatek.com>
 <01020191b9d74883-4c4deeb2-1be0-4c45-9fff-c228767de23d-000000@eu-west-1.amazonses.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <01020191b9d74883-4c4deeb2-1be0-4c45-9fff-c228767de23d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/24 05:42, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Aug 30, 2024 at 07:07:31PM GMT, Macpaul Lin wrote:
>> Convert mt6323-poweroff.txt to be compatible with DT schema.
>> Since this is a power-controller device node, merge it into parent
>> mediatek,mt6397.yaml. Subsequently, remove mt6323-poweroff.txt with a
>> separate patch.
>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
> 
> Please merge this into PATCH 2/7 in the next version of the patchset
> (i.e. the patch creating the new YAML binding).
> 
> -- Sebastian
> 

[snip]

Will squash the other patches for removing text format files in to the 
MFD patch in next (v3) version. Thanks!

Regards,
Macpaul Lin




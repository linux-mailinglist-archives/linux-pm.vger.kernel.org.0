Return-Path: <linux-pm+bounces-14185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75039785CA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9E528AA9F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3574418;
	Fri, 13 Sep 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NHnBJTqu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D042042;
	Fri, 13 Sep 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245039; cv=none; b=V8gCFmf8XnIXKNmTQcaCoSIHidKrRrbi6PjoLM+rYZIWBD+SpnaRlw6Evo0gB8VOBTsvLLokaKNa0h1QYeDGBc83SXMNuTKDpVgKvWZG8X8y2EZpioJbgKcolqDKYGT9EyLPQyVQeWc9UHjRfhkwUix/UcuFMZG4iInkb57qzvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245039; c=relaxed/simple;
	bh=aKK46FKilK+bKnoX2daqexXas1ZpJ5Ewg8DpXYBnFJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g8MzZ/XdtJYj370i4zCp5MIEPhUSAN6Hb2VH0Lm7u34rQFyuZA9CYKHqTz+tu2ODzaC+C9l0lvnFB4sDY6L2y9D2tCtbdH1ZK8yXYIlPza+pEhQFC+KIFjn3baIgNA/sprxL8gsYUlmJ52IHSkYS+dCS/lzEvEauVNbgMqr2igc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NHnBJTqu; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7c1f77ec71ed11efb66947d174671e26-20240914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=5/b8q4BoSrQ3NlAvsKLlfGTvGmk5/ocjY5IDio7BDIk=;
	b=NHnBJTquKlPLrnfIzK6mPmMknXBJBhSWyH7Jg3GU1n3lOvXOyjSPbc5Tbdj2Oosvb1Lwf1nu+yUIaa6e3pqJjc16Swlf7Rli+aL5y6nijsJx6p6Mjj5o0gOpsTFQmo8HBinSCxz6/PNd+QWzhYQb5IRE14fX37lcxaLcXu5piq0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:b312c942-3092-41ab-8541-c4ec0f873cc5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:233ffcb6-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7c1f77ec71ed11efb66947d174671e26-20240914
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1165984055; Sat, 14 Sep 2024 00:30:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 14 Sep 2024 00:30:25 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Sat, 14 Sep 2024 00:29:53 +0800
Message-ID: <d77b6a8c-f499-7980-868d-7717046ec3e3@mediatek.com>
Date: Sat, 14 Sep 2024 00:29:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/7] dt-bindings: rtc: mt6397: merge to MFD
 mediatek,mt6397 DT schema
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-leds@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pavel Machek
	<pavel@ucw.cz>, Sean Wang <sean.wang@mediatek.com>, Lee Jones
	<lee@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>, Flora Fu
	<flora.fu@mediatek.com>, Bear Wang <bear.wang@mediatek.com>, Pablo Sun
	<pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen Chu
	<sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek
 Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
 <20240830110732.30080-3-macpaul.lin@mediatek.com>
 <20240830153437.GB4175444-robh@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20240830153437.GB4175444-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 8/30/24 23:34, Rob Herring wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Fri, Aug 30, 2024 at 07:07:28PM +0800, Macpaul Lin wrote:
>> Convert rtc-mt6397.txt be compatible with the DT schema.
>> Since this is a simple RTC device node, merge it into parent
>> mediatek,mt6397.yaml. Subsequently, remove rtc-mt6397.txt with a
>> separate patch.
> 
> This doesn't match what the patch does. You can just squash this into
> the MFD patch where you add the schema.
> 

[snip]

Will squash the other patches for removing text format files in to the 
MFD patch in next (v3) version. Thanks!

Regards,
Macpaul Lin


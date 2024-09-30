Return-Path: <linux-pm+bounces-14915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333BD989A51
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 07:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE0B282323
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 05:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C80145A0B;
	Mon, 30 Sep 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a55CGF/I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471E2D7B8;
	Mon, 30 Sep 2024 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727675638; cv=none; b=Q7CdxFGaJTQjCaWxsIzcjEFa/RAFNQllmONQKQBHHlktvJuwBpbTFHzEeMT4Ck9oqAqRa48cCtVKN4UWhE+a/Ew++Md0uwszVI9ydoAP+WgcH4bRoTw2NcL0hUnoOpmvvbnWhoqqiqC2NeNgPXzRa5gqY/Pbxd0Srl2ayZsH6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727675638; c=relaxed/simple;
	bh=kygPFsZ2XYPjoVkzhSowd9Adm/7rhcVBf9+Hlrjeq2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QLJCCGwpQ0YkIHwS/BGHaw3lRZeCLFEal7ZBUgn/bfROaZDmX2u8FH+p5j+r5oiuDt8V2Fs3Bi5P8FE1FiMriOXSfH/2Tx40zJDKJDraGQi1zQUMcbOvNQ2exi0Rtdj2FrHnWrI2O/42d2+H0CtvQImz5ciA8pG+hOKOoJWOhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=a55CGF/I; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5eaa4d627ef011ef8b96093e013ec31c-20240930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=7Q0x9yH1Uzj10hQrb2viip48aTGZ70NFlnLir/OAPVM=;
	b=a55CGF/Ix4VEHt9m1H3XC+uFemhBBvMPiC/4S3KyrhzrIIUa3APACGFcpowojZoD46FD43PFC2pholeKvK4esU27uWPeAZ7vxA1ynbYY5HYV6Zri6n9LPf1gZOzYZHSCLvfVnJt3th/7ae8LENxvh2oHF09xO5s9TEurA0WWbZs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f1968182-615e-4e37-a327-534a64cb0094,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:40ba7518-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5eaa4d627ef011ef8b96093e013ec31c-20240930
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2020342360; Mon, 30 Sep 2024 13:53:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 29 Sep 2024 22:53:50 -0700
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:48 +0800
Message-ID: <bd6376df-baea-d29d-6b74-68d350cbf797@mediatek.com>
Date: Mon, 30 Sep 2024 13:53:48 +0800
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
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Pablo Sun <pablo.sun@mediatek.com>, Alexandre Mergnat
	<amergnat@baylibre.com>, Sean Wang <sean.wang@mediatek.com>, Sen Chu
	<sen.chu@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-pm@vger.kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>, Bear Wang
	<bear.wang@mediatek.com>
References: <20240925171156.9115-1-macpaul.lin@mediatek.com>
 <172731883694.2430476.10157265874067724564.robh@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <172731883694.2430476.10157265874067724564.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 9/26/24 10:47, Rob Herring (Arm) wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Thu, 26 Sep 2024 01:11:55 +0800, Macpaul Lin wrote:
>> Since MT6359 PMIC has been added as one of the compatibles of
>> "mediatek,mt6397.yaml", the sub-device node of "MT6359 PMIC AUXADC" and
>> "MT6359 PMIC Regulators" should also be contained in this DT Schema as
>> well.
>> 
>> This patch includes:
>>  - add 'adc' property and $ref for 'mediatek,mt6359-auxadc'.
>>  - add 'mt6359-regulator' to the compatibles of regulators.
>> 
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 

Thanks for the review. This patch will be merged into v7 patch of
the conversion of
Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml'

Thanks!
Macpaul Lin


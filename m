Return-Path: <linux-pm+bounces-14913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF32989A3D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191AF281AA8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 05:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5373313D531;
	Mon, 30 Sep 2024 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R3mDzn0O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3D126C07;
	Mon, 30 Sep 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674960; cv=none; b=eL6+kHamYdFch77QBhWj3SAekO2ocB7oixBDg001AuaNx4r/EaGVhaGEjSWNGz9Ds1TOaI4MYNxQbj6LHeaOhAOAh97sRIUdqLM1tiy68BewzLC4eJESEyd828/tjtOjsi4IsqGwjSgdu6uj7ieYNOgoWepmy9mvuJfihzzgss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674960; c=relaxed/simple;
	bh=EnpoqgIUgbGCv4B26GwSnq+jqer0A6xiBOpid1AYyhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=afXZ/ax1om76tLHH+s25FhjiMoq5lsARr/4TyHDNCLj0h1USWTL+BHy0mRN8sNz4bs3bXklzZaIhGXAQ6PAjXKmSngnZbfmHI/DNj6ggk63HCNYhW2PRHIxhwsNErLlPW2yIWvxx9ta7657hWkTnj+I7p+kSNPvPGnHrpf9BtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R3mDzn0O; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c47e78367eee11ef8b96093e013ec31c-20240930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=zasI9d4EFSlQDUt9pveMHKbUWNguU0pHqIbERcEhkJU=;
	b=R3mDzn0OYfxLm0AkkHg1z4tDuUqHPLUTLU8pfof9/DgJ/CNlLgec43/P8q6N4k1JfUhnkhNkX3GixRnAqxpXGvG3Z6ieMrCImr/Eh6qWYf6aZALIGV7Ikrx2B+NIEAaCYzAFqxou4AyrbHlnCM1YmmZpYegPAzjG9c5Ta/rHQJg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2b0b04bf-b81b-471d-9fc6-d22c8c7f36a6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:0c8c7518-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c47e78367eee11ef8b96093e013ec31c-20240930
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 443754191; Mon, 30 Sep 2024 13:42:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Sep 2024 13:42:22 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 30 Sep 2024 13:42:21 +0800
Message-ID: <edeb6345-fc70-a3e8-0702-b9b146295aa2@mediatek.com>
Date: Mon, 30 Sep 2024 13:42:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] dt-bindings: mfd: mediatek: mt6397: add compatible
 for mt6359-codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Conor Dooley <conor@kernel.org>, Sen Chu <sen.chu@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Eason Yen
	<eason.yen@mediatek.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>, Shane Chien
	<shane.chien@mediatek.com>, Hui Liu <hui.liu@mediatek.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-sound@vger.kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang
	<bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin
	<macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek
 Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
References: <20240926092519.6556-1-macpaul.lin@mediatek.com>
 <20240926092519.6556-2-macpaul.lin@mediatek.com>
 <20240926-smokeless-clobber-0fb8a1cdc7ab@spud>
 <78381b10-eae6-1414-6913-994e1ed03410@mediatek.com>
 <z5zehicgqqsbgsjz5nrjlqrkpqll57gb26jdc3ctpeajtlfusm@b2s5vrbuv3es>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <z5zehicgqqsbgsjz5nrjlqrkpqll57gb26jdc3ctpeajtlfusm@b2s5vrbuv3es>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 9/27/24 17:42, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Fri, Sep 27, 2024 at 03:57:58PM +0800, Macpaul Lin wrote:
>> On 9/27/24 00:04, Conor Dooley wrote:
>> > On Thu, Sep 26, 2024 at 05:25:18PM +0800, Macpaul Lin wrote:
>> > > This patch updates the audio-codec properties includes:
>> > >   - compatible:
>> > >    - Re-order the supported device items.
>> > >    - Add 'mt6359-codec' to compatible since MT6359 PMIC has been included
>> > >      in this DT Schema.
>> > 
>> > >    - Set 'additionalProperties: true' for 'mt6359-codec'.
>> > 
>> > Why?
>> 
>> The mt6359-codec support these 3 properties:
>> mediatek,mic-type0, mediatek,mic-type-1, mediatek-mic-type2.
>> While mt6358-sound and mt6397-codec don't (at least, I didn't find
>> these 3 properties in driver codes.
>> 
>> Set 'additionalProperties: true' is also required to fix the following
>> dtbs_check errors:
>> pmic: audio-codec: 'mediatek,mic-type-0', 'mediatek,mic-type-1',
>>       'mediatek,mic-type-2' do not match any of the regexes:
>>       'pinctrl-[0-9]+'
> 
> Why is this a correct fix? Aren't you allowing "pink-pony" property as
> well?
> 
>> 
>> > > 
>> > > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> > > ---
>> > >   Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 5 +++--
> 
> There is no such file.
> 
> Best regards,
> Krzysztof
> 

This patch is no longer necessary. I'm working on a new fix (v7)
for 'Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml' and try 
to rid of these mess in audio-codec node.

Thanks
Macpaul Lin


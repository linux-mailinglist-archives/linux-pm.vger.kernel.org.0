Return-Path: <linux-pm+bounces-14852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F42987FD8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 09:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3580AB20FE0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDCC188A1F;
	Fri, 27 Sep 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pm+L6SuX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83C16EBE6;
	Fri, 27 Sep 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423891; cv=none; b=Lrw4GJd4HGTsdFs9Crnpsdryan9ZfADN0v2h7ORlZI2VI7ZD2q2FGedUf96uyyILv48i9VrGyUeRuWdmx/F1GQsnT730lr9sErOVDCiFW8fZUBvygkp6TOJsY1PLkDCDFcTHioi/msSzWH/kVrPxKMzZgmyVOpiOR6PzaDPQZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423891; c=relaxed/simple;
	bh=K4Ha9SzluEelrcb7mPJ+hSpYuWIb/WY9wcGQ3BuJxPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mZ5ErZuolZkgHIrozMLGN+9ouFC/SEohKNQUcuQav27yw6BMBYelzi8hv15mc4+C5Ul2w814YOzmE/XiQW2J0VR3zKvVe8iV/LsJ2RMknK43iCyGu8tOs/J2eA52qbMG09Jw0TNE3IkdFx1BO8dl8r/4rS0jchgXpjOcz3HuiwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pm+L6SuX; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3882a9787ca611ef8b96093e013ec31c-20240927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=FSHvJiePihDHrvRm0P0iXE0axppBM5CqjqpGGZtkmaU=;
	b=pm+L6SuXs8JD+H7o0asCxTFJPtH4P9Y8t1ICqDkmzKrf0tYRm36pa3rqRVnFUDHbTQUgPEYXfOoNC5dvgK7UModwFGXuHhm/HqX2nQlQgCQ44FRxL/E63G+g6mT2gCrGzX4v/lrJ99sj595JhPOjWVbSGXOkaNTEOXhctImRs7s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:effb94ce-42ef-4fd9-b367-5cfcc011b8c5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:00885818-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3882a9787ca611ef8b96093e013ec31c-20240927
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1584982245; Fri, 27 Sep 2024 15:58:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Sep 2024 15:58:00 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 27 Sep 2024 15:57:59 +0800
Message-ID: <78381b10-eae6-1414-6913-994e1ed03410@mediatek.com>
Date: Fri, 27 Sep 2024 15:57:58 +0800
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
To: Conor Dooley <conor@kernel.org>
CC: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, "Lee
 Jones" <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Eason Yen
	<eason.yen@mediatek.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>, Shane Chien
	<shane.chien@mediatek.com>, Hui Liu <hui.liu@mediatek.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-sound@vger.kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang
	<bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin
	<macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, "MediaTek
 Chromebook Upstream" <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
References: <20240926092519.6556-1-macpaul.lin@mediatek.com>
 <20240926092519.6556-2-macpaul.lin@mediatek.com>
 <20240926-smokeless-clobber-0fb8a1cdc7ab@spud>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20240926-smokeless-clobber-0fb8a1cdc7ab@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.744400-8.000000
X-TMASE-MatchedRID: cgbqQT5W8hcOwH4pD14DsPHkpkyUphL9GNMTWh+TA9t+YesuCgkiXJsn
	GP/L/vukQ2hUNgLaYpUvndTJnUi/SAAt/Fsc5wFGbc297PAGtWbXof+XRfBH287EPIkVcg+OD3J
	fu36QI2GIi0Yt2qmJZR9K6LGpAwssZMLMXtQ7bzFsG7r4Qh7N3J6KYa03LCO2myiLZetSf8nJ4y
	0wP1A6AKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7HPBXw4uHT3JyO9Fb+NyVxV9IeBCvU2xpOg2z
	GJYtXDU5BRVekiXxRE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.744400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: AFFE03E053B385FE89437B5129CE9C73A9E0002E6ECFE675424FD8767641666F2000:8

On 9/27/24 00:04, Conor Dooley wrote:
> On Thu, Sep 26, 2024 at 05:25:18PM +0800, Macpaul Lin wrote:
>> This patch updates the audio-codec properties includes:
>>   - compatible:
>>    - Re-order the supported device items.
>>    - Add 'mt6359-codec' to compatible since MT6359 PMIC has been included
>>      in this DT Schema.
> 
>>    - Set 'additionalProperties: true' for 'mt6359-codec'.
> 
> Why?

The mt6359-codec support these 3 properties:
mediatek,mic-type0, mediatek,mic-type-1, mediatek-mic-type2.
While mt6358-sound and mt6397-codec don't (at least, I didn't find
these 3 properties in driver codes.

Set 'additionalProperties: true' is also required to fix the following
dtbs_check errors:
pmic: audio-codec: 'mediatek,mic-type-0', 'mediatek,mic-type-1',
       'mediatek,mic-type-2' do not match any of the regexes:
       'pinctrl-[0-9]+'

>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>> index 40cabaf60d0d..ffb5848a96d5 100644
>> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>> @@ -104,7 +104,7 @@ properties:
>>   
>>     audio-codec:
>>       type: object
>> -    additionalProperties: false
>> +    additionalProperties: true
>>       description:
>>         Audio codec support with MT6397 and MT6358.
>>   
>> @@ -112,8 +112,9 @@ properties:
>>         compatible:
>>           oneOf:
>>             - enum:
>> -              - mediatek,mt6397-codec
>>                 - mediatek,mt6358-sound
>> +              - mediatek,mt6359-codec
>> +              - mediatek,mt6397-codec
>>             - items:
>>                 - enum:
>>                     - mediatek,mt6366-sound
>> -- 
>> 2.45.2
>>

Thanks
Macpaul Lin


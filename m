Return-Path: <linux-pm+bounces-14194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99613978722
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 19:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CA21F25141
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767712C460;
	Fri, 13 Sep 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bLXyoRao"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FD84A5C;
	Fri, 13 Sep 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249695; cv=none; b=gWaHF8NODowWjqC2R4J5xNSdkfUzBjx63yUNjzEENoE03RIbbxh8v0efGXWmR3+w0mlIKGgG84lSeDootxrWfMd8M4tdBC9Gh9KVKkzu5fngv7XlRCNLIwc/JyEo3spks23hPLcxip4VRF62NXXkzfVXkhzAWpBh7GDM7mHVnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249695; c=relaxed/simple;
	bh=1bgvytnR1cBoSNS0eNWksDlJAGVUVW56J/DY/7oQ/r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dpula4lhPyko0yJZwc7LTWiB+LRivtPsekXVcq/GblGbqrUHRUgVVi1oWEdXPxDn1F1p197MwvWnTusIhFf0MrpMLr12fkprTz57/lCbp9gCzcCeJBPgqAZCwpitkC7Fx5sKVsY4fyJf/FqfRwWU3iWZAg1CIqx0FOl6eMvLPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bLXyoRao; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5567fcfe71f811efb66947d174671e26-20240914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=xotAzUqezhsD17X56wb62uKRJaTQRcsCpG1PKAuJkiA=;
	b=bLXyoRaoG2BWcPSJ/Lob/YGLmHH4jbYR3bk0ORhMvifoOAmUaBlAx6bHj6/nV1/gzH0pPf1djrTf1weAV0tC6/tEpJIFJ93cPXAaiu6cberu/CQ1x3hEI3RwJcQmMKOFE6KcDyKPU1wwt6G6AWFtgAJ4PdIBznlj4kQQ+79uViw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:260387d0-77f3-4e5a-a2a0-e1a34bc0a739,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:d5672ed0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5567fcfe71f811efb66947d174671e26-20240914
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 321677032; Sat, 14 Sep 2024 01:48:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 14 Sep 2024 01:48:04 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Sat, 14 Sep 2024 01:47:53 +0800
Message-ID: <f6050fa5-4cb5-9283-263b-bcd0d97a09bc@mediatek.com>
Date: Sat, 14 Sep 2024 01:47:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/7] regulator: dt-bindings: mt6323: Convert to DT
 schema
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
	<sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, "MediaTek
 Chromebook Upstream" <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
 <20240830145056.GA4170065-robh@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20240830145056.GA4170065-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.924800-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaYOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rdkc3IJsq77y9FtW7XfHueU+OjsPhIWDiwR/wKmchi2X3ikYeDnk/KepZ
	UyQ6EeDXoapbtUvkIf+xNbFV/iNBgt3ZVSPV8VOi0sO72q2op4f+UEb65dgmQEB/Asc4oaYEfg0
	sA1HT2xmQQJkXF7hk6vMxSxMv7UnmPLG+A0qvEpp4CIKY/Hg3AtOt1ofVlaoLUHQeTVDUrItRnE
	QCUU+jzjoczmuoPCq0Bv7xhCXsjZm/ZfgvjZa1rh9ifqkpf8qhcEkm/83qnHz1B6iuMVH+d
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.924800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BAB98BC90D7C6C90416F4D37BF8B8CF0C1790B6C68AB3A968115B29A6A8B76452000:8

On 8/30/24 22:50, Rob Herring wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Fri, Aug 30, 2024 at 07:07:26PM +0800, Macpaul Lin wrote:
>> Convert this from the old style text based binding to the new DT schema
>> style.
>> 
>> The examples have been trimmed down and move to parent schema
>> mfd/mediatek,mt6397.yaml.
>> 
>> Add new maintainers and submitter from MediaTek.
>> 
>> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

[snip]

>> +
>> +patternProperties:
>> +  "^(buck_)?v(pa|proc|sys)$":
>> +    description: Buck regulators
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    properties:
>> +      regulator-allowed-modes: false
>> +    unevaluatedProperties: false
>> +
>> +  "^(ldo_)?v(camio|cn18)$":
> 
> Why are buck_ and ldo_ prefixes optional? The old binding didn't reflect
> actual (upstream) users? If so, that's fine, but mention that in the
> commit message.
> 
> Rob
> 

Will use "^buck_v" and "^ldo_v" as the prefixes of each items in 
patternProperties. Thanks!

Regards,
Macpaul Lin


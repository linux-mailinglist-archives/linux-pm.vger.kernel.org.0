Return-Path: <linux-pm+bounces-28913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC9ADD27D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D75189BBC3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E12ECD2F;
	Tue, 17 Jun 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="tCiFaxQf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFED62ECD3B;
	Tue, 17 Jun 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174965; cv=none; b=PDmashkq9iUrzp38cxiH5NiljgRBAoW+nkIChtSCCbsUNgrXA66na02xK0xeQhf+pIWyYq6tMeGkVCUFXAuvtm5iQYx+f35UKse2Y4Ys+d6fgNycOdLpZfgfrpyB089FTUNgMQK7vjWV3jrR1hlAht/a5JCKMdfSP3YamnexVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174965; c=relaxed/simple;
	bh=E6kezSGdN55teYM7U2kumz8A/hhUd53+bGnkF7ImWHg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Og5QcnBIfPdg+HqTF80l1arz0ypb082rCOlTLR6OJhXOlRp58AsFLfqqWkER08+UNYTKres8AuvDVJpcmrJw1xlID5XOaUb7PMBnGH9KBlN6PkqbjXF2VjxLLR1HlsDK7J/hmSl6lxjJq4vloTNbJ1w4VDrT+8AkSEBNSqZZ4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=tCiFaxQf; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id C7804100949;
	Tue, 17 Jun 2025 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750174954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4y61tvVtL+Nu9zAfwj8f/C4Um0svSaW4IhjMC/PKRbY=;
	b=tCiFaxQfSyRl2HQrruBNDzRHlIucijlwJHs9wUz8grfg4jPl8cjBHtsE9+0MXnK2mhqW77
	aoemFKp3k0OyAzqkBwmpD5t4WiKrDCfkiSzPM/zuYi2jiNT6tIdvtbdMchKxj6GU3vCEOF
	sK7BDBpkB4XHraZiaJ4BgJsHZFFeO5A=
Received: from [IPv6:::1] (unknown [IPv6:2a01:599:80e:f26f:d033:b886:5aa2:2cc2])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 1868B360564;
	Tue, 17 Jun 2025 15:42:32 +0000 (UTC)
Date: Tue, 17 Jun 2025 17:42:31 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_01/13=5D_dt-bindings=3A_n?=
 =?US-ASCII?Q?et=3A_mediatek=2Cnet=3A_update_for_mt7988?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250617151354.GA2392458-robh@kernel.org>
References: <20250616095828.160900-1-linux@fw-web.de> <20250616095828.160900-2-linux@fw-web.de> <20250617151354.GA2392458-robh@kernel.org>
Message-ID: <D1ACA985-56B7-48B6-8DFA-3B93AF893127@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: dc9dec3d-80df-4759-b36b-a6ba1f02e733

Am 17=2E Juni 2025 17:13:54 MESZ schrieb Rob Herring <robh@kernel=2Eorg>:
>On Mon, Jun 16, 2025 at 11:58:11AM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Update binding for mt7988 which has 3 gmac and 2 reg items=2E
>>=20
>> With RSS-IRQs the interrupt max-items is now 6=2E Add interrupt-names
>> to make them accessible by name=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>> v4:
>> - increase max interrupts to 8 because of RSS/LRO interrupts
>
>But the schema says 6?

Yes it was an error in changelog,see mail i
 sent later to you and ML=2E 8 was previously
 because original version had 2 reserved irqs
 around rx+tx i dropped later by using
 irq-names=2E

See my patch introducing irq-names in mtk
eth driver:

<https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/20250616080=
738=2E117993-2-linux@fw-web=2Ede/>

Original (downstream/sdk) was (but=20
index-based):

rsv
rx
tx
rsv/misc
rx-ring0
=2E=2E=2E
rx-ring3

So total 8 and i don't wanted to add 2=20
reserved irq to dts forever so i decided
moving to irq-names now=2E

>> - dropped Robs RB due to this change
>> - allow interrupt names
>> - add interrupt-names without reserved IRQs on mt7988
>>   this requires mtk driver patch:
>>   https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch/202506160807=
38=2E117993-2-linux@fw-web=2Ede/
>>=20
>> v2:
>> - change reg to list of items
>> ---
>>  =2E=2E=2E/devicetree/bindings/net/mediatek,net=2Eyaml | 28 +++++++++++=
+++++---
>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml =
b/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> index 9e02fd80af83=2E=2Ef8025f73b1cb 100644
>> --- a/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> +++ b/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> @@ -28,7 +28,10 @@ properties:
>>        - ralink,rt5350-eth
>> =20
>>    reg:
>> -    maxItems: 1
>> +    items:
>> +      - description: Register for accessing the MACs=2E
>> +      - description: SoC internal SRAM used for DMA operations=2E
>> +    minItems: 1
>> =20
>>    clocks:
>>      minItems: 2
>> @@ -40,7 +43,11 @@ properties:
>> =20
>>    interrupts:
>>      minItems: 1
>> -    maxItems: 4
>> +    maxItems: 6
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 6
>> =20
>>    power-domains:
>>      maxItems: 1
>> @@ -348,7 +355,17 @@ allOf:
>>      then:
>>        properties:
>>          interrupts:
>> -          minItems: 4
>> +          minItems: 2
>> +
>> +        interrupt-names:
>> +          minItems: 2
>> +          items:
>> +            - const: tx
>> +            - const: rx
>> +            - const: rx-ring0
>> +            - const: rx-ring1
>> +            - const: rx-ring2
>> +            - const: rx-ring3
>> =20
>>          clocks:
>>            minItems: 24
>> @@ -381,8 +398,11 @@ allOf:
>>              - const: xgp2
>>              - const: xgp3
>> =20
>> +        reg:
>> +          minItems: 2
>> +
>>  patternProperties:
>> -  "^mac@[0-1]$":
>> +  "^mac@[0-2]$":
>>      type: object
>>      unevaluatedProperties: false
>>      allOf:
>> --=20
>> 2=2E43=2E0
>>=20


regards Frank


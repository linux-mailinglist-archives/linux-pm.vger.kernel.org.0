Return-Path: <linux-pm+bounces-29889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8680AEF59B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 12:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5A0189E740
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5338C270EAD;
	Tue,  1 Jul 2025 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="q6ygmPaT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642C26E71A;
	Tue,  1 Jul 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367140; cv=none; b=gFXg+kxzP4vmr54xUGMudTtR2Zq75+IPquJxw2c12251fgNRFL4nlXoEXjEAZgasCWgxRJumDn0mBdtZ/OKI3+JoBcM08AKOe561KgyYwdlDzo40bgJ7gKzQmFNHhUCLwm9g3uMEzhtnDlMOZDMPRE4KFlADaYFbz9KGEg5bfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367140; c=relaxed/simple;
	bh=PK2PDcN3SNcc+Zwtx/+Ecvz8LoJJ09xOiNWonKP7GK8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=U0u8W2MJ0iStjGw5eMrKkyM7NwCcMtzn9Os2PnI5cUG53XFuIUNGLm1SPK8Xvsj1jPfUfzPVXJKTebwTQBnLXl/WDBc1bEOOvGCRO+9clTxqxZ9DBFg+bqOFk8PPSw8hPDIujGxzhjT+FkXb3Ms2dpmIJrRkVknHsyoYH8deg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=q6ygmPaT; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1751367099; x=1751971899; i=frank-w@public-files.de;
	bh=fzinALOKJSg5BHqUrqm0HfAIrQmnYOWWzYnc9uuZeLo=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q6ygmPaTuDGvJa475IHhXhS1mWBLh7P5g1oIVBeGG+/bd5MGYcn0rhnD7WerUTNn
	 +sxj0GO2hzp7TBRPTTizuisLpIwy7dSAJkAR4Ufcpj2qNdiXZxzic0ELDMRKI6zz9
	 PT8yfkxKvKlMVbM0Tg50OL1q/b0nSifKzYhz8dUiV+yCoxv2NbnNpqdKAb2a+Reki
	 Q7zgqccbq69ixST29bjf6fhnmqpDemcJ3XHjgxBNJER5I7Ek3jUmnml3hrxiPWtHt
	 BOsN723eBEciXhelCoNKjLGQQ+9uoNRcVjvfTeuhCDJsoBjy3T04PoY1PNZ9r0210
	 mQoAC3nZ1PbsNnbPpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [IPv6:::1] ([80.187.118.70]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1uAqar2qiF-00YN80; Tue, 01
 Jul 2025 12:51:39 +0200
Date: Tue, 01 Jul 2025 12:51:31 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank Wunderlich <linux@fw-web.de>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 01/14] dt-bindings: net: mediatek,net: allow irq names
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20250701-wisteria-walrus-of-perfection-bdfbec@krzk-bin>
References: <20250628165451.85884-1-linux@fw-web.de> <20250628165451.85884-2-linux@fw-web.de> <20250701-wisteria-walrus-of-perfection-bdfbec@krzk-bin>
Message-ID: <9AF787EF-A184-4492-A6F1-50B069D780E7@public-files.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/x13cGSdXeC8a3AZxM86LjNC4QW9IjV/yKhknGpUw58qFVsmBUk
 ManrKwGyZL++1Rgi13uVdYel61STP231jKRojunlUxXrrplSqVsRsRTgN0qu03NSKmzdPP+
 gpXAspXnmqtd6y9LjyPcWQnM67Ya0vTSbd1yf8x+GGeBQvb4wKdZnQSto2cV3wE9BwRdIe7
 75RVRsjc4O7gF9RO63S6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IwHMtIvjAYg=;YDRSDgoITeSH1NIvelvbRaSGEis
 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
 QrcpWXy1JQV2vISFETlQ==

Am 1=2E Juli 2025 08:44:02 MESZ schrieb Krzysztof Kozlowski <krzk@kernel=2E=
org>:
>On Sat, Jun 28, 2025 at 06:54:36PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> In preparation for MT7988 and RSS/LRO allow the interrupt-names
>
>Why? What preparation, what is the purpose of adding the names, what do
>they solve?

Devicetree handled by the mtk_eth_soc driver have
a wild mix of shared and non-shared irq definitions
accessed by index (shared use index 0,
non-shared
using 1+2)=2E Some soc have only 3 FE irqs (like mt7622)=2E

This makes it unclear which irq is used for what
on which SoC=2E Adding names for irq cleans this a bit
in device tree and driver=2E

>> property=2E Also increase the maximum IRQ count to 8 (4 FE + 4 RSS),
>
>Why? There is no user of 8 items=2E

MT7988 *with* RSS/LRO (not yet supported by driver
yet,but i add the irqs in devicetree in this series)
use 8 irqs,but RSS is optional and 4 irqs get working
ethernet stack=2E

I hope this explanation makes things clearer=2E=2E=2E

>> but set boundaries for all compatibles same as irq count=2E
>
>Your patch does not do it=2E

I set Min/max-items for interrupt names below like
interrupts count defined=2E

>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>> v7: fixed wrong rebase
>> v6: new patch splitted from the mt7988 changes
>> ---
>>  =2E=2E=2E/devicetree/bindings/net/mediatek,net=2Eyaml | 38 +++++++++++=
+++++++-
>>  1 file changed, 37 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml =
b/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> index 9e02fd80af83=2E=2E6672db206b38 100644
>> --- a/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> +++ b/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> @@ -40,7 +40,19 @@ properties:
>> =20
>>    interrupts:
>>      minItems: 1
>> -    maxItems: 4
>> +    maxItems: 8
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    items:
>> +      - const: fe0
>> +      - const: fe1
>> +      - const: fe2
>> +      - const: fe3
>> +      - const: pdma0
>> +      - const: pdma1
>> +      - const: pdma2
>> +      - const: pdma3
>> =20
>>    power-domains:
>>      maxItems: 1
>> @@ -135,6 +147,10 @@ allOf:
>>            minItems: 3
>>            maxItems: 3
>> =20
>> +        interrupt-names:
>> +          minItems: 3
>> +          maxItems: 3
>> +
>>          clocks:
>>            minItems: 4
>>            maxItems: 4
>> @@ -166,6 +182,9 @@ allOf:
>>          interrupts:
>>            maxItems: 1
>> =20
>> +        interrupt-namess:
>> +          maxItems: 1
>> +
>>          clocks:
>>            minItems: 2
>>            maxItems: 2
>> @@ -192,6 +211,10 @@ allOf:
>>            minItems: 3
>>            maxItems: 3
>> =20
>> +        interrupt-names:
>> +          minItems: 3
>> +          maxItems: 3
>> +
>>          clocks:
>>            minItems: 11
>>            maxItems: 11
>> @@ -232,6 +255,10 @@ allOf:
>>            minItems: 3
>>            maxItems: 3
>> =20
>> +        interrupt-names:
>> +          minItems: 3
>> +          maxItems: 3
>> +
>>          clocks:
>>            minItems: 17
>>            maxItems: 17
>> @@ -274,6 +301,9 @@ allOf:
>>          interrupts:
>>            minItems: 4
>> =20
>> +        interrupt-names:
>> +          minItems: 4
>> +
>>          clocks:
>>            minItems: 15
>>            maxItems: 15
>> @@ -312,6 +342,9 @@ allOf:
>>          interrupts:
>>            minItems: 4
>> =20
>> +        interrupt-names:
>> +          minItems: 4
>
>8 interrupts is now valid?
>
>> +
>>          clocks:
>>            minItems: 15
>>            maxItems: 15
>> @@ -350,6 +383,9 @@ allOf:
>>          interrupts:
>>            minItems: 4
>> =20
>> +        interrupt-names:
>> +          minItems: 4
>
>So why sudenly this device gets 8 interrupts? This makes no sense,
>nothing explained in the commit msg=2E

4 FrameEngine IRQs are required to be defined (currently 2 are used in dri=
ver)=2E
The other 4 are optional,but added in the devicetree
to not run into problems supporting old devicetree
when adding RSS/LRO to driver=2E

>I understand nothing from this patch and I already asked you to clearly
>explain why you are doing things=2E This patch on its own makes no sense=
=2E
>
>Best regards,
>Krzysztof
>


regards Frank


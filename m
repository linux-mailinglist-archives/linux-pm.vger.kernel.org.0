Return-Path: <linux-pm+bounces-29224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0EBAE2F9E
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A74816BE9D
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84751DED42;
	Sun, 22 Jun 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="kFkDrSko"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040F18C03F;
	Sun, 22 Jun 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750592753; cv=none; b=NzZKgX11FA2SuDUNxctyu53YujnlyH/Tl01dFycjGimQsCfuG3UEBDUnQNWElyKUMW/9BdNa2o3rPxOfzSfznUbhkwsS7heWtIOu7lFYts8xudUxULCckvTvBIadJl8kkfhIxrRNCpEOsP4R1c+CjiNIW4pAVoAKxXlkUF5hfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750592753; c=relaxed/simple;
	bh=NTnfvI0ef/rqaTY63+Tjx+p92niOfjjbvILdaXFdx9E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NW/2iwVRZWebzcssNZ9mmGRlEvHFiOn/J2vHKNRKz3ILaJzsNk54EE/iTxvQ5bj+mUJHewe/n9JyTO08+GwuoFNuPwyGDNsalnyJmtctsH44sMIBRId9B5FWh0upyH9eCI0ClY2gKDrD5Tutu3Xso6BRE8pRKhIk9KVbyPrM8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=kFkDrSko; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1750592706; x=1751197506; i=frank-w@public-files.de;
	bh=V5PqOs3/xKFezUmd6NAwv3w8UOkeGu5C9tM8XmOfbSQ=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kFkDrSkoN5p2YldLIl98CfwrfIcyhOqULm+WmcdIHZXHnkIaXc3sLhDUJbiJx0Qc
	 eMN80zsvd8WtD83oIOopeXQnX9YKcjZ3Imtrl7CKJvz1uA4mEU0XEyyzV1nLswmzG
	 1tH7qQ7ceUKc9z5dBI5Ew9ndZVD1Mr6hW/fn+R/F8T/cLO5vY3y5ozQ5/B6A3mz+p
	 f8IIF5vPPbXc3QCFoxqP1c295l3rKtXa6xrypS+Sh9Odwfli3gk7WErOOy5GgZ4Wl
	 C3cOm7wkR0R6m1S6Z/INbzztFbqPtcNx9KtLgZIyUEoRgoVvFNJh9jW6lZ6KnmFdm
	 SX/YT3unxu14P5ek5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([157.180.225.81]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1vDK8Y0sie-00cVd7; Sun, 22
 Jun 2025 13:45:06 +0200
Date: Sun, 22 Jun 2025 13:44:52 +0200
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
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_01/13=5D_dt-bindings=3A_n?=
 =?US-ASCII?Q?et=3A_mediatek=2Cnet=3A_update_for_mt7988?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <jnrlk7lwob2qel453wy2igaravxt4lqgkzfl4hctybwk7qvmwm@pciwvmzkxatd>
References: <20250620083555.6886-1-linux@fw-web.de> <20250620083555.6886-2-linux@fw-web.de> <jnrlk7lwob2qel453wy2igaravxt4lqgkzfl4hctybwk7qvmwm@pciwvmzkxatd>
Message-ID: <100D79A2-12A9-478D-81F7-F2E5229C4269@public-files.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+r1sBgNM7c57oZwI1X1Lex+Vk+TlgKFmXGGKMZI21F/aRb9y7qQ
 upSptjxfZBqLpOGruu5mXs/Ondcwe7HU2HwpsFNQb0HhlqXLcHOCZcasJNByAOoDrHQ2SC+
 EXGC5inY7x3PdD+gGZj8DTEuBXQL33tO6CYv2VU+eLM3GUAyxGwQ5YtDzj9eZPt1UQRVnt/
 Rxzk1lhyjApnX034rNTNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bWFyMbVZYnw=;lif7dhqLi3iNLh4tsO2z2HnMbx0
 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

Hi,

Thank you for review=2E

Am 22=2E Juni 2025 13:10:31 MESZ schrieb Krzysztof Kozlowski <krzk@kernel=
=2Eorg>:
>On Fri, Jun 20, 2025 at 10:35:32AM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Update binding for mt7988 which has 3 gmac and 2 reg items=2E
>
>Why?

I guess this is for reg? Socs toll mt7986 afair
 get the SRAM register by offset to the MAC
 register=2E
On mt7988 we started defining it directly=2E

>> MT7988 has 4 FE IRQs (currently only 2 are used) and the 4 IRQs for
>> use with RSS/LRO later=2E
>>=20
>> Add interrupt-names to make them accessible by name=2E
>>=20
=2E=2E=2E
>>    reg:
>> -    maxItems: 1
>> +    items:
>> +      - description: Register for accessing the MACs=2E
>> +      - description: SoC internal SRAM used for DMA operations=2E
>
>SRAM like mmio-sram?

Not sure,but as far as i understand the driver
 the sram is used to handle tx packets directly
 on the soc (less dram operations)=2E

As mt7988 is the first 10Gbit/s capable SoC
 there are some changes=2E But do we really need=20
 a new binding? We also thing abour adding
 RSS/LRO to mt7986 too,so we come into
 similar situation regarding the Interrupts/ =20
 -names=2E

>> +    minItems: 1
>> =20
>>    clocks:
>>      minItems: 2
>> @@ -40,7 +43,11 @@ properties:
>> =20
>>    interrupts:
>>      minItems: 1
>> -    maxItems: 4
>> +    maxItems: 8
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 8
>
>So now all variants get unspecified names? You need to define it=2E Or
>just drop=2E

Most socs using the Fe-irqs like mt7988,some
 specify only 3 and 2 soc (mt762[18]) have only
 1 shared irq=2E But existing dts not yet using the
 irq-names=2E
Thats why i leave it undefined here and
 defining it only for mt7988 below=2E But leaving it
 open to add irq names to other socs like filogic
 socs (mt798x) where we are considering
 adding rss/lro support too=2E

>> =20
>>    power-domains:
>>      maxItems: 1
>> @@ -348,7 +355,19 @@ allOf:
>>      then:
>>        properties:
>>          interrupts:
>> -          minItems: 4
>> +          minItems: 2
>
>Why? Didn't you say it has 4?

Sorry missed to change it after adding the 2
 reserved fe irqs back again (i tried adding only used irqs - rx+tx,but go=
t info that all irqs can be used - for future functions - so added all avai=
lable)=2E

>> +
>> +        interrupt-names:
>> +          minItems: 2
>> +          items:
>> +            - const: fe0
>> +            - const: fe1
>> +            - const: fe2
>> +            - const: fe3
>> +            - const: pdma0
>> +            - const: pdma1
>> +            - const: pdma2
>> +            - const: pdma3
>> =20
>>          clocks:
>>            minItems: 24
>> @@ -381,8 +400,11 @@ allOf:
>>              - const: xgp2
>>              - const: xgp3
>> =20
>> +        reg:
>> +          minItems: 2
>
>
>And all else? Why they got 2 reg and 8 interrupts now? All variants are
>now affected/changed=2E We have been here: you need to write specific
>bindings=2E

Mt7988 is more powerful and we wanted to add
 all irqs available to have less problems when
 adding rss support later=2E E=2Eg=2E mt7986 also have
 the pdma irqs,but they are not part of
 binding+dts yet=2E Thats 1 reason why
 introducing irq-names now=2E And this block is
 for mt7988 only=2E=2E=2Ethe other still have a regcount of 1 (min-items)=
=2E

But of course i can limit the reg/ irqs/
 irq-names for each compatible=2E

>https://elixir=2Ebootlin=2Ecom/linux/v6=2E11-rc6/source/Documentation/dev=
icetree/bindings/ufs/qcom,ufs=2Eyaml#L127
>
>https://elixir=2Ebootlin=2Ecom/linux/v6=2E11-rc6/source/Documentation/dev=
icetree/bindings/ufs/samsung,exynos-ufs=2Eyaml#L39

I take a look into it,but allowing irq names for all matching compatibles =
does not require it for them=2E Or am i wrong here?

>Best regards,
>Krzysztof



regards Frank


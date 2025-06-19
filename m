Return-Path: <linux-pm+bounces-29054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747EADFEB0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 09:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A197AA020
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1C925C71B;
	Thu, 19 Jun 2025 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="UUj5/2Zl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1B2571C5;
	Thu, 19 Jun 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318104; cv=none; b=mD2JJki6k87Gn10WJfyLBFp43wBQs2njy9IEX8qXaoA64zN95iUKUbU9pL7IHiydUitudv3m4L6NBB7GGONS38/RXRx+iHxoNWcEVcfGWRO2lNxjqdkUGnw2a1z1GhGUei4SNYtfLJqWA5aibX+F3ckHqAL0mjOfqMpdwmNrtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318104; c=relaxed/simple;
	bh=Ewm+addfvSDikRboSHhhbhrr12QAKX2Gpa+H73HFsWw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KarAv6UOTf0ol81wgQHbUYf0dpD33BsOhlTdWLiQ/KqMJS4wPFBIxt5dKomvUfYxM/xJzWCLEZIflqe1ipB0sGHNeHbIRIGjuxtH6JRDVitBp4UTL7a93V3yPRoWeisMhcumRo4WDXTyp3YAW9OSW6Iih/AH0+JyAehC5DoK3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=UUj5/2Zl; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1750318060; x=1750922860; i=frank-w@public-files.de;
	bh=waa0tpkCKiHZk7WUJJIS/rThJf704mbh76mxtiYq81o=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UUj5/2ZlVTmsOTcBj0uoIeI/f3n/Bi8B0/9zxTrVPwqyI8TdWBgWYjnr21mbHUWY
	 R8tboJA+SNf0F4PFKFUtyg+7fmzsY+k+0A17unR8ws1iYkiFVx2Z4d5H9N4YVl9//
	 chct74iQVq5/hgVGFI2jlyi+C3aRtF7SDwbjC3M0EIbzDSMnCuuhdruIMsF/Qlh1G
	 mSruxeE/RDxDlQN0IkAL1kkaYnwPcoEznMHD2+2XhJo+g5/mawXQPB4+Ra4YrTF2e
	 jBk7kpw9DnlgxohrPm+XFoJUKW+mIzyabCgGSgDHNJ/fbrgEKz1h+aoAYeQaFDXXl
	 bdN1H8xbNAMY8QO4lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.76.73]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1u6lBd2yxi-00PdST; Thu, 19
 Jun 2025 09:27:39 +0200
Date: Thu, 19 Jun 2025 09:27:23 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: "Rob Herring (Arm)" <robh@kernel.org>, Frank Wunderlich <linux@fw-web.de>
CC: DENG Qingfang <dqfext@gmail.com>, Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Landen Chao <Landen.Chao@mediatek.com>,
 Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 devicetree@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
 linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Felix Fietkau <nbd@nbd.name>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Johnson Wang <johnson.wang@mediatek.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_01/13=5D_dt-bindings=3A_n?=
 =?US-ASCII?Q?et=3A_mediatek=2Cnet=3A_update_for_mt7988?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <175026826312.2322513.8876769837630455596.robh@kernel.org>
References: <20250616095828.160900-1-linux@fw-web.de> <20250616095828.160900-2-linux@fw-web.de> <175026826312.2322513.8876769837630455596.robh@kernel.org>
Message-ID: <9BC433E2-B764-4DE6-A760-D054D981F652@public-files.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q+Q3bL2VPEIF7bQ0QHxlDWXPnd/Ii5Fo66vg5xZ5klhHgyhraJ3
 mc3YMx436z3Wp28bYyctybXZJq48fZ5LrWJlCl6ZxqDAWnw/o7HwIB0rtdAcCgLrjVRW5EH
 B6IpU8mBap9ufFBpTSCbsw8gvVCDRZXOHVMbG9oGlS561WFrQCMzmdgOTeR+tIY2cdVA0V7
 iX3hGZCHjR9KdFN/yPHNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WQzJv+DCJ1c=;LweDzB+7EvdV75Z5+FSp/bctZkP
 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

Am 18=2E Juni 2025 19:38:07 MESZ schrieb "Rob Herring (Arm)" <robh@kernel=
=2Eorg>:
>
>On Mon, 16 Jun 2025 11:58:11 +0200, Frank Wunderlich wrote:
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
>
>Reviewed-by: Rob Herring (Arm) <robh@kernel=2Eorg>

Thank you rob=2E

Have you seen my reponse to coverletter? Got info from mtk that reserved i=
rqs are not unusable (only currently unused) and imho they should be upstre=
amed too but without a special meaning=2E

What do you think?

I would increase the interupts count to 8 and name the reserved irqs fe0=
=2E=2Efe3=2E can i keep your RB or should i drop it again?


regards Frank


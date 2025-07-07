Return-Path: <linux-pm+bounces-30247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA6AFAD1C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148E817CAB1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39E274B32;
	Mon,  7 Jul 2025 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="tcPHlMoW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B3279918;
	Mon,  7 Jul 2025 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873438; cv=none; b=BQnn5cozS4YrbcP0qHNUkcgoM1nl9NTSYtkm39Kz13NwVBZqSW/vLeHS77fCpe9mErQ9ycXNg1y7iLuAAmSqELsjmAddnP0F6tqkHn6ECo2ps+oZR4IQJU+hxXUfLsdcClIqvDcZZ5voekMCj9mKX/mvoVpXeBpQV626/+4a0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873438; c=relaxed/simple;
	bh=zVp3mU9tpJoLyKShOFZbvOMZjx+sbDfvqdrK5RIOkbg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dnKZKvJFkxX0ObBgAWIdHZYyi2AfLGJdmzplvA+FMz7A63lWrxMDGJ7F9V8FTwGQWQ6uY48Sr3SVZeDmfP5UNY/wvFV0BGBbHOJ83W883p94JgD3wHroH2BQ114p6BhGRMkTe7k7rslbvu3fipw7Xx3oq+mei+V9FxsWqTAoLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=tcPHlMoW; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id B0FE35FAAF;
	Mon,  7 Jul 2025 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751873433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVp3mU9tpJoLyKShOFZbvOMZjx+sbDfvqdrK5RIOkbg=;
	b=tcPHlMoWChlrn8xTPaCqBQ/0kL86NAfoif4bczhRr5EPFM2mHMEWkuotkm7Qcm8BgxNhKd
	cfd7uYKu7+c3NyNy1MFOYQHSkksnV/+Gw9qqAyCXu09nxFsZXLYurxI+bXh6AVtUosXhwp
	CTur5EUurSQKKFv4T1RiC3Lo7PaHHeg=
Received: from [IPv6:::1] (unknown [IPv6:2a01:599:808:65f4:756a:9686:4114:2d58])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 3BB8D100758;
	Mon,  7 Jul 2025 07:30:31 +0000 (UTC)
Date: Mon, 07 Jul 2025 09:30:32 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_02/16=5D_dt-bindings=3A_n?=
 =?US-ASCII?Q?et=3A_mediatek=2Cnet=3A_allow_up_to_8_IRQs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250707-modest-awesome-baboon-aec601@krzk-bin>
References: <20250706132213.20412-1-linux@fw-web.de> <20250706132213.20412-3-linux@fw-web.de> <20250707-modest-awesome-baboon-aec601@krzk-bin>
Message-ID: <B875B8FF-FEDB-4BBD-8843-9BA6E4E89A45@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 03c03832-acef-4e85-9034-7323a57b8c25

Am 7=2E Juli 2025 08:31:11 MESZ schrieb Krzysztof Kozlowski <krzk@kernel=2E=
org>:
>On Sun, Jul 06, 2025 at 03:21:57PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Increase the maximum IRQ count to 8 (4 FE + 4 RSS/LRO)=2E
>
>Because? Hardware was updated? It was missing before?

There is no RSS support in driver yet,so IRQs were not added to existing D=
TS yet=2E

>>=20
>> Frame-engine-IRQs (max 4):
>> MT7621, MT7628: 1 IRQ
>> MT7622, MT7623: 3 IRQs (only two used by the driver for now)
>> MT7981, MT7986, MT7988: 4 IRQs (only two used by the driver for now)
>
>You updated commit msg - looks fine - but same problem as before in your
>code=2E Now MT7981 has 4-8 interrupts, even though you say here it has on=
ly
>4=2E

Ethernet works with 4,but can be 8 for MT798x=2E
I cannot increase the MinItems here as it will
throw error because currently only 4 are defined in DTS=2Esame for MT7986=
=2E
>>=20
>> Mediatek Filogic SoCs (mt798x) have 4 additional IRQs for RSS and/or
>> LRO=2E
>
>Although I don't know how to treat this=2E Just say how many interrupts
>are there (MT7981, MT7986, MT7988: 4 FE and 4 RSS), not 4 but later
>actually 4+4=2E

First block is for Frame Engine IRQs and second for RSS/LRO=2E Only mentio=
n total count=20
across all SoCs is imho more confusing=2E

>I also do not understand why 7 interrupts is now valid=2E=2E=2E Are these=
 not
>connected physically?

7 does not make sense but i know no way to allow 8 with min 4 without betw=
een (5-7)=2E

>Best regards,
>Krzysztof

Hi

Thanks for taking time for review again=2E

First block are the frame engine IRQs which are max 4 and on all SoCs=2E
The RSS IRQs are only valid on Filogic (MT798x),so there a total of 8, but=
 on
MT7981 and MT7986 not yet added as i prepare the RSS/LRO driver in backgro=
und=2E
We just want to add the IRQs for MT7988 now=2E
regards Frank


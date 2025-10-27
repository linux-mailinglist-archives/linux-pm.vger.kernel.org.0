Return-Path: <linux-pm+bounces-36907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF0C0D629
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 13:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B79422537
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B202FF656;
	Mon, 27 Oct 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="civc0jIU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22F2FBDEA;
	Mon, 27 Oct 2025 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566197; cv=none; b=oHFb1VB4UW1Ip+Ew3NISV1beF+EAKzYJ57kXbjSOeRU2DcOpJiuHpJ856uQ1McZwi4Rjupg67JRnt7Pq2IMBWUk8wY2n5rICsaonAeGL+AcLNIsOTjvIXto6evjidpgpHmAL9Wod+AFIhi8GGrxyJqjllwyhKVhGIWp5SI9GaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566197; c=relaxed/simple;
	bh=9OGkJVJ45qtPKQyI7/RCIvdM85jSkeuhNffNRsXu1vQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=b1DvGZ8Xx4GRwNT6ijl8kImhIZKPjzD9KIwdu6Yxj/1J1951GiXvMYfP4Gm45RbZfY0WlS98Tldc+5FblGHnscbZzoT/hKiMAONevIXpn5UI8K+q2lT1u6AwnHzghKMOohBpSxnFKcfm5P6pZyCL/sA5+MklJoSxLBfpu+mNarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=civc0jIU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1761566188; x=1762170988; i=frank-w@public-files.de;
	bh=q1+2gFkrxY6m/U7u8dzCBDzgNo3djn7xfSEsltllsG4=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=civc0jIUwW6SoLobk7dIdSQStdwux08xKrwkDcRuzbluG+oK4Rr3A2Dqno+bYfYW
	 rHSc0kMXS+GzW0p4LITyYrTyAkNOM+lwwNE8uMdfGyHdbN5Om6ULOWe0skarFhKdZ
	 mij0PvBZoVaANU2m1UVeAX9eKCxsL9Egd5SltPqXa9lRpq1YrTTSdOEjDbcs8aNEV
	 8X0tWQIaaB+lzmSyymdv0U97l5/XAOLDaW8DX5CxxWfiLgie33Jt/x/lGrXISqD7Y
	 fKVQ/GzF23CuwTa8bkEoDKxg6pdMQgT83i50qX6TYVohHRDeXWWkByyzzJUGWpLWS
	 WJ/vHwke3/CqRwLqzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.158] ([217.61.159.158]) by
 trinity-msg-rest-gmx-gmx-live-654c5495b9-nsbx8 (via HTTP); Mon, 27 Oct 2025
 11:56:28 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-ecc07569-6b82-472e-80d4-5e41728a4ed1-1761566187916@trinity-msg-rest-gmx-gmx-live-654c5495b9-nsbx8>
From: Frank Wunderlich <frank-w@public-files.de>
To: angelogioacchino.delregno@collabora.com, linux@fw-web.de,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com
Cc: nfraprado@collabora.com, mason-cw.chang@mediatek.com,
 u.kleine-koenig@baylibre.com, bchihi@baylibre.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, rafael@kernel.org
Subject: Aw: Re: [PATCH v1 4/5] thermal/drivers/mediatek/lvts_thermal: Add
 SoC based golden Temp
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 11:56:28 +0000
In-Reply-To: <6f71b834-2b4d-48a8-be6f-1efdf0e78812@collabora.com>
References: <20251026122143.71100-1-linux@fw-web.de>
 <20251026122143.71100-5-linux@fw-web.de>
 <6f71b834-2b4d-48a8-be6f-1efdf0e78812@collabora.com>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:6q6PGOlzcCNzMNaTrdZ3gzfoNmPOdU+wx3DB5m2may/IeMwf4QtuG3f9yeaLhhpA05smP
 jruORDfxpBXBuQT5ScmHGSRedy6RIjK4f8L4doDqjyVOo7KG/PILZPnhJjeK3Xm8S5JgAjz4IwU6
 dX9IJevAcU29kLeuyZX/9pbbR0BavbvPzIXl4xG6x1LZjOYdKUz0n+8Y6pG+8FcN8ECilxjt8Nbt
 WPvnr0bursIzseoEtQAdh2Hd+4a8pP08NbVtU3On7udme1LOsbuGjLAPD/Q3jpjBnxgCbH9mImPy
 tbuoBShVH9e6v2kctnnxNmqYORCeZCJU5ndP91hoO2qCYncp5OTLIPe5siQ69Ql/vg=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1mI2S1j+1GM=;c6wDB2P1jLfG5s0jCPIAv7ijtL0
 GJmMHf1Hg1aFE0j/TwnY7dq/e4bHS/+SdFcPF7K4cYPvikPgRb3MlT2fMHW4WGrJxEjrp0IF6
 I8P40+tzkhyRlwYyWM93vI2ZhObB/qOVbkMmLv9mPnFCHQFseSnfm94io9zVTWoIgm6APWpxe
 Tf5hU3WdVaGF8QNZbo+M3bsVPGznjOxl+oWbv08BrrNYqUxAZ008GUlFD7TwpBvjKhSpec+vh
 pEjYsolTFp/FhPWPqvNUo4t8+yrousvSsEJADCANSt1PSu5JPvJY4i1ernUFZWY9JFxldB81Z
 ovFs1uXfiO5WRBvF5fL7fiAwVVWnUUj/zJolYHMRyi7zwlvewGKf6o2L5G/NEFp8jBI6aiMVF
 4kUIbgAEUMHyvJKlrjGccLkKN0Ut7xoMGdYpTpNLumOpVWJo8wciwfJVZ51WcgsfDADqFeynm
 8Y1u8P08yRqxu4R3dKABEY5K4yyZSRs2QyAaF1a7PrGwMPLzn0asRNvlhfgAXGrSMXJ1W8SWn
 GzdiSQhcTvuSusUgL+AjbB/sVQABy/6M6HPzCYA3wgEFCMuDZbuZNJTtZIXnIicY6kADYg4KO
 vucVhvm4QSL/D9B4V45VDBwXPpPuL7PwyL4aIaD7UYUPIzbasxP+eixBwMB9XJA+vt8G1qSDs
 GC5OcksfRu/hts5RTNOeGoJOHPGYAj/tmpsMmOwEHgZNzOxZGJ+HmTV/Bh3uXgIrY91af9Pk6
 IW5E6jEo2hnTGzXSyo+5o61loDaBAWz83OdSZweHby8jGI2jS5WaWMHYLV0EmGSj0tUBiDAnQ
 NKxvKbaBDLk65q4Y4twJf1jCMKbgcUC9nrcRZE8Vx3wkjtO5mbGBD8JDvefTT4gefUsZNmzyF
 pbd/4nbS6KqqZOMKX1NzQYUUnlS1sUbY6ejRd3BKUDz/te2P6xJrdscT13PviEwPzsCDwZwFT
 eAQQTMOoS2j1P1p1mh3C76Lc/1VpK2BKiwtVZ8Hjom+cNPIACZ6IscSDxdpqj8IiQIR52iNWD
 dSM1CZx6uEKY74K2R1JFqPuaRAkHKeXI9PWMSGWrusGduuDJsYiXtMvIYhYRjpl5krhuohnvD
 kuz0YbxXa2mSMvVTy2A2T2ApR4CjXrPi8ZncUs8FkzW6HLqrt9e7GYSI1MgEbfhNY+2RFK9Uh
 q7s6wCGPvOEjmZLT8IoGW3lFA1DD3uzB5Zn7paeAqVDz5MPFbFOnVS3Y4ICAM1U7Ic7YUGdRX
 7T35GJqxY7N4OD8hjS77qLZeP0iBwO97eHvUrObEX+myRBPA6uGuhcAONPnYKqTnhGUAugubz
 kpQ043GScV5QcoPXhYZRN4VE2oApxDNqneFxNsD3RTYxosb3bH0Vh97+OO9unGqiT7tS0Jp87
 zJ/Ybq9LvOyfwpmTeqWrWj0qZBSlIy0Fkd1GXhfsLFkRczDCFi/OAErCVPCRRUbby7nGVtfPK
 Lg8jk5VZ4O70B7DQJxXhEqZXEPe/JYdPRV8aQSsqEXkF167B8zc17ZLdArU/DrxqKijxrJfuk
 RQz2UJLVtuCcJO20XEbpnmz5nhjNfa51WymZnpIehl8Lh+3VjQ5ML5V/Zkk15Azfas4B86Woh
 y33CpbtEApOikmi4eETOYfPic27oL98TgHHLUUQsEtmEGxVdNeqrvsuoTIvVWQf3cAWD7pZb6
 E/ok8zeUDh7UWKuvpdzssgb9GEQkRPBltf+nWi3bP2U4PJhfvUhSD9Ye1AN+1B1snak2NVxqQ
 rabX+42SzMMfZYT+i1drrrslBhIg8ZJRS7aXG3FFJekPaWzKMqgheVWkQV4+1q4Scqzhr5TvG
 ZPiHQew+6VjnzESsFeSOxKEBgsiHKxyBaCO/P31/2WAU82/Gl6r7ygg2vVnZ9jkxmKpZtugCb
 uHPAN9Wq/7NRdh3LW4gyFwYWJ1C5O2as5t1PQHk5DOSaiUvPsuZfwE2oU03vtPUuHc4zew+7L
 n9EiXg6Jh6asnHyt8vI3cu+5uGQn9tqK1FmDAWbOPcYX5rwL90bghAkBvM/BzrKlrcU/FQFtd
 R6CCCpX9yA0H2IXCwd5kEvok9epTBD9uSWlo9tH6LQBMgdLdt54jY3DcP6VrzXEg3w4T5KXiV
 HLN0J6yBoXQdQrdRqv+u0a55cjWgX/2piQu42yxQXrNWhzCBr7QtKF7qwBJaYBdtRkHlpOki9
 YuKJqoSaLvkap8WJpEfIC+1gcxevqg8iV64WvqePXUSUgrRgleg2NKj76wZmJWllYXN68ffLp
 Mp+Z/6ZKTmkoNzbxSONm1Isl2AYuC/HzkYTojiT7hXoDANb5MLI6OeeywzXruM+Tx+q/b7BQ7
 r4JMfMzZxI0pIex7fpDNNCa+WO3b5ldEWEl8QFQQnbW6jt99x6Xf+W5ZVBAYMt76ihBwBQ9uk
 10jvSmy0DupAtigCAYKHFD1hi5vp7/3fteohNpx7AFxKoM2dZtDp9aVOT/ITcTwE9T98WFJo7
 AS1Z0SmqeEfQC0jXWTIpo1ZJUHAsmIcYd9ZjHaBvmnZWSEcKvLBJk1QZHxEGNjentRmJhvaC6
 VFWYBx5kH1OhOergWSS0nWzmOeWXhxJrvgz8UfxICzb159aI70XInlqLdhWn9+pJbC0t7gkc0
 gv8ryIaXBUn5e9D8l079fIXUtJ+MwR5Zu6d4mgijAdCcPM96S7cm5e21GpvW1rhfCpBa1t+T6
 wFaTXRHdGF9nC6rrS5BucKdFtK/I9HB4E2rpGi6c+Mg296r3VtujdFOYVfMLLTZ6tB+jes4AK
 6xO0LZhwJvFn37EnOhf9C869AZs9Os06KryO8J3ar78moYkQJ7BOUg4v37HJ3YUo8INSaMypI
 uTeSKxhefcEOuwfj8bR2Z9nIx1O+5hx/G01cdnJLK05FEtLFQ92hYvu78vz7/aAakFzm+qgZO
 Kze7s7TAk87J4FdJAemkGXaNdZCNatRW5DrY8tSZSnP+UvAfZTtPp341aUlFw0Hk3nbGVJ7ef
 Y04WrCFil/3/WlqqvG0VvEqK+s1CPcf8bQEx/94bM+hoiVLtAFAHN+8C5JrI/pdIPwoHrsMSZ
 auYuS31okZYxq04mnP6nSAt1Cxvi6of4YmSAyeJxh/n2bSdC6eM48N6m2T7EtGFG9gSObAM77
 vwGRi7QWhULfmMcU/1kWzaNGZUzXfjrP+inyesggVzFu3ue1J4TTtx4n+F/DgV4F4D89NLT1P
 aO9QIdOHRDsGMuthPyw2HnFwfwaU3att9K9sycFBlALue51axqqJX27uKI0vivfFBp8/TQnoL
 nJMg/0/V0w+rl3SM898sBT0ak8zww5+bjNgtv4mYRKIYuzKnvd/8OL9FiM+XLs9pieK+5Jaak
 gI/8uEajL0N0RLOtIqxUfa5tQAGG7xZxm+QZwU7bhl8sQDuq8GVc6QOLp2fGN9bGxGACSBMOK
 E76lufotmHO6cDaWXNwca4LtvZ50FLpfns2VlbSHqwuGkfTnZEv1ZgyNraB4MVppZNUnlbjqc
 8Y5gpc2rYee9NCN3WUgc5Aj1m1hMu8CQuiO3UPHKU//1n1gQ4uKWXd0KD4r6WMbIuvMogYkmN
 Ftn780835yDTUdavGvFnrdnLHayNVFPeNQ0St3CXIEpSsIaOp0+rz3VCdrFbUIXKa6vEM4Lje
 DHPN8iQCnKWicvuBqhI2CDRZbbj8izcGcH3WtDxmf8EauB5GyNgZM63GJRAjeKLXKlU3ClwJq
 K6zP2q+faTzH1EcPAI+mVtAFBlV8lthX2h1f/VaH0RLa8E13cD95BZOL3OwWbQG4TdPfziXq8
 g6LM/Zd8AOcebwRYf/VM5n5txHEq+vrke7yXoJBlbse0x6BE+/zdiKo77VxM2VSgr5dvgcHkr
 LuvLKd9E29XkjeiorNoV99YzgHSsuYW+p9NEngXGBtPpeoaJW6Sn8iapoVoGjuPsxi8DOK41U
 LXKcjZjJ9NNyPsLdRVGg54cBu+wG4Qfeo7cUboTi7ui8gAm4FVDltIg53rmpxpbMnvlxi0DMN
 TSrRQqhvZ98WbT6pTX9tMoVY8x1wiA9izD1gAfEd8mTQuGq5HWb6IU4dl/9OrCpxUgTHWlpnv
 AlsNOwHlCSTZizat/AjXNG4dG7BalTSaK8PRAzANiA8reKYoeeeyVAn/oN8m0tE8QarxPPuLm
 mp+rfYSpPBPcbxmoUr4Q8uPlT3+frYxlaA1FVRjiOpCm+6WFIM5VXaedGhrzEbtzsf8c4i8Sh
 i+dlA8UCjSLx19NRqrm4ywnHeGcFmBSODtXxf9W9o6aT0EGPyslhsULp2P/IkIeRHkurI26O6
 bSEoT1L/xePf9LpAIGvJ/onZTLUcY+KlLV/O5ghzXM9yBv1gXd1UUG1l29xHcQvvAlGbJWN2L
 YN1xugQEMxXNxEvpRqpy9oI//ty2kmoeveDkQbZW+9rh0yCt36QsMGeqAvp1Y8DO3XMrlQr2Y
 chlUa9/QgEpiSEQPIBnQ73DCw9J6Vsgb6uQ3czIYnZPiANcdw+1rO6B0tuKurzl2fFYMcpstQ
 t8FVCecE9xb09T0XZN5qMnjwy+K5CWsVepJVI0YRaSuMEPtqFg/zZfd9dJbRvCc180NXuCOeT
 cSpTn8Y9VY9ixZ6RWn8zzgK0+OwyMb15aaR0h1wgrPvKfxhq5w5ed+QQYuaHcyDvGAq9CkZQf
 G5iwLhqpuTRHrHZRAx1aHyZZSR+NNAEHfuBMVq5k5pPnGoGf0idh331uuxqSBG7JfOgInHMCt
 ZkJ2yxFAG1TRIlUI8m5y9Au6t98652eKVvHvBiKAfdJK6gfuWdZCfaq/1mBKV8F/nc3pled9h
 f15chdonyKQJ3inFNNh9X52RNe3uuZotVaCtgywE4VlggO6TYIt74Z2M0TM9umsFvMnIDLiUq
 ob+zRueSpyvQNv27eHgxrBa0UJcT0lrw==
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

> Gesendet: Montag, 27. Oktober 2025 um 11:45
> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.c=
om>
> Betreff: Re: [PATCH v1 4/5] thermal/drivers/mediatek/lvts_thermal: Add S=
oC based golden Temp
>
> Il 26/10/25 13:21, Frank Wunderlich ha scritto:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >=20
> > Add SoC based golden temp for invalid efuse data.
> >=20
> > This is a preliminary patch for mt7987 support where goldentemp is
> > slightly higher than other SOCs.
> >=20
>=20
> I've found this "hack" required for all of the preproduction SoCs, as th=
ose are
> usually unfused and/or missing at least some calibration parameters.
>=20
> Are you using an early/preproduction/whatever SoC, or are you testing on=
 a retail
> board?

thanks for looking into it. I'm using a Bananapi R4 Lite v1.1 so not pre-p=
roduction SoC afaik.

Not sure why i ported this patch from sdk (maybe due to patch compatibilit=
y and thinking this is needed).
Tested without it and it seems to work as far as i can tell. Will drop it =
in next round.

For the no-irq part i also ported this from SDK where no irq is defined (i=
 also wondered about missing irq-support as it would require polling to ha=
ndle emergency shutdown which seems not done in sdk too):

https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds=
/+/HEAD/autobuild/unified/filogic/24.10/files/target/linux/mediatek/files-=
6.6/arch/arm64/boot/dts/mediatek/mt7987.dtsi#556

https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds=
/+/HEAD/autobuild/unified/filogic/24.10/files/target/linux/mediatek/patche=
s-6.6/999-2101-thermal-mediatek-add-mt7987-lvts-support.patch#160

the irq_enable part is squashed with the mt7988 lvts support:

https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds=
/+/HEAD/autobuild/unified/filogic/24.10/files/target/linux/mediatek/patche=
s-6.6/999-2100-thermal-mediatek-add-mt7988-lvts-support.patch#110

regards Frank

> Regards,
> Angelo
>=20
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >   drivers/thermal/mediatek/lvts_thermal.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)



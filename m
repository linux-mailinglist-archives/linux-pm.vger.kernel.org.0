Return-Path: <linux-pm+bounces-32463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF96CB28B3F
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 09:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFBC3BF9B9
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4721FF49;
	Sat, 16 Aug 2025 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="B90Bbbv3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8E21B918;
	Sat, 16 Aug 2025 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327794; cv=none; b=fdqxyH8Fv13JzKCvP8IeFBKEQc1QGsixRVwlalzRRRgsZgToVAKom7CN4lqkZCKkMcJ3f2sesGfcGxHX9Ov6DEoa1g+XKWEzH+fX6//TKelmIG6VCfM03FujZbGwV129ph0AZoGjGbWE/hz/La8nOZIr6EEvX6ASJSRncwaExHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327794; c=relaxed/simple;
	bh=OnJuy7emtHk4hQBUmYOKm/D2zPW1BmNtYcmtvPGdvAY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DWoNrbRBQlNg5ebANu3tgwP7PlhUhjzkXvXEldwK+pXV1bX5CWwbXqF3pV4Jit3Fwmf9ajnQbnzcIMsZVJOc24eDqhN57/tbgCvhiJaoR46zMyJ9oPJAM9XYN4b/r7rjPc8TqDEU00R+hvE50oSyHLzJY0muJrGAL5oqqHYo5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=B90Bbbv3; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 87FCD10078F;
	Sat, 16 Aug 2025 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1755327352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOdNjKyebw/s0rYRUwH2anrLdBAU4WTiR9sWOyp0RzU=;
	b=B90Bbbv3kORkuslteF8M9lfemmr/Ar1i0t3y1qMPZ3aNWD5GMw4AF99Zmf/twP1Z2Xvzxh
	VHoMItSyNhLXYNk6eJP2k+iwn8QLsnvEmMzpau4i7qAkKW02XnkQBDIX7WsMeXFCbyVHbA
	JGT7zABH+1AdtypI/z6yjto4yaFzkLc=
Received: from [IPv6:::1] (unknown [IPv6:2a01:599:a34:a3b8:9076:e76e:6930:1412])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 156781002C7;
	Sat, 16 Aug 2025 06:55:51 +0000 (UTC)
Date: Sat, 16 Aug 2025 08:55:51 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: patchwork-bot+netdevbpf@kernel.org
CC: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com,
 djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, johnson.wang@mediatek.com,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, daniel@makrotopia.org, lorenzo@kernel.org,
 nbd@nbd.name, frank-w@public-files.de, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 00/13] further mt7988 devicetree work
User-Agent: K-9 Mail for Android
In-Reply-To: <175218542224.1682269.17523198222056896163.git-patchwork-notify@kernel.org>
References: <20250709111147.11843-1-linux@fw-web.de> <175218542224.1682269.17523198222056896163.git-patchwork-notify@kernel.org>
Message-ID: <8A21C091-0C26-4E9F-9B9E-E28A01F71369@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: d7d08745-eee0-42d0-ad9e-cba520e4f9d1

Am 11=2E Juli 2025 00:10:22 MESZ schrieb patchwork-bot+netdevbpf@kernel=2Eo=
rg:
>Hello:
>
>This series was applied to netdev/net-next=2Egit (main)
>by Jakub Kicinski <kuba@kernel=2Eorg>:
>
>On Wed,  9 Jul 2025 13:09:36 +0200 you wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> This series continues mt7988 devicetree work
>>=20
>> - Extend cpu frequency scaling with CCI
>> - GPIO leds
>> - Basic network-support (ethernet controller + builtin switch + SFP Cag=
es)
>>=20
>> [=2E=2E=2E]
>
>Here is the summary with links:
>  - [v9,01/13] dt-bindings: net: mediatek,net: update mac subnode pattern=
 for mt7988
>    https://git=2Ekernel=2Eorg/netdev/net-next/c/29712b437339
>  - [v9,02/13] dt-bindings: net: mediatek,net: allow up to 8 IRQs
>    https://git=2Ekernel=2Eorg/netdev/net-next/c/356dea0baf4c
>  - [v9,03/13] dt-bindings: net: mediatek,net: allow irq names
>    https://git=2Ekernel=2Eorg/netdev/net-next/c/23ac2a71bdbd
>  - [v9,04/13] dt-bindings: net: mediatek,net: add sram property
>    https://git=2Ekernel=2Eorg/netdev/net-next/c/c4582a31efd9
>  - [v9,05/13] dt-bindings: net: dsa: mediatek,mt7530: add dsa-port defin=
ition for mt7988
>    https://git=2Ekernel=2Eorg/netdev/net-next/c/588cb646ce70
>  - [v9,06/13] dt-bindings: net: dsa: mediatek,mt7530: add internal mdio =
bus
>    https://git=2Ekernel=2Eorg/netdev/net-next/c/66a44adf4c3d
>  - [v9,07/13] arm64: dts: mediatek: mt7986: add sram node
>    (no matching commit)
>  - [v9,08/13] arm64: dts: mediatek: mt7986: add interrupts for RSS and i=
nterrupt names
>    (no matching commit)
>  - [v9,09/13] arm64: dts: mediatek: mt7988: add basic ethernet-nodes
>    (no matching commit)
>  - [v9,10/13] arm64: dts: mediatek: mt7988: add switch node
>    (no matching commit)
>  - [v9,11/13] arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethe=
rnet
>    (no matching commit)
>  - [v9,12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and li=
nk to gmac
>    (no matching commit)
>  - [v9,13/13] arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phy=
s and leds
>    (no matching commit)
>
>You are awesome, thank you!

Hi

Any comments on the missing DTS parts or can they applied too?
regards Frank


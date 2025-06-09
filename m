Return-Path: <linux-pm+bounces-28299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA0AD1B96
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 12:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FA7188A703
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9B253F30;
	Mon,  9 Jun 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="MS/0fkoK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DE253949;
	Mon,  9 Jun 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749464964; cv=none; b=LV7/l7jLeVpJ9APGystqXRQRVXY1Lo0Vy/W77/CV/p+yqNV/EyvpakWmyntED1BhNY6Wgs/kv+CeDY7XGlGcQbZs6L/gDGuYbVoGS3RqpWYqyZ3mA0ZwsoORJqm3J+POHVhHEXZ2zhvoPJl3+X5b2REuS0oizjoj2IGXjItvIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749464964; c=relaxed/simple;
	bh=kLeynbC7Nsabe/zZnAE4wIR/2+EJVZRySOC+x218YFQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=DAiIUDuONzxJglc6/2kjp79DzX5hYJRjJTtp+I9lhk2LWaQS/HlVlhIrEcrzyH240KuLCFoKbCz9quF9T94HhW3jHsmjivQDQ+CLu+7xKXHKEu2EDhrP6T2P4Heph0JHg+1jGiutT2vdNzVwGQpaQ4DD7iK2YQff2Mir6oR+LA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=MS/0fkoK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1749464918; x=1750069718; i=frank-w@public-files.de;
	bh=UjVgFSIpV2X04ea9AxQMDu3aUAqHlJDuyDyhBp2KhX4=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MS/0fkoKpCyad+CC+J4GnkAyF87kEu/JFzIgg5K4U+jerrW54U+QOyOsaXPpvRKr
	 LyCb8s0xH6ff+z6Nv3DomqSz0T0hAC7TjTfw5CUUiFu67M3Hso8pxSIW4hYIXPu8y
	 T2T4AC2rsVc6vVEfmGHJqTKelmohQ0y+JHAcphkSJO4Y1lAUu8jB0rSAxkbHhLP2v
	 w2RgfeS+BdRzDattHZZf2Q/p9ef6LzvK05Xw37ITnzQzcUja9Q7ZCuKBc9f7XWt2A
	 SpOVrpq3MKhRx884LzjMZRtAXRVs+WdzYVtwSBmZKPc0EwT5OszD77DHgelzJ8m2n
	 RY7cEaodwo7EOS+9Rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.71.3.129] ([100.71.3.129]) by
 trinity-msg-rest-gmx-gmx-live-5d9b465786-mldbm (via HTTP); Mon, 9 Jun 2025
 10:28:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-87fadcdb-eee3-4e66-b62d-5cef65f1462d-1749464918307@trinity-msg-rest-gmx-gmx-live-5d9b465786-mldbm>
From: Frank Wunderlich <frank-w@public-files.de>
To: andrew@lunn.ch, linux@fw-web.de, daniel@makrotopia.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 cw00.choi@samsung.com, djakov@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, jia-wei.chang@mediatek.com,
 johnson.wang@mediatek.com, arinc.unal@arinc9.com, Landen.Chao@mediatek.com,
 dqfext@gmail.com, sean.wang@mediatek.com, lorenzo@kernel.org, nbd@nbd.name,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v3 06/13] arm64: dts: mediatek: mt7988: add basic
 ethernet-nodes
Content-Type: text/plain; charset=UTF-8
Date: Mon, 9 Jun 2025 10:28:38 +0000
In-Reply-To: <cc73b532-f31b-443e-8127-0e5667c3f9c3@lunn.ch>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-7-linux@fw-web.de>
 <cc73b532-f31b-443e-8127-0e5667c3f9c3@lunn.ch>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:5JwfFEh+N+ttjTh5vxuvvC5upKEDjso7yy21yl5pV/dtZv3anNKBvjY4rDfI6hKaUSOph
 u8cGAWJUMqq9DWNm8iKkqwO2Z5WJeQqxTWvWCSuzL4Xre7oAMDiEITW76an37MgkjRiA/VVTVBAn
 TCuY1ELiDsMHuFNrDzszDGVRqLzacVimbed2YZnRdNlsBYJjaqCXQLWiZPBfQq3r7GObmVg0ocIP
 A5WoGgxfMhiqvOzBnRLK+WX0OfUnkAXTuI00V5820/3i5E3zK5rBte6ZVcFLl2V5lBRpaDq949jq
 3zwHlZajQ3Yg+5V0ACqAG+LGF7OsDOtplghm9747djY/y9p/OJ653mxK7VE6jqn6OU=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nc+zqxOfX0U=;I8/8WjzQbL4heqzXq4h8MsUMufe
 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
Content-Transfer-Encoding: quoted-printable

Hi Andrew

> Gesendet: Sonntag, 8. Juni 2025 um 23:23
> Von: "Andrew Lunn" <andrew@lunn.ch>
> An: "Frank Wunderlich" <linux@fw-web.de>
> Betreff: Re: [PATCH v3 06/13] arm64: dts: mediatek: mt7988: add basic et=
hernet-nodes
>
> > +			gmac0: mac@0 {
> > +				compatible =3D "mediatek,eth-mac";
> > +				reg =3D <0>;
> > +				phy-mode =3D "internal";
> > +
> > +				fixed-link {
> > +					speed =3D <10000>;
> > +					full-duplex;
> > +					pause;
> > +				};
>=20
> Maybe i've asked this before? What is on the other end of this link?
> phy-mode internal and fixed link seems an odd combination. It might
> just need some comments, if this is internally connected to a switch.

yes you've asked in v1 and i responded :)

https://patchwork.kernel.org/project/linux-mediatek/patch/20250511141942.1=
0284-9-linux@fw-web.de/

connected to internal (mt7530) switch. Which kind of comment do you want h=
ere? Only "connected to internal switch"
or some more details?

> > +			mdio_bus: mdio-bus {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +
> > +				/* internal 2.5G PHY */
> > +				int_2p5g_phy: ethernet-phy@f {
> > +					reg =3D <15>;
>=20
> It is a bit odd mixing hex and decimal.

do you prefer hex or decimal for both? for r3mini i used decimal for both,=
 so i would change unit-address
to 15.

> > +					compatible =3D "ethernet-phy-ieee802.3-c45";
>=20
> I _think_ the coding standard say the compatible should be first.

i can move this up of course

> > +					phy-mode =3D "internal";
>=20
> A phy should not have a phy-mode.

not sure if this is needed for mt7988 internal 2.5g phy driver, but seems =
not when i look at the driver
(drivers/net/phy/mediatek/mtk-2p5ge.c). The switch phys also use this and =
also here i do not see any
access in the driver (drivers/net/dsa/mt7530-mmio.c + mt7530.c) on a quick=
 look.
Afaik binding required the property and should be read by phylink (to be n=
ot unknown, but looks like
handled the same way).

Maybe daniel can describe a bit deeper.

> 	Andrew

regards Frank



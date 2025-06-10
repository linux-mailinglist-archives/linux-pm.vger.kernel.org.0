Return-Path: <linux-pm+bounces-28346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A0AD3122
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 11:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5743B3633
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 09:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA628A3F2;
	Tue, 10 Jun 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="IJ5Ea6W7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCE1EE033;
	Tue, 10 Jun 2025 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546260; cv=none; b=uEhG3TEvMadqABGnZQAOTIyt5aHaWk9obEgp0LGuxzjoMOVKQkx8bKG7KIo7mO4JJouiv/GG3c7JQSIhdtjublgtqHmym3Dnh0dX6NNsB3iZ0t6i5e3SDrx+FKCtl+Qe1AjepG5M8XTOQzMvNz511BK9UDZVwoNxzgq4Qi4R0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546260; c=relaxed/simple;
	bh=c7eXqn3OR8hXh/I05OT0JGgKzgXMbXPO7tWOiXvXpQo=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=cnkL+pe9fzF833e3VyR5DzBmj7PX/z9buD4rt1T1Z+ITtgHeSxMFtYotQ5U3xTVzDpX4Ng3KRA+X4hbz5LhIz3AVkOYeEtJP8FrQru3H1Ql369oPfl69uM2PO7Hm9i3bZGV8y4lIgP0PfrdwumAjfcDxc93hUQy4MMv/TbOPw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=IJ5Ea6W7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1749546239; x=1750151039; i=frank-w@public-files.de;
	bh=x9isndutnG7FzSCz38wRWR3/GK7vlaPRNBGI74YSN5E=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IJ5Ea6W7y6sTzEDB05dbUDocNZCqcni0Hii/uaCZIuM0Zg/7l8U89wwEXWC0u7PI
	 fYgLeMT7BIOvyx1mbGJVu/s033MIr4CbHo+0uRS8hAsXSFrNEXiblFuJBONebx1i/
	 kCqAI2G0WQCKQtIfRH6QtbdeRTaMLSRjJM6ss5Ihb/PIQelp+XlC5V9TuSbifXu40
	 2CGrvxqkxKmgI2MvYE10hzuN3ucSkVkCjwZC6Xal71MdGyY3+CwYaCLf9YLqdOa7M
	 tSXyPJ1LdBjiVd3iRL6o9wBZtLlYtTM3nOAp9mdaiQ4DjFv+TenKPtDN9pnG7AbJD
	 PK7vX4n1uYJPspO/fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.70.254.165] ([100.70.254.165]) by
 trinity-msg-rest-gmx-gmx-live-5d9b465786-6phds (via HTTP); Tue, 10 Jun 2025
 09:03:59 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-b9ab960d-38f8-4524-b645-fc0832ce72ec-1749546239525@trinity-msg-rest-gmx-gmx-live-5d9b465786-6phds>
From: Frank Wunderlich <frank-w@public-files.de>
To: andrew@lunn.ch, linux@fw-web.de
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 cw00.choi@samsung.com, djakov@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, jia-wei.chang@mediatek.com,
 johnson.wang@mediatek.com, arinc.unal@arinc9.com, Landen.Chao@mediatek.com,
 dqfext@gmail.com, sean.wang@mediatek.com, daniel@makrotopia.org,
 lorenzo@kernel.org, nbd@nbd.name, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v3 12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add
 sfp cages and link to gmac
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 09:03:59 +0000
In-Reply-To: <934b1515-2da1-4479-848e-cd2475ebe98d@lunn.ch>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-13-linux@fw-web.de>
 <934b1515-2da1-4479-848e-cd2475ebe98d@lunn.ch>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:P+w5LatxuczWjuU5VjC2cu3RusygmzTEcHnWEMF+vMd+V144Nuq0nbegfrwU1/70t+IO5
 ZZCfjP1mt0nBNkGjj7f83sEa1HX3LswwVcLmtn0EkewzcBQy+5sk93/FE8OFJGz2cjArfnRlYVfB
 3XMrQQsXoPxZtNXsZP8bmZLVhtzLablHfLA6+NXenDy0XEURhrtBRk+vVZ+h17JVyrBl/eHW2FY2
 uaWJKp0HW8d7z76dXGwZ1/AAP+8bL2oTm6hnK6iomw2WSiz0PVS0NPZKi4ROB6MkXRYd1FGSV6CI
 oFPPiTF5PBKHUC5CAEdu/94Ju1rZzvA0FeA3Gu9s0Qj3j8HbE5+i4yztEMvFIiZFnY=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TLvXeFIDP6E=;qZFVm6ncGdxJPw6owUfJx41Igss
 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
 AmzvamVKyQ==
Content-Transfer-Encoding: quoted-printable

Hi Andrew

> Gesendet: Sonntag, 8. Juni 2025 um 23:31
> Von: "Andrew Lunn" <andrew@lunn.ch>
> Betreff: Re: [PATCH v3 12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add =
sfp cages and link to gmac
>
> > +&gmac1 {
> > +	phy-mode =3D "internal";
> > +	phy-connection-type =3D "internal";
>=20
> ethernet-controller.yaml says:
>=20
>   phy-connection-type:
>     description:
>       Specifies interface type between the Ethernet device and a physica=
l
>       layer (PHY) device.
>     enum:
>       # There is not a standard bus between the MAC and the PHY,
>       # something proprietary is being used to embed the PHY in the
>       # MAC.
>       - internal
>       - mii
>       - gmii
>   ...
>=20
>   phy-mode:
>     $ref: "#/properties/phy-connection-type"
>=20
>=20
> so phy-mode and phy-connection-type are the same thing.

phy-connection-type seems not needed, tested without it and 2.5G phy works=
 without this property in the 2g5 dts.

> > +	/* SFP2 cage (LAN) */
> > +	sfp2: sfp2 {
> > +		compatible =3D "sff,sfp";
> > +		i2c-bus =3D <&i2c_sfp2>;
> > +		los-gpios =3D <&pio 2 GPIO_ACTIVE_HIGH>;
> > +		mod-def0-gpios =3D <&pio 83 GPIO_ACTIVE_LOW>;
> > +		tx-disable-gpios =3D <&pio 0 GPIO_ACTIVE_HIGH>;
> > +		tx-fault-gpios =3D <&pio 1 GPIO_ACTIVE_HIGH>;
> > +		rate-select0-gpios =3D <&pio 3 GPIO_ACTIVE_LOW>;
> > +		maximum-power-milliwatt =3D <3000>;
>=20
> sff,sfp.yaml says:
>=20
>   maximum-power-milliwatt:
>     minimum: 1000
>     default: 1000
>     description:
>       Maximum module power consumption Specifies the maximum power consu=
mption
>       allowable by a module in the slot, in milli-Watts. Presently, modu=
les can
>       be up to 1W, 1.5W or 2W.
>=20
> I've no idea what will happen when the SFP core sees 3000. Is the
> comment out of date?

at least sfp-core has no issue with the setting

root@bpi-r4-phy-8G:~# dmesg | grep sfp
[    1.269437] sfp sfp1: Host maximum power 3.0W
[    1.613749] sfp sfp1: module CISCO-FINISAR    FTLX8571D3BCL-C2 rev A   =
 sn S2209167650      dc 220916 =20

imho some modules require more than 2W (some gpon/xpon and 10G copper ethe=
rnet).

> 	Andrew
>=20

regards Frank


Return-Path: <linux-pm+bounces-30236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3983FAFA888
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE1C18984B7
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B5D20297C;
	Sun,  6 Jul 2025 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="eGcSIRgb"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBA19005E;
	Sun,  6 Jul 2025 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751846361; cv=pass; b=W0KBUiCKb1dGikyvv3BECZiWURawv4UVUETGRqhNnn4Cc9ljd4N/uIjWpf83pPQDEqsO88jjrN3ubWBXylZvLRUejRQztsMLU0k9aBtGn+x/DhvS0UdDth0dI9QydlOQ+A3rTIATj1dseTIZIRzyl66TXNMmNmwLYpfJNhxshJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751846361; c=relaxed/simple;
	bh=K2TLkI7gP4juXCxzoZJJXd81gycFQI6C2x4UpGsuZko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRtC5P0vzBG1zoxunDdIobYEhQhURZpMiQC5poAHSR6SD68ertkNfmXQRoR/dyFA5/DiRXSL03dwyqGremlzio3CuSD4DB0md76iyT0TOkQ/zXDSYublvINBBAvx8+GfdhkSZcmN9JJO8HaZnWp4BYYTrnyOT7glyrolmkQi2CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=eGcSIRgb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751846345; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iZvaqcHYYkkWJOoppH7Mhh0AovxMxPTU70vRdmiv/dQafEq274MLjqun5UBcpTzCRneUyu66xuRxr/rOaJX/rDzMogwERiCONXa79OI/tBQzC58nZgq0HH3gP79q36EdPBUK/RBoluzN64emgfQFGrQRIb8nvZsDQaUIvL363rw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751846345; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4YASFBwX97G7t8uWuk6GOjhJx3b5rCBSNe6Sfs+DpWs=; 
	b=YyRzIjBCrybNrlXnavLDi+yAIEtDDCKY6qpJaw8SSSs67rnLke56mxO+m5JJB0DCQQv6p+nHE+TzqHm/7axxhfk5rMbgufzkBk9ENGpKQwKxu7Udh5UBstP6U6t4xuQJVSDwqGnrWyqUsC4Eoz/e3cynwwd6/kQ2pH7P4GgcZfU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751846345;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=4YASFBwX97G7t8uWuk6GOjhJx3b5rCBSNe6Sfs+DpWs=;
	b=eGcSIRgbzjQxAg+nwQqZFkt6qAYLEFDkSR4V03bo+1gNTbdYv0KMyapLYS9DIJfv
	wTaZwy9uSa4PJPPZhYB0MGYR+exSSuS0dyYAk6DVP/Yjdd2IS4m9h8CSNTAS2ZV0i4l
	coco5iR2apAUJgsLtsdAzNNr524wIM934CGhwa84=
Received: by mx.zohomail.com with SMTPS id 1751846342840223.73657093435042;
	Sun, 6 Jul 2025 16:59:02 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 8B6FF180F14; Mon, 07 Jul 2025 01:58:57 +0200 (CEST)
Date: Mon, 7 Jul 2025 01:58:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas Antoine <t.antoine@uclouvain.be>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
Message-ID: <5n5nkgbviv2dyuqiji3n5ehp5bo5d4azqrlbcz45m2wpmnl525@4vgwghcaytc6>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
 <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
 <4cahu6dog7ly4ww6xyjmjigjfxs4m55mrnym2bjmzskscfvk34@guazy6wxbzfh>
 <793c02e4-fa7a-4c13-bfc3-bb058e211b5f@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nclyy4wjoce7arde"
Content-Disposition: inline
In-Reply-To: <793c02e4-fa7a-4c13-bfc3-bb058e211b5f@uclouvain.be>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/251.827.75
X-ZohoMailClient: External


--nclyy4wjoce7arde
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
MIME-Version: 1.0

Hi,

On Wed, Jun 25, 2025 at 02:12:21PM +0200, Thomas Antoine wrote:
> > On Fri, May 23, 2025 at 02:51:45PM +0200, Thomas Antoine via B4 Relay w=
rote:
> >> From: Thomas Antoine <t.antoine@uclouvain.be>
> >>
> >> The interface of the Maxim MAX77759 fuel gauge has a lot of common wit=
h the
> >> Maxim MAX1720x. A major difference is the lack of non-volatile memory
> >> slave address. No slave is available at address 0xb of the i2c bus, wh=
ich
> >> is coherent with the following driver from google: line 5836 disables
> >> non-volatile memory for m5 gauge.
> >>
> >> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a6=
8c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
> >>
> >> Other differences include the lack of V_BATT register to read the batt=
ery
> >> level. The voltage must instead be read from V_CELL, the lowest voltag=
e of
> >> all cells. The mask to identify the chip is different. The computation=
 of
> >> the charge must also be changed to take into account TASKPERIOD, which
> >> can add a factor 2 to the result.
> >>
> >> Add support for the MAX77759 by taking into account all of those
> >> differences based on chip type.
> >>
> >> Do not advertise temp probes using the non-volatile memory as those are
> >> not available.
> >>
> >> The regmap was proposed by Andr=E9 Draszik in
> >>
> >> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455=
a116.camel@linaro.org/
> >>
> >> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> >> ---
> >>  drivers/power/supply/max1720x_battery.c | 265 +++++++++++++++++++++++=
+++++----
> >>  1 file changed, 238 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/s=
upply/max1720x_battery.c
> >> index 68b5314ecf3a234f906ec8fe400e586855b69cd9..c9ad452ada9d0a2a51f37d=
04fd8c3260be522405 100644
> >> --- a/drivers/power/supply/max1720x_battery.c
> >> +++ b/drivers/power/supply/max1720x_battery.c
> >> @@ -37,6 +37,7 @@
> >>  #define MAX172XX_REPCAP			0x05	/* Average capacity */
> >>  #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
> >>  #define MAX172XX_TEMP			0x08	/* Temperature */
> >> +#define MAX172XX_VCELL			0x09	/* Lowest cell voltage */
> > [...]
> >>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > [...]
> >> +			ret =3D regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
> >> +			val->intval =3D max172xx_cell_voltage_to_ps(reg_val);
> >=20
> > I haven't reviewed this fully due to all the feedback you already
> > got from Peter Griffin and the DT binding being broken, but something
> > that catched my eye:
> >=20
> > POWER_SUPPLY_PROP_VOLTAGE_NOW provides the voltage of the whole
> > battery and not of a single cell. E.g. a typical Li-Ion battery
> > with two serial cells has a nominal voltage of roughly 7.4V while
> > each cell has just 3.7V.
> >=20
> > Greetings,
> >=20
> > -- Sebastian
>=20
> Downstream just reports this value which is usually a bit over 4V when I
> record it.
>=20
> Also from what I saw online, it seems that the battery does output
> voltages around 3.86V as it is written on the battery:
> https://cdn.shopify.com/s/files/1/0092/8133/9443/files/QeqxTLOL6eAp6OpZ.j=
pg?v=3D1728588266&width=3D2048
>=20
> So I guess that there could only be a single cell in the battery? Which
> would explain why they only report the lowest one.
>=20
> It thus should be ok if we consider only the Google Pixel 6 (Pro). If we
> need to take into account the possibility that the chip would be
> used with other batteries, we could take from the devicetree the number
> of cells and only provide the voltage if the number of cells is 1. Would
> this be a good solution?

That's fine with me. But getting the DT binding prepared will take
some time (the DT property should definetly go via
Documentation/devicetree/bindings/power/supply/battery.yaml), we
had some prior discussions around this IIRC. It might be sensible
to move adding VOLTAGE_NOW support to an extra series.

> There is also a VSYS register (0xb1) but I couldn't find anything
> about it. Taking a LSB of 156uV (twice the one of VCell), I see a
> clear correlation with VCell, except for it being very slightly
> lower. As it is mostly guesswork, I don't think it would be a good
> idea to use this without any confirmation it is correct.

I see the datasheet does not have the register listed for < 0x10.
Have you tried contacting the original Google driver author to shed
some light to this?

Greetings,

-- Sebastian

--nclyy4wjoce7arde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhrDb0ACgkQ2O7X88g7
+poIhRAAi6S6FcK4GYRPjYWN/URGf5qBd1DRGWJF9nlVoYfXUWFJiuXTvnPjPMQ3
y6b9zWXHRaIn5fa0pDcyKrO6oAz7EBsflk0aijPqnbPGxlIBthmk1QaynzQ/8Ldr
WFTkKE3sorCC/Ki43Q2+QFzBMDgknGfeQNVhOfIHrDmNpnXg9TR2V+jnYZzyP2Xj
Iz/vYtIpqSMOWMdfkGxi25nhMOjn6t99GRjhT5ajhqVfv5qNuR8Eihqz8Czttr0/
jFTz8Ct01b6f7N+9HoPpWS2TLqiH3atq1+Z69EAdAssTaT7SFd7ZqYGSIs9KY+bZ
aBLr4avVNNDe7qrrxFh8jjEwEy4qYyq64ZM9uSuMG7WKF8ronqPiTKn4mU6Ec8t/
OZzLBVgwUQG5DXL1USMu37sfmo/kfqS0XTUu+XK/UGfPkj3kwKdXMjo+6yyZ3mNF
bOeLTWfv/fIpJ4AJivZSbbTRbhqjD1xW9Z6dbMqJ+x88Xern9lB8JdVzkActXzt3
gdk9tQ/U7YH+kn+oVWuJ8lNkrujSO0t6rvCVGmealRDdLUoFuzl8UaGoYJ4i1Clo
CaK0gQ51wv430u3SB+O2MTF2Q+LWvuYa6ao12KhE5FTPxBZ4WicvV73yXAhgJgnd
o2JD8WjWl4LRIRzVUef9O5AxKRZxkbnAUNgJ2yQ5VD9PzkLP0hs=
=Lwm3
-----END PGP SIGNATURE-----

--nclyy4wjoce7arde--


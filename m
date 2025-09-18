Return-Path: <linux-pm+bounces-35008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7919AB873CF
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 00:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDE73B2F45
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD622D1308;
	Thu, 18 Sep 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="G3fT7X0q"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229C8BEE;
	Thu, 18 Sep 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234760; cv=pass; b=DDn/n87uQYWWGZHFrRhJebjV5rpDM8uj00Y3aRgTL+Df6ApNGcEN05KqaPEPqycFl1ZZAKAGuem62pBC5u7hTggnJ3j9+9XUNPEZRuRzxb4Kh8XBeXERdq4t0hhNIof8XDM92AyICQObJVTdmyt+ilfIjkkX14RyahwnfP6y2C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234760; c=relaxed/simple;
	bh=LKfd7YhgqVodO+ohQnk7rPcRh/t7chZtCCpRejy960A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzriTKaqAGoos4DCXfoFLxK2pNUYAyRmTrebc1/k+Yk2Qi4PPMXqFbG68xICqquLP1ajHc/sI1FC9qRlXz+35kV6xIYamTEOAZCAZSpt/lQhePcqcLbhwn5BZmWZKBk0p6WBhe8+wf7++o/OIfguDiSwxRIEUkgXXh+ydQXyg9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=G3fT7X0q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758234752; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jOMTxLBaV/5FveAwFspfWOOfSMg+weuKkPzL+a51cYqaltJyNvaLDsJcGxriWK3+hVdpoYrpI5rR06YUtHoY9bsHL20q7l+/wG0kuuL1WDTH5rtyDGm9lawp6gXUN2IyF7/SFTOAP8D2dmFK8qmQRuc8nXdGtPujYn/maTT0/RE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758234752; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mDwItCB03abiRLXZLyNzwDEO1gPTRSnyb/2++XuyMts=; 
	b=d6loXg6iYRsZNBM9ICnnqk8/qTdMGs++mYo66E3AZsoGYrEuUjTrahb9idqoxHnI68boNDW3rTjfQqRxD6wi+8fbHhStV0wSCgZAoZtqBWM//6yKYIKrzay+JKXd6fSoq8Bg34+BmcV+acz1oM3mF+ouaYJn9SgbXqJwBPukee0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758234752;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=mDwItCB03abiRLXZLyNzwDEO1gPTRSnyb/2++XuyMts=;
	b=G3fT7X0qqAwWeTr9zOezSwLPeh4CMr5I0IdoD05TF7JioykPPuOlPQmuWaVmsHNU
	bZDgojnRXvwIpUz9umuBTKjSIf5WR95vXeKeUIA6FwjrSdRWcvHZDtRG2vuvazA+lQf
	RAeIImgVzkOCJLy20BKiyBpEs3WC+ZOp31KB4hBQ=
Received: by mx.zohomail.com with SMTPS id 1758234750741977.6413015849289;
	Thu, 18 Sep 2025 15:32:30 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 1186A180517; Fri, 19 Sep 2025 00:32:18 +0200 (CEST)
Date: Fri, 19 Sep 2025 00:32:18 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Thomas Antoine <t.antoine@uclouvain.be>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
Message-ID: <65xrumpt7ug5mqd7mkcknwyqmljrn4sofrqymg46bwvcmjoarr@wmt5fhsj3viz>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
 <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
 <20250915-presoak-answering-2df6fca532ad@spud>
 <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
 <a55d7e6e6d9515293ca735f25ffd5c925a6ec617.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uby4qznfm6t46loa"
Content-Disposition: inline
In-Reply-To: <a55d7e6e6d9515293ca735f25ffd5c925a6ec617.camel@linaro.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.211.62
X-ZohoMailClient: External


--uby4qznfm6t46loa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
MIME-Version: 1.0

Hi,

On Thu, Sep 18, 2025 at 02:02:55PM +0100, Andr=E9 Draszik wrote:
> > On 9/15/25 7:31 PM, Conor Dooley wrote:
> > > On Mon, Sep 15, 2025 at 12:14:11PM +0200, Thomas Antoine via B4 Relay=
 wrote:
> > > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > > >=20
> > > > The Maxim MAX77759 is a companion PMIC for USB Type-C. It contains
> > > > Battery Charger, Fuel Gauge, temperature sensors, USB Type-C Port
> > > > Controller (TCPC), NVMEM, and additional GPIO interfaces
> > > >=20
> > > > Use max77759-fg compatible to avoid conflict with drivers for other
> > > > functions.
> > > >=20
> > > > The battery node is used to pass the REPCAP and ICHGTERM values
> > > > needed for the initialization of the fuel gauge.
> > > >=20
> > > > The nvmem cells are used to get initialization values and to backup
> > > > the learning and the number of cycles. It should work out of the box
> > > > with gs101-oriole and gs101-raven which were previously running
> > > > Android.
> > > >=20
> > > > Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> > > > ---
> > > > =A0.../bindings/power/supply/maxim,max77759.yaml=A0=A0=A0=A0=A0 | 7=
8 ++++++++++++++++++++++
> > > > =A01 file changed, 78 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,m=
ax77759.yaml
> > > > b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..4d45739fcaf26273ec5=
7b60049d6d0421df38efb
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759=
=2Eyaml
> > > > @@ -0,0 +1,78 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/power/supply/maxim,max77759.yam=
l#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Maxim Integrated MAX77759 fuel gauge
> > > > +
> > > > +maintainers:
> > > > +=A0 - Thomas Antoine <t.antoine@uclouvain.be>
> > > > +
> > > > +allOf:
> > > > +=A0 - $ref: power-supply.yaml#
> > > > +
> > > > +properties:
> > > > +=A0 compatible:
> > > > +=A0=A0=A0 const: maxim,max77759-fg
> > >=20
> > > Compatible doesn't match the filename, why?
> > > I assume the "fg" is fuel-gauge, but can this device be anything else?
> >=20
> > The max77759 is a multifunction chip.
> > The following compatibles are already used for some of those functions:
> > - maxim,max77759 (for the pmic)
> > - maxim,max77759-gpio
> > - maxim,max77759-nvmem
> > - maxim,max77759-tcpci
> >=20
> > The fuel gauge functionality that is added with this patch is very simi=
lar
> > to the functionality of the max1720x which is why the filename was chos=
en
> > to fit other maxim fuel gauge chips pattern.
> >=20
> > Maybe it would be better to use the maxim,max77759-battery compatible to
> > match the filename? It would also fit with the already existing
> > maxim,max77705-battery and maxim,max77849-battery compatibles.
>=20
> It also has a (battery) charger, a -battery compatible could be misleadin=
g.
> The datasheet refers to these subblocks as FG (for fuelgauge) and CHARGER.
> I'd suggest keeping those terms.
>=20
> Additionally, the FG block can also measure temperature and battery ID. F=
or
> those, a combination of (top-level) PMIC and FG registers are needed
> unfortunately. Which means that the FG should probably be an MFD child
> device, even though the FG itself doesn't depend on the top-level. Otherw=
ise
> it'd be hard to access the top-level PMIC register.

My understanding is, that the FG has a dedicated I2C device address
and thus cannot be a simple MFD child of the PMIC. Did I misunderstood
that part?

Assuming I understood things correctly, I think I suggest to model
things like this for the battery temperature/ID:

i2c {
    pmic: pmic@42 {
        compatible =3D "maxim,max77759";
        ...

        pmic_adc: adc {
            compatible =3D "maxim,max77759-adc";
            ...
        };
    };

    fuel-gauge@43 {
        compatible =3D "maxim,max77759-fg";
        ...
        io-channels =3D <&pmic_adc MAX77759_ADC_BAT_TEMP>, <&pmic_adc MAX77=
759_ADC_BAT_ID>;
        io-channel-names =3D "temperature", "ID";
    };
};

Greetings,

-- Sebastian

--uby4qznfm6t46loa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjMiGcACgkQ2O7X88g7
+prggxAAgXz3uekzgfRqZwrErlIsVJbozFo1uNIETUzLbK2Ad+oLrGZBMHGbeAdF
VFS01udeF7SjmEap8qQ7DqjJ64iaP6KxkqnblPIgHPH7FV8kgS7CzdSTrgQofSFg
+TbCovtw9xDJKZ9QY5DUmckMhCGkklpj8NDsr6EMn9JgPkhd7zqdxOt24KDMgCJ7
DlGnIaU4ickaFQ/fpSkhoUaf7eRi1svFE2BTfUX3Qygrp0JR67J2UJR5iLSDRi39
EO+LKwr1vRQjcSbnGZ2ubHf6f9AjAG7N7CKty1IQejuz0Mn9vQ7MVHwJueLOGgh1
kgVIlTZvddNhPJVUxMjrgit0EAVt2j24YNgFTRd18DxpZyP5I9WHk8JPpEcoT8EW
eKis2G7A47KadR2wXDJwSQUjDWN8ED5pjSfu8wRQ/+B3oRUiG14gqTIhPoU4WlD7
5nU+l69jmqakkg+XxFcbkl4nHgy53v5/O0mupikPnofX4m24AXPcdPy8MxMM8HcD
ChiKkOZDnOEd9XFVF0zTXCnXke4VsaUU2B993x279joRTzyC6llvcTlJSmjnjr61
6ExxVSxk2SV7dgY+cY7cucEf3yEcX6u6e9ZUmOSW8HM2CMOUwG29UTMBMsI6KTdg
EN/KQQSmvzYrI2NdLEpHkD3Cpcb04/JoicfMKLuf3i2O74LVc0M=
=xT0I
-----END PGP SIGNATURE-----

--uby4qznfm6t46loa--


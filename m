Return-Path: <linux-pm+bounces-14330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB17979E87
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D73D1C22A27
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 09:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866C13DDD3;
	Mon, 16 Sep 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PwpeKzY9"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9638DC7;
	Mon, 16 Sep 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479253; cv=pass; b=QOCoBIumakcq8ZH2KB6P1o2F+6aRJS3D065VxXQSj7iztvD9jhvZfgicajbvfvuWxrFoaVl62w7xJIZq4rrAF0OeCjy/DbU5OMLy6dht4Fp4OSOQNZCNX/4SoFTHH4xU5F20fch6Sz5TgukACbTRMeYAFdloRxemHsNA0r442Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479253; c=relaxed/simple;
	bh=/C5DVyaFYRs4m0iLIjEkmA94KWruIAMcJAhQB1xsBa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rilKvjjvMjJjJZBrJLZJWbd5ThUm81JtmEJ7wbE3VR+7A95LeuRCaY3mhvoT3oIGI6faXLC6+38J/5ngMz7fI/3lkJa2oKxtPcVhkmN6T6zt9n//ddTP6JxsjEY5VmMUsgjp/720Z66pViBsiyOTcwSNwfCn/Kwk2BaJnxgi458=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PwpeKzY9; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726479236; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P2/xxq+X+GnsvnttO03rGUqfqw0BwDPuuSvniMGRHTrv+HT93mY5TuzDLnJ8KHBE/f5Q/VMmx/dRxMT0sSJxtFFm0SzlR5I4/YXaoyh8j/3V38J8jxHE7b/q8vonocqqzSl6ZcZVHcjChG99gOBosNxt2ZsFEpW679A4RYlHYtI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726479236; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UEUWLpPPDTmSa024FOqQ+FIB9efbDQtQGIkrO739UrU=; 
	b=gJ5l+KxMIHFzefmZb3g1TfaAnGTGCedkKL+ItWkJGvrHWJh1pT5Owqbpwtb/GHJEqvxbJTCk4yuzlrmDJ5UQY+AIcpJS1frvgBTDXSGC7UyEz49ABEp4Dc1ILceX1Rbs6NpQmbGVOTwwbbjQ3AgB6KOtxOwbhsFdPalmeo9q2qM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726479236;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=UEUWLpPPDTmSa024FOqQ+FIB9efbDQtQGIkrO739UrU=;
	b=PwpeKzY9UvZnk1MOmRHTQ275nY0kj6vAgt6WpEWKUVsw0b77ok7b0k5v5F7i6SCn
	DjHd3/2Eq1ZDZR6tMzfRGSlhvX3hKqO6Et8wWD9oFqejg4f+Xy22MkoSI1GEP5gBXpb
	khb7mmxQbuMR94+GfpAQuJEg5NxpJCbD14A4HXa4=
Received: by mx.zohomail.com with SMTPS id 1726479234546209.23693508685574;
	Mon, 16 Sep 2024 02:33:54 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id B4AA0106045D; Mon, 16 Sep 2024 11:33:48 +0200 (CEST)
Date: Mon, 16 Sep 2024 11:33:48 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, broonie@kernel.org, 
	lgirdwood@gmail.com, heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, 
	lee@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Message-ID: <6rtwirzocmvs37hm4texyznhxj6d5b5du6rgkjamjg5mehl4si@qjujbypd7msi>
References: <20240829213102.448047-1-macroalpha82@gmail.com>
 <20240829213102.448047-2-macroalpha82@gmail.com>
 <20240830163042.GA319200-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qfdbozivw76gkyne"
Content-Disposition: inline
In-Reply-To: <20240830163042.GA319200-robh@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--qfdbozivw76gkyne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 30, 2024 at 11:30:42AM GMT, Rob Herring wrote:
> On Thu, Aug 29, 2024 at 04:30:58PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> >=20
> > Document the Texas instruments BQ25703 series of charger managers/
> > buck/boost regulators.
> >=20
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 143 ++++++++++++++++++
> >  1 file changed, 143 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.y=
aml
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/D=
ocumentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > new file mode 100644
> > index 000000000000..e555aa60f9ad
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > @@ -0,0 +1,143 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: BQ25703 Charger Manager/Buck/Boost Converter
>=20
> BQ25703A?
>=20
> > +
> > +maintainers:
> > +  - Chris Morgan <macromorgan@hotmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,bq25703a
> > +
> > +  reg:
> > +    const: 0x6b
> > +    description: I2C slave address
>=20
> Drop description.
>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-supplies:
> > +    description:
> > +      phandle of the power supply that provides input power
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>=20
> Already has a type. You need a reference to power-supply.yaml at the=20
> top level and 'maxItems: 1' here.
>=20
> > +
> > +  ti,charge-current:
> > +    description:
> > +      maximum current to apply to charging the battery
> > +    minimum: 0
> > +    maximum: 8128000
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>=20
> I guess this is copied from other TI parts, but really this should move=
=20
> to a property with a unit suffix. Or these shared properties moved to a=
=20
> shared schema so we aren't redefining the type multiple times.
>=20
> Same for the others here.

This is effectively information about the battery cells. The driver
should use the simple battery infrastructure and reference it via
monitored-battery. See also:

Documentation/devicetree/bindings/power/supply/battery.yaml

> > +  ti,current-limit:
> > +    description:
> > +      maximum total input current allowed
> > +    minimum: 50000
> > +    maximum: 6400000
> > +    default: 3250000
> > +    $ref: /schemas/types.yaml#/definitions/uint32

Use "input-current-limit-microamp" as property name.

> > +  ti,max-charge-voltage:
> > +    description:
> > +      maximum voltage to apply to charging the battery
> > +    minimum: 1024000
> > +    maximum: 19200000
> > +    $ref: /schemas/types.yaml#/definitions/uint32

That also belong into the simple-battery node.

> > +  ti,minimum-sys-voltage:
> > +    description:
> > +      minimum system voltage while on battery power, with default value
> > +      depending based on cell configuration
> > +    minimum: 1024000
> > +    maximum: 16128000
> > +    default:
> > +      enum: [3584000, 6144000, 9216000, 16128000]
> > +    $ref: /schemas/types.yaml#/definitions/uint32

Property should have -uvolt suffix.

Greetings,

-- Sebastian

> > +  regulators:
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      Boost converter regulator output of bq257xx
>=20
> Doesn't this apply to "usb-otg-vbus"?
>=20
> Really, only one regulator, so you don't need a container node.
>=20
> > +
> > +    properties:
> > +      "usb-otg-vbus":
>=20
> Don't need quotes.
>=20
> > +        type: object
> > +        $ref: /schemas/regulator/regulator.yaml
> > +
> > +        properties:
> > +          regulator-name: true
> > +          regulator-min-microamp:
> > +            minimum: 0
> > +            maximum: 6350000
> > +          regulator-max-microamp:
> > +            minimum: 0
> > +            maximum: 6350000
> > +          regulator-min-microvolt:
> > +            minimum: 4480000
> > +            maximum: 20800000
> > +          regulator-max-microvolt:
> > +            minimum: 4480000
> > +            maximum: 20800000
> > +          enable-gpios:
> > +            description:
> > +              The BQ25703 may require both a register write and a GPIO
> > +              toggle to enable the boost regulator.
> > +
> > +        additionalProperties: true
>=20
> Nope.
>=20
> > +
> > +        required:
> > +          - regulator-name
> > +          - regulator-min-microamp
> > +          - regulator-max-microamp
> > +          - regulator-min-microvolt
> > +          - regulator-max-microvolt
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - power-supplies
> > +  - ti,charge-current
> > +  - ti,current-limit
> > +  - ti,max-charge-voltage
> > +  - ti,minimum-sys-voltage
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/pinctrl/rockchip.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        bq25703: bq25703@6b {
>=20
> charger@6b
>=20
> > +            compatible =3D "ti,bq25703a";
> > +            reg =3D <0x6b>;
> > +            interrupt-parent =3D <&gpio0>;
> > +            interrupts =3D <RK_PD5 IRQ_TYPE_LEVEL_LOW>;
> > +            power-supplies =3D <&fusb302>;
> > +            ti,charge-current =3D <2500000>;
> > +            ti,current-limit =3D <5000000>;
> > +            ti,max-charge-voltage =3D <8750000>;
> > +            ti,minimum-sys-voltage =3D <7400000>;
> > +
> > +            regulators {
> > +                usb_otg_vbus: usb-otg-vbus {
> > +                    enable-gpios =3D <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
> > +                    regulator-max-microamp =3D <960000>;
> > +                    regulator-max-microvolt =3D <5088000>;
> > +                    regulator-min-microamp =3D <512000>;
> > +                    regulator-min-microvolt =3D <4992000>;
> > +                    regulator-name =3D "usb_otg_vbus";
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > --=20
> > 2.34.1
> >=20

--qfdbozivw76gkyne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbn+3AACgkQ2O7X88g7
+pqptw//Z7e5FioRcpTYmsngah9sVVa1ZL2ddErqwXO9eDJFoHAbYQyciLEehAdT
l1L3SgSN55jWzQ3Y2vqqXTBAl/HQwxauu/t920NIOWuJ4hPkO8vNvUskYoOsMWZU
4cGZvuziNECLWxyZD+hUys10P/Ckl9d4lIzbfkTs5x7BRu5fSNSsY0EyubHD180H
aAmBolZspB9AcH5+tnaHMUuiyhBCyfWsE5Gns3uJL5eUbc2zEPn+CXM0IUQ1ByQ1
s3oYX54FWDLq6FjADOu8knvAdewUzI36L/5lkEwWRnPkbMbgtuF+28i8GO0X3r7n
XwleQ8Gt5m0Kht/kQlcYQ/Jlh1GEd6OAHxgjK0PhYQZbYedNddzxRrntbkELWzn/
qCunIcECq4Y846SCZXL9WIzo+lFQYvlxfb4ccbkAYxGXMwy32ZV4qh1FivgxYrZX
8XGypZJwHx9/UGcZamydjxdKKSK4/UH1fRWCZ7HX7TBe7wpn+7OaDVbtcX/HSaUg
eWGebPy1wAMqPVyluMqYTtOciT0W3MOKNW5z7h/MPoWHWHSFJpZjteVycAAuKyC+
yQkxJ+cJOthrZkcKCHMztWfbThrdgM47HSTeKH/7ZGkPRqNATK9MX7HW0cj+gNEe
dGDZhKBIq47g3NeVqoooz7DaC1C5H68ggLZ41YZgLMmsq490Imw=
=SJRo
-----END PGP SIGNATURE-----

--qfdbozivw76gkyne--


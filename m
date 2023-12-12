Return-Path: <linux-pm+bounces-991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285780F3A9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 17:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A722BB20E1B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164727B3A4;
	Tue, 12 Dec 2023 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMFKjM8e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5357A221;
	Tue, 12 Dec 2023 16:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2221C433C7;
	Tue, 12 Dec 2023 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702400063;
	bh=h1eNwF1ukAZwGMPIsPczsxbRoYecqddxkA6L6AgPQ40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMFKjM8eqWRvgFjaSMtjvAgNnbCdSjJ5AL09SNEdeNnKdGEiFZHRNQFcY4Cle8CM0
	 xMVLCvmHkXv0+75ziNGrHpkotS1vIivnxNmrl1cIRskaXBIB/Nyv4+ZBI89kfc3SJn
	 CpMtXmMaR2aKMT9AzanuKoR4flQNcHnLlVnRUx6Qn65lU05s7+nLvAhBZx4pVlOIp9
	 AjJhN+dy9SoCkaq9JBISMucJqxz0YNj95guhsLpYJZHPYQVUhEcLwitBFxFhFGtr4j
	 HBlUka5Vws4HkuMZhZn8gM2B3AnOMwXl4R8hMhDLosVTCe03UWw78dZ49/LsBnReeJ
	 toAdT3vgidNPw==
Date: Tue, 12 Dec 2023 16:54:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Message-ID: <20231212-enrich-borax-7943611e2586@spud>
References: <20231210134717.94020-1-biju.das.jz@bp.renesas.com>
 <20231210134717.94020-9-biju.das.jz@bp.renesas.com>
 <20231211-dissuade-skirt-5961ef525497@spud>
 <TYCPR01MB112697AA2A3BC9F58C7BF4B67868FA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AApjMWf173swIuM7"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB112697AA2A3BC9F58C7BF4B67868FA@TYCPR01MB11269.jpnprd01.prod.outlook.com>


--AApjMWf173swIuM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 06:51:14PM +0000, Biju Das wrote:
> Hi Conor Dooley,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Monday, December 11, 2023 6:38 PM
> > Subject: Re: [PATCH v5 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062
> > to json-schema
> >=20
> > On Sun, Dec 10, 2023 at 01:47:17PM +0000, Biju Das wrote:
> > > Convert the da9062 PMIC device tree binding documentation to json-
> > schema.
> > >
> > > Document the missing gpio child node for da9062.
> > >
> > > While at it, update description with link to product information and
> > > example.
> > >
> > > The missing child node with of_compatible defined in MFD_CELL_OF is
> > > causing the below warning message:
> > > da9062-gpio: Failed to locate of_node [id: -1]
> > >
> > > So, make all child nodes with of_compatible defined in struct mfd_cell
> > > as required property for da906{1,2} devices.
> >=20
> > > +  gpio-controller: true
> > > +
> > > +  "#gpio-cells":
> > > +    const: 2
> > > +
> > > +  gpio:
> > > +    type: object
> > > +    additionalProperties: false
> > > +    properties:
> > > +      compatible:
> > > +        const: dlg,da9062-gpio
> >=20
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
> > > +    i2c {
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +      pmic@58 {
> > > +        compatible =3D "dlg,da9062";
> > > +        reg =3D <0x58>;
> > > +        gpio-controller;
> > > +        #gpio-cells =3D <2>;
> >=20
> > > +        gpio {
> > > +          compatible =3D "dlg,da9062-gpio";
> > > +        };
> >=20
> > I know you had some conversation with Krzysztof, but I still don;t real=
ly
> > follow this. Why is the parent, rather than the child, the one that gets
> > the "gpio-controller" and "#gpio-cells" properties? The commit message
> > just mentions why missing child node was added, but not the reason for =
the
> > gpio properties being added at what appears to be the "wrong" level.
>=20
>=20
> Please see [1], The driver is checking against parent "gpio-controller"
>=20
> [1] https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/pinctrl/pinc=
trl-da9062.c#L270

I would appreciate if you could note in your commit message the
rationale behind the strange setup. Citing the existing driver users etc
would be helpful.

Thanks,
Conor.

--AApjMWf173swIuM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiQOQAKCRB4tDGHoIJi
0rh4AP9s+Bmcr/KyPluXcEi2EtRA6eePFmH6Mq5j3SFKasEY5gEAlGa4LQlVue+w
FEKTSM6GPxE3wSMv7j6CkqL8+egPXgM=
=G9hA
-----END PGP SIGNATURE-----

--AApjMWf173swIuM7--


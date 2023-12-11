Return-Path: <linux-pm+bounces-908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29080D789
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 19:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2B5280FDA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 18:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4C154F8B;
	Mon, 11 Dec 2023 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXyZDnu2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E753E13;
	Mon, 11 Dec 2023 18:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97000C433C8;
	Mon, 11 Dec 2023 18:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702319865;
	bh=i7f2h372frnquYOlIfxX2lsm1eHXYw5UJ8UdHu+pUYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXyZDnu275hYShBpLNwHtHQRPLdzWRlC8tK2NfEv6Yohynuhr5D4I/2ZZ+HsHumMK
	 20ZZP6YrzehHWiWuJ4/vCo7qtMejMZlI2wxsq2TkZUma+q/SPxeDiU4Z0+s5ybXX5q
	 /Nq35FdKIwpCWc2VjWW7YOhRfF/chG1+mPqqxfKLsXv66OIGMXbPUXFZJYovF0nnKf
	 sJIbSRXvZ0Lr6y8wbo4+WV3qlDfWACFbwHRKNMZuhCvdbkJ2nRbzdSxSwzMPTz90de
	 5Z9nNREs21GI7TS2oY7ZY9IuI3+e3jyVSDhkDK2gxzLKWtmBAIGuweNrm9tAITo1Tm
	 kis+/zCMfoENQ==
Date: Mon, 11 Dec 2023 18:37:39 +0000
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
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Message-ID: <20231211-dissuade-skirt-5961ef525497@spud>
References: <20231210134717.94020-1-biju.das.jz@bp.renesas.com>
 <20231210134717.94020-9-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jm1o6il1/fMjzFQV"
Content-Disposition: inline
In-Reply-To: <20231210134717.94020-9-biju.das.jz@bp.renesas.com>


--jm1o6il1/fMjzFQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 01:47:17PM +0000, Biju Das wrote:
> Convert the da9062 PMIC device tree binding documentation to json-schema.
>=20
> Document the missing gpio child node for da9062.
>=20
> While at it, update description with link to product information and
> example.
>=20
> The missing child node with of_compatible defined in MFD_CELL_OF is
> causing the below warning message:
> da9062-gpio: Failed to locate of_node [id: -1]
>=20
> So, make all child nodes with of_compatible defined in struct mfd_cell
> as required property for da906{1,2} devices.

> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        const: dlg,da9062-gpio

> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      pmic@58 {
> +        compatible =3D "dlg,da9062";
> +        reg =3D <0x58>;
> +        gpio-controller;
> +        #gpio-cells =3D <2>;

> +        gpio {
> +          compatible =3D "dlg,da9062-gpio";
> +        };

I know you had some conversation with Krzysztof, but I still don;t
really follow this. Why is the parent, rather than the child, the one
that gets the "gpio-controller" and "#gpio-cells" properties? The commit
message just mentions why missing child node was added, but not the
reason for the gpio properties being added at what appears to be the
"wrong" level.

Cheers,
Conor.


--jm1o6il1/fMjzFQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXdW8wAKCRB4tDGHoIJi
0s/hAQCcpeg0Ix+zrZd8Cf70zuqtbsWdTGdhWRWP8v1wdghxAAEAqmct8je5QquP
eVk0NNNvZnXr8dpON8vw+X10erxBBgQ=
=C8uT
-----END PGP SIGNATURE-----

--jm1o6il1/fMjzFQV--


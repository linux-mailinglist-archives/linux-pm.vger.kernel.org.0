Return-Path: <linux-pm+bounces-1157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47265813585
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC31C20CC8
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B85E0BA;
	Thu, 14 Dec 2023 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE/U4nNR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BB5D91C;
	Thu, 14 Dec 2023 15:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326FEC433C8;
	Thu, 14 Dec 2023 15:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702569595;
	bh=7CoqfRw4JMr1mH61QnY6pnHqNDAJkzpjjIZkWX4fWDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oE/U4nNRQ8qAZMz6rhJ8Sce7YX983atw1Ny0Zxc1hMmAY3JxOc7pXYNlvPBXeaGuQ
	 loSUdaeJXdWV/b3HHhWHdDDfT6hOK0eKn3Pt3dYKl6FVkwhr2ptTCiXvrUv9tSOUBV
	 KDfMM8KNsKA3mz02PUm3IzzbDmXD8pzBQINycWQ65iM94UygxbumUS/VhfEFlA+nQF
	 9iMziNRgNs4Q/XbCBepT75LTFGS1psYisR0ReKKYzFozGOYLbjC1TLjHBrdDMCiJEO
	 mUmt/Ay9ptppcOBYMVi3QK87vU8cfcMSXYvX6HW4Fx9kLEIg1b77B9osyiebHQrJvD
	 eKcW3URUzhcqg==
Date: Thu, 14 Dec 2023 15:59:49 +0000
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
	Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Message-ID: <20231214-muzzle-spectator-6d8c278ccf8b@spud>
References: <20231214080911.23359-1-biju.das.jz@bp.renesas.com>
 <20231214080911.23359-9-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HqlfYCRaK1p8RYfx"
Content-Disposition: inline
In-Reply-To: <20231214080911.23359-9-biju.das.jz@bp.renesas.com>


--HqlfYCRaK1p8RYfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 08:09:11AM +0000, Biju Das wrote:
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
>=20
> The "gpio-controller" and "#gpio-cells" properties are defined in the
> parent instead of gpio child node as there are existing driver users
> based on these parent properties.

Thanks for updating the commit message :)
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--HqlfYCRaK1p8RYfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsmdQAKCRB4tDGHoIJi
0lzGAP4oEdT2WUJUxiyRRCFGE6OT0WvQwnCe1E3iSspn6sqjPAEA2Ki0TvwYTowX
TGIvSJPBorLjAV43jOT30EsDyvL91gg=
=3PTg
-----END PGP SIGNATURE-----

--HqlfYCRaK1p8RYfx--


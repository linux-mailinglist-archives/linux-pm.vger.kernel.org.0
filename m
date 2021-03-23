Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A9345E8C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCWMvv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 08:51:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50206 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCWMv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 08:51:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 21DC51F40E89
Received: by earth.universe (Postfix, from userid 1000)
        id 836543C0C96; Tue, 23 Mar 2021 13:51:23 +0100 (CET)
Date:   Tue, 23 Mar 2021 13:51:23 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-omap@vger.kernel.org
Subject: Re: [PATCHv2 01/38] ARM: dts: motorola-cpcap-mapphone: Prepare for
 dtbs_check parsing
Message-ID: <20210323125123.b63euv4vi6whahow@earth.universe>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-2-sebastian.reichel@collabora.com>
 <YFISPyIMCbp6WcAr@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unnwwncoobn4f2ef"
Content-Disposition: inline
In-Reply-To: <YFISPyIMCbp6WcAr@atomide.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--unnwwncoobn4f2ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Wed, Mar 17, 2021 at 04:29:19PM +0200, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.com> [210317 13:50]:
> > '<&gpio1 parameters &gpio2 parameters>' and '<&gpio1 parameters>,
> > <&gpio2 parameters>' result in the same DTB, but second format has
> > better source code readability. Also 'dtbs_check' currently uses
> > this format to determine the amount of items specified, so using
> > this syntax is needed to successfully verify the devicetree source
> > against a DT schema format.
>=20
> Looks good to me:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Please take this patch via your tree. I will take the other ones
through the power-supply tree.

Thanks,

-- Sebastian

--unnwwncoobn4f2ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBZ5EAACgkQ2O7X88g7
+pp/zw/+LM0w8J4WWGXpcDuEXp8mBPYCOxmSmsuj4levdK80QbuPuqXWB1wMTmhl
dXWhCkNEV1oAiy+xtrC5lUCKZ57RN+ShXQJgRErWnJENGt4hvopNQzhTlcOeNGNW
RtsAh/x+gTxn3uCd2lu9o7CLSwbGR1SUol+bTqB6IZ/2HHih5zWYY7dGrGYgVXM9
Zr7UbrQFx/ruxc6w/7rbkBwzsudwGu7U1fnyyqDeoove0NOctJYfYk0wGEcrl8YN
lzwbMnM94rhXW2+m4TiSxru+V/bXphN8C/Q+TUg7VKUhFXiPLScyRAK3pmIjMcCX
Q+IdRSLLsakgMLEMQxWjOjiFZD9ifBwZG/os6AU8A5i1PTAyFBqPQW19q8aBCoBJ
BqAwvmasOLZ3IEOMlbew7M49haOh2iy7siFa/1dIJ7ZMh66h77Lg9lSqkfADDAiM
dmmI1BQglr8WqdNPubad0eGwwsCEFL8uZ1sGvWuxKs9ONWvtHW/AzrMMwzyhE+Zl
IMagUmSZ05e5HB3949wqA1NUmGPbw0oa0mrHWbrgVja9eWL3cS0KQq18FzH1egV2
qKMTMM2te21cqtrH8t1vangIL1aBKNQB9Na9BPoOEKyYhiG/z99RiA4ZEU6+upjK
uEZjC2IS4dtQZlubhWMTyK1JLI6sJsY9aFqS4BHaWyTObBDGOA4=
=xC8B
-----END PGP SIGNATURE-----

--unnwwncoobn4f2ef--

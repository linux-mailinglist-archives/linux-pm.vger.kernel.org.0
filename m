Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC4D55B7
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfJMKz3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 06:55:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40455 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMKz3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 06:55:29 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1B5AD80249; Sun, 13 Oct 2019 12:55:10 +0200 (CEST)
Date:   Sun, 13 Oct 2019 12:55:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/5] power: supply: cpcap-battery: Move coulomb counter
 units per lsb to ddata
Message-ID: <20191013105505.GA26237@amd>
References: <20191009210621.10522-1-tony@atomide.com>
 <20191009210621.10522-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20191009210621.10522-2-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 14:06:17, Tony Lindgren wrote:
> We can simplify cpcap_battery_cc_raw_div() a bit by moving the units per
> lsb to ddata.
>=20
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/cpcap-battery.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -111,6 +111,7 @@ struct cpcap_battery_ddata {
>  	struct power_supply *psy;
>  	struct cpcap_battery_config config;
>  	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
> +	u32 cc_lsb;		/* =CE=BCAms per LSB */

micro-Ampere-seconds? Should be uAs?

									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jAokACgkQMOfwapXb+vLHvgCcDH3Jzo7DRlXg7WHfpaycOW4L
Td8AoL6fJ3hD4VcZIRybDHn+nLWhnwsD
=eo6j
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

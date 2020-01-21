Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF09143A12
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 10:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAUJ5P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 04:57:15 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:49918 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAUJ5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 04:57:15 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B67521C036D; Tue, 21 Jan 2020 10:57:13 +0100 (CET)
Date:   Tue, 21 Jan 2020 10:57:12 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for
 rough capacity
Message-ID: <20200121095712.GC6934@amd>
References: <20200119201124.29620-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20200119201124.29620-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Get a rough battery charge estimate until we've seen a high or low
> battery level. After that we can use the coulomb counter to calculate
> the battery capacity.
>=20
> Note that I should probably update this to support ocv-capacity-table
> before this makes sense to apply. With ocv-capacity-table we should be
> able to estimate battery state as described in the documentation for
> Documentation/devicetree/bindings/power/supply/battery.txt.

Maybe we should let userspace do that?

https://github.com/pavelmachek/libbattery

> +struct cpcap_battery_capacity {
> +	int capacity;
> +	int voltage;
> +	int percentage;
> +};
> +
> +#define CPCAP_CAP(l, v, p)			\
> +{						\
> +	.capacity =3D (l),			\
> +	.voltage =3D (v),				\
> +	.percentage =3D (p),			\
> +},
> +
> +/* Pessimistic battery capacity mapping before high or low value is seen=
 */
> +static const struct cpcap_battery_capacity cpcap_battery_cap[] =3D {
> +	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN,        0,   0)
> +	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL, 3100000,   0)
> +	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_LOW,      3300000,   2)
> +	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_NORMAL,   3700000,  50)
> +	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_HIGH,     4000000,  75)
> +	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL,     4200000 - 18000, 100)
> +};

No, not like this; it is simultaneously too complex and not complex
enough.

Too complex: we don't really want a table, when there's well know
formula implementing it:
http://git.goldelico.com/?p=3Dgta04-kernel.git;a=3Dpatch;h=3D22ab047ae296e9=
98379c1aa29fe1210043cfa040=20

Not complex enough: we know the current (and there are going to be big
differences between CPU idle and CPU loaded with GSM active), and
there's dependency on temperature, too...

Best regards,

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4myvgACgkQMOfwapXb+vJA3ACggo6KZgzG66dDEMewMxO05q5A
uMwAoJM+jK1VSlNT8EVqssIHnYJbpdQp
=6FcI
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CFED55CB
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 13:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfJMLaX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 07:30:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41135 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMLaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:30:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 653138023F; Sun, 13 Oct 2019 13:30:05 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:30:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/2] power: supply: cpcap-battery: Fix handling of
 lowered charger voltage
Message-ID: <20191013113017.GC5653@amd>
References: <20191009210141.10037-1-tony@atomide.com>
 <20191009210141.10037-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20191009210141.10037-2-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> With cpcap-charger now using 4.2V instead of 4.35V, we never reach
> POWER_SUPPLY_CAPACITY_LEVEL_FULL unless we handle the lowered charge
> voltage.
>=20
> Let's do this by implementing POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> and assume anything at that level or higher is a full battery.
>=20
> Let's also make it configurable for users who may still want to
> reconfigure it, and notify the charger if supported by the charger.

> +static int cpcap_battery_set_property(struct power_supply *psy,
> +				      enum power_supply_property psp,
> +				      const union power_supply_propval *val)
> +{
> +	struct cpcap_battery_ddata *ddata =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		if (val->intval < ddata->config.info.voltage_min_design)
> +			return -EINVAL;

Is minimum design applicable here? I believe that's the lowest voltage
battery is discharged to...

I guess we can use it if there's no more suitable limit?

> +		ddata->config.bat.constant_charge_voltage_max_uv =3D val->intval;
> +
> +		return cpcap_battery_update_charger(ddata, val->intval);
> +	break;

Delete the break.

Acked-by: Pavel Machek <pavel@ucw.cz>
	  								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jCskACgkQMOfwapXb+vKKagCcDMwmVFNX3hCHyu6q63XvXs6M
tUEAn3kwe2rx5jKEmMC1YGZ5W0860vMO
=f43u
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--

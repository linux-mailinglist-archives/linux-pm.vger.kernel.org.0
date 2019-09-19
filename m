Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4A3B763F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbfISJ1C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 05:27:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45291 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388601AbfISJ1B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 05:27:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3721881B7E; Thu, 19 Sep 2019 11:26:45 +0200 (CEST)
Date:   Thu, 19 Sep 2019 11:26:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/3] power: supply: cpcap-charger: Allow changing
 constant charge voltage
Message-ID: <20190919092658.GD9644@amd>
References: <20190917215253.17880-1-tony@atomide.com>
 <20190917215253.17880-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <20190917215253.17880-3-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Let's allow reconfiguring the cpcap-charger max charge voltage and
> default to 4.2V that should be safe for the known users.
>=20
> This allows the users to use 4.35V for the extra capacity if really
> needed at a cost of probably shorter battery life. We check the
> constant charge voltage limit set by the battery.
>=20
> Some pieces of the property setting code is based on an earlier patch
> from Pavel Machek <pavel@ucw.cz> but limited to configuring the charge
> voltage for now.

I'm sorry I'm a tiny bit busy at the moment.

> +const int cpcap_charge_voltage[] =3D {
> +	[CPCAP_REG_CRM_VCHRG_3V80] =3D 3800000,
> +	[CPCAP_REG_CRM_VCHRG_4V10] =3D 4100000,
> +	[CPCAP_REG_CRM_VCHRG_4V12] =3D 4120000,
> +	[CPCAP_REG_CRM_VCHRG_4V15] =3D 4150000,
> +	[CPCAP_REG_CRM_VCHRG_4V17] =3D 4170000,
> +	[CPCAP_REG_CRM_VCHRG_4V20] =3D 4200000,
> +	[CPCAP_REG_CRM_VCHRG_4V23] =3D 4230000,
> +	[CPCAP_REG_CRM_VCHRG_4V25] =3D 4250000,
> +	[CPCAP_REG_CRM_VCHRG_4V27] =3D 4270000,
> +	[CPCAP_REG_CRM_VCHRG_4V30] =3D 4300000,
> +	[CPCAP_REG_CRM_VCHRG_4V33] =3D 4330000,
> +	[CPCAP_REG_CRM_VCHRG_4V35] =3D 4350000,
> +	[CPCAP_REG_CRM_VCHRG_4V38] =3D 4380000,
> +	[CPCAP_REG_CRM_VCHRG_4V40] =3D 4400000,
> +	[CPCAP_REG_CRM_VCHRG_4V42] =3D 4420000,
> +	[CPCAP_REG_CRM_VCHRG_4V44] =3D 4440000,
> +};

We really don't need this kind of explicit table, as the values can be
simply computed. Can I offer this?

Best regards,
								Pavel

static int voltage_to_register(int microvolt)
{
	int milivolt =3D microvolt/1000;
	int res;

	if (milivolt < 4100)
		return CPCAP_REG_CRM_VCHRG_3V80;
	if (milivolt > 4350)
		return -EINVAL;

	milivolt =3D milivolt - (4100 - 250);
	res =3D milivolt / 250;
	BUG_ON(res < 1);
	BUG_ON(res > 0xb);
	return CPCAP_REG_CRM_VCHRG(res);
}

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2DSeIACgkQMOfwapXb+vI3ZwCfbjRw5XriwwePmB0OD5zrLXQo
6cMAn0LHMD1AefGxjgzYYy/t3k1UKBe5
=1nCB
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--

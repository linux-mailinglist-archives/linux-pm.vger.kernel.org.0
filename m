Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F50D55CD
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 13:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfJMLbR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 07:31:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41151 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMLbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:31:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E7AE480249; Sun, 13 Oct 2019 13:30:59 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:31:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/2] power: supply: cpcap-charger: Allow changing
 constant charge voltage
Message-ID: <20191013113111.GD5653@amd>
References: <20191009210141.10037-1-tony@atomide.com>
 <20191009210141.10037-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <20191009210141.10037-3-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9UV9rz0O2dU/yYYn
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
>=20
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

> @@ -259,6 +263,83 @@ static int cpcap_charger_get_property(struct power_s=
upply *psy,
>  	return 0;
>  }
> =20
> +static int cpcap_charger_match_voltage(int voltage)
> +{
> +	switch (voltage) {
> +	case 0 ... 4100000 - 1: return 3800000;

Would it be better to return 0 for < 3.8V values?

> +	case 4100000 ... 4120000 - 1: return 4120000;

I believe this should be 4100000.

> +	case 4120000 ... 4150000 - 1: return 4120000;
> +	case 4150000 ... 4170000 - 1: return 4150000;
> +	case 4170000 ... 4200000 - 1: return 4170000;
> +	case 4200000 ... 4230000 - 1: return 4200000;

With that fixed,

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jCv8ACgkQMOfwapXb+vIsqgCffXuGA63JaCsbY4hYDH+3HovA
m6MAoLrdwLvgzK6OYD2B4Ykgms7dRMUr
=Slai
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--

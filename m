Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E591C166E
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 16:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgEANsQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731925AbgEANsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 09:48:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E47C08E859;
        Fri,  1 May 2020 06:48:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3703E2A3057
Received: by earth.universe (Postfix, from userid 1000)
        id C13453C08C7; Fri,  1 May 2020 15:48:08 +0200 (CEST)
Date:   Fri, 1 May 2020 15:48:08 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 02/11] power: charger-manager: don't write through
 desc->properties
Message-ID: <20200501134808.dbmsc7sy7pffiqvr@earth.universe>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
 <a529e64edb81a4795fe0b6480f1e4051bed1b099.1585944770.git.mirq-linux@rere.qmqm.pl>
 <20200501123849.ws2a5ybeeej6phyr@earth.universe>
 <20200501133008.GA8927@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="knuoulvhycxt3vyk"
Content-Disposition: inline
In-Reply-To: <20200501133008.GA8927@qmqm.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--knuoulvhycxt3vyk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 03:30:08PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Fri, May 01, 2020 at 02:38:49PM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Fri, Apr 03, 2020 at 10:20:31PM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> > > psy_desc->properties will become pointer to const.  Avoid writing
> > > through the pointer to enable constification of the tables elsewhere.
> > >=20
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > For patches 1-3 I used my version, that I wrote in parallel while
> > reviewing a different patch series. It is slightly different, but
> > achieves the same goal.
>=20
> There is a bug in the tree now regarding use of num_properties
> in charger-manager.  Following patch should fix it.

Thanks, I folded this into the charger-manager patch.

-- Sebastian

> Best Regards,
> Micha=C5=82 Miros=C5=82aw
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index a71e2ee81423..2ef53dc1f2fb 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1740,14 +1740,14 @@ static int charger_manager_probe(struct platform_=
device *pdev)
>  	}
>  	if (!power_supply_get_property(fuel_gauge,
>  					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
> -		properties[cm->charger_psy_desc.num_properties] =3D
> +		properties[num_properties] =3D
>  				POWER_SUPPLY_PROP_CHARGE_NOW;
>  		num_properties++;
>  	}
>  	if (!power_supply_get_property(fuel_gauge,
>  					  POWER_SUPPLY_PROP_CURRENT_NOW,
>  					  &val)) {
> -		properties[cm->charger_psy_desc.num_properties] =3D
> +		properties[num_properties] =3D
>  				POWER_SUPPLY_PROP_CURRENT_NOW;
>  		num_properties++;
>  	}

--knuoulvhycxt3vyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sKIwACgkQ2O7X88g7
+pprmA//a2gYLZogVty4flbheMGa30mYF3mxI3KM495HeF2OrPAN2fN9zZXsPQwC
hgwuhIqpsTHzjFIvFzQ1RsAJjVTrGsvwBUd875zxqf0z4FO++UYRhdZmpxC6rFCI
cTaAgyRrnuQjlBHHZTfzbcOQlM4W6hskLOaOR7NFSIoAn7KvrBCc/tRHUcY9f4JY
aOKi34jSGG8WcnIPIDBgcFRuL66Xzh7qbKkYK5j1Q7VbXxps6YXYeDyqI7Nx6R2r
W2K1Elo2eIrXTXb5Z2CV2xP0lFkcAYTn+B7i4IiKU6hL6ctH0d1hbUVM6OOxDGHR
ThEOKHmHBgcrvXDZ+J40s4QddmIUgCDs5wzBIm2qbNKohnYOpTusn6M2Psld1Ae/
n8vNAaWFhArjD0NSNN9UrmGQE+BV0Eu3RpC8YQ33C4TAy9zT6g964Bs9Zty57iaa
hHjlMCHrAEIRoNGiloElrCA1BKV9DnhkL4nqt0XeCh3PUJ2W/OAgv3hXg0YMWJM8
ha2E9Jmgqyi2C8hphFSjP5bDMtQQx2yEugn0lqcaREdgdeaOCaslmUYd1BQ4uZbA
l/mBn1qz2Thv3iO/ZGK9GT7Z+jqkZAZI0fTUswhl2Ag1n3UPTJgwPpbWzO/40Qbw
0WjrCnetZxodJT/UXg0L2roQrgh0Mh0IR5Cs3V0wTeQJWi5OoTI=
=GnxU
-----END PGP SIGNATURE-----

--knuoulvhycxt3vyk--

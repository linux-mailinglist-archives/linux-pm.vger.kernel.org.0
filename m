Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5D41D812
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350095AbhI3KwH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 06:52:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350127AbhI3KwG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 06:52:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 111741F44AD2
Received: by earth.universe (Postfix, from userid 1000)
        id 9E77A3C0CA8; Thu, 30 Sep 2021 12:50:19 +0200 (CEST)
Date:   Thu, 30 Sep 2021 12:50:19 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] power: supply: core: Move psy_has_property() to fix build
Message-ID: <20210930105019.h7jhfjr5hkmzhh6e@earth.universe>
References: <7b35a74f2c2ad19c8dc1ca60c59e48a14288677f.1632830348.git.geert+renesas@glider.be>
 <YVSOCZZiSjMX5Ul7@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zfv6tookm75yhkib"
Content-Disposition: inline
In-Reply-To: <YVSOCZZiSjMX5Ul7@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zfv6tookm75yhkib
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 29, 2021 at 09:02:17AM -0700, Matthias Kaehlcke wrote:
> On Tue, Sep 28, 2021 at 02:00:19PM +0200, Geert Uytterhoeven wrote:
> > If CONFIG_THERMAL=3Dn:
> >=20
> >     drivers/power/supply/power_supply_core.c: In function =E2=80=98__po=
wer_supply_register=E2=80=99:
> >     drivers/power/supply/power_supply_core.c:1137:6: error: implicit de=
claration of function =E2=80=98psy_has_property=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
> >      1137 |  if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> > 	  |      ^~~~~~~~~~~~~~~~
> >=20
> > Fix this by moving psy_has_property() outside the section protected by
> > CONFIG_THERMAL.
> >=20
> > Fixes: 9ba533eb99bb2acf ("power: supply: core: Add psy_has_property()")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---

Thanks, queued.

-- Sebastian

> >  drivers/power/supply/power_supply_core.c | 32 ++++++++++++------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index 75575ea45f21ddc7..fc12a4f407f431a6 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -951,6 +951,22 @@ void power_supply_unreg_notifier(struct notifier_b=
lock *nb)
> >  }
> >  EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
> > =20
> > +static bool psy_has_property(const struct power_supply_desc *psy_desc,
> > +			     enum power_supply_property psp)
> > +{
> > +	bool found =3D false;
> > +	int i;
> > +
> > +	for (i =3D 0; i < psy_desc->num_properties; i++) {
> > +		if (psy_desc->properties[i] =3D=3D psp) {
> > +			found =3D true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return found;
> > +}
> > +
> >  #ifdef CONFIG_THERMAL
> >  static int power_supply_read_temp(struct thermal_zone_device *tzd,
> >  		int *temp)
> > @@ -975,22 +991,6 @@ static struct thermal_zone_device_ops psy_tzd_ops =
=3D {
> >  	.get_temp =3D power_supply_read_temp,
> >  };
> > =20
> > -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> > -			     enum power_supply_property psp)
> > -{
> > -	bool found =3D false;
> > -	int i;
> > -
> > -	for (i =3D 0; i < psy_desc->num_properties; i++) {
> > -		if (psy_desc->properties[i] =3D=3D psp) {
> > -			found =3D true;
> > -			break;
> > -		}
> > -	}
> > -
> > -	return found;
> > -}
> > -
> >  static int psy_register_thermal(struct power_supply *psy)
> >  {
> >  	int ret;
>=20
> Thanks for the fix!
>=20
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

--zfv6tookm75yhkib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFVlmQACgkQ2O7X88g7
+pp5+Q/7BHTkk5ug8j0lEOXPCT3yz+z8fDcNqfQOiwpw8eqB4sF+xTynMJ9jp9gF
dhkrIBKaaOOlkz79W6s/YZ8lzZv913+cr8cfsBE8M2p/4d9zTqZaDv7D6ImrF3CY
Ru+/uWNQqULuzn2+Yjnf3IdEyTw5BIidXT+ae7rY2Y5i0a+bHpIpMQ20RAZvmy/v
6LMhQp1ZcT8DTxqICBzJLJCX88db7FTH8GSEq64YLfavjaYKOW3gvq9+wVAPwG71
gdv9DvmNq681BoSpMoSV8Dm0HaDTmTZK8EFfohkpKdp9amc2fU/vhF1IceEMS+W5
yyqVGRTNimKbmX8xlUNTwfTrKpS/5t8UCBzIshXl+KPTnEwBNBFbi4fed1g2N+76
CF+PJIY1S/lx+ZZ+ajrFwFt8IdFHT433mO12MiJBzMU+IzoLEf/fNrR1G0z5FSrG
UxZwOCkTduUNY8rrZcOcpO1Emtr1YCcKTGfhzOK8b5vOJFU95ng57Y3yhJihL1HV
Hdb7f3Em42mvZK6X9CYZLUR6b5SmmkGzAtLUad8C8uqYyh6hd9ttp7FRgWF+lRHe
RQPfsE2u2IAm+e+RHWqgIP/eaBF3SXzOENyEz9iIwzySrdGOzRiQzZtLvkkaZqPr
ONCGTP0IBzjtcPyJdCizupSORkwxbwSKUC9HWaX+N3YcRDk9/Bo=
=Zayd
-----END PGP SIGNATURE-----

--zfv6tookm75yhkib--

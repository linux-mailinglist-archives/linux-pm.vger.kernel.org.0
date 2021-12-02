Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A3466954
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 18:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbhLBRro (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 12:47:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348154AbhLBRro (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 12:47:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 040961F469C1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638467058; bh=CAK/QaTj1EmKdEe0z8w5xDfoJgsZYK/fo9l3+cDN7zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1fDE1dW77HUg5iqk2WNfH4J18ejEaTWBeHModw/54n1y2q9TFe07O1caQAHUqgHK
         mNDhvlgqTirtuezN8z0FaKE2deop5mvDsu67pg1/VPYEZLgwcqTX6WplHCs4sKaoFk
         zhV5TEWjMxMbILrrQyTrmy0UPthL9ItyfcCJQgmQBDnFsp8kXHVPbuRG0FFTr3m9JS
         KCNO9J7fhcVQgwUOq6uNR/y/ld3LZcwvzTwNlhMFBi2vGBKnvSMrvVFJKfQkR4LvEz
         m+cWZlAt9vk8WFhSK5TT7SWZoVuOhkkPpKh/xcxmW8esOlUYB1mifbP8wYYflOWtkq
         eAm9oFKHUV7ZA==
Received: by earth.universe (Postfix, from userid 1000)
        id 61FDE3C0CA8; Thu,  2 Dec 2021 18:44:15 +0100 (CET)
Date:   Thu, 2 Dec 2021 18:44:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     Evgeny Boger <boger@wirenboard.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: [PATCH] power: supply: axp20x_battery: properly report current
 when discharging
Message-ID: <20211202174415.fn3kg4tg63lqcmqh@earth.universe>
References: <20211119181835.441233-1-boger@wirenboard.com>
 <20211201180304.z2jtgi5udwcjf2wa@fiqs>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="euw4nmcykz5ytfyo"
Content-Disposition: inline
In-Reply-To: <20211201180304.z2jtgi5udwcjf2wa@fiqs>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--euw4nmcykz5ytfyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 01, 2021 at 07:03:04PM +0100, Quentin Schulz wrote:
> Hi Evgeny,
>=20
> On Fri, Nov 19, 2021 at 09:18:35PM +0300, Evgeny Boger wrote:
> > As stated in [1], negative current values are used for discharging
> > batteries.
> >=20
> > AXP PMICs internally have two different ADC channels for shunt current
> > measurement: one used during charging and one during discharging.
> > The values reported by these ADCs are unsigned.
> > While the driver properly selects ADC channel to get the data from,
> > it doesn't apply negative sign when reporting discharging current.
> >=20
> > [1] Documentation/ABI/testing/sysfs-class-power
> >=20
> > Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> > ---
> >  drivers/power/supply/axp20x_battery.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supp=
ly/axp20x_battery.c
> > index 18a9db0df4b1..4ed01777035b 100644
> > --- a/drivers/power/supply/axp20x_battery.c
> > +++ b/drivers/power/supply/axp20x_battery.c
> > @@ -186,7 +186,6 @@ static int axp20x_battery_get_prop(struct power_sup=
ply *psy,
> >  				   union power_supply_propval *val)
> >  {
> >  	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> > -	struct iio_channel *chan;
> >  	int ret =3D 0, reg, val1;
> > =20
> >  	switch (psp) {
> > @@ -267,11 +266,11 @@ static int axp20x_battery_get_prop(struct power_s=
upply *psy,
> >  			return ret;
> > =20
> >  		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING)
> > -			chan =3D axp20x_batt->batt_chrg_i;
> > -		else
> > -			chan =3D axp20x_batt->batt_dischrg_i;
> > -
> > -		ret =3D iio_read_channel_processed(chan, &val->intval);
> > +			ret =3D iio_read_channel_processed(axp20x_batt->batt_chrg_i, &val->=
intval);
> > +		else {
>=20
> The if should also have curly brackets now, even if it's only one line.
>=20
> > +			ret =3D iio_read_channel_processed(axp20x_batt->batt_dischrg_i, &va=
l1);
> > +			val->intval =3D -val1;
> > +		}
>=20
> Otherwise, since the ABI is not deemed stable (testing in the path of
> the name), I guess there;s no contract with userspace and we're fine
> fixing this broken behavior (which userspace might have worked-around
> themselves and thus we break userspace).
>=20
> @Sebastian, is that ok?

Sure.

-- Sebastian

--euw4nmcykz5ytfyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGpBekACgkQ2O7X88g7
+pq+0A/+Nhrxpdql3Qe+s7qBpPEq9LiGiWiMGFj9ou756FvKUY9HeZNoMzo+o7F4
KQ3NeoyXYv+vaqMFmnWRXdZyWyO6M/uPtOtSLfkUVF5/pn5xArml93NvP12+7THa
fzKBkqVHl7+ovI819DfJ9DZEMVAQFPrFbZnkFKtiqZcmVxfDQnftnAkdw2dY5lYq
93KOcomH8a93gsTGofXOxDqiQBtD2iavn4kjr9i1EYRlpdkLq6oHeAXtEuDFB/A+
KRBmN3RT2aFHul3R5QkfJ5mM5uWREVwpj7KNACDOPuUGeSeS/7oQo+w1kduXPgmy
W7Uj6xo8b4RBCla6kPSuEcMuE9mQNEn4HVehpMIRceb2xApiZnpxax7rOyxRbr/5
cJzz6s354Pb2SOwy+MY7TIDxr6e2XFJJZ9Ni6uk8GaNw4rLWp961m1RL4aOD7ILC
+9Ub3ws2psEGpzFTidc69cb/wS10P+jaS0iCwGhTPXbU1XKgstpGEvVPEWZ5mLnn
u2xNRCzKOV99qRUIQaeaDphuFDlJVHITiwFYgDQNKaIw77Dmn+KhQExwJs+htwx0
AQaVvWzwTi8WLMg4524cWqPml9Nb1P1NYfH9amQ5GfW4ktdBHAwXVTcmUs7UC0If
N3FQ2O58ONXaGZpyt0oXinxwmn8Zam9LEIcxgCCndDyIGVC59+c=
=Tta9
-----END PGP SIGNATURE-----

--euw4nmcykz5ytfyo--

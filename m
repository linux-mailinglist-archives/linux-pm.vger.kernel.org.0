Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1479255E4A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgH1P6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 11:58:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42336 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1P6s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 11:58:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5D2A129ACA6
Received: by earth.universe (Postfix, from userid 1000)
        id 8ECDB3C0C82; Fri, 28 Aug 2020 17:58:43 +0200 (CEST)
Date:   Fri, 28 Aug 2020 17:58:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org, dianders@chromium.org,
        briannorris@chromium.org
Subject: Re: [PATCH v4] power: supply: sbs-battery: don't assume i2c errors
 as battery disconnect
Message-ID: <20200828155843.33xb2ig2gpawigsw@earth.universe>
References: <20200828043626.1247250-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qgqurc2mhqgxz722"
Content-Disposition: inline
In-Reply-To: <20200828043626.1247250-1-ikjn@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qgqurc2mhqgxz722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 28, 2020 at 12:36:26PM +0800, Ikjoon Jang wrote:
> Current sbs-battery considers all smbus errors as disconnection events
> when battery-detect pin isn't supplied, and restored to present state back
> when any successful transaction is made.
>=20
> This can lead to unwanted state changes between present and !present
> when there's one i2c error and other following commands were successful.
>=20
> This patch provides a unified way of checking presence by calling
> sbs_get_battery_presence_and_health() when detect pin is not used.
>=20
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
> v4: rebase from merge conflict, amend commit messages
> v3: check return value of get_presence_and_health()
> v2: combine get_presence_and_health functions to reuse
> ---

Thanks, queued.

-- Sebastian

>=20
>  drivers/power/supply/sbs-battery.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 6273211cd673..dacc4bc1c013 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -959,10 +959,17 @@ static int sbs_get_property(struct power_supply *ps=
y,
>  		return -EINVAL;
>  	}
> =20
> -	if (!chip->gpio_detect &&
> -		chip->is_present !=3D (ret >=3D 0)) {
> -		sbs_update_presence(chip, (ret >=3D 0));
> -		power_supply_changed(chip->power_supply);
> +	if (!chip->gpio_detect && chip->is_present !=3D (ret >=3D 0)) {
> +		bool old_present =3D chip->is_present;
> +		union power_supply_propval val;
> +
> +		ret =3D sbs_get_battery_presence_and_health(
> +				client, POWER_SUPPLY_PROP_PRESENT, &val);
> +
> +		sbs_update_presence(chip, !ret && val.intval);
> +
> +		if (old_present !=3D chip->is_present)
> +			power_supply_changed(chip->power_supply);
>  	}
> =20
>  done:
> @@ -1147,11 +1154,13 @@ static int sbs_probe(struct i2c_client *client)
>  	 * to the battery.
>  	 */
>  	if (!(force_load || chip->gpio_detect)) {
> -		rc =3D sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> +		union power_supply_propval val;
> =20
> -		if (rc < 0) {
> -			dev_err(&client->dev, "%s: Failed to get device status\n",
> -				__func__);
> +		rc =3D sbs_get_battery_presence_and_health(
> +				client, POWER_SUPPLY_PROP_PRESENT, &val);
> +		if (rc < 0 || !val.intval) {
> +			dev_err(&client->dev, "Failed to get present status\n");
> +			rc =3D -ENODEV;
>  			goto exit_psupply;
>  		}
>  	}
> --=20
> 2.28.0.402.g5ffc5be6b7-goog
>=20

--qgqurc2mhqgxz722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9JKasACgkQ2O7X88g7
+pqaew/+LBPta+H2lhFkotrZpmZwi5OmzMGZWKi/omMsgFzr+rF2qO5WguFdXSK1
it0rjssL24ZIm4pZor87yk5OB1PGarD7xeCx4vd4rjb2sePtVNzHC9CONcf12k0e
f3YJN//Aw7MaeWGutj1nVviJIpNvQ8XA/xZCkTp7iwjzKEnmOAzDg/v1pxAgOnhe
1i3s7k6C8UbZyXRj9+1YPtok6DKkj1QBc/cUborVMGImq8mGarvbEQ7O35RmoPN8
yhSYHD+h79k+azlFKF2aSYIx3BZP1gfCpU+8Klc+xrJiFXccaC0SnrshnVr8ODXd
pTSxAqKYa91P5IZw0QqJ2+RPVXlMB34sPJld5gruiPjAdCTAwZk4kskiAvayjAbq
zdSsjb6G9q2YHaiQvG36xg3t+hjuEoCtO9vZtbBoTWF8JSzEdS/g51+wMmiIkhDG
HpzbWx2HRTY/axbUuPjvEYd7mwbqmF7lRV7kakmFsrDkzCN5rvynLet9sdEo1SrA
SZgnxbiOD2zIMWEsL4y/B9RFneQcBef5z6TOpvDy3uFsPIkWMCNL2s2DGKc6N6tz
x5eQ0pyDPIr42sejeWtoH72o6oSLNelDv6o5PyYfxKpJBPUXmNHLK6fu5P5uU5un
simTUPK4S/hzVyw7m5NLEnmVfi5I099Xn6m1hjuLRVm7o/z75qQ=
=ydBg
-----END PGP SIGNATURE-----

--qgqurc2mhqgxz722--

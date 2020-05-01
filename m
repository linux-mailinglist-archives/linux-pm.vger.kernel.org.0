Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5901C12C9
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgEANWd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 09:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728586AbgEANWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 09:22:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC86C061A0C;
        Fri,  1 May 2020 06:22:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 036C72A0C36
Received: by earth.universe (Postfix, from userid 1000)
        id E3C473C08C7; Fri,  1 May 2020 15:22:29 +0200 (CEST)
Date:   Fri, 1 May 2020 15:22:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 08/11] power: supply: core: hide unused HWMON labels
Message-ID: <20200501132229.aeg44zi635ktfuap@earth.universe>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
 <7ac1176497a246b59316efecef9912dcf9b1e48a.1585944770.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wcqqnkkh7dhow3c4"
Content-Disposition: inline
In-Reply-To: <7ac1176497a246b59316efecef9912dcf9b1e48a.1585944770.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wcqqnkkh7dhow3c4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 03, 2020 at 10:20:34PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Currently HWMON emulation shows all labels (temp and ambient temp)
> regardless if power supply supports reading the values. Check that at
> least one property is enabled for each label.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

> v3: use a tabule for type checking instead of switch() sequence
> ---
>  drivers/power/supply/power_supply_hwmon.c | 42 +++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index 5621e72a39f0..1b473deaf391 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -103,6 +103,39 @@ static bool power_supply_hwmon_is_a_label(enum hwmon=
_sensor_types type,
>  	return type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_label;
>  }
> =20
> +struct hwmon_type_attr_list {
> +	const u32 *attrs;
> +	size_t n_attrs;
> +};
> +
> +static const u32 ps_temp_attrs[] =3D {
> +	hwmon_temp_input,
> +	hwmon_temp_min, hwmon_temp_max,
> +	hwmon_temp_min_alarm, hwmon_temp_max_alarm,
> +};
> +
> +static const struct hwmon_type_attr_list ps_type_attrs[hwmon_max] =3D {
> +	[hwmon_temp] =3D { ps_temp_attrs, ARRAY_SIZE(ps_temp_attrs) },
> +};
> +
> +static bool power_supply_hwmon_has_input(
> +	const struct power_supply_hwmon *psyhw,
> +	enum hwmon_sensor_types type, int channel)
> +{
> +	const struct hwmon_type_attr_list *attr_list =3D &ps_type_attrs[type];
> +	size_t i;
> +
> +	for (i =3D 0; i < attr_list->n_attrs; ++i) {
> +		int prop =3D power_supply_hwmon_to_property(type,
> +			attr_list->attrs[i], channel);
> +
> +		if (prop >=3D 0 && test_bit(prop, psyhw->props))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static bool power_supply_hwmon_is_writable(enum hwmon_sensor_types type,
>  					   u32 attr)
>  {
> @@ -129,9 +162,12 @@ static umode_t power_supply_hwmon_is_visible(const v=
oid *data,
>  	const struct power_supply_hwmon *psyhw =3D data;
>  	int prop;
> =20
> -
> -	if (power_supply_hwmon_is_a_label(type, attr))
> -		return 0444;
> +	if (power_supply_hwmon_is_a_label(type, attr)) {
> +		if (power_supply_hwmon_has_input(psyhw, type, channel))
> +			return 0444;
> +		else
> +			return 0;
> +	}
> =20
>  	prop =3D power_supply_hwmon_to_property(type, attr, channel);
>  	if (prop < 0 || !test_bit(prop, psyhw->props))
> --=20
> 2.20.1
>=20

--wcqqnkkh7dhow3c4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sIpAACgkQ2O7X88g7
+pr0lBAAg/bEnt2yXctWBRB2ixT9sZwNldl0hoRkVakYnSCpp6XUgayUx10PU8Jy
b2lars/pNd0pD+PjbXFqG4iSoUd+h9JkR3ZyeWBmwidQJumy9wGuGGmeMhoNrFGW
KKFEW4tdZD1uLUUIKUE740cas3gG8hcZS5dLfZY+F84b1Fk4hZDnb6pXpzW9LcNK
8ISybTVWSjISSliIHwxRfzPAeuqmqWFvo3K/peXwbwlD2JWYuvkMK05Ju8M/X7+a
KFIm8QLUqrOPRaEy97mChRaBE5wZXJOJLWlXeNw/OqlLF9Rfp/bqMdq74VL4UUnl
QT8lYI/wpd6Qf+/RcOuz9qwYen4a8uxxd0H6M7dG+UzClYApenEXK4ntMGk2hQi1
Ggo3shGxIcU4lGsLFN2unfmSPjO57MSPmRUiiXBox2j0IEpuOay1tEDFCKQzw65Z
rQFroG5GzWzLILhtM+D+/5yYVpyZFqT1sxIrB481zFvBtEnmgWOILtdNmV0xYpOl
+hKA3/EkWaCO8y4ulcONPMhPxoUfegkpKFGloYKFrgIwPre11WL6C2yENiI21cRV
mWx69b/Lfkpc3apf2Rq0aAeYgUhRm/2utjb5Qsjng/cifn74yMj9Pv8kzpR46DPs
fK+kGaBcpwQywUrjAMeA/DMGyO+W/v4xWy9tB1olsNvQOKXhx+A=
=iMAn
-----END PGP SIGNATURE-----

--wcqqnkkh7dhow3c4--

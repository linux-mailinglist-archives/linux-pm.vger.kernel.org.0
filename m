Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABA7250AF6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 23:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHXVjF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 17:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 17:39:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179AC061574;
        Mon, 24 Aug 2020 14:39:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 99FF2297C57
Received: by earth.universe (Postfix, from userid 1000)
        id D3FA43C0C82; Mon, 24 Aug 2020 23:38:59 +0200 (CEST)
Date:   Mon, 24 Aug 2020 23:38:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] power: supply: Add battery gauge driver for Acer
 Iconia Tab A500
Message-ID: <20200824213859.6o3q5i2kvtk44lqi@earth.universe>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-3-digetx@gmail.com>
 <20200824140718.apoavlny6hlkm2ql@earth.universe>
 <31ec6865-4a33-bde8-73a6-20c188ec2ee7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rq3bkynnovf3rl57"
Content-Disposition: inline
In-Reply-To: <31ec6865-4a33-bde8-73a6-20c188ec2ee7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rq3bkynnovf3rl57
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 24, 2020 at 09:55:14PM +0300, Dmitry Osipenko wrote:
> 24.08.2020 17:07, Sebastian Reichel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> +static int a500_battery_get_serial_number(struct a500_battery *bat,
> >> +					  union power_supply_propval *val)
> >> +{
> >> +	unsigned int i;
> >> +	s32 ret =3D 0;
> >> +
> >> +	if (bat->serial[0])
> >> +		goto done;
> >> +
> >> +	a500_ec_lock(bat->ec_chip);
> >> +	for (i =3D 0; i < BATTERY_SERIAL_LEN / 2; i++) {
> >> +		ret =3D a500_ec_read_locked(bat->ec_chip,
> >> +					  &ec_data[REG_SERIAL_NUMBER].cmd);
> >> +		if (ret < 0) {
> >> +			bat->serial[0] =3D '\0';
> >> +			break;
> >> +		}
> >> +
> >> +		bat->serial[i * 2 + 0] =3D (ret >> 0) & 0xff;
> >> +		bat->serial[i * 2 + 1] =3D (ret >> 8) & 0xff;
> >> +	}
> >> +	a500_ec_unlock(bat->ec_chip);
> >> +done:
> >> +	val->strval =3D bat->serial;
> >> +
> >> +	return ret;
> >> +}
> >=20
> > If battery is swapped, this will keep the old serial.
>=20
> Hello, Sebastian! The battery isn't hot-swappable on A500, but it also
> should be okay to always re-read the serialno. I'll consider removing
> the caching in the v2, thanks.

I assumed it would be hot-swappable because of a500_battery_get_presence().
If it's not hot-swappable, the caching is fine.

-- Sebastian

--rq3bkynnovf3rl57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9EM20ACgkQ2O7X88g7
+prI2BAAn2AN5O1hII/9SN9g6Y9PKVjcObQgTSKI9W8g16d0g+g6swLv4SOI5w+1
gYt3Zi3X8uRK1kc92X2ZXQBdtacuqfArU+nK6fpwLfC13spffvpob9bBtNWMT0s1
6tdpQ7yJtrRfTdIr+cVCrM6rj3Cp06gcd2+xF5+zpenaZZScR5g/bF9X05RYoplZ
G9Nvjhwm6Rvm6O4XvzuNwDON4CGa0RG94th2W07FkGTrkob4FTJJ0bKgI/vtodAB
gIkrcSaC4qcW5tkeZzt0iq+Fj5Ztm5aTH7voZ/AfBrCznMVgO9JjOnEH+ecRWexQ
XcXrCT8z+FKUHIG+oUkM0WkqfaaOqB5NeeghwOnOCf41V1JVJIcm9GOTM7i1J8yF
wwmY3aa8k3shIN6UfG7DqdW8DziqmS8vjHcdaprLCDjLfmJagWnSmYuU+3I2adsA
ayydD8AJxGFIHPzUW0svjTCfSOHQPm2hM1U4Anye73WByf3zxGcSWTKMWCNYoLal
COLYxVJIDNq2lkaHtme/7z0i84dnHzXvsrsUMJ4SXhCKYH0YQp8CzbkkXglgYtYe
DjZptysEJL3RZPmQa0ft0J75oLvQ+VwrIEtPRWID7dry6i8RONP4SI5L6LxiQBYe
fz/4qbyvmu/HQ/8nJsvYUMwFjmG/EVzN0cQGHuSxknM0H6Mq0+g=
=pUMB
-----END PGP SIGNATURE-----

--rq3bkynnovf3rl57--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A6DD6B42
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 23:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfJNV0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 17:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731287AbfJNV0s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 17:26:48 -0400
Received: from earth.universe (eth-west-pareq2-46-193-2-41.wb.wifirst.net [46.193.2.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B6421835;
        Mon, 14 Oct 2019 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571088406;
        bh=7/AhaNPDgZNvkvT9YnXKUPXg5QzFw/154jC621nlWIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ppow9DQRFn59PClKLaF2tKdukIKa7mNcHJFkz75VZEgoXxMV2ywgCAb+g25Wa982Z
         eb4M13ZdtLHYLVnWeNoyPVXAeCPiiRZ4quWQnGn/yZqZVl2mJgsptxJd/XKiMvwD7o
         nVDmmhkO0Tn90TY+966TmJNRqNQdNi4KBGviPenE=
Received: by earth.universe (Postfix, from userid 1000)
        id A96633C0CA6; Mon, 14 Oct 2019 07:46:21 +0200 (CEST)
Date:   Mon, 14 Oct 2019 07:46:21 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     lecopzer@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yj.chiang@mediatek.com, lecopzer.chen@mediatek.com
Subject: Re: [PATCH v2 1/2] test_power: Add CHARGE_COUNTER properties
Message-ID: <20191014054621.lopb7keyo7iej567@earth.universe>
References: <20190912182600.24211-1-lecopzer.chen@mediatek.com>
 <20190912182600.24211-2-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2covrf7b6w7z3ql"
Content-Disposition: inline
In-Reply-To: <20190912182600.24211-2-lecopzer.chen@mediatek.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p2covrf7b6w7z3ql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 13, 2019 at 02:25:59AM +0800, lecopzer@gmail.com wrote:
> CHARGE_COUNTER is really general in other power supply drivers and
> Android also has an interface to monitor CHARGE_COUNTER, so let's
> add it into test framework.
>=20
> Set default as -1000 is because the default status is
> POWER_SUPPLY_STATUS_DISCHARGING, which means the counter should be
> negative, and 1000 means not zero but small enough.
>=20
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/test_power.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index c3cad2b6daba..70db8d20e138 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -33,6 +33,7 @@ static int battery_present		=3D 1; /* true */
>  static int battery_technology		=3D POWER_SUPPLY_TECHNOLOGY_LION;
>  static int battery_capacity		=3D 50;
>  static int battery_voltage		=3D 3300;
> +static int battery_charge_counter	=3D -1000;
> =20
>  static bool module_initialized;
> =20
> @@ -100,6 +101,9 @@ static int test_power_get_battery_property(struct pow=
er_supply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
>  		val->intval =3D battery_capacity;
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
> +		val->intval =3D battery_charge_counter;
> +		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		val->intval =3D 100;
> @@ -135,6 +139,7 @@ static enum power_supply_property test_power_battery_=
props[] =3D {
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
>  	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> @@ -447,6 +452,21 @@ static int param_set_battery_voltage(const char *key,
> =20
>  #define param_get_battery_voltage param_get_int
> =20
> +static int param_set_battery_charge_counter(const char *key,
> +					const struct kernel_param *kp)
> +{
> +	int tmp;
> +
> +	if (1 !=3D sscanf(key, "%d", &tmp))
> +		return -EINVAL;
> +
> +	battery_charge_counter =3D tmp;
> +	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
> +	return 0;
> +}
> +
> +#define param_get_battery_charge_counter param_get_int
> +
>  static const struct kernel_param_ops param_ops_ac_online =3D {
>  	.set =3D param_set_ac_online,
>  	.get =3D param_get_ac_online,
> @@ -487,6 +507,11 @@ static const struct kernel_param_ops param_ops_batte=
ry_voltage =3D {
>  	.get =3D param_get_battery_voltage,
>  };
> =20
> +static const struct kernel_param_ops param_ops_battery_charge_counter =
=3D {
> +	.set =3D param_set_battery_charge_counter,
> +	.get =3D param_get_battery_charge_counter,
> +};
> +
>  #define param_check_ac_online(name, p) __param_check(name, p, void);
>  #define param_check_usb_online(name, p) __param_check(name, p, void);
>  #define param_check_battery_status(name, p) __param_check(name, p, void);
> @@ -495,6 +520,7 @@ static const struct kernel_param_ops param_ops_batter=
y_voltage =3D {
>  #define param_check_battery_health(name, p) __param_check(name, p, void);
>  #define param_check_battery_capacity(name, p) __param_check(name, p, voi=
d);
>  #define param_check_battery_voltage(name, p) __param_check(name, p, void=
);
> +#define param_check_battery_charge_counter(name, p) __param_check(name, =
p, void);
> =20
> =20
>  module_param(ac_online, ac_online, 0644);
> @@ -525,6 +551,10 @@ MODULE_PARM_DESC(battery_capacity, "battery capacity=
 (percentage)");
>  module_param(battery_voltage, battery_voltage, 0644);
>  MODULE_PARM_DESC(battery_voltage, "battery voltage (millivolts)");
> =20
> +module_param(battery_charge_counter, battery_charge_counter, 0644);
> +MODULE_PARM_DESC(battery_charge_counter,
> +	"battery charge counter (microampere-hours)");
> +
>  MODULE_DESCRIPTION("Power supply driver for testing");
>  MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
>  MODULE_LICENSE("GPL");
> --=20
> 2.17.1
>=20

--p2covrf7b6w7z3ql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2kC6oACgkQ2O7X88g7
+poV6w/9EMKb8RCHrFqH+t3GCtmpFqNB86zAFTLRWIBp+Y7FbJoDICMP0zhoRUU0
qCTYu2hoNJoUMuA+zCVfqAhtJ6eSzNxemp16a2T+3gQ1a+gms5E9jD7AhYVTK2ow
694D94vaqLzZVJ4ZaPglNcSpMXrQItTTt+0U9z1K7e0ml1b4VwXOgMpUktzav4Jy
uHFUlhtA+hdtfef2Hck1hr+4UJh4QZ6MA39R1j7er7QuD2ygCw+I2fFh6QLoHen5
88zHKhGZZzrGOki7h/Vhj5uJBGZ0mgF8Y6OWeaPBNDJGdNC3NE+UPLlYGU3aKNE1
HAWUrZ0fcVqqKitW1GNrTEuuJA28kEbqAKQVlN+thD328hbS0Q7Uo4OR6FqW9x/q
sJRrP2F6igwvqXjoT2OP97Y5oRQP0C2TnGMXXCF6S4vElv08m7QY3fUTWx4hFgi+
aSZvTfxuBPbvFfGtNAdRRlWCzkTuvTlBuzbmFoTd8Kof/+3EZ8JYTc7smGLfbUeq
gLgeOaVZyrylsYo++ZKFhmV4psyjFVzVvJrKynyfK7ytoCYX9F9Ymk6/p2WaEKsU
+izHwa7/UGhTpLJjQfzb6NRAtXbmBdAK3TUhK/JwOLnTb1d3XD3U7kbMJZpXXshg
JjOaO58qmDLJvSrxsZJjNfGmdei+02Q2h8m++uBIBuRXtUqUVbs=
=HD4T
-----END PGP SIGNATURE-----

--p2covrf7b6w7z3ql--

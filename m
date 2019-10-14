Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02816D6B3A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfJNV0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 17:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730823AbfJNV0s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 17:26:48 -0400
Received: from earth.universe (eth-west-pareq2-46-193-2-41.wb.wifirst.net [46.193.2.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B40312067B;
        Mon, 14 Oct 2019 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571088406;
        bh=+KgQJOXU7urgB72CYh2W8EVuBlhYXZcyO6nz2vNzloQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zFyNm3I/Crp/zzW6NZoOZVILPbYpW29GiOPdC9tSS5lRFEJyYQROLLOVShsCul5pt
         wknAjJI8ZXVuvjI7DhWc72ZyCf2WwOAwQgfyIepqs6iDbJrfO1G9daRQRdYsWoFkMf
         k903R6AbCcCEPNrn5z/Ah8hVYnWNJK6TQaPM9OvQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 9791C3C0CA7; Mon, 14 Oct 2019 07:46:35 +0200 (CEST)
Date:   Mon, 14 Oct 2019 07:46:35 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     lecopzer@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yj.chiang@mediatek.com, lecopzer.chen@mediatek.com
Subject: Re: [PATCH v2 2/2] test_power: Add CURRENT properties
Message-ID: <20191014054635.a5h5jyuefxqpderp@earth.universe>
References: <20190912182600.24211-1-lecopzer.chen@mediatek.com>
 <20190912182600.24211-3-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsj4wc5oafdhapfr"
Content-Disposition: inline
In-Reply-To: <20190912182600.24211-3-lecopzer.chen@mediatek.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tsj4wc5oafdhapfr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 13, 2019 at 02:26:00AM +0800, lecopzer@gmail.com wrote:
> CURRENT is really general in other battery drivers,
> Android also has an interface to monitor CURRENT, so let's
> add it into test framework.
>=20
> The default value (1.6A) is just a random but reasonable value.
>=20
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/test_power.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 70db8d20e138..65c23ef6408d 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -34,6 +34,7 @@ static int battery_technology		=3D POWER_SUPPLY_TECHNOL=
OGY_LION;
>  static int battery_capacity		=3D 50;
>  static int battery_voltage		=3D 3300;
>  static int battery_charge_counter	=3D -1000;
> +static int battery_current		=3D 1600;
> =20
>  static bool module_initialized;
> =20
> @@ -118,6 +119,10 @@ static int test_power_get_battery_property(struct po=
wer_supply *psy,
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  		val->intval =3D battery_voltage;
>  		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval =3D battery_current;
> +		break;
>  	default:
>  		pr_info("%s: some properties deliberately report errors.\n",
>  			__func__);
> @@ -149,6 +154,8 @@ static enum power_supply_property test_power_battery_=
props[] =3D {
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>  	POWER_SUPPLY_PROP_TEMP,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
>  };
> =20
>  static char *test_power_ac_supplied_to[] =3D {
> @@ -467,6 +474,21 @@ static int param_set_battery_charge_counter(const ch=
ar *key,
> =20
>  #define param_get_battery_charge_counter param_get_int
> =20
> +static int param_set_battery_current(const char *key,
> +					const struct kernel_param *kp)
> +{
> +	int tmp;
> +
> +	if (1 !=3D sscanf(key, "%d", &tmp))
> +		return -EINVAL;
> +
> +	battery_current =3D tmp;
> +	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
> +	return 0;
> +}
> +
> +#define param_get_battery_current param_get_int
> +
>  static const struct kernel_param_ops param_ops_ac_online =3D {
>  	.set =3D param_set_ac_online,
>  	.get =3D param_get_ac_online,
> @@ -512,6 +534,11 @@ static const struct kernel_param_ops param_ops_batte=
ry_charge_counter =3D {
>  	.get =3D param_get_battery_charge_counter,
>  };
> =20
> +static const struct kernel_param_ops param_ops_battery_current =3D {
> +	.set =3D param_set_battery_current,
> +	.get =3D param_get_battery_current,
> +};
> +
>  #define param_check_ac_online(name, p) __param_check(name, p, void);
>  #define param_check_usb_online(name, p) __param_check(name, p, void);
>  #define param_check_battery_status(name, p) __param_check(name, p, void);
> @@ -521,6 +548,7 @@ static const struct kernel_param_ops param_ops_batter=
y_charge_counter =3D {
>  #define param_check_battery_capacity(name, p) __param_check(name, p, voi=
d);
>  #define param_check_battery_voltage(name, p) __param_check(name, p, void=
);
>  #define param_check_battery_charge_counter(name, p) __param_check(name, =
p, void);
> +#define param_check_battery_current(name, p) __param_check(name, p, void=
);
> =20
> =20
>  module_param(ac_online, ac_online, 0644);
> @@ -555,6 +583,9 @@ module_param(battery_charge_counter, battery_charge_c=
ounter, 0644);
>  MODULE_PARM_DESC(battery_charge_counter,
>  	"battery charge counter (microampere-hours)");
> =20
> +module_param(battery_current, battery_current, 0644);
> +MODULE_PARM_DESC(battery_current, "battery current (milliampere)");
> +
>  MODULE_DESCRIPTION("Power supply driver for testing");
>  MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
>  MODULE_LICENSE("GPL");
> --=20
> 2.17.1
>=20

--tsj4wc5oafdhapfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2kC7sACgkQ2O7X88g7
+poarA//S/InhPqISwJjDMvHrhrHAKC8/GjEzggsBixhDbnnj7SKrkmJJ15908TZ
gFhMTzplv0eiJu4BBFexS2ogAxBQ+O5b5672Jw0nXwv+vJU/l2NasVIHE5b5wl0l
+bboYa4gcrEAVVweKv5fbUz7vRhqQB6U6xmUkkFWaXYNAm5lNUt/m6aCYlVhM8a9
k2kD/j+WWVlXzi8rf8GFbDyTgMH/+FBI+77sPQgc2sBiSF0KVWz8i1U5SW0RHYlN
eOzKX6BsX/B9uqMILPWOX2IhPVFvoiImFgS2JeZzGxotHdG7fYoJwQ77g2M8KvJV
8IieFzt8otiYEFVzAMrKmxXN8DizalrQ0wzb5G0jkKyaTwIUEaOxugtXQYToI5Ol
XHLWXPOaUUN47VAZRmvB+Zsl2LP4LKVSrFVFNsEQbHhnyr3wzsA38CCFc8jKRQa1
4AmZBQBeCD0RBDpgVabeh70pcZ9fn44sDkIuxdxs6euSmcjyspT16MbTbScLCe/R
ftoPKnIvXpQw+eHPctDDDTvH4bhZ7qpoZLEWfpSM8am0F87zCtllxdZP0EyUJGAr
xJ+ir9I2kK8W6kc3nkdiZWdzSr/s09sUeDZUbhLPIiHyJ+zYQJHuPe60/KbaeCbl
GXAR3GyJsmaHaB74Ulj5VssiFolcKfnkm+rjdx99cjFwBE2RPfw=
=yx3M
-----END PGP SIGNATURE-----

--tsj4wc5oafdhapfr--

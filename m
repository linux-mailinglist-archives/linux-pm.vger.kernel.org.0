Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92B55B51
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFYWfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 18:35:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59902 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYWfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 18:35:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E0BD7260A4C
Received: by earth.universe (Postfix, from userid 1000)
        id C0DCE3C08D5; Wed, 26 Jun 2019 00:35:37 +0200 (CEST)
Date:   Wed, 26 Jun 2019 00:35:37 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, yj.chiang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] test_power: Add CURRENT and CHARGE_COUNTER properties
Message-ID: <20190625223537.6dlcooifqfs2rv2b@earth.universe>
References: <1557828298-16591-1-git-send-email-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i4lf3yrmw6f6ubgm"
Content-Disposition: inline
In-Reply-To: <1557828298-16591-1-git-send-email-lecopzer.chen@mediatek.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--i4lf3yrmw6f6ubgm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 14, 2019 at 06:04:58PM +0800, Lecopzer Chen wrote:
> From: "Lecopzer Chen" <lecopzer.chen@mediatek.com>
>=20
> Emulate battery current (variable) and battery CHARGE_COUNTER
> (same as battery_capacity) properties.
>=20
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Cc: YJ Chiang <yj.chiang@mediatek.com>

Thanks for the patch and thanks for taking care of testing infrastructure.
I don't think it's a good idea to use CHARGE_CAPACITY/CHARGE_NOW also for
CHARGE_COUNTER. CHARGE_COUNTER may be negative, but capacity should not be
negative. Also the patch should be splitted (one for the current feature and
one for the charge counter feature). Last but not least I don't see any
conversion from mA to =B5A. The userspace sysfs ABI should always
return =B5A.

-- Sebastian

> ---
>  drivers/power/supply/test_power.c | 33 +++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 57246cdbd042..9f85060c84de 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -36,6 +36,7 @@ static int battery_present		=3D 1; /* true */
>  static int battery_technology		=3D POWER_SUPPLY_TECHNOLOGY_LION;
>  static int battery_capacity		=3D 50;
>  static int battery_voltage		=3D 3300;
> +static int battery_current		=3D 1600;
> =20
>  static bool module_initialized;
> =20
> @@ -101,6 +102,7 @@ static int test_power_get_battery_property(struct pow=
er_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		val->intval =3D battery_capacity;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> @@ -117,6 +119,10 @@ static int test_power_get_battery_property(struct po=
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
> @@ -138,6 +144,7 @@ static enum power_supply_property test_power_battery_=
props[] =3D {
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
>  	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> @@ -147,6 +154,8 @@ static enum power_supply_property test_power_battery_=
props[] =3D {
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>  	POWER_SUPPLY_PROP_TEMP,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
>  };
> =20
>  static char *test_power_ac_supplied_to[] =3D {
> @@ -450,6 +459,21 @@ static int param_set_battery_voltage(const char *key,
> =20
>  #define param_get_battery_voltage param_get_int
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
> @@ -490,6 +514,11 @@ static const struct kernel_param_ops param_ops_batte=
ry_voltage =3D {
>  	.get =3D param_get_battery_voltage,
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
> @@ -498,6 +527,7 @@ static const struct kernel_param_ops param_ops_batter=
y_voltage =3D {
>  #define param_check_battery_health(name, p) __param_check(name, p, void);
>  #define param_check_battery_capacity(name, p) __param_check(name, p, voi=
d);
>  #define param_check_battery_voltage(name, p) __param_check(name, p, void=
);
> +#define param_check_battery_current(name, p) __param_check(name, p, void=
);
> =20
> =20
>  module_param(ac_online, ac_online, 0644);
> @@ -528,6 +558,9 @@ MODULE_PARM_DESC(battery_capacity, "battery capacity =
(percentage)");
>  module_param(battery_voltage, battery_voltage, 0644);
>  MODULE_PARM_DESC(battery_voltage, "battery voltage (millivolts)");
> =20
> +module_param(battery_current, battery_current, 0644);
> +MODULE_PARM_DESC(battery_current, "battery current (milliampere)");
> +
>  MODULE_DESCRIPTION("Power supply driver for testing");
>  MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
>  MODULE_LICENSE("GPL");
> --=20
> 2.18.0
>=20

--i4lf3yrmw6f6ubgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0SobYACgkQ2O7X88g7
+ppFxg/+KogtQlbL0EWEB9FBygjBTSsXfwoCrx39eIEIqGF9f/CIdn1k/2hI7OKk
2yAYtdIhTJhUgwsjrjscsa7MJ5DnUHVHtzzG+yFGsTx2/86lEBryZ2eiTmCWIgj1
Re12yKd6RN5eUouaqqnIZbilmTWbGQhvEAadB+rygUSfW3bI4f9tvZej1CONx0WV
TSGfLD/XXcNBZgusXWsH6bslKGeV3YkRLZlc3tZAcW+mNhtMDfJbSJhZB1J5kKT1
UZspF6sYr3PMaN7A10bqr0mFeFqd4V/RpFXReQoFO4+EPbS43KyPOFM63LdCeKXV
YgdrGCndTraSbObv1RMQYpe5z3z2CBM9Uxok9zSNNMdxl+o6OAbHbKUTBRdWkCIV
xo6frnnuFCH+Lj0KgXmcePwNaFC5svn8c6/uVv7hMs6g0afICw+ojOne/yf+jsTr
iMfsEwLoR4+hwROrdzqId5LhgPY6INdpQXxNLIy8aAx4e73xSoct5DchamGtCaDl
MVsCVbntiXjJfNgEI6rpVJrsRsHGBh0Ls0xHJhiT/pZpI3ci3D5eDGKLLKOshBGt
k3BKxOkJc4frIf2iBgvy4XkP1ITvI1hiuX9WA6JYMSO0BE+tl1Feu8MFJPH4Hmbt
jA6XHIS8Sw8G+PeO7rX5+CHuzUfCehxKc/rppLZck5eGl5Q6WnY=
=0+K2
-----END PGP SIGNATURE-----

--i4lf3yrmw6f6ubgm--

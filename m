Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8578F1BE63B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2S2c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2S2c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 14:28:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5CAC03C1AE;
        Wed, 29 Apr 2020 11:28:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DECFE2A223C
Received: by earth.universe (Postfix, from userid 1000)
        id 3D4783C08C6; Wed, 29 Apr 2020 20:28:28 +0200 (CEST)
Date:   Wed, 29 Apr 2020 20:28:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max17042_battery: Add support for the
 TTE_NOW prop
Message-ID: <20200429182828.xgqltubijz7y6wei@earth.universe>
References: <20200330053352.GA28178@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t2ax7cucttldjspz"
Content-Disposition: inline
In-Reply-To: <20200330053352.GA28178@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--t2ax7cucttldjspz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 30, 2020 at 01:33:55AM -0400, Geordan Neukum wrote:
> The max170{42,47,50,55} family of fuel gauges all provide time-to-empty
> estimation. As such, let's export this as a property.
>=20
> Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 69ec4295d55d..f284547913d6 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -87,6 +87,7 @@ static enum power_supply_property max17042_battery_prop=
s[] =3D {
>  	POWER_SUPPLY_PROP_SCOPE,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
>  };
>=20
>  static int max17042_get_temperature(struct max17042_chip *chip, int *tem=
p)
> @@ -411,6 +412,13 @@ static int max17042_get_property(struct power_supply=
 *psy,
>  			return -EINVAL;
>  		}
>  		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> +		ret =3D regmap_read(map, MAX17042_TTE, &data);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D data * 5625 / 1000;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> --
> 2.18.1
>=20

--t2ax7cucttldjspz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6px0cACgkQ2O7X88g7
+poMqw/9Esv66ea/NvgO4QzIQAsMYGE/irM6QqbHQrmAOPWacir96tsG1Hq4XxXS
1hoGb3LxtYTBUBws6I+UdLHM4RpuYVEw4pstk97WHpBddNZRRCWjvdzR+8YnFVjR
bgdkXjYBaE3zE+fV5HogTOFR7l1YR8JSXLjIep+U9bSMoCUWoZvoVrZvpuNkVcMI
kxBWyZj1lmE0HF7K66eW+ydaDRHbzkBnbWxPsfeWcbxKQmi8+DeTTLSN02P8o3r6
mlgMEOA/MoQP8OI7VRTnfSDbsagF8njkkvZOXJCU1Vm67tGvbOgfpAaH9Wclixlg
ODe1fWGnChDzbhHECrTazj73TmsNCCxRMAcQspOWm4akRqNK2bCX3oUWGcAeAaeX
BOZZ/ai4Hy8iULmnsRQwVJOBi1dfdK78IwU8u1kF4/TPzVo6vBeB5h/z7C00mte6
bHDBbeM59Adg//KNlutkuFghIDj+rKdFQY8bd0MV25fTXOAowRm3r1VkGaNM4ptm
zBm1nmorWlUNzbsz/PTXXFRNcfPlgbFuYJMpZCIncQe4DRpR/LVOc8rxlBErKE/0
L9R1wK6YViWsnO6Q7yCaFd2jQssSudah6nd+5IZ3MZTZE5iSxEe81Bwv1tQWewzb
LMMXDjS6LsDO74t5X/vvZbob19ZZPpXp40yIVXQ0S1rraT0Azi4=
=nyOD
-----END PGP SIGNATURE-----

--t2ax7cucttldjspz--

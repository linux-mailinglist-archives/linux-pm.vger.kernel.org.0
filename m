Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902A53CC469
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGQQXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 12:23:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGQQXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 12:23:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 890A01F43463
Received: by earth.universe (Postfix, from userid 1000)
        id 03D273C0C97; Sat, 17 Jul 2021 18:20:07 +0200 (CEST)
Date:   Sat, 17 Jul 2021 18:20:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 08/12] power: supply: smb347-charger: Remove caching
 of charger state
Message-ID: <20210717162006.66cqkbw2mertd6tr@earth.universe>
References: <20210717121112.3248-1-digetx@gmail.com>
 <20210717121112.3248-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgyf46uz57z2zrjo"
Content-Disposition: inline
In-Reply-To: <20210717121112.3248-9-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dgyf46uz57z2zrjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 17, 2021 at 03:11:08PM +0300, Dmitry Osipenko wrote:
> Regmap already provides us with the caching, so remove caching of charger
> state to make code cleaner.

cache_type is not initialized in smb347's regmap config and thus
set to 0 =3D REGCACHE_NONE:

static const struct regmap_config smb347_regmap =3D {
	.reg_bits	=3D 8,
	.val_bits	=3D 8,
	.max_register	=3D SMB347_MAX_REGISTER,
	.volatile_reg	=3D smb347_volatile_reg,
	.readable_reg	=3D smb347_readable_reg,
};

-- Sebastian


> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/power/supply/smb347-charger.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index db1378b41f80..f81c60c679a0 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -135,7 +135,6 @@
>   * @id: SMB charger ID
>   * @mains_online: is AC/DC input connected
>   * @usb_online: is USB input connected
> - * @charging_enabled: is charging enabled
>   * @irq_unsupported: is interrupt unsupported by SMB hardware
>   * @max_charge_current: maximum current (in uA) the battery can be charg=
ed
>   * @max_charge_voltage: maximum voltage (in uV) the battery can be charg=
ed
> @@ -192,7 +191,6 @@ struct smb347_charger {
>  	unsigned int		id;
>  	bool			mains_online;
>  	bool			usb_online;
> -	bool			charging_enabled;
>  	bool			irq_unsupported;
> =20
>  	unsigned int		max_charge_current;
> @@ -358,21 +356,13 @@ static int smb347_charging_status(struct smb347_cha=
rger *smb)
> =20
>  static int smb347_charging_set(struct smb347_charger *smb, bool enable)
>  {
> -	int ret =3D 0;
> -
>  	if (smb->enable_control !=3D SMB3XX_CHG_ENABLE_SW) {
>  		dev_dbg(smb->dev, "charging enable/disable in SW disabled\n");
>  		return 0;
>  	}
> =20
> -	if (smb->charging_enabled !=3D enable) {
> -		ret =3D regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
> -					 enable ? CMD_A_CHG_ENABLED : 0);
> -		if (!ret)
> -			smb->charging_enabled =3D enable;
> -	}
> -
> -	return ret;
> +	return regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
> +				  enable ? CMD_A_CHG_ENABLED : 0);
>  }
> =20
>  static inline int smb347_charging_enable(struct smb347_charger *smb)
> --=20
> 2.32.0
>=20

--dgyf46uz57z2zrjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDzAzIACgkQ2O7X88g7
+pquQw//T9rvYylRZXTm+X6TbARMLX/jnUii6FLPGAAb5Xs/ROMpqOqzUuK5v9JL
iOs1r2DNcK1OzdDEPLwh2OA5FHoihxx+K/ZMLm0aAJZNXmTbmysa0UcdFWrRgtrV
CZ41kuCa3VOJWBexZt+MZ1vXjIOi1T4CGfbhoGnFggv+jEHF/k6+XncDSFCw/HDn
PiZm5TklYUEQPkcJPhGBxQra1UNjTGOg6XQ4rIfgKQG/TyTdEv2/MAPsHLk9KC5N
6NgGxBRcvDgb+BLmJ4d5j4FLebnSIJaRaRSN5rojjdIIG72mwtSbeyq/URs5ucKU
ejDWI/nag9xwPPU+l+LFc7sYiUuEnWameuuzbex1kpa4/uWDX9QRvnPZpZWhTAfC
8Ki+Sg4BkVIxvyosRmKUBccAfPNrs6TPPfpjgbiHjvrYkk2ZS5aJ1/vZeW94vDuw
rph+KJQ5yHIjwdXnbx6i+zjjwAphdqOUpFqc+KeOyrGp8Q0Re4RVRs+wxd6pEdCo
+FapgItIggnp8FGvfOwSIqEC2Hhz/wOFLKlKudhbKdESeAqXf/VxqP6Tf1mESP9Y
vQDYcglbuiU5bAiWO6bmEPOvPa4IYYBf5oAxhDe/fR9fGM/JrZenFpavcsVHAQV7
bRiHd5YeHAmORHxxvb3iB/U0jKwFdKnYE+PJOrfbcWtViktV4gY=
=9ZX5
-----END PGP SIGNATURE-----

--dgyf46uz57z2zrjo--

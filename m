Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3493E30C3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhHFVOG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238715AbhHFVOD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 17:14:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4862A61186;
        Fri,  6 Aug 2021 21:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628284427;
        bh=SytdQxth9CJJUgSJWz+l+8KZpRLKCpTEvxUpLGTP2iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=linh2w8S4m5FvQPqCk/LGHdKeiP6HI5IHnDSbqknS1pObzcDK0a1ekS1w/3L4BlOi
         8Gezu+VVJPKwlWr2M06EkHVWXf5gr0wN1nSb8CYFvInPzPvacyZjDw6xekEfKCeinX
         HWODpwRd6ICL/c0dvyTntai4JUkF49hd1TK3MSumaNrPnxk4eCKKKnHncwNeOXYW2l
         SVCG1MDL7H2JQhCozSg4xIfzlTZpPReVHhfiy6+oth0qo0KGYb5q/rFqogE2gEPlj1
         AmEIt3F3KTC8vMbDADpubMa2e6XxRqZXTurGSrKPidoGXwC0OM5PGEwSpVOYWtKnnq
         8kqLcW5EDtXXQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 9F85E3C0C99; Fri,  6 Aug 2021 23:13:45 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:13:45 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 07/12] power: supply: smb347-charger: Utilize generic
 regmap caching
Message-ID: <20210806211345.drecxf76bc6mhzmw@earth.universe>
References: <20210731173842.19643-1-digetx@gmail.com>
 <20210731173842.19643-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bjxp4r5bbky4twa6"
Content-Disposition: inline
In-Reply-To: <20210731173842.19643-8-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bjxp4r5bbky4twa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 31, 2021 at 08:38:37PM +0300, Dmitry Osipenko wrote:
> Utilize generic regmap caching in order to avoid unnecessary slow I2C
> accesses to all constant registers each time the supply status updated
> and remove local caching of charger state to make code cleaner.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index db1378b41f80..27254e6efdde 100644
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
> @@ -1310,6 +1300,8 @@ static const struct regmap_config smb347_regmap =3D=
 {
>  	.max_register	=3D SMB347_MAX_REGISTER,
>  	.volatile_reg	=3D smb347_volatile_reg,
>  	.readable_reg	=3D smb347_readable_reg,
> +	.cache_type	=3D REGCACHE_FLAT,
> +	.num_reg_defaults_raw =3D SMB347_MAX_REGISTER,
>  };
> =20
>  static const struct power_supply_desc smb347_mains_desc =3D {
> --=20
> 2.32.0
>=20

--bjxp4r5bbky4twa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENpgkACgkQ2O7X88g7
+pqOsBAAioDKuQX3GL++jaA5XsqRe6XxpAZKEQX+sTxLjejawelozfttPPz4ij6x
0i9i6YvFIk9/G4BacSK8hfdtME382SEk3v2JFdgB1Ol/HrL8Rg5oqMmdgreqTpC7
xDgOksvLHduAz6f8MHyZ+I72FC+++5D/lT71t7TQA47/Fu/GTeUO6Z5KXX9KWpP7
oDWvEROUU72gvgUoQWwWqFjiFwz/h0dVaCMZCTH0SIAPclJakvOwjv1FQWJpBjWF
TJAU7uf8TxVV1fUvITZrKBG/Fk/rKBEKz+k+8poqY6QleKjWbZH3aS5+yq+ypzJF
vUO2AIH9aDDCWZMfJCv0bPmDQTVim+TUZiJS/5eSTyrsC/lJkZQbTyB0ZmfEv6Ep
wr6wCrSe0YHBXl1++OJznztDrpbMFR+WyJmeramadcCVPkuVmadobSsIYPaAHeuy
IzGKdr1nervM55F5Os62K5CAtE3LkjgrYk+0bqp2KMpERBPgzpL2mA14vpzf+xtZ
Y+xqdRFzwTHRY844pto94f/ZD3rJUqgFR4PkSt07PITC2jvRUWauUCsBYy5EFkhU
l2PHKLKW+3/awRzAMsplTnra0EPIuTX2X+mqRteHcJBUVq0KZWCvgNXiZWF//1wH
fG8ED+08rBaX3DkkfSTvEYx7PjMvLKHxH4xYdEpySj3pjd0cF8g=
=bbW6
-----END PGP SIGNATURE-----

--bjxp4r5bbky4twa6--

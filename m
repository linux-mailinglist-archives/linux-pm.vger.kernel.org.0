Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267DC3E30BE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbhHFVNv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238752AbhHFVNv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 17:13:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 220CE61167;
        Fri,  6 Aug 2021 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628284415;
        bh=yMRPt3saPi8S81aQz2c5eMAKh9QI7iGIwFAFLF4dDnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9ZRP/6bYE4HzAURJbEXA1movcCRpT6zYxM2xk26gV2Ymho+XEdtIo/QobMIXRotM
         PviZ+bsO8rQ76mfE3dDTWO5UXsNON5KIrUQ9QnGcxuF3i+yCdceWGiOlpRkfudQM0K
         IBeOwfzIf1YREPG475ElTpDiqD5iGAqi2xFP/kgqEEoRMwZl/UvVxT++cn+WmlSW80
         hCfGPzbgbke9EWWnJrbjFP57bRai1tBIrf+Bm4ViwKm1O9DyFaGCXJAHPH6lwVcFek
         H8E4ayfqgvit8ODrsVwesj+lNK3NUh97meSKnTSxizI22AcjoE+oKltM3v+f9GeGJm
         6YXOCCZj9tOpA==
Received: by earth.universe (Postfix, from userid 1000)
        id 78DFE3C0C99; Fri,  6 Aug 2021 23:13:33 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:13:33 +0200
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
Subject: Re: [PATCH v6 06/12] power: supply: smb347-charger: Make
 smb347_set_writable() IRQ-safe
Message-ID: <20210806211333.uylwmagnoas3lyl2@earth.universe>
References: <20210731173842.19643-1-digetx@gmail.com>
 <20210731173842.19643-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mwikk6n67qm3qst4"
Content-Disposition: inline
In-Reply-To: <20210731173842.19643-7-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mwikk6n67qm3qst4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 31, 2021 at 08:38:36PM +0300, Dmitry Osipenko wrote:
> The smb347_set_writable() is used by interrupt handler and outside of it.
> The interrupt should be disabled when the function is used outside of
> interrupt handler in order to prevent racing with the interrupt context.
> Add new parameter to smb347_set_writable() that allows to disable IRQ.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 30 +++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index df240420f2de..db1378b41f80 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -671,10 +671,22 @@ static int smb347_set_temp_limits(struct smb347_cha=
rger *smb)
>   *
>   * Returns %0 on success and negative errno in case of failure.
>   */
> -static int smb347_set_writable(struct smb347_charger *smb, bool writable)
> +static int smb347_set_writable(struct smb347_charger *smb, bool writable,
> +			       bool irq_toggle)
>  {
> -	return regmap_update_bits(smb->regmap, CMD_A, CMD_A_ALLOW_WRITE,
> -				  writable ? CMD_A_ALLOW_WRITE : 0);
> +	struct i2c_client *client =3D to_i2c_client(smb->dev);
> +	int ret;
> +
> +	if (writable && irq_toggle && !smb->irq_unsupported)
> +		disable_irq(client->irq);
> +
> +	ret =3D regmap_update_bits(smb->regmap, CMD_A, CMD_A_ALLOW_WRITE,
> +				 writable ? CMD_A_ALLOW_WRITE : 0);
> +
> +	if ((!writable || ret) && irq_toggle && !smb->irq_unsupported)
> +		enable_irq(client->irq);
> +
> +	return ret;
>  }
> =20
>  static int smb347_hw_init(struct smb347_charger *smb)
> @@ -682,7 +694,7 @@ static int smb347_hw_init(struct smb347_charger *smb)
>  	unsigned int val;
>  	int ret;
> =20
> -	ret =3D smb347_set_writable(smb, true);
> +	ret =3D smb347_set_writable(smb, true, false);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -758,7 +770,7 @@ static int smb347_hw_init(struct smb347_charger *smb)
>  	ret =3D smb347_start_stop_charging(smb);
> =20
>  fail:
> -	smb347_set_writable(smb, false);
> +	smb347_set_writable(smb, false, false);
>  	return ret;
>  }
> =20
> @@ -866,7 +878,7 @@ static int smb347_irq_set(struct smb347_charger *smb,=
 bool enable)
>  	if (smb->irq_unsupported)
>  		return 0;
> =20
> -	ret =3D smb347_set_writable(smb, true);
> +	ret =3D smb347_set_writable(smb, true, true);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -891,7 +903,7 @@ static int smb347_irq_set(struct smb347_charger *smb,=
 bool enable)
>  	ret =3D regmap_update_bits(smb->regmap, CFG_PIN, CFG_PIN_EN_CHARGER_ERR=
OR,
>  				 enable ? CFG_PIN_EN_CHARGER_ERROR : 0);
>  fail:
> -	smb347_set_writable(smb, false);
> +	smb347_set_writable(smb, false, true);
>  	return ret;
>  }
> =20
> @@ -919,7 +931,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
>  	if (!client->irq)
>  		return 0;
> =20
> -	ret =3D smb347_set_writable(smb, true);
> +	ret =3D smb347_set_writable(smb, true, false);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -931,7 +943,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
>  				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
>  				 CFG_STAT_DISABLED);
> =20
> -	smb347_set_writable(smb, false);
> +	smb347_set_writable(smb, false, false);
> =20
>  	if (ret < 0) {
>  		dev_warn(smb->dev, "failed to initialize IRQ: %d\n", ret);
> --=20
> 2.32.0
>=20

--mwikk6n67qm3qst4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENpf0ACgkQ2O7X88g7
+prhBQ/+MouR83n65h6WM1o09SVEzB3u0Hk3/akRvUezMXouzql4CgUGFXIXslL8
km7FpUDvEN1+8bUZApxY72tH4ZaNfONR4/u8bPv7PShlvI1ipaFS4ldcna1IY0gK
N1UGiVOYJgfysxzrxlE20wewHexYXoy3u3fdHatZX5NLZJ0YyoOePUynu4gD9VIr
F7QuU34Qz14IK841995RLQG6LJgXtCwL4vmHdaXreRcvd4uJXLd2ZgpuCiZMUdYk
xidkC6uyI3pLzFbHibJmktCmRDn6bYwC+84ZSjEh9VNq5IlwNBxF7RDmAvNvqziS
Ui7jKXJht7RNl6oZivUVTbBsNGPvDGiUf22mS6HJ19JaGSx7LSlQf/wCukjVFmmk
cdCdGqwavisy/snoNDeND2IBiiIMbZw8RuSSy05oMRuN8yLbMjw86mnJMxksxhg9
gqYrIlmc8bAQA17pVQOc7VquwaU8Nm9opce5RaOqLhfKbNJZTOaByKN0CwwKA6eo
MnH41Pk+21O1yTHGr8Mev/U+XqE8zVmObli7Is85b3KIE1kfNXJPH/MTAY/kUFQO
dZ0LnUCoNSfBsvOYMgPCGJuZZsvMldY/Z2Z8GXJYNw96yr5J6+DmgbkNluwshCj0
5DXDqfdYdyjqyX7BxzYzFWrvnvFWj/t4ZAOF6DM5mqRR3GrTbWo=
=TWNl
-----END PGP SIGNATURE-----

--mwikk6n67qm3qst4--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB451CCC3F
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 18:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEJQda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgEJQda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 12:33:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4DC061A0C;
        Sun, 10 May 2020 09:33:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7E4852A02F1
Received: by earth.universe (Postfix, from userid 1000)
        id 643EB3C08C7; Sun, 10 May 2020 18:33:26 +0200 (CEST)
Date:   Sun, 10 May 2020 18:33:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Heidelberg <david@ixit.cz>
Cc:     Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] power: supply: smb347-charger: Use resource-managed
 API
Message-ID: <20200510163326.6kojpvcghnjqmqus@earth.universe>
References: <20200329161552.215075-1-david@ixit.cz>
 <20200329161552.215075-4-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pz3z6n46r7f4mtul"
Content-Disposition: inline
In-Reply-To: <20200329161552.215075-4-david@ixit.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pz3z6n46r7f4mtul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 29, 2020 at 06:15:46PM +0200, David Heidelberg wrote:
> Simplify code, more convenient to use with Device Tree.
>=20
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Generally I like this change a lot, but it changes the removal
order, so that the IRQ is only free'd after power-supply has
already been unregistered. While it is disabled in the sm347 I
think it's better to keep the previous order to be on the safe
side.

This can easily achieved by having another patch moving from
power_supply_register to devm_power_supply_register, which will
further cleanup the code as a nice side-effect.

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 45 +++++++++++++--------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index f99026d81f2a..4add9f64ba90 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -836,21 +836,31 @@ static int smb347_irq_init(struct smb347_charger *s=
mb,
>  			   struct i2c_client *client)
>  {
>  	const struct smb347_charger_platform_data *pdata =3D smb->pdata;
> -	int ret, irq =3D gpio_to_irq(pdata->irq_gpio);
> +	unsigned long irqflags =3D IRQF_ONESHOT;
> +	int ret;
> =20
> -	ret =3D gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
> -	if (ret < 0)
> -		goto fail;
> +	/* Requesting GPIO for IRQ is only needed in non-DT way */
> +	if (!client->irq) {
> +		int irq =3D gpio_to_irq(pdata->irq_gpio);
> +
> +		ret =3D devm_gpio_request_one(smb->dev, pdata->irq_gpio,
> +					    GPIOF_IN, client->name);
> +		if (ret < 0)
> +			return ret;
> +
> +		irqflags |=3D IRQF_TRIGGER_FALLING;
> +		client->irq =3D irq;
> +	}
> =20
> -	ret =3D request_threaded_irq(irq, NULL, smb347_interrupt,
> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				   client->name, smb);
> +	ret =3D devm_request_threaded_irq(smb->dev, client->irq, NULL,
> +					smb347_interrupt, irqflags,
> +					client->name, smb);
>  	if (ret < 0)
> -		goto fail_gpio;
> +		return ret;
> =20
>  	ret =3D smb347_set_writable(smb, true);
>  	if (ret < 0)
> -		goto fail_irq;
> +		return ret;
> =20
>  	/*
>  	 * Configure the STAT output to be suitable for interrupts: disable
> @@ -860,20 +870,10 @@ static int smb347_irq_init(struct smb347_charger *s=
mb,
>  				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
>  				 CFG_STAT_DISABLED);
>  	if (ret < 0)
> -		goto fail_readonly;
> +		client->irq =3D 0;
> =20
>  	smb347_set_writable(smb, false);
> -	client->irq =3D irq;
> -	return 0;
> =20
> -fail_readonly:
> -	smb347_set_writable(smb, false);
> -fail_irq:
> -	free_irq(irq, smb);
> -fail_gpio:
> -	gpio_free(pdata->irq_gpio);
> -fail:
> -	client->irq =3D 0;
>  	return ret;
>  }
> =20
> @@ -1299,11 +1299,8 @@ static int smb347_remove(struct i2c_client *client)
>  {
>  	struct smb347_charger *smb =3D i2c_get_clientdata(client);
> =20
> -	if (client->irq) {
> +	if (client->irq)
>  		smb347_irq_disable(smb);
> -		free_irq(client->irq, smb);
> -		gpio_free(smb->pdata->irq_gpio);
> -	}
> =20
>  	power_supply_unregister(smb->battery);
>  	if (smb->pdata->use_usb)
> --=20
> 2.25.0
>=20

--pz3z6n46r7f4mtul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64LNYACgkQ2O7X88g7
+pqjNA//QHLJtJTnBTPHdrc5QN0f4F68QEVTLP1X3DyA4gJ+PfRv9rneGHicqSVw
oPcabYFZ+r0Q8fadzn7gMpKSpCsuOYC4MYn7J8T0R7LiV+jZvKsIiMEwV/hXA9Cn
iPK0L30TXhM7cChRFBSvFJK8hwLLKt+IyrrX5hwO8K5ug2SxPDI+Q0eCDVqkHF7X
JZtV1E5Yd9vId+bs90ANkX+3vI0RrCl60YCLfPatSw++4ZgE1rGBbWMjw7a4WUcx
TaBAaf66M2SyaBIH/+NDfVWgBLInxrg4iyblG9JJeOzikzmTskGAv11ZhrA3IrAh
ZU7SNumQi4iQlsp8rkYVVYMqvAHUzfVn3TB0sNPqXIhnNYNSwrxDuvgEl/fpEksV
hufMkWFgdgxjujIWwjSYpaBx3fEoKIn4tayEaQfENW+TIevTreUfAcwW5+U72kmH
e+zHtzm8wBmhZnPbMgaYsiVj0esqrineFipWOvqTj7ljn+aDvD4wGqcHDA2MawLN
CrDatM+T+FSJGFyID74lzRmXP4MxC6k5xiRMbWedlwmURCTbxwP6iYomuCrSUz7K
Gi9l4ouHA1u7qqjbv7l3+6Fpj4Pi070KA/tmVfW0YrOADjE5smDPROEidEY0lgJK
/tITAu00zzxmrCX6nyP61P3468p1aFKmlqTUKBfncwyS8h34WzA=
=3ZnK
-----END PGP SIGNATURE-----

--pz3z6n46r7f4mtul--

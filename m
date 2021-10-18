Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A814323EF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhJRQhh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhJRQhh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 12:37:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FBC061745;
        Mon, 18 Oct 2021 09:35:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C21B31F41B9D
Received: by earth.universe (Postfix, from userid 1000)
        id 353043C0CA8; Mon, 18 Oct 2021 18:35:22 +0200 (CEST)
Date:   Mon, 18 Oct 2021 18:35:22 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     linux-pm@vger.kernel.org, kernel@puri.sm,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: bq25890: add return values to error messages
Message-ID: <20211018163522.rbvv35ddilumc3uu@earth.universe>
References: <20211014094533.4169157-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7fszvvmprm57xvod"
Content-Disposition: inline
In-Reply-To: <20211014094533.4169157-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7fszvvmprm57xvod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 14, 2021 at 11:45:33AM +0200, Martin Kepplinger wrote:
> Add more details to the error messages that indicate what went wrong
> and use dev_err_probe() at a few places in the probe() path in order
> to avoid error messages for deferred probe after which the driver probes
> correctly.
>=20
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 34 ++++++++++++--------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 0e23d2db0fc4..ec81653e58c0 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -979,13 +979,13 @@ static int bq25890_get_chip_version(struct bq25890_=
device *bq)
> =20
>  	id =3D bq25890_field_read(bq, F_PN);
>  	if (id < 0) {
> -		dev_err(bq->dev, "Cannot read chip ID.\n");
> +		dev_err(bq->dev, "Cannot read chip ID: %d\n", id);
>  		return id;
>  	}
> =20
>  	rev =3D bq25890_field_read(bq, F_DEV_REV);
>  	if (rev < 0) {
> -		dev_err(bq->dev, "Cannot read chip revision.\n");
> +		dev_err(bq->dev, "Cannot read chip revision: %d\n", rev);
>  		return rev;
>  	}
> =20
> @@ -1028,10 +1028,9 @@ static int bq25890_irq_probe(struct bq25890_device=
 *bq)
>  	struct gpio_desc *irq;
> =20
>  	irq =3D devm_gpiod_get(bq->dev, BQ25890_IRQ_PIN, GPIOD_IN);
> -	if (IS_ERR(irq)) {
> -		dev_err(bq->dev, "Could not probe irq pin.\n");
> -		return PTR_ERR(irq);
> -	}
> +	if (IS_ERR(irq))
> +		return dev_err_probe(bq->dev, PTR_ERR(irq),
> +				     "Could not probe irq pin.\n");
> =20
>  	return gpiod_to_irq(irq);
>  }
> @@ -1153,34 +1152,33 @@ static int bq25890_probe(struct i2c_client *clien=
t,
>  	mutex_init(&bq->lock);
> =20
>  	bq->rmap =3D devm_regmap_init_i2c(client, &bq25890_regmap_config);
> -	if (IS_ERR(bq->rmap)) {
> -		dev_err(dev, "failed to allocate register map\n");
> -		return PTR_ERR(bq->rmap);
> -	}
> +	if (IS_ERR(bq->rmap))
> +		return dev_err_probe(dev, PTR_ERR(bq->rmap),
> +				     "failed to allocate register map\n");
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(bq25890_reg_fields); i++) {
>  		const struct reg_field *reg_fields =3D bq25890_reg_fields;
> =20
>  		bq->rmap_fields[i] =3D devm_regmap_field_alloc(dev, bq->rmap,
>  							     reg_fields[i]);
> -		if (IS_ERR(bq->rmap_fields[i])) {
> -			dev_err(dev, "cannot allocate regmap field\n");
> -			return PTR_ERR(bq->rmap_fields[i]);
> -		}
> +		if (IS_ERR(bq->rmap_fields[i]))
> +			return dev_err_probe(dev, PTR_ERR(bq->rmap_fields[i]),
> +					     "cannot allocate regmap field\n");
>  	}
> =20
>  	i2c_set_clientdata(client, bq);
> =20
>  	ret =3D bq25890_get_chip_version(bq);
>  	if (ret) {
> -		dev_err(dev, "Cannot read chip ID or unknown chip.\n");
> +		dev_err(dev, "Cannot read chip ID or unknown chip: %d\n", ret);
>  		return ret;
>  	}
> =20
>  	if (!dev->platform_data) {
>  		ret =3D bq25890_fw_probe(bq);
>  		if (ret < 0) {
> -			dev_err(dev, "Cannot read device properties.\n");
> +			dev_err(dev, "Cannot read device properties: %d\n",
> +				ret);
>  			return ret;
>  		}
>  	} else {
> @@ -1189,7 +1187,7 @@ static int bq25890_probe(struct i2c_client *client,
> =20
>  	ret =3D bq25890_hw_init(bq);
>  	if (ret < 0) {
> -		dev_err(dev, "Cannot initialize the chip.\n");
> +		dev_err(dev, "Cannot initialize the chip: %d\n", ret);
>  		return ret;
>  	}
> =20
> @@ -1225,7 +1223,7 @@ static int bq25890_probe(struct i2c_client *client,
> =20
>  	ret =3D bq25890_power_supply_init(bq);
>  	if (ret < 0) {
> -		dev_err(dev, "Failed to register power supply\n");
> +		dev_err_probe(dev, ret, "Failed to register power supply.\n");
>  		goto irq_fail;
>  	}
> =20
> --=20
> 2.30.2
>=20

--7fszvvmprm57xvod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFtokoACgkQ2O7X88g7
+prOFQ/+MZvD8b0bUexF2b7y/t508/n0ler/vgjTsly7Z1voSREo/3sNjg29gXdC
hcMzlaomuLvdrfNvoeXDqvGWasIzX/HrFybKhbi0aQLs5K3llYp8VABnr0mFyGc2
iAZnd2HFMuR/PdXvCeeIs4LYBOq2aTf3KyjPjlJ0WMFrk9GHZ/upNQR2ilahISuT
mSFyFcYvp6ZtDcuq99uY6umKD03LKt5X/5HaDcu7EFQyCZXJ184fX8cTkXSRU/CF
iD6ICQYV7ReuJ0J+XyCkaw26rZX+86JcHJFLwLLFpyxhHxBxpAxYrwwq5RNXWWXX
R00T/3I97EDQuhXyZwHlSCmPlbfArPLQoKQoz4B4SF8Cgrn7I1ps7nemauxCYWn3
DWWdmfkbK+29K+MrRiFVeWd6XX7d73v9bij3uItynnnMdgdUaLMYUJ8CvA+6TM96
sEh4OTdTAmOj5D/+jqaRpv4V+XigzB8Pz3/KEZ7jvBZ6zKM2ocypoHxP6+Jdaad9
icqymXTPzix3jClOudodFEPDWbX7Vn0p5mwMuvQALVivpJcK14pfteSpc0mza2mC
IvSg/NaqwLuJsrD7KsKioMUeg4I9YrhXbCp8KLpxGqprd4BMlo/UaRGJuD2Gte1+
KpiUApLWdscjgzCDkoeZTah9EWEjS34SS3NmzxPYmcsUSAKT/Wg=
=HBZp
-----END PGP SIGNATURE-----

--7fszvvmprm57xvod--

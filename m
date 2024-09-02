Return-Path: <linux-pm+bounces-13364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32203968F57
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 23:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573461C212C5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C0187356;
	Mon,  2 Sep 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EFS05vGK";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="h44q7Bon"
X-Original-To: linux-pm@vger.kernel.org
Received: from a7-42.smtp-out.eu-west-1.amazonses.com (a7-42.smtp-out.eu-west-1.amazonses.com [54.240.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A72187344;
	Mon,  2 Sep 2024 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725314146; cv=none; b=dU0u2rnKKZAeQYJFowc29G/9Ge1XxH2auXdrUVrHAjQ7hrw2NtZZz1w1hCrnEkbpX+lslUzNMUSExBPnpIwgF0H79oerkOxZvfvE9wIO6OQZPzINuq3pLeN2bmbz/SMgPWVK8ivijkT+iMZ0oNRTcT3BzddWTvlaFcHU8jJYJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725314146; c=relaxed/simple;
	bh=k7aKxeQmEkM1y7ybGawqN1iDsl7azjOv3PpczXOhmzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC76R1qGT6+lG5kQhspkdL3rnedehdI8rE4VN+PMN38MBSWOHVcpCOU1+T12GWxkRzXx2p9qQbBcxHVGoMvU09FBTk81DRoiDvkTtItPNrxYnrSjfvZ9pjudRcYHiy5NLbCk0p40vU09/SF5dIiI0FB6EQBga7gumBdOE3jLnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EFS05vGK; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=h44q7Bon; arc=none smtp.client-ip=54.240.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725314142;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=k7aKxeQmEkM1y7ybGawqN1iDsl7azjOv3PpczXOhmzU=;
	b=EFS05vGK7/OYS8ClPD5BssuHd9lEwTyOQOIjgkCQqIjw2AAJr8Im0i1vUJNRJJYy
	wrnFu5aoUCWjhTN/+n0KLoWsENUkaLWPrsINqUGlXOLSzrknEUEHF5VMkx4e0T6PFAe
	AMIEfmuqUidiqtYySvjN+GN2SUDXBWzsn1wOmtPSLP9B+I320jQsCE/6ASP3DBxOwka
	KvlWJO3siZJE8Llk/7mSZVmMFXBCaWvz1KvrJA9t5L/awiigrC0uxRZzYmjLh+Y9kyK
	D2mhuIzulZ9KPdtV4zUJkCSfTpwNJ/H0/0lLV+H/OK9kSSKPPY9J5eeog54pqOHaY7N
	byDjJ5rcMA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725314142;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=k7aKxeQmEkM1y7ybGawqN1iDsl7azjOv3PpczXOhmzU=;
	b=h44q7Bon45QsvSKu3Nt2A6JQyXYs2RfgRA8WZ5yVbjfPIwXdD3cMbrfT6szOwJHU
	dLIeAXW78B/dsL81+coA2wEZtF1WAs23jbuLPYYl2r9bKkTmv8zEhZMg01Yfllv78mt
	5WQV5r4ihsMJxXxodd707snQF+6PNl5Y+VTsgZME=
Date: Mon, 2 Sep 2024 21:55:42 +0000
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: max1720x: add read support for nvmem
Message-ID: <01020191b4bc8ff0-e7e8d909-4802-4076-9caf-cee0296fd10d-000000@eu-west-1.amazonses.com>
References: <20240831182145.11589-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ggta6jjiwxntt2pw"
Content-Disposition: inline
In-Reply-To: <20240831182145.11589-1-dima.fedrau@gmail.com>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.02-54.240.7.42


--ggta6jjiwxntt2pw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 31, 2024 at 08:21:45PM GMT, Dimitri Fedrau wrote:
> ModelGauge m5 and device configuration values are stored in nonvolatile
> memory to prevent data loss if the IC loses power. Add read support for
> the nonvolatile memory on MAX1720X devices.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>=20
> Based on:
> 479b6d04964b "power: supply: add support for MAX1720x standalone fuel gau=
ge"
> in branch for-next
>=20
> Changes in V2:
>   - remove function max1720x_remove and use devm_add_action_or_reset() to
>     unregister info->ancillary to avoid race condition during module remo=
ve

Thanks, but the transformation is quite incomplete. You probably
should have a look what device managed resource actually means :)

> ---
>  drivers/power/supply/max1720x_battery.c | 220 ++++++++++++++++++++++--
>  1 file changed, 205 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supp=
ly/max1720x_battery.c
> index edc262f0a62f..d27c94bdb835 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c

[...]

> +static int max1720x_probe_nvmem(struct i2c_client *client,
> +				struct max1720x_device_info *info)
>  {
>  	struct device *dev =3D &client->dev;
> -	struct i2c_client *ancillary;
> +	struct nvmem_config nvmem_config =3D {

As noticed by the build bot: you need to add this include for the
struct:

#include <linux/nvmem-provider.h>

> +		.dev =3D dev,
> +		.name =3D "max1720x_nvmem",
> +		.cells =3D max1720x_nvmem_cells,
> +		.ncells =3D ARRAY_SIZE(max1720x_nvmem_cells),
> +		.read_only =3D true,
> +		.root_only =3D true,
> +		.reg_read =3D max1720x_nvmem_reg_read,
> +		.size =3D ARRAY_SIZE(max1720x_nvmem_cells) * 2,
> +		.word_size =3D 2,
> +		.stride =3D 2,
> +		.priv =3D info,
> +	};
> +	struct nvmem_device *nvmem;
> +	unsigned int val;
>  	int ret;
> =20
> -	ancillary =3D i2c_new_ancillary_device(client, "nvmem", 0xb);
> -	if (IS_ERR(ancillary)) {
> +	info->ancillary =3D i2c_new_ancillary_device(client, "nvmem", 0xb);
> +	if (IS_ERR(info->ancillary)) {
>  		dev_err(dev, "Failed to initialize ancillary i2c device\n");
> -		return PTR_ERR(ancillary);
> +		return PTR_ERR(info->ancillary);
>  	}
> =20
> -	ret =3D i2c_smbus_read_word_data(ancillary, MAX1720X_NRSENSE);
> -	i2c_unregister_device(ancillary);
> -	if (ret < 0)
> -		return ret;
> +	ret =3D devm_add_action_or_reset(dev, max1720x_unregister_ancillary, in=
fo);
> +	if (ret) {
> +		dev_err(dev, "Failed to add unregister callback\n");
> +		goto err;
> +	}
> =20
> -	info->rsense =3D ret;
> +	info->regmap_nv =3D devm_regmap_init_i2c(info->ancillary,
> +					       &max1720x_nvmem_regmap_cfg);
> +	if (IS_ERR(info->regmap_nv)) {
> +		dev_err(dev, "regmap initialization of nvmem failed\n");
> +		ret =3D PTR_ERR(info->regmap_nv);
> +		goto err;
> +	}
> +
> +	ret =3D regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read sense resistor value\n");
> +		goto err;
> +	}
> +
> +	info->rsense =3D val;
>  	if (!info->rsense) {
>  		dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
>  		info->rsense =3D 1000; /* in regs in 10^-5 */
>  	}
> =20
> +	nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> +	if (IS_ERR(nvmem)) {
> +		dev_err(dev, "Could not register nvmem!");
> +		ret =3D PTR_ERR(nvmem);
> +		goto err;
> +	}
> +
>  	return 0;
> +err:
> +	i2c_unregister_device(info->ancillary);

devm_add_action_or_reset() already unregisters on failure, so this
results in a double unregister. Please also simplify 'goto err'
with 'return ret;'.

> +
> +	return ret;
>  }
> =20
>  static const struct power_supply_desc max1720x_bat_desc =3D {
> @@ -299,20 +487,22 @@ static int max1720x_probe(struct i2c_client *client)
> =20
>  	psy_cfg.drv_data =3D info;
>  	psy_cfg.fwnode =3D dev_fwnode(dev);
> +	i2c_set_clientdata(client, info);
>  	info->regmap =3D devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
>  	if (IS_ERR(info->regmap))
>  		return dev_err_probe(dev, PTR_ERR(info->regmap),
>  				     "regmap initialization failed\n");
> =20
> -	ret =3D max1720x_probe_sense_resistor(client, info);
> +	ret =3D max1720x_probe_nvmem(client, info);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to read sense resistor value\n");
> +		return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
> =20
>  	bat =3D devm_power_supply_register(dev, &max1720x_bat_desc, &psy_cfg);
> -	if (IS_ERR(bat))
> +	if (IS_ERR(bat)) {
> +		i2c_unregister_device(info->ancillary);

This is also already handled by devm and must be removed.

>  		return dev_err_probe(dev, PTR_ERR(bat),
>  				     "Failed to register power supply\n");
> +	}
> =20
>  	return 0;
>  }

-- Sebastian

--ggta6jjiwxntt2pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbWNFkACgkQ2O7X88g7
+prnKw/7BvyloO8T23jJijuCuMrDU7wMGOVNh4D+Ij/WrJ6UmhOqD5KBqXt0h0Hy
GPIHrmnDGSXwjtIc1WuulmP6Ka0ZpeMsiidNr2vihWLixEEXMw6ZtiCpFuC3X9OM
KqBGWPHPz32HlTZu2BBPEjKRkAWdpIlXKeXHCpmEWHHrF+MnC7tkglJanSNuYmD1
/jCvMkM8MwVpiK9wVeSvVh7klZiEcrvNVWy9qCO6U5/ZVYf/Rw9DOVko2K7Wt+Tx
HzrkYmrGUPp379ZlP3K/j16KK9g9NpoYpfsvT5jKPZQo80KhKHOQQ02hGnnDTKxF
gIxamttKfNudVy3IZz2AFzkS03f123H6xjCvXfkjG7EvqY9S6EkLljS6pAwNzF6/
xrQGUsfWTIHBsXNeLpctxLZxYFtJx2HSFNt9TicsNBIYWH3Aq+hrs3T/zzdA0H7H
Uf/ZnL1DwqUstyCW7a69u9QGaz9cJd6lBmohw6oCa1E/L+X4h8C4gG2YC0GpNL/W
TiARhxwkKOgnCgYDJOR+G06ACtl97fTSC+6uLZP4bd9IdtSmvotYia08lsl/scLO
BjWRpELGQV97aD011TVNzmM4Lk9ElownNMCRKqyLHCU5+q8h9MNHlZ6wUJ7hBXAk
zq7re8TaaXfmT1/Mqr1IQmlmIdno3AeZ3p1JKfwunTEyZr1qBIk=
=VGt2
-----END PGP SIGNATURE-----

--ggta6jjiwxntt2pw--


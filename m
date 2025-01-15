Return-Path: <linux-pm+bounces-20507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B173A12CFC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 21:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BE6164E27
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D571F1D9A54;
	Wed, 15 Jan 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="O71r3jEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF21D8DEE;
	Wed, 15 Jan 2025 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974215; cv=pass; b=VVJQdLHMgQh899I4BbcniWw2UZOpRMpze5jdDjCbGuvHAIacw4CmpFsx9nlHO7mxFVEUtso2UIAdD3+IG0PF+X8aE0ZJAcr0sDRRIhqwnP1AhmLqsNN2DNP7cUC1CZFl4AhIsFB5HaP86AkujOJCeRekt7/RaVOOidKeHtoKU4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974215; c=relaxed/simple;
	bh=OFpQWIvudZbHlBhiZDicAhYOkbhQ2YsUpzLFvHd076E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEdvzmV1Gucgojyls0A9MkIKfuWFcuOV9EMyzxpnnIe2COy/ZRlxH3YXzexQrwf/h4LWCJ/kXVsuWQCJawDdSm4c6DDnoY+zh/bOEQ3ovi9VTGO4jWIe1uVRwDfViCUyTtbcrsC8nlvwhwz5oY1HeQlLvK1x9ASLI8rmcevJpOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=O71r3jEF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736974207; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b4/8I1XjEeiu3gZ6KF3zvFiZD/BMMnMwoOXVcuSiyzQdM6Kf/rgFLUjienjPWhnb0Gb4qyn0Ucj7ql1DOvFoq1E3FzWdatCADQ2AL1SMRGKuJnjxjJxX754eecdwbDMdSuncIfc9s0xnbh1gMABWUdguJyFRnbvzVh8Ed6bwZsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736974207; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hK3sPpgixNlnf98tqWvN93PwpeEMbEFwHQY2lXn/WeQ=; 
	b=JF084HRELG1/bm+wo9m65NwakAeznd8pALERNtjRuE67lmlXVp2Uk2Sl+fTclwIGZGV8wGQ3w3yux3FHi82kYBzCZUp+RtlsQ53xmDwHsXDoCF3h7NwrgSBgxlasgLj5yXFAO876XSz/RVUI9DznITEIsv7r84MI+vG2JKTDAkA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736974207;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=hK3sPpgixNlnf98tqWvN93PwpeEMbEFwHQY2lXn/WeQ=;
	b=O71r3jEFCASFSy4ObcsT0eYEvN9wuErT3mYzRnhRBiX8GJ3u9eMLwpOVXH5XIRZ8
	wE3upkx9Hss2MVe1i7bXO9peOhDHV5aFI8jEsBj9M5jB0l+L5X1u6zd+m55ihtKaazh
	lh7CvoGJPYzl7PnFNG3ULeSvfRA03dm6pXgjWiug=
Received: by mx.zohomail.com with SMTPS id 173697420510774.80312423010707;
	Wed, 15 Jan 2025 12:50:05 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id D36B01060346; Wed, 15 Jan 2025 21:50:01 +0100 (CET)
Date: Wed, 15 Jan 2025 21:50:01 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: dimitri.fedrau@liebherr.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Thomas Antoine <t.antoine@uclouvain.be>
Subject: Re: [PATCH] power: supply: max1720x: add support for reading
 internal and thermistor temperatures
Message-ID: <rvn4ixkj5ggjx4c3ip453nyltcjk6krzz5pjheqzsrxlikwswd@2t4jv6knrhn2>
References: <20250113-max1720x-temperature-v1-1-cd9dd3b9d217@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxmyl4ldtdz7jb5i"
Content-Disposition: inline
In-Reply-To: <20250113-max1720x-temperature-v1-1-cd9dd3b9d217@liebherr.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.1/234.845.73
X-ZohoMailClient: External


--bxmyl4ldtdz7jb5i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: max1720x: add support for reading
 internal and thermistor temperatures
MIME-Version: 1.0

Hi,

On Mon, Jan 13, 2025 at 03:27:49PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> If enabled in the nPackCfg register, the Temp1, Temp2 and IntTemp registe=
rs
> contain the temperature readings from the AIN1 thermistor, AIN2 thermistor
> and internal die temperature respectively. Registers are shared between S=
BS
> and normal IC functions and are always readable regardless of IC settings.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---

Custom sysfs properties must be documented, see for example

Documentation/ABI/testing/sysfs-class-power-surface

Greetings,

-- Sebastian

>  drivers/power/supply/max1720x_battery.c | 60 +++++++++++++++++++++++++++=
+++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supp=
ly/max1720x_battery.c
> index 9c7e14d2c7b87b8194511f36ade16e774281333e..e237528df29d2cac87361b75d=
71c576c0ed2b530 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c
> @@ -16,6 +16,11 @@
> =20
>  #include <linux/unaligned.h>
> =20
> +/* SBS compliant registers */
> +#define MAX172XX_TEMP1			0x34
> +#define MAX172XX_INT_TEMP		0x35
> +#define MAX172XX_TEMP2			0x3B
> +
>  /* Nonvolatile registers */
>  #define MAX1720X_NXTABLE0		0x80
>  #define MAX1720X_NRSENSE		0xCF	/* RSense in 10^-5 Ohm */
> @@ -113,11 +118,15 @@ static const struct regmap_config max1720x_regmap_c=
fg =3D {
>  };
> =20
>  static const struct regmap_range max1720x_nvmem_allow[] =3D {
> +	regmap_reg_range(MAX172XX_TEMP1, MAX172XX_INT_TEMP),
> +	regmap_reg_range(MAX172XX_TEMP2, MAX172XX_TEMP2),
>  	regmap_reg_range(MAX1720X_NXTABLE0, MAX1720X_NDEVICE_NAME4),
>  };
> =20
>  static const struct regmap_range max1720x_nvmem_deny[] =3D {
> -	regmap_reg_range(0x00, 0x7F),
> +	regmap_reg_range(0x00, 0x33),
> +	regmap_reg_range(0x36, 0x3A),
> +	regmap_reg_range(0x3C, 0x7F),
>  	regmap_reg_range(0xE0, 0xFF),
>  };
> =20
> @@ -388,6 +397,54 @@ static int max1720x_battery_get_property(struct powe=
r_supply *psy,
>  	return ret;
>  }
> =20
> +static int max1720x_read_temp(struct device *dev, u8 reg, char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct max1720x_device_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap_nv, reg, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Temperature in degrees Celsius starting at absolute zero, -273C or
> +	 * 0K with an LSb of 0.1C
> +	 */
> +	return sysfs_emit(buf, "%d\n", val - 2730);
> +}
> +
> +static
> +ssize_t temp1_show(struct device *dev, struct device_attribute *attr, ch=
ar *buf)
> +{
> +	return max1720x_read_temp(dev, MAX172XX_TEMP1, buf);
> +}
> +
> +static
> +ssize_t temp2_show(struct device *dev, struct device_attribute *attr, ch=
ar *buf)
> +{
> +	return max1720x_read_temp(dev, MAX172XX_TEMP2, buf);
> +}
> +
> +static
> +ssize_t int_temp_show(struct device *dev, struct device_attribute *attr,=
 char *buf)
> +{
> +	return max1720x_read_temp(dev, MAX172XX_INT_TEMP, buf);
> +}
> +
> +static DEVICE_ATTR_RO(temp1);
> +static DEVICE_ATTR_RO(temp2);
> +static DEVICE_ATTR_RO(int_temp);
> +
> +static struct attribute *max1720x_attrs[] =3D {
> +	&dev_attr_temp1.attr,
> +	&dev_attr_temp2.attr,
> +	&dev_attr_int_temp.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(max1720x);
> +
>  static
>  int max1720x_nvmem_reg_read(void *priv, unsigned int off, void *val, siz=
e_t len)
>  {
> @@ -488,6 +545,7 @@ static int max1720x_probe(struct i2c_client *client)
> =20
>  	psy_cfg.drv_data =3D info;
>  	psy_cfg.fwnode =3D dev_fwnode(dev);
> +	psy_cfg.attr_grp =3D max1720x_groups;
>  	i2c_set_clientdata(client, info);
>  	info->regmap =3D devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
>  	if (IS_ERR(info->regmap))
>=20
> ---
> base-commit: a3a8799165ff83bb764fd800c6559c3cba0ddac3
> change-id: 20250113-max1720x-temperature-cec67fb40197
>=20
> Best regards,
> --=20
> Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
>=20

--bxmyl4ldtdz7jb5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmeIH3kACgkQ2O7X88g7
+pqlag/+Oa3uMT0WuteW4VFr0mmtzqXSG0BICputQhhgiK5Yd/IzUIuJC6pnX107
rWmSWfMMv4xVi6sV3A0DiuWzm9AtODfv0EDiX3TQTeV269W+1/4/VffmBUiLH3ld
UWDmNucpqW6FA/qSiyS0fUUqHCP0PlDsT/qcWYqMQLJnVRvN6f2Admxps8+eoYuW
NRRk6Ju+xldo9GZC62mxuJKSVb006GGlmSEdERAsMMmiJg/Z3O7LgU8rwDUkyxOf
DqPiGo/ts2ibrZS2kGWH+gFA6NpnNQ9u8Gvh7b5xmyOOOSUQxMYnKZnWakqj/0vp
ZvwZSvAYLysM7vRYs+1XdCWhHfRC4julwckWBLhhCb84k/KLTyxWvhRQv+Hk6RdC
kvnRwgShng45pNIsTB8lftsR8Cffhbjw1yyR1UFssWGKcacOXSBJYB57+RCUKb5K
JI+HYj2c4MvxaJrszfnVlRrJJYHV12/h3f5KBS1u3JqKWh9Oo997jxQp7OeIAKCk
ywnF+IX+Yo6ka8/Xl8RhMPz2Y6P/SKhS3NiKmXMW5l4uJsrvgI4DDQ48/KueIcIB
1hJbUC46eqvdTlI2arm+MLYsBGUee0TbOIx2V363lE7DpFppTDawCluzqSKDGyr9
joGOc3mwmp0NxxWlJTrqNrXwcy78rQyKt9TzgCSvOfloLuDBa2k=
=T/w3
-----END PGP SIGNATURE-----

--bxmyl4ldtdz7jb5i--


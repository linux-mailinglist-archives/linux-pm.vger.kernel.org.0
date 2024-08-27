Return-Path: <linux-pm+bounces-12994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5763961573
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 19:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3586CB22F0C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E117C1D1735;
	Tue, 27 Aug 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="BhKcbk/O"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498F1D174E;
	Tue, 27 Aug 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779733; cv=pass; b=XsDCFAiuCWyY2HGCn0ABXqTJfdReoiYenjL8pHV/XNMUQyfX2PcDfI31lZdNHxjHJepWOuIvqQ0TvE6k9GFmPDilkmpBCGyLL5SpEud7fvfDjuenseDMcnNAsiEag5eu+osIRo04JKe/tzDXqObfLSpo+YmzX7lgoB9bmF8rVBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779733; c=relaxed/simple;
	bh=nwB3rmYmfULW9bLKogTtOSlxfE3HH4TcDq/7QJSYgrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCrDdq03Tl2WusU0bVl8xVKtvzXaZzt7zb6ZuWhJQZlEWEkUfG4dU7wzXg3qT+MFEskwfGL6gcuVI2MhImm0enTLAcXl+VQdqfdLgp87HWoXqHbhkQ6N1T0dwFfGD5gp0DCwzLWR73MyshrAmFEklEiK76ekIcX5fDfjvcwhDTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=BhKcbk/O; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724779728; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b+C9s9wUaIrNlojJXyn6f1eYqOPYwWoGSWWH4ewBJVDrOLbS8FcOcEp92RojKnTYRpwcA7RuGFGfLjth649oC5crMPp1cFtq0pAhIacX0iq7iuAnomaUSiLPSeGSZm927EAFFVNEHc0TyfWJ+ZyjejEWmjDfVCWHgyN0LoquPWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724779728; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fnctxmLcz4OATeswXk8+Q9Wgju+2+gUPn0SEZspUvkc=; 
	b=AyzgxPjUguxvp9yA3JV6Oo+fEvlq4K14yf1wxTJd2RyEqK4P8bHb8YOYcQjBqL8xufhZM9/WPQXn3AxITIVuxqe4pi+Tk1zXwDZPMC3UO93tPS7OfV2PrFy587lD16YCGZH8VXNkDzW8UX1X2u4vR1nfHfQkLyWfZ718oDOIREQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724779728;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=fnctxmLcz4OATeswXk8+Q9Wgju+2+gUPn0SEZspUvkc=;
	b=BhKcbk/O8HfRJcEurW4lLgFEwIBj/FEllbRUvS1XHB/8+1Ake8xJipGPTUnbqpOz
	xyIj8JftzzruLEBlheQY/dgrWz4A1uGj5HyTmlvBX52vA7UGwydMbpdwEWv2Tnm5HX4
	FH1O9lBLmmrKBcOs8tokrSWpSCtkOtc4c4jyntZ8=
Received: by mx.zohomail.com with SMTPS id 1724779727216340.1386291208237;
	Tue, 27 Aug 2024 10:28:47 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 143EF10604BD; Tue, 27 Aug 2024 19:28:44 +0200 (CEST)
Date: Tue, 27 Aug 2024 19:28:43 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max1720x: add read support for nvmem
Message-ID: <635z2qvxmoz24dbqe5ur255iyzayggy3laq6zq4tav34r3yoy6@jugdtqrar2zf>
References: <20240717183757.3948-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56cwoah7oqpp3krd"
Content-Disposition: inline
In-Reply-To: <20240717183757.3948-1-dima.fedrau@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.307.46
X-ZohoMailClient: External


--56cwoah7oqpp3krd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 17, 2024 at 08:37:57PM GMT, Dimitri Fedrau wrote:
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
> ---
>  drivers/power/supply/max1720x_battery.c | 215 ++++++++++++++++++++++--
>  1 file changed, 200 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supp=
ly/max1720x_battery.c
> index edc262f0a62f..175f36e83b85 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c
> @@ -16,7 +16,9 @@
>  #include <asm/unaligned.h>
> =20
>  /* Nonvolatile registers */
> +#define MAX1720X_NXTABLE0		0x80
>  #define MAX1720X_NRSENSE		0xCF	/* RSense in 10^-5 Ohm */
> +#define MAX1720X_NDEVICE_NAME4		0xDF
> =20
>  /* ModelGauge m5 */
>  #define MAX172XX_STATUS			0x00	/* Status */
> @@ -46,6 +48,8 @@ static const char *const max17205_model =3D "MAX17205";
> =20
>  struct max1720x_device_info {
>  	struct regmap *regmap;
> +	struct regmap *regmap_nv;
> +	struct i2c_client *ancillary;
>  	int rsense;
>  };
> =20
> @@ -106,6 +110,134 @@ static const struct regmap_config max1720x_regmap_c=
fg =3D {
>  	.cache_type =3D REGCACHE_RBTREE,
>  };
> =20
> +static const struct regmap_range max1720x_nvmem_allow[] =3D {
> +	regmap_reg_range(MAX1720X_NXTABLE0, MAX1720X_NDEVICE_NAME4),
> +};
> +
> +static const struct regmap_range max1720x_nvmem_deny[] =3D {
> +	regmap_reg_range(0x00, 0x7F),
> +	regmap_reg_range(0xE0, 0xFF),
> +};
> +
> +static const struct regmap_access_table max1720x_nvmem_regs =3D {
> +	.yes_ranges	=3D max1720x_nvmem_allow,
> +	.n_yes_ranges	=3D ARRAY_SIZE(max1720x_nvmem_allow),
> +	.no_ranges	=3D max1720x_nvmem_deny,
> +	.n_no_ranges	=3D ARRAY_SIZE(max1720x_nvmem_deny),
> +};
> +
> +static const struct regmap_config max1720x_nvmem_regmap_cfg =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 16,
> +	.max_register =3D MAX1720X_NDEVICE_NAME4,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +	.rd_table =3D &max1720x_nvmem_regs,
> +};
> +
> +static const struct nvmem_cell_info max1720x_nvmem_cells[] =3D {
> +	{ .name =3D "nXTable0",  .offset =3D 0,  .bytes =3D 2, },
> +	{ .name =3D "nXTable1",  .offset =3D 2,  .bytes =3D 2, },
> +	{ .name =3D "nXTable2",  .offset =3D 4,  .bytes =3D 2, },
> +	{ .name =3D "nXTable3",  .offset =3D 6,  .bytes =3D 2, },
> +	{ .name =3D "nXTable4",  .offset =3D 8,  .bytes =3D 2, },
> +	{ .name =3D "nXTable5",  .offset =3D 10, .bytes =3D 2, },
> +	{ .name =3D "nXTable6",  .offset =3D 12, .bytes =3D 2, },
> +	{ .name =3D "nXTable7",  .offset =3D 14, .bytes =3D 2, },
> +	{ .name =3D "nXTable8",  .offset =3D 16, .bytes =3D 2, },
> +	{ .name =3D "nXTable9",  .offset =3D 18, .bytes =3D 2, },
> +	{ .name =3D "nXTable10", .offset =3D 20, .bytes =3D 2, },
> +	{ .name =3D "nXTable11", .offset =3D 22, .bytes =3D 2, },
> +	{ .name =3D "nUser18C",  .offset =3D 24, .bytes =3D 2, },
> +	{ .name =3D "nUser18D",  .offset =3D 26, .bytes =3D 2, },
> +	{ .name =3D "nODSCTh",   .offset =3D 28, .bytes =3D 2, },
> +	{ .name =3D "nODSCCfg",  .offset =3D 30, .bytes =3D 2, },
> +
> +	{ .name =3D "nOCVTable0",  .offset =3D 32, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable1",  .offset =3D 34, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable2",  .offset =3D 36, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable3",  .offset =3D 38, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable4",  .offset =3D 40, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable5",  .offset =3D 42, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable6",  .offset =3D 44, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable7",  .offset =3D 46, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable8",  .offset =3D 48, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable9",  .offset =3D 50, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable10", .offset =3D 52, .bytes =3D 2, },
> +	{ .name =3D "nOCVTable11", .offset =3D 54, .bytes =3D 2, },
> +	{ .name =3D "nIChgTerm",   .offset =3D 56, .bytes =3D 2, },
> +	{ .name =3D "nFilterCfg",  .offset =3D 58, .bytes =3D 2, },
> +	{ .name =3D "nVEmpty",     .offset =3D 60, .bytes =3D 2, },
> +	{ .name =3D "nLearnCfg",   .offset =3D 62, .bytes =3D 2, },
> +
> +	{ .name =3D "nQRTable00",  .offset =3D 64, .bytes =3D 2, },
> +	{ .name =3D "nQRTable10",  .offset =3D 66, .bytes =3D 2, },
> +	{ .name =3D "nQRTable20",  .offset =3D 68, .bytes =3D 2, },
> +	{ .name =3D "nQRTable30",  .offset =3D 70, .bytes =3D 2, },
> +	{ .name =3D "nCycles",     .offset =3D 72, .bytes =3D 2, },
> +	{ .name =3D "nFullCapNom", .offset =3D 74, .bytes =3D 2, },
> +	{ .name =3D "nRComp0",     .offset =3D 76, .bytes =3D 2, },
> +	{ .name =3D "nTempCo",     .offset =3D 78, .bytes =3D 2, },
> +	{ .name =3D "nIAvgEmpty",  .offset =3D 80, .bytes =3D 2, },
> +	{ .name =3D "nFullCapRep", .offset =3D 82, .bytes =3D 2, },
> +	{ .name =3D "nVoltTemp",   .offset =3D 84, .bytes =3D 2, },
> +	{ .name =3D "nMaxMinCurr", .offset =3D 86, .bytes =3D 2, },
> +	{ .name =3D "nMaxMinVolt", .offset =3D 88, .bytes =3D 2, },
> +	{ .name =3D "nMaxMinTemp", .offset =3D 90, .bytes =3D 2, },
> +	{ .name =3D "nSOC",        .offset =3D 92, .bytes =3D 2, },
> +	{ .name =3D "nTimerH",     .offset =3D 94, .bytes =3D 2, },
> +
> +	{ .name =3D "nConfig",    .offset =3D 96,  .bytes =3D 2, },
> +	{ .name =3D "nRippleCfg", .offset =3D 98,  .bytes =3D 2, },
> +	{ .name =3D "nMiscCfg",   .offset =3D 100, .bytes =3D 2, },
> +	{ .name =3D "nDesignCap", .offset =3D 102, .bytes =3D 2, },
> +	{ .name =3D "nHibCfg",    .offset =3D 104, .bytes =3D 2, },
> +	{ .name =3D "nPackCfg",   .offset =3D 106, .bytes =3D 2, },
> +	{ .name =3D "nRelaxCfg",  .offset =3D 108, .bytes =3D 2, },
> +	{ .name =3D "nConvgCfg",  .offset =3D 110, .bytes =3D 2, },
> +	{ .name =3D "nNVCfg0",    .offset =3D 112, .bytes =3D 2, },
> +	{ .name =3D "nNVCfg1",    .offset =3D 114, .bytes =3D 2, },
> +	{ .name =3D "nNVCfg2",    .offset =3D 116, .bytes =3D 2, },
> +	{ .name =3D "nSBSCfg",    .offset =3D 118, .bytes =3D 2, },
> +	{ .name =3D "nROMID0",    .offset =3D 120, .bytes =3D 2, },
> +	{ .name =3D "nROMID1",    .offset =3D 122, .bytes =3D 2, },
> +	{ .name =3D "nROMID2",    .offset =3D 124, .bytes =3D 2, },
> +	{ .name =3D "nROMID3",    .offset =3D 126, .bytes =3D 2, },
> +
> +	{ .name =3D "nVAlrtTh",      .offset =3D 128, .bytes =3D 2, },
> +	{ .name =3D "nTAlrtTh",      .offset =3D 130, .bytes =3D 2, },
> +	{ .name =3D "nSAlrtTh",      .offset =3D 132, .bytes =3D 2, },
> +	{ .name =3D "nIAlrtTh",      .offset =3D 134, .bytes =3D 2, },
> +	{ .name =3D "nUser1C4",      .offset =3D 136, .bytes =3D 2, },
> +	{ .name =3D "nUser1C5",      .offset =3D 138, .bytes =3D 2, },
> +	{ .name =3D "nFullSOCThr",   .offset =3D 140, .bytes =3D 2, },
> +	{ .name =3D "nTTFCfg",       .offset =3D 142, .bytes =3D 2, },
> +	{ .name =3D "nCGain",        .offset =3D 144, .bytes =3D 2, },
> +	{ .name =3D "nTCurve",       .offset =3D 146, .bytes =3D 2, },
> +	{ .name =3D "nTGain",        .offset =3D 148, .bytes =3D 2, },
> +	{ .name =3D "nTOff",         .offset =3D 150, .bytes =3D 2, },
> +	{ .name =3D "nManfctrName0", .offset =3D 152, .bytes =3D 2, },
> +	{ .name =3D "nManfctrName1", .offset =3D 154, .bytes =3D 2, },
> +	{ .name =3D "nManfctrName2", .offset =3D 156, .bytes =3D 2, },
> +	{ .name =3D "nRSense",       .offset =3D 158, .bytes =3D 2, },
> +
> +	{ .name =3D "nUser1D0",       .offset =3D 160, .bytes =3D 2, },
> +	{ .name =3D "nUser1D1",       .offset =3D 162, .bytes =3D 2, },
> +	{ .name =3D "nAgeFcCfg",      .offset =3D 164, .bytes =3D 2, },
> +	{ .name =3D "nDesignVoltage", .offset =3D 166, .bytes =3D 2, },
> +	{ .name =3D "nUser1D4",       .offset =3D 168, .bytes =3D 2, },
> +	{ .name =3D "nRFastVShdn",    .offset =3D 170, .bytes =3D 2, },
> +	{ .name =3D "nManfctrDate",   .offset =3D 172, .bytes =3D 2, },
> +	{ .name =3D "nFirstUsed",     .offset =3D 174, .bytes =3D 2, },
> +	{ .name =3D "nSerialNumber0", .offset =3D 176, .bytes =3D 2, },
> +	{ .name =3D "nSerialNumber1", .offset =3D 178, .bytes =3D 2, },
> +	{ .name =3D "nSerialNumber2", .offset =3D 180, .bytes =3D 2, },
> +	{ .name =3D "nDeviceName0",   .offset =3D 182, .bytes =3D 2, },
> +	{ .name =3D "nDeviceName1",   .offset =3D 184, .bytes =3D 2, },
> +	{ .name =3D "nDeviceName2",   .offset =3D 186, .bytes =3D 2, },
> +	{ .name =3D "nDeviceName3",   .offset =3D 188, .bytes =3D 2, },
> +	{ .name =3D "nDeviceName4",   .offset =3D 190, .bytes =3D 2, },
> +};
> +
>  static const enum power_supply_property max1720x_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_CAPACITY,
> @@ -249,31 +381,74 @@ static int max1720x_battery_get_property(struct pow=
er_supply *psy,
>  	return ret;
>  }
> =20
> -static int max1720x_probe_sense_resistor(struct i2c_client *client,
> -					 struct max1720x_device_info *info)
> +static
> +int max1720x_nvmem_reg_read(void *priv, unsigned int off, void *val, siz=
e_t len)
> +{
> +	struct max1720x_device_info *info =3D priv;
> +	unsigned int reg =3D MAX1720X_NXTABLE0 + (off / 2);
> +
> +	return regmap_bulk_read(info->regmap_nv, reg, val, len / 2);
> +}
> +
> +static int max1720x_probe_nvmem(struct i2c_client *client,
> +				struct max1720x_device_info *info)
>  {
>  	struct device *dev =3D &client->dev;
> -	struct i2c_client *ancillary;
> +	struct nvmem_config nvmem_config =3D {
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

Use devm_add_action_or_reset() to unregister info->ancillary. It
results in cleaner code and also fixes a race condition during
module remove, which frees info->ancillary before the regmap with
your current patch.

Otherwise LGTM.

Greetings,

-- Sebastian

> =20
> -	ret =3D i2c_smbus_read_word_data(ancillary, MAX1720X_NRSENSE);
> -	i2c_unregister_device(ancillary);
> -	if (ret < 0)
> -		return ret;
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
> =20
> -	info->rsense =3D ret;
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
> +
> +	return ret;
>  }
> =20
>  static const struct power_supply_desc max1720x_bat_desc =3D {
> @@ -299,24 +474,33 @@ static int max1720x_probe(struct i2c_client *client)
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
>  		return dev_err_probe(dev, PTR_ERR(bat),
>  				     "Failed to register power supply\n");
> +	}
> =20
>  	return 0;
>  }
> =20
> +static void max1720x_remove(struct i2c_client *client)
> +{
> +	struct max1720x_device_info *info =3D i2c_get_clientdata(client);
> +
> +	i2c_unregister_device(info->ancillary);
> +}
> +
>  static const struct of_device_id max1720x_of_match[] =3D {
>  	{ .compatible =3D "maxim,max17201" },
>  	{}
> @@ -329,6 +513,7 @@ static struct i2c_driver max1720x_i2c_driver =3D {
>  		.of_match_table =3D max1720x_of_match,
>  	},
>  	.probe =3D max1720x_probe,
> +	.remove =3D max1720x_remove,
>  };
>  module_i2c_driver(max1720x_i2c_driver);
> =20
> --=20
> 2.39.2
>=20

--56cwoah7oqpp3krd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbODMgACgkQ2O7X88g7
+prrJg//dzm6mTxTabmKb7gA2B+aQJ04dRnMcYR6bArXh8EHJhuybgZUZwYUfMwY
5ATWOx8mXsWj2u8ehgEBfKA86JD8LcQ7oDsZ67DxttFHMAStoPtcvD1A5I8weKCs
Uwx88WbCEClxB7HF1qBhnxZo4dOda69MpLsImaJXnFRyu6zxTu/9Cr4XNubV1eH1
FKAvjbDWy1N0HXNEoKG6Lm5xdV313v1xOAkOc+5U8mp4hHHZoxxJmFPHAtZEBjzl
Fx+m1cynDU+daXeWG5a49fvd42kToQxwLG/aw8VvV9QG5VBZNEtRRNFMQd/fTHBP
yRCKBZBzirHx5RosZMza4i1SnkPHR01Ra1Rrh3s04u0NocJaVCqOuasi32Vr7egQ
M16faH+i481RQj0knj++HltEv0gc1UTqCoe7bhTYi/vR87+gwuIzr88MCh86Wl8V
g7aOCHK5NB17BWI9K2UAL8ohabzXf0eXTZIi8RK55i3IW7yUfeiN5YQO0FNeeDUx
RXrDwptvEqUuuNN6aNATmKpIuJg0k3MTMSnrOk5hNJfdWdj6SmPc50mUlTtshcEx
vWAAMEpEy6s2GdBt9+siPDCKGY/csPhBtKIoJqoEMjZYp6kRVxE+6eifTQf2mLow
Lt4K4fmsWCvBXA2m+6LBEnvFtc2mQ3cNnbMlSUTcMyAe6s16rds=
=5LNJ
-----END PGP SIGNATURE-----

--56cwoah7oqpp3krd--


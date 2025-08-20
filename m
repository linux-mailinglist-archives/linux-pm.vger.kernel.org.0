Return-Path: <linux-pm+bounces-32717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D31B2DF42
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 16:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5FD5E5CBD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89627510E;
	Wed, 20 Aug 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="YxTp5PJa"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172726FDB2
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699803; cv=none; b=LRJRYKejrGtleP1kqBy+oT/iPFIr2K2hT6A+HR05QS+kpCY11LTc2nvkADifK/zTRzuZYqYPujF0S/ajTcMZ/H5yaldg0UwaQmg4G4gYIiKuKlVLuAmleQtL360y/ve8JCaWTdFivlwa6YIZu2nxSOSIazvtv0pv+EAjZLA53O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699803; c=relaxed/simple;
	bh=JLmPQUDdMFVJ4Wsl2Lbe7VQmcdMhJvL3lGO+VFk1YiQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dCCTctzcVJ5FHjbMxMRTqpdM4EdsW9jsFAoDMeSyOTC2Nk7e+W7mDVbD+iK+Qnvq3lshknvnl/qI7VnbG4gpuoGrHTBCRoZ9qevXZtAgyKdsk6Q4uq6WuGthJIQ+FJNkr4KHAcvecPPBuAxqwMh6KYQW5iWhVPM/9vD9sI8aU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=YxTp5PJa; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755699797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=up1RSHC3bmjFdtojDRArO6p3YgGDPNjjN84qZWu2NY8=;
	b=YxTp5PJawb9k0Hw6LVfv5aAhiNilnjc+DPn0rsU0/xrtQ3oMZLFm3T/eqyHbhwaquns2sB
	HjDlw1zgpsHhqG9TGoTjN97n6XIIQ65WLIK32Oe9d9dT7Co27Rq+c3qUspGPgX8HmHPdn3
	rFA5NhDKnJDiu6Gl1OVSiQ7yPwn6F5gtI47PHi/UpG8FrbqOOaZ5/YUhXUvJSZ/PKn0D31
	W3zBWOpSZzolrvjDCzfWdwRPPUXihkT2xlbME9Fydx+UTTGnRpTljcoh9SQV4/StuEgsyU
	LT2j+EdTzZxQOshziUzXx0An7kHYyuUbDLr2IIGBrhxLcpvBx8hpOQ3kwTsHqA==
Content-Type: multipart/signed;
 boundary=698049d7621a3f79bb424488419fcc815111d0a5c6d83ffbae678ca86f50;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 20 Aug 2025 16:23:06 +0200
Message-Id: <DC7BMRFU4CZP.1R3PY4OJVGJHE@cknow.org>
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Heiko Stuebner" <heiko@sntech.de>
Cc: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <kernel@collabora.com>
Subject: Re: [PATCH] thermal: rockchip: shut up GRF warning
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
In-Reply-To: <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
X-Migadu-Flow: FLOW_OUT

--698049d7621a3f79bb424488419fcc815111d0a5c6d83ffbae678ca86f50
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Sebastian,

On Mon Aug 18, 2025 at 7:26 PM CEST, Sebastian Reichel wrote:
> Most of the recent Rockchip devices do not have a GRF associated
> with the tsadc IP. Let's avoid printing a warning on those devices.

Thanks for this patch :-)

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 53 ++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchi=
p_thermal.c
> index 3beff9b6fac3abe8948b56132b618ff1bed57217..1e8091cebd6673ab39fa0c4de=
e835c68aeb7e8b5 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -50,6 +50,18 @@ enum adc_sort_mode {
>  	ADC_INCREMENT,
>  };
> =20
> +/*
> + * The GRF availability depends on the specific SoC
> + * GRF_NONE: the SoC does not have a GRF associated with the tsadc
> + * GRF_OPTIONAL: the SoC has a GRF, but the driver can work without it
> + * GRF_MANDATORY: the SoC has a GRF and it is required for proper operat=
ion
> + */
> +enum tsadc_grf_mode {
> +	GRF_NONE,
> +	GRF_OPTIONAL,
> +	GRF_MANDATORY,
> +};
> +
>  #include "thermal_hwmon.h"
> =20
>  /**
> @@ -97,6 +109,9 @@ struct rockchip_tsadc_chip {
>  	enum tshut_mode tshut_mode;
>  	enum tshut_polarity tshut_polarity;
> =20
> +	/* GRF availability */
> +	enum tsadc_grf_mode grf_mode;
> +
>  	/* Chip-wide methods */
>  	void (*initialize)(struct regmap *grf,
>  			   void __iomem *reg, enum tshut_polarity p);
> @@ -1099,6 +1114,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_=
data =3D {
>  	.chn_offset =3D 0,
>  	.chn_num =3D 2, /* 2 channels for tsadc */
> =20
> +	.grf_mode =3D GRF_MANDATORY,
> +
>  	.tshut_mode =3D TSHUT_MODE_CRU, /* default TSHUT via CRU */
>  	.tshut_temp =3D 95000,
> =20
> @@ -1123,6 +1140,8 @@ static const struct rockchip_tsadc_chip rv1108_tsad=
c_data =3D {
>  	.chn_offset =3D 0,
>  	.chn_num =3D 1, /* one channel for tsadc */
> =20
> +	.grf_mode =3D GRF_NONE,
> +
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1148,6 +1167,8 @@ static const struct rockchip_tsadc_chip rk3228_tsad=
c_data =3D {
>  	.chn_offset =3D 0,
>  	.chn_num =3D 1, /* one channel for tsadc */
> =20
> +	.grf_mode =3D GRF_NONE,
> +
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1173,6 +1194,8 @@ static const struct rockchip_tsadc_chip rk3288_tsad=
c_data =3D {
>  	.chn_offset =3D 1,
>  	.chn_num =3D 2, /* two channels for tsadc */
> =20
> +	.grf_mode =3D GRF_NONE,
> +
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1198,6 +1221,8 @@ static const struct rockchip_tsadc_chip rk3328_tsad=
c_data =3D {
>  	.chn_offset =3D 0,
>  	.chn_num =3D 1, /* one channels for tsadc */
> =20
> +	.grf_mode =3D GRF_NONE,
> +
>  	.tshut_mode =3D TSHUT_MODE_CRU, /* default TSHUT via CRU */
>  	.tshut_temp =3D 95000,
> =20
> @@ -1222,6 +1247,8 @@ static const struct rockchip_tsadc_chip rk3366_tsad=
c_data =3D {
>  	.chn_offset =3D 0,
>  	.chn_num =3D 2, /* two channels for tsadc */
> =20
> +	.grf_mode =3D GRF_OPTIONAL,
> +
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1247,6 +1274,8 @@ static const struct rockchip_tsadc_chip rk3368_tsad=
c_data =3D {
>  	.chn_offset =3D 0,
>  	.chn_num =3D 2, /* two channels for tsadc */
> =20
> +	.grf_mode =3D GRF_NONE,
> +
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1272,6 +1301,8 @@ static const struct rockchip_tsadc_chip rk3399_tsad=
c_data =3D {
>  	.chn_offset =3D 0,
>  	.chn_num =3D 2, /* two channels for tsadc */
> =20
> +	.grf_mode =3D GRF_OPTIONAL,
> +
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1297,6 +1328,8 @@ static const struct rockchip_tsadc_chip rk3568_tsad=
c_data =3D {
>  	.chn_offset =3D 0,
>  	.chn_num =3D 2, /* two channels for tsadc */
> =20
> +	.grf_mode =3D GRF_OPTIONAL,
> +
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1321,6 +1354,7 @@ static const struct rockchip_tsadc_chip rk3576_tsad=
c_data =3D {
>  	/* top, big_core, little_core, ddr, npu, gpu */
>  	.chn_offset =3D 0,
>  	.chn_num =3D 6, /* six channels for tsadc */
> +	.grf_mode =3D GRF_NONE,
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1345,6 +1379,7 @@ static const struct rockchip_tsadc_chip rk3588_tsad=
c_data =3D {
>  	/* top, big_core0, big_core1, little_core, center, gpu, npu */
>  	.chn_offset =3D 0,
>  	.chn_num =3D 7, /* seven channels for tsadc */
> +	.grf_mode =3D GRF_NONE,
>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,
> @@ -1572,7 +1607,7 @@ static int rockchip_configure_from_dt(struct device=
 *dev,
>  				      struct device_node *np,
>  				      struct rockchip_thermal_data *thermal)
>  {
> -	u32 shut_temp, tshut_mode, tshut_polarity;
> +	u32 shut_temp, tshut_mode, tshut_polarity, ret;
> =20
>  	if (of_property_read_u32(np, "rockchip,hw-tshut-temp", &shut_temp)) {
>  		dev_warn(dev,
> @@ -1621,12 +1656,16 @@ static int rockchip_configure_from_dt(struct devi=
ce *dev,
>  		return -EINVAL;
>  	}
> =20
> -	/* The tsadc wont to handle the error in here since some SoCs didn't
> -	 * need this property.
> -	 */
> -	thermal->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> -	if (IS_ERR(thermal->grf))
> -		dev_warn(dev, "Missing rockchip,grf property\n");
> +	if (thermal->chip->grf_mode !=3D GRF_NONE) {
> +		thermal->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> +		if (IS_ERR(thermal->grf)) {
> +			ret =3D PTR_ERR(thermal->grf);
> +			if (thermal->chip->grf_mode =3D=3D GRF_OPTIONAL)
> +				dev_warn(dev, "Missing rockchip,grf property\n");
> +			else
> +				return dev_err_probe(dev, ret, "Missing rockchip,grf property\n");
> +		}
> +	}
> =20
>  	rockchip_get_trim_configuration(dev, np, thermal);

I tested this patch on the following devices and found no regressions:
- Rock64 (rk3328)
- RockPro64 (rk3399)
- Quartz64 Model B (rk3566)
- NanoPi R5S (rk3568)

When tested on my Rock 5B (rk3588), I no longer saw this warning:
 =20
  rockchip-thermal fec00000.tsadc: Missing rockchip,grf property

And found no regressions, so

Tested-by: Diederik de Haas <didi.debian@cknow.org>

Cheers,
  Diederik


--698049d7621a3f79bb424488419fcc815111d0a5c6d83ffbae678ca86f50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKXaTgAKCRDXblvOeH7b
bqblAP4jPqaWdIPCDRsvkAv1AAHlOf1IltDXJI2S5FepeV2a9QD/fty5wxSUpUMf
gIvJ32RXC5nU6+id1xZfkx099JFU0As=
=74NQ
-----END PGP SIGNATURE-----

--698049d7621a3f79bb424488419fcc815111d0a5c6d83ffbae678ca86f50--


Return-Path: <linux-pm+bounces-32579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8EB2B0B5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 20:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CD91890B66
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E326D4E2;
	Mon, 18 Aug 2025 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Kuhfz07M"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894426FA70;
	Mon, 18 Aug 2025 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542683; cv=none; b=kprzMb+6wtE2bn7A5kYeMjNfSGROeJav2NvcAxN4naWVVySoNkxCf7QYJ3NbfbhEClEaaYdxrWL5hZ+4sB7bYSAOm6Q2zcTwAe2KBh0aba6aHQg4R8/VJkwKnYpYX+vPdByhi2Fzs0fyPuEQUm3qMEnwVzcMJAO+fbyc1Dc+EU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542683; c=relaxed/simple;
	bh=ZAPT9fuu0IPx5iygoOI781s8oP2NzNCflbQUWvHrXSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huMKhukZPi0/3qfyPPTJM+JJ2hyFx65lmZl1CK01PVvzwgwX74gO5bRmu+ynQAW1NnsEVX38NPhVmz79pHp9bxiu7yuqlHJ0xxGvl9eNfxEYgTtR2QNY9CKf4fkUOxJQZ+Q9aXNNlIEzvyhy1pxWubQAEB/EuFU7ooS3kPw1BEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Kuhfz07M; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ubTyn2ugoz2/Rq288NzNSXVDl2tAW+oxgRy2HaQbf9M=; b=Kuhfz07MorWp4PpYWOL7VftqW3
	kPWgyELtaB1PJADPBexGvgKpFWJAjB9NSqmoY9lEjr/ulldNLSkZMDWbwN/ys/NhkWXtzctQYkM5d
	qi9dmeWfUm9UUfL8ZPKEWlrMl2MSIDqynWNMwVGU1ulHL+9zK4rP5/W2uGSEYipRh45UxzfSC2M3W
	P1WC6KTQln6tu8kKt9crOLps0HY4zkfBf53iO0c+RG12QWMwJo0JqIJHu62AQ5IGghbLxc3ZyjipZ
	E5SNbYPtwLeFrA73I+1N+f4+yBLvsafZaZidS1gPqyqJXSGblIgnQ0h5GeiQ/9zfq24JwH3xNtF+W
	5qymsxLQ==;
Received: from i53875ad4.versanet.de ([83.135.90.212] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uo4q8-0000eZ-KQ; Mon, 18 Aug 2025 20:44:16 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] thermal: rockchip: shut up GRF warning
Date: Mon, 18 Aug 2025 20:44:15 +0200
Message-ID: <8402789.eFmWaWnqpD@diego>
In-Reply-To:
 <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
References:
 <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Sebastian,

Am Montag, 18. August 2025, 19:26:15 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Sebastian Reichel:
> Most of the recent Rockchip devices do not have a GRF associated
> with the tsadc IP. Let's avoid printing a warning on those devices.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

thanks a lot for tracking down the GRF usage for all the soc variants :-)

> ---
>  drivers/thermal/rockchip_thermal.c | 53 ++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 46 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchi=
p_thermal.c
> index 3beff9b6fac3abe8948b56132b618ff1bed57217..1e8091cebd6673ab39fa0c4de=
e835c68aeb7e8b5 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
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

nit: I guess instead of adding an empty line, you could also just drop
the empty line above, to bring the "older" variants into the form
rk3576 and rk3588 use.


>  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp =3D 95000,

[...]

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

[...]

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

I guess it might make it easier for people seeing the log, if we could
insert an "optional" into that message for the optional tier.

> +			else
> +				return dev_err_probe(dev, ret, "Missing rockchip,grf property\n");
> +		}
> +	}
> =20
>  	rockchip_get_trim_configuration(dev, np, thermal);

Overall, though

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko




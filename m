Return-Path: <linux-pm+bounces-30559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E4B00065
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4DF6448CE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B62E0B44;
	Thu, 10 Jul 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RqUHNqOo"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D3243954;
	Thu, 10 Jul 2025 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146325; cv=none; b=dyioht8rwKYTbwP5sva24jIlqLJRVJnKNEJ4OayLNXZ8ja0F2WEha5xZOEM764H3r8aTk514bgBlkEkpg7l5EEv3xwvQDHMedigs1TihGmVeqdtAiR0ZP04/Z2Dib5MfCRhpNGQmOY7zMI4Sy3Xy+D5Gp4ARk2UCnzp/Ig3Fo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146325; c=relaxed/simple;
	bh=OASp3ouFHIEGBXNur1Vsp+fUvKl4ReKoAQHL5zs7py8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmNQzRlTu8V/szb0+ZbKp7IW+XDnzg50JcDjS0OFCcoZdqWW3eCM7jnZgbASMyqgCShIdM9bkgXfGJuAJWJd3YZEWfeD5X6XWvgrDgZxd/5AevFcs8zsaG4c9C32AMktBiacnqHsBqhavGh8IwGrQGYP3fgh1iCHbS/p9rK/5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RqUHNqOo; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=OGWfNBdHoVHP4kTvUQ6WShWEYkHdudkm5fWMOhkJyS0=; b=RqUHNqOoepFa2HPuBXfxAAL/Ay
	w+6aKfzuDz1B9FST9JjSIXn3Od+Rb0LSLbwwXDzxu33q9bDydHWA+DjJIJG7hh7cgXS9v1ne1u6HN
	qWMijKFV+y776h2PEsTo+lXj1P4RMgtCdKAVUADIlKrZVwSg+cQMD/F9AiPiUnlP91GRVcJG1x9bF
	mvuzg7ZUBFh+cImic3a1tp8uiWQTxgIWpG2fy1kIWjxvxqqOoZlpN3NiaSZ4XGFCKdNYYLRJQJ8BV
	w5MCSFtaMrsA/7kPYyZNudLxiyE+BAZUvrY/QEayUR/K2RsQNu2f7G3cEyh9eK3dfkUwFzkIt+s4p
	Fxa35FNw==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZpIM-0004Ra-84; Thu, 10 Jul 2025 13:18:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Ye Zhang <ye.zhang@rock-chips.com>
Subject:
 Re: [PATCH v6 3/7] thermal: rockchip: Support RK3576 SoC in the thermal
 driver
Date: Thu, 10 Jul 2025 13:18:29 +0200
Message-ID: <4039995.ElGaqSPkdT@phil>
In-Reply-To: <20250610-rk3576-tsadc-upstream-v6-3-b6e9efbf1015@collabora.com>
References:
 <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <20250610-rk3576-tsadc-upstream-v6-3-b6e9efbf1015@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 10. Juni 2025, 14:32:39 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> From: Ye Zhang <ye.zhang@rock-chips.com>
>=20
> The RK3576 SoC has six TS-ADC channels: TOP, BIG_CORE, LITTLE_CORE,
> DDR, NPU and GPU.
>=20
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> [ported to mainline, reworded commit message]
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Nice that it does not need introduce another temperature table.

> ---
>  drivers/thermal/rockchip_thermal.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchi=
p_thermal.c
> index 40c7d234c3ef99f69dd8db4d8c47f9d493c0583d..89e3180667e2a8f0ef5542b0d=
b4d9e19a21a24d3 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1284,6 +1284,28 @@ static const struct rockchip_tsadc_chip rk3568_tsa=
dc_data =3D {
>  	},
>  };
> =20
> +static const struct rockchip_tsadc_chip rk3576_tsadc_data =3D {
> +	/* top, big_core, little_core, ddr, npu, gpu */
> +	.chn_offset =3D 0,
> +	.chn_num =3D 6, /* six channels for tsadc */
> +	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
> +	.tshut_temp =3D 95000,
> +	.initialize =3D rk_tsadcv8_initialize,
> +	.irq_ack =3D rk_tsadcv4_irq_ack,
> +	.control =3D rk_tsadcv4_control,
> +	.get_temp =3D rk_tsadcv4_get_temp,
> +	.set_alarm_temp =3D rk_tsadcv3_alarm_temp,
> +	.set_tshut_temp =3D rk_tsadcv3_tshut_temp,
> +	.set_tshut_mode =3D rk_tsadcv4_tshut_mode,
> +	.table =3D {
> +		.id =3D rk3588_code_table,
> +		.length =3D ARRAY_SIZE(rk3588_code_table),
> +		.data_mask =3D TSADCV4_DATA_MASK,
> +		.mode =3D ADC_INCREMENT,
> +	},
> +};
> +
>  static const struct rockchip_tsadc_chip rk3588_tsadc_data =3D {
>  	/* top, big_core0, big_core1, little_core, center, gpu, npu */
>  	.chn_offset =3D 0,
> @@ -1342,6 +1364,10 @@ static const struct of_device_id of_rockchip_therm=
al_match[] =3D {
>  		.compatible =3D "rockchip,rk3568-tsadc",
>  		.data =3D (void *)&rk3568_tsadc_data,
>  	},
> +	{
> +		.compatible =3D "rockchip,rk3576-tsadc",
> +		.data =3D (void *)&rk3576_tsadc_data,
> +	},
>  	{
>  		.compatible =3D "rockchip,rk3588-tsadc",
>  		.data =3D (void *)&rk3588_tsadc_data,
>=20
>=20






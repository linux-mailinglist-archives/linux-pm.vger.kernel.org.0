Return-Path: <linux-pm+bounces-30557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8E4B00055
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F63A8D70
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33682D9485;
	Thu, 10 Jul 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hyIEnXbF"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAA20FA9C;
	Thu, 10 Jul 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146201; cv=none; b=MdKG2YE0BHcyhPzYiixaElyC9Z+IaVkdOU8Go0Xc+aDBmGH2UMEQ2OhaZd9ph3OyFeuRWM92dEmo/mpEG8jqlDBnZhmjfgo3xuD7N2pwAbUiG1bat+agBp4gFuf2AfVnfZ9xvT2OhHxzRlCHnZxLb+8CHhKmsT75nRKMyUL4ua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146201; c=relaxed/simple;
	bh=MEmSgmVTX2PGVhfOQtQQrzoCYdMiXbOvniDFRRrYphU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5jpqEfRteM/1e3257kPVmma1xFAxrDMaVWA7uGUIRj4q782nXfVuxYI2ieOzKv2oAM7NajBj4eiNz+AJWnOpzIoijzrdiaGkJWRv8PBARIqpKghF0WFQR8Y8aYuWK+wc/nS/L+Tej8Bio3gZlEaXyfTP6BDxJofifmESyCQv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hyIEnXbF; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Kgi11dZK94dq8u+jzWaaEo1iTl1oo581SiHl97QOATU=; b=hyIEnXbFeVAiaubFEW+EudR2QL
	EGJE/o6h3gS6JUHFZR3Mf8S5vi48x0m3Sf7Dt2MMo5ltxWJNW6iWfs3TP/fCzZESzKkGKZ3dbN2oQ
	S9yuw8lyN4Xb/TpuzKcBtpGdIhynxmzninz4hBbO1QZKe3jR4nmVPF5J7WFpcEvGsgnp/gTNxNv7y
	lgsSfvRdn1gd3LxtutYIgxAYEBGdLPIHa6cAgK4fngFNN2nCCOdous77NW5ojIPL/FwOrN2Ht7T9Z
	oyvzeSRmWdE5alqzDgWsIa7iEiUpJsD7CqQp46/sg/W6TNtwNy2T64Sj7dhG3EeoNCpQaQAdX49l1
	5uBHFEkw==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZpGO-0004QB-JM; Thu, 10 Jul 2025 13:16:28 +0200
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v6 1/7] thermal: rockchip: rename rk_tsadcv3_tshut_mode
Date: Thu, 10 Jul 2025 13:16:27 +0200
Message-ID: <7568508.DvuYhMxLoT@phil>
In-Reply-To: <20250610-rk3576-tsadc-upstream-v6-1-b6e9efbf1015@collabora.com>
References:
 <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <20250610-rk3576-tsadc-upstream-v6-1-b6e9efbf1015@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 10. Juni 2025, 14:32:37 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> The "v" version specifier here refers to the hardware IP revision.
> Mainline deviated from downstream here by calling the v4 revision v3 as
> it didn't support the v3 hardware revision at all.
>=20
> This creates needless confusion, so rename it to rk_tsadcv4_tshut_mode
> to be consistent with what the hardware wants to be called.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I checked the vendor-kernel, and your're right the
rv1126 gets identified as v3 it seems, while all of rk35xx except rk3568
(=3D rk3506, rk3528, rk3562, rk3576, rk3588) call themself v4


> ---
>  drivers/thermal/rockchip_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchi=
p_thermal.c
> index a8ad85feb68fbb7ec8d79602b16c47838ecb3c00..40c7d234c3ef99f69dd8db4d8=
c47f9d493c0583d 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1045,7 +1045,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __i=
omem *regs,
>  	writel_relaxed(val, regs + TSADCV2_INT_EN);
>  }
> =20
> -static void rk_tsadcv3_tshut_mode(int chn, void __iomem *regs,
> +static void rk_tsadcv4_tshut_mode(int chn, void __iomem *regs,
>  				  enum tshut_mode mode)
>  {
>  	u32 val_gpio, val_cru;
> @@ -1297,7 +1297,7 @@ static const struct rockchip_tsadc_chip rk3588_tsad=
c_data =3D {
>  	.get_temp =3D rk_tsadcv4_get_temp,
>  	.set_alarm_temp =3D rk_tsadcv3_alarm_temp,
>  	.set_tshut_temp =3D rk_tsadcv3_tshut_temp,
> -	.set_tshut_mode =3D rk_tsadcv3_tshut_mode,
> +	.set_tshut_mode =3D rk_tsadcv4_tshut_mode,
>  	.table =3D {
>  		.id =3D rk3588_code_table,
>  		.length =3D ARRAY_SIZE(rk3588_code_table),
>=20
>=20






Return-Path: <linux-pm+bounces-9135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105169080B8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 03:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A967F1F2301E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 01:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958B31822E7;
	Fri, 14 Jun 2024 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0xM6FHeW"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57462AF0F;
	Fri, 14 Jun 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718328930; cv=none; b=ifbmy41bjGVM4R6Vk9m2FXOVrZQLJUALgCkfw5eaB4N4f6O/4AqtDURfiH2CLciSGLelAIgL5vX3dMmgLGYaBGupdMgp8AiHTJMjWPYK9IA5pm1XHERLTxUipQGJD4wEuhZtQPeV19wczP9Vdvih3PPYEzx3eUoA5O+QDCr55r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718328930; c=relaxed/simple;
	bh=v3Qw98jelyFXnj4jFQ7LoIE7Rtkyp417F9WQDHhbY1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYJxu+zqsUiXdZl0ZzMIrMTW0ilz218s7foboZ27fqbBRQ/vmeK7YhQnKaztvzYhLVuOu6yZZ+0+jSy3ALbuBv26k/DdWoZLg8BJMqGrPfuD36skC8hFqyG0WtAkEXDbTGWT8M5PmQxdeCuiJ4w22L92yUiVFHd3DhpCwcQ23Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0xM6FHeW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718328926;
	bh=v3Qw98jelyFXnj4jFQ7LoIE7Rtkyp417F9WQDHhbY1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0xM6FHeWJ/E0j5TBZpQmTvNm6dwjE3FxtbjWzwTr25mO2h3MLNp3MrBrdFmQk4/iQ
	 wuHUPjY1unhE9+5HWyzlK/NYBIGc4G+UeS8CkPCxTDdeM+xNk9Jft2YD4vZvSLIV3R
	 Wo4/hFHIdMtOJauwgZE3keub+SaIo9KrPtQVGNsqM6Fcmv0kRGJmfVxqbSkC4Mbj4n
	 N8nXa4qeJmy96nZFv2ZTMl0i63/8/xzCCd6glovL80owyH8fNkmzGCDTwYhi20CgZj
	 XZpwS+4X9m5rsSU1EQ9oMqaLeOmGPvxRamBXXuN+uzY1KIt31pAUfNPAVsnat+DBmF
	 MN/ITcEp/Mi3A==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D6CC6378107D;
	Fri, 14 Jun 2024 01:35:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 61CE210608F7; Fri, 14 Jun 2024 03:35:25 +0200 (CEST)
Date: Fri, 14 Jun 2024 03:35:25 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v6 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
Message-ID: <r5wjdxqdechzxbyqwbyz7ou6nbxqewb6bruvklvcek2dhspixf@ujavcd3ky7n7>
References: <20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org>
 <20240612-yoga-ec-driver-v6-4-8e76ba060439@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xulyxrxhy6ccwuiy"
Content-Disposition: inline
In-Reply-To: <20240612-yoga-ec-driver-v6-4-8e76ba060439@linaro.org>


--xulyxrxhy6ccwuiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 12:59:35PM GMT, Dmitry Baryshkov wrote:
> On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
> and battery status. Add the driver to read power supply status on the
> laptop.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/power/supply/Kconfig                    |   9 +
>  drivers/power/supply/Makefile                   |   1 +
>  drivers/power/supply/lenovo_yoga_c630_battery.c | 500 ++++++++++++++++++=
++++++
>  3 files changed, 510 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3e31375491d5..55ab8e90747d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -167,6 +167,15 @@ config BATTERY_LEGO_EV3
>  	help
>  	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
> =20
> +config BATTERY_LENOVO_YOGA_C630
> +	tristate "Lenovo Yoga C630 battery"
> +	depends on OF && EC_LENOVO_YOGA_C630

The driver should no longer depend on OF. Otherwise LGTM.
Thanks for reworking it.

Greetings,

-- Sebastian

--xulyxrxhy6ccwuiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZrnlUACgkQ2O7X88g7
+po9/g/+LchaOK3fxp4Ks0qfIV6s6rPwUjxhMA9+JLpq62BTpdYsklPtbF3aCjJE
8eJzchrPFDxhP0/jJFYIMYQsy4dBY5GJS3VK02fflNhSgLgLy8aLlFbafrYIu+Av
GmWi/M6UcvTJ366avMqazRvWbwqomMzQ6yUkA9dqYNTo9WnjWV6ereiWTkRlonFo
GN61nFbjoMiNS7fvb216KEq2EbZ+RdZjzup0k/b10Zyu+zX6iIbyoWQ8ALdQXyK8
TsMshTv9R/Mbk3pVp+0EIxPPnbkTG2GkrzJmK2pE8Nh3Cs3fVC9zjojZtj9XtZID
RZYMjk+2l/1xZEEnQfUK8SBzRx3DtHSG5dDJr7IHaqWfphVI2BGQwgujsGsbuu4r
rKKv6k7tyAXMXa3KHNzTcf7msmTnn3cipWnaBY3OtJ4Q088aXCSKxti1l0zFSjGN
UXzgECgLeNMSbWEEZZ0TqBEY+ye8YBpV6/Q0cv6YfFfl0yr16tqsStj9vFNR7FFS
hicmJpxzRvTwuvVOV0GpgxNiA51aqnaxXI4lDNHfCKHQ97Hq50BeNkd3almuYjgO
F8e53wz2aopNqBT4WSOSLi4MAZbGQRG7kiVCyl2IBPnBMkoShBqWqdF6BWLuYodc
+xLePf7j6ThMA1q1+JuLpv2rpvsEPrWyoYTHAdRGqee37XiKaUQ=
=J71+
-----END PGP SIGNATURE-----

--xulyxrxhy6ccwuiy--


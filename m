Return-Path: <linux-pm+bounces-42101-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMrFAx97g2nyngMAu9opvQ
	(envelope-from <linux-pm+bounces-42101-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 18:00:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3AEAAFD
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1749C3049165
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213F33E36C;
	Wed,  4 Feb 2026 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrTz+Iue"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B533E344
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224097; cv=none; b=EZoW/gGzdBW3MjzaytmS7mwyPmIdGbdtCX+yr8ChjiDQo5uKGjQgTF1UIEexeVPnC9c1xUW8RRQk7z5Swk1WhY9NfVOUfpsUuZ7IuX5LDA9BkCm1Qeo4Z73/POgmXJAFNLztifSaX63lAJ2povLG+PrbgJ2PdpLd+S1C9LUfALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224097; c=relaxed/simple;
	bh=iiapcZ/DGEP/cwCQIyrmgJLGryp0jX6aBFaErKOZYUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X5Ka6pqJYdpaccZ5n3EaDSW1GQy+cMH4vNgYm7nwq2EiKj+GzJxc3QbJXXpMca+Fe6a6eNrQnXRhcYdpztrFuTId3qo3vN7fkS6356B4wo0eE+nh8TU2zvAF+N96eo2zTiV/rEJAq7My/lSOnBiEeBCY8hK6DSwXuHwqSrZLCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QrTz+Iue; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8946e0884afso654356d6.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770224095; x=1770828895; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pj16dI3qaH0YVk42KgqHTQPPBcA62LkSoA1Q8YJmVwU=;
        b=QrTz+Iuej7m3JtXVBuDN/j3zVnZaMVvrwBcGCoIZzHXXF0X3grWj4n051n0GxuvvBJ
         TcIcvZkKrCU1pxouG+OuX84eZKBtv7rKrZfZmmLJYbIe2NHTSxWAYyL+Db6S8RSoINeh
         scifuex8SSK7ITLkwfUFuuPwyLgMYoZDI8kGMeVk6ipOaj20v2no68qxssbombxj9iQ7
         bLsHeaMskGEbux2dU05tqNIal7RxZFjZeUCwp66VL5QYPS+2HzXLzNw5bWvtdqiCI36a
         wGLmuzmgqW199JyV6fnuIbpsxoyxlbW/A7zPvXWkwTn3GQ1ucQN3jnzrNp1xT7zhxfQP
         tw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224095; x=1770828895;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pj16dI3qaH0YVk42KgqHTQPPBcA62LkSoA1Q8YJmVwU=;
        b=AvHIgV0sO3rB1WZOuL+n+dbylZ6/tyMfvdt8J1/cDqrgbHxAsod5mVc/eJnx9/SfRU
         ujHyBbFVALtftJg/8vU4FU3jYzwUngsl8ukoGr5KLDbYkJql2+x5hc1bMKZ5RMT9r420
         VZluNv3vO9SWdwwUdfqXZPBxJdAQRqwJ/WX5wnEwPiMnl4/1GsNzsUALrmonx8Nn3mCu
         SOde4NqEankeK+Eys0RGU8XYyBkqkDzB2uE65xYBIl0lNzt5HalTaP/lnJoM9Ox5o4c2
         rRXl+FTgvybZkm7arDyv+YMe9RAZC9mHI0ibHBcSGBT+T5WViXjFsCOk9p3d3Iuxjva3
         bZZw==
X-Forwarded-Encrypted: i=1; AJvYcCW/ISVrNrjIsvSrrcXt20U3fFrevw+YEYln6m6gP1krC8twgitq+CYnZW6T0tYoazaSjfM0IYj+Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJL8PN7eZC5qXboIC5pyB80cg+p0glEaN4yotM33FXMlyObbn
	XeXRC1T8VMFXdSFfp6g/HFTAYp+eO5joqEzRJoddge3sbs2uEoYUazh1HyMilWCooi8=
X-Gm-Gg: AZuq6aK5RG7GbAtwADFw8OkG2NSL78Gmd72IzDcOthNPSzE3GcGHeeZWOPysPFNos+t
	q2EQWQekajx4WeOJT3JT9Dbti09beLXKpmVbBSpOqh1gE7z2xZ5HyxY/WUwfgW+q/vX1UzVyEq6
	xHK0/KgoBXdDeYSgQgkTjjhACT6QIT+srD+TO05h0qUt4B7Wfzp5ljai6RtxddXAYZhqXqOc5HC
	CKjksxmNDt8fvAWO5RxBoj7Im7pA+SNIGR0DcKQk9QcTYRhY6ztW7e4R4MgJ3TgfdVERCwOtpX+
	O2KyrFuBn8BE3rnf6u795bMKUzmG9crHZ8wZfD8CsaBtWVZsEw9tyGvuV0Gx9Y4VeYcxUayUIt6
	6t6sA4kZvbg5zQebhK7eIAh9ZSXyIx5/go6/4h1naRKHeAVFFSrElhsxB/X83Q6uw65NFEo0/uj
	xiMxANgqG7/O5i2PAy3A==
X-Received: by 2002:a05:6214:2469:b0:894:7051:bd9d with SMTP id 6a1803df08f44-895220f553bmr47201306d6.9.1770224095252;
        Wed, 04 Feb 2026 08:54:55 -0800 (PST)
Received: from draszik.lan ([212.129.76.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521cf87fcsm25696886d6.30.2026.02.04.08.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:54:54 -0800 (PST)
Message-ID: <e34d429e27392eba894b9592724a77fa82fc8009.camel@linaro.org>
Subject: Re: [PATCH v2 08/12] leds: flash: add support for Samsung S2M
 series PMIC flash LED device
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Lee Jones
 <lee@kernel.org>,  Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo
 Choi	 <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Jonathan Corbet	 <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Wed, 04 Feb 2026 16:55:11 +0000
In-Reply-To: <20260126-s2mu005-pmic-v2-8-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
	 <20260126-s2mu005-pmic-v2-8-78f1a75f547a@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42101-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,disroot.org:email]
X-Rspamd-Queue-Id: 6BB3AEAAFD
X-Rspamd-Action: no action

Hi,

On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
> Add support for flash LEDs found in certain Samsung S2M series PMICs.
> The device has two channels for LEDs, typically for the back and front
> cameras in mobile devices. Both channels can be independently
> controlled, and can be operated in torch or flash modes.
>=20
> The driver includes initial support for the S2MU005 PMIC flash LEDs.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> =C2=A0drivers/leds/flash/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 12 ++
> =C2=A0drivers/leds/flash/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/leds/flash/leds-s2m-flash.c | 410 +++++++++++++++++++++++++=
+++++++++++
> =C2=A03 files changed, 423 insertions(+)
>=20
> diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
> index 5e08102a67841..be62e05277429 100644
> --- a/drivers/leds/flash/Kconfig
> +++ b/drivers/leds/flash/Kconfig
> @@ -114,6 +114,18 @@ config LEDS_RT8515
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le
> =C2=A0	=C2=A0 will be called leds-rt8515.
> =C2=A0
> +config LEDS_S2M_FLASH
> +	tristate "Samsung S2M series PMICs flash/torch LED support"
> +	depends on LEDS_CLASS
> +	depends on MFD_SEC_CORE
> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> +	select REGMAP_IRQ
> +	help
> +	=C2=A0 This option enables support for the flash/torch LEDs found in
> +	=C2=A0 certain Samsung S2M series PMICs, such as the S2MU005. It has
> +	=C2=A0 a LED channel dedicated for every physical LED. The LEDs can
> +	=C2=A0 be controlled in flash and torch modes.
> +
> =C2=A0config LEDS_SGM3140
> =C2=A0	tristate "LED support for the SGM3140"
> =C2=A0	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
> index 712fb737a428e..44e6c1b4beb37 100644
> --- a/drivers/leds/flash/Makefile
> +++ b/drivers/leds/flash/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_LEDS_MAX77693)	+=3D leds-max77693.o
> =C2=A0obj-$(CONFIG_LEDS_QCOM_FLASH)	+=3D leds-qcom-flash.o
> =C2=A0obj-$(CONFIG_LEDS_RT4505)	+=3D leds-rt4505.o
> =C2=A0obj-$(CONFIG_LEDS_RT8515)	+=3D leds-rt8515.o
> +obj-$(CONFIG_LEDS_S2M_FLASH)	+=3D leds-s2m-flash.o
> =C2=A0obj-$(CONFIG_LEDS_SGM3140)	+=3D leds-sgm3140.o
> =C2=A0obj-$(CONFIG_LEDS_SY7802)	+=3D leds-sy7802.o
> =C2=A0obj-$(CONFIG_LEDS_TPS6131X)	+=3D leds-tps6131x.o
> diff --git a/drivers/leds/flash/leds-s2m-flash.c b/drivers/leds/flash/led=
s-s2m-flash.c
> new file mode 100644
> index 0000000000000..1be2745c475bf
> --- /dev/null
> +++ b/drivers/leds/flash/leds-s2m-flash.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Flash and Torch LED Driver for Samsung S2M series PMICs.
> + *
> + * Copyright (c) 2015 Samsung Electronics Co., Ltd
> + * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
> + */
> +
> +#include <linux/container_of.h>
> +#include <linux/led-class-flash.h>
> +#include <linux/mfd/samsung/core.h>
> +#include <linux/mfd/samsung/s2mu005.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <media/v4l2-flash-led-class.h>
> +
> +#define MAX_CHANNELS	2
> +
> +struct s2m_fled {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct led_classdev_flash cdev;
> +	struct v4l2_flash *v4l2_flash;
> +	struct mutex lock;

Please add a (brief) comment describing what the mutex protects.

> +	const struct s2m_fled_spec *spec;
> +	unsigned int pmic_revision;
> +	u8 channel;
> +	u8 flash_brightness;
> +	u8 flash_timeout;
> +};
> +
> +struct s2m_fled_spec {
> +	u8 num_channels;
> +	u32 torch_max_brightness;
> +	u32 flash_min_current_ua;
> +	u32 flash_max_current_ua;
> +	u32 flash_min_timeout_us;
> +	u32 flash_max_timeout_us;
> +	int (*torch_brightness_set_blocking)(struct led_classdev *led_cdev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 enum led_brightness brightness);
> +	const struct led_flash_ops *flash_ops;
> +};
> +
> +static struct led_classdev_flash *to_cdev_flash(struct led_classdev *cde=
v)
> +{
> +	return container_of(cdev, struct led_classdev_flash, led_cdev);
> +}
> +
> +static struct s2m_fled *to_led_priv(struct led_classdev_flash *cdev)
> +{
> +	return container_of(cdev, struct s2m_fled, cdev);
> +}
> +
> +static int s2m_fled_flash_brightness_set(struct led_classdev_flash *cdev=
,
> +					 u32 brightness)
> +{
> +	struct s2m_fled *priv =3D to_led_priv(cdev);
> +	struct led_flash_setting *setting =3D &cdev->brightness;
> +
> +	priv->flash_brightness =3D (brightness - setting->min) / setting->step;
> +
> +	return 0;
> +}
> +
> +static int s2m_fled_flash_timeout_set(struct led_classdev_flash *cdev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 timeout)
> +{
> +	struct s2m_fled *priv =3D to_led_priv(cdev);
> +	struct led_flash_setting *setting =3D &cdev->timeout;
> +
> +	priv->flash_timeout =3D (timeout - setting->min) / setting->step;
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
> +static int s2m_fled_flash_external_strobe_set(struct v4l2_flash *v4l2_fl=
ash,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool enable)
> +{
> +	struct s2m_fled *priv =3D to_led_priv(v4l2_flash->fled_cdev);
> +
> +	mutex_lock(&priv->lock);
> +
> +	priv->cdev.ops->strobe_set(&priv->cdev, enable);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_flash_ops s2m_fled_v4l2_flash_ops =3D {
> +	.external_strobe_set =3D s2m_fled_flash_external_strobe_set,
> +};
> +#else
> +static const struct v4l2_flash_ops s2m_fled_v4l2_flash_ops;
> +#endif
> +
> +static int s2mu005_fled_torch_brightness_set(struct led_classdev *cdev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 enum led_brightness value)
> +{
> +	struct s2m_fled *priv =3D to_led_priv(to_cdev_flash(cdev));
> +	struct regmap *regmap =3D priv->regmap;
> +	u8 channel =3D priv->channel;
> +	unsigned int reg_enable;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	/*
> +	 * Get the LED enable register address. Revision EVT0 has the
> +	 * register at CTRL4, while EVT1 and higher have it at CTRL6.
> +	 */
> +	if (priv->pmic_revision =3D=3D 0)
> +		reg_enable =3D S2MU005_REG_FLED_CTRL4;
> +	else
> +		reg_enable =3D S2MU005_REG_FLED_CTRL6;

You could REG_FIELD() and friends for this and everywhere else with
similar if / else.

> +
> +	if (value =3D=3D LED_OFF) {
> +		ret =3D regmap_clear_bits(regmap, reg_enable,
> +					S2MU005_FLED_TORCH_EN(channel));
> +		if (ret < 0)
> +			dev_err(priv->dev, "failed to disable torch LED\n");
> +		goto unlock;
> +	}
> +
> +	ret =3D regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL1(channel),
> +				 S2MU005_FLED_TORCH_IOUT,
> +				 FIELD_PREP(S2MU005_FLED_TORCH_IOUT, value - 1));
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to set torch current\n");
> +		goto unlock;
> +	}
> +
> +	ret =3D regmap_set_bits(regmap, reg_enable, S2MU005_FLED_TORCH_EN(chann=
el));
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to enable torch LED\n");
> +		goto unlock;
> +	}
> +
> +unlock:
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static int s2mu005_fled_flash_strobe_set(struct led_classdev_flash *cdev=
,
> +					 bool state)
> +{
> +	struct s2m_fled *priv =3D to_led_priv(cdev);
> +	struct regmap *regmap =3D priv->regmap;
> +	u8 channel =3D priv->channel;
> +	unsigned int reg_enable;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	/*
> +	 * Get the LED enable register address. Revision EVT0 has the
> +	 * register at CTRL4, while EVT1 and higher have it at CTRL6.
> +	 */
> +	if (priv->pmic_revision =3D=3D 0)
> +		reg_enable =3D S2MU005_REG_FLED_CTRL4;
> +	else
> +		reg_enable =3D S2MU005_REG_FLED_CTRL6;
> +
> +	ret =3D regmap_clear_bits(regmap, reg_enable, S2MU005_FLED_FLASH_EN(cha=
nnel));
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to disable flash LED\n");
> +		goto unlock;
> +	}
> +
> +	if (!state)
> +		goto unlock;
> +
> +	ret =3D regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL0(channel),
> +				 S2MU005_FLED_FLASH_IOUT,
> +				 FIELD_PREP(S2MU005_FLED_FLASH_IOUT,
> +					=C2=A0=C2=A0=C2=A0 priv->flash_brightness));
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to set flash brightness\n");
> +		goto unlock;
> +	}
> +
> +	ret =3D regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL3(channel),
> +				 S2MU005_FLED_FLASH_TIMEOUT,
> +				 FIELD_PREP(S2MU005_FLED_FLASH_TIMEOUT,
> +					=C2=A0=C2=A0=C2=A0 priv->flash_timeout));
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to set flash timeout\n");
> +		goto unlock;
> +	}
> +
> +	ret =3D regmap_set_bits(regmap, reg_enable, S2MU005_FLED_FLASH_EN(chann=
el));
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to enable flash LED\n");
> +		goto unlock;
> +	}
> +
> +unlock:
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static int s2mu005_fled_flash_strobe_get(struct led_classdev_flash *cdev=
,
> +					 bool *state)
> +{
> +	struct s2m_fled *priv =3D to_led_priv(cdev);
> +	struct regmap *regmap =3D priv->regmap;
> +	u8 channel =3D priv->channel;
> +	u32 val;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret =3D regmap_read(regmap, S2MU005_REG_FLED_STATUS, &val);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to fetch LED status");
> +		goto unlock;
> +	}
> +
> +	*state =3D !!(val & S2MU005_FLED_FLASH_STATUS(channel));
> +
> +unlock:
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static const struct led_flash_ops s2mu005_fled_flash_ops =3D {
> +	.flash_brightness_set =3D s2m_fled_flash_brightness_set,
> +	.timeout_set =3D s2m_fled_flash_timeout_set,
> +	.strobe_set =3D s2mu005_fled_flash_strobe_set,
> +	.strobe_get =3D s2mu005_fled_flash_strobe_get,
> +};
> +
> +static const struct s2m_fled_spec s2mu005_fled_spec =3D {
> +	.num_channels =3D 2,
> +	.torch_max_brightness =3D 16,
> +	.flash_min_current_ua =3D 25000,
> +	.flash_max_current_ua =3D 375000, /* 400000 causes flickering */
> +	.flash_min_timeout_us =3D 62000,
> +	.flash_max_timeout_us =3D 992000,
> +	.torch_brightness_set_blocking =3D s2mu005_fled_torch_brightness_set,
> +	.flash_ops =3D &s2mu005_fled_flash_ops,
> +};
> +
> +static int s2m_fled_init_channel(struct device *dev, struct fwnode_handl=
e *fwnp,
> +				 struct s2m_fled *priv)
> +{
> +	struct led_classdev *led =3D &priv->cdev.led_cdev;
> +	struct led_init_data init_data =3D {};
> +	struct v4l2_flash_config v4l2_cfg =3D {};
> +	int ret;
> +
> +	led->max_brightness =3D priv->spec->torch_max_brightness;
> +	led->brightness_set_blocking =3D priv->spec->torch_brightness_set_block=
ing;
> +	led->flags |=3D LED_DEV_CAP_FLASH;
> +
> +	priv->cdev.timeout.min =3D priv->spec->flash_min_timeout_us;
> +	priv->cdev.timeout.step =3D priv->spec->flash_min_timeout_us;
> +	priv->cdev.timeout.max =3D priv->spec->flash_max_timeout_us;
> +	priv->cdev.timeout.val =3D priv->spec->flash_max_timeout_us;
> +
> +	priv->cdev.brightness.min =3D priv->spec->flash_min_current_ua;
> +	priv->cdev.brightness.step =3D priv->spec->flash_min_current_ua;
> +	priv->cdev.brightness.max =3D priv->spec->flash_max_current_ua;
> +	priv->cdev.brightness.val =3D priv->spec->flash_max_current_ua;
> +
> +	s2m_fled_flash_timeout_set(&priv->cdev, priv->cdev.timeout.val);
> +	s2m_fled_flash_brightness_set(&priv->cdev, priv->cdev.brightness.val);
> +
> +	priv->cdev.ops =3D priv->spec->flash_ops;
> +
> +	init_data.fwnode =3D fwnp;
> +	ret =3D devm_led_classdev_flash_register_ext(dev, &priv->cdev, &init_da=
ta);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to create LED flash device\n");
> +		return ret;

dev_err_probe()?

> +	}
> +
> +	v4l2_cfg.intensity.min =3D priv->spec->flash_min_current_ua;
> +	v4l2_cfg.intensity.step =3D priv->spec->flash_min_current_ua;
> +	v4l2_cfg.intensity.max =3D priv->spec->flash_max_current_ua;
> +	v4l2_cfg.intensity.val =3D priv->spec->flash_max_current_ua;
> +
> +	v4l2_cfg.has_external_strobe =3D true;
> +
> +	priv->v4l2_flash =3D v4l2_flash_init(dev, fwnp, &priv->cdev,
> +					=C2=A0=C2=A0 &s2m_fled_v4l2_flash_ops, &v4l2_cfg);
> +	if (IS_ERR(priv->v4l2_flash)) {
> +		dev_err(dev, "failed to create V4L2 flash device\n");
> +		v4l2_flash_release(priv->v4l2_flash);
> +		return PTR_ERR(priv->v4l2_flash);

dev_err_probe()?

> +	}
> +
> +	return devm_add_action_or_reset(dev, (void *)v4l2_flash_release,
> +					priv->v4l2_flash);

maybe add dev_err_probe() here, and drop the extra message in s2m_fled_prob=
e().

> +}
> +
> +static int s2m_fled_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct sec_pmic_dev *pmic_drvdata =3D dev_get_drvdata(dev->parent);
> +	struct s2m_fled *priv;
> +	struct fwnode_handle *child;
> +	struct regmap *regmap;
> +	const struct s2m_fled_spec *spec;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv) * MAX_CHANNELS, GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver private\=
n");
> +
> +	platform_set_drvdata(pdev, priv);
> +	regmap =3D pmic_drvdata->regmap_pmic;
> +
> +	switch (platform_get_device_id(pdev)->driver_data) {
> +	case S2MU005:
> +		spec =3D &s2mu005_fled_spec;
> +		/* Enable the LED channels. */
> +		ret =3D regmap_set_bits(regmap, S2MU005_REG_FLED_CTRL1,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S2MU005_FLED_CH_EN);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "failed to enable LED channels\n");
> +		break;
> +	default:
> +		return dev_err_probe(dev, -ENODEV,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "device type %d is not supported by driver\=
n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 pmic_drvdata->device_type);
> +	}
> +
> +	device_for_each_child_node(dev, child) {
> +		u32 reg;
> +
> +		if (fwnode_property_read_u32(child, "reg", &reg))
> +			goto next_child;
> +
> +		if (reg >=3D spec->num_channels) {
> +			dev_warn(dev, "channel %d is non-existent\n", reg);
> +			goto next_child;
> +		}
> +
> +		if (priv[reg].dev) {
> +			dev_warn(dev, "duplicate node for channel %d\n", reg);
> +			goto next_child;
> +		}
> +
> +		priv[reg].dev =3D dev;
> +		priv[reg].regmap =3D regmap;
> +		priv[reg].channel =3D (u8)reg;
> +		priv[reg].spec =3D spec;
> +		priv[reg].pmic_revision =3D pmic_drvdata->revision;
> +
> +		ret =3D devm_mutex_init(dev, &priv[reg].lock);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to create mutex lock\n");
> +
> +		ret =3D s2m_fled_init_channel(dev, child, &priv[reg]);
> +		if (ret < 0)
> +			dev_warn(dev, "channel init failed (%d)\n", ret);

s2m_fled_init_channel() already prints a message on (most) errors, and then
there's another one here. Also, is it really OK to continue ignoring the
error?

> +
> +next_child:
> +		fwnode_handle_put(child);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id s2m_fled_id_table[] =3D {
> +	{ "s2mu005-flash", S2MU005 },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(platform, s2m_fled_id_table);
> +
> +#ifdef CONFIG_OF

I believe the general recommendation is to not use ifdef CONFIG_OF

Cheers,
Andre

> +/*
> + * Device is instantiated through parent MFD device and device matching
> + * is done through platform_device_id.
> + *
> + * However if device's DT node contains proper compatible and driver is
> + * built as a module, then the *module* matching will be done through DT
> + * aliases. This requires of_device_id table. In the same time this will
> + * not change the actual *device* matching so do not add .of_match_table=
.
> + */
> +static const struct of_device_id s2m_fled_of_match_table[] =3D {
> +	{
> +		.compatible =3D "samsung,s2mu005-flash",
> +		.data =3D (void *)S2MU005,
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, s2m_fled_of_match_table);
> +#endif
> +
> +static struct platform_driver s2m_fled_driver =3D {
> +	.driver =3D {
> +		.name =3D "s2m-flash",
> +	},
> +	.probe =3D s2m_fled_probe,
> +	.id_table =3D s2m_fled_id_table,
> +};
> +module_platform_driver(s2m_fled_driver);
> +
> +MODULE_DESCRIPTION("Flash/Torch LED Driver For Samsung S2M Series PMICs"=
);
> +MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
> +MODULE_LICENSE("GPL");


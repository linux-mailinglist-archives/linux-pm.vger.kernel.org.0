Return-Path: <linux-pm+bounces-42162-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMaHLhDDhGk45QMAu9opvQ
	(envelope-from <linux-pm+bounces-42162-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 17:19:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DAF5228
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2817302A6F3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C643636D;
	Thu,  5 Feb 2026 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NCbFoffT"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C76407583;
	Thu,  5 Feb 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308210; cv=none; b=nGxL2FoMCbnxs0wFDZzZhtYTG8ITeSZoqooiD3NMnf5gDNKhgI62oTrzq2xUpuPJN3Z4L8ANIdHDaQupDCuyQyT6tDIRzD+wH16ayEh1WC28PPsRcKOPoQX0ULnbtQufoYTnywZi8yD9pCCNAJGgvq9IiYubkyhAd+GMJ4uM42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308210; c=relaxed/simple;
	bh=9q/yPf7X0hHDzw/Po/8rdQeCeC5OLx+uo6E2CxQ7bsk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jzBQEF5c/E/Sq0tO0V+xuwHSqgpKpMZ69CWD/iUFiLyJdiOmgL0rROGbrbuugcnb/2g2LG5t7+qFLLa1DAaJfezWC2bbI7m0rBwoamgZ+zbQ+8rjauVgiCsx9wIDRhwBJGup4d6+Vo/uj0mgtNUuHah25mdgT6ms23BZgjmhu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NCbFoffT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4C8CE263EA;
	Thu,  5 Feb 2026 17:16:48 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3DltKUeKJnu; Thu,  5 Feb 2026 17:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770308206; bh=9q/yPf7X0hHDzw/Po/8rdQeCeC5OLx+uo6E2CxQ7bsk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=NCbFoffTpWNQ8jeNE+pUk6StBGacIJM5uXTuXA6RPSsDH/ulSq5XvrEGH//LpDhtd
	 XP7Vat9d6h+btryzBGiWGnWYIBNfDW5DRFv75dkCNmXSyqejOjIAI39bk95jKQYqVQ
	 52MvGgKSIjT5vYglotRaTBihjJLe9WMBx4C+8yZu5Ss+yRTwHM42B6PtgdjUCq1I1s
	 ed2JNOjpY10Svt+xoIlcm4Qt+lLFJIIbnTF9tlnEM3KWK5zDdm25congLT3Fj5+pse
	 8zDanL0QuD6Cml0XHz1veCjMSO4XkW3osw5j1sAsNckyKMr+gIHFA+oTrKhWpzZiDy
	 RDDOVZFB+BpSg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 21:46:34 +0530
Message-Id: <DG75VP6IIUXD.1VA6YSMNTPJQ6@disroot.org>
Subject: Re: [PATCH v2 08/12] leds: flash: add support for Samsung S2M
 series PMIC flash LED device
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, "Kaustabh
 Chakraborty" <kauschluss@disroot.org>, "Lee Jones" <lee@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "MyungJoo Ham" <myungjoo.ham@samsung.com>, "Chanwoo Choi"
 <cw00.choi@samsung.com>, "Sebastian Reichel" <sre@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>
Cc: <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-8-78f1a75f547a@disroot.org>
 <e34d429e27392eba894b9592724a77fa82fc8009.camel@linaro.org>
In-Reply-To: <e34d429e27392eba894b9592724a77fa82fc8009.camel@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42162-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,disroot.org:email,disroot.org:dkim,disroot.org:mid]
X-Rspamd-Queue-Id: 545DAF5228
X-Rspamd-Action: no action

On 2026-02-04 16:55 +00:00, Andr=C3=A9 Draszik wrote:
> Hi,
>
> On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
>> Add support for flash LEDs found in certain Samsung S2M series PMICs.
>> The device has two channels for LEDs, typically for the back and front
>> cameras in mobile devices. Both channels can be independently
>> controlled, and can be operated in torch or flash modes.
>>=20
>> The driver includes initial support for the S2MU005 PMIC flash LEDs.
>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>> =C2=A0drivers/leds/flash/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 12 ++
>> =C2=A0drivers/leds/flash/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0drivers/leds/flash/leds-s2m-flash.c | 410 ++++++++++++++++++++++++=
++++++++++++
>> =C2=A03 files changed, 423 insertions(+)
>>=20
>> diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
>> index 5e08102a67841..be62e05277429 100644
>> --- a/drivers/leds/flash/Kconfig
>> +++ b/drivers/leds/flash/Kconfig
>> @@ -114,6 +114,18 @@ config LEDS_RT8515
>> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the mod=
ule
>> =C2=A0	=C2=A0 will be called leds-rt8515.
>> =C2=A0
>> +config LEDS_S2M_FLASH
>> +	tristate "Samsung S2M series PMICs flash/torch LED support"
>> +	depends on LEDS_CLASS
>> +	depends on MFD_SEC_CORE
>> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
>> +	select REGMAP_IRQ
>> +	help
>> +	=C2=A0 This option enables support for the flash/torch LEDs found in
>> +	=C2=A0 certain Samsung S2M series PMICs, such as the S2MU005. It has
>> +	=C2=A0 a LED channel dedicated for every physical LED. The LEDs can
>> +	=C2=A0 be controlled in flash and torch modes.
>> +
>> =C2=A0config LEDS_SGM3140
>> =C2=A0	tristate "LED support for the SGM3140"
>> =C2=A0	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
>> diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
>> index 712fb737a428e..44e6c1b4beb37 100644
>> --- a/drivers/leds/flash/Makefile
>> +++ b/drivers/leds/flash/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_LEDS_MAX77693)	+=3D leds-max77693.o
>> =C2=A0obj-$(CONFIG_LEDS_QCOM_FLASH)	+=3D leds-qcom-flash.o
>> =C2=A0obj-$(CONFIG_LEDS_RT4505)	+=3D leds-rt4505.o
>> =C2=A0obj-$(CONFIG_LEDS_RT8515)	+=3D leds-rt8515.o
>> +obj-$(CONFIG_LEDS_S2M_FLASH)	+=3D leds-s2m-flash.o
>> =C2=A0obj-$(CONFIG_LEDS_SGM3140)	+=3D leds-sgm3140.o
>> =C2=A0obj-$(CONFIG_LEDS_SY7802)	+=3D leds-sy7802.o
>> =C2=A0obj-$(CONFIG_LEDS_TPS6131X)	+=3D leds-tps6131x.o
>> diff --git a/drivers/leds/flash/leds-s2m-flash.c b/drivers/leds/flash/le=
ds-s2m-flash.c
>> new file mode 100644
>> index 0000000000000..1be2745c475bf
>> --- /dev/null
>> +++ b/drivers/leds/flash/leds-s2m-flash.c
>> @@ -0,0 +1,410 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Flash and Torch LED Driver for Samsung S2M series PMICs.
>> + *
>> + * Copyright (c) 2015 Samsung Electronics Co., Ltd
>> + * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
>> + */
>> +
>> +#include <linux/container_of.h>
>> +#include <linux/led-class-flash.h>
>> +#include <linux/mfd/samsung/core.h>
>> +#include <linux/mfd/samsung/s2mu005.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <media/v4l2-flash-led-class.h>
>> +
>> +#define MAX_CHANNELS	2
>> +
>> +struct s2m_fled {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	struct led_classdev_flash cdev;
>> +	struct v4l2_flash *v4l2_flash;
>> +	struct mutex lock;
>
> Please add a (brief) comment describing what the mutex protects.

The mutex object prevents the concurrent access of flash control
registers by the LED and V4L2 subsystems. -- will add this.

>> +
>> +	/*
>> +	 * Get the LED enable register address. Revision EVT0 has the
>> +	 * register at CTRL4, while EVT1 and higher have it at CTRL6.
>> +	 */
>> +	if (priv->pmic_revision =3D=3D 0)
>> +		reg_enable =3D S2MU005_REG_FLED_CTRL4;
>> +	else
>> +		reg_enable =3D S2MU005_REG_FLED_CTRL6;
>
> You could REG_FIELD() and friends for this and everywhere else with
> similar if / else.
>

REG_FIELD(), from what I understood, is for selecting a bit field inside
a single register. However this code chooses between two separate
registers. I believe your interpretation was incorrect? Please clarify.

>> +static int s2m_fled_init_channel(struct device *dev, struct fwnode_hand=
le *fwnp,
>> +				 struct s2m_fled *priv)
>> +{
>> +	struct led_classdev *led =3D &priv->cdev.led_cdev;
>> +	struct led_init_data init_data =3D {};
>> +	struct v4l2_flash_config v4l2_cfg =3D {};
>> +	int ret;
>> +
>> +	led->max_brightness =3D priv->spec->torch_max_brightness;
>> +	led->brightness_set_blocking =3D priv->spec->torch_brightness_set_bloc=
king;
>> +	led->flags |=3D LED_DEV_CAP_FLASH;
>> +
>> +	priv->cdev.timeout.min =3D priv->spec->flash_min_timeout_us;
>> +	priv->cdev.timeout.step =3D priv->spec->flash_min_timeout_us;
>> +	priv->cdev.timeout.max =3D priv->spec->flash_max_timeout_us;
>> +	priv->cdev.timeout.val =3D priv->spec->flash_max_timeout_us;
>> +
>> +	priv->cdev.brightness.min =3D priv->spec->flash_min_current_ua;
>> +	priv->cdev.brightness.step =3D priv->spec->flash_min_current_ua;
>> +	priv->cdev.brightness.max =3D priv->spec->flash_max_current_ua;
>> +	priv->cdev.brightness.val =3D priv->spec->flash_max_current_ua;
>> +
>> +	s2m_fled_flash_timeout_set(&priv->cdev, priv->cdev.timeout.val);
>> +	s2m_fled_flash_brightness_set(&priv->cdev, priv->cdev.brightness.val);
>> +
>> +	priv->cdev.ops =3D priv->spec->flash_ops;
>> +
>> +	init_data.fwnode =3D fwnp;
>> +	ret =3D devm_led_classdev_flash_register_ext(dev, &priv->cdev, &init_d=
ata);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to create LED flash device\n");
>> +		return ret;
>
> dev_err_probe()?
>
>> +	}
>> +
>> +	v4l2_cfg.intensity.min =3D priv->spec->flash_min_current_ua;
>> +	v4l2_cfg.intensity.step =3D priv->spec->flash_min_current_ua;
>> +	v4l2_cfg.intensity.max =3D priv->spec->flash_max_current_ua;
>> +	v4l2_cfg.intensity.val =3D priv->spec->flash_max_current_ua;
>> +
>> +	v4l2_cfg.has_external_strobe =3D true;
>> +
>> +	priv->v4l2_flash =3D v4l2_flash_init(dev, fwnp, &priv->cdev,
>> +					=C2=A0=C2=A0 &s2m_fled_v4l2_flash_ops, &v4l2_cfg);
>> +	if (IS_ERR(priv->v4l2_flash)) {
>> +		dev_err(dev, "failed to create V4L2 flash device\n");
>> +		v4l2_flash_release(priv->v4l2_flash);
>> +		return PTR_ERR(priv->v4l2_flash);
>
> dev_err_probe()?
>
>> +	}
>> +
>> +	return devm_add_action_or_reset(dev, (void *)v4l2_flash_release,
>> +					priv->v4l2_flash);
>
> maybe add dev_err_probe() here, and drop the extra message in s2m_fled_pr=
obe().
>
>> +}
>> +
>> +static int s2m_fled_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct sec_pmic_dev *pmic_drvdata =3D dev_get_drvdata(dev->parent);
>> +	struct s2m_fled *priv;
>> +	struct fwnode_handle *child;
>> +	struct regmap *regmap;
>> +	const struct s2m_fled_spec *spec;
>> +	int ret;
>> +
>> +	priv =3D devm_kzalloc(dev, sizeof(*priv) * MAX_CHANNELS, GFP_KERNEL);
>> +	if (!priv)
>> +		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver private=
\n");
>> +
>> +	platform_set_drvdata(pdev, priv);
>> +	regmap =3D pmic_drvdata->regmap_pmic;
>> +
>> +	switch (platform_get_device_id(pdev)->driver_data) {
>> +	case S2MU005:
>> +		spec =3D &s2mu005_fled_spec;
>> +		/* Enable the LED channels. */
>> +		ret =3D regmap_set_bits(regmap, S2MU005_REG_FLED_CTRL1,
>> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S2MU005_FLED_CH_EN);
>> +		if (ret < 0)
>> +			return dev_err_probe(dev, ret, "failed to enable LED channels\n");
>> +		break;
>> +	default:
>> +		return dev_err_probe(dev, -ENODEV,
>> +				=C2=A0=C2=A0=C2=A0=C2=A0 "device type %d is not supported by driver=
\n",
>> +				=C2=A0=C2=A0=C2=A0=C2=A0 pmic_drvdata->device_type);
>> +	}
>> +
>> +	device_for_each_child_node(dev, child) {
>> +		u32 reg;
>> +
>> +		if (fwnode_property_read_u32(child, "reg", &reg))
>> +			goto next_child;
>> +
>> +		if (reg >=3D spec->num_channels) {
>> +			dev_warn(dev, "channel %d is non-existent\n", reg);
>> +			goto next_child;
>> +		}
>> +
>> +		if (priv[reg].dev) {
>> +			dev_warn(dev, "duplicate node for channel %d\n", reg);
>> +			goto next_child;
>> +		}
>> +
>> +		priv[reg].dev =3D dev;
>> +		priv[reg].regmap =3D regmap;
>> +		priv[reg].channel =3D (u8)reg;
>> +		priv[reg].spec =3D spec;
>> +		priv[reg].pmic_revision =3D pmic_drvdata->revision;
>> +
>> +		ret =3D devm_mutex_init(dev, &priv[reg].lock);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "failed to create mutex lock\n");
>> +
>> +		ret =3D s2m_fled_init_channel(dev, child, &priv[reg]);
>> +		if (ret < 0)
>> +			dev_warn(dev, "channel init failed (%d)\n", ret);
>
> s2m_fled_init_channel() already prints a message on (most) errors, and th=
en
> there's another one here. Also, is it really OK to continue ignoring the
> error?
>

The LED channels are supposed to be independent, so if one fails, the
others may still work.=20

But errors in s2m_fled_init_channel() is not-hardware related, so this
reasoning doesn't make sense. So I shall implement your changes.


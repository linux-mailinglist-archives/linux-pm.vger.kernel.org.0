Return-Path: <linux-pm+bounces-40216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF2CF502E
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 18:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AF79301D634
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD833E36E;
	Mon,  5 Jan 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EU1tkukJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53333BBDD
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634322; cv=none; b=X0AyvASW0ZB9ZrDgCVEWZApplr3RslgPlyUVwXP4H+KlnidAx8fS88l7Ngg+axG4Vk5fp57TCSIhMy5TpKCH2fCTKujqTXFcBMLBn29WkM1WeP80h++uqLGeSVrkrwS5D9/CCUzj1liuYSh7S9zmVTKCZNpzTvlIkf9vBB2tZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634322; c=relaxed/simple;
	bh=8Urss54SQemyl1UnvN+qN6F+GzbuvOZZAJg83t54Acg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gARrdYPelgvNI/mT1NMeaIMCjfTu5pTakj+TilBAhzzdEP2WzhTWHeZuuWkvCMhB7qqoYMkUt4BpP9c4KJyCi1b/ob09LbEgK7dF6PRrpgptwdB6XXKtUpMKVPcf5j17LlkNf81+Cyl/vhT1NUUzilymKDo5DKQd75lX/K9o7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EU1tkukJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6503b561daeso192811a12.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 09:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767634311; x=1768239111; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fxjRB9RFgti9QEFwWw+sCXCBRhSDyfakhFJ/62eHjdo=;
        b=EU1tkukJNUddCrj2VaeZBhAnmTCSwKuHdowvYYtaDikqhKqBQ35D2E/LEVO95z8YkI
         FUO/cUguXvQ8IbTPyYlMgeOxRBGC1N9rBCtOM1h2TZR7izvo+GOWwXC+28SNEvUql+A3
         IlbJAh9iMeR3miJM9090DKEdQlV692f2RiHt1JJGwAxvHjUY+AtkbK0oijzUls66MKKv
         LV3AKb+YtYf2Pla5p4msDvxeNJrmZySgxvGz9TR6tGtY0/YbyNqIdS9I3JxNmL6WmIvW
         XR0Kka20vBHEHyiinNFNLsUO03iQy6PBuUvi3qO42YPL7Acst/+4P+sTviFBC0Z7rv5J
         rDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634311; x=1768239111;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxjRB9RFgti9QEFwWw+sCXCBRhSDyfakhFJ/62eHjdo=;
        b=Hp6uJXCN1+9rrrQn9BUe6A3e2JM/KUZTClkgtfi7Om4CldTh1pB4GQdpKOKhiP2Q7A
         tiAphwNKxe67qlN4nJm5r8bB5ErF5ZXfTEFvtJ3TbvdfyaZRys2PhfTl3+iqETk8j2h1
         3NjaDozDIScX0bgQMuz1wLPcowEK0T9CuPyfPzMgdRY/DLXg28QrU2O9W8sb9fWSQltR
         0B21sVuOG9TXc73JtE+psyQF1mDvPv4ABqKyh9AoD5U8Zrxm/PNi6MC0psxmtxJ5Uxkt
         +b+DdMHgbdSqpY1ehCkL102cK+W0GtZO/5ncZCjn2PulrQPg6VXK/rigOpO7GEHgC9qA
         bprA==
X-Forwarded-Encrypted: i=1; AJvYcCWluIpn8kWktR2phPcJ72bJ/lcIRW+5o55WJxZ/bY/t2EMA0ySRnU69P882xhba6uUxDIqAwIFclQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1kvDoLyOIjMfTEIYXX8wcTfDVdd/gSo9kPxOR0Q6AOmSvRrP
	V16A60dAaVwCy//pTi+vi3YsfYUv8aXFzhPcfZtKK0eln5pTU2dmiI4YzUBOFW3vNIk=
X-Gm-Gg: AY/fxX6jw3174APByZ0brR4RfILKH1mW/GNeIPkM0DkIXzflTCRsxXyXLTh0JQomUPE
	DuuraNQNc4voPtp2M9vcIKgr2Xz3c2/dkSEaOnWqkuRBQHXCYvq5VD9S9VSMOwsWnntAPgp0geV
	p3Cc7YHK9aCzFePmtMeIovRDOPLqprpw3CXYu2xSLvTlAoVZQ9HSvh0SN364jiF60H5vWLillfa
	c66Mu96oeYGclUp9nf14p4QPpv9G6xlBjj/2Hba+P7DCNprEmOLY7UI21j7W0Xo96guMoAs7PQ3
	XJhgHUwYlPTIVlapGyBmHTVhBinU+4c02V8Bc2NpNtMxS47HO/gOcZ61FbvoULS9G+m/UZiaTAu
	LVSaCLFFEh4Hlw19Zv3esMtGk6jl5T42DfJyXM2kW2eHdIPTmSY9XtKDXlgBV1bhpPvncpucN6j
	EBL1Vd9Zs2UfcW55958Q==
X-Google-Smtp-Source: AGHT+IGkKXLAAsur6A4HtehUgmDaFqa9c5vn+9NObUDNmqi8f6o7714VngeOYiKEjS50fqmHFvg/lA==
X-Received: by 2002:a17:907:94d3:b0:b83:3773:e72a with SMTP id a640c23a62f3a-b8426a43d45mr49749966b.1.1767634310701;
        Mon, 05 Jan 2026 09:31:50 -0800 (PST)
Received: from draszik.lan ([212.129.74.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507618cc6fsm330165a12.27.2026.01.05.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:31:50 -0800 (PST)
Message-ID: <298ca35590d2180fdcf334f94964b6110e17c606.camel@linaro.org>
Subject: Re: [PATCH v3 4/5] power: supply: max77759: add charger driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Mon, 05 Jan 2026 17:32:24 +0000
In-Reply-To: <20251227-max77759-charger-v3-4-54e664f5ca92@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
	 <20251227-max77759-charger-v3-4-54e664f5ca92@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Amit,

I haven't done a full review, but a few things caught my eye.

On Sat, 2025-12-27 at 00:04 +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add support for MAX77759 battery charger driver. This is a 4A 1-Cell
> Li+/LiPoly dual input switch mode charger. While the device can support
> USB & wireless charger inputs, this implementation only supports USB
> input. This implementation supports both buck and boost modes.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0drivers/power/supply/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/power/supply/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/power/supply/max77759_charger.c | 764 +++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 782 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc731d37c8fe..26a9654ab75e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15539,6 +15539,12 @@ F:	drivers/mfd/max77759.c
> =C2=A0F:	drivers/nvmem/max77759-nvmem.c
> =C2=A0F:	include/linux/mfd/max77759.h
> =C2=A0
> +MAXIM MAX77759 BATTERY CHARGER DRIVER
> +M:	Amit Sunil Dhamne <amitsd@google.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/power/supply/max77759_charger.c
> +
> =C2=A0MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
> =C2=A0M:	Javier Martinez Canillas <javier@dowhile0.org>
> =C2=A0L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 92f9f7aae92f..e172fd980fde 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -1132,4 +1132,15 @@ config FUEL_GAUGE_MM8013
> =C2=A0	=C2=A0 the state of charge, temperature, cycle count, actual and d=
esign
> =C2=A0	=C2=A0 capacity, etc.
> =C2=A0
> +config CHARGER_MAX77759
> +	tristate "MAX77759 Charger Driver"
> +	depends on MFD_MAX77759 && REGULATOR
> +	default MFD_MAX77759
> +	help
> +	=C2=A0 Say M or Y here to enable the MAX77759 Charger Driver. MAX77759
> +	=C2=A0 charger is a function of the MAX77759 PMIC. This is a dual input
> +	=C2=A0 switch-mode charger. This driver supports buck and OTG boost mod=
es.
> +
> +	=C2=A0 If built as a module, it will be called max77759_charger.
> +

It might make sense to add this block near the existing MAX77... charger dr=
ivers,
while updating the tristate string and keeping alphabetical order of entrie=
s.

> =C2=A0endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index 4b79d5abc49a..6af905875ad5 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
> =C2=A0obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
> =C2=A0obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_smbx.o
> =C2=A0obj-$(CONFIG_FUEL_GAUGE_MM8013)	+=3D mm8013.o
> +obj-$(CONFIG_CHARGER_MAX77759)	+=3D max77759_charger.o
> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supp=
ly/max77759_charger.c
> new file mode 100644
> index 000000000000..3d255b069fb9
> --- /dev/null
> +++ b/drivers/power/supply/max77759_charger.c
> @@ -0,0 +1,764 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * max77759_charger.c - Battery charger driver for MAX77759 charger devi=
ce.
> + *
> + * Copyright 2025 Google LLC.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/max77759.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/string_choices.h>
> +
> +/* Default values for Fast Charge Current & Float Voltage */
> +#define CHG_CC_DEFAULT_UA			2266770
> +#define CHG_FV_DEFAULT_MV			4300
> +
> +#define FOREACH_IRQ(S)			\
> +	S(AICL),			\
> +	S(CHGIN),			\
> +	S(CHG),				\
> +	S(INLIM),			\
> +	S(BAT_OILO),			\
> +	S(CHG_STA_CC),			\
> +	S(CHG_STA_CV),			\
> +	S(CHG_STA_TO),			\
> +	S(CHG_STA_DONE)
> +
> +#define GENERATE_ENUM(e)		e
> +#define GENERATE_STRING(s)		#s
> +
> +enum {
> +	FOREACH_IRQ(GENERATE_ENUM)
> +};
> +
> +static const char *const chgr_irqs_str[] =3D {
> +	FOREACH_IRQ(GENERATE_STRING)
> +};
> +
> +static int irqs[ARRAY_SIZE(chgr_irqs_str)];

No global variables please, this is not a singleton.

> [...]
>=20
> +static int set_input_current_limit(struct max77759_charger *chg, int ili=
m_ua)
> +{
> +	u32 regval;
> +
> +	if (ilim_ua < 0)
> +		return -EINVAL;
> +
> +	if (ilim_ua =3D=3D 0)
> +		ilim_ua =3D MAX77759_CHGR_CHGIN_ILIM_MIN_UA;
> +	else if (ilim_ua > MAX77759_CHGR_CHGIN_ILIM_MAX_UA)
> +		ilim_ua =3D MAX77759_CHGR_CHGIN_ILIM_MAX_UA;

What if ilim_ua =3D=3D 1 (or any other value < min_uA)? You could use clamp=
()
instead of open-coding.

> +
> +	regval =3D val_to_regval(ilim_ua, MAX77759_CHGR_CHGIN_ILIM_MIN_UA,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_CHGIN_ILIM_STEP_UA=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_CHGIN_ILIM_REG_OFF=
SET);
> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09,
> +				=C2=A0 MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
> +				=C2=A0 regval);
> +}
> +
> +static const enum power_supply_property max77759_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
> +static int max77759_charger_get_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *pval)
> +{
> +	struct max77759_charger *chg =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret =3D get_online(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret =3D charger_input_valid(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D get_status(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret =3D get_charge_type(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret =3D get_health(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		ret =3D get_fast_charge_current(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		ret =3D get_float_voltage(chg);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D get_input_current_limit(chg);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	pval->intval =3D ret;
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static const struct power_supply_desc max77759_charger_desc =3D {
> +	.name =3D "max77759-charger",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.properties =3D max77759_charger_props,
> +	.num_properties =3D ARRAY_SIZE(max77759_charger_props),
> +	.get_property =3D max77759_charger_get_property,
> +};
> +
> +static int charger_set_mode(struct max77759_charger *chg,
> +			=C2=A0=C2=A0=C2=A0 enum max77759_chgr_mode mode)
> +{
> +	int ret;
> +
> +	guard(mutex)(&chg->lock);
> +
> +	if (chg->mode =3D=3D mode)
> +		return 0;
> +
> +	if ((mode =3D=3D MAX77759_CHGR_MODE_CHG_BUCK_ON ||
> +	=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D=3D MAX77759_CHGR_MODE_OTG_BOOST_ON) &=
&
> +	=C2=A0=C2=A0=C2=A0 chg->mode !=3D MAX77759_CHGR_MODE_OFF) {
> +		dev_err(chg->dev, "Invalid mode transition from %d to %d",
> +			chg->mode, mode);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00,
> +				 MAX77759_CHGR_REG_CHG_CNFG_00_MODE, mode);
> +	if (ret)
> +		return ret;
> +
> +	chg->mode =3D mode;
> +	return 0;
> +}
> +
> +static int enable_chgin_otg(struct regulator_dev *rdev)
> +{
> +	struct max77759_charger *chg =3D rdev_get_drvdata(rdev);
> +
> +	return charger_set_mode(chg, MAX77759_CHGR_MODE_OTG_BOOST_ON);
> +}
> +
> +static int disable_chgin_otg(struct regulator_dev *rdev)
> +{
> +	struct max77759_charger *chg =3D rdev_get_drvdata(rdev);
> +
> +	return charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> +}
> +
> +static int chgin_otg_status(struct regulator_dev *rdev)
> +{
> +	struct max77759_charger *chg =3D rdev_get_drvdata(rdev);
> +
> +	guard(mutex)(&chg->lock);
> +	return chg->mode =3D=3D MAX77759_CHGR_MODE_OTG_BOOST_ON;
> +}
> +
> +static const struct regulator_ops chgin_otg_reg_ops =3D {
> +	.enable =3D enable_chgin_otg,
> +	.disable =3D disable_chgin_otg,
> +	.is_enabled =3D chgin_otg_status,
> +};
> +
> +static const struct regulator_desc chgin_otg_reg_desc =3D {
> +	.name =3D "chgin-otg",
> +	.of_match =3D of_match_ptr("chgin-otg-regulator"),
> +	.owner =3D THIS_MODULE,
> +	.ops =3D &chgin_otg_reg_ops,
> +	.fixed_uV =3D 5000000,
> +	.n_voltages =3D 1,
> +};
> +
> +static irqreturn_t irq_handler(int irq, void *data)
> +{
> +	struct max77759_charger *chg =3D data;
> +	struct device *dev =3D chg->dev;
> +	u32 chgint_ok;
> +	int i;
> +
> +	regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &chgint_ok);

You might want to check the return value and return IRQ_NONE if it didn't
work?

> +
> +	for (i =3D 0; i < ARRAY_SIZE(irqs); i++) {
> +		if (irqs[i] =3D=3D irq)
> +			break;
> +	}
> +
> +	switch (i) {
> +	case AICL:
> +		dev_dbg(dev, "AICL mode: %s",
> +			str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_AICL));
> +		break;
> +	case CHGIN:
> +		dev_dbg(dev, "CHGIN input valid: %s",
> +			str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHGIN));
> +		break;
> +	case CHG:
> +		dev_dbg(dev, "CHG status okay/off: %s",
> +			str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHG));
> +		break;
> +	case INLIM:
> +		dev_dbg(dev, "Current Limit reached: %s",
> +			str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_INLIM));
> +		break;
> +	case BAT_OILO:
> +		dev_dbg(dev, "Battery over-current threshold crossed");
> +		break;
> +	case CHG_STA_CC:
> +		dev_dbg(dev, "Charger reached CC stage");
> +		break;
> +	case CHG_STA_CV:
> +		dev_dbg(dev, "Charger reached CV stage");
> +		break;
> +	case CHG_STA_TO:
> +		dev_dbg(dev, "Charger reached TO stage");
> +		break;
> +	case CHG_STA_DONE:
> +		dev_dbg(dev, "Charger reached TO stage");
> +		break;

Are the above debug messages really all needed?

> +	default:
> +		dev_err(dev, "Unrecognized irq: %d", i);
> +		return IRQ_HANDLED;

I'm not sure it should return IRQ_HANDLED in this case.

> +	}
> +
> +	power_supply_changed(chg->psy);
> +	return IRQ_HANDLED;
> +}
> +
> +static int max77759_init_irqhandler(struct max77759_charger *chg)
> +{
> +	struct device *dev =3D chg->dev;
> +	unsigned long irq_flags;
> +	struct irq_data *irqd;
> +	int i, ret;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(chgr_irqs_str); i++) {
> +		ret =3D platform_get_irq_byname(to_platform_device(dev),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chgr_irqs_str[i]);
> +		if (ret < 0) {
> +			dev_err(dev,
> +				"Failed to get irq resource for %s, ret=3D%d",
> +				chgr_irqs_str[i], ret);
> +			return ret;
> +		}

You should use return dev_err_probe() here, and drop the additional dev_err=
_probe()
in max77759_charger_probe().

> +
> +		irqs[i] =3D ret;
> +		irq_flags =3D IRQF_ONESHOT;
> +		irqd =3D irq_get_irq_data(irqs[i]);
> +		if (irqd)
> +			irq_flags |=3D irqd_get_trigger_type(irqd);

The above three lines are not needed, and then you can also drop irq_flags =
and
use its value in the below call directly.

> +
> +		ret =3D devm_request_threaded_irq(dev, irqs[i], NULL, irq_handler,
> +						irq_flags, dev_name(dev), chg);
> +		if (ret) {
> +			dev_err(dev,
> +				"Unable to register irq handler for %s, ret=3D%d",
> +				chgr_irqs_str[i], ret);
> +			return ret;

dev_err_probe() please.

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77759_charger_init(struct max77759_charger *chg)
> +{
> +	struct power_supply_battery_info *info;
> +	u32 regval, fast_chg_curr, fv;
> +	int ret;
> +
> +	regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00, &regval);
> +	chg->mode =3D FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_00_MODE, regval);
> +	ret =3D charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> +	if (ret)
> +		return ret;
> +
> +	if (power_supply_get_battery_info(chg->psy, &info)) {
> +		fv =3D CHG_FV_DEFAULT_MV;
> +		fast_chg_curr =3D CHG_CC_DEFAULT_UA;
> +	} else {
> +		fv =3D info->constant_charge_voltage_max_uv / 1000;
> +		fast_chg_curr =3D info->constant_charge_current_max_ua;
> +	}
> +
> +	ret =3D set_fast_charge_current_limit(chg, fast_chg_curr);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D set_float_voltage_limit(chg, fv);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D unlock_prot_regs(chg, true);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable wireless charging input */
> +	regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
> +			=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
> +
> +	regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
> +			=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);

I think it's good practice to check return values.

> +
> +	return unlock_prot_regs(chg, false);
> +}
> +
> +static void psy_work_item(struct work_struct *work)
> +{
> +	struct max77759_charger *chg =3D
> +		container_of(work, struct max77759_charger, psy_work);
> +	union power_supply_propval current_limit =3D { 0 }, online =3D { 0 };
> +	int ret;
> +
> +	power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_CURRENT_MAX,
> +				=C2=A0 &current_limit);
> +	power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_ONLINE,
> +				=C2=A0 &online);

Would it make sense to rework this and check the return values? Then you ca=
n also
drop the greedy init at function entry.

> +
> +	if (online.intval && current_limit.intval) {
> +		ret =3D set_input_current_limit(chg, current_limit.intval);
> +		if (ret)
> +			dev_err(chg->dev,
> +				"Unable to set current limit, ret=3D%d", ret);
> +
> +		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON);
> +	} else {
> +		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
> +	}
> +}
> +
> +static int psy_changed(struct notifier_block *nb, unsigned long evt, voi=
d *data)
> +{
> +	struct max77759_charger *chg =3D container_of(nb, struct max77759_charg=
er,
> +						=C2=A0=C2=A0=C2=A0 nb);
> +	const char *psy_name =3D "tcpm-source";
> +	struct power_supply *psy =3D data;
> +
> +	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
> +	=C2=A0=C2=A0=C2=A0 evt !=3D PSY_EVENT_PROP_CHANGED)
> +		return NOTIFY_OK;
> +
> +	chg->tcpm_psy =3D psy;
> +	schedule_work(&chg->psy_work);

Maybe add a newline here.

> +	return NOTIFY_OK;
> +}
> +
> +static void max_tcpci_unregister_psy_notifier(void *nb)
> +{
> +	power_supply_unreg_notifier(nb);
> +}
> +
> +static int max77759_charger_probe(struct platform_device *pdev)
> +{
> +	struct regulator_config chgin_otg_reg_cfg;
> +	struct power_supply_config psy_cfg;
> +	struct device *dev =3D &pdev->dev;
> +	struct max77759_charger *chg;
> +	int ret;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +	chg =3D devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, chg);
> +	chg->dev =3D dev;
> +	chg->regmap =3D dev_get_regmap(dev->parent, "charger");
> +	if (!chg->regmap)
> +		return dev_err_probe(dev, -ENODEV, "Missing regmap");
> +
> +	ret =3D devm_mutex_init(dev, &chg->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize lock");
> +
> +	psy_cfg.fwnode =3D dev_fwnode(dev);
> +	psy_cfg.drv_data =3D chg;
> +	chg->psy =3D devm_power_supply_register(dev, &max77759_charger_desc,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &psy_cfg);
> +	if (IS_ERR(chg->psy))
> +		return dev_err_probe(dev, -EPROBE_DEFER,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to register psy, ret=3D%ld",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 PTR_ERR(chg->psy));
> +
> +	ret =3D max77759_charger_init(chg);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize max77759 charger");
> +
> +	chgin_otg_reg_cfg.dev =3D dev;
> +	chgin_otg_reg_cfg.driver_data =3D chg;
> +	chgin_otg_reg_cfg.of_node =3D dev_of_node(dev);
> +	chg->chgin_otg_rdev =3D devm_regulator_register(dev, &chgin_otg_reg_des=
c,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &chgin_otg_reg_cfg);
> +	if (IS_ERR(chg->chgin_otg_rdev))
> +		return dev_err_probe(dev, PTR_ERR(chg->chgin_otg_rdev),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to register chgin otg regulator");
> +
> +	ret =3D devm_work_autocancel(dev, &chg->psy_work, psy_work_item);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize psy work");
> +
> +	chg->nb.notifier_call =3D psy_changed;
> +	ret =3D power_supply_reg_notifier(&chg->nb);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unable to register psy notifier");
> +
> +	ret =3D devm_add_action_or_reset(dev, max_tcpci_unregister_psy_notifier=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &chg->nb);
> +	if (ret)
> +		return ret;

You could print a message here as well.

Cheers,
Andre'


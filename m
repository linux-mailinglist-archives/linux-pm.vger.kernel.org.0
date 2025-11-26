Return-Path: <linux-pm+bounces-38680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C322BC88707
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 08:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FF0D4E9372
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6842B2BE7C0;
	Wed, 26 Nov 2025 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXN5obsY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2312BD5BD
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142603; cv=none; b=iE3P2mUnV66Akm4Me2XRzCJbkGEDlcQo//xRH8nflwl1ugB6eOq7M3Un5ygtkY5WC3SULQaKcfiwGbmHz8X1iTY0/YAf3nSNfb36GAgv0yzp1TAGCjX2faOgNYyH5Z4xw4bT6Q8MAIYzST0/HfhKh80Vfy94g+F3MVNqXbX6MVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142603; c=relaxed/simple;
	bh=LhAHoJh8B7gsTZA++tXUGHdSEeGHiqa9mxR0gYOF9Z8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1OamqpOVwRbcn7rgPnCDrdZ07S9dvPzhZ2S9QuQmjWOzTcD2b6+PVjyCkLxAKjfbaZP0CF3xKYkafYjKL3BzY/MWBBnbHQVWk/LF98v2XlxyHpB+01F1D03lSzAVd37QhmMb65/PlWnsxaEpFYX7Z/KeL5O5bugVFziu24fA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXN5obsY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so41816725e9.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764142599; x=1764747399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=huaG+/GxqBZsLsw0w3QyMKo1sHeAUCmpJPn5GUTjThY=;
        b=hXN5obsYS+CQfz6Xek7GxzpgaHHV3KvLzp9r8tzVy34ztDWoqRbc19nuqLODXlaQDH
         KEa7zLbtX9Iaks2s0wu0LZk6YVngGz7eYFn6mHc1hM4LclznkeofdEgRPNYsy0r+7Zp4
         kfDxXz8nGTJ2SnDuLpU7drnhpeRYvn2o0EYU/tXiBVT4jwiXEYYR06/mKAnjP5OOePj6
         yG5DX1FJgV2cFt/UvnFjijG16R6iinGzBdohHPKcBnTMEZS1CtejU92JXE5w/If9VQcY
         bAMRCi3N/1frV3HPiUoDo25OeZUuJ5TxrfWHGFsnApt42LL0TZkMdqqb0yu4V0TAwbNR
         9WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764142599; x=1764747399;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huaG+/GxqBZsLsw0w3QyMKo1sHeAUCmpJPn5GUTjThY=;
        b=sdZe1Ex5MQTHqgF+Pp4uGIXjEt9sOOlyfrx7fttLSclVsSJN90QHxwJAbCcOljUb4V
         W9V4Kb4rRbzuaaKKRhPnJCe94FAjdWm1OF7nlPY+NEmOnApz6gy17yLH9GKk2IKOzUV2
         FDTNmnwW+nc/rsKbMMNL7jYqyJEsUNs6XL0JWcs82rj7L8yQaFdOts4wCRKxAfz2T9zq
         DYiowBN3pP0yVErgViZ9xjAT1K9e6fCPx1rb0czYu2wS9AxyJ+dqXKvpDhMcJbS3z3l2
         kS+dPibQUgSRwMkmrmajW6ZnDXDK98ejJQFQzj4uyQRoiaNpnjyqQhVY1n6CQuIHlFma
         Buyg==
X-Forwarded-Encrypted: i=1; AJvYcCWNxT+XhPN9+7N0Z7kER2xyxMFnKREuixIAaK9MnIn4Iwf9Isfn+MswXeqGMbcXY8OrNOziZzIi6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0bktEu0fNIxE7MJhjI0Drz1hl/J1o0JX7Ok0Wpyzn7Gsu3Zo
	AykJFC1BqIPeRmrM2a23KeCxFgiajsOrx2sqyYauziBfokqNWfw+vvoQ0Ml45HMpCYo=
X-Gm-Gg: ASbGnctcQmzze3tMhdgBjQb895b6URJJdXIwFeh8UYbomOcK/2KVlPbjRPKDJX+fVQC
	MQbxe6TvAdQYBoLT4KAiLXPHPvTEsBlsJO02rcfT+As4YTllCo4wPAuk/j6z6ST6Bbv4g9/Swrk
	ZJvHHfIM6y6zaSQqh4x/V0O5DJSs5EvuWm/YdkCsrDv3F3EmB6W0ABW7vIB7guwu1cRuznl3NmR
	nx8tIPK1KIKLQQaU+sz6vuNo+ptkFJoiqVJkjUd0rAvcQglZSXHR6nP9MiNcVBH+khhKNT/k4pA
	VeioHY0i6bpVNjGxnh2+8WXfa6Qck5Jgr7wn8UbYtbzwbMUGkXK/LVGzf93vpeaS4KfDp2gX4lk
	I/9vpjZsUHBIMiLqX4bDakc/kDqDFLdlJQ4JKXsIUhrPOxKmAb4cP3F9C0OhKpe3xoU4VBeBEr9
	BBiWQPW2SfjIc4asPXTgqGhQHD0gM=
X-Google-Smtp-Source: AGHT+IGERlOuApsMignFjxRwNc06zHKXZ2/JbcDEMkz/E1/5bE/ahRgimkLS4/dK9MW3yfyecDo0DA==
X-Received: by 2002:a05:600c:1d0d:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-477c1126d1emr170754625e9.28.1764142599438;
        Tue, 25 Nov 2025 23:36:39 -0800 (PST)
Received: from draszik.lan ([212.129.87.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790ab8bb21sm29049505e9.0.2025.11.25.23.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:36:39 -0800 (PST)
Message-ID: <7c326abd0d48c77c4b7df64da87870644d093757.camel@linaro.org>
Subject: Re: [PATCH 5/6] power: supply: max77759: add charger driver
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
Date: Wed, 26 Nov 2025 07:36:54 +0000
In-Reply-To: <20251123-max77759-charger-v1-5-6b2e4b8f7f54@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
	 <20251123-max77759-charger-v1-5-6b2e4b8f7f54@google.com>
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

Just a quick comment below for something I noticed during a brief look.

On Sun, 2025-11-23 at 08:35 +0000, Amit Sunil Dhamne via B4 Relay wrote:
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
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0drivers/mfd/max77759.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +=
-
> =C2=A0drivers/power/supply/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/power/supply/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/power/supply/max77759_charger.c | 866 +++++++++++++++++++++=
+++++++++++
> =C2=A05 files changed, 887 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fed6cd812d79..f1b1015c08b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15053,6 +15053,13 @@ F:	drivers/mfd/max77759.c
> =C2=A0F:	drivers/nvmem/max77759-nvmem.c
> =C2=A0F:	include/linux/mfd/max77759.h
> =C2=A0
> +MAXIM MAX77759 BATTERY CHARGER DRIVER
> +M:	Amit Sunil Dhamne <amitsd@google.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/supply/maxim,max77759-charger=
.yaml
> +F:	drivers/power/supply/max77759_charger.c
> +
> =C2=A0MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
> =C2=A0M:	Javier Martinez Canillas <javier@dowhile0.org>
> =C2=A0L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
> index 5fe22884f362..8a22838be1b0 100644
> --- a/drivers/mfd/max77759.c
> +++ b/drivers/mfd/max77759.c
> @@ -349,7 +349,8 @@ static const struct mfd_cell max77759_maxq_cells[] =
=3D {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mfd_cell max77759_charger_cells[] =3D {
> -	MFD_CELL_RES("max77759-charger", max77759_charger_resources),
> +	MFD_CELL_OF("max77759-charger", max77759_charger_resources, NULL, 0, 0,
> +		=C2=A0=C2=A0=C2=A0 "maxim,max77759-charger"),
> =C2=A0};
> =C2=A0
> =C2=A0int max77759_maxq_command(struct max77759 *max77759,
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2da..b97990cc0b92 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -1074,4 +1074,15 @@ config FUEL_GAUGE_MM8013
> =C2=A0	=C2=A0 the state of charge, temperature, cycle count, actual and d=
esign
> =C2=A0	=C2=A0 capacity, etc.
> =C2=A0
> +config CHARGER_MAX77759
> +	tristate "MAX77759 Charger Driver"
> +	depends on MFD_MAX77759
> +	default MFD_MAX77759
> +	help
> +	=C2=A0 Say M or Y here to enable the MAX77759 Charger Driver. MAX77759
> +	=C2=A0 charger is a function of the MAX77759 PMIC. This is a dual input
> +	=C2=A0 switch-mode charger. This driver supports buck and OTG boost mod=
es.
> +
> +	=C2=A0 If built as a module, it will be called max77759_charger.
> +
> =C2=A0endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index f943c9150b32..12669734cfe3 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -122,3 +122,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
> =C2=A0obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
> =C2=A0obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_smbx.o
> =C2=A0obj-$(CONFIG_FUEL_GAUGE_MM8013)	+=3D mm8013.o
> +obj-$(CONFIG_CHARGER_MAX77759)	+=3D max77759_charger.o
> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supp=
ly/max77759_charger.c
> new file mode 100644
> index 000000000000..51637e87182b
> --- /dev/null
> +++ b/drivers/power/supply/max77759_charger.c
> @@ -0,0 +1,866 @@
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
> +/* CHG_INT_OK */
> +#define CHG_INT_OK_AICL_OK			BIT(7)
> +#define CHG_INT_OK_CHGIN_OK			BIT(6)
> +#define CHG_INT_OK_CHG_OK			BIT(4)
> +#define CHG_INT_OK_INLIM_OK			BIT(2)
> +

[...]

> +static irqreturn_t irq_handler(int irq, void *data)
> +{
> +	struct max77759_charger *chg =3D data;
> +	u32 irq_status, chgint_ok, idx =3D 0;
> +	int ret;
> +
> +	if (irq =3D=3D chg->irq[0])
> +		idx =3D 0;
> +	else
> +		idx =3D 1;
> +
> +	ret =3D regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT + idx,
> +			=C2=A0 &irq_status);
> +	if (ret) {
> +		dev_err(chg->dev, "regmap_read_error idx=3D%d ret=3D%d", idx, ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	regmap_write(chg->regmap, MAX77759_CHGR_REG_CHG_INT + idx,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 irq_status);
> +	regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &chgint_ok);
> +
> +	if (idx =3D=3D 0) {
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT_AICL)
> +			dev_dbg(chg->dev, "AICL mode: %s",
> +				str_no_yes(chgint_ok & CHG_INT_OK_AICL_OK));
> +
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT_CHGIN)
> +			dev_dbg(chg->dev, "CHGIN input valid: %s",
> +				str_yes_no(chgint_ok & CHG_INT_OK_CHGIN_OK));
> +
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT_CHG)
> +			dev_dbg(chg->dev, "CHG status okay/off: %s",
> +				str_yes_no(chgint_ok & CHG_INT_OK_CHG_OK));
> +
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT_INLIM)
> +			dev_dbg(chg->dev, "Current Limit reached: %s",
> +				str_no_yes(chgint_ok & CHG_INT_OK_INLIM_OK));
> +	} else {
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT2_BAT_OILO)
> +			dev_dbg(chg->dev,
> +				"Battery over-current threshold crossed");
> +
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC)
> +			dev_dbg(chg->dev, "Charger reached CC stage");
> +
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV)
> +			dev_dbg(chg->dev, "Charger reached CV stage");
> +
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO)
> +			dev_dbg(chg->dev, "Charger reached TO stage");
> +
> +		if (irq_status & MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE)
> +			dev_dbg(chg->dev, "Charger reached Done stage");
> +	}
> +
> +	power_supply_changed(chg->psy);
> +	return IRQ_HANDLED;
> +}
> +
> +static int max77759_init_irqhandler(struct max77759_charger *chg)
> +{
> +	static const char * const irq_res_names[] =3D { "INT1", "INT2" };
> +	struct device *dev =3D chg->dev;
> +	unsigned long irq_flags;
> +	struct irq_data *irqd;
> +	int *irq =3D chg->irq;
> +	int ret, i;
> +
> +	for (i =3D 0; i < 2; i++) {
> +		irq[i] =3D platform_get_irq_byname(to_platform_device(dev),
> +						 irq_res_names[i]);
> +		if (irq[i] < 0) {
> +			dev_err(dev, "unable to find %s irq", irq_res_names[i]);
> +			return irq[i];
> +		}
> +
> +		irq_flags =3D IRQF_ONESHOT | IRQF_SHARED;
> +		irqd =3D irq_get_irq_data(irq[i]);
> +		if (irqd)
> +			irq_flags |=3D irqd_get_trigger_type(irqd);
> +
> +		ret =3D devm_request_threaded_irq(dev, irq[i], NULL, irq_handler,
> +						irq_flags, dev_name(dev), chg);
> +		if (ret) {
> +			dev_err(dev, "Unable to register threaded irq handler");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

The way you're requesting the IRQ here I don't think you need to modify
max77759_chgr_irqs[] in patch 4 at all. You're requesting the interrupt
and are manually demultiplexing and acknowledging the actual event in your
IRQ handler.

Your change in patch 4 would instead allow your charger driver to call
request_irq for each individual bit of the interrupt register(s), letting
regmap-irq demultiplex and acknowledge the event for you before calling
your handler(s). As an example, see how the ACPM result interrupt is
requested in max77759_add_chained_maxq().

It's probably cleaner to let regmap-irq deal with demultiplexing etc.


Cheers,
Andre




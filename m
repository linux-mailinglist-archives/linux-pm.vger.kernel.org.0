Return-Path: <linux-pm+bounces-30668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCE8B01720
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 11:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0661C4422C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0C21D5BD;
	Fri, 11 Jul 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pvYjKxg+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1801FE45B;
	Fri, 11 Jul 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224562; cv=none; b=hPv64SUlYsHC92vs9cIsytBCmlsxRnPm+ANDAu5cNV8PYCl4IH1clPJWy4w3fiQ2Wnq0aeua3iVnpNokITOpA3KtIvyzOG7pMcnB6QbKHaUMrOfMDYiBecESugkQILssR2gIxWtqP8/ixbNH6wl2vpktJmvwOjLrq51mX2gosLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224562; c=relaxed/simple;
	bh=5hfsErzK8U6eSfuwK4siKcG5sl3MlW6guRBomqwJNSk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ND+o+f0r7KqGWklEr4n4vh3BLT3IYIZo6U9H/mxKSbC4Af5a6zJqpoKE47bF+9CH2gLaFqHZwlTCdIoA6UaZh+sWJhs7oklH5znsO6z6i8zwL5fwBY+0OdMUCeC25uNkxnHCIjUFgrdGA1aFEAACr5NqUJ5JOyDNyA9jZmjkXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pvYjKxg+; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752224545; x=1752483745;
	bh=Tg8aOMQgSF6YM5PlWDpcJQLYft5zXTyVat8RUlVrpKw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pvYjKxg+twOgyt8Gd11RZkN46LUq/vcNdz+VJNLdIhPNUk8jW8rLrZ9elL9Jk5tVr
	 gJZOIwc3mWNqT1BXJCbD3WeF97oGiLwK0wSFpPQCbDgeMDp5i+AcGDqWsMy+ciFy2B
	 hqBRwRtRCtfjq6sTBpQv8oILCY9PPRcHkgFKV8WtgxlijSyUiyqW4HZjDcotJ87mKm
	 8NlwtLVFXpsmwR6xXkvCzEMYunKbwXTwo0Eoc3dMAQG98JQB8fPcaaon3ChmsPQaTC
	 Iqk2EnOSjzHY9rVAFqxb2Mfsh8wr3LHX+9PXUpo4a34hMUOvSQybCDn2QWadpL8Z/t
	 9rxiueNtV4oAQ==
Date: Fri, 11 Jul 2025 09:02:18 +0000
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 5/6] power: supply: pf1550: add battery charger support
Message-ID: <e2veigexln4ma5meguxqh6jh2r2fhj2d47pv4exjzwrhlazn7d@raknfsiucqls>
In-Reply-To: <20250707-pf1550-v8-5-6b6eb67c03a0@savoirfairelinux.com>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com> <20250707-pf1550-v8-5-6b6eb67c03a0@savoirfairelinux.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: e22eee3c66a526c8ffff06f5cd1ab1c871b3bad9
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 07, 2025 at 05:37:24PM +0100, Samuel Kayode wrote:
> Add support for the battery charger for pf1550 PMIC.
>=20
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---

[...]

> diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply=
/pf1550-charger.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7a6bd9c30d60280f1e1c50d4e=
1ddaf0a4998b9f0
> --- /dev/null
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -0,0 +1,632 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * charger driver for the PF1550
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Robin Gong <yibin.gong@freescale.com>
> + *
> + * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> + * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> + */
> +
> +#include <linux/devm-helpers.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +
> +#define PF1550_DEFAULT_CONSTANT_VOLT=094200000
> +#define PF1550_DEFAULT_MIN_SYSTEM_VOLT=093500000
> +#define PF1550_DEFAULT_THERMAL_TEMP=0975

Default is 95

> +#define PF1550_CHARGER_IRQ_NR=09=095
> +
> +struct pf1550_charger {
> +=09struct device *dev;
> +=09const struct pf1550_ddata *pf1550;
> +=09struct power_supply *charger;
> +=09struct power_supply *battery;
> +=09struct delayed_work vbus_sense_work;
> +=09struct delayed_work chg_sense_work;
> +=09struct delayed_work bat_sense_work;
> +=09int virqs[PF1550_CHARGER_IRQ_NR];
> +

[...]

> +
> +static int pf1550_set_thermal_regulation_temp(struct pf1550_charger *chg=
,
> +=09=09=09=09=09      unsigned int cells)
> +{
> +=09unsigned int data;
> +
> +=09switch (cells) {
> +=09case 60:
> +=09=09data =3D 0x0;
> +=09=09break;
> +=09case 75:
> +=09=09data =3D 0x1;
> +=09=09break;
> +=09case 90:
> +=09=09data =3D 0x2;
> +=09=09break;
> +=09case 105:
> +=09=09data =3D 0x3;
> +=09=09break;

From the datasheet 80, 95, 110 and 125c is supported

> +=09default:
> +=09=09return dev_err_probe(chg->dev, -EINVAL,
> +=09=09=09=09     "Wrong value for thermal temperature\n");
> +=09}
> +
> +=09data <<=3D PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT;
> +
> +=09dev_dbg(chg->dev, "Thermal regulation loop temperature: %u (0x%x)\n",
> +=09=09cells, data);
> +
> +=09return regmap_update_bits(chg->pf1550->regmap,
> +=09=09=09=09  PF1550_CHARG_REG_THM_REG_CNFG,
> +=09=09=09=09  PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK,
> +=09=09=09=09  data);
> +}
> +
> +/*
> + * Sets charger registers to proper and safe default values.
> + */
> +static int pf1550_reg_init(struct pf1550_charger *chg)
> +{
> +=09struct device *dev =3D chg->dev;
> +=09unsigned int data;
> +=09int ret;
> +
> +=09/* Unmask charger interrupt, mask DPMI and reserved bit */
> +=09ret =3D  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_M=
ASK,
> +=09=09=09    PF1550_CHG_INT_MASK);
> +=09if (ret)
> +=09=09return dev_err_probe(dev, ret,
> +=09=09=09=09     "Error unmask charger interrupt\n");
> +
> +=09ret =3D regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS,
> +=09=09=09  &data);
> +=09if (ret)
> +=09=09return dev_err_probe(dev, ret, "Read charg vbus_sns error\n");

data is unused here :/

> +
> +=09ret =3D pf1550_set_constant_volt(chg, chg->constant_volt);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D pf1550_set_min_system_volt(chg, chg->min_system_volt);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D pf1550_set_thermal_regulation_temp(chg,
> +=09=09=09=09=09=09 chg->thermal_regulation_temp);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Turn on charger */
> +=09ret =3D regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_OPER,
> +=09=09=09   PF1550_CHG_TURNON);
> +=09if (ret)
> +=09=09return dev_err_probe(dev, ret, "Error turn on charger\n");

There are 3 modes for the charger operation:
0: charger =3D off, linear =3D off
1: charger =3D off, linear =3D on
2: charger =3D on, linear =3D on

The driver is hardcoded to use no. 2.

We are using the mode 1, and setting it to 2 causes my system to boot loop.

I don't know how we should select mode, maybe it could be an option from
the devicetree or use power_supply_get_battery_info() to look for a
battery and the only select between 1 or 2, but 0 would also be a valid
option.

/Sean



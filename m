Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACC511EC08
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 21:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfLMUtR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 15:49:17 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43984 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMUtR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 15:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576270153; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgOd8DNrA6cWegX2wWJrOiZQHCYtJnQOx+GCCgoINAA=;
        b=MGGy7+bvJrWLaLFeV2OvxUGRzOjzfnEkPbf9nIWFOJmx4Cphe5bk6CpZdePlxa/xqbGET3
        S0QNd7MY/W1v0YpB+ydgv8SbYewIrjjdIIZT7DqXVaIxzZDAql3b84GT17oagR+grw7y8W
        dMtxblK5zOl8QcAqXFXwc2xa0MyLobo=
Date:   Fri, 13 Dec 2019 21:49:07 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/3] power/supply: Add generic USB charger driver
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Message-Id: <1576270147.3.0@crapouillou.net>
In-Reply-To: <20191212091814.GA7035@b29397-desktop>
References: <20191211155032.167032-1-paul@crapouillou.net>
        <20191211155032.167032-3-paul@crapouillou.net>
        <20191212091814.GA7035@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,


Le jeu., d=E9c. 12, 2019 at 09:18, Peter Chen <peter.chen@nxp.com> a=20
=E9crit :
> On 19-12-11 16:50:32, Paul Cercueil wrote:
>>  This simple charger driver uses the USB role switch framework to=20
>> detect
>>  the presence of a charger. The USB charger will report as online=20
>> when
>>  the USB role is set to device, and offline otherwise.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2: Instead of detecting charger state from USB PHY, we detect=20
>> it from the
>>          USB role in use.
>>=20
>>   drivers/power/supply/Kconfig               |   8 ++
>>   drivers/power/supply/Makefile              |   1 +
>>   drivers/power/supply/generic-usb-charger.c | 124=20
>> +++++++++++++++++++++
>>   3 files changed, 133 insertions(+)
>>   create mode 100644 drivers/power/supply/generic-usb-charger.c
>>=20
>>  diff --git a/drivers/power/supply/Kconfig=20
>> b/drivers/power/supply/Kconfig
>>  index 27164a1d3c7c..c4221bcabee4 100644
>>  --- a/drivers/power/supply/Kconfig
>>  +++ b/drivers/power/supply/Kconfig
>>  @@ -51,6 +51,14 @@ config GENERIC_ADC_BATTERY
>>   	  Say Y here to enable support for the generic battery driver
>>   	  which uses IIO framework to read adc.
>>=20
>>  +config GENERIC_USB_CHARGER
>>  +	tristate "Generic USB charger"
>>  +	depends on USB_SUPPORT
>>  +	select USB_ROLE_SWITCH
>>  +	help
>>  +	  Say Y here to enable a generic USB charger driver which uses
>>  +	  the USB role switch framework to detect the presence of the=20
>> charger.
>>  +
>>   config MAX8925_POWER
>>   	tristate "MAX8925 battery charger support"
>>   	depends on MFD_MAX8925
>>  diff --git a/drivers/power/supply/Makefile=20
>> b/drivers/power/supply/Makefile
>>  index 6c7da920ea83..03f9b553bdfc 100644
>>  --- a/drivers/power/supply/Makefile
>>  +++ b/drivers/power/supply/Makefile
>>  @@ -8,6 +8,7 @@ power_supply-$(CONFIG_LEDS_TRIGGERS)	+=3D=20
>> power_supply_leds.o
>>   obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
>>   obj-$(CONFIG_POWER_SUPPLY_HWMON) +=3D power_supply_hwmon.o
>>   obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
>>  +obj-$(CONFIG_GENERIC_USB_CHARGER)	+=3D generic-usb-charger.o
>>=20
>>   obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
>>   obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
>>  diff --git a/drivers/power/supply/generic-usb-charger.c=20
>> b/drivers/power/supply/generic-usb-charger.c
>>  new file mode 100644
>>  index 000000000000..0493fafbd4c0
>>  --- /dev/null
>>  +++ b/drivers/power/supply/generic-usb-charger.c
>>  @@ -0,0 +1,124 @@
>>  +// SPDX-License-Identifier: GPL-2.0
>>  +/*
>>  + * Simple USB charger driver
>>  + * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
>>  + */
>>  +
>>  +#include <linux/device.h>
>>  +#include <linux/module.h>
>>  +#include <linux/of.h>
>>  +#include <linux/platform_device.h>
>>  +#include <linux/power_supply.h>
>>  +#include <linux/usb/role.h>
>>  +
>>  +struct usb_charger {
>>  +	struct notifier_block nb;
>>  +	struct usb_role_switch *role;
>>  +	struct power_supply_desc desc;
>>  +	struct power_supply *charger;
>>  +};
>>  +
>>  +static enum power_supply_property usb_charger_properties[] =3D {
>>  +	POWER_SUPPLY_PROP_ONLINE,
>>  +};
>>  +
>>  +static int usb_charger_get_property(struct power_supply *psy,
>>  +				    enum power_supply_property psp,
>>  +				    union power_supply_propval *val)
>>  +{
>>  +	struct usb_charger *charger =3D power_supply_get_drvdata(psy);
>>  +	enum usb_role role;
>>  +
>>  +	switch (psp) {
>>  +	case POWER_SUPPLY_PROP_ONLINE:
>>  +		role =3D usb_role_switch_get_role(charger->role);
>>  +		val->intval =3D role =3D=3D USB_ROLE_DEVICE;
>>  +		break;
>>  +	default:
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int usb_charger_event(struct notifier_block *nb,
>>  +			     unsigned long event, void *d)
>>  +{
>>  +	struct usb_charger *charger =3D container_of(nb, struct=20
>> usb_charger, nb);
>>  +
>>  +	power_supply_changed(charger->charger);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static void usb_charger_unregister(void *data)
>>  +{
>>  +	struct usb_charger *charger =3D data;
>>  +
>>  +	usb_role_switch_unregister_notifier(charger->role, &charger->nb);
>>  +}
>>  +
>>  +static int usb_charger_probe(struct platform_device *pdev)
>>  +{
>>  +	struct device *dev =3D &pdev->dev;
>>  +	struct power_supply_desc *desc;
>>  +	struct usb_charger *charger;
>>  +	struct power_supply_config cfg =3D {
>>  +		.of_node =3D dev->of_node,
>>  +	};
>>  +	int err;
>>  +
>>  +	charger =3D devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
>>  +	if (!charger)
>>  +		return -ENOMEM;
>>  +
>>  +	cfg.drv_data =3D charger;
>>  +	charger->nb.notifier_call =3D usb_charger_event;
>>  +
>>  +	charger->role =3D usb_role_switch_get(dev);
>>  +	if (IS_ERR(charger->role)) {
>>  +		if (PTR_ERR(charger->role) !=3D -EPROBE_DEFER)
>>  +			dev_err(dev, "Unable to get USB role");
>>  +		return PTR_ERR(charger->role);
>>  +	}
>>  +
>>  +	desc =3D &charger->desc;
>>  +	desc->name =3D "usb-charger";
>>  +	desc->properties =3D usb_charger_properties;
>>  +	desc->num_properties =3D ARRAY_SIZE(usb_charger_properties);
>>  +	desc->get_property =3D usb_charger_get_property;
>>  +	desc->type =3D POWER_SUPPLY_TYPE_USB;
>=20
> What's your further plan for this generic USB charger?
> To support BC1.2, we need to know charger type, and how
> we could get it?
>=20
> Peter

Well I don't really know. The USB role framework does not give any info=20
about what's plugged.

-Paul


>=20
>>  +
>>  +	charger->charger =3D devm_power_supply_register(dev, desc, &cfg);
>>  +	if (IS_ERR(charger->charger)) {
>>  +		dev_err(dev, "Unable to register charger");
>>  +		return PTR_ERR(charger->charger);
>>  +	}
>>  +
>>  +	err =3D usb_role_switch_register_notifier(charger->role,=20
>> &charger->nb);
>>  +	if (err) {
>>  +		dev_err(dev, "Unable to register USB role switch notifier");
>>  +		return err;
>>  +	}
>>  +
>>  +	return devm_add_action_or_reset(dev, usb_charger_unregister,=20
>> charger);
>>  +}
>>  +
>>  +static const struct of_device_id usb_charger_of_match[] =3D {
>>  +	{ .compatible =3D "usb-charger" },
>>  +	{ /* sentinel */ },
>>  +};
>>  +MODULE_DEVICE_TABLE(of, usb_charger_of_match);
>>  +
>>  +static struct platform_driver usb_charger_driver =3D {
>>  +	.driver =3D {
>>  +		.name =3D "usb-charger",
>>  +		.of_match_table =3D of_match_ptr(usb_charger_of_match),
>>  +	},
>>  +	.probe =3D usb_charger_probe,
>>  +};
>>  +module_platform_driver(usb_charger_driver);
>>  +
>>  +MODULE_DESCRIPTION("Simple USB charger driver");
>>  +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>  +MODULE_LICENSE("GPL");
>>  --
>>  2.24.0
>>=20
>=20
> --
>=20
> Thanks,
> Peter Chen

=


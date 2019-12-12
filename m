Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1619811C8FF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 10:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfLLJSW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 04:18:22 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:23301
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbfLLJSW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Dec 2019 04:18:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDRNR+fsnuaBOE8d7eLdYH/LOS9OXVtPkQ+r5p3X/ymfIhcDim2BQrJ+VhAHr5k7LV68V102jJI85YIX7kHpzUdK9tC47tWzn5pNb/ooZRDlk8j4bvlJFiN6Nxbz/Rbd+KLAvqkTezhltuiKY6u+exBqA+jA+JcJjO6Br0mfq/YB6i60k4sj+BLTn3lBzvQKeIFE+ytP6EsdV4Njp6CiH9EhtYnVAZlf3ihFHTi7Qr8UB2dpFaDL4G0yd57SAYqIh1oMUqMhtjtr4OGArn4cWghR+fWCTo9t8e8LPNe5RkNFKjF9or6bmoGojagNGwhPOrGOCx7rVZFnRpeCZYB7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1avFtZt5VJbVmEjggLRy+hTmqSv6Y7lbKYSyWuApqlU=;
 b=Bi6RpbpQdB9OZin9Jld5n9Jbzvjf1nRQjUkLsDXizV/NmyzE7sTeVrRPeTS3BDv1IQTUmRuDtYZRjsRLpVCu3xyMU9eGHShf6q0zkhRmNyXk0DAUHVaixBMOtYTn5PnQKutx9004LsWOy599KPjxPRhZ+Hni3T1g8maAQCxO+GhQEhQIKclJS1QWIqIB9AgzUqZrE1t2Iq09BfEj7F9XU4QgUoNJ+nG4MItnIBtqBGz/++wFoSZKW1+lkl/TUtlz7uwB3FBYxv2pe4Ixg/uCdtCNXWXRoyijI6EVrXb1DMqpb0T/lGEEu96Q2bLvXVCQcANih7yA26dCQeuTvRLywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1avFtZt5VJbVmEjggLRy+hTmqSv6Y7lbKYSyWuApqlU=;
 b=UUyR7ke8Bx5Xl32732NFINIiNzggtGK1dku7I0q2Kl71eusS3WB4+vDytCHI2w2HRloYLbRkTKlxXayJr7VsaCR2SRu4221vI4KeosDILza95+qhltA7XHwowsDkitDENpAlMSmH15J/w0g9cxA5C2La4NGPV/+qMHTBWC03uTc=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5214.eurprd04.prod.outlook.com (20.177.52.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 09:18:17 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 09:18:17 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "od@zcrc.me" <od@zcrc.me>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] power/supply: Add generic USB charger driver
Thread-Topic: [PATCH v2 3/3] power/supply: Add generic USB charger driver
Thread-Index: AQHVsDrKPWSbvY6T+0OJ94dLsbCA8qe2ObMA
Date:   Thu, 12 Dec 2019 09:18:17 +0000
Message-ID: <20191212091814.GA7035@b29397-desktop>
References: <20191211155032.167032-1-paul@crapouillou.net>
 <20191211155032.167032-3-paul@crapouillou.net>
In-Reply-To: <20191211155032.167032-3-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96b79031-808f-44c0-3a6c-08d77ee43932
x-ms-traffictypediagnostic: VI1PR04MB5214:
x-microsoft-antispam-prvs: <VI1PR04MB5214ED458014234B7457B2F78B550@VI1PR04MB5214.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(189003)(199004)(8676002)(54906003)(316002)(6486002)(53546011)(6506007)(33656002)(81166006)(81156014)(8936002)(66556008)(66446008)(66476007)(478600001)(64756008)(66946007)(76116006)(91956017)(71200400001)(6916009)(2906002)(186003)(26005)(5660300002)(9686003)(6512007)(44832011)(7416002)(1076003)(4326008)(33716001)(86362001)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5214;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GA8h8EVSV+mHjbywby/ydP5rkS38ukNymb358eR5gyoXwRBqIVbiQjVb0zXJNT5PwqxoQ2NIsgKoWd9cpmX03FSvl5rOAKHRTlKJrDxeqLNh0iDORkn8Fs1gpgWUrHqsKPhtccy131wR81rdyV1ey5gaPl086VSlGtYBl2Qad6cJYrTnqCZcarMGKz511VAwIDvfUc8K+A92feIfZKf4gGBu619OyQnGlCPaADnf9ASnO6uoRozWYHIuKc7u2uctyHM9sAdfcrZNWw6jVYX9f6o8CkIKf3aJy0WMYtBOyu7kbaoBAcPs2JlhPT7wfiPalvFj6WUeepbBF7XE44GqUM0avq6TIp/160EfRgTsnu8Ajct7GvM1pU54VMechAOiHeTcfrZC1n6tzKCfhsI1V3bVBThk7L1JRR5A3iR0UClU1hCvi7YmklKoP0q/kpu/5LVU7rkU4uvlIE4la/FaVnlGkk/s5Rd+36RSxPuv1O96MNn5eEbXUoXz3wUMQ1I
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CB23395BF7ABD439D05E7C5AB876866@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b79031-808f-44c0-3a6c-08d77ee43932
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 09:18:17.2491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GJsIMNjO6+lIoRgZtQRkgav8vAy/5vIj8g/7ArxJD2DfuxvW00etrcMO8MC5McOg/u3EANl2CcRstUhktfyyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5214
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-12-11 16:50:32, Paul Cercueil wrote:
> This simple charger driver uses the USB role switch framework to detect
> the presence of a charger. The USB charger will report as online when
> the USB role is set to device, and offline otherwise.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>     v2: Instead of detecting charger state from USB PHY, we detect it fro=
m the
>         USB role in use.
>=20
>  drivers/power/supply/Kconfig               |   8 ++
>  drivers/power/supply/Makefile              |   1 +
>  drivers/power/supply/generic-usb-charger.c | 124 +++++++++++++++++++++
>  3 files changed, 133 insertions(+)
>  create mode 100644 drivers/power/supply/generic-usb-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 27164a1d3c7c..c4221bcabee4 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -51,6 +51,14 @@ config GENERIC_ADC_BATTERY
>  	  Say Y here to enable support for the generic battery driver
>  	  which uses IIO framework to read adc.
> =20
> +config GENERIC_USB_CHARGER
> +	tristate "Generic USB charger"
> +	depends on USB_SUPPORT
> +	select USB_ROLE_SWITCH
> +	help
> +	  Say Y here to enable a generic USB charger driver which uses
> +	  the USB role switch framework to detect the presence of the charger.
> +
>  config MAX8925_POWER
>  	tristate "MAX8925 battery charger support"
>  	depends on MFD_MAX8925
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index 6c7da920ea83..03f9b553bdfc 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -8,6 +8,7 @@ power_supply-$(CONFIG_LEDS_TRIGGERS)	+=3D power_supply_le=
ds.o
>  obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
>  obj-$(CONFIG_POWER_SUPPLY_HWMON) +=3D power_supply_hwmon.o
>  obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
> +obj-$(CONFIG_GENERIC_USB_CHARGER)	+=3D generic-usb-charger.o
> =20
>  obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
>  obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
> diff --git a/drivers/power/supply/generic-usb-charger.c b/drivers/power/s=
upply/generic-usb-charger.c
> new file mode 100644
> index 000000000000..0493fafbd4c0
> --- /dev/null
> +++ b/drivers/power/supply/generic-usb-charger.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Simple USB charger driver
> + * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/usb/role.h>
> +
> +struct usb_charger {
> +	struct notifier_block nb;
> +	struct usb_role_switch *role;
> +	struct power_supply_desc desc;
> +	struct power_supply *charger;
> +};
> +
> +static enum power_supply_property usb_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static int usb_charger_get_property(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    union power_supply_propval *val)
> +{
> +	struct usb_charger *charger =3D power_supply_get_drvdata(psy);
> +	enum usb_role role;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		role =3D usb_role_switch_get_role(charger->role);
> +		val->intval =3D role =3D=3D USB_ROLE_DEVICE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int usb_charger_event(struct notifier_block *nb,
> +			     unsigned long event, void *d)
> +{
> +	struct usb_charger *charger =3D container_of(nb, struct usb_charger, nb=
);
> +
> +	power_supply_changed(charger->charger);
> +
> +	return 0;
> +}
> +
> +static void usb_charger_unregister(void *data)
> +{
> +	struct usb_charger *charger =3D data;
> +
> +	usb_role_switch_unregister_notifier(charger->role, &charger->nb);
> +}
> +
> +static int usb_charger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct power_supply_desc *desc;
> +	struct usb_charger *charger;
> +	struct power_supply_config cfg =3D {
> +		.of_node =3D dev->of_node,
> +	};
> +	int err;
> +
> +	charger =3D devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	cfg.drv_data =3D charger;
> +	charger->nb.notifier_call =3D usb_charger_event;
> +
> +	charger->role =3D usb_role_switch_get(dev);
> +	if (IS_ERR(charger->role)) {
> +		if (PTR_ERR(charger->role) !=3D -EPROBE_DEFER)
> +			dev_err(dev, "Unable to get USB role");
> +		return PTR_ERR(charger->role);
> +	}
> +
> +	desc =3D &charger->desc;
> +	desc->name =3D "usb-charger";
> +	desc->properties =3D usb_charger_properties;
> +	desc->num_properties =3D ARRAY_SIZE(usb_charger_properties);
> +	desc->get_property =3D usb_charger_get_property;
> +	desc->type =3D POWER_SUPPLY_TYPE_USB;

What's your further plan for this generic USB charger?
To support BC1.2, we need to know charger type, and how
we could get it?

Peter

> +
> +	charger->charger =3D devm_power_supply_register(dev, desc, &cfg);
> +	if (IS_ERR(charger->charger)) {
> +		dev_err(dev, "Unable to register charger");
> +		return PTR_ERR(charger->charger);
> +	}
> +
> +	err =3D usb_role_switch_register_notifier(charger->role, &charger->nb);
> +	if (err) {
> +		dev_err(dev, "Unable to register USB role switch notifier");
> +		return err;
> +	}
> +
> +	return devm_add_action_or_reset(dev, usb_charger_unregister, charger);
> +}
> +
> +static const struct of_device_id usb_charger_of_match[] =3D {
> +	{ .compatible =3D "usb-charger" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, usb_charger_of_match);
> +
> +static struct platform_driver usb_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "usb-charger",
> +		.of_match_table =3D of_match_ptr(usb_charger_of_match),
> +	},
> +	.probe =3D usb_charger_probe,
> +};
> +module_platform_driver(usb_charger_driver);
> +
> +MODULE_DESCRIPTION("Simple USB charger driver");
> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.24.0
>=20

--=20

Thanks,
Peter Chen=

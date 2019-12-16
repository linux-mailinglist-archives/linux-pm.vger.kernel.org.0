Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A701202F3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLPKwO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 05:52:14 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42740 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 05:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576493531; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJtKg4YBH/DsNNYyKShEC+cjzAd8qY62spFT3pgBt20=;
        b=P6aWTboUJ49iR09mjEKD0sd3Jw123RPpiEYdRir1RQrcwtYq/ezKQrhszcaPBdS7A7DVQP
        phKTilD8m1ja30fBqFmDrw+6BwZgBakNHExJ8ugrmvA3GrzeNUY4xoyEKDi/UYAMYQE5Gp
        wfMBzqHQjI4GCgur+IiYHqri5cnNqPI=
Date:   Mon, 16 Dec 2019 11:52:05 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: RE: [PATCH v2 3/3] power/supply: Add generic USB charger driver
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Message-Id: <1576493525.3.0@crapouillou.net>
In-Reply-To: <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.c
        om>
References: <20191211155032.167032-1-paul@crapouillou.net>
        <20191211155032.167032-3-paul@crapouillou.net>
        <20191212091814.GA7035@b29397-desktop> <1576270147.3.0@crapouillou.net>
        <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,


Le lun., d=E9c. 16, 2019 at 01:24, Peter Chen <peter.chen@nxp.com> a=20
=E9crit :
>=20
>>  >>  +
>>  >>  +	desc =3D &charger->desc;
>>  >>  +	desc->name =3D "usb-charger";
>>  >>  +	desc->properties =3D usb_charger_properties;
>>  >>  +	desc->num_properties =3D ARRAY_SIZE(usb_charger_properties);
>>  >>  +	desc->get_property =3D usb_charger_get_property;
>>  >>  +	desc->type =3D POWER_SUPPLY_TYPE_USB;
>>  >
>>  > What's your further plan for this generic USB charger?
>>  > To support BC1.2, we need to know charger type, and how we could=20
>> get
>>  > it?
>>  >
>>  > Peter
>>=20
>>  Well I don't really know. The USB role framework does not give any=20
>> info about
>>  what's plugged.
>>=20
>=20
> What's the use case for this patch set? How it be used?

My devicetree:

usb_otg: usb@13440000 {
	compatible =3D "ingenic,jz4770-musb", "simple-mfd";
	reg =3D <0x13440000 0x10000>;
	[...]

	usb-role-switch;

	connector {
		compatible =3D "gpio-usb-b-connector", "usb-b-connector";
		label =3D "mini-USB";
		type =3D "mini";

		id-gpios =3D <&gpf 18 GPIO_ACTIVE_HIGH>;
		vbus-gpios =3D <&gpb 5 GPIO_ACTIVE_HIGH>;
		[...]
	};

	usb_charger: usb-charger {
		compatible =3D "usb-charger";
	};
};

The new gpio-usb-connector driver uses the ID/VBUS GPIOs to detect in=20
which state (device, host, unconnected) a OTG connector is. However,=20
that means I cannot use the standard gpio-charger driver to detect the=20
presence of a charger based on the state of the VBUS gpio, since it's=20
already requested here. So the point of this patchset is to provide an=20
alternative to gpio-charger that works with OTG controllers compatible=20
with 'usb-role-switch'.

Cheers,
-Paul


>>  >
>>  >>  +
>>  >>  +	charger->charger =3D devm_power_supply_register(dev, desc,=20
>> &cfg);
>>  >>  +	if (IS_ERR(charger->charger)) {
>>  >>  +		dev_err(dev, "Unable to register charger");
>>  >>  +		return PTR_ERR(charger->charger);
>>  >>  +	}
>>  >>  +
>>  >>  +	err =3D usb_role_switch_register_notifier(charger->role,
>>  >> &charger->nb);
>>  >>  +	if (err) {
>>  >>  +		dev_err(dev, "Unable to register USB role switch notifier");
>>  >>  +		return err;
>>  >>  +	}
>>  >>  +
>>  >>  +	return devm_add_action_or_reset(dev, usb_charger_unregister,
>>  >> charger);
>>  >>  +}
>>  >>  +
>>  >>  +static const struct of_device_id usb_charger_of_match[] =3D {
>>  >>  +	{ .compatible =3D "usb-charger" },
>>  >>  +	{ /* sentinel */ },
>>  >>  +};
>>  >>  +MODULE_DEVICE_TABLE(of, usb_charger_of_match);  +  +static=20
>> struct
>>  >> platform_driver usb_charger_driver =3D {
>>  >>  +	.driver =3D {
>>  >>  +		.name =3D "usb-charger",
>>  >>  +		.of_match_table =3D of_match_ptr(usb_charger_of_match),
>>  >>  +	},
>>  >>  +	.probe =3D usb_charger_probe,
>>  >>  +};
>>  >>  +module_platform_driver(usb_charger_driver);
>>  >>  +
>>  >>  +MODULE_DESCRIPTION("Simple USB charger driver");
>>  >> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>  >> +MODULE_LICENSE("GPL");
>>  >>  --
>>  >>  2.24.0
>>  >>
>>  >
>>  > --
>>  >
>>  > Thanks,
>>  > Peter Chen
>>=20
>=20

=


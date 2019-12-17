Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DEE12389E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 22:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLQVYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 16:24:30 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:38492 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfLQVYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 16:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576617868; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C9AwKJoFefXH+ToH8CSxGK5C+sj8QnbEUgDjj7IX84=;
        b=XheFhTOzEWgjztClMj0L64tByp2E6JNkSY03/XUQ97k6wj1JvqbMLoFbROM8AAIeKgguFE
        uKI5d1OJjevXTsjMS0hOSXrvQUBzbRm7WMJBhEfLdQCKv91MdVKqRzFiOhm/azDXCin5q+
        Ak/NWKcuO5zRaypR6YsuDEMb7Lj76RI=
Date:   Tue, 17 Dec 2019 22:24:23 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: RE: [PATCH v2 3/3] power/supply: Add generic USB charger driver
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Message-Id: <1576617863.3.1@crapouillou.net>
In-Reply-To: <VI1PR04MB5327B8EF35340FC4B2D02DE88B500@VI1PR04MB5327.eurprd04.prod.outlook.c
        om>
References: <20191211155032.167032-1-paul@crapouillou.net>
        <20191211155032.167032-3-paul@crapouillou.net>
        <20191212091814.GA7035@b29397-desktop> <1576270147.3.0@crapouillou.net>
        <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <1576493525.3.0@crapouillou.net>
        <VI1PR04MB5327B8EF35340FC4B2D02DE88B500@VI1PR04MB5327.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

Le mar., d=E9c. 17, 2019 at 01:32, Peter Chen <peter.chen@nxp.com> a=20
=E9crit :
>=20
>>  Le lun., d=E9c. 16, 2019 at 01:24, Peter Chen <peter.chen@nxp.com> a=20
>> =E9crit :
>>  >
>>  >>  >>  +
>>  >>  >>  +	desc =3D &charger->desc;
>>  >>  >>  +	desc->name =3D "usb-charger";
>>  >>  >>  +	desc->properties =3D usb_charger_properties;
>>  >>  >>  +	desc->num_properties =3D ARRAY_SIZE(usb_charger_properties);
>>  >>  >>  +	desc->get_property =3D usb_charger_get_property;
>>  >>  >>  +	desc->type =3D POWER_SUPPLY_TYPE_USB;
>>  >>  >
>>  >>  > What's your further plan for this generic USB charger?
>>  >>  > To support BC1.2, we need to know charger type, and how we=20
>> could
>>  >> get  > it?
>>  >>  >
>>  >>  > Peter
>>  >>
>>  >>  Well I don't really know. The USB role framework does not give=20
>> any
>>  >> info about  what's plugged.
>>  >>
>>  >
>>  > What's the use case for this patch set? How it be used?
>>=20
>>  My devicetree:
>>=20
>>  usb_otg: usb@13440000 {
>>  	compatible =3D "ingenic,jz4770-musb", "simple-mfd";
>>  	reg =3D <0x13440000 0x10000>;
>>  	[...]
>>=20
>>  	usb-role-switch;
>>=20
>>  	connector {
>>  		compatible =3D "gpio-usb-b-connector", "usb-b-connector";
>>  		label =3D "mini-USB";
>>  		type =3D "mini";
>>=20
>>  		id-gpios =3D <&gpf 18 GPIO_ACTIVE_HIGH>;
>>  		vbus-gpios =3D <&gpb 5 GPIO_ACTIVE_HIGH>;
>>  		[...]
>>  	};
>>=20
>>  	usb_charger: usb-charger {
>>  		compatible =3D "usb-charger";
>>  	};
>>  };
>>=20
>>  The new gpio-usb-connector driver uses the ID/VBUS GPIOs to detect=20
>> in
>>  which state (device, host, unconnected) a OTG connector is. However,
>>  that means I cannot use the standard gpio-charger driver to detect=20
>> the
>>  presence of a charger based on the state of the VBUS gpio, since=20
>> it's
>>  already requested here. So the point of this patchset is to provide=20
>> an
>>  alternative to gpio-charger that works with OTG controllers=20
>> compatible
>>  with 'usb-role-switch'.
>>=20
>=20
> Thanks for explaining it.
>=20
> What's the user for this USB charger,  PMIC or what else? How the=20
> user uses
> this USB charger interface?

It's exported as a standard charger, so it can be passed to client=20
drivers through devicetree, and its online status can be retrieved from=20
sysfs.

-Paul

>=20
>>=20
>>=20
>>  >>  >
>>  >>  >>  +
>>  >>  >>  +	charger->charger =3D devm_power_supply_register(dev, desc,
>>  >> &cfg);
>>  >>  >>  +	if (IS_ERR(charger->charger)) {
>>  >>  >>  +		dev_err(dev, "Unable to register charger");
>>  >>  >>  +		return PTR_ERR(charger->charger);
>>  >>  >>  +	}
>>  >>  >>  +
>>  >>  >>  +	err =3D usb_role_switch_register_notifier(charger->role,
>>  >>  >> &charger->nb);
>>  >>  >>  +	if (err) {
>>  >>  >>  +		dev_err(dev, "Unable to register USB role switch=20
>> notifier");
>>  >>  >>  +		return err;
>>  >>  >>  +	}
>>  >>  >>  +
>>  >>  >>  +	return devm_add_action_or_reset(dev,=20
>> usb_charger_unregister,
>>  >>  >> charger);
>>  >>  >>  +}
>>  >>  >>  +
>>  >>  >>  +static const struct of_device_id usb_charger_of_match[] =3D {
>>  >>  >>  +	{ .compatible =3D "usb-charger" },
>>  >>  >>  +	{ /* sentinel */ },
>>  >>  >>  +};
>>  >>  >>  +MODULE_DEVICE_TABLE(of, usb_charger_of_match);  +  +static
>>  >> struct
>>  >>  >> platform_driver usb_charger_driver =3D {
>>  >>  >>  +	.driver =3D {
>>  >>  >>  +		.name =3D "usb-charger",
>>  >>  >>  +		.of_match_table =3D of_match_ptr(usb_charger_of_match),
>>  >>  >>  +	},
>>  >>  >>  +	.probe =3D usb_charger_probe,
>>  >>  >>  +};
>>  >>  >>  +module_platform_driver(usb_charger_driver);
>>  >>  >>  +
>>  >>  >>  +MODULE_DESCRIPTION("Simple USB charger driver");
>>  >>  >> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>  >>  >> +MODULE_LICENSE("GPL");
>>  >>  >>  --
>>  >>  >>  2.24.0
>>  >>  >>
>>  >>  >
>>  >>  > --
>>  >>  >
>>  >>  > Thanks,
>>  >>  > Peter Chen
>>  >>
>>  >
>>=20
>=20

=


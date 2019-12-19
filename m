Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9321260EA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 12:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLSLfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 06:35:47 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47908 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSLfr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 06:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576755342; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckop6Kqk0CV79KVL4zcYWdYOX/VFrNEJtlGjWhAJS+I=;
        b=cHB0INpO3f2CogS5CbRHjpHON4couUPO673zqq7Nuzt+0O+Ra3tG1zlgjfXmhQ2Kt3PwMz
        PHDsiKkqjNju5o4p8QeS2Z3/WPfYnErBSN8CD/X2l05m+WBKnaDH4WED7emxpQl0M3cUd5
        xAKnVCRlloCicTthjywCisc97X4H6dU=
Date:   Thu, 19 Dec 2019 12:35:37 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: RE: [PATCH v2 3/3] power/supply: Add generic USB charger driver
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Message-Id: <1576755337.3.0@crapouillou.net>
In-Reply-To: <VI1PR04MB53273342340E350BFFFDE12F8B530@VI1PR04MB5327.eurprd04.prod.outlook.c
        om>
References: <20191211155032.167032-1-paul@crapouillou.net>
        <20191211155032.167032-3-paul@crapouillou.net>
        <20191212091814.GA7035@b29397-desktop> <1576270147.3.0@crapouillou.net>
        <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <1576493525.3.0@crapouillou.net>
        <VI1PR04MB5327B8EF35340FC4B2D02DE88B500@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <1576617863.3.1@crapouillou.net>
        <VI1PR04MB53273342340E350BFFFDE12F8B530@VI1PR04MB5327.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,


Le mer., d=E9c. 18, 2019 at 02:46, Peter Chen <peter.chen@nxp.com> a=20
=E9crit :
>=20
>>  >>  >
>>  >>  >>  >>  +
>>  >>  >>  >>  +	desc =3D &charger->desc;
>>  >>  >>  >>  +	desc->name =3D "usb-charger";
>>  >>  >>  >>  +	desc->properties =3D usb_charger_properties;
>>  >>  >>  >>  +	desc->num_properties =3D=20
>> ARRAY_SIZE(usb_charger_properties);
>>  >>  >>  >>  +	desc->get_property =3D usb_charger_get_property;
>>  >>  >>  >>  +	desc->type =3D POWER_SUPPLY_TYPE_USB;
>>  >>  >>  >
>>  >>  >>  > What's your further plan for this generic USB charger?
>>  >>  >>  > To support BC1.2, we need to know charger type, and how we
>>  >> could  >> get  > it?
>>  >>  >>  >
>>  >>  >>  > Peter
>>  >>  >>
>>  >>  >>  Well I don't really know. The USB role framework does not=20
>> give
>>  >> any  >> info about  what's plugged.
>>  >>  >>
>>  >>  >
>>  >>  > What's the use case for this patch set? How it be used?
>>  >>
>>  >>  My devicetree:
>>  >>
>>  >>  usb_otg: usb@13440000 {
>>  >>  	compatible =3D "ingenic,jz4770-musb", "simple-mfd";
>>  >>  	reg =3D <0x13440000 0x10000>;
>>  >>  	[...]
>>  >>
>>  >>  	usb-role-switch;
>>  >>
>>  >>  	connector {
>>  >>  		compatible =3D "gpio-usb-b-connector", "usb-b-connector";
>>  >>  		label =3D "mini-USB";
>>  >>  		type =3D "mini";
>>  >>
>>  >>  		id-gpios =3D <&gpf 18 GPIO_ACTIVE_HIGH>;
>>  >>  		vbus-gpios =3D <&gpb 5 GPIO_ACTIVE_HIGH>;
>>  >>  		[...]
>>  >>  	};
>>  >>
>>  >>  	usb_charger: usb-charger {
>>  >>  		compatible =3D "usb-charger";
>>  >>  	};
>>  >>  };
>>  >>
>>  >>  The new gpio-usb-connector driver uses the ID/VBUS GPIOs to=20
>> detect
>>  >> in  which state (device, host, unconnected) a OTG connector is.
>>  >> However,  that means I cannot use the standard gpio-charger=20
>> driver to
>>  >> detect the  presence of a charger based on the state of the VBUS
>>  >> gpio, since it's  already requested here. So the point of this
>>  >> patchset is to provide an  alternative to gpio-charger that works
>>  >> with OTG controllers compatible  with 'usb-role-switch'.
>>  >>
>>  >
>>  > Thanks for explaining it.
>>  >
>>  > What's the user for this USB charger,  PMIC or what else? How the=20
>> user
>>  > uses this USB charger interface?
>>=20
>>  It's exported as a standard charger, so it can be passed to client=20
>> drivers through
>>  devicetree, and its online status can be retrieved from sysfs.
>>=20
>=20
> Hi Paul,
>=20
> If you would like to get role from usb-role-switch, the udc driver=20
> may probably have already worked.
> There is a 'state' entry under the udc device to indicate USB Ch9=20
> state. Try to see if it could
> satisfy your requirement.

This is not the proper way to retrieve charger status.
Linux supports chargers through the power supply subsystem, that's=20
where it should be exported.

Cheers,
-Paul

=


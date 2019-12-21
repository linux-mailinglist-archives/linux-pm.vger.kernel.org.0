Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7FE128947
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLUNzX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Dec 2019 08:55:23 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40934 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfLUNzX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Dec 2019 08:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576936520; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMr5tq4u/iCVvyge/KXZh59ydoLu25ejT807wqisIzA=;
        b=HyOld4TtSERwF3mEIs/pjgsZBfBqqCQ2mJmCJx0PzMsuFfxi3hE2G1dF4NlTMuyuawTF+a
        k9NUL7kh/DBUILojk1HHYITwJSbxaJ67CmdOEXnoom/dCZ/fkJJYaRDmeiYOE64dmen4S4
        8V3HIfF2wgz54mJtpZJx/kFqgFsyOFs=
Date:   Sat, 21 Dec 2019 14:55:14 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/3] power/supply: Add generic USB charger driver
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Message-Id: <1576936514.3.0@crapouillou.net>
In-Reply-To: <20191219213845.GA3481@bogus>
References: <20191211155032.167032-1-paul@crapouillou.net>
        <20191211155032.167032-3-paul@crapouillou.net>
        <20191212091814.GA7035@b29397-desktop> <1576270147.3.0@crapouillou.net>
        <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <1576493525.3.0@crapouillou.net> <20191219213845.GA3481@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,


Le jeu., d=E9c. 19, 2019 at 13:38, Rob Herring <robh@kernel.org> a=20
=E9crit :
> On Mon, Dec 16, 2019 at 11:52:05AM +0100, Paul Cercueil wrote:
>>  Hi Peter,
>>=20
>>=20
>>  Le lun., d=E9c. 16, 2019 at 01:24, Peter Chen <peter.chen@nxp.com> a=20
>> =E9crit :
>>  >
>>  > >  >>  +
>>  > >  >>  +	desc =3D &charger->desc;
>>  > >  >>  +	desc->name =3D "usb-charger";
>>  > >  >>  +	desc->properties =3D usb_charger_properties;
>>  > >  >>  +	desc->num_properties =3D=20
>> ARRAY_SIZE(usb_charger_properties);
>>  > >  >>  +	desc->get_property =3D usb_charger_get_property;
>>  > >  >>  +	desc->type =3D POWER_SUPPLY_TYPE_USB;
>>  > >  >
>>  > >  > What's your further plan for this generic USB charger?
>>  > >  > To support BC1.2, we need to know charger type, and how we=20
>> could
>>  > > get
>>  > >  > it?
>>  > >  >
>>  > >  > Peter
>>  > >
>>  > >  Well I don't really know. The USB role framework does not give=20
>> any
>>  > > info about
>>  > >  what's plugged.
>>  > >
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
>=20
> What h/w device is this?

GCW Zero: arch/mips/boot/dts/ingenic/gcw0.dts

Most of it isn't upstream, so I can still experiment things to get the=20
perfect devicetree.

>=20
>>  	};
>>  };
>>=20
>>  The new gpio-usb-connector driver uses the ID/VBUS GPIOs to detect=20
>> in which
>>  state (device, host, unconnected) a OTG connector is. However, that=20
>> means I
>>  cannot use the standard gpio-charger driver to detect the presence=20
>> of a
>>  charger based on the state of the VBUS gpio, since it's already=20
>> requested
>>  here. So the point of this patchset is to provide an alternative to
>>  gpio-charger that works with OTG controllers compatible with
>>  'usb-role-switch'.
>=20
> Why not fix gpio-charger or make whatever 'owns' vbus-gpios to=20
> register
> a charger device?

I see there is a GPIOD_FLAGS_BIT_NONEXCLUSIVE bit that could be used,=20
I'll have a look.

Thanks,
-Paul

>=20
> I guess you could have Vbus sensing with no charging capability, but
> that sounds like a new property, not a node to me.
>=20
> Rob

=


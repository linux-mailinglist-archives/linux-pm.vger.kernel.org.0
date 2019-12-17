Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B50122195
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 02:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfLQBdH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 20:33:07 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:16475
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfLQBdH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 20:33:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpGMOiV9f/+Y6ciCJ5kAf1khuX4SW6P+jhcTC+MG7i7AhgLzm7vLGEz2N+3P0QpH6ZihDnE5QgaQNzKfTmGaqv2SPIaou4VT2tkXcAU+7SNfHc5uUfQcEFZlFqKDtsUSgbiqVom8bCbIa9ofjhMbIl2AVklvIGtPDHLSdXSiXgdZTG2/txsmKgNenrgep3wqIZpQDgjD7JsI6T+moMlREXQmpFXDSwu9YpwEIhavbTYXSrNcakh1RGngKlkajiJ874jor5opvuPXfx1B7aOhT78TBTYkPcSrqVXWZ/fHy6ZRhTBXFGBF2/VatxtCiq3OKQ4ZUYVmOE+EeTB5vNUIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmodkr6+NhGoXf4aikQiVvsxgOdD3BMoaKluZ1LwlXA=;
 b=I5+JMMlOVupFpqFvbpHAo3vbTashW6DCnAH9L74mFbQPz1EBOOU/vOmnLLSDul2exhCG1UW1viIky2Zxu1UOnZAXj8TpKNgrl1EJy+70Sb/gkJWJHGI1j+aA0w+59T06KawATQ3/mba3lWRQjCLGG3fXhlsqUkPVlEny16C3O/qo+wRrNiFJCKLG7+nsuIaDEvPUT4RO7GCOxC+gAP1FlMXuh7y0XMgQdPODSaiwhhA/IRRgqk60GbEtTiscVoUCB3QfLu3j6MMggUjjpIQy512vUIK10mvv55FrUCh26vzc5RC2CYAbUxTgDwa0JZCmP46Jx05fkOd4SgIub1Qg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmodkr6+NhGoXf4aikQiVvsxgOdD3BMoaKluZ1LwlXA=;
 b=jH2PhbE3BDwDvja9JnZorB07ftgl5Z5Kqw1Q/MefXE80a9SHNiHYEwF2u5Kjg3zfBdwFv+2k43qMzz1anKEp87uHdhC5BnRJrnibxC0ppmhmMWnEtIxvEyYwe33Fkwyu0SNrMYENBrYV0Og+xHXQR1rdRnR81tzfd2kKkofJvTQ=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4496.eurprd04.prod.outlook.com (20.177.54.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Tue, 17 Dec 2019 01:32:24 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 01:32:24 +0000
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
Subject: RE: [PATCH v2 3/3] power/supply: Add generic USB charger driver
Thread-Topic: [PATCH v2 3/3] power/supply: Add generic USB charger driver
Thread-Index: AQHVsDrKPWSbvY6T+0OJ94dLsbCA8qe2ObMAgAJTXYCAA3BKkIAAn/jzgAD0ddA=
Date:   Tue, 17 Dec 2019 01:32:23 +0000
Message-ID: <VI1PR04MB5327B8EF35340FC4B2D02DE88B500@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20191211155032.167032-1-paul@crapouillou.net>
        <20191211155032.167032-3-paul@crapouillou.net>
        <20191212091814.GA7035@b29397-desktop>
 <1576270147.3.0@crapouillou.net>
        <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <1576493525.3.0@crapouillou.net>
In-Reply-To: <1576493525.3.0@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cadfeda2-5c47-4915-9c77-08d78290f7cd
x-ms-traffictypediagnostic: VI1PR04MB4496:
x-microsoft-antispam-prvs: <VI1PR04MB449605E5A354797DA6C784558B500@VI1PR04MB4496.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(8676002)(2906002)(8936002)(81156014)(81166006)(6506007)(33656002)(7416002)(5660300002)(86362001)(66446008)(64756008)(66476007)(66556008)(4326008)(76116006)(66946007)(7696005)(52536014)(186003)(6916009)(55016002)(9686003)(44832011)(54906003)(26005)(478600001)(316002)(71200400001)(66574012)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4496;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /GFpltcX4roxBZAXTbPhSaYUbwSkMV/72W+F95S78GCcRRSeGFnGwDhK2mVh4MhX/5L0iE6k1yvPLn1lWJl/b/PEMorI4tEWyKJZ/1KMDLyTSBQyQTd/UHdC0OHyBSge8vpDwSviQmxs/7ZfamCTj/wsEJcEuuIe3arTWZePRjrrQ3e57K35WK2hHpc7tSvcAiaJwZ2DVu4E4F1//E3C5Lzrh6ye3Ld6sdo7lW6MUXOMvMmmq999LAxRCVtT8SUpwAowQ6PfxtT2/OSBDVe7n/7BloZMDnlZXV3SrfYum52TpNekg2AsqW3r+gr5So/WtN/CDgtlBwZp9j8W4vaCb214BAsOODNRI1FgO/CLq3GEJPORPInX7A+TANo0Pu6s90aTL7oePc0WD2zcG7RbXGyoLZQD59l+llyfIP26X2Ky2HlNB+WrElsXmeLfU45fzfTN39ZRdEd8kV2POKJHcRzhZt7xI8GhIsTn+w0cjfFG+J80eunFCmQcVSvNyfoz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadfeda2-5c47-4915-9c77-08d78290f7cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 01:32:23.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jOkljhrQPTm1fpB80dj8KrYcbidr6KhTKOWD+VpjnmlmTJokq47WPwT+u1TkfezOW5QkDNYaEIHEv6ScS3/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4496
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=20
> Le lun., d=E9c. 16, 2019 at 01:24, Peter Chen <peter.chen@nxp.com> a =E9c=
rit :
> >
> >>  >>  +
> >>  >>  +	desc =3D &charger->desc;
> >>  >>  +	desc->name =3D "usb-charger";
> >>  >>  +	desc->properties =3D usb_charger_properties;
> >>  >>  +	desc->num_properties =3D ARRAY_SIZE(usb_charger_properties);
> >>  >>  +	desc->get_property =3D usb_charger_get_property;
> >>  >>  +	desc->type =3D POWER_SUPPLY_TYPE_USB;
> >>  >
> >>  > What's your further plan for this generic USB charger?
> >>  > To support BC1.2, we need to know charger type, and how we could
> >> get  > it?
> >>  >
> >>  > Peter
> >>
> >>  Well I don't really know. The USB role framework does not give any
> >> info about  what's plugged.
> >>
> >
> > What's the use case for this patch set? How it be used?
>=20
> My devicetree:
>=20
> usb_otg: usb@13440000 {
> 	compatible =3D "ingenic,jz4770-musb", "simple-mfd";
> 	reg =3D <0x13440000 0x10000>;
> 	[...]
>=20
> 	usb-role-switch;
>=20
> 	connector {
> 		compatible =3D "gpio-usb-b-connector", "usb-b-connector";
> 		label =3D "mini-USB";
> 		type =3D "mini";
>=20
> 		id-gpios =3D <&gpf 18 GPIO_ACTIVE_HIGH>;
> 		vbus-gpios =3D <&gpb 5 GPIO_ACTIVE_HIGH>;
> 		[...]
> 	};
>=20
> 	usb_charger: usb-charger {
> 		compatible =3D "usb-charger";
> 	};
> };
>=20
> The new gpio-usb-connector driver uses the ID/VBUS GPIOs to detect in
> which state (device, host, unconnected) a OTG connector is. However,
> that means I cannot use the standard gpio-charger driver to detect the
> presence of a charger based on the state of the VBUS gpio, since it's
> already requested here. So the point of this patchset is to provide an
> alternative to gpio-charger that works with OTG controllers compatible
> with 'usb-role-switch'.
>=20

Thanks for explaining it.

What's the user for this USB charger,  PMIC or what else? How the user uses
this USB charger interface?

Peter

>=20
>=20
> >>  >
> >>  >>  +
> >>  >>  +	charger->charger =3D devm_power_supply_register(dev, desc,
> >> &cfg);
> >>  >>  +	if (IS_ERR(charger->charger)) {
> >>  >>  +		dev_err(dev, "Unable to register charger");
> >>  >>  +		return PTR_ERR(charger->charger);
> >>  >>  +	}
> >>  >>  +
> >>  >>  +	err =3D usb_role_switch_register_notifier(charger->role,
> >>  >> &charger->nb);
> >>  >>  +	if (err) {
> >>  >>  +		dev_err(dev, "Unable to register USB role switch notifier");
> >>  >>  +		return err;
> >>  >>  +	}
> >>  >>  +
> >>  >>  +	return devm_add_action_or_reset(dev, usb_charger_unregister,
> >>  >> charger);
> >>  >>  +}
> >>  >>  +
> >>  >>  +static const struct of_device_id usb_charger_of_match[] =3D {
> >>  >>  +	{ .compatible =3D "usb-charger" },
> >>  >>  +	{ /* sentinel */ },
> >>  >>  +};
> >>  >>  +MODULE_DEVICE_TABLE(of, usb_charger_of_match);  +  +static
> >> struct
> >>  >> platform_driver usb_charger_driver =3D {
> >>  >>  +	.driver =3D {
> >>  >>  +		.name =3D "usb-charger",
> >>  >>  +		.of_match_table =3D of_match_ptr(usb_charger_of_match),
> >>  >>  +	},
> >>  >>  +	.probe =3D usb_charger_probe,
> >>  >>  +};
> >>  >>  +module_platform_driver(usb_charger_driver);
> >>  >>  +
> >>  >>  +MODULE_DESCRIPTION("Simple USB charger driver");
> >>  >> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> >>  >> +MODULE_LICENSE("GPL");
> >>  >>  --
> >>  >>  2.24.0
> >>  >>
> >>  >
> >>  > --
> >>  >
> >>  > Thanks,
> >>  > Peter Chen
> >>
> >
>=20


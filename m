Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9681123D68
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 03:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLRCq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 21:46:28 -0500
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]:58569
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbfLRCq2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Dec 2019 21:46:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekcepr6SZf18xiQYFPsgVz6vlFLG19yttotG+gRt2IbovdhhikqO9AMnbWtCbgZdMtCDypM/p5U3N+30024Fzr1m0kuckw3qv/0afHHGzeIaxIaL7RngrL7qBlb1GjO4wkQVuk2CPM/wL2i4ROlyyGHbxY+Xo+ZSuEO2bRUca32MK/Xv418gyOw+9eVLSJEIvMyFegIgryuYt30yxF3MfsrKGhH+ZV6tTYo3l77Ozq6Bt+mLZBHugpgcjEnLoUaCx+liLVjlhDXw/kiiYYVPm+rgoeq0OeJi4O3yPjO2Yd4zZArjQhMu+hHxariP9x+0IbhYazbyCrOK31PGCs9OiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4nsnySAbjuSRT02GZR66zDBPoFelcxVMeS+O5MNmOs=;
 b=gr8s1p4aODF6X6rmNJjpwpCxF8GK3ZKtcNHXSpzBzcU3zX4EhSiycM/eFaFPPRJP3B/WJ1HrWgABC2jka8QydLCJzQjPZ0Pn6d2wY4xzwKVi7bmxwpEbnsJ8vkWi9UnO6Swzps9ZBN7rbsLG1Bp8QF/WWpf1cqWKnVbOeV5p9OWe6CZRsxtopx6KMu6e9FoC0QDNklT9Fyh+z3jvdKW4jiEL3QuYElY4gMXMcaa5DpZ0/qUtOyzs91zIqQM4XoRFHA70XmzLcCWlEk8Fa+R+hC+wd8JDuQ02LCFfYsJsOHgOUnUnjUlK8ObgpjO6XipPMr7MCNeouJTe8237X6a/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4nsnySAbjuSRT02GZR66zDBPoFelcxVMeS+O5MNmOs=;
 b=RjHnSpf0D+K0LTHfVlXFQOfGq7FrbzxI77X2ZJ5+Ss0TpkKBkaDYYQ57OOUjabVsHnEBc5ZywwJPnw4mB+UccWl+HDr8ahvHuqo2r/+K2FcUk87XX301jlp2SUmzxO6vHY2aloCE4vxc7sF8MSXDoqTZ364B4ac8l+/KlGgNIEA=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5792.eurprd04.prod.outlook.com (20.178.204.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 02:46:20 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 02:46:20 +0000
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
Thread-Index: AQHVsDrKPWSbvY6T+0OJ94dLsbCA8qe2ObMAgAJTXYCAA3BKkIAAn/jzgAD0ddCAAU6BzYAAWE8A
Date:   Wed, 18 Dec 2019 02:46:20 +0000
Message-ID: <VI1PR04MB53273342340E350BFFFDE12F8B530@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20191211155032.167032-1-paul@crapouillou.net>
        <20191211155032.167032-3-paul@crapouillou.net>
        <20191212091814.GA7035@b29397-desktop> <1576270147.3.0@crapouillou.net>
        <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <1576493525.3.0@crapouillou.net>
        <VI1PR04MB5327B8EF35340FC4B2D02DE88B500@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <1576617863.3.1@crapouillou.net>
In-Reply-To: <1576617863.3.1@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6eb970f5-20f8-43e1-d793-08d7836476aa
x-ms-traffictypediagnostic: VI1PR04MB5792:
x-microsoft-antispam-prvs: <VI1PR04MB5792D8DD23B35B6E16A0871D8B530@VI1PR04MB5792.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(71200400001)(4326008)(86362001)(478600001)(54906003)(186003)(316002)(6506007)(33656002)(26005)(7696005)(8676002)(81156014)(8936002)(81166006)(64756008)(55016002)(7416002)(6916009)(66556008)(66476007)(66446008)(5660300002)(66946007)(2906002)(9686003)(44832011)(52536014)(76116006)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5792;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISqJbviy5Nbi16dfdLcfbV3YCEowNII5cuk4hmXGjAzsVSK0xXjTKWieWqnKFgctXgacoxQefMP4NTHPQlNHNjKIDRgWE+VMzVANQnuAo8kQegdYMapiqFJpYwVQ+BR3WftPoUbO8zYKHNL202rHm2mUKXPKxcLqiZ49xeuKAaGZqyZvObRxWEm6Qebm6SpvlkoTlz5RGaXpWpIS2wOTHHqJoxZ955IZeI5UwQfogbDgLdW7RKFJ0+swEeM00xzSdHZBl/5QEZ1OyZAojRNMYQuxL/Yv4Q6BXs5uzyFS2u9G62J+PolRed+5qHk7DwvPMT4ITCn4/n2ENNNOfYTFMOGFrpHLGGW1h52fPbpxyN+zPi9wakp/Ne/sogcoqShBYmUIsM/pb8PUZLjmlFomiTj2fP7Ou6a4WXcarNOx7UFktYmMS+Hzq9mKDPepV8FocQph+fDmyqX7ERtx5uWJopbjp1OnD0kpO4/pxjBElZQ7ceTJNdHWwe8THqlR+/p5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb970f5-20f8-43e1-d793-08d7836476aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:46:20.5501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJzEJ13i8Eh239lTEVpAfS61MCfPqMeb3vvtBNA2hbF8x1kpL3XK9e1ruu4lIWMXagSOyGUiiGl9OE7XrKfhnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5792
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=20
> >>  >
> >>  >>  >>  +
> >>  >>  >>  +	desc =3D &charger->desc;
> >>  >>  >>  +	desc->name =3D "usb-charger";
> >>  >>  >>  +	desc->properties =3D usb_charger_properties;
> >>  >>  >>  +	desc->num_properties =3D ARRAY_SIZE(usb_charger_properties)=
;
> >>  >>  >>  +	desc->get_property =3D usb_charger_get_property;
> >>  >>  >>  +	desc->type =3D POWER_SUPPLY_TYPE_USB;
> >>  >>  >
> >>  >>  > What's your further plan for this generic USB charger?
> >>  >>  > To support BC1.2, we need to know charger type, and how we
> >> could  >> get  > it?
> >>  >>  >
> >>  >>  > Peter
> >>  >>
> >>  >>  Well I don't really know. The USB role framework does not give
> >> any  >> info about  what's plugged.
> >>  >>
> >>  >
> >>  > What's the use case for this patch set? How it be used?
> >>
> >>  My devicetree:
> >>
> >>  usb_otg: usb@13440000 {
> >>  	compatible =3D "ingenic,jz4770-musb", "simple-mfd";
> >>  	reg =3D <0x13440000 0x10000>;
> >>  	[...]
> >>
> >>  	usb-role-switch;
> >>
> >>  	connector {
> >>  		compatible =3D "gpio-usb-b-connector", "usb-b-connector";
> >>  		label =3D "mini-USB";
> >>  		type =3D "mini";
> >>
> >>  		id-gpios =3D <&gpf 18 GPIO_ACTIVE_HIGH>;
> >>  		vbus-gpios =3D <&gpb 5 GPIO_ACTIVE_HIGH>;
> >>  		[...]
> >>  	};
> >>
> >>  	usb_charger: usb-charger {
> >>  		compatible =3D "usb-charger";
> >>  	};
> >>  };
> >>
> >>  The new gpio-usb-connector driver uses the ID/VBUS GPIOs to detect
> >> in  which state (device, host, unconnected) a OTG connector is.
> >> However,  that means I cannot use the standard gpio-charger driver to
> >> detect the  presence of a charger based on the state of the VBUS
> >> gpio, since it's  already requested here. So the point of this
> >> patchset is to provide an  alternative to gpio-charger that works
> >> with OTG controllers compatible  with 'usb-role-switch'.
> >>
> >
> > Thanks for explaining it.
> >
> > What's the user for this USB charger,  PMIC or what else? How the user
> > uses this USB charger interface?
>=20
> It's exported as a standard charger, so it can be passed to client driver=
s through
> devicetree, and its online status can be retrieved from sysfs.
>=20
=20
Hi Paul,

If you would like to get role from usb-role-switch, the udc driver may prob=
ably have already worked.
There is a 'state' entry under the udc device to indicate USB Ch9 state. Tr=
y to see if it could
satisfy your requirement.

Peter

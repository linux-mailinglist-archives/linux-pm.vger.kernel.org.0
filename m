Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2724E11FC8D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 02:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLPBYk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 20:24:40 -0500
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:35386
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbfLPBYk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Dec 2019 20:24:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIxVA1J4UKpcpH8yZlw7/zrYbl0kk2E35RBcqcLqqo/ll4TwlfxPejRYymHM0DlH1Ft0/pqlv3ar7Crhtlo6/ozVil6jYHUvECMj9Dbqrdq86Ww5zdI2UJjjQsUvO6XrZ8vffRsIrQrgUR72bPqAu1ub2j4HTXF84tb7DEJsMtqqx5PsZrFyNW7+A//d/3yj6c45vVaskuryhgVQO9imCBhhjjNZUdi3U70FPErX9dexlr/0boMGLwCMM6Zowlp8LwzfDgFl+u21+nGOVg/f3+Iu0suqyerSm7gPRcU1Yebmw501PQkBDyP8JWqjc0LVeQ+B3frhNqBQi+5LUfXqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWcz42ePjnkuxrDXmlXo+w8oHCACf/paQLTWyda5P7M=;
 b=aLMxnA2q0IQdF/WP24MujUcl4xAiFZOuOihYVGn5JmtD6IPsCDSbJsylhtnble2eRz4XYCBWj1XqWhJYK34EFA7fGiIq6STb/nWpGQk40g4dUTTKYcWUwPRGegM1twsF/Riek7Om2uhJhrvWtcd9jtqheL1uSzj+JDgCpFUlPdzKJ4s2KTKbw+JqwHdtmvg+9j5U/Px4jFWQadOm3T6KdjjXlefZiCcem+1cO/rlgHJjyV3N8fYJRJ0ahWZjwxc5DwF7H2jFpNhApWPXvMDOQnPZFAox7+H1MVuvXNsra1QarGP44fRcp3Df3JTmsRzins7nAMZcbkPASarnUzMkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWcz42ePjnkuxrDXmlXo+w8oHCACf/paQLTWyda5P7M=;
 b=aMfTO5H70W4SE10xSDJjGQkP9/MKA1NpVwBZNZDWeUCvNk35AadQLgC4cb5FO+fkGuIqYRGEBvaITUezmMY2QRva8he07GUVa5a+aDGK381my+njj11qufO9QLBC8PTvYf4MCsFQr1LBUYw7gVX8xSKZCkD+JJOIXJ6I/0x1CG0=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB3229.eurprd04.prod.outlook.com (10.170.231.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Mon, 16 Dec 2019 01:24:35 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 01:24:35 +0000
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
Thread-Index: AQHVsDrKPWSbvY6T+0OJ94dLsbCA8qe2ObMAgAJTXYCAA3BKkA==
Date:   Mon, 16 Dec 2019 01:24:35 +0000
Message-ID: <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20191211155032.167032-1-paul@crapouillou.net>
        <20191211155032.167032-3-paul@crapouillou.net>
        <20191212091814.GA7035@b29397-desktop> <1576270147.3.0@crapouillou.net>
In-Reply-To: <1576270147.3.0@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35b637ed-a5e1-4c42-4b53-08d781c6b631
x-ms-traffictypediagnostic: VI1PR04MB3229:
x-microsoft-antispam-prvs: <VI1PR04MB3229D387431E7EF62D46BC518B510@VI1PR04MB3229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(7696005)(478600001)(4326008)(5660300002)(33656002)(26005)(52536014)(6506007)(6916009)(66556008)(86362001)(66946007)(316002)(54906003)(64756008)(76116006)(186003)(44832011)(9686003)(7416002)(8676002)(71200400001)(55016002)(8936002)(66476007)(66446008)(81166006)(81156014)(2906002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3229;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Yl6s7ezAOyhIYkO9aQAEbwLzL9dZWre+IfcSs9QoOZXbWuEvIkCdU30lBef8T7CmCJAVS8xhRTLzDg7MRJ8ao+0Yh3WuSZu8oIMWspfpPj+YZIiO1SOqstzBOBR+q8b/6T7xYTLKlybrhmE4V75Gs87Shcbrczrzr2Pa1Xv541Sukl0wd+fnJvPC/IFcvMSKcmh62YOXcceR2cV2N3pJiDqcntqZFrghGBb1KDeAM3Dlu9r6zKsrONuI7emimIOM3quw+lAO41bQYCaYbHmrJySrLlhNdUKcrlJACgVMXF7cYeCwJymebF1E1+TwY0V4tTDholEZhkaoJRQ4beANtFRgoKO0zI/aJ/Lv6KOz52IAN0xM0Yb/1c+QdMbigt2bzr/G5DQsFbLSsfCzZBo1EhnJ5BbVl6hEGbVMqfR1w7B6zoqjNTJE6aRq+yk3Wd+Fu7wnUrf1iQc5b45ti/Fd2EoobXY/a6yyqe8jmxT+OsY8EbGKdWvDvSmldIWU68p
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b637ed-a5e1-4c42-4b53-08d781c6b631
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 01:24:35.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wEwjRdPxSS3hdbP9zP6/Kl1zt7l/1aF8fcGEMAsDFs19CzoEUj179+mz+2/GTfyvSlL2MT0UNzhZVFMBxKenQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3229
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=20
> >>  +
> >>  +	desc =3D &charger->desc;
> >>  +	desc->name =3D "usb-charger";
> >>  +	desc->properties =3D usb_charger_properties;
> >>  +	desc->num_properties =3D ARRAY_SIZE(usb_charger_properties);
> >>  +	desc->get_property =3D usb_charger_get_property;
> >>  +	desc->type =3D POWER_SUPPLY_TYPE_USB;
> >
> > What's your further plan for this generic USB charger?
> > To support BC1.2, we need to know charger type, and how we could get
> > it?
> >
> > Peter
>=20
> Well I don't really know. The USB role framework does not give any info a=
bout
> what's plugged.
>=20

What's the use case for this patch set? How it be used?

Thanks,
Peter

> -Paul
>=20
>=20
> >
> >>  +
> >>  +	charger->charger =3D devm_power_supply_register(dev, desc, &cfg);
> >>  +	if (IS_ERR(charger->charger)) {
> >>  +		dev_err(dev, "Unable to register charger");
> >>  +		return PTR_ERR(charger->charger);
> >>  +	}
> >>  +
> >>  +	err =3D usb_role_switch_register_notifier(charger->role,
> >> &charger->nb);
> >>  +	if (err) {
> >>  +		dev_err(dev, "Unable to register USB role switch notifier");
> >>  +		return err;
> >>  +	}
> >>  +
> >>  +	return devm_add_action_or_reset(dev, usb_charger_unregister,
> >> charger);
> >>  +}
> >>  +
> >>  +static const struct of_device_id usb_charger_of_match[] =3D {
> >>  +	{ .compatible =3D "usb-charger" },
> >>  +	{ /* sentinel */ },
> >>  +};
> >>  +MODULE_DEVICE_TABLE(of, usb_charger_of_match);  +  +static struct
> >> platform_driver usb_charger_driver =3D {
> >>  +	.driver =3D {
> >>  +		.name =3D "usb-charger",
> >>  +		.of_match_table =3D of_match_ptr(usb_charger_of_match),
> >>  +	},
> >>  +	.probe =3D usb_charger_probe,
> >>  +};
> >>  +module_platform_driver(usb_charger_driver);
> >>  +
> >>  +MODULE_DESCRIPTION("Simple USB charger driver");
> >> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> >> +MODULE_LICENSE("GPL");
> >>  --
> >>  2.24.0
> >>
> >
> > --
> >
> > Thanks,
> > Peter Chen
>=20


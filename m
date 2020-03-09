Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C717E013
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 13:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgCIMUU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 08:20:20 -0400
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:39296
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbgCIMUT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 08:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFphMUX3SMR6owq7r49H/e3a51QD/hF+hiduKPt7yJPvZjmDUgqY4L5q7fUcxwvc4BRZNcm1Y83Mt2qdDfqWMk0Z0e+zpja6nAwabzu1H+RIERMDT1FeBHFhZV/TmlZSBUBgvNjHREQ+7nO2JXEqi5NCe1yugnW2ZR3KdfSB0QRxlzGpEg89lrljVN1c8ZTbTrsH48zs7v3ZnWRVqflY899BnydBl+SMw3q9ThsapOjiYx7PNbX9oq2PIJXG9z+LZ4rfSx+vEM30Ea6FDhICgDIdxuTKVwtNtMNmxMkSNosg6bQrjcw/XZagpUVkss0+3ortd2NwU1HlNuADj36LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXUBHp6mXq14jGibTQXvuZyQpL+5M0pw2w+qjMrh9H0=;
 b=XVMSwgBRk2M/vUWYZzxnO2sc7k3mW+wd56/GSRhVrF/dIkiqhQaBB6bNiaD6yVzpGLvbPMGDX4QTc6BaNOCIcsTPnC/ZuVfJb6+LgDvWzD3YZ5KM/VZZSZkKnd/RUzomEsJqEEVcfD0GdCNOQRy18FOVnq87zWQJNxJpFjUGr5VjE/Nftl5aTGvWl3d9EvDE+7qvZMeudbJx2UF/PxbfmghM3QFgexPCOrBFBoikFdQxRow2hQF+cR+8g+eEoSX2JLMwmD2LjWHkiMyvC+lyGfAplGR25E9aTj+S9D/qzI3QuSgfSQLmBA3IC5TbgdvLSwNLB22I3DyfU3BRAqMDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXUBHp6mXq14jGibTQXvuZyQpL+5M0pw2w+qjMrh9H0=;
 b=Ga4cPinVR60LBPQfwyMFeZflYNuKEdi/A4ZiYwBJBBLmSOGFD6jPKDFX0NDzxx7HChZ1p1AOChyG7DFUDp2OTgu5o3UdKOERenkfe71ZtXIBs3t0VCFrNqOlGbAUgoLr32U+AkQB7YZBBPWCTX2ekb1/4WlpBQH5kAvxEprrX4U=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 12:20:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 12:20:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Topic: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahAGiGAgAAUKRA=
Date:   Mon, 9 Mar 2020 12:20:14 +0000
Message-ID: <DB3PR0402MB3916FA1EA54CF342E21350BEF5FE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <20200309110609.GE3563@piout.net>
In-Reply-To: <20200309110609.GE3563@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69461a82-7002-4b9f-f77d-08d7c4243894
x-ms-traffictypediagnostic: DB3PR0402MB3818:|DB3PR0402MB3818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3818DC3BD33B2F51E0B6A503F5FE0@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(316002)(33656002)(26005)(186003)(54906003)(7696005)(4744005)(86362001)(81156014)(81166006)(66446008)(76116006)(8936002)(5660300002)(66556008)(8676002)(64756008)(66476007)(478600001)(66946007)(71200400001)(52536014)(2906002)(6506007)(7416002)(6916009)(4326008)(9686003)(44832011)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhVYfGwZJdGlYYDAPuWsuGL2loB+BcmIX0NP+WXWa2X/nmRUahYSzt8VATW5G1amkxi1Wp7mteKiTZ7B3BxI+b2FWkwiYjX2zmYopLeTFlfIhG1eW3j0XrsUENR6IxckpkuFwoJc85yIHLDmUQXGti2tIS6M2nCuo3nGHjcbj9suNs+ZUSLNPUh2xejlzoXWA+9C5RM8zFGYppoW6VjE9BHmFoCciyYfqjiftV6Iw05W4cZCk4/TNI+ijIcNX1XVuyewhVhN6u1XsqRJbznWJci8Vgq8i39wGhsL/Ao46VzFkf2kpRFlMLR2KkqYheT1Ta8ByLlBQZDVv5gP+jD9qnXzvo6MaucsE+ufJhp+q9u7TCUMW2AcoyuEJwUIQvbyAsJ9ocwP7KPIK/5hYS1pirh7bdSVvF+uZS+F7SR1mHLjlb/7PM1LQhZBu15N0tu/
x-ms-exchange-antispam-messagedata: TuLX2sfxP8NEiOolHPdFaeiww7l+BeKxMXTMTa/jCWT4cPtwZhOCF/dL1GInzHFEXD5PSFPsAep+2R4ypL/jLJtDWIalpX8d3m98AMjbO5+Aci2aTKm83okypYlHZBwNobq8+u9kfg0SINEtuEQ8dQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69461a82-7002-4b9f-f77d-08d7c4243894
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 12:20:14.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42RyDOXBI3wjM+iIMF6/YHiRBIq0gk57cKyOJPcJIbp7um3Zf9DyWx52bMArn3fDOEuezGrE3pY7sHewsiY6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFsZXhhbmRyZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS83XSBmaXJtd2FyZTog
aW14OiBBZGQgc3R1YnMgZm9yICFDT05GSUdfSU1YX1NDVQ0KPiBjYXNlDQo+IA0KPiBPbiAwOS8w
My8yMDIwIDA4OjM4OjE0KzA4MDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEFkZCBzdHVicyBm
b3IgdGhvc2UgaS5NWCBTQ1UgQVBJcyB0byBtYWtlIHRob3NlIG1vZHVsZXMgZGVwZW5kaW5nIG9u
DQo+ID4gSU1YX1NDVSBjYW4gcGFzcyBidWlsZCB3aGVuIENPTVBJTEVfVEVTVCBpcyBlbmFibGVk
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWMjoNCj4gPiAJLSByZXR1cm4gZXJyb3Ig
Zm9yIHN0dWJzLg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoeSB5b3UgYXJlIHNlbmRpbmcgdjMgd2l0
aCB0aGUgc3R1YnMgYXMgd2UgZGV0ZXJtaW5lZCB0aGF0DQo+IDIvNyBpcyBlbm91Z2ggdG8gY29t
cGlsZSBhbGwgdGhlIGRyaXZlcnMgd2l0aCBDT01QSUxFX1RFU1QuDQoNCkl0IGlzIGp1c3QgYmVj
YXVzZSBJIGFtIE5PVCBzdXJlIHdoaWNoIGFwcHJvYWNoIG1haW50YWluZXIgcHJlZmVyLCB0aGUg
VjMgaXMgdG8NCmFkZHJlc3MgdGhlIGNvbW1lbnQgb2YgVjIuIElmIGV2ZXJ5b25lIGFncmVlIHRo
YXQgMi83IGlzIGVub3VnaCwgdGhlbiBJIHRoaW5rIElNWF9TQ1UNCm1haW50YWluZXIgY2FuIGp1
c3QgcGljayB1cCBWMSBwYXRjaCBzZXJpZXMsIHNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLg0KDQpU
aGFua3MsDQpBbnNvbg0KIA0K

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A16186779
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 10:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgCPJJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 05:09:03 -0400
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:55649
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730152AbgCPJJC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 05:09:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeQUXUpc0Xbrod7aklB7IhDQuVgyevv/fImH3PkKCLjLFkC0NpRkfPJwLuU6cx81kpRrFzL/fu+XAdfgzA1Jc64v3YwoMKCdJ8ExNQmkTVgmXqEuryJYfVD0AXD1aJSlbTt+TJhJlyflJiZEiYFQvMZwVtDBA3ga9o6xB7WgAeiPmFhio3paS5VWMoGFJftfKiff0b42dLCvjD3O6bC8RRg/TXTvhlVf3LQ18t4hyyDR6lgA56zWdMkUwGiV+7kxXAeugdq+dirPM/+l3kGKwGOCknDkJkvjj3nbQJUuqgrMC2Gnj9ZqY35orq2Sb/sRvSmbEp1pOe4Emp6WxSJzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kjgbNFQGJVbdwxCHfpgZXiPXx2dSYRdXoSSFADNk6s=;
 b=E9HCk4Lmu7+UcQe+rq4rQrPW/yjaELdrRze8gNspmcnUYTrRBa1DIBCsilwQI5gk31/jx/CcMwt4gtRvH4Dsd50W59naN1Dztf6XU63RbfyOoaBZSaCi4dG1S+EJdSIMTmPq1DphezK90FXAQyVHxRAUREmf0oBFBcNaa3VdLqJ8w6hrB8mNkEn6SUMlMqPfDwoC6D9coTSafSXYd3cakbdcM7HtYQrF5yIWouM9NEPnVEq5YJaB1EaA1j1BFnzB5ES+aTB4mweC3enjy4hw9eLxCWQYkBzIbc4tI2pJGqIIWiSC3TdHE9vaR0Ke2CxHe0YH8yZ6r4friBpQM/U/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kjgbNFQGJVbdwxCHfpgZXiPXx2dSYRdXoSSFADNk6s=;
 b=PvYcswTtFXiF8KaGnJ+oQRWTHV+bBOjVgNlgjW6QzWr3rPRsMXJIpi8letNQhHthD74g6R4zaRBXHxjqj6y6Dl953PkTY1p8j3HyEwSkfXWVbaIw1ODpopZxufr11tSYuAWO0oXYdz+r1Z8G2rpV3lyjawJKfLUba7ooZMI8u/s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (52.134.65.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Mon, 16 Mar 2020 09:08:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 09:08:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
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
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahARTIAgAopwQCAACFfgIAABHaAgAADEYCAAAR+AIAASuWQgAAKpACAAABIoIAABUuAgAABn+A=
Date:   Mon, 16 Mar 2020 09:08:53 +0000
Message-ID: <DB3PR0402MB391683A05820920158DFDA77F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481F087AC3CDA691300710288FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316005219.GD17221@dragon>
 <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316030744.GC17221@dragon>
 <AM0PR04MB44817A48746601EADA4E06BC88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316033447.GE17221@dragon>
 <DB3PR0402MB3916DA9F0F175B9D2E9E684FF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316084056.GG4518@piout.net>
 <DB3PR0402MB391663DB37A8D241092AD708F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316090053.GH4518@piout.net>
In-Reply-To: <20200316090053.GH4518@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0225dfd-997e-45af-c0d3-08d7c989a6bf
x-ms-traffictypediagnostic: DB3PR0402MB3913:|DB3PR0402MB3913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3913F57B4249EB6BE885172BF5F90@DB3PR0402MB3913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(76116006)(71200400001)(66556008)(8676002)(66476007)(2906002)(66946007)(81156014)(81166006)(66446008)(64756008)(6506007)(55016002)(44832011)(9686003)(7696005)(54906003)(5660300002)(7416002)(478600001)(316002)(33656002)(86362001)(6916009)(4326008)(52536014)(8936002)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tme6ENiCGhuOHJ3+bkaEKvdCWwWZKX+UtuXA5yr0GJEStqOzL1t1shOjUClxkRNicO8W1aulaXd986Av4exBjZgmGDv23oOUNjIx5Iz/qTSEylLp3KXWwswap4NEpXl7iVSueQMZ3/gjxGENZbQ8KmrYsVl0Y1uP0W8SFyyJTzswvBT3xRQxTzWVEMuhuKz2Kkq4AKCgDBHR7gRA9iB+BoxrkJECt0N1ULpxwqjjGonYLo3eVa8bIWqOb88Jf5s6m9ypZ+msEtuu/wYPb5OEEytOAk9pGGr/UwWcfzYXmNe6GTpg8ZtonkjK2Kinhsz/uLejC6fNAsGIsV6m9KDj6A9J9MCt6wrd91A0xBvPUcf7RxwAq5H+h38loz15Zl7zs2qKzb7rAyqEuJCsGBi7JfRbmyrF35ym4j1PSWUkK8E6JJyvEfrjMFMMnGG54KLC
x-ms-exchange-antispam-messagedata: CHrqtDOfD+64TlZJOBIyqkF0sqx7Zmtpwjows/UXA22Gq6ML8W+lz0pVXeIT4uVd2+jGhVlMnmKxSvQE/FH4hHgo4su0yB3k7nkAvDEOLWQ3L72BgG3yGdAn1Jx07o+qoBDiUiUAbIWmgrBsA7gZZw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0225dfd-997e-45af-c0d3-08d7c989a6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 09:08:53.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jem9JTRit0K1ldnKfsoTiTO+y83DBSOiEF91ZTH1woVlhsZSMqHdhn7HnS3y+0jH5T1VjBy4+gBbaupYGABPvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFsZXhhbmRyZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS83XSBmaXJtd2FyZTog
aW14OiBBZGQgc3R1YnMgZm9yICFDT05GSUdfSU1YX1NDVQ0KPiBjYXNlDQo+IA0KPiBPbiAxNi8w
My8yMDIwIDA4OjQ0OjEwKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS83XSBmaXJtd2FyZTogaW14OiBBZGQgc3R1YnMgZm9y
DQo+ID4gPiAhQ09ORklHX0lNWF9TQ1UgY2FzZQ0KPiA+ID4NCj4gPiA+IE9uIDE2LzAzLzIwMjAg
MDg6MDQ6MTcrMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+IEhpLCBTaGF3bg0KPiA+
ID4gPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS83XSBmaXJtd2FyZTogaW14
OiBBZGQgc3R1YnMgZm9yDQo+ID4gPiA+ID4gIUNPTkZJR19JTVhfU0NVIGNhc2UNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IE9uIE1vbiwgTWFyIDE2LCAyMDIwIGF0IDAzOjE4OjQzQU0gKzAwMDAsIFBl
bmcgRmFuIHdyb3RlOg0KPiA+ID4gPiA+ID4gSnVzdCBzZW50IG91dC4gT25lIG1vcmUgdGhpbmcs
IEkgdGhpbmsgYWxsIGRyaXZlcnMgZGVwZW5kcyBvbg0KPiA+ID4gPiA+ID4gSU1YX1NDVSBzaG91
bGQgbm90IGhhdmUgQ09NUElMRV9URVNUIGlmIHdlIHBsYW4gbm90IHRvIGFkZA0KPiA+ID4gPiA+
ID4gZHVtbXkgZnVuY3Rpb25zLiBJIHNlZSB5b3UgcGlja2VkIHVwIEFuc29uJ3MgcGF0Y2ggaW4N
Cj4gPiA+ID4gPiA+IGlteC9kcml2ZXJzIGJyYW5jaCwNCj4gPiA+IHBsZWFzZSBjaGVjayBtb3Jl
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGEsIHllcy4gQ09NUElMRV9URVNUIHNob3VsZCBiZSBk
cm9wcGVkIGZvciBJTVhfU0NVX1BEIGluDQo+ID4gPiA+ID4gQW5zb24ncw0KPiA+ID4gcGF0Y2gu
DQo+ID4gPiA+ID4gVGhhbmtzIGZvciByZW1pbmRpbmcuDQo+ID4gPiA+DQo+ID4gPiA+IEkgc3Rp
bGwgTk9UIHF1aXRlIHVuZGVyc3RhbmQgd2h5IHdlIHdvbid0IHN1cHBvcnQgQ09NUElMRV9URVNU
IGZvcg0KPiA+ID4gPiBTQ1UgZHJpdmVycywgd2l0aCB3aG9zZSBzdHVicywgdGhlIGJ1aWxkIHNo
b3VsZCBiZSBPSywgaWYgdGhlcmUgaXMNCj4gPiA+ID4gYW55IGJ1aWxkIGVycm9yLCB3ZSBzaG91
bGQgdHJ5IHRvIGZpeCBpdCwgTk9UIGp1c3QgcmVtb3ZlIHRoZQ0KPiA+ID4gPiBDT01QSUxFX1RF
U1QNCj4gPiA+IHN1cHBvcnQsIGFueSBzcGVjaWFsIHJlYXNvbj8NCj4gPiA+ID4NCj4gPiA+DQo+
ID4gPiBDT01QSUxFX1RFU1QgaXMgc3VwcG9ydGVkIGFzIGxvbmcgYXMgSU1YX1NDVSBpcyBzZWxl
Y3RlZCBsaWtlIGlzIGl0DQo+ID4gPiBmb3IgYW55IGRyaXZlciBkZXBlbmRpbmcgb24gYW55IGJ1
cy4NCj4gPg0KPiA+IEJ1dCB3aXRob3V0IGhhdmluZyAiIHx8IENPTVBJTEVfVEVTVCAiIGluIGtj
b25maWcsIENPTVBJTEVfVEVTVCB3aWxsDQo+ID4gTk9UIGJlIHN1cHBvcnRlZCwgSSB0aGluayBh
cyBsb25nIGFzIHdlIGhhdmUgc3R1YnMgZm9yIHRob3NlIFNDVSBBUElzLA0KPiA+IGFsbCBkcml2
ZXJzIGRlcGVuZGluZyBvbiBJTVhfU0NVIGNhbiBzdXBwb3J0IENPTVBJTEVfVEVTVA0KPiBpbmRl
cGVuZGVudGx5Lg0KPiA+DQo+IA0KPiANCj4gV2h5IGRvIHlvdSBhYnNvbHV0ZWx5IG5lZWQgdG8g
Y29tcGlsZSB0aGVtIGluZGVwZW5kZW50bHk/IEZyb20gYSBjb2RlDQo+IGNvdmVyYWdlIHBvaW50
IG9mIHZpZXcsIGhhdmluZzoNCj4gDQo+IENPTVBJTEVfVEVTVD15DQo+IENPTkZJR19JTVhfU0NV
PXkNCj4gDQo+IGlzIGVub3VnaCB0byBzZWxlY3QgYW5kIGNvbXBpbGUgdGhlIHJlbWFpbmluZyBk
cml2ZXJzLg0KDQpXaGF0IEkgbWVhbnQgaXMgZm9yIGJlbG93IGNhc2UsIGxpa2UgdXNpbmcgb3Ro
ZXIgYXJjaCBjb25maWcgd2hpY2ggZG9lcyBOT1QgaGF2ZQ0KQ09ORklHX0lNWF9TQ1Ugc2VsZWN0
ZWQsIE9OTFkgd2l0aCBDT01QSUxFX1RFU1Qgc2VsZWN0ZWQsIGFkZGluZyBzdHVicyBmb3INCklN
WF9TQ1UgQVBJcyBjYW4gZml4IHN1Y2ggc2NlbmFyaW8uDQoNCkNPTVBJTEVfVEVTVD15DQpDT05G
SUdfSU1YX1NDVT1uDQoNCkFuc29uDQo=

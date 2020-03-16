Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FCB1868C8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgCPKSk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 06:18:40 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:1924
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730478AbgCPKSk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 06:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqEqdJBsTxv6mbgra3wF69F+uhNHVaAcROHEjP0tHcJrCgTjNds04OeNx4VyrKiNkVBwE90rgKW98Q0gqN8SiT3xCH6ccnyuNvnDdluFieAC51qoZg+EEzxQ1wZMZUbOmhF9/sneZr6wP6G11mWz3SNouJH/C3d6TH7UgUbsSZBZhGGzSS5qXC0ik72Ui0vVNHEevy9tmhWwKwXZgSrwV9K0At6Yks8cwQsh4QgopPo4huum7SFgjNniPQwmBAHjmeEtT0PzUo9+VMNGHEw/FAgBQdNsCCh2y7hSyhANf/UlLeXm7sPnza6JsZXdbZiUzacMdmolCXpVm7jAOzEYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6s2FdtyG0cmPEEhSbx4w6x5jgjcivBIWfArPsvWMxY=;
 b=aQWb+HQ3iFM+RGKCGph2IJSXQr24kHeOKZvI2vzw3amxGM5MktXczBwhEfY2gBRhLf9d4BaRWSg1Av1jw3SEljLCKGQDIn7WGaxnMMoYIez3zuuhki9gTOyEoIGbQ69XexTtIdZfFvurI4cgzd7Pd7R9Ngbhd8zswgrthsA/q0H42PmbxSgXeecVJyaG3g92OVpxBemVLRlGMbvD8UnXxeX9oeHa6fSVpBWBUYl/ZqjhSm81hoZBgYaYMUU9eXstGPB/zOaebJgvapGdK/9wfOR9XhFrJ0AdBqLB/iie8MzL16ZwKIuWjrqvrJ6L4Kazhv+sMKcnvwJcYbf27rol/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6s2FdtyG0cmPEEhSbx4w6x5jgjcivBIWfArPsvWMxY=;
 b=mxAcSsJu2R1GM0GorrLIMltGi33K2ZThoSVqKpO7iAwvN0B6EPSlbksf/tZlVxGZs5Fi2sm0FR9msJMyOK1Ip84UJOvvdJ8GthbFV05q9i4N5xSFS8JgDrD9nTKn82kyvjnXPosrCxhelRl+oHOqNRPu0tTpaI0xQ6siSr0xozM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Mon, 16 Mar 2020 10:18:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 10:18:21 +0000
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
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahARTIAgAopwQCAACFfgIAABHaAgAADEYCAAAR+AIAASuWQgAAKpACAAABIoIAABUuAgAABn+CAAAKDgIAABdZwgAAGoICAAATqwA==
Date:   Mon, 16 Mar 2020 10:18:21 +0000
Message-ID: <DB3PR0402MB39162BD818145F57C5CBBCC3F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20200316030744.GC17221@dragon>
 <AM0PR04MB44817A48746601EADA4E06BC88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316033447.GE17221@dragon>
 <DB3PR0402MB3916DA9F0F175B9D2E9E684FF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316084056.GG4518@piout.net>
 <DB3PR0402MB391663DB37A8D241092AD708F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316090053.GH4518@piout.net>
 <DB3PR0402MB391683A05820920158DFDA77F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316091541.GI4518@piout.net>
 <DB3PR0402MB39169528B3FF39E23C7A90FCF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316100017.GM4518@piout.net>
In-Reply-To: <20200316100017.GM4518@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eeb64d91-d511-408a-d6f2-08d7c9935aa6
x-ms-traffictypediagnostic: DB3PR0402MB3771:|DB3PR0402MB3771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB377184575E74DBA8F9D5CD77F5F90@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(52536014)(66446008)(9686003)(55016002)(66946007)(71200400001)(6506007)(2906002)(66476007)(64756008)(66556008)(76116006)(7696005)(54906003)(316002)(86362001)(44832011)(6916009)(186003)(33656002)(7416002)(5660300002)(4326008)(8936002)(8676002)(81156014)(81166006)(26005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkAXsuj1fL9vpJsvVLMTjZwMKXI2hhJ9j9li+vXJGCBXrcbCDubffe0CEUT4N9q2xFHfQ/ConVfUwU25j6p0OjiBPMwQDaRRAmSKbPoS3yOTqWXqCynW4iFwgQdGnM8TnVLDkQWr8lLt11G9vq4KiGhZxS32mdmk4amzmXD8htYnyU7Ed1hQbOpnkBMv8ex9zaxqR6lO6cuXptWt+IFkGz9vvQFOqPJOSzKJXda2T5k4MgoGDv1+4DJvZnuULN88QMPGKTR24vBjDTP9fOj9QuJeO0knc7WWla2PLBJWH+9KzWPisAZB3CuLGAob7CSRNQjrPtiqATd+4+dTklN0B4GPHwS5y94HuNgKe0wGSFbbYa5nem1X54NrjJKF5cR4sBj+yHlA+sZmR+G4AnDEfTYdxHecoWumBCCNwbUj9yPWCbMpwXSVGA8i/+Jea3X9
x-ms-exchange-antispam-messagedata: IdKwMxScy4WZZ+yRX0puITeYvu8VVDp6Ci+mKbmbz2RzYf70FXy/Ao3MDyeZPXqQs+haS6oJPwYzl2WFP+8u+ORXW1GVvnCWiMoFcPoJoPFjDTgFHry54gAHVX26z0Cs+uU9x5u8XrQi3+LHc2k5bQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb64d91-d511-408a-d6f2-08d7c9935aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 10:18:21.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAp1/vA1u9dm9yfaeFk0IDjhmcPaah5Jg/od/7t6hROW1KNBK5mGbIELzLKByEBVUe3dpz2yIsqQZhvsgjG30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAxLzddIGZpcm13YXJlOiBpbXg6IEFkZCBzdHVi
cyBmb3IgIUNPTkZJR19JTVhfU0NVDQo+IGNhc2UNCj4gDQo+IE9uIDE2LzAzLzIwMjAgMDk6NDA6
NTIrMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiBXaHkgaXMgdGhhdCBhbiBpc3N1ZT8g
SWYgdGhleSBkb24ndCBoYXZlIElNWF9TQ1Ugc2VsZWN0ZWQsIHRoZW4gdGhlDQo+ID4gPiBvdGhl
ciBTQ1UgZHJpdmVyIGFyZSBub3Qgc2VsZWN0ZWQgZWl0aGVyLCBoYXZpbmcgc3R1YnMgZG9lc24n
dA0KPiA+ID4gY2hhbmdlIHRoYXQgeW91IHdpbGwgaGF2ZSB0byBzZWxlY3QgYXQgbGVhc3Qgb25l
IG9wdGlvbi4gUGxlYXNlDQo+ID4gPiBleHBsYWluIHdoYXQgaXMgdGhlIGlzc3VlIHRoYXQgaXMg
bm90IHNvbHZlZCBoZXJlLg0KPiA+DQo+ID4gT0ssIHdoYXQgSSB0aG91Z2h0IGlzIGV2ZW4gd2l0
aG91dCBJTVhfU0NVIHNlbGVjdGVkLCBvdGhlciBTQ1UgZHJpdmVycw0KPiA+IHN0aWxsIGNhbiBi
ZSBzZWxlY3RlZCBmb3IgYnVpbGQgdGVzdCBhZnRlciBhZGRpbmcgIkNPTVBJTEVfVEVTVCIgdG8N
Cj4gPiB0aGUga2NvbmZpZywgbGlrZSBiZWxvdywgaWYgd2l0aG91dCBJTVhfU0NVIEFQSSBzdHVi
cywgdGhlDQo+ID4gIkNPTVBJTEVfVEVTVCIgY2FuIE5PVCBiZSBhZGRlZCB0byBTQ1UgZHJpdmVy
cyB0byBlbmFibGUgYnVpbGQgdGVzdCwgc28gSQ0KPiB0aGluayB0aGUgSU1YX1NDVSBBUEkgc3R1
YnMgc2hvdWxkIGJlIGFkZGVkPw0KPiA+DQo+IA0KPiBObyB0aGV5IHNob3VsZG4ndCBiZWNhdXNl
IHRoZXJlIGlzIG5vdCBwb2ludCBhZGRpbmcgQ09NUElMRV9URVNUIHRvIHRoZQ0KPiBTQ1UgZHJp
dmVycy4gV2UgZG9uJ3QgYWRkIENPTVBJTEVfVEVTVCB0byBhbGwgdGhlIGRyaXZlcnMgYW5kIGFk
ZCBzdHVicyB0bw0KPiBhbGwgdGhlIHN1YnN5c3RlbXMuIEUuZyB0aGVyZSBpcyBubyBwb2ludCB0
cnlpbmcgdG8gY29tcGlsZSBhbiBJMkMgZHJpdmVyIGlmIHRoZQ0KPiBJMkMgY29yZSBpcyBub3Qg
ZW5hYmxlZC4NCg0KT0ssIG1ha2Ugc2Vuc2UuDQoNClRoYW5rcywNCkFuc29uDQo=

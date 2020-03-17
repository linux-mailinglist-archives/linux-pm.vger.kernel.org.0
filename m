Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6104F1877DE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 03:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCQCfc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 22:35:32 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:37441
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbgCQCfc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 22:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9tomkOGjwlLeM6/x7BVFxaP/ktQikCsd8rSSD5Xxb/IZvxUzAzCnVU5NVN1J9xJ7D/AeLGQ2/VVCsmpccdRTKCqdLiuZEJu0pDxkNl0QxOEvMjXOvYGrXFf83u5ZG4bfRA0lNjRi6cFR6Gv+P3HX27JhI+iILGWhwiaeMIOL13pNoqpscugvkUZ9lp60nlwrB1H5GoQVDSpjSOtxxZuPQQVF3jUlm64p/KD+vRLOQKgR/8eFkATs1yt2Fh164sXM5qkq4gwR20+s8ykHZAWM1CNJ+xRUSI52GSRl2Q+1ptR6ieV6tHH5ehWFlQYmtcBLGTM8jFEWnEXl0KJpjmyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+NYqHSmaa0fBdc/KDbiGtkPs+BO62E0Ys3++B97g4k=;
 b=DL3Obz4RclVWWrA2Dc265f6ECkT07iixSyG9aVAqK/e4/2CReyjnwRrja04FRTJy+aPPlSt+Nl94ZMHBTnKLvJHyon/RGVaNJpDJKo4jp8j1Fc1BCu3PDL4pJbYy0NroesVLeT1QI5qmeKV74SIYtP8QgWfkYcAnvmDopCRgw5soB9cxAESsWsgGLtIgsXudIiJ4RaLWNHgtcpJvVq8fGIJHkHJN6STVb0gBWBVa4B1ZVKnvgGTfMfCzb1gwlkhgndGoTii5x0Fg8185ZvOUOArOzZbop9y2mxXrSrDWFRz9ZOEbfvT7RRbSJ97eP+45l9mGRI/GP4TT1bylgTTbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+NYqHSmaa0fBdc/KDbiGtkPs+BO62E0Ys3++B97g4k=;
 b=JBiF2891vczXb2W+U+Kh9dsXUkNgDOQykkDOP1FVj1DNZMOHqy/HjucIf409Uyn00RSIT1qQYIeANF1a/XzNbrA6hGirXzYPb36b+8gW2M9S/UujOilb7UTIwUn1DcElkq+5jaxcTxSJbtxOVC5j23caJ/grTsPXxf32M9p3R6M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Tue, 17 Mar 2020 02:35:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 02:35:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>, Peng Fan <peng.fan@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
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
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahARTIAgAopwQCAACFfgIAABHaAgAADEYCAAAR+AIAASuWQgAAKpACAAABIoIAABUuAgAABn+CAAAKDgIAABdZwgAEX1ICAAAQYAIAAADvQ
Date:   Tue, 17 Mar 2020 02:35:14 +0000
Message-ID: <DB3PR0402MB3916D27B3D860D8CD7441AA5F5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20200316005219.GD17221@dragon>
 <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316030744.GC17221@dragon>
 <AM0PR04MB44817A48746601EADA4E06BC88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316033447.GE17221@dragon>
 <DB3PR0402MB3916DA9F0F175B9D2E9E684FF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316084056.GG4518@piout.net>
 <DB3PR0402MB391663DB37A8D241092AD708F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316090053.GH4518@piout.net>
 <DB3PR0402MB391683A05820920158DFDA77F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316091541.GI4518@piout.net>
 <DB3PR0402MB39169528B3FF39E23C7A90FCF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB4481A54C639FD1D45098302088F60@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <b049be1c-1f3f-54fc-3c47-0873d95cb769@roeck-us.net>
In-Reply-To: <b049be1c-1f3f-54fc-3c47-0873d95cb769@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c52e271-4b53-454d-54e9-08d7ca1bd327
x-ms-traffictypediagnostic: DB3PR0402MB3867:|DB3PR0402MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB386787CA5704A21198D23D91F5F60@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(66446008)(66556008)(9686003)(66946007)(64756008)(55016002)(66476007)(76116006)(81156014)(8676002)(186003)(81166006)(33656002)(44832011)(26005)(8936002)(71200400001)(54906003)(7696005)(316002)(110136005)(6506007)(53546011)(478600001)(5660300002)(52536014)(4326008)(86362001)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z8xABrCeRLQT8wbQN4x43VrI3XB6MxyEJyv8fvR/M09LIG3AnXhyONZrrHps7HoFQLPPa8lofnRrdUevCiPEtmWDs26AHM6CyeHQuThtHKexLUmNKukxVZw6Jmw2bHyDVpw8WXL6xp9nd66/c68vtBYkcO/eOijxErUdYW/6pYPEfE+kCz+53/pSJdh2P0skywAC7H0l3De8F30O8DfbORF3QX+kpT/dH+D6ISoo3LgmzYQdhEOozEVrNaM9pCWaHZQLQFyE+qz1utLQl1zIr4CAM4dGcOzt6P2gKXe7Tn7v1QNg4NtCcB3BwOsiMqQvqUMk66TXym9ewGL0jSPc01F7XOPtn5GlAxiUcnVdxvhUVMRjQYpXqku5tvsPiJs3U24VJnxc2vOakM1JkqxehCyWenRcZUY6I9WEbpHUqCDz7GNTlfaSWNTlWQVq81UZ
x-ms-exchange-antispam-messagedata: KZmNt9s8qU4StJt9ayQx5SUSX+tY88hgKy5CgyODV/qHfrupsWORm61SrbEeQj11flqM9yHGcJdQZPEcLNZVtCgfR9NUXi7ds3/dGZo81p/RslnrgyHf+VKvMTSqrXd6BuE+pKIUNXLTC+/gLXLLog==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c52e271-4b53-454d-54e9-08d7ca1bd327
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 02:35:15.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GV1D4U8PA+UsRWkvumzzlzzm4LYD9fxG8vheS7XkU17aDSYRgsHlxN6VJqVlvRcgqFgh2g/VBUzivcji0/GD4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS83XSBmaXJtd2FyZTogaW14OiBBZGQgc3R1YnMg
Zm9yICFDT05GSUdfSU1YX1NDVQ0KPiBjYXNlDQo+IA0KPiBPbiAzLzE2LzIwIDc6MTggUE0sIFBl
bmcgRmFuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSRTogW1BBVENIIFYzIDEvN10gZmlybXdhcmU6
IGlteDogQWRkIHN0dWJzIGZvcg0KPiA+PiAhQ09ORklHX0lNWF9TQ1UgY2FzZQ0KPiA+Pg0KPiA+
PiBIaSwgQWxleGFuZHJlDQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+Pj4gRnJvbTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4u
Y29tPg0KPiA+Pj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNiwgMjAyMCA1OjE2IFBNDQo+ID4+PiBU
bzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4+PiBDYzogU2hhd24gR3Vv
IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+Ow0K
PiA+Pj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0
ZXZhbUBnbWFpbC5jb207DQo+ID4+PiBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tOyBhLnp1bW1v
QHRvd2VydGVjaC5pdDsNCj4gPj4gcnVpLnpoYW5nQGludGVsLmNvbTsNCj4gPj4+IGRhbmllbC5s
ZXpjYW5vQGxpbmFyby5vcmc7IGFtaXQua3VjaGVyaWFAdmVyZHVyZW50LmNvbTsgd2ltQGxpbnV4
LQ0KPiA+Pj4gd2F0Y2hkb2cub3JnOyBsaW51eEByb2Vjay11cy5uZXQ7IERhbmllbCBCYWx1dGEN
Cj4gPj4+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
ZzsNCj4gPj4+IGxpbnV4QHJlbXBlbC1wcml2YXQuZGU7IHRnbHhAbGludXRyb25peC5kZTsgbS5m
ZWxzY2hAcGVuZ3V0cm9uaXguZGU7DQo+ID4+PiBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRl
bC5jb207DQo+ID4+PiBhcm5kQGFybmRiLmRlOyByb25hbGRAaW5ub3ZhdGlvbi5jaDsga3J6a0Br
ZXJuZWwub3JnOw0KPiA+Pj4gcm9iaEBrZXJuZWwub3JnOyBMZW9uYXJkIENyZXN0ZXogPGxlb25h
cmQuY3Jlc3RlekBueHAuY29tPjsgQWlzaGVuZw0KPiA+Pj4gRG9uZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+PiBsaW51
eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4gPj4+IHJ0Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+ID4+PiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+ID4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDEvN10gZmly
bXdhcmU6IGlteDogQWRkIHN0dWJzIGZvcg0KPiA+Pj4gIUNPTkZJR19JTVhfU0NVIGNhc2UNCj4g
Pj4+DQo+ID4+PiBPbiAxNi8wMy8yMDIwIDA5OjA4OjUzKzAwMDAsIEFuc29uIEh1YW5nIHdyb3Rl
Og0KPiA+Pj4+PiBXaHkgZG8geW91IGFic29sdXRlbHkgbmVlZCB0byBjb21waWxlIHRoZW0gaW5k
ZXBlbmRlbnRseT8gRnJvbSBhDQo+ID4+Pj4+IGNvZGUgY292ZXJhZ2UgcG9pbnQgb2Ygdmlldywg
aGF2aW5nOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBDT01QSUxFX1RFU1Q9eQ0KPiA+Pj4+PiBDT05GSUdf
SU1YX1NDVT15DQo+ID4+Pj4+DQo+ID4+Pj4+IGlzIGVub3VnaCB0byBzZWxlY3QgYW5kIGNvbXBp
bGUgdGhlIHJlbWFpbmluZyBkcml2ZXJzLg0KPiA+Pj4+DQo+ID4+Pj4gV2hhdCBJIG1lYW50IGlz
IGZvciBiZWxvdyBjYXNlLCBsaWtlIHVzaW5nIG90aGVyIGFyY2ggY29uZmlnIHdoaWNoDQo+ID4+
Pj4gZG9lcyBOT1QgaGF2ZSBDT05GSUdfSU1YX1NDVSBzZWxlY3RlZCwgT05MWSB3aXRoIENPTVBJ
TEVfVEVTVA0KPiA+Pj4+IHNlbGVjdGVkLCBhZGRpbmcgc3R1YnMgZm9yIElNWF9TQ1UgQVBJcyBj
YW4gZml4IHN1Y2ggc2NlbmFyaW8uDQo+ID4+Pj4NCj4gPj4+PiBDT01QSUxFX1RFU1Q9eQ0KPiA+
Pj4+IENPTkZJR19JTVhfU0NVPW4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IFdoeSBpcyB0aGF0IGFu
IGlzc3VlPyBJZiB0aGV5IGRvbid0IGhhdmUgSU1YX1NDVSBzZWxlY3RlZCwgdGhlbiB0aGUNCj4g
Pj4+IG90aGVyIFNDVSBkcml2ZXIgYXJlIG5vdCBzZWxlY3RlZCBlaXRoZXIsIGhhdmluZyBzdHVi
cyBkb2Vzbid0DQo+ID4+PiBjaGFuZ2UgdGhhdCB5b3Ugd2lsbCBoYXZlIHRvIHNlbGVjdCBhdCBs
ZWFzdCBvbmUgb3B0aW9uLiBQbGVhc2UNCj4gPj4+IGV4cGxhaW4gd2hhdCBpcyB0aGUgaXNzdWUg
dGhhdCBpcyBub3Qgc29sdmVkIGhlcmUuDQo+ID4+DQo+ID4+IE9LLCB3aGF0IEkgdGhvdWdodCBp
cyBldmVuIHdpdGhvdXQgSU1YX1NDVSBzZWxlY3RlZCwgb3RoZXIgU0NVDQo+ID4+IGRyaXZlcnMg
c3RpbGwgY2FuIGJlIHNlbGVjdGVkIGZvciBidWlsZCB0ZXN0IGFmdGVyIGFkZGluZw0KPiA+PiAi
Q09NUElMRV9URVNUIiB0byB0aGUga2NvbmZpZywgbGlrZSBiZWxvdywgaWYgd2l0aG91dCBJTVhf
U0NVIEFQSQ0KPiA+PiBzdHVicywgdGhlICJDT01QSUxFX1RFU1QiIGNhbiBOT1QgYmUgYWRkZWQg
dG8gU0NVIGRyaXZlcnMgdG8gZW5hYmxlDQo+ID4+IGJ1aWxkIHRlc3QsIHNvIEkgdGhpbmsgdGhl
IElNWF9TQ1UgQVBJIHN0dWJzIHNob3VsZCBiZSBhZGRlZD8NCj4gPg0KPiA+IEZvcmdvdCB0byBt
ZW50aW9uLCB3aXRob3V0IHN0dWIgYXBpLCBmb3IgZHJpdmVycyB3aXRoICIgI2luY2x1ZGUNCj4g
PiA8bGludXgvZmlybXdhcmUvaW14L3NjaS5oPiAiIHdpbGwgbWV0IGNvbXBpbGUgZXJyb3Igd2l0
aG91dA0KPiA+ICsjaWZkZWYgQ09ORklHX0lNWF9TQ1UNCj4gPiArI2VuZGlmDQo+ID4NCj4gPiBT
byB3ZSBoYXZlIHRvIHVzZSBpZmRlZiBDT05GSUdfSU1YX1NDVSB0byBndWFyZCB0aGUgaW5jbHVk
ZS4NCj4gPg0KPiBBZGQgImRlcGVuZHMgb24gSU1YX1NDVSIgdG8gdGhlIEtjb25maWcgZW50cnkg
Zm9yIHRob3NlIGRyaXZlcnMsIGFuZC9vcg0KPiBkcm9wICJDT01QSUxFX1RFU1QiIGZyb20gdGhl
aXIgS2NvbmZpZyBlbnRyeS4NCj4gDQo+IFJlYWxseSwgQ09NUElMRV9URVNUIGlzIGFidXNlZCBo
ZXJlLiBJIHN0YXJ0IHRvIHVuZGVyc3RhbmQgdGhvc2Ugd2hvDQo+IGFkdm9jYXRlIHRoYXQgaXQg
c2hvdWxkIGJlIHJlbW92ZWQuIFRoaXMgaXMgYW4gZXhjZWxsZW50IGNhc2UgaW4gcG9pbnQuDQoN
Cll1cCwgQ09NUElMRV9URVNUIHNob3VsZCBPTkxZIGJlIGFkZGVkIHRvIHRob3NlIGluZGVwZW5k
ZW50IGRyaXZlcnMsDQp0aG9zZSBkcml2ZXJzIHdpdGggZGVwZW5kZW5jeSBvbiAiY29yZSIgZHJp
dmVyIHNob3VsZCBOT1QgaGF2ZSBpdCBhZGRlZC4NClNDVSBkcml2ZXJzIGFyZSBzaW1pbGFyLg0K
DQpBbnNvbg0K

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F9199F6
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 10:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfEJIrs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 04:47:48 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:28780
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbfEJIrr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 May 2019 04:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKw7itVYQyo+4eFN59cJKMGPToWKniCev6D+Nvm+0wI=;
 b=AvgKK5wubaXvPiWX1zEAmBQkPSPr4+JJ778fVt+5q2SB0hYJMvNeZZl0zuEmxJ72UPXjULYdZ8UjTbyMCfaG/5oh1//FJNtaWAjhPINQuLgybDh2ubTc53K34tZ9cFvqhIBzUV74gLPEWjMANAMUlSRwDQ4L9Ig2ta0SfiCra40=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4159.eurprd04.prod.outlook.com (52.133.15.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 08:47:36 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::3ca0:86a9:eb1:a8c2]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::3ca0:86a9:eb1:a8c2%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 08:47:36 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Subject: RE: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
Thread-Topic: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
Thread-Index: AQHU+XzmCgrzkjA8mUWSxshg4ZOzYKZjybwAgAADYUCAAEB/AIAAD+og
Date:   Fri, 10 May 2019 08:47:36 +0000
Message-ID: <VI1PR04MB4333372C1DABD0E4C9DD7FE8F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190423022507.34969-1-andy.tang@nxp.com>
 <20190510031335.GD15856@dragon>
 <VI1PR04MB4333D24227603D1497BA3CB9F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <9fb2e306-38c7-2af7-5470-ff5bc4e23370@linaro.org>
In-Reply-To: <9fb2e306-38c7-2af7-5470-ff5bc4e23370@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 836abc34-10ef-47c9-ffe5-08d6d52426ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4159;
x-ms-traffictypediagnostic: VI1PR04MB4159:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB41593ABF2E45E00EA610024AF30C0@VI1PR04MB4159.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(13464003)(189003)(199004)(102836004)(7416002)(68736007)(53546011)(6506007)(53936002)(25786009)(66556008)(64756008)(66476007)(66946007)(66446008)(9686003)(6306002)(44832011)(305945005)(74316002)(66066001)(76116006)(5660300002)(186003)(73956011)(7736002)(86362001)(229853002)(26005)(71190400001)(71200400001)(99286004)(316002)(54906003)(7696005)(110136005)(6246003)(478600001)(2906002)(14454004)(55016002)(6436002)(256004)(81156014)(8936002)(81166006)(8676002)(11346002)(446003)(486006)(33656002)(476003)(3846002)(52536014)(6116002)(76176011)(2501003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4159;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8+9LrmYBvNgeJDyRpXbCGecJT4sWigDHlt1UT61afp3ZUL9LK44kuwQnTq5usfPChdEeCMvun6Qxxh0oO7oTSsMALZ5d8x7cfCxt3g3IUMv09fcwULphksAtZYquBi9xkCKoG4GA+GhiVaFiO7Aw1qFRUCmhwxtry+62ZkTXWg6gbtAEQS/JGvvFnkm7hlRJ3pNLl4C+9b8ZMp8XfTGCY5vQOlLuKIUYeESS3vNqj5WMFqPnensJO3GHks/iVn8gXMXAemN/0Paw0rmeZR/SwodMFUkQAJl/J0Hzcn1RCp/zMmgLq8snSu9qY/4NB5ftMzYstVNRB8dsZ/7dz5albU2bvU0pGZVO/AyFBCQ5QG9UUtUK+a98EUEf35TzW4zNKjc4/kP3QhQZYeGyIhapL7INa22SGLx8wuHdcIiF+eo=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836abc34-10ef-47c9-ffe5-08d6d52426ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 08:47:36.6223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4159
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

KyBWaXJlc2ggZm9yIGhlbHAuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIw
MTnE6jXUwjEwyNUgMTU6MTcNCj4gVG86IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+OyBT
aGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBMZW8gTGkgPGxlb3lhbmcubGlA
bnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBtQHZnZXIu
a2VybmVsLm9yZzsgcnVpLnpoYW5nQGludGVsLmNvbTsgZWR1YmV6dmFsQGdtYWlsLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2Nl0gYXJtNjQ6IGR0czogbHMxMDg4YTogYWRk
IG9uZSBtb3JlIHRoZXJtYWwNCj4gem9uZSBub2RlDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwN
Cj4gDQo+IE9uIDEwLzA1LzIwMTkgMDU6NDAsIEFuZHkgVGFuZyB3cm90ZToNCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJu
ZWwub3JnPg0KPiA+PiBTZW50OiAyMDE5xOo11MIxMMjVIDExOjE0DQo+ID4+IFRvOiBBbmR5IFRh
bmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiA+PiBDYzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5j
b20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmc7IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7DQo+ID4+IHJ1aS56aGFu
Z0BpbnRlbC5jb207IGVkdWJlenZhbEBnbWFpbC5jb20NCj4gPj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCB2Nl0gYXJtNjQ6IGR0czogbHMxMDg4YTogYWRkIG9uZSBtb3JlDQo+ID4+IHRoZXJt
YWwgem9uZSBub2RlDQo+ID4+DQo+ID4+IENhdXRpb246IEVYVCBFbWFpbA0KPiA+Pg0KPiA+PiBP
biBUdWUsIEFwciAyMywgMjAxOSBhdCAxMDoyNTowN0FNICswODAwLCBZdWFudGlhbiBUYW5nIHdy
b3RlOg0KPiA+Pj4gTHMxMDg4YSBoYXMgMiB0aGVybWFsIHNlbnNvcnMsIGNvcmUgY2x1c3RlciBh
bmQgU29DIHBsYXRmb3JtLiBDb3JlDQo+ID4+PiBjbHVzdGVyIHNlbnNvciBpcyB1c2VkIHRvIG1v
bml0b3IgdGhlIHRlbXBlcmF0dXJlIG9mIGNvcmUgYW5kIFNvQw0KPiA+Pj4gcGxhdGZvcm0gaXMg
Zm9yIHBsYXRmb3JtLiBUaGUgY3VycmVudCBkdHMgb25seSBzdXBwb3J0IHRoZSBmaXJzdCBzZW5z
b3IuDQo+ID4+PiBUaGlzIHBhdGNoIGFkZHMgdGhlIHNlY29uZCBzZW5zb3Igbm9kZSB0byBkdHMg
dG8gZW5hYmxlIGl0Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFl1YW50aWFuIFRhbmcg
PGFuZHkudGFuZ0BueHAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiB2NjoNCj4gPj4+ICAgICAgICAg
LSBhZGQgY29vbGluZyBkZXZpY2UgbWFwIHRvIGNwdTAtNyBpbiBwbGF0Zm9ybSBub2RlLg0KPiA+
IEkgbGlrZSB0byBleHBsYWluIGEgbGl0dGxlLiBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRoYXQg
bXVsdGlwbGUgdGhlcm1hbCB6b25lDQo+IG1hcCB0byBzYW1lIGNvb2xpbmcgZGV2aWNlLg0KPiA+
IEluIHRoaXMgd2F5LCBubyBtYXR0ZXIgd2hpY2ggdGhlcm1hbCB6b25lIHJhaXNlcyBhIHRlbXAg
YWxhcm0sIGl0IGNhbiBjYWxsDQo+IGNvb2xpbmcgZGV2aWNlIHRvIGNoaWxsIG91dC4NCj4gPiBJ
IGFsc28gYXNrZWQgY3B1ZnJlcSBtYWludGFpbmVyIGFib3V0IHRoZSBjb29saW5nIG1hcCBpc3N1
ZSwgaGUgdGhpbmsgaXQNCj4gd291bGQgYmUgZmluZS4NCj4gPiBJIGhhdmUgdGVzdGVkIGFuZCBu
byBpc3N1ZSBmb3VuZC4NCj4gPg0KPiA+IERhbmllbCwgd2hhdCdzIHlvdXIgdGhvdWdodD8NCj4g
DQo+IElmIHRoZXJlIGFyZSBtdWx0aXBsZSB0aGVybWFsIHpvbmVzLCB0aGV5IHdpbGwgYmUgbWFu
YWdlZCBieSBkaWZmZXJlbnQNCj4gaW5zdGFuY2VzIG9mIGEgdGhlcm1hbCBnb3Zlcm5vci4gRWFj
aCBpbnN0YW5jZXMgd2lsbCBhY3Qgb24gdGhlIHNoYXJlZCBjb29saW5nDQo+IGRldmljZSBhbmQg
d2lsbCBjb2xsaWRlIGluIHRoZWlyIGRlY2lzaW9uczoNCj4gDQo+ICAtIElmIHRoZSBzZW5zb3Jz
IGFyZSBjbG9zZWQsIHRoZWlyIGJlaGF2aW9yIHdpbGwgYmUgc2ltaWxhciByZWdhcmRpbmcgdGhl
DQo+IHRlbXBlcmF0dXJlLiBUaGUgZ292ZXJub3JzIG1heSB0YWtlIHRoZSBzYW1lIGRlY2lzaW9u
IGZvciB0aGUgY29vbGluZw0KPiBkZXZpY2UuIEJ1dCBpbiBzdWNoIGNhc2UgaGF2aW5nIGp1c3Qg
b25lIHRoZXJtYWwgem9uZSBtYW5hZ2VkIGlzIGVub3VnaC4NCj4gDQo+ICAtIElmIHRoZSBzZW5z
b3JzIGFyZSBub3QgY2xvc2VkLCB0aGVpciBiZWhhdmlvciB3aWxsIGJlIGRpZmZlcmVudCByZWdh
cmRpbmcgdGhlDQo+IHRlbXBlcmF0dXJlLiBUaGUgZ292ZXJub3JzIHdpbGwgdGFrZSBkaWZmZXJl
bnQgZGVjaXNpb24gcmVnYXJkaW5nIHRoZSBjb29saW5nDQo+IGRldmljZSAob25lIHdpbGwgZGVj
cmVhc2UgdGhlIGZyZXEsIG90aGVyIHdpbGwgaW5jcmVhc2UgdGhlIGZyZXEpLg0KPiANCj4gQXMg
dGhlIHRoZXJtYWwgZ292ZXJub3JzIGFyZSBub3QgYWJsZSB0byBtYW5hZ2Ugc2V2ZXJhbCB0aGVy
bWFsIHpvbmVzIGFuZA0KPiB0aGVyZSBpcyBvbmUgY29vbGluZyBkZXZpY2UgKHRoZSBjcHUgY29v
bGluZyBkZXZpY2UpLCB0aGlzIHNldHVwIHdvbid0IHdvcmsgYXMNCj4gZXhwZWN0ZWQgSU1PLg0K
PiANCj4gVGhlIHNldHVwIG1ha2luZyBzZW5zZSBpcyBoYXZpbmcgYSB0aGVybWFsIHpvbmUgcGVy
ICdjbHVzdGVyJyBhbmQgYSBjb29saW5nDQo+IGRldmljZSBwZXIgJ2NsdXN0ZXInLiBUaGF0IG1l
YW5zIHRoZSBwbGF0Zm9ybSBoYXMgb25lIGNsb2NrIGxpbmUgcGVyICdjbHVzdGVyJy4NCj4gVGhl
IHRoZXJtYWwgbWFuYWdlbWVudCBoYXBwZW5zIGluIGEgc2VsZi1jb250YWluZWQgdGhlcm1hbCB6
b25lIChvbmUNCj4gY29vbGluZyBkZXZpY2UgLSBvbmUgZ292ZXJub3IgLSBvbmUgdGhlcm1hbCB6
b25lKS4NCj4gDQo+IEluIHRoZSBjYXNlIG9mIEhNUCwgb3RoZXIgY29tYmluYXRpb25zIGFyZSBw
b3NzaWJsZSB0byBiZSBvcHRpbWFsLg0KSGkgVmlyZXNoLA0KDQpJIHdhbnQgdG8gbWFwIG11bHRp
cGxlIHRoZXJtYWwgem9uZXMgdG8gdGhlIHNhbWUgY29vbGluZyBkZXZpY2UuIFRoZSBhYm92ZSBp
cyB0aGUgZGlzY3Vzc2lvbiBhYm91dCBpdC4NCkl0IHNlZW1zIHJlYXNvbmFibGUuIEJ1dCBJIGFt
IG5vdCBleHBlcnQgb24gdGhpcy4gQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIHNvbWUgdGhvdWdo
dHM/IFRoYW5rcy4NCg0KQlIsDQpBbmR5DQo+IA0KPiANCj4gDQo+IC0tDQo+IA0KPiA8aHR0cHM6
Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYl
MkZ3d3cuDQo+IGxpbmFyby5vcmclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2FuZHkudGFuZyU0MG54
cC5jb20lN0M5MzViN2EwOA0KPiAzMWNjNDY2ZGE0MDgwOGQ2ZDUxNzZmOGUlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzANCj4gJTdDMCU3QzYzNjkzMDY5Mzk2NTU0MDE4OSZh
bXA7c2RhdGE9V0s5TkRCVnd6aENDOVdNa21qTE9iSg0KPiBPQlF3UkclMkZib2VkJTJGS3gxOHhp
Qk5RJTNEJmFtcDtyZXNlcnZlZD0wPiBMaW5hcm8ub3JnIKmmIE9wZW4NCj4gc291cmNlIHNvZnR3
YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzoNCj4gPGh0dHBzOi8vZXVyMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0K
PiBmYWNlYm9vay5jb20lMkZwYWdlcyUyRkxpbmFybyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50
YW5nJTQwbngNCj4gcC5jb20lN0M5MzViN2EwODMxY2M0NjZkYTQwODA4ZDZkNTE3NmY4ZSU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjDQo+IGQ5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2OTMwNjkzOTY1
NTUwMjAyJmFtcDtzZGF0YT1PMG1XTzc2DQo+IDlzSzJaTUdYOUF4Z0xHWU5WZmtGSEJENFpJR0Nj
bHR0dnlQSSUzRCZhbXA7cmVzZXJ2ZWQ9MD4NCj4gRmFjZWJvb2sgfA0KPiA8aHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ0d2l0
dGUNCj4gci5jb20lMkYlMjMhJTJGbGluYXJvb3JnJmFtcDtkYXRhPTAyJTdDMDElN0NhbmR5LnRh
bmclNDBueHAuY29tDQo+ICU3QzkzNWI3YTA4MzFjYzQ2NmRhNDA4MDhkNmQ1MTc2ZjhlJTdDNjg2
ZWExZDNiYzJiNGM2ZmE5MmNkOTljNQ0KPiBjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MzA2OTM5NjU1
NTAyMDImYW1wO3NkYXRhPXRWJTJCaThCazNPcU8NCj4gaCUyRlpIcEJyMk5RREFDVnZ0R2k4S05H
UXQ1ZFphVGV5ZyUzRCZhbXA7cmVzZXJ2ZWQ9MD4gVHdpdHRlciB8DQo+IDxodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4N
Cj4gbGluYXJvLm9yZyUyRmxpbmFyby1ibG9nJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbmR5LnRh
bmclNDBueHAuY28NCj4gbSU3QzkzNWI3YTA4MzFjYzQ2NmRhNDA4MDhkNmQ1MTc2ZjhlJTdDNjg2
ZWExZDNiYzJiNGM2ZmE5MmNkOTkNCj4gYzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MzA2OTM5NjU1
NTAyMDImYW1wO3NkYXRhPTBFOGE5Mzh4RXQ3bDINCj4gTUJMbk1FVHNDUUtmaEpNZ216Rk50dUNL
UFhmNVNZJTNEJmFtcDtyZXNlcnZlZD0wPiBCbG9nDQoNCg==

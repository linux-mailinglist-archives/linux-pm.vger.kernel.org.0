Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B65631E3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 09:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfGIHYd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 03:24:33 -0400
Received: from mail-eopbgr10040.outbound.protection.outlook.com ([40.107.1.40]:33505
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfGIHYd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jul 2019 03:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjpchV01pHmnk5GqI/LL9E4uzXRYyIGfTbbBXOtRVQE=;
 b=QefiUC5NKrwRO7DCxNTrTe/5gprVoAexLDEF2gRMjg1l/+kbPwb7jOrKAozQHgAIOTQFKPDT0gRW4+RPC09ei9HkmuJO5P91QshP1FLCpF06Qyhw1t9LpNYgwwsmVEAMOPGii5prwcc13Kp4KU/rTJyh/61tiIDtvXGbmQ7zoAs=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3752.eurprd04.prod.outlook.com (52.133.29.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 07:24:28 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::d5e6:6a87:7e6:95a]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::d5e6:6a87:7e6:95a%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 07:24:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCH] cpufreq: imx-cpufreq-dt: Assign max supported frequency
 as suspend frequency
Thread-Topic: [PATCH] cpufreq: imx-cpufreq-dt: Assign max supported frequency
 as suspend frequency
Thread-Index: AQHVNWKJ4JQ0/eE8UEiBYmKtB9w1KqbBm1SQgABHZfA=
Date:   Tue, 9 Jul 2019 07:24:28 +0000
Message-ID: <AM6PR0402MB3911FD909B16941E22974FC6F5F10@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <20190708074624.910-1-Anson.Huang@nxp.com>
 <VI1PR04MB5055565FFF1241B61B47F22AEEF60@VI1PR04MB5055.eurprd04.prod.outlook.com>
 <AM6PR0402MB3911ED00DB7CCD6866DB8AE2F5F10@AM6PR0402MB3911.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB3911ED00DB7CCD6866DB8AE2F5F10@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e326853-b8bb-4505-8b7f-08d7043e7a3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3752;
x-ms-traffictypediagnostic: AM6PR0402MB3752:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR0402MB375291F2265A3BF1062F26B8F5F10@AM6PR0402MB3752.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(11346002)(71190400001)(52536014)(71200400001)(446003)(476003)(81156014)(7416002)(5660300002)(6506007)(53546011)(102836004)(7696005)(486006)(14444005)(316002)(8676002)(26005)(186003)(76176011)(99286004)(76116006)(81166006)(305945005)(73956011)(66946007)(44832011)(15650500001)(86362001)(256004)(2940100002)(66476007)(8936002)(74316002)(66556008)(66446008)(64756008)(7736002)(2906002)(110136005)(33656002)(4326008)(229853002)(478600001)(55016002)(6436002)(6246003)(966005)(54906003)(9686003)(53936002)(6306002)(6116002)(3846002)(66066001)(25786009)(68736007)(14454004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3752;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eBx4nTXvm+IeVn5JSmloPXE1DgB/Ic4pN3y/XkQQMo25/Kg35mr1DOFosdMMOnzPz7fPXWhPQklvqhIW5pDcJRaoXQkDJ+p5naEgbxQgNxiScRVjhN8csiDsH/baZBe6SfE9EoZxYxwlwvhl4KOkxLHjPLMgBUUU1KgYpN1vDPdd/2YvkOoMi+32ZwDLK5dwouGUJ0W/onu0BfM8G/6hKrgo/Qb36CxaVuDYUlFDUgvtqY++fVlGt2YuN4eIZhZFTtI9mD0HU92ifKqnXZRyXdoQ468y8PI1bISZuYDWsDX/hb8hpOpR1s9nIq9RUDs12hiLQE0N3lr3UDf20IQsk0YFfN5uL3jw2O2QLJwzE7GfwfgJIOgCeS61cGXRPlXt8apR6RyldpSoqk2nYchkEVGGzn+Q8yNmQu7EbyFbH3s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e326853-b8bb-4505-8b7f-08d7043e7a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 07:24:28.1141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3752
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQo+ID4gT24gNy84LzIwMTkgMTA6NTUgQU0sIEFuc29uLkh1YW5nQG54cC5jb20gd3JvdGU6DQo+
ID4gPiBUbyByZWR1Y2UgdGhlIHN1c3BlbmQvcmVzdW1lIGxhdGVuY3ksIENQVSdzIG1heCBzdXBw
b3J0ZWQgZnJlcXVlbmN5DQo+ID4gPiBzaG91bGQgYmUgdXNlZCBkdXJpbmcgbG93IGxldmVsIHN1
c3BlbmQvcmVzdW1lIHBoYXNlLCAib3BwLXN1c3BlbmQiDQo+ID4gPiBwcm9wZXJ0eSBpcyBOT1Qg
ZmVhc2libGUgc2luY2UgT1BQIGRlZmluZWQgaW4gRFQgY291bGQgYmUgTk9UDQo+ID4gPiBzdXBw
b3J0ZWQgYWNjb3JkaW5nIHRvIHNwZWVkIGdhcmRpbmcgYW5kIG1hcmtldCBzZWdtZW50IGZ1c2Ug
c2V0dGluZ3MuDQo+ID4gPiBTbyB3ZSBjYW4gYXNzaWduIHRoZSBjcHVmcmVxIHBvbGljeSdzIHN1
c3BlbmRfZnJlcSB3aXRoIG1heA0KPiA+ID4gYXZhaWxhYmxlIGZyZXF1ZW5jeSBwcm92aWRlZCBi
eSBjcHVmcmVxIGRyaXZlci4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3B1ZnJlcS9pbXgtY3B1ZnJlcS1kdC5jDQo+ID4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9pbXgtY3B1
ZnJlcS1kdC5jDQo+ID4NCj4gPiA+ICtzdGF0aWMgaW50IF9faW5pdCBpbXhfY3B1ZnJlcV9kdF9z
ZXR1cF9zdXNwZW5kX29wcCh2b2lkKQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGNwdWZyZXFf
cG9saWN5ICpwb2xpY3kgPSBjcHVmcmVxX2NwdV9nZXQoMCk7DQo+ID4gPiArDQo+ID4gPiArCXBv
bGljeS0+c3VzcGVuZF9mcmVxID0gY3B1ZnJlcV9xdWlja19nZXRfbWF4KDApOw0KPiA+ID4gKw0K
PiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArbGF0ZV9pbml0Y2FsbChpbXhfY3B1
ZnJlcV9kdF9zZXR1cF9zdXNwZW5kX29wcCk7DQo+ID4NCj4gPiBUaGUgaW14LWNwdWZyZXEtZHQg
ZHJpdmVyIGlzIGJ1aWx0IGFzIGEgbW9kdWxlIGJ5IGRlZmF1bHQgYW5kIHRoaXMNCj4gPiBwYXRj
aCBwcm9kdWNlcyBhbiBlcnJvcjoNCj4gPg0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi9k
cml2ZXJzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQuYzoxMToNCj4gPiAuLi9pbmNsdWRlL2xpbnV4
L21vZHVsZS5oOjEzMTo0MjogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhfX2luaXR0ZXN04oCZ
DQo+ID4gICAgc3RhdGljIGlubGluZSBpbml0Y2FsbF90IF9fbWF5YmVfdW51c2VkIF9faW5pdHRl
c3Qodm9pZCkgIFwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fg0KPiA+IC4uL2luY2x1ZGUvbGludXgvZGV2aWNlLmg6MTY1NjoxOiBub3Rl
OiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYbW9kdWxlX2luaXTigJkNCj4gPiAgIG1vZHVsZV9p
bml0KF9fZHJpdmVyIyNfaW5pdCk7IFwNCj4gPiAgIF5+fn5+fn5+fn5+DQo+ID4NCj4gPiBBcyBm
YXIgYXMgSSBjYW4gdGVsbCBsYXRlX2luaXRjYWxsIGlzIG5vdCBzdXBwb3J0ZWQgZm9yIG1vZHVs
ZXMuDQo+IA0KPiBBaCwgeWVzLCBJIGhhdmUgTk9UIHRlc3QgdGhlIG1vZHVsZSBidWlsZCwgSSBP
TkxZIHRlc3RlZCB0aGUgYnVpbHQtaW4gY2FzZSwNCj4gdGhhbmtzIGZvciByZW1pbmRlci4NCj4g
DQo+ID4NCj4gPiBWaXJlc2g6ICJtYXggZnJlcSBhcyBzdXNwZW5kIGZyZXEiIGlzIHNvbWV0aGlu
ZyB0aGF0IGNvdWxkIGJlIHVzZWZ1bA0KPiA+IGZvciBvdGhlciBTT0MgZmFtaWxpZXMuIFRoZSBo
YXJkd2FyZSBjYW4gc3VzcGVuZCBhdCBhbnkgZnJlcTsgaXQncw0KPiA+IGp1c3QgdGhhdCB0aGUg
aGlnaGVzdCBvbmUgbWFrZXMgc2Vuc2UgYmVjYXVzZSBpdCBtYWtlcyBzdXNwZW5kL3Jlc3VtZQ0K
PiBzbGlnaHRseSBmYXN0ZXIuDQo+IA0KPiBBZ3JlZS4NCj4gDQo+ID4NCj4gPiBDb3VsZCB0aGlz
IGJlaGF2aW9yIGJlIHB1c2hlZCB0byBjcHVmcmVxLWR0IGFzIGEgYm9vbCBmbGFnIGluc2lkZQ0K
PiA+IHN0cnVjdCBjcHVmcmVxX2R0X3BsYXRmb3JtX2RhdGE/DQo+ID4NCj4gPiBPbmx5IGEgZmV3
IG90aGVyIHBsYXRmb3JtcyB1c2UgdGhpcywgbW9zdCBvdGhlcnMgcGFzcyBOVUxMIGxpa2UgaW14
Lg0KPiA+IEJ1dCBwYXNzaW5nIGN1c3RvbSBTT0Mtc3BlY2lmaWMgZmxhZ3MgdG8gY3B1ZnJlcS1k
dCBtYWtlcyBhIGxvdCBvZg0KPiA+IHNlbnNlDQo+IA0KPiBBbHRob3VnaCB3ZSBoYXZlIG90aGVy
IG1ldGhvZHMgdG8gbWFrZSBpdCB3b3JrIGZvciBpLk1YIHBsYXRmb3JtcywgbGlrZQ0KPiBzZXR0
aW5nIHRoZSBzdXNwZW5kIGZyZXEgYXMgdGhpcyBwYXRjaCBkaWQgYnV0IE9OTFkgYmUgY2FsbGVk
IGJlZm9yZSBzdXNwZW5kLA0KPiBidXQgaWYgY29tbW9uIGNwdWZyZXEtZHQgY2FuIGhhbmRsZSB0
aGlzIGNhc2UsIHRoYXQgd291bGQgYmVuZWZpdCB1cyBhbmQNCj4gb3RoZXIgcGxhdGZvcm1zIGEg
bG90LCB3YWl0aW5nIGZvciB5b3VyIG9waW5pb24uDQoNClBsZWFzZSBpZ25vcmUgdGhpcyBwYXRj
aCwgYmFzZWQgb24gdGhlIGRpc2N1c3Npb24sIEkgaGF2ZSBzZW50IG91dCBhIG5ldyBwYXRjaA0K
c2VyaWVzIHRvIHN1cHBvcnQgdGhpcyBmZWF0dXJlLiBQbGVhc2UgcmV2aWV3IHRoZW06DQpodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMDM2NTA1Lw0KDQpUaGFua3MsDQpBbnNv
biANCg0K

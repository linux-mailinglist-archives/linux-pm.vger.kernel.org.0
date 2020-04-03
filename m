Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF6619CEE6
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbgDCDef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 23:34:35 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:14400
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388951AbgDCDee (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 23:34:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIjHUkZPfwHGJxrLlxStFvJecddaNI5sD1d9zMGQHcEHIXsVJF2db4vN/kHrZ0TaZ9+kxKCnHn2zFkxsHCRTJtahJDqhAhYvbQJNUR8eHdig1Ykua/Z5svYyI3g/lUyFUVscrXs7yW/ChFJedkTCajBrocEQHLm8vAOAvUAJAV69JTykKHz1PL7RLybTzLJQcmGSTca49lrmtLhZMNEPu/LQ2oGzkAkYUJALHzGUwkapIKFDRVKMjUl83YfQX0njZ3tx+xVd9WOXEBuCEnbZq+CAXjEwCDAz51bcMkFb7zNYRbkBf3s4NbX0qJF/jmd3ilwCxNvvH0r0+UFUVpLTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKzOl2f8irD5sTtsiW7yUAcKYVOq0ZG8/EK3jjBOY3o=;
 b=AYQhq1AtvDPS2/oH8Oys1wJZ/tjZptRXboeUmSigRoJ3FhaJ2/YKLCvVMFCKLO2/2lgWIRGuOa/S373/ISgxo96LO/wjv4Ka0OllZtTq41AzVZDe2TeqpFq+7FSkY9lva6xs5JRGFWIGePAh/DkYfKl/2JgNNEJ1mjCl3OqS6zrL6Zf/6qcvPS3r8n2XjZKtWvd8g6FbpZqeVRRJfA7mDW1pEVgFrCXUow8hQvgiVF1zGSvW++o2n4cjdlNgiImCdY/oXRnwrVcYxMyY1oxw5QsZrF7ZE+FHqfgt2IMh8uiqgvaa4WI/8tpyTzDtHFBrM8hPlgNTvsMmSiiO4yuymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKzOl2f8irD5sTtsiW7yUAcKYVOq0ZG8/EK3jjBOY3o=;
 b=kopBYJOOeZm/vGYByI15ik9uoYbrKpGnd1sCX06diJS3Oh+5uaHeko0lqkcWzvWG78zTZSLQDSZJyN9RQ2Qfdln4xpJrrlzGXDub1ypdSHWFhYCiFdjW3qOojKOzyXhPA+22Y3ZJbvtQBnHw5wH1xwYKefrOFnr/5VFnIm/W+OE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3882.eurprd04.prod.outlook.com (2603:10a6:8:10::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 3 Apr
 2020 03:34:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 03:34:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
Thread-Topic: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
Thread-Index: AQHWAQ+QtAia75yS0Eqy8vkWi4oyW6hltAKAgAEav0A=
Date:   Fri, 3 Apr 2020 03:34:28 +0000
Message-ID: <DB3PR0402MB3916AF241DE20AB9CCE1A4C2F5C70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
 <1584966504-21719-3-git-send-email-Anson.Huang@nxp.com>
 <CAHLCerNG3ZBbWrTwXxCbd1BOfyHxuvpAuo5tW_bNKgWcO5zESA@mail.gmail.com>
In-Reply-To: <CAHLCerNG3ZBbWrTwXxCbd1BOfyHxuvpAuo5tW_bNKgWcO5zESA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d30f8d7a-217c-47c8-894e-08d7d77fea5d
x-ms-traffictypediagnostic: DB3PR0402MB3882:|DB3PR0402MB3882:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3882E2F9F4838A6AF050C330F5C70@DB3PR0402MB3882.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(7696005)(8936002)(86362001)(81166006)(8676002)(66946007)(2906002)(44832011)(64756008)(76116006)(66446008)(316002)(66476007)(7416002)(6916009)(71200400001)(66556008)(26005)(5660300002)(81156014)(4326008)(6506007)(186003)(9686003)(478600001)(33656002)(52536014)(54906003)(55016002)(53546011)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IP1DWrOs1sOQ/SV0ylMggRJl8EFoRn3claRycGNxDYECaCDsCa07pU5pMRRmQphVUFyLdXEev4YCr7odtQG+jyJFHm+ijp8vYNNXr8SEDXG5K/Hw+49SvjxEWdpWH7SLscnqc5R8d5dYtuYg34XpgUHMXc4mXyljVfYw8clCA9owMpOHScFMyFW1jXGSK5sifat9MsCRylNvPe0SYxEuxn8YhHy4vzMxfsDgaH/dWJRHOIZoDYx14zsMfOzWC0SuD6/IABvVzltOS+fxTOBvHw71Tpfv0L8Ep1QUMagC5DOd3jmpdrY7neDBhwb7BQcZAE4IFdR/NthBiJardjCqEEjQre1kKrMSvOUK7bxe74Jb40oqNUQe55GG2Uo5k8uhE6JddhTW47rHsKcJQV4V5SuwTDptsOTuvNtSlDP9JUbttyJpfQgZO9mv4i43xT8IH3XHo5pjPwd+sFe+6/Jn2Eq9kN99Pkm9IxdjqiDR/aEM+DyKsrlZtZk8szMvioYh
x-ms-exchange-antispam-messagedata: vAnCz/S5jbIETDFmqD4jQIVWflEbRpz46lHRWNM33SSH/TuWLe39/QGZ9EorN+dQcCsVc+N9Jaaaei4aWuHUtNkex+F4qgrJ7yxqPjfVFXVCiejQivJR2rnyFr73mFj9+YGwoXuvQWY3GXtV1aq+ZQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30f8d7a-217c-47c8-894e-08d7d77fea5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 03:34:28.8401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQD/oo0W6t0lNTx5LMCUqCijbIqSqxBZPm8bnlu47QCUpl4shFXTB1UyO6J8kL/MEfyPseeI5NY8NpgNCkqviA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFtaXQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDMvM10gYXJtNjQ6IGR0czogaW14
OG1wOiBBZGQgdGhlcm1hbCB6b25lcyBzdXBwb3J0DQo+IA0KPiBPbiBNb24sIE1hciAyMywgMjAy
MCBhdCA2OjA1IFBNIEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiB3cm90ZToN
Cj4gPg0KPiA+IGkuTVg4TVAgaGFzIGEgVE1VIGluc2lkZSB3aGljaCBzdXBwb3J0cyB0d28gdGhl
cm1hbCB6b25lcywgYWRkIHN1cHBvcnQNCj4gPiBmb3IgdGhlbS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gDQo+IFtzbmlw
XQ0KPiANCj4gPg0KPiA+ICsgICAgICAgdGhlcm1hbC16b25lcyB7DQo+ID4gKyAgICAgICAgICAg
ICAgIGNwdS10aGVybWFsIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwb2xsaW5nLWRl
bGF5LXBhc3NpdmUgPSA8MjUwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwb2xsaW5n
LWRlbGF5ID0gPDIwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHRoZXJtYWwtc2Vu
c29ycyA9IDwmdG11IDB4MD47DQo+IA0KPiBObyBuZWVkIGZvciAweDAsIGp1c3QgdXNlIDANCg0K
T0suDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdHJpcHMgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1X2FsZXJ0MDogdHJpcDAgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZW1wZXJhdHVyZSA9IDw4NTAwMD47
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh5c3RlcmVzaXMg
PSA8MjAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR5
cGUgPSAicGFzc2l2ZSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0K
PiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV9jcml0MDogdHJp
cDEgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZW1wZXJh
dHVyZSA9IDw5NTAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHR5cGUgPSAiY3JpdGljYWwiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBjb29saW5nLW1hcHMgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbWFwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHRyaXAgPSA8JmNwdV9hbGVydDA+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb29saW5nLWRldmljZSA9DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZBNTNfMA0KPiBUSEVSTUFM
X05PX0xJTUlUIFRIRVJNQUxfTk9fTElNSVQ+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDwmQTUzXzENCj4gVEhFUk1BTF9OT19MSU1JVCBUSEVS
TUFMX05PX0xJTUlUPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA8JkE1M18yDQo+IFRIRVJNQUxfTk9fTElNSVQgVEhFUk1BTF9OT19MSU1JVD4s
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZB
NTNfMw0KPiBUSEVSTUFMX05PX0xJTUlUIFRIRVJNQUxfTk9fTElNSVQ+Ow0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9
Ow0KPiA+ICsgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgc29j
LXRoZXJtYWwgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBvbGxpbmctZGVsYXktcGFz
c2l2ZSA9IDwyNTA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBvbGxpbmctZGVsYXkg
PSA8MjAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdGhlcm1hbC1zZW5zb3JzID0g
PCZ0bXUgMHgxPjsNCj4gDQo+IE5vIG5lZWQgZm9yIDB4MSwganVzdCB1c2UgMQ0KDQpPSy4NCg0K
PiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB0cmlwcyB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzb2NfYWxlcnQwOiB0cmlwMCB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRlbXBlcmF0dXJlID0gPDg1MDAwPjsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHlzdGVyZXNpcyA9IDwyMDAw
PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHlwZSA9ICJw
YXNzaXZlIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc29jX2NyaXQwOiB0cmlwMSB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRlbXBlcmF0dXJlID0g
PDk1MDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHlz
dGVyZXNpcyA9IDwyMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdHlwZSA9ICJjcml0aWNhbCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB9Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH07DQo+IA0KPiBZb3UgbmVlZCBh
IGNvb2xpbmctbWFwIGhlcmUgc2luY2UgeW91IGhhdmUgYSBwYXNzaXZlIHRyaXAgcG9pbnQuDQoN
CkN1cnJlbnRseSwgdGhlcmUgaXMgbm8gY29vbGluZyBtYXAgZGVmaW5lZCBmb3Igc29jIHRoZXJt
YWwgem9uZSwgdGhlIGNwdWZyZXEgY29vbGluZw0KaXMgbWFwcGVkIHRvIGNwdSB0aGVybWFsIHpv
bmUgYWxyZWFkeSwgc28gZG8geW91IHRoaW5rIGl0IGlzIE9LIHRvIGxlYXZlIGl0IGFzIG5vIGNv
b2xpbmcNCm1hcCwgb3IgaXQgaXMgYmV0dGVyIHRvIHB1dCBjcHVmcmVxIGNvb2xpbmcgZm9yIHNv
YyB0aGVybWFsIHpvbmUgYXMgd2VsbD8NCg0KDQpUaGFua3MsDQpBbnNvbg0KDQo=

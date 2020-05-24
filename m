Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502151DFC25
	for <lists+linux-pm@lfdr.de>; Sun, 24 May 2020 02:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbgEXAuW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 May 2020 20:50:22 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6074
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388171AbgEXAuW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 23 May 2020 20:50:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggK61/lUqX0Z25uAIeWyl8VS852e1TdwrYANYBZs077x/vtgpRYECt8jkwJ4P1FvWDMOkvKZfsTZtTNSCCnSkXqCdU/5HsCwKznBnYCKEgX83c83vKcSbZvu//lAV9TTnifuOCuImwWN0Da6HhKVwpmf3vAA6y3odMLUR9/w8CVldT16lqh4+NsHD9VuH929Hh+63fA2ymepT+KOXOFSkcnE3VAImuvzKls2UoO0BlkMgtffCtoLpZh7J1X3yYF6d7VjHzhtcMHGr1BIMCkgL1qu92I1yxyxl8mF/5ybDwUkLAHUZh4YimK4hjZ8T/mJ+3O7wDcb3fHcIkr3veGhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPL44lVymTyWLhw9zXFHJU2EZePqi1ZW+3lUvlfGpW8=;
 b=BS7uibF0xu+yIT2awCsZzOwyg2j8uEH0QDMXIFXrPq2vhnagJ/7JvccDd1v0XUEa+3wO2+HxIFE0E0g3lyhK5pJiGt4o2UzSfY6Y0JJJiTvGOeUxQPNTlZry0OOZCjRAF4yJSipADx/DdhpEX7h66u0YhkZjdHpl0V8PjMXLce6sl8jexISzLA8ohSKuR6JCRi0EOGuZJ8U3NL++7EB3WAJw+KEUFpuFNTzM6DHawworPcEUjrqrvAbxnfmMBMLuVraYj+0CNarfNfzyKExNV8sxDwQL4WmrJxMVdL0QS2o/ZisO9MlFQB9NctWNt2evbX0SedsK1aTDxignOyMztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPL44lVymTyWLhw9zXFHJU2EZePqi1ZW+3lUvlfGpW8=;
 b=GUaE0KGVQWxGfCjOm0/PTX/ezKMNvN2KGRTb1x7t6pp+SB7n75z3jLFWanKXyHGk56B137WR37EI55QjhWUcKfHn7cCimjoDHGU1Y4K+al94BdnyLtuh3fvrJu+NNcE68SEpEHi+Eo+nzCa3ihYR6BHkEU5zcwOqQovDr2Vy55Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3835.eurprd04.prod.outlook.com (2603:10a6:8:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Sun, 24 May
 2020 00:50:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3021.027; Sun, 24 May 2020
 00:50:18 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: imx8mm: Add get_trend ops
Thread-Topic: [PATCH] thermal: imx8mm: Add get_trend ops
Thread-Index: AQHWKNOp8EPkl0qqRkG+GoQWiQOYA6i0bHgAgABvx3CAAM7gAIAAy+Lw
Date:   Sun, 24 May 2020 00:50:18 +0000
Message-ID: <DB3PR0402MB39167D71ED6979FC33D3747DF5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
 <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
 <DB3PR0402MB3916B6D11328A036BD479D39F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <6a4d31e4-8a24-2e9f-aa49-bec8258ead4c@linaro.org>
In-Reply-To: <6a4d31e4-8a24-2e9f-aa49-bec8258ead4c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7949d8a6-e582-459a-511d-08d7ff7c6e14
x-ms-traffictypediagnostic: DB3PR0402MB3835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38356832CC0F0B910FCEAA03F5B20@DB3PR0402MB3835.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0413C9F1ED
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sl89vu6/G9XVgjvW1Cq0FROUSCHAIbcr4wOBRkGx+zoxEifk5NpTkCL7TeItiNfqdaQkDu57tp7E7cTmEL7vTCoYh27QpP0KkuG1UW1snL57Gp+TCl+kFSwAElcRDBKPuK7tCXHi4R1FnZhYxjPTyxWD8rYn1nOTYPl3LMVlqdULXbZGgO3XoLmxUEUsMcXxvewIonuakMgffuOCB3dDAUFPyOrmmyJ6eSjovceQxBO682OKAmlbKa/EVnNKIyLq/cxeeRWF91XujsVsExQc0MudOJ5VXd5I4uwaJ25REmPwsbyBtHyb5fOURolLNXhSnAbPRL9AFZs+jwXmS1mA5ahC7hIyCR4IZiAUGvejjhh6w9DHOHZ6xfO4t2nzhEJz/mgTxx21pgHu0lOxIUxYBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(26005)(33656002)(186003)(71200400001)(64756008)(5660300002)(66946007)(76116006)(66446008)(66476007)(44832011)(66556008)(52536014)(478600001)(86362001)(8676002)(4326008)(2906002)(9686003)(7416002)(55016002)(110136005)(6506007)(8936002)(7696005)(53546011)(316002)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IoGjZ3w63PqJMbDZx5ygZu2IKqmKVzxg/bqbvTRta+vt73MLhURm86zO9wha1ekQOaoNa5VWuSCHfL3YRIsHX287gHVcYhgAJwIfPKf6RGVxTNqlYv/wr8gXmKsL54QDVXFLjfrj7Z2gIG0Bqa4K1geZuLEfRNqzlMtvN823kN7w4seWmnPDekzPV0tuQkqKqC2YFs3QrxdXcIeVDKorwd7t1Wn5QKLHuvyItEtzgPXyINXqkxETeB2vPg/SH6yhZ0Kn4hVjGLx2o7X8lX+4xHYZSO/CL6lqcX4z39H/fXW7RIRIqDgAK1c1xLG4zmMxeQjWvuQVCS1ULkDmeMxwkPnVSNDHwm/d6MP8lGShk7cJ0tlOFjJj2rOG5p5rwnKO5uZgIl5dUn/qjBL847EGpaZg6rRzM4I5Jbn/scYMa+w58lG6DjiAR3VGBXt53q2kODvYC3tD+kuejab3NuBL6o1c3avMd+KnB7iA1GULZ40=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7949d8a6-e582-459a-511d-08d7ff7c6e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2020 00:50:18.2498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFHgszfVlpGhWKJab4DhElTJVcD6W3HDGrieUZWGagjsp1gbHmAJqidw44hLh7EQWS+JNhwoH4kMUryLrcoIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3835
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRoZXJtYWw6IGlteDhtbTogQWRk
IGdldF90cmVuZCBvcHMNCj4gDQo+IE9uIDIzLzA1LzIwMjAgMDI6MzUsIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+IEhpLCBEYW5pZWwNCj4gPg0KPiA+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IHRoZXJtYWw6IGlteDhtbTogQWRkIGdldF90cmVuZCBvcHMNCj4gPj4NCj4gPj4gT24gMTMvMDUv
MjAyMCAwNDo1OCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4+PiBBZGQgZ2V0X3RyZW5kIG9wcyBm
b3IgaS5NWDhNTSB0aGVybWFsIHRvIGFwcGx5IGZhc3QgY29vbGluZw0KPiA+Pj4gbWVjaGFuaXNt
LCB3aGVuIHRlbXBlcmF0dXJlIGV4Y2VlZHMgcGFzc2l2ZSB0cmlwIHBvaW50LCB0aGUgaGlnaGVz
dA0KPiA+Pj4gY29vbGluZyBhY3Rpb24gd2lsbCBiZSBhcHBsaWVkLCBhbmQgd2hlbiB0ZW1wZXJh
dHVyZSBkcm9wcyB0byBsb3dlcg0KPiA+Pj4gdGhhbiB0aGUgbWFyZ2luIGJlbG93IHBhc3NpdmUg
dHJpcCBwb2ludCwgdGhlIGxvd2VzdCBjb29saW5nIGFjdGlvbg0KPiA+Pj4gd2lsbCBiZSBhcHBs
aWVkLg0KPiA+Pg0KPiA+PiBZb3UgYXJlIG5vdCBkZXNjcmliaW5nIHdoYXQgaXMgdGhlIGdvYWwg
b2YgdGhpcyBjaGFuZ2UuDQo+ID4NCj4gPiBUaGUgZ29hbCBvZiB0aGlzIGNoYW5nZSBpcyB0byBt
YWtlIHN1cmUgd2hlbmV2ZXIgdGVtcGVyYXR1cmUgZXhjZWVkcw0KPiA+IHBhc3NpdmUgdHJpcCBw
b2ludCwgdGhlIGhpZ2hlc3QgY29vbGluZyBhY3Rpb24gd2lsbCBiZSBhcHBsaWVkDQo+ID4gaW1t
ZWRpYXRlbHksIGUuZy4sIGlmIHRoZXJlIGFyZSBtYW55IGNwdWZyZXEgT1BQLCB0aGUgZGVmYXVs
dCBjb29saW5nDQo+ID4gd2lsbCBiZSBzdGVwIGJ5IHN0ZXAsIGl0IHdpbGwgdGFrZSBzb21lIG1v
cmUgcm91bmRzIHRvIG1ha2UgY3B1ZnJlcSBkcm9wIHRvDQo+IGxvd2VzdCBPUFAsIHdoaWxlIG9u
IGkuTVgsIHdlIGV4cGVjdCB0aGUgY3B1ZnJlcSBkcm9wIHRvIGxvd2VzdCBPUFANCj4gaW1tZWRp
YXRlbHkuDQo+IA0KPiBXaGF0ZXZlciB0aGUgc2xvcGUgb2YgdGhlIHRlbXBlcmF0dXJlIGluY3Jl
YXNlPw0KDQpZZXMuDQoNCj4gDQo+ID4+IElJVUMsIHRoZSByZXN1bHRpbmcgY2hhbmdlIHdpbGwg
YmUgYW4gb24vb2ZmIGFjdGlvbi4gVGhlIHRoZXJtYWwgem9uZQ0KPiA+PiBpcyBtaXRpZ2F0ZWQg
d2l0aCB0aGUgaGlnaGVzdCBjb29saW5nIGVmZmVjdCwgc28gdGhlIGxvd2VzdCBPUFAsIHRoZW4N
Cj4gPj4gdGhlIHRlbXBlcmF0dXJlIHRyZW5kIGlzIHN0YWJsZSB1bnRpbCBpdCBnb2VzIGJlbG93
IHRoZSB0cmlwIC0gbWFyZ2luDQo+ID4+IHdoZXJlIHRoZSBtaXRpZ2F0aW9uIGlzIHN0b3BwZWQu
DQo+ID4NCj4gPiBZZXMsIHlvdXIgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0bHksIG9uY2UgdGhl
IHRlbXBlcmF0dXJlIGV4Y2VlZHMNCj4gPiBwYXNzaXZlIHRyaXAgcG9pbnQsIHRoZSBoaWdoZXN0
IGNvb2xpbmcgYWN0aW9uIHdpbGwgYmUgYXBwbGllZA0KPiA+IGltbWVkaWF0ZWx5IGFuZCB0aGVu
IGl0IHdpbGwgYmUgc3RhYmxlIHRoZXJlIHVudGlsIHRlbXBlcmF0dXJlIGRyb3AgdG8NCj4gPiB0
cmlwIC0gbWFyZ2luLCB0aGVuIHRoZSBjb29saW5nIGFjdGlvbiB3aWxsIGJlIGNhbmNlbGxlZCwg
dGhlIG1hcmdpbiBpcyB0byBhdm9pZA0KPiB0aGUgYmFjayBhbmQgZm9ydGggbmVhciB0aGUgcGFz
c2l2ZSB0cmlwIHBvaW50Lg0KPiA+DQo+ID4+DQo+ID4+IEV4Y2VwdCwgSSdtIG1pc3Npbmcgc29t
ZXRoaW5nLCBzZXR0aW5nIGEgdHJpcCBwb2ludCB3aXRoIGEgMTAwMDANCj4gPj4gaHlzdGVyZXNp
cyBhbmQgYSBjb29saW5nIG1hcCBtaW4vbWF4IHNldCB0byB0aGUgaGlnaGVzdCBvcHAgd2lsbCBy
ZXN1bHQgb24NCj4gdGhlIHNhbWUuDQo+ID4NCj4gPiBZZXMgc2V0dGluZyBjb29saW5nIG1hcCBt
aW4vbWF4IGNvb2xpbmcgc3RhdGUgdG8gaGlnaGVzdCBPUFAgd2lsbCBtYWtlDQo+ID4gdGhlIGhp
Z2hlc3QgY29vbGluZyBhY3Rpb24gYXBwbGllZCBpbW1lZGlhdGVseSwgYW5kIHRvIGhhdmUgdGhl
DQo+ID4gZnVuY3Rpb24gb2YgY29vbGluZyBhY3Rpb24gYmVpbmcgY2FuY2VsbGVkIHdoZW4gdGVt
cGVyYXR1cmUgZHJvcHMgdG8NCj4gPiB0cmlwIC0gbWFyZ2luLCBJIGhhdmUgdG8gZGVmaW5lIGFu
b3RoZXIgdHJpcCBwb2ludCwgc2F5IHBhc3NpdmUgdHJpcA0KPiA+IHBvaW50IGlzIDg1MDAwLCBh
bmQgY29vbGluZyBtYXAgbWluL21heCBzZXQgdG8gaGlnaGVzdCBPUFAgaW4gcGFzc2l2ZQ0KPiA+
IHRyaXAgcG9pbnQgdGhlbiBhZGQgYW5vdGhlciB0cmlwIHBvaW50IG5hbWVkICJhY3RpdmUiIHdp
dGggNzUwMDAsIGFuZA0KPiB3aXRob3V0IGFueSBjb29saW5nIG1hcCBpbiBpdCwgcmlnaHQ/DQo+
IA0KPiBNYXkgYmUgSSBtaXN1bmRlcnN0b29kIGJ1dCBvbmx5IHRoZSBjaGFuZ2UgYXMgYmVsb3cg
aXMgbmVlZGVkLiBObyBuZWVkIHRvDQo+IGFkZCBhIHRyaXAgcG9pbnQsIGVzcGVjaWFsbHkgYW4g
J2FjdGl2ZScgdHJpcCB3aGljaCBpcyBhIGZvciBhbiBhY3RpdmUgY29vbGluZw0KPiBkZXZpY2Ug
bGlrZSBhIGZhbi4NCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0uZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS5kdHNpDQo+IGluZGV4IGNjNzE1MmVjZWRkOS4uYmVhMjYzYmQwNmI0IDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiBAQCAtMjMxLDEwICsyMzEs
MTAgQEAgY29vbGluZy1tYXBzIHsNCj4gIAkJCQltYXAwIHsNCj4gIAkJCQkJdHJpcCA9IDwmY3B1
X2FsZXJ0MD47DQo+ICAJCQkJCWNvb2xpbmctZGV2aWNlID0NCj4gLQkJCQkJCTwmQTUzXzAgVEhF
Uk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPiwNCj4gLQkJCQkJCTwmQTUzXzEgVEhF
Uk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPiwNCj4gLQkJCQkJCTwmQTUzXzIgVEhF
Uk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPiwNCj4gLQkJCQkJCTwmQTUzXzMgVEhF
Uk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPjsNCj4gKwkJCQkJCTwmQTUzXzAgMiAy
PiwNCj4gKwkJCQkJCTwmQTUzXzEgMiAyPiwNCj4gKwkJCQkJCTwmQTUzXzIgMiAyPiwNCj4gKwkJ
CQkJCTwmQTUzXzMgMiAyPg0KPiAgCQkJCX07DQo+ICAJCQl9Ow0KPiAgCQl9Ow0KPiANCj4gDQoN
ClRoYW5rcywgSSB3aWxsIGhhdmUgYSB0cnkgdG8gc2VlIGlmIGl0IG1lZXRzIG91ciBleHBlY3Rh
dGlvbi4NCg0KQW5zb24NCg==

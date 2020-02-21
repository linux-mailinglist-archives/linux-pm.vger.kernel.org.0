Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7537168A8E
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 00:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgBUXx3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 18:53:29 -0500
Received: from mail-db8eur05on2055.outbound.protection.outlook.com ([40.107.20.55]:6183
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgBUXx2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 18:53:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2aNyrYwnNgofjzPqxplC51T5aK7UwHb3Dp3XnrGiVxlgTYTdjGBki/vRFLMJsm01a8bEifEtHpg6vYfMmzYKTA7Kouu3oQ6L++nNQzIZe3X3HBcStaFG0xFIXY6oqjl8bJd4CwORbR4KoUZMz1+t+jKu50A8GOPe+h4Na7D7ePkvDaYbyCuiG+naQpugL07alWYCatt5i9yvubLf/xQT2AFiuMmsVJeYW/Sajs/8HHSIc8RZPPz5Rc75iOx8dg/NRL/oUD1OyWEPi8j+41axdNH4vcYWitAHFo2MxlQ4fAoqW2iA/ULoyKeiZLpQrauNTIwOR3EINcDtdq1yt1XfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6cQsBBJljDolCCRLbx41PwFwNJAtfHfFuDFkgQ+vxs=;
 b=CWneKa7Xc0xaM8c6U4+vNJDii/eYgu5mUgnaHx1s7F+PXpqV22gMUskwDBSNIa1A6rm4xzTpUwdOGDtvbIBsFMAfUEjamhIv0fCfOuntxotCC9VD9+RbTbWLz/yJ0BjWEOLuyjWmblMc7GPY4WYbBJyZdIbEmOdO6mujQa0efgYGfztHjI8DZJCtTZWWAzsnO6nE7dNLNLWOtfgVdnkh/8oVcKB4zJ/BlI6cHQIKHPOTB+Zwh088KgXb7nRZ6kOGi7HOXRnbyRLftb8VzrZ2N+l75aVoJmGCqbmOsty9H6SbrwamMOzgZ14bKnTRCn/HHYFJjXlJlE92FxjyWsLTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6cQsBBJljDolCCRLbx41PwFwNJAtfHfFuDFkgQ+vxs=;
 b=pL+an/dUhXxxwG1eJvuHFHh9/R8hvXaGenG0CX93F7EG2pDABLINzAFCfOsQEi4Cm9hlL8O8YFMxbqktbZmrJ6pELunRmojzjZvQ/8p4muj9JwxQ8hkHQ/vntuTwMecDpsDtnZZOcdTrK+y/2NKqFtAq0G3/Ex6MJPP3oCNNxOU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Fri, 21 Feb 2020 23:53:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 23:53:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V15 RESEND 5/5] arm64: dts: imx: add i.MX8QXP thermal
 support
Thread-Topic: [PATCH V15 RESEND 5/5] arm64: dts: imx: add i.MX8QXP thermal
 support
Thread-Index: AQHV54t0EBaEeunlYUezwg4Plo/Olqgln+YAgACz3LA=
Date:   Fri, 21 Feb 2020 23:53:23 +0000
Message-ID: <DB3PR0402MB39163B3EC2B6077C51D821DEF5120@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-5-git-send-email-Anson.Huang@nxp.com>
 <20200221130448.GC10516@linaro.org>
In-Reply-To: <20200221130448.GC10516@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [220.161.57.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae729a50-d692-4997-0bd7-08d7b7293ce9
x-ms-traffictypediagnostic: DB3PR0402MB3641:|DB3PR0402MB3641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3641FF7D5FF56A5D35401157F5120@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(199004)(189003)(7416002)(6506007)(71200400001)(81156014)(86362001)(26005)(2906002)(186003)(316002)(7696005)(5660300002)(33656002)(54906003)(52536014)(76116006)(478600001)(6916009)(66476007)(66446008)(66556008)(64756008)(66946007)(8936002)(9686003)(8676002)(81166006)(4326008)(44832011)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6JZaZGiFEHqO9xJtYo8D5HqJ8Jen58AfvDl8BOLPWa1JGD0grwExQy4gIN+0xkvs4+n78lX1KWYhXwmPdeOiVt51ZC9GvpLAdoHMWZ74pyVtOerx+BBO573JTLAvCG1jwsICRIQIAdzhZQJLLNSHcYoMUBS4rZv6/QHuPDI/kdrjg7oNNW6a53PSmNDLJvheEmrXKW3YXJYqkwhOLLBiA+dPVL/18ha9ISk9gpVxymZXjZ4nGFJZHU3YCVBQkWuFVUUXZhcQxJPRKfMVxsf2+nH8czAvvY4v9rS9N2GXP2uq34uLUxqO9rkqFXS3lFioyF9CHfzFrFVFlN1XMIWEZqX7WMTe81SkzjNSUOUtZ7xkwJzOnivUGDG7wfagXhhMF9nEOqj0S5NeqEEMOccDZLBO7EAbTsPyML8xiWFKZQlv06MHejxthSa/eVHGlfwJ4hHyno1Qz9Tl22GpWxieUg/UjIVEK0bgjGg/cCRI5u+c5VdQpQ8X0ND5tskak9k8e1AcCdFmC2I4yMvi7O1Qp9qcM1xrpcA4+7cV1QR53ijYzUpTqRx4tpbuTL6J9fXWUcQJXt4rqb+PlGlCQXSAW4JMbHFIXymVAQi6K5lnU2Dn6U+gbDtONLSN+0DmBRjR
x-ms-exchange-antispam-messagedata: xSFWvxSU4QyiDrEhrVVIhrgO3w+BH2+aUKzmHZpcHx7HKkEXazQKzzryt/K9h0blQ+l+KfIJPHvW5U76N30gwHv1JIDG6EckcoWxF2T4uh4bQexvPO2jYH89OpI/HQfKyMXzl4rcPNo11VlCsMx4iw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae729a50-d692-4997-0bd7-08d7b7293ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 23:53:23.7004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nh32aJQU5QN1gmCHXIUdxf7KychL41Yt276LLAbSMegHs1x8qpBWFKMPNFxOcONhw8+x2hyUnzMYA7l/ANsYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjE1IFJFU0VORCA1LzVdIGFybTY0
OiBkdHM6IGlteDogYWRkIGkuTVg4UVhQIHRoZXJtYWwNCj4gc3VwcG9ydA0KPiANCj4gT24gVGh1
LCBGZWIgMjAsIDIwMjAgYXQgMDk6MTA6MjhBTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+
ID4gQWRkIGkuTVg4UVhQIENQVSB0aGVybWFsIHpvbmUgc3VwcG9ydC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+
IE5vIGNoYW5nZS4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OHF4cC5kdHNpIHwgMzYNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gPiBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+IGluZGV4IGZiNWY3NTIu
LjBhMTRmZTQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OHF4cC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OHF4cC5kdHNpDQo+ID4gQEAgLTExLDYgKzExLDcgQEANCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL2lucHV0L2lucHV0Lmg+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQt
Y29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9waW5jdHJs
L3BhZHMtaW14OHF4cC5oPg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvdGhlcm1hbC90aGVy
bWFsLmg+DQo+ID4NCj4gPiAgLyB7DQo+ID4gIAlpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0K
PiA+IEBAIC0xODksNiArMTkwLDExIEBADQo+ID4gIAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhx
eHAtc2Mtd2R0IiwgImZzbCxpbXgtc2Mtd2R0IjsNCj4gPiAgCQkJdGltZW91dC1zZWMgPSA8NjA+
Ow0KPiA+ICAJCX07DQo+ID4gKw0KPiA+ICsJCXRzZW5zOiB0aGVybWFsLXNlbnNvciB7DQo+ID4g
KwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2MtdGhlcm1hbCIsICJmc2wsaW14LXNjLQ0K
PiB0aGVybWFsIjsNCj4gPiArCQkJI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+Ow0KPiA+ICsJ
CX07DQo+ID4gIAl9Ow0KPiA+DQo+ID4gIAl0aW1lciB7DQo+ID4gQEAgLTU4Niw0ICs1OTIsMzQg
QEANCj4gPiAgCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+ICAJCX07DQo+ID4gIAl9Ow0KPiA+
ICsNCj4gPiArCXRoZXJtYWxfem9uZXM6IHRoZXJtYWwtem9uZXMgew0KPiA+ICsJCWNwdS10aGVy
bWFsMCB7DQo+ID4gKwkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwyNTA+Ow0KPiA+ICsJCQlw
b2xsaW5nLWRlbGF5ID0gPDIwMDA+Ow0KPiA+ICsJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5z
IElNWF9TQ19SX1NZU1RFTT47DQo+ID4gKwkJCXRyaXBzIHsNCj4gPiArCQkJCWNwdV9hbGVydDA6
IHRyaXAwIHsNCj4gPiArCQkJCQl0ZW1wZXJhdHVyZSA9IDwxMDcwMDA+Ow0KPiA+ICsJCQkJCWh5
c3RlcmVzaXMgPSA8MjAwMD47DQo+ID4gKwkJCQkJdHlwZSA9ICJwYXNzaXZlIjsNCj4gPiArCQkJ
CX07DQo+IA0KPiBNYXkgYmUgeW91IGNhbiBhZGQgYSAnaG90JyB0cmlwIHBvaW50IGJlZm9yZSAn
Y3JpdGljYWwnIGZvciBmdXR1cmUgdXNlIGJlZm9yZQ0KPiByZWFjaGluZyB0aGUgZW1lcmdlbmN5
IHNodXRkb3duLg0KDQpUaGUgJ3Bhc3NpdmUnIHRyaXAgaXMgYWN0dWFsbHkgdGhlICdob3QnIHRy
aXAgcG9pbnQgeW91IG1lbnRpb25lZCwgYW5kIEkgaGF2ZSBjb21iaW5lZCBpdCB0bw0KYmVsb3cg
Y29vbGluZyBtYXAgd2hpY2ggd2lsbCB0aHJvdHRsZSBjcHUtZnJlcSB3aGVuIHBhc3NpdmUgKGhv
dCkgcG9pbnQgaXMgcmVhY2hlZC4NCldlIGFsbCB1c2UgJ3Bhc3NpdmUnIGFzICdob3QnIGFsYXJt
IGFuZCB0cmlnZ2VyIGNwdS1mcmVxIHRocm90dGxlIG9uIGkuTVggcGxhdGZvcm1zLiANCg0KVGhh
bmtzLA0KQW5zb24NCg0KPiANCj4gPiArCQkJCWNwdV9jcml0MDogdHJpcDEgew0KPiA+ICsJCQkJ
CXRlbXBlcmF0dXJlID0gPDEyNzAwMD47DQo+ID4gKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsN
Cj4gPiArCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCj4gPiArCQkJCX07DQo+ID4gKwkJCX07DQo+
ID4gKwkJCWNvb2xpbmctbWFwcyB7DQo+ID4gKwkJCQltYXAwIHsNCj4gPiArCQkJCQl0cmlwID0g
PCZjcHVfYWxlcnQwPjsNCj4gPiArCQkJCQljb29saW5nLWRldmljZSA9DQo+ID4gKwkJCQkJCTwm
QTM1XzANCj4gVEhFUk1BTF9OT19MSU1JVCBUSEVSTUFMX05PX0xJTUlUPiwNCj4gPiArCQkJCQkJ
PCZBMzVfMQ0KPiBUSEVSTUFMX05PX0xJTUlUIFRIRVJNQUxfTk9fTElNSVQ+LA0KPiA+ICsJCQkJ
CQk8JkEzNV8yDQo+IFRIRVJNQUxfTk9fTElNSVQgVEhFUk1BTF9OT19MSU1JVD4sDQo+ID4gKwkJ
CQkJCTwmQTM1XzMNCj4gVEhFUk1BTF9OT19MSU1JVCBUSEVSTUFMX05PX0xJTUlUPjsNCj4gPiAr
CQkJCX07DQo+ID4gKwkJCX07DQo+ID4gKwkJfTsNCj4gPiArCX07DQo+ID4gIH07DQo+ID4gLS0N
Cj4gPiAyLjcuNA0KPiA+DQo+IA0KPiAtLQ0KPiANCj4gDQo+IDxodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gbGlu
YXJvLm9yZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDQW5zb24uSHVhbmclNDBueHAuY29tJTdDZDZj
MGQNCj4gMGNlNTdhMTQ5ODVhMzkwMDhkN2I2Y2VhNGZmJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUlNw0KPiBDMCU3QzAlN0M2MzcxNzg4NzA5NTE5Nzc3NTEmYW1wO3NkYXRhPWE3
Qlhlb0dLUHNZbFhteTBzQ21BNklNDQo+IFNiZXhkaVh3WkVYQWU4byUyQkkzajAlM0QmYW1wO3Jl
c2VydmVkPTA+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlDQo+IHNvZnR3YXJlIGZvciBBUk0g
U29Dcw0KPiANCj4gRm9sbG93IExpbmFybzoNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBmYWNlYm9vay5j
b20lMkZwYWdlcyUyRkxpbmFybyZhbXA7ZGF0YT0wMiU3QzAxJTdDQW5zb24uSHVhbmclNA0KPiAw
bnhwLmNvbSU3Q2Q2YzBkMGNlNTdhMTQ5ODVhMzkwMDhkN2I2Y2VhNGZmJTdDNjg2ZWExZDNiYzJi
NGM2ZmE5DQo+IDJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcxNzg4NzA5NTE5Nzc3NTEmYW1w
O3NkYXRhPU1WcGlFRCUNCj4gMkJscDRoJTJGVjRFUXNNUyUyRldUNFF2TEpZak9aJTJGSXB1Z2VP
NDAxVmMlM0QmYW1wO3Jlc2VydmVkPQ0KPiAwPiBGYWNlYm9vayB8DQo+IDxodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnR3aXR0
ZQ0KPiByLmNvbSUyRiUyMyElMkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q0Fuc29uLkh1
YW5nJTQwbnhwLmMNCj4gb20lN0NkNmMwZDBjZTU3YTE0OTg1YTM5MDA4ZDdiNmNlYTRmZiU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MTc4ODcwOTUx
OTc3NzUxJmFtcDtzZGF0YT04c0xlU0xwb085VHRJc2YNCj4gakc4aGNvNWElMkZKdjVoJTJCYkRq
TTRZQjQzdXklMkZGMCUzRCZhbXA7cmVzZXJ2ZWQ9MD4gVHdpdHRlciB8DQo+IDxodHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3
dy4NCj4gbGluYXJvLm9yZyUyRmxpbmFyby0NCj4gYmxvZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdD
QW5zb24uSHVhbmclNDBueHAuY29tJTdDZDZjMGQwY2U1Nw0KPiBhMTQ5ODVhMzkwMDhkN2I2Y2Vh
NGZmJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDDQo+IDAlN0M2Mzcx
Nzg4NzA5NTE5Nzc3NTEmYW1wO3NkYXRhPVhMNThmcEtMQ0ZxT2xRV3BpN21pZG9JdEpKc0JhbWlq
DQo+IFhGeUEycVQlMkJ3ak0lM0QmYW1wO3Jlc2VydmVkPTA+IEJsb2cNCg==

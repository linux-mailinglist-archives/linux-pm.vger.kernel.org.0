Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5F1646CD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBSOWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 09:22:07 -0500
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:11008
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbgBSOWH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Feb 2020 09:22:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzVF/4AVgqk0Y40GpWdjMysmiD9mdhqIMiTjiUkWulBEctMB/l0FyMFJ1+bpRTzSxkgWIaJPJ22WyKnJVU9AKsucai3rVwFu5m3l9U3wvRJXcQLU7C9h8NvmsTyXp0kKCgbyisBUTleVSXkcHbKBwIbRo4BZchUKuB9Chw+IulmeyeHWsb42tda3nXh4Zf4LPSEXgQQiTHrwto7fdUub5YbR2WU5/af2NiS4ONIh0WupL/U8hKGffd3BqGssiDrt/1kT8/Tqqo5ceJQ5a2Lhi0aZyM4QA+f2Lec/q54qKJD215FBkBX8EVTvl+uTIQQCc+O+cIWgyxWnA9a74tmjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6E5kY/cRRiZ/WJseSy4RncNHQ5YNkzbZBWQQsEBfdY=;
 b=W4jKQmuGiFxg7gwYbBFCn9UZHG2nKxRePEGohe0QbGkxPiG8vY4TTF4JJlBIp+MZ99XgC9hBaW2lsowYLmWp4zbtwmG6v8Fn6sYbVNVyUxTLpi5ywWXGMU7+a5P8r0RgfWxDgxF2Fke1QH8GrtrGwuVIpYmBYNNSmzOozB4MldeTHOvSsV4iaiznGkwVRG/ne+TvVws2GooaMWZIwPTs+fSc8+cuUVrQ/i/jJmNfzfYedOU2VIwi3lc0zJPb7adSwdmYpCKrvfyRuGT/UhQxfQLzIKidNjl9F3W4kL62bBYVNwAmC4EiJyLjFtJoeqyZMK7mWtsQWnA6SkEd4AJeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6E5kY/cRRiZ/WJseSy4RncNHQ5YNkzbZBWQQsEBfdY=;
 b=mEu2UlJ2H2m8rUljJxY8q5MtLFY5uSN565o1aAwW1x1hTqrJ/8b1pSSK1HMq6bX4uDGfPHEwXIasswGchZ60NXkAGVDwzCkW8o5Rp8gbJ6x4iIh7KkXmRbjEECMAyzCSOJTTsWVPd/nBItFEiCrYU3cXeM3o2yrV7a9Z6neR7MI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3689.eurprd04.prod.outlook.com (52.134.69.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 14:21:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 14:21:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "'robh+dt@kernel.org'" <robh+dt@kernel.org>,
        "'mark.rutland@arm.com'" <mark.rutland@arm.com>,
        "'corbet@lwn.net'" <corbet@lwn.net>,
        "'shawnguo@kernel.org'" <shawnguo@kernel.org>,
        "'s.hauer@pengutronix.de'" <s.hauer@pengutronix.de>,
        "'kernel@pengutronix.de'" <kernel@pengutronix.de>,
        "'festevam@gmail.com'" <festevam@gmail.com>,
        "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'rui.zhang@intel.com'" <rui.zhang@intel.com>,
        "'edubezval@gmail.com'" <edubezval@gmail.com>,
        "'daniel.lezcano@linaro.org'" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "'ulf.hansson@linaro.org'" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "'mchehab+samsung@kernel.org'" <mchehab+samsung@kernel.org>,
        "'linux@roeck-us.net'" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "'maxime.ripard@bootlin.com'" <maxime.ripard@bootlin.com>,
        "'horms+renesas@verge.net.au'" <horms+renesas@verge.net.au>,
        "'olof@lixom.net'" <olof@lixom.net>,
        "'jagan@amarulasolutions.com'" <jagan@amarulasolutions.com>,
        "'bjorn.andersson@linaro.org'" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "'dinguyen@kernel.org'" <dinguyen@kernel.org>,
        "'enric.balletbo@collabora.com'" <enric.balletbo@collabora.com>,
        "'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-pm@vger.kernel.org'" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHVJXvnLQPj9qjL2U2LZTWuyBDONqaqeq9ggC7WvJCAjvj14IC7yhIw
Date:   Wed, 19 Feb 2020 14:21:50 +0000
Message-ID: <DB3PR0402MB391606A52B41299F63FC4837F5100@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190618021820.14885-1-Anson.Huang@nxp.com>
 <DB3PR0402MB39162C5B5AF828B127DD871EF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39162EB555CD7AE75D58C582F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391666ED47460B81E1C3FEC7F56B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391666ED47460B81E1C3FEC7F56B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [220.161.57.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cae4e7eb-6c4c-42f2-666c-08d7b5470fd3
x-ms-traffictypediagnostic: DB3PR0402MB3689:|DB3PR0402MB3689:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3689D139616B3714A1DD8F1BF5100@DB3PR0402MB3689.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(6506007)(66446008)(4326008)(86362001)(5660300002)(110136005)(76116006)(66476007)(2906002)(66556008)(64756008)(66946007)(316002)(478600001)(33656002)(186003)(71200400001)(81156014)(7416002)(8676002)(81166006)(7696005)(8936002)(52536014)(26005)(55016002)(9686003)(44832011)(921003)(491001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3689;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HujuYedAYwg7pVrtdr8r8ZwVrJDGbbnFPd7iCbgnoD+kDKLoQKjPRZ4yUFh/2ZJ5g0Di4xjPujFjDHWMOatXsJ+cRP3rIMsSY6Wivhav37tikgulc/wO7q5ZT8QHccyBJVtU7nrvDLVC4dUuWwBaoMeJ9CNE+vllGiz0SVD8dQV+F8ren+rk75WeW+25OaxgMhHGUIIiXH8KUEsOL5Z0n3bD8/0F2UygBLLObOAcs3gOiyBZYN4M5jqwV5Sk/crk4ko+3shTC3lOSF5n0i/pANrDmV+pd3rMiG0GDHTXTGgOLY+QtUP+xCSIp7ZgB70/+eSH/itOvi2Gr5Zq/nuFVZmGLzYzPhBXS1FQQ1evlWj/dC7pmz/jUrBg/YdtaCwttcQX8JOFBtjnFLewSrNUfXkY5CY3tkjn9vty1/EhgVZ0WFFBrIu13rHhxTYmYhJvne3vfG/kR5mRrww5ldfjVJzgQqk4edpzN1vUtaDGqOI8y5V3C1Tiy5L0bY0UxbL/qIOQtkPVTp9kpgHIO6YZ5A==
x-ms-exchange-antispam-messagedata: 0DpsVhyx/yty0KF8X2I0IlO0FQSa8DWGI1hHU07s3OrAxbQqpHXzFbVZC9VNwhMmBTiOd3Pcmwz/0+GSavG/G/J9N/pN/P5ydhe7N2wgML5lI8YNh5Bx/2wJQ9VkAQWOKuwbio0K2arhrY6AJvYjIQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae4e7eb-6c4c-42f2-666c-08d7b5470fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 14:21:50.6284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FWmTGSYB23IPSzMpJldARKq+3R0q2E1XlFRRGkl/OddgR1LFUZzif4tgPl/zuUgS6Vhz00/UPQkIJjtbTW3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3689
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UGluZy4uLi4NCkl0IGhhcyBiZWVuIG1vcmUgdGhhbiBoYWxmIHllYXIsIGlzIHRoZXJlIGFueW9u
ZSBjYW4gaGVscCBvbiB0aGVybWFsIHN1Yi1zeXN0ZW0/IA0KDQpBbnNvbg0KDQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0ggVjE1IDEvNV0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQgdGhlcm1hbCBi
aW5kaW5nDQo+IA0KPiBQaW5nIGFnYWluLCBpdCBoYXMgYmVlbiAzIG1vbnRocyBwYXNzZWQuDQo+
IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjE1IDEvNV0gZHQtYmluZGluZ3M6IGZzbDogc2N1
OiBhZGQgdGhlcm1hbA0KPiA+IGJpbmRpbmcNCj4gPg0KPiA+IFBpbmcuLi4NCj4gPg0KPiA+ID4g
SGksIERhbmllbC9SdWkvRWR1YXJkbw0KPiA+ID4gCUNvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxv
b2sgYXQgdGhpcyBwYXRjaCBzZXJpZXM/DQo+ID4gPg0KPiA+ID4gQW5zb24NCj4gPiA+DQo+ID4g
PiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gPg0KPiA+
ID4gPiBOWFAgaS5NWDhRWFAgaXMgYW4gQVJNdjggU29DIHdpdGggYSBDb3J0ZXgtTTQgY29yZSBp
bnNpZGUgYXMNCj4gPiA+ID4gc3lzdGVtIGNvbnRyb2xsZXIsIHRoZSBzeXN0ZW0gY29udHJvbGxl
ciBpcyBpbiBjaGFyZ2Ugb2Ygc3lzdGVtDQo+ID4gPiA+IHBvd2VyLCBjbG9jayBhbmQgdGhlcm1h
bCBzZW5zb3JzIGV0Yy4gbWFuYWdlbWVudCwgTGludXgga2VybmVsIGhhcw0KPiA+ID4gPiB0byBj
b21tdW5pY2F0ZSB3aXRoIHN5c3RlbSBjb250cm9sbGVyIHZpYSBNVSAobWVzc2FnZSB1bml0KSBJ
UEMgdG8NCj4gPiA+ID4gZ2V0IHRlbXBlcmF0dXJlIGZyb20gdGhlcm1hbCBzZW5zb3JzLCB0aGlz
IHBhdGNoIGFkZHMgYmluZGluZyBkb2MNCj4gPiA+ID4gZm9yIGkuTVggc3lzdGVtIGNvbnRyb2xs
ZXIgdGhlcm1hbCBkcml2ZXIuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVu
ZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBObyBjaGFuZ2Uu
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVz
Y2FsZS9mc2wsc2N1LnR4dCAgICAgICAgfCAxNg0KPiA+ID4gKysrKysrKysrKysrKysrKw0KPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4g
ZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiA+ID4gaW5kZXggYTU3
NWU0Mi4uZmMzODQ0ZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiA+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQN
Cj4gPiA+ID4gQEAgLTE1NSw2ICsxNTUsMTcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiA+
ID4gIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAtIHRpbWVvdXQtc2VjOiBjb250YWlu
cyB0aGUgd2F0Y2hkb2cgdGltZW91dCBpbiBzZWNvbmRzLg0KPiA+ID4gPg0KPiA+ID4gPiArVGhl
cm1hbCBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KPiA+ID4gPiArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gPiA+ICstIGNv
bXBhdGlibGU6CQkJU2hvdWxkIGJlIDoNCj4gPiA+ID4gKwkJCQkgICJmc2wsaW14OHF4cC1zYy10
aGVybWFsIg0KPiA+ID4gPiArCQkJCWZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXRoZXJtYWwiOw0K
PiA+ID4gPiArDQo+ID4gPiA+ICstICN0aGVybWFsLXNlbnNvci1jZWxsczoJU2VlDQo+ID4gPiA+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3RoZXJtYWwudHh0DQo+
ID4gPiA+ICsJCQkJZm9yIGEgZGVzY3JpcHRpb24uDQo+ID4gPiA+ICsNCj4gPiA+ID4gIEV4YW1w
bGUgKGlteDhxeHApOg0KPiA+ID4gPiAgLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiAgYWxpYXNlcyB7
DQo+ID4gPiA+IEBAIC0yMjIsNiArMjMzLDExIEBAIGZpcm13YXJlIHsNCj4gPiA+ID4gIAkJCWNv
bXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2Mtd2R0IiwgImZzbCxpbXgtc2Mtd2R0IjsNCj4gPiA+
ID4gIAkJCXRpbWVvdXQtc2VjID0gPDYwPjsNCj4gPiA+ID4gIAkJfTsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArCQl0c2VuczogdGhlcm1hbC1zZW5zb3Igew0KPiA+ID4gPiArCQkJY29tcGF0aWJsZSA9
ICJmc2wsaW14OHF4cC1zYy10aGVybWFsIiwgImZzbCxpbXgtc2MtDQo+ID4gPiA+IHRoZXJtYWwi
Ow0KPiA+ID4gPiArCQkJI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+Ow0KPiA+ID4gPiArCQl9
Ow0KPiA+ID4gPiAgCX07DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+ID4g
PiAyLjcuNA0KDQo=

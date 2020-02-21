Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE11E168A7F
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 00:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgBUXqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 18:46:40 -0500
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:3442
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgBUXqk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 18:46:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtw1vM7P4bVcL1+ocSqrQU+aZOyHvqb4pOH/MG+oRHmVoJR8e405buCbab79w0+Vu4bYXu2lD63nQ7LfNsTbf9IoF6quWJhMpdrdfluhMMdW9Z75vZCx6If5EgZsYIG6vj7+/Nl3Gzg1J3EF2JCV+GnNmb76Mv+LJRhYco3Vs94D350eEVkkQZnKNeCgZgkZEW5yd5CHQqDjPvOIgGQgQ7YkTjOliTLIY6zbsppuC9qDrluQK0DQORWcXzp+fIb/BxLHIzChs9HeFu9PIXTr6Ku3O33Ugbqalpt3Jn9fkS5fRhMt15gBh3OpgKptOmnUoevF9sBIy8k2bSiYN+mHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+vvelfwz0CGcyGAtSPXxxUetT7NThqfu6xyftU5Nnw=;
 b=XYPWQqV3YadxuPBRZUlBPTFr5O6+609S6BGdUIDUv5jUlDA3lKXVsb/4b5fcQ+pfPJtkBOm7Sm+ahKaWEgTbpholY0lh+oR1tmqHTfaE/OYlwSq0KA1PQA8rSs682TTPRXy8HydZfosWEhanS8g62pl8+PhzbnCIat48bCeap2ovnCFS+p4SVqFQaQgVn3CkHLT8bIHN755tn96L17vduVZc2nE0l/CEcxfI+fa+n5ZjM0VDSdFxK0+UTTy9v7x6qk52uqG9AiwAWLmj7g82VLIDjejYzOt3KKmmUkl2IEUnz2b36whAh1HWVJNw00aHx0vzZ1i9aTjtfu35E6LcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+vvelfwz0CGcyGAtSPXxxUetT7NThqfu6xyftU5Nnw=;
 b=S0UxRfDyk4D2Zhjzq8sGfDskw2s3oHLNcz0aia9sH7WaAp5yiIU0aloPx6OUMGu949msz47sK7tTq22QpAosXPjnM4kZxZnA3Fm0C9lZRsWdw2udYXboLKO1RcBDoad1rSUi272f5idQ4LnohJDukUXNWyxCfxqVxP/MajAaAUw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Fri, 21 Feb 2020 23:46:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 23:46:34 +0000
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
Subject: RE: [PATCH V15 RESEND 3/5] thermal: imx_sc: add i.MX system
 controller thermal support
Thread-Topic: [PATCH V15 RESEND 3/5] thermal: imx_sc: add i.MX system
 controller thermal support
Thread-Index: AQHV54tyrEs41afDFEamskokSU5+h6glnJoAgAC0k8A=
Date:   Fri, 21 Feb 2020 23:46:34 +0000
Message-ID: <DB3PR0402MB3916CCBD8F36161B6F9EA45FF5120@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-3-git-send-email-Anson.Huang@nxp.com>
 <20200221125300.GB10516@linaro.org>
In-Reply-To: <20200221125300.GB10516@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [220.161.57.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4324fba-c3e2-4002-7cf7-08d7b72848e2
x-ms-traffictypediagnostic: DB3PR0402MB3641:|DB3PR0402MB3641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3641FAF1508534056E6D9170F5120@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(52536014)(76116006)(478600001)(6916009)(66476007)(66946007)(66446008)(66556008)(64756008)(5660300002)(54906003)(33656002)(44832011)(55016002)(8676002)(81166006)(4326008)(8936002)(9686003)(86362001)(6506007)(7416002)(81156014)(71200400001)(2906002)(316002)(7696005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3bUT51mdtVrg268trkXp4iN8CWeQNXzS9TDy8FVF0tN8PU5/gKRECOPrLMPWNbvrElCtX2YVwhqw0SyEuznA8fdi6vpNnPfkZ2uTGKZvMPzfIlpIcfIjATevyBSergamXtGuwCNydZPshAJM6NdaDo6S/7se5sNPParGV1zo5q/aiOUFPt7HbICgMc3+sMoIbPPBDE+odj2MEgWC18UtzWLIIGAV1AvnridoY5XqRWLrov0evcRZed+oEpNhPWqHjXlRL3AcXx3rZaVadJSpxHU+JGRy/aigw2Y0mkA2yyChz5iyBsY33UV+O+afx66DeWGb1VWRLwBSuEJNJNluBLjCAIUJdx/wIG7t8sTXgafz3b5Dvx+sDonxQ4/6JB9SevhHqcm7BXWstQLV94WQgzSFRg4ec0+bXQSaRtLpF0yCAn7wtJzL01DE37h5YDSktYiZ4YCaxGrtDAzORD3Qz9KzlDNUPh4StZaM5E9055sHCpB74F1xoyE+Y2/QM3vNLagJTIOj2bWz+Y/skjska1XJXwDh4qfv3J5Ds/8DLdwNCc6OrHx33IUsQX3Crt6bnoV9QeC7R1dUNFvTITPw+Fye5MEphGyBj3ts4xA+PPnIFbHSIeM5PQRBl+I29CX
x-ms-exchange-antispam-messagedata: +CfrUj2/ZIszakT6w0oiDMyamKZsZaL+KZkJF1TQNvyHr6ghQo3wUXwET8i4Vtd/C/JjC1VaZypKof4YOlG/01EnWVSPXqhYfvpPHQgL27fbK1J1G6k1Yhp7D6sA/+bOb4yiwYpa8nI42BLSts7BaA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4324fba-c3e2-4002-7cf7-08d7b72848e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 23:46:34.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0WdhAgicgrZ0BQrDpIZPcuYRB+i1xf98N7xJj4NOndxy2PlScK/HHF+HM52C89d+WIeL4ybbmoBehq44O0KtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjE1IFJFU0VORCAzLzVdIHRoZXJt
YWw6IGlteF9zYzogYWRkIGkuTVggc3lzdGVtDQo+IGNvbnRyb2xsZXIgdGhlcm1hbCBzdXBwb3J0
DQo+IA0KPiBIaSBBbnNvbiwNCj4gDQo+IHNvcnJ5IGZvciB0aGUgZGVsYXkgd2l0aCB0aGlzIHJl
dmlldywgaG9wZWZ1bGx5IHRoZSB1cHN0cmVhbWluZyB3aWxsIGJlIG5vdyBhDQo+IGJpdCBtb3Jl
IHNtb290aC4NCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgcmV2aWV38J+Yig0KDQo+IA0KPiBBcGFy
dCB0aGUgY29tbWVudHMgYmVsb3csIHRoZSBkcml2ZXIgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+
IE9uIFRodSwgRmViIDIwLCAyMDIwIGF0IDA5OjEwOjI2QU0gKzA4MDAsIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+IGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aGljaCBoYXMgYSBDb3J0ZXgtTTQg
c3lzdGVtIGNvbnRyb2xsZXINCj4gPiBpbnNpZGUsIHRoZSBzeXN0ZW0gY29udHJvbGxlciBpcyBp
biBjaGFyZ2Ugb2YgY29udHJvbGxpbmcgcG93ZXIsIGNsb2NrDQo+ID4gYW5kIHRoZXJtYWwgc2Vu
c29ycyBldGMuLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGkuTVggc3lzdGVtIGNvbnRyb2xs
ZXIgdGhlcm1hbCBkcml2ZXIgc3VwcG9ydCwgTGludXgNCj4gPiBrZXJuZWwgaGFzIHRvIGNvbW11
bmljYXRlIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQpDQo+ID4g
SVBDIHRvIGdldCBlYWNoIHRoZXJtYWwgc2Vuc29yJ3MgdGVtcGVyYXR1cmUsIGl0IHN1cHBvcnRz
IG11bHRpcGxlDQo+ID4gc2Vuc29ycyB3aGljaCBhcmUgcGFzc2VkIGZyb20gZGV2aWNlIHRyZWUs
IHBsZWFzZSBzZWUgdGhlIGJpbmRpbmcgZG9jDQo+ID4gZm9yIGRldGFpbHMuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiBObyBjaGFuZ2UuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdGhlcm1hbC9LY29uZmlnICAg
ICAgICAgIHwgIDExICsrKw0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUgICAgICAgICB8
ICAgMSArDQo+ID4gIGRyaXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jIHwgMTQyDQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hh
bmdlZCwgMTU0IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
dGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90
aGVybWFsL0tjb25maWcgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyBpbmRleA0KPiA+IDVhMDVk
YjUuLmQxY2I4ZGMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL0tjb25maWcNCj4g
PiArKysgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiA+IEBAIC0yNTEsNiArMjUxLDE3IEBA
IGNvbmZpZyBJTVhfVEhFUk1BTA0KPiA+ICAJICBjcHVmcmVxIGlzIHVzZWQgYXMgdGhlIGNvb2xp
bmcgZGV2aWNlIHRvIHRocm90dGxlIENQVXMgd2hlbiB0aGUNCj4gPiAgCSAgcGFzc2l2ZSB0cmlw
IGlzIGNyb3NzZWQuDQo+ID4NCj4gPiArY29uZmlnIElNWF9TQ19USEVSTUFMDQo+ID4gKwl0cmlz
dGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRyaXZlciBmb3IgTlhQIGkuTVggU29DcyB3aXRoIFN5
c3RlbQ0KPiBDb250cm9sbGVyIg0KPiA+ICsJZGVwZW5kcyBvbiBBUkNIX01YQyAmJiBJTVhfU0NV
DQo+IA0KPiBJTVhfU0NVIGRlcGVuZHMgb24gSU1YX01CT1ggd2hpY2ggZGVwZW5kcyBvbiBBUkNI
X01YQy4gVGhpcw0KPiBkZXBlbmRlbmN5IGNvdWxkIGJlIHNpbXBsaWZpZWQuDQo+IA0KPiBBbHNv
IGFkZCB0aGUgQ09NUElMRV9URVNUIG9wdGlvbiB0byBpbXByb3ZlIGNvbXBpbGF0aW9uIHRlc3Qg
Y292ZXJhZ2UuDQoNCldpbGwgbWFrZSBpdCBkZXBlbmRzIG9uIElNWF9TQ1UgYW5kIENPTVBJTEVf
VEVTVA0KDQo+IA0KPiA+ICsJZGVwZW5kcyBvbiBPRg0KPiA+ICsJaGVscA0KPiA+ICsJICBTdXBw
b3J0IGZvciBUZW1wZXJhdHVyZSBNb25pdG9yIChURU1QTU9OKSBmb3VuZCBvbiBOWFAgaS5NWA0K
PiBTb0NzIHdpdGgNCj4gPiArCSAgc3lzdGVtIGNvbnRyb2xsZXIgaW5zaWRlLCBMaW51eCBrZXJu
ZWwgaGFzIHRvIGNvbW11bmljYXRlIHdpdGgNCj4gc3lzdGVtDQo+ID4gKwkgIGNvbnRyb2xsZXIg
dmlhIE1VIChtZXNzYWdlIHVuaXQpIElQQyB0byBnZXQgdGVtcGVyYXR1cmUgZnJvbQ0KPiB0aGVy
bWFsDQo+ID4gKwkgIHNlbnNvci4gSXQgc3VwcG9ydHMgb25lIGNyaXRpY2FsIHRyaXAgcG9pbnQg
YW5kIG9uZQ0KPiA+ICsJICBwYXNzaXZlIHRyaXAgcG9pbnQgZm9yIGVhY2ggdGhlcm1hbCBzZW5z
b3IuDQo+ID4gKw0KPiA+ICBjb25maWcgTUFYNzc2MjBfVEhFUk1BTA0KPiA+ICAJdHJpc3RhdGUg
IlRlbXBlcmF0dXJlIHNlbnNvciBkcml2ZXIgZm9yIE1heGltIE1BWDc3NjIwIFBNSUMiDQo+ID4g
IAlkZXBlbmRzIG9uIE1GRF9NQVg3NzYyMA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJt
YWwvTWFrZWZpbGUgYi9kcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUgaW5kZXgNCj4gPiA5ZmI4OGUy
Li5hMTFhNmQ4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZQ0KPiA+
ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZQ0KPiA+IEBAIC00Myw2ICs0Myw3IEBAIG9i
ai0kKENPTkZJR19EQjg1MDBfVEhFUk1BTCkJKz0NCj4gZGI4NTAwX3RoZXJtYWwubw0KPiA+ICBv
YmotJChDT05GSUdfQVJNQURBX1RIRVJNQUwpCSs9IGFybWFkYV90aGVybWFsLm8NCj4gPiAgb2Jq
LSQoQ09ORklHX1RBTkdPX1RIRVJNQUwpCSs9IHRhbmdvX3RoZXJtYWwubw0KPiA+ICBvYmotJChD
T05GSUdfSU1YX1RIRVJNQUwpCSs9IGlteF90aGVybWFsLm8NCj4gPiArb2JqLSQoQ09ORklHX0lN
WF9TQ19USEVSTUFMKQkrPSBpbXhfc2NfdGhlcm1hbC5vDQo+ID4gIG9iai0kKENPTkZJR19NQVg3
NzYyMF9USEVSTUFMKQkrPSBtYXg3NzYyMF90aGVybWFsLm8NCj4gPiAgb2JqLSQoQ09ORklHX1FP
UklRX1RIRVJNQUwpCSs9IHFvcmlxX3RoZXJtYWwubw0KPiA+ICBvYmotJChDT05GSUdfREE5MDYy
X1RIRVJNQUwpCSs9IGRhOTA2Mi10aGVybWFsLm8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90
aGVybWFsL2lteF9zY190aGVybWFsLmMNCj4gPiBiL2RyaXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhl
cm1hbC5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5kNDA2
ZWNiDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbXhfc2Nf
dGhlcm1hbC5jDQo+ID4gQEAgLTAsMCArMSwxNDIgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjArDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAyMDE4LTIwMTkg
TlhQLg0KPiANCj4gKnNpZ2gqIDIwMjAgbm93IC4uLg0KDQpZZXMsIHNob3VsZCBiZSAyMDE4LTIw
MjANCg0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiArc3RhdGljIGludCBpbXhfc2NfdGhlcm1hbF9n
ZXRfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXApIHsNCj4gPiArCXN0cnVjdCBpbXhfc2NfbXNn
X21pc2NfZ2V0X3RlbXAgbXNnOw0KPiA+ICsJc3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIgPSAm
bXNnLmhkcjsNCj4gPiArCXN0cnVjdCBpbXhfc2Nfc2Vuc29yICpzZW5zb3IgPSBkYXRhOw0KPiA+
ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwltc2cuZGF0YS5yZXEucmVzb3VyY2VfaWQgPSBzZW5z
b3ItPnJlc291cmNlX2lkOw0KPiA+ICsJbXNnLmRhdGEucmVxLnR5cGUgPSBJTVhfU0NfQ19URU1Q
Ow0KPiA+ICsNCj4gPiArCWhkci0+dmVyID0gSU1YX1NDX1JQQ19WRVJTSU9OOw0KPiA+ICsJaGRy
LT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDOw0KPiA+ICsJaGRyLT5mdW5jID0gSU1YX1NDX01J
U0NfRlVOQ19HRVRfVEVNUDsNCj4gPiArCWhkci0+c2l6ZSA9IDI7DQo+IA0KPiBDYW4geW91IGV4
cGxhaW4gdGhpcyAnc2l6ZScgdmFsdWU/DQoNClRoZSBzaXplIG1lYW5zIHRoZSBTQ1UgbWVzc2Fn
ZSBzaXplLCBpbmNsdWRpbmcgdGhlIGhlYWRlciBhbmQgdGhlIGRhdGEsIGl0cyB1bml0DQppcyB3
b3JkKDQgYnl0ZXMpLCBpbiB0aGVybWFsIGdldCB0ZW1wZXJhdHVyZSBtZXNzYWdlLCB0aGUgaGVh
ZGVyIHRha2VzIDEgd29yZCBhbmQNCnRoZSBkYXRhIHRha2VzIGFub3RoZXIgMSwgc28gaXQgaXMg
Miwgd2UgYWxsIHBhc3MgdGhlIHNpemUgaW4gdGhpcyB3YXkgdG8gU0NVIGluIGkuTVg4DQpTb0Nz
LCB0aGUgU0NVIGtub3cgaG93IGxvbmcgbWVzc2FnZSBpdCB3aWxsIG5lZWQgdG8gcmVjZWl2ZSBm
cm9tIEFQLg0KDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCBpbXhfc2NfdGhlcm1hbF90YWJsZSk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciBpbXhfc2NfdGhlcm1hbF9kcml2ZXIgPSB7DQo+ID4gKwkJLnByb2JlID0gaW14
X3NjX3RoZXJtYWxfcHJvYmUsDQo+IA0KPiBUaGUgZHJpdmVyIGNhbiBiZSBjb21waWxlZCBhcyBt
b2R1bGUgYnV0IHRoZXJlIGlzIG5vICdyZW1vdmUnIGNhbGxiYWNrDQoNCkFzIHRoZXJlIGlzIG5v
dGhpbmcgbmVlZHMgdG8gYmUgZG9uZSBpbiAucmVtb3ZlIGNhbGxiYWNrLCBzbyBJIHNraXAgaXQu
IEJ1dA0KSSB0aGluayBJIGNhbiBhZGQgYSBibGFuayAucmVtb3ZlIGNhbGxiYWNrIHRvIG1ha2Ug
aXQgbW9yZSBjb21wbGV0ZS4NCg0KVGhhbmtzLA0KQW5zb24NCg0KPiANCj4gPiArCQkuZHJpdmVy
ID0gew0KPiA+ICsJCQkubmFtZSA9ICJpbXgtc2MtdGhlcm1hbCIsDQo+ID4gKwkJCS5vZl9tYXRj
aF90YWJsZSA9IGlteF9zY190aGVybWFsX3RhYmxlLA0KPiA+ICsJCX0sDQo+ID4gK307DQo+ID4g
K21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoaW14X3NjX3RoZXJtYWxfZHJpdmVyKTsNCj4gPiArDQo+
ID4gK01PRFVMRV9BVVRIT1IoIkFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPiIpOw0K
PiA+ICtNT0RVTEVfREVTQ1JJUFRJT04oIlRoZXJtYWwgZHJpdmVyIGZvciBOWFAgaS5NWCBTb0Nz
IHdpdGggc3lzdGVtDQo+ID4gK2NvbnRyb2xsZXIiKTsgTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIp
Ow0KPiANCj4gDQo+IA0KPiAtLQ0KPiANCj4gDQo+IDxodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gbGluYXJvLm9y
ZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDZDVjZTU1DQo+
IGFhYWI0MTQxZjVmNmUzMDhkN2I2Y2NmZTcyJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlN0MwDQo+ICU3QzAlN0M2MzcxNzg4NjM4NjQ4MjYwMDImYW1wO3NkYXRhPTFYT0tOcnJJ
a1U5elhrbGpPQWNTeFBjS0FGNGcNCj4galNoQmF2JTJGeUdPNjEyRk0lM0QmYW1wO3Jlc2VydmVk
PTA+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlDQo+IHNvZnR3YXJlIGZvciBBUk0gU29Dcw0K
PiANCj4gRm9sbG93IExpbmFybzoNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBmYWNlYm9vay5jb20lMkZw
YWdlcyUyRkxpbmFybyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNA0KPiAwbnhwLmNv
bSU3Q2Q1Y2U1NWFhYWI0MTQxZjVmNmUzMDhkN2I2Y2NmZTcyJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
DQo+IDJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcxNzg4NjM4NjQ4MjYwMDImYW1wO3NkYXRh
PWdwenhZRmNFVg0KPiBjNExzZW5xTkZiTVZTNVl2eDhHTGVxaXRvTkI2NmJuOHY0JTNEJmFtcDty
ZXNlcnZlZD0wPiBGYWNlYm9vayB8DQo+IDxodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnR3aXR0ZQ0KPiByLmNvbSUyRiUyMyEl
MkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmMNCj4gb20l
N0NkNWNlNTVhYWFiNDE0MWY1ZjZlMzA4ZDdiNmNjZmU3MiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJj
ZDk5Yw0KPiA1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MTc4ODYzODY0ODM1OTk3JmFtcDtzZGF0YT1U
WHluJTJGMSUyQjJiDQo+IHNDS2hDaWJkU2pkbHlNZTdScWpDOEx6VlVoJTJGcllPbk5QcyUzRCZh
bXA7cmVzZXJ2ZWQ9MD4gVHdpdHRlciB8DQo+IDxodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gbGluYXJvLm9yZyUy
RmxpbmFyby0NCj4gYmxvZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAu
Y29tJTdDZDVjZTU1YWFhYg0KPiA0MTQxZjVmNmUzMDhkN2I2Y2NmZTcyJTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDDQo+IDAlN0M2MzcxNzg4NjM4NjQ4MzU5OTcmYW1w
O3NkYXRhPUxDTkZmc2ZZR0IxVDFJRk5kaDRkbWpaSjhTNE5JQXYNCj4gaVBwaWhSJTJGWGFBWUEl
M0QmYW1wO3Jlc2VydmVkPTA+IEJsb2cNCg==

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8C28F8F
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 05:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfEXDWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 23:22:08 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:38126
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731773AbfEXDWI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 May 2019 23:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/WfSce1xbDv/ISSEsSYy5O9ACrgYzL2uY79ijl659g=;
 b=b7VWQTx531SdDdTgl1twglfOOyL98Ucz7d99+N5tuWUVKg2QJUZT8XLELcqcYdnm+Ncshas5hSEcKKsbTSV3oygf2j9S0SYurIrS/NVRfZNmXDgs7bVfUwZnF91FPLgZv1egW6C7S6mFVRz6OMnX3q2w08ptw3KkUWICbULaaFs=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1SPR01MB0371.eurprd04.prod.outlook.com (20.178.125.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Fri, 24 May 2019 03:21:24 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::497a:768:c7b1:34e0]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::497a:768:c7b1:34e0%6]) with mapi id 15.20.1922.018; Fri, 24 May 2019
 03:21:24 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: thermal: Make cooling-maps
 property optional
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: thermal: Make cooling-maps
 property optional
Thread-Index: AQHVCwLUH4zad13tsE2wQPY/IOtNWqZ5oNEAgAADyNA=
Date:   Fri, 24 May 2019 03:21:24 +0000
Message-ID: <VI1PR04MB4333A37E27148B4295C3E761F3020@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190515093647.47656-1-andy.tang@nxp.com>
 <20190524025017.GA4146@localhost.localdomain>
In-Reply-To: <20190524025017.GA4146@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e793d0e-8c6e-4bd1-9c3f-08d6dff6e6da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1SPR01MB0371;
x-ms-traffictypediagnostic: VI1SPR01MB0371:
x-microsoft-antispam-prvs: <VI1SPR01MB037137945C99C9C2CE86B2C4F3020@VI1SPR01MB0371.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(13464003)(199004)(189003)(55016002)(446003)(74316002)(26005)(102836004)(9686003)(11346002)(86362001)(25786009)(66066001)(53546011)(6506007)(52536014)(6436002)(66946007)(66556008)(316002)(2906002)(73956011)(76116006)(229853002)(186003)(66476007)(66446008)(64756008)(33656002)(44832011)(4326008)(478600001)(8936002)(1411001)(71200400001)(71190400001)(81156014)(81166006)(6916009)(54906003)(53936002)(476003)(76176011)(3846002)(305945005)(6246003)(14454004)(7736002)(5660300002)(68736007)(486006)(256004)(99286004)(7696005)(8676002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB0371;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JUoun0wIKqd9t/GRlzGFlOmemm6eChiNNt1WUvh18CiEYk3f2q5lSJKyzE/vHU1qbM+IqdNfzlFfyU2Dp+Mmp6EE+YuN7LXkx5h9YMCQjl7HPCS2W3yNyr8aaizdZ4EcsKiKB42d9U3Nzglh5SHP29BBBGNY5++AkY0Tlo84mznWvpdmys2jANfw1Sju96EvDBBt68DzIeV+A/8AYdz2suH45UINk8K18iT8S5ZBsG0PTuj8R8jSG0obQXG9eRvNsGdk/JI/FjMFBn5FGbi1H1/qixy3xAfTxK8a4hl+jzgQr0RXg+s7UM4oh//sHs1A7VMFhdAIdpwBLRpIU7b9fZwoQdGVO0zAFvfjzWSwCsKnQYWmT0VE37zjetMZ60XY7O+j2tjoWmIKUtWWodmNN/touSZOf9tARo6U7UOlSgg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e793d0e-8c6e-4bd1-9c3f-08d6dff6e6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 03:21:24.5800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andy.tang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB0371
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFZHVhcmRvIFZhbGVudGluIDxl
ZHViZXp2YWxAZ21haWwuY29tPg0KPiBTZW50OiAyMDE5xOo11MIyNMjVIDEwOjUwDQo+IFRvOiBB
bmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiBDYzogcnVpLnpoYW5nQGludGVsLmNvbTsg
cm9iaCtkdEBrZXJuZWwub3JnOyBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOw0KPiBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBb
RVhUXSBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogdGhlcm1hbDogTWFrZSBjb29saW5nLW1hcHMg
cHJvcGVydHkNCj4gb3B0aW9uYWwNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24g
V2VkLCBNYXkgMTUsIDIwMTkgYXQgMDU6MzY6NDdQTSArMDgwMCwgWXVhbnRpYW4gVGFuZyB3cm90
ZToNCj4gPiBUaGVyZSBtYXkgYmUgbm8gY29vbGluZyBkZXZpY2Ugb24gc3lzdGVtLCBvciB0aGVy
ZSBhcmUgbm8gZW5vdWdoDQo+ID4gY29vbGluZyBkZXZpY2VzIGZvciBlYWNoIHRoZXJtYWwgem9u
ZSBpbiBtdWx0aXBsZSB0aGVybWFsIHpvbmUgY2FzZXMNCj4gPiBzaW5jZSBjb29saW5nIGRldmlj
ZXMgY2FuJ3QgYmUgc2hhcmVkLg0KPiA+IFNvIG1ha2UgdGhpcyBwcm9wZXJ0eSBvcHRpb25hbCB0
byByZW1vdmUgc3VjaCBsaW1pdGF0aW9ucy4NCj4gDQo+IFllYWgsIEkgYW0gIG5vdCBzdXJlIHRo
YXQgaXMgZW5vdWdoIHJlYXNvbiB0byBtYWtlIHRoaXMgcHJvcGVydHkgb3B0aW9uYWwuDQo+IExl
dCBtZSBtYXliZSBhc2sgeW91IHdoeSBkbyB5b3UgY2FyZSBjcmVhdGluZyBhIHRoZXJtYWwgem9u
ZSBpZiB5b3VyIGNvbnRyb2wNCj4gaGFzIG5vIGFjdGlvbnM/IE9yIHJhdGhlciwgd2h5IGJvdGhl
cmluZyBzZXR0aW5nIHVwIGEgY29udHJvbCB0aGF0IGhhcyBubw0KPiBhY3R1YXRvcnM/DQpObyBj
b29saW5nLWRldmljZSBtYXAgZG9lc24ndCBtZWFuIE5PIEFDVElPTlMuIFRoZXJlIGNvdWxkIGJl
IGNyaXRpYyB0cmlwcyB0aGF0IHRyaWdnZXIgQ1BVIHJlc2V0IG9yIHNodXRkb3duLg0KVGhlIHJv
b3QgY2F1c2UgZm9yIGl0IGhlcmUgaXM6IHRoZXJlIGlzIG5vIGVub3VnaCBjb29saW5nIGRldmlj
ZSBmb3IgZWFjaCB6b25lIHdoZW4gbXVsdGlwbGUgem9uZSBleGlzdC4NCkZvciBleGFtcGxlLCBm
b3Igb3VyIGxzMjA4OGEgcGxhdGZvcm0sIHRoZXJlIGFyZSA3IHRoZXJtYWwgem9uZXMsIGJ1dCB3
ZSBoYXZlIG9ubHkgb25lIGNvb2xpbmcgZGV2aWNlIHdoaWNoIGlzIGNwdWZyZXEuDQpEdWUgdG8g
dGhpcyBvcHRpb24gbGltaXRhdGlvbiwgbXVsdGlwbGUgem9uZXMgY2FuJ3QgYmUgc3VwcG9ydGVk
Lg0KSSBiZWxpZXZlIG9uIG1vc3QgcGxhdGZvcm0sIHRoZXJlIGFyZSBvbmx5IHR3byB0eXBlIG9m
IGNvb2xpbmcgZGV2aWNlcywgY3B1ZnJlcSBhbmQgZmFuLiBTbyBob3cgbWFueSBjb29saW5nIGRl
dmljZXMgaXQgY291bGQgYmU/DQpTbyBtYWtpbmcgdGhlIHByb3BlcnR5IG9wdGlvbmFsIGlzIHJl
YXNvbmFibGUuIFdlIGNhbiBhc3NpZ24gY29vbGluZyBkZXZpY2VzIHRvIGNlcnRhaW4gdGhlcm1h
bCB6b25lcyBhbmQgbGVhdmUgdGhlIHRoZXJtYWwgem9uZSB3aXRoIG5vIGNvb2xpbmcgZGV2aWNl
IHRha2luZyBkZWZhdWx0IGFjdGlvbnMuDQoNCkJSLA0KQW5keQ0KPiANCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFl1YW50aWFuIFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3RoZXJtYWwudHh0ICAgICAgICB8ICAg
IDQgKystLQ0KPiA+ICAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdGhlcm1hbC90aGVybWFsLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50eHQNCj4gPiBpbmRleCBjYTE0YmE5Li42OTRlODM0
IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVy
bWFsL3RoZXJtYWwudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3RoZXJtYWwvdGhlcm1hbC50eHQNCj4gPiBAQCAtMTQyLDExICsxNDIsMTEgQEAgUmVxdWly
ZWQgcHJvcGVydGllczoNCj4gPiAgLSB0cmlwczogICAgICAgICAgICAgQSBzdWItbm9kZSB3aGlj
aCBpcyBhIGNvbnRhaW5lciBvZiBvbmx5IHRyaXAgcG9pbnQNCj4gbm9kZXMNCj4gPiAgICBUeXBl
OiBzdWItbm9kZSAgICAgcmVxdWlyZWQgdG8gZGVzY3JpYmUgdGhlIHRoZXJtYWwgem9uZS4NCj4g
Pg0KPiA+ICsNCj4gPiArT3B0aW9uYWwgcHJvcGVydHk6DQo+ID4gIC0gY29vbGluZy1tYXBzOiAg
ICAgICAgICAgICAgQSBzdWItbm9kZSB3aGljaCBpcyBhIGNvbnRhaW5lciBvZiBvbmx5DQo+IGNv
b2xpbmcgZGV2aWNlDQo+ID4gICAgVHlwZTogc3ViLW5vZGUgICAgIG1hcCBub2RlcywgdXNlZCB0
byBkZXNjcmliZSB0aGUgcmVsYXRpb24NCj4gYmV0d2VlbiB0cmlwcw0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICBhbmQgY29vbGluZyBkZXZpY2VzLg0KPiA+IC0NCj4gPiAtT3B0aW9uYWwgcHJv
cGVydHk6DQo+ID4gIC0gY29lZmZpY2llbnRzOiAgICAgICAgICAgICAgQW4gYXJyYXkgb2YgaW50
ZWdlcnMgKG9uZSBzaWduZWQgY2VsbCkNCj4gY29udGFpbmluZw0KPiA+ICAgIFR5cGU6IGFycmF5
ICAgICAgICAgICAgICAgIGNvZWZmaWNpZW50cyB0byBjb21wb3NlIGEgbGluZWFyIHJlbGF0aW9u
DQo+IGJldHdlZW4NCj4gPiAgICBFbGVtIHNpemU6IG9uZSBjZWxsICAgICAgICB0aGUgc2Vuc29y
cyBsaXN0ZWQgaW4gdGhlIHRoZXJtYWwtc2Vuc29ycw0KPiBwcm9wZXJ0eS4NCj4gPiAtLQ0KPiA+
IDEuNy4xDQo+ID4NCg==

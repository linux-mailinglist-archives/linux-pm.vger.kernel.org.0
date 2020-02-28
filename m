Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9230172DA9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 01:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgB1Apz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 19:45:55 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:15334
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730536AbgB1Apw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Feb 2020 19:45:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBf+aMld5Cc2wB1zNz4oSsTtJLs8KYR2qA2Wdr0g4NFB41/Go2dkKzc10AKU5K586sQkRqSOW2wzn1wrYqioUO50d/t8/+vOU/bbU/9M83sjlO6Na1N5F+FwBAKM6DIdtChRAw2ovEtqTHsXMxeRQ13f0pCk2gfWf1JpDP9ZciJEtnBp3zBH6WF9GR7dbK2Z5Jcjhw/xnjhbSr6FWOjPynZe91/waMYsb4+9MAWFKJBGPku5OBua6jJuHy9hd9hGSRQj1bBNTqeP0HReySMNggAubNHu5p9tl5La/YY96Gj1UuWi7TmvypEuNrVOwmx4oywgB4Yy9gdAAhCx6bZJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwDSx44lFmM+UYltTS60Q4HIVpB2drlseL5x1zmAakI=;
 b=l8tLLIPm6MR03kNd+RccKqa3Xkf03WqRVXaW8roaBV+XEU2QHyC3PSyuG5YFLwRpKJUqA26QVQJW2bps7RgQOH21XvTOv+Kz30hhDvZmqRJo3Z9CU3IpeVNFapMYgI7roB3VKXm2siMvZ9OAfoSHyLPIZ6RfREe5Y1w/KrmNNDSVOzQg5Ql9eJKzcxuUozQiFuDuMVuPuytxpwXDHeoAAyXA52HcDJGWEAsOaoXLOl2b+qNT3xsj3LWyJSscpSB1apMCtoBA0Ot1afi/8NUhWvqw1JrRrIwZ929s6j9Xi1dqSSBDoyUOyRx423GPetWl2cIrEb4hau/2AE7N2dPePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwDSx44lFmM+UYltTS60Q4HIVpB2drlseL5x1zmAakI=;
 b=im9El94pTE5IWGaUtAJAdb3PT1YalNo9r/uhnh0cPrjjiEZIjgu3tHUOLCStoHEftohfKFFgQY3JpqH/Plj745M+uOZ3ZKqT79OQ7a8FoPHMZgBZWGU+VRFj/N/N6HM4HRBqJ92BRC2L1GuMIB8YxcOf+Z1bCm0kdthg79KF+gU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Fri, 28 Feb 2020 00:45:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 00:45:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V16 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V16 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHV6RUly757KwSthUGsSdMMqHZymqguyRCAgAEFViA=
Date:   Fri, 28 Feb 2020 00:45:48 +0000
Message-ID: <DB3PR0402MB391617AA88AE4D4A81262A68F5E80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1582330132-13461-1-git-send-email-Anson.Huang@nxp.com>
 <41da5dc1-9d46-da71-4893-5c23e6e3d96a@linaro.org>
In-Reply-To: <41da5dc1-9d46-da71-4893-5c23e6e3d96a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df39afc0-5ebb-4de1-12d4-08d7bbe78e02
x-ms-traffictypediagnostic: DB3PR0402MB3738:|DB3PR0402MB3738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3738437826CF5FB8F0F8F942F5E80@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(7416002)(478600001)(44832011)(66946007)(76116006)(66446008)(66476007)(66556008)(52536014)(9686003)(2906002)(55016002)(5660300002)(4326008)(64756008)(8676002)(26005)(186003)(71200400001)(81156014)(81166006)(6506007)(53546011)(8936002)(86362001)(316002)(110136005)(7696005)(33656002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r0wTNWCnYlX9XS/UrcTgnwxeRK9wVfdP4teTCDgSMijQTCvkPmnWhsPu+jPUAiI3CN/a+QBCJUcvPEVqWZV2+Nd/41bwOIe1pziybUvDOAyk9u6m6qfwl3808bWufrlktZwcLmBZ9sREsu6D1Q4W+UOMTVFhHzRE+CnYdYzqwbas6qcvj/9pEpST4mE29e7aP9iODLj8CQA6H5X6xzOyZ8e+Ti3xGwJABhC8FRBw3kyJZzwCdAoYVxODdXsMQCfB5lCf4G/pOaHMc21sQVj5wK9RZS9tDU3/Vs7Zb7M1xx9a8i16IuMGDEbABcC70u+cXBFel9dks5a+uMMnReZ0HKXgO8A206MmvnxKHK4DWLRufANTTvEGLTIxhiaP7qH9rLj4EPPao6xAEp9JY8PWNMKSDnE+lRwuEkHfwto1jDifpaMt7alc6Mjy0ntno7UNM+/imkMcKI/OqVCya7O9Ing0Z1WuDvO+tRXJbNz3yCkiIf7vOQofeZxjuNUxh7grz4KRdkXObtVwhLgo7InJGBbn6CbQgm/W/c9u+C3Lcm3oHOr19XjsPQnBYKf+NkvEYGoFJseM0/NyLqh57Dun3WCxFxXC2f9VokTgPw1P/iVnAMwysgCmTTQ8WdW0cnqEYDoYOUI/cVNsrcz4VJlb+3GvKhQubG4CtXvKItIogfZ9srZvkQDTYXVz48mcC1ZX
x-ms-exchange-antispam-messagedata: sP8qXgpKSsYXWpmlb8yqCBqsbmUTmRorPpL+Ju+VHhnkdIC1d2YaqjLDxoJk4qUfV+tWPQvAntMRxSfer7F+m0BTLjQeksiBHDCxdbhSIFAnG1CszDxRTFDQKpN3GZpJBO0Uajm8aSTkJho7BRSYdg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df39afc0-5ebb-4de1-12d4-08d7bbe78e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 00:45:48.8625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvFUIQOyVgBivKCa0wyys5Th+nnnynCEbrNkfU8s7tASC1XVhAte4awYajX261+4h+LeGECF4T+MLma+xUxw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFNoYXduDQoJV2lsbCB5b3UgdGFrZSBwYXRjaCAjNCBhbmQgIzU/IFRoYW5rcy4NCg0KQW5z
b24NCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxNiAxLzVdIGR0LWJpbmRpbmdzOiBmc2w6IHNj
dTogYWRkIHRoZXJtYWwgYmluZGluZw0KPiANCj4gT24gMjIvMDIvMjAyMCAwMTowOCwgQW5zb24g
SHVhbmcgd3JvdGU6DQo+ID4gTlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29y
dGV4LU00IGNvcmUgaW5zaWRlIGFzIHN5c3RlbQ0KPiA+IGNvbnRyb2xsZXIsIHRoZSBzeXN0ZW0g
Y29udHJvbGxlciBpcyBpbiBjaGFyZ2Ugb2Ygc3lzdGVtIHBvd2VyLCBjbG9jaw0KPiA+IGFuZCB0
aGVybWFsIHNlbnNvcnMgZXRjLiBtYW5hZ2VtZW50LCBMaW51eCBrZXJuZWwgaGFzIHRvIGNvbW11
bmljYXRlDQo+ID4gd2l0aCBzeXN0ZW0gY29udHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkg
SVBDIHRvIGdldCB0ZW1wZXJhdHVyZQ0KPiA+IGZyb20gdGhlcm1hbCBzZW5zb3JzLCB0aGlzIHBh
dGNoIGFkZHMgYmluZGluZyBkb2MgZm9yIGkuTVggc3lzdGVtDQo+ID4gY29udHJvbGxlciB0aGVy
bWFsIGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5I
dWFuZ0BueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPg0KPiA+IFJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29t
Pg0KPiANCj4gSSdsbCB3aWxsIHRha2UgcGF0Y2hlcyAxLCAyIGFuZCAzDQo+IA0KPiBUaGFua3Mh
DQo+IA0KPiAgIC0tIERhbmllbA0KPiANCj4gPiAtLS0NCj4gPiBObyBjaGFuZ2UuDQo+ID4gLS0t
DQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQg
ICAgICAgIHwgMTYNCj4gKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+
ID4gaW5kZXggZTA3NzM1YTguLjdmNDJjYzMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1
LnR4dA0KPiA+IEBAIC0xNjYsNiArMTY2LDE3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4g
ICAgICAgICAgICAgICAgZm9sbG93ZWQgYnkgImZzbCxpbXgtc2Mta2V5IjsNCj4gPiAgLSBsaW51
eCxrZXljb2RlczogU2VlDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lu
cHV0L2tleXMudHh0DQo+ID4NCj4gPiArVGhlcm1hbCBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVz
c2FnZSBQcm90b2NvbA0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6
DQo+ID4gKy0gY29tcGF0aWJsZToJCQlTaG91bGQgYmUgOg0KPiA+ICsJCQkJICAiZnNsLGlteDhx
eHAtc2MtdGhlcm1hbCINCj4gPiArCQkJCWZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXRoZXJtYWwi
Ow0KPiA+ICsNCj4gPiArLSAjdGhlcm1hbC1zZW5zb3ItY2VsbHM6CVNlZQ0KPiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC90aGVybWFsLnR4dA0KPiA+ICsJCQkJZm9y
IGEgZGVzY3JpcHRpb24uDQo+ID4gKw0KPiA+ICBFeGFtcGxlIChpbXg4cXhwKToNCj4gPiAgLS0t
LS0tLS0tLS0tLQ0KPiA+ICBhbGlhc2VzIHsNCj4gPiBAQCAtMjM4LDYgKzI0OSwxMSBAQCBmaXJt
d2FyZSB7DQo+ID4gIAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2Mtd2R0IiwgImZzbCxp
bXgtc2Mtd2R0IjsNCj4gPiAgCQkJdGltZW91dC1zZWMgPSA8NjA+Ow0KPiA+ICAJCX07DQo+ID4g
Kw0KPiA+ICsJCXRzZW5zOiB0aGVybWFsLXNlbnNvciB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxeHAtc2MtdGhlcm1hbCIsICJmc2wsaW14LXNjLQ0KPiB0aGVybWFsIjsNCj4gPiAr
CQkJI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+Ow0KPiA+ICsJCX07DQo+ID4gIAl9Ow0KPiA+
ICB9Ow0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiANCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBsaW5h
cm8ub3JnJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NBbnNvbi5IdWFuZyU0MG54cC5jb20lN0NhNWZi
NzgNCj4gYzgyOGJkNDBmMjBjNmEwOGQ3YmI2NGMxZjMlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3Qw0KPiAwJTdDMCU3QzYzNzE4MzkxMzczMDA2OTcyMyZhbXA7c2RhdGE9cUt0
JTJCbVQ3eVR3QW10elVrYXVqQiUyDQo+IEJ1UVgwcVN6YWozMnIzY3dMMGNvUEF3JTNEJmFtcDty
ZXNlcnZlZD0wPiBMaW5hcm8ub3JnIOKUgiBPcGVuDQo+IHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJN
IFNvQ3MNCj4gDQo+IEZvbGxvdyBMaW5hcm86DQo+IDxodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gZmFjZWJvb2su
Y29tJTJGcGFnZXMlMkZMaW5hcm8mYW1wO2RhdGE9MDIlN0MwMSU3Q0Fuc29uLkh1YW5nJTQNCj4g
MG54cC5jb20lN0NhNWZiNzhjODI4YmQ0MGYyMGM2YTA4ZDdiYjY0YzFmMyU3QzY4NmVhMWQzYmMy
YjRjNmZhOQ0KPiAyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MTgzOTEzNzMwMDY5NzIzJmFt
cDtzZGF0YT1TMVFOanFIcQ0KPiBYMW5qVzQzNkQ1amNuWktTbWRtJTJCWnR5NXNNQ08wM0N2TnRz
JTNEJmFtcDtyZXNlcnZlZD0wPg0KPiBGYWNlYm9vayB8DQo+IDxodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnR3aXR0ZQ0KPiBy
LmNvbSUyRiUyMyElMkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q0Fuc29uLkh1YW5nJTQw
bnhwLmMNCj4gb20lN0NhNWZiNzhjODI4YmQ0MGYyMGM2YTA4ZDdiYjY0YzFmMyU3QzY4NmVhMWQz
YmMyYjRjNmZhOTJjZDk5Yw0KPiA1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MTgzOTEzNzMwMDY5NzIz
JmFtcDtzZGF0YT00aiUyRkRYTlFpZVRncw0KPiBYaHZXV1lOU1RnbnBiajhVMGI4U0tkNjJYZUJ4
ejhZJTNEJmFtcDtyZXNlcnZlZD0wPiBUd2l0dGVyIHwNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBsaW5h
cm8ub3JnJTJGbGluYXJvLQ0KPiBibG9nJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NBbnNvbi5IdWFu
ZyU0MG54cC5jb20lN0NhNWZiNzhjODI4DQo+IGJkNDBmMjBjNmEwOGQ3YmI2NGMxZjMlN0M2ODZl
YTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MNCj4gMCU3QzYzNzE4MzkxMzczMDA2
OTcyMyZhbXA7c2RhdGE9b25iTmJYQWJueHdZd1VUTXBHNWpHdHNmbU4lDQo+IDJCTUpGOEpWWlYy
WVMwYmJKdyUzRCZhbXA7cmVzZXJ2ZWQ9MD4gQmxvZw0KDQo=

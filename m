Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8873F1B66C8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 00:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDWW26 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 18:28:58 -0400
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:16481
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbgDWW26 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 18:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp83+fOeF/8VIKdVi7E8CdZjQ8xfB1z0ZfE7ZiReZ5/bcrwSXkEKWM+HXI4YFs99Qdh8yFDr/k5mchsEk9vlZfkk3mRKnVud+ikac/h9hB0H/K+0iG0o+EvCGQbol0Tp24Kc+JyFRlCnxGAoMKbrcuGr9gfTJwh8IayMwzdGoOxWK60N2gh5NZ2eL6kQaucV0qIRBtvlsSgDLe4r30vovLtv55JZy+tH8178wrN0Kgb3mL2F/b6kXVMAGf+94cWU4EbVQ13urcwSA7scGAYqw/4d5x+Zkx8yU6sFn1QX8xNlbldKTy71DYUkrohG2ev2syZu0AJ1ULcO/np4DLbh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sje7wFswqOj3yOxtyDEZzfmlCTPQDzRx5br9haas2k=;
 b=CiCWl+m6UV6oixAu1+dAHtr/joY2zyIlIExBkL9sGIyFvYggHfxYUFSVjoUaZEQ8gjKHLcz4OOmSTVOlEUe5faxIA1HTHoHA85pU9QvhmdImLj7lcnX4VBCMsYL8PFPghsojlzxFTIfQi7GPYzmylGzwxRZmLdDsCoiWHdcqK3D9+/YBm7JlOu5vg3bamQB7svyGYVE4q+zxtbyl+VDZnmb7NQi3DzT23FkxNFxA2Qa0r532pUFKVOd+Glppnb7cDg7QJ58SwDsbn9BxbHUHcsVm7zl0zkK1WGdSPd8AtAcqI+qdhiPp31nKVHafF4fvGdOtHAwRMZZNl05xUhRWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sje7wFswqOj3yOxtyDEZzfmlCTPQDzRx5br9haas2k=;
 b=akugVlet94ll5d9IJMNs7zZFJcgdNMoxX8liIYLlfKPLhdHtPARbyxAJn5ShLG2YtGWWf5w7cOzcXccSzYC0q72zql4eh5ioaD+JPSOqALjuTDc6j3Wn5sg5nPHLe/bupSUiQGkVET0R87xy7dTZmcB8AkOjfi3Gg9Tv1n/Y5DE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3930.eurprd04.prod.outlook.com (2603:10a6:8:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 22:28:53 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2921.035; Thu, 23 Apr 2020
 22:28:52 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: firmware: imx: Move system control into
 dt-binding headfile
Thread-Topic: [PATCH V2] dt-bindings: firmware: imx: Move system control into
 dt-binding headfile
Thread-Index: AQHWGYYRHw3KZsZM0UG42O+lWsXrlaiG3HaAgABrSDA=
Date:   Thu, 23 Apr 2020 22:28:52 +0000
Message-ID: <DB3PR0402MB3916489B8ADCA1F487F7A748F5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587656148-24581-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966AF54A95ACF4F33634AD080D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966AF54A95ACF4F33634AD080D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87e96c26-b302-407e-06a5-08d7e7d5b3f4
x-ms-traffictypediagnostic: DB3PR0402MB3930:|DB3PR0402MB3930:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3930046C180BCB0CDE81E5CAF5D30@DB3PR0402MB3930.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(33656002)(66446008)(66556008)(55016002)(7416002)(26005)(76116006)(66476007)(66946007)(71200400001)(7696005)(52536014)(6506007)(44832011)(4326008)(8936002)(2906002)(5660300002)(186003)(64756008)(9686003)(81156014)(86362001)(8676002)(478600001)(110136005)(316002)(921003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5ViQKdwzyEOlS1cabz2C+yn1QcMa8+LOzC9RNwx9Y/F3ps57DJCoPDbcO8Q8zxHrY1qJ3p5J7Zodh1RCXp4oTgPXbFHobpH4dRz7FBh++YsaL8aGYUeC3lTzc8JEuhsQR2f5UiJ0vfYKOK9QNlwqOxFLVS/wJNWkyTK3rNUu4/ZK1PgoQoSJVw4rpHaLNS1q7z1TqalbrFlh881OX++xEbCjigsqCOUtgNXl3cToeAhGfX3359zHqftT+eMf8pEAlO1ngwrdRbC54e7pn1MPnTSzLKImdl5b9RKenSszZtSFPD7LUGFkm0t7KHGOawzrH4Z4whPcaowwdHCF/LmVsx8UMhgK6bbn9xNNARe2u94avILW/jifX6U565eb/RrCDagefJm0Kujwh4EWrGBsHKtVca4ye65NLo7w2N7OKvPCBcgi/XGJ/vpjgKPC/C63BGPTAHNiscPjaRckZLspfTyWN4Ek2+Sno4R6VzbsUM=
x-ms-exchange-antispam-messagedata: qYePP3GUcCqIgSG8dME5B5EhR3J87pg3OtnywGkj97uGP+HOLknpYD581d/bPg+XL12BgXDwk7HVhk2/cHCIfmX4k4mQ0k67WuvpPK8rb2GpTzimXx7k4KS9jkDZnSArd/Z6c+SDbizYpfdJax4uMNMzJ3LGwagKpgQcLt5OTCOJWnK+95cB19sdcjTze2VEUbCG6p2JWjaU524yVzUC9yg60Ku8Z1TQ21vRXA9xSDZnB4h6leGvhY9/YL+s26LnoDE69BXSZwrZTGEswitmMSo8Yk6hPqSD/SScZaM8oZakvSN115AgoFTiCKLWLhvLGbhdnk+PZOCFiScUDR5SXJEkAuF0DNGmyZpoCkbaS278/taUsOVEV8ws0v2O8K0gHhG4+5Nm5ILI6OhFjFguBpJekQi1E6LeoJCZsovbHUj/yln07AvTwD7FjJNEMWZGxKi5jLk1/HwA84CruFKMeJK6rt8O3GSPyfMCjFf8Isgy66fjXL1Qq3hvLiAHQyDw6ymZZILHKGmd4O4ytsg/i4GpklelmbqoTpNwIqpgXXGheKdB+wCKpqpapwhdM4cyeZQKd8FhZ8IgggmTHkGQvSnvW0k2ywIdNtZXlNBAx7lctFXngYnN0HGFf4kdwRCpXdD7/WKoA+UWW1ti1TWoxcaC5e4xKcwwC/Gckr33PwrgU5lb7SItkgfPoIBqYqsAA9QgCEBsZnR4dpQfIipuTL+pcC23zZZGKjBU3iaWys7lnhgwbg+AVXuAcuf9nMbk7nUIkFvd2v8P2FXGR9jNHp7RsEPo3wY5aru/224aKlA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e96c26-b302-407e-06a5-08d7e7d5b3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 22:28:52.8049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bU+fzP5GzYCWZYQ58KglAVIt9gjUlnJsADBgnTx2Bjee2rD99MBxMeWY/QsIUqG54LdOdLxGD6gk88mXQaou8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3930
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBpbXg6
IE1vdmUgc3lzdGVtIGNvbnRyb2wgaW50bw0KPiBkdC1iaW5kaW5nIGhlYWRmaWxlDQo+IA0KPiA+
IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IFNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCAyMywgMjAyMCAxMTozNiBQTQ0KPiA+DQo+ID4gaS5NWDggU29DcyBEVFMgZmls
ZSBuZWVkcyBzeXN0ZW0gY29udHJvbCBtYWNybyBkZWZpbml0aW9ucywgc28gbW92ZQ0KPiA+IHRo
ZW0gaW50byBkdC1iaW5kaW5nIGhlYWRmaWxlLCB0aGVuIGluY2x1ZGUvbGludXgvZmlybXdhcmUv
aW14L3R5cGVzLmgNCj4gPiBjYW4gYmUgcmVtb3ZlZCBhbmQgdGhvc2UgZHJpdmVycyB1c2luZyBp
dCBzaG91bGQgYmUgY2hhbmdlZCBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gWW91IHNlZW1zIGlnbm9y
ZWQgbXkgY29tbWVudHMgaW4gVjEuDQo+IFVzdWFsbHkgd2UnZCBiZXR0ZXIgdG8ga2VlcCBvcmln
aW5hbCBhdXRob3Igd2hlbiBzZW5kaW5nIHBhdGNoZXMgaWYgbm8NCj4gZnVuZGFtZW50YWwgY2hh
bmdlcy4NCg0KSGVyZSBpcyB0aGUgZGV0YWlscywgdGhlIGFpbSBvZiB0aGlzIHBhdGNoIGlzIHRv
IGdldCByaWQgb2YgYmVsb3cgcGF0Y2ggaW4gaW50ZXJuYWwgdHJlZSwNCkkgZGlkIE5PVCBjaGVj
ayB0aGUgZGV0YWlscyBvZiBpbnRlcm5hbCB0cmVlIGFuZCBkaWQgdGhlIHBhdGNoIG1hbnVhbGx5
IGFuZCBkaWQgTk9UIA0KY2hlY2sgaG93IG1hbnkgcGF0Y2hlcyBJIG5lZWQgaW4gaW50ZXJuYWwg
dHJlZSBpbiBvcmRlciB0byBtYWtlIHRoZSBidWlsZCBwYXNzZWQuIEFmdGVyDQpjaGVja2luZyBp
dCwgbG9va3MgbGlrZSB0aGVyZSBhcmUgMyBwYXRjaGVzLCAyIGFyZSBmcm9tIHlvdSwgYW5kIDEg
ZnJvbSBKYWNreS4gU2luY2UgdGhlc2UgcGF0Y2hlcw0KbmVlZCB0byBiZSBzcXVhc2hlZCBpbnRv
IDEgcGF0Y2gsIGFsc28gZml4IG1pbm9yIGNvbW1lbnQgaW4gY29kZSBhbmQgaW1wcm92ZSB0aGUg
Y29tbWVudCwNCnNvLCBzaG91bGQgSSBwdXQgeW91IGFzIGF1dGhvciBvciBKYWNreSBhcyBhdXRo
b3I/Pw0KDQpjb21taXQgY2I2NjAzOTk5MzY3YWVhZTU3MDA0NjM4YTRiOGU0M2VlNjE4ZGJlYw0K
QXV0aG9yOiBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+DQpEYXRlOiAgIE1vbiBNYXIgOSAx
NDo0MTo0NCAyMDIwICswODAwDQoNCiAgICB0aGVybWFsOiBpbXhfc2NfdGhlcm1hbDogZml4IHRo
ZSBidWlsZCBicmVhayBjYXVzZWQgbm9uIGV4aXN0ZW50IHR5cGVzLmgNCg0KICAgIFRoZSB0eXBl
cy5oIGhhcyBiZWVuIG1vdmUgdG8gdGhlIGR0LWJpbmRpbmdzLywgc28gY29ycmVjdCB0aGUgaW5j
bHVkZWQNCiAgICBoZWFkZXIgZmlsZSB0byBmaXggdGhlIGJ1aWxkIGJyZWFrLg0K

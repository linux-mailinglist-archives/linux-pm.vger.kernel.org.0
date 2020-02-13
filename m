Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0FF15BAAA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 09:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgBMITA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 03:19:00 -0500
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:3042
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMIS7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 03:18:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjpNb+N/wv/VmClIbyLxR/M7ZtPB7Qz7v47Hs6zpdhDjpTAiwLDyiAPl7CLTEA2OQvZxovUq442SBE5ObjMHjxEtpu9/lknS+9yMRKZdhGP33ASzJpFcH0hootXpg6NRhYFazqesKPeWL6m7FyYo5EeqlwjMTD1lwKcY6IG1PKMl1BXX4jShCiIlbWK9IlO81XwJmuUSr34VKzl+fQGHkhGEGA/5ubgeHBNOQts/59EF6Yhx9QW4HOUBivcJcdUNg4zn8Hvhzl6j6ceBnugjVeG33k1xMtZDRyQIegWpXpnbuCwVmBaTrtr+G8s8pZzhtrIeUR3qOffopgLfFQBK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF8rp0eyEpcuu1GnXvp/Ze9m11kHVn1miPSp7WKti1s=;
 b=PuUA+ZBVafARhUyVTi9BsdRmbaqW6JHWp9QcNFD9BrOHhjgcezgmJQ9Wdxr59+5vIJWPYKpxFuuwfvL5XpRzHpky3zReMA2DPMNJNV1HTXOeY2Vunnohchvv7v8sjmdP8P21qCrEmCPgF6t2IeYEHTivtTc7p3DZgqCwLs8pT3g5bRJZz4ZA8xdaT11rlC0SF9ZP/Ki+OpPt+d7oKLrLvAJun72glt13Hf3zVssbxTfJ14WphFEJbOnhCL3hyHNHSuENzr+zcrU8kUdKNcTx8c9XCNhLmFhcEI37deJjOLtG689ccxldoS8VIIoZ1eAm/69FNNrGZveu3DGh/sJ+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF8rp0eyEpcuu1GnXvp/Ze9m11kHVn1miPSp7WKti1s=;
 b=FUeiwnr2ZcCWKoZ9hFz7k8j1DEJHFnFT/4f634ZaUyb8/soq4LI5sau2G/C9tE32R6bpJcUIpvto+Kf8L7lDlJ8aeYZbzYg/b+ilU3oqBERM5voaMb7vOcshy8SyHcBibyi7cDCPdmbbQxY6hgkS+K0QBg438AqYdfi6MF9109k=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB3968.eurprd04.prod.outlook.com (52.134.30.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 08:18:15 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57%5]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 08:18:15 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEAAA3btAADDOJ9wAANpvoAAAOC7QAAAkWqAADlKDXAABAwMAAAokcIQ
Date:   Thu, 13 Feb 2020 08:18:15 +0000
Message-ID: <VI1PR04MB43332FB8B9FAD91160D91A0CF31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
 <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
In-Reply-To: <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [120.244.236.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: feba4ab4-88ac-41d5-5e1d-08d7b05d467d
x-ms-traffictypediagnostic: VI1PR04MB3968:
x-microsoft-antispam-prvs: <VI1PR04MB3968E18B9A31F53F2D5E22C0F31A0@VI1PR04MB3968.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(54906003)(478600001)(4326008)(2906002)(33656002)(316002)(44832011)(7696005)(81166006)(8936002)(8676002)(26005)(6506007)(53546011)(81156014)(52536014)(186003)(5660300002)(64756008)(6916009)(71200400001)(66446008)(66556008)(66476007)(76116006)(66946007)(86362001)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3968;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZmtiGKCJW7jVF/UEnAqCu4dy1WY3rR+wOTzChE1rWd71K/BWkHTg9c2Z48LjXW5NcDUuNNYzX1nOJoMPIvu/h0eiVzOAoixL3kLCGaTxlgKhn5ZtLMrRWv2s7JnGBb5U57ivtsNWjODUkj4pr4PmDOPS7IQOfM8/EMVDX/t9F0exwMDI99NutYphhXuWfkGAt08V9lv3zmJ23/gl9pDcoLO3ieoKrm3oQvEZIW7WHwNB/STCVWwZAxsNYjVIoVrFO72v4vwAL5oQu8/YT02jl+H96RoAr4EcusjH/+FimTOblF6Z1hTiP1m7cXbIdMODrUY7S3CmUzSuk6pkDhSJfr0R+9hCaO//fofCTqhBMuc0FnAxEDQ6mA5s+7226B69NJZeId+c1T4vvwCf8caS+1JgaMhE+n/ZJUERKLVlGTxy/D6N/ULDIDGiz51h4Xe
x-ms-exchange-antispam-messagedata: HCNqOadv4NIYUpXRuFHNzH+dKDjC6yZ3z83P1JpUIEgEQit8S4U9HELbihwi6vp+iH7RAUJeE1JVrl3cEwhWtaqOtTtwsBlXHbvNpFTCurET3/du5A4x46XtbBZEuhtgUfFbMDlY8TE0nhUc6YWamA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feba4ab4-88ac-41d5-5e1d-08d7b05d467d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 08:18:15.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iofvx5pBP+/2xqdKgRR7kz8Du8u0+nNZlswa6zWsHjnUgO2lP3eHRCLL0tC7IBdh29ZtGhddJtOJmSjkUwP7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3968
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVmlyZXNoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVz
aCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjDE6jLUwjEyyNUg
MTk6NTENCj4gVG86IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IENjOiByandAcmp3
eXNvY2tpLm5ldDsgbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogQXNrIGZvciBoZWxwIGFib3V0IGNwdWZyZXEgaXNzdWUNCj4gDQo+IENhdXRpb246IEVY
VCBFbWFpbA0KPiANCj4gT24gMTItMDItMjAsIDEwOjExLCBBbmR5IFRhbmcgd3JvdGU6DQo+ID4g
SGkgVmlyZXNoLA0KPiA+DQo+ID4gSSBoYXZlIGFub3RoZXIgY3B1ZnJlcSBpc3N1ZSBvbiBvdXIg
bHgyMTYwYSBwbGF0Zm9ybSB3aGljaCBoYXMgMTYgY29yZXMNCj4gYW5kIDggY2x1c3RlcnMuDQo+
ID4NCj4gPiBDcHVmcmVxIHdvcmtzIHdlbGwgZm9yIG9uZGVtYW5kLCBwZXJmb3JtYW5jZSBnb3Zl
cm5vci4NCj4gPiBCdXQgZm9yIGNvbnNlcnZhdGl2ZSBnb3Zlcm5vciwgZXZlbiB0aG91Z2ggY3B1
IHVzYWdlIGlzIGFsbW9zdCB6ZXJvLA0KPiA+IGJ1dCBzb21lIGNwdXMgYXJlIG5vdCB3b3JrIG9u
IHRoZSBsb3dlc3QgZnJlcXVlbmN5IHNvbWV0aW1lcy4gSXQga2VlcHMNCj4gPiBib3VuY2luZyBm
cm9tIHRoZSBsb3dlc3QgZnJlcXVlbmN5IHRvIHRoZSBvdGhlciBoaWdoZXIgZnJlcXVlbmNpZXMu
DQo+ID4gVGhlIGRlZmF1dCB2YWx1ZXMgYXJlIHVzZWQgZm9yIHRoZSB0dW5hYmxlIGZvciBjb25z
ZXJ2YXRpdmUgZ292ZXJub3IuDQo+ID4gSW4gc3VtbWFyeSwgd2h5IGNwdSBkb2Vzbid0IHdvcmsg
YXQgdGhlIGxvd2VzdCBmcmVxdWVuY3kgZXZlbiB0aGUgY3B1DQo+IGxvYWQgaXMgYWxtb3N0IHpl
cm8/DQo+ID4NCj4gPiByb290QGx4MjE2MGFyZGI6L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUjIGNh
dCBjcHVmcmVxL2NvbnNlcnZhdGl2ZS8NCj4gPiBkb3duX3RocmVzaG9sZCAgICAgICAgZnJlcV9z
dGVwICAgICAgICAgICAgIGlnbm9yZV9uaWNlX2xvYWQNCj4gc2FtcGxpbmdfZG93bl9mYWN0b3Ig
IHNhbXBsaW5nX3JhdGUgICAgICAgICB1cF90aHJlc2hvbGQNCj4gPiByb290QGx4MjE2MGFyZGI6
L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUjIGNhdCBjcHVmcmVxL2NvbnNlcnZhdGl2ZS8qDQo+ID4g
MjANCj4gDQo+IFRyeSBpbmNyZWFzaW5nIGRvd25fdGhyZXNob2xkIHRvIGEgdmFsdWUgb2YgNTAg
KGkuZS4gd2UgcmVkdWNlIGZyZXF1ZW5jeSBpZg0KPiB0aGUgbG9hZCBpcyBiZWxvdyA1MCUpIGFu
ZCBzZWUgaWYgaXQgbWFrZXMgYSBkaWZmZXJlbmNlLg0KSSB0cmllZCBkb3duX3RocmVzaG9sZCA9
IDUwLCBpdCBpcyBiZXR0ZXIuIEJ1dCBzb21lIGNwdXMgc3RpbGwgZG9uJ3Qgd29yayBhdCB0aGUg
bG93ZXN0IGZyZXF1ZW5jeSBzb21ldGltZXMuDQoNCj4gDQo+IEkgYmVsaWV2ZSBzb21ldGhpbmcg
aXMgcnVubmluZyBvbiB0aGUgQ1BVLCB0aGF0IHlvdSBhcmUgdW5hd2FyZSBvZi4NCj4gVHJ5IGRv
aW5nIHRyYWNpbmcgdG8gc2VlIHdoYXQncyBnb2luZyBvbiBhbGwgQ1BVcy4NCkkga2VlcCBtb25p
dG9yaW5nIGNwdSB1c2FnZSBmb3Igc2V2ZXJhbCBtaW51dGVzLCBieSB0b3AgYW5kIG1wc3RhdCB0
b29sLCBhbmQgZm91bmQNCm1vc3Qgb2YgdGhlIGNwdXMgYXJlIDEwMCUgaWRsZSwgb25jZSBpbiBh
IHdoaWxlIG9uZSBvZiB0aGUgY3B1cyBpbmNyZWFzZXMgdGhlIGxvYWQgdG8gYWJvdXQgMTglLg0K
DQpUZWNobmljYWxseSBpZiB0aGUgY3B1IHVzYWdlIGlzIG5vdCBtb3JlIHRoYW4gdXBfdGhyZXNo
b2xkKDgwKSwgY3B1IHdvbid0IGluY3JlYXNlIGl0cyBmcmVxdWVuY3kgYW5kIGtlZXANCmF0IHRo
ZSBsb3dlc3QgZnJlcXVlbmN5IHdoZW4gY3B1IGlzIGF0IHRoZSBsb3dlc3QgZnJlcXVlbmN5IGFu
ZCBjb25zZXJ2YXRpdmUgZ292ZXJub3IgaXMgdXNlZC4gDQpTbyBJIGNhbid0IHVuZGVyc3RhbmQg
d2h5IGNwdSBmcmVxdWVuY3kgaW5jcmVhc2VkPw0KDQpUaGFua3MsDQpBbmR5DQo+IA0KPiAtLQ0K
PiB2aXJlc2gNCg==

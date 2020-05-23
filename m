Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66791DF386
	for <lists+linux-pm@lfdr.de>; Sat, 23 May 2020 02:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgEWAfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 20:35:16 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:11876
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731182AbgEWAfQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 May 2020 20:35:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUofwUzwskeXFN8wJw72S3R9pJ6pQwCiSvovTCgbe79ZgjOhfnJrTtEzDk73cEOGlPAgJGQSHJq0fssiHyW+5JLmVf+eJq867ks90Ak4XEUpAgN64BRicuvPTpN40YzfeUaclxzwzyZ2VS8GYBacVx1eusRgCwIOVaXkVDgbW3uolnsE9YqVBXDbNzv6QQ/L5d13xwlZ0qbLKGXaQE9PQUVLWAwAN5c89wMkdL80yW8qWZuFUyP2mSHC6UPCOZDBMROC+JyrTZ3qd3wYS+1eDqN1cqFZcPczc5/Ga+cVQyC0gk0S1HFpa4aLaaoHohjvhUsed17YQTIT4rb8wJd1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CgbGxjv1xzEnPJeI09pmjT5z+wlxOGIjpXSrRzpDA4=;
 b=GZlYl0UaY1Fb+OlVPUTRfiLHSu28koAQe/WRweJegsYEn4IXBmFeluB3IVDgeeu9ILrYeE8BJthfXaGKae1nHKP+cH/KGjc4JxR5dWlFm2L0mxD6bBCvWAisJy+mjI93H1atd9sXtA/o2XoMEypgAxxJP2ZdTMVPpXvSyT2mgYGbvau18ap9ImygkBh3DmsILkHQKyaD9E5CcQ8Z5HMlHK+7buI1IiHuHS6u6vDD/JpIM+W3vUgiHYf3L+fjuiu6fGOiCtN8MBK6nczaDc4wgduST4abcIWP6eeeHSwE0jH6dIfqLEGfcIn2Qzjcu0Z7ariAVUAUAXEqayg8/NKuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CgbGxjv1xzEnPJeI09pmjT5z+wlxOGIjpXSrRzpDA4=;
 b=W2HyZ358P1FCdKWsfjo7PP0khyBbJcQ0OpfhY69EcTKVGfwp6Gw/V9DugLkcnxHV07OH0tbV6DRXYae/hrDkcQ08Sb3vzZliZS5sd0QPW9ojwn7FGzxsPdVbnW8qgdFZswaG2fHXZM8korlPXpUe1wQeL9X5XDIu5ospy9XYlOE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3817.eurprd04.prod.outlook.com (2603:10a6:8:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Sat, 23 May
 2020 00:35:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.034; Sat, 23 May 2020
 00:35:10 +0000
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
Thread-Index: AQHWKNOp8EPkl0qqRkG+GoQWiQOYA6i0bHgAgABvx3A=
Date:   Sat, 23 May 2020 00:35:10 +0000
Message-ID: <DB3PR0402MB3916B6D11328A036BD479D39F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
 <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
In-Reply-To: <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e3df3c7-6104-46cd-4b13-08d7feb12675
x-ms-traffictypediagnostic: DB3PR0402MB3817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38179BCC3C2832CA5FFF01DBF5B50@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0412A98A59
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJ2Fs24bII8WsdA11wTitiJX62SUUTJx1XiOHkWA68AWDEHB+BEnDKgFoKZyi7iwT2vB6BXhf8bZ0t6ynHtI81R2xMpa+qTymVDoizKvHrMzkLtyIwD4uo1UOUetdq6v5cZC0fNBIgn2CZpnSLCC4sjd2Zoj/9ZGDLTrvNdGZPuCtSLihFNsO0e46cqKQBRRFCQd1atYSSKTMxm/g4m15CR6Hld6e1kYHS7yB3pJLOo7MOIwwYarkTRE5wIeofdQFESJj7e+gPFmYfArWNM9WMZslQGtc5+EogN63/mAU8V1IzEW54UviTVA+gQGSryq0lQ8a6FtSBRmppn4bb3Ny5hNTOLIbDHHYnGP814nF7+pNALmqJa+qZkekBIzNqzNUinl7ZD8qQvtkMzEbvRvZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(478600001)(316002)(55016002)(5660300002)(44832011)(71200400001)(33656002)(64756008)(66946007)(66556008)(66476007)(52536014)(66446008)(76116006)(26005)(6506007)(8936002)(53546011)(186003)(4326008)(7696005)(2906002)(110136005)(9686003)(8676002)(7416002)(86362001)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: kPMCGqafYeMUQfvVFo0Fmt5gFHlxBpYfL3z1ZIlpWA6YGMfLvw/IToO1klpvR8rOs3jjmc0zr4Gxo/D9UO6d9c3MAhtWejVZpPCcBg0CFA/2eyLMv8zUaP9Yzt3BNSYc70RXr0XgdvFCMKE4dD35fUVQE1+IQhBSM8wISjBpfUslIC/pUrlRTIT3n5nKy3QvnTIRMIO1B5+9OZA1mfsVBAHcGY91fWBYWpkP0brj5FadjItFjVSxvonwpNNjW3lv2nH8Zd/HoMkfqzd0sczLYZ3N29Meoz4prHLyTP0qVDd+xgSJodS7y+OStWBRoVdzbHNtHxPIhFiY4oiJyAWHGky6iJzfNfjELdc9mczeNVoQ7w7WHDmLd3js476o45uuuTdrI1/BnEj7btMWkUK1rSJBKu1anjzj2l1EofOdBsne7tndVKZduELj5ABWMXP9DSvMbIFmvL8GyYOvsnocqfnkfzxvShLIRkmIJ7yZXIU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3df3c7-6104-46cd-4b13-08d7feb12675
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2020 00:35:10.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIgadSXYpzpzTu6atqeIHxB+x1Jht3wYWN0pjSRYA3frde/o0SrD40IvxH3tANhDXFsqmm++e7dWxUXz2WTkfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdGhlcm1hbDogaW14OG1tOiBB
ZGQgZ2V0X3RyZW5kIG9wcw0KPiANCj4gT24gMTMvMDUvMjAyMCAwNDo1OCwgQW5zb24gSHVhbmcg
d3JvdGU6DQo+ID4gQWRkIGdldF90cmVuZCBvcHMgZm9yIGkuTVg4TU0gdGhlcm1hbCB0byBhcHBs
eSBmYXN0IGNvb2xpbmcgbWVjaGFuaXNtLA0KPiA+IHdoZW4gdGVtcGVyYXR1cmUgZXhjZWVkcyBw
YXNzaXZlIHRyaXAgcG9pbnQsIHRoZSBoaWdoZXN0IGNvb2xpbmcNCj4gPiBhY3Rpb24gd2lsbCBi
ZSBhcHBsaWVkLCBhbmQgd2hlbiB0ZW1wZXJhdHVyZSBkcm9wcyB0byBsb3dlciB0aGFuIHRoZQ0K
PiA+IG1hcmdpbiBiZWxvdyBwYXNzaXZlIHRyaXAgcG9pbnQsIHRoZSBsb3dlc3QgY29vbGluZyBh
Y3Rpb24gd2lsbCBiZQ0KPiA+IGFwcGxpZWQuDQo+IA0KPiBZb3UgYXJlIG5vdCBkZXNjcmliaW5n
IHdoYXQgaXMgdGhlIGdvYWwgb2YgdGhpcyBjaGFuZ2UuDQoNClRoZSBnb2FsIG9mIHRoaXMgY2hh
bmdlIGlzIHRvIG1ha2Ugc3VyZSB3aGVuZXZlciB0ZW1wZXJhdHVyZSBleGNlZWRzIHBhc3NpdmUg
dHJpcCBwb2ludCwNCnRoZSBoaWdoZXN0IGNvb2xpbmcgYWN0aW9uIHdpbGwgYmUgYXBwbGllZCBp
bW1lZGlhdGVseSwgZS5nLiwgaWYgdGhlcmUgYXJlIG1hbnkgY3B1ZnJlcSBPUFAsDQp0aGUgZGVm
YXVsdCBjb29saW5nIHdpbGwgYmUgc3RlcCBieSBzdGVwLCBpdCB3aWxsIHRha2Ugc29tZSBtb3Jl
IHJvdW5kcyB0byBtYWtlIGNwdWZyZXEgZHJvcA0KdG8gbG93ZXN0IE9QUCwgd2hpbGUgb24gaS5N
WCwgd2UgZXhwZWN0IHRoZSBjcHVmcmVxIGRyb3AgdG8gbG93ZXN0IE9QUCBpbW1lZGlhdGVseS4N
Cg0KPiANCj4gSUlVQywgdGhlIHJlc3VsdGluZyBjaGFuZ2Ugd2lsbCBiZSBhbiBvbi9vZmYgYWN0
aW9uLiBUaGUgdGhlcm1hbCB6b25lIGlzDQo+IG1pdGlnYXRlZCB3aXRoIHRoZSBoaWdoZXN0IGNv
b2xpbmcgZWZmZWN0LCBzbyB0aGUgbG93ZXN0IE9QUCwgdGhlbiB0aGUNCj4gdGVtcGVyYXR1cmUg
dHJlbmQgaXMgc3RhYmxlIHVudGlsIGl0IGdvZXMgYmVsb3cgdGhlIHRyaXAgLSBtYXJnaW4gd2hl
cmUgdGhlDQo+IG1pdGlnYXRpb24gaXMgc3RvcHBlZC4NCg0KWWVzLCB5b3VyIHVuZGVyc3RhbmRp
bmcgaXMgY29ycmVjdGx5LCBvbmNlIHRoZSB0ZW1wZXJhdHVyZSBleGNlZWRzIHBhc3NpdmUgdHJp
cCBwb2ludCwNCnRoZSBoaWdoZXN0IGNvb2xpbmcgYWN0aW9uIHdpbGwgYmUgYXBwbGllZCBpbW1l
ZGlhdGVseSBhbmQgdGhlbiBpdCB3aWxsIGJlIHN0YWJsZSB0aGVyZQ0KdW50aWwgdGVtcGVyYXR1
cmUgZHJvcCB0byB0cmlwIC0gbWFyZ2luLCB0aGVuIHRoZSBjb29saW5nIGFjdGlvbiB3aWxsIGJl
IGNhbmNlbGxlZCwgdGhlDQptYXJnaW4gaXMgdG8gYXZvaWQgdGhlIGJhY2sgYW5kIGZvcnRoIG5l
YXIgdGhlIHBhc3NpdmUgdHJpcCBwb2ludC4NCg0KPiANCj4gRXhjZXB0LCBJJ20gbWlzc2luZyBz
b21ldGhpbmcsIHNldHRpbmcgYSB0cmlwIHBvaW50IHdpdGggYSAxMDAwMCBoeXN0ZXJlc2lzIGFu
ZA0KPiBhIGNvb2xpbmcgbWFwIG1pbi9tYXggc2V0IHRvIHRoZSBoaWdoZXN0IG9wcCB3aWxsIHJl
c3VsdCBvbiB0aGUgc2FtZS4NCg0KWWVzIHNldHRpbmcgY29vbGluZyBtYXAgbWluL21heCBjb29s
aW5nIHN0YXRlIHRvIGhpZ2hlc3QgT1BQIHdpbGwgbWFrZSB0aGUgaGlnaGVzdA0KY29vbGluZyBh
Y3Rpb24gYXBwbGllZCBpbW1lZGlhdGVseSwgYW5kIHRvIGhhdmUgdGhlIGZ1bmN0aW9uIG9mIGNv
b2xpbmcgYWN0aW9uIGJlaW5nDQpjYW5jZWxsZWQgd2hlbiB0ZW1wZXJhdHVyZSBkcm9wcyB0byB0
cmlwIC0gbWFyZ2luLCBJIGhhdmUgdG8gZGVmaW5lIGFub3RoZXIgdHJpcCBwb2ludCwNCnNheSBw
YXNzaXZlIHRyaXAgcG9pbnQgaXMgODUwMDAsIGFuZCBjb29saW5nIG1hcCBtaW4vbWF4IHNldCB0
byBoaWdoZXN0IE9QUCBpbiBwYXNzaXZlDQp0cmlwIHBvaW50IHRoZW4gYWRkIGFub3RoZXIgdHJp
cCBwb2ludCBuYW1lZCAiYWN0aXZlIiB3aXRoIDc1MDAwLCBhbmQgd2l0aG91dCBhbnkNCmNvb2xp
bmcgbWFwIGluIGl0LCByaWdodD8NCg0KSWYgeWVzLCB0aGVuIEkgdGhpbmsgSSBjYW4gdHJ5IHRv
IG1ha2UgdGhlIGNoYW5nZXMgaW4gRFQgaW5zdGVhZCBvZiB0aGVybWFsIGRyaXZlci4gDQoNClRo
YW5rcywNCkFuc29uDQo=

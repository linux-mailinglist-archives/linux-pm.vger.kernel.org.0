Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370811E113F
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403981AbgEYPFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 11:05:44 -0400
Received: from mail-vi1eur05on2065.outbound.protection.outlook.com ([40.107.21.65]:38062
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403999AbgEYPFn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 May 2020 11:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw2oI8vVqYkroFrLTNOByJpTPTXw9ka75Zu6yl7TeX6NwMpTuVMmgM0QwSNjUDTUTMCSBZvekRAnKyscJXkxF1S/4A3q3TWTleNAkAyVsDf8G8egeTaJsdBgEpCvQTmikzE92Ken9aVNDFhZeCnTSYjJvpS7D1n/RPRV2C+rPsNArOeRjzTtswg+KYVFQXbw52LyOBkRYy3+Pk1NOXcxsUTF7w4jYECXSOo8WjjNydRcaWIbNTK2zPT9kFlvvE64zaPmjJn9pXOm0cXpB+oAvd4gtP5UUKh3/Xsmpn1y8VdZ98lqIB2NJZPUdQGLHx912uaiwNjppm32Q2EbJq9wpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmlqqsdEPrfiX8FYkwjFbIC27l/QSxWL9ZgWk7aG2O4=;
 b=Xch9pkbcWNfLLJiyFl1ZylPm2YKJ/iJy5lEiDyNFblR77Gxp5SU1uZSDQfwJIoCCnw3aOgqvC86YxGwB04eGIFCwy8OzQKIZrmlq1O/iMgm2hfhCef9kZvawQSMT9Iav5HFX3Encvo68eXBjv2TrNYzxiSNNVtzIX7Y8uBlRk1UZmRtUanhryaWHVe/jLl1ihHa9uVftsquya7S+k9J0A0d/dvbwkteaMKvBt7wkriAhRuRiv8HJchSqhXOWQpNlaR3iZiTp9HymLVxyNGuNerphnpgsyM6WuOy+yhyj4zBhwJlpn9bXXQn0cKnxODrCNCs6optC4NuQVo105NWvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmlqqsdEPrfiX8FYkwjFbIC27l/QSxWL9ZgWk7aG2O4=;
 b=KjeVsADqHMJ+3fZbI+plpQx1awVk+d8NBmkX22HZazAMnUXG7oBHyj1KLzWSjeSGuVMmiDyiDqRLNiH7IdTgP2Jq9e5Gd2G4+TnsZnmgxUhVHNldtCZcxXmkblEV29zqeMkjdyPNQh0+hR6wCmaoZlj4vL5xk1X6t+PBKMcL1r4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3836.eurprd04.prod.outlook.com (2603:10a6:8:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 15:05:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 15:05:38 +0000
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
Thread-Index: AQHWKNOp8EPkl0qqRkG+GoQWiQOYA6i0bHgAgABvx3CAAM7gAIAAy+LwgAGwT5CAAI+kAIAAQRqA
Date:   Mon, 25 May 2020 15:05:38 +0000
Message-ID: <DB3PR0402MB391695A412B26134060D1D1BF5B30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
 <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
 <DB3PR0402MB3916B6D11328A036BD479D39F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <6a4d31e4-8a24-2e9f-aa49-bec8258ead4c@linaro.org>
 <DB3PR0402MB39167D71ED6979FC33D3747DF5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39162E6A876BA54A80B0DCE2F5B30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <dadf94db-8aa5-d1a7-5818-c56032a44ea4@linaro.org>
In-Reply-To: <dadf94db-8aa5-d1a7-5818-c56032a44ea4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41fe8431-20c7-45ce-51d0-08d800bd15a9
x-ms-traffictypediagnostic: DB3PR0402MB3836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38361B07C1F6D27EB11A5FEBF5B30@DB3PR0402MB3836.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJpWMjmsyP1McZYkupRPAqduE//Y2gnv3JXcsUnyUBLTRogFqjBJxx61ZFetwL3Nxzv+MY+bwjPQMumjUcn3lqGRgG9gorCapxWYbX9fOdViiRda5+n9RtF0XcgRi73Qz4Zvphx1Pylsobj+fkoxLOw/BVlF6ffwdFP/fLRClQeAJa3oFM6e/fr9rRwnaSJd/rS2s7ejWL0buU0IOuZ36T7HaPR0fG35zHqJaQvFm2nKUx4zGyATlFjmQC5GhuxNpfjduywSf1VchSjS/M3WNIRdXLJID2N+b9YkzkbtM3qG+jEmgQRHQQD3gFqROuVXp54ICXtWbA7f8hJLxVQbTD7/c9kiaCAMIHxs1m2MKai9L5D83op6YmOMBDe0FhSo0dsJ0ohArlxRxjWpfG9Z2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(66946007)(186003)(4326008)(478600001)(26005)(7696005)(316002)(6506007)(53546011)(66446008)(66556008)(76116006)(64756008)(71200400001)(2906002)(66476007)(8676002)(52536014)(5660300002)(33656002)(7416002)(86362001)(55016002)(8936002)(9686003)(44832011)(110136005)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QP7ctTnYcyTgcMU7PWHq8ollHnjIzSTmuQU4oEx/6ykdXgka3MdIfEK1rHq0lV/X3ATr1fNbSBaVBR2fTrdrFSEDkWX9BJcIu1ZVZZQmxl/dPzdjXxUvo3wC5xocV8jIIBUX40cduh7R6Zf61S9lSW1r6/XR33coi96KarOOAVzjakTfQ4fpsLufeVPH6PYg71Sda+kQD5WHdIOSblrHGHe/9zYhB4FohXV3WalCJcUv30ubVbxI4hPBsFfPghI/zAQG1tbPCLlZmW5B5lktmHn0OgxUvYhvtoCyLCCjEJ9OxGqJ6KerCVqigIY1DIv0pml0SOJwWqUQURqNFEf2xwv3LKIpYF3VIhQabtFw+k3VH2UBHmopQFhoJjoKNl9YPismLjbptqH6ZyI6ytJ2+tTh7fc/QZjV7YW3g9uhuaffxYh2D7rAi9WNaT8pKidlXnEGnq0lxMx5A5EhXIZ1RCC8VtDjrVw60QzC5bcs7j4Pm1wfeos2EQeZhMw7/1At
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fe8431-20c7-45ce-51d0-08d800bd15a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 15:05:38.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbKtxaUjhzWt2XMVgBfRp5v5ZpvKAltsFYT7e8bACIHXuHIXFtKLVwR3gYheynm8prAPETMp9xa42Ckb0H13DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRoZXJtYWw6IGlteDhtbTogQWRk
IGdldF90cmVuZCBvcHMNCj4gDQo+IE9uIDI1LzA1LzIwMjAgMDQ6NDYsIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+IEhpLCBEYW5pZWwNCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4gSSB0cmllZCBtb2Rp
ZnlpbmcgdGhlIG1pbi9tYXggdG8gJzInIGluIGNvb2xpbmcgbWFwLCBpdCB3b3JrcyB0aGF0DQo+
ID4gd2hlbmV2ZXIgY29vbGluZyBhY3Rpb24gaXMgbmVlZGVkLCB0aGUgbWF4IGNvb2xpbmcgYWN0
aW9uIHdpbGwgYmUNCj4gPiBhcHBsaWVkLiBCdXQgSSBhbHNvIG5vdGljZWQgc29tZSBiZWhhdmlv
cnMgd2hpY2ggTk9UIGFzIGV4cGVjdGVkOg0KPiA+DQo+ID4gMS4gdG8gZWFzeSB0aGUgdGVzdCwg
SSBlbmFibGUgdGhlICIgQ09ORklHX1RIRVJNQUxfV1JJVEFCTEVfVFJJUFMiLA0KPiA+IGFuZCBq
dXN0IG1vZGlmeSB0aGUgcGFzc2l2ZSB0cmlwIHRocmVzaG9sZCB0byB0cmlnZ2VyIHRoZSBjb29s
aW5nDQo+ID4gYWN0aW9uLCB0aGlzIGlzIG11Y2ggbW9yZSBlYXN5IHRoZW4gcHV0dGluZyB0aGUg
Ym9hcmQgaW50byBhbiBvdmVuIHRvDQo+ID4gaW5jcmVhc2UgdGhlIFNvQyB0ZW1wZXJhdHVyZSBv
ciBydW5uaW5nIG1hbnkgaGlnaCBsb2FkaW5nIHRlc3QgdG8NCj4gPiBpbmNyZWFzZSB0aGUgdGVt
cGVyYXR1cmUsIGJ1dCB3aGVuIEkgbW9kaWZ5IHRoZSBwYXNzaXZlIHRyaXAgdGhyZXNob2xkDQo+
ID4gdG8gYmUgbG93ZXIgdGhhbiBjdXJyZW50IHRlbXBlcmF0dXJlLCB0aGUgY29vbGluZyBhY3Rp
b24gaXMgTk9UDQo+ID4gdHJpZ2dlcmVkIGltbWVkaWF0ZWx5LCBpdCBpcyBiZWNhdXNlIHRoZSBk
ZWZhdWx0IHN0ZXBfd2lzZSBnb3Zlcm5vcg0KPiA+IHdpbGwgTk9UIHRyaWdnZXIgdGhlIGNvb2xp
bmcgYWN0aW9uIHdoZW4gdGhlIHRyZW5kIGlzDQo+ID4gVEhFUk1BTF9UUkVORF9TVEFCTEUuIEJ1
dCB3aGF0IGV4cGVjdGVkIGlzLCB3aGVuIHRoZSB0ZW1wZXJhdHVyZSBpcw0KPiA+IGV4Y2VlZCB0
aGUgcGFzc2l2ZSB0cmlwIHRocmVzaG9sZCwgdGhlIGNvb2xpbmcgYWN0aW9uIGNhbiBiZSB0cmln
Z2VyZWQNCj4gPiBpbW1lZGlhdGVseSBubyBtYXR0ZXIgdGhlIHRyZW5kIGlzIHN0YWJsZSBvciBy
YWlzaW5nLg0KPiANCj4gWW91IGFyZSByaWdodCwgd2hhdCBpcyBleHBlY3RlZCBpcywgd2hlbiB0
aGUgdGVtcGVyYXR1cmUgZXhjZWVkcyB0aGUgcGFzc2l2ZQ0KPiB0cmlwIHRocmVzaG9sZCwgYSBj
b29saW5nIGFjdGlvbiBoYXBwZW5zLCB0aGUgdHJlbmQgaXMgcmFpc2luZyBpbiB0aGlzIGNhc2Uu
DQo+IA0KPiBCdXQgaW4geW91ciB0ZXN0LCBpdCBpcyBub3Qgd2hhdCBpcyBoYXBwZW5pbmc6IHRo
ZSB0cmlwIHBvaW50IGlzIGNoYW5naW5nLCBub3QgdGhlDQo+IHRlbXBlcmF0dXJlLg0KPiANCj4g
UHJvYmFibHksIHRoZSBjcHVmcmVxIGRyaXZlciBpcyBhdCBpdHMgbG93ZXN0IE9QUCwgc28gdGhl
cmUgaXMgbm8gcm9vbSBmb3IgbW9yZQ0KPiBjb29saW5nIGVmZmVjdCB3aGVuIGNoYW5naW5nIHRo
ZSB0cmlwIHBvaW50Lg0KPiANCj4gSU1PLCB0aGUgdGVzdCBpcyBub3QgcmlnaHQgYXMgdGhlIHRy
aXAgcG9pbnQgaXMgZGVjcmVhc2VkIHRvIGEgdGVtcGVyYXR1cmUgd2hlcmUNCj4gYWN0dWFsbHkg
dGhlIFNvQyBpcyBub3QgaG90Lg0KPiANCj4gSWYgeW91IHdhbnQgdG8gdGVzdCBpdCBlYXNpbHks
IEkgcmVjb21tZW5kIHRvIHVzZSBkaHJ5c3RvbmUsIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gIGRo
cnlzdG9uZSAtdCA2IC1sIDEwMDAwDQo+IA0KPiBUaGF0IHdpbGwgbWFrZSB5b3VyIGJvYXJkIHRv
IGhlYXQgaW1tZWRpYXRlbHkuDQoNClRoYW5rcywgSSB1bmRlcnN0YW5kLiBUbyBhbGlnbmVkIHdp
dGggdGhlIGZvcm1hbCB0ZXN0IG1ldGhvZCwgSSB3aWxsIGluZm9ybSBvdXIgdGVzdA0KdGVhbSB0
byB1cGRhdGUgdGhlIHRlc3QgY2FzZSB0byBtZWV0IHRoZSByZXF1aXJlbWVudC4NCg0KPiANCj4g
PiBUaGF0DQo+ID4gbWVhbnMgd2UgaGF2ZSB0byBpbXBsZW1lbnQgb3VyIG93biAuZ2V0X3RyZW5k
IGNhbGxiYWNrPw0KPiANCj4gRnJvbSBteSBQT1YgaXQgbXVzdCBkaXNhcHBlYXIsIGJlY2F1c2Ug
aXQgaGFzIGxpdHRsZSBtZWFuaW5nLiBUaGUgZ292ZXJub3IgaXMNCj4gdGhlIG9uZSB3aGljaCBz
aG91bGQgYmUgZGVhbGluZyB3aXRoIHRoYXQgYW5kIGNhbGwgdGhlIGNvcnJlc3BvbmRpbmcgY29v
bGluZw0KPiBpbmRleC4NCg0KT0ssIEkgd2lsbCB1c2UgY29tbW9uIC5nZXRfdHJlbmQoKSBpbXBs
ZW1lbnRhdGlvbi4NCg0KPiANCj4gPiAyLiBObyBtYXJnaW4gZm9yIHJlbGVhc2luZyB0aGUgY29v
bGluZyBhY3Rpb24sIGZvciBleGFtcGxlLCBpZiBjb29saW5nDQo+ID4gYWN0aW9uIGlzIHRyaWdn
ZXJlZCwgd2hlbiB0aGUgdGVtcGVyYXR1cmUgZHJvcHMgYmVsb3cgdGhlIHBhc3NpdmUgdHJpcA0K
PiA+IHRocmVzaG9sZCwgdGhlIGNvb2xpbmcgYWN0aW9uIHdpbGwgYmUgY2FuY2VsbGVkIGltbWVk
aWF0ZWx5LCBpZiBTb0MNCj4gPiBrZWVwcyBydW5uaW5nIGF0IGZ1bGwgcGVyZm9ybWFuY2UsIHRo
ZSB0ZW1wZXJhdHVyZSB3aWxsIGluY3JlYXNlIHZlcnkNCj4gPiBzb29uLCB3aGljaCBtYXkgY2F1
c2UgdGhlIFNvQyBrZWVwIHRyaWdnZXJpbmcvY2FuY2VsbGluZyB0aGUgY29vbGluZw0KPiA+IGFj
dGlvbiBhcm91bmQgdGhlIHBhc3NpdmUgdHJpcCB0aHJlc2hvbGQuIElmIHRoZXJlIGlzIGEgbWFy
Z2luLCB0aGUNCj4gPiBzaXR1YXRpb24gd2lsbCBiZSBtdWNoIGJldHRlci4NCj4gPg0KPiA+IERv
IHlvdSBoYXZlIGFueSBpZGVhL2NvbW1lbnQgYWJvdXQgdGhlbT8NCj4gDQo+IFllcywgdGhhdCBp
cyBhIGdvb2QgcG9pbnQuIFRoZSBoeXN0ZXJlc2lzIGlzIHN1cHBvc2VkIHRvIGRvIHRoYXQuIFRo
ZXJlIGlzIGEgd29yaw0KPiBkb25lIGJ5IEFuZHJ6ZWogUGlldHJhc2lld2ljeiB0byBkaXNhYmxl
IC8gZW5hYmxlIHRoZSB0aGVybWFsIHpvbmVzIFsxXS4gSSB0aGluaw0KPiB3ZSBzaG91bGQgYmUg
YWJsZSB0byBmaXggdGhhdCBhZnRlciB0aGUgY2hhbmdlcyBhcmUgZG9uZS4NCg0KT0ssIHRoZW4g
SSB3aWxsIHdhaXQgZm9yIHRoaXMgY2hhbmdlLiBTbyB0byBhcHBseSBNQVggY29vbGluZyBhY3Rp
b24gaW1tZWRpYXRlbHksDQphbGwgZXhwZWN0ZWQgY2hhbmdlcyBmb3IgaS5NWCBwbGF0Zm9ybXMg
YXJlIHRvIGFzc2lnbiBtaW4vbWF4IGNvb2xpbmcgaW5kZXggaW4NCkRUIGNvb2xpbmcgbWFwLCBJ
IHdpbGwgc3VtbWl0IGEgcGF0Y2ggc2V0IHRoZW4uDQoNClRoYW5rcywNCkFuc29uLg0K

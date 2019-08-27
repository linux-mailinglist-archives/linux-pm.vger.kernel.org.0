Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40C9DB5C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 03:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfH0Bv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 21:51:27 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:50277
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfH0Bv0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 21:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjWP7zZkrDS6iYPE7ncOfoB61LbUzKD85Nv7HEsplBf4Flc4K0F89YKpr+UO6ZFFsXKKOQHoxuxvRLJei/1rvejFbztS1B60SmM8QMW3CNDydg7JzGMTdrSjjKyjbAYxi6/ux8qo3qDSme0se/T1clqHiFQTVRnEDFDaMTARpXXawl6hbH0PHtskcqZvd4VlEv+Cf4R0wZI+qXj9MJFHNrXg1Q2tDGa/MJ4/y6mJhWRfQhkLaIHLAfluJyMok1sThdm3fRDFTE3tOXEdTy0Gq6TdOIkYKIGtHtcfBTmonOO8427hStAwxSUIS/lWMkaT4b8KuKi44UDGmmN1zQjnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04kpSK0OjLxD75A8OFUUoZ1dPnRiJi30AynNX349/YU=;
 b=nuIwxYCNwhI2y+luVk9IWdymb7KvepiV9NyNr6G+uAFuYQWPwYXZ/2Kow8v96Rannx/y3/fQVwBpU+j1Y0xF5DAZBGBkEidfM3KgpDRTzOgV2zV5fOw74Psg/5xJhPVjqU2Ov2g7dSOwgHBiIjg2oCWUjCbCGGh/qmfgYAKpKmeSBGznYP+KWRgggWyWg/yRG4HxsGNqWFR1bQ+qCsRh2w8RmoxF2oJS0gkeqhu3YXEDluQ10aVexFIXgQacVkzoKYdBAXh7yeaRChn4bQ20jrt5lH6aYiKka0axjWFNwXQ1P3SVfQfeXq+zmpE0moVtKB3EwB7x0M/GeUAs+I5b7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04kpSK0OjLxD75A8OFUUoZ1dPnRiJi30AynNX349/YU=;
 b=LjulPGvEN07kzCI9roCVlEkDXrKnha7tLQ2FSyvlTYM7njZ+VDI6hgzeDaHx0fSurfowJlNbx2dCbMWiID3zGuAzpUGJiWEJO7jKp2pa+RFlg7I4i4laYVRHDqWVDqjIMGWK3E3hTrp9vMcF7KcVhGuTxD2Mf3NJoBkUNGEY8Z0=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3894.eurprd04.prod.outlook.com (52.133.8.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 01:51:20 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c9d3:4e41:12b7:892]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c9d3:4e41:12b7:892%5]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 01:51:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Index: AQHVRn7U0xGc5nAWcEuPNmwDSS0IiacOZc9g
Date:   Tue, 27 Aug 2019 01:51:20 +0000
Message-ID: <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
 <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a8ee726-5a46-4b65-4006-08d72a910eed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3894;
x-ms-traffictypediagnostic: AM6PR0402MB3894:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB389462E7CF145C846171B4F1F5A00@AM6PR0402MB3894.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(446003)(305945005)(4326008)(256004)(66476007)(2906002)(25786009)(8936002)(14444005)(229853002)(33656002)(316002)(110136005)(9686003)(53936002)(74316002)(6246003)(7416002)(54906003)(71190400001)(71200400001)(6436002)(7696005)(55016002)(76176011)(6506007)(53546011)(102836004)(26005)(66574012)(186003)(478600001)(66066001)(5660300002)(3846002)(86362001)(6116002)(486006)(76116006)(44832011)(14454004)(8676002)(7736002)(66556008)(64756008)(11346002)(66446008)(81156014)(81166006)(476003)(66946007)(99286004)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3894;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RWJJNfUHL5JyuaUrNyghSSaJKQNH0b+1m7sDBjZ/7p7hfigLSotdP4MOWyTMbBqHGl9ijXxuTeq9Gk0Wnb7DmoWJrgCBbMWAJRLf1Emzp9qLq6517VFiIuDIMgTuV1rlRnYIiUF5ZN0nOeOdtHrXJaJuEISEsumimE+YNN8VN+YBzqYPoib2/gzdbEpOaF5b3hoHIO/dNM4FABiTrv0KXXjg0rHzZ37dvfTZduKzqFrgr18iXyS8yx+6E/m8EyLiiEPBdHiU2Bno43g/KWQ+uP1UPiIIGgBT1rTgCiKJJJKuIvlfip/VXqiQg7jcPHwsDhhZXGulMFhR++xMI4DnUOl/Fy2oVXs9Htb26vmKklVA0crtjztIZg9k9ZuKZ75yOEWwfXMI6YFvokv33owflL671FQrJSe4tn7p3P0l7dA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8ee726-5a46-4b65-4006-08d72a910eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 01:51:20.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ksd2GJ3EzniwHaJ7u5Pnmy/Ic5wKmUf1XDKZlKD5aqqCvhE4Yvh1g/LhyKQuAMwNZaHL2KcSi3ImQe6rT1ZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3894
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gT24gNy8zMC8yMDE5IDU6MzEgQU0sIEFuc29uLkh1YW5nQG54cC5jb20gd3JvdGU6DQo+
ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4NCj4gPiBTb21l
IHBsYXRmb3JtcyBsaWtlIGkuTVg4TVEgaGFzIGNsb2NrIGNvbnRyb2wgZm9yIHRoaXMgbW9kdWxl
LCBuZWVkIHRvDQo+ID4gYWRkIGNsb2NrIG9wZXJhdGlvbnMgdG8gbWFrZSBzdXJlIHRoZSBkcml2
ZXIgaXMgd29ya2luZyBwcm9wZXJseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBHdWlkbyBHw7xudGhl
ciA8YWd4QHNpZ3hjcHUub3JnPg0KPiANCj4gVGhpcyBzZXJpZXMgbG9va3MgZ29vZCwgZG8geW91
IHRoaW5rIGl0IGNhbiBiZSBtZXJnZWQgaW4gdGltZSBmb3IgdjUuND8NCj4gVG9kYXkgd2FzIHY1
LjMtcmM2Lg0KDQpJZiB0aGUgcXVlc3Rpb24gaXMgZm9yIG1lLCB0aGVuIEkgYW0gTk9UIHN1cmUs
IHRoZSB0aGVybWFsIHBhdGNoZXMgYXJlIHBlbmRpbmcNCnRoZXJlIGZvciBhbG1vc3QgaGFsZiB5
ZWFyIGFuZCBJIGRpZCBOT1QgcmVjZWl2ZSBhbnkgcmVzcG9uc2UsIGxvb2tzIGxpa2Ugbm8gb25l
DQppcyBtYWludGFpbmluZyB0aGUgdGhlcm1hbCBzdWItc3lzdGVtPw0KDQo+IA0KPiBJbiBhbiBl
YXJsaWVyIHNlcmllcyB0aGUgQ0xLX0lTX0NSSVRJQ0FMIGZsYWdzIHdhcyByZW1vdmVkIGZyb20g
dGhlIFRNVQ0KPiBjbG9jayBzbyBpZiB0aGUgdGhlcm1hbCBkcml2ZXIgZG9lc24ndCBleHBsaWNp
dGx5IGVuYWJsZSBpdCB0aGUgc3lzdGVtIHdpbGwgaGFuZw0KPiBvbiBwcm9iZS4gVGhpcyBpcyB3
aGF0IGhhcHBlbnMgaW4gbGludXgtbmV4dCByaWdodCBub3chDQoNClRoZSB0aGVybWFsIGRyaXZl
ciBzaG91bGQgYmUgYnVpbHQgd2l0aCBtb2R1bGUsIHNvIGRlZmF1bHQga2VybmVsIHNob3VsZCBj
YW4gYm9vdA0KdXAsIGRvIHlvdSBtb2RpZnkgdGhlIHRoZXJtYWwgZHJpdmVyIGFzIGJ1aWx0LWlu
Pw0KDQo+IA0KPiBVbmxlc3MgdGhpcyBwYXRjaGVzIGlzIG1lcmdlZCBzb29uIHdlJ2xsIGVuZCB1
cCB3aXRoIGEgNS40LXJjMSB0aGF0IGRvZXNuJ3QNCj4gYm9vdCBvbiBpbXg4bXEuIEFuIGVhc3kg
Zml4IHdvdWxkIGJlIHRvIGRyb3AvcmV2ZXJ0IGNvbW1pdA0KPiA5NTFjMWFlZjk2OTEgKCJjbGs6
IGlteDhtcTogUmVtb3ZlIENMS19JU19DUklUSUNBTCBmbGFnIGZvcg0KPiBJTVg4TVFfQ0xLX1RN
VV9ST09UIikgdW50aWwgdGhlIHRoZXJtYWwgcGF0Y2hlcyBhcmUgYWNjZXB0ZWQuDQoNCklmIHRo
ZSB0aGVybWFsIGRyaXZlciBpcyBidWlsdCBhcyBtb2R1bGUsIEkgdGhpbmsgbm8gbmVlZCB0byBy
ZXZlcnQgdGhlIGNvbW1pdCwgYnV0DQppZiBieSBkZWZhdWx0IHRoZXJtYWwgZHJpdmVyIGlzIGJ1
aWx0LWluIG9yIG1vZCBwcm9iZWQsIHRoZW4geWVzLCBpdCBzaG91bGQgTk9UIGJyZWFrDQprZXJu
ZWwgYm9vdCB1cC4NCg0KQW5zb24uDQoNCj4gDQo+IE1lcmdpbmcgcGF0Y2hlcyBvdXQtb2Ytb3Jk
ZXIgd2hlbiB0aGV5IGhhdmUgaGFyZCAoYm9vdC1icmVha2luZykNCj4gZGVwZW5kZW5jaWVzIGFs
c28gYnJlYWtzIGJpc2VjdC4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IExlb25hcmQNCg==

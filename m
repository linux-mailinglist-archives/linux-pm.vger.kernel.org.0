Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B39150C
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 08:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHRGUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 02:20:02 -0400
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:32462
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfHRGUC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Aug 2019 02:20:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNBkBlGduWc+yqexTu5BXEnCTAP8KktfWGRl7EzWZNcdV83PqekdLaw+G5iTbtE8KLOAJPWdzkADD0P/qtJydmI1VOyv5rieAyWdfVyCZmcdIxh0e1O5kS5qt+t123CszQ+Tmhuq24eDKKbP+OldHFGnw2julWoeRpz/IskjPY6y86uhlg+c+ohyFX1HqtLQxEppSjrIcTYsIBjJaMREzGOIOYzh12eJ8Dy8i5cMtmwBVgSX63rFcY07sh4zUhIeT4V1DEHX2sjH2BHlKWN2STGrAMmbEvILQfPmeKRgiTIn5aTdxRp/HfCnQxTyEwW9IKEWamttkKfAfBn4NKMRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrdefZeLSSCjJ5v6ejDuYQueRtbu9YhTZjC1uV7NtzU=;
 b=O3YAvqe4CWpYGDfyRQ3TlnttjJTCeKLtvTVahoTbNmR69q37Nx271jGq73Mtm6Ns7kZf5CL7WKZstQITCzQ6/NSC1IGq5c7UbV9UmM/Wv9jQo+XatnT0EiaS42wllHGL+vVPSqomCYxEP0mMdjxLrRJ/V1GRyIblFqBcJ5bT6GoadFCz6RadnjvBtEYUM3+6nZgnbXTejBwBu+XY341iaxTHgk7j5yzqGSx9M0LFkfygyBKalEVyVk7TfFn6et001KHGhjormRgF33DaLlyDt23fxf68u6iYfJ725g6CZLDZCYCMcQKDYPFlUQYQ/UlpS+jKwyOeDOW+QNWl4uhR/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrdefZeLSSCjJ5v6ejDuYQueRtbu9YhTZjC1uV7NtzU=;
 b=LZerwB4Kj2h/iGnpN62vivsVyVSP9Dyj+zXrj7tOD/I8C4V9KGhSZI4L2PLKvFzn6RgBvuX+sEL8WdRp5fDDR3155zaEkedyEyrtnxtHzZKvqGSh2BCB5stpFgGMZZ344O0X56YcDWobE1UkkqTCSp38f3OE4qwnMvrsnUxU1fw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sun, 18 Aug 2019 06:19:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2178.018; Sun, 18 Aug 2019
 06:19:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 5/6] clk: imx8mn: Add necessary frequency support for ARM
 PLL table
Thread-Topic: [PATCH 5/6] clk: imx8mn: Add necessary frequency support for ARM
 PLL table
Thread-Index: AQHVU1smspIlsoJa7UagSycBskV9A6b+t5+AgAE1uXCAAC+xgIAAVbXw
Date:   Sun, 18 Aug 2019 06:19:14 +0000
Message-ID: <DB3PR0402MB3916710B3613D6C08A68438BF5A90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1565866783-19672-1-git-send-email-Anson.Huang@nxp.com>
 <1565866783-19672-5-git-send-email-Anson.Huang@nxp.com>
 <20190817035220.268F32173B@mail.kernel.org>
 <DB3PR0402MB3916D320EB51B2D9E28D55E1F5AE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190818011133.CE6F52173B@mail.kernel.org>
In-Reply-To: <20190818011133.CE6F52173B@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65473061-7e63-4afb-8f02-08d723a3fe45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3931;
x-ms-traffictypediagnostic: DB3PR0402MB3931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3931856C43F375B6D4B52526F5A90@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 01334458E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(66946007)(64756008)(99286004)(66476007)(66446008)(74316002)(66556008)(71190400001)(71200400001)(76116006)(305945005)(52536014)(229853002)(6436002)(4326008)(7736002)(7696005)(76176011)(33656002)(8936002)(81166006)(7416002)(8676002)(81156014)(2906002)(25786009)(6246003)(256004)(5660300002)(6636002)(110136005)(53936002)(9686003)(316002)(3846002)(11346002)(2501003)(26005)(486006)(44832011)(102836004)(66066001)(446003)(6506007)(2201001)(478600001)(186003)(86362001)(55016002)(14454004)(6116002)(476003)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tPLY4+nxi1Uv3yaPxiDpAtdrX6QNp9iM29EL4mjX84lLK8XCHqbNpDVi6vmKK9l15wykat+zuKdZO66hLnwgbiR+wYzxcEqeXbQDtUPOGQChGA7u63ZBS3Oa5k4LDk+cpeAgVl2TsEfoCkzHdDx1gqqo5sDVYwB8BesWEz5h5HPXgtYTk6dHw1UUpDSg11+mRvCgNA0wjM0L3tvEcUm7NxRlnig+sbLTLKDv7xvNn267Y/8VAh1NuPyTtmYTOL/YOmeA0u1zmFisxZhfDbv571ThZgRts3FvE05djuphScUrZ2VWi0sRToooUl6opyDeN4FRppu4YL8bAkfGPV5GktZby1IArKWpFbW/P83TsKmrL8ZKBHitK15HWiPkZoVT24LPtUXQZM1S/0Bwewz97re8t9Pu3Sz1MO1Rec+o46M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65473061-7e63-4afb-8f02-08d723a3fe45
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2019 06:19:14.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIUWUOhytTMGNC5Ru5tvgwV5OKTeZoY/omHRBQa+Bwtp4u9sDGkBgrkcnqMXSFX8nL0b5B4shsVPFyAPpClLOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3931
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiBRdW90aW5nIEFuc29uIEh1YW5nICgyMDE5LTA4LTE3IDE1OjIyOjAx
KQ0KPiA+IEhpLCBTdGVwaGVuDQo+ID4NCj4gPiA+IFF1b3RpbmcgQW5zb24uSHVhbmdAbnhwLmNv
bSAoMjAxOS0wOC0xNSAwMzo1OTo0MikNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L2lteC9jbGstaW14OG1uLmMNCj4gPiA+ID4gYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbi5j
IGluZGV4IGVjZDEwNjIuLjNmMTIzOWEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY2xr
L2lteC9jbGstaW14OG1uLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4
bW4uYw0KPiA+ID4gPiBAQCAtODIsNiArODQsNyBAQCBzdGF0aWMgc3RydWN0IGlteF9wbGwxNHh4
X2NsayBpbXg4bW5fZHJhbV9wbGwgPQ0KPiA+ID4gPiB7IHN0YXRpYyBzdHJ1Y3QgaW14X3BsbDE0
eHhfY2xrIGlteDhtbl9hcm1fcGxsID0gew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgLnR5cGUg
PSBQTExfMTQxNlgsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAucmF0ZV90YWJsZSA9IGlteDht
bl9wbGwxNDE2eF90YmwsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAucmF0ZV9jb3VudCA9IEFS
UkFZX1NJWkUoaW14OG1uX3BsbDE0MTZ4X3RibCksDQo+ID4gPg0KPiA+ID4gV2h5IGlzIHJhdGVf
Y291bnQgYWRkZWQ/IFRoYXQncyBub3QgZGVzY3JpYmVkIGluIHRoZSBjb21taXQgdGV4dC4NCj4g
Pg0KPiA+IHJhdGVfY291bnQgaXMgbmVjZXNzYXJ5IGZvciB0YWJsZSBzZWFyY2ggZHVyaW5nIHNl
dF9yYXRlLCBpdCB3YXMNCj4gPiBtaXNzZWQgcHJldmlvdXNseSwgSSB3aWxsIGFkZCBpdCBpbnRv
IGNvbW1pdCB0ZXh0IGluIFYyLg0KPiA+DQo+IA0KPiBSaWdodCwgaXNuJ3QgdGhhdCBhIG1vcmUg
Y3JpdGljYWwgZml4IHRvIG1ha2UgYnkgaXRzZWxmIGluc3RlYWQgb2Ygcm9sbGluZyBpbnRvIHRo
aXMNCj4gY2hhbmdlIHRoYXQgYWRkcyBhIGZldyBtb3JlIGZyZXF1ZW5jaWVzPw0KDQpSaWdodCwg
bGV0IG1lIHNwbGl0IHRoaXMgcGF0Y2ggaW50byB0d28gcGF0Y2hlcyBhbmQgcmVzZW5kIHRoZSBW
Mi4NCg0KVGhhbmtzLA0KQW5zb24uDQoNCg0K

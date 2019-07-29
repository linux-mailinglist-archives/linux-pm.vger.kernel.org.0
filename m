Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC26178313
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 03:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfG2B3I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jul 2019 21:29:08 -0400
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:58245
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbfG2B3I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Jul 2019 21:29:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHFMibwAUuGNekD09lRpBH4Pc4OYOBIH/2oVIqNICwANRVKAD4m1EBlUhozFNMaU9DmPcGqa7TCVEv0zdunPSbKmXJIy+abyBTB545UEN7IpNe1ApL9tMA3BKFAR+zyonvBW4ZDIFG9fHLi7g/PvwCkAVppf19vupryboeW2lxgJAcfffhl3Q8w1cjvTirEl8f3BdexBvkvEVV2afowTO4iBsLNL0iqmKl7aOwhdMaYQvpW2d56GLAU3J0xxgff/k8lLYoXhkEq4Gv+G+pMske9lqR+ANy6LbXWwmOUXNh+JpBi1URMRpHdywsD+XBBM+XhlVgKY/Dp2GxD92cqHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siBQZXsmuGvkSgajytb1Vyk62omVCYC4RCjLgKCwOPw=;
 b=dvRi9NHyymrMhSk4WM1dm8rwMHSMpSIJYSloqytGXAYdcv/u8vueis/MJcgY7c9OeztKgCFMzlHiRzH8Dl/+eePbGsn/ukQ7UKIQmavwG2VTsVFGwOk0wCheULCQd6rdTQOhd26IRz3fcPb9fre1hAw2nV9frZYoKBSkEmQbPiXbnO4fJ1dlfWVGM8+szUMNOzajGngC/TKi49XjCT2TZyZcAidrV29TEEAKb0NLzHHSdQ9G7lvrqUHo2KER6f1zLR7rHy0/1SjPMnNhQn+mui9Yfr1uZ1lH+Rk87WkmyVGJ+vxLNvK8FT82wXLvwozSJG9sAoDd/KgKuEttX3gJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siBQZXsmuGvkSgajytb1Vyk62omVCYC4RCjLgKCwOPw=;
 b=SRaW+TzC12iyZBArxAWvKlRuoscJS/pPpCMM8TTRg2RBDqct7nhnqXdoX5V3gFN7SAKxq5h0Y1goV1dT6IwJuzz8qnyRbW2+MbnLjF5zfz8oZ+266BgUNsxoszL/uXIK8sszwjgw6WotAlum0EVHoFKQFgMfLkBcQZt8wDRJnvE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3948.eurprd04.prod.outlook.com (52.134.70.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Mon, 29 Jul 2019 01:29:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 01:29:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@gmail.com>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Thread-Topic: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Thread-Index: AQHVMu9Qagn4ZAj9sUKncGzfKuws0abdnJEAgAB74HCAAAwBAIAAo0oAgAIrlTA=
Date:   Mon, 29 Jul 2019 01:29:01 +0000
Message-ID: <DB3PR0402MB391600891BA75DFFA9674058F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZCrZybzcy__u4p_Eq4zSVc2ESyfKLk5sPf1JYba1JSOiA@mail.gmail.com>
 <20190727161736.4dkfqgwftre67v56@fsr-ub1664-175>
In-Reply-To: <20190727161736.4dkfqgwftre67v56@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58b357b5-ac00-415f-75a4-08d713c42339
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3948;
x-ms-traffictypediagnostic: DB3PR0402MB3948:
x-microsoft-antispam-prvs: <DB3PR0402MB3948C2542603E948C57DA9B5F5DD0@DB3PR0402MB3948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(53754006)(86362001)(44832011)(71200400001)(476003)(3846002)(486006)(14454004)(33656002)(71190400001)(6116002)(7416002)(76116006)(66946007)(66476007)(256004)(66556008)(64756008)(66446008)(52536014)(6246003)(7736002)(74316002)(81166006)(81156014)(66066001)(5660300002)(99286004)(25786009)(229853002)(53546011)(102836004)(7696005)(316002)(2906002)(110136005)(54906003)(55016002)(11346002)(446003)(68736007)(478600001)(76176011)(6506007)(186003)(26005)(8936002)(8676002)(53936002)(6436002)(9686003)(305945005)(4326008)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3948;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1wy8ZQeEqTgq4qTbmtpZZhz4WVB7N9hBMF0sZBqQgTacUpueIBn3VbcQDOBLkXGjZL4fHER+AyqomxpCvZc4FHROXb9CQ4O71B0+hWhdgIDtMURFbjt5ELHRGCyB/vMJCUdwNeLvUWuSurqep36CU4DaGQzZ80XF/ZrOl4LzneQ0AiLoReHsDmXILLZX93Y4Ru0aKbQhet8hDKF2Wf3PwIJyI9GccT0pZZ89h/NNG5DTVXdWAy/Z/XSm0HxjESx9+G2BB9aPcjQj/s5wX5gTbJoZ45JZmqYONCu+MNkzsL2i5wICzSAChV3nF9SwZcgg8t2atSc4Am6bBZeyMZfgZCRNhloXG8qPVTCPEybj+o7lxLROvzS0s9mo+5xG+qoaKtxqtb5ZrDflulefM5e2Zhus4ZtaXxwWb1xhihBNjVw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b357b5-ac00-415f-75a4-08d713c42339
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 01:29:01.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFiZWwvRGFuaWVsDQoNCj4gT24gMTktMDctMjcgMDk6MzM6MTAsIERhbmllbCBCYWx1dGEg
d3JvdGU6DQo+ID4gT24gU2F0LCBKdWwgMjcsIDIwMTkgYXQgOToxOSBBTSBBbnNvbiBIdWFuZyA8
YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGksIERhbmllbA0K
PiA+ID4NCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzZdIGNsazogaW14OG1xOiBSZW1v
dmUgQ0xLX0lTX0NSSVRJQ0FMIGZsYWcNCj4gPiA+ID4gZm9yIElNWDhNUV9DTEtfVE1VX1JPT1QN
Cj4gPiA+ID4NCj4gPiA+ID4gSGkgYWxsLA0KPiA+ID4gPg0KPiA+ID4gPiBsYXRlc3QgbGludXgt
bmV4dCBoYW5ncyBhdCBib290Lg0KPiA+ID4gPg0KPiA+ID4gPiBjb21taXQgZmRlNTBiOTZiZTgy
MWFjOTY3M2E3ZTAwODQ3Y2M0NjA1YmQ4OGYzNCAoSEVBRCAtPg0KPiBtYXN0ZXIsIHRhZzoNCj4g
PiA+ID4gbmV4dC0yMDE5MDcyNiwgb3JpZ2luL21hc3Rlciwgb3JpZ2luL0hFQUQpDQo+ID4gPiA+
IEF1dGhvcjogU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQo+ID4gPiA+
IERhdGU6ICAgRnJpIEp1bCAyNiAxNToxODowMiAyMDE5ICsxMDAwDQo+ID4gPiA+DQo+ID4gPiA+
ICAgICBBZGQgbGludXgtbmV4dCBzcGVjaWZpYyBmaWxlcyBmb3IgMjAxOTA3MjYNCj4gPiA+ID4N
Cj4gPiA+ID4gICAgIFNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1
dWcub3JnLmF1Pg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBJIGtub3cgdGhpcyBpcyBjcmF6
eSBidXQgcmV2ZXJ0aW5nIGNvbW1pdDoNCj4gPiA+ID4NCj4gPiA+ID4gY29tbWl0IDQzMWJkZDFk
ZjQ4ZWUyODk2ZWE5OTgwZDkxNTNlM2FlYWYwYzgxZWYNCj4gKHJlZnMvYmlzZWN0L2JhZCkNCj4g
PiA+ID4gQXV0aG9yOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4g
RGF0ZTogICBGcmkgSnVsIDUgMTI6NTY6MTEgMjAxOSArMDgwMA0KPiA+ID4gPg0KPiA+ID4gPiAg
ICAgY2xrOiBpbXg4bXE6IFJlbW92ZSBDTEtfSVNfQ1JJVElDQUwgZmxhZyBmb3INCj4gPiA+ID4g
SU1YOE1RX0NMS19UTVVfUk9PVA0KPiA+ID4gPg0KPiA+ID4gPiAgICAgSU1YOE1RX0NMS19UTVVf
Uk9PVCBpcyBPTkxZIHVzZWQgZm9yIHRoZXJtYWwgbW9kdWxlLCB0aGUNCj4gZHJpdmVyDQo+ID4g
PiA+ICAgICBzaG91bGQgbWFuYWdlIHRoaXMgY2xvY2ssIHNvIG5vIG5lZWQgdG8gaGF2ZSBDTEtf
SVNfQ1JJVElDQUwgZmxhZw0KPiA+ID4gPiAgICAgc2V0Lg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+
ID4gPg0KPiA+ID4gPiBtYWtlcyB0aGUgYm9vdCB3b3JrIGFnYWluLg0KPiA+ID4gPg0KPiA+ID4g
PiBBbnkgaWRlYT8NCj4gPiA+DQo+ID4gPiBJIGp1c3QgZm91bmQgaWYgZGlzYWJsaW5nIFNETUEx
LCB0aGVuIGtlcm5lbCBjYW4gYm9vdCB1cCwgaXQgZG9lcw0KPiA+ID4gTk9UIG1ha2Ugc2Vuc2Ug
VE1VIGNsb2NrIGlzIHJlbGF0ZWQgdG8gU0RNQTEsIEkgd2lsbCBjaGVjayB3aXRoIGRlc2lnbg0K
PiBhbmQgZ2V0IGJhY2sgdG8geW91IHNvb24uDQo+ID4gPg0KPiA+DQo+ID4gSGkgQW5zb24sDQo+
ID4NCj4gPiBBcHBseWluZyBBYmVsJ3MgcGF0Y2g6DQo+ID4NCj4gPiBjb21taXQgODgxNmM0N2Ri
NmE4MmY1NWJiNGQ2NGY2MmZkOWRkM2FmNjgwZjBlNCAoSEVBRCAtPiBtYXN0ZXIpDQo+ID4gQXV0
aG9yOiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KPiA+IERhdGU6ICAgVHVlIEp1biAy
NSAxMjowMTo1NiAyMDE5ICswMzAwDQo+ID4NCj4gPiAgICAgY2xrOiBpbXg4bXE6IE1hcmsgQUhC
IGNsb2NrIGFzIGNyaXRpY2FsDQo+ID4NCj4gPiAgICAgS2VlcCB0aGUgQUhCIGNsb2NrIGFsd2F5
cyBvbiBzaW5jZSB0aGVyZSBpcyBubyBkcml2ZXIgdG8gY29udHJvbCBpdCBhbmQNCj4gPiAgICAg
YWxsIHRoZSBvdGhlciBjbG9ja3MgdGhhdCB1c2UgaXQgYXMgcGFyZW50IHJlbHkgb24gaXQgYmVp
bmcgYWx3YXlzIGVuYWJsZWQuDQo+ID4NCj4gPg0KPiA+DQo+ID4gVGhlIGtlcm5lbCBib290cyB1
cCBhZ2Fpbi4NCj4gPg0KPiA+IEl0IG1ha2Ugc29tZSBzZW5zZS4gSSBkb24ndCB1bmRlcnN0YW5k
IHRob3VnaCB3aHkgaGF2aW5nDQo+ID4gSU1YOE1RX0NMS19UTVVfUk9PVCBhcyBjcml0aWNhbCBh
bHNvICJ1bmhhbmdzIiB0aGUga2VybmVsLg0KPiA+DQo+IA0KPiBPSywgc28gdGhpcyBpcyBob3cg
aXQgd29ya3MuDQo+IA0KPiBCeSByZW1vdmluZyB0aGUgY3JpdGljYWwgZmxhZyBmcm9tIFRNVSwg
dGhlIEFIQiBkb2Vzbid0IHN0YXkgYWx3YXlzIG9uLg0KPiBXaXRoIG15IHBhdGNoIHRoZSBBSEIg
aXMgbWFya2VkIGFzIGNyaXRpY2FsIGFuZCB0aGVyZWZvcmUgc3RheXMgb24uDQo+IA0KPiBUaGUg
c2RtYTFfY2xrIGhhcyBhcyBwYXJlbnQgdGhlIGlwZ19yb290IHdoaWNoIGluIHR1cm4gaGFzIGFz
IHBhcmVudCB0aGUNCj4gYWhiIGNsb2NrLiBBbmQgSSB0aGluayB3aGF0IGhhcHBlbnMgaXMgc29t
ZSByZWFkIGZyb20gdGhlIHNkbWEgcmVnaXN0ZXJzDQo+IGhhbmdzIGJlY2F1c2UsIGZvciB3aGF0
ZXZlciByZWFzb24sIGVuYWJsaW5nIHRoZSBzZG1hMV9jbGsgZG9lc24ndA0KPiBwcm9wYWdhdGUg
dG8gZW5hYmxlIHRoZSBhaGIgY2xvY2suIEkgbWlnaHQgYmUgd3JvbmcgdGhvdWdoLg0KPiANCg0K
SSBjYW4gZXhwbGFpbiB3aHkgQWJlbCdzIHBhdGNoIGNhbiBmaXggdGhpcyBpc3N1ZSwgdGhlIEFI
QiBjbG9jayBpcyBhIE1VU1QNCmFsd2F5cyBPTiBmb3Igc3lzdGVtIGJ1cywgd2hpbGUgaXQgZG9l
cyBOT1QgaGF2ZSBDTEtfSVNfQ1JJVElDQUwgZmxhZyBzZXQgZm9yIG5vdywNCndoZW4gU0RNQTEg
aXMgcHJvYmVkLCBpdCB3aWxsIGVuYWJsZSBpdHMgY2xvY2ssIGFuZCB0aGUgY2xrIHBhdGggaXMg
c2RtYTFfY2xrLT5pcGdfcm9vdC0+YWhiLA0KYWZ0ZXIgU0RNQTEgcHJvYmVkIGRvbmUsIGl0IHdp
bGwgZGlzYWJsZSBpdHMgY2xvY2sgc2luY2Ugbm8gb25lIHVzZSBpdCwgYW5kIGl0IHdpbGwgdHJp
Z2dlcg0KdGhlIGFoYiBjbG9jayB0byBiZSBPRkYsIGFzIGl0cyB1c2Vjb3VudCBpcyBhZGRlZCBi
eSAxIHdoZW4gcHJvYmUgYW5kIGRlY3JlYXNlZCBieSAxIGFmdGVyDQpTRE1BMSBwcm9iZSBkb25l
LCBzbyB1c2Vjb3VudD0wIHdpbGwgdHJpZ2dlciBBSEIgY2xvY2sgdG8gYmUgT0ZGLg0KDQpTbyBJ
IHRoaW5rIHRoZSBiZXN0IHNvbHV0aW9uIHNob3VsZCBiZSBhcHBseWluZyBBYmVsJ3MgcGF0Y2gg
YXMgeW91IG1lbnRpb25lZCB1cHBlciwgdGhlIFRNVQ0KY2xvY2sgcGF0Y2ggaXMgTk9UIHRoZSBy
b290IGNhdXNlLCBpdCBqdXN0IHRyaWdnZXJzIHRoaXMgaXNzdWUgYWNjaWRlbnRseeKYuQ0KDQpC
dXQgSSBzYXcgQWJlbCdzIEFIQiBwYXRjaCBpcyBzdGlsbCB1bmRlciBkaXNjdXNzaW9uLCBzbyBJ
IHRoaW5rIHdlIG5lZWQgdG8gc3BlZWQgaXQgdXAgYW5kIG1ha2UgDQprZXJuZWwgYm9vdCB1cCB3
b3JrIGZvciBkZXZlbG9wbWVudC4gQUhCL0lQRyBhcmUgYWx3YXlzIGNyaXRpY2FsIGZvciBpLk1Y
IFNvQ3MuDQoNClRoYW5rcywNCkFuc29uLg0K

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE77834214
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfFDIoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 04:44:16 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:57045
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfFDIoQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 04:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdf20Bp34g9IXFpkFBSGXHHQUhMbYYT9z6xsjQmdrN0=;
 b=lE4xLS2UW+yb7q1PWncRU6G2r9fbUONZRMwG96pE/nJoKXUxOKbKW7KM+XDqd/39tKBkWcDq77VO32+u0R3GFvEdQwOGoojgf8/HVfscwtTF0S5ofc27z4O9zYp8vyYGHlHH2xDcnEV2pSWn5eiLA8+J42Imrro3+PG9uRBmYWg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 08:44:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 08:44:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Emilio Lopez <emilio@elopez.com.ar>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: RE: [RFC PATCH 0/3] Add support of busfreq
Thread-Topic: [RFC PATCH 0/3] Add support of busfreq
Thread-Index: AQHVCowAYPsUDFKXNUq2eGEvBhKyoKaLTMDA
Date:   Tue, 4 Jun 2019 08:44:10 +0000
Message-ID: <DB3PR0402MB39167B9EAE9A741AB0F20E30F5150@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
 <8af96425-a6f5-0114-7abb-c2a67b952e1b@baylibre.com>
 <AM0PR04MB643434FB6A26B4D70F52F350EE080@AM0PR04MB6434.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB643434FB6A26B4D70F52F350EE080@AM0PR04MB6434.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dd8d03e-0101-4d90-f1a1-08d6e8c8d036
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB3690247734C8A961D382B681F5150@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(52084003)(13464003)(86362001)(52536014)(44832011)(102836004)(6506007)(53546011)(6436002)(186003)(99286004)(14444005)(256004)(5660300002)(446003)(26005)(6246003)(71200400001)(71190400001)(6116002)(316002)(7696005)(3846002)(6636002)(66066001)(53936002)(7736002)(2906002)(486006)(7416002)(9686003)(4326008)(8936002)(11346002)(25786009)(229853002)(76176011)(478600001)(8676002)(33656002)(81166006)(81156014)(68736007)(66556008)(66946007)(55016002)(476003)(64756008)(73956011)(110136005)(14454004)(305945005)(66446008)(76116006)(74316002)(54906003)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iXQ8Q4MN2EpslZZxeiJn2xN9jsYL+d5IF6dud5GKFf3ynbVRSQ+39RAm+lHQMSCpn0pYiJTSTsemGQjq8cXQ+AvJqmKQjVg2t3orwcyl7AeYDstvY0cIQGLvSFqniIACXTwhyxnWa6ufBHcAulQ9lpXMadwJ5pd45ANiL6dcCPUt0zabbKVCmMrF/UtTZsDlt1d5GjWYiVvY3qkV0Gy6admgJiOuwP/xtCc9iMhYbLQunJJYgLQdhjVc/PMedO68MhyoLtdLCK6SOIezEALudYVpmEQs59nP9YwVPv33kFrluD76o8Ghd4yTSALcSGWxDUf4ND4PihSSnJnqsXb5zyznphbCudhqoc16Nl0Chz8FvDt7GtV4qzecSXEOQVjKi8rdCmSm2eQfZDiYglUodSd3lTCshitYl0YP0f5H1Kk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd8d03e-0101-4d90-f1a1-08d6e8c8d036
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 08:44:10.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFsZXhhbmRyZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExl
b25hcmQgQ3Jlc3Rleg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAxNSwgMjAxOSAzOjM0IEFNDQo+
IFRvOiBBbGV4YW5kcmUgQmFpbG9uIDxhYmFpbG9uQGJheWxpYnJlLmNvbT47IEphY2t5IEJhaSA8
cGluZy5iYWlAbnhwLmNvbT4NCj4gQ2M6IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJh
eWxpYnJlLmNvbT47IExpbnV4IFBNIGxpc3QgPGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5vcmc+
OyBHZW9yZ2kgRGpha292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+OyBQYXRyaWNrDQo+IFRp
dGlhbm8gPHB0aXRpYW5vQGJheWxpYnJlLmNvbT47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3Qg
PGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU3RlcGhlbiBCb3lkIDxzYm95ZEBj
b2RlYXVyb3JhLm9yZz47IEVtaWxpbw0KPiBMb3BleiA8ZW1pbGlvQGVsb3Blei5jb20uYXI+OyBI
YW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsNCj4gbGludXgtY2xrIDxsaW51eC1j
bGtAdmdlci5rZXJuZWwub3JnPjsgbGludXgtYXJtLWtlcm5lbCA8bGludXgtYXJtLQ0KPiBrZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IFplbmluZyBXYW5nIDx6ZW5pbmcud2FuZ0BueHAuY29t
PjsNCj4gQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEtldmluIEhpbG1hbg0K
PiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+OyBDYXJsbyBDYWlvbmUgPGNjYWlvbmVAYmF5bGlicmUu
Y29tPjsgZGwtbGludXgtDQo+IGlteCA8bGludXgtaW14QG54cC5jb20+OyBBbnNvbiBIdWFuZyA8
YW5zb24uaHVhbmdAbnhwLmNvbT47IFZpcmVzaA0KPiBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFy
by5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAvM10gQWRkIHN1cHBvcnQgb2YgYnVz
ZnJlcQ0KPiANCj4gT24gMTUuMDMuMjAxOSAxODo1NSwgQWxleGFuZHJlIEJhaWxvbiB3cm90ZToN
Cj4gPj4gT24gV2VkLCBNYXIgMTMsIDIwMTkgYXQgMTI6MzMgUE0gQWxleGFuZHJlIEJhaWxvbg0K
PiA8YWJhaWxvbkBiYXlsaWJyZS5jb20+IHdyb3RlOg0KPiANCj4gPj4+IEFzIGV4ZW1wbGUsIHRo
aXMgc2VyaWVzIGltcGxlbWVudHMgYnVzZnJlcSBmb3IgaS5NWDhNTSB3aG9zZQ0KPiA+Pj4gdXBz
dHJlYW1pbmcgaXMgaW4gcHJvZ3Jlc3MuIEJlY2F1c2UgdGhpcyByZWxpZXMgb24gQVRGIHRvIGRv
IHRoZQ0KPiA+Pj4gZnJlcXVlbmN5IHNjYWxpbmcsIGl0IHdvbid0IGJlIGhhcmQgbWFrZSBpdCB3
b3JrLg0KDQpJIGhhdmUgc2ltaWxhciBxdWVzdGlvbiBhcyBwcmV2aW91cyByZXZpZXdlciwgaXMg
dGhlcmUgYW55IGJyYW5jaCB0aGF0IHdlIGNhbiB0ZXN0DQp0aGlzIHNlcmllcz8gDQoNCkFuZCwg
ZnJvbSB0aGUgcGF0Y2gsIGl0IGhhcyBtdWx0aXBsZSBsZXZlbHMgZGVzY3JpcHRpb24gb2YgZmFi
cmljIGFyY2gsIHdoaWxlIHdlIE9OTFkNCmludGVuZCB0byBzY2FsZSAiYnVzIiBmcmVxdWVuY3kg
cGVyIGRldmljZXMnIHJlcXVlc3QsIGhlcmUgImJ1cyIgaW5jbHVkZXMgRFJBTSwgTk9DIGFuZA0K
QUhCLCBBWEksIHNob3VsZCB3ZSBtYWtlIGl0IG1vcmUgZmxhdHRlciwgc3VjaCBhcyBqdXN0IGEg
dmlydHVhbCBmYWJyaWMgYXMgYSBzaW5nbGUgcHJvdmlkZXIsIGFuZCB0aGVuDQphbGwgb3RoZXIg
ZGV2aWNlcyBhcyBub2RlcyB1bmRlciB0aGlzIHByb3ZpZGVyPw0KDQpBbnNvbg0KDQo+ID4+DQo+
ID4+IEl0J3Mgbm90IGNsZWFyIHRvIG1lIHdoZXRoZXIgdGhpcyBzZXJpZXMgYWN0dWFsIHNjYWxl
cyB0aGUgZHJhbQ0KPiA+PiBmcmVxdWVuY3kgYmFzZWQgb24gd2hhdCB5b3Ugc2FpZCBhYm92ZS4g
SXMgaXQganVzdCB0aGVvcmV0aWNhbCBvciBkbw0KPiA+PiB5b3UgaGF2ZSBpdCB3b3JraW5nIHdp
dGggYSBwaWxlIG9mIG91dC1vZi10cmVlIHBhdGNoZXM/IFdvdWxkIGJlIGdvb2QNCj4gPj4gdG8g
aW5jbHVkZSB0aGF0IHBpbGUgb2YgcGF0Y2hlcyBpbiB5b3VyIGludGVncmF0aW9uIGJyYW5jaCB0
aGF0IEkNCj4gPj4gc3VnZ2VzdGVkIGFib3ZlLg0KPiANCj4gPiBUaGUgY3VycmVudCBzZXJpZXMg
b25seSBpbnRyb2R1Y2UgYnVzZnJlcSBnZW5lcmljIGRyaXZlciwgYW5kIHRoZQ0KPiA+IGJ1c2Zy
ZXEgZHJpdmVyIGZvciB0aGUgaW14OG1tLg0KPiA+IEFzIGlzLCB0aGUgaW14OG1tIGRyaXZlciB3
aWxsIGp1c3QgYmUgbG9hZGVkLCBidXQgZG8gbm90aGluZyBiZWNhdXNlDQo+ID4gbm9uZSBvZiB0
aGUgZHJpdmVycyBoYXZlIGJlZW4gdXBkYXRlZCB0byByZXF1ZXN0IGJhbmR3aWR0aCB1c2luZyB0
aGUNCj4gPiBpbnRlcmNvbm5lY3QgZnJhbWV3b3JrLg0KPiA+DQo+ID4gTXkgaW50ZW50IHdhcyB0
byBzZW50IGEgZmlyc3QgZHJhZnQgbyBidXNmcmVxLCB0byBnZXQgc29tZSBmZWVkYmFjaywNCj4g
PiBiZWZvcmUgdG8gc2VuZCBhIG1vcmUgY29tcGxldGUsIGFuZCBmdWxseSBmdW5jdGlvbmFsIHNl
cmllcy4NCj4gDQo+IEl0J3MgYmVlbiBhIHdoaWxlIHNpbmNlIHRoaXMgd2FzIGZpcnN0IHBvc3Rl
ZCBhbmQgaW14OG1tIG5vdyBib290cyBmaW5lIGluDQo+IGxpbnV4LW5leHQuIElzIHRoZXJlIGEg
bW9yZSB1cC10by1kYXRlIFdJUCBicmFuY2ggc29tZXdoZXJlPw0KPiBPdGhlcndpc2UgSSBjYW4g
dHJ5IHRvIGhhY2sgdGhpcyBzZXJpZXMgaW50byBhIGJvb3RhYmxlIGZvcm0uDQo+IA0KPiAgPiBJ
biBhZGRpdGlvbiwgdGhlIGN1cnJlbnQgY2xvY2sgZHJpdmVyIG9mIGlteDhtbSBkb2Vzbid0IGFs
bG93IGRyYW0gID4NCj4gZnJlcXVlbmN5IHNjYWxpbmcsIHNvIGlmIGJ1c2ZyZXEgZHJpdmVyIHRy
aWVzLCBpdCB3aWxsIGZhaWwgKHNob3VsZCBiZSAgPiBoYXJtbGVzcw0KPiBiZWNhdXNlIGFueSBv
dGhlciBjbG9ja3Mgc2hvdWxkIHJlc3RvcmVkIHRvIHRoZWlyIHByZXZpb3VzICA+IHJhdGUpLg0K
PiANCj4gSSdtIGNvbmZ1c2VkIGFib3V0IHRoaXMuIEluIE5YUCB0cmVlIHRoZSBhY3R1YWwgRFJB
TSBzd2l0Y2ggaXMgZG9uZSBpbnNpZGUNCj4gQVRGIHZpYSBTSVAgY2FsbHMgYW5kIGludm9sdmVz
IGNvcnJhbGxpbmcgYWxsIENQVXMuIERvIHlvdSB3YW50IGFuICJkcmFtIiBjbGsNCj4gd2hpY2gg
d3JhcHMgdGhlIFNJUCBjYWxscyByZXF1aXJlZCB0byBjaGFuZ2luZyBkcmFtIGZyZXF1ZW5jeSBh
bmQgcm9vdA0KPiBzd2l0Y2hpbmcgZXRjPw0KPiANCj4gSSd2ZSBiZWVuIGxvb2tpbmcgYXQgdGhl
IGJ1c2ZyZXEgaW1wbGVtZW50YXRpb24gaW4gdGhlIE5YUCB0cmVlIGFuZA0KPiByZWZhY3Rvcmlu
ZyBqdXN0IHRoZSAiZHJhbSBmcmVxIHN3aXRjaCIgYmVoaW5kIGEgY2xrIG1pZ2h0IHdvcmsgbmlj
ZWx5Lg0KPiANCj4gVGhpcyB3b3VsZCBiZSBzaW1pbGFyIHRvIHRoZSBpbXhfY3B1IGNsayB1c2Vk
IGZvciBjcHVmcmVxLWR0IGFuZCBpdCBtaWdodA0KPiBldmVuIGJlIHBvc3NpYmxlIHRvIHVwc3Ry
ZWFtIHRoaXMgc2VwYXJhdGVseSBmcm9tIHRoZSByZXN0IG9mIGJ1c2ZyZXEgbG9naWMNCj4gZGVh
bGluZyB3aXRoIGRldmljZSByZXF1ZXN0cy4NCj4gDQo+IA0KPiBJIGhhdmVuJ3QgZG9uZSBhIHZl
cnkgY2FyZWZ1bCByZXZpZXcgYnV0IEkgbm90aWNlZCB5b3UncmUgbm90IHVzaW5nIHRoZSBPUFAN
Cj4gZnJhbWV3b3JrIGFuZCBpbnN0ZWFkIHJlZGVmaW5lZCBldmVyeXRoaW5nPyBJdCdzIG5vdCBj
bGVhciB3aHkuDQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBMZW9uYXJkDQo=

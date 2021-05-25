Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D947D390078
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 14:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhEYMBe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 08:01:34 -0400
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:35641
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232153AbhEYMBd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 May 2021 08:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBJE3QPcaZ/nGs4W8Q69XYAOFUxb2By9EAEMIL6ECH1lAletrdAbwnnJ+SUrV6B6ni8rWXbIq5cud3XxJucgfI7+vyTq+Enyt41zot+ahJi06bVf1J5yplSUYWgSIfhi+wdBWeYuqoDkeoyXJflRzubjzJ6Cz62Zqi/ahWXQ9Wm5nUsBLDifal8DgDpp7hFz2KMtGrrFUKW69/EOfDkrWfNkeByqjj9HfM3FoHir3ezdz4LHbwAmoERAqix0dtaHcqjiy0OA9YPt1Qxz1rujLiRkRD9Nj4T+SnBp1I6i3dutmZc+g+e0yg9tAugjIMkAwlv0Y4PsWYB3HiwnBb7yZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSdWHi4ODzJ7KlJ+/OvHFNnl1sBuo27QgX5s7DYoaac=;
 b=fJ7PvCRrHc5aL9zMQCNyA/ruzFj7KAY/qAT4iI+N+2GjU0pb2KQtmE1vQqHZ1hxGwni/157K/iYT+ay123LeVT3YI16Nfst40BSGyZXzRyP7k9SxKQa//daqM20mFvvtB9eulSMri/svwbQyWEtBuAqDFJ2znDuIIAqv6IqH4qPlHw18FSlVSqTsHo29Da2mMcuCQG+ULeio7hIO6uzQ+nsU4DDxYUVfR7rAUq1lNuFrbJJJqosLarJafbFLWyaHNOyWhscMdX4g1/sX7ugA7bZVAa48Be9pLhrhPEyxtQz7Oi/Zz7MhQB8Rq9JUxopJ4Urk+DWyayjy3Ao3L6JbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSdWHi4ODzJ7KlJ+/OvHFNnl1sBuo27QgX5s7DYoaac=;
 b=wWLiMxmi6GpwVdpJGWpquNZBSn7VTuWz+IcF3B5FWk9Q9tav3TKwFZx0yejvJeNT8EHltDv8wx2hoqGML6m+vKvKAfcNrCn5WdKPb1wzbIgMwXrVlbpyljL5lye+B1ymlwD7QblkY2ZgTyARfjO7wq65QgPpVH/gNNBGgKV8sFE=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2314.eurprd03.prod.outlook.com (2603:10a6:3:25::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26; Tue, 25 May 2021 11:59:58 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 11:59:58 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/9] rtc: bd70528: Drop BD70528 support
Thread-Topic: [PATCH 2/9] rtc: bd70528: Drop BD70528 support
Thread-Index: AQHXUU66OMBDD7qDREeYJ8kT72eroar0FLwAgAADjIA=
Date:   Tue, 25 May 2021 11:59:58 +0000
Message-ID: <83c091bef8adecd06a5c6fac9c86ca572bcc06d4.camel@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
         <2beaa677bde0f9516f366b97e91419598f1dfde4.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
         <YKzjtml4GL+dhP6j@piout.net>
In-Reply-To: <YKzjtml4GL+dhP6j@piout.net>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0967ccda-7a73-47f1-16e3-08d91f749e7e
x-ms-traffictypediagnostic: HE1PR0301MB2314:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB231441EE26DDE84B8969D32CAD259@HE1PR0301MB2314.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oeMIg6Z4oMKS6VlrDslqJ6lrezk4PR4eIPJlYljzg5CVh9BUwdHkXYSct6495ITWj0wsZcxnfGIjLhXzVTp05A/mPTNM8cU8hHZh8yi8CDgx6O/Zz1SnG+39HAWSBmE2uAFqowS+gWK2lNChPNFfwRFmTa9QOu30eeDLmgrtcXjXbddBiI9Yqychuf5CQ/VVG0ppJyDePcZ2tjjubxPgJNCvW6mhgknWaUSdoYB6l6UDkiTevGz9zRES3lrwlca4P303X07fFAJq2RBVHKVH7gL9/6fkrLbyJZiylRaX80/onklmhAnHCKoUxri0358I7x3yRYXok/UyMfbnEykbCP+Gk71UNXJZR/8DrcKWYVAUC+qBRXEKEweklSp0fJV7XQU6qbxrYifI8A/SU5zdK8dVxbkGwOLB4Eo7XFj2ow0/fKLYxBJNLBe0rd+pU4nNXlIfhgjDVI4FGQWKvu+zwkl1CEpchloRVSPaWBKBnIpZd1SH3R05OAQ2k8eeVXuITs3Vo/E3tJomvU3+0L/zushiW4C0XZoL6qNQ8BXOmzn6CdeW0nwj2u3TYeIgVVIyhACjvQgh7ZSY+qXSXDEE85UTJQupv+yYrLuk7PW1/t8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(396003)(366004)(376002)(2616005)(71200400001)(186003)(122000001)(83380400001)(6916009)(66946007)(66556008)(86362001)(6486002)(66446008)(4326008)(66476007)(8676002)(64756008)(76116006)(6506007)(3450700001)(8936002)(478600001)(5660300002)(316002)(2906002)(54906003)(6512007)(38100700002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aXVscXZsU1JTUkNRWmVOVEkxc1BnRGUxTDB4MGpFK2NoZ3BLZldHTjV4eWJ4?=
 =?utf-8?B?Q01RTkgycElwdzVsUXNEd1p0QTlIb3ZQdnVtWnVLT0VzdDJ5aGtFTkxHaEh3?=
 =?utf-8?B?U0RIVFRjTDlSN3R5Tno5ckt4czcxclc0OFR2Qk92b0JVdldMYzNMOG1qbjJ5?=
 =?utf-8?B?U1VYRW1FYlllSGtDT0c3ckZPWVhiTThMVG5ZdThlNXp1MlB2cS9Yc0ZSdm1l?=
 =?utf-8?B?bmVEcGsvZVl5Y24zRXNURFV4QVhJYjJMell1VDNhbVU2ek8yWmlZQy82UGdN?=
 =?utf-8?B?OVVJVHR5RlFITzhVU0xKSENrMW9CVWFVTjljblVobTV1M2o5MU5RQ092SER3?=
 =?utf-8?B?RmkzWENySzlsbTNWekdWL1NRdVRPb0VKTnpqL3hWbEVvVFMzYXo0NU41Ni9D?=
 =?utf-8?B?ZVVyckJqc0J0RWFvaGpGSjlhVytIME5wUitFenBEQmYyVThQWlJId1FWRjdo?=
 =?utf-8?B?OG8veE1PVk5CNGJqc0FyOENhTUI0aDVqL29BR3ZZcnRhZzdaTlM4SFlXOFQ5?=
 =?utf-8?B?QkdlaVJ3V3N3dzZjSDA4UkM1ZDcyWGM2NnJFcmRmSEZSNXl3dkVLaVUyOC8x?=
 =?utf-8?B?R1JsemFwUWkvVFJGNDdLQS85aWk1RGtLVmlISk5lajJqKzJ6ZS9BL3lLTTdL?=
 =?utf-8?B?aXNEQ1loNlgwZDFsMDd6MUx1Y0J4MUo0QmNNMkl0bDFtall0ZFgyRGYyVmJD?=
 =?utf-8?B?aE1iQzdnVWxHbDE1VjdoWnA2a2JLcE5seENlTk52Z2dwVFppbE1MQVN1U3h4?=
 =?utf-8?B?SzBiVU9FTkhCdWhYQWYzZXFXS2pZdmc0MEN1SmFILytKSUhBWlMyWDc2QXRh?=
 =?utf-8?B?UEo3R0hGTUxsZndoU1I0ZHVJZTl1Skk1ZUZ1eFlEdjgyZG5zekNyRm50MVUr?=
 =?utf-8?B?aWFNczdQWTVQcHBwMlFPK3hxRDdYMjM4SUdoK1F0MVZYdVBRTFMvVmVaenZ6?=
 =?utf-8?B?MVk5MndESnU0STUzZmdTbXFjUlQ2S2tLUzI4aXNyZTJhQ3hRWDVNRys2VWFt?=
 =?utf-8?B?b3AyWW4rcXJpcWlBKys0cU92Z1EweUUyKzdiT2hmMUU3UWp1NGpLU1g2cEox?=
 =?utf-8?B?QjZ3RzMrWUdIdTR5N1dGL3VGQ2U1ZGNWTzB1aDlETzRDRGdzOXhLUVNCVUdE?=
 =?utf-8?B?WWMxMGdSanhxQjBHdm9PenYwV0EvTWNRMkJGU3IxNWZmVEV0VFFXSWcvbmFN?=
 =?utf-8?B?N1RmeGczZk44N1lxcExGSFlONDErcEVSQUlBbVVZWjBidHcyMlNQdzlieFQx?=
 =?utf-8?B?UGVzK3dYdUFwdDBzWWZNQUgrcDRCQlJFdnV2R25pTUJXUnk0SFA5SG43eXlZ?=
 =?utf-8?B?NTFHcWRYbkhMV1V6c2ticUwyZW5hL2V0MXlmdTlTV3FyVVRmL3RnRkw5UUt3?=
 =?utf-8?B?MXNIMlkxeDlEMnpkY3FKREpSaXY1S2dBTEJGUHMxQzZNNkhjbnpwai80TFZl?=
 =?utf-8?B?NVROb3JFSXJjZjdzTDMwT3Q1bHFrZTNWZndTbGhiM0F3ODVZdkE0akJyMHUr?=
 =?utf-8?B?bEFMdUZsNHhVS3c5eHRRUnErSDNYZEJFSmRkN0o3VENMeE9qRkFvZmxiQnh3?=
 =?utf-8?B?aTEwRWw4QW5pTTZtQUIydm9nOG05TFdlQ2ZUVi81K24xWWJVUDJDWS9kUWls?=
 =?utf-8?B?S1gwNnpVc0NLQWhpY1hXMDFHcExnUjh6cVliWDljd3JldFlZWGk0UmpUKzJu?=
 =?utf-8?B?VWJMZTg4aUprRGxhcmhSakNrYk8wNVk5dG9sRS96ZEs0UE5kWHdRQ3dpbjV2?=
 =?utf-8?B?VjlrTjFFSUV4V1UrSFIwSGxBN1FqSCtvNnRMZ3JXR0tWYjdOK2NtYXhwcitU?=
 =?utf-8?Q?7rdrYmMzw1k1HgvfM4v2h6kVyw7vQA1YajFJc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <506E6D0224A05C4F95AAAB3223EB80D5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0967ccda-7a73-47f1-16e3-08d91f749e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 11:59:58.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaC1C/ifNpAWyRXogrVBSmtxLz8stPChnu7LDPROzob5zRetYHWNBlxJxR6TGJnucmzN7fPHCH2Llil+CTTad8+5R/7vCNPAX5+HxiIgit192dGon1oBLQpwgOxVKgMS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2314
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBUdWUsIDIwMjEtMDUtMjUgYXQgMTM6NDcgKzAyMDAsIEFsZXhhbmRyZSBCZWxsb25pIHdy
b3RlOg0KPiBPbiAyNS8wNS8yMDIxIDEzOjE0OjA5KzAzMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90
ZToNCj4gPiBUaGUgb25seSBrbm93biBCRDcwNTI4IHVzZS1jYXNlcyBhcmUgc3VjaCB0aGF0IHRo
ZSBQTUlDIGlzDQo+ID4gY29udHJvbGxlZA0KPiA+IGZyb20gc2VwYXJhdGUgTUNVIHdoaWNoIGlz
IG5vdCBydW5uaW5nIExpbnV4LiBJIGFtIG5vdCBhd2FyZSBvZg0KPiA+IGFueSBMaW51eCBkcml2
ZXIgdXNlcnMuIEZ1cnRoZXJtb3JlLCBpdCBzZWVtcyB0aGVyZSBpcyBubyBkZW1hbmQNCj4gPiBm
b3INCj4gPiB0aGlzIElDLiBMZXQncyBlYXNlIHRoZSBtYWludGVuYW5jZSBidXJkZW4gYW5kIGRy
b3AgdGhlIGRyaXZlci4gV2UNCj4gPiBjYW4NCj4gPiBhbHdheXMgYWRkIGl0IGJhY2sgaWYgdGhl
cmUgaXMgc3VkZGVuIG5lZWQgZm9yIGl0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRp
IFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiA+IA0KPiA+
IC0tLQ0KPiA+IE15IGhlYXJ0IGlzIGEgYml0IGxlc3MgYmxlZWRpbmcgd2hlbiBJIHNlZSBob3cg
bXVjaCBzaW1wbGVyIHRoaXMNCj4gPiBSVEMNCj4gPiBkcml2ZXIgYmVjYW1lLi4NCj4gPiBQbGVh
c2UgbGV0IG1lIGtub3cgaWYgc29tZSBvZiB5b3UgdGhpbmsgdGhlIGRyaXZlciBpcyBuZWVkZWQu
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcnRjL0tjb25maWcgICAgICAgfCAgIDQgKy0NCj4gPiAg
ZHJpdmVycy9ydGMvcnRjLWJkNzA1MjguYyB8IDMxNiArKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+IC0tLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDMwNyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMv
S2NvbmZpZyBiL2RyaXZlcnMvcnRjL0tjb25maWcNCj4gPiBpbmRleCBkOGMxM2ZkZWQxNjQuLjM5
ODg5OTIxNzYyNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3J0Yy9LY29uZmlnDQo+ID4gKysr
IGIvZHJpdmVycy9ydGMvS2NvbmZpZw0KPiA+IEBAIC01MDIsMTAgKzUwMiwxMCBAQCBjb25maWcg
UlRDX0RSVl9NNDFUODBfV0RUDQo+ID4gIA0KPiA+ICBjb25maWcgUlRDX0RSVl9CRDcwNTI4DQo+
ID4gIAl0cmlzdGF0ZSAiUk9ITSBCRDcwNTI4LCBCRDcxODE1IGFuZCBCRDcxODI4IFBNSUMgUlRD
Ig0KPiA+IC0JZGVwZW5kcyBvbiBNRkRfUk9ITV9CRDcxODI4IHx8IE1GRF9ST0hNX0JENzA1Mjgg
JiYNCj4gPiAoQkQ3MDUyOF9XQVRDSERPRyB8fCAhQkQ3MDUyOF9XQVRDSERPRykNCj4gPiArCWRl
cGVuZHMgb24gTUZEX1JPSE1fQkQ3MTgyOA0KPiANCj4gVGhpcyB3b24ndCBhcHBseSBhcyBJIGFw
cGxpZWQgYjBkZGM1YjE3MDA1ICgicnRjOiBiZDcwNTI4OiBmaXgNCj4gQkQ3MTgxNQ0KPiB3YXRj
aGRvZyBkZXBlbmRlbmN5IikgeWVzdGVyZGF5Li4uDQo+IA0KDQpJIGtub3cgQWxleGFuZHJlLiBT
b3JyeSBhYm91dCB0aGF0LiBJIHJlY2VpdmVkIGNvbmZpcm1hdGlvbiB0byBteQ0KcXVlc3Rpb24g
d2hldGhlciB0aGUgQkQ3MDUyOCBpcyB1c2VkIG9ubHkgYXQgdGhpcyBtb3JuaW5nLiBTb3JyeSBm
b3INCmFsbCB0aGUgd29yay4NCg0KVGhpcyBpcyB3aHkgdGhlIGNvdmVyLWxldHRlciBzdGF0ZWQ6
DQoNCiIuLi5BcyBhIGZpbmFsIG5vdGUgLSBGZXcgaW1wcm92ZW1lbnRzL2ZpeGVzIHdlcmUganVz
dCBhcHBsaWVkIHRvIHRoZQ0KcmVndWxhdG9yIHRyZWUgc28gdGhpcyBzZXJpZXMgaXMgbGlrZWx5
IHRvIGNvbmZsaWN0LiBTb21lIGZpeGVzDQp3ZXJlIGFsc28gYWRkZWQgdG8gUlRDIEtjb25maWcg
LSB3aGljaCBtZWFucyBhbHNvIHRoZSBSVEMgdHJlZQ0KbWF5IGhhdmUgY29uZmxpY3RzLiBQbGVh
c2UgbGV0IG1lIGtub3cgaWYgeW91IHdpc2ggbWUgdG8gcmViYXNlDQp0aGlzIHNlcmllcyBvciB0
aG9zZSBwYXRjaGVzLiINCg0KQW5kIGluIGFueSBjYXNlIGFwcGx5aW5nIHRoZSBNRkQgYW5kIFJU
QyBwYXRjaGVzIHNob3VsZCBiZSBzeW5jZWQuIFJUQw0KcGFydHMgc2hvdWxkIGJlIGFwcGxpZWQg
YmVmb3JlIE1GRCBwYXJ0cyBiZWNhdXNlIGZldyBvdGhlciBQTUlDcyB1c2UNCnRoaXMgc2FtZSBS
VEMgZHJpdmVyIGFuZCBjb21waWxhdGlvbiB3b3VsZCBmYWlsIHdpdGggbWlzc2luZyBoZWFkZXJz
IGlmDQpNRkQgd2FzIHJlbW92ZWQgYmVmb3JlIFJUQyBjaGFuZ2VzIGFyZSBhcHBsaWVkLg0KDQpT
dWdnZXN0aW9ucyBvbiBob3cgdG8gZ3VhcmFudGVlIHRoZSBvcmRlciBvZiBNRkQgYW5kIFJUQyAt
IGFuZCBob3cgdG8NCnJlc29sdmUgY29uZmxpY3RzPw0KDQpCZXN0IFJlZ2FyZHMNCglNYXR0aSBW
YWl0dGluZW4NCg==

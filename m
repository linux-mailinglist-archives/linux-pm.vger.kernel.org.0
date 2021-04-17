Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6EC362E9C
	for <lists+linux-pm@lfdr.de>; Sat, 17 Apr 2021 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhDQIt7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Apr 2021 04:49:59 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:49123
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229631AbhDQIt6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Apr 2021 04:49:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1uvJjaUreJpYot5vL1iP9uylTPuUaD6H8nDX6MwLLVgD5edHRzBSPDp1L48bpiSGEiRFBm4zsShcaHYvKz4GrwDoaiczoSgZ41JAPfk7GS/CiPxFtCdZqOnLEMKB5uCPZdr2rtwcfzfE9g5fpS7ETZ02SOYkmSLtWR8OZISyuBSHu/i7K4QM8Il+FrNUVNuK86NWKQPLu8UX3RdsTtrTbSW1j4xNrCDI5yjBo1jSrqFIc1z7XXASI7YDtP+On8v94xUqfEIS+bKFg6wFgUK9OxVmf85uSl4YMNJtf3pP8O7xf4+HDmb+jMIeYhPgfTfHViBSk83O7pxrHLy2hXI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5JhgTb6/fozF+pLz0wsZACvWfWfnKi/dWWFZ15BkW8=;
 b=UkR33IW6ksJZsdwHO9nGOMFtGMsyYEUTikugSG//dnUFmYrPEaEy574o2n7Grv9E7pk0NN/2E4YjzQgzkPrBDjvjzLkauxQopuoKI7Xqnb/+rzfxBN6KHYvJvZ8BC+ZtkBg0YpNOVggS5EavwsI/1wC/jsrmvIlcs+JyJvUMHCy174D1IEWajKpssDtX2L2hBIEOOASe3Tm+vy2B/y8LEgXwkW+nBgif9O6wRWlQznkkMcYRWCvGtDBIMj9RBgkkCkOH0jBg82N6uvgT/JdzleNDtSFVUkDGcdvw5s7MpNQs4t6ZxaPbqgZooBT9UyM9ZVZDA7O1Vuo5ISJ6TjZN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5JhgTb6/fozF+pLz0wsZACvWfWfnKi/dWWFZ15BkW8=;
 b=pMasrZeSXTPeAXVqHsTzbOB/OCh+6QOUsPMiPlO9uGK/rigRmS0CMq1ZQZU45SlfI8He1l1x/98Mk20BOQvLR3xYyvaACOmcQAjawbHl6uqQd4daVnozPzpEY1KeUtzHStCvxyhqUxPluIpD0VdJSb0xeUtwGfdWQVkoUsAa1xg=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2811.eurprd03.prod.outlook.com (2603:10a6:3:ec::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Sat, 17 Apr 2021 08:49:27 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd%3]) with mapi id 15.20.4020.025; Sat, 17 Apr 2021
 08:49:27 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "mcroce@microsoft.com" <mcroce@microsoft.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v7 2/9] reboot: thermal: Export hardware protection
 shutdown
Thread-Topic: [PATCH v7 2/9] reboot: thermal: Export hardware protection
 shutdown
Thread-Index: AQHXMPJX60uUF9bqVk2k1/COG/vp8aq4KloAgABA3gA=
Date:   Sat, 17 Apr 2021 08:49:27 +0000
Message-ID: <b039aa6253d38219c40fc36c8109f3b48bee4147.camel@fi.rohmeurope.com>
References: <cover.1618377272.git.matti.vaittinen@fi.rohmeurope.com>
         <adf417797006c996605a03c8bacfb4961e8f0b42.1618377272.git.matti.vaittinen@fi.rohmeurope.com>
         <7e231384-77c9-d32d-a0e0-63b735072b2d@linaro.org>
In-Reply-To: <7e231384-77c9-d32d-a0e0-63b735072b2d@linaro.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 335641f8-ad6c-4e18-1bfe-08d9017db55c
x-ms-traffictypediagnostic: HE1PR0302MB2811:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0302MB2811C32704AFEA349E682EB7AD4B9@HE1PR0302MB2811.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Sb3lWRBhspSc4FHV82jFZrhCXC7sXo3Y9+kDl3sZKme+ZpO4g8tXS3Tw8ILwo8Mzy63CzGJ8ZO/XaXf2zYGzbR6JBzrfyQKURXwQZgXsBVAfGaMXChVq4m0bE15/6WLYARKTil1bD3k04kGMbqQwerkSmTynb5BRiSFRobW11kGBAwbJUSMHysIE6lI3naRPAPNVi1nZhIys9EkWD3Gki4xLFcCo56bOkDYemTOwKRTHeSZqu9Pfoi+r3GDfZOO8c6SlNR23wyIOqo0BbRtJpu231ijVSycikKmJpDFegibTUjs7iOUOIugj2ol6MN4Mqz/u8XZ/2g1y1wkYcM6p+tqQxBoILrHKMJMpxRGAzLPYLEtGoB8rSx6jV147szIAZtjmqjHh/5AMOOT+b0dHp6G4jcgcK0L+H94qsCWoh5ilgn3240a0M9sSYxIJ0B+YhXjsTH3hIBIwEuEei3TA/rYDrB2dq8cHgQsJ8lufl5TZfAGhyxw5sJM0jHL+i4XCUHs3wXHIBYzHaxj1Ukow+h9yv2N5LLACtHYGhuB7uRn7I+yEYrYsVgvdF+hzPdh4E3FPTKz6bpKb6SIgMh2D6zmnFz+340vRbNdDV1FHmk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(136003)(346002)(366004)(376002)(83380400001)(3450700001)(54906003)(66446008)(5660300002)(7416002)(316002)(6512007)(6506007)(86362001)(6486002)(6916009)(186003)(2906002)(122000001)(64756008)(66946007)(38100700002)(2616005)(478600001)(8676002)(8936002)(4326008)(66476007)(71200400001)(66556008)(53546011)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OSs3V0hVeXI3Q0ttMjE4MUFHQlIvNDQyTWpPU2RtVDdRSnZYbnp2enpOdk00?=
 =?utf-8?B?WDBvamk4RUwyQUwvTmRlejFaemU4YU1CeXpZWFliWmppa1drTUpiazlZMFg4?=
 =?utf-8?B?d2FaMUdWc2JlQk5VSUwwNFVHTW9tMkRZcDFCWkh6U2h5SFFJclpCSVFEenNi?=
 =?utf-8?B?WU4yRExlenE2ZDhLVEVHd1IvZUt6VDNaUlQzR0tScTg3dnZDZDNnMHpFV3VB?=
 =?utf-8?B?cG0vemQ3SDRTa1U2dG5rbFJoLzQ4OFRuamlsUkVSSWx4dFRrOHpUVU9pZ1J0?=
 =?utf-8?B?dUFzQWcyVDZhK290Q0p3dytjUFJXaUtBeTFBN1ZCa1NJaS9SUnJmbVYySnFS?=
 =?utf-8?B?NHhJMkl0VXN3K2FmRTdQZWQva2RJcVNicnNwc0pnbnltaG5aRHorNTlKMm9k?=
 =?utf-8?B?MGFMNVAvVkQzYm1FMVZSVjNTSzBRWkQ0cTBOanBOcXkwenBqUzZ2TWorTngv?=
 =?utf-8?B?K3lhb1dxUDdZRlh5a29UNkM0QmpPVi9aK3drdjBJaWVNdHdOTDlOR0xuY3Jk?=
 =?utf-8?B?ZG05Z0RUdWJrd3Bod09XMEpUVmxhZnVkSXBqREJRZXM5ZERZaEJCVENMOVI2?=
 =?utf-8?B?Y3Z3TGw1UVFXSG5tYS9pZ0EvZ21yTWhoektjRm5mV1VZaDl3R29OYWt2bnds?=
 =?utf-8?B?YnFUTDN4T0w0N0pERmpjOEsxTzFCNXFIRXBzcDllYk1HTWRiRTBXZmpLK3dF?=
 =?utf-8?B?b3dCRlp6TnNINzdnVWpsSGxhZWpQTkd3YVdnQXpIK2haZVUzYjQrQXVnTUtH?=
 =?utf-8?B?dThGQnFCeThRcEM3dStiU1VnUUN3WWlUSXBFc2UyWDcwV1VnUlBpN0taanor?=
 =?utf-8?B?Tis1c3E2OGtFUHJLb2J4dGVUUTRadkl0WkkwYkl6S0pWK09yUk53TEthVFk3?=
 =?utf-8?B?MUFWSk5XU2xBdjVPQjgwRHBhajltYUl5bkNrMmFrTms2aHhLNEE3Unl4OG9o?=
 =?utf-8?B?QkZVSWlhbks3bFp1TEVqQVl4QXZqNExHaEd3VGlnQVlrbWhZOWlKZFpPdHh2?=
 =?utf-8?B?WUhPckpTNFJ0eFdER2hiNFM1UGFWQXRXRnp4dFdZcEJ4Z2FQVGtza29QQ29C?=
 =?utf-8?B?ZE9IMFdvN0lLV1VhSGpPR1ZOc1RhRXRHbDMrT2pCZ3N0eFFDeWxmSGpxNmxu?=
 =?utf-8?B?blUxTmFNWkp3QlRnSS8zRFpoNHY0OTFvSGRCRWMvNG5YVU9VOEdzR21nVzNz?=
 =?utf-8?B?ZU9kVWVZM0RtSHpGQjU2enMrWE93dVcvQlhaMDFsbmNoaHN0MGJpS09IY0pS?=
 =?utf-8?B?RE1tYyt0dnJ2RGh4NDVXNEloNUJqUmFZYTN6NWh4LzVSZW1oZkRCSEdRVGJW?=
 =?utf-8?B?Qnl1SVF0bWFhQUw2N255S09xbG4reExUT1NzMzNieXRNZ2V4VjZPVmpqcU81?=
 =?utf-8?B?aVpDMW9EdVBmU2xrbnpOYlNnR3hZZzdaRGJsNXY3eUF6d0gvSExGTnVmcmhE?=
 =?utf-8?B?dHNLTzFvTUlmSTNXcGxDV3RvWHU2dCtoYnFUZUlBUVIvU0tsdldydFVPdFF5?=
 =?utf-8?B?VXJkcVBXYlV0cmFPN2I3SlNCK1V2ZCtwZzZtYk01ZGVhSndxeG1kYzhELyt6?=
 =?utf-8?B?Z0pyZGJ6bDhwNHIvd3p4bDlKWFpkOXdiRUVvdWhML0QwNVg1V1QyalV6S1Bt?=
 =?utf-8?B?S205QklkK3h6MU01YkFZWGMzWlI2Q2hnUmtiNUNLeFJhT2RIdWIreVQ3aGN1?=
 =?utf-8?B?M0tGRXp3REZFcTl6c0dGZlFMdlB1Q0lCbk9lckNPeWpLRVNnMklhZzJiaEcv?=
 =?utf-8?B?cUxaNDlWbDZXODNHQVFnV0Fzb1U0VDFocXE2SE1XdEt0NHdNcTIyVlVNUHM0?=
 =?utf-8?Q?fegmSNjshBiA+BS00Ot7FuWnbgr/uFa2640tI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26F8A36692B18849ACC2AB5A86DF4999@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335641f8-ad6c-4e18-1bfe-08d9017db55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 08:49:27.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfOHc8rSVX1lGV7/e5BqiYcbqqIaheMcCKo05fF1m5XYbxO5Tm8M/OLxlfCvzFNmNjq+K2M1tT5LgEnsEAfBawW+6bXyZDT0167VQglDv35dys3UjHeT5VT5TxaXkSQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2811
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBTYXQsIDIwMjEtMDQtMTcgYXQgMDY6NTcgKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3Rl
Og0KPiBPbiAxNC8wNC8yMDIxIDA3OjUyLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gVGhl
cm1hbCBjb3JlIGNvbnRhaW5zIGEgbG9naWMgZm9yIHNhZmV0eSBzaHV0ZG93bi4gU3lzdGVtIGlz
DQo+ID4gYXR0ZW1wdGVkIHRvDQo+ID4gYmUgcG93ZXJlZCBvZmYgaWYgdGVtcGVyYXR1cmUgZXhj
ZWVkcyBzYWZldHkgbGltaXRzLg0KPiA+IA0KPiA+IEN1cnJlbnRseSB0aGlzIGNhbiBiZSBhbHNv
IHV0aWxpemVkIGJ5IHJlZ3VsYXRvciBzdWJzeXN0ZW0gYXMgYQ0KPiA+IGZpbmFsDQo+ID4gcHJv
dGVjdGlvbiBtZWFzdXJlIGlmIFBNSUNzIHJlcG9ydCBkYW5nZXJvdXMgb3Zlci12b2x0YWdlLCBv
dmVyLQ0KPiA+IGN1cnJlbnQgb3INCj4gPiBvdmVyLXRlbXBlcmF0dXJlIGFuZCBpZiBwZXIgcmVn
dWxhdG9yIGNvdW50ZXIgbWVhc3VyZXMgZmFpbCBvciBkbw0KPiA+IG5vdA0KPiA+IGV4aXN0Lg0K
PiA+IA0KPiA+IE1vdmUgdGhpcyBsb2dpYyB0byBrZXJuZWwvcmVib290LmMgYW5kIGV4cG9ydCB0
aGUgZnVuY3Rpb25hbGl0eSBmb3INCj4gPiBvdGhlcg0KPiA+IHN1YnN5c3RlbXMgdG8gdXNlLiBB
bHNvIHJlcGxhY2UgdGhlIG11dGV4IHdpdGggYSBzcGlubG9jayB0byBhbGxvdw0KPiA+IHVzaW5n
DQo+ID4gdGhlIGZ1bmN0aW9uIGZyb20gYW55IGNvbnRleHQuDQo+ID4gDQo+ID4gQWxzbyB0aGUg
RU1JRiBidXMgY29kZSBoYXMgaW1wbGVtZW50ZWQgYSBzYWZldHkgc2h1dC1kb3duLiBFTUlGDQo+
ID4gZG9lcyBub3QNCj4gPiBhdHRlbXB0IG9yZGVybHlfcG93ZXJvZmYgYXQgYWxsLiBUaHVzIHRo
ZSBFTUlGIGNvZGUgaXMgbm90DQo+ID4gY29udmVydGVkIHRvIHVzZQ0KPiA+IHRoaXMgbmV3IGZ1
bmN0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGku
dmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZWxvZw0KPiA+
ICB2NzoNCj4gPiAgIC0gbmV3IHBhdGNoDQo+ID4gDQo+ID4gUGxlYXNlIG5vdGUgLSB0aGlzIHBh
dGNoIGhhcyByZWNlaXZlZCBvbmx5IGEgbWluaW1hbCBhbW91bnQgb2YNCj4gPiB0ZXN0aW5nLg0K
PiA+IChUaGUgbmV3IEFQSSBjYWxsIHdhcyB0ZXN0ZWQgdG8gc2h1dC1kb3duIG15IHN5c3RlbSBh
dCBkcml2ZXIgcHJvYmUNCj4gPiBidXQNCj4gPiBubyBvZGQgY29ybmVyLWNhc2VzIGhhdmUgYmVl
biB0ZXN0ZWQpLg0KPiA+IA0KPiA+IEFueSB0ZXN0aW5nIGZvciB0aGVybWFsIHNodXRkb3duIGlz
IGFwcHJlY2lhdGVkLg0KPiANCj4gWW91IGNhbiB0ZXN0IGl0IGVhc2lseSBieSBlbmFibGluZyB0
aGUgb3B0aW9uDQo+IENPTkZJR19USEVSTUFMX0VNVUxBVElPTg0KPiANCj4gVGhlbiBpbiBhbnkg
dGhlcm1hbCB6b25lOg0KPiANCj4gQXNzdW1pbmcgdGhlIGNyaXRpY2FsIHRlbXAgaXMgYmVsb3cg
dGhlIG9uZSBzcGVjaWZpZWQgaW4gdGhlIGNvbW1hbmQ6DQo+IA0KPiBlY2hvIDEwMDAwMCA+IC9z
eXMvY2xhc3MvdGhlcm1hbC90aGVybWFsX3pvbmUwL2VtdWxfdGVtcA0KPiANCg0KVGhhbmtzIERh
bmllbCwgSSB3aWxsIHNlZSBob3cgdGhhdCB3b3JrcyB3aGVuIEkgY3JlYXRlIHRoZSBuZXh0IHZl
cnNpb24NCjopDQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0KDQoNCg==

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D002D27AD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 10:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgLHJbL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 04:31:11 -0500
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:33700
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727498AbgLHJbI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 04:31:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxK0HbiUG7M5zZL4nl32gx5JQJ3ikLvnuPemalekbgDSDk+oC2S89Fbyx0myutqZbpTlwUmg4fRUmmMQTcBCWJKgUrla+S0+igv0nwQuk+5Ldj29UW6GY2H8ofG3sGifwyswngeXpsR+CkzFboGrU1vZWesA+1IWYUIxaxebZJxTPKnyj29favwa6JhFDhX9ANQO8u5JdGkhg5jVi6b8tbuuLWVvP9a6JcOsDx6v1xNBxQbrz4QlxphQEViJ403rJno4r/9jbrRBfgtMeCWAkJmjA0P4f4hPtFX8CTujOz82Srp/wUyqWnQAa7mO7lY3TUc0qLQCYks6oNzZduX5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMICcSmuLv4IkRgUNLs0UCE2lNq6yHyh/5Zf1sOvsuo=;
 b=HrbfM7gOjbkQQ7p5uGv0XeJ/jeJfFvnuR2Guh1Iof0GlpmlvHx2Ft4s+MceGXxxWiX+VCgVCjvIoxxqDIFMkobcB0lZkVKojHR/9oEghdLqON+BkkfOGIdKiDsQAsRS4YE4jn2cKa4xRefvp2t56ffhhWcfju6caazCbt6T1qfwyMH9KyDn6ZFqRjGX+xCKMQe5lHHZu3nHw2RsKJDqYPTP+Jm9T28Fjq3qsstMQUTcn+89bMKlWukV97tC5GerErXaQ4hpOgmNc8dKRGqy8atmzLwHhkN7nZjIK9RQlkk2GZ4PZ97G2KbE1CRA8x8llXRUPmcmJgicRJ64/rxTejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMICcSmuLv4IkRgUNLs0UCE2lNq6yHyh/5Zf1sOvsuo=;
 b=gMYWbbutvbl4Fi8LTAZLCIdQTRlRecAGSq+OudzWLZKG3nYjDhhJl9FXZySHyx4j5IgqHn7E3Ca7yWTlH9dKDyexopAp6L4Iydcd9qKkQm4l3aoU7f0lEtTvG8At+Givg108ufsMhHV3w4rOgWHF10HvQoptiFoOjrWv8PErTGQ=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB3068.eurprd03.prod.outlook.com (2603:10a6:7:56::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.23; Tue, 8 Dec 2020 09:30:17 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 09:30:16 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "krzk@kernel.org" <krzk@kernel.org>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "cpham2403@gmail.com" <cpham2403@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/6] power: supply: add cap2ocv batinfo helper
Thread-Topic: [RFC PATCH v2 1/6] power: supply: add cap2ocv batinfo helper
Thread-Index: AQHWyjrDm4pTRnDkEUmwkGjtLPq3Fans6yiAgAAJ2wA=
Date:   Tue, 8 Dec 2020 09:30:16 +0000
Message-ID: <eec6f5b1600187d9d7a6988ede02b6276e60f4d6.camel@fi.rohmeurope.com>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
         <f2866a9052bbeaa4b3795907f91974e1d18ef68e.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
         <CACRpkdYjVJ9_6L2hthkoZ-G51aazxcyeHtu4EmeT8Eoo=0e=8w@mail.gmail.com>
In-Reply-To: <CACRpkdYjVJ9_6L2hthkoZ-G51aazxcyeHtu4EmeT8Eoo=0e=8w@mail.gmail.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [213.255.186.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07d7a30a-4c16-41c1-e79f-08d89b5bdf8e
x-ms-traffictypediagnostic: HE1PR03MB3068:
x-microsoft-antispam-prvs: <HE1PR03MB306870A432CBC96F733E02F2ADCD0@HE1PR03MB3068.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wehVqo18fLEScLIRLtY3rB/eNu7vIIFCjEllhfhueBRR7dlau4+RDAhcOmFsU72Pa39Hi43VCYwILJnoHg1NOsmlHyw72SBTM5hALmP/0VaWs9DOqM+k9ECD2f2SVngZm5kD2LFL6bWp3s9jKOWyKt87GCKGTdpG514oTvl6kmcUPOLEohlh+4uNt+rDivcY3glpeHJ9tz6QL7A9CrChtPxRLXRbn9EtcR9PwS+nmPXU7s657fe4Xo8Dut0WJneLBHdfE8wmd+0DYeSh4XuK3OUNkHgz3107Ww6h2cN506949OrNhY0IFqdFJNAFY6rhleVg2sy+BNcd72Vvmf7qPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(2906002)(186003)(6916009)(6486002)(66556008)(76116006)(5660300002)(8676002)(8936002)(83380400001)(508600001)(64756008)(66446008)(7416002)(4326008)(6512007)(66476007)(26005)(2616005)(3450700001)(6506007)(86362001)(66946007)(71200400001)(53546011)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WFFrWlhxM2hCazlGTDBYQVA4YVVBQjRYYnVpdFlrQjdMYTZaQlN2ZmpWakY3?=
 =?utf-8?B?SVU4dzZwZEkrZnFVcjRETGpXVW1SY1E1SEQwejhHcVpFZXdqbGJRYlZubmZ3?=
 =?utf-8?B?anZodTh5dFBNM2dvQlcvb3U4Y01lVDB2WWZLTmV1OHBOYTVOcE5TWUdMbFAx?=
 =?utf-8?B?Q3dIUVJRMStsMlZjTlBvOE1ocWFrbjZPanJxVk1KcjA2bzdoNzlEVFJ2UXh0?=
 =?utf-8?B?cUQyM0J4bld5ZHJvNnd5SVlUaDgybGlZSHNMb0lmQXlTL21ybWk2MWJpL29w?=
 =?utf-8?B?RS8rYTFsR3JGWGs1M1RkOVdRQ3hsdDZTRmpSUW1wSGdYczYvQUFKeHdkSVJK?=
 =?utf-8?B?YjFWNFgvYStFbldubXdUdi9RRlZVaTd4b3lrQTdzWmpMQ01YNTgydkdZMjd4?=
 =?utf-8?B?NXhINVcrWWdxWVlJaDNiak82SEdnZ0VVQkhScjM1YXZVYzdaRlZTNDFUaEkz?=
 =?utf-8?B?ZlFTMVR1bFE1cVBVQ2RHaDIydURkSzBTd1lWRFFpdkEzeDN0M3FQK0FuTk1Z?=
 =?utf-8?B?bEt2dTVQVFZhd1l6TnZXTHU4RjVzZ3U0ek5Lc0RTTG01RE9EYnFnMGRxRXFa?=
 =?utf-8?B?am5oVGxsSTBFWnRya2IwWWlWSFpxMG5QVTFwdjFxSGRMTVZkQUw3ZjR5L1FU?=
 =?utf-8?B?WERFblplaHVJTDZQK0dWV0ZLNFljME5DMnFiMUZCL0gzOFQxWkttb1M2Znpa?=
 =?utf-8?B?MlUxOEhkNkVVM0FGd25YWEJMWCtBY2dhcU91eWs4d3lwWmFMSjN6UzZGbGVC?=
 =?utf-8?B?Q0VOTFhSc1hjUG5ieDVITk9qK29EUmdKcXhuRk84bGZKQVZKRDJhV1JQMHVO?=
 =?utf-8?B?bC9vamxOcmJDdHhFeUFCbWtUOElZeTVkczlXcmZscU16VFkycENmOU1Pay9E?=
 =?utf-8?B?R0xUZUlUZFNpWFVrVWxSY0ZKajlkQnZtM1lveXg2MWEvMTdrUEUzUXpMamta?=
 =?utf-8?B?ZWwvTjFNOWFJUHFicHhzRk16aW5wRzNlRUdlSW9STHRMc1FVZWVMVFg2c2lM?=
 =?utf-8?B?MWk3WlRod0E4cVhkTEp5UDl4SE5UTVU2K3liYmY0UUM4ZENJdDl3WmdoQ2M0?=
 =?utf-8?B?WGRYbzVmOTNISzlWSW5NN2g0YkJId2Z5T1UrODRQcU1DeGJlakhMTGMzaDlH?=
 =?utf-8?B?QlJYN2tKRStjWUxOWUN1WEtoRW05NStERHAxaERkUkVtY0xucENtVnBHWnZ6?=
 =?utf-8?B?ZEl1WWE1WS9ibExGN1FXTkh4aWEwWndMc3dramhiZFNvOS9pb05aK3NKUXp0?=
 =?utf-8?B?Vml1dTNuQTZFL1FyMmhDaTZyUmpGdWQvQWhUcm1ETGt0MThuNkxINkg3dXl3?=
 =?utf-8?Q?u6slFU0tKGWLmholEskKKi625mWM6lceN9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <47C53D83352A1E47AFF2B7D92515D129@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d7a30a-4c16-41c1-e79f-08d89b5bdf8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 09:30:16.6459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: selghfXclMUGDOLW+nizY8cAtqjPeP3TEyt18kmTt8mElNBmOgCKRHWmoy/t0d4DPFs5LKSrslylqiSE+DAD8kjC8P1PYkbEM+ooajDUqY9U5Db+xoDI1TYmCeUgojvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3068
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgZGVlZSBIbyBMaW51cywNCg0KVGhhbmtzIChhZ2FpbikgZm9yIHRha2luZyBhIGxvb2sgYXQg
dGhpcyEgSGlnaGx5IGFwcHJlY2lhdGVkIDpdDQoNCk9uIFR1ZSwgMjAyMC0xMi0wOCBhdCAwOTo1
NCArMDEwMCwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gT24gRnJpLCBEZWMgNCwgMjAyMCBhdCAx
OjQxIFBNIE1hdHRpIFZhaXR0aW5lbg0KPiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUu
Y29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIHBvd2VyLXN1cHBseSBjb3JlIHN1cHBvcnRzIGNvbmNl
cHQgb2YgT0NWIChPcGVuIENpcmN1aXQNCj4gPiBWb2x0YWdlKSA9Pg0KPiA+IFNPQyAoU3RhdGUg
T2YgQ2hhcmdlKSBjb252ZXJzaW9uIHRhYmxlcy4gVXN1YWxseSB0aGVzZSB0YWJsZXMgYXJlDQo+
ID4gdXNlZA0KPiA+IHRvIGVzdGltYXRlIFNPQyBiYXNlZCBvbiBPQ1YuIFNvbWUgc3lzdGVtcyB1
c2Ugc28gY2FsbGVkICJaZXJvDQo+ID4gQWRqdXN0Ig0KPiA+IHdoZXJlIGF0IHRoZSBuZWFyIGVu
ZC1vZi1iYXR0ZXJ5IGNvbmRpdGlvbiB0aGUgU09DIGZyb20gY291bG9tYg0KPiA+IGNvdW50ZXIN
Cj4gPiBpcyB1c2VkIHRvIHJldHJpZXZlIHRoZSBPQ1YgLSBhbmQgT0NWIGFuZCBWU1lTIGRpZmZl
cmVuY2UgaXMgdXNlZA0KPiA+IHRvDQo+ID4gcmUtZXN0aW1hdGUgdGhlIGJhdHRlcnkgY2FwYWNp
dHkuDQo+ID4gDQo+ID4gQWRkIGhlbHBlciB0byBkbyBsb29rLXVwIHRoZSBvdGhlci13YXkgYXJv
dW5kIGFuZCBhbHNvIGdldCB0aGUgT0NWDQo+ID4gYmFzZWQgb24gU09DDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9w
ZS5jb20+DQo+IA0KPiBPdmVyYWxsIGEgZ29vZCBpZGVhIQ0KPiANCj4gPiArLyoqDQo+ID4gKyAq
IHBvd2VyX3N1cHBseV9jYXAyb2N2X3NpbXBsZSgpIC0gZmluZCB0aGUgYmF0dGVyeSBPQ1YgYnkN
Cj4gPiBjYXBhY2l0eQ0KPiA+ICsgKiBAdGFibGU6IFBvaW50ZXIgdG8gYmF0dGVyeSBPQ1YvQ0FQ
IGxvb2t1cCB0YWJsZQ0KPiA+ICsgKiBAdGFibGVfbGVuOiBPQ1YvQ0FQIHRhYmxlIGxlbmd0aA0K
PiA+ICsgKiBAY2FwOiBDdXJyZW50IGNhcCB2YWx1ZQ0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGhl
bHBlciBmdW5jdGlvbiBpcyB1c2VkIHRvIGxvb2sgdXAgYmF0dGVyeSBPQ1YgYWNjb3JkaW5nDQo+
ID4gdG8NCj4gPiArICogY3VycmVudCBjYXBhY2l0eSB2YWx1ZSBmcm9tIG9uZSBPQ1YgdGFibGUs
IGFuZCB0aGUgT0NWIHRhYmxlDQo+ID4gbXVzdCBiZSBvcmRlcmVkDQo+ID4gKyAqIGRlc2NlbmRp
bmcuDQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybjogdGhlIGJhdHRlcnkgT0NWLg0KPiA+ICsgKi8N
Cj4gDQo+IFNwZWxsIG91dCB0aGUgYWJicmV2aWF0aW9ucyBpbiB0aGUga2VybmVsZG9jIGFuZCBu
b3QganVzdCB0aGUgY29tbWl0Lg0KPiBUaGVzZSB3aWxsIGJlIHJlYWQgbXVjaCBtb3JlIHRoYW4g
dGhlIGNvbW1pdCBtZXNzYWdlIHNvIEkgd291bGQNCj4gbW92ZSBhbGwgdGhlIGV4Y2VsbGVudCBp
bmZvIGluIHRoZSBjb21taXQgbWVzc2FnZSBpbnRvIHRoZSBrZXJuZWxkb2MNCj4gYW5kDQo+IGRp
ZXQgdGhlIGNvbW1pdCBtZXNzYWdlIGluc3RlYWQuDQoNCkhtLiBJIHRoaW5rIHlvdSBoYXZlIGEg
cG9pbnQgaGVyZS4NCg0KPiANCj4gPiAraW50IHBvd2VyX3N1cHBseV9jYXAyb2N2X3NpbXBsZShz
dHJ1Y3QNCj4gPiBwb3dlcl9zdXBwbHlfYmF0dGVyeV9vY3ZfdGFibGUgKnRhYmxlLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHRhYmxlX2xlbiwgaW50IGNhcCkNCj4g
PiArew0KPiA+ICsgICAgICAgaW50IGksIG9jdiwgdG1wOw0KPiA+ICsNCj4gPiArICAgICAgIGZv
ciAoaSA9IDA7IGkgPCB0YWJsZV9sZW47IGkrKykNCj4gPiArICAgICAgICAgICAgICAgaWYgKGNh
cCA+IHRhYmxlW2ldLmNhcGFjaXR5KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+ICsNCj4gPiArICAgICAgIGlmIChpID4gMCAmJiBpIDwgdGFibGVfbGVuKSB7DQo+ID4g
KyAgICAgICAgICAgICAgIHRtcCA9ICh0YWJsZVtpIC0gMV0ub2N2IC0gdGFibGVbaV0ub2N2KSAq
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIChjYXAgLSB0YWJsZVtpXS5jYXBhY2l0eSk7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgICB0bXAgLz0gdGFibGVbaSAtIDFdLmNhcGFjaXR5IC0g
dGFibGVbaV0uY2FwYWNpdHk7DQo+ID4gKyAgICAgICAgICAgICAgIG9jdiA9IHRtcCArIHRhYmxl
W2ldLm9jdjsNCj4gDQo+IFRoaXMgaXMgc29tZSBsaW5lYXIgaW50ZXJwb2xhdGlvbiByaWdodD8g
SXQncyBub3QgaW1tZWRpYXRlbHkgZXZpZGVudA0KPiBzbyBpbnNlcnQNCj4gc29tZSBjb21tZW50
IGFib3V0IHdoYXQgaXMgZ29pbmcgb24uDQoNClllcy4gQ29kZSBpbnRlcnBvbGF0ZXMgdGhlIE9D
ViB1c2luZyB0d28gY2xvc2VzdCBrbm93biB2YWx1ZXMgZnJvbQ0KdGFibGUuIFRoaXMgaXMgcHJl
dHR5IG11Y2ggaWRlbnRpY2FsIGxvb3AgdG8gdGhlIGV4aXN0aW5nIG9jdjJjYXANCmNhbGN1bGF0
aW9uIC0gaXQgd291bGQgaGF2ZSBiZWVuIGJldHRlciB0byBpbmNsdWRlIGl0IGluIHRoZSBkaWZm
LiBPVE9IDQotIEkgZGlkIG5vdCBleHBlY3Qgc2VlaW5nIGFueSBwcm9wZXIgY2FyZWZ1bCByZXZp
ZXdpbmcgLSB0aGlzIFJGQyB3YXMNCnNlbnQgdG8gY29sbGVjdCBvcGluaW9uIG9uIHdoZXRoZXIg
dGhpcyB3b3VsZCBiZSB3b3J0aCBmdXJ0aGVyIHdvcmsuDQpBbnl3YXlzIC0gSWYgdGhpcyBmdW5j
dGlvbiBpcyBhZGRlZCBpdCBzaG91bGQgYmUgY2hhbmdlZCB0byB0YWtlIG1vcmUNCmFjY3VyYXRl
IFNPQyAtIHBlcmhhcHMgMC4xJSg/KSAtIEknbSBhZnJhaWQgcm91bmRpbmcgdGhlIGN1cnJlbnQN
CmNhcGFjaXR5IHRvIG5lYXJlc3QgMSUgd2lsbCBraWxsIHRoZSBhY2N1cmFjeSBhbmQgcmVuZGVy
IHRoaXMgc29tZXdoYXQNCnVzZWxlc3MuDQoNClRoaXMgbWFrZXMgbWUgd29uZGVyIGlmIHRoZSBT
T0MvT0NWIHRhYmxlIGluIERUIHNob3VsZCBhbHNvIHN1cHBvcnQNCnByb3ZpZGluZyB2YWx1ZXMg
dXNpbmcgMC4xJSBhcyB1bml0PyAoSSBkb24ndCB0aGluayB0aGlzIGlzIGEgbXVzdCBidXQNCml0
IG1pZ2h0IGJlIHVzZWZ1bCkuDQoNCj4gDQo+ID4gIC8qKg0KPiA+ICAgKiBwb3dlcl9zdXBwbHlf
b2N2MmNhcF9zaW1wbGUoKSAtIGZpbmQgdGhlIGJhdHRlcnkgY2FwYWNpdHkNCj4gPiAgICogQHRh
YmxlOiBQb2ludGVyIHRvIGJhdHRlcnkgT0NWIGxvb2t1cCB0YWJsZQ0KPiA+IEBAIC04NDcsNiAr
ODg0LDIwIEBAIHBvd2VyX3N1cHBseV9maW5kX29jdjJjYXBfdGFibGUoc3RydWN0DQo+ID4gcG93
ZXJfc3VwcGx5X2JhdHRlcnlfaW5mbyAqaW5mbywNCj4gDQo+IEkgc3VzcGVjdCB0aGlzIGtlcm5l
bGRvYyBjb3VsZCBiZSBpbXByb3ZlZCBpbiB0aGUgcHJvY2VzcyBhcyB3ZWxsLg0KPiANCg0KSSBh
Z3JlZS4gQW5kIGFsc28gZm9yIGZldyBvdGhlcnMuIEJ1dCB0aGF0IGNvdWxkIGJlIGEgc2VwYXJh
dGUgcGF0Y2ggbm8NCm1hdHRlciBpZiB0aGlzIFJGQyBwcm9jZWVkcyBvciBub3QgOikNCg0KPiBZ
b3VycywNCj4gTGludXMgV2FsbGVpag0KDQo=

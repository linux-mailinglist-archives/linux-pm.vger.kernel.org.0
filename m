Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19B9473DCB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Dec 2021 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhLNHuG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Dec 2021 02:50:06 -0500
Received: from mail-db8eur05on2087.outbound.protection.outlook.com ([40.107.20.87]:51296
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231506AbhLNHuG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Dec 2021 02:50:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMMRs6JjBp5w61VQNTzCnoMsrrle9n5YOZcByjXoNtuSISlg1L6Fxzdmy4hA8BZzYUuRP5grI6JYFrYyhP8LSWEpYqs2HZQm4rB/owNLh0X21BEqeiDXBVWsIrSFv1K9zQXGtVZYiQs7CYr6dNwpi09fbBw5AlnOfye2oDUGKuizKsw1eV8DJodJOZ3RQusx81m331HP/Wd6CpXWeGevUvUAFuxrTu6BnRhO98ahERxQYjqaYFSIMkB4lu6+ibINn+KyQPfj/1ys6SAgyjuPyKbaoKld+UuNqK4pagKTJzqtNzaNdIsIxfiUWIJCk5eyVCv2B0wly5e/r8dB+siG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ISnrp1S6fon53iLp8HbTLJf9e6+jkpRNS5a8Ho3djw=;
 b=C0uf1Z6f+leZN2VebndNBFL0r2sXyssV3vH8fNQL2BEu9q68ibCJKC4WNevbw8C0Q3NNl3Nj/3DzLsHXVll1Bv82wt8CcESGziBQYGSlVcXDUuy5s3gQ4JFQRBOSbvtGaO4h3gpClHEgm09AeLlD3s2fP4GBVqGKERxzBoGmEkuCJpHCyElKxo9F87P/vJXW6G0LtT08+73PwA8zhx/T0F4kMZOiIMDp67M+gN9H4tuDhrnCzrou23VjSdxz1bVZ6DVhQkeVI+uSA0UcO5ie0O0V9/viyKKgPZtHy71JxbuNPgd27fMl2oaJMRYJpmo7X+QI6ngkcVl39VDaKcqpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ISnrp1S6fon53iLp8HbTLJf9e6+jkpRNS5a8Ho3djw=;
 b=XZLEBCQSTkRhwmUGIMiGzoKJvytNm/RuB5QIQ24iwj0OqVET21sISzor2AuoxHycj4Ic3gCl0Cb19g5LUyzlQXguNurFzALbicnLLYEX2ZcnWpQ85pbe1YfZKmO4X9HRpjLSAfn9kvHJt5g1H8eSfehjg4/NkcWGzrKwvf3YBa4=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2987.eurprd03.prod.outlook.com (2603:10a6:7:5b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.25; Tue, 14 Dec 2021 07:49:56 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 07:49:56 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] power: supply_core: Pass pointer to battery info
Thread-Topic: [PATCH v2] power: supply_core: Pass pointer to battery info
Thread-Index: AQHX8LdQGviRSf/qnkquoPixbKLqp6wxnO+A
Date:   Tue, 14 Dec 2021 07:49:55 +0000
Message-ID: <53d4223e-d446-8581-a59b-1daec3f423dc@fi.rohmeurope.com>
References: <20211206000651.4168035-1-linus.walleij@linaro.org>
 <7228bbd0-4428-18d2-8cef-df9a9c789d41@gmail.com>
 <CACRpkdaKmZp62DSB7oMbESRjXAH8ncfLyc3KioSDx2z-_JOK8A@mail.gmail.com>
 <CANhJrGMHr=VLAwe-Tvyg70nN4ArjHa8UHKZODwrufK1r+rRNcA@mail.gmail.com>
 <d4478fbf-1ec8-5659-c77d-f412c351e497@gmail.com>
 <04df0bff-87b0-d39a-4f5c-bbeb7f3e0cd1@gmail.com>
 <9bed108f-9600-871f-d126-64f9a8796bee@fi.rohmeurope.com>
In-Reply-To: <9bed108f-9600-871f-d126-64f9a8796bee@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f608ad30-1f52-40c4-cbb0-08d9bed65225
x-ms-traffictypediagnostic: HE1PR03MB2987:EE_
x-microsoft-antispam-prvs: <HE1PR03MB2987AF0E973BFD9172B2F46BAD759@HE1PR03MB2987.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmFOB2avd6CB869OMtUD8g2C8WowKr11d/HF+Qk5SwRu7QWWarFzzYsYFPn94b8L3IX9N2YENLuwl/Qn+Kgh380oKjJHoZEy6HsjMLUnMckM44YVO/Z4/n0GKZHS6igtlyCmeb5f7BYLwBi2701N3kYGYSojzpNTRzzurIukd7mL3G3JocXYCaTtK3YqjclBMqOO/TBUOXPCqGqz4+ATo41eRUY1I9EhdIdVkAhjkq08wNDGaMDSrA2EOuAICGMzoOJsjtYdwVtuOp9hLDuWuQtEo8kGkg15nwlsJJsFKMfNEZ1O8ORQHWgWdkn7G5tbTkYfIa4d+VQgwKv7HwsUek6hRatmRHR0Y+e/wXAF2/yzR71LhUjLxxf4/jJU90T7jPZvuZJuBTjLA6INe2N++z1MCfux5rlzioLxi9lMBB0itbAM0Qs/XCE30juZh0p/oqnBl+e3aZg7mdvm2qZk3LvzIj41ORR+I6vTVWUTFX6I0Nz5iycvN1RWlDfdraawP1L15evRwAmhoDtZsD4AI3ckfVpPAHiF3O9tjmmDjcSgrXbMPhDkqcH4dySg8o+ss480OU3UO2C5Wq//5iyeLGl1SKmhIEpPSt52u+USKlpYnX8qAUxUYqik+vEY3VgxLzdq35WFWOAF+7Xv1KaiZO3ZUC2T5XjMJHNARpT4/5UPG4T6YZa/kRCkPPax4gIaU3MGXszqFXKhM1/XduqkpWbX6DM4gfc6Mo2qj85M9/fFE3pwjJGqLLH6HQBw+Rir+28w0zhYkI3bCTEb4sWJZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(6916009)(5660300002)(86362001)(316002)(31696002)(8676002)(66946007)(4326008)(64756008)(54906003)(66446008)(508600001)(66556008)(66476007)(6512007)(38100700002)(6486002)(8936002)(122000001)(31686004)(83380400001)(71200400001)(186003)(2906002)(2616005)(53546011)(6506007)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUJ0TkQwaFErbXYvMFB4azQzbktoQlNpeFRQeHJxNzhGYnl6MXB4cFNZQitn?=
 =?utf-8?B?ak81cWdCeXk4M09HMEpRM2gweWJuUEVQdngxNEM3UytUSEF5YWdoS3BudEVa?=
 =?utf-8?B?NXpFSzdXVjdaQ2tvMm5SQlgvOVVYclBYVUI5ZHZjaHpoZEhOVTJ4aitoSVhv?=
 =?utf-8?B?SG5La0FaZDZXMEdFNkVyblhVREFBbXF2Q1F1QXMySG1JMEFPMDFBMDBkaVdJ?=
 =?utf-8?B?WWo5K1NxTUtpZnljWXBUUGt0QjBPcWNQYUxVblpkWnR5ck1mTlZjTHF1cnZt?=
 =?utf-8?B?OEw5WWJMMkVxRjRkeDdHUXMrazhzc3NvV3ZJZHN2Slp4SFJFalM3ZVozK0ps?=
 =?utf-8?B?OHRJbHhGMi82M1NON2hDcVpDK3hpY2ZXY2d5b0VwQkkyMTdzSGJRaWxXcndT?=
 =?utf-8?B?alZZWlBXWkQ1WVQ1dVlUdjRVanNhYzJERXN0b0o1QXRRWUg0RThrWWVpZjYv?=
 =?utf-8?B?UzIxSmlmUGlNUVlENjZKY3FnTTREblhZc1BUTURTNmhJRzR6U2poS0NvMHdI?=
 =?utf-8?B?VUVWWmdBb1RzYk8zWktWaUNLVVQ1TnYzaU50NmVzVUhQTlAxVEw3WVZzVmlu?=
 =?utf-8?B?UFhuN1lCWkplZnAwOFZlaTE3d0xibkV3bFM2UEtFN0xsaDdkYTJibzU4bUdZ?=
 =?utf-8?B?TE9CcEsxYkhmdkU0WTNqV2NxT0tNa1MvQTJBd2pQMi9JRWxOYURxTFlTbFpI?=
 =?utf-8?B?QkxRaXRtK2t5WU1WWHpuL3kwL2taVm1tSW9UcEUxUDUrT2thaHZYWHV0ME5S?=
 =?utf-8?B?Q2pKY05WemZqb1NUZGNLeURJWUoxSkZBQVc1SVhybUNwblpGdHhzaHJ5VXlR?=
 =?utf-8?B?ZkV3UXRWUFdBNVRvNEFIeHhIRlpZdVhWVTNydHFPVkVtQkxUaW9nZC80eGpz?=
 =?utf-8?B?TmwvUjFoNjZNSzZzenNKQWgxbERjQU0xYkxZbXRaaUYyU3VLbzJjeUk2RjN3?=
 =?utf-8?B?R2N0Ujg2MWNzZlNuYlExMTJSS1dRSGtJd25CdHJSaG5VcUloc1AzcWF1N2xY?=
 =?utf-8?B?RGxCeXArRERPeHFHSkUvUVBaOENBdXpLWUhnOFZqSEFmcmZCUGFyck5LR2Yw?=
 =?utf-8?B?eDBQZjZ6cFV6QnM0dExyYWdrYUVzcmRzWnBzWEkza1p1L0h1OUJDclhyNVp4?=
 =?utf-8?B?NG1qVS9PblgvYTh1WmFvdmlSNU14bWdPYW80WHVFLytsL3RyQXE0YnBoS1Ja?=
 =?utf-8?B?R1JqYnNQUjJyeXBPZ1NmakdwVGlVRW50Z1h1Y1FhVUR2ZlNUSmRLOVJMVU5u?=
 =?utf-8?B?eWJkODA0MlNJajFWYXI2bVo5RFdZbFZZb211K3ZBYkV1bERRZmNza2NOWEdk?=
 =?utf-8?B?ZFlaR1NwRFluVk82bnBDWDhSNS9XM3I1U21EZWl4REJDRi9wU21KMHJKbG8z?=
 =?utf-8?B?cS9rdjRFSFZ1dE5uK0I1SVJoelhvMGMzUTNTWGVhZXpodDR3UDV5SmtZaUxT?=
 =?utf-8?B?QWNIZlhKSkdPSGhHL0ZJY0VCZUJlMWI2b1VjVGxFMWVZbnhyU3FNcjhXMkhW?=
 =?utf-8?B?NUlrTjhwRkVKME9oWkdZZ25vTm5IYVR6R3NaY2k1QS9KdmN4bUxJS2RKT3Q5?=
 =?utf-8?B?N0xpcDRkLzgxN1hkelVFZVFxNmV0OGtiSW1nOVh1aS9QY2NPUzZ1d21CK2tJ?=
 =?utf-8?B?VldHTTNWenNSa2MxOGdtWEZFUFpzODdTR1BXSTBUUm9FMTRyUk5QUUlEc2dF?=
 =?utf-8?B?OEdMRjkxL3o5UHhhSGs5K2lJbXNoOTdUZDkvSjZtSDB2Rm5Mdm8va0RaRmsz?=
 =?utf-8?B?bUwxdFlsbXlTU0VPZXBTZC8wUnFNRW1KQ3Q4b2FCTnlsTnlTemdFNlVjNUY2?=
 =?utf-8?B?SFBJbjdnMk1qa29aclpKZzNyZ2c1QVMwU1J4U09pbnlWQndiRXZHTTZBMyt3?=
 =?utf-8?B?eVI3Z2pFV3VaVGxJc1pxUVVIVVJ0SFBXWDd5aUkxaExKZjFqZmVzQkUrZU44?=
 =?utf-8?B?L1BDeUdta2ZsRy9YK1IzN1o3bGlDUzNuQk1YWUhFWnhqNVJ3cDJ3dzJkdHlT?=
 =?utf-8?B?YjdMWTZGdlhKN01EdEo2VUlhSFlqbzRrNlVWU1RVRmV4eVdodUFldTRRYzJV?=
 =?utf-8?B?SkFsYnBxMzk0QzZmUXQwVEFNc2k0cGRObW9lNUVvVWpMeEkvWnBvdkY3Tmtj?=
 =?utf-8?B?L2wrOTZPRDVhQm9sSldaZ093ekxYZG5TOXA5UkRiTDlPMDE2ZUxwWkVwV0Ru?=
 =?utf-8?B?ODVMTXphcHJOc3Z3dXdyaDVLVHhkVW9PdThpQjBJZ3V4ck1Zd2p3MmVHaWxh?=
 =?utf-8?B?eXU1cmt2cGY5ZWFOcnlJbG5ra0JnN1B3L3pONzEzQlpXUGVTZHd5K2d2TDVM?=
 =?utf-8?B?Z0k4YW5ONVdtejZEM041U1dmeW51U0VoM2NyTExXaUQ3YzkyTUFPZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A715F6E87F37F443AAF164BDE6A7D301@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f608ad30-1f52-40c4-cbb0-08d9bed65225
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:49:55.8914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THBisX+F1XcmrpwsrMzjBVovdsBZeBnuFrqJfMqWaeEw0siJJZrhq4zJD0UJ76hRtwUig1kzHQr5UNcK8cMDHfiJhbAB4EtKkOA69m9RN+yw57m6J09/Yo/2j0KcarIE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2987
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTIvMTQvMjEgMDg6NTMsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gT24gMTIvMTQvMjEg
MDg6NDQsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4+IEhpIGRlZWUgSG8gcGVlcHMsDQo+Pg0K
Pj4gT24gMTIvMTMvMjEgMTE6MjMsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4+PiBPbiAxMi8x
MC8yMSAwNzo1NywgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4+PiBPbiBUaHUsIERlYyA5LCAy
MDIxIGF0IDI6NDYgQU0gTGludXMgV2FsbGVpaiANCj4+Pj4gPGxpbnVzLndhbGxlaWpAbGluYXJv
Lm9yZz4gd3JvdGU6DQo+Pj4NCj4+Pj4+IEFsc28gSSB3b3VsZCBsb3ZlIGlmIHlvdSBjb3VsZCB0
ZXN0IHYyIG9uIGhhcmR3YXJlIQ0KPj4NCj4gDQo+PiBJdCBhcHBlYXJzIHRoZSBwYXRjaCB3b3Jr
ZWQgYXMgZXhwZWN0ZWQgLSBidXQgaXQgYWxzbyBhcHBlYXJzIHRoZSANCj4+IEJEOTk5NTQgZHJp
dmVyIGRvZXMgbm90IGhhbmRsZSBtaXNzaW5nIGluZm8gdG9vIHdlbGwuLi4gSSB0eXBvZWQgdGhl
IA0KPj4gdHJpY2tsZS1jaGFyZ2VyIGN1cnJlbnQgcHJvcGVydHkgaW4gRFQgLSBhbmQgYXMgYSBy
ZXN1bHQgdGhlIGRyaXZlciANCj4+IGRlY2lkZWQgLUVJTlZBTCB0byBiZSB2YWxpZCB2YWx1ZSAo
anVzdCB0b28gbGFyZ2UpIGFuZCBzZXQgdGhlIGxhcmdlc3QgDQo+PiBjdXJyZW50IEJEOTk5NTQg
c3VwcG9ydHMgZm9yIHRyaWNrbGUtY2hhcmdpbmcuLi4gDQo+IA0KPiBJIHNob3VsZCBoYXZlIGxv
b2tlZCB0aGlzIG1vcmUgY2FyZWZ1bGx5LiBJdCBhcHBlYXJzIHRoZSBCRDk5OTU0IGRvZXMgDQo+
IGNoZWNrIGZvciB0aGUgLUVJTlZBTCAtIGJ1dCB0aGUgcG93ZXJfc3VwcGx5X2NvcmUgZG9lcyBu
b3QgaW5pdGlhbGl6ZSANCj4gdGhlIHRyaWNrbGVjaGFyZ2VfY3VycmVudF91YSB0byAtRUlOVkFM
Lg0KPiANCj4+IExpbnVzLCB3YW50IHRvIGZpeCB0aGlzIHdoaWxlIGF0IGl0IC0gb3IgZG8geW91
IHByZWZlciBtZSB0byBwYXRjaCB0aGUgDQo+PiBCRDk5OTU0IHdpdGggc29tZSBzYW5pdHkgY2hl
Y2tzPyBJIHRoaW5rIGl0J2QgYmUgbmljZSB0byBnZXQgdGhlIGZpeGVzIA0KPj4gaW4gc3RhYmxl
IHNvIGl0IG1pZ2h0IGJlIGJlc3QgdG8gYWRkIHRoZSBzYW5pdHkgY2hlY2tzIGJlZm9yZSBjaGFu
Z2luZyANCj4+IHRoZSBiYXR0ZXJ5LWluZm8gYWxsb2NhdGlvbiAtIHRoYXQgbWlnaHQgYmUgbmlj
ZXIgZm9yIHRoZSBzdGFibGUgDQo+PiBmb2xrcy4gKEkgZ3Vlc3MgeW91IGhhdmUgcGxlbnR5IG9m
IG90aGVyIHRoaW5ncyB0byBjb2RlICsgc29tZSBJUkwgDQo+PiB0YXNrcyBhcyB3ZWxsIC4uLjtd
IFNvLCBJIGNhbiBwYXRjaCB0aGlzIGJ1dCBpdCBtZWFucyB0aGVyZSBpcyBsaWtlbHkgDQo+PiB0
byBiZSBzb21lIGNvbmZsaWN0cyB3aXRoIHlvdXIgc2VyaWVzLiBIZW5jZSBJIHRob3VnaHQgSSds
bCBhc2sgaWYgeW91IA0KPj4gd2lzaCB0byBhZGQgY2hlY2tzIGZvciB1bmluaXRpYWxpemVkIGJh
dHRlcnktaW5mbyB2YWx1ZXMpDQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgYSB0cml2aWFsIHRoaW5n
IHRvIGZpeCBhbmQgd29uJ3QgYmUgdG9vIGhhcmQgYSBjb25mbGljdCANCj4gdG8gcmVzb2x2ZSA6
KSBTbyBJJ2xsIGp1c3Qgc2VuZCBhIHBhdGNoDQo+IA0KPiBTb3JyeSBmb3IgdGhlIGhhc3NsZS4N
Cj4gDQo+IFNvLCB3aGF0IGl0J3Mgd29ydGg6DQo+IFJldmlld2VkLUJ5OiBNYXR0aSBWYWl0dGlu
ZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gVGVzdGVkLUJ5OiBNYXR0
aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gDQoNCk1h
eSBJIHdpdGhkcmF3IGFsbCBvZiBteSBzdGF0ZW1lbnRzIHJlZ2FyZGluZyB0aGlzPw0KDQpJIGRp
ZCBzdWRkZW5seSByZWNhbGwgd2h5IEkgZGlkIG5vdCBpbml0aWFsaXplIGFueSBvZiB0aGUgYmF0
dGVyeS1pbmZvIA0KZmllbGRzIEkgYWRkZWQgYmFjayB3aGVuIEkgZGV2ZWxvcGVkIEJEOTk5NTQg
ZHJpdmVyLiBCZWZvcmUgdGhpcyBjaGFuZ2UsIA0KdGhlIGNvbnRlbnQgYW5kIGluaXRpYWxpemF0
aW9uIG9mIGJhdHRlcnktaW5mbyBmaWVsZHMgKHdoaWNoIEkgYWRkZWQpIA0Kd2FzIGluIGNvbnRy
b2wgb2YgdGhlIGNhbGxlci4gSXQgbWFkZSBzZW5zZSB0byBfbm90XyBvdmVycmlkZSB2YWx1ZXMg
DQpjYWxsZXIgbWlnaHQgaGF2ZSBhZGRlZCB0byBiYXR0ZXJ5LWluZm8gYnVmZmVyIGlmIHRoZXJl
IHdhcyBubyBiZXR0ZXIgDQppbmZvcm1hdGlvbiBpbiBkZXZpY2UtdHJlZSBhdmFpbGFibGUuIEZv
ciBleGFtcGxlLCB0aGUgQkQ5OTk1NCBkcml2ZXIgDQpkaWQgaW5pdGlhbGl6ZSB0aGUgaW5mb3Jt
YXRpb24gdG8gemVybyAtIHdoaWNoIGlzIGluIEJEOTk5NTQgY2FzZSBpcyB0aGUgDQpzYWZlc3Qg
b3B0aW9uIGFzIGl0IHlpZWxkcyBsb3dlc3Qgdm9sdGFnZXMvY3VycmVudCBsaW1pdHMuIEl0IGRp
ZCB3b3JrIA0KdW50aWxsIHRoaXMgY2hhbmdlIC0gd2hpY2ggbm93IHJlcXVpcmVzIHRoZSBjb3Jl
IHRvIGluaXRpYWxpemUgYWxsIHRoZSANCmZpZWxkcy4NCg0KU28sIGFzIEkgc2VlIGl0IChhdCB0
aGlzIHBhcnRpY3VsYXIgbW9tZW50IGFuZCBob3BlZnVsbHkgYWxzbyAxMCBtaW51dGVzIA0KZnJv
bSBub3cgOl0gKSAtIGluaXRpYWxpemF0aW9uIHdhcyBfbm90XyBuZWVkZWQgcHJpb3IgdGhpcyBj
aGFuZ2UgZnJvbSANCkxpbnVzLiBJdCBob3dldmVyIGlzIHJlcXVpcmVkIGFmdGVyIHRoaXMgY2hh
bmdlIC0gc28gTGludXMsIGNvdWxkIHlvdSANCnBsZWFzZSBhZGQgdGhlOg0KDQogICAgICAgICBp
bmZvLT5jaGFyZ2VfdGVybV9jdXJyZW50X3VhICAgICAgICAgPSAtRUlOVkFMOw0KICAgICAgICAg
aW5mby0+Y29uc3RhbnRfY2hhcmdlX2N1cnJlbnRfbWF4X3VhID0gLUVJTlZBTDsNCiAgICAgICAg
IGluZm8tPmNvbnN0YW50X2NoYXJnZV92b2x0YWdlX21heF91diA9IC1FSU5WQUw7DQorICAgICAg
IGluZm8tPnRyaWNrbGVjaGFyZ2VfY3VycmVudF91YSAgICAgICA9IC1FSU5WQUw7DQorICAgICAg
IGluZm8tPnByZWNoYXJnZV92b2x0YWdlX21heF91diAgICAgICA9IC1FSU5WQUw7DQorICAgICAg
IGluZm8tPmNoYXJnZV9yZXN0YXJ0X3ZvbHRhZ2VfdXYgICAgICA9IC1FSU5WQUw7DQorICAgICAg
IGluZm8tPm92ZXJ2b2x0YWdlX2xpbWl0X3V2ICAgICAgICAgICA9IC1FSU5WQUw7DQogICAgICAg
ICBpbmZvLT50ZW1wX2FtYmllbnRfYWxlcnRfbWluICAgICAgICAgPSBJTlRfTUlOOw0KICAgICAg
ICAgaW5mby0+dGVtcF9hbWJpZW50X2FsZXJ0X21heCAgICAgICAgID0gSU5UX01BWDsNCiAgICAg
ICAgIGluZm8tPnRlbXBfYWxlcnRfbWluICAgICAgICAgICAgICAgICA9IElOVF9NSU47DQoNCkFm
dGVyIHRoaXMgbXkgdGVzdGVkLWJ5IGFuZCByZXZpZXdlZC1ieSBjYW4gc3RheSB0aGVyZSA6KQ0K
DQpCZXN0IFJlZ2FyZHMNCgktLSBNYXR0aSBWYWl0dGluZW4NCg0KLS0gDQpUaGUgTGludXggS2Vy
bmVsIGd1eSBhdCBST0hNIFNlbWljb25kdWN0b3JzDQoNCk1hdHRpIFZhaXR0aW5lbiwgTGludXgg
ZGV2aWNlIGRyaXZlcnMNClJPSE0gU2VtaWNvbmR1Y3RvcnMsIEZpbmxhbmQgU1dEQw0KS2l2aWhh
cmp1bmxlbmtraSAxRQ0KOTAyMjAgT1VMVQ0KRklOTEFORA0KDQp+fiB0aGlzIHllYXIgaXMgdGhl
IHllYXIgb2YgYSBzaWduYXR1cmUgd3JpdGVycyBibG9jayB+fg0K

Return-Path: <linux-pm+bounces-783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2C808445
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 10:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84581F22848
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E045D33089;
	Thu,  7 Dec 2023 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="o+U0hRHA"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED78619BE;
	Thu,  7 Dec 2023 01:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPUvRoi2egXEfsJ/JDqu14PiMQSsg+HuTJW0Blh0nYzumEd4NrFLA/4XOGTyaIagD7waZc22StL0xJ7GVLR0qk6hpqiM5gAbktl2JY/iONaaMTuU3gKiJ94es2mAk3i6apc1nPOR9BSdHWqGhHM0fjqOV/0R5MFB0DPQy5auxsbA06EA3UxZHOVFT/ptdqml/RNWF8yoJDYKkCkG90qA5Qj97thTbVXN+XFvFNm34U8seWUGqsgod474yXlZ7UxpbbLAtzeTdQhH1wwytVKyPSuEYDMMvgIAffZp+4SqQJZqDkH6KCR1DsrDZOLrb/7wk+xFIHPOSndFUFjpfqAZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ib2YzR9Wpct9tY0xDR3Hn7RrCTAdU80Q7P33OF5nT4=;
 b=K7w+KSLtdrnTFkU0UUM7QBbF3dN4goTg9evQplI7NMtBPFoSP1PfK8Ly3pe7HaH/Bo7yC82ipmhLd4F+FeOW7pk7EfqPFv0yauLKOo0D3OZ3kibqp9cT4+2xjnyM/CWchgpjTilwCvRE5nL/WnN2+Inny7LXkkdfzsvc33ANLmugNd8Wl3pFe49S8Jy1dIB/F155KdvOMiIvJf0SLarraRCqB7oFjoRc07yLTS1Dd9AilWA09TFxqughwZRmWjahkOR2ZQrZO2hGTgzhfQKantxDBjgry0XxfJbpftTHFXhFANI2uzuAr9/4WAohIosc7LCuQYO+/ZRypkdax/n1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ib2YzR9Wpct9tY0xDR3Hn7RrCTAdU80Q7P33OF5nT4=;
 b=o+U0hRHAmitgPw9uer46OWv0HByG6yUsLSz1eFlYOuZ0XLpc+7G+/vNj3Jtb9mgGPQ/YiCKdT1QGeiLBmstqLOpIMrvdIpjSfrKeMf59ZMGXfv2yEHfsvZSOmCwYNiYS/9pW1EPBSlRZhO8w7q1pHz1cZvUuhR1XP7xm+i9N6MA=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB6312.jpnprd01.prod.outlook.com
 (2603:1096:604:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 09:20:31 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7091.010; Thu, 7 Dec 2023
 09:20:31 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lee Jones
	<lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Support Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Steve Twiss
	<stwiss.opensource@diasemi.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Topic: [PATCH v4 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Index: AQHaKFz3HbsQIYu8ikSsYixCn8jyCrCdgLMAgAAE/aCAAAWVAIAAAQQA
Date: Thu, 7 Dec 2023 09:20:31 +0000
Message-ID:
 <TYCPR01MB112691F7F57F976F813072E14868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231206155740.5278-1-biju.das.jz@bp.renesas.com>
 <874165ae-c7a2-4f04-825a-aa9d6f4d4cb3@linaro.org>
 <TYCPR01MB11269663E4EE04920195D708D868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <22597bf1-b623-4c5d-b230-c2054c4c13b5@linaro.org>
In-Reply-To: <22597bf1-b623-4c5d-b230-c2054c4c13b5@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB6312:EE_
x-ms-office365-filtering-correlation-id: 2fa977a2-3284-470c-be88-08dbf705c29f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1++CPJAy7kh01+BErFL7Bbc/yGaGLQeygCUfLJnlXb87uS/TL8ohF5R1l+RJYC1P7YoJc2048mGT8dy+02IQkgCnP7zIIweyY9Scstt4savyDlZUjFjQegVIjvi23uM7lcJ7KMFcZHnRErwUEg21R3aBL3pt0KhClpFtNNbRHRa/bY3OQWoo2dwUUfCDHyS9zqnAmg/J7riHFwEBKf7ARDhoRTPKgVm+Bf/DxQwuF2RcQWgCqszhKDLCVr7Ry6Sqm7U5TfPni4MbAjIoUBcO950X8N3tVeJuhqXmAm+LznouSboLzIjHdkhJnFuLO6rN+QxdtcgkDrVM923oe9xx8Omg21ICqZ6QFckU+R92osUhg12LHnoqSShcrv90bVWPLLO232RQ39z0SgFOWOnItji853uNKWnxEs/xkYQOS5/ZEdZVC8L0OHKZR2dq4sHCGSEkRwCLzVdEmggSBn61mSm6L9f41SIcKH+tZcasGWWnV83i+lvV5ibbwk2rGPO2XZ9txtEWF3Gyn1c6uyDt9vh/D+GCIsua5a4yg+yKWUzuvwThWZ9xIRcD3pkNaRvU5Kz1u1fIfQ+pLjlmaL4XVBZC3YJPHc9+K4Jm37UQxMiCLGKx4yjXimy2IHFvCpFu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38070700009)(55016003)(316002)(7696005)(478600001)(6506007)(52536014)(53546011)(26005)(122000001)(4326008)(71200400001)(8676002)(64756008)(83380400001)(8936002)(110136005)(76116006)(66946007)(54906003)(66446008)(66476007)(66556008)(38100700002)(7416002)(86362001)(9686003)(2906002)(41300700001)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXhEYW5lSUg0R210VzMzaXRYYjNuckFNTXNwNVhyV3FEem9ZWkhtYUFGbnhC?=
 =?utf-8?B?ZHpGUm11NEtiYnlkWGk4KzI1ZlUrMVRadHdjbGljYjljaDVZRUg1QjdINGVH?=
 =?utf-8?B?aXlGS0FNdkc0VUsrYS9Ld3NmdGh3dlkwYkk1ZHBmekdCU2pLYXJTRVJySHBJ?=
 =?utf-8?B?aXRZVzBVb2QwcHlPbnRJclZqRDBraTJYeFZEUnYxZlpRamt6V2Z1NDAvZERI?=
 =?utf-8?B?UHZDSncvbFVtU2lVMmg1NnVwUlJXTlBZZ1NyVGxQazNUK2MzQ0p2T0t4Mk5U?=
 =?utf-8?B?Q1NJcWExZ3pXVUpRelRXSG1DNlRYbEVyWEplK3ZBckhhYUF4YnU1NEhWSjk2?=
 =?utf-8?B?MGpPSE1lOEZCUUQ3bmUvMlpNNlVUbzh3WkFqY3I1ak1qRGpjaGpiMk5UQS8w?=
 =?utf-8?B?eURBbU9WZFFpSUd2R1dWZ051bWUzdkVnUDBFa09lUk1uYXZJTVEwbmtldnJw?=
 =?utf-8?B?OWhsbHJZYXEveHYwdU92K1JOZmNMc0RJSzNWbGh2dStmcnZxLzRmOUxmM1lp?=
 =?utf-8?B?QVpkU2J5NGZ3QW4wbytXT0NPM0VzcGp1WnM5MkE4c09kU2lrZG5HSGJOM1NU?=
 =?utf-8?B?Tm44N09pN1RnZUxOUGFTN3ZUekJ3dWxJMysrRzJtYWRLVU93aE5RcEh6NmpU?=
 =?utf-8?B?QVJCWGx3emYwcVV5MVgyTHY1L2FVakZGR3BIV29rMHJVbHY1aWtVNWMvQnJ0?=
 =?utf-8?B?MTY5QzIzcEtPMzZqME43ZlZ6QUNPUkd5bGdvR3QvcUlDY2FUb2h3NitaWTIv?=
 =?utf-8?B?RXpHeGFhMjFQbGxkeFBTbElCWWlITUxNQnZYK2xhamxDQjhSY3BwMmhSMzE3?=
 =?utf-8?B?dkQwclNrdFBYa1M1RHE2VElDZ0wvVGhoZjNnczFwbkNFcnVHcVg1eVh4T3A5?=
 =?utf-8?B?bHBra1JMS0I5Y0hybnNpMkpqa09vaUtwS0lpT2puRjRUK2RjTFY3L0dsUWRT?=
 =?utf-8?B?VTlZNXFOTlBJNVR0Vmo5c2x6ZGt1QXczZDI5Unc3UXlRVXgySmZ6YmxUTHpB?=
 =?utf-8?B?bWtqZUdoNnZDbTRHV0pHcHV6YWhjQkMwQVZmRGQ2WSsrYUNZUFF4MEVaaXEz?=
 =?utf-8?B?WlhHUUFJUDhvbHRSNzRnYk1iakZvWnM2Q0dhdk9FMVhNT0dPM2l2NXBjWGMr?=
 =?utf-8?B?WGRlVVp1QkprL3VHK0tHK0hhdGFUaHhuTmN5T2p3QVBtTTZhbEVqUWVydHNh?=
 =?utf-8?B?SDBWbGFoejdXNmdFZzVDbHl2VUVKU05rYWdLSlpkbFdWNHk2c3oyQ1JSdXVP?=
 =?utf-8?B?SVpuSWlkMTNhZXJTd3RWWjVPQkhaT0FhTXZJS3kyY3ZaVy90MGlUWVVUNW1a?=
 =?utf-8?B?Nk5INjRraEdQaXhPRGh6azB6YWNaQVM4WDdtZDZXU1pNZk8wZmZLSUZvWlBu?=
 =?utf-8?B?TFdYWmRYbjlXYW42ZWhqWVNRbHBmYWR2ZHM2U1ZmRld6bm9GV2V4V0lRMnQx?=
 =?utf-8?B?RkFmZnoxU2ZVNDQ4d1hMNlBQYUNBbzU1aTdNTzFrL1FWcGtlK1NDd1Vka0ZU?=
 =?utf-8?B?REVaUHlVOTRZb0tJM2NvWTlCM1QvdlZ2RGtuQXBSMnNvbTVpZEtkV09JcUZP?=
 =?utf-8?B?SmVSanNQMk53Qm5UT0lpU21Xb1Y1SXNqbTdZK1hETTFUVmtKWmhYazgyN3FC?=
 =?utf-8?B?eFBGc1B2YjdMRVJHT2dPRWVKOWNod2xmbmd5Tmgza3JhS294dS90T1crQUVU?=
 =?utf-8?B?Wm1idlFzczlIekRsaitqUGUzbURQeWVhZmxGTUYzd3lvbHdPeVlleHJ4YklH?=
 =?utf-8?B?akhqZHBVWFM5azRxNUt5UUxHd3ZsS2UxQjQ5b0Urcy9VeXpkc3BXczFuRzNq?=
 =?utf-8?B?TWRqRHd3RVNDNGQ0OFBzbEh4WTkwa09EQlBSV0lJcWlDbzhrQXRwanl2Wkpw?=
 =?utf-8?B?bm52azc3LzVrQUJ6SDA5MUZLd3RQZEhpR0VDM1dJM1lFdFdnWXhGdU94T0Zr?=
 =?utf-8?B?Z3FVamYrMGpUOXVwTEZuWGpDcHVMWmNnclg3QUw0VmhvZTRJNTZRWDNlV1RU?=
 =?utf-8?B?WWw2VFNIU1d5Y0lwcFAyYldVOGZPR2drdGFNMW16RjNvaEkySHJSOXlqVW1H?=
 =?utf-8?B?dE10b0FXN0E0ZHIyeGUyY04xSGRlaWhBVEYzT1NtM2F4STEvZERrQU83RzJi?=
 =?utf-8?B?VGZCTzBzUml6eGpPQ0gxaHZhMjFvMVlQOThTR2NRaDZneDEwdjNwelZTZDlL?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa977a2-3284-470c-be88-08dbf705c29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 09:20:31.4782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REu65XMKg6NKHA0Jn7byW6l2W07avekNikgDn9hDh+7AuLWuNNg4wpNgHLsO+kxyh4/g/vxcwSkB9wFskp6I619Zxmyn02gXicDheXEN/uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6312

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciA3LCAyMDIzIDk6MTYgQU0NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NCAwLzhdIENvbnZlcnQgREE5MDZ7MSwyfSBiaW5kaW5ncyB0byBqc29u
LXNjaGVtYQ0KPiANCj4gT24gMDcvMTIvMjAyMyAxMDowMSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4g
SGkgS3J6eXN6dG9mIEtvemxvd3NraSwgTGVlIEpvbmVzLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDcs
IDIwMjMgODozOCBBTQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvOF0gQ29udmVydCBE
QTkwNnsxLDJ9IGJpbmRpbmdzIHRvDQo+ID4+IGpzb24tc2NoZW1hDQo+ID4+DQo+ID4+IE9uIDA2
LzEyLzIwMjMgMTY6NTcsIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4gQ29udmVydCB0aGUgYmVsb3cg
YmluZGluZ3MgdG8ganNvbi1zY2hlbWENCj4gPj4+IDEpIERBOTA2ezEsMn0gbWZkIGJpbmRpbmdz
DQo+ID4+PiAyKSBEQTkwNnsxLDIsM30gb25rZXkgYmluZGluZ3MNCj4gPj4+IDMpIERBOTA2ezEs
MiwzfSB0aGVybWFsIGJpbmRpbmdzDQo+ID4+Pg0KPiA+Pj4gQWxzbyBhZGQgZmFsbGJhY2sgZm9y
IERBOTA2MSB3YXRjaGRvZyBkZXZpY2UgYW5kIGRvY3VtZW50DQo+ID4+PiBEQTkwNjMgd2F0Y2hk
b2cgZGV2aWNlLg0KPiA+Pg0KPiA+PiBQbGVhc2UgZXhwbGFpbiBoZXJlIGRlcGVuZGVuY2llcyBh
bmQgbWFrZSBjbGVhciBtZXJnaW5nIHN0cmF0ZWd5LiBUaGUNCj4gPj4gcGF0Y2hlcyBjYW5ub3Qg
YmUgdGFrZW4gaW5kZXBlbmRlbnRseS4NCj4gPg0KPiA+IFJvYiBtZW50aW9uZWQgaXQgbmVlZHMg
dG8gYmUgdGFrZW4gdGhyb3VnaCBNRkQgdHJlZS4gU2VlIFsxXQ0KPiA+DQo+IA0KPiBUaGlzIEkg
a25vdywgYnV0IHlvdSBtdXN0IGV4cGxhaW4gaXQgaGVyZSAtIG5vdCBpbiBteSByZXBseSwgYnV0
IGluIHRoZQ0KPiBjb3ZlciBsZXR0ZXIuIE5vIG9uZSB3aWxsIHJlbWVtYmVyIHdoYXQgd2FzIGFn
cmVlZCBkYXlzIGFnbywgbm90DQo+IG1lbnRpb25pbmcgdGhhdCBub3QgZXZlcnlvbmUgY291bGQg
cmVhZCBSb2IncyBtZXNzYWdlLiBTbyBob3cgYW55b25lDQo+IHJlYWRpbmcgeW91ciBjb3ZlciBs
ZXR0ZXIgY291bGQga25vdyBpdD8NCg0KQWdyZWVkLCBXaWxsIG1lbnRpb24gaXQgaW4gY292ZXIg
bGV0dGVyLg0KDQpDaGVlcnMsDQpCaWp1DQo=


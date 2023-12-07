Return-Path: <linux-pm+bounces-780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A698083B7
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 10:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FB11F22787
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8731739;
	Thu,  7 Dec 2023 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XDIDdG8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2123.outbound.protection.outlook.com [40.107.114.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C8310B;
	Thu,  7 Dec 2023 01:01:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1QFDaY4Qt35NG/tsqmZKRXEL1272AG8t9hPX0rutdzUCsRJfvvBe6eN8BqzlUpSfmlMrfYuOCY3JYho0hJN7wL8FwOMicbbUuXd71cUZ/cENz6uQXB5tXrxFFP6oLWybPglpsoY9EHFLpJz1jSI7Y8/jMCtdZSatRoYs2YBGOZHGpXXQJQbXRWF8o3ETYwV6Hhac9/XLDT5muCS3nRf0Al3GyWzTCao5KsPWlS7GM3f8QwLrAgptCU4z23qc7VLv3c4ZxGZSYttnnBvBbLzCt2BuqOk8FXJ5GYdYGnb3ixKqTjuL9tRc8ptpmQ3hkqcYA9WljkdCorqSwKhgFQfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3+MYSmHisuelDjPvQbnR8NxGh1ThqpmoouvP/7f4L8=;
 b=SwZXgbxgLGT+50/gmbRKm+RN0ar09mClDzFs+LHlPzdfudlnp9S1IT5Cd9a0redlKI2mGFarhzOzDcPTtUEd2Txd+a91kcL+6h/ZmWnLbde4manxXTLuEbuDDUItnFjuyI8LHUPtL8jf5P4DbamxKxtButiaix1lF+1W/l+kCdYqm/xcWmfsED2JENzNMxD+iQD4pXJebwGaxM7GAwXmLuKcWgz1YZzGuCXvsX4iH1Ac1jL0Kp1yCjYPlSjY3jUJMF9XFP3zsINBoEe0z/gJr8dOibBJj3XsMOz3GQAPkZuNyv0FH4mylNJk6YIpPrNCLhg2AsI2ky5WXPwyANY/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3+MYSmHisuelDjPvQbnR8NxGh1ThqpmoouvP/7f4L8=;
 b=XDIDdG8A3fpbaNxKqS7WPGb6PIAkVTpU5n50Ml2GHjbFP0r5VnBpQg4t/xlyETm9qrA0kO/qDaC42Q3AAvWmBH4eC+30xHwJaaxX+IdNIxkePArr+SRQeh04X6ny5ey+xqeP7bXEmVc2zzHd5+MftjwSWPD4Un9MircQluQtzoQ=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB6273.jpnprd01.prod.outlook.com
 (2603:1096:604:f3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 09:01:15 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7091.010; Thu, 7 Dec 2023
 09:01:14 +0000
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
Thread-Index: AQHaKFz3HbsQIYu8ikSsYixCn8jyCrCdgLMAgAAE/aA=
Date: Thu, 7 Dec 2023 09:01:14 +0000
Message-ID:
 <TYCPR01MB11269663E4EE04920195D708D868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231206155740.5278-1-biju.das.jz@bp.renesas.com>
 <874165ae-c7a2-4f04-825a-aa9d6f4d4cb3@linaro.org>
In-Reply-To: <874165ae-c7a2-4f04-825a-aa9d6f4d4cb3@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB6273:EE_
x-ms-office365-filtering-correlation-id: ca93fd52-7313-4be9-61ff-08dbf7031138
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YYj7keJ7CfzH+mVm+euW431tp/ouKv+Xyj8e6RaaFZtMOSYnoG/rg5WeBZNgRKQ7wHPN/alssd2uR7U54IsiztsbBjCOYxJCd9bjS6wS2y4rhzjD7HNGHNuTLGxn70RuIpWanFBjzYw5DF5qoGezicXbb12C5ClXh0TMU7nR6DeXz30IO/qtd7xtGUMKzE/19p+dI2a5upCkhy92woIpHocJxovRIVjcOQPorYHEECzPwwPVR0kTdvQlZHjCasf5FlZWOFDdNHPDzYonVun4r78UeFtE7Nos+n368vha2pC+kpI2Xh3t1PDX8bYjfXD+fz182pG640BoHBZPXnfbuaLM+w09jg8ZxmCyr77sYiqHR8rZCEpvdd3Y4YOVXBq1rX1IHnSo4g6sLQYfEyKTPW/xqV7g2NE3PGxGTCyiJyIrFlD678oZsoQt9LZuQuhYE5jykg8EgelyGy+piSVRZLjRQ+yDlT23f0THJBXIKYJE5PvB7AyRFy0vAV0oqIce6YaGVAwr+mC5xzaxzI6nqhx1loJS6h+wFuycw+rVtw6jqyFaKxwtN0dGH+yliPymZ1ORgNpPXd+2HMjqd6xGEStgf6hYK3VnpLIoxF/I2Xc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(9686003)(53546011)(6506007)(7696005)(38070700009)(86362001)(122000001)(38100700002)(33656002)(41300700001)(26005)(7416002)(83380400001)(5660300002)(110136005)(4326008)(4744005)(54906003)(316002)(52536014)(8936002)(2906002)(66946007)(55016003)(76116006)(66476007)(66556008)(64756008)(66446008)(478600001)(966005)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHR5V0t5U1pOVklrWVlXMzlwemZWWm00b0xsd3IzUFpjeFNUOHQ3Q1VuYzdX?=
 =?utf-8?B?UUtFOFpPMHR3TzVIbkdjMzJERkxIMlRVa1dBNDBRWHdVbDJqSkpiVngvdStI?=
 =?utf-8?B?RXlpT3M0Mnpuc1FnMUVwSmdqQlBRL3UyQlQvcGlVbWJydE1UQ0oyakthUWJS?=
 =?utf-8?B?Q0ZPZ0Iyckxlb0dCU29nUHBnSkJZSVdycitSTkdTd0tWZGNnc0VBcEVXNFF5?=
 =?utf-8?B?dDI0ODRTNkVqTlNRbG5mSGloT0hsL0xQRVZDZDV0aGdiUStoTHRNS2IxYlJz?=
 =?utf-8?B?YWVjc3c0UG9sUE0zVlRQd0ZLN2JDaWI0eFp0Q0ROZExlNG4xYnAwY0hpd2o2?=
 =?utf-8?B?a3BBczFhNWJCbzd6VmpxQ0p3NFBxb2ZUcEhHVG5qTEU5U0s2bUF1bnlyT3JL?=
 =?utf-8?B?OTl3VkN6S3JwM1h6YVhyUUJKV1JDekt4ckZtL0kvL0ZHNERHdGlwVWdCTVJZ?=
 =?utf-8?B?TUxGaUVIdTdRYUZBMkdaeFZ1TGpEWTNiaFdiV0ZPN2RMYThUUkRYZlRBYnNz?=
 =?utf-8?B?dlgvOTRxRTFEY2hHdFk3WEhZeTNnaWhRZGNXNkd0cU5zdWRoOUsyK0drWUlU?=
 =?utf-8?B?RVZBUzRTb3l0NHR2MUUrLzFhekRLTFNRQWxOcURWK2I2WmpYUy9XL25hdnBT?=
 =?utf-8?B?Y3N3MU1sUVYybXYzYTVuWGd1b2VZVVdyUGtKYkNPQWl3NjFhZm9ZaGJubDlq?=
 =?utf-8?B?ZkNuNzdpR0xPV2dZcVpxM3Z6Qlg2elhhdm94NUJUenJ6NWNkeUc2ZHZWWFQ2?=
 =?utf-8?B?YUIrUkZtNFJoR0YreWY4ck1nSkliWDFtb3NGMkdxY0FtVndhTTZMem92TnRT?=
 =?utf-8?B?dkZhMkg5aXhyaTJ4dE1mWW1jdnJoTEJseHRvU0pqa1Vmd25Qc1Q3cW03UHJF?=
 =?utf-8?B?SEdlSnhZMWlzd1NkbXRSY1JCVEF1N0dXaTVpdjNBd1Q1QWI2RmR1K1YxaHhC?=
 =?utf-8?B?RGNrbmJwcVkzSGpSZ1Vka0FIblF6c3grVHNzM1krWE5BbEVid2Mvb2czQnJV?=
 =?utf-8?B?c2Z1a09JVmJqWGdsaDJZS0w1akFqcXY3UVdTN1dPdzFoYm5UMHlsdjJFaFNv?=
 =?utf-8?B?TTNQaVZWS0w2cC9HUU9iMEpTNzd5cGFiUWdVWk1ZczhyQVRRQXNrTlJtNm85?=
 =?utf-8?B?d29IZ1lNdnNQaUt2aFRxREpPWWIrSU1BVXdEbEROR01jeHQ5VmI4aDU1VkRW?=
 =?utf-8?B?RGtCUlJqZ3dIU1FxbTMzdFlwM2VudkcrNC9tRTZBMk9rOVJSNnI4Y21JOWEy?=
 =?utf-8?B?dy94M1dyOUt0QUVqZUFFNVpGbXZUcUorZWZ1aVFGckZuOVZGQk1VVnIxeTBX?=
 =?utf-8?B?UCtGK2hJUTdvNEdpOThGS29YVTZHQzJiNU9nZlJFSFJ3Nm80QWlqaEpUM1BH?=
 =?utf-8?B?WVdhZ3g1L3prUURyZnNBM250L08vaExURTNyOHVSbFdpKzkrUFlCcXdvL0xx?=
 =?utf-8?B?eTdYRGlIYjZFYzZHTFBNUXA2L01BellQVTJVS2N4NEYxVmRVUm1aMnhVcnJ2?=
 =?utf-8?B?Tlo3OGI0UCt6MmZ1T0ZSMWlXOHBQMUZIMlRCSUIyYU8xQ3puNlZaallrVkln?=
 =?utf-8?B?M3Jsa01HVi80a3p4cWx2MzJGN2dUcHZnZVRQK0l6eFRFWE1UZTRZOUhaRU1X?=
 =?utf-8?B?UkNmWFlCRk5yNjBldDBLd2QrNVBDekFvZXMxNGphdHdqbUVGbWdFYm13eGVr?=
 =?utf-8?B?dGRxeEE0WXVWay8zN2JRME5qbnNxd3djL1hTN0tvUzNHZSttQUtVREpjQTJX?=
 =?utf-8?B?cmRiN3JoWkwwZFEwWG1RYTRNTUFWcVZaWUpTQWJDbklZMVhyMXFpYktwUmIv?=
 =?utf-8?B?SExlQXVLRlVhWDlWY1RURWhtaFR2ZTAyQ2FZUFZETHZXUUhMcmZ1bmVlcDhO?=
 =?utf-8?B?NU42Y3lkQzNJb2YxQ2xFYmxHQ0ZsdGxFcGhkVUoyQ0FJUlkzakJpc3FwcE1z?=
 =?utf-8?B?MXRPcmRSdCtmdzc2cEladlB2L0VxajJHZEVYU2pSS3U2RVFUUU5BZUhKclcx?=
 =?utf-8?B?OWZoZzd0bDdORmFWS3dyQThuL0U4d3ZKa0o2ODhzd2dCWWI5UkdTVWtzUDRS?=
 =?utf-8?B?K1BlakR6RVBVcXJnVmxYY0s0YmlDdGxlSjluRm1hZlhhNDFGTWVNY0p1Ti8x?=
 =?utf-8?B?MFlNRWhqSU5IRlRIMzRHSzEvN0t6SEwrVjVYV0dwSmJNNGgzWXlxUVpBbTVC?=
 =?utf-8?B?VVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca93fd52-7313-4be9-61ff-08dbf7031138
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 09:01:14.8717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3XcYw7pdgYLwPBziM4IC2ljUTty3esByG4UOZfyCBDRY0Vr1H1Ow0NbjSVrgrfiHIKmBsrRBZKPoXFHmPSJV5g/avnGkKlrI5rYt7zaACE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6273

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwgTGVlIEpvbmVzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2lAbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDcsIDIwMjMgODozOCBB
TQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvOF0gQ29udmVydCBEQTkwNnsxLDJ9IGJpbmRp
bmdzIHRvIGpzb24tc2NoZW1hDQo+IA0KPiBPbiAwNi8xMi8yMDIzIDE2OjU3LCBCaWp1IERhcyB3
cm90ZToNCj4gPiBDb252ZXJ0IHRoZSBiZWxvdyBiaW5kaW5ncyB0byBqc29uLXNjaGVtYQ0KPiA+
IDEpIERBOTA2ezEsMn0gbWZkIGJpbmRpbmdzDQo+ID4gMikgREE5MDZ7MSwyLDN9IG9ua2V5IGJp
bmRpbmdzDQo+ID4gMykgREE5MDZ7MSwyLDN9IHRoZXJtYWwgYmluZGluZ3MNCj4gPg0KPiA+IEFs
c28gYWRkIGZhbGxiYWNrIGZvciBEQTkwNjEgd2F0Y2hkb2cgZGV2aWNlIGFuZCBkb2N1bWVudA0K
PiA+IERBOTA2MyB3YXRjaGRvZyBkZXZpY2UuDQo+IA0KPiBQbGVhc2UgZXhwbGFpbiBoZXJlIGRl
cGVuZGVuY2llcyBhbmQgbWFrZSBjbGVhciBtZXJnaW5nIHN0cmF0ZWd5LiBUaGUNCj4gcGF0Y2hl
cyBjYW5ub3QgYmUgdGFrZW4gaW5kZXBlbmRlbnRseS4NCg0KUm9iIG1lbnRpb25lZCBpdCBuZWVk
cyB0byBiZSB0YWtlbiB0aHJvdWdoIE1GRCB0cmVlLiBTZWUgWzFdDQoNClsxXSBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmVuZXNhcy1zb2MvcGF0Y2gvMjAyMzEy
MDIxOTI1MzYuMjY2ODg1LTktYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20vIzI1NjIwNjM2DQoN
CkNoZWVycywNCkJpanUNCg==


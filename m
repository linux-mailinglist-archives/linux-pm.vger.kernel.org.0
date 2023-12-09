Return-Path: <linux-pm+bounces-857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A680B543
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398291F21439
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E51F168BD;
	Sat,  9 Dec 2023 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FzxRxF99"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2118.outbound.protection.outlook.com [40.107.113.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F410C9;
	Sat,  9 Dec 2023 08:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYqaHPtlUznZFMKR3m4aRmqaDGfyAo+WGJPMgYv2Fk2fTbyOxJKcJM8qqvqAFblPSKlZuRNMwRkkH5Sly/ebK60xFHqGyCFQ0qeQFuVLJpft8LOdvQEcNVwItsUV4a1a+cIY+O4sNMMSFbVi9MY5JG4jj0HCXaIeUYsYtj6oFNoHPFBrK29g/g6CMag0QwNK3T9QWYXJDBPLDidb4aqGyHbStgYpKIGt9t7gqDgAH9IOejSWtDoOSVZAUgivJfIUwS/k1t83PXrHGF+qQqGNIxVBxV1AGX4am3gMkPs1WR4EXD3R+9Ik3VJtTKG6fob+z0id0eKXTZvyj8SNDDKNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7ylFf26GmYz9x02dtd9p6AsrLWz+3NCTAXnqkkszbY=;
 b=dKMJfzInSMmeyhE8ghl/uzwvkYeO2QlinTb464mevp1v3iuxgar/5H6sJ5rcd2CLPiEN1XOh/Sd2YBGxtJcUYOOmV+Zc+pj9dHzjK4wfyT57h7hVVNxJJI/+gdOvHpaATZgOvOAt8dAF8ZA9zg3jYj/1FaXvmK8zNkHE2n/f38RhK/H37gXi/Wd5NAXJEqoJHwdZPXCztgQm4anNuj6mmCjq9vKiOAwj/0QIcHrPiti1FeSoj9q04mASzHr5aWMlQPcSie86Xv1PgDP43bkS1kb2+K/ba4YWLH+x1hwW0sYcEP41BzcaAMz6CklZzDbhcbyQr62C12lcaSmLueLCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7ylFf26GmYz9x02dtd9p6AsrLWz+3NCTAXnqkkszbY=;
 b=FzxRxF99Lt1OnSYbrH9pYRWSkOvN4ylTOg9K5erKdJUtXm2aUR0wdgezE8QY8dG8R0QI4t4lBxHCVMs13vVesli7S6/RU9TMXV6JYK4Z8J03uW5vD183FhueR96urS0GvEtiSQ8C4sdJa8T8tV9rcsV2KjhAmnFgk9EQXgeFE8g=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 (2603:1096:400:1e3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.19; Sat, 9 Dec
 2023 16:38:03 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.018; Sat, 9 Dec 2023
 16:38:03 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
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
Subject: RE: [PATCH v4 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Thread-Topic: [PATCH v4 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Thread-Index:
 AQHaKF0O3M4G5vsMkEy5OPyHlzeaZ7Cdgj4AgACF+8CAAP7tgIACEfiQgAAJ1wCAAAZlMA==
Date: Sat, 9 Dec 2023 16:38:02 +0000
Message-ID:
 <TYCPR01MB11269DB39303B9FCFFD8666808689A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231206155740.5278-1-biju.das.jz@bp.renesas.com>
 <20231206155740.5278-9-biju.das.jz@bp.renesas.com>
 <114c9baf-66d1-4055-a47c-916642b6dedd@linaro.org>
 <TYCPR01MB11269C774B8FFE9E43455EB61868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <11ec89a8-5fdd-456c-b070-988bbf8f312d@linaro.org>
 <TYCPR01MB11269F887AE07FDA09F19112D8689A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <d9ede094-10db-4789-8157-4145faa03f53@linaro.org>
In-Reply-To: <d9ede094-10db-4789-8157-4145faa03f53@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB10082:EE_
x-ms-office365-filtering-correlation-id: df3b3354-497b-4faa-4c7c-08dbf8d5365e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZIpCdekKZiex1zvlWDR6NiPpp1jAhx6vSeU2QdgMDTSqRDT+KmRD6xaPaOMVJkwMgF5OaZ2x14neoXyGljb7r0lu1QrLza0V8V1WENr0tqVQ7pMeJOQLPMKlUgAZxoRE7mSbMwPcpIT7Cn895b//mKTtFiTFRzOjHGhcgT4btvFMU6XEdBD2ZQIs9X6hj8d2EuI23iMdapbbeqY3KvMYh2L78+UrmXGgJOgUetSl0leZ8Lqmr3pvbFJY25D89VPdi9NuNq+8wLp27G+NxI0h78fcwKCJsvThn+zMy4/yWLy+TYxuR/xBa4Lm1uoLD+LCfpoS5oFWBh1q+dJgcOMSwM/hoEKomFYqITyQVEXGDhTu/DsD0nlAlMHSZZ5MS0EOwg/9piVXvwP9pGcupOlgYmjxpHKeQH47Ja/YnOVvpNNvg1YlVigVg1QXfwQWZO2n/PP9+CXCBQdh56r50vuQjpB2k60tksGl2CPqMkA/S5OcE6ElMOep4IXCrBbD4lljdVFYULRLb/ve3JZQuFP/qS8bqzly/OhE1XSgLTndZA+7djDuJn/U+IeS/rpVn58xR7G/yfXWMBYm2zBQ0AxJDpwxgXq0SKO6XmU35W8jC3ioG/IAJj7ETE+799wgNKr7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(6506007)(7696005)(71200400001)(9686003)(53546011)(83380400001)(5660300002)(7416002)(52536014)(41300700001)(2906002)(4326008)(478600001)(8676002)(8936002)(66946007)(76116006)(110136005)(66556008)(66446008)(316002)(66476007)(54906003)(64756008)(122000001)(33656002)(86362001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTNFRlhqTWFzVkdmc1JFaDdoUzBqWFQ0T3dvRHFtS0ZjNGhTR09HYURUTzFl?=
 =?utf-8?B?NTlyU0ZtQmlHR0lRTThDWll1RnVwR2JaVTBoSVJmY29scURnc3pwcDZpL2Vi?=
 =?utf-8?B?UnV5eHBJZUExOU9UZE5xL1d3cUNPN28vOXFFU3Y4UjFXcThwTzdwTjcvdVpu?=
 =?utf-8?B?d2ZoQnFNL2VlaUp0UnVWb0UrQ2wzT0VpTllDa2hydXkwMFBZWFM3ZnZFMUdi?=
 =?utf-8?B?TXJydUxrb1VqdExzU2ZhdkwrbVM3KzhtUmdBTXIrbGdIelJxTjhzUzl4U1c1?=
 =?utf-8?B?ZDVzUFd1T3pVNU9TUTE5RnNJRG1FdkxUR1hhS2xnYXhsRGxKUmFGQ3d1YnNn?=
 =?utf-8?B?NVBldjE4RGlsc3ZnL1dOYzBXTjdhZ09PUGRhb3BVSkZjRE9vbGhPa1VXZURJ?=
 =?utf-8?B?d2pjdmVwMXBLWDZ2c1JhajNQcWJLdlVFV3Jpd2h2UWpkTC9CcUU3MldHbVRF?=
 =?utf-8?B?MkYrd1I5SE92Q3NPU0dWK1ZDcGJ4TTRkd2hXVWplUVpoYjI2VzRIMTdOMkRY?=
 =?utf-8?B?NCsyNjlUaHJRMUZZUE04aHlMVFZYakpRUEp5WnhYNWhCZFVOWm9NYnF5WmhM?=
 =?utf-8?B?bU03Mk1KYzBjVnpvbHo4b2g1aEJOSjNldmVPQzhTZ3ZRVjcraGQza1BzT2NS?=
 =?utf-8?B?U0VrTGVGNThpU3gyMlc2b21SLzc0U3JRcjNBVWYxUzNTclRXMXRoK29zNjMy?=
 =?utf-8?B?Z091OEZMNzFCcFVWUEkzckpDbzY5K3BiZ25uMGxnUlBwSkhTeHFoVUsxbGg0?=
 =?utf-8?B?VzhQeXlCaXhLRU40dFFSMXZqRjQrcFlpdVJuM3dKeGp5MDJ2cXFsSlhSc09V?=
 =?utf-8?B?dWRlZWRaU3NlV1FldmMwOEFMekduTkVFQjIycFYyMDVVcmh2bXNMaTQ4UzAv?=
 =?utf-8?B?TS8rSHZmSjZIbk5YeGJadWNxWnMya2Q1QnMvRDBFU2JUcm9MWnJPNnp4VGlT?=
 =?utf-8?B?Q0s4ZEJLaDVUSXR4eFVnVTJQV0Y2UlE1WE5HN292OUpJQ1AzekpKaG9ZMnRW?=
 =?utf-8?B?RVh4ZVNOQlIvdmVWZlZTcUg2QkJMSXBTU0xxSFJMWlVsZXVQeUJwRDNWM1A4?=
 =?utf-8?B?TWtzUzF3MVhVNTgzZU5KRzZtR2Y0UUF5T1NXZjZYVnU2YzAxdGFyUkJzcTJm?=
 =?utf-8?B?MWlhWSs0T3c4aVRibFI5cHVQNG1JK3JmQlFPQVlLdlFreisxZTBnRnl4d2Zy?=
 =?utf-8?B?SEhmVmRMR3picHJBUWtIcG5xYmZUTkJQbEVqSmhLZTZTU1M4OXNNU1hYa1g4?=
 =?utf-8?B?MFNXZXVDd2E2dlBFb3NwVHhWNm1SVVJ4ODd4Q1FPUUpLc1JaZEtmVnJwUVVz?=
 =?utf-8?B?RzV5YXBqUFlMUEV5MlZHMTNmWHNxYkVsMlUvRmN6aExjZnlEMXVyamVqSjRi?=
 =?utf-8?B?dEtZWkc5Umg5Tnl6NlZCc3RaNGM2cittaHE2YnhIc24vMmJ6VExpK1A2TENL?=
 =?utf-8?B?Z01TU1g5bE1NdWZLY2JJd2xyam5pTEZCdzBONUpVUVhoemNKUUhlS1hkeHhY?=
 =?utf-8?B?RXFNOVhaZXgxR1pPMnltRDNBSnBJa28zSjdwSHlsZjV2RG5zblFBV2VsMCt3?=
 =?utf-8?B?KzNHcDJpTk9vdVpqbEUyMzk3NFRqUGp0R0E5bitzZHVuL29pd2c1ZE5VVFMv?=
 =?utf-8?B?dWVHeUhhOHJzdHlVS3RnQXFCSGpjaVU3T3JYQkdtWWhKaElFOVpoZU4venFz?=
 =?utf-8?B?UUEwb0Rmc0JMcVVmSUZheEhSWkl0WkFqeHhvTkRhMnhPZU5mTGtndm9PM2V2?=
 =?utf-8?B?WmlqVHlPY2t6YjduU1VFTWxtOENrU2FBbEF4YXhMYjBhbFo1Yll1THJ2U0Jv?=
 =?utf-8?B?OUZJMjVDalBwc1JTd2Q2R1VGcjJmMzVIK05CeG9YbUZEN3kxVzRrQUtYZXFH?=
 =?utf-8?B?MCtnVUlBcjJRUmJHWjN5cUR5MXJ3bFpGSndvbjZiZk9lZEMwNnFzeVpBVm91?=
 =?utf-8?B?NjI5SGUyNGRCU3BxSGY5S0VLb3gxSjF1aE9yQWpmeVlnM3RqREw5U0RyNEcx?=
 =?utf-8?B?M2NqQ0JUdkN4ckR6eXdTd1NHc3pZMWVaUncxSkgySUFic2JFdjhDRDRhcXdD?=
 =?utf-8?B?YlVZMXg3RlYzTklWNXF1OGtBVnBrRTEwQ0RVUnJNeStMUlhxRFpSZC9lVWxN?=
 =?utf-8?B?ZlhROVVHUUVrOTBtUVN3NW1HZy9NRWp1MUxJYVhDTUNHaisvckl6bFhsNy9x?=
 =?utf-8?B?dUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df3b3354-497b-4faa-4c7c-08dbf8d5365e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2023 16:38:02.6834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+Ka3MV/KKZFQrJXgGTQxXYqE/FFsWXrdnnEUhsa6GEkMuIdKlTjkHWJsamCYKhn/5HT7ou0EXH1yxCZcjppdlq0IEbRoEaYlIzhC4eh0l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10082

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJv
Lm9yZz4NCj4gU2VudDogU2F0dXJkYXksIERlY2VtYmVyIDksIDIwMjMgNDowOCBQTQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDgvOF0gZHQtYmluZGluZ3M6IG1mZDogZGxnLGRhOTA2MzogQ29u
dmVydCBkYTkwNjINCj4gdG8ganNvbi1zY2hlbWENCj4gDQo+IE9uIDA5LzEyLzIwMjMgMTY6NDEs
IEJpanUgRGFzIHdyb3RlOg0KPiA+Pg0KPiA+PiBXaHkgZGlzYWJsaW5nPyBEcm9wIGFsbCBzdGF0
dXNlcyBmcm9tIGFsbCB5b3VyIGJpbmRpbmcgZXhhbXBsZXMuDQo+ID4+DQo+ID4+Pj4gV2hlcmUg
YXJlIGdwaW8tY29udHJvbGxlciBhbmQgY2VsbHM/IEZvciB0aGlzIG5vZGUgYW5kIGZvciBwYXJl
bnQ/DQo+ID4+Pj4gV2h5IHRoaXMgZXhhbXBsZSBpcyBpbmNvbXBsZXRlPw0KPiA+Pj4NCj4gPj4+
IEN1cnJlbnRseSBJIGRvbid0IHNlZSBhbnkgZHJpdmVyIGlzIHVzaW5nIHRoaXMgY29tcGF0aWJs
ZSBvdGhlciB0aGFuDQo+ID4+IE1GRC4NCj4gPj4NCj4gPj4gT3BlbiB0aGUgTUZEIHNvIHlvdSB3
aWxsIHNlZSBpdC4uLg0KPiA+DQo+ID4gQWN0dWFsbHksIGZvdW5kIHRoZSBkcml2ZXIgYW5kIHRl
c3RlZCBHUElPcywgRm9yIGlucHV0IGdwaW8sIEkgY2FuIHNlZQ0KPiA+IHRoZSBzZDFfcHdyX3Nl
bCB2YWx1ZXMgYXJlIHRvZ2dsZWQgZHVyaW5nIGNhcmQgaW5zZXJ0L3JlbW92YWwuDQo+ID4gRm9y
IG91dG91dCBncGlvLA0KPiA+IFN5c3RlbSBpcyBlbnRlcmluZyBpbnRvIHJlc2V0IG1vZGUsIGlm
IEkgc2V0IG91dHB1dC1sb3cgaW4gRFQuIFNvIHNldA0KPiA+IEluaXQgc3RhdGUgYXMgb3V0cHV0
LWhpZ2ggdG8gYXZvaWQgcmVzZXQuDQo+ID4NCj4gPiBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1k
YTkwNjIuYw0KPiANCj4gQW55d2F5IHRoZXJlIGlzIGEgR1BJTyBjaGlsZCBub2RlIGFuZCBkcml2
ZXIgd2hpY2ggYmluZHMgdG8gaXQuIFdoYXQncyBpdHMNCj4gcHVycG9zZSBpbiBzdWNoIGNhc2U/
DQoNCg0KVGhlIHBpbmN0cmwtZGE5MDYyZHJpdmVyIGlzIGluc3RhbnRpYXRlZCBmcm9tIHRoZSBw
YXJlbnQsIHNpbmNlIHRoZXJlIGlzIGENCkdQSU8gY2hpbGQgbm9kZSB3aXRoIG1hdGNoaW5nIGNv
bXBhdGlibGUuDQoNCk1GRF9DRUxMX09GKCJkYTkwNjItZ3BpbyIsIGRhOTA2Ml9ncGlvX3Jlc291
cmNlcywgTlVMTCwgMCwgMCwNCgkJICAgICJkbGcsZGE5MDYyLWdwaW8iKSwNCg0KDQpyb290QHNt
YXJjLXJ6ZzJ1bDp+IyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvZ3BpbyB8IGdyZXAgZGE5MDYyIC1B
NQ0KZ3Bpb2NoaXAxOiBHUElPcyA2NjQtNjY4LCBwYXJlbnQ6IHBsYXRmb3JtL2RhOTA2Mi1ncGlv
LCBkYTkwNjItZ3BpbywgY2FuIHNsZWVwOg0KIGdwaW8tNjY1ICggICAgICAgICAgICAgICAgICAg
IHxTRDBfUFdSX1NFTCAgICAgICAgICkgaW4gIGxvDQogZ3Bpby02NjYgKCAgICAgICAgICAgICAg
ICAgICAgfFNEMV9QV1JfU0VMICAgICAgICAgKSBpbiAgbG8NCiBncGlvLTY2NyAoICAgICAgICAg
ICAgICAgICAgICB8U1dfRVQwX0VOIyAgICAgICAgICApIGluICBoaQ0KIGdwaW8tNjY4ICggICAg
ICAgICAgICAgICAgICAgIHxQTUlDX1BHT09EICAgICAgICAgICkgb3V0IGhpDQpyb290QHNtYXJj
LXJ6ZzJ1bDp+Iw0KDQoNCg==


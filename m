Return-Path: <linux-pm+bounces-40702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B9D16F3D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 08:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A7C30213C2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F3369962;
	Tue, 13 Jan 2026 07:10:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32424290D;
	Tue, 13 Jan 2026 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768288238; cv=fail; b=hJm3D6iiOqAVA5ixI+RFvomUOk9/VuQEOsS9mGzSnET1F2Iq+LaE695hi+fl8Bxj63zV4dmfARGBFFnAyCLTgYhvQstJ03CRgw3RPj8coHk/jVxrUrzWV+hiv18H5LptZ8a1zO+ctAodQ9KGigpEBNU2LV5NLsq0WUMbh5ZYd5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768288238; c=relaxed/simple;
	bh=cqYS1et785goMBrxTVHbdQ4MBEQn2kgM3XGvinwUIbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OKBgwXU83B62v9I2y2kn9d0Tz9kCuoGwV0BQjPNOuxvJhdEt5AIld0Q2hyMGgcdt6BF+B7PB+xq5Z1ycuLOPSJP5LfhfrP5XAltUb04v/gGc0w9keErrtULHJt2qaLYGVxpebdoTNukJUSaULvZrrwo6rnaGtvOCagrFCdxNfOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLqz8yDnDyG+qjyS5/9k33tmAc1o1H9M3ine0NvpbWjW8nV4jnfmjIotErpmYSCMePZ2djCJo71NwDtMEzVd4lE9y07AgEoyUxdkoFO4j8ADzTAnTPLbvln4NsAq6CsLQ03amYAHuGWjqZxZUrIH2cPdOPdzZnR4i3Ewt6BPaPfLkRn8SQYvFT2THQX5zAEGG55/YEf+DEx+2PvgLqsD597knSw1OHBmTYt8QCTzR/A9yTnXJGUksm9NiRnhtIePtEzvaA62sqlLPnhZJJvBODQFw/CCiF+YLEY6dpFXTcTtqFSbavGQVk/zlOTkJBbybm2VmCgw96d6weROvPDNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqYS1et785goMBrxTVHbdQ4MBEQn2kgM3XGvinwUIbo=;
 b=Z68e+y4SFTreSoFUAo0OEUxmxQ+AzoZWTgI5iCfvhq5cZ3aU8ZoI6AHeDn2D4rLp3SIzJue+sVvwnVk9fMFu/3u0HKpVOxUvlO+HpMujM7FihBSbtaXesCgsnSJIH11IjLN9s7iIP2z34yTCGpgasj2Yp2SvUPrfM9s70/TmpgGTG9SHyYmz0DOkR5dYomleyTTCC3puRvhly8+nuvmFaeHfT42X4bjYIRBKYygi4J8nK6wMnF6F8jPugMP022nM0zgMAMM0OnDEFprhMCu8lDqGsyV+CUrvKC6+EM7WZSw/4xABM7Y0EDxm0XCR/D6/ghkHqopaCPq29xc+KlKE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0505.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 13 Jan
 2026 02:35:16 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%4]) with mapi id 15.20.9388.011; Tue, 13 Jan 2026
 02:35:16 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Rahul Pathak <rahul@summations.net>
CC: "anup@brainfault.org" <anup@brainfault.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "pjw@kernel.org" <pjw@kernel.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "alex@ghiti.fr" <alex@ghiti.fr>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "jms@oss.tenstorrent.com"
	<jms@oss.tenstorrent.com>, "darshan.prajapati@einfochips.com"
	<darshan.prajapati@einfochips.com>, "charlie@rivosinc.com"
	<charlie@rivosinc.com>, "dfustini@oss.tenstorrent.com"
	<dfustini@oss.tenstorrent.com>, "michal.simek@amd.com"
	<michal.simek@amd.com>, "cyy@cyyself.name" <cyy@cyyself.name>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
Thread-Topic: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
Thread-Index: AQHcfu35VvAr0fQuSkK4e06gnDRDPbVOY/mAgAEIZAA=
Date: Tue, 13 Jan 2026 02:35:16 +0000
Message-ID:
 <SH0PR01MB0841EF813268269C2AE59372F98E2@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
 <20260106092117.3727152-5-joshua.yeong@starfivetech.com>
 <CABdD5xmVVkQu6rYzF52V-JrsdL=NOQa9N9i8PsMgfaOh3GT-Bg@mail.gmail.com>
In-Reply-To:
 <CABdD5xmVVkQu6rYzF52V-JrsdL=NOQa9N9i8PsMgfaOh3GT-Bg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0505:EE_
x-ms-office365-filtering-correlation-id: 6cff2058-5f1c-4f64-dc8c-08de524c62d4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 675CNg5pNURwouEukKvPvnsrLUtR/KOBNAe994CZQghIc3zfnD2B/ZKO8BsDI1U5cg6s986fJsWqiHmGf4+3Sz0JCWC7/cRUgFtyjeq39Htb2me5LmWnEzKqlwDIFB6otDRj9nA+D5NC+7A+8yQ7UZuqyKlKFgK6X4uWI9sk13LvLjabV/5ry4fI7itepscoFPjpPGWcjBt0i8ENDxMcbJR3IwBRGcnI3qbPTWr+88ErGxCYBGqipy+sbXGo3Fzu/dND51bHoD6MAfGIqVusZRgaTKFmHObfOL5p89z6LZQKKDdMGT85jeOx55kDOHcT8hmqpbzyhfYrJ+iWT+tkIsPNFXP//V/5hGd99YyAk6zsxYFH3OGJVHQp34gFRYbwi6NuzHTZuIBl8hdrPouHIE2FUa6D1tO9eBB68MYOP/SPynRxHmLOqC/e4gnOR3r8IHZDKA8uROlzlS1s4uqbi7ypfUTSn87WPKBMShJKfH/DQ/OSN1a7uSgzt+T6VaalclFbp47HdVIKFIepmNciPczOntCj2n5RY0sE+cPf5fmPABzES0AtYrA8Z09xDSSHvCc11oUzTSgxg0UvwhjsQoIwGH8k6yIdE1/Wz8c6Xvc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjRGOEtXNFZOMk1yQy84bzRzTGtpNjI3bzhDWVlFemZLam4xWENSbVJRVXFM?=
 =?utf-8?B?MGk3SDNqTXVZL1NZWTI3V0JQU0FUbnk2Z0NMTXd3OER6SWpjZThWSkVKcXA1?=
 =?utf-8?B?U0RhcExvUDM2ODkwUm0xNlFMV09CMTFoTnZremUxaWdya1NRaHpwSkNZTkI3?=
 =?utf-8?B?c2ZFREljaVpnSmdEQ3NIbmJVMHdKcWZ5aFFjOEx6ZnZBeFVpUDVlL2pKalho?=
 =?utf-8?B?TVRzdzFJS3NOSzM4YlExMThtVC9OY1BGL09PVE9oS21JeUpqMFAzWmpxSnhS?=
 =?utf-8?B?MWRhbkFTWEVBWXZob0FTb1czOENjTzNJMWFaYzluWThOenpzcHFFU2puSjlj?=
 =?utf-8?B?anMzUkpVWkZ0NlVPM2R5MXFGNFM4UGJuVUljWGU3RVU4UXp5Y3loQXVxczhr?=
 =?utf-8?B?NkR4MEdxL1ozZ2tiU051ejcxREQ3TzVuMW9FSlptUHBHVE4yY3lSbU5jMXhi?=
 =?utf-8?B?Wnhpa2ZtbFVpV0dZY00rUUY1Rjh5SDRxTWxRUm1GZmdUZ3FadjhwWi9HeUxx?=
 =?utf-8?B?cVN5YjFwTjBqTk10Nkg0M20rMTAxalRYZS9ud3VITkViZ3JNaU9wbW1Qc1JM?=
 =?utf-8?B?Qm9aaG1jemF2OXFvenBQMU9DZzR0cW9ENlo5NTIrVXhsODc3RWZ5ZUVjUHdD?=
 =?utf-8?B?Q3hxMnpMdjR4MXZHdGJGYWxJdThTaW9pR0pDTDRLcEd4NXRhdXZrNFFOSU1C?=
 =?utf-8?B?YkFzaUZWL1Bxcmpaa3p5MVFPNWQyMHRrY24zem11N21FcndIRHRkbVVzM1A2?=
 =?utf-8?B?UzB1N2hxbDRhbGwweWhMTFdEV3lSdFBhNHZWeUNqMVVFVnlaaHBSbkxNMGpJ?=
 =?utf-8?B?WWhQN3RkNnRENkkwOHpxR09EZTZYMGpoRmF3ZWlyeklPMjNVa2tyNjUxdnBR?=
 =?utf-8?B?VVFzbTNQbkxyVzdqQ0s3U0c2MlZQTFIxK1ErRkhEalNCMnhTeWVlN09nNU8v?=
 =?utf-8?B?VnZTaEU5Y3g0VU9MdXY4RHJ5YXhFeFFkMGI0akd2RVN6anJaMUVQUWVCN0k0?=
 =?utf-8?B?bVpjTWhnT2pKblFMSENFM3g1bVN6WktwUnNzWmVweVJpRExFOUxZMmJmdkYv?=
 =?utf-8?B?RHVNRiszaHQ2TCtqbW9rSVYyVDQ4L0RLOHIxUGoxVW0zZEgycXEvSWtqNElO?=
 =?utf-8?B?clN5N0xOVjdWY0FId3RieXRmZW9UdWUwVURzaUwraG1Ba2dISm9iUk9ZTXV5?=
 =?utf-8?B?d2pKd2hMNUFpS296em1TRk0veXEzU1hTYVVlYlNoQ1FBeXZHak85bEU0eU15?=
 =?utf-8?B?UU4rSW1HTlQ4SjRzNk5kS1B3eGtETGR0VHBpSWd3bjg4dmE5dEFTN0pMTFRt?=
 =?utf-8?B?RzZ0M1kzSGRIV2doSnl3VitpeHgvbXlKTTJxSTVkSlZoSk4yUjd1N09MZTYr?=
 =?utf-8?B?ZFlHNG92a0hxNE1wRmd3MlluZ1pjaUJnS3ZGbE1VZ2NPeHRaa1Y1dlJ3V080?=
 =?utf-8?B?bU5TMFpaTzBBSFVpMHJZRnEyZ2RKOHFqTXJXYVk0anR5TFZPNlhCVDlXRHBz?=
 =?utf-8?B?anYwMlZPNzd1VWZiVU5RKzZIakRNb0lZdkFrWjloSkhoc0NNRjJaNTd6Mmhr?=
 =?utf-8?B?UFFDVnA0Szh6Q0VFSkZGalJUK2hkU0JoQnlWb1QzY2lmaWh4dDdaRzJTbzJT?=
 =?utf-8?B?MWxrUlRNWUhXM1NVU0wxY21kaXVWR1A2K1k1cjVUV1lqSjA0VHladG5FVVI2?=
 =?utf-8?B?RlVZRngyTDM2N25VdVlJTGV6SHMrK1pLdm1mUnBYMXl5M2hZZU5rL3VoZWp2?=
 =?utf-8?B?aGFwMWxzbDdyRi9NaHlnb2I3emZnalVXYnY3Qlc2NGVXK1lSZEN3ZS9aOVBB?=
 =?utf-8?B?YzhRK0JKZ3FPcEl0cFFVbWo3L0ZHWWpvaWIwc1AxU1FmVWNhT1l3cytDVy9V?=
 =?utf-8?B?Y3lzTVVxTVlrdFc4VU10UjUzWU96dVR5SFZrSXlybmRCVWs5ckVXdnIzTGY2?=
 =?utf-8?B?dWJJakcxN2ZkMEZFVDZhdDNDa3puZy9SNDdmeEJlTW4wTzA2RzA1TDdFT1Er?=
 =?utf-8?B?WUowYVF2a1JKNnY5dGZRcDRiV000K0daVzdxRDNPR1hjemdNVldPZDFPalFQ?=
 =?utf-8?B?R0cxOGRTN3NsOTcrNmE5dFBqcFMzendpNWF4S3VVY0JmQ0QwOENUNmc0ZHVm?=
 =?utf-8?B?aFNEd0FQMExFSXk1OWhwNlJtdjcrTUx0TUU4ekZKRG4wc0lZZ1pEOFY1SStS?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cff2058-5f1c-4f64-dc8c-08de524c62d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 02:35:16.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AysfVYtU4RrNWN3zEsUgOMtcaIkGvhIiWPH/1WNDQnrtuntK8u+trao2orRrSHq2ZGvJdtbOyWAnS7tGTOAiaS1WUC/wkWN4aGJgoY6FDmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0505

T24gTW9uZGF5LCBKYW51YXJ5IDEyLCAyMDI2IDY6NDcgUE0sIFJhaHVsIFBhdGhhayA8cmFodWxA
c3VtbWF0aW9ucy5uZXQ+IHdyb3RlOg0KDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJwbWlfY3B1
ZnJlcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsgICAgICAgc3RydWN0IHJwbWlf
cGVyZiAqbXB4eV9wZXJmOw0KPiA+ICsgICAgICAgc3RydWN0IHJwbWlfY3R4ICptcHh5X2N0eDsN
Cj4gPiArICAgICAgIGludCBudW1fZG9tYWlucyA9IDA7DQo+ID4gKyAgICAgICBpbnQgcmV0LCBp
Ow0KPiA+ICsNCj4gPiArICAgICAgIG1weHlfY3R4ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYs
IHNpemVvZigqbXB4eV9jdHgpLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIGlmICghbXB4eV9j
dHgpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAg
ICAgIC8qIFNldHVwIG1haWxib3ggY2xpZW50ICovDQo+ID4gKyAgICAgICBtcHh5X2N0eC0+Y2xp
ZW50LmRldiAgICAgICAgICAgID0gZGV2Ow0KPiA+ICsgICAgICAgbXB4eV9jdHgtPmNsaWVudC5y
eF9jYWxsYmFjayAgICA9IE5VTEw7DQo+ID4gKyAgICAgICBtcHh5X2N0eC0+Y2xpZW50LnR4X2Js
b2NrICAgICAgID0gZmFsc2U7DQo+ID4gKyAgICAgICBtcHh5X2N0eC0+Y2xpZW50Lmtub3dzX3R4
ZG9uZSAgID0gdHJ1ZTsNCj4gPiArICAgICAgIG1weHlfY3R4LT5jbGllbnQudHhfdG91dCAgICAg
ICAgPSAwOw0KPiA+ICsNCj4gPiArICAgICAgIC8qIFJlcXVlc3QgbWFpbGJveCBjaGFubmVsICov
DQo+ID4gKyAgICAgICBtcHh5X2N0eC0+Y2hhbiA9IG1ib3hfcmVxdWVzdF9jaGFubmVsKCZtcHh5
X2N0eC0+Y2xpZW50LCAwKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIobXB4eV9jdHgtPmNoYW4p
KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihtcHh5X2N0eC0+Y2hhbik7DQo+
ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gcnBtaV9jcHVmcmVxX2F0dHJfc2V0dXAoZGV2LCBtcHh5
X2N0eCk7DQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIHZlcmlmeSBSUE1JIGF0dHJpYnV0ZSAtIGVycjolZFxuIiwgcmV0
KTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBmYWlsX2ZyZWVfY2hhbm5lbDsNCj4gPiArICAg
ICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAvKiBHZXQgbnVtYmVyIG9mIHBlcmZvcm1hbmNlIGRv
bWFpbiAqLw0KPiA+ICsgICAgICAgcmV0ID0gcnBtaV9wZXJmX2dldF9udW1fZG9tYWlucyhtcHh5
X2N0eCwgJm51bV9kb21haW5zKTsNCj4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAg
ICAgICAgICAgZGV2X2VycihkZXYsICJpbnZhbGlkIG51bWJlciBvZiBwZXJmIGRvbWFpbnMgLSBl
cnI6JWRcbiIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZmFpbF9mcmVlX2NoYW5u
ZWw7DQo+ID4gKyAgICAgICB9DQo+DQo+IFRoZSBkb21haW4gc3BhY2UgaW4gUlBNSSBwZXJmb3Jt
YW5jZSBmb3IgQ1BVIGFuZCBEZXZpY2UgaXMgbm90IHNlcGFyYXRlIGFuZCBhIGRvbWFpbiBjYW4g
YmUgZWl0aGVyIENQVSBvciBhIERldmljZS4NCj4gSG93IHRoZSBkcml2ZXIgd2lsbCBtYWtlIHN1
cmUgdGhhdCB0aGUgZG9tYWlucyB3aGljaCBhcmUgcmV0dXJuZWQgYXJlIENQVSBvbmx5IGFuZCBu
b3QgdGhlIGRldmljZS4NCg0KSSB0aGluayB3ZSBuZWVkIHRvIGVuaGFuY2UgdGhlIFJQTUkgc3Bl
YyB0byBpbmNsdWRlIGluZm9ybWF0aW9uIGZvciB0eXBlcyBvZiBkZXZpY2UuDQpXaGF0IGRvIHlv
dSB0aGluaz8NCg0KPg0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBycG1pX2NwdWZyZXFf
b2ZfbWF0Y2gpOw0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgcnBt
aV9jcHVmcmVxX3BsYXRkcnYgPSB7DQo+ID4gKyAgICAgICAuZHJpdmVyID0gew0KPiA+ICsgICAg
ICAgICAgICAgICAubmFtZSA9ICJyaXNjdi1ycG1pLXBlcmZvcm1hbmNlIiwNCj4gPiArICAgICAg
ICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gcnBtaV9jcHVmcmVxX29mX21hdGNoLA0KPiA+ICsg
ICAgICAgfSwNCj4gPiArICAgICAgIC5wcm9iZSA9IHJwbWlfY3B1ZnJlcV9wcm9iZSwNCj4gPiAr
ICAgICAgIC5yZW1vdmUgPSBycG1pX2NwdWZyZXFfcmVtb3ZlLCB9Ow0KPiA+ICsNCj4gPiArbW9k
dWxlX3BsYXRmb3JtX2RyaXZlcihycG1pX2NwdWZyZXFfcGxhdGRydik7DQo+ID4gKw0KPiA+ICtN
T0RVTEVfQVVUSE9SKCJKb3NodWEgWWVvbmcgPGpvc2h1YS55ZW9uZ0BzdGFyZml2ZXRlY2guY29t
PiIpOw0KPiA+ICtNT0RVTEVfREVTQ1JJUFRJT04oIkNQVUZyZXEgRHJpdmVyIGJhc2VkIG9uIFNC
SSBNUFhZIGV4dGVuc2lvbiIpOw0KPg0KPiBOSVQ6IENQVUZyZXEgZHJpdmVyIGJhc2VkIG9uIFNC
SSBNUFhZIGV4dGVuc2lvbiBhbmQgUlBNSSBwcm90b2NvbCAgIC0NCj4gc29tZXRoaW5nIGxpa2Ug
dGhpcw0KPg0KPiA+ICtNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo=


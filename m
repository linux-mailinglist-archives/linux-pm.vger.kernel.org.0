Return-Path: <linux-pm+bounces-40446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D8D02C54
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 13:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16D7A319088A
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1529354AFB;
	Thu,  8 Jan 2026 10:31:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC342F25F2;
	Thu,  8 Jan 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868313; cv=fail; b=rujdWZFAGtptBX81R88S0gUJ2jAGH4JRQXkmjyQkeKrJfzzp+ykPzZxNPc+1gy36h1Wl5s0jJCfyjeNhoCBUtPbQ58FSuTMBjDCYo6XuBFXl4oTabezHFmQWGyBqLevZiocFCeZ/LbVbuMQPRT5Hx8EvW0UbQZ8G/8cOQERK/z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868313; c=relaxed/simple;
	bh=42kWheYlyIVWKVQlq9eU1pXCpOHuedbL/0xdto2VGQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SaaRIsqOJRldPgiC3G6GUvkpxHp+MVx1nrTa71i69kSBTEOjSXkna0F1VqN2gFqAiA5uKKHr5ax/xTsRjdtgjHXA/onvdh7nlnGUqJxa/L74phCNkj0Zb7WIddb9efBtblGTOkb+uzaNSrpWUQCnw9u4jKiejg+ZnoM+S73Z5pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB5gEEIH4yAdDQ0nWxU4clFvOBC9hUGSkFBjyXeMNUgXfyht05UOfdfI6x7QUJKt9OZZfUDjmAc3ZmC2FGCV7LLwDYMmJTe5vUIacfbfr5f2oAWs4joxbN5PdpeEMLWdfGGlRP0/RkbkHz29cyPr1YEA6gE+LxVd7bUG2oMSkMBp1Q6qoH5bBwsnZgBuINfyhOHMDHqYXpbtJ9I6ob3wbeL7yaMa4OO/1YSSWnEPUQAaQ0u+/fmKY+u4yZFPFo+TL6MIiSZuwf4FgF+Q18/PKviTvgHlHqYj6b7wh/m9BS4jdJfXDRmKsMjiBexMr/kXXN5RF56W4IKO/+gavGDZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42kWheYlyIVWKVQlq9eU1pXCpOHuedbL/0xdto2VGQU=;
 b=V4T/21Jb84kxA9DHPYtF8vfNhaJ3F1dGAR3cOExNW4reABBOx0DW3Tfa6bciZIDwjUtYYBVqRk2aNTRsdg0eUjBbnxiCqLAEJ5ufBQAsCOfJ0+ts3k1AfAgF+83GqWwqIqDIpD12qEpmrWjvu0hc/Fa56Hb1ssxR5T8u3J5ilbZ74NYonNzYEtQWIWFF8MH0f1g/55QIhgPXV3C1pqkW7hr5s/YC8xFl6dXCetEdX+7OZ72BmQzdBJNQqMGZbobn09oPU2Pb8e05gIX1avFYExH+upOx4+2LJm74rIil5GIHo9qwCb9VzqptYp2dXNyVfYieMrg4Qm9loibdxvZXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0875.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Thu, 8 Jan
 2026 06:56:01 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%4]) with mapi id 15.20.9388.011; Thu, 8 Jan 2026
 06:56:01 +0000
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
Subject: RE: [PATCH 0/5] RISC-V: RPMI performance service bindings and cpufreq
 support
Thread-Topic: [PATCH 0/5] RISC-V: RPMI performance service bindings and
 cpufreq support
Thread-Index: AQHcfu3jK4E6NYU2x0aaRY1yL0LrPbVHwSaAgAAWmAA=
Date: Thu, 8 Jan 2026 06:56:01 +0000
Message-ID:
 <SH0PR01MB08414F0C86E4A624D0F08EFDF9852@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
 <CABdD5xkq=LbaUo=jDGSF2U2Rb0r13EEJQMfSjxEMsSX0mCDyhQ@mail.gmail.com>
In-Reply-To:
 <CABdD5xkq=LbaUo=jDGSF2U2Rb0r13EEJQMfSjxEMsSX0mCDyhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0875:EE_
x-ms-office365-filtering-correlation-id: 625c96f7-773a-4e2a-09e4-08de4e82fbfd
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|41320700013|38070700021;
x-microsoft-antispam-message-info:
 kTRkApswprLFNCmhxmj6/DZieVOo3DEPVxMOukBigFF+AmBlES1xYWLPZDbwyrXL2cOSn8aEzSvyjUssw/6pgnmLWf7oVZQVuuFZShlKQI5dp5FQYCS6McBeJ4Fq+FzczctPpGi5fSvWRvv9T0vC5vIuHGNlCEbclY3FmmkfVjSmVIYXtA1KIxrqBqt7iluQUkMDNdB1769EIXJCJL/z4hIs2J/9Nny1SlcA5ATEc06EI8f/hjeOEkZUZMCmfVl7dmjx8VUuZQ8p9xKYUQORWHREDkAbnqS/Uz4P1V7Vu9XNr8AHdnl89FrEbuYIczBTGMAl6EJQNkevzZwHnyCedRlfTWUrLdvKssE4v0m6Vg+Lcg/4ELuIqbirMD5ej7FH4lbYsd9GsGSzYgwEss0aZvoiPBNWwdG3AXW9bZGxFhtIT70PHCl3mWpHb78Lbk+uzFS0hrKeTyIbKkP2lvWccIR66PW7djpMQBjc5zZ0zuD8B3sYIL4PQTsvpV597iH1LJi5eKh3SRje2fwXh7kxtzdsEKtfM2cWue6esXdle/EfNzKDIcXC0mEzk+1p1z4vhx0TpcRQzgm5vRwDeNiZItPFmlwhcTj6vyaSczj+6Bc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(41320700013)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blRYRXl5OGI3WWNDcmZJL1MzcTlveWQ2OTc3U0w3YzV2UzZVOW9OTnk4SENt?=
 =?utf-8?B?emxlU2w0ZXF4YUYwbGFYTjlmMDVKSTRWTTZwUU1zYWl4Q1lvZ2kvTVNTNHZk?=
 =?utf-8?B?TGw4YzI1eDE3dmhzb3hYYzlBNHB1emU5UkJQbDhrMENEZ0hORlNycGpqV0p0?=
 =?utf-8?B?bUQvQzFxd3hCWlgrdWUvZVV3bmlSTFE1RWlBdExLZzg2d05NVFgyL045WGVM?=
 =?utf-8?B?dGxMUlJsdHJ3TWNOMnZNRXdiWWx5KytTSkJuOEhSQlpnVGhlRCtUWkJzMWg1?=
 =?utf-8?B?UGRhVkZVcWs2aDI4ZzVBbzZyQmdYeThEaUE0VSswZS9lYndJRGxaaGEveEFz?=
 =?utf-8?B?Yy9TZldyUE9Wa2dKYk92RWhpWXZkRnZlUGhNY0NKRlY5WlRZQkEzMmhaOFNu?=
 =?utf-8?B?UFFXemxyZmhxOGhVVndjdUtaOS9mNEZBMW0zQWlnWEFPZi9ocS9VSmJGd3o1?=
 =?utf-8?B?TmJBSWwybWp2MU83em4ycWtvOWVucTdsVVBIaEdxM2N2Q3VaT1Yxb3pxTVlJ?=
 =?utf-8?B?N3NjVnRtRHZzMmlYS3BaNy9EMUYrUlVXcktnQkhRZlY4OU5IU283ZHNoK0FP?=
 =?utf-8?B?bXBHRlpYaGUvek1TZUpYUHFCWlBSUkNycFJCQW50cUZRYnV2RHZuYUswdUNy?=
 =?utf-8?B?Z3dSbSs3OWdtK2hTY3hQbS9yV3ovc0VGZUFTVXZQSTUwODROaWYxOGZSVDJn?=
 =?utf-8?B?OHdaVGRBYWxydUJZNklnMzBKQkhOeVRmcjNNWXBTbTEwWE1tZFB3Q0ZCTFVN?=
 =?utf-8?B?ZDhsNnBPVTNZSWRZMlFJN1pxVVV5cFpmQUJydkdsZERVUjhoN1QrN2FZc0oz?=
 =?utf-8?B?U1JRbFF4R0NzZkZOV1M5MGppZGJWRWFEa29OeEJHTHdJYUY2dmlKOEhkSDBJ?=
 =?utf-8?B?SWVCdFU0UWNPRmxBV24rMXZoZVhtV1U3MmJpaUp0Yncyek1ISGFSQVp2aFNi?=
 =?utf-8?B?dzNlRWhUVTlrWGxZWWg3aHhnQ2t6TDJSY2dEdVpjN1ptK2F5ZGxoOWo4TVRl?=
 =?utf-8?B?NWFEWVEvUTc1bkEwRTJ3RytvYXR6RnhjNi9jZXJXK2NaZzRJTUVKNVFMc0VW?=
 =?utf-8?B?WTA1VHhSRU1VSEVGRDR1bE1DSkhneldQdXJPdGZSemI2U2tET29CcjNKaVRX?=
 =?utf-8?B?VHlmZkkrQkNuQUlPV1lETThZaXYvKzNOUWM5TFE5alQ3UmJJTkpNY2drZWZm?=
 =?utf-8?B?VFY1RWs0cFBCMWl4eHowdEVIb1hwcnMxenQveHNGaVlIMk0zVnhkRmc3ZHpC?=
 =?utf-8?B?Rk00RStsdkhYM2RYc0FnLy9ZeVUyK3E2MGZwNXRvdVF5VHc2dE0rY1dmQ1Mv?=
 =?utf-8?B?RTlLVTliZlErNXVtdUk1NEttbnVDZXdWNko0OWFtUCtVT2ZrK09QdVExN1FD?=
 =?utf-8?B?cU5nTjk2ZDZGMU85SUJwTW1MQlJBTWZob2VTZXE5bWZOQysxbWZVb1djK2xU?=
 =?utf-8?B?TWNnaDRjNXVUWnNNVmphazg0VFlIMTRDN1JGekVsTENheUl6dWJ1amk3OVdi?=
 =?utf-8?B?S1gvNEZoMGJmc2VpY2NVQ3kyVWRBQ2Z0MldkcStpZG1Gck1OMTVzTUFSR0FS?=
 =?utf-8?B?aFNqN013WTI4Z1pWMkdyUVMxU040dGE3dHkvRVRhc3V6SURNbzNSUmVibm5r?=
 =?utf-8?B?SnRCRDc3cTBUd29QcEVDMjRrZkgrM2lFVlVOYldTNVJJSG9sbzZSa1BGVTEv?=
 =?utf-8?B?YlBjSlU0eG5kaFQ3VEtCdHE2YVlYUWdTOEgwdE5ZQWwvTW9nVGVHWjEzV3dy?=
 =?utf-8?B?MEQwWWZxamlKRWZMR3oxdGtoQ3A0Wkh0Mm5XNEFYZzU3TTM5MW94Q1JzNVVY?=
 =?utf-8?B?SVhTN3VVR1AyRFJvQmtDK0FQdHdsOUFoY3RMS1pwL2MrUC9Tbi9Vb1dLR2xt?=
 =?utf-8?B?b0MvblVlS2VPdlJKczRrM3BGWVRhdmErcE1kcVpMY3JlRkNQNFQybUI5LzNo?=
 =?utf-8?B?UHFxemtOak1nbHAxRjdGMllEdzVsN2pRcmZLaWpYMS9xSGxybkJoTmtKNSs0?=
 =?utf-8?B?LzJzZ0ZBVDhZWDBEZ2FSalZmaklGRG1jazVpM1hKcTJTS3hRR3IwSnlSQVZw?=
 =?utf-8?B?aERZTlpSTXJCUEtLeGxSMjQxTjdyVDFSUGNLdFVyeENJa0pIZkc4SXVKZy8v?=
 =?utf-8?B?b2FhV1NSdkd0QXU0cTEwRjBmcWcwMW4zdE14amFEcGNOR0I2OWgvWXpTa2lC?=
 =?utf-8?B?SEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 625c96f7-773a-4e2a-09e4-08de4e82fbfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 06:56:01.2977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RENZcw1qySkqqfMsVArBzDp+r1sa+nGRcp8mhk8aygya1Y3LZpgbX1PWgJqYgfWyqvwuxwx32rGI7lX1g63VwMwksJTH8RHlr4nlkWtDa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0875

T24gVGh1cnNkYXksIEphbnVhcnkgOCwgMjAyNiAxOjI3IFBNLCBSYWh1bCBQYXRoYWsgPHJhaHVs
QHN1bW1hdGlvbnMubmV0PiB3cm90ZToNCg0KPiBPbiBUdWUsIEphbiA2LCAyMDI2IGF0IDI6NTHi
gK9QTSBKb3NodWEgWWVvbmcgPGpvc2h1YS55ZW9uZ0BzdGFyZml2ZXRlY2guY29tPiB3cm90ZToN
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGludHJvZHVjZXMgc3VwcG9ydCBmb3IgdGhlIFJJ
U0MtViBSUE1JIChSSVNDLVYgDQo+ID4gUGxhdGZvcm0gTWFuYWdlbWVudCBJbnRlcmZhY2UpIHBl
cmZvcm1hbmNlIHNlcnZpY2UsIGNvdmVyaW5nIGJvdGggDQo+ID4gRGV2aWNlIFRyZWUgYmluZGlu
Z3MgYW5kIGEgY29ycmVzcG9uZGluZyBjcHVmcmVxIGRyaXZlci4NCj4gPg0KPiA+IFRoZSBmaXJz
dCBwYXJ0IG9mIHRoZSBzZXJpZXMgYWRkcyBZQU1MIGJpbmRpbmdzIHRvIGRlc2NyaWJlIHRoZSBS
UE1JIA0KPiA+IHBlcmZvcm1hbmNlIHNlcnZpY2UgYXMgcHJvdmlkZWQgYnkgcGxhdGZvcm0gZmly
bXdhcmUsIGFzIHdlbGwgYXMgdGhlIA0KPiA+IHN1cGVydmlzb3ItbGV2ZWwgY29udHJvbGxlciBp
bnRlcmZhY2UgZXhwb3NlZCB0byB0aGUgb3BlcmF0aW5nIHN5c3RlbS4gDQo+ID4gVGhlIGJpbmRp
bmdzIGFsc28gZG9jdW1lbnQgaG93IENQVSBub2RlcyByZWZlcmVuY2UgcGVyZm9ybWFuY2UgZG9t
YWlucyBtYW5hZ2VkIGJ5IFJQTUkuDQo+ID4NCj4gPiBUaGUgZmluYWwgcGF0Y2ggYnVpbGRzIG9u
IHRoZXNlIGRlZmluaXRpb25zIGJ5IGludHJvZHVjaW5nIGEgY3B1ZnJlcSANCj4gPiBkcml2ZXIg
dGhhdCBsZXZlcmFnZXMgdGhlIFJQTUkgcGVyZm9ybWFuY2Ugc2VydmljZSB0byBtYW5hZ2UgQ1BV
IA0KPiA+IGZyZXF1ZW5jeSBzY2FsaW5nIG9uIFJJU0MtViBzeXN0ZW1zLiBUaGUgZHJpdmVyIHN1
cHBvcnRzIFJQTUkgYWNjZXNzIA0KPiA+IHRocm91Z2ggU0JJLWJhc2VkIHRyYW5zcG9ydCBtZWNo
YW5pc21zIGFzIHdlbGwgYXMgZGVkaWNhdGVkIHN1cGVydmlzb3ItbW9kZSB0cmFuc3BvcnRzLg0K
PiA+DQo+ID4gUlBNSSBzcGVjaWZpY2F0aW9uIHJlZmVyZW5jZSBbMV0gYW5kIFsyXQ0KPiA+DQo+
ID4gVGVzdCBFbnZpcm9ubWVudCBpcyBhcyBmb2xsb3dzOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNv
bS95ZW9uZ2pvc2h1YS9saW51eC90cmVlL3Y2LjE5LXJjNC9ycG1pLXBlcmZvcm1hbmNlDQo+ID4g
aHR0cHM6Ly9naXRodWIuY29tL3Jpc2N2LXNvZnR3YXJlLXNyYy9vcGVuc2JpDQo+ID4gaHR0cHM6
Ly9naXRodWIuY29tL3llb25nam9zaHVhL3FlbXUvdHJlZS9ycG1pLWRldi11cHN0cmVhbQ0KPiA+
DQo+ID4gVXNlICctTSB2aXJ0IC1NIHJwbWk9dHJ1ZScgd2hlbiBydW5uaW5nIHFlbXUNCj4gPg0K
PiA+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vcmlzY3Ytbm9uLWlzYS9yaXNjdi1zYmktZG9jL3Jl
bGVhc2VzDQo+ID4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi1ub24taXNhL3Jpc2N2LXJw
bWkvcmVsZWFzZXMNCj4gPg0KPiA+IEpvc2h1YSBZZW9uZyAoNSk6DQo+ID4gICBkdC1iaW5kaW5n
czogZmlybXdhcmU6IEFkZCBSUE1JIHBlcmZvcm1hbmNlIHNlcnZpY2UgbWVzc2FnZSBwcm94eQ0K
PiA+ICAgICBiaW5kaW5ncw0KPiA+ICAgZHQtYmluZGluZ3M6IGZpcm13YXJlOiBBZGQgUlBNSSBw
ZXJmb3JtYW5jZSBzZXJ2aWNlIGJpbmRpbmdzDQo+ID4gICBkdC1iaW5kaW5nczogcmlzY3Y6IGNw
dXM6IGRvY3VtZW50IHBlcmZvcm1hbmNlLWRvbWFpbnMgcHJvcGVydHkNCj4gPiAgIGNwdWZyZXE6
IEFkZCBjcHVmcmVxIGRyaXZlciBmb3IgdGhlIFJJU0MtViBSUE1JIHBlcmZvcm1hbmNlIHNlcnZp
Y2UNCj4gPiAgICAgZ3JvdXANCj4gPiAgIE1BSU5UQUlORVJTOiBBZGQgUklTQy1WIFJQTUkgcGVy
Zm9ybWFuY2Ugc2VydmljZSBncm91cA0KPg0KPg0KPiBIaSBKb3NodWEsDQo+DQo+IEkgaGF2ZSBh
IGdlbmVyYWwgcXVlc3Rpb24gLSAgUlBNSSBwZXJmb3JtYW5jZSBzZXJ2aWNlIGdyb3VwIGlzIHBy
aW1hcmlseSBkZWZpbmVkIGZvciBkZXZpY2VzIGJ1dCBjYW4gYWxzbyBiZSB1c2VkIGZvciBDUFVz
Lg0KPiBEbyB5b3UgcGxhbiB0byBhZGQgYSBSUE1JIGRldmZyZXEgZHJpdmVyIHRvbyBmb3IgZGV2
aWNlcz8NCj4NCj4gVGhhbmtzDQo+IFJhaHVsDQoNCkhpIFJhaHVsLA0KDQpNeSBzaWRlIGlzIHll
dCB0byB0ZXN0IHBlcmZvcm1hbmNlIHNlcnZpY2UgZ3JvdXAgd2l0aCBkZXZmcmVxIGJ1dCBzaG91
bGQgaGF2ZSBubyBwcm9ibGVtIGxpa2UgeW91IG1lbnRpb25lZC4NCkkgd2lsbCBoYXZlIGEgbG9v
ayBhZnRlciB0aGUgb3RoZXIgUlBNSSBzZXJ2aWNlIGdyb3VwIHVwc3RyZWFtZWQgb24gbXkgc2lk
ZS4NCg0KVGhhbmtzDQoNCg==


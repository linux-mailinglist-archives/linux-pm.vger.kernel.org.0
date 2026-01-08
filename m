Return-Path: <linux-pm+bounces-40495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6DAD059B9
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 19:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D2131CB36C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D332EA15C;
	Thu,  8 Jan 2026 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Wb0FXnm1"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612682EC562;
	Thu,  8 Jan 2026 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895728; cv=fail; b=SBr62wrXUjB6vd0RqvOuu/L3DH0j/rPomoZpcYHZthLt+p5Qjo2aFewzQhLemnFu+WvyYGdjCaWHGMJtvqRLXBgADC01HHWq0o+EQ9S9W7Z7lYYGSFHrpz2wsIaM63sOVHm2ya62aNjwjmxlfQzmOWPqslx/1G6LKp2QLmBZoKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895728; c=relaxed/simple;
	bh=kdwJwn7jjtFNWLXu12c6Sms23zL5hn5yTL2CJVetxk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WY6r17MQAL15QYBxgClkv4WtT3AO1Uu0RUHUXeeyzNrhNHOaf5zc+E7wM1rifb5H+o2WzWpsB483PVNDFAR2TbZxQPT7hS+uqKzUnMYRcuOKOiph5gsvX34aHGHpVtWCZHVyMERRHwW0HxDfbG/2SsrYU1VoYUlGXsU1f0HjqBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Wb0FXnm1; arc=fail smtp.client-ip=52.101.125.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrVb9tvcTa19j6DwTYcczE4J9eeGhG6wL9emEO8IvEBA6dt2Clv6UTf+8BDx1p5wYbNbjf0oekSiSOLB6baz9kYTxMaP8fp3Tdq1FMbU+evZMqI4nTJI06VuvQvWshy8WUQ+XYPSV6biq7bNZKlneTsemXENuT3DUgl+NaltWS7XdBiDeGth7e9KTJeunhlj0aWXaqt2EBDWw+dnbi9Ewzl2eMdCnXwS8UADWtd7BnnmKlyWfBiD1SGvMeQB9vt6jMz5TTa6UAfmC+hpAJlyPSvBTAJ+I3IciF8m39NuiJpCz4YAN2gkkmWrr6uGMXO3r3gjTxZLmBqjDjYaxJrNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdwJwn7jjtFNWLXu12c6Sms23zL5hn5yTL2CJVetxk4=;
 b=ypdoFBmbcIj3lPDB7wXskitwUYZGzwnqfrX6wtpzFxO2qGbyfwdn3KI0UJCt9qHr4MOrjP7M6Wo+Z+aRz+ILOb6C30jdptUuVZlY6RwQ7LSIh/kaL5b7OPW3p+zKw035OYOwnZnBf7/CMs4Ludkzjzv1ZdCZ5ARVcRVND5T+dSl1eWLwAwUcXLNSGddwGnpBOMLROlOmYslEqEAYRZZCcqImvCNrWDJX83YoDi3t1hF3+t4y5RE56fUD7HakKPxdjjmwAZTYEMEu6GTkLL/euqlwPsoG0y54J9YYCrokwN/ZZpuV0iDnRf22cMDA/xJQQiIIPKMc3SVVEV8Pi5gdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdwJwn7jjtFNWLXu12c6Sms23zL5hn5yTL2CJVetxk4=;
 b=Wb0FXnm1eQGR0FZ8rYxEu5YfjWiVVtERKZgh93LybGar80Q7IuBzUB3d9/ZnwVPVPnYWL3Rk0xLC+zLR9zIkctcaxzovyT7IxPx7oz/aRz+u06z3gdxg6EnPext0K9+SxtCYn5wcoW1XmTIaagWvGU7oszmtRPDTaaOQvvMDe9I=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TY4PR01MB15095.jpnprd01.prod.outlook.com
 (2603:1096:405:280::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 18:08:39 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::606d:1c5a:2899:5ea6]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::606d:1c5a:2899:5ea6%4]) with mapi id 15.20.9520.000; Thu, 8 Jan 2026
 18:08:39 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
CC: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, magnus.damm
	<magnus.damm@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v4 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcgL+POiX0Vlfu+U6nLZTJm8XRWLVIiueAgAADSYA=
Date: Thu, 8 Jan 2026 18:08:38 +0000
Message-ID:
 <TYRPR01MB15619ECA5180E6F630798DDEE8585A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260108165324.11376-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260108165324.11376-6-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdX0G92JmwneZp1h+AOF-Cit2scVGGWXCBZGwBVmJjUAVg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdX0G92JmwneZp1h+AOF-Cit2scVGGWXCBZGwBVmJjUAVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TY4PR01MB15095:EE_
x-ms-office365-filtering-correlation-id: d613f649-b616-4f98-a24c-08de4ee0f2f1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vm1sT0I1RlJBSVU2SVpCRHhLMGQvYktBWnFrODJzQnROcEhKdXNYaU93dGRR?=
 =?utf-8?B?cUZtakFINysrZjRvcmZuUXpIS2M3dlU2NDlxSHNwOVJyQUlwTGF4NGZZYTI4?=
 =?utf-8?B?S1JyRHFNaUYvV0FXY0xQT3dkMU40SGd4a0tSVE40RlhROS9PZXQ1Q0ZBRjd1?=
 =?utf-8?B?TWxRYUtsa01vNWJ1VXhaOWwxWEV1MU1vVVlHSFVYdWlONHlCK1NUQXpOVjJQ?=
 =?utf-8?B?SVphaGdKaENnWmlJaW96cVFTUVpqalJrc2pQM25BM1ZCbTlpUmZKUkVSUHE2?=
 =?utf-8?B?SzVvckFGNllHU3dMREMvZEkvRVdPZDhLVytRanB3c2U1TEMyTmdsUDF5WHp0?=
 =?utf-8?B?djJrYWhjNVFLbHIwQm9XTVgvMExlYXVIdUhvN0c5cTNMaTRZY0tPWmlHTHJ5?=
 =?utf-8?B?WnlYaW02czNmajlaWS9jZEVpTWZxNm9LM1krbklNRTFReDNoZUNnR3FzMmc5?=
 =?utf-8?B?TU1JZ3BuWHJaVjNrZ1ZUbHhLVkRXM1NDaVR5Vm1JR2hLcVllWlJtQnl1eDFs?=
 =?utf-8?B?OHpiZ2pUQ2ZlcXJCR2tiY3Boendobzk3M0xvQ3ptMHBUQW9wWXNHUlpWekhn?=
 =?utf-8?B?SE94a2JvQlNjZEdXUjNJTFFjVDU2aXJTSjBPZmVBeVJyV2RJWVc2SWg1d1dY?=
 =?utf-8?B?OXB2bkVTcnUzQ0liMHd4RjFYMjVoYkc3TWMxUSs2OW1CbWdoMXV2SHVvNGlH?=
 =?utf-8?B?cXFkTzZMS1A1UzJ1VVR5VTcwZmtMdmpSdGNReTdLb05tVldDWmd2cTczTlF2?=
 =?utf-8?B?UTBBMUhKTjhqZTZUZzArMW9jVjE1QzU2ZE4zbmMzTmFldENLaTVWWk83SzFj?=
 =?utf-8?B?WDJyWFRac1JSOGcrZE9GWTVzVW1mSGRzQzhaZ0QvcUg4c2tHdGpjMXlnK0tq?=
 =?utf-8?B?Z29pWVdJRTcxaUI4QUsxT2Q0NXQ1UG5GQjJ0Q2V5NXF6dC9Ra3JHaEVWSEsx?=
 =?utf-8?B?VThLYlUvK05MOHpheFpVSWxHcHBxeHZIZTYvQVAwQkZ3NFdidzlaSlpRK05P?=
 =?utf-8?B?NEIwWFI3ekpHVEtFU1VuL1NDeXVMNStHS0ZFSkYyd052eFJjaEF1cFlSUEZN?=
 =?utf-8?B?RE1tVTZxZDc3ekpEME5qdllVdGlOTDFCaksyazNLckxkOHJ0TG1OSnVCNTIw?=
 =?utf-8?B?L09LR3IzVmV5SDVhaCtpY3EydFJIWmR3VHF5aXBDck1PTnFkWDJFdFNVK2V5?=
 =?utf-8?B?R1JlUTkzS2JOZnB5cDhOZFVRRkg0YVNKaHJNU2lvRUsxTktmVTdjckJVdk05?=
 =?utf-8?B?algzWTNkTkdOZWcvZW04OG5Ta0JYQXF4Rm9uQ0N0OFBjcTRrMlFla0JlYlRH?=
 =?utf-8?B?a0pielFBd0NPVUJPVGpob2VMV0JiYThVc0RCYk9MdXYvQ0t5YXl4ejJZWjBs?=
 =?utf-8?B?aWhPZStJNi8xMU9la3JRSDZ1VkdQOXN1S2prUkVXdXVhU3BzNmlDSG5RWk1T?=
 =?utf-8?B?SkFDUVQvb0p5SmZGdkRXQk96UXRZMXdaTi83WFZKZlR6ZXpWOHhLekhISk9l?=
 =?utf-8?B?bFRMSTM4eWNuVEx6MWtENy9lM2xpL3ljRG9XTU9QeEJmaE1pcEp3clpzYzRy?=
 =?utf-8?B?Zmd6UlRGQ1FkQi9BWXEwSFZzRjhzOE1ZTUMyOUloQUEvd0dMUnpRK2VYbHFu?=
 =?utf-8?B?VnY5Umd3OHRFbFJCUGUzZXJKTkUxdzdDOUg5b0RoVENqWTdSaFNRNGZjV0Fk?=
 =?utf-8?B?bWV0bHh3bnhwcUtkbS9wNmNCN0p6VEJVSkxHM0NLMFdIVERUSW44bmR0OXVI?=
 =?utf-8?B?TytxZlgwK1NIME9UZUtHNnF6NVEwbXluZmM2eFNkdDNyVHZUQXBaeUU0NTh1?=
 =?utf-8?B?YlRVSUE5TTlrUW4rV0d4ZGs1T2hsMHE3RklMckhMWXRTVzRLSXYyTEFTbHRs?=
 =?utf-8?B?cjYrY3RCWXExT1p4NGFVQlNBL3ZpbzM4RjJHMDVYWmZQVi8zSElJdElzL2ht?=
 =?utf-8?B?Rk9HL1lJbFF4aWN0RzFram55dlNwRlNHYi9CYXJtV08wRlh3TTVEbDFrVVpu?=
 =?utf-8?B?a3JnVzc1aHhvRGVQMXNjck1kODlwZGd1VklQSkJURWxiT05mc0thZGhvQjlW?=
 =?utf-8?Q?wnmFrT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UW5VOXRuTWtaQ01KdFNBaUdpTm11d202RWoxTmZUSHF2YlRSZjU1NXRJaWQ2?=
 =?utf-8?B?dGxCOVlEYmhrVEFHM1RvQlRkcXBoOElvTDVqeGFtbThVZU52YmlKYm04enpI?=
 =?utf-8?B?ZVVZWjRxRGRPWkQxRGo3RmlwazJwcFJ2QmVGMEVHNmM4T0pUS1FJeWFaL0Vt?=
 =?utf-8?B?dVpNWUNwZk9BUnpoZmltTVpBUld0aFRIYjcycUMwSjlsTFdJczdRdnVhYUxn?=
 =?utf-8?B?WDhHb0swck9DWFg0NHFmZ3cwM0tRVWduZlZaQmJyR3AxTGFKVXhwNVM1VU9k?=
 =?utf-8?B?cFNkekxRY3JtOGFtWGl2OFdEMlNiMWZ5VVJLTGFjc3dwUkFIaTVKV3NMNlJn?=
 =?utf-8?B?ZzZId0F2TG81dFNMWkN3aGVXaE1BS0kxWXlqT3UrZlBrTHB3cnVEYjRiNzBH?=
 =?utf-8?B?U2tHWkZlTHZJZG5JNzJ4UjlxSy9JS2xqL3FkWmUzYWw2OTd1aTRya1dsRzhY?=
 =?utf-8?B?ZlZEVXIybmwvUC9nMlZiU0hsdE95WG5pdlUyWk0weHBHVEJlSFlWdUZjTUNU?=
 =?utf-8?B?SkRSajBaNFVOUGxDc3B4eGs5bUxPMG4wQWQ2VGd3WXQ0VHFnSWRseHpYYlJs?=
 =?utf-8?B?MWorWFZKSGFoelNPRXdrR2E4RXh6R0wwdUQzTmR4MGU3aURnN0o1S3dWMlpM?=
 =?utf-8?B?SmFvZkhYclhtWlVZZi9CNkdMdjlielg3Q1lsaVZpbUVua1RnLzZEeFE0cXFl?=
 =?utf-8?B?K20wbGozdE4yNHZLQ01XV2NsaUNVMHNtblRRZGpDd2NhaU5UWWdqTW9CZENI?=
 =?utf-8?B?VEtEV2RTSm9QSFNMOXZzanZzRThzWHZHSFpPWUl5c0hSdGtOZE1sR2txZjAw?=
 =?utf-8?B?cSsvNDc2MGFFYTd2SktmRFhSWEFpekYwa3hQVTZFaG81eFU1cENvRkhONkNI?=
 =?utf-8?B?ajNGSEkxY2VyYlllL2hRWDhtY0Frb1lmTWlNaU9wMFpFMnFlZUN1clhRTE4z?=
 =?utf-8?B?V1FzVUl2Ymh5S1p1OXhzVVBLbVAzbWZPeDhDTHBJZ09MRlZ4cE5pQjNndkV5?=
 =?utf-8?B?WitueFFpRDMrSFI4R0tHcXdBQlU0bWVsMi94QTJ3V24wNHpyVytiU3k3ZDNZ?=
 =?utf-8?B?clZiZlVRNWN0dndiNzBpMTQ5UW1hWE12SW5oRzZXNmNSQW90Wnc1OUJwaG9r?=
 =?utf-8?B?TUJaOFpOc2xkbEs2d0pvVklCUUZXQUEwVzVZd1ZIZjk0d0Vxdmg3UnNOT1Uz?=
 =?utf-8?B?dDBac24vV1dBNG1iVzZNT0xFK3dDQkNyRUVacmhaSVM4blgrd0VNNkFtcE9m?=
 =?utf-8?B?dXJsSGtDd2xMUGxyMFFTYWtXTFVZQnZDZEV5RkVlMFRtTFZTem5JTWFVMDd0?=
 =?utf-8?B?YkFaYzJEU2ttd2ZwdG8xUnpFV1Q0STBaSG5WSDZiVEpsQXpvbThNYVhYSmZj?=
 =?utf-8?B?L2hocGVtS3pVS29ZNk9JMkNiVkthS2pmeDJRQWQ5NHBid2JrR3NCTmVINThz?=
 =?utf-8?B?VE5LdmJJSHhldnFBSFFZVnYrN2F6eS9zWnduSTVEeHpqeU1HQXNGSEZnRlQ5?=
 =?utf-8?B?RytJdU9ZVjZCOFpWQlFDdzJ4S3U5b0tjZXVoSU1WZG9GT1lDM3Q4MjR4UWFR?=
 =?utf-8?B?ZDdRek1NZFpISkdqZDh5TkZFNjJ0V1RSd00rZGlZRFU1QjJyY0dwK0pPbERY?=
 =?utf-8?B?NWxqZmppT1RyM2ZGOTZmL0ZIZlkxeGoxV3NDRHQrMGtlakk5THlVQ2RacmVq?=
 =?utf-8?B?b2FYeXNjRVBPems1L2src2ovbXM4TkdwNC9SU3BHcHYrK3AzWk81Q1YrUUZl?=
 =?utf-8?B?VU14dmtUS2NBVGNCLzAzRWFEU0dCWVJqbHVhS2FISkVHa2s0MTQ5SHVZZ2VX?=
 =?utf-8?B?bDJMVHdQcVBsZmFTMmhXRjJwcG5lSW5ZUHA3ZEo4SGc5bU5WUWhHbDFobVVS?=
 =?utf-8?B?c3FmYm1aTlRRSTVZbC9tdW8yZkhwUWpqdjJBeElsT1JreWlGVHJLUUxTZm5l?=
 =?utf-8?B?dDA0Mk1DcVlxUUlkYUFFWU9POTRUSGNUOXBCOTEvQlJUNkhkdjg4WmF5T3l5?=
 =?utf-8?B?cVpYM0FxMHJnQk90OWxhdzh0cEJNODBmWFF4eVlXdDJCL2h6U1FFRTVaSUFl?=
 =?utf-8?B?UEt0czFPUTg0VGRzMmpLVXBRbU4vaE9BQVlXL2dyTGNBc2hMUmJLcFJYbm1U?=
 =?utf-8?B?aGhvcVVwVXZXdmJuYkJEdHpKNlF5MStkcCtsSUtIVzZLQUl5Z05vQUJCSmNm?=
 =?utf-8?B?bTR4L3BSWnNIMFFvRTdWcDdlNVNYK0tBb1Q0eWdBelZXZW9MeHd0eHc5VGpo?=
 =?utf-8?B?RzRieDhYY3Q0a3Nqalg5b0swbHJyb1YwOGp6VXArdTR5bmxnNEEwNFdreEFL?=
 =?utf-8?B?dFExMHBDUFQ2WUZRV1lwTStpaFB0MCtYcnBQeUxxYlEyU1E2U3pMdXVFRmFP?=
 =?utf-8?Q?NSH4rt28q4YRXRd+ECUIYToeTWkM4yzeJP932?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d613f649-b616-4f98-a24c-08de4ee0f2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 18:08:38.8262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwRz5FrIeNh2JTBETtoVmGxQmcacaLy4AbilwYnYSKWkDIzTGO8hI2hyezlV1rqG23oFbH415AEKPyRnKDHdLbo0zQOXbqHJPmGVmBrV4pVVfgzC54Dir13qZqydw6Zn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15095

PiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50
OiBUaHVyc2RheSwgSmFudWFyeSA4LCAyMDI2IDc6NDMgUE0NCj4gDQo+IEhpIENvc21pbiwNCj4g
DQo+IE9uIFRodSwgOCBKYW4gMjAyNiBhdCAxNzo1NSwgQ29zbWluIFRhbmlzbGF2DQo+IDxjb3Nt
aW4tZ2FicmllbC50YW5pc2xhdi54YUByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhlIFJlbmVz
YXMgUlovVDJIIChSOUEwOUcwNzcpIGFuZCBSWi9OMkggKFI5QTA5RzA4NykgU29DcyBleHBvc2Ug
dGhlDQo+ID4gdGVtcGVyYXR1cmUgY2FsaWJyYXRpb24gdmlhIFNNQyBTSVAgYW5kIGRvIG5vdCBo
YXZlIGEgcmVzZXQgZm9yIHRoZQ0KPiA+IFRTVSBwZXJpcGhlcmFsLCBhbmQgdXNlIGRpZmZlcmVu
dCBtaW5pbXVtIGFuZCBtYXhpbXVtIHRlbXBlcmF0dXJlIHZhbHVlcw0KPiA+IGNvbXBhcmVkIHRv
IHRoZSBhbHJlYWR5IHN1cHBvcnRlZCBSWi9HM0UuDQo+ID4NCj4gPiBBbHRob3VnaCB0aGUgY2Fs
aWJyYXRpb24gZGF0YSBpcyBzdG9yZWQgaW4gYW4gT1RQIG1lbW9yeSwgdGhlIE9UUCBpdHNlbGYN
Cj4gPiBpcyBub3QgbWVtb3J5LW1hcHBlZCwgYWNjZXNzIHRvIGl0IGlzIGRvbmUgdGhyb3VnaCBh
biBPVFAgY29udHJvbGxlci4NCj4gPg0KPiA+IFRoZSBPVFAgY29udHJvbGxlciBpcyBvbmx5IGFj
Y2Vzc2libGUgZnJvbSB0aGUgc2VjdXJlIHdvcmxkLA0KPiA+IGJ1dCB0aGUgdGVtcGVyYXR1cmUg
Y2FsaWJyYXRpb24gZGF0YSBzdG9yZWQgaW4gdGhlIE9UUCBpcyBleHBvc2VkIHZpYQ0KPiA+IFNN
Qy4NCj4gPg0KPiA+IEFkZCBzdXBwb3J0IGZvciByZXRyaWV2aW5nIHRoZSBjYWxpYnJhdGlvbiBk
YXRhIHVzaW5nIGFybV9zbWNjX3NtYygpLg0KPiA+DQo+ID4gQWRkIGEgY29tcGF0aWJsZSBmb3Ig
UlovVDJILCBSWi9OMkggY2FuIHVzZSBpdCBhcyBhIGZhbGxiYWNrLg0KPiA+DQo+ID4gUmV2aWV3
ZWQtYnk6IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gPiBU
ZXN0ZWQtYnk6IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDb3NtaW4gVGFuaXNsYXYgPGNvc21pbi1nYWJyaWVsLnRhbmlzbGF2
LnhhQHJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gVjQ6DQo+ID4gICogcGljayB1cCBK
b2huJ3MgUmV2aWV3ZWQtYnkgYW5kIFRlc3RlZC1ieQ0KPiA+ICAqIHJlcGxhY2UgbmV3IG1hY3Jv
IFRTVV9URU1QX01BU0sgdXNhZ2Ugd2l0aCBleGlzdGluZyBtYWNybw0KPiA+ICAgIFRTVV9DT0RF
X01BWA0KPiANCj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0KPiANCj4gTG9va3MgbGlrZSBHbWFp
bCBibG9ja2VkIG15IHJldmlldyBjb21tZW50cyBvbiB2NCA6LSgNCj4gDQoNClRoYXQgZXhwbGFp
bnMgd2h5IHRoZXJlIHdlcmUgbm8gY29tbWVudHMgb24gdGhpcyBvbmUhDQoNCj4gPiBpbmRleCBj
MWI1ODYxMjhmYTYuLmJhMTNjYThjYmI4YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJt
YWwvcmVuZXNhcy9yemczZV90aGVybWFsLmMNCj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvcmVu
ZXNhcy9yemczZV90aGVybWFsLmMNCj4gDQo+ID4gQEAgLTM2Miw2ICszNjYsMjEgQEAgc3RhdGlj
IGludCByemczZV90aGVybWFsX2dldF9zeXNjb25fdHJpbShzdHJ1Y3QgcnpnM2VfdGhlcm1hbF9w
cml2ICpwcml2KQ0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0
aWMgaW50IHJ6ZzNlX3RoZXJtYWxfZ2V0X3NtY190cmltKHN0cnVjdCByemczZV90aGVybWFsX3By
aXYgKnByaXYpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBhcm1fc21jY2NfcmVzIGxvY2Fs
X3JlczsNCj4gDQo+IE1pc3NpbmcgI2luY2x1ZGUgPGxpbnV4L2FybS1zbWNjYy5oPiAob24gZS5n
LiBhcm0gYW5kIHJpc2N2KS4NCj4gDQoNCkFjay4NCg0KPiA+ICsNCj4gPiArICAgICAgIGFybV9z
bWNjY19zbWMoUlpfU0lQX1NWQ19HRVRfU1lTVFNVLCBPVFBfVFNVX1JFR19BRFJfVEVNUExPLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAwLCAwLCAwLCAwLCAwLCAwLCAmbG9jYWxfcmVzKTsN
Cj4gDQo+IENhbiB0aGlzIGNyYXNoPyBFLmcuIGlmIHRoaXMgU01DIGNhbGwgaXMgbm90IHN1cHBv
cnRlZCBieSB0aGUgZmlybXdhcmU/DQo+IA0KDQpEZWZhdWx0IFRGLUEgZmlybXdhcmUgZm9yIFJa
L04ySCB3YXMgbWlzc2luZyB0aGlzIGV4YWN0IFNNQyBjYWxsIGFzIGl0DQp3YXMgb24gYW4gb2xk
ZXIgdmVyc2lvbi4gQWxsIGl0IGRpZCB3YXMgcmV0dXJuIFNNQ19VTkssIHdoaWNoIGlzIC0xLg0K
SSBjaGVja2VkIHRoZSBjb2RlIGFuZCBTTUNfVU5LIGlzIHJldHVybmVkIGluIGFsbCBmYWlsdXJl
IGNhc2VzLg0KU28sIG5vIGNyYXNoLiBBbmQgLTEgaXMgY2F1Z2h0IGJ5IHRoZSAweEZGRiBjaGVj
ay4NCg0KT2gsIG1heWJlIEkgc2hvdWxkIGNoYW5nZSB0aGUgMHhGRkYgY2hlY2sgKHRoZSBvbmUg
SSBqdXN0IG1vdmVkIGludG8NCnJ6ZzNlX3RoZXJtYWxfcHJvYmUoKSkgdG8gdXNlIHRoZSBUU1Vf
Q09ERV9NQVggbWFjcm8gdG9vPyBJIGp1c3QNCm5vdGljZWQgaXQuDQoNCj4gPiArICAgICAgIHBy
aXYtPnRybXZhbDAgPSBsb2NhbF9yZXMuYTAgJiBUU1VfQ09ERV9NQVg7DQo+ID4gKw0KPiA+ICsg
ICAgICAgYXJtX3NtY2NjX3NtYyhSWl9TSVBfU1ZDX0dFVF9TWVNUU1UsIE9UUF9UU1VfUkVHX0FE
Ul9URU1QSEksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIDAsIDAsIDAsIDAsIDAsIDAsICZs
b2NhbF9yZXMpOw0KPiA+ICsgICAgICAgcHJpdi0+dHJtdmFsMSA9IGxvY2FsX3Jlcy5hMCAmIFRT
VV9DT0RFX01BWDsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiANCj4g
R3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0K
PiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBi
ZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29u
dmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIu
IEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dy
YW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==


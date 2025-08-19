Return-Path: <linux-pm+bounces-32610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03779B2BBBA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4C3BE33D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C973274668;
	Tue, 19 Aug 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IRwCcg9F"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EC1FC0E2;
	Tue, 19 Aug 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591836; cv=fail; b=Q9qDX+FUrE1VTfIipTSIZVAxkBZMgZuHbhAHxFJKH2bY0jVWMrOtsZuwFep2rNU5hG+Fn8vHYq+ZDXLhzp5iN2AD55zDRJD5cqOfeU5/gBlo/S0gQpZe1MBQueHaDaCuGDnj9e1x+1i0AHcR/HRIJ29f+bGLyXT1ZtH4QBn8vR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591836; c=relaxed/simple;
	bh=7RVWtnvsPoTIEKxVsaImgF28O4adfCO8J6/KvOHMpWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRGz33NIrgt6bMVjZ8ufIZTEMt7Zxv90VnRm86pHyjLIY7cmIFJlEHWCauoCSbCi8m48lMKVc+8kmdq26ngmLmSBSXnpfvURl0xicSh07dDdaZuypAi9HE4b9VCIfEwrLH0zCV1RCrSJ/QOTlitKUvdXzBd+ZSCnMrgDPRqwPQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IRwCcg9F; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNwmSmSZ5HGyhV8SS14J1eAed40WEVIPFyTWS80TycoaDeAY7LylQSTrDXY+Utu7SC+Ul7eh71PpP596dczuqD0TUN3kDfAta6LE6XqlK9/2fu+BYJk5a8iDnPgLLu1NVZg1psnKAEfUvAGPD5s54pg94hZulRkZdKEt0saQBGTalTAnTyJr5xP1gXefXUYo3xu2sECdHYB+E8+M2ZHkqNdzOHk1xInReCNY2HoJu/qw5LZwxUppVpK8LqK3OEs4pZU426e/bs/7Yq3rULeSUWckZsktFIE2kiczKt3aDGJzb39E5eATiBVqkapdw7DGc7qsHT1nhRvbH2zKujHuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RVWtnvsPoTIEKxVsaImgF28O4adfCO8J6/KvOHMpWc=;
 b=kDp/dRt3AgeN7DNnMcszkP7Vv/xs85YJm38VGVpA62P5lgXMozOWedw18IBA+Z9DZybuwm61FpM5+mVK8Bz3b6IHGtxuOnKph9V7ZelKC0Yqpvehv5La6TczaJlmdQ9c0G6Rh3YwZ8MPJGqW7Rg7ipKjp1qE2RcZgIMu699LgLp/jIyTJw57SOJbL6KMqAlKDmAduqaRRmYxZKnzfrVSVegqaTgygYsowN8T68QoUb+od8HnDDZ4CTn78tK1fpxOaQDjNUnphtowvk64UXgj7eSlOFoncoOn6PXHczNACyENd55SdBhvSK9DR/NuYDeiZPpRWKUebGsSWXMGm1hkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RVWtnvsPoTIEKxVsaImgF28O4adfCO8J6/KvOHMpWc=;
 b=IRwCcg9FvvBMTf/QXozlibOMww/iHTTVnBlCZ0fp/qBnGMFW9BUhDAaMK9k4RNJInjU3JNoBnrYsdmiXsPK6UglVaz5VH0yNO17jMNhq7ofrAAh9UHNW7M53Mr7G7TGd+laR+3gkhSHysOh7x3kgsxhJguGsajFaWcaPL+HPQDY=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by OS3PR01MB9659.jpnprd01.prod.outlook.com (2603:1096:604:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 08:23:49 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:23:47 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: magnus.damm <magnus.damm@gmail.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 3/6] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Topic: [PATCH v7 3/6] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Index: AQHcEF1M57cYRdAdr0+ic5VHjE8Tu7RpmvsAgAAIZIA=
Date: Tue, 19 Aug 2025 08:23:47 +0000
Message-ID:
 <OSCPR01MB1464799D0293902681D74E03EFF30A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
 <20250818162859.9661-4-john.madieu.xa@bp.renesas.com>
 <CAMuHMdUGmbn1H2JV17+9gTYBbnEOmoR9vUevWVx5BTX973MfoQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUGmbn1H2JV17+9gTYBbnEOmoR9vUevWVx5BTX973MfoQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|OS3PR01MB9659:EE_
x-ms-office365-filtering-correlation-id: 21201bae-2cfb-4803-ff24-08dddef9b853
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWUrSWpza1U5UEhuUTg4R3hrdG1vbVVQSHB1Z2o4aGJvRWk2ajhtV1hnNE9y?=
 =?utf-8?B?L2FKdjRwZGRSR0N1d2YzL2ZCU0ppYjNFNHdRcVdxRlhvdVlMZ3dsR3hBYXRu?=
 =?utf-8?B?eHhaS1laQlRCazZERGx5d2RWdS9hTVFMUGVCMDR0QmxJOTBtUDRGbm04WTBt?=
 =?utf-8?B?bVdHSnF5K2h0NWRhNFZLZEJwWmpjWlFsU2MvbWJnZFpvcTRvdGFhcDJiMHFI?=
 =?utf-8?B?bU5tVFRzVStqSURhU0xVNzdPVVhxb2duOEdZOU1PeXB4R0hEdGxBRUM2eEto?=
 =?utf-8?B?VCtlcFBoYnhGTi9kYjd1UmhZa2o4c2ZlTS9tUzBZSlQzRUZKLy9IbzhOQ2tJ?=
 =?utf-8?B?Sk1nUFNBajFHUy82a2pCWm1RaEpaL0NtRGlZRXpKSVdZc2FVTk5qS3FJRzlD?=
 =?utf-8?B?NW9OUFRoMkFqdFI4dFRENzVpVnN5ZlZjU1dpcWl5bEYyN2dwaXZ3T29GbndX?=
 =?utf-8?B?bTluWlFUbmE5LzNRL1IvRzNGKzJBb3V5azdndWdGVldnb3RyZDZzV2t1aWlr?=
 =?utf-8?B?d3NURkVlcU0ycEFjY1Bjei9waVp3LzBCVlZRZjJrZUZvQy9vTDliWHh0WFZl?=
 =?utf-8?B?NDViZytpaXh5eDBWSjBNZ3hLa2o1T3pBTE44VHdOSFpGR09IUmdRK2lUT2xG?=
 =?utf-8?B?ZHJ3YStXY28wa3hUekhjN01QWlIrZEZCM09Xa1UxeWx6SDJRYVZJVjRranQ5?=
 =?utf-8?B?VlE3Z3NSRFBlTjdOVU1hQkJSaVRSSitHQ2Q5azk0NFZpb25iMHFPcGR4SEN6?=
 =?utf-8?B?QVFnb1VsS2g1QjArQis3Q05BTTd3NG83eUZXZDRBaGRwaEpkN3pIanBQRWdJ?=
 =?utf-8?B?dklsWEVGMGJjeitkd0pEdXNkUFg1ekpLOEVyRjdKQy9iMnN2Y0xTcXVyMUVo?=
 =?utf-8?B?MVMrYStLRHZwOUxDVXRlSmFFVmJmblVsNFFDUVdIZ0RjL0NZeW1UZEp0S2Jo?=
 =?utf-8?B?MEdEY1E4S2tSeDNydGRrOXA1aFdVa0MrODJMZU5sdmd1WlQyYWZ6MmNjcC9K?=
 =?utf-8?B?aUR0R09oWStobFk0VmFONno3TmE3cmxoSzRjRE1icUdQajJiM2JVSm8xbUs0?=
 =?utf-8?B?WW5VdlVrSHA5QTZGSFN5LzlBNzlLUEZEcXl3bXl2aHc4dEVnNUJVRXFPTDRF?=
 =?utf-8?B?d0hoeDNSMVkyWTMwdnlwUjY2WkZuTDNYSm9XKzd6bWFwOGlnczNZaUM1N25B?=
 =?utf-8?B?Vmd0cXJuNlIzU2F5cmR3U1JjUVhSdjhGTmJ1czRPMFBJNStoVXdqQUhRYTR5?=
 =?utf-8?B?TlJVZmZ5cVJlaXhjZHY5c0p6TEtadHVpMU5aSUtrbGRNY1Q4TERDUFE2UThV?=
 =?utf-8?B?cGRlNUlQZTYyZG9uNlpSUC9OR0c0enozaHcxR244WkZRd0MvUHVWYjExbC9D?=
 =?utf-8?B?bllVdEQvUXVDeTlRWVhHUGQyaEZtQjBSN1N3MnhURnZOM0U5ZElGYXpoRUF2?=
 =?utf-8?B?V3dtWVRrZUV1azEzWGxUMFZVelpxS1ZNYTB0Mjg3bGRwV1lFclhnbjk3TnRG?=
 =?utf-8?B?Unp2d1BjdEdqUnpaRDNkdHE5Z0Q4QzN3bzVwT0tNZ3NaeXAralk5MURseHkz?=
 =?utf-8?B?cnBTaXZjN3dES1NoWEpXcEdNRS9rNUNaTmlJSXhjSWlsTkp5cmowRGsxMHBw?=
 =?utf-8?B?ZEJLWUlsRGxLanlBNEhNQ3dFdC8yTU1jK0VjZ3Q2a0hXS3hyVE9UVDdzSUtG?=
 =?utf-8?B?RXRlQkpMVk5tM2Q1eER6dDd3VlBmOUNXd3d3Z3B3NGxLcEtvcmpLMHlJTnhz?=
 =?utf-8?B?NDZOZkZvSW9JRE9ZNU5NaUNVc2JBZW9kblAyUUxUWEwrSC9sOXl4aSs5TmtE?=
 =?utf-8?B?SVp0dHI1YzFjK3Z4SHZWbEdjSkpNamp4aHgzNWY0b3I0UGVlN0d4NXFqenpt?=
 =?utf-8?B?WXd2alFvTExLendCWGJmR1VxV2RzSVpMRTdzWlh0b2Nzam1FejJDTXJ5Rk9z?=
 =?utf-8?B?TVVuVUJ4Njl0MDA5c3NDcVV2dEd1dnRJR3lHQlkvQ3cwbVY1dFVTelNPa1FO?=
 =?utf-8?B?MFErc0xOL0V3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3RseTliWTJqeUhaU2dKckxBS2ZWS29pbnp0OVh3aHVMM0xOZGhzclFFbWhu?=
 =?utf-8?B?cm11UUd4MU9DWS9LZE9OUHRJV0VoZm4yL0Q2MXUwekZrREN6TEF4NUh5akVu?=
 =?utf-8?B?bFBTNlNlcGxWdlhvR3lrdXppSWxvYTdxZmt2NHdBbDIvelpOZHVwTnVIRUE3?=
 =?utf-8?B?bnJLczRhQytDZGZIRFlTYS9RNm1JSno5UENCWE1idlVUT2RyZTJtVFBPdFpF?=
 =?utf-8?B?eUtUaC85aEprM0lvSC9RZmcrR3k2RFNseW43Rm5rdmhQaVoyN2FPck5MK2lM?=
 =?utf-8?B?cHY3ZXRveVR6NS9laEVCTlNSR2JsOGUrc3lTZ2JGcktLZDM2ZXZWWDBqMGpz?=
 =?utf-8?B?WG10UUkyUElWSDFoUnlGbElseXV1ZTdHd0lQN2xGSitsbXI2ekE5aHZ4eWMx?=
 =?utf-8?B?U2FYZ2JXRGhqd3N5OVEwR0xaSmxuMEVwbHJqUmhsa0NmT2hDdmo5TExJSVJF?=
 =?utf-8?B?OFpteWxPUHgzQ1pvd3NCcnh6MTZWSHVtOEV6WHAyMk51Q2x3dWpOYmtwc2Yv?=
 =?utf-8?B?VFFLdFUwNkRkb3FTQWs5dGFHbGw4d1pxdUhWK0Zjdzl6QXFINElxNTJscVF4?=
 =?utf-8?B?OVZucTc2RUFiZGg1ODZxa1J6emxTdS9MSlBySTh1QyszZTl5UHl6VFN1TFlT?=
 =?utf-8?B?Wjk2Zk9jM2VwbGpoSWd6Tm5KZ0h2UFZrK0g1eDRCaG1SODl1KzgrQkFLNUcy?=
 =?utf-8?B?VXg4Zlg3ZWdRZXJjc1B5WTVmb0c4cU45Q1RiM0ZoN25XRXBxWnRidzNxSUdL?=
 =?utf-8?B?bjlGaGxQS3JxNlJYS0RwMllZc1JzeXBRbWxlRVE3d3ZyVWE1Vzg0N3dSdjYw?=
 =?utf-8?B?SStrbjEyYXBSTm4ycTA2USs2NnJvZWNKRkpxOVNHTzA5aFp4bkZVV2dwN1pj?=
 =?utf-8?B?MjN5RVN3VWJUUCtkUjRQaHJrZ1ArVWJOUjc3MEZ2TXBJSlc5ay9xQTNYa3Rp?=
 =?utf-8?B?bDEveThKSUYyYThaRXFpYUJqYXNBZ3NKL1dZdzNuYWlqQTUzS1c3eGl5UUx2?=
 =?utf-8?B?alU3Vm5Xb3k0MW0yTTJGZ3h6YVlYdlE3bHkzbEw2eFM3NlZvd0E1QjFkcEMz?=
 =?utf-8?B?YlNRam0rZnBnV2gwL0Qvc0ZtQ0pjTDhEQWpmRVo3L2VhWUlFazZtdjJ1dENF?=
 =?utf-8?B?TE1OL2ZCWkE5dFRjV0Vqd09udmk5K1VMM2cwZ3RjQWhXYWFyZjAyMjVrbGZ6?=
 =?utf-8?B?aWZnWURFMXJCdlRHTXJYU2RGQStJQmNBYUg5NGlZbGpaSlVlOVhlZVdUYy94?=
 =?utf-8?B?Vkhob2poUUtLM1E5LzdOY1RqUGRsNnlPSjZBOWFOREJpWDBsRG5WdWtwcDRE?=
 =?utf-8?B?SEZGL09EMHdDRkxkUjR2aFozMHhZdDd5QUp1RCtsS2RvK2I2bVJLVXhGTUpC?=
 =?utf-8?B?aUhiK1dlblBtSG8vQXJsWDF0MVF2Z0pLenc3UExveUxROVVtYndsQ3lwMkxP?=
 =?utf-8?B?UGUvazhjaTFFbDdxN2wzL2s2Z3FRTDN3dzhaTHBVUXl6M2lNS1FyOGUyNUZV?=
 =?utf-8?B?eDc0d1lKMnZqTWtERWJFQzhvYjBsQ3UxKzdZbHlHTDV1VUdlN2pKUHZPWERz?=
 =?utf-8?B?T3A0VWFRRVA1UUpWVlNWNUY2SXlnYVh1S0NWMG12eW9wV3hZTi82RXlocVZV?=
 =?utf-8?B?OC9oQ1o0dFdvSEJOR3BRakdiWHZJMDlQVk9udXN6R0puS0xaK3ByTUFMYmE4?=
 =?utf-8?B?Vzg4YmtGWEtBOTdMR25ydXFoUFNNR3lBeHYrQm93VGRnSGI1cjl5QWVmamp5?=
 =?utf-8?B?OU80ZXlacmpEU2hSNUgwMEh5QURoc1BGRkhaR1BSYWRzVXE4Q1pwdDBraGZU?=
 =?utf-8?B?UlM3RVZSVVlINk5kQWJGbTFHMCtWRC9RcGpyS0s0dkJlMnNuS1c3dk9FS3My?=
 =?utf-8?B?RWVJRTJMb1Via3dnKzk0eTB2UXJPSFNCZDV0TXkya1lWT2F5NzVWR1RKQjlB?=
 =?utf-8?B?b0c5NndaVFkwdGpjMFZ4NVZFdzVZTjBlZkNXekVSVVh2eHQvVDNvalVLTDAy?=
 =?utf-8?B?SlJRcElMMm1veHJzbjlHTU1CMWdCTFhtdEhxakNSOW40Tit1QTdiUVBKUnZB?=
 =?utf-8?B?RGZwalpDK1dUdUtaWkFTUFk4RXpzVHl1LzdFWWR6dUl3RjNmRTU5U2ROdXdI?=
 =?utf-8?B?S2w1Vlc0eXZ3RjV1RjFCWHlENk5paGZNdExDY25lL3FjejlHM1BkdS9MSXBz?=
 =?utf-8?B?UlE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14647.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21201bae-2cfb-4803-ff24-08dddef9b853
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 08:23:47.6607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5OOH1ACGGcw+c69NFB1eybbMt8dPwAqf3LUQ+VGoh0ny01YXNRS5o2DXVKRsNrgQ9f+OlYphCKvkbuS0fgwWR9AXr0f9cU7DpE0OjfySNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9659

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02
OGsub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTksIDIwMjUgOTo1MCBBTQ0KPiBUbzog
Sm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY3IDMvNl0gdGhlcm1hbDogcmVuZXNhczogcnpnM2U6IEFkZCB0aGVybWFsIGRy
aXZlciBmb3INCj4gdGhlIFJlbmVzYXMgUlovRzNFIFNvQw0KPiANCj4gSGkgSm9obiwNCj4gDQo+
IE9uIE1vbiwgMTggQXVnIDIwMjUgYXQgMTg6MjksIEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54
YUBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gVGhlIFJaL0czRSBTb0MgaW50ZWdyYXRl
cyBhIFRlbXBlcmF0dXJlIFNlbnNvciBVbml0IChUU1UpIGJsb2NrDQo+ID4gZGVzaWduZWQgdG8g
bW9uaXRvciB0aGUgY2hpcCdzIGp1bmN0aW9uIHRlbXBlcmF0dXJlLiBUaGlzIHNlbnNvciBpcw0K
PiA+IGNvbm5lY3RlZCB0byBjaGFubmVsIDEgb2YgdGhlIEFQQiBwb3J0IGNsb2NrL3Jlc2V0IGFu
ZCBwcm92aWRlcw0KPiB0ZW1wZXJhdHVyZSBtZWFzdXJlbWVudHMuDQo+ID4NCj4gPiBJdCBhbHNv
IHJlcXVpcmVzIGNhbGlicmF0aW9uIHZhbHVlcyBzdG9yZWQgaW4gdGhlIHN5c3RlbSBjb250cm9s
bGVyDQo+ID4gcmVnaXN0ZXJzIGZvciBhY2N1cmF0ZSB0ZW1wZXJhdHVyZSBtZWFzdXJlbWVudC4g
QWRkIGEgZHJpdmVyIGZvciB0aGUNCj4gUmVuZXNhcyBSWi9HM0UgVFNVLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0K
PiANCj4gPiB2NzogUmVmYWN0b3JlZCBkcml2ZXIgc3RydWN0dXJlOg0KPiA+ICAgLSByZW1vdmVz
IHNwbGlubG9jayB1c2FnZQ0KPiA+ICAgLSB1cGRhdGVzIHBvbGxpbmcgdGltZW91dCBhcyBwZXIg
dGhlIGRhdGFzaGVldA0KPiA+ICAgLSB1c2VzIGF2ZXJhZ2UgbW9kZSB0byBiZSBtb3JlIGFjY3Vy
YXRlDQo+ID4gICAtIHVzZXMgcG9sbGluZyAoZmFzdGVyIHRoYW4gaXJxIG1vZGUpIGZvciBnZXRf
dGVtcCgpIHdoaWxlIGtlZXBpbmcgSVJRDQo+IGZvciBodw0KPiA+ICAgdHJpcC1wb2ludCBjcm9z
cyBkZXRlY3Rpb24uDQo+ID4gICAtIGFkZHMgYm90aCBydW50aW1lIGFuZCBzbGVlcCBQTSBzdXBw
b3J0DQo+IA0KPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUhDQo+IA0KPiBJIG9ubHkgbG9va2VkIGF0
IHRoZSBjb2RlIHRvIG9idGFpbiB0aGUgdHJpbSByZWdpc3RlciBvZmZzZXRzLg0KPiANCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3JlbmVzYXMvcnpnM2VfdGhl
cm1hbC5jDQo+IA0KPiA+ICtzdGF0aWMgaW50IHJ6ZzNlX3RoZXJtYWxfcGFyc2VfZHQoc3RydWN0
IHJ6ZzNlX3RoZXJtYWxfcHJpdiAqcHJpdikgew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZV9u
b2RlICpucCA9IHByaXYtPmRldi0+b2Zfbm9kZTsNCj4gPiArICAgICAgIHN0cnVjdCBvZl9waGFu
ZGxlX2FyZ3MgYXJnczsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAg
cmV0ID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MobnAsICJyZW5lc2FzLHRzdS10cmltIiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIjYWRkcmVzcy1j
ZWxscyIsIDAsICZhcmdzKTsNCj4gDQo+IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9maXhlZF9hcmdz
KG5wLCAicmVuZXNhcyx0c3UtdHJpbSIsIDEsIDAsICZhcmdzKQ0KPiANCj4gPiArICAgICAgIGlm
IChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKHByaXYtPmRl
diwgcmV0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVk
IHRvIHBhcnNlDQo+ID4gKyByZW5lc2FzLHRzdS10cmltXG4iKTsNCj4gPiArDQo+ID4gKyAgICAg
ICBpZiAoYXJncy5hcmdzX2NvdW50IDwgMSkgew0KPiANCj4gIiE9IDEiLCBob3dldmVyLCBJIHRo
aW5rIHRoaXMgdGVzdCBpcyBubyBsb25nZXIgbmVlZGVkIGFmdGVyIG1vdmluZyB0bw0KPiBvZl9w
YXJzZV9waGFuZGxlX3dpdGhfZml4ZWRfYXJncygpLg0KDQpUaGFua3MhIFdpbGwgdXNlIHRoaXMg
Zml4ZWRfYXJncygpIHZhcmlhbnQgaW4gbmV4dCBzZXJpZXMgYW5kIHJlbW92ZQ0KYWRhcHQgdGhl
IGNvZGUgYWNjb3JkaW5nbHkuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIocHJp
di0+ZGV2LCAiSW52YWxpZCByZW5lc2FzLHRzdS10cmltDQo+IHByb3BlcnR5XG4iKTsNCj4gPiAr
ICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQoYXJncy5ucCk7DQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHByaXYt
PnRyaW1fb2Zmc2V0ID0gYXJncy5hcmdzWzBdOw0KPiA+ICsNCj4gPiArICAgICAgIHByaXYtPnN5
c2NvbiA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChhcmdzLm5wKTsNCj4gPiArICAgICAgIG9mX25v
ZGVfcHV0KGFyZ3MubnApOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChJU19FUlIocHJpdi0+c3lz
Y29uKSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUocHJpdi0+ZGV2
LCBQVFJfRVJSKHByaXYtPnN5c2NvbiksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJGYWlsZWQgdG8gZ2V0IHN5c2NvbiByZWdtYXBcbiIpOw0KPiA+ICsNCj4gPiAr
ICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+IEdye29ldGplLGVldGluZ31zLA0KDQpSZWdhcmRz
LA0KSm9obg0KDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0N
Cj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEz
MiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNh
dGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLg0KPiBC
dXQgd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVy
IiBvciBzb21ldGhpbmcNCj4gbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=


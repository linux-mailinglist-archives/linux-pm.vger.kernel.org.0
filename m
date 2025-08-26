Return-Path: <linux-pm+bounces-33095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA24B356E1
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3292F1B61C19
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482F2F745C;
	Tue, 26 Aug 2025 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLc1gLHy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9351FC0EF;
	Tue, 26 Aug 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197000; cv=fail; b=JOR2Oef06VXyPzAztfCL8dRm1UvrL7KYuRC+1RyGxDItpuc9ez8vgF6X2gyCjsr4gc2m97dnyT5GrYhT74S9vf6zcLvWea6D4GW/fwJ3SzNibZoD5GsYAC8i+KilFpepcJ1SXNlcTzhCETJO3pmoWmfj0gnKiYlR+2MEjtof9ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197000; c=relaxed/simple;
	bh=JPVM6LGlQ6q0ToRzkcEHG4/VAWporT3VnPcUch85cnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqpRyhP7anY1/F/ZoJ3cgpKwTPHnLR5mKj28qRbJj8GbXyaksCdzNZNNxxF681upewI5nuE/btQsZg8UIcKGi0t0jXC9sTZPcXxMpl35fQwnmKaRXxmmji9LMAKHIzMY+fLTFK0/pkeolGmaqrAgsOYqjjJDnbom26A7HWtumKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLc1gLHy; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VF5aMV0WqDYZlxT9KJf/DgDtfRIFt1D66XnCkzbPmIX42wtZSc9gHvbKuwdmwAxrxPEz0qe2aZs/vI8Zby2BzgvcR/zEf+ZiHA0MbL+ql61IlngYeZT0pgUGoIJhvCSrOZ9PPWLzJERRGL4sgV2QSS8TEg6Gru/hF3xwlw/hjC/q3EtTMdtanNQMmdcj8qttVuqrebxCAlk8U2YeaTxmc/R+yyoAvgJkHsEk4s97EMEnpg0Nd7BIs/KTiUaKSjC1JhzAyl7mTfgQFbWRMHfl31uedE1iJCT++PEDvsHM/LUsPnId2S6vKvers9D9V4J4aDay5cnU8gGf6ta21TFjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l56325eYtTWp5JGFokib4VZ3JrUuSt/+mpXwwRtkBSs=;
 b=vxU9AfFc5YxRn2ZqsdiG4i0gpAd6P3zuF7pyCjkPTcjYgOzI0inaHRrKZTJTd1NOjFClPae4+0VPmk/Hp4+uxVejj5m3flQrjeZL8y10DXgDEFuqSfdYVSQlH4quzgG2UhnSReBTfDCn4TtMSVTSpa/te4pp1t/hvePzR/t6KIhtx3r6oQ+ukazRoA919iuQMGQ27KJeVDyYH9X2iuAow/q8KMHO9ZcasFAfF2hs5O0ylnIgSz3Bo/JRq2zjT8iga5yiLxmsKP4SGO3oEMqtvKQYqNfC4makS8HRVe6geAS0TpivN8pLxSXB+cX0R//HWPscybMmqQLEa43WWzS6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l56325eYtTWp5JGFokib4VZ3JrUuSt/+mpXwwRtkBSs=;
 b=RLc1gLHy3UvKnFjhdDLvaRuFUXPb3ZnYosqlxlbOFx9Al/gCpETn9AQf9xxyClAnBz4rQmwLbPrjud5VfXbTGfu/kPzpCtzlm2NCkUQGC7/Nd7Tp/+ntuoYtwgQPHeXfGQmeS/hWtKf5wGSeWUO6fA6L23UZgorwLGxt56ZZOPN0oJGDJ2Ve5OF7K/gKXKVUpjx/0bo1v5XlA6aQ4fgmeO70oZnid8EhZ0AI7oXnhfbwZ7dJCMwkMP7Zk3uK5HBsFmQADYlJSK4aLRJLrNLmP6EXvuYoMsnMlD31n4bTbxjF/izCbkqjMasnv8h6LbaS7/ZZW8h6xgm7T9Ej9cbrJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 08:29:56 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 08:29:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: reset: add Tegra114 car header
Date: Tue, 26 Aug 2025 17:29:52 +0900
Message-ID: <3303492.5fSG56mABF@senjougahara>
In-Reply-To: <2ef333b7-2c4c-4c06-b90f-5dfa8af41e36@kernel.org>
References:
 <20250826061117.63643-1-clamor95@gmail.com>
 <20250826061117.63643-2-clamor95@gmail.com>
 <2ef333b7-2c4c-4c06-b90f-5dfa8af41e36@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0062.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::15) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9ed869-91dc-45ed-45f3-08dde47abca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|366016|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3V1c29XeG1iYXhtalBmZlJ4dDIwMm40SnhMdkttd2ZBeG0xeUcxVFJBQ2dS?=
 =?utf-8?B?aHF3YTNqUjBnMUF2M3o0dE1SOWYwdS9RNzQvVTdXZ1Ruc2txdHh0NXNYN1M3?=
 =?utf-8?B?N2pWdy92cFViWHZmMWxwV2x5MFdxWnJLcit0c0JWekUwM0NXaUFYZERSdnB6?=
 =?utf-8?B?SnVja3ppckdhSVNJbkNXbHRmd2dwNEZCcE5vdXlWMmI3TklyZzlUSG5xaExC?=
 =?utf-8?B?blFkWVpNK0J5OE5HYS9tZ3VlaDdnM0FQTUxiemJYaTFrSkFETnhicFZaL3h6?=
 =?utf-8?B?TzdvcUdEaEYvU21VOHdSeUphNURyS2RxMkphOC9Id2VCNjlzbnNaREFKS3l3?=
 =?utf-8?B?UU5xRDZLM2RrU0pjOTNLcXhVeUFDL3g1QmFSWFR1Q2ZVekwvczVDbG1nYkRJ?=
 =?utf-8?B?RWUvTmRyM0VUVitnYUNwbzBwTEJIVzdqWHZwOUNIRGg1elZOTldzY2hreURZ?=
 =?utf-8?B?bHg5SmVCUVl3eDdZVVRtM25PV2ZROEExbEM2R0tiVWdwUUEwM2JjWXM0Wmxq?=
 =?utf-8?B?dksrSjNsM2pWVmRJOWE0YkFQZHBCY2ZuR0ZPd3J2anU2TVlWRzM2eWtnazhT?=
 =?utf-8?B?UUl3RlkramRpN3Yzc0d5NUFUSGJyR2M4YkwxbFlqYkxXWXBBa1hwcGM2UG52?=
 =?utf-8?B?SUoyd1huNXhzQmxhNm15VlpiL2VISExLeEI3NElLUEg3bWIwWHVpc3F2VDFr?=
 =?utf-8?B?SjFVOUxma3JsWmtINXQ2bnE4bGUwSFlyekRZYWc2Nks1MjZSU245L0Y4bW0v?=
 =?utf-8?B?TkxpMldjWW4yNytqOEFsa0drcjk0cUlQbUxsWllhd01sNHlwdHM3ZTZJK0t5?=
 =?utf-8?B?OEorcWwxSWRDcWtCa201ZElPa1pEYmx5UEZGdXF5V1FNekplUjdCcUNtTFhm?=
 =?utf-8?B?M3lUdmtnNk9BbmNYQ01RQ241N0oxVHhwYnJoQVpUekJjUkcwTmc0cnZsWVR6?=
 =?utf-8?B?UVJ5V0hPZDd0SXFFdWhoQmVlVmtzdU52S1ZqSVRzVlJZeDdXbWVTc1hjNTdo?=
 =?utf-8?B?citkTTJKd1VNN3JOOGtTYVFtZGpROW5RUDMwT0k2Vm84cm1oc0NnWVd0QnZY?=
 =?utf-8?B?aE16L2piN1U5U0h4S2lBeGFCYnJrMEhzQTBBekF4bXUxL3hkUUo1M3JPcXRa?=
 =?utf-8?B?SitiTlpoTlF3ODQxZEFJOTd1d09UMlFxRFZNOWhpYURDWnRIVEIwbkhCdGxG?=
 =?utf-8?B?RTIzMkVjUVdScWF2dUtsNlpOZzZDc2haSFVia1pyNU9mSStucjVENWRObDBs?=
 =?utf-8?B?Tlp5d043ekdOK21nTExEZThZTzlMMEx3RFRqSjhKOC9rdmV1SXg0dzRVWHBs?=
 =?utf-8?B?NGpHb1NQckVYRnhmNFpobkpNYmZQS0ttQ3RtSFcrczRidklPMnFmeGpLZlVQ?=
 =?utf-8?B?VTJ6VzlieXdxTmlwbUllaDRmM2N6RGMwNXlkZVUzc2tJYjR5cVZZdnFPcVRX?=
 =?utf-8?B?b21pbnVGSHFmT2FNdmNxenZERnFiNDcxanNKbVM4UExUUk9NWFl6bjYvR3F2?=
 =?utf-8?B?R09ka0EyYkc1Zys5aUhqTzFpNlZGWklpT0dUb0cxZS9wZ3RaV2RnMmozSERL?=
 =?utf-8?B?VS9xam9vNVExWks5K25Ic3Y4RysrVTZja0I1UDlINmFuR09rN3IyNjkyeGxr?=
 =?utf-8?B?TlFwd3ZrT3Vob1VPQ0dHZzcvWlJwNThJZ2dXandmWTJCdjgrVC9CcTQraEVq?=
 =?utf-8?B?dVUxcHVKSXpxZmN5NkNEbi9HRHVCV2hrZnhNMDNTYXIxYVpqenBJaVpNUm5S?=
 =?utf-8?B?OWJ3SkV0Zk5Md3JONVp6ZlN0MVZxdll2Y2JmblJTUzg5MVJKbzJEenZmVVcx?=
 =?utf-8?B?YjlnNUdvd3RNMWcxZVZsZStvY0VBbkRvWTI2Q1VWVXoyRy94REcwUEFOTjZU?=
 =?utf-8?B?MlJsVDlMLzJPdHkxaW1uOWpkckRUM1kzYmNnNjdtN2k2enEzTjRURkZFMUJ4?=
 =?utf-8?B?TzBnUlQrMmZ2a2hZc05Mc0VScDJUandILzh3VGJwNUxDbEg2VDlrYjVaZ3VZ?=
 =?utf-8?B?UTdENDd1MXhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(366016)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZGdE51ZEt3TlJueUQyYzZlUzY0S3htOVp5OHFUYVFFbmJjWG1BNG05d25u?=
 =?utf-8?B?NlJGV3VGUTZDZHdLMktLdTNkY3RudFl1MnBnTFZWRkN4LzdxYkgra2kxRmQr?=
 =?utf-8?B?Umd0eFhCL1NxZzFaYzN2M1UvaldGd1FiNGMwUFFMMXJtcSttQVNJRCt4NlUy?=
 =?utf-8?B?WndNcmFvRkxsQXdyWTFRTUkydzlaZG5JOFo3OFhkc2w5clhIUzh4eFd5Vm9F?=
 =?utf-8?B?SE1CWVdwcmpJSG9uanBGWElIS1cyaGJmQysyaURrZmxSUjFCWW1tb2VCWDIv?=
 =?utf-8?B?T1doQldsdXlwMTl2UDdYbTNQbndTdm5pOExpMjNla2NUZWlNa2lqaEhwU1RM?=
 =?utf-8?B?bFd5MmpzRXJ5ajYzMUtTd2x0TUw4YWdQTTZhYzdVVGVIZmZ0d1ZjUCtwRXVN?=
 =?utf-8?B?WW1UckFraU5ZVkMvcW9nTFJhUkNOaW9uRTBBWDFHSlBWVm9sdDYrSmlQUmQw?=
 =?utf-8?B?a3dXOXA3a2NFQTB5TVoxc1h1SUFvL2FmRUw4Q0dsSHVISTZlRjdraElsNTBS?=
 =?utf-8?B?d2Y2SGJrQm5WZFp1RStIRk1tbTFWTjl5YlFIREJoRkEyYVVZc2FOdHlXa0dn?=
 =?utf-8?B?VFNweTE1NjZmbytOeTNSOU1rbFJ0eHVpbFpNR0s0UkViRk91VUJjU0hqNDB1?=
 =?utf-8?B?ZkF5UFZrZzhXUXpkczNMRmYrMU9TcjFMTkhxOG9TVWEvWm9ON0R3NGt4bEpz?=
 =?utf-8?B?MXVyWjJoalJGbXNFcHkxWkpxUzdpQWpJZW0zQ3c3Ky9ZbXpKTDRDN21ZU2NN?=
 =?utf-8?B?NGpaa1g3aGlFSEZXWDl3eEpZUkxNYlkzUzU4QjBjOWFoMi9FRU8yWXJLOExJ?=
 =?utf-8?B?Z3pURGhjTUtXeXZUcFYyUXQyR3k2RGY3di9RaStIRWxVNFZMK2dVUkFJeElG?=
 =?utf-8?B?VnFKU3d4TE4rd0xON2RrNlRKK05SdTJaRU5VNUR2aE5UUk83QlVoRURzaDUr?=
 =?utf-8?B?d2M4SzZLQVpiUkVxa1o2L3lqL3FoVDFXOFZKblBmU3QvQnBmUHVrQU0vT1hx?=
 =?utf-8?B?WHFZOFpwT1UwVkV5V2pzNUNCenV5eDZVcWZCd0xHWlNiajlYYWpxeWdCcEht?=
 =?utf-8?B?S0ZkQmJlTzdsUk8rdHRjYUF4QytCQzB4UWNuY0ZLTXRlY2hKOEZncFp2UWJT?=
 =?utf-8?B?NFlaMHZlRDNzNk5kQkJQeitpUHdsQitJdW94WnJuTnVVNTBKc2pBVEgyR0s4?=
 =?utf-8?B?QW5OMHE4QkJHZUZOYzQzOW1IMGh3ODhvSkhsUkNCL2ZVWHdsbm9aNFBPWTFr?=
 =?utf-8?B?ZWUrRGVkc3c1Yko3d2RReklrZ2RUWGtjVW9jcThZWnhKWW5OZGFLeTd6SHVV?=
 =?utf-8?B?NklUV2wrWFVKY0xiTlB4cFArNDllbldxZThZTTlzeE9sS3V6TlJYTk1YeER3?=
 =?utf-8?B?SWV6UUVQa1FNNzV6bStDQzBjcVIzRWdybkdjNFhGMVRYZVhvL0hkZWJIVUFH?=
 =?utf-8?B?c3FDWkE5cDhiZEpmNkN4MnppOE5kMGRQZnRycElJNFdBUjE1Umo3Y24wWHZG?=
 =?utf-8?B?RkZnN0tvdVA0SlJEbXB4VFpjRHRNbGNNeHd5RFB3NlhxbDBPNFdhbUZ1dm5r?=
 =?utf-8?B?RzRWb3ZoMFhiSmNlS3VBTkNBZlFkWEoxNm8zalpFUUUzT2lrRCtlamIydnBK?=
 =?utf-8?B?aXN4L0FDTHZ5OEFpb2sxN0pvWkFyb3o2OU9kUWozdUxRenk4QmVvUEZGMGFB?=
 =?utf-8?B?MzluZWROTnlLeW5PNjJoazNVZVJJbGZBMTE3WDhrWWdaR0ZmVkE5NjB3UTdB?=
 =?utf-8?B?L05kbTlRY1BSMEZoTjUyMW1TaDZJaUVDZjB0eExHRmFmbHNDRytTTHAva0hm?=
 =?utf-8?B?YmVzSmFGaXFGRklzVUNZMFo3d0xyTlRpSHZobVRGVVA5NzlFMjlCUk5mNUhZ?=
 =?utf-8?B?YzdxS0JLSUpXOXFVcmtYMG03SWxDdjdFa1NydzRGcktMeDBSNjNoMDhLTk9h?=
 =?utf-8?B?N2NCeUlGWWZxSDdqL1pRZ1U0MUpUa0JXWkI5dWRzZ21OY2JxNEt5RGI4aUs1?=
 =?utf-8?B?RnN4cG5CMWY2S2hxdWk3UlcrWmFLNndBanZTb25VYldSVVN6d0tNdVE3NXVt?=
 =?utf-8?B?U0pabGl0cTllVjdqczJnRGgvOEhXaUprTDFobTBxUFFKTXIyendqa1UxRkl0?=
 =?utf-8?B?QXByVWRPbkx5WVhOVFVHOC9CZmpoL1QxSURaU0VxaTByN3lFQkxXWnhGYXJS?=
 =?utf-8?B?N2lGamxHeVltQVllZ05WbVg0eFNJUmpUMkEveElzRmp1V2VmaHdIRVh3OVFn?=
 =?utf-8?B?YkIybWFGUmRXZGNSZEFjQ29pbStRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9ed869-91dc-45ed-45f3-08dde47abca3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:29:55.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m6cBqZ1UE5v3FX8r6IEIxgroiVx15sjUVuvBKMkuh4jzy5ssbt7dbJZz39rnRzf4UtgHcKbIPeNxxvXBiii5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678

On Tuesday, August 26, 2025 5:21=E2=80=AFPM Krzysztof Kozlowski wrote:
> On 26/08/2025 08:11, Svyatoslav Ryhel wrote:
> > Binding values for special resets that are placed starting from
> > software-defined index 160 in line with other chips.
> >=20
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >=20
> >  include/dt-bindings/reset/tegra114-car.h | 13 +++++++++++++
>=20
> NAK
>=20
> You got comments last time and you completely ignored them.
>=20
> Best regards,
> Krzysztof

Thierry explained to you last time why this patch makes sense.

The existing binding is such that values below 160 map to clock IDs (in dt-
bindings/clock/tegra114-car.h). We cannot use those numbers for these "spec=
ial=20
resets" that have no corresponding clock, or we'd be changing existing=20
binding. Hence this patch starts them at 160, above the clock IDs. The same=
=20
already exists in the tegra124-car binding for TEGRA124_RST_DFLL_DVCO -- th=
is=20
just extends that to Tegra114.

Mikko





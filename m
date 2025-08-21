Return-Path: <linux-pm+bounces-32813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C8B2FD09
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 16:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0753B2329
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790026B75F;
	Thu, 21 Aug 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N5UJqTEk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB62367D1;
	Thu, 21 Aug 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786827; cv=fail; b=hFd3kn3efY4GxvGzlfQht9VA3boklVZDN741bHkSWF0NYA+dS5MC8q4Kwu0x9orcCOkGeEmOV4gjtXvMeZYR1nr9s1q/ju34qgQDeZY/kkk/6ccskM6jxa6DlP4Pq4md7sFFTJdVKY3uYwAdO3guvoSe5Wyk/2tc1rIPMtV53mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786827; c=relaxed/simple;
	bh=IplE8c3b9AtchOmZSt5qVaw0N4+qLM5Lm9aG7SToF5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nW1+OxePqjkR6gYPNyB6PEs+Ye3h79vWdv6ZCpeqDSSHNvXqg092tGRdEfYNPr00vo4IScbI3cASYn4R+ZeJ1UpeCamBXKAr+oEaemMZAlAxArS2vaK5BWES9J+Xh2E5Nmocw2UpsCCTlshoTbN+N+XxwNJ9TA+EjD0gwNE35eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N5UJqTEk; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipsIOAlFBNpttqkzfnZSrkR5zsg7ubbFsstDVNvLOh7K53iFXbgMNgxRr8m3XBnUrcfK5dA2U0nzO494fDhSMGQQ556ZtqWMoRY2QtMwaW1ziTDr2+DkIPOSPMPxGR7Tg+9gR9WrpBy9yGtl+mM+0S1hpDtEmUaX13RsHXKr8sQYVszeEJ+zCFxV/Gv/CuzFRnoceoSJ65JFFAN+TK9Zp4AGzT4fefQT+CSZVTf+DSXVfMew90FbZTH3pLyD0BgWW0cidufIizcM/usWgA7jnbDjv9J8+1yy+clN4nLIN0uQ8xv3IXeAejd+iwnLAxLYPYYhiyj/+rzwWoYKMF5WzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IplE8c3b9AtchOmZSt5qVaw0N4+qLM5Lm9aG7SToF5U=;
 b=uaqarvZYwCGgq8x8YThk8r6qsItE3EXV4YvYMXx0Cp5dDhGwW2B0vB/ET/J9Q3dbbTjjrJ7pDRhT0Tibtu1P/pFADBkL3l94WyUm+4ZTQFXFcMfTadqML0vX1e3nK+BPqc6VraFwn62ARc52sv0dAuofyjS8yg2pQdoEBP2H49WULyDXUzoVEyrvoKVeY67Elc7KjVSEM8ekB00dltdfpFVgaGg2jZvoaxu156SirScj9dpt64ALqIHhbSHcTf02AkCD9a+VeSavsZCjayqlKZj03D+H1+0uiYvUtxhptZIO7F1Xms1ffx9/2TS9W4insSHcEfbFTaUYSUK8r6HG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IplE8c3b9AtchOmZSt5qVaw0N4+qLM5Lm9aG7SToF5U=;
 b=N5UJqTEkadt0NBlCRsfMwA2gS9oEY2GOHfJiytoKdY2KwSEVBjcSaBqnkxrpmkRamvICyZ5k3sqUIkV7kxlwVIotH7c/m3pNAooZHd/GBYjBn72gLCV/tLNSt1Cv8HwIktLawTiKcEjyxyFUZGRGaDw9xUVfzN9Cux6WeUW+XGM=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 14:33:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:33:41 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, "Yuan, Perry"
	<Perry.Yuan@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix setting of CPPC.min_perf in
 active mode for performance governor
Thread-Topic: [PATCH] cpufreq/amd-pstate: Fix setting of CPPC.min_perf in
 active mode for performance governor
Thread-Index: AQHcElPbMtzkCA/Y6EmFufTBSbpw3rRtLIQA
Date: Thu, 21 Aug 2025 14:33:41 +0000
Message-ID: <333e4ac8-8d38-4489-966b-15c3a2f797fd@amd.com>
References: <20250821042638.356-1-gautham.shenoy@amd.com>
In-Reply-To: <20250821042638.356-1-gautham.shenoy@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: 41700e1f-7bf1-4381-eac5-08dde0bfb970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3FIaHRzVjR1VTY2WkdFY250dVZ3VVg3WlhpQndoVkN0a2xhTWtQVjEvMVBG?=
 =?utf-8?B?c0p3MGxSMk1RWmh2Q1hIa2NnMStDQTNpakJyNFAzUnc4THZMbng3TFNQTGky?=
 =?utf-8?B?c2VwQ3dMMStvbXdvQnY0d3ZQVEx2NXdYcGt1V2NmLzUvQnBZZjBvVzM1N1Fz?=
 =?utf-8?B?WmFOdjlPYTAyYmZibG1aYkFiNU9XcGRiMXo1ekNFSDJuSnE1Zm0zK2JheG9o?=
 =?utf-8?B?N29UdTEydHZ2WkxNeXlQeWx1MWpvcDZMYWNnS2g1Q09LVDBFOG5sSWNiRnBq?=
 =?utf-8?B?NFdGam5rV0FmdE5wS1F1UzQ0ZUZwSkF3VDh4S2hSbFJPV3NrMk5IZnFrZ3lT?=
 =?utf-8?B?WjgrOFZoc2xRR1BCTVNBcDZRQy9LQ21zZEtmTGl4UDVrREU5cVd3UC8rNFlS?=
 =?utf-8?B?TVNRU01jSDY3bDFTREt0ODkxQUNxeGdSNXFyQVVpWHlweWhJVVkxK1VUUnFF?=
 =?utf-8?B?THJTN3psb01DMnNmU2xSdGtGSDl3RnlHYTJyZG5lU2p0TnkxTndCTityUXpY?=
 =?utf-8?B?ajZ3VDd5dXhGQzc5aHowYUVOOUZFTTlPUDV1aVdqT09qK1k0WFB6SGRhNVor?=
 =?utf-8?B?SDNMWU0zUXRsNk5HSkpCMm9iZDB5cmZsNTFONTdSRGs3eHByd1ZuRExlUHhp?=
 =?utf-8?B?U2hCYkVzNXdJRmorL2k0N05oUHk3MnRKY2ZLLzRDWWZZN2V2dDNjbkJoODdF?=
 =?utf-8?B?bjVGWjFmL0k3OExUMllKOVU3dzBlR3ZiSS9CNGgyS3JSV1ZrWmMyaXNPTW5u?=
 =?utf-8?B?OUdjRUgxcG15azlWSmpBSXFGOWdpU1lqT2VKVVA2YlFpQXhWZVhsWEhDN3pz?=
 =?utf-8?B?cXQ0dEQxcVplbjArT3U5ZVRjeWUxaVI5a25NRnZ3dE92a3h0d2hMbUtERmhG?=
 =?utf-8?B?SU9FUHFkWVpLMEd4cDEzcUMyWSsyMlFHdEtrZHI0Q1RCRlRjYW5mTlZwU2FH?=
 =?utf-8?B?cmhUQ3UyTXQ1aWR3aURZSjBSVHJUZGpGNk15Y1cyVWQ3Y2d0WlhQVFFHMm4y?=
 =?utf-8?B?K0w5WDREMjNoblZQTWxkOWV5QTVFUHRKbVkvMG5ZNk5IdUhwcnBhWUViL0J0?=
 =?utf-8?B?RTJDZW5KUUx3UHFrUzdHVFp5T0pVVlhEYWI4QXdhc0lXaDNIYVR2ZUp3VG5l?=
 =?utf-8?B?ZDhKSjBCSGNyZHlCb3BUUGxFTmtHR0wzdjFuNXVtb1BxNmxXa0kvV2xZM2R4?=
 =?utf-8?B?enRaVHFmVVlxWmJWdnV1bXZyZDAxSllHV3pZQkRVd04vb3VVNG9KOFRpaVoz?=
 =?utf-8?B?alc2c2dWR0c1RVJuYkI2K3BLOWZwajh4Z0k4SCsyNmxqSFlKT29JVjF1SFhp?=
 =?utf-8?B?Vmo3OWZPZk9QU3IvaVNrcEE2ZUh5c2F5dW1ZN3JNVDdMcjJZeDdrWGdCREox?=
 =?utf-8?B?dUpLZHJaMGc0N2xWdTVJVGVnYXdNU1U3WHlhUUQ1eVJpZ3p2VW9YWnZ5RnBQ?=
 =?utf-8?B?TlNtdktSU0ErM3BMQ2l6dldjcmc0RUxyVERHZFh3NmFIM0N0YlJ4eTVwd1hj?=
 =?utf-8?B?ZWFXWnAyU2VhNndIekFlY2w5TDAzbm43bm8xUjRkUFRrcGlxV3NsSlR4WVFY?=
 =?utf-8?B?cnVSTFBrdkZFd0lSNzc4eGtlMHNULzk0S2MvMG5xb1VMNFFXeUVxS2NPdnJV?=
 =?utf-8?B?SEVmWm1iMnVVcjYyVG8wZHI0dTBiWEVhOU9kVkN2dWVwYUQwZ1RNK0VKQVZh?=
 =?utf-8?B?ZllLNWdoMzVIbGNDZ2lSWEg0a0gzb3BrSzFEM25qak9XSDdzSG1saHdpNk0w?=
 =?utf-8?B?cUJjNHNyUkxMalgzUTUvMWxhMXhqOThhRjhoVjRBSzZQY2h3NTl3dVBLcVM4?=
 =?utf-8?B?M296UXVXOGdueE9SRlhvaTQrblpsZWpiazJqU2tERWErWkMxUVJsU3dRbXJF?=
 =?utf-8?B?QVJYemN5aHl4Lzg0bWNuQWdZcHVnY1c3c0I2SmVjRXhiWHFXWmYrSGIzbTZw?=
 =?utf-8?B?Y1BoU2xkS05MRndRN1NsVk9tY3grT3JvQllrYjJ4UXZvTjl2NDN6SFllMDNJ?=
 =?utf-8?Q?WNE4luUhIvgEHdHOx5CJgPLQ3iFPNQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUk1QW5BdllJT0R4THk1MkNGWWx1L241YncxNkhTenRIY0ZRRVlIbFcyeUR3?=
 =?utf-8?B?L2FKU0M5eHRpR2s5UlpMRG4yTGlFUTFPV3VXSkR6MzFDeTlPRFdRcnkxVDFw?=
 =?utf-8?B?cUhveUtuenpPQmlQaWtMUXpmYlhDeXk5NVgzMjVUL0VUOGlzczI3bHF6REl6?=
 =?utf-8?B?amdnLzBvbnExQkxpU1UyYXc0ajkzZ2VKY0R4Y0ludzdUdDRiN1UvT1ZMS3d3?=
 =?utf-8?B?L25tRWU1cXdkRmI0cHB5WDV2SmVQUWs3NjZEQWx6NzdQWDJzQUJBc2thQzFi?=
 =?utf-8?B?RlFSeWdzSkpGLzJHT0c4b1MrSjRQVmlGcDF2aFlhdlBWS2FoOXRISWROYzdj?=
 =?utf-8?B?ang1R2tCZUpOMEg1dGo2dDhTaVpIb1N3S0ZOa3FFd0tPV3FoZzNTaGhtZHpJ?=
 =?utf-8?B?NlJYWENFNm1raVVHeVA4Umlpd2NiT0FBbE54L2h5dE85VTd0UjBCM0lUOHpq?=
 =?utf-8?B?SjhMdHUyS0tHS3FVamx5WndTK25ycFhDNm1pRnNOcHFXcDZJc2FQWkRWbEVJ?=
 =?utf-8?B?QnhmNW9FV2Q2Y1VUVTNxSTVTeEF3ZTJHM1lZanIzVWRDNmJnZXFVM0ZXKzJw?=
 =?utf-8?B?bWd1ZVNXYmdLdGVxVEZ3Y2lwNjVISUdVSldicFp6Mk9zaE5tcVluR1lnbzBG?=
 =?utf-8?B?QzJkaEJQQS9ZL05Sd25Obys5UGdBSlZic09CVjVjajFObDBsdVFpVFYvTWJU?=
 =?utf-8?B?bVZHNVdubStzam5PaEFoUGVrMGVWL1RTdU14OXF4T0xHeU8wUEFYemQzcTJk?=
 =?utf-8?B?alprZXBYK2xXRUlkb3h0Vjg3aVRuSDYwOUtFMnJoZWErOHpkM0RVWDAvMjFs?=
 =?utf-8?B?YmlnV01KOHlja0RuRE84RHNURlM2ZEJEbGE2VjRRd3ZYc0JjNStqTzY2OEdo?=
 =?utf-8?B?QTFRTTdRRWxZZ3pKNEEwWmFjMm5LSlhGNVNBVVN1UE9EQXRPeFRCS0k3cEM0?=
 =?utf-8?B?blprd1p6Z3FyRGw2R1BYTThFeTU0S1JlREFXQmZkeEhoSVZEZjA3UlRQL091?=
 =?utf-8?B?eHlFZ3REMnVPYUkwNUExUW0yRU5MQTRyUFFEb21xUCtGa2ZJaUhyZmJzRFZk?=
 =?utf-8?B?b2J6aWZMQmJOc2hORGdFd0dpODZYMHFHOWdZWkxOWjVQdUkrK2lPa3lzWk1m?=
 =?utf-8?B?V0xWKy9XR0F5WnhSeFZhb24yUHdieTBnUEd0N2VvK1BmMWRpY1BDUFRBV2tT?=
 =?utf-8?B?TEZiaElPVTdWTkxJZGZMSGR4L3lHMWx0RXR6Y1BZdmo4OTQxQndDNGlpVExk?=
 =?utf-8?B?dEU0R1FKREIrT1NGRXV2K1p3OUFIUE16NEFzZjlXck9QYk5JcWFKWHZiMGhY?=
 =?utf-8?B?SGx0eENTU0FPb3QvanMyUWcvZXdOY1A0QmEzV25OVVpOczBWSnl0Y1hZYmNt?=
 =?utf-8?B?alNIMEZRY3BBYnpoa2Q3aFlxbkJJRytIZnFVdFg3N1hNWmdHYWR6cWhoWFhk?=
 =?utf-8?B?cjVvWlJ2ZXBTejNTZlZlYmNLMm82N3JLVlpXTk1TY3I2cVh0Y3hqOUhnaDRt?=
 =?utf-8?B?Rm1TdjF0dU9IdTI2SGV0VnlVcCsrWDNDT2gwSjIySy9BL3JpR0k5WnUwSkw3?=
 =?utf-8?B?OFB3TEFhOXRsdG9jMGVMb2dPcXZsM2tTQWJJUHN3TWxzU3hkVTVvcGZMR1Zm?=
 =?utf-8?B?d1l0bUlsakFTOWRkRExhbGtBUDZGNHBFcnVsYjZCZkdMM0R6UUdvbFl3VStS?=
 =?utf-8?B?M3FIbytDcEFxczB0SERrSFZybmpnVVdMUHVBcThrQUpkREYzbGsxUy9zNlRM?=
 =?utf-8?B?bWtOSlNiWlVYemJFSE1CdHhUR1cvU3U3T2JxU2NYKzllcitvWWNFVlRNTkhT?=
 =?utf-8?B?aWJENUdKQ0RyTFc3Tlc5YkFIMGZvUFRNQ2YyeFFXSFhBeVJsZ3RMYXlqak16?=
 =?utf-8?B?amNXcEFkM3RlQTR6MlZQckJWUjN4NXBvYjZHYis2cUtqSzNZUmJRL3hCZjN5?=
 =?utf-8?B?YmZocE4xbERHL1h3d2dURUV0SGdCcmdPT0Rld2hhc3dYL0ZsWDlKWEJaQzgr?=
 =?utf-8?B?dGN1a2oyeXI3THNxWWdqRHVWTXpWMU5UZVE1MlpldjZ5R0l4Rk5QK3VoSHFG?=
 =?utf-8?B?U3podzJldHhvR0Z6RkU2SUUwUnVoZzVnSDc2bnlGUUpEM0NiVDgxaGFLT3lt?=
 =?utf-8?Q?LGos=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE28338B95991345B4A107A738537410@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41700e1f-7bf1-4381-eac5-08dde0bfb970
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 14:33:41.0589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebhnoRYCKYs9KXmzBw3AD2DZdCnJWe9LMGX/Wc2EnL19gBJZ9oapvhUy8H7bbfqbJVBBakhL9ouiZYHH0AU5vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290

T24gOC8yMC8yNSAxMToyNiBQTSwgR2F1dGhhbSBSLiBTaGVub3kgd3JvdGU6DQo+IEluIHRoZSAi
YWN0aXZlIiBtb2RlIG9mIHRoZSBhbWQtcHN0YXRlIGRyaXZlciB3aXRoIHBlcmZvcm1hbmNlDQo+
IGdvdmVybm9yLCB0aGUgQ1BQQy5taW5fcGVyZiBpcyBleHBlY3RlZCB0byBiZSB0aGUgbm9taW5h
bF9wZXJmLg0KPiANCj4gSG93ZXZlciBhZnRlciBjb21taXQgYTliOWI0YzJhNGNkICgiY3B1ZnJl
cS9hbWQtcHN0YXRlOiBEcm9wIG1pbiBhbmQNCj4gbWF4IGNhY2hlZCBmcmVxdWVuY2llcyIpLCB0
aGlzIGlzIG5vdCB0aGUgY2FzZSB3aGVuIHRoZSBnb3Zlcm5vciBpcw0KPiBzd2l0Y2hlZCBmcm9t
IHBlcmZvcm1hbmNlIHRvIHBvd2Vyc2F2ZSBhbmQgYmFjayB0byBwZXJmb3JtYW5jZSwgYW5kDQo+
IHRoZSBDUFBDLm1pbl9wZXJmIHdpbGwgYmUgZXF1YWwgdG8gdGhlIHNjYWxpbmdfbWluX2ZyZXEg
dGhhdCB3YXMgc2V0DQo+IGZvciB0aGUgcG93ZXJzYXZlIGdvdmVybm9yLg0KPiANCj4gVGhpcyBp
cyBiZWNhdXNlIHByaW9yIHRvIGNvbW1pdCBhOWI5YjRjMmE0Y2QgKCJjcHVmcmVxL2FtZC1wc3Rh
dGU6DQo+IERyb3AgbWluIGFuZCBtYXggY2FjaGVkIGZyZXF1ZW5jaWVzIiksIGFtZF9wc3RhdGVf
ZXBwX3VwZGF0ZV9saW1pdCgpDQo+IHdvdWxkIHVuY29uZGl0aW9uYWxseSBjYWxsIGFtZF9wc3Rh
dGVfdXBkYXRlX21pbl9tYXhfbGltaXQoKSBhbmQgdGhlDQo+IGxhdHRlciBmdW5jdGlvbiB3b3Vs
ZCBlbmZvcmNlIHRoZSBDUFBDLm1pbl9wZXJmIGNvbnN0cmFpbnQgd2hlbiB0aGUNCj4gZ292ZXJu
b3IgaXMgcGVyZm9ybWFuY2UuDQo+IA0KPiBIb3dldmVyLCBhZnRlciB0aGUgYWZvcmVtZW50aW9u
ZWQgY29tbWl0LA0KPiBhbWRfcHN0YXRlX3VwZGF0ZV9taW5fbWF4X2xpbWl0KCkgaXMgY2FsbGVk
IGJ5DQo+IGFtZF9wc3RhdGVfZXBwX3VwZGF0ZV9saW1pdCgpIG9ubHkgd2hlbiBlaXRoZXIgdGhl
DQo+IHNjYWxpbmdfe21pbi9tYXh9X2ZyZXEgaXMgZGlmZmVyZW50IGZyb20gdGhlIGNhY2hlZCB2
YWx1ZSBvZg0KPiBjcHVkYXRhLT57bWluL21heH1fbGltaXRfZnJlcSwgd2hpY2ggd291bGRuJ3Qg
aGF2ZSBjaGFuZ2VkIG9uIGENCj4gZ292ZXJub3IgdHJhbnNpdGlvbiBmcm9tIHBvd2Vyc2F2ZSB0
byBwZXJmb3JtYW5jZSwgdGh1cyBtaXNzaW5nIG91dCBvbg0KPiBlbmZvcmNpbmcgdGhlIENQUEMu
bWluX3BlcmYgY29uc3RyYWludCBmb3IgdGhlIHBlcmZvcm1hbmNlIGdvdmVybm9yLg0KPiANCj4g
Rml4IHRoaXMgYnkgaW52b2tpbmcgYW1kX3BzdGF0ZV9lcHBfdWRwYXRlX2xpbWl0KCkgbm90IG9u
bHkgd2hlbiB0aGUNCj4ge21pbi9tYXh9IGxpbWl0cyBoYXZlIGNoYW5nZWQgZnJvbSB0aGUgY2Fj
aGVkIHZhbHVlcywgYnV0IGFsc28gd2hlbg0KPiB0aGUgcG9saWN5IGl0c2VsZiBoYXMgY2hhbmdl
ZC4NCj4gDQo+IEZpeGVzOiBhOWI5YjRjMmE0Y2QgKCJjcHVmcmVxL2FtZC1wc3RhdGU6IERyb3Ag
bWluIGFuZCBtYXggY2FjaGVkIGZyZXF1ZW5jaWVzIikNCj4gU2lnbmVkLW9mZi1ieTogR2F1dGhh
bSBSLiBTaGVub3kgPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBNYXJp
byBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCg0KSSdsbCBhZGQgdG8g
bXkgdGVzdGluZyB0cmVlLCBhbmQgaWYgYWxsIGxvb2tzIGdvb2Qgd2lsbCBzZW5kIG91dCBmb3Ig
DQotZml4ZXMgbGF0ZXIgdGhpcyBjeWNsZS4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2NwdWZyZXEv
YW1kLXBzdGF0ZS5jIHwgMTAgKysrKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVm
cmVxL2FtZC1wc3RhdGUuYyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gaW5kZXgg
ZjM0NzdhYjM3NzQyLi5iYmI4ZTE4YTZlMmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3B1ZnJl
cS9hbWQtcHN0YXRlLmMNCj4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiBA
QCAtMTU0NywxMyArMTU0NywxNSBAQCBzdGF0aWMgdm9pZCBhbWRfcHN0YXRlX2VwcF9jcHVfZXhp
dChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkNCj4gICAJcHJfZGVidWcoIkNQVSAlZCBl
eGl0aW5nXG4iLCBwb2xpY3ktPmNwdSk7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGludCBhbWRf
cHN0YXRlX2VwcF91cGRhdGVfbGltaXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+
ICtzdGF0aWMgaW50IGFtZF9wc3RhdGVfZXBwX3VwZGF0ZV9saW1pdChzdHJ1Y3QgY3B1ZnJlcV9w
b2xpY3kgKnBvbGljeSwgYm9vbCBwb2xpY3lfY2hhbmdlKQ0KPiAgIHsNCj4gICAJc3RydWN0IGFt
ZF9jcHVkYXRhICpjcHVkYXRhID0gcG9saWN5LT5kcml2ZXJfZGF0YTsNCj4gICAJdW5pb24gcGVy
Zl9jYWNoZWQgcGVyZjsNCj4gICAJdTggZXBwOw0KPiAgIA0KPiAtCWlmIChwb2xpY3ktPm1pbiAh
PSBjcHVkYXRhLT5taW5fbGltaXRfZnJlcSB8fCBwb2xpY3ktPm1heCAhPSBjcHVkYXRhLT5tYXhf
bGltaXRfZnJlcSkNCj4gKwlpZiAocG9saWN5X2NoYW5nZSB8fA0KPiArCSAgICBwb2xpY3ktPm1p
biAhPSBjcHVkYXRhLT5taW5fbGltaXRfZnJlcSB8fA0KPiArCSAgICBwb2xpY3ktPm1heCAhPSBj
cHVkYXRhLT5tYXhfbGltaXRfZnJlcSkNCj4gICAJCWFtZF9wc3RhdGVfdXBkYXRlX21pbl9tYXhf
bGltaXQocG9saWN5KTsNCj4gICANCj4gICAJaWYgKGNwdWRhdGEtPnBvbGljeSA9PSBDUFVGUkVR
X1BPTElDWV9QRVJGT1JNQU5DRSkNCj4gQEAgLTE1NzcsNyArMTU3OSw3IEBAIHN0YXRpYyBpbnQg
YW1kX3BzdGF0ZV9lcHBfc2V0X3BvbGljeShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkN
Cj4gICANCj4gICAJY3B1ZGF0YS0+cG9saWN5ID0gcG9saWN5LT5wb2xpY3k7DQo+ICAgDQo+IC0J
cmV0ID0gYW1kX3BzdGF0ZV9lcHBfdXBkYXRlX2xpbWl0KHBvbGljeSk7DQo+ICsJcmV0ID0gYW1k
X3BzdGF0ZV9lcHBfdXBkYXRlX2xpbWl0KHBvbGljeSwgdHJ1ZSk7DQo+ICAgCWlmIChyZXQpDQo+
ICAgCQlyZXR1cm4gcmV0Ow0KPiAgIA0KPiBAQCAtMTY1MSw3ICsxNjUzLDcgQEAgc3RhdGljIGlu
dCBhbWRfcHN0YXRlX2VwcF9yZXN1bWUoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+
ICAgCQlpbnQgcmV0Ow0KPiAgIA0KPiAgIAkJLyogZW5hYmxlIGFtZCBwc3RhdGUgZnJvbSBzdXNw
ZW5kIHN0YXRlKi8NCj4gLQkJcmV0ID0gYW1kX3BzdGF0ZV9lcHBfdXBkYXRlX2xpbWl0KHBvbGlj
eSk7DQo+ICsJCXJldCA9IGFtZF9wc3RhdGVfZXBwX3VwZGF0ZV9saW1pdChwb2xpY3ksIGZhbHNl
KTsNCj4gICAJCWlmIChyZXQpDQo+ICAgCQkJcmV0dXJuIHJldDsNCj4gICANCg0K


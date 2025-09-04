Return-Path: <linux-pm+bounces-33805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC52B434D1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D99E485EF9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0572BE029;
	Thu,  4 Sep 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IQ87C7tm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1E32F775;
	Thu,  4 Sep 2025 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972720; cv=fail; b=EnpeHEYdKHRWBMxMagWd0R0iq7HKmZtHHyQ0EhVJVrHiAv/IsIxBQI4SkI08irun4o980Y9vIHFJztuUjuq2rH/9+aLAbqOS4X76a9teB8e2NfuavGNHU6Tlyexl0gSULBvnUJShhunrfLq/TRXkOL5qNZbmMEP6JKqssQvOvtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972720; c=relaxed/simple;
	bh=VTFXRkWW2Vs5Kog0v6Xh9RvlNm7N/g4q+IItx7jzFjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwtoXBHnH9E9LXtKeXSG93TjYzo6/Z/pxcyIldNRX6cLZskXc0Bb8/bwRUiAoj0fxZlhAJ/dpIgzp8W7X1cSBkbX7Swy9NvCoY1dhjzq0j1EVdMardLIRLM4HIh9gtiLMmhMwk8AETnxcBUo59ZhMCGG9QtOqjYPoMEXnHXnri8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IQ87C7tm; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7v7eIA95EsDIjzMV4mYgQJfIXIScOSBzrGMo7bOXGF4Izsll694SHRmKMiTxcn1Dua/BXJmUj1w5xSigvz3kH7FiR7aBqEFXSGKgDO6fxSPLzJN1fTDZSNsr2M7z2zXaFmSGlbMHSuMl7iEvnoi8GQDwCCd3LZP+MACVdcMjKJGL8ws1OeW3r2q2foS2H0GXGouV5I+PUootJqH1NILkg5s9u90g1Q5xknoVKuj/kvBjvBrsVaqy/rP97IaKshHf2TgZfRv1wwQcimUHprB32jut9qCMWBk1EJKihSOIMHZ3wipgNWEDfTlpYKzlMEZBWGdMH3Yd+7W95TVu/AhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTFXRkWW2Vs5Kog0v6Xh9RvlNm7N/g4q+IItx7jzFjw=;
 b=frUlknTZKlksWjJgMhNp+92R5TJHn7fRr/4fdw+EspMWtQfiwpcIBzJKCW82RndiMz/ALGLzAsOtnseXggOasSkcpFb/oyCYmt1titE37VqhHCnhb7e/4h0g63HZvF8k26Qq3qCNV/zUfU7Ny9O8KfM3ZfarQKsM2eDeWu2OssKov/pS7orHSjQLcxaJvHnnJoDFzResqPeCgUkUZ5EqZ5ffCqAkGAkS43RQ7HmrxuImdX5KWbnZkmg1nrbNyS8spAOTyAX8g9o5sZzUZkxrDSol6lhCftekGhDuFVhLLsfYk96tRXoqvMNONpJPqGeXSUQVmOKZq1PxwA6xUZjpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTFXRkWW2Vs5Kog0v6Xh9RvlNm7N/g4q+IItx7jzFjw=;
 b=IQ87C7tmvbY+H8d6SIn6Cg9UgqbymWcXTFcyBtFCu7d+o0n6S5oPD0qmab1OzV9Wal9Fjn5g44756FRVqFmwQuhQYUNPXQjsecGqtOzzmw06PZwzCJa5xnH0vbQs/KfURLah791Ani/8wvgc3edneBR254S44m3g8oRtoHbvSDmk97lY3OqK3xEY95F0ora5DwPKFdqYtaCHfhZ3B32F6UMAEAV3SImbJAvew0cOHAdaUa35Xsz3UqVa7GRMlnJcVCieLTuoGC3bKyT4ievbGrmJiO9leE3IWfCyFePpUJqpDIsOGl/ScunGpzVCu2E1sv7dLx6eYeOgKKiyA+Vy0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 07:58:35 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 07:58:35 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: webgeek1234@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>,
 Sumit Gupta <sumitg@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] cpufreq: tegra186: Fix initialization and scaling
Date: Thu, 04 Sep 2025 16:58:07 +0900
Message-ID: <5102294.LM0AJKV5NW@senjougahara>
In-Reply-To: <20250904050358.kj7gxypu5mmov4f7@vireshk-i7>
References:
 <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
 <20250904050358.kj7gxypu5mmov4f7@vireshk-i7>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: d849d98d-6531-40be-070f-08ddeb88d946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWFlVlBCUkVJMVp4ZG5zaG9abUhHMkNGYWJEbmYxL0JFeXU0TnpDRDFIMWhT?=
 =?utf-8?B?RzlOaGplUjcrbDIzcFRid25ib2VqV1pPUk1XNjZWMzRHYzNsV3FhY3lpV1Bi?=
 =?utf-8?B?OHdKdmtJYlpHZ1ZSRmloMEpSNmVMcGZiNFFvMnZUOWZFRWFRY1JkeEhzMkxz?=
 =?utf-8?B?QVE0MGN1Q1c5K3FBUklGUkgxaUNmekdmK3dhZ0ZMVm1ZVlRHNS90R3cxS3Qx?=
 =?utf-8?B?V3dsTnJNVEVlYnN2TUZDK0Rhek82Uy9aYzF6SWM3QWNXQXRUczd1eHVsbzRP?=
 =?utf-8?B?VDczWmFpek5tOWJReXltSWd6aU12MFZ6L29GRGFiR0tFMGczQmhpa3dRSnJl?=
 =?utf-8?B?M0tRV2xCbjdnU3c0ejdlc3JPRE1xYS8reXYrUTAycERPaHdSbHJmclJUUEZK?=
 =?utf-8?B?K3pmbmhhb1M3a2hnWDZiNkNWeE4rMHFDT1k1SmN4MXFScUlFRXZjbVNib1pk?=
 =?utf-8?B?cjh5OXVDSGV1ckhxTzdtaU5SWHFIQ0FFcU1pNmxnQ3NQL2NtL0NqdXZENFQv?=
 =?utf-8?B?Y2RjQmZCVFZPVlZacFhRR0lYaXBLR3psRkJEK2dJUElWLzd1aEJyRDBGc3JW?=
 =?utf-8?B?VTA1bGl5c2tDZysrUXMwN3VUS1R2YWxUUkV0T2FKUERMWmpEbFlNZ1QrZnFE?=
 =?utf-8?B?OGUxN041NExBWjV6VEdTclcxUVRUcFNWbzI4dDczUG1lUmtMd01iSUlrUHhh?=
 =?utf-8?B?dnJ2cnVNdElLWC9rejlYS1BoRnFDZjFzSlRaaUhGVXA4WjduQ0d2ZzBMVWdz?=
 =?utf-8?B?SUp3dW5jcmNMc3JldHlzb0VUTWZmNWFSL2tBUDRScFF0Qm1jbG5Bb1FLRmtS?=
 =?utf-8?B?VnFxWUl5TzJWbEM3Z0VQWEJjdmlMUlRiN0JhalJIWVVtRGJCM1NQY3V4L0dJ?=
 =?utf-8?B?REVQQS9ZVWRoQzg0WFY2RUFzOWNxQ1o4eEpwWkNiRFJCRDNNSnB2ZG5DS3NY?=
 =?utf-8?B?QzlzZWZMNzZITFBuTzNtc2JISk92eHlCQ1V3RnVKZ1FhQzEvZXlaZm1IVE00?=
 =?utf-8?B?ZDRCMkJ6UDNDMUNqbVY2SlhJZ3RTRVJmM1Y1L09rTW4zWnE3UWsyVjVmU1Vx?=
 =?utf-8?B?blF1bzJ0L2ZkUGZZY29lQTFYT0xubHBvYjF0Q3M5dWovTzl4M2twd0x4U0Ux?=
 =?utf-8?B?MnlOS0plQURZWHJMTmdPWHVQaGt0ZjdMWW1iaWtBN3NQNGprMDNMM2tNNklK?=
 =?utf-8?B?eFNhbkNkVVpyNnJxNXRsM3dRYnFOVDJ3UHFaMEVJUFdYQnkzK0pId2pNS1VP?=
 =?utf-8?B?M0IzTjZaekdkbzZGRE93M3ljRXVCSTVlTDRDb1h6Qld5Zm52NFJ1dndGQkxq?=
 =?utf-8?B?SlZQdW82clhDakhCcnNXTTBVb3R2RUI0NUdSaXdMZW1MOHN4ZDZiSUQ1UkND?=
 =?utf-8?B?ZjlYZDM5ckVhL0xRaTdodnRhL1ZkQmFGUHF0aTZPaHVtd3Z1aGJMc3BTdGhY?=
 =?utf-8?B?YU5iL2kwV1U4cml5dTluN0x1YTRiRmtxekxxRFNkT0tnRWxjN09Oa2xVOGR3?=
 =?utf-8?B?bFJlcFpKRDFzTjlEWGJsNVk0T1RJVUowWWhhR0NRQm54MTNIOUNLbXA1eUZZ?=
 =?utf-8?B?dDBITGVUNStDTUxZdDF4M3Y2cUNxcmlLMll5REl5cFhEN0Voa200bCtZZUIx?=
 =?utf-8?B?NTNBUERLVE5BTWtKWVJpZ3U3SExlNXhHNVNEQk04YkpmRVlyQ2Jld3ZBRTBk?=
 =?utf-8?B?UDRnQWFtdUMxeDI5c3RYSVlnYkpESUdqb2pQaUhMWXoyTUlwci8yY2dRN1pF?=
 =?utf-8?B?WGxIZVdWM2NRcmFQSU5QUHIvRmxHVVZONUR4azgrOFJ0R3ZFWlF3MVRnVWRk?=
 =?utf-8?B?K1hlK1FkMHVPYi9TTHcySmlIUjVLT0p0K1BJcUlSNUpiRW9kVmFRdlFPQWk3?=
 =?utf-8?B?YzZRcnBQd3M0bFNtQW9oTkcxRWpWOVA2bUd4N2FzSmhYTEg4RGFOVERDT1Vh?=
 =?utf-8?Q?iLkCg9Z9JIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZYM1FyeFJZcCtiTHBYQTV2Q0hVdFFRd0xwbk13N0hEcVFzMnpSNmtkS0Z0?=
 =?utf-8?B?RHUvTklNQXBjZWRmMkRZcWhXdTQ5RlVKcTR2QUlielpzYldaM0ljWE1QVGV1?=
 =?utf-8?B?bklMcXpSTTFRVThiMGxGTnRDejkxdmpEQkcwNzVJMzRqTFFvTjVHR05NeDQv?=
 =?utf-8?B?cVRlRE15UHRyTVc2ZjVyMzAyQUxHbWdmWVlLbDgveXJpTnYzdlU5TStBc3JX?=
 =?utf-8?B?TDdMNVJqY245dmkzOGFpMk5TRzh3TjRkL0ZydmgzdGlaMTAzeGZNYVhQUzlN?=
 =?utf-8?B?NFhKTEI5U3ZCbVJEOEtSd2dleVlPZU5kWW5NakpDNXZ4cW9oVUdFL3B5WWpT?=
 =?utf-8?B?ZW1pMDhWYmFSOWlHZG1UWmlJZGFCc2hRTUNxT3JlbUZzZnoweVVNSGY5T0ZP?=
 =?utf-8?B?QTdyaitQNm0xc2p3UmFTRG95MlNLamdHMERCMkM4MUJvb2REalJmdG1RdXR4?=
 =?utf-8?B?bWIwWjlvSkxabHVtcU5XeWRGOXhHOWRITHpWampIQWlNTXJkNS9VOXdXbVZj?=
 =?utf-8?B?UnZMWGplL3d5MjJWVmxaMm1WR0U3ZFN6QThZZXlHTk1aNDBxcHBNWDVYcUh4?=
 =?utf-8?B?NHVoMm1xMmcwOWNZbUt3Z3F6SmltbFR3Q0JBR1ppdm9nZE16M29kK25STFdn?=
 =?utf-8?B?NUl4SGJqbWpNdFdUcUFhZGYxYlFKQjNvV3hHZVl2UHo3VXVQcTFoNjFsVjV4?=
 =?utf-8?B?UXgxenV5UFFuVUc5WFI4Z1dSKzZVTlFZNXlpTlpoVTRlYzFuNU9kU0NHYUs5?=
 =?utf-8?B?WElJYmFUdC9pcEZXSU00WFJxVTV2dEh1WnR3cVZZeXB0WSswbEZ4VmlVcitx?=
 =?utf-8?B?WldPK1dTaTdGd1FHemltbm1wRktWdEpZNG5yOHRYU3RPUVZuandHWUIwZFU5?=
 =?utf-8?B?V3dUV2lnM0ljMHNhN28wOHBmaHFPMjZXc1NKNGd4RDVCWG8rcDdEUGRTMyty?=
 =?utf-8?B?KzVjNmdXVmN6NzVudnZBOUFLZjg2RjJOa3BlSlFwdmk2anN0azFDVHJmT0tZ?=
 =?utf-8?B?dmdjUWFsSEYxM0hBUUJNTUJHeFUxSXltUWN4Q0hPUFhRKzh3bGx4cUw0U0I5?=
 =?utf-8?B?ZWRVMUd4eEZzd01ITU96YTU3cnBKaWpPeDU1OG9VWUpBb29OUUV0R3VKbm1C?=
 =?utf-8?B?SlI3WElNWjA0dmJva0NTU0RPM290Z0p0ekJOamx1ZHJJbEwyc1doa0JTNlBs?=
 =?utf-8?B?Z0dEL0N6ajVMV2U1dzhVcHlabUViT1hXaTBMV1ZxSEhCV3V3YlloT0ZkcWk1?=
 =?utf-8?B?dG9kYU1JeEZGVXhKdUhTamtmYVpTOGZ4ald6UDVnZDB6amxnTkdhZlA2cGt0?=
 =?utf-8?B?SFROdDQ2Qm1RMHJqTXl5R0JSWTczNXA0ZEtTclV6ZG1GVDZmME1yVzd3aTkw?=
 =?utf-8?B?d2d0T3Ria21Vai95WW5EWXd3d3pwQ1FoUkVzenViR0tHZEQzWkNEY1dueXJE?=
 =?utf-8?B?Vmhnc29mVkZuUDhUcWxUSWxWZDZyZXBndkc5R0hjbzUzVVhVZGt3eEI5ZVJV?=
 =?utf-8?B?ZE9jbzFmS0NWcEtBb1F2STNaa1ZzbU5oSWl3aGxjRFZMNDltcVk3SlR2aHI2?=
 =?utf-8?B?WXk5L1hXSlYyZ2NrTkZ1TDFCZnRrN2hRL2xXKzhacXFhTFJBR2ErRzcrN0xE?=
 =?utf-8?B?ak9zMlYvOTB1SHdiSFBYdWZnKzJYbXdCYllvQ2c1enlZNzFRN09PNGdzK2U0?=
 =?utf-8?B?Mk5YbmFjSE1UdHFhcmMydUZteWlOVXUwYXhsd0g2MFdFZkhpdkVXRjNYU0dm?=
 =?utf-8?B?MXhhNVJ3M3lITkpQTWR1UXJVWGlValFTMDgyL3labW9HSHpwblJxZ21ZNWth?=
 =?utf-8?B?c004QW1NZEVKUmNxQllYWHlOeWRnb3lDdVZndkFjMEF2RHdCcTFDRjR2MFB4?=
 =?utf-8?B?WXJXWUZNdTVFbGRaMjFFOFpFc0l2TFdtbzhUbTN1OHFOcXZFcEU0MXVrd1Yw?=
 =?utf-8?B?TlBHemhKd1N2SE01eCtJSjhqWG43SHZna3J2M0FXaFJtejhoS2VGN2NReFhU?=
 =?utf-8?B?T0NBak1CV2oxTEtIMWgxVFlJZnNKZllvaFZMWGw2eGZqUmFxNTczRmlRdHlx?=
 =?utf-8?B?NnpyTG5SVThiNkY3RDZwUWdRYkdFRkovdHlvR0JTQmpGUUowRVdSamZLSUZM?=
 =?utf-8?B?R2FGUk1SZ0hPdU8wamNNUkR4azNUSE5kWEVNY1F4OEhmOTVnc2NudTdRMWRk?=
 =?utf-8?B?d0I1UnpidU82UkJhY3ZwallHNXF4Y2dYcmk5SWk4ZHlTZ2NzeHJTS1pJbGlu?=
 =?utf-8?B?bnUxVXFLNXlmUFFqaFRIUDlLMXFnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d849d98d-6531-40be-070f-08ddeb88d946
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:58:35.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zX9hZcitgpWeZgOkvArZSIO3TIQGOlUAJBSh5py/A6gYUxgU36TOSXoeXy4L5YHZdSSuXRkhXdPu+oGFOyDM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664

On Thursday, September 4, 2025 2:03=E2=80=AFPM Viresh Kumar wrote:
> On 28-08-25, 21:48, Aaron Kling via B4 Relay wrote:
> > This series fixes an issue with shared policy per cluster not scaling
> > all cpus and with some cores being initialized by the subsystem.
> >=20
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > Changes in v3:
> > - Use more clearly named variables in patch 2
> > - In patch 2, fail probe if no cpu rates reported by bpmp
> > - Link to v2: https://lore.kernel.org/r/20250828-tegra186-cpufreq-fixes=
-v2-0-fcffe4de1e15@gmail.com
>=20
> Would be nice to get an Ack from one of the Tegra maintainers before I
> apply this.
>=20
>=20

Not technically a maintainer for this area, but FWIW,

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




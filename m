Return-Path: <linux-pm+bounces-12023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91994C99D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1741F22BE3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 05:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903F016C440;
	Fri,  9 Aug 2024 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hf3osR7i"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6816B384;
	Fri,  9 Aug 2024 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723181248; cv=fail; b=ktfezkr7Odob8zpZWVOjgMBzgoT7uMPz1ZsYsPcju2xLJ3/8z+lrWROAYcKrbxr6IT3b4TAL9R+cdoNScbtvF55tTxSiK8XwlXr01xzMaQszUe5a4vj/g3Wc5mRA1LH4x5C1bo2Sk15wElyu52rbldWYGq9y8BHl0/JmoQ0r9Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723181248; c=relaxed/simple;
	bh=K6OkaMdG6GPJv7Z7utu6feANxaDOVRG7aJO2jbxFkMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A8jyq4jaAXdHoZrQ2buGQsVK9+TejAKxHal1S4gw85ug5DWO+PzxLvZNJDdun+OiwhU7RQsr2l0UHkeTkPH97DebubYpVfi47iYDq2VCAfJ6VqFsDMTG4nR6uFpU00V//zAIbEYGCiXp5YoEAAVHO6cQQdsEF/px2zKo6tMDCk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hf3osR7i; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRsNPeZ9bolw1q3ePMbDUxtYXp0ZBy30QFcAGRIiEJEtTWqi28QCmGGbUzUQ0T8nEWffqVz/rhNRN6I/kV9hrGbLQARoB4BZeJZncA9oo45uWNKqbW7dNrPFAazSrGgB0MJGEz9ZfXIE3RNhifx8Lu42VW2NxOj4HO+ZENijCWldbG7rByCmc+6D/6IDPn8X/CR+o51UTvlTMEPVExRhQWXr7gQSnji4hVtpzxHvHK+XIXvtlZCI05xS4Dm3DBg6Dc8+pIMC2hYbhYrowySdFU9XSftkwFceuxxxqLD0H+DO58dr6t7jaWAacmq1x4EjxHjKYrLpW0LQQtS7mIvLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAEmLcuPFFH+tGF0RVkyuj7Xs8Qbe6Ct9aGsnmNNpd0=;
 b=JVcDj3wiGA4UnIWDBTdEwvQtG+IFRnJR/hSX6BRoY5ck4cD7MD25Bf+BV10ZlMAMDR6bcLZ6/YjFPWUPnoUSFSWNnEbiCe0+Umu9O3pITE2/3fHKzAx1bufHRPWRMC8tLo5rmvkCwV1LyGDAyqRqdSf837AzC/0xvGo76vY7MTsiWpvFI3nNTBPtJvWWZqbB4pvk2P87Uu6oLVvZh7Od7Qf4BrmHnG06BdbJN6oBEyY/YPvSNvwGUKGd2UK+ehhqZQ8UVi/dh4pON8dDaA4JhMJOAyfB0y+iC8pFC59Jwl27yfrokqNkGlOldsI6nBifFx5kQSdt0cGArt88ThRXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAEmLcuPFFH+tGF0RVkyuj7Xs8Qbe6Ct9aGsnmNNpd0=;
 b=Hf3osR7i29vfHpt4dCUWUGSLjEHoz0D5pnlYmlDXQCQiwLJK0dSn8FR0Ck83wQA054zGoHcsqCnAsT68F0KMwJmWrap7iQdIjNUjw8TSD+P/Rm2XtPnLvFu1zbIts6Bao60+9bi3LmV21zV5nSm4LM3aqrKBk82QZzM3TzWttKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 05:27:21 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.7828.031; Fri, 9 Aug 2024
 05:27:21 +0000
Message-ID: <484da8d3-c03a-4315-8861-93888adece47@amd.com>
Date: Fri, 9 Aug 2024 10:57:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, li.meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240808123651.3741-1-Dhananjay.Ugwekar@amd.com>
 <20240809051455.eswe346caiee6gpp@vireshk-i7>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240809051455.eswe346caiee6gpp@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::27) To SA3PR12MB9198.namprd12.prod.outlook.com
 (2603:10b6:806:39f::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c427b9-f85a-42ab-647a-08dcb833f074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGJEdEF3em9PSDB1TXM0eU5YNHhxak1yS3BBYSt4ODNvTGY4R1BuMTFyT3ZC?=
 =?utf-8?B?a1NEeWxBV2U1QzI1UmxJc2dLTnZwa1BQSnJXL0FzT20yeDlGQ1FNV3lLYUc3?=
 =?utf-8?B?OEJEdXc1WmtLNFJ4SWJSeEN4Y2g0ZnVPRlA3QmdwUUFkZm1nZzcvQjZaUWJp?=
 =?utf-8?B?ZzEyaG53QnlpRWJ3cndETENDRVhoWlpBdzliQm02SWNFOFoybmV4MjkzMmtZ?=
 =?utf-8?B?ZVZJR3dyMDJzdXE3SkdUVGFrMjNYSXg2WkpNVGpUZEorbktIdGgvM1VFbXZB?=
 =?utf-8?B?R2RzVEN4NUZvN25WakxNNFRoVmU4Nm5qcVRORlIzWm1sTk9razZwUTNjNVpL?=
 =?utf-8?B?ZU1SY1praytralQrbS9UaUZ2K2xTWXViYkdLOVZrcTNUejJGYmN3QXdKVjNo?=
 =?utf-8?B?bFNKVFdEVHlPb29oYWJ3RlZmQnFXLytlR0tDSFlpd202T251SWRSdmJyaUph?=
 =?utf-8?B?d3lNYlJIS0ZDaXdYbWQzYWJkaERrcUpvdEFRSCtEOCtSbTNZbEFJem9tVG1V?=
 =?utf-8?B?TVNXUkpUSlFIQ1lXSHdHbXduNWJZb2lCOEdpRExQYkZhZERRS1h1aTdCUWVE?=
 =?utf-8?B?N1dDZ0I5RHROTUtVQlNsLzQ5YjF4c1VmNUgxclNNQ3hwaDZJMWZoa01ucThU?=
 =?utf-8?B?Z1BROWpjRU5tRmxPY2Nud3NUTngzbkhiZ3JDdjRSS1RHM2ljYTBKckwwRkdW?=
 =?utf-8?B?bzBudGhQRWtndVhuS1FwTndVRlRXVS9lbFVoTmpwYzFxSndXN3Nhc2xma0VQ?=
 =?utf-8?B?WjVpNjhpT0gvUE1STUJURHltM0luUjlnbjVjTzZOVW9vVWFqWWJBUHBJY2ZW?=
 =?utf-8?B?aHVjZGh0L0ZWUVpNZFdDQ04rRVB6U0VFR1JDWEVVUGNnL0hlakdNb0NKaXFt?=
 =?utf-8?B?aXk1TnNuaFMyVmE2NU5yaW1NV3ovTkgxaGQwMVRoTm5BNHdFZy9pVUlFak1W?=
 =?utf-8?B?cW5wWTJYZ0ppUXhlVVFibFI5eG9obVRvYjJVZXhHWjlHU2phcG8xOEZaZFUr?=
 =?utf-8?B?NWcvaVZzZy9YSEFkQnpneEkreGZ2VkhOZVhiM1drNnBIcDRJNVVndkdYNzFZ?=
 =?utf-8?B?L1NVWFpSNFBPWGhVOUZIc2poVE5Na2M4Y1FrNkdCbDEzV3MySWhaMHZBUm5q?=
 =?utf-8?B?UTl0NnpRMXAvcnVwem1qWGNHaWFBTkk1NG5xd0JWMDI3OWo0eWJuZDFhakxG?=
 =?utf-8?B?WEpoQnRjT0RPRURYTUwvVXo0WFhYVUcrL1VDRlJUbEgwNU95N2lRZEdmdlU5?=
 =?utf-8?B?UlBKTlpTTGNRdTZ1Q3VDMnljVzhJdDhoQ2Q3dWxSczIwWU1RT0FzbUxqOEV5?=
 =?utf-8?B?aDE1dU1IbEpIQjVkbjFjeVpLVEQ4UmxobUtJcFhCQmo1MkJTa0I4c2QvQmxi?=
 =?utf-8?B?MU1KbmxXck4yVGNJZkJoSThYTFd1NndVRWlHR2JETTZWL2NyYW9id0RnUEYv?=
 =?utf-8?B?TXRKQzcwckw4d0JrN3pIc0I3Y0RrOGV1NkN2VGRQRjlvb1VsNVg4T2FsT24w?=
 =?utf-8?B?eUY1K3FZcWV2RUYyb0U0L0JBcEJia085QkN5SXdGMTMxbHgvTHd1M0pUekt5?=
 =?utf-8?B?RjAvYTRYUFVmcWRtSWFhdHg4WlBObWlzSWFSZGJOSmxtUEtqUWgrRndvUkZy?=
 =?utf-8?B?MGlJZG82bDQwYUhWOHovZVh6RzM3WFMzM0ZXMWdleUdlSnJIK2hRc2trb2Ev?=
 =?utf-8?B?SzdyV3JyN1Y2NE5nVXdhZHVIUDQzbzI1UUR6Y2FLVEFhcG93QWI5RnEzZklu?=
 =?utf-8?B?L2VId2ZQai9DYW96Y3VOU0ZmK0VXZGlaUDhpaUw4dWQwLzNLN0lReXY5TlVo?=
 =?utf-8?B?RWh0TWRWV3FFLzMxZjFQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHZBUm45b2tpMDFsWm9rM2FtSnE1K3dWb01EUTBZUm83UjVWSGFoYzJQRWlD?=
 =?utf-8?B?NXJYUzVyUmRRVUZFUm5SZVZ2dVpDeC92S2UycmFNeHN2Q09KRnA5T0JXNlBU?=
 =?utf-8?B?V09mWW9MalFKQ2UydzBPMnJYbzFNcGdXSVlQblJSeWpFMWNrOHloM3RZblZq?=
 =?utf-8?B?YzdsQUNRbWM5bm5LN1VRaXlWT1dsSzZINlZYd2pveUJGZmd5VlpTNzdxakZh?=
 =?utf-8?B?bXZaV1RyaERxbDBqd2o0bC82WWgvM2h5VWs1MmlIYnQ1QjhRRDArUjBzYzkr?=
 =?utf-8?B?eWIvMVpiY2ZsaWYrUVAzWWtYQllGYlpKZXlkdnFUV3E4VjB1eVFoSDE1bGxr?=
 =?utf-8?B?S1laa01TcmtZdEFUM3FHdTRTZ2R6dXpSMlhtblBPOWR5bElMVGVvZUVwc0Uy?=
 =?utf-8?B?RWllUjVTbG5oV213R2VQeW9oV2dXdkkweGE4Yng3YWh2RjhKbE1sNlNpUHh4?=
 =?utf-8?B?RzJid2xNTE1vQ043NURQNEw2dGE0R1ZaWTNXREl4OXFlNUF5R1B6MUZVd0h3?=
 =?utf-8?B?NVFmSmVJUTlsbERzS05nYU9rbm0vTHpnRFJVWVE2akRqSTlUUXpUQUVUV1A0?=
 =?utf-8?B?SXFVcDVnZU1wRElCQ3p3Nzh4TXo1NHlKc0ZZTDYxVzIvd3h3QVh2UXQzd0JS?=
 =?utf-8?B?TnNZNmdmdzlQSEhIRWZiVERmN3JvenBldGNVejdEZ1laTENWTkxDZWw2Wlda?=
 =?utf-8?B?eVNJNVFqL3VBQ2tsdUt5UWlBcnZPVjN5Z0lZaHcvNlZSa0lacHZqUTBzYWxu?=
 =?utf-8?B?UW5lY045OTNWQ3F6SEluemhsMGZSbGxTc0hWZFQ1ekFKSm1TMWlqWEdUdlR1?=
 =?utf-8?B?TXJQUzhReTI4QW5IQ2p2Tm5IUXE0a1AwWWxteFNYajJyak9DMnpNak5UUmdW?=
 =?utf-8?B?eVdyVGxBazU4N1N5QU16S2lnWDBpd2NaRFlvclYxdUtCUk5rbmdDSGQwTnpx?=
 =?utf-8?B?a3hDSitBTGdTV1dqQlZiaWRLRWQwdldqazRzb2k0UWg0QURwTkpIcGRmSmlI?=
 =?utf-8?B?YmlCR1dKMU1SWUdKR1ptSzFYbEpGMG5rN0xWWWlRbEIycUNjSGlDY3ErZE4w?=
 =?utf-8?B?ZGZyUisyL3JwZk4xTmxJRHF4RElyRUpSZUhDb0Z0VDNFZjBYOGJlaldZZkdo?=
 =?utf-8?B?blhVK0gyMlE3TURjUmJ4ajJYTWdCR0pXOWJpTVNydGtHdFJMcU90YUhtRFlY?=
 =?utf-8?B?em50czhNcW15UHB4Q0REQTBTZGJSU2s0NWlSS1ZZbFZSR0J2N1RLenBPdUY2?=
 =?utf-8?B?RUdKblBDdHRKZ3o1UHVDSXdOZVU2bm5xYUk2SjU0NVZmVjJxR3I4MFRMbzJ4?=
 =?utf-8?B?SkFRdVRBSEllSmtlTEtGOWxjQnY2bktNd1E1a29nTjU5R2NVZXBqZ296NjRT?=
 =?utf-8?B?aGdGazZ4L1hSemVVTHhNYzJjVnRBbmhiYTZzcVFhL0czMVo5NnFHUzVmMjcy?=
 =?utf-8?B?Z3lkelVDRGM0bmo3OHlkQTNVYXVqNDJ5Rm81dG9HcEhDVlpTUC84emVQQ0hQ?=
 =?utf-8?B?NFp3SHFJUW1kWTUvUDhSZXpRY3pxUzJVZmdIaVREMm51cGxCa0J3cm5qa1l3?=
 =?utf-8?B?aFpwU0QzLzlaMWQwTUEvQzZXUHJlWGZpY3BpeWkwQ0xQK3JUS3lSdmdtNU1U?=
 =?utf-8?B?UTZVZXZlZlN5Nm5seWR2ZkhUa0Y4WmcyZ3J1cUo5R0JlaFFObmVNODZESWow?=
 =?utf-8?B?aXhRYUkwK3ZDVCtKY2Jnam8rWFA2elZMUUJZMHV1VWxrVlZ5dDI2blpRNFI4?=
 =?utf-8?B?Zkhkd1hSTGZnNVZPVmIrS3RBRmEyUW53cjJ4T2Z0djdoYm9HUHlEOHd6Y3BC?=
 =?utf-8?B?Q2pBVFVkc2xoYjlJMCtjaHNzbGFOU1N4TWJjdzgzdFZ3SEQ1eTFVVUJCUDJK?=
 =?utf-8?B?bVdRVTJYUmpyK2JaUFladyszNVVCVmo2ZDJmZVpDKys5eVMyVzJxNXBXUWVH?=
 =?utf-8?B?eFJ1M1hON01EdFM2T3hETTVaTTFoV2p0SzRSc1JsM0E2ZTVYaEJtWGdBV3lF?=
 =?utf-8?B?Z1hCdzlKMFgxa3NSNkpUVnR2RWYwQVlLOXJpWUhLa1ExRDhFaHROeWp4Zlk4?=
 =?utf-8?B?TEFEYTEwcGFsaWw4VTcwSVRIc1NXZERRY3dRRkJCTFBSNnhtbGRZL3hmc1lw?=
 =?utf-8?Q?UYqgtjvxsLXWVJCFBw5BMKbtc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c427b9-f85a-42ab-647a-08dcb833f074
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB9198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 05:27:20.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrRFpouHQ265mxBLFw9stUwZheULjcHg6zE643dTmQ1p2lku5UsI08KBRcfnA25nPZ4Yae2Sxz64u663IhnyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045



On 8/9/2024 10:44 AM, Viresh Kumar wrote:
> On 08-08-24, 12:36, Dhananjay Ugwekar wrote:
>> Fix the reference counting of cpufreq_policy object in amd_pstate_update()
>> function by adding the missing cpufreq_cpu_put().
>>
>> Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
>> ---
>>  drivers/cpufreq/amd-pstate.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 804fab4ebb26..36edae40db1a 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -560,6 +560,8 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>  
>>  	amd_pstate_update_perf(cpudata, min_perf, des_perf,
>>  			       max_perf, fast_switch);
>> +
>> +	cpufreq_cpu_put(policy);
> 
> There is an early return path in this routine, which still doesn't
> perform this action.

Thanks for catching this, will fix in next version

Regards,
Dhananjay

> 


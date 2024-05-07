Return-Path: <linux-pm+bounces-7589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9728BE63F
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 16:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427F7282452
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2C15F326;
	Tue,  7 May 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qWfWsjBy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354015EFD8;
	Tue,  7 May 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092898; cv=fail; b=KGkT70CeYu12yDB5bndG94nRuJU99R0A2MDN2hPIBtSEbsXIXMHYZFT/Yev6PL5AkuQLo6I2EVdKO8ECo5ZCZ4S2lg7d0wnPzUk6DEjE7CTwuDC8hKlyvdgsKMr27YGcWzKfYYyJ86lYE9NdXksBKwxyHUCnK/VTwrXh/sJnOEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092898; c=relaxed/simple;
	bh=xIVw9cy1M5wgJC+gmwaMhBo/NWgM1ALS1XUubkhrAhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PosvcWk21v0+pofw98UdKQGrm8mFUoB1tJMsVAzVggR3HR52uQhMkbTEIdUAxRRTBoDYpflmKmTkpYTDCAoYGG6prDQ0qVG1G8a8+ZAjcqYP0PziLPnp2klJwKsM2EPzzhnZMbdl8Jfp6TuzqkxDR2LyfCfhGUq6T22RpqiglV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qWfWsjBy; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj/eyGCKR8NY2srziSPMT8MRoSLAU1pIjbPJZlcwRwgw6clVYO8NnIIItLMtFWKuj8bS08+96P/C7QgLrMAjWi/3h3V78ejg1NGpBKm7OIpN64wepujSEPoY+CYNVLIfWlbzW6+DZbTlMtwH+/ZtIu3vc/kFxRIJ9MheY/0J3EU5mwgfc1nZ1FHOWVRGFZA59l1XjpTWYS99kDImzbwqANLpnHefrP34WT27DB/2GKR7UnkqCzLh60+yr0XXCnhcahBe8rAHuGGMtK22r+w+iCHtdjiF9rClDAmEqrXMufEWngbH045UQHCFPaWUuDwcsFtAfovux06PkPybpPRd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PTk2xU4hOkhgdVxy01zjPoOe50s5uwi8uvx0PUBZWk=;
 b=a5ApPNOGvt8+Guwc2vLZOpJX0RV9sejONf2W/2OTCpA5wZorAzbXenPeF+nNSOeMkk/P75rZGvbESkbrfiPz+QwwxWK0SPl0ysAcnPNQlZTDwELUvHVJWZR1MK1gO+sq1ktjrOLE7Iy7/mgRlodv/wZ1/I00zUTJ1T9JPv+3R/Kk5RPAtVZG/VbF/eCpU7f8IfD3Qwn27gAsuX4N+YfaLSIr8+vCGpOzWbLaO9qOMSt8xFUs6T8vMq6JsljRGir1LNuxeaYH78kQ7pC9HV5R2GvisodBlOZPswCEQETH4muy60DxrTdbZzcP2iimiFIlbaQ1a0RyjEqgpzP0Ww//Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PTk2xU4hOkhgdVxy01zjPoOe50s5uwi8uvx0PUBZWk=;
 b=qWfWsjBypWf+wcZvsyshgsME1C1f6K5mv0JlnKnUbhRf+JuAF6VlDGFOJfTdj7rs2J9zWdeDbCkj8Lk+U/1W3yi0dtosEIZIBN1fcnLN4mN2w+neJFXCZ1IfB39ybeHUiPKNenXgQFKokL5cbIXfvi25i13CJZtBB7YvZObkSnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 14:41:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:41:32 +0000
Message-ID: <3cd5fe9d-514c-4a09-a895-47d97a5c6b94@amd.com>
Date: Tue, 7 May 2024 09:41:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] cpufreq: amd-pstate: automatically load pstate
 driver by default
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715065568.git.perry.yuan@amd.com>
 <60bdfbeb426512d74faa91597453fd7960ebd7b5.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <60bdfbeb426512d74faa91597453fd7960ebd7b5.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: b962ee54-ecbd-4bb3-843c-08dc6ea3c9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUdxSHZXSkxzN3pKQWlTcGhhdGJiR3FWdXRmTlZaRlhwYTBudmF0UGhMN3Nw?=
 =?utf-8?B?RStPeERXUmhnWkpxWS81bkpwR3Q5djJPWGU3TzlQL0VxOE9pMENFdjlsYTM2?=
 =?utf-8?B?ajJKeFhIZFlha2pMZ0NaOXZGSkMzbktoWVJzS2piK0Nra2tBV05rRHc0djB4?=
 =?utf-8?B?UURVSEQ0QWxSeEN3UHZJeGk3K1hwb0QvNG1LZTZpKzhDZHFLMGZsakRnenRj?=
 =?utf-8?B?V0dtOS80UFVyVWcvWmxJN1BXejI5RzZsazBmcGRmNTdSc0VvK2s1azEraytL?=
 =?utf-8?B?Nk1nMG94UVNzeHdpVXBEZkNaREErTk1nMmRZbjU1T0ZtM0VQNlF4N29XZzBJ?=
 =?utf-8?B?SFNoVWZubVpZbVdydDNxVnM2amZ2aWljbjIyeU14Nzl1dFV3bHVEM3BGWGRj?=
 =?utf-8?B?OTZDdUQvcFRZYjY1dXRtakd3eHg2eFllZS92aE5nZ1FiWFhaS2RGU2FQQVo3?=
 =?utf-8?B?UWFYUnFlV2tvZ0pleXVYQitsYlpYODNkT29qczZIbjMwcEdRQmhkTnF4b0lX?=
 =?utf-8?B?NTNWdTFNSVU3YjB2LzVsaUdZaGF6cjhvWnorTlNxQXA5aUJoc0RCbmZWU0hU?=
 =?utf-8?B?azRXdlpBbU8zd1g5LzlWUVRjWjBDVlA5eEtHbTZxaS8vd2pBSlduRiswTEQz?=
 =?utf-8?B?UTUvbzlnUHJtVTREZENmVVRvY0YyTWt1azJUYkoyVXlTcWFFaHI1bE1vcS9a?=
 =?utf-8?B?N3p2cXFnNjlaTmxQcngyb29VZ1Q4aUpVVTJJbWxWN1dCRVdadFlMMkROcE5D?=
 =?utf-8?B?eUJURmRoK21qZUFkMHp4eHo0RWFCMkRmWUpsbFZhOFlTTWNsbmgvdHVoY1dU?=
 =?utf-8?B?dy9pM3VkSzB4cFphRDNyVmxla29VN1hUS2ZwQ3MydCtzbjcyc2JyNmx0cXZq?=
 =?utf-8?B?NnhBY2VZYnZTa0w5QXk3aWFTdDNub0xHYm9QQ3NpVkRjSU9QRnBOYUNnZEV5?=
 =?utf-8?B?NXVPSmE2Wko5RFp5aUdmNi9PYno5SmVQTkgvd2JtWk4zRUt4TmRoRUd4cjk3?=
 =?utf-8?B?b2ZvYTlUMVJJbTdFK2ZmZkU5dmdQVjNwRGRPeW4xekxFK0pUUFkrSUdDbTlD?=
 =?utf-8?B?RUVLUVEyMjlrRTBmUnlpRWdTZ0YzNnEwc3piOWpocW1JMks0YStXbmhST1Fr?=
 =?utf-8?B?VGdqdFZLd1hTeHluRkcxbzBrdnNzajFEWW9obGJKUmJPbnN0WXAwY0JzK0p6?=
 =?utf-8?B?RVZDNHBIelVxdDhReWs2eFFwb1U5TlB6U1Y4Mlkyb2duZlczMlFmMGFNclZI?=
 =?utf-8?B?ekNzakk2RGN6NWlLY1VqSXM3aG02ZS9WYnY5Q09yM2N5dC92Y29HR2xCNHJs?=
 =?utf-8?B?S0Vzd0IxcXl4V2dlSXNkSHhXK1VZcHRmMDlWVjFPTnVDQTc4c1FFMG9MUjlk?=
 =?utf-8?B?V3dlYk03a2hvbURGVWF0NGtFekZYbTNYQXV4RHhNN1Juc2IxMHlqVEt1V2xm?=
 =?utf-8?B?dUNPRXlSVlBVVk00QkI1eEtrVFVNN2s1NnFoWFNXMU44M2ROK0dFUzhla2VN?=
 =?utf-8?B?U3VjVGIxUEJGNEY4S0pKRTBheFE1dlVyTXh2UVUrOXBNSXgzZlYrWVF2Z08x?=
 =?utf-8?B?UWh5UnlSRHNIYzN6dDVJTWpwQjU5SFVwZFpIWlZhdEdNR3VPSWQySjVrVTho?=
 =?utf-8?Q?XsnMXbWuxyDptsk3Y3eK1MmjJ76z7iuIJ2UQ1jR6XHPo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm95a2U1S093aXkrMlh0THVONGUvelo2cE5Pa3dkRDIwNnZLbGRNMlBSb054?=
 =?utf-8?B?OUpLdTZTVGgyMk9BUTNvY3I1a0dHZHo2MmJVWFNQZHQzRU4zRTcyZ2Y1UEtL?=
 =?utf-8?B?OFVRMlFGQlNWMnFSK01rWnFCbFZPcTI3a1lHOFhOWldlZUoxR2xWak1ZTVIw?=
 =?utf-8?B?ZXlwWWtOd0ZzUVJWZm5NOEpPWTA1WElhay9aenpjSG4xK25LZzQvdVNsUXdx?=
 =?utf-8?B?RlZLTDg1SkptR3g2ejlkNVI1ajV6WkVzRFZmdGlobUR2cVEzaWw2TTJ1U25N?=
 =?utf-8?B?QThNd2N3TFhpUG1ya0Fma3FwckNyZjZoSi9YWDh4ZzI0dk9yKzhGQzJyOWw1?=
 =?utf-8?B?S0FzK29FYUZ1WllvaVV6U0xTdGNEK0FDRVZKVHpKQ3Z6YnU1cm5uY2NoUXg5?=
 =?utf-8?B?QTRvWDQ0bllaNVF5ZWIxOUJtdi9JNk9ocmpIU3VybFpPaUZoL2hyZTRsMlpl?=
 =?utf-8?B?Z1pmTHpSUUNZNWZLcWdjR1BRTUtpTmFXclhlaC9MVTIyMHFGT2sxTFFuK3pZ?=
 =?utf-8?B?TEZ4M0c4S3krZ1U0OUszdmY1NkdpQXpDZHBGbm9DcnBCZVJ1Z2ZRR0VBUjRV?=
 =?utf-8?B?Vm1EQlhjRmxQd0Z1MkFuMDMzREVSWEdESmZzeE43bE9ILzdnMnF0c3FrY3hx?=
 =?utf-8?B?cG1ieUxiV1VaaGZ5b3pPT2NtUS83bzRVUDExMDZiRlVQV3pmOUZCdGw2TU9T?=
 =?utf-8?B?TVNDelpEbXNGY25NNjROc3haQ2ZyRlYwRkJLYThNcEkxN3JsR0NYaHdyc0xs?=
 =?utf-8?B?WDRXVkZDZitXVGNuNG8xWncyMGtXcmVSK29KV2ZsYnk1TjNDMVkzZE1vNVZH?=
 =?utf-8?B?R0xUMmY3d0VoZk16Yjl3L3VRV090ZlhGVFIxZ2FQckQvSmpkcFNwblpBZWZJ?=
 =?utf-8?B?dTY0RmxSUXVDWUdDOUh6dDJYWnFRQlZxMURzTTNJdWY4RG53Y3QxRmkxTFM5?=
 =?utf-8?B?Mm5SaStvMU5xS1lJZjF3YjUwOFBjRWVXYVBia0hvMUtVSEtVZDhDOHVOQUtn?=
 =?utf-8?B?SXIxZVhNVHZDTk52aXAyN1Z4Nk4vYkdtS2NHbXp3KzFiWmpTaGhnM3prNFA5?=
 =?utf-8?B?MkE5Q1JnajFrcjV4WUNVNTJsRjNyMDR4QURtbFIrQ21DVXJ3MWlZbExnZ09v?=
 =?utf-8?B?YXc4S3NrM3U1cG02VExBQURuZjJ0bGU4dGcrSWFMeVhHTXowZ3NuVUtaYklw?=
 =?utf-8?B?VEZaNDZEejZHVXhlQU9kZEJHRFh3SUx3M0YwMVcra1MwWDhLak1mMWYwdXZH?=
 =?utf-8?B?YU80WXRmVWVlTUQrRWFBQkU2MVN6aUhNNnltTVZwQnYveXAwVEkxM2NPU2la?=
 =?utf-8?B?MkFVRUU0N2JTemZzcWxNTE9SdEd0WlVqczNwUG9zY09lUHdseXV2c0pvdnB4?=
 =?utf-8?B?dUV3VnNBU1BHdU1oeWtGWi96K3piaUpZdndUVmNZcFpic3luRHovMktBa0pa?=
 =?utf-8?B?THpObVNSZ0QrOG1xZkZ2aEZPTm1uWnR4SGdrYmtyT0EwRlNEMGZROUlCYmdy?=
 =?utf-8?B?T0hKMjJCN0QwbTR0S0V2cE45NGR1RUlhM0wzRkFRSm1XbVVPL1NhOC81ZWcv?=
 =?utf-8?B?U2YvS3AwaEJHRUFuSHFsbEFldnZ0cWViVnBYSUlsS0VBbi8rVVBhWlp6Rnkx?=
 =?utf-8?B?QWwvZnZoNlQzNTl6WWZ2L2d6KzV5S2tJWGd5b3NyMmZJbTFERmdzbk45NnNN?=
 =?utf-8?B?MGZUS1ZaWFYxakdseFlPVjB3bnc1Wk1Hb1dtK3M3Wlhsa1I3emszOTRuSXN2?=
 =?utf-8?B?NWxrOWg5TFFnWHJDaVR2dzBtRktCS0JtQ1MwRTFaRjg1V3VsRCs5Z1FkVCtE?=
 =?utf-8?B?WHVDVWx2NFBMb0pmWHZRQ2hLTlpIRUh3T0p3MkMvdU1KVWxlMzVYRkFzVUZH?=
 =?utf-8?B?Mm9VVnNxcVV2TnBibTZhK0FyeWxiWHRMalp3MVgvbVJSMkFxdkh0dCtDUEVJ?=
 =?utf-8?B?YzFXaFR0Z1RQMkU1ZWZicWMxZkdHWVYyS1J5NGZzMVAxQ0FKdDRhSVYra003?=
 =?utf-8?B?R2tvaGVwdVpGUWhnQW9YSUVESG1wbVErSWcrQWtaR2NGOXY1QVlsQUFaSEtM?=
 =?utf-8?B?SHhmSHZJWllGUEdjWXpFdnhkQ3paOUpmK2RnandlU3VsWTJQTnJvaGcrUGZo?=
 =?utf-8?Q?0m+1sVFZ2IggXEbXE67oGu9jL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b962ee54-ecbd-4bb3-843c-08dc6ea3c9c2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:41:32.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSwTtty/GhPPt3j2k/6ra6rdA55PlpnmJtZVeZxaR2OXgPURnBnzni3S+E3AvEhi9h2XxlLe6ur9r757zKa8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318

On 5/7/2024 02:15, Perry Yuan wrote:
> If the `amd-pstate` driver is not loaded automatically by default,
> it is because the kernel command line parameter has not been added.
> To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
> function to enable the desired mode (passive/active/guided) before registering
> the driver instance.
> This ensures that the driver is loaded correctly without relying on the kernel
> command line parameter.
> 
> [    0.917789] usb usb6: Manufacturer: Linux 6.9.0-rc6-amd-pstate-new-fix-v1 xhci-hcd
> [    0.982579] amd_pstate: failed to register with return -22
> 
> Reported-by: Andrei Amuraritei <andamu@posteo.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++-----------------
>   1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3ff381c4edf7..f5368497ee79 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -66,7 +66,7 @@
>   static struct cpufreq_driver *current_pstate_driver;
>   static struct cpufreq_driver amd_pstate_driver;
>   static struct cpufreq_driver amd_pstate_epp_driver;
> -static int cppc_state = AMD_PSTATE_UNDEFINED;
> +static int cppc_state;
>   static bool cppc_enabled;
>   static bool amd_pstate_prefcore = true;
>   static struct quirk_entry *quirks;
> @@ -1762,6 +1762,16 @@ static int __init amd_pstate_init(void)
>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>   		return -ENODEV;
>   
> +	/* Disable on the following configs by default:
> +	 * 1. Undefined platforms
> +	 * 2. Server platforms
> +	 */
> +	if (amd_pstate_acpi_pm_profile_undefined() ||
> +		amd_pstate_acpi_pm_profile_server()) {
> +		pr_info("driver load is disabled for server or undefined platform\n");
> +		return -ENODEV;
> +	}
> +
>   	/* show debug message only if CPPC is not supported */
>   	if (!amd_cppc_supported())
>   		return -EOPNOTSUPP;
> @@ -1781,28 +1791,21 @@ static int __init amd_pstate_init(void)
>   	/* check if this machine need CPPC quirks */
>   	dmi_check_system(amd_pstate_quirks_table);
>   
> +	/* get default driver mode for loading*/
> +	cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;

Rather than setting it here within amd_pstate_init() I think you can 
just set it at line 67 to CONFIG_X86_AMD_PSTATE_DEFAULT_MODE.

> +	pr_debug("cppc working state set to mode:%d\n", cppc_state);

I think this debug line is going to be unnecessary when it's already 
hardcoded to kernel config.

> +
>   	switch (cppc_state) {
> -	case AMD_PSTATE_UNDEFINED:
> -		/* Disable on the following configs by default:
> -		 * 1. Undefined platforms
> -		 * 2. Server platforms
> -		 * 3. Shared memory designs
> -		 */
> -		if (amd_pstate_acpi_pm_profile_undefined() ||
> -		    amd_pstate_acpi_pm_profile_server() ||
> -		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -			pr_info("driver load is disabled, boot with specific mode to enable this\n");
> -			return -ENODEV;
> -		}
> -		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
> -		if (ret)
> -			return ret;
> -		break;
>   	case AMD_PSTATE_DISABLE:
> +		pr_info("driver load is disabled, boot with specific mode to enable this\n");
>   		return -ENODEV;
> +	case AMD_PSTATE_UNDEFINED:

With the intent of this patch I no longer see a need for 
AMD_PSTATE_UNDEFINED in the rest of the driver (or in this case 
statement even).

I feel you can drop it from amd-pstate.h.

>   	case AMD_PSTATE_PASSIVE:
>   	case AMD_PSTATE_ACTIVE:
>   	case AMD_PSTATE_GUIDED:
> +		ret = amd_pstate_set_driver(cppc_state);
> +		if (ret)
> +			return ret;
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -1823,7 +1826,7 @@ static int __init amd_pstate_init(void)
>   	/* enable amd pstate feature */
>   	ret = amd_pstate_enable(true);
>   	if (ret) {
> -		pr_err("failed to enable with return %d\n", ret);
> +		pr_err("failed to enable driver mode(%d) with return %d\n", cppc_state, ret);
>   		return ret;
>   	}
>   



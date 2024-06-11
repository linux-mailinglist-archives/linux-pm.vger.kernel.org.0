Return-Path: <linux-pm+bounces-8967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B320D9043FE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B71282E00
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391E80605;
	Tue, 11 Jun 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uQ1ZN2xf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74F57CAE;
	Tue, 11 Jun 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131827; cv=fail; b=KKE5uq/cQ91VF0zGqBnrKXN4/2fefY13S6XkfuTf+e2CfWAa9AP/HKqb9l3BUOxSLRmiSJWBd3oOlex5fSaxdLWC+YLQb8mJizu8uj5xk2oY3YBRu7U0/GRaBWGJrplj8ey1UVlzzCbuHdwHqnj1jAakXhsbflWZwad5mxY5MH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131827; c=relaxed/simple;
	bh=zftxwze457lgJI2v+CLxjoKZIQryROeWm1WOoVQU4lw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XesjAk2gfGQ0iVrv0wExBGrGpKxOPSA2aXxU3RaJXiGtsat327YCXp3eDXq+pb5ZjK61M9hlX6lcQkr3dJatZR33J2Q2tlOQDN0RXw2JkR63kWTX4VDF4To8I7ULEdFgfwUuA7aKYnj19Ubs/eWHowifi+wCoLrBgjhC/6a1paI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uQ1ZN2xf; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHfydlOp4GbML1TixUIHOIKvYvisIsnxOOwzLxE/MSSvOF8Io/ANZW9Qphinuqq1BAA7ran2MJxIblkADEemYBKSCZIOcPWpXcnUKOVm2rmfDijBiJ6AzTCMXZEwz38M+n8HpwQcmQvRaOgCogv7IM04Jy1UAO3D/s1htdrReTkRZ+BeV6Hbj9O2CFypetjCb11339E895Dw5qfwWfz9PYfkMpZKRvLMKSsZZbiKAJ3ld5LQ3doBkUQ7ZoqXW4x2MbAjBUrcq7FbOnOpjiUBhL4Y8X5uX4WTvHbvgyoErNrWIx8bYJkTWXlNe9/7Bdyl8UT4+VHpU9UHt3LFCRomwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERprZy03tr/pSUXLmd45v5YwUGkAoyGeDtZ4SpVQ/5E=;
 b=lpCrA1FZExEMkQplj/t88hrGeTwlIkBU2Dmn5DgQSfLOW++4y3F2Cd8dZLEIU7wm6cJ4E2vQnkwAsD2N3C5ASnjZnxiv8srx3NnD/MHrQczihzY931kjAXGyiJAOBDoqqwInspmp6wHm4WmUIw2r4LjvDDiYerAS9KYFwgWKBkrZj873pztO/lyG0NaGhSLLrjhoa7/eMJMkR5eHKyoEqo9HvJ6pN6OfQYEqLaYquJ33t0X++4CasgJz2n3xA+4VV5TVNtD+Vh8Y+k8tBFToJ5vF5Og/u88b+EUNS4vUxklf1OOqYXNdzFAC9QTGsytklGkUvvNKW/ETYxa3L/LfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERprZy03tr/pSUXLmd45v5YwUGkAoyGeDtZ4SpVQ/5E=;
 b=uQ1ZN2xf2ubluvBZEcOGFVynxw5q9sIqjDDa9ElgErMziM672vL0OFlJTgHva+x3ndFTDZgEiKVuFO+y2iLngJKVSpJBOjknEBmCpJwItTwoJgv3IVekJJJ3L50PmZKwRQ+mBkuFyipAf4QEl+nP+heEfZCMwZbsNlDK5mpxzZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 18:50:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 18:50:18 +0000
Message-ID: <37e3477c-db6c-4fa2-9799-f23a0f37d20c@amd.com>
Date: Tue, 11 Jun 2024 13:50:15 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 01/10] cpufreq: amd-pstate: optimize the initial
 frequency values verification
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718095377.git.perry.yuan@amd.com>
 <c3e867be691b6fdb3d34e378199b297256aeebff.1718095377.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <c3e867be691b6fdb3d34e378199b297256aeebff.1718095377.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: fae03404-f81a-4178-3aa3-08dc8a47567b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MENNcEFLcVdMaDBQRSs4YVM5d3RCVnJNUDZBZ2drSzZVMWFlV3MreG1ocVBn?=
 =?utf-8?B?c1o2c3NQVThnQ3h3OTkrZVprdWJNSElqc0dIbmUxMDNnOUU2ak9BQW5ObjZi?=
 =?utf-8?B?Myt2RlVkK1lBRk9LNEVPVUlrWEVTN1VEVXcybE5Vbm1SK2ZaRCtiYWVCSy8v?=
 =?utf-8?B?Q3FwN2Zjcnp3dXBESU8rN0JoaDZkK0hXZUxuNkVFOGdXVXpKNHhxT2lMbzBK?=
 =?utf-8?B?Y3h3MTlhVTd2dGYwMVdoQ3g1UzlHb2RDMjdXbGlUdzhvQ1A2YklXRmpzaXl4?=
 =?utf-8?B?cVV6bzhmdVZ4Y2NiZUNMRE5RS3B5TGhtbVFRVzdzUXl4YWtuTGFDSGhWd2dJ?=
 =?utf-8?B?UUc1Q1dVMkY0RysrRUo3S09TVktlc0RUOGxNR1dmdlFDNlhjRDBFMlVMT0ZB?=
 =?utf-8?B?dGJoSjJRTUxRVjVaaDMrOVBpRUxmNmxwd05nM2ZBVUxkeW5rQVhUTit2Tk14?=
 =?utf-8?B?UW9VZytMUWVSR3VZWWdTbksvNGF1aXhUMVJkSVp4bGdIY2RESkl2REpHYzlB?=
 =?utf-8?B?SUd0S3YxUDhKcWF3azQrMWgvL0pqVnZ0OEV6MGF1ZGQ3ZGc1VUgrT3orUldO?=
 =?utf-8?B?d2JmYXQ3N0k5SGJhdmpwMzEycmlnc3d1U25ZWWhGQkNUTjJuM1JvdVQ0U1A0?=
 =?utf-8?B?bUM1L2lIZ2RQNnB1a3I4azZwS1pJcG83VnZwS2hhN3NQR3ViVnhZL1ZNZ2N2?=
 =?utf-8?B?ekt5a3FLeFM1S0szUFVZQjFNbzNOMmZxak9leHlwYVpoM3NuK21WNnRJNlpL?=
 =?utf-8?B?Z1ZmVnFMZmR3a2pCNGJCUUVramNJdC9HMGM2WUxLY1kyWVBjQlA5aEFZcFRo?=
 =?utf-8?B?NHBpYlJRSEJQQThFVVZHUG9POElqUldpZTl4T3ZIM2Q3OEcyTkZwdTVpa055?=
 =?utf-8?B?R3R0NXgxTWZ0dlZNSXFHb0pYVkZ4M3JRTlNNNVpPY1ZjN0t0elpvNk5Pc29W?=
 =?utf-8?B?MWFLR0xZZXdENkh2SlgyN1huMzA3RTR2K0MzRkExRWQybU1pc2ZJTzdHeW9H?=
 =?utf-8?B?bGdnU0g4ZUZrbTNBdFFiKzZPRDVFK2NkOWR4WW10R2oyOVRadW4xeXg1dFND?=
 =?utf-8?B?VnVyTFVKK2F0UDhzOFZLYXJoWmlBT014YitvYmF2ZmlZeGVtQmtReFBZU2xo?=
 =?utf-8?B?WnhGNXdKTk44U0p4a3d4aENOWUlpUnB2Q1BOQkFLdG5HZEduMFV1TTFva0VT?=
 =?utf-8?B?S0FKMk11ckVzWUovUjJJYnZNeHVWYlovU2hwRHRFUmJvYkNMaHN5NmxsMml5?=
 =?utf-8?B?UUkrbWpSMFVDa3FYTnpmOUhYTC9KT3hOMHIzU1FwSVZwUlp3N2hEQ1MrTThm?=
 =?utf-8?B?OUhrWjF4aUl3TFh6cjJJeUZmbXRPVERJZEh1cU1lcUdrOUNzTkxqR0FNdXVl?=
 =?utf-8?B?TmZEZm0vaFNsQ3VzWTV1d3JoQjVwUnVjdHhudkU0SXA3WDUrQ1ZQSllhL0dh?=
 =?utf-8?B?UjBXVjRPbmhaMXlCbG8reEhJQjE0MlBRb0srL081azUyV0NUcm1UcXBTcWsr?=
 =?utf-8?B?RG1KODB1RHFvZkViRk1jQzJTQXhxSzA1NWRDdTRPQS9xMFBDSjRIaUdnTEVx?=
 =?utf-8?B?RjBFRlphenN0MFpOWFRoMFBwK3ZZN1d0WUJqNG5PTUM5QmxYNSticDZURVNN?=
 =?utf-8?B?NzZPZnBDUUM5SS9md1RBVVVpU2pFMjk5VkZMWWZmcXNyQkJDQjA4UTZuMnJm?=
 =?utf-8?B?MzltR2hyeHd5OVlPTEMyS1hGUk5Wb045MmdJV0Rodm9zN1NMQzNUOW5KQ01O?=
 =?utf-8?Q?sMnFGuwnPQPwDQqiLwcKOUvo/Rvz6Lw8aRIQCuA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXoxSVpnbTNHcFJDV2pVL24wRnU4eHZHYnNPT29pS2lBcHFpSU5tK0dZUktu?=
 =?utf-8?B?citxSlhidVJnMmdwSm9UQWVlYy9JamU5N0NYY29CSG9wN1BrcVo0ZUJCSXVq?=
 =?utf-8?B?MXNXb3BaSWd3bEd3S0JuakpUUTB0Y05rODRMZXVpZHVGdmlHeWF1ZDV2YXgw?=
 =?utf-8?B?OWkvYjRzdlUwYzdGN2tOa3RIc3hGRzNJOU5NNlFwdks3TFBUdTRFV29OcE82?=
 =?utf-8?B?dklDVWE3YWJidG4yTGt3UjBwT0h3eHpOWC9BTlhBM0ZLSW9rdDJBVVBESVBP?=
 =?utf-8?B?UDFXaERTS1p6NXh2SkRRUU56L0l2ZGYvQzZERUVXWmsvWUZSYklITXpJLytR?=
 =?utf-8?B?NG1NYUFMZ1p3ZmZFNHdJYys4YVplY0hoRFlRTTJEREx0N2czamFRSjE0UnFp?=
 =?utf-8?B?U2FoeFhhbWRSMXlDdEZnbkdaR0FqR1V3d21GSDFSclpxWTBrZXZjK1dWdG5M?=
 =?utf-8?B?WU5UZkpEaU9WQVN6TDhuUnFPcWRGNm9weTZXN0RSbGFJcVdkQjNaMVFWVTNy?=
 =?utf-8?B?eUIwbTNLenBVdzhtY2gwd002VjdyK2Vob2VmMTdYOHdkOU1ZcXZKWWJTaXU4?=
 =?utf-8?B?dEorcTZFbDkzWFlqZGpmUGdUY3V5Z2g2TmhJS1JNeXJzZ2ZVU2tKbFFOTG9u?=
 =?utf-8?B?UzZmZnJYYWFBNTVKZ0RPY25wQlBtZ0JsNmM2dGlscDIxNHFXL0M5Q2xYR0VK?=
 =?utf-8?B?NjNNa1c5Q0M4azhiZ0pDbHdWNkRGamdDMlNHdUZheTdxN2ZhcHVVUzI0ekRL?=
 =?utf-8?B?MXBNQlEzVGxoZkhKZGR1M01qT2dXOHduakw3bVVHVFM4RjVHZkNScDdsOVpl?=
 =?utf-8?B?ekROby9Gd3pVSFJPamdyeDJLVXUwQTVvTkt4UUdqbEtiRzRCNW1oYWNUczJz?=
 =?utf-8?B?dnBqMm1JWVpackhOQ3B2NUVvdDRibEZ2UG5wTHNIOHcvcUhhMEpLZlFCVkhU?=
 =?utf-8?B?R3JVMTF4U1IwRWp6d2tDUFQycmlNWlBVTitoS2tOMGxkWjRIaUN0NURZb2hh?=
 =?utf-8?B?WVcyQnBUQXhsSVFMdlpVZXR6TTZUQ0RhOGVHVlJ1RG9oZzhQMzEzU0VSNGdM?=
 =?utf-8?B?RkxkY3pRWW1yZzBUSFFIUWRKMmQvWm4wcVZiQmhlYjRyY0ptb0RkT1N0Uzhv?=
 =?utf-8?B?SGphWUxjZDl4YU53bVNsTFRCR0hzczZNZDJLKzlrNUFyZFNLUE1pd3JZYTN5?=
 =?utf-8?B?UEVoQUo2YnBFVTA1alRBam9kSDBhZFpEVm1iMTlzaldMeGNkV2ZoS2crV2tJ?=
 =?utf-8?B?bWt4QXdvMi9BYnhDQ0xzUGhEL0FyZy95bW5SeVZRSlo4Z05zZnkxRzFKTlJz?=
 =?utf-8?B?em15Q3VRTEd5YjhEQVQxK1pLVTN1cFg2RWR6REcxcU10S1NuSmExcVNBVnJC?=
 =?utf-8?B?UjVTTVdweGxhbm43V3ZBUzVnOXdwOXJvRjZCTll2aDRFaC9ERFdmczZSNDY2?=
 =?utf-8?B?QjFNam1Cck5FVVVjZWdaYWZiUHhiZU9zeCsyOFVqcHl6cFJWRGZTSzI2dEdj?=
 =?utf-8?B?RHo1VHdKWWJJcjRQdTZVNk1MS2wrM1k5WHphUlNoZVp4QXVINnNNY25tVXZF?=
 =?utf-8?B?ck9sdXNkcVZHTWpZYm5kMzhQaml4cURMenM5cWJtaXRkVHd3RmRia1ZZSzdl?=
 =?utf-8?B?QmFVQ1JpMGpaRzl0aGRGTDh2b0xad0xJclI4Nmw0RThGOVdqb0JJMHBNbnBQ?=
 =?utf-8?B?ZlJpOTBqVVR3ZmgxNTZpb1dqcnY5bk0rbEJaNldYTUVhRzZ6amFuVkMyY29W?=
 =?utf-8?B?UW9HOThUaElrVFBZK21Zd3phL0FKaUZ3dGtGRTdVMnBwVjlTMFhTWDZuTXdE?=
 =?utf-8?B?WGhRZVpKcmpkU25yTmVhb21OeVJIa0M3ei83SS93dEdpall4cTA5c09NOGIy?=
 =?utf-8?B?SU5HZDdmd3NTYVExVDVSMzV0aG92R3NPVW1LMFJMRG5FSTJnS29IeHdERmZh?=
 =?utf-8?B?cTRna0VPTjBHSU1NTXJReFBORXBuNUJBaXE0NmJWUUpZZkVWVkpGOGJyS1Vp?=
 =?utf-8?B?S3gwRHE2cEdBN0gwWnNvT2FYT0wwN05LeEoxL3loVkhSTWUyOENQekY4c3Jw?=
 =?utf-8?B?Qi9pZXR1ZUNLOXU5UzNNNDB3NlFGKzh5M2pGRFl3VlVBcmZpRDFuSGxrMkFT?=
 =?utf-8?Q?3579Zvq14lQNQdwHlwpH2v1ec?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae03404-f81a-4178-3aa3-08dc8a47567b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:50:17.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaEBA7KCqX97Ebmj8MmpuR6krvA0YpubwPpMHe09L/h4GjhTFHcvQXCb77ZqINcULxP1DuYhIj232S4fR+YIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

On 6/11/2024 03:52, Perry Yuan wrote:
> To enhance the debugging capability of the driver loading failure for
> broken CPPC ACPI tables, it can optimize the expression by moving the
> verification of `min_freq`, `nominal_freq`, and other dependency values
> to the `amd_pstate_init_freq()` function where they are initialized.
> If any of these values are incorrect, the `amd-pstate` driver will not be registered.
> 
> By ensuring that these values are correct before they are used, it will facilitate
> the debugging process when encountering driver loading failures due to faulty CPPC
> ACPI tables from BIOS
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
>   1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ad62dbe8bfb..37fce0569d06 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -921,6 +921,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>   	WRITE_ONCE(cpudata->max_freq, max_freq);
>   
> +	/**
> +	 * Below values need to be initialized correctly, otherwise driver will fail to load
> +	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
> +	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
> +	 * Check _CPC in ACPI table objects if any values are incorrect
> +	 */
> +	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
> +		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> +			min_freq, max_freq, nominal_freq * 1000);
> +		return -EINVAL;
> +	}
> +
> +	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
> +		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
> +			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -959,15 +977,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	max_freq = READ_ONCE(cpudata->max_freq);
>   	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>   
> -	if (min_freq <= 0 || max_freq <= 0 ||
> -	    nominal_freq <= 0 || min_freq > max_freq) {
> -		dev_err(dev,
> -			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
> -			min_freq, max_freq, nominal_freq);
> -		ret = -EINVAL;
> -		goto free_cpudata1;
> -	}
> -
>   	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>   	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>   
> @@ -1420,14 +1429,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	min_freq = READ_ONCE(cpudata->min_freq);
>   	max_freq = READ_ONCE(cpudata->max_freq);
>   	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	if (min_freq <= 0 || max_freq <= 0 ||
> -	    nominal_freq <= 0 || min_freq > max_freq) {
> -		dev_err(dev,
> -			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
> -			min_freq, max_freq, nominal_freq);
> -		ret = -EINVAL;
> -		goto free_cpudata1;
> -	}
>   
>   	policy->cpuinfo.min_freq = min_freq;
>   	policy->cpuinfo.max_freq = max_freq;



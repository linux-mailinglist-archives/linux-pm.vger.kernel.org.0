Return-Path: <linux-pm+bounces-9102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68493907A4B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D265A1F229C0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3AC14A4D4;
	Thu, 13 Jun 2024 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uufuHZlu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45CF1494D0;
	Thu, 13 Jun 2024 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301235; cv=fail; b=gX2WOkUw5ntaYE94hW17vAjOxtSDmUY6FG8QVbNmb/K21WAzTb+rCIaKhk+C95A5Ph3SZiFGxkYrHRbdx/HK7gbPer0LvRLvwnrtI8JkToP9/hKKE7h26htaL1qVHNzHyc6ggLYOipcO/ohUn5j2o4WtXMb3W2hNbQ9j2hPZtq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301235; c=relaxed/simple;
	bh=pcweEOXKen/dVn9Um1ZWHxT/FEtD45vkk15Y6e4EQ4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+4bx6a1oFv72uXNHq18TJgquvHZPl6SKVvqJCSuAtAnF5UW+7P5xnSEQ6TK6GXe0Po4LPe7GgNTipuq20iYnFW8S2qpCntSAUAC5XnnIWAXHDQz9kGU5jhM2jx2F/aArYmsNcFFebLv/CWXQP0Jc+U2Yg9RwgPAbhYVomrsIac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uufuHZlu; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr6n92MvnXcAEo77tlbOOzgGeLuKUYHopOHIhRiLLTQkkhXjJAlPIo1ksc9gqGGwe+pLfuRPrG63hsPGPC2GUWWsbD6FajLyvq3emlmxpvmhpvVFmX/RiYQirInFpur+sRYlCB+U9Tt0OOcfh3nlGd816XwE1DMjAtWnypFehsaBEkB7d17d2AerxqaZlNBnRYRzwRCkBRb9mqg9yqDcvnKOhvv6MNiPXC77uiujXCyt9Db1KJqgoiPz47eyZ/ymsTpvegyqKs1HCat9vJlSdsVbCw4IDPlTkKBPmB5WKKC5AdvPCYs+fUAw16sgWqAyxl9Ieui3ACZwneKXVd5KLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVUTQaIVkuPpUl9d+cwCsfEGEBKFZCGDXqvo/gFWeK8=;
 b=VirGQvsEzn3kyEiMvm/tDKW/s5CVn+9n26V9/hgh8TtGPApAzddr3zhcPfMrP+CnB5ls+G1xUVBIMsSlO59+IIY3N0V9FZVSkrSQNIRPQJPrbLUBo9oQjG/ApwDfgrN+ud6EM593MXc6l/aFZDJcUJ1jxqOGRKDXyJeJCxpID+lZMg8Ic1fJjCI2/irrwvm2yBLsET9891r7Vf7xxplo0Ve4juSt2V5cLeRbsrR8rFbWpuRHm3DOZOs/KaNEq8ghxMf4qG2vX9UqrNK2GHgcZ9wtYIMagExpHvR856Wgn0dEaI6oKV8mndEW5rzjuYkZ1a9mW3jkPWHUBaSoQVXOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVUTQaIVkuPpUl9d+cwCsfEGEBKFZCGDXqvo/gFWeK8=;
 b=uufuHZluoYMKDfFooQxObQD1BVgvyCdTUVy2HeG6X8/4taRe7GXOzMOyWbQsXGphJSyukQRgUFrt+QORtcxvdVlXA2jyBaB9qgA3h6y/xIFE+fqC3JDCWIC2Gcclsw1+XTqUvid73AuSIAbqxfinC+LW8U1e9x3V/OEAHhORpLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 17:53:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:53:50 +0000
Message-ID: <4ce0f6c6-8ed4-41df-a57e-bf2b0522f2e1@amd.com>
Date: Thu, 13 Jun 2024 12:53:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] Documentation: cpufreq: amd-pstate: introduce the
 new cpu boost control method
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718262992.git.perry.yuan@amd.com>
 <deeab069d0aeed0d221a33345044f9faefbdd6f2.1718262992.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <deeab069d0aeed0d221a33345044f9faefbdd6f2.1718262992.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:5:120::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: f5809868-13f5-4f53-3e85-08dc8bd1c837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkMvTXdTeWx5VW9CMzJGN0JGcFkrMGpiU3dwaDhpd1I4V2ZvUDVIN09PVVM2?=
 =?utf-8?B?QjJRcW9BUlIwckRjNXBMNW1tUkhoK2lSb0R2OWdFUVZrdnBhbG90dUhTYXdh?=
 =?utf-8?B?eUg3TVZqZnBxREdySGNvS3VJNUZGMVllcUdqZ0UybDd0WWRhekRILzZ6M1Er?=
 =?utf-8?B?NEVubWl0VkVKYzdPbXRtU3BFTnhVTi9sSnkweWtkeUZGZktGcmNmcFR0QXdu?=
 =?utf-8?B?emNGYXByYk1HazVidkFkNG52MnRrTkpNbEJ2TTFYY2dWaUxNSVpwSjdXV3Y2?=
 =?utf-8?B?M1czcmpLaWVnV1pNV1NIZ3RtMkJDdXpDc1ZCZFlEVXl4ZnVmanB1b3RXME80?=
 =?utf-8?B?TWpKWHBrL0RoQTZua0d0RSsyeFRoN28vSExmSVZUUGRaRklraWpwSG9ESXZ5?=
 =?utf-8?B?bXZwTXl0VlV4MXlhWXlLVnJQZ0lQRDlzckRRMGRhV011TWZscVpTeWc3Y2ZE?=
 =?utf-8?B?SUoxSEVvY1c3cUM5NU1vMzMxalo5dHJuOCt3N0hmdzBoZmkxZUhIUHlaeVlB?=
 =?utf-8?B?K0R3bkpDTEF3R2dFRDBrUnljTngxZWxsNWNTaDY5VlZzbktOWkRhWTVnaWkz?=
 =?utf-8?B?b1hNUUVUZFpWdk82OWVWTWNQS29iWjV2QXk4TFZRa2p6MmF1Nk9DMlNQU29P?=
 =?utf-8?B?SWRsM09UM3RkTGlwdzZlODE3NlBicjdXT0pWRVhWdE04a3dkcUZhWUE3UHV1?=
 =?utf-8?B?emJtL29JVXNrZmpidGU3MGVJb0tTR0lXMms5VWhxcFllei9xR1BWQkJ0MTRG?=
 =?utf-8?B?c3QxU1lxTVV4K1doenZNZC95ZGhUaWkwOTcydXBZbnBCS1lSK2FkR2ozMnBi?=
 =?utf-8?B?WDlIWEZBMnFjRW5RTFJvZ2I1aTVvS3NkYlVvVzQydVpjU1Ixci9uWU1heTVQ?=
 =?utf-8?B?U3p5TGpSaFJPb3Azc09RVnZEdFMrTHg2VDZHWSt4TUIvN2JkdGUxUnl3ZTZm?=
 =?utf-8?B?T1A0dFN3SzhFZkUwN0RURGdPN2Q2MzhqaGI2S21pT1BvNHFDQ09WT2ZROE0w?=
 =?utf-8?B?MnFwSTNwMEk2dHM1aUlndkxsK1JPRjBkUVFlYXdKNmM3alhPTXhvWWNORG1W?=
 =?utf-8?B?TUpmS3FBdktTM1pGQlI1UVVzeGJEUVN1KzVwSnE2LzhSZWRaeDJHUlZlWUVR?=
 =?utf-8?B?VTYrdmNmckVsSXdRd0tCb1gyc0JYYmVoWVBtNElGYUhVSklNNGpWSmh5cUVS?=
 =?utf-8?B?S3U1RlI0MkE5QzRpQXV6Mk5pa0M0N2lyblNQNXM0U2g3eEtTQzJOMDFwYnFl?=
 =?utf-8?B?LzBURmZqMzVrM01zbDN3TXFlY1pPbzVRaU1UZm1HUUhzY2hFZm0rQ0JNK0xt?=
 =?utf-8?B?QW1OZ0lacXQ5VVpOTTBJa016YTBmQU13azV2alR5T1VBZ0tNcW8ycU9LSHZD?=
 =?utf-8?B?VjRMYldlamFXRW8wZFhwUkdWRUJDVWcxVGpkWmlSMkN3THdKNXlMZ1pmQkRV?=
 =?utf-8?B?K3cwc2J1WXlzZ2xuVjBvb3BseS92bGZkVy9nY2lWZTZnK3ptN2N0ejNMRm91?=
 =?utf-8?B?QXVjdVU0TGhDNkNuYVhsd2dZRkEvbnBBNFVRU2hEeDdrZTdWS25mM2txejYy?=
 =?utf-8?B?TEdsbzh4b05TSUZ5QWZtZ1hXWjd5R2ZNcmNPSXJMd1FjVVlIelM0bUROS1J0?=
 =?utf-8?B?ZXJCK1lwK1pyTFZmUmo2ZDduOXZ3WE1FT0N4eTdYQkVyUW5oY2lHRjBwQW9n?=
 =?utf-8?B?RjdnQzFxSjlmU0lNRzlGeFkxTlU3Q2RGbkUzRTdiRE1FTlkzSHdJSWNuY1pX?=
 =?utf-8?Q?5dD9Dam99WLts1NdzrjGVpetur2vZf2mgtsk4G0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ZERjRqZzQvTDhrR1ljKzgvTm13Sm14dGlwVWdsQThJelNyRXB4bjVydmd5?=
 =?utf-8?B?UlJkV1B5amJ3Qk1pK0VsYmFXTzlUNWIyNzFXQ29IR3ExVUFJMW9YcHJGL2Rt?=
 =?utf-8?B?cnlUWjBzRkVkYlNqMjU1RVlXd2FBK2Uxei9tQ1k5R1J5dEI0UkhxTmhKMlFO?=
 =?utf-8?B?NEZPRlNrTXdlOXpNdTZncUdVOUdlNTJUNG56d0lvMVhGbzEwcks2ZXphMHRP?=
 =?utf-8?B?Wm9vbHdtU3FVQ1lRcERuUVdBbFlBSytDcHorWFFETzBGSnUrR3k5Y3hXNExZ?=
 =?utf-8?B?WDN6UUdaKzRoTWw4NWFIZE9jb0Z0ZmpiejFqMmxPVjlzdFhIeFRMUW9DYk80?=
 =?utf-8?B?SGQxT3dIdzViZ3RFTUFLeFhiVGd3UFdmK0Myc3NQUkNXSWJ2V3BpVTd3RW1y?=
 =?utf-8?B?Nm13aGsxZDh6Tit4Z0RRSjRjc0RUWVRjZ3pkYlk3NnkyY3JsVXhYT3R1TFQ5?=
 =?utf-8?B?YVVIbEZUWm40Y3o1NFZtdS8yWVYveGdTanhXZVFPeU1ZSFZzMXY3UFRYZWMy?=
 =?utf-8?B?aHI1cnQxTGREMWpXSHhaYlEyQmJkMllpRkRmbUpndVdDdjRrT1VpYlRVQTBQ?=
 =?utf-8?B?eG1jWG82dElVaGNOSWlLaU42ZjFQZUlPNmNWdEhLUTR3NHNHS1NJK0dTV1hY?=
 =?utf-8?B?NmJ6UVdKNkpRZFBoTDRHY2krcXcvbkd5c1ZXSlR6WjhEYWtmN0tGYnBSYW9N?=
 =?utf-8?B?TVduL0tFT2xUVDMwdHFJTlhJbmxRc0VvTVpNbFZYTnoyZE1lb3RTczFYdnB5?=
 =?utf-8?B?UDJGcDhSNmE5eWFDVjd3aS9LQnR2R0NtSFBuaTdocUR5Z1U5ZWhKSDRDbG1h?=
 =?utf-8?B?ZDRyTWhiMTVRT1M4YlJxMGxlbXY2TDBaSkFzMFZSalBLS0JiNzlZVW5JRTA3?=
 =?utf-8?B?dXdmYmEvQUFnZFprS2lrTCs3SFA1Z0c0QlBGM2U2Vi9weUxVWnBxUEhveUF0?=
 =?utf-8?B?ZllrSmlySDd0WjFyUUwweDlKNDNDSzFvZ2JOZzFmVGJ3UlB5WlRaUDJiT3c0?=
 =?utf-8?B?QmxZNXpIZnEyNWdZbWp0ZkFqaTdkVll0d2duSG9pY2FIQ2hnOUxyQXhadEgy?=
 =?utf-8?B?SkJZQ29uMVV6VEh2S1k2S2Y0YmxmeXBqbDJ2UHhtc1lmN3djN05POHQyTi9I?=
 =?utf-8?B?U3NtVFRTRkNJaElHYjBtbkNCaTliSThwSHAxNzQ3R1l4ZHBVTVpvSVNHa1NK?=
 =?utf-8?B?M1E3dVVNTnphdzVJWEc4a1QzQkpFTXJRRkdWOUw4MTY0YUlZMlM4SkNhT2dQ?=
 =?utf-8?B?RzBkeWxGR1dhTnhnVTRhdC85U0hUcytmTDR2b21wNUlmbW9HSFh3ZlNsbUVw?=
 =?utf-8?B?czg3bUxsSVptVWk3Q1hZSitlTFJXM2xFNVE0SDQyWVBBZ2dDQnRUWDFpemx4?=
 =?utf-8?B?bENhNEVZTVNkQ1BIaldsaHAzQlhtY2c5elgycVNrUUN4Q2NjamxnVkpFWS9N?=
 =?utf-8?B?S0dFL1ZPTVE1SXVra2VRY014T3pPaXMyNzFBNktKMmNMbm1OZzVuV1BHVFhw?=
 =?utf-8?B?NEtFdjRkMzkzZWkwRzZjZGJiWm1SUFlDclkwd2RjV3BHaU5MdVpYM0JTSGFX?=
 =?utf-8?B?b0tsb1U3VUgwbjVxRi9UNVdjSzk2enRsU01uWGRJU003SXZaSktqYldKVitn?=
 =?utf-8?B?VHo2R2R4MVZoMTJlNHFNNzEvY1R0YXpqNVBOamlndjJ2SlBkbFpzcjlVSy95?=
 =?utf-8?B?Y05pZGZMQkxqOHpabXlsVDRlOXQzRkgwYkdlK2xuOG5HQVZMM3MvZW90OHha?=
 =?utf-8?B?a25pR2JIdXlvNEJlS2JQOFNIVzArWTFYbUJGYlVVQnJPN2t4MUx2Y3NDRlNB?=
 =?utf-8?B?L3RadkRMSmVrOGhWSU83d1MxdnNYeDNQQkNtdlUrRlBMM0FWd2hwVDBIbG5h?=
 =?utf-8?B?TkhiOG5DeVBvWndGWG9GZkF2U00wK2tMeEJROGtGQ2FrMC9LbjJ3UFNpd21J?=
 =?utf-8?B?N3ovakRzQmIyNE9LME1YTHpVNkdyS1NncTBSODJ6dGFyQlFRVm9hUWE1N0Jr?=
 =?utf-8?B?aFVOdXJHRzhmNnhCRlJ4MXpJaW10WWtVb090YURIUFNScjRqMnBRYUIyc0l5?=
 =?utf-8?B?djQzTVM5WVFvT3EvZVpzMUJsTE4rc3A1Q2Y0UmdlcW9wY2hmc1VCNFRzUzBp?=
 =?utf-8?Q?aM+INbuRxa3gELJHpj2k8tzYD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5809868-13f5-4f53-3e85-08dc8bd1c837
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:53:50.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbAFAJ36SGPHQjC7qQjDw4/4Z/OK9+I/9Pqxz0F81il7Rz/SBBmgbA10dvLDVPQ9gyE8njZ12mXeZCE77PMmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

On 6/13/2024 02:25, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduce AMD CPU frequency boosting control sysfs entry which used for
> switching boost on and boost off.
> 
> If core performance boost is disabled while a core is in a boosted P-state,
> the core automatically transitions to the highest performance non-boosted P-state
> The highest perf and frequency will be limited by the setting value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1e0d101b020a..bcc0d9404c18 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -440,6 +440,16 @@ control its functionality at the system level.  They are located in the
>           This attribute is read-only to check the state of preferred core set
>           by the kernel parameter.
>   
> +``cpb_boost``
> +        Specifies whether core performance boost is requested to be enabled or disabled
> +        If core performance boost is disabled while a core is in a boosted P-state, the
> +        core automatically transitions to the highest performance non-boosted P-state.
> +        AMD Core Performance Boost(CPB) is controlled by this attribute file which allows
> +        user to change all cores frequency boosting state. It supports all amd-pstate modes.
> +
> +        "0" Disable Core Performance Boosting
> +        "1" Enable  Core Performance Boosting
> +
>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   



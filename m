Return-Path: <linux-pm+bounces-8965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179B9043FA
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820D72824EA
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C087404F;
	Tue, 11 Jun 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yxpu79dC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149629429;
	Tue, 11 Jun 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131815; cv=fail; b=fTxrU+itIBXxcTUi2jpjGqsu8d/9gNVfy+Foo8CicMLPU9asFnrKnaCYuZpw2/HDZjwW2GFkcIYNsenOmKMkjYDBYzBcq4VfcdC2AC+SSSmjbEGSKIqRxrVcK1sm4tBWU1lzv8CuX+Ti1/Q2zR9MONa1A9ER50npopclhNGcxYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131815; c=relaxed/simple;
	bh=uibNdJ89+jvEo59bkIbrJUdIL1oJRq9YXa3BevPeVRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RxGgLojhxxlTDkyN6cVPlXsdhrEigUXmEzKntO15sh3bCQ2nm50D7zs9YKdzeGqgQ1aPfNWbur17KVkF6xL1iYx1VwtulhGpR+mRj/NhgSVy+gt2kqqRZZbAU1B38B+KLAVMjr1t1bmPOE2XzLuJ4i+8eFCnve6AKTpz2h0BUwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yxpu79dC; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7wGkI1BwAuoWnMzEOZx5TiTMQgtdP1R8kJ1j15l7VsQ9RLUccebBV5e6bWV4UAvY1wVJuwUNJ92DMu/I87A8L9Sodv82xCEnq0pwdPfQu6TdaoN9B9toCroO0DrmTLybLhlG1ToOBst/D78toPi+JhVr17Z3rXRFqb6WrWoFqboXbSPgpzZ/LpBJTJ0657tySkaPHdw8R0aj3Oi6Yj8Mgu04IJNQR/7TR1Xik3dGGIUFpnbrrQUa5lFn+K1uh+98xxY5E/Yv7DiCoD2Y313t9MciFay5as/jC827R70APxRtmwLHkZXQWCA7rcAt2IRp182meRnwdPjN1HdIGt+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9gJFHDjOqSxzAdACGtThs5tiVoIARL3x3gACY3bsZo=;
 b=bEPE/D2VO9qIPiIXl42dcjo8hUco9H0MMLXVCeiQD7Fl9uda/KEFC66CougVm1ybwCIURZgSxofP3HTeND5GT8HvaCTkbjeKjCByrr6RTW9GaUvNPa1IXt7o129M4o7H1i9Pu4Eb3V51GyqOVLj8BOI9/KMnyGOhipVIq7bjN3U4CNBfXM8QsNSovKR4pDYS1gVimPU1uINPRNdCeyb7017OA/PEsbY+Kj4rA7AVOZUOddKItoYzvJ5LthFSyjlwqDuZIH4Exa9kRbROn1ZQnk4R+Ug8g1vwuZOqUf/JVpWK48N1acmAjEfhC6obvfvWJ+1rCYHQt/g/Qar5teL1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9gJFHDjOqSxzAdACGtThs5tiVoIARL3x3gACY3bsZo=;
 b=yxpu79dCc3pwADP8oX+aUNH0U7KtFQXou8XeG65yF76VipHSvDY4L82BQpR/muRru889qauS8/hmk9vcAGg9Sj1lbOflBzCokk1l/H5wlto+wRwpr0polndN9sTUhzc9QVaNJRVNyMLbV1gbTI9oLuoBSORx4gR+SCFCt71O8ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 18:50:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 18:50:07 +0000
Message-ID: <7e24a4f2-5f4a-4ed2-ac98-d60158e8e461@amd.com>
Date: Tue, 11 Jun 2024 13:50:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] cpufreq: amd-pstate: show CPPC debug message if
 CPPC is not supported
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718095377.git.perry.yuan@amd.com>
 <41d5573ed19525f95d79d2af46bd1cce5779d6a1.1718095377.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <41d5573ed19525f95d79d2af46bd1cce5779d6a1.1718095377.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:8:56::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 0853f7be-8bfa-4e7d-8494-08dc8a474ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFZQc1dEaEtEMGIzWGY3bFNqQ3JpSkorTkRGd24zeG1CRUc4cFc5SzhteTYr?=
 =?utf-8?B?TCtGbkFnTW50Tm5XY21DaHZmTDdUMXMvWTBQSW51NlkzMjRTVmdobXlJb1g5?=
 =?utf-8?B?eDcwWnVGQWpLeVRhTzRnZUxRM2E4QlRhRWNxUVI4K1owQ1ZidG5pYmJURFFE?=
 =?utf-8?B?Y09qRmtJMjM2SkNjZU9JMVZsRTRDaXlkbSs1SWFYbFA1RVlSeURXK2NUTXp1?=
 =?utf-8?B?RGltaWdRSnNHTU9MOGJCSDEwQVdyTVR6Q2Y5MVp4OWQvcXJFdFBML2tNR1I2?=
 =?utf-8?B?OXVMMjN1eHkzbUpQNkZwcHM3RU0ySWpTYUY5M2pucEZRNitvV205bGtSUjEz?=
 =?utf-8?B?Y3pJbjlkQXhPSTF1VEg1eGRQVEl2KzVVN1lUeGtKdmRteWR0ZGJ1Yk0rTlp0?=
 =?utf-8?B?Vk1SV0t2TEsyMmVSclRUM3RodnJERmJYVG4xQnk3cjl1ejZHb3dJSHgyaE5v?=
 =?utf-8?B?NmpWci9YL2IxMVpXYTNiZUQwVzRJK3AxTjFjM3ZYS2xsVG05MitzRTF5cG13?=
 =?utf-8?B?eXBlVWpnU0RKWmV0TGRwZFpXdDJ5RU9jNnVYVVZacm1iQkZjaEo0c3lZYzY1?=
 =?utf-8?B?ZFNscG5raWJ6emV1a2pOeUd3WHRVcnROZW9EbEhEUHVmaHR1Wkd0bEhUVXpG?=
 =?utf-8?B?MkdIMEl3TTgxWlhsek5URmlxcmZ3Ujh6aU5tb2pNelI2Y21YSGtranhuK1Q1?=
 =?utf-8?B?KzdMK3hOL0daUDJiVFlqRC95Z1JZWlp3bkJKSFFqRzhYVzR0bExaYXFINElB?=
 =?utf-8?B?aGdhYlNidzRpT2ZQeDhyUHI0U21TMndQbkVzL3QwQ2kzR2Y2YzU2Wm1GbnRC?=
 =?utf-8?B?c2pJdm9KV3JhSTBVMHliS0t0Y3RRLzFibWlDR3E1azFtSldOV2pqRzdNYS9z?=
 =?utf-8?B?Njk4MUMvamprZEpuc3F6enNHSDlHajhMcWtYM2ZMUWJvQ1ptWm5QUFNJZDVk?=
 =?utf-8?B?WFJZaW8xSkxCNnFmRkFZamoyQTJyQWM1ZWpJUUkvcGk0Y01KTTNrcEljM1NY?=
 =?utf-8?B?cjVvWUhEU1ZFS0I5dXRER2tkYm9nZzlSaHlxVjZYanpiekRHc2V4Y1FNR0pM?=
 =?utf-8?B?NjIrdkU5aUxYanc4SENTSU54NDFiNkJLak9zUGNZeHdVWEZKZVRuR0VGTmxh?=
 =?utf-8?B?dnI4M2lEV0NHZDBWbUNheERCVU9ha09IQU1zeFBvb0lqSDRoWHp6Uk14TS9N?=
 =?utf-8?B?NVVLYWk0RDhlUmIvaGFYWnc0aFpXL3djOHp6Nk9VcEtLQklwR1NVbi9qaGs5?=
 =?utf-8?B?M2J3UU4xYVhWRm56NENBUDYrY2R1RUFiTHdvWVZOZkFKNzYxUXhSZDR3dlBU?=
 =?utf-8?B?MVhHdjRZc1ZCV0dJSEEyUHBXZDRzV3lTQm05RzUyR0dZa3k3aHNFaE9SU0tx?=
 =?utf-8?B?MXZvT2toQnF3cForTXFRVU5WUmNqd1VjR0k5QVhpQlcrSm9RUXllVjUwTnFq?=
 =?utf-8?B?R2o0eE9JOVNydDRUNE5DREQxODVZN1gwRTBkOCtxMk05Wk4xSTg1OW1zdU9N?=
 =?utf-8?B?TnNrNjlnOFBBYU5pUEpEeDI0UHVsdG9tRFQ4d0FHLytGTDRZTzUvZEtRWUVm?=
 =?utf-8?B?Umg0Q2xoZHlvVzJGd3lJcUxQSXRzNGRwem4xTzcyVENTd29FZHJjVTd4VW5N?=
 =?utf-8?B?UHJpb0J6WmZhZkY0VXUySU1jTks3OHpqN0NtN0l0cGMrNStXbTkwUUJ2ZExQ?=
 =?utf-8?Q?Ywv3oUSfhg7kOJN2yAop?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUpPVjRlZzBnUlMrMWRReXg0Zmd4WWhQam1uSmpzb1lFeCtWVk5yditSSFlu?=
 =?utf-8?B?UGhGLzBGZ0RYeEpXN2d6N3RqbVhUbGF6TEtYRVdiQS9WYW1obmpSczlMd1Jq?=
 =?utf-8?B?QnJJN0V0eDJYUDFqSkRidEZEQTdydmJwaS9MYTd3S2Q3YWl5aWpiNmJlb1FC?=
 =?utf-8?B?V2tYMjdpKzAyZ3ZlV0wvSSs0cEllNmpIUEdIb29MSHNTREttUWF6QzcrRURQ?=
 =?utf-8?B?R3hKVy96dUJnNE9heU9iTFVKcmlreWdwTnNiUER1d3h2cmhIS01tWWNNaElx?=
 =?utf-8?B?OTdRd1IvNW51RHNhUEJkdVJqb3JLM0hxTGhOYmdUcEZvWVlSMHZpQ1BaUjc0?=
 =?utf-8?B?TzdLNnh6UXhIYVZBbFJqVDhKTTdrSDZHZXlKMnMzN2VPMS9LNytZVEZVckxF?=
 =?utf-8?B?N1ZvTzRqOVFEVVdIUzJCZzBqS2RkSkEvaEpaWFI5czhWZVBRUGJUanZnMC8z?=
 =?utf-8?B?VEYyMHVwYjIyWmU2Q0RmdU56K2FFbzZWMHdvVHFSSkRpZEQzQmF4OVRsVFB2?=
 =?utf-8?B?Q3BDclZscXVtaVA5bExIWGR6SkxGSWE5R2kwdVRuRUlrK21sUFRBUTJVSEcy?=
 =?utf-8?B?MUJyakNNTGM2MFhObjJaeGxEME96aXk3YWFpWFdlbE12RHdzcXR0RDVYS2pV?=
 =?utf-8?B?d2JJdDRqTjJaaEhFa204YjJwcSt5VFlYSS9yYXRBQWlrUDA2OUlZdjFWR0pH?=
 =?utf-8?B?akhDNU9pbk94TGpaL1hlOE55YzdOZmF4bHJRVDNFV3lHUW1xVGRVVmR5VGJm?=
 =?utf-8?B?d01IU3paa0lwU2d4TnUwVUZsVEZzVm5BdndrOFBCbjd0Y3NWZWZvMFlCMjcw?=
 =?utf-8?B?RWhURllwMnJaR2dkY1djY0gyeTJBaExVSGRrT3N2Mm1jTFlMSnhNOWlZK2NW?=
 =?utf-8?B?Wm5Pc2Y4bmp5RVB2dzN2RUpRVWoxV0xZUnoyT3FMT1NWZ05OaWhTTjUvT2h1?=
 =?utf-8?B?bTFIQmpkNXRKNllTQ2VHUUZHTm1abTBnSVJYUGdyNXZ5bmFhS1RyTFFHNzM3?=
 =?utf-8?B?WXppQ2xjYytpWDkwckJkb0ExUmpCRnY5d3hhQUN3cGFOZXRRNXdSOUVQcEZR?=
 =?utf-8?B?THJlK3JtVml4Z2dqSElNV1BOV3ZJRjN2SkxKb2VQZmhJbk90UlgxZWUybkx5?=
 =?utf-8?B?SG9rSjIyQk5pOFJZTVJYRks5SDFPaEVNKzRoM0VicjVJWXZMSGVQNW1iRlpS?=
 =?utf-8?B?SlpsbEtDUk5uZE0xSjF4Y1JrMG56K0pGU0Q5YzR4UFltTmo4bXpQbUxsVy96?=
 =?utf-8?B?ZTE0WDQ0QXZUYmtHSXJtOWZwaGZDdTBOZm9ZZ1RLUWNBUElNMVFpZ01QT2I0?=
 =?utf-8?B?VEZZY3FmODRJZzBsK3YzTlk4WW9GSWFLY3lvTFlibFoxaGZlNm9xSC8wY0hu?=
 =?utf-8?B?OHZCVVFHRERrenp6WjgyOFFjL3AzN29xNWRRS2dHb2R4RUdUZFlpKzFTcW8y?=
 =?utf-8?B?Y1ZtaVBLejhrSWFlTm5nWlNVNHNSZ1I2WnUwYmQ5NW53ZWMyWmg1VVNpV1Nv?=
 =?utf-8?B?SW5Td0t2bjVVZEFFZlpjVVZzM0MzQzNGb0pMcTZaeXJVdkhPbHRoVHBMRkor?=
 =?utf-8?B?KzFVMUhLbEtsZE8rT1YxbWVaVnZvL3V1eGwwcmNhMXF2ck1ZdlZsbjNCUzY3?=
 =?utf-8?B?dWw1YXVreTc2VEJrRXo4V2ZPbTd3L2pmZ2lWb2tQcjRCajhhWlZxeWtNb0xR?=
 =?utf-8?B?eHpKYUFKWHVlMUFNeUg5TWsrVzM0U0ZScnZ5ckdzU2hUcUZ0YzhZbkFUeGRQ?=
 =?utf-8?B?NndNeENvVEs5MG9zbGhUbExGM0RyakxQUnpQYUJBaE1pczNCTTNzQXc3cU1P?=
 =?utf-8?B?N1B5bEI1VmkrTmw2aFVxSVAwVHNJL1FMUCsvMWNRWW5EZzczZUg0a1pqdWVt?=
 =?utf-8?B?enl5WG05MmhOa0ErYjZOcjRRUHV4Nyt2TUNJNjMxRHZDQWdFcWgydUM4eGlB?=
 =?utf-8?B?NisrOEw4UFJ6RlkxUXQyRHdBaitTRGUya0JCdWNoOGhlKzZMd1FtS3FMVldw?=
 =?utf-8?B?N0VOUEdyeE9XV3hrR3RKakFDOCsydUNZaDNDRVJLWVhwViszb2VzNGgwelpW?=
 =?utf-8?B?NEc3OWcvalBRNElLczVXT3hJdDZFWFBRUHc1RitoVkVqdTlESFU3Y3h0am1q?=
 =?utf-8?Q?PQzguZp2Uo9M8LLFlsDlaAalI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0853f7be-8bfa-4e7d-8494-08dc8a474ff7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:50:07.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V3YWjKYWLNdmrJiKkyrElBabweqTvjmhxQwMfsLvn30ZoiyMkgs34XqzPcYvfbUfNccyVtftssiRSX69JVuFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

On 6/11/2024 03:52, Perry Yuan wrote:
> Add CPU ID checking in case the driver attempt to load on systems where
> CPPC functionality is unavailable. And the warning message will not
> be shown if CPPC is not supported.
> 
> It will also print debug message if the CPU has no CPPC support that
> helps to debug the driver loading failure issue.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/linux-pm/CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com/T/#t
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 36b1964ca8d3..f166b3b94091 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1740,6 +1740,20 @@ static int __init amd_pstate_set_driver(int mode_idx)
>   	return -EINVAL;
>   }
>   
> +/**
> + * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
> + * show the debug message that helps to check if the CPU has CPPC support for loading issue.
> + */
> +static bool amd_cppc_supported(void)
> +{
> +	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
> +		pr_debug_once("CPPC feature is not supported by the processor\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int __init amd_pstate_init(void)
>   {
>   	struct device *dev_root;
> @@ -1748,6 +1762,11 @@ static int __init amd_pstate_init(void)
>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>   		return -ENODEV;
>   
> +	/* show debug message only if CPPC is not supported */
> +	if (!amd_cppc_supported())
> +		return -EOPNOTSUPP;
> +
> +	/* show warning message when BIOS broken or ACPI disabled */
>   	if (!acpi_cpc_valid()) {
>   		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
>   		return -ENODEV;



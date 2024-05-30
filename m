Return-Path: <linux-pm+bounces-8402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B98D453A
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D47285B32
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6E142E91;
	Thu, 30 May 2024 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nBCFXpJ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19010000.outbound.protection.outlook.com [52.103.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D87F;
	Thu, 30 May 2024 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048955; cv=fail; b=Ks7D5JJvuZfNkJ58X1vVid7/4roqYu/1l+LN+BlmktR0WCMd+5GNRVEPTSAgJ17C8z2xbP+Jhz7qtZ9hWUXmfssytVGNvZ7x4LDTusXALeUiuf8XL0TU8Oa7vXTVWSKI0J5XXEj1wJzgopwgyXU+LWUKje+HXDnaUC206XK6Px8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048955; c=relaxed/simple;
	bh=6eIdCJ3vMatjxKK14aiYRGsKPzF5/1ui6hCgcZZUGrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DcIh4iTMboezoK4k77MmdL769cyxw6AwPIeuwUuLXmIli8GnmWm9EAKx0ef9MlfhUfRyDqekVZJ7tpbXhUJ9RoV6c4yMjEkk5Ur79ZhV9UsB4YwLrqBhJT3fXJ7Krf5mBg2TzmesnsV8i9y8S6PHt+WCC8ZK1tmQ2uWPTf9NP40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=nBCFXpJ2; arc=fail smtp.client-ip=52.103.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knqKES//as6y3efAPneO+U0YEfXl51G5dYLurGj3SFxU5Pd3bvqYsc6Iv4+riEmumhfZfpLV25dSPJv1HIr/t+y39K45/DIWsEaRUU0XxFU09yToAsNQYrhtz8jSVG+RRcWpwpaQx/U/eIEU7oiueMUvPDic3+rmiJHymm76oO0esBoZ2SSYV0gGof9j+E+etOC/aE+uMboI8eeavPDWikP2qkYqjYkj0OFFKx4EKpUTbYqi7qNJ9FKF5CBzCj11vN7BJrApKFIABVmSg9e/p7TdM05xJwcfUuH8Oy8EXye6P0YdeeprYEDa/JfU2eREOrtYDb9PdZceON4wkl8wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8Ry2GjzNhI2SSeNr7WpYtSpsHmrEg0+7ITkxeulUI8=;
 b=b5DXoDKoKBkv9CaKjmthj5fWTY70G60dZ0ygUE8hU1/SlXv4gzTgtCGCiSupuwt9P59ho7c3c6LWUiQ8Jqyk7MsTSy+ReXBAPNiWqTtxOeH//e8X4lH6Ob8AsPFnRZ8QULJ3lp/pZCRIWqQ0DoN/+T5Vmvsgz6ZMtMmEKSiW+QjydUaKWWtZjTWJvwl4uslB9vTRvA7XH98HIzeAKI5jJr1JzpsuE0TpwmlyrFDBxlFoKb6Bhykmk4uslqiVgIBadNh6qauYFUIbDXO1KXPsBgikrjGD4v6bTW+MSu8wlZjlU4ycxIPJL4mkjNCB0zH31Ec5ioGbjGIZ4xVBfATyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8Ry2GjzNhI2SSeNr7WpYtSpsHmrEg0+7ITkxeulUI8=;
 b=nBCFXpJ2rKqlSE5UJhBR8I1qU7/CryOhc/qHxObhXgqbqY94CCeplbtKXY6iZA1QlIHrHFjQZWbnVsEbWW8zIq89QFjF84o1xs1DWw9nthRrmnNdnt+WdTDdQqVaHDe7OMISo4lmTPxl+pLY2noyy65YLDOFSxwn5TKq0PC+Ay8muwuxbLJ0Z91HbD9iZ6gurCXRUIu7Rp8M+39qaoGQcx5FfJUW3hS54iQyB7DvnDjraixOSzS8oOk1Ffm7FVPw0gl84xXWRiyjuH0nP/4xD3+3JL3VM8BO73HalxlvgyFNaCx6miIikY+KCFsqr9DFWadXB7XEKqMAPkAO4djD7w==
Received: from TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:221::11)
 by TYCP286MB3469.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 06:02:30 +0000
Received: from TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8048:573b:c353:1c19]) by TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8048:573b:c353:1c19%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 06:02:30 +0000
Message-ID:
 <TYCP286MB2486A0F14AE38F83F425F506B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
Date: Thu, 30 May 2024 14:02:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set
 target
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Ionela Voinescu <ionela.voinescu@arm.com>,
 Beata Michalska <beata.michalska@arm.com>, Hoan Tran <hotran@apm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
References: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
 <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529071244.vwognqagaa4347dm@vireshk-i7>
 <TYCP286MB2486B1D734F8E2D74BFBEEB1B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240530055624.quutkzdd44l3oevc@vireshk-i7>
Content-Language: en-US
From: Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <20240530055624.quutkzdd44l3oevc@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [afbJbm7FL3RkMarN3tZq0aAJdnysEj/V]
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:221::11)
X-Microsoft-Original-Message-ID:
 <f34b92cc-3a9d-4ac2-babd-432a76134118@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2486:EE_|TYCP286MB3469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2177562b-3652-4fd0-d95b-08dc806e1728
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	PyDngKtH03yQPyHsg+ssk2hUiy1YoiM8Odt4I2esCmvrQMDd5IjciHkCxqVUUkgfYyKzJb8jH2J3RNTZheHFYgtgSNVcvNwhiLTDp+MLEe4XWhUR5jCqjZV+D5WF4DOWAIBiLzIN0YBzI4AJvIq8x8rJTsxRmMCopLKzrtAgi2T1iUpQk8hCCX9Ka70BRQq9iYqCOk7gTwZvNkfgTd98yODJzBzi3MJaN7TBjMVK2Y5LCdorjfLnEocj5oChGgeg81syrVPe3xiRHWeUPAVH0Oz9c/vA/PF9sSeH3Q6irrj1C2QI/AZDXKSmxFfkSflQGdvCA/NcqJtWPJUg32B6rommZYl6Rc9yHA/DSzyJrIJ5wl2xhENZ4/LHBcke9uZUtBkYoSTiybCNPxdGwGVGuakC1DqA/YiApkIqrABHUIwYV+dcnde24qypjQhELM/T+Q+A/37ldtiRyUzoK5MCfrYlTKhoXO3F3tsw9RVWcWesivYaL1VVfqRvkmSFNQWVvG4iJHOjKtJmEgJARWtqzx4nh/HyCs4+oljeKqB8pyHe3id5wiYTLtVa0+VVFo+o
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDByMVRxM3I1VmxzWkk2WHRIMFZ5My9BU3VsVVZxRHRJd09MamJnd1NvWUcr?=
 =?utf-8?B?S21ieHB6TWNySk84a1BlSTRxTnltOUpmWnB3OFZ5QVlwb1kwMFZVZTAwVG5J?=
 =?utf-8?B?cVhRand1OUlFaEo3aThXQ01yVjFPMXUrT2hRMVBOS0phekpoaGQ1V25YZ0ZD?=
 =?utf-8?B?R1ptUmRzVVNuNHh4dTFpUUxnVGUwUURrVnF3eGFpR08weU4zb1dqMlRBdzNV?=
 =?utf-8?B?MjZSZ3lTRHJqclJqLzJsd3lwUHRlSGJQdFRsdVRyOHdmS0VhZ0N0b2xZY1pY?=
 =?utf-8?B?aUFZcUxqSXZ2Z0dXdW5FRGsxWG9MMnA2ZTUwM3NIanQybGZvRU5YYTZLa0VL?=
 =?utf-8?B?NTJKcmZLNWxTajZ6bHlvK1lSQkh5aEtjZjV3cFNpNUg3aTdXVVNBZmhKTTQz?=
 =?utf-8?B?bm1qb3ppNTZtQ1h3Y1J4b3RyeTdCdklGdnFPSUV6RjZnVS96OFV0cVVJbHV0?=
 =?utf-8?B?RzNhL1pwSnVHbmUwREZkSGJQbGN2SWFTN3hoeG5RZEh4UFpkdFAzS3hWR0RY?=
 =?utf-8?B?cVV4SG5MV2ZJOXFrR1VseTR6bVgzOTVib3Z5eVpzbUc5aWRHTWpYcFcvMW53?=
 =?utf-8?B?MERvdFlJMEc4TVJOeEQyNnMzWCs2Zlo2YVg0RnZkdzcrRWpVaU9jdE4relhs?=
 =?utf-8?B?dWtvc3lHSVVuQzZLOGpkVENOc3NVZEhNNU4vdGpSa1dYVDBNbkVzSzdqcG9S?=
 =?utf-8?B?Y0lUSHlMakMyNmtoT2NKTXZrQzFoUGZDTE9GUUtFb0hCYmF5cHJNK1hoVGU4?=
 =?utf-8?B?NllMdkdFL05NU0NuNlR2K1cwSzBxSnU4R3lGYjllNm1RQnF5Y0ZvbE50R3A1?=
 =?utf-8?B?b1RlRTBWNEduNzBSeE9WMGZvbGtpS3p5YmRSTWhCNlpLVGVnN2p5STlNT0gz?=
 =?utf-8?B?em1pZFowc04zWmJjdGJPZFlzVXEvRkw2ZVJPOUdUUHpqT2VoUy9rNkV3Y29T?=
 =?utf-8?B?SExkL2ZTZ2wwekpsMDhjM2FvbDQ2NWZjbFZZWVNZa3p0UmRNaGVxcTFJdk5I?=
 =?utf-8?B?U1l4M05lSGlaZEpDRVVGTnlYMHFiMFdLcGRySXliallXNEt6YkpJNEgzZDc1?=
 =?utf-8?B?YUlUVEM2UGVqYW5JR0JJOHp5bVQzQzlLUVVOUWlaVW1YOERzV1ltd2VXWURB?=
 =?utf-8?B?V0t4aitwMFhBc3AzMVpBelQrelhlYXo2QU1vaUVIZVd0WHNrVUVocHZXRUFs?=
 =?utf-8?B?U2dJOWlZTnJQQnY2WTI1OWFFQkdYRFFYM2VseEdUa1hoTHo4aXpDSkgySkZv?=
 =?utf-8?B?U25mMUt5cFd4WE5NRFNDNXFLSFl3NHp5UlpLaENiWTRrWEtPN3hkdy9UOUdY?=
 =?utf-8?B?STYrUEJYSTFEa3ZpOCtxZXkwRStmaExPUG43UzRVKzFXVFY5K2FQUlgraHQ3?=
 =?utf-8?B?L3NRYlZkemJyYXdCMjI4dlVOYTZHcUpNZGg5YzJzYmd0cTAyRSsyUnJ5Zi9v?=
 =?utf-8?B?L3BneE90VkRqazJQRWRBMTJMR2J3ZnRURTZQdUttalNWOUxFYWF3RUFVZDVR?=
 =?utf-8?B?UFM0QXArQVBDMFZmekdlT3haL04wczFwcHVVbS9aSnNxQ3YxbmNJUFNhY3pF?=
 =?utf-8?B?c3VnYklCbklXeHMxOGFpRC9PcExZVGdtUDEwL1k5S1BaT1MwU1d4c1BYNlZV?=
 =?utf-8?Q?yDdBdoD75TzTRZBOWxFI19LRG0v66ZegBiOPHQsOK4pE=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2177562b-3652-4fd0-d95b-08dc806e1728
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 06:02:30.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3469

在 2024/5/30 13:56, Viresh Kumar 写道:
> Cc'ing few more people.
> 
> On 30-05-24, 09:06, Riwen Lu wrote:
>> 在 2024/5/29 15:12, Viresh Kumar 写道:
>>> On 29-05-24, 14:53, Riwen Lu wrote:
>>>> Yes, you are right， I didn't think it through. In this circumstance, the
>>>> policy->cur is the highest frequency, desired_perf converted from
>>>> target_freq is the same with cpu_data->perf_ctrls.desired_perf which
>>>> shouldn't.
>>>
>>> Please investigate more and see where the real problem is.
>>>
>> The boot CPU's frequency would be configured to the highest perf when
>> powered on from S3 even though the policy governor is powersave.
>>
>> In cpufreq resume process, the booting CPU's new_freq obtained via .get() is
>> the highest frequency, while the policy->cur and
>> cpu->perf_ctrls.desired_perf are in the lowest level(powersave governor).
>> Causing the warning: "CPU frequency out of sync:", and set policy->cur to
>> new_freq. Then the governor->limits() calls cppc_cpufreq_set_target() to
>> configures the CPU frequency and returns directly because the desired_perf
>> converted from target_freq and cpu->perf_ctrls.desired_perf are the same and
>> both are the lowest_perf.
>>
>> The problem is that the cpu->perf_ctrls.desired_perf is the lowest_perf but
>> it should be the highest_perf.
>>
>> In my opinion, desired_perf and cpu->perf_ctrls.desired_perf represent the
>> target_freq and policy->cur respectively. Since target_freq and policy->cur
>> have been compared in __cpufreq_driver_target(), there's no need to compare
>> desired_perf and cpu->perf_ctrls.desired_perf again in
>> cppc_cpufreq_set_target().
>> So, maybe we can remove the following logic in cppc_cpufreq_set_target().
>> /* Return if it is exactly the same perf */
>> if (desired_perf == cpu_data->perf_ctrls.desired_perf)
>> 	return ret;
> 
> This is what I was thinking as well yesterday.
> 
OK, I'll push a V3 patch.



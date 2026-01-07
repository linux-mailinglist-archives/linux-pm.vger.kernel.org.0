Return-Path: <linux-pm+bounces-40346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F329CFC038
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 05:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2708030245F7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 04:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFD1E0B9C;
	Wed,  7 Jan 2026 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ia2gC+FF"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFE35959;
	Wed,  7 Jan 2026 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767761402; cv=fail; b=SN3/MrkBOnUzdBbsgpp6frA3M6xsDt1r/lsGeimq6HMjepS2NxIWRgEF3fGxg7uM/v49nqsxSzv5ilaWavD7S9qs7OQ4/lE8jS6ZNS27+S16ALhQ//RkRsaMeI9UL72Zus7/IuIQKoKEG49cBqCCgfxkWiMXaJdwHXYphNCNDxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767761402; c=relaxed/simple;
	bh=86GoidyRphMvMHa0O7J2LWiaehFVu+ZyC7seA3J9qI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DTo6UlUeL0PFgHlLsXoOexQKIR+itE3g5JSBuGPenjXCEjlgmis/LXAwI49yxjGvVevpZw99Dc8/0DXkT55Sf4u6KbxenLcXiU/FzXLgBT7ahwqaorXDVlN9zjBCgG3hih0htXoQwR+8+g24jtM75XD2XibowCV1U424G5irkEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ia2gC+FF; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWEbu9u4JkPsCfvfHJMsWv8mcoQSJvhzQKqOoXln4toL35PKGBo2Uf1R2bmnqx84fGbij1j0hDN5EguAX8lVTQGtr7xdKEddJgSyCPRu5EAAhIe98Gb31wpndwTn6abk5WcTJ/e+YHzjaiow9m5VuYCv+U6XaAxM94QHSdR6VQkFemBSx3mzAWkhZrJRkxOK8UcvmH3yAo4KLWPxsONwnkkWJdIeyX4AXnh/ayTXPjTxVD5EuMsj+7DxAqqvyBwfCXD3mluqu3blWB7GszU8GoMYIs4FDwVta+uUgAnog6sZUzb0DpNn77JCtu19VOfnY8Qt4vDR4eRr21F1ilMf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq09EMj1mLc2gaeXQ30D9i8Ed3Tpkr9ifBblmLPs+J0=;
 b=mYCmO8nhKJ8UJJc5uC60qF2YIBfPMzYXmuhSI3rHwzrSQYzLRoOAyeMlBWY5kqs4UpT1vkBMZqO0hRhEtzP7cIoisQ2Xd+jh6rTAlhAUwmB6LE6irFcDRcjqGo6qbX5yxvNn/Spl0gDTMoBPhm7AIX6R01K+xl/JShs5iE70owPi0/rOZZKq0fZI4XVMpIDhbDGYq0dE41TNfNONZzt8hMvKzvg+zMnlNeovY9f8MlF05ueLB6PCxxol6BTrkoezhho/wp1W6iqn3QfltFSMSfWH5kzK6tVeKy87Rryt3ufdsKoTfXlJXTWqX6a9afXtQPgmvCLDLRUamgjHSMMVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq09EMj1mLc2gaeXQ30D9i8Ed3Tpkr9ifBblmLPs+J0=;
 b=ia2gC+FFdM1TRV6dNif/J3FfaOte8ArFCNAnFdha4BaFBU4CMwaP1ZleMNhxiZYRLa84SlDx29Sq/l9bdXiTAUFoDLnq6LXC9mo/1+igOeySlI2YrrOOQOUjBaMDS4pWvxykARWYbwHIYggt/z6zby1gC+VEG99Cd84ST0n+izI=
Received: from SA1P222CA0079.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::16)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Wed, 7 Jan
 2026 04:49:54 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::20) by SA1P222CA0079.outlook.office365.com
 (2603:10b6:806:35e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 04:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 04:49:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 22:49:53 -0600
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 6 Jan 2026 22:49:49 -0600
Message-ID: <a29f0be2-5d8f-4585-8cf0-baabfd316e12@amd.com>
Date: Wed, 7 Jan 2026 10:19:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Huang Rui
	<ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown
	<lenb@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Clark
 Williams" <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: Perry Yuan <perry.yuan@amd.com>
References: <20260106073608.278644-1-kprateek.nayak@amd.com>
 <20260106073608.278644-3-kprateek.nayak@amd.com>
 <1e51babe-d112-44fb-96e6-8ee7c8050302@kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1e51babe-d112-44fb-96e6-8ee7c8050302@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 290a974d-2823-42cf-87fe-08de4da83328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmRsWnZoVTVuYlYySGYvdnR6V2NLcUpzUTdvMjJOYkVrSnFVMTFiME1BU25M?=
 =?utf-8?B?bGhZeWZOWlFrRk9qaCsvS084NHUwSklBSGpMbDhsV3NPMSt6cDErOEVXald1?=
 =?utf-8?B?c1liZ2lpaW5pc25GL1huWGdxOVhEdERtYlkzVC80dEt6NFozcEVhdnZXcWVE?=
 =?utf-8?B?V29MTmt1Vm4rYmI3YTlsaUdGdnh1cEZ3dDlNR09uSXcwbTZ1U3hNNXV1aHN0?=
 =?utf-8?B?QUtteHhsYTdTUTl1VVI3c2p3NzdPQi96aDRvTUxSQkRVaXMyM3pIbCtYSnZ1?=
 =?utf-8?B?Z09NZWs1amVmb0lFQWVia3kxQXE2aXFNV1J5TWlnVTFwUTNuUTlGZ1M5TnlO?=
 =?utf-8?B?ZVNRU2FaY1UvRjQrWm0xenI0ZHpaVWNXN0ZhRXZJck83YWdHQ3g0S2ZBUmx5?=
 =?utf-8?B?NE52WFJrMVVtdHI4dFViTTl3TW5LUjR1RmpBdElsazFPK240Y1c4eHBjMjRl?=
 =?utf-8?B?bXJhdm9EZFdBbXhuY2FWcTZianJTTngzNFNTT1BpZDFTdW5uSWhLQUpkNHYv?=
 =?utf-8?B?WlNWbUNQWmVlQlBGYXF6VmU1U0FGL1hqUm5KWm1oMW8rUGRZaE5BSGhrL3RF?=
 =?utf-8?B?UHdqZ3huT1dqT3ovMXFzaitZS3ZiMkgrby9Cd0dPUVY0UmcxQ05TM0tMd0oy?=
 =?utf-8?B?bUZUVHpLZkQzdnRQQ1NZN0ZZek5jU0JiRlJvRWlvS3hGTWQxK3Q5RFEwUXZi?=
 =?utf-8?B?R0p0N3pIKzNDTG02Y3JMc1hJQlpqSllkOHRmRU43Q05YSi9ZZUJCNlJENVZu?=
 =?utf-8?B?ZE00QmVwekRacldzc2liWllXYTFaNDFpaWdEbk9zbGpLNXh0a2hTK3FtbXda?=
 =?utf-8?B?aFVmQUNYQTBHN1VIMlVqakJuMndycitNVUxERnlscnkzQ203ODdIQ3RRYTdR?=
 =?utf-8?B?cVRnK1lFTnRieUUvVHlGSzVHSjJ5V0RnOEhDeXMrZ2VrTFR0UnJhT2twdm16?=
 =?utf-8?B?YWpCYTBlZGoyK2tPSnNPcWRpZUloU014WkFpZFlvaHFUZWhrd2dJT3hZVkEw?=
 =?utf-8?B?bGxpNUlUaG5iSWxVdzlWS2tBb2JuS0xMZTVOTEg1OVJaSUJmSzlnNkFMOWhL?=
 =?utf-8?B?K0pmY3psQ044N1FmQThoY00zWmlYV0RnSW1NLyt4dlpMT01HTGRRR2NvZnA1?=
 =?utf-8?B?ODlXNk14eDlsYlU3ZjJHUC8zNllUYjZzRkxxaGxpYjdwM2ZCQisrdVdCRjU2?=
 =?utf-8?B?eFo3SkFyek1ubm5hQmFpMUxpRXMvb1NWaWlYRTFwdTdWUTZOdkZJbENFZHNs?=
 =?utf-8?B?MjNUOG1mNGkzQTB3ZU1WUmRGKzN4NndGbXJ1R0FEV2t3UEJubGZlREZSeEcw?=
 =?utf-8?B?VFBXVk15bDdEbmk5MEEyQ1UvOWdJa1RxOXlxSHBEQVZzTTFEMVVYbDB2QUpw?=
 =?utf-8?B?ZTBzZ3g1d0hhOUlHaEhzK2dFbmtKeks1aVRwZU1UdkhZUHZQd2ZONThQNFBT?=
 =?utf-8?B?Rm1vMG9yanMrajdFbU44SGx1R3NyWlB2cjQxSTYvNzIzMkIzQWdhWHNRdVM2?=
 =?utf-8?B?U050NHhILy8yMjZwMHBaYVRjdDZxUXZOWlBIRkYweWdFUWU0ck52dDVJUmNT?=
 =?utf-8?B?aVJhU0JTTWtESDJuRWNhaFNVczY5ZXduZVBwOUtDVDRwL0JsTzIyUk9yYVRP?=
 =?utf-8?B?UnpDczlSWWFwbnlocnNBZkpaY3lzellDWDZPclNvbUozUVk2aXBERUd1QTJi?=
 =?utf-8?B?V2hNWkNDM0xVWVFoUDlSd0NPVHdtNld0bHNBNTA0Y1N5STd6ak1zcnNlQTBX?=
 =?utf-8?B?QmJsQlVmWExBNVROMG5UVi80WVh5Rm13S2NUOEQydEdaMkw4WE5iY1BsL01u?=
 =?utf-8?B?QXpuWlVXNTArWFpUY0VyUUtEMWVscFhscy9ibEk3K1BFbEJ4YVdoZlhWSDNS?=
 =?utf-8?B?eDlUVy9rUXlqMmdxOWl6Z1dLOTh6N1o5dURVQmVXOGNES1FCSmFjL0c2MVlo?=
 =?utf-8?B?d2RIYUtTWVNqWUg3QXlaemJ2VzVCQnNEdFFEb1pma1h3aTZ4V05zZkthVk1s?=
 =?utf-8?B?SFpod1dqRGdBRFhEcFdZaUY0dmhDOTFxd3RZa0xIQ1VIK2ZmYTJhODg3cTBa?=
 =?utf-8?B?VDlXNkhiOGtKQUJ4K1RsTU9rZzFtdTI2Z2VsMjRGRlJncXBvU1BYeFh1aXpL?=
 =?utf-8?Q?YWKzM87x+r3r4vlXtnKwSuOKL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 04:49:54.0714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290a974d-2823-42cf-87fe-08de4da83328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093

Hello Mario,

On 1/7/2026 1:01 AM, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 1/6/2026 1:36 AM, K Prateek Nayak wrote:
>> cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
>> writer(s), however amd-pstate depends on fetching the cpudata via the
>> policy's driver data which necessitates grabbing the reference.
>>
>> Since schedutil governor can call "cpufreq_driver->update_perf()"
>> during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
>> fetching the policy object using the cpufreq_cpu_get() helper in the
>> scheduler fast-path leads to "BUG: scheduling while atomic" on
>> PREEMPT_RT [1].
>>
>> Pass the cached cpufreq policy object in sg_policy to the update_perf()
>> instead of just the CPU. The CPU can be inferred using "policy->cpu".
>>
>> The lifetime of cpufreq_policy object outlasts that of the governor and
>> the cpufreq driver (allocated when the CPU is onlined and only reclaimed
>> when the CPU is offlined / the CPU device is removed) which makes it
>> safe to be referenced throughout the governor's lifetime.
>>
>> Link: https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
> 
> I think you should have these tags instead:
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]

Ack! I'll update it in the next version. Thank you for the review.

-- 
Thanks and Regards,
Prateek



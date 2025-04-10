Return-Path: <linux-pm+bounces-25072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD93A837F1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A411B6335A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E51EB190;
	Thu, 10 Apr 2025 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LbIT7m+D"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C3259C;
	Thu, 10 Apr 2025 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260132; cv=fail; b=fwwX0fsY1+E0bIapUrrTwOOQTcow9PpQGlWnx1JI5Hxh9F3Cg/XhaeI0Po/7zrJxAqrnFVCAK9qf3xwlax1KtLFiIYGUXl8Bma3STCklsNvY1hWUw/7UK2QWOFrSe+iZ/WFK9H7Dq9fqB7pL2GZ0QesSfiJg13NJQ1Yrp20K2oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260132; c=relaxed/simple;
	bh=BQZ5ZYz1W7S8zKavimvmv0WJbe34Tfs1vutm/aPBDQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ppzt775eDZHTt8yKJ9SGUWzdwOi+xH2cUwY5J4zvqeQfwl5eL0Tdhs1uzyXl+sjEZ1tOrN8H/awDGP/Huhk0nNSQWNabjYqTW8lKQ3NVXEtrBi+qhNdPnL+lqBLmEypPj+xxD4rjrJ2ybZsSh//EhD/rQwuIfop8KJWvlNuMD/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LbIT7m+D; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXMve0Lc+mZ1e/IivFk4O1j6eJg617oq2A2xmGRBBu74uWtMVY7oT5VXnMXiZ+0xM16cRvDejvslVKY7r6kyH3BARxubfGuFErmV7P3S+f7VTmjwa63fZrUdxmX/GlZwm6snuDv6AIXiVd6dvMapW6S0JrzwaPc22wL7DXtYTv49Wlo3PvjgYDTCmFluWE/rhJ1od/is/CE93SWjyVLjhyuPgoSg9h/wHLBAXGXOpCU7Y+qsdYi65et7ObvxE8p6bXs/CgAu5xn1wDOPQ29I88yPxiqyuYm4aEfLshZVkGtGOTfnNqNYk9YBpl0wSY5UV1gLwEAbH+RXh23H6yXRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu++Cp5MK6uEbbOldRMN5/bHjR+cMwhhSbVeFfE2Gow=;
 b=sie2RMMGwVhUfUoLukEGBv/iPbqJM2rbvvHUkMY05rqu9q4SaMRGc5omwTN7Qb+uM3mlv56bISGLBIJFu5i/ulNohJgtEqXnzMvtqGivbzYkAIiA9hbPP2FJHcdKagrJ+qItaSfnXeQ/vyS6muPz2qP60IGY+NdRmHQwHF+AuX2r/ci0P4Sx3+hEQuHd3trrT6hmCe3lBQIvfSmnAEisKWhw+xNzIk2OMxbskNVUni5ftpnvOOhpBXxuP3eT5qoMif5n2SHwxF225NP8Cwx85SxI05eXCTRUNdhcXPe+wnkof6tkx8VldQrASJZx+KbLUqDF6ckkwBuPlRuLLsGmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu++Cp5MK6uEbbOldRMN5/bHjR+cMwhhSbVeFfE2Gow=;
 b=LbIT7m+D6pNxGT2SrofFuOe06GPQU07Zdqhp7fXqLoIhsQJ7CPy+Av1ztTrwW0n90+NRJDxqLyjrn6niZdBYLsCrkonEFFQrW/C/O1NjSL6vQiZ93TXDis3rSibRDCl6KzX4E26tFeuM1YDYT8NmQIXP5jsXwlQPoN/YHydasYY=
Received: from MW4PR04CA0242.namprd04.prod.outlook.com (2603:10b6:303:88::7)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Thu, 10 Apr
 2025 04:42:04 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::4b) by MW4PR04CA0242.outlook.office365.com
 (2603:10b6:303:88::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Thu,
 10 Apr 2025 04:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 04:42:04 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 23:42:00 -0500
Message-ID: <f62e5ac5-313b-4668-a6ab-a683e5ddfcda@amd.com>
Date: Thu, 10 Apr 2025 10:11:53 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Enable ITMT support after
 initializing core rankings
To: Mario Limonciello <mario.limonciello@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, Huang Rui
	<ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, Meng Li
	<li.meng@amd.com>
References: <20250409030004.23008-1-kprateek.nayak@amd.com>
 <483e9fc0-28bb-4531-88bb-738cd9ce9eb3@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <483e9fc0-28bb-4531-88bb-738cd9ce9eb3@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8f6316-d056-411a-cc96-08dd77ea0ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmRJMU9BeWY2blJHazlZVUt2c1d5dE1raUhSWFE5bWlVS1NsV0xlZytIbG9h?=
 =?utf-8?B?R0xReTlvS2lhMGNyS2xBSDlRekd1TmdUTEdHSU9zMlpGWFdIaGJnUTFGdStO?=
 =?utf-8?B?eWhBTlF4RU1sb0N0L1NqbzJ2SThObFlMTFpjNVkwc3FvRk1kak4wQVMvL3Bu?=
 =?utf-8?B?SnQwNFhaMWFqS3B0Y3NLVHZWL0V0REtWUUZmYkMxeThmTFZ3eWVWWjBFSE9w?=
 =?utf-8?B?eVdRU3RRa3RtU3JDQnJhR1llbFUzWFdVNkpYcEtRK3pVRE1hUGh5ek9tWGw0?=
 =?utf-8?B?TTl6QUZsbkU1Y2FLRGVKU0NsOTRrMm5pbE00cUwrZEJQc0tSMnJ1b21JMlJk?=
 =?utf-8?B?dU1hOVNBZXY3OTY2TUZNM1BMU0VRbng2TVlQMEk4b2R2K3FyNGJDeWRYZFhE?=
 =?utf-8?B?YjJ1SjhDU1NGQ2JZYnJTY3BNVmt1Y3lnY2l2OUdmZmgzWHBxcW02Tmoyb3lv?=
 =?utf-8?B?REUzWG1NU0haSUZQM1d5ZG1zTFZUbVI2ek1pZk96aFEwY0ZIQ3F6OGFkTW5a?=
 =?utf-8?B?a2tjTHJOeDQ1RzUrSFU0WEZCMnhQZXNwVi9mbDA0YjFhWnZqRW9ZZEtzcjlZ?=
 =?utf-8?B?SDZGTTdBS3dQUXg5UFR3dzVPanZEMi8ybmpvc2RhWkNWWU5ZbFV5QmUyd1pE?=
 =?utf-8?B?c1pPTUVaczUvc2k2aU9jSXpWY3VjRkd4b05ISXdidW95cW5yZlN0TkZpR2h4?=
 =?utf-8?B?Q1R2UEVsMFRkdzRUaHJiSy9JK3lhQzV0ajdYYmdITjdKNXhWVW0vK1kwd2VP?=
 =?utf-8?B?RmovdklKTWlxTTFTbG5sNDlwaGpCbUZOOTZaRk9tamtnTmp2WEsvTmw1emlN?=
 =?utf-8?B?RmdtUkpnK0VLUGZwamFvMzZ6eVpYVDJNV1F3azlCbXcyZWRreFU1cGwxZU0x?=
 =?utf-8?B?U1VubEVJMS9iOWFuSGNWTFUxT0ZObkZEdHJ1Q0cwdU9uNmp3SXRLY0p1QmJI?=
 =?utf-8?B?eFpDWWtvNThyR05XQ1YzcWlsQ0N6NE9RMmNkaEZSZWZSc09xNlNZTENtLzMy?=
 =?utf-8?B?MmszTzRjTEtnNC9tb3BWRGE5OVg3MHkxa3pSdWxVbnNLVEdjdXJ4RUp2Zmwx?=
 =?utf-8?B?YkxpeDZjTTRvMTlFTmx5OTVOOEJXdmE0a2phSERTK3NkanNoQWFqc3ozRUJj?=
 =?utf-8?B?Rk1KVXN3TlVHVTVsZzh6T2lOQTFpRjdNL0xnYmJkYkdzai9PNHFYb1hwZjNt?=
 =?utf-8?B?am1nQStkZGQrSnVRUlB6L2JZbUV5ekZxUXhSeWtMYlJRSU9yVU85UjdWeWZh?=
 =?utf-8?B?Y2lXcE5ESFd1R3p5UVBCSWNNWElES0t4N3RUdFZ1WXd2NERCZXh4R0kwK2Rs?=
 =?utf-8?B?S29VOE9ZMWNWRk0yY1A2elFGUXkzN01teExLOVlOU3p1NVZOR0t1NkExV1ls?=
 =?utf-8?B?UXNacGtFanlINEpwSmJNRzJPbkpoak5SU25mdCtQb3A0SEVzOGc1S3BVMkNZ?=
 =?utf-8?B?QmJuQ015bjhaay9vc0c0R3pncy9uRzQydnpOeHBzZlV2OE5Ea3FQZTB2anJQ?=
 =?utf-8?B?bVhVbndhQ09ZSmdhNGJBYmEycURHeUY5eUJBUTlXTk1vcGtmRzlBV1Z3cFpa?=
 =?utf-8?B?aGNmWittTlVuczVOSzIyY2hpbFlZN1J4VnFGNXZwNGtCZlFlZ0Q3RkNGam9M?=
 =?utf-8?B?SmhLY2hoTnByRmxObXpMbXJFMk8zUXdKTFNWOGd1VEZtRDN3bG5qaEZOdXdT?=
 =?utf-8?B?ZXE1RzU2dCtNaTE1ZWUxNEtBaDFwS1M4TE1jdHhBM2tnL1hHeHlBWkhLc3Ba?=
 =?utf-8?B?bS9LbGI0RVQwclJNQTdJeVBpVXFVZVlnZGpLM3JtNmhyWTVPNDl3VUUrY2NG?=
 =?utf-8?B?dy9pbmtIdmlnaFNHbUtNR2FaNUdkTmVoNVlqNUdXOXl3R3ZJNzR6YmkyNlFB?=
 =?utf-8?B?VUN4ZGs0UTNUbUtjUDlDN3V5MmVSdWo0TjlObzNMcW5CUWh3TEpBSDdvaUFR?=
 =?utf-8?B?cHlnM3U0NU1JZFZQSGNocmJrQ2htVkQzeXgvNXgvb0ZxOWxsVXRXdnFlR0Vw?=
 =?utf-8?B?OXpvQnQydnVWSFU1aENBaUs1Y2pFanFsU2hKdGdqWCtiUXBuMm00Vnp1L3I1?=
 =?utf-8?Q?CdewGN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 04:42:04.2948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8f6316-d056-411a-cc96-08dd77ea0ad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148

Hello Mario,

On 4/10/2025 2:28 AM, Mario Limonciello wrote:

[..snip..]

>>   #define CPPC_MAX_PERF    U8_MAX
>> -static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>> +static void amd_pstate_init_asym_prio(struct amd_cpudata *cpudata)
> 
> I think the previous function name was fine.
> 
> 1) It still does set cpudata->hw_prefcore afterall and
> 2) We still have an amd_detect_prefcore() that is used to determine whether amd_pstate_prefcore is set.

Ack. I'll change it back in v2.

> 
>>   {
>>       /* user disabled or not detected */
>>       if (!amd_pstate_prefcore)
>> @@ -814,14 +804,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>>       cpudata->hw_prefcore = true;
>> -    /*
>> -     * The priorities can be set regardless of whether or not
>> -     * sched_set_itmt_support(true) has been called and it is valid to
>> -     * update them at any time after it has been called.
>> -     */
>> +    /* The priorities must be initialized before ITMT support can be toggled on. */
>>       sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
>> -
>> -    schedule_work(&sched_prefcore_work);
>>   }
>>   static void amd_pstate_update_limits(unsigned int cpu)
>> @@ -974,7 +958,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>       if (ret)
>>           goto free_cpudata1;
>> -    amd_pstate_init_prefcore(cpudata);
>> +    amd_pstate_init_asym_prio(cpudata);
>>       ret = amd_pstate_init_freq(cpudata);
>>       if (ret)
>> @@ -1450,7 +1434,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>       if (ret)
>>           goto free_cpudata1;
>> -    amd_pstate_init_prefcore(cpudata);
>> +    amd_pstate_init_asym_prio(cpudata);
>>       ret = amd_pstate_init_freq(cpudata);
>>       if (ret)
>> @@ -1780,6 +1764,10 @@ static int __init amd_pstate_init(void)
>>           }
>>       }
>> +    /* Enable ITMT support once all CPUs have initialized their asym priorities. */
>> +    if (amd_pstate_prefcore)
>> +        sched_set_itmt_support();
>> +
> 
> Hmm, by moving it after the first registration that has the side effect that if you changed driver modes from active to passive (for example) ITMT priorities stay identical and aren't updated.
> I guess that makes sense since the rankings /shouldn't/ change.

Currently, when amd-pstate unregisters during mode switch, ITMT remains
enabled and if the rankings change before the new driver is registered,
update_limits() is never called and that too can cause issues.

Based on discussion with Dhananjay, and the fact that one can mode
switch to disable amd-pstate completely, What are your thoughts on this
addition diff:

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 40d908188b78..320b9551947e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1177,6 +1177,9 @@ static ssize_t show_energy_performance_preference(
  
  static void amd_pstate_driver_cleanup(void)
  {
+	if (amd_pstate_prefcore)
+		sched_clear_itmt_support();
+
  	cppc_state = AMD_PSTATE_DISABLE;
  	current_pstate_driver = NULL;
  }
@@ -1219,6 +1222,10 @@ static int amd_pstate_register_driver(int mode)
  		return ret;
  	}
  
+	/* Enable ITMT support once all CPUs have initialized their asym priorities. */
+	if (amd_pstate_prefcore)
+		sched_set_itmt_support();
+
  	return 0;
  }
  
@@ -1761,10 +1768,6 @@ static int __init amd_pstate_init(void)
  		}
  	}
  
-	/* Enable ITMT support once all CPUs have initialized their asym priorities. */
-	if (amd_pstate_prefcore)
-		sched_set_itmt_support();
-
  	return ret;
  
  global_attr_free:
--

This way, when the new driver registers, it can repopulate the rankings
and then the sched domain rebuild will get everything right. The only
concern is that disabling ITMT support during mode switch will cause the
sched domains to be rebuilt twice but I'm assuming mode switch is a rare
operation.

If disabling and re-enabling ITMT support during mode switch is a
concern, I can work something into my dynamic asym priority support
series to detect any changes to the ranking during mode switch and use
sched_update_asym_prefer_cpu() to update the "asym_prefer_cpu" that way.

Let me know your thoughts.

> 
> I feel this should be OK, thanks.
> 
>>       return ret;
>>   global_attr_free:
>>
>> base-commit: 56a49e19e1aea1374e9ba58cfd40260587bb7355
> 

-- 
Thanks and Regards,
Prateek



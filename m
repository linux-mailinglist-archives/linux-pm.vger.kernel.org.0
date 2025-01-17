Return-Path: <linux-pm+bounces-20640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3DA15653
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 19:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1EC188BA35
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A71A3056;
	Fri, 17 Jan 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dfAK6Z16"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739A1A0BED;
	Fri, 17 Jan 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137383; cv=fail; b=pnR8Epzc4nQytyV1UFsh0cehtq/VoeePI0u6MrQAccegVdEtXtT3Z1cMWRENbN3tv/3+/xLgLWvzjWMifTWE1RgMeFAH2yJQPsq1hjKXm9pNRlc54zV9EoA+kfhW6sJEtcfm8gUCEH9VH47ii24IzZKlbe6GfoR3EZRVG3Rc4BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137383; c=relaxed/simple;
	bh=GCdiX8CqV38dD/alR25/M3Ky1VVJ0VdgC5Xj1WgsxWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PPpfWo/eL4c2EUXEOn7H1Rl3TNcTyTLGxUFJYzqWSSl2Q3fRgmAvveyWlZcaFUIaT4u3wLcv63p7lxwTW3iqUsr/kk5UvN6qnk7DCq+qw9ho9bpn09J6Io9n8DnBeMFIlHCoVDx0TsEsVqG5Ewa77Gp3tPVPQi26H8StYL1hkq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dfAK6Z16; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FES7NIVZk5AxB0gBpxEEI+c/Io8qwaHZZFbFhLhxTC2yoQAExJDULJsenm2JDhXSmnulgSOAW4Hxdsqd45W0U7CDIE2JaWPnSTJFpeod2L2BllwNqtV9C9qExZp4ibxjBe/pH6TwJNOkWOeNmn2QviiBIs14Db9Qj7IjGDuSCnUw/3JqtpELe0j+i3CexZC8YKZKvb5qBJaxqIk5eqbECbrPJBX+57LCMGS+2WkGY/SrqkrgTrSJw1i+7i+Fz9P6dIlVu6WVwaMgCyO+44d3S+ZN8i3n40n0hC8q4qcOKouGjPPXKSghe8YYdFDwkLL5kr0+3DpxtCZNBimUud2OYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwImGnwnY6mGjI/EQQzdMF9G/xEBynFQhX45yjuWCXE=;
 b=Nqclbk0tNQFNCHEy9tok1UNAmAUm+QVulxb6Y3FCCvCZiGD5xpb0DYSPSW5E9tqzMp4gaK3QSZkSpJFP18mNxvXjqqY9aOptX7zr7crO8dk4TdULAv5ayIQ76wKHIf0MSAmWIA5Jjnu9CzQ3qUuq4DkYH9eG4xoEqrSk54y+4SXsrIal35CbYaL8x3dknOzOD3JwvclfBg/p+/t0gjBG0T6Fp4Qda7XSzMts18AQracu+aQbDK265gD7zmmKEPUTAIFKrSUg9R6MSlPVwnaKsIjiRZ+BVOSHZdoaToNb8v0j7iEtYBceIZkUU0zlqYAu9RbydssHwv0GtjWHBvDKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwImGnwnY6mGjI/EQQzdMF9G/xEBynFQhX45yjuWCXE=;
 b=dfAK6Z16onkH7uHfGxPY2dePmLld6mS+/QH9uGBTSsFe2f02Uw1GmmfQDrj9TVY4Vr/58fhXmnI0I5TzD3USKYiuXN/Ow/RVhxxLuBd+V+haM+NFVqct0MAoIvvOjrJNXvqANXLOyiMvOwr2Wf7CH51gxD5Z7VAfyVQd9s/B/C4=
Received: from MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31) by
 SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.17; Fri, 17 Jan 2025 18:09:36 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:10c:cafe::ae) by MN2PR01CA0018.outlook.office365.com
 (2603:10b6:208:10c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Fri,
 17 Jan 2025 18:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 18:09:35 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 12:09:31 -0600
Message-ID: <ca4f26e7-aa6a-4dd1-a10d-ea0d9bece6a6@amd.com>
Date: Fri, 17 Jan 2025 23:39:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] cpuidle: Handle TIF_NR_POLLING on behalf of
 CPUIDLE_FLAG_MWAIT states
To: Frederic Weisbecker <frederic@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, <linux-pm@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
References: <20250102150201.21639-1-frederic@kernel.org>
 <20250102150201.21639-5-frederic@kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250102150201.21639-5-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f9e8bb-87f4-45ee-535a-08dd372219df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2tLZi9LMGEyVllSYzVTSkFCSTAvRjIzamJnY0dxWC9YR1hCakx5VGozbllF?=
 =?utf-8?B?N3BTT1VzV0hxeC9wUjJzTEpHMTVHMGRpTm1SRCs4aHdHVmFEclVnTXAzWWVU?=
 =?utf-8?B?eTd2bUtwbXdQcDFqSFhaUCs0cGJvWXJDOFE3bXlBMnVuRzdLcDg5VnpDSU5I?=
 =?utf-8?B?UG1Nd1JOTVpSQlNxekZFZS91ZmpkQ3pvcXlUbW1wTHIxYlhEM3hCWklERllk?=
 =?utf-8?B?azhrdEFEbFZuZWk1OE8veWpMU2JWN3BJcWhxRytTZ1pVSWhxYnNQeWhkN3U3?=
 =?utf-8?B?NTZ6Ulp5UzhMZUZjOGZvSFVRdFlYTWdXanlLbmZubUlSZk5FaEl2ZnRMcUMz?=
 =?utf-8?B?MUJ1bEM5eGFIKzlPQ0pOaWtDb2RCZFUrdndMQm9nZ2g5dm85M0xyejFZWnE3?=
 =?utf-8?B?bi9aMllzb2FGZkpDcklzTTFWNm9RSTZaM0I5Z0hxODNXbFZIRFdyT3NDMnhz?=
 =?utf-8?B?dWxwdnp2eUYyRnVzUU1LQkExNFFXeEdNdklBK0JweGxJNVc0aVNvRFl0QS9C?=
 =?utf-8?B?ME14Z0RoVVRwNXpCZDFpc09UcXNhVzJTVkNjRjdWWjlhL1MxSE5mcnh5c013?=
 =?utf-8?B?NEdvSHhKNUlRbVRtK0prT1FadWNacWRpRGYzOEFCVUFET3h5aVNrSEhxcXox?=
 =?utf-8?B?WEN3R2d3WTJLaTY5U1J4cTF2ZkRleDV2YmxvUEZnQ2xGTkJFL0ZsS2JseDN2?=
 =?utf-8?B?a2tCS0tsTXZpeVpzQVdpdDErbzByMHBKRjFCN3dQTE9HVExYS1J4bDhKM0pF?=
 =?utf-8?B?eGxqdlU2b1FzL1JSN05rWEtISHpGUDZ5dlIxdm9RcTZldW9ZYlREOVVuYW8y?=
 =?utf-8?B?bkhDRHlXZHVBT3BVdGVhUlpLdjJ6akprdEFCMlRXQmtZN2hPMlJFdlVxc1VE?=
 =?utf-8?B?aGNLU1ltVWJhTzJEK0dMc3E3K2txM1FrUnBQWDBQMnBseGs1aStCbGFTQnll?=
 =?utf-8?B?dkRYZjZWU2l4cUpiVkF1TXFFampaV3BBb2FrSGhsR01FWSszUkN3WGNORkdq?=
 =?utf-8?B?RjlaZ3NLMEdNU2V1VjRNdE9ONy9ZK1Q1Y0VIVTRhMEh5M0FUdFB0SzJsWlZo?=
 =?utf-8?B?RHg2cDgyS2NMcEM3T05WMTJYZlAyM1JodVFwdUt5UFp5Y0xIUVpDYm9Lck9M?=
 =?utf-8?B?NlVtZE0wTll1YjRUcnN6ZGora3FodEhOS0g3Q0lqRllMQWQ5MWdZQ05LU25B?=
 =?utf-8?B?K09TWXMzTkFnWXJ6RGJNZXM0SjBkKzJLZlVhSXEvKzBYY2REY2p0Wi9RalZy?=
 =?utf-8?B?TUdkbkswc0JQaURNczAwTEFDZWFDOVl2cVhGMGdmWnI1K1UwQjc1WjVsYTA5?=
 =?utf-8?B?M2ZqT1FmQUVWb0JCaFZ0QVVHQ0Z6b3R0SXA3Z0xaeFlndmVYNjdkbHdwcnJX?=
 =?utf-8?B?U0ppSVdORDF2ZHJoSTNTc05vTHlUUW1ncVI3d3RhdGM2TVM4b2x3ZVFJZmVJ?=
 =?utf-8?B?WGFxRmNBTzhnci9iU3ByZExvc3JwRS9kZi9xbUxVam10OGREVEJnSXNOTStM?=
 =?utf-8?B?R0RsM1IxbE82c05NVzIxZ0poTE1GY3lWUUdzdFVCQ3E4UmltMzJ4YTJYRUNQ?=
 =?utf-8?B?OWdzbEtJQ21Ud09lT1k4MTVERjB3YVBzMFRaamM5dGlPcHRDTWV6NEx5Ylda?=
 =?utf-8?B?YnBpbWZObGNReE9DTUs3Zy8xNnVxQWhrWkNrcDhIRE4vVWhtV0R3a05SNFZP?=
 =?utf-8?B?bENtZWJCQTBCY0tQMmNGSjhhUkVLbVJ5WmlTYTQ3NkdYaXRBdS9OU3ZnUHNI?=
 =?utf-8?B?eDdTckpMUkIrblV6YVdnMkpybXNJRm5zcWhyMkltOGhlT1NUTkNEK1l1bXJw?=
 =?utf-8?B?cG05T3BWcWFpdmZ5NGxGRWp6QlNPWnYvdjBhTFM4cFg4b1N3M0gzUjJLck5i?=
 =?utf-8?B?c2J6SDZKQ21zVXdzUjR0TUJIL3FQeUh6Z3NraHMxSzg4amo3Mm84eHdXM2FB?=
 =?utf-8?B?NGZURHNiM2hremkwOHBpdm9MdzUyckNBSjBTNWFMNThTT0xZZGtoQlk5MUtT?=
 =?utf-8?Q?QMf0i0G4xs5NCODXJoNlXiBepTmPhs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:09:35.7241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f9e8bb-87f4-45ee-535a-08dd372219df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

Hello Frederic,

On 1/2/2025 8:31 PM, Frederic Weisbecker wrote:
> [..snip..]
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 621696269584..9eece3df1080 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -114,12 +114,13 @@ void __cpuidle default_idle_call(void)
>   		stop_critical_timings();
>   
>   		ct_cpuidle_enter();
> -		arch_cpu_idle();
> +		arch_cpu_idle(); // XXX assumes !polling
>   		ct_cpuidle_exit();
>   
>   		start_critical_timings();
>   		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>   		cond_tick_broadcast_exit();
> +		__current_set_polling();
>   	}
>   	local_irq_enable();
>   	instrumentation_end();
> @@ -128,31 +129,14 @@ void __cpuidle default_idle_call(void)
>   static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
>   			       struct cpuidle_device *dev)
>   {
> +	int ret;
> +
>   	if (current_clr_polling_and_test())
>   		return -EBUSY;
>   
> -	return cpuidle_enter_s2idle(drv, dev);
> -}
> -
> -static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> -		      int next_state)
> -{
> -	/*
> -	 * The idle task must be scheduled, it is pointless to go to idle, just
> -	 * update no idle residency and return.
> -	 */
> -	if (current_clr_polling_and_test()) {

nit.

Previously, if TIF_NEED_RESCHED was set by this point, the CPU would
bail out early before entering the idle state but with this change, I
believe only at need_resched() in mwait_idle_with_hints() do we realize
we have a pending IPI / task wakeup. Is this a concern?

In my testing with ipistorm I could not see any difference in IPI
throughput to polling idle CPUs but a bailout before the entry method
for need_resched() can save a few cycles.

-- 
Thanks and Regards,
Prateek

> -		dev->last_residency_ns = 0;
> -		local_irq_enable();
> -		return -EBUSY;
> -	}
> -
> -	/*
> -	 * Enter the idle state previously returned by the governor decision.
> -	 * This function will block until an interrupt occurs and will take
> -	 * care of re-enabling the local interrupts
> -	 */
> -	return cpuidle_enter(drv, dev, next_state);
> +	ret = cpuidle_enter_s2idle(drv, dev);
> +	__current_set_polling();
> +	return ret;
>   }
>   
>   /**
> @@ -213,7 +197,7 @@ static void cpuidle_idle_call(void)
>   		tick_nohz_idle_stop_tick();
>   
>   		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> -		call_cpuidle(drv, dev, next_state);
> +		cpuidle_enter(drv, dev, next_state);
>   	} else {
>   		bool stop_tick = true;
>   
> @@ -227,7 +211,12 @@ static void cpuidle_idle_call	(void)
>   		else
>   			tick_nohz_idle_retain_tick();
>   
> -		entered_state = call_cpuidle(drv, dev, next_state);
> +		/*
> +		 * Enter the idle state previously returned by the governor decision.
> +		 * This function will block until an interrupt occurs and will take
> +		 * care of re-enabling the local interrupts.
> +		 */
> +		entered_state = cpuidle_enter(drv, dev, next_state);
>   		/*
>   		 * Give the governor an opportunity to reflect on the outcome
>   		 */
> @@ -235,7 +224,6 @@ static void cpuidle_idle_call(void)
>   	}
>   
>   exit_idle:
> -	__current_set_polling();
>   
>   	/*
>   	 * It is up to the idle functions to re-enable local interrupts





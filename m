Return-Path: <linux-pm+bounces-40965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C15D2B87E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 05:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40E103016AA0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 04:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9371347FC3;
	Fri, 16 Jan 2026 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E8cg7c5M"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94405347BA7;
	Fri, 16 Jan 2026 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768538370; cv=fail; b=kWWrImL3vjM0Zc5qsD5apozKG6atMmgpITJlIiprNOzTDNbMLDfjuDmyOFR2va+jJNQt8s9Wm3A5H2I74PJx/MKmO9t14d/SCuIgXO9p0vvkcHQBOQ9LlbuiG1hR+AL+zOMK7IOZCt24Do2I4ao+f7XTjpfcfB7jBAunnFDs4pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768538370; c=relaxed/simple;
	bh=xoz4hugNZHEWfGDYtD+2com4DcQnGB1ngBdzV2jbFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XM0xQWl2Dx+IUXSP0RuMHbJfDc8XFU48B4vwvL9vB7PTYs/C7XKrYZOcHG4EsdFUUA/erYTxrILjkL2Tk+yC81gdVD48JXRBb0eIlnLSJEKEfHm/zQinhWo4DnodWYaKCba24M6PLgusWvbhRkSDVc9dyGIZMcyIpKTZ2XFGk4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E8cg7c5M; arc=fail smtp.client-ip=52.101.61.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLnN6gZs9iDnyjR5WzKVAX6rmCLfAyOcPwEzrho6npQ893gtK6Pc/aE6xQO/8M8qkYElvwQeLF+dX1AivIIVoBwbYhPSYL0PxLfRqTM7z5q52oDCNJqZcTjabJJRORe4vMDP1RDGKFu4iBmENpAnuCApdMeKd/XlPtMFvQeg9oTUTIXbSjY/Mm1uQsjzQEmKDJluQP7XQpH9zrxsbgpcmfUtU0k835COoIAfh0VhFpjUngCPXKbzm2MJF1kVI/EOvenrUQjzIAGNVMNODM3OQ0IUOujsqpjTJWN0eTR5ol5Qn/vZLs/hp6R3NroePXk1WP9X3qLvve8XyEJ2k+xVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Yoi5licWXk9Hmy4rNNO/zzimHWCyZN9cG8+rb9iARI=;
 b=UvVJSKPRIZdeRugvjcBP3IUYr+Tyq61UZ69djQ3jjGC15BeYjQYj6KEGA0nkkPUYsf5Ye5oNZ3XJdhEcmKv4iSFyzDtwf76YQa3edGkAccwOTKJnwUD2tI7eB0HIHqsrnQzMqO5e5WgTw/itv8U/M7DgQumfaSoFtqaJruy/r+10VNZQt6Y5My5erZJthvyJ9KU8NLxWBxHFKf7950eGdE7jg0vunDwihpZLe/2ExVPbLZK2Oo2hbFEoTEOIyRyadKhf/bxHhqoejSyaDQnHNMOOciNGwoy/Tlkl9IduNDAVnLmS6dAz2lh2U9fIdZxdCc/Oa4uwWmyScDpwuJjQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Yoi5licWXk9Hmy4rNNO/zzimHWCyZN9cG8+rb9iARI=;
 b=E8cg7c5MagzqZaPmGJgCM7YUJMtkF9qTuFRyE1OPO0WJyLbW0JO7snrVsmedprnRWBHtzao1NvfSMAhlSddJxr6Mzj9ly039Kug6m2FYKddRmr8BZPU/LfaWKb9Q2nABci098YbBYIEirBaxF7zvsPABWXriQ+kv7bue4ukXTeo=
Received: from CH2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:610:4f::28)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 04:39:09 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::23) by CH2PR18CA0018.outlook.office365.com
 (2603:10b6:610:4f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 04:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 04:39:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 15 Jan
 2026 22:39:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Jan
 2026 22:39:07 -0600
Received: from [10.136.34.241] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 15 Jan 2026 22:39:03 -0600
Message-ID: <6eabf604-9168-47fb-8fd8-b2f0d985db6a@amd.com>
Date: Fri, 16 Jan 2026 10:08:57 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, Perry Yuan <perry.yuan@amd.com>
References: <20260114085113.21378-1-kprateek.nayak@amd.com>
 <20260114085113.21378-3-kprateek.nayak@amd.com>
 <bqvpt465nowq3jipfsciaoafjpjhu42l63vi6p67qscwx5oil4@t2tkh2u5giuy>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <bqvpt465nowq3jipfsciaoafjpjhu42l63vi6p67qscwx5oil4@t2tkh2u5giuy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b34ec55-98ee-42d0-c92a-08de54b92fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG53ZnpWRGJieWE0V0JDS0RQN0NWb3ZUMVB0cUtqNXJLTjlKL0s4Tlg0eUNK?=
 =?utf-8?B?Yyt6QWcydDRYbWtXSkk4YnN3elc0NmMwNEQvVmtLNnBVK3ZTVW9IOHhDaXpR?=
 =?utf-8?B?Vkc4KzdrZDhMR0h2Nk01azRIalBYWTZaenhkb25Ndi9rSXZDRmN5R1dwcDJM?=
 =?utf-8?B?M0l3YmFmSEJjMnZDaXQrZmVqM0xMK1V5eENoVnZlRjU2NXhlbGwxZDlNK21j?=
 =?utf-8?B?RFFrS3creEJUVnFmUG0vaHRSWlA2R0gzTjZBOVYyakZVSnp5dWVDdU5GMmIr?=
 =?utf-8?B?U0NaVWlDaE1hc0dMWVlNV3UxbjBIOXFncE9EZTUwT1kydFlCVEU4bndReEtM?=
 =?utf-8?B?Yy8rQWZpeXlUZ1lLUHVYaTRTVmR1RUNIZGE3dlpjR2lxUGNIaHNROFY0cGMy?=
 =?utf-8?B?KzlkY1VEWnRsTDhRNkphR1A1Tk5waXI2aXVIcGx2dTVQRE1ocUpTY3lsMU4v?=
 =?utf-8?B?WkhkNTRpQjBmOVhmQitjK1NtNTQ5a3BkOTdITTdtTGoxR3NXTm0vN0o3MUZh?=
 =?utf-8?B?amczWkZNRjcvRzA1ZUM3K3FCVjBoeTMwU0pHRnV6b1pzaWN6U0JyTGkzTXBy?=
 =?utf-8?B?V242ZllRMkNVNTRnMW1NSnN0QTN3MkZITC9KWU8wNkZvMyt1dDlCYVlUWXhJ?=
 =?utf-8?B?VHJhK0owaDVla0RDTm9oK2FUWXlYcE5HbW55blBxNDMzejJVQllXU0UwMDFu?=
 =?utf-8?B?TVZ0MGxVQU93YStmVFIwZDEzTEtmalhCSE5rN0dydzRiTTAwbmRZVi9Fdk95?=
 =?utf-8?B?UUNaRTI2VHBxVTBOWHVFbWFxQnlVWUc3QlBub09IOGF6SUJwdEdMRXpneVpU?=
 =?utf-8?B?QVAybURhcnlxelMrZHdGeHI0VGxXRkVLM1E2Y3dBVGtXYXo0aE1FcnMyOWFq?=
 =?utf-8?B?bVBNTEo3NG5uOVQwMkVaWXhveVZJUWd3aExiWElWbVpVNmUvOWVUZjVSWVcy?=
 =?utf-8?B?SWh2RUxtUnUvb1BuS3ZhWXhCSHRQMVhCRFFCeDRGMGZmbm04RzQrZnVJTHNJ?=
 =?utf-8?B?Nnp3VCsyMXFEWFNqbGlTUmhhQktJQ0FnUE9JNVNnSjdlc0FXeDhIUzNwYm91?=
 =?utf-8?B?dVFhLzhhaUxsYW10b25BWVZjNU9nVGNOcVVDVlg2emt0TmI3d1NqOFd0M0pz?=
 =?utf-8?B?WWMyM2tURk0rRGY3NlBDeWlzbUlmMk5oTlVkTzcraDBRcXFseHQwUmdHUnBt?=
 =?utf-8?B?MVFLSWRqemVZN3JKNnJHQ0Q2NGNEcCtadmpCdk5nOHlKWldrYzFobG50RXA1?=
 =?utf-8?B?aDZIMi84QnJ0Z1pJbExQMlpYNWxYUXRTL2NCVEo1Yjc1Q1Z2cjhtY3hBOVJy?=
 =?utf-8?B?UEtybS9DR210ZWI1Z0JPMXU2V2dSaDZVTlFUbG4vQUljM2dJcFhpOTFodUw5?=
 =?utf-8?B?aTJWamFVSjRUSk5pb0kwOUg3Rk14SnJaOU9LUDNvQ2NVWVBSZVE0N0wwdDla?=
 =?utf-8?B?d0lsS2lMbHlLWHB1aTJxU1l2TnQzWnhwcVhyRzJCQi83aTlmZENEWlVNbXhH?=
 =?utf-8?B?THMzUC9nK09SZHhURDVMOXJ5N2ZhSlFsZTVwaFFiZXppcVYxb0F3K0U1eVJQ?=
 =?utf-8?B?eDVjWndsc3V0Vi9sbDEyMmx5S3A0eGlxMWJzWDk5UHQrM3I3cmU4dERXdEpz?=
 =?utf-8?B?dXgwVnU1U0tnU0hZaUwrQ2JjeFlTMG0yYm5DcVJZcjU1VTZicVgvY3hwS1FS?=
 =?utf-8?B?NjExSXptODB0ODhtaGIvM0RPMEJOY1JET21nNEY2OG1MVksxbUlRYXI5enpJ?=
 =?utf-8?B?YnV0VFE5SmY4dDBYQzRBL2ZkYUNvdXpsVmt5bGp1VWVPcHV6YldaandpNGti?=
 =?utf-8?B?OVlpTjVJRndoUjl5bHRyT0s4ZFk1dkFlK2hNNmloMmRzOTBybkdKVEFLa292?=
 =?utf-8?B?RERwZUliUjJRVFQ5ekhwbzB3eG5MbTRSMXBuVWIvWFFyRWd5ekQrRHNEVW9m?=
 =?utf-8?B?aERSZDdub3Mzbjd3QjgvOFBySlJOSGFoQmgxUVVONWZEaVVXL3ZoY1g5OTEr?=
 =?utf-8?B?Vjl1ekYvNklPeG9lVFJISllqMnVDamNtOVl1U2grYllEc1BPK1JpMU9EaFN0?=
 =?utf-8?B?VFZ0ZHpibEVBYzQ2VFoxVGpZclhCMlBjYXVTWVhDY1lzUEhySjlsVldXYlhm?=
 =?utf-8?B?YWpvZmdZVHQxOWhtcW1FS2pmUnI4N3cvUDV6dUhFekdITnh6dUp5WFg2VjlR?=
 =?utf-8?B?NjlJb2lCUGthcnV3RG5VTUliTTlWdFpPWWQ4R0g1bjZlbDQ2cmFRUHVDMTVY?=
 =?utf-8?B?LzRwSkNhME4wL0RJd3Q0R3ZBamVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 04:39:08.1902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b34ec55-98ee-42d0-c92a-08de54b92fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401

Hello Viresh,

On 1/15/2026 9:44 AM, Viresh Kumar wrote:
> On 14-01-26, 08:51, K Prateek Nayak wrote:
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
>> Reported-by: Bert Karwatzki <spasswolf@web.de>
>> Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Ahh, you need to fix the Rust binding as well. Minor change there.

Guilty of not having CONFIG_RUST enabled! I've arrived at the
following after tasking a look at cpufreq.rs (specifically the
fast_switch_callback implementation):

  (Only build tested currently)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f968fbd22890..bea109f8ff78 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1255,18 +1255,17 @@ impl<T: Driver> Registration<T> {
     /// # Safety
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn adjust_perf_callback(
-        cpu: c_uint,
+        ptr: *mut bindings::cpufreq_policy,
         min_perf: c_ulong,
         target_perf: c_ulong,
         capacity: c_ulong,
     ) {
-        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
-        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
-
-        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
-            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
-        }
+        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+        // lifetime of `policy`.
+        let policy = unsafe { Policy::from_raw_mut(ptr) };
+        T::adjust_perf(policy, min_perf, target_perf, capacity);
     }
 
     /// Driver's `get_intermediate` callback.
---

Let me know what you think. If you think this is alright, I'll fold it
into this same patch in the next version to preserve bisectiblity with
CONFIG_RUST (or should I keep it separate?).

Since this is my first time dealing with the rust bindings, comments are
highly appreciated.

-- 
Thanks and Regards,
Prateek



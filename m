Return-Path: <linux-pm+bounces-40802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C9D1D4E5
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4871B30A3F2C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8466837FF47;
	Wed, 14 Jan 2026 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XXai3Csm"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6737FF5C;
	Wed, 14 Jan 2026 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380753; cv=fail; b=sX1oMTHCFj3XhDIA9YJTBnhWURZlleGVK1FDfmWJGuiUwN/9pWZLICAMGCMUwAcaOz6zM1reFj4f82Z7Jz9fLMwFuDWR3Y+OOG6ynPtT/xL+eclHC14AB2IQEPcWXA/TXi0gsOphWYX3pcMLiGsUUIE4xIxEfFS9nJPnZ4RA39Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380753; c=relaxed/simple;
	bh=FCo0pXsOVjBfZvRdtuFSD77E0rIDp7qGQIys+8iBNYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFQo7xL5xv0sfXNqTDRL0a4SmJ+VqjLLHhCFlZR5bpO3m9ubgJc9Q359gdd5vI88DgywWpBc/iUL+mb774vAikWeyOy9Rk8SB2ehICu4thtXxmy21OogqHmp93AJPBGAk/rkxJAec5I2ITgzG9iC2f+zd36tebtH+8MPfx7ugfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XXai3Csm; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjF0emeodSR6WJ3wL82/zhRZqLvlkMycmydl+1KXN2MGcWNlFLeAyIHonyAXMJsZNoLS0nsjRvhYzxIXG3gFswu9hKuzt4pmheBZptJDzxujwp9gI9fWoMoOBY52PcB9vEDgWzGZlW8xA8ZH+0BTxvrp9sAdZyDPNiXmmz71DEnnhnKeI/R/gD7bvhdCVdsrLLSya1wirtis9mL7oR3q2qU1W9wWTtnJ/s5LlkrvWSJVQk6o/28QVY2xEnGKM1SoirOw/zSx7hjkuvuZzu9NjFcCEvbYbtyaFYYtAhVsCdkipE7x9bEiModZZ02jOz9HZOQuihxIOV9F1BVvM/akAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez04Gmb5yiMUiFbp2p7XrreApqvO/gUgotNp6j5gaJA=;
 b=fgn+2DUe36S8j9nyP8TYcOEWAJSaDVbVNjLuIjHrUjRU8yfzrj9Vw/u2hnmlCvn7+/bsgWCKK1CCrPIxNQU9hVzLcnYsjeZhdb74phZZNJ3ZkbOzngUmhGw1P47iebj/EjiSolZmA5zv4uYrtiPfiQQzgm8KU6G3XAo5bqYkVSjVtyAFvCjXvwSSBI5vC9+KSTQigypIEuiYpMdZksF9kNTQX9W1oFO962SBmpj5ooscQ+FTfv1agpkOBcXIW6EJmasS9SEE5/ULx62JWk7Xe5/lzv+JmmJ+yDVRURouqdajURU5XBcO9T9Jisb0TUI7GA+MaqTgMryyb80xQc1eWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez04Gmb5yiMUiFbp2p7XrreApqvO/gUgotNp6j5gaJA=;
 b=XXai3CsmIIAoDVt3OD08m/vjRqDuBen3M9KxHkbIi3p5yoWx/DM4AGZmQM/g3KgAfA1OgOjJelZrDc3DvlAG4xygRIgC+jvqDDkVqtYxztIMrEvcmge4H/a4b7r2KEaR/xyUyJCsbjWa9WRAY++OtdqOYAvZOUhH5xABdNNG5vM=
Received: from BN9PR03CA0457.namprd03.prod.outlook.com (2603:10b6:408:139::12)
 by CH3PR12MB9731.namprd12.prod.outlook.com (2603:10b6:610:253::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 08:52:23 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::c5) by BN9PR03CA0457.outlook.office365.com
 (2603:10b6:408:139::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 08:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 08:52:23 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 02:52:18 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2 2/2] cpufreq: Pass the policy to cpufreq_driver->adjust_perf()
Date: Wed, 14 Jan 2026 08:51:13 +0000
Message-ID: <20260114085113.21378-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114085113.21378-1-kprateek.nayak@amd.com>
References: <20260114085113.21378-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 881ec57a-fb49-40cd-a996-08de534a3c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AdoAi9+BX/dzOs3j3PYGZLqskAIYN5gFeaetRgyCwMzLSrBNLOCd16XQBiP3?=
 =?us-ascii?Q?FFEmDFWn2yqZ/4OQyHYerriCEnU8zNBRYtkehTKSvATe8Df1//d/284Cj4q0?=
 =?us-ascii?Q?ApMrti/MlVs+Pfb40BIm0IvQGaiF9owaLNQAVa0p+BRUlNfBKdBB3SFSO4Ri?=
 =?us-ascii?Q?LsE9o25Chx1FZmKSHpDRhOYn7ntNADyrA1Nv0FHHxHPzIl1W2CPkfxDNve13?=
 =?us-ascii?Q?cvuT+7/3ubpaUBUrX3vKcN/ie/e8KNyUEtUUzoYuXVvVkBHOB6Uf76G84kxY?=
 =?us-ascii?Q?/xp0xycyZj7iofNwBUNiarIkWWOgOtwsBA5QfA4tLkFlE8nwMPjMYJNsh8L7?=
 =?us-ascii?Q?sg0FOVSoz/5IzLKaNM1qb3xFQpJZ01toUhgty8UONJte5VR3k2XLmhuCB8Tu?=
 =?us-ascii?Q?aUxXOIDadxegJxg8YfxRvdC4Ql+pWffG8xdcO4YrSYQxTOSn4fe69dGQY6OK?=
 =?us-ascii?Q?D1PCJvkR3hSbXkdLQuraHjMH3rjOsFtl2LY8SayVyBaLYoQXvDGOpD8+tfLL?=
 =?us-ascii?Q?gWVAMm8F2xQCtbaHrwoHI/L/+7w61FJDicenXXLfgJb4uHfYr/2Ckmc7tVZW?=
 =?us-ascii?Q?g2GB3fYSG6HC0Zgm2haeiSvOc8TofbNMsSjnlu4loYvZlz3zUqpz3AP+vE1/?=
 =?us-ascii?Q?0SNRTFA+86Bk4smyRFHHgKTFxD/G0FE4pqQVitIKK1arMC8s+CdEboWcEdhG?=
 =?us-ascii?Q?jA2+kSN3NPNfFN0V7/uXYmMM1bbyiG0Ct69Lr2GpH2spPWtMuxDevWBOoQBh?=
 =?us-ascii?Q?tKvQ/IEDkDQvYn5gMpvxKxZx1ha0ZsXs1Wi0dNmQ9sCU9hN0tVhoteRX32TA?=
 =?us-ascii?Q?BVOC1gOE3RYie1TfhU8AZdkCJfVyOz8ogMW9gwVoPjRDiqJQEXVRanwg0VK5?=
 =?us-ascii?Q?30hYC9zrMMkn+E5vcPI30hl2WAQ3ddHwNdZcmG9T7K6KVLVNiM1X+Q3qjSN+?=
 =?us-ascii?Q?OuaobrKOZ3HLqVcnne4YTu7p7MsclocYi07dO4Wg2N1avOS1gy5YA3DYYzGV?=
 =?us-ascii?Q?NS5r5JlcG9jhF6HRn7q/03jebmggxWfz5q/vEkfuixjKmzv6QcNqBssZ6lDv?=
 =?us-ascii?Q?PN4/Oe+BJO5YhvewqO+y7CTSvuvGDiYu3h8qsCbVJKCXOysCkGGf8eXBmCpP?=
 =?us-ascii?Q?afEtGy7LO+L6p2v+pMytMPRP7sfg6rf5BdDZJPLTor6BBK+zsLz/7lmFQM/2?=
 =?us-ascii?Q?9Veok2T0h7EvWDm0IVr5PZ22xllzRKSZHnWxz2rMD63AExV5KxXHdm2BG+cA?=
 =?us-ascii?Q?RrTdYqLtTWsu2ZeBlx9VqplKL0T1ZM9nla6jBjcngmVpEsKZSB5MONofYdaJ?=
 =?us-ascii?Q?VZpZoHHQ/5EeUlAWWbyH2QIyu7Pkb9mjEXPA3VMynyrtS8bwrm46eEixKoiW?=
 =?us-ascii?Q?YvzKcLPkVDnzl7gzH11tXYYHft+6zLZhMLCgSwgrf34mcpWS1qJUuJiFzL+d?=
 =?us-ascii?Q?BjYJx3WzpM9/pQBfVAxcuVB7nYFwxvPbMSiDhBkkpVQV9BrX79KBiOquwg9C?=
 =?us-ascii?Q?Uu+3NOPmpSOG2LMIslJr32RinsMu6YVAnpBVwRbH9jh96OJKRjkr5hqZdfxW?=
 =?us-ascii?Q?kbZz+PqKBVdQM+/pmrkxIGj85VMqeOHer0ajP5Rd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:52:23.5405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881ec57a-fb49-40cd-a996-08de534a3c32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731

cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
writer(s), however amd-pstate depends on fetching the cpudata via the
policy's driver data which necessitates grabbing the reference.

Since schedutil governor can call "cpufreq_driver->update_perf()"
during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
fetching the policy object using the cpufreq_cpu_get() helper in the
scheduler fast-path leads to "BUG: scheduling while atomic" on
PREEMPT_RT [1].

Pass the cached cpufreq policy object in sg_policy to the update_perf()
instead of just the CPU. The CPU can be inferred using "policy->cpu".

The lifetime of cpufreq_policy object outlasts that of the governor and
the cpufreq driver (allocated when the CPU is onlined and only reclaimed
when the CPU is offlined / the CPU device is removed) which makes it
safe to be referenced throughout the governor's lifetime.

Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v1..v2:

o Updated the kdoc comment above cpufreq_driver_adjust_perf() to
  reflect that cpufreq_policy is passed as an argument now instead of
  the Target CPU. (kernel test robot)

o Added "Reported-by:" and "Closes:" tags. (Mario)

o Collected tags from v1. (Thank you Viresh)
---
 drivers/cpufreq/amd-pstate.c     | 3 +--
 drivers/cpufreq/cpufreq.c        | 6 +++---
 drivers/cpufreq/intel_pstate.c   | 4 ++--
 include/linux/cpufreq.h          | 4 ++--
 kernel/sched/cpufreq_schedutil.c | 5 +++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5818a92d96b9..455e58a9b738 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -697,13 +697,12 @@ static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
 	return policy->cur;
 }
 
-static void amd_pstate_adjust_perf(unsigned int cpu,
+static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
 				   unsigned long _min_perf,
 				   unsigned long target_perf,
 				   unsigned long capacity)
 {
 	u8 max_perf, min_perf, des_perf, cap_perf;
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
 	union perf_cached perf;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50dde2980f1b..28b82c2eb7b3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2225,7 +2225,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
 /**
  * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
- * @cpu: Target CPU.
+ * @policy: cpufreq policy of the target CPU.
  * @min_perf: Minimum (required) performance level (units of @capacity).
  * @target_perf: Target (desired) performance level (units of @capacity).
  * @capacity: Capacity of the target CPU.
@@ -2244,12 +2244,12 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
  * parallel with either ->target() or ->target_index() or ->fast_switch() for
  * the same CPU.
  */
-void cpufreq_driver_adjust_perf(unsigned int cpu,
+void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
 				 unsigned long min_perf,
 				 unsigned long target_perf,
 				 unsigned long capacity)
 {
-	cpufreq_driver->adjust_perf(cpu, min_perf, target_perf, capacity);
+	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
 }
 
 /**
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec4abe374573..8d25f0f2925c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3237,12 +3237,12 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	return target_pstate * cpu->pstate.scaling;
 }
 
-static void intel_cpufreq_adjust_perf(unsigned int cpunum,
+static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
 				      unsigned long min_perf,
 				      unsigned long target_perf,
 				      unsigned long capacity)
 {
-	struct cpudata *cpu = all_cpu_data[cpunum];
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
 	int old_pstate = cpu->pstate.current_pstate;
 	int cap_pstate, min_pstate, max_pstate, target_pstate;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0465d1e6f72a..fd26b3a4aa28 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -367,7 +367,7 @@ struct cpufreq_driver {
 	 * conditions) scale invariance can be disabled, which causes the
 	 * schedutil governor to fall back to the latter.
 	 */
-	void		(*adjust_perf)(unsigned int cpu,
+	void		(*adjust_perf)(struct cpufreq_policy *policy,
 				       unsigned long min_perf,
 				       unsigned long target_perf,
 				       unsigned long capacity);
@@ -612,7 +612,7 @@ struct cpufreq_governor {
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq);
-void cpufreq_driver_adjust_perf(unsigned int cpu,
+void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
 				unsigned long min_perf,
 				unsigned long target_perf,
 				unsigned long capacity);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 0ab5f9d4bc59..307f3076635e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -461,6 +461,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 				     unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long prev_util = sg_cpu->util;
 	unsigned long max_cap;
 
@@ -482,10 +483,10 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
-	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
+	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
 				   sg_cpu->util, max_cap);
 
-	sg_cpu->sg_policy->last_freq_update_time = time;
+	sg_policy->last_freq_update_time = time;
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
-- 
2.34.1



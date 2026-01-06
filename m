Return-Path: <linux-pm+bounces-40268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A64CF7134
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 08:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B360A3090A49
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5396D30AD0A;
	Tue,  6 Jan 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jzfVqHUG"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDB309F0D;
	Tue,  6 Jan 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685038; cv=fail; b=ts0U7sTNUTz70r/dbbxwJ/bssixacwXPNw4nRV+lLt6uPLLSGDuwKeD7PYXMK3URmdiOU0yHkcS57pjtBO4wB0j5PLLBqIdu6G3czeugcoFkcxUIB4Pfk7PApH7RSFjR0cuXddwfKWCMVmCl1LrOdQ9NbC1fdBnXmWg51CJekmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685038; c=relaxed/simple;
	bh=6SzxRa1LZhGGAdIopSAsbN34jCL9MjCFJqD28BwiXB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSyXcqcUKb1wfCl+DLLdK5+u0nFjsywUd6SKunNkzN4MSFNROI14IElsFA0ecxrqy8ZFvFNc4muNrlv3RUtYrOZiV9TBLyEcuRI375HBsTNXQq89GNYD/lqven/zBlVjqjT5x55ZAhSXBIX7JlXb2MdF4C1beAjN8ziHfSI0jdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jzfVqHUG; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1vyNiHY5gjJg4Wv3Bh5fNk7iRmIko9qfeLOoEqixiuMB/5FV+wt1+HYTY4/dSX0Snzh9hT9oEDJ+UOLbkiIIroH8aqKJ4GviIVAWp15roDbUOgyf1CBzVqkCqN0GXYGIjFFHXdz0c5cDV9ud5FJUoge/g8JNmSxyGaG2Jb0X2TMqCdc1sW0bER3Mh2knVomIcOt4bYds689yG9YDpPej/qWhv6VBI5X8ED+rCF1qmKi0jrFhJVtgkkDEWGwrifyoxfs9kkIQT880S8szLpdZl+1SsdpOhoyu7o28pBRyNltEoW88h+1AhgQD0urVkLoSUPLZeETRWK7+7GYJ/c+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3kgHTKrBU5x4ZhYXd7n8Yb2GCtEZLBPZtunWwAWUnY=;
 b=i+oXnQBNsGltwQ5W7xuUunZVtU3yi5WWmftbdt1NIKA/Vij1SX+fHki+C1/S4kljnXJfV9j5REB548Ogv+BH3u5+jdI5bFW4U5gkbLBOiaIfahBTaorS33tKIpG+LkueL3KCbtiaNdz70rKPu8G9h/TJYXqg18lnlYgejLbEGsHawb15AyQFcVb5M9U+ayQImO6LdqkKUV6wnf9y3RqMLiTU5iMqywk1IDu2On3ud7rPy7PLFRKjV9BFzxMD/qSN00T1X3IMBvICq1CV8k/oYsXnSr7i2vMKFh1SOeWQ8DqQrQl7WUtO50BhOoh+m/Jcokjg4N/igAhbHzu0drNjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3kgHTKrBU5x4ZhYXd7n8Yb2GCtEZLBPZtunWwAWUnY=;
 b=jzfVqHUGjrjiKrPA4/QWwG0zxFIRI7MKuJW49thBcJWoMrJigSN+uA8cUrviWkcD+cdjRihoB/B9+fix0N/KM6lWJPXFV9iWmQFW+dKtd/+m4+zgoAcFg3zjoWEwu9UsFpE6Ee1Bzx1KFCKqbHgbXjC8HZ5U1kDngR8HvXRnNio=
Received: from PH1PEPF0001330A.namprd07.prod.outlook.com (2603:10b6:518:1::19)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 07:37:12 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF0001330A.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 07:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 07:37:12 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 01:37:07 -0600
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
CC: Perry Yuan <perry.yuan@amd.com>
Subject: [RFC PATCH 2/2] cpufreq: Pass the policy to cpufreq_driver->adjust_perf()
Date: Tue, 6 Jan 2026 07:36:08 +0000
Message-ID: <20260106073608.278644-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106073608.278644-1-kprateek.nayak@amd.com>
References: <20260106073608.278644-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 251d0c4f-a1e6-4c9e-88fd-08de4cf66818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vKLAApL26tOVyHalY0NR5dqywPTyuJ43S3O6HgOTWLGvc/lJYDWlwD4CAdee?=
 =?us-ascii?Q?q8hWNdKXY+zmCFUwWOELbkCiuxzDz+4fF4j10swJyMdaq/fsLmUM3mnMMO03?=
 =?us-ascii?Q?q54fRDcptRL9XM2rBgIWhwQ8LYSHyQL8H8xhJxrkJWQyRzJ5RdiJK2vB6xPN?=
 =?us-ascii?Q?nWlnJo0vGAZDZcZ01xM2Sg1TZ5GyMrQDUaB+qtwBgdfyTUMrwQ+/H1/CNw/Z?=
 =?us-ascii?Q?vDjfLzn42Z76IBPFM3cRZ8yEM1X7PGg802kbYZcxdadoDd8N1F5W7iYwW/HA?=
 =?us-ascii?Q?okPkrgxIqYxHfUq2IrBx6HsoMKU/yZHIwTZ3I/IrQEe3C0cPv2v3CbPDXb8i?=
 =?us-ascii?Q?8uYCLHYfearxRHGAtC2h7lrMR3n1hCNQ/5Rl1npttmfYrvvENJ1q2+xNIDlR?=
 =?us-ascii?Q?UYfmavJhPj9H9iMDsjRNbIWHdd2bAnqTYmUTAQfAhjawvQjIApebwa+djT+n?=
 =?us-ascii?Q?BvZu7TNuLxSpHCKMhf/RNwYs69cGZaeAy3dqhcFTY3KlURFL9nHEdJTMlnep?=
 =?us-ascii?Q?LliBHGFd0eMnS5aqmgMz2e/ofNyfumBi3uL6i3K++lu6+RxNKYChnHQivWQv?=
 =?us-ascii?Q?LZfo/ceb9Q2KuTFME2leYDhDmX/erXZXdQ3x3xvoWUW85I6yWQj7GJJPYbJg?=
 =?us-ascii?Q?xT4nVtP6Q0W6oTzfsq94UUo2DrjaXtVygRrxxT1pOzDbGv6QQo/7eEYMwsGO?=
 =?us-ascii?Q?Blp/opLjF7CQjG0tzCs6vSbdnvFBDXEFzl/EldZTw6YSkMLa6u0Xl4VfY/Rq?=
 =?us-ascii?Q?l6+bZYsH9Pk+wSh7aZdwdfsrnk3gFC8MB6dvRW9OU0gFDdPK6FiXKnBBrhkN?=
 =?us-ascii?Q?76hE6dH/6gBZZoUcXo7sDajI2jzUOXxCnmoqlQUylydpMWPP2pZLBB7qMsTI?=
 =?us-ascii?Q?a0hf7IUVoe7sESMdooFXPvKouqpDFj7tnpBn90IWlq4zqOljjlUyxUGYQQSv?=
 =?us-ascii?Q?jxQD9fD+pOrfhassS64ZaHDCt0s2tIMfqWIYg8rCmawnAPxz2qWrg8r7mLjV?=
 =?us-ascii?Q?kVW7xoG72FxV0Jjg0wbYDqGcycCXNbY3+ADBaMFF0WudSWGsVVIITzUoBYRt?=
 =?us-ascii?Q?JTevak8aIUzulXWrV54OnFbzoBim46FTYDdo2P9g07kn+VMnzVMwbMTrJ+Ia?=
 =?us-ascii?Q?5u7uWf2H++pMDWQTdCc7OdhbsmEvCAH+iKDmkILTtgmnYj1Bx6zcyAHh9w1Q?=
 =?us-ascii?Q?Zbd8YxqFpGWTpI4JYZFExAv5wBsKHVhKOFNr/cjEsy7X80whsFyvzSy93VmY?=
 =?us-ascii?Q?pSCP/ZxgqaaOATnt0GqBc8cMrQcU+8ZR0u8E77FJ1/UrshS92dmTGOKcGa1N?=
 =?us-ascii?Q?OsmMFIuFCtKPIXZra50eSgLyUH2MG0uwc8QLEe59HT6QgVfXIOopoJkAfucC?=
 =?us-ascii?Q?IeNsAJ5p2tJe4I9uZFEfZ49jHpYoe05CMliY+SQ1CqWKU2rRNFplfkKa3lY7?=
 =?us-ascii?Q?uBJs58DPSp3s3+KvHdu9naSz51oARaQrx55mvH7u817cV6IMpafK4mDz+lhB?=
 =?us-ascii?Q?uYAsKCN+kbGb6hUyjYIrRx10xlTyPUBUspW9GeXO8tj5xVF1QtD6STltpx6O?=
 =?us-ascii?Q?gSS/vToWhXVCNaniuxzBaTpRFpYcrmm5r4/j/moP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 07:37:12.4385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251d0c4f-a1e6-4c9e-88fd-08de4cf66818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798

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

Link: https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c     | 3 +--
 drivers/cpufreq/cpufreq.c        | 4 ++--
 drivers/cpufreq/intel_pstate.c   | 4 ++--
 include/linux/cpufreq.h          | 4 ++--
 kernel/sched/cpufreq_schedutil.c | 5 +++--
 5 files changed, 10 insertions(+), 10 deletions(-)

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
index 50dde2980f1b..8bdc8f9b8d86 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
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



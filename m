Return-Path: <linux-pm+bounces-40971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EDAD2C986
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 07:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18605302D915
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 06:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1834DB67;
	Fri, 16 Jan 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jRjW3Y01"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87A34A788;
	Fri, 16 Jan 2026 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768545221; cv=fail; b=lBPQOtMiFbYwf/4MTktxx9V/NweeGY3Am0mjGE61FPIG2TZKGYh0C7FvQRIFFWW3kPGeNiSSp1Zn+wQQSH/7/ZF2G3eMFPxd9cUkZDP3X4SZ2lsxdbqFqaTuqrivFfm2lO60G6GjzQMuaFl/nZgjwetMOT8PY6eo1tXM4GDKU+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768545221; c=relaxed/simple;
	bh=/i/DVuF78hxcdqWq0VhW/s09bIYcsOTnpqz+QiLiP4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXCckU4NfiZBFXDXzEHRMvp9LQixoW8BwNvo18Qz4fb1gyvkOFBNrnWAjzcgcH97ytumtKDn3HiBoTR9pHteJg9EgMk5CH7Xm1/Ga70T0gb3/aYdpy83gWqdBV0MKdbq1/PekkAMY4KmgrtiHVo9SzVxZwumSMGwvgBSYJOMPbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jRjW3Y01; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaCu0//au2MsNmWJLGfUnSuv0sThr0mp8dqM1hQv874T+KDxB/R8osagY3EG1srgeAEvjpzuRphpuyFTjQmw78Z2Oqg7UL+6B9fKlMKNnUg3oz3y/kXj7vJviemkju+9JRPi78Fg8mEGmmiD5pd0g4l/TJOPAXXgwIMCAI3HBtZbaBLK05FwYtZxU7HoM4Dmc2MLJz0Qm2OM0XdpJ/Gl3WGDZvuf0PWBh6Ow5vDd9aaeQwtVxaS8WccQ2A8Pjgoyk21/5W+dPTSl/6AywoFjx4Y0ifHZsIJn8pzWZkREcy//kfdd4yUmRQrbrBmVz42KbsliVBrHL/r2rGFHdOUYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zSI4Fynfnzj17lneq7kb45E9S0Y7MNbEBDXtAgAG6s=;
 b=fU7YZOY2X4z9oswgXlaniGAfnf6CnhhCtij4xx+s2Hf9XWX0tqn4dhQNxtbGyKW6XqVfWYrC++oHv2d91SFDCFrk5qnhLFg+xo2iKjTijBCIaHrJwB/yY30ERCYshBY8R7C2ZUJCW+J+DrXxV9LHDMRdYHUsqkkKz1wnzcPw2oIr6hzE6W1Lp4Akncc6nTqs05tNrpoDFhWWQAOtK7MxSgKA3wSDZt3da/yWPF0hjOGFA8tuiRQcuu0O7OO47oFTC4MKRkTwYYJCLmYb05sJJQDBe2IXCPvV88E/nVWIE8tc9JClSnM3AS0jW4YOKn6vM8Cd1K3YkNoMMyJeZJGtXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zSI4Fynfnzj17lneq7kb45E9S0Y7MNbEBDXtAgAG6s=;
 b=jRjW3Y01h92MqLHEfRqIDPaI8wptG9eV2kmVGyU779gDRDKAF2jZtA9bHBfmuI6Oi2XkceYXdKMyCp72f9WhSQaEkpuuVkDo3vCMyD4y3dLwzJROgHE+hvXbNMpCvbnl1UJcp71fsaFWZqerZzE/odW/oWSSgUpVtQcM+IMbo5w=
Received: from SN1PR12CA0093.namprd12.prod.outlook.com (2603:10b6:802:21::28)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 06:33:34 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::e5) by SN1PR12CA0093.outlook.office365.com
 (2603:10b6:802:21::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 06:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 06:33:33 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 00:33:22 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <rust-for-linux@vger.kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Miguel Ojeda" <ojeda@kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>
Subject: [PATCH v3 2/2] cpufreq: Pass the policy to cpufreq_driver->adjust_perf()
Date: Fri, 16 Jan 2026 06:32:34 +0000
Message-ID: <20260116063234.24084-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116063234.24084-1-kprateek.nayak@amd.com>
References: <20260116063234.24084-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4c033d-a49a-49a6-8a1a-08de54c92c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWsKC+dsPK027prVTHnov3qst7882sYj4xbRD1FFwnqdKwIKPSE9Iwr3KPFe?=
 =?us-ascii?Q?50dLbgeSQFGdEecL6HKQgcStSxAbkirqhkjC1C63PEHI/Tr4QT8KnHyUDNM6?=
 =?us-ascii?Q?TjUIB8mOZEzJCZizN7ikZHO//ZrmFaFnHNh5yLmGqko7E8H8fqcVPpxxbhNu?=
 =?us-ascii?Q?CO6EX1dCnUSA0UnBKwggsxU2FNHoUgOww0NoJAoQyBKu8jgzhECFKL/Qsizi?=
 =?us-ascii?Q?fN6l4+3CfhXwt/HNlUJipXIIiGIT09vIr/i7bRIq3s33teNGN9boMmLF2UMO?=
 =?us-ascii?Q?vlS8nihXU8jzwCIMcWWn6UVH+IV38gRd2QraxO/BzlBgFZlN/SYn0KdhGcEP?=
 =?us-ascii?Q?vKyCni6xWdfbzqiZY2axAFgdA3IEt9z2nCySguPrkeO5AZYToiP3bjADGr0T?=
 =?us-ascii?Q?9E7jC/fDFiHvdiTCwiW4jRwcaPYkBEQfLEJuWkFBSUo41VkzSC1b/g2MZXfa?=
 =?us-ascii?Q?a8e04/AnXhCVXehA7RGNo2d3xQ8/Vf9JT5C1Lz1fKI5GVRJcDzcCRLdaD4rs?=
 =?us-ascii?Q?rMpt108AqxS9zsF3qOiZHz5DXH7GjKDFrh3Q2i4nUxeH/0ARVrzquTmoH6aT?=
 =?us-ascii?Q?ImDOfk6q3bcg2VSIi5RqjdOWVRPgMCo7taGAoV9fBR6Zaf/0FQjQ9B5u0u20?=
 =?us-ascii?Q?c6r0w4Y12PD0eUfq6RoZX3izioIoQqhFsbR+sG6BrZ6jVjdElHmXVXcAp/SG?=
 =?us-ascii?Q?pacsG77RKD4HdRwGq02IYNqLhuHHeoSfV+NmDosztD9BLFz/2wZASIPWQPoW?=
 =?us-ascii?Q?F0NyosqZ75np2Ts3iLkPS7EP1NF8h9X/hAzpr+7g69vWyM2QJdHpcYBaQPpQ?=
 =?us-ascii?Q?1Ex6pWcVx086hsEakKxXrW2NIHGud+q65rI+aOA191RFEOaBWoFd7XszTq1e?=
 =?us-ascii?Q?2FGLj6ycu6Xx9h0GJ009P6xHIB98X3pa+HNrgtdc/u3+ndnKVs4GDIFfWmhI?=
 =?us-ascii?Q?u1H5JsoMszOHbXqn1RKb4Rk2PvOEPHKWNh4FWe2R4xSSfAUxqFAQBTyx9zcj?=
 =?us-ascii?Q?D8LhIDtbTokEbA3FtB1uByoPFFjvmuX13++g5OlZOx+m1u6cg3iWv3lBW1v1?=
 =?us-ascii?Q?BqvBEGcD+CCGm+HQvx7CL3QrlxH3swcsuOafUUN0RxhMtu+qxgZf5B6NVxlv?=
 =?us-ascii?Q?sHcpIm4BGb3eU6An3m/5VMcpmlNRmCnNIIRpgkQFt9BGhQKl9AWU9tbA5Lzc?=
 =?us-ascii?Q?XInpzObAh/efqLwcFQfsxVMVED60MCUj4sm9A4erBoyfqYcPmV+4aesCGnNy?=
 =?us-ascii?Q?g5pIjBVVi6C7SFmp4UqUqaGV8DNUY+t1J1GAVG7oM7UL7edO46rQP5eV206H?=
 =?us-ascii?Q?rKJiGC4aycJ/qNgP4jLeTn7mhiKVUedRVg+vOHef3WStNEzL7Yuzj79zutiq?=
 =?us-ascii?Q?A0IXBtpUBOQ9TGryhqGnmu9TKN33xTGMvwE71lQ8YdcqDDw75Y8mcY0Unh5G?=
 =?us-ascii?Q?R8I3tyn2MtwoL9TyFU3gIFRCDQgrZucZxVRUm5f3xSo4d7CNpBXNigIQoJ6J?=
 =?us-ascii?Q?8NjpOplWj8JqvY5qzRogeKVn3Tjn48INcUpFhIT8+HOPFuvbGQQwX8SHcTLS?=
 =?us-ascii?Q?+n05zfQtFg6YYog2aaDJIgRyLZhIO80bbm+I+VrmqmbtNsKOZlaB9ZKZvz+J?=
 =?us-ascii?Q?7zC2urW9/52IG7eYA73Dnzc3h79gpZwE69FM9RVHzrtgu638cpdZDhjdx123?=
 =?us-ascii?Q?Dz/HNfKlOquEI2/wrKkadgEt3dE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 06:33:33.7512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4c033d-a49a-49a6-8a1a-08de54c92c18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

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
Changelog v2..v3:

o Fixed the rust bindings for adjust_perf_callaback (kernel test robot).
---
 drivers/cpufreq/amd-pstate.c     |  3 +--
 drivers/cpufreq/cpufreq.c        |  6 +++---
 drivers/cpufreq/intel_pstate.c   |  4 ++--
 include/linux/cpufreq.h          |  4 ++--
 kernel/sched/cpufreq_schedutil.c |  5 +++--
 rust/kernel/cpufreq.rs           | 13 ++++++-------
 6 files changed, 17 insertions(+), 18 deletions(-)

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
+ * @policy: cpufreq policy object of the target CPU.
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
-- 
2.34.1



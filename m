Return-Path: <linux-pm+bounces-40969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADE0D2C944
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 07:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6873E3038391
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765A347BAF;
	Fri, 16 Jan 2026 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mfXjkeZf"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DC2D6E55;
	Fri, 16 Jan 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768545177; cv=fail; b=VtaSwuOT1H8CL5RLFvtFduDlhkIhVGrzm0CUU/vd1BSBaXyyVWMyO7XOhWX78ANWPmVgx/mqC5dgV3qA3qdJNbN0dhHtUc2BnLbV14o0KieoTDV1A/9bUC8Nkm6xpNVTwtqhXCnW+3udltKUKqWfRehsuD1OJ+Gh86ANqeeM53g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768545177; c=relaxed/simple;
	bh=Bq0a9waL62aEU0/o6H6ZpFaZuLSi0ndwwvuz08BCGzo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vD+qfEPDbWVPrhiaMUlrx1HuJ4B6XCzCWIBx4Mo2bMfo7Owc1XdWlKfElwqFCVvrxQ2W3GcvRIbzZFiodpMTELzMDctkj/ShI8zSdBod/AylcSfVkYNyRI9J/pvfZuHGLpVJjeiViM3yH30HnzMBUCMZd/q8C1hKdFU5jnRTYIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mfXjkeZf; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6O+C7c4TziuJkfeQPoOP9k883m19tQX4KEwsTTDHHYTtSmOqhYlHS0pK/0HHuMFAnLxB74ofAKDkHA1T7QyJ0ItAFtTlibee1cZWWM+3Eveu6f+C/Vhw+GvSC3dOvAYSZVlPVXrMegF2LLCvsRcuCgVrOYtU5HAMUa51VFCsyvn0Q8lHqLbiM7pMZWi0Cky7ZJRDjWh973pXEvD3yywNGABsNT2ONl3YAvDH/A5VN4s9Ns1tEkmQCjMu8khCDgPWLTyiNCiQlc7yPYf3ghWTjBSgEjRpAvbUI/pGJRCwTFZyw4pRyAxoMwoQvP6tYwRD4iZBb3sevOHGpZBJWcrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRE9sfcz2GZfzQj1lmyzRXH9rbBAdrvWn5c4eLx010M=;
 b=v57vZ7CIB2vwLQbly0VRTC7fkCuLi4dIKjvnriCo+etqA+MgbzrzBJ5dUiQuXCPMEjsHaoQpIWDe+5+Iri7uLHzCBPijulufZUYc6JVIUE3l/YYrQ9gKeA3HmzOQgea+aiWAHJaRbUHOdO/J0CO0FElaScUrkW+TJUcAdh7d930rPZpAAHp+cTxlJlgsbwt+S737CnevAzEl4XzS6oF2Gu5i8JVDdAEZSe+i520vr3CMfKonZ96hypdqDbyK170zlnGEI7GHuiQ4hjnHMwM4KDU5UYsP912ieoLgvs1Ly3TJMqjuk/U35pkPsTLzxJQdGFXCW32ogxYjlAnHc98jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRE9sfcz2GZfzQj1lmyzRXH9rbBAdrvWn5c4eLx010M=;
 b=mfXjkeZfr1cbRYeutUbwqv58Lrem/XMpUX0zbZorfI5+x04pxVFF93NUl0WDwCI7heG1HOsB2Y0Cy7ZO7q/39LASSXdX103dWJO0wTT+hTE9P4ke1bAzGWm6T6fiTHy7iKIW6Ggh0cNUzECxLf/Kv228IOQ330F2rOncnSulK1I=
Received: from SN7PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:f2::16)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 06:32:51 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::b3) by SN7PR04CA0011.outlook.office365.com
 (2603:10b6:806:f2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 06:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 06:32:51 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 00:32:42 -0600
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
Subject: [PATCH v3 0/2] cpufreq/amd-pstate: Prevent scheduling when atomic on PREEMPT_RT
Date: Fri, 16 Jan 2026 06:32:32 +0000
Message-ID: <20260116063234.24084-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: cd37f0a3-ee9b-4ca3-b1fa-08de54c912de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VBznT9snlDGJ0XFaqf1xw9UqH4rjUC/+N/1VFiuvguYpWOnHVnmBtM/bN7Ti?=
 =?us-ascii?Q?XPXUt+KuCWKuHxtJHlGfiaB9LkKN2bG6znWUelE99nl470fbmo2V5aD0tSjM?=
 =?us-ascii?Q?mXMK5rs7iKXKbDUTh12XMga5UK4nUsqAwGhCRRCJjNA+4dIdsR5XMMBeNPDO?=
 =?us-ascii?Q?L1l+cmlG3XuoQTRe+DzbHxVl16xMgJ/ve31/Uqbc+ADOTrywpsIhHX5+FDh7?=
 =?us-ascii?Q?K/l60WCmSIKzBYSsfb1G2S+KWxuh3/5BH5UcpPUoxUaTz3lYofGPUsT1KqVS?=
 =?us-ascii?Q?eGgtMuYU9AtT+QLpk3AnPaka8KhqRJJhr4BjFkrLADD4BUfnOX+SXp+pAN1k?=
 =?us-ascii?Q?UxXLVS+nk3wxvdpTN/wacwCXvLvKmrJ/5ihPb5MMw3GK0YEwlP5Pbc/YONey?=
 =?us-ascii?Q?iQdVLCk2aZ4BTNNI/sC/DiP0K/W2QYKQkKpV+mFHlew2CYCei37lpaIz3zak?=
 =?us-ascii?Q?7b4ahAooJkKKEVfBmc5T4ExEQk7Cnm3oeEGrtvIzkLiVkewI2B/ybUbaf8fm?=
 =?us-ascii?Q?da0WYUwL2A5htuYHn7QocvPj8Prt4i1BNI71vjq7i7jc4K9e95Frlyrd32+Y?=
 =?us-ascii?Q?ozKOrY9N8DEMJnkEK7NkVSmKMIaN+OY3wGT0u4tudS5QeHwG3kXdAkMmDylZ?=
 =?us-ascii?Q?87pcUI5gogtGkdSMyRf9V7p7KPst71vMaXg2aJ0g8CWiqIz08RoW2tqQPZxp?=
 =?us-ascii?Q?o+zh7nkqxN/u+OYMuZrezCZjfdCKyQgxA2LpHtdXZc1LQkHMrq1/apkH0DTI?=
 =?us-ascii?Q?/0d7V30Mpkw7qnwTmsTrx0DWoVzYlUu7z5drec2qGC6EmD6Sd3kbg1dT4Jfo?=
 =?us-ascii?Q?4dOnp7Exe1z4ezQfr3iC0+yL9XeVCZFUTyVaHw7PwU0LZgWqRsSAw029RkRb?=
 =?us-ascii?Q?orp6PXAWCQ5K+15FCZoFvpaIiTYq6gHlIA4qNhmVncg3bJPYe8SGxgxLXjLd?=
 =?us-ascii?Q?obdEHCmN3kb5E7CE2yTUdVDKrG2/pkC++gJ25t4DG1Z+JDTpa45CTguvMz+k?=
 =?us-ascii?Q?H9htVPX3Xy1W5dPS7+A6pre6YR+BZRbYEIP3gBK3xDqSne3+U17+fZxIILEq?=
 =?us-ascii?Q?qJ/XufgkdpOMh3YuE62kBtPxPTT1Nt5Rxb+y5ANQzFALlZ5ovJHGEwZBrgoK?=
 =?us-ascii?Q?PwbOXUPJiviciFDxnCGCTKtH7U3ABaZCX92YxbFSjF6F3UcsFso9F2w05Dff?=
 =?us-ascii?Q?0wrw6V2ZGJf2ENlHZ4y43jcbg8yvveG4BSpGj9KS0D+9sTqIaNg+S6tgilA3?=
 =?us-ascii?Q?xrBIcIrQbEdBt1/KEwm5NO8mCDd/duqpZPPJyhNtMyyhZsvOqVegDv/puKbe?=
 =?us-ascii?Q?5Rh4IUSHaHWzhhANRnKL43lXpAgbbu7hjVFD1KsjIyeE0eJU3YIgP30189Iu?=
 =?us-ascii?Q?5D86tr6MIy1zKEEbTrKdFdm/0zVoxc9g5GFCNDJBEsbNSpyO7MKQsYMe+JL5?=
 =?us-ascii?Q?S5zrzlWtdypR7SHea26itoZwRW5TIz33fWVYa5B7zT6Nn5we1gY1rWvrKq06?=
 =?us-ascii?Q?17v1KtMF4VBe4glGzp1zUWlg9RCL+qgm/HxED2oOZMR6EE8y5R5wXbSu8MeN?=
 =?us-ascii?Q?OFReup3Bx0Mv0SXCYq2VPuI19NyPAq2Bxp80i5w7ZB5f+cEBa2AO2HsiJHes?=
 =?us-ascii?Q?ca/3P+j7wtkDbUu5lAKocH1Bnx/f6xu6vB9sxHfCS3MF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 06:32:51.4270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd37f0a3-ee9b-4ca3-b1fa-08de54c912de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990

Bert reported hitting "BUG: scheduling while atomic" when running
amd-pstate-ut on a PREEMPT_RT kernel [1].

Since reader-writer locks turn sleepable on PREEMPT_RT, they are not
suitable to be used in the scheduler hot-path under rq_lock to grab the
cpufreq policy object.

Unfortunately, the amd-pstate driver has a tight coupling between the
cpufreq_policy object and the cpudata stored in it as the driver_data.

Trying to grab a read reference on PREEMPT_RT can cause "scheduling
while atomic" if a concurrent writer is active, and trying to grab a
nested reference in presence of a writer can cause a deadlock (manifests
as lockup) since the reader fast-path is disabled on PREEMPT_RT to
prevent write-side starvation.

The two patches included removes cases of grabbing a nested read
reference to the cpufreq policy in amd-pstate, and modifies the
cpufreq_driver->adjust_perf() callback to take the raw policy reference
cached by the schedutil governor respectively.

The policy object outlives the governor and the driver making it safe to
use this cached reference from the sugov data. Any changes to the policy
will end up calling cpufreq_driver->set_policy() or
governor->set_limits() once the policy is modified which should ensure
eventual consistency despite not holding the read-side.

Series has been tested with amd-pstate-ut on PREEMPT_RT kernel which
successfully passes without any splats on LOCKDEP + DEBUG_ATOMIC_SLEEP
config. Additionally, the driver switch test from Gautham [2] was run
for 10min on the same config without observing any splats.

[1] https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/
[2] https://lore.kernel.org/all/aJRN2wMLAnhDFykv@BLRRASHENOY1.amd.com/

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge

at commit d22b6c061c99 ("Merge branch 'pm-runtime-cleanup' into
bleeding-edge") (2026-01-16).
---
Changelog v2..v3:

o Fixed the rust bindings for adjust_perf_callaback in Patch 2 (kernel
  test robot).

o Tested PREEMPT_RT + CONFIG_RUST builds using amd-pstate-ut.

o Viresh's ack on Patch 2 was retained since the incremental diff for
  Rust bindings was discussed on v2. (Viresh let me know in case you
  have additional comments and if I should drop the tag.)

o Adding the Rust and sched folks to Cc for awareness on rust bindings
  and the schedutil bits respectively.

v2: https://lore.kernel.org/lkml/20260114085113.21378-1-kprateek.nayak@amd.com/

Changelog rfc v1..v2:

o Updated the kdoc comment above cpufreq_driver_adjust_perf() in Patch 2
  to reflect that cpufreq_policy is passed as an argument now instead of
  the target CPU. (kernel test robot)

o Added "Reported-by:" and "Closes:" tags to Patch 2. (Mario)

o Collected tags from v1. (Thank you Mario, Viresh)

o Dropped the RFC tag.

v1: https://lore.kernel.org/lkml/20260106073608.278644-1-kprateek.nayak@amd.com/
---
K Prateek Nayak (2):
  cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
  cpufreq: Pass the policy to cpufreq_driver->adjust_perf()

 drivers/cpufreq/amd-pstate.c     | 14 +++++---------
 drivers/cpufreq/cpufreq.c        |  6 +++---
 drivers/cpufreq/intel_pstate.c   |  4 ++--
 include/linux/cpufreq.h          |  4 ++--
 kernel/sched/cpufreq_schedutil.c |  5 +++--
 rust/kernel/cpufreq.rs           | 13 ++++++-------
 6 files changed, 21 insertions(+), 25 deletions(-)


base-commit: d22b6c061c9911a8d0f76c6e902c951455c8c4ba
-- 
2.34.1



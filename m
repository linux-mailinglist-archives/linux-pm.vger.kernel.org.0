Return-Path: <linux-pm+bounces-10970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BDD92E49D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5663E283613
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5BA15B14E;
	Thu, 11 Jul 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3AVI+mLF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E94158DDD;
	Thu, 11 Jul 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693535; cv=fail; b=WfJrOmRO7/RI2PpAC9+YKNnbN6/tFsrWcoAIfPzTCNr14/I8ky+w6c3Ix/GR6lK6xzkRO35j8gifNzcb7GvA5OgG5muTSSCB6oGbs/kAX9QFZTcKHB9Rrg1P6PgB6jQ0ASha8GH6sgdXeAcCgNsILYsdtL0/jIFAL5uzZ2HEW/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693535; c=relaxed/simple;
	bh=gEU2zSp1/XhNFjsY/G9KZYZlBz9JnafmSzYwhygMyLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ny2Q6tmbiboalBKtC4XlBYiLeXaULfLmrwDmfYgiQN8Gv0xEtamfQOcBF75mpzLOgkoPnQoaBjTwENPA+GQEZDk87CCrIMVJnAS/TFJLwaeN6ElmzE0has9epvZZjSstUPtPNhpNaQs2WXAqt6qXek5ePufg632Wq64Kf0eyYC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3AVI+mLF; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF0eDuj3JVTaZNfJ2sLyYSX8u3DI19t5043bpiz5lbkvf0kEhtzsH49BFFbX4TuqQi+YQ7jQkHbo6YOR0HL7G9OJ44JkkaIfWkfFPUektwITwB6KSwsDKkeTMKADCVpoqyBx4DsyIswAlzD28wx0RPKcLLCYLhZV4hbOaA+ceWHhIJpGnPB5BcJ41wTsvVePdYL0FCBl8IkewWJoLmb+Xjb6YYFd93RHzc2BzemAiNtJMZ3vVUmXsaejjD1ocCywZGnMpA2ch38lxER05CJ1ebQyQbszfQjra+O5dOhaqW3B3bqEGf1W4PF9wUynySxA/btmk+HM5EuspIUeh/edVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz5aih4ChjQF0k5a1F91PhbHXzb7m+YVcpwKfwyeiJQ=;
 b=NXPkm9sTrpojUS5OZmzjJJHRgYNiE10XJ+dW5tl4y8lAe+93WClwuOETEhK9HkaqPSmvVYwAR/HiH1NzBx/0GjzHcGmqlIo3Sva8mh7mSqIkAyHN2p0u4UKCJ7MKiyq3CvyLTfRwYZ8MJVQoWaVO2UX5u84ObwekcWo10PfyK8uaFs+ge4ytYXzCDxpgQ8Q06B5zoY2MDJMo5tj9Hb8wA284dKjQlVheYSiJ6HB6p7mtoMcn84/ziD3KO1DJ5xvJWGVCJiSPiMrWeVcw170w8WhmyazbDWs3Qb+rEa9CgZwrBgBiS4JlsNnXlX87yv+dzSUCeyKtCmg8gYXt/7mjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz5aih4ChjQF0k5a1F91PhbHXzb7m+YVcpwKfwyeiJQ=;
 b=3AVI+mLFVlrPOyEu3pixYHFwQsEO5J6z7rpI9Q5OjgF7FUfjxGeCMaf6Ph3TC+752CXc1ib7yrrOniZpvftqPcBZqToaEzYsPgU6P278YkhjNBbQ4B4JJhDQcU0vQPk8zuM0Vh819VZE3yMNdFzQCbBZTsIyfksNfuwUIKfKFrI=
Received: from SN6PR2101CA0015.namprd21.prod.outlook.com
 (2603:10b6:805:106::25) by CY5PR12MB6082.namprd12.prod.outlook.com
 (2603:10b6:930:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 10:25:29 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::fe) by SN6PR2101CA0015.outlook.office365.com
 (2603:10b6:805:106::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.8 via Frontend
 Transport; Thu, 11 Jul 2024 10:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:25:28 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:25:20 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<rui.zhang@intel.com>, <oleksandr@natalenko.name>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>,
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v4 00/11] Add per-core RAPL energy counter support for AMD CPUs
Date: Thu, 11 Jul 2024 10:24:26 +0000
Message-ID: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 41228f73-c5fd-4ff5-3011-08dca193c965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WuQTOMQfJLh12ZWiLbC/XQmVe+32xkyN7S2y1q1s82Wx5o4hvefDSu8Zzzd7?=
 =?us-ascii?Q?HdwSHpp67mYLuQDKN0FZlSXgLvKL+XBnVVmZg3xSDYfBjlFEwxdFEzhucb1p?=
 =?us-ascii?Q?evwTqVnEOcno2kVzOsZ4YEUjj/TL2VhOkwa8u064X9NA5X1KVseU1pErtgXX?=
 =?us-ascii?Q?0HZTZ2exRlzfmrYzauNfbMlVckegz7vkyCfd/RBEQxQ2vAa9hOM/PqA2ykcz?=
 =?us-ascii?Q?t3RvBgbA3KdxxXGuHDR7OdsCLPrcZEbVd9AamsOoTLKPPzdxPB1KuBtCvfX2?=
 =?us-ascii?Q?NTltJVNEenpSvoN7kKUO3ALmP0uiGFAM/GBtJB8pslohGqhu+BxdAvwD3/dJ?=
 =?us-ascii?Q?39XhV1Rxf1wOJvD/d6/P8wjynqKXHx5q1JC6pMoKNAwzI7y3lOUxQAZ8s64A?=
 =?us-ascii?Q?Z97mohsSdaVRBuSR/n+NwsCP+UaYhrMFKIjUDb/keKoRK6wwTOsFka1Gw0dk?=
 =?us-ascii?Q?BXQwez39mu7xNBUdks/gr/xb1YQqxlTGnN+SBamympsJRQULKCpvYSgsdi+v?=
 =?us-ascii?Q?td5b5IrPE9UIQsDRIc2F0BqEEhCYVzZHNzt6J4P1w/s9SK7gdK5jR2lV97A7?=
 =?us-ascii?Q?ULU7soOcqL4pmRcYRu25HFHwbaS9qJNZ6mAdh4hMLRWO52ZaHqCJoTOeYdoz?=
 =?us-ascii?Q?RySr/T56auDJNFGK4HNLsy08bfq2VM9XUeJNR8utFHTmq5J4Iwwf1WHviPHr?=
 =?us-ascii?Q?yUuBqbRfBNbn75qnIVBqHMTT5dGwinCfsylS8yXgJXjYdDSTA8dPsBYDLc9g?=
 =?us-ascii?Q?ukq3QngnianKduF6Brz04NpX9nfm4ESX3N2ANrhfcJzjZwLPa1/pk5u1pwjm?=
 =?us-ascii?Q?8rbxFyBS7MEf4sTUyyEsgOKSvSARqYfTkTA7xPC+FJaH5M5fW+cmbf/Lzgs8?=
 =?us-ascii?Q?Fgfz7ErSqXJwxwOd0dSwLC3P7iBhsO//rZWn/9bCdo/BjrXzLIlN/Ce7N6hT?=
 =?us-ascii?Q?3Y5iMTXyLEgsgbVRHePnIJ5KVj6B7HvLZ3i7aUyTIVs/WAWijD26o2FG2LMo?=
 =?us-ascii?Q?JaIUapTi2GxgzA9KPi04yc9gHsVyBk4Wqp9s+3ZAQdRtDH4bB6DOaAGQRokN?=
 =?us-ascii?Q?nRVFDhE9fd72n3Fby+G8jBsDspoqANEQx8A7BpQYRI98y0Nwb7MfFjQA3cWS?=
 =?us-ascii?Q?vL2EELL0v+gVa/bn/piWKAKCJz1qK4O2N5MIOKk1f4D3fo/BPPQbl2+HLC6c?=
 =?us-ascii?Q?rdErviTpdyPINFKzkjuaaOU/AsAb68Ae/5XYCfq/pCJrpGbW3UIBMpUbXgob?=
 =?us-ascii?Q?uTzcHtwd27hfI/+YY8gybfRplVD/FP/fIDjhU+X6nOSIG/ttUgtnmPMhEsvT?=
 =?us-ascii?Q?Byu/xCOaoG27+RjrhIKCzRoEk8Cqzllz6j0j26qeiO0/5LgK9lZV2dMrp2ge?=
 =?us-ascii?Q?Lm6/dfEZCJ0Bw2EJFZDjW0IO/V0qF3MZE0xfF1VQIj1bXj8tVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:25:28.8540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41228f73-c5fd-4ff5-3011-08dca193c965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082

Currently the energy-cores event in the power PMU aggregates energy
consumption data at a package level. On the other hand the core energy
RAPL counter in AMD CPUs has a core scope (which means the energy 
consumption is recorded separately for each core). Earlier efforts to add
the core event in the power PMU had failed [1], due to the difference in 
the scope of these two events. Hence, there is a need for a new core scope
PMU.

This patchset adds a new "power_per_core" PMU alongside the existing
"power" PMU, which will be responsible for collecting the new
"energy-per-core" event.

Tested the package level and core level PMU counters with workloads
pinned to different CPUs.

Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa 
machine:

$ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/

[1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/

This patchset applies cleanly on top of v6.10-rc7 as well as latest 
tip/master.

v4 changes:
* Add patch 11 which removes the unused function cpu_to_rapl_pmu()
* Add Rui's rb tag for patch 1
* Invert the pmu scope check logic in patch 2 (Peter)
* Add comments explaining the scope check in patch 2 (Peter)
* Use cpumask_var_t instead of cpumask_t in patch 5 (Peter)
* Move renaming code to patch 8 (Rui)
* Reorder the cleanup order of per-core and per-pkg PMU in patch 10 (Rui)
* Add rapl_core_hw_unit variable to store the per-core PMU unit in patch
  10 (Rui)

PS: Scope check logic is still kept the same (i.e., all Intel systems being 
considered as die scope), Rui will be modifying it to limit the die-scope 
only to Cascadelake-AP in a future patch on top of this patchset.

v3 changes:
* Patch 1 added to introduce the logical_core_id which is unique across
  the system (Prateek)
* Use the unique topology_logical_core_id() instead of
  topology_core_id() (which is only unique within a package on tested
  AMD and Intel systems) in Patch 10

v2 changes:
* Patches 6,7,8 added to split some changes out of the last patch
* Use container_of to get the rapl_pmus from event variable (Rui)
* Set PERF_EV_CAP_READ_ACTIVE_PKG flag only for pkg scope PMU (Rui)
* Use event id 0x1 for energy-per-core event (Rui)
* Use PERF_RAPL_PER_CORE bit instead of adding a new flag to check for
  per-core counter hw support (Rui)

Dhananjay Ugwekar (10):
  perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
  perf/x86/rapl: Rename rapl_pmu variables
  perf/x86/rapl: Make rapl_model struct global
  perf/x86/rapl: Move cpumask variable to rapl_pmus struct
  perf/x86/rapl: Add wrapper for online/offline functions
  perf/x86/rapl: Add an argument to the cleanup and init functions
  perf/x86/rapl: Modify the generic variable names to *_pkg*
  perf/x86/rapl: Remove the global variable rapl_msrs
  perf/x86/rapl: Add per-core energy counter support for AMD CPUs
  perf/x86/rapl: Remove the unused function cpu_to_rapl_pmu

K Prateek Nayak (1):
  x86/topology: Introduce topology_logical_core_id()

 Documentation/arch/x86/topology.rst   |   4 +
 arch/x86/events/rapl.c                | 454 ++++++++++++++++++--------
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/include/asm/topology.h       |   1 +
 arch/x86/kernel/cpu/debugfs.c         |   1 +
 arch/x86/kernel/cpu/topology_common.c |   1 +
 6 files changed, 328 insertions(+), 134 deletions(-)

-- 
2.34.1



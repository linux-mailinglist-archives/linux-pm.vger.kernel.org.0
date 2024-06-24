Return-Path: <linux-pm+bounces-9866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 222AE91425D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BC41F230D3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A718E25;
	Mon, 24 Jun 2024 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="spM9iwS0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E771D551;
	Mon, 24 Jun 2024 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208782; cv=fail; b=FUbn4sJP6rD+MewFfROpnj/JNA0FSCvREnARGT7LxuKw7d2YY1hD5/SVPE6eOSvyI1fN+CyNSWDuNItD5zTaWeCRz7KGAycgeLf36QNjh3UqiC+GKLuwc8x6hAm8zIrDA8+O/Br0fusbvBeG738lKE/vMnrjg0ZnHWS83pdRCZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208782; c=relaxed/simple;
	bh=LokVu3KlItJVGI7Xw/fEGIGOedfJBVBwECL1ljHGVE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3WtfU+mCws+iiINeDPBzWUNw8KkcISplHKFe5tyWwgP2DTLAcKh3B/oxSO2dNCqIZ/0cYCTSYt+ZLCFScpkni+ZRLNbu5YTEkG9dpqoJpCG+AFpaWRWZfLTVk/I4W59K010qmT99X7Rd+yR0oFcRaPrrkY8aV3WuxhXEN5GpeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=spM9iwS0; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gauC1lp3kzQHlAR0XC0JCyO+TLLZ+5tImDIO7t3wg0yBDSvHVEnLUm4Ymq+I+HCtldwerKxJmj8tw3E6RmdawM3c4s5Fz6+uN2o/ts8tYFWkRqe8+C/teZGrXLjkrcZHKzNGu11GGf4eRqIm68LFB5treZd70MEk8tOhfBfW4WDY34yVqq/1APiNL+ATkLY9BhmZmKjMInHh23T7pzmjnb707/iuCegmqauFBsLu8KcJ/uWUVSlngseGORAuV0TXa9IFUBkG8tTBFKOrYyrJ19vubGPX/h7tzHfgaPJbAYWSIDeTijc3jPYtlwaUchbG9pSuW55cswpRwRK1S6K6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi0BrC5p72xNXuX9lBHEfwg3//X2/F4NQgyGnyAE8B8=;
 b=Oy2ZaVTlCqwDRLGra/CdkaMGQloNz+qACeTi51pZaeEWFHpKGYVqDCaMzm5Bd8WdxASDDkYx7cgP0u2P8kc4oLTy9NIOx9QVUiksrCdJfkkFD0ThNh8mOLy/YjZH/rOQX5DzWLfEC/trzrcRCvywbBI/DnPX3LowlDY1ZF6aW4YNxEwHIcgd6tnxJ5+HrmtkHRScEg3L8QG1xfI92Lzkcso+hG7eg/vt2WnKTfUztRUnSayBDs9m3uX1vThb+dn/Sirui7VUyCPkyL7VDO9fKBJcV1AMOIldZiyxoZkkY+6ggZcER0XX/CRA+nOoJ+6dGbXt5dVbhRC4CHhWm5hIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi0BrC5p72xNXuX9lBHEfwg3//X2/F4NQgyGnyAE8B8=;
 b=spM9iwS0Q0307CGnUzq021vWrNT2osp8mx7KcPRzQimzGm51/7m727UCtes+fgeQc3dN2brt124IDBBmzfNNnO83GjcNUu/eyqLAVv0tBDF+tn45MCgJg2mrGrAyOZIXG6QhiGkwjkeu8PCi8bQgz9naLLSSEJkd+QzDhiSheJg=
Received: from CH2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:610:5a::29)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 05:59:37 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::2b) by CH2PR08CA0019.outlook.office365.com
 (2603:10b6:610:5a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 05:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 05:59:36 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 00:59:29 -0500
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
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v3 00/10] Add per-core RAPL energy counter support for AMD CPUs
Date: Mon, 24 Jun 2024 05:58:57 +0000
Message-ID: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfdd9a2-690a-46c8-2b8f-08dc9412d40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TRHLlFMs65xjoZ1Uw9Jqcq6SEO4US4TtokyLWXUPwXrhd6Op5bfWr1XkUhrH?=
 =?us-ascii?Q?jB38C2AS9Vj39Pxt2iecT4dHkw68bPwfvYO2liKn+Jz+G0CdgECNn9ifvv2b?=
 =?us-ascii?Q?8aPdXCVGMEbO1J95KJFQDS46p0zn7KVdD0o2KGdXtHuGnAo4BQBjPe6UC28U?=
 =?us-ascii?Q?Nhh9pgo8CEablBW6KtMX+DX0uFp1sgO5oS8eEceve9Bd1OMnuBpj3rG83NTu?=
 =?us-ascii?Q?7rVr1FsXBW28ZM+E6t6xpx/q19/9QnIubg+VgMArdvLPLbRwDs6LsRFSKkPV?=
 =?us-ascii?Q?m6mD6XD+XbcoNh/yLY99NGizWUWVZAr97vZw915JAweLv6umQlxzlRFUa64g?=
 =?us-ascii?Q?kutQENIQA5Y/DmDD3QwEmM41la7GSR4cNfFTHI3nygYfGMi3+GncOFcBLnGG?=
 =?us-ascii?Q?HGzEPtj2nuisYFr9cTpK4QgePjASn13OUoajBM8+nzUFvkGNnmOMmYpg8Qm5?=
 =?us-ascii?Q?WuxZBbItOGAebAlC4zWFAHGpfAdIXbdCabKeRW0MXSCTv3Ae9DdRH2h1Qoav?=
 =?us-ascii?Q?Hs1iGG6XHm3FIYwUFCONkgEGU/d8TeBMF89ypVFKDpbFNPGI0KJ3dfuecetW?=
 =?us-ascii?Q?7PuotKPzAV+IOly03UU1li4HWxI881K+ClLpK4yVgtt/7uGh2NykgUxctLSv?=
 =?us-ascii?Q?MGq+pUpHsgLFaC2h1K5VN+mZEoYGkex99YFRdugNfP7YSDAWxUlBPm5HCuoP?=
 =?us-ascii?Q?+aNqNNX+Zls3pGiv5afb2bKY6jte2Fgpr42Csq8FRUciH90WxT/m8J+LqBz2?=
 =?us-ascii?Q?0AprnE0CZsziq805npcl45VWqRRNKYlBsW5HfXuJ6oW1LS0t0ccnjdyjJw9r?=
 =?us-ascii?Q?HcfkKsARfgUuDudcS5rBaZw3bz0AF51HULpSOZx/JfJELiaKvBgB2YgS3K9V?=
 =?us-ascii?Q?87yklZc0JngHc7IEFBzzNdoiB+iMHVh/CslDKdmq9fVl64zwzKfKsw/wvFUA?=
 =?us-ascii?Q?6kS5lglra4Ydzt+G4vu3KtH5/68b0EvN1YZa/hTD6Srs4MMwA9DMIRVL7sRG?=
 =?us-ascii?Q?iZNSEBF8O8cRKdtFsLJyrkcd8xEmzUW7Wgw8iN03iFnquglTDDjGbmWvi2Bl?=
 =?us-ascii?Q?2DfT1PlcN/aMthOuS/ZTWBe7eB14JPFfzzJaCsEBpHC9C/iXE6ACfKvSELww?=
 =?us-ascii?Q?lu1RmbWcNsQLJV+us8YdxTKsqtK++EesBTQ8LR1WXIs26MEZDOrfHauQGz/g?=
 =?us-ascii?Q?wCDeYrAngcmGYZCVEXpUn8dzaVxntAjASNlNuPyD8nd0WnOfjgenEpRXrJ6z?=
 =?us-ascii?Q?KnEc9a343AAMASTwvPBIxw5aUGTzO1umXApofX5IvDgiKmUrdcypFF79YK5W?=
 =?us-ascii?Q?/z+CvmDPMNDbrgazIF9DVEneGBQ1BlPTrja6BEBXUGJImp0xYxUmoAWC9HNS?=
 =?us-ascii?Q?uewcrtE83cum1WJw6PU9mZbjTU/2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 05:59:36.6588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfdd9a2-690a-46c8-2b8f-08dc9412d40a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

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

This patchset applies cleanly on top of v6.10-rc4 as well as latest 
tip/master.

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

Dhananjay Ugwekar (9):
  perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
  perf/x86/rapl: Rename rapl_pmu variables
  perf/x86/rapl: Make rapl_model struct global
  perf/x86/rapl: Move cpumask variable to rapl_pmus struct
  perf/x86/rapl: Add wrapper for online/offline functions
  perf/x86/rapl: Add an argument to the cleanup and init functions
  perf/x86/rapl: Modify the generic variable names to *_pkg*
  perf/x86/rapl: Remove the global variable rapl_msrs
  perf/x86/rapl: Add per-core energy counter support for AMD CPUs

K Prateek Nayak (1):
  x86/topology: Introduce topology_logical_core_id()

 Documentation/arch/x86/topology.rst   |   4 +
 arch/x86/events/rapl.c                | 418 ++++++++++++++++++--------
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/include/asm/topology.h       |   1 +
 arch/x86/kernel/cpu/debugfs.c         |   1 +
 arch/x86/kernel/cpu/topology_common.c |   1 +
 6 files changed, 305 insertions(+), 121 deletions(-)

-- 
2.34.1



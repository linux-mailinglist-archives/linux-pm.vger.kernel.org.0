Return-Path: <linux-pm+bounces-8854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC36F901EF3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D081281451
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568B1763EE;
	Mon, 10 Jun 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pcEaYAlP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952AB75813;
	Mon, 10 Jun 2024 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014113; cv=fail; b=lX1LA1DFUZzR0D4pZElDrRQpSiKbBy0ayA7qPIaOl/YaaZwYYIZ7gGo3YlgGiL8c8u5PDR3Cxrmpo53gGnYCmW+wX/qFx0IIZnDl07255rb+hKK3HWf9OpDYHq5iIL96c+n9KmQWTQDyWjSUsP5siBEJ21mhtwBKl8YIj5qXRiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014113; c=relaxed/simple;
	bh=OpXRE3lgl70Y1TwPbQ8YG2USpijxRjQT6l4RSZI7Yi0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dj490aDFdjoVzyb/9Do+dii43eL3o72PQuMi3PNLe1n5TSgdg3ifYLNyTNWgY/HsyV1AeF83nCs1b6ireCewt+Ef1JD78GXZoJo5n+Y+FEPVSXccdg1P6cUQaeLnZTx9LvqkHuXxenQ0bdTk3OEa0+kIsru+V6LnFztmc/RZiO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pcEaYAlP; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7IVnf35SkBXlIniXKQe0D2nqbJ60y+WOGBC5pcXvNVPhG+KWeMenOnXJkDxL7r1pUlrVMQBhzzMMonYeX3c8rCXQHqRcpgCPF8jTy20wwUU4lioRg9NnLIY5H9mpY5PCa1eybp6qOqYSLUzlBmfblvW2ujF+JvQKT9igxghqUc1yb4b4A6njGf9QCUj6yl+Ie+mIJWmiofhsNu1HliCuFjnnBlT8g1jJhKH2DoVuZB6kbaeQP9SRA9kfOuwF7AkXUntUUU9L8GjGV976SKP0XyGRjAfLwFjyr3ryd/20vRsRCQEiLU7Q1P5OzuJAuA0mV/cJC2a2E4051g5rFFCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M08RlDTqK+oMepdl0UpcdFV9+KeDTl7Y75QiulF7Jo=;
 b=LGltlSpRpN4DjTehHbHnWtazGkSZIx0jY1xewetNjp0ORyYx+jq7MWcbWlusReXJNihGYLP8Zq7VmWurFiy3Rr8Lok5z+hjBHe0IqrCeSBZHc+aEGT+KulzklpkA5fYWTho8cz6omcaCh4s/AalcurP+KxBDrfk5GIt8w9q+3ut32Vp1gHd1VHIArQR4I8i4bFCK8bxrYN37+loHi1JPs55tn/jTz6y24V/FopjGnnRR7e7DtnFgXLEOr8goQgyUZjV8TLRu/8qvTCT5rHGy56169w7aKDpSSzBy4ZpLInhsw1aUb8In02lZWFYr/myTcro2C1QIDpAge4TkFjp90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M08RlDTqK+oMepdl0UpcdFV9+KeDTl7Y75QiulF7Jo=;
 b=pcEaYAlP1mlts8DvRUjqg8Poqz6xOvKZ2KSP3UBA4qBNvDl4nxlBg0UR2iGQDnt6iYLDLENwfzgTBqe6/Wkm/xyfaWQZh1o3ob2ySKdJiZJW20QjPwSaDeZjQ3SNMHfBOTvGyUrq/9tdCA9t+0qoghFD/hwwIqtDe2p1Y1Kg8d0=
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:08:28 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::53) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16 via Frontend
 Transport; Mon, 10 Jun 2024 10:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 10:08:27 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 05:08:20 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 0/6] Add per-core RAPL energy counter support for AMD CPUs
Date: Mon, 10 Jun 2024 10:07:45 +0000
Message-ID: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a282dbc-64c3-42a4-0254-08dc893545a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|36860700004|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JocBEse9vzMG9vPh6UPzMTOpK0+NMPtrOFgiswugeRouoTOBgcoKXCKhALNU?=
 =?us-ascii?Q?yA982Apq12HgUvcZOTtyyDhSjfRfhgna7THZ0hnrqj+8n+3TX5UcLHJJOL2q?=
 =?us-ascii?Q?xg9Qy8H/PvU4O7lPOHdzWUu/1pi28HhfDzUXALhl08orKmegflbTnDM2oO4x?=
 =?us-ascii?Q?7lbNUIdOVorFYY6Y5j5gLjPN9EHib2MU4kyGWzvWZkhRVdC+V/K2bgLqaCpj?=
 =?us-ascii?Q?a+vwwnO/hP/s+T2TxjOQjrqQYPYJvNpOgE0E1yhIWeZRNcslqctGnZM5Vn8w?=
 =?us-ascii?Q?jP0z2ev18tgHzp0TAfXfypz3ElvcV/kXg87D+WgWHjL2RMX26b9Jih6GZohe?=
 =?us-ascii?Q?PG1UITrRcf6SFZQ+KnzW8px+9hM8++GbuXTGkvXzcX1nBm/ZkyCiNCN45TlA?=
 =?us-ascii?Q?eHsc+hAfyNow/1aRoOMuzSDTNFTG/ngtIg8a3d+x3Jx4zPqlNyZXoQa8TP5y?=
 =?us-ascii?Q?sLOM/eECs5gq9C9+X5FCEc+qhgQFB1fzntEMXwieIrS+bCKj9TIx2KHkgSNB?=
 =?us-ascii?Q?DrzcQhDAAgF0NoLF/duKJYbcb3y0ZF7CEo/bR6aQilZmUNYuTLkIThJ5z9S3?=
 =?us-ascii?Q?CeNhHrt39Tz5wDdKd/l3Ga0y3wozBT5v3h3JjMkr8osat9IAJsRpb2b7r8ZK?=
 =?us-ascii?Q?AjxWaXvajDNuC5r6AHUSPZjhbOfW1pBxOGIT50YdKnwcdgW6u92QuFdHWV/y?=
 =?us-ascii?Q?Vv7YZAbiV8H6aZEbIINsqAbjwspSHjbf6ZbLxmTak5+ykNhkl0P9u9TgXZkf?=
 =?us-ascii?Q?9D7TGsTr9SYlgMWOERiym5dDLdQTOOrDwBLKwCToNiItUspNA4Y+KaKKrOro?=
 =?us-ascii?Q?zhHUk4//qc+Ul9x41YFUmAKKRF0yNfwI4PPwrJhU+ZPOhETP8z6Vv/h65qtm?=
 =?us-ascii?Q?yphMQ879n32TLRU626LXUyYYFlRdH2QEzgpeBLpx/ZXDgHJ8aRYPy2VKFhks?=
 =?us-ascii?Q?Hd4aV0v691u8haZhhkkM6cRHCkUrIHBYo9oGKqIXzu+fT1qwnkF46DTDkQjr?=
 =?us-ascii?Q?w4RVmOtYoJn1/WdDa3NVvGLrlZgdPhjHWfHVgWyEaVMPHhjrMhA0y7N24O7E?=
 =?us-ascii?Q?vq/JkcnpOsNOUkgxYr5lbJGSwvuUbrC4iB5oJbBO6W1mM2Sz9veXX3EWqiNO?=
 =?us-ascii?Q?M8L718chwRAw++Qd582dU4S3HHjAAByF25uuuRMdX/dG/fUjjtn1yeDqJ7Cj?=
 =?us-ascii?Q?gTC9oquyHrRFt/P18ikuc27KOrvYKu7UBwwKuPN+uNQtO/45RQ3H5vBF82xs?=
 =?us-ascii?Q?g0lNUclsO63GbHL+z4AEfk4n4YBfpKYAxEuZ7XWkTxxiKrj0Ap2n/JnyUWMc?=
 =?us-ascii?Q?991A9PQ1BBsDrIFoAdrgUQL/UdXP9XL0BqCeTeoNsdQle9OXBW0fDOjwlOsT?=
 =?us-ascii?Q?e1te5Ehzi/es6mgZNhkS/+IrzNgSm25pdOBmtW5dyJj4+E91zPMYz0kOcTpk?=
 =?us-ascii?Q?MXtbogPxb0c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:08:27.3060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a282dbc-64c3-42a4-0254-08dc893545a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

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

$ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1

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

This patchset applies cleanly on top of v6.10-rc3 as well as latest 
tip/master.

Dhananjay Ugwekar (6):
  perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
  perf/x86/rapl: Rename rapl_pmu variables
  perf/x86/rapl: Make rapl_model struct global
  perf/x86/rapl: Move cpumask variable to rapl_pmus struct
  perf/x86/rapl: Add wrapper for online/offline functions
  perf/x86/rapl: Add per-core energy counter support for AMD CPUs

 arch/x86/events/rapl.c | 311 ++++++++++++++++++++++++++++++-----------
 1 file changed, 233 insertions(+), 78 deletions(-)

-- 
2.34.1



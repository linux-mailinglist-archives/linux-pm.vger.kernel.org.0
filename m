Return-Path: <linux-pm+bounces-9662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D8910542
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E00D28743B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17821AE859;
	Thu, 20 Jun 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JxSMhKnL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433C1AE852;
	Thu, 20 Jun 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888275; cv=fail; b=NuDXsm0fgnc+88U7jBcs7mh2Kvrriu2AJjTazY68OAkj8lblX89JWegHqw8jSOYhUW+sT0e0y7DmTxwNEdT9J/2irMwIElhzTmWOqfiZkgxeAfLbQJpM+NECNGJRVK8hjooSHVid6JyDBf19+v1xBwdKemkuBSXTIiyZdf3JYTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888275; c=relaxed/simple;
	bh=VDEdkz4pQPh99XyNCIX1ZdKLZwMWWf2SnNlGqzwhPMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=An2gwyRQK0B0ruTG7D/oU1RpTTzW8WGW249g6GAXYXWqwK3WLJi8H+6ANWhh9C0Q1zHuParn8U6CCqWLtMY/A6d4dUJkCzmQddSnJlibV61NdcE6ZstX4qH0Ta5z7vUE2BaluMi5u4JzoyCNqYBGNJFkOfLNKnJT0wsHqiHUtNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JxSMhKnL; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE3vJWOp/CHbqQagB/btOqICKwll7boH6HdYOhrzmrrJPNq4dywiQgcDLj5cEVkxkwV6dcXVKkcGrIHq3E0YT0trzAu/cnIKIN2dyshK18JkVtXuyiMIhCQAn9Lu3rnMK+YsWUgDff+ojWHGti6oZr4oD/xyNS2i/UlubAwBoQv2hNL5INI6bqjWf0rqT5o7jBCa4wFSRWG33cvYbQkJURwFio1tVvmUGHzwn/dQO8Q12kx9/ZLHngyx1dRRTwCWE7tiCg60mS9rNvNBwgk2gKLxOUL0jWFydEDjBWKmW6Bf1+ziZbiQxSXfRjHrlc85LZcXB2x/0g03z66hFUOzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw6TkxGtrmRS3uuJa43wa1SX3Pk39jG8WlLkVCxSW3o=;
 b=IY50m4jGDkXw3g3fJOTRaLJJ6bT00smP5APikl3eMsBdEVUWO7DZ6nD6oxaqXcrwn0xUuwzUgAqZA/Hjx3V7vAelSYRLVJjrnmcvB0Ap3/L9NBZBPlU+7M7/qa+8ptV3LAiMoQFM81Fj/Uw4s45kQCTlWDOAO8DpHEtV/P9FpOpU6/2STC9Y7oy8MFAsjAvR/IEQlM010BDhaZZovqvPzi3urgwuwjLeKmUQTrIeS0DZM4w6EvDqbZWEhw2onlGM9yq5kbTv5scIdmbjidu4h8puN4PCFnbVSsa85Qd26jQspjWtenqANgVmAde7Bsuio1Is0VYPgRmnvdkeYdxWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw6TkxGtrmRS3uuJa43wa1SX3Pk39jG8WlLkVCxSW3o=;
 b=JxSMhKnLkHJDKK/Ohvqs1zC45HD9qjhp9JBHiZSM5ao9ag2Ic0ItI8+01OXPOFzHxdePwnOpGD8qwyhkNeMVxlHrsjbnr7jqb7wLFdamq9//2R7ed4uOanvqdgLbS6I1i8aT8y86ARhxRy4NiroXq6FuJn7UkW0MmwKDAhoVecM=
Received: from BYAPR21CA0007.namprd21.prod.outlook.com (2603:10b6:a03:114::17)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 12:57:49 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::84) by BYAPR21CA0007.outlook.office365.com
 (2603:10b6:a03:114::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Thu, 20 Jun 2024 12:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 12:57:49 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 07:57:41 -0500
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
Subject: [PATCH v2 0/9] Add per-core RAPL energy counter support for AMD CPUs
Date: Thu, 20 Jun 2024 12:56:54 +0000
Message-ID: <20240620125703.3297-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: f9390d11-2b78-42e0-e549-08dc912896b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|7416011|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8KO1DFj3tkG8GIm6BUsA+K9kXEPAi7qX3v+Q5/C+BXjzwMK2JT64OdCQZ5Hx?=
 =?us-ascii?Q?DTWOYB4FekB1sYj+oofwXd6TfKdN/N+1gDk332wca1h/2TKgqYtdjVrEdSz+?=
 =?us-ascii?Q?fV5dORBC7dfUivktaFJnr2i9Nq27O2BoVO8pFggqcVubvzK1Sd7nc+bRBXmG?=
 =?us-ascii?Q?odaLxmk+9k8x0LgArFZHTPJqjQDMQfxXUFAKExKR0clW3CSgU3zYZx8XgBnd?=
 =?us-ascii?Q?G50zQKO0lmNpcVu1tq0iTeZ5V5rG9nQmNEMmFr4FgXx0Y3ymYgil1f1Ilj0a?=
 =?us-ascii?Q?2uJvieVYQLJmTndGUYwlWhObXA2/oCJ1doyYWRsMyUlgF9QLA/+4VZqyfG5L?=
 =?us-ascii?Q?L9yFZD83MYztwct+f3eKzsnFQU15dOPuEnZn1ki7Q/+fiXhtfGz0N60g+8kU?=
 =?us-ascii?Q?I4vWkTL6/kwlc4fe6SlzLmQX6DtTQsI7cCDZyD6TZZ61xMa6gXrJgl7sQ3eu?=
 =?us-ascii?Q?iPR2+Pkfi5IIICxhEjAfziB3HtLu7Nj0+tMncDUsCOafVB6z0BL/d7U8kn4Y?=
 =?us-ascii?Q?bNx9ELmxVps2TN0kkB+/6Xic0/mHc5LXJTyfIlUDeuN8jVQPxXm/fzNQOpxh?=
 =?us-ascii?Q?SkOyGNVX6/33XXttoQHVBnAaL5j5Q/glBOkdKerN0rpMMnn3ZWn0+PAI2vcg?=
 =?us-ascii?Q?NMYHGp+f1TEPr5lVSXF5uVKptlm9wyV0NZHMjtNMidkleenvq87fXvwbrqbl?=
 =?us-ascii?Q?15qkGrUs64A0FtIiGJWEtcn1ArjSzAqGzorpaIbVVzPY9lvWMraTWHpk45rw?=
 =?us-ascii?Q?ZAU/WdvYpFK7WWrahkEhz561LhyKwin258deEnTJeaFGq8wEv19yj1TbEBdw?=
 =?us-ascii?Q?3YVry+on+la0OwNwPWHBlZFSgEdHYvKh7jb2HQQWYK3k1CIFdvO/vk9VUfgK?=
 =?us-ascii?Q?2aa3j5t0NUENNfCgLMa0B1fgqzbXnSNUBa7ls5+SAc/B4eD9wpockG2YNeCz?=
 =?us-ascii?Q?I57tctMaWtrfWMNJAfdujWTvjWYLNLkjfzp2E9yb6gRgZay3g7YDRFUV3tga?=
 =?us-ascii?Q?SF0lEu1gjdZfBOMdHz0gQz6PJfGOWRXDywn4qXCqSZM/ZlkXneRUugKP5QgE?=
 =?us-ascii?Q?RtFYFtXKJDCLNo72jHUlPLhyex4Qi4l/nqnaOxKZRM9noNczXRQAnGAdTRvf?=
 =?us-ascii?Q?9JKDFWOO0zn2S2xh5xF1PG4O5iTJfU2xpBxKfsd1TIiEEx7s7gTiHJBr4WXC?=
 =?us-ascii?Q?eOPW1agsPyyxaynUJT2eVwkQo2j6HkGZ8Gn+kZ/IkFPAjD4mLQZ3OXm6dzsO?=
 =?us-ascii?Q?+trAXZ1p6f36K2nQ3bX3ZbfMWNjefZ6gl1KoWh2KEOVX6/qXx1PLJQ279rGs?=
 =?us-ascii?Q?PT4qSsXummBbvBu/pR6i3wdfyFGh9QXK5Q0uDfd4nEsNZkkfo+jb7oEmKFs5?=
 =?us-ascii?Q?QamOe4qmHO0TS2oLJnyKAk/ijOCs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(7416011)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 12:57:49.1427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9390d11-2b78-42e0-e549-08dc912896b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934

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

This patchset applies cleanly on top of v6.10-rc4 as well as latest 
tip/master.

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

 arch/x86/events/rapl.c | 418 +++++++++++++++++++++++++++++------------
 1 file changed, 297 insertions(+), 121 deletions(-)

-- 
2.34.1



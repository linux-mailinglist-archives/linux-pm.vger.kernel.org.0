Return-Path: <linux-pm+bounces-9867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B294B914260
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45F91C211AE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D581B95B;
	Mon, 24 Jun 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BcSBpC3r"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26D2564;
	Mon, 24 Jun 2024 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208825; cv=fail; b=Ts2ByaLESiEmaEVVih9icXO64uQz5BvIi5X2sX+hN3gZsn6eNge9za4EomRU+jNHw/4l6ysl0kSkFrHXuTomHd0Irn4tqb6zTRlx69KfHydrvBK5TzF55yNrtpCZWDx3ORNx45vTKgX7LaClnuG2KvK9EXKwO/fZGwpedablq+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208825; c=relaxed/simple;
	bh=trjQ08VS9nqaEk4bElC0BEHF4z+L0KraXrOCGGgynmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emx+R/eyqmiJqOv6icd3szsQhHpMCC+b3+u2BOK43iuziFS76VG87DfxvBj2drSzt4N8Yunj29T5TAFAUMCxb2rJ57mZtQoE2I+qvoIb0bRL3e3LAmpBakXFdf4ZSaTKCLexcT/BvTXhXQiOROK3VvjhzJ3vgjLsw6jqA86fZI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BcSBpC3r; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpButckLIkYdmBXhLdGOPJPxU6wEg05fQnn3UmNMDMPzuElfq3rmnSgGjjiuZNS/6vPxDirDnxxWnj9KM4A3cChl8p/S3yyyQZkqidPbC4OSSItDm4vQcp2C0cfgkYYe/1mboW2G8rSzc6wBGb1TmLLgNbqhyVbH2EwnTcubizxb+j6mARq1zOfXiwuTRPcuMnFTap56WwKeqUGgo0uaHr4BKlPZ8mSwEMRq3u4AAEv2CFiNOfIU3zYMRzNvNujiLGG8gZ8VdWJ4u4z9FM+V/oXV1qImh6tJoAGMUq9fpo6lDy1k0WknFXXW7qWTdetJR3Xe94WFTrQl38SHdhjOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nig0DHr8BLxwu+43onKPqrDar4BGIuSM21jlS50W734=;
 b=JtacrWEbMYimqUG+3jSBio+IWyVvyxVBePuXnnsR4hXGRe84/4EInIm7ODt2POVkNHa4VA4bSr6Hxwd22ccNvG0zaNbD9QrV8ueJG2/pV1nzEbe6CTfwYOoyJzZC6Y+O1yF2JbqlKL5SpQwODKX2mpJaE2IEkJ9LEtkRa/pn58JT+eTLD6gflehXXRpLye4sqKUktIcSgxqGUhbHd6uB8jB+ts3IbS0wTljP+YP4JEkz1IVTisOg5pe+z0pU8ZNbTEDHeN23X25mGGXojJMkdJ93sMBwSZIgrdlQpTAtTeW7YuGX7kPEf3wX7Bh639+3TT6pIZCsUAPbzQBX5qSDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nig0DHr8BLxwu+43onKPqrDar4BGIuSM21jlS50W734=;
 b=BcSBpC3rijFstV41o5mM+yLfzZjnKEgnaCUNRUxl0BJeIpnhyvEw/j4jocIIsDX/ibmruNSuF4qTT+JxVezAODEAqnzO87sjOi4sooSOzqyghohPhywd/YZ6idXv0aJIjRp/EAa59X6uZB2Sn9o8JhxXGJ6WxfL3xHx2ESkNM9o=
Received: from BL1PR13CA0384.namprd13.prod.outlook.com (2603:10b6:208:2c0::29)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 06:00:20 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c4) by BL1PR13CA0384.outlook.office365.com
 (2603:10b6:208:2c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.18 via Frontend
 Transport; Mon, 24 Jun 2024 06:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:00:19 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:00:11 -0500
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
Subject: [PATCH v3 01/10] x86/topology: Introduce topology_logical_core_id()
Date: Mon, 24 Jun 2024 05:58:58 +0000
Message-ID: <20240624055907.7720-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbcc1c6-c167-43f0-bca6-08dc9412ed89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HyZjlKT9HI3b+fT1Sg2lXAN6RQyS8j8LWyZ6GdPsl8V6kBSleT3sQCVzFjlg?=
 =?us-ascii?Q?qAItNohOj8u+Vwz0/1Qdl83QyJj2PCSTDEwNjdKatp9dsDuNQ01jPn6oBqf1?=
 =?us-ascii?Q?k1GJpBnKVu9VqAtovmIbVcsJUexFCVVdiRQFwoW8r3KqQvME1hyW3fycz+Rj?=
 =?us-ascii?Q?ewY6utaJsoe2Sffcqm70mTKYQWNHgrWCFyywJmS49/z5NoQWiXpwqc1VPUAg?=
 =?us-ascii?Q?q8f1JAEvxk4j28r5K7kJZw2OQhm5J1tGWoFiEjld52jV/2e3AFjRc04ucwDb?=
 =?us-ascii?Q?iGtXcPyQZp5CcoO1sPr0Ic3bSfxBPO7BXMZGWp8+BymLmQUovzigwwKFzvQQ?=
 =?us-ascii?Q?yZi7vn9rlw28M+9GmT5c8dOApp0HzL7QIQxQCPA8GGoKaTQEWFo0IjuTtfcV?=
 =?us-ascii?Q?IHYLwLlKHw5dOEzlisCCCGlUUkWT27PHUuOF/5SOr+ngzJ/f7l/xZ8TtCFPZ?=
 =?us-ascii?Q?vaJQvkyLIfK5QquxB3/6MZR3d9dbogwklPDgDi/vOWv4VPxpYT/XNOiNeMbS?=
 =?us-ascii?Q?s4YxHSQJTlJ7YTcFRGKBvSYkCYmsCMEwRuHhq8GiwRbpXVtTaYIakeuoAO7u?=
 =?us-ascii?Q?7e6kqrvQ2RumtbafIRFHZ0aQVqINX9fX+Rp9NMJIW/WJfOEImTRsAJBMZhPh?=
 =?us-ascii?Q?W+z5odvaBScaCasFA7LwjowJpU+2yOuLH67Eq0Ta52UfZ3FyFpK6gdzdoC11?=
 =?us-ascii?Q?e24PeAxiHAm1TzYOUNqGfgyBgKdZp41xfdSXOwiZPUJfpzVpMAlAVRqtnl3i?=
 =?us-ascii?Q?YJRzmS5qUZNOIBMIjxY3+2MygG7v2yNyfwUKmO3IOIWTgoM4DJONb/A9j8ik?=
 =?us-ascii?Q?qGshFxVThbhIkoz9G77Hl5WbSUlACSld91IPy01D31j3HfW1GNg6I2dL1Nak?=
 =?us-ascii?Q?HScl25XM1ZH/guRIh7fo5do2N6ZCnuJdaX8XY/vWhszcaHGwMv0SVvNiS5ne?=
 =?us-ascii?Q?uIt+uf0cHq2XEOjhv8Xo9wJCrVsoKbFP+IrQiOQMznM7NT3C9kilh1EnWPLz?=
 =?us-ascii?Q?9nF/DcTx/9rhjDOU5gPe1FfH3RD2QRwRAWOs+FuFTxKuQ48sAiI62ZKJKg13?=
 =?us-ascii?Q?3mR3j6op+fHV0hcF4dpfksKkG2I/8eeA89mijs/8abj2GFwdN2kg1PI9TqiX?=
 =?us-ascii?Q?k49+amEDSKT3nypDUQrsFMc1QgtNMI6J+mSuhxvKqUJKT27vORAH4haby5Kf?=
 =?us-ascii?Q?qPHCW2tDQvoxtIL3/jeOtKSeAakXDI6utKO3kNXT13W/relrKzxMwNML9KQQ?=
 =?us-ascii?Q?IKytqeH5QApOt0U1+JklNVIWAzPch1D5WmIVR1B5VljXoFeHFp6E3xYu1Xcb?=
 =?us-ascii?Q?UP4/alzT3ZCMLIh6R3lhGSU5raDvyZvedkM53v/uwahzuUZvyuMVrJRGr4iw?=
 =?us-ascii?Q?EHtZz5aGDWa08MZC/AdbMx2wMCRzyJ7HAlwiolvfW0CkiNoQ3XGHEZYFQEaz?=
 =?us-ascii?Q?MggxguMOHWg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:00:19.4691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbcc1c6-c167-43f0-bca6-08dc9412ed89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057

From: K Prateek Nayak <kprateek.nayak@amd.com>

On x86, topology_core_id() returns a unique core ID within the PKG
domain. Looking at match_smt() suggests that a core ID just needs to be
unique within a LLC domain. For use cases such as the per-core RAPL PMU,
there exists a need for a unique core ID across the entire system with
multiple PKG domains. Introduce topology_logical_core_id() to derive a
unique core ID across the system.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 Documentation/arch/x86/topology.rst   | 4 ++++
 arch/x86/include/asm/processor.h      | 1 +
 arch/x86/include/asm/topology.h       | 1 +
 arch/x86/kernel/cpu/debugfs.c         | 1 +
 arch/x86/kernel/cpu/topology_common.c | 1 +
 5 files changed, 8 insertions(+)

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/topology.rst
index 7352ab89a55a..c12837e61bda 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -135,6 +135,10 @@ Thread-related topology information in the kernel:
     The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
     "core_id."
 
+  - topology_logical_core_id();
+
+    The logical core ID to which a thread belongs.
+
 
 
 System topology examples
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4fd3364dbc73..e1eeb42edeaf 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -98,6 +98,7 @@ struct cpuinfo_topology {
 	// Logical ID mappings
 	u32			logical_pkg_id;
 	u32			logical_die_id;
+	u32			logical_core_id;
 
 	// AMD Node ID and Nodes per Package info
 	u32			amd_node_id;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index abe3a8f22cbd..2a6dbf965d92 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -137,6 +137,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).topo.logical_pkg_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
+#define topology_logical_core_id(cpu)		(cpu_data(cpu).topo.logical_core_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e435834..b1eb6d7828db 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -24,6 +24,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
+	seq_printf(m, "logical_core_id:     %u\n", c->topo.logical_core_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
 	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
 	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 9a6069e7133c..23722aa21e2f 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -151,6 +151,7 @@ static void topo_set_ids(struct topo_scan *tscan, bool early)
 	if (!early) {
 		c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
 		c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+		c->topo.logical_core_id = topology_get_logical_id(apicid, TOPO_CORE_DOMAIN);
 	}
 
 	/* Package relative core ID */
-- 
2.34.1



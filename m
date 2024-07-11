Return-Path: <linux-pm+bounces-10971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF3A92E4A7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4281F22AB5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F65C158DD4;
	Thu, 11 Jul 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HT/6EPti"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995B158DC0;
	Thu, 11 Jul 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693632; cv=fail; b=bsVRkCyXRBbcAFH55LION10gR5dbegcvGgQiaH/JkWlPP4VrN4AX48mFDAc9bRD80JPWL6k/YwniVYobM+9mvrkw82As9QbeTKA5lU4ocIcewe9xqBLpbKcIWgTuVm2lBSUpPLFd1Gr4dkcD1eCZ6c8iljfiO5UxoZQj9lGBYoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693632; c=relaxed/simple;
	bh=bdSf84gGt2+ppfupKPnT53Dz8c8Prw7bUBSUOhNtm3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8PMrznmJqTFhRO3ZhsRwd3ohGwa2LumU5WO3YcvFno9PEsagoFC2l1oaVKsk+p3I9XzYXxtC8FdJlsaxmj7ScU+rfPia+9eOdqVgPb7Nkyc0hGcMYpCHOPqhnTYTfD0sXB5MMvMm9EUAqUNR2JAZMPMgby3dVevH0UHq0CjaiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HT/6EPti; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhqYgrHsIdyCa/+Q38Ylu0QwSAa48pYQ5HSD9A25ACRVIsuWogUp2i16ZuhFZ7BR9Didq8q3//Z7PVJ3OdgVrNWZNjuOr1KIh7Fxrv3R4g3piR3lpT91zixhxh5mZNRM6YWgiJOryk3/ISvZsLebhqt0OsStCfozWIdmrSjAgRNWb8AYk1dLz8Hiw1zJoAd6SRg5dUJL50bIX4rl4veHldNI70sQeKz06YhrQ0xRJCSugJvUM0DnxqSBEu2MQqVh8PPv9EDRY5D85dnCr1T9G2944hkNc57zJxS8HpYn7wxWtryrLY7jbMgwbXOKq2AWY3Mwm71w/nhT7vIUYrguPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VB0mnWMAMkAvDfdiuyx2za+lkYjWygNVTD0XXerRk4=;
 b=kv91LRROX8Zoi7ZyM46Y5uqsv/ZDmdkasSWmuFD9Woi+ppKn15GvmYfm0iGvKi8O+E3Zw3zk6+X3qHdGRVenWuZDPvyQjXkMXbKcbvkzxwFWqyoImX9aSP+R4KIJEaNlvOI8jgIMoRMs6e0xDAoqmxPJkoCnWjKekRQz7SWbjApex0JrbwK7BuzmL8gaPwpFLjE4mSfSkZb3pU1ZkMqMHn2XMeJOaPLW8APbg02wMDdhKHw0OeEPRw3OnpAJvPFcQxHT6m4bCupiw/nDDe0E3oIjBbWe5pqkahtIy4nFWbHcXaQ6GQAzmz2ZGluF7a6KyRoCdw/1NDM2i10gmFaJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VB0mnWMAMkAvDfdiuyx2za+lkYjWygNVTD0XXerRk4=;
 b=HT/6EPtixFuHlomlGjo02Wf2r//V8UwaJYMZ1iezPoDBOaO37ORHib/P/ifWN/Z3+K9oiLWYi2G3ddeiilhLkoa9HL1NA4yDWBuRsAv3Ncsx50poeIu1pqOGxaDWIC6Fj/SR5mmH0w5PNp2hmfx11WRTgce7u0/uF3P4yK0OeiM=
Received: from PH7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:510:339::19)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 10:27:07 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::86) by PH7PR03CA0015.outlook.office365.com
 (2603:10b6:510:339::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Thu, 11 Jul 2024 10:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:27:05 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:26:57 -0500
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
Subject: [PATCH v4 01/11] x86/topology: Introduce topology_logical_core_id()
Date: Thu, 11 Jul 2024 10:24:28 +0000
Message-ID: <20240711102436.4432-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a641676-d6e0-4471-0716-08dca1940330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3PcR446S6hVNtbDqZ2gsU+KKfrBlQ7GoeVGKjHdjlt7nYQsOIpia1hO5C94i?=
 =?us-ascii?Q?nnWd6BXUwKST47xfJG4OvYR3LINvfMsBzN8XjaCkJ2AvLa3a6Bsy1GTi04KM?=
 =?us-ascii?Q?8z/qA5vJ2/+qMfQqXzxcSu9PCgcSsQyurek1m+S8kF58y5ibxMXQ/ykTnqsi?=
 =?us-ascii?Q?qy/4ITMP98VvctwLNcUkLic4wB6CjHr5ZFF8mXFJubSlA87ZVCO9mZO1tCod?=
 =?us-ascii?Q?j7Wyva2dQ3jbdLo3KHMlO7OxOXw/M6uGBZklsT0+Jjk2X22OqlZf2C/OPo9B?=
 =?us-ascii?Q?LpzkrtM270ROIiIA7vITAKA9j9J86KQM92pre4lzJG//q6nj8ucaNagOMpKf?=
 =?us-ascii?Q?d16kk2PGZNS9/63iHJDTy6cgFvWPmr4Mt0AVz8Fp4vCDdwVtcVHtI0fNmPGt?=
 =?us-ascii?Q?GLh50G0KtDOfjnYFMGn+VdDR6tQI/Y6hO26WCoV5KWrU0/B2ddmNg0maV5gp?=
 =?us-ascii?Q?1cZYq5F+axjDhSAEnoHfORwuwL3cuBhCw+OB3AF1vKUGdIYlO7xftPA5At2y?=
 =?us-ascii?Q?Sc/AbU3w1dgSOHLe/z8fzKQx7U5c2UkFt+q8LqkSUGk8cfyzGMNP/1Q7Dz4G?=
 =?us-ascii?Q?mAt1HNKglnWx6FF0RCiqOURml357xMrOrYxRlcnk4ND4bUTC3E/6Byq3R5hk?=
 =?us-ascii?Q?C5FwJeLfebmRMwXHIaISni/WtRN7a29NYtYknlpriw42JmUshtcRmxGtDu+G?=
 =?us-ascii?Q?TPisgQSvEtQIy5n5f0O/bp53p8q1Otvc2ZGdYJNr96arrMepF2ad2zxAVnx1?=
 =?us-ascii?Q?HkRSvIEM0yrkHafbwCuCazuFWss31kClgNqc3QQQDiVKc3mo/YBdlSVcPUpu?=
 =?us-ascii?Q?oQTko1RtDVHmXEzgoScu6nkGVi9rOTZEELVThTTIP1/j7vhsfAasOyNNN5KY?=
 =?us-ascii?Q?hpDaEahMe1oFVp9HYzd+oMl8N1qrDdBRXoEfSaQRiZgDJ86EnM7grIkiS6q/?=
 =?us-ascii?Q?jYCV9JHEHe9p4XRagY9DxJWDiRLCFaYrleqkkU+QblFsFrWyhUG2Ojyh0ELy?=
 =?us-ascii?Q?kAMqIpT1SVcV1FZ++fv55vlev+PairrsMnIQ9LahFI3P0lR2X8/dcYMObTgI?=
 =?us-ascii?Q?jatogvRAjAgTvXWH4pdqDGhHVtD3neGL0NorJtwDNGLPICMzsKCxLwc6Gkvh?=
 =?us-ascii?Q?k7nFIIq65zqcZhBLSPvfySgcB7OQijvDtWyMwRdhG9SiNRfbg7w5EATlAjb/?=
 =?us-ascii?Q?q5wif2QIKH04k+r/GFIQgQ+jNyBznyrMF7/sFpJx3xm4z4UbttXzZbRt+mvC?=
 =?us-ascii?Q?wLDnYy4EgsP0SrRchjwcKdwQMJ5VNLuYhLq67FsCUhlCobeqAI55HGIN9wI7?=
 =?us-ascii?Q?7nNhYE/6zpuPIbAFF80AkN8wZTcHkccCsLlG6ThBYHv0X2WjATJxuLXf6BoM?=
 =?us-ascii?Q?XFe7DNQlpSwZp5KvvxOf1rKyjjjZyUtYTqDXkB5piIpRj8Yp0PTX5LCKb4O9?=
 =?us-ascii?Q?OPIWbjADSzZzuhdOcK9MzserP1IaYzzQMNyoYvM7a5H6/8ZbeDj/WA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:27:05.8134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a641676-d6e0-4471-0716-08dca1940330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048

From: K Prateek Nayak <kprateek.nayak@amd.com>

On x86, topology_core_id() returns a unique core ID within the PKG
domain. Looking at match_smt() suggests that a core ID just needs to be
unique within a LLC domain. For use cases such as the per-core RAPL PMU,
there exists a need for a unique core ID across the entire system with
multiple PKG domains. Introduce topology_logical_core_id() to derive a
unique core ID across the system.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
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
index cb4f6c513c48..1ffe4260bef6 100644
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



Return-Path: <linux-pm+bounces-27808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C9AC7D5C
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 13:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FA61C01890
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B521FF29;
	Thu, 29 May 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eQnO05bb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EAD18DB03;
	Thu, 29 May 2025 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748519328; cv=fail; b=e6/2d1SkZLX6AgAMvttO6F2e9Ev+EEyUfWtc3+IV+rzMTSL0AXu3AjgYmEndNuuVRCmGNVK8HH1ZJkLklV5WYTbG3IsjaDI7XaOfgU2mYPEgP04EBpAYomYV+K8kjhlAQMzGX1nxrjWGd32w5z8rDVP3CzITuMZq8wU+/H0zlZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748519328; c=relaxed/simple;
	bh=lAW4b6KBnkUcu1uUCzDZftEh+QxDHOrg7V32bvbrfpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WtEZuYmRn31qFRCiAVeGQZFMDT3wm8bPgetYUcenKZ1yLBtHTJknW5gQXFN4xvk6YoFf8eE7lq+v17dHI855B0z7XG04Cy5yCuznCcH//6KWGE+BXsQhBqJJmaNdTPHzhhKxCRhOSTrV57MRQwhd03ySM+vFxIEAf1sBp62b/CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eQnO05bb; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRuOn/ZSgc0tQNbezTYmoSOazSdjygYdoFz189aYglXy9Fp400ZZl4jrUnrtJezlcpMpNWIg4cARPewvJ5Ax8CQg1czfOtLPh+P4botWFXWuXwGChCOp6PtjiGHazhBSpSFpbEX53s41FhTe1BiFnOxQJ4S22SyVIqhDTJ7YVz7HRyD2aQRvA6T3jh+qFDVBMGMTz3l6gVgotFMDrEuxsI8k5Nx+mfnIvNxUs5lu6Lhh3c8OgoJDiLzNsFkFk+aRv8ZqsoYWkN9oa/duqODtf2JofT/rcgUTr2YHhjR4fW1GIS/re5mVNEhTUwmngDwim6maeyKr/t33jXCZMAgWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6yrNd2LbPQK1K+2LkDTTqu5HeXqB0/lNy9ziHEMBw0=;
 b=Es8jC61RbB9ZZeehcgp0+0JHWKCyTTwg0vN2FIwbnYelANdbKRZV93ng/5RbsCUn4I912zDrqNI4+oUG502sQBtgXjb/qtzh0okYALn90WUs57SEMs0X2xc5/1bBlIZBfzUQBml/UZQ1M+FSNvRj6Xkop7GlhJCshacCZ0Cq/hrPtcu0ixiUPu6wubrdCE0yly4gOTW2bHOACYgaUn56xBW8gmSJC2T6vecYtcv4A5q6fMLzKfRYFOFsMDTnxyX5OiTEAls8Uov4OSah4JdMt4iGd8g2J4KUY9mbzNpqeddcs0AccQoO5mQPJvtNMrxTAyY8gOztJJiyJyXhHhL1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6yrNd2LbPQK1K+2LkDTTqu5HeXqB0/lNy9ziHEMBw0=;
 b=eQnO05bbVQijz6SIIyP5WXV9kC0Tza5QotY7GFVYaKQZg/fU97CRQsYPcPTHb077ASIshK+tWQBPJPeqJVX33H/ucEa7n4I7h8W9LQuqrBJv0fYtOlpb5QXw+JF0o/Ocaty/dJvr353t9b/M7aoWaG3SVw1xLJ/DCSpyL/dxETg=
Received: from BN9PR03CA0336.namprd03.prod.outlook.com (2603:10b6:408:f6::11)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 11:48:43 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::9f) by BN9PR03CA0336.outlook.office365.com
 (2603:10b6:408:f6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Thu,
 29 May 2025 11:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 11:48:42 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 06:48:40 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Len Brown <lenb@kernel.org>, Patryk Wlazlyn
	<patryk.wlazlyn@linux.intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH] tools/turbostat: Fix package-energy reporting on platforms with per_core_rapl
Date: Thu, 29 May 2025 17:18:25 +0530
Message-ID: <20250529114825.1826-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f6d207-48b3-444e-8be6-08dd9ea6c2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIdc6IcURFCTHvQXH9l9/ZPaifPO3uACQ6NcBuiBshp+E+b+OTNZFWtwlZ1F?=
 =?us-ascii?Q?YSas9CoWL42HJzTOCVE2+vUxKzqToixej5H+IMazvqRUGlqTRClKXblIi8+v?=
 =?us-ascii?Q?xZZD8V6tLW3YI3RJyiKiqrJRUfldDL+QmA++dtIXvlTzExOhxEReATcNAu30?=
 =?us-ascii?Q?DVr0ycYkxWIVdTMGeokOFb/XpF5JLXXcmg6Q2vVebrw/m9EutY+eC1q/Cnmy?=
 =?us-ascii?Q?zSnBAnvEO5LwmJXR6YbQzHnfr1wAAWN3Qp/Ies8icZee7SNnt2/nL+VsDE8J?=
 =?us-ascii?Q?JR2NbUmMvKTeCT1ldafRSS119iA4tKfOyFeXo0o3uuUFWbjwvUk/6KMTuAdp?=
 =?us-ascii?Q?5J14eGDW6leLk51iE/kDpbgwZRlbQT5c6ZmxUb/6khETZaNxwfEXSDdI8I8I?=
 =?us-ascii?Q?E4BjftEj9PCyinTtyAGL0n+ZKsJxv2N/yEyRAwfiypZIgHK94sPXgIqzlPoj?=
 =?us-ascii?Q?y51E+uhowc0AvlkCILbt+tEEYP/dvnUH21uxRdI2pE/Zou55XiJeafDR+49K?=
 =?us-ascii?Q?M1KYWt6yMNNFJES8SRkFQCPQQZ9MquK2EItDwp+82svyztBpknR+M8C3tB7t?=
 =?us-ascii?Q?MUSvw2VVc2/NowWQYobyx+/yWfdyndiPk0qoiy/XSQfRbjSOBYja/BKspX5W?=
 =?us-ascii?Q?ektE1QouNLfM63Nfsc337rCC+QhdwqvCoEkBUTlZnaPgvmkRF7gJLntNACqX?=
 =?us-ascii?Q?8RA/+ZCqsuccOtCRpzj6K8NY0NnOCUZu6FeG24qVXNS94Y1yfp3NyZ8EsLG9?=
 =?us-ascii?Q?IvVOeNcKiGRz2BHjNTIqhpM0U9R686hi/RGw+jC+qasZehtAFFU0U8eSsfl1?=
 =?us-ascii?Q?zowIQd6vw9HOQcomKqLs7+Qq9BJq8nclU4VtJAGlPk+ZVpIMC87QZCWEMlia?=
 =?us-ascii?Q?NN9I2xiXCKHjJB7zFhG9pSBCVaz6ctH401Rol3giD5uwGHSZtXEp5zLe9iDk?=
 =?us-ascii?Q?kzszCtVHjZ/zTUqa+HI1cunUgpBdb5/qWsq9OLPxzeciPisr+KVfGVSHNYt4?=
 =?us-ascii?Q?wCkljdzVUMlcTqwK66iun3STEJaqtWxuYzanPDKwtt9LjHSsWBKVpcySa+UL?=
 =?us-ascii?Q?bjDo8kkhtLUDQUPTlAXmzHB2jAt3xFAI5jTTZ9COcPrs8YWeLIJ5/70gLjSJ?=
 =?us-ascii?Q?bYSJD8HmrPKJh6pAWIHE+158rea+lC+eGGmMsHMHxURSC7dDPK4fpbp1GSXa?=
 =?us-ascii?Q?ua+2PeVvoref2xQsjqzXOd/xkH3VBJyeROUtXH/MGlKjiToVcFJV8vEoRRH+?=
 =?us-ascii?Q?+CQQ9sWPozz+vAJXt06z/sg8VsXIpZhE0V6oxV5O8sulrQQJRK2M8T5R8aLD?=
 =?us-ascii?Q?wV87WYRKfhFiZPH49p9dltQLMw+04mNZozOCAYy/3pRitdl5+x+MaWP8DcM4?=
 =?us-ascii?Q?U6mX4a6Hzgkje2MnOrjyf4eqE1kMktOHr6PqwvSBHGXEyUGj3bDyQedouGjm?=
 =?us-ascii?Q?BbFblO8kmoHpGJF0Krc57zu+6HonfV/NZjJ8IFDCV9MqRJqH87OX8ozFtIkm?=
 =?us-ascii?Q?S5soau9nzojyy14t4fUhYax+w2Icp2RORPM9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 11:48:42.8539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f6d207-48b3-444e-8be6-08dd9ea6c2f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

commit 05a2f07db888 ("tools/power turbostat: read RAPL counters via
perf") that adds support to read RAPL counters via perf defines the
notion of a RAPL domain_id which is set to physical_core_id on
platforms which support per_core_rapl counters (Eg: AMD processors
Family 17h onwards) and is set to the physical_package_id on all the
other platforms.

However, the physical_core_id is only unique within a package and on
platforms with multiple packages more than one core can have the same
physical_core_id and thus the same domain_id. (For eg, the first cores
of each package have the physical_core_id = 0). This results in all
these cores with the same physical_core_id using the same entry in the
rapl_counter_info_perdomain[]. Since rapl_perf_init() skips the
perf-initialization for cores whose domain_ids have already been
visited, cores that have the same physical_core_id always read the
perf file corresponding to the physical_core_id of the first package
and thus the package-energy is incorrectly reported to be the same
value for different packages.

Note: This issue only arises when RAPL counters are read via perf and
not when they are read via MSRs since in the latter case the MSRs are
read separately on each core.

Fix this issue by associating each CPU with rapl_core_id which is
unique across all the packages in the system.

Fixes: 05a2f07db888 ("tools/power turbostat: read RAPL counters via perf")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 tools/power/x86/turbostat/turbostat.c | 41 +++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0170d3cc6819..ab79854cb296 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4766,6 +4766,38 @@ unsigned long pmt_read_counter(struct pmt_counter *ppmt, unsigned int domain_id)
 	return (value & value_mask) >> value_shift;
 }
 
+
+/* Rapl domain enumeration helpers */
+static inline int get_rapl_num_domains(void)
+{
+	int num_packages = topo.max_package_id + 1;
+	int num_cores_per_package;
+	int num_cores;
+
+	if (!platform->has_per_core_rapl)
+		return num_packages;
+
+	num_cores_per_package = topo.max_core_id + 1;
+	num_cores = num_cores_per_package * num_packages;
+
+	return num_cores;
+}
+
+static inline int get_rapl_domain_id(int cpu)
+{
+	int nr_cores_per_package = topo.max_core_id + 1;
+	int rapl_core_id;
+
+	if (!platform->has_per_core_rapl)
+		return cpus[cpu].physical_package_id;
+
+	/* Compute the system-wide unique core-id for @cpu */
+	rapl_core_id = cpus[cpu].physical_core_id;
+	rapl_core_id += cpus[cpu].physical_package_id * nr_cores_per_package;
+
+	return rapl_core_id;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -4821,7 +4853,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		goto done;
 
 	if (platform->has_per_core_rapl) {
-		status = get_rapl_counters(cpu, c->core_id, c, p);
+		status = get_rapl_counters(cpu, get_rapl_domain_id(cpu), c, p);
 		if (status != 0)
 			return status;
 	}
@@ -4887,7 +4919,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		p->sys_lpi = cpuidle_cur_sys_lpi_us;
 
 	if (!platform->has_per_core_rapl) {
-		status = get_rapl_counters(cpu, p->package_id, c, p);
+		status = get_rapl_counters(cpu, get_rapl_domain_id(cpu), c, p);
 		if (status != 0)
 			return status;
 	}
@@ -7863,7 +7895,7 @@ void linux_perf_init(void)
 
 void rapl_perf_init(void)
 {
-	const unsigned int num_domains = (platform->has_per_core_rapl ? topo.max_core_id : topo.max_package_id) + 1;
+	const unsigned int num_domains = get_rapl_num_domains();
 	bool *domain_visited = calloc(num_domains, sizeof(bool));
 
 	rapl_counter_info_perdomain = calloc(num_domains, sizeof(*rapl_counter_info_perdomain));
@@ -7904,8 +7936,7 @@ void rapl_perf_init(void)
 				continue;
 
 			/* Skip already seen and handled RAPL domains */
-			next_domain =
-			    platform->has_per_core_rapl ? cpus[cpu].physical_core_id : cpus[cpu].physical_package_id;
+			next_domain = get_rapl_domain_id(cpu);
 
 			assert(next_domain < num_domains);
 
-- 
2.34.1



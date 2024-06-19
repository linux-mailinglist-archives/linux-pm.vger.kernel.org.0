Return-Path: <linux-pm+bounces-9603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D2790F26A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B631F23366
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4235A15535A;
	Wed, 19 Jun 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PbiXQAwR"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FF14F9F1;
	Wed, 19 Jun 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811658; cv=fail; b=VoRukNUXr5WgmntaeXXa6KpTb2UX+XA+feuhq3g+5B7RAUhRsmO2mvDHdyGiawbLv1BnxoF9wTbpxzKF4Ri4zeXxhTj7w9lgflfba+4EoIQ4loh7776fXb1V7/yxiPlHWpBA21Vlemcs06qncdbmrkD/fz/ORI09lBe1FU0RRH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811658; c=relaxed/simple;
	bh=Ny0uF5aZ/FeQsrJblVc03pDhAKlF0YUxpi5V+fC9JQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOn5EM5v5c+mOQ3K2a2AA7WOC7DmpOwSGO2LFdPF7FSQtfsl58DUy9Ut0n4N5n3u+5hWulpwRWTiKkik/F/P2ihkfBzIC+FZp7DBDyfN+UKqwxXKeMkld6FnAGEbyA4Z3tWIGILnVUj2qe6wjZoKw6ewea4mcKLWl6DJyzbdIhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PbiXQAwR; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itLnPfLQdhEVMo2ker5dTv4xF33MCRMKquSH8aeVGxCU20nzN2RjRv+04+Z2kR2GTDo/Q9kWwMTEuh3rvWWyM59N0AIhgwCkr0gxgZUAxeqj67O7qxN/feQTkFZ1K9GvpOqPKRXvnp7gydjHOx3ZlbNkXtd+okfCGfHAvJo2xOGNsAaHtga/4RgKVCurl728yr89FuRbDN+UXD66okD1NfIQ0jxP6Y+gt76OCawxAMqs6gC5bzKePyuTO7csR2bmxSvDF0WFkpZJ/rcdb/9hRM39mDbMBvnIEY7o+VewI7BSCfmNz4NlSUDiTQjOp0T0ZgDv4nnTQb2DqoyAvJb6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2k7rycL6MnzZVLP8tEfnjfQzvvGfryfV/i9jWa2Jxc=;
 b=QJwGYoRi+WdOrjwQYdHx9cNqBcKQswsmhXK60tUhHgLIbfo82lImFf4FoFFhEX65TsStWraoCZBCthHVtKLEuvkQeuD3Of/sV1TuGMwCOIDJPZRDp8UczC6WM9dRGUxce2cx8KUFvbSFY7/afD3ktkk4L40DrLiNq6boFxr3ay6RtyUIIv7MD9/bBqWm7Vfk761D7gbCX95o84W+/xJ2VeD35HZ2jKB2GQIQpe+mLbq1jLXUvVHpU3k5GOckfiw4sFxY4aDQcC+XoL37uyNGy9JTM6iR0iELPnxPT67RZFO4ENiUa7EsEFxgVkk1eZPzzIGLykanZadT1bMkH4w9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2k7rycL6MnzZVLP8tEfnjfQzvvGfryfV/i9jWa2Jxc=;
 b=PbiXQAwR3ekaDNWSgH41vBbX4Y6z1pLDQIOmpLtRU04BVR07HxqdN4AOuS/q7tdZWHGLyPH204vYBnLYfra/AeI6EtuCt7hqIafBXTXTXW+8gEwWs4ETBPpUd469bnv5I2RHZgXcKq9Qh+c5FOim8dPcBpm1Z0U0nNAE7RowTm8=
Received: from CH2PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:4e::19)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:40:51 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::1f) by CH2PR02CA0009.outlook.office365.com
 (2603:10b6:610:4e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 15:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:40:50 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:47 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/8] cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS
Date: Wed, 19 Jun 2024 23:40:15 +0800
Message-ID: <42c953616ac121bd1e5c329e83d015a02e6b32c7.1718811234.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718811234.git.perry.yuan@amd.com>
References: <cover.1718811234.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: d141c250-e215-465f-f0fa-08dc90763289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FQgY31eGcr4cBhO1fyylmjF2fHc/33x51NKKw5xv3EC5P8XfQ6MdDLfQRWyA?=
 =?us-ascii?Q?mBk2lTgHuFdkGrse11CcLpkpYRGwc0QFO7UTJORdLUWEO73MGM9RW6BV2i+J?=
 =?us-ascii?Q?tJEyp8VkoWbcQfDYoBa+yq4mII64TM85d/NbXI6ffjR/y63Q9UhdEMghiRyk?=
 =?us-ascii?Q?dL2Qo7zBVIV3+7+K4Y1ndhtFUtxYs4oaYy4KL8fYHOt4MR84NST1sSPB+M32?=
 =?us-ascii?Q?VUDjuYAhEF0h97+ipG3hNDzkQudo8a8YLmBCwOxF4NR+gCyCg00ml9UGwcJx?=
 =?us-ascii?Q?fgB/U+lyz4VotbyUFfSQVmA9OnNbuuuQ9tDFRoS+yc9Vvs98vExJlUfb56OJ?=
 =?us-ascii?Q?yN6I6Eg95rLgGm42SmRCnS9UAkeCOtNd+qma1E6EJ0eZMXzm4HKibjJSMMit?=
 =?us-ascii?Q?R725C/+V9UJqA6uZuJ/pxXGryG4gwDD53qfQqhjauO5BJx9CewyqoOjL/xtT?=
 =?us-ascii?Q?RUsgVJSZVDgnPiBWFSzWXi+cBVOlpW4Y/3dZnFvoBi2x4+ItSyzvOC5+iXHX?=
 =?us-ascii?Q?AZQrSh8ntNLL5dZNvLR9xyHECbukS4GdITxl+WqQ2OYJcR8pfll0coiQd81T?=
 =?us-ascii?Q?MPguZblJjxrKtFnQVC1fGNP8iQFPD+mDV/91Ow0sqQcb2gmdUmZxILvwjJkE?=
 =?us-ascii?Q?R1O+k0Qqn/kJFtDWlO/7yTeI5GQlC6uYxCbGoIJZyL1w4wX9sDlQ46uZaeK/?=
 =?us-ascii?Q?uFefKtlIDoeyx3kbMEugZLyJefeZk7aOj8yYYLSpm2y+z4MSfWwPDZ2rKNaq?=
 =?us-ascii?Q?pyUppeF4Q75x63l1nIWruRqIAgBxcm1f5423YRbFWIGu4jgXw9+jQ6crP/To?=
 =?us-ascii?Q?qexzcduqnLf6o+lABb7jX6xQutAcgDG0oIKpGzgk4vQzruHsu9kHFM64vGja?=
 =?us-ascii?Q?gNyNhStxZZTqZ0JGxthzVgSCO0T864/2GV+umGvEsVpy0k5j6pE+ym20c5zq?=
 =?us-ascii?Q?l+jklONe5M45grR5sUDpdSDvtaarrLxAkqUmgUGBuQmq3xKaEgOhS6KqVCRa?=
 =?us-ascii?Q?9YMwHOxWAvCwhyDcO4Y+GBLOmAHva7cMZLx0KPWWvmv1Ld8YX3zL2+Qcq+mB?=
 =?us-ascii?Q?J9a8hnIC8Rk2gcAa801ee8CXWmkjS9dvt+g0DEjkdFG06tyxLw5jVDcUfu7L?=
 =?us-ascii?Q?pEHc/7hp5F36NLM7i5t15cArMKQf5/mKdkQIPeBKnvCVQ2hAz3Qe0cZERXiV?=
 =?us-ascii?Q?gzOn6tBiDRbWQpSXW8hcOL76xv3+Yo0efLCeofEqwyIuGHLbWQtmoDJhvrFn?=
 =?us-ascii?Q?LJVUoFRqXDFcmPT74nKDYbcybql309jOdiPTWJdQIdQo4Z22/MvRMb+ovfFW?=
 =?us-ascii?Q?5EjFXm/zDENQBi0Mc0bvFAlJQaPPTp0zI8LyjC0K8CgzLPLGacyQfE0GgUc0?=
 =?us-ascii?Q?nGA1nyM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:50.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d141c250-e215-465f-f0fa-08dc90763289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050

If CPPC feature is supported by the CPU however the CPUID flag bit is not
set by SBIOS, the `amd_pstate` will be failed to load while system
booting.
So adding one more debug message to inform user to check the SBIOS setting,
The change also can help maintainers to debug why amd_pstate driver failed
to be loaded at system booting if the processor support CPPC.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 76419762c04f..9aa220a0e3fe 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1749,11 +1749,37 @@ static int __init amd_pstate_set_driver(int mode_idx)
  */
 static bool amd_cppc_supported(void)
 {
+	struct cpuinfo_x86 *c = &cpu_data(0);
+	bool warn = false;
+
 	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
 		pr_debug_once("CPPC feature is not supported by the processor\n");
 		return false;
 	}
 
+	/*
+	 * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
+	 * the AMD Pstate driver may not function correctly.
+	 * Check the CPPC flag and display a warning message if the platform supports CPPC.
+	 * Note: below checking code will not abort the driver registeration process because of
+	 * the code is added for debugging purposes.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
+			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
+				warn = true;
+		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
+			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) ||
+					(c->x86_model > 0x40 && c->x86_model < 0xaf))
+				warn = true;
+		} else if (cpu_feature_enabled(X86_FEATURE_ZEN5)) {
+			warn = true;
+		}
+	}
+
+	if (warn)
+		pr_warn_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
+					"Please enable it if your BIOS has the CPPC option.\n");
 	return true;
 }
 
-- 
2.34.1



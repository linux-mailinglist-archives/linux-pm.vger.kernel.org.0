Return-Path: <linux-pm+bounces-9282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048B690A64B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01491C215EC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB4418F2E5;
	Mon, 17 Jun 2024 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="abfgOLRt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7188118F2C8;
	Mon, 17 Jun 2024 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607629; cv=fail; b=PApyGWmSwrHB2YSzydqxjvkf69mYEAvYiTRUrJtONnn9cRmFobZqN/Zpql4xsbGOyxl5uR66FwH8NL+rpwLR/WNe1ljaCIvnjBYmyaGhTms0BD8pNak1cYdhGjpuqklOfSDZDuqCuBJ8EcY9CD82DfhU5r8ARZIoUjQDmdi913Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607629; c=relaxed/simple;
	bh=flulp2l17ZcMirBGjtuR9DGyLFB5qYQ1O9kTE/k2utA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdANSd6XW0tDC6jXXky61bCHwlx9iV3wkYpS9G5xNDhJpx4a8nu6K6UVPwdJs+iFZulXyyiF85D9lHRTcygNj1hpZ52tgedOElIMTDM+mN+ErjhQjXDnmeOkj/RBUY6qho5qvr9mEkpHSkAxfYuFzGeLgqLUt3KluyTWr3JAcxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=abfgOLRt; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow5gf4KWXFgzjZisjRb2jl6jhiTE/xtfMRNYNSy68xrGqpBpTt88wLbpqVTUPAuS+3/4GSPvMcqy8aAtZ7J2Dbc/veyWQLpa12giBaWmKRuaVj0wmMOcrKPpE1JqwWh6y0srNYS4QD4pLY0L5ftxOycs7Sbtx2zjOXVSp+RSETsncp/6fh9pZMW9cd0xHULDIiQfPEDJG9rldmpFXx1tjjo8K9Mpbj13HQsD4iwYkuy0be5IJO7n3bcdUnc9pI9yf1uqvryfvh6DEA7WnCl1NUFQWPZ/b9ZvJDwzlQQI3d1hcEHLr1J0gXqIhHC94QCP/BUe3RBxqxbqCGD/IHOSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBDCR8wKHm6M0ndj0xbQF2fjvAcPcwvYwUuQn5l17x8=;
 b=VVDkHtAB3oZ9ls9lek6r6n5mCMIF4g3CK2mHqzEYjhuWPwioz2Qc74AjQBNipLDZUoRX1ntZuEaWJaScdKnVpP283WQf7xqqqKzDwlit13qBiQzwfVoDNpgPWbT6zKNYT4WsEc5vzxSqix5WCZfWqeT2KvA+PQAe4GP2rJQyPrOzGCz5+zugIeDrUn028Oh9OgVkM1EC0ev7pxukcdR3tDlB6TgTSh3ogBVhR8U3/FVeTaLwN7ynNdjpymymfUq/JoIIls5Hq5iOOmkC87ZrD00ouPvElShqfTGHarZPwi87N2fip6dub23jCyUiFZZuslHg6MTpEU3F0QXJxFFRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBDCR8wKHm6M0ndj0xbQF2fjvAcPcwvYwUuQn5l17x8=;
 b=abfgOLRtN+3ZuRJMPfWP2CCocP+NlxX9kYwM7ZjuIbWUmz2lUk3i2XlRdbLqVg8LTBV7eF2RVOT2+vye5GIRjsfN577lEQiyIiT9TGiZXHNd4M5eenFhLkHMmvORUtd9rMPTHrmBKpK2/NqnggZgEDjDBQP+7cSNsAv5suNesLM=
Received: from DS7PR03CA0143.namprd03.prod.outlook.com (2603:10b6:5:3b4::28)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:00:24 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::e9) by DS7PR03CA0143.outlook.office365.com
 (2603:10b6:5:3b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:24 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:20 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/11] cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
Date: Mon, 17 Jun 2024 14:59:05 +0800
Message-ID: <77c51d83efa4663d94c733fe43c2033161e8ad9f.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0ad955-ee54-4855-0350-08dc8e9b2999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oEBJ9yPgH2xlDUmkz3a4wSx8FIVkQlwdajBX5AHarX3VX2hmE37R8yF1quAr?=
 =?us-ascii?Q?w/a1q0MguKyKPkd3h2VAIvovSOL2FrLhk435PVnXYTjMuwbNn3FJSWYfoINc?=
 =?us-ascii?Q?1SEL4Yk32oG19Bive9KFj9kJEg/moK4SQkEWIH+XJqF+FFCwWBGJuz57KfTZ?=
 =?us-ascii?Q?ZbuRn9TZQ0dtJZbVVmW0kJWk1a/n2isLnNbQ/JceqD4iCeZqbpEEuwCSiQLr?=
 =?us-ascii?Q?xN//sUAwdZq+8nKesCIMk8SvSAiUKPh1AALtj68YS0kPISugV2sWH70LVg2g?=
 =?us-ascii?Q?PiC75uVM6X6GuwO7G86NnVTWYvuf9IZa1Wlw4z2qOtWnft+cZaOIOw7oZcOV?=
 =?us-ascii?Q?HyO9sqle+qcQ2GYS2NEhfxN+/3XoUN+U4wobptfUf3kFwzVkuXzvklHPIyY5?=
 =?us-ascii?Q?Ck03b4eNmP/rjMnbo1snn9jg1ral61lqipItPR+7NEc74JQp+JIytaChUVSC?=
 =?us-ascii?Q?AXF83BtXb4e1ffZvxYpkBFZkvFReVO0Qf+v/snf+5MP9wtrD1tavt/ViIm+r?=
 =?us-ascii?Q?iaQTzrhNk6oqijXAJv3WzV/CCxw9xbdYoxB1/j1uPP3WX+bot06vuwq1ltq+?=
 =?us-ascii?Q?CSm4ciUW0ZoDPLJsyF7T45PqWWFDXvCDN7N6RHxxVfABL8DiGZ33XCkyXO+i?=
 =?us-ascii?Q?EiwWoA3T2NVBPsAXE9AenkfyhJx2OZ7c0wwiqHDRjfHVSP4G3CRSRlM0E2fq?=
 =?us-ascii?Q?g+mdwk6IYsindxNHI65lyIeqHQjAt8sV+xlZhWfi2ApaCF12D7Rv+AtVWroi?=
 =?us-ascii?Q?PlEAn2oEV1+/SOsHMTDLVYYYLefwn0F6nKOhL0PYr9oKfmXGY0tlDLv0fRok?=
 =?us-ascii?Q?9eXKOJKVojrEGo9WnGJA8PM7BwRkrCGIedvUU/bulJB8TO2E93hQYFkDbHrb?=
 =?us-ascii?Q?GNHwW9JQensStXc9vSgh5KBx+OmsEkNYsMP1/TMsDw5ul3XxOs6hmhfYuZMA?=
 =?us-ascii?Q?pEARnxq5o9S4CjaIsJ61gzVnm66fT0kr15iYoe/6v8sa6ZAeoA3T3ciVyBsC?=
 =?us-ascii?Q?RKQ7XPKOMGiZOYJN+rV62pYnJrVf8t4rx1cOYifiEZqRZTvWg48yVvKmF9Y0?=
 =?us-ascii?Q?NMGjHF3XZn62DCZgB3PkJkDCrI4f9ae6PKk1x6fImvsrfS89WT8hRAL3biIx?=
 =?us-ascii?Q?y2FVQZwChSNR2+tHoZlJ+CrmbnA7NqBmerKr2P2BZ0LuDfrQAU0u3pdqA6xn?=
 =?us-ascii?Q?HBvI92EnC2LPliNZOvzDkY7FcuApRLe/YQPKJqqM+rkPLbdXXw5ClFw0fcVE?=
 =?us-ascii?Q?VfbfMVarGItoaARb51nPn8HzItINF2rSaCWd7BxRkUwTkk6slVovgnMa8Zk/?=
 =?us-ascii?Q?Ll5SJdEK+pX1sz24eLGn5Kl9Ad95aO/qReXH6pjxbHIpv128eIFo85wPLRl/?=
 =?us-ascii?Q?/nyROoY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:24.7642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0ad955-ee54-4855-0350-08dc8e9b2999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

Add CPU ID checking in case the driver attempt to load on systems where
CPPC functionality is unavailable. And the warning message will not
be shown if CPPC is not supported.

It will also print debug message if the CPU has no CPPC support that
helps to debug the driver loading failure issue.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-pm/CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com/T/#t
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1ce063a22214..76419762c04f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1743,6 +1743,20 @@ static int __init amd_pstate_set_driver(int mode_idx)
 	return -EINVAL;
 }
 
+/**
+ * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
+ * show the debug message that helps to check if the CPU has CPPC support for loading issue.
+ */
+static bool amd_cppc_supported(void)
+{
+	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
+		pr_debug_once("CPPC feature is not supported by the processor\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int __init amd_pstate_init(void)
 {
 	struct device *dev_root;
@@ -1751,6 +1765,11 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
+	/* show debug message only if CPPC is not supported */
+	if (!amd_cppc_supported())
+		return -EOPNOTSUPP;
+
+	/* show warning message when BIOS broken or ACPI disabled */
 	if (!acpi_cpc_valid()) {
 		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
 		return -ENODEV;
-- 
2.34.1



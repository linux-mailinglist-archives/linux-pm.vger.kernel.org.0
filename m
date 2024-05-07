Return-Path: <linux-pm+bounces-7563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C768BDC4E
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967591F21459
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED1313D513;
	Tue,  7 May 2024 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TR1KRgQE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868A13D501;
	Tue,  7 May 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066190; cv=fail; b=rO2yu8yxgOO1q7oQNRXvaq18sBN/oyq941ThQtIcxaa9bG/T9GrZuaxnkI1lfPQ/Na5HP0FLJTbG5fvgVeKl9HzKvONIBSVIsLZ+XjpsgnEZQmRlIjbtsU4qD4KzcGeW8GU8WKGX3KhuzPC27S0lp0XkVYThk9dwJhuvek9G/EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066190; c=relaxed/simple;
	bh=W06K47bL5zCYSt75aSZyNAtpQ/FwFe9ZWe6fIjMWRT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhArjGmRT5R3ZsM9lGlwGnTygLZbpwdgm9gl3PID4cQmJXlBA6cdXk0W/KgOD38PWdTaGMglR5rPjwOwc2ffFHiHqoXL08NyZVD5UKY2lIIC4ViCqNGgJtGTmIhbd1rnhocQbZyMWVnVMzJN7ole9uyfR6omFrOU1g228BEF1Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TR1KRgQE; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpbB9dBmMznO71OUB/Z6T95lKY+pXDBFQw3g6eMty/CeT34pMgrYr7LRslSOdBhYxV1svqbGYoK9434WkTu+SuYslb9Zv450ewwMdSdVXihBKwzT9IDgjlmEQYyITux+LIc51NzHklMwnGb6J0e2bnDDGSnP5iyyiKaMTSCMCwbnJUF91j7JqiJ9t+lmdmEnFZdYZJJ4CENTz+8ntLivcQvlnkLC0wVOp7wTo6oyh5FYguZrQVF2H3QcEWv7LcqEbb+dve04c+LO5+nkwuEEpP13nCOnvtXJy7kb1R62vi+WmOqRa8MBHwTx1BMtSldiz9OcOEE+DGc9lHfSt26pXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1xSnUzQ2FzYThqDpwt0+5Ar45O/EvXjCsYYKNQOn/E=;
 b=Skb8BrW2UfjXWsg697hTgujAE/ypPvKe4xjA4rceAL4CO2x3qleu6k1ESQY08GBCZG6gESGBS7atdSEzXjWadro2rIgWo1RvI07+qBLxNaC4K9WJDr9U4bjRy0ItYrAZi7fazyJT77Nukm3ukoshHA8Rq7fLuGDCUgi4ppmTmxMxAp7qs35jQtmc6eVbEPjIGxamHrkz3Ze+lQgbX33pfeBCpPcp4sS6TZxolIAMhQNQMF8EGt/ibpL8dnLZAWoJvLAsSgoOCSF49kNc92WAia9Vl5DCo37qTZzHe4p34rAvhQipWiVxTOFBM86Ikr3vwCG97WnXAOcaATvCqwEQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1xSnUzQ2FzYThqDpwt0+5Ar45O/EvXjCsYYKNQOn/E=;
 b=TR1KRgQEs3PJ4/MdcZzpW0GQy+bt28b+fA0xbsGXqVRFwIyNdfXGUEaFYCAZyMPxjy+4CwaXmivPS18Hh5EKICj4jZ0GrO0LBoiXT6d2bg0gyzqCfOvBpRf1wQxBeA+WqNqCyz26AL7Q3KpXCF4OFKRzq9oloQBnZ4pYvWRizm8=
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 07:16:26 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::e5) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 7 May 2024 07:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:16:25 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:16:22 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] cpufreq: amd-pstate: automatically load pstate driver by default
Date: Tue, 7 May 2024 15:15:27 +0800
Message-ID: <60bdfbeb426512d74faa91597453fd7960ebd7b5.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715065568.git.perry.yuan@amd.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: dae60c5a-5284-4eb4-e8be-08dc6e659b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SMMbUUQPNLER+NOgnwdIb16PhD7oahc24Yu9Y9X0+fpno59tYVlCRm0Kcyus?=
 =?us-ascii?Q?W085SWsj47G1YgIwdCDY/NIwWRa/eGOFRk06DRmzZWi8T5etHVKiCN5Ag24p?=
 =?us-ascii?Q?JWdDB2cCbXQO1PgMkOo5t4MoQ6+xxq/eLejZjxDnMAE/Jp+Z1pLjAi1vDRea?=
 =?us-ascii?Q?VDN9t2MBFm5iDpK6S8pDMd4xlCJ1V3p7XTZipYnpAUT3HvMK89GmPigDrc6M?=
 =?us-ascii?Q?Tlx2SMfwM8O/y7ACu6gajYuWUSTnAxLfb2uLgTvbWujzOvBZ60ot5YlDGOTP?=
 =?us-ascii?Q?+P+67143XQpkduInb0P2CUwmboA2Yz0yByomvLghEHLP/CNtTT9Y7HDJJJv7?=
 =?us-ascii?Q?XBtu2jjwkLF7JQMoBeRACWxYD0VovQqasHKKmjRODXcPRVy0afw89MgtOypZ?=
 =?us-ascii?Q?Cn0JAapHzbzNRACe/cSFt0CNSN8Hlh56cG4h8BuIAm73UT7gx0q4pLzYJmJi?=
 =?us-ascii?Q?+oyxUizKdX7E8PkSWr6fttT1HpTZb9N8Qx80PV02q1E5L9G0SPPoEGvintyt?=
 =?us-ascii?Q?Irr6d4IZ1rhu1Q00WZFI9BR+cC7rAHuOZvrIpbXXiTQbyXBsX2+9F9Dk1cUQ?=
 =?us-ascii?Q?gJUwMcpkxi+tMuFc/3+b3s1AkJNCEHgrdPuwJSr9i241MCfAP3piwjUaf7dH?=
 =?us-ascii?Q?H0D9C+5Ccrs/mzwKF+xR+EuLB6t0PNWUHTDlvWdRORsGWO3gPIR3xF6j5drP?=
 =?us-ascii?Q?0GmID/wfmUPjv1ADM6IDZBRZa69l1IcsKwLVShFYKzZXa1i+iPB6v2NsaUHZ?=
 =?us-ascii?Q?8v66g44BBTZg6jo6eHr/SzfjQv2FtapRTPcUvBVS39pqH8T4vCxWhVUvaq6i?=
 =?us-ascii?Q?1Yyjic/IsNuvjVzDpvlMKqPP78Gf6ryxaaGxPxKmYK5jQZ5nKG0/sG6nzYl5?=
 =?us-ascii?Q?UPyqCNqgI0OqHIifsqTxT/Yb+KGmwRjuuZWHNOqzHeh/Ugh5rGZ6Za/jwQQe?=
 =?us-ascii?Q?S6yXWoaKOPPyhIYxqJcG8tfHt8UrzeKsKeMKSTwxRe9zD5wdOVzXOhw643Q+?=
 =?us-ascii?Q?8ADu6Tx+Duch0v5gF5OUaLxyLmI592HKJenlX1XxIODzc2XH8RxreHXXEF/w?=
 =?us-ascii?Q?CZ+nXKqssPR96c02M0F51BPUuR9YjQrNS7w0RGy9eZRxSSRS+m5CiZHVg6Em?=
 =?us-ascii?Q?v+Q2TN8ZpmqF8UCUJQA1YJEJu8YKutsAUddr7Slz+e7j6ZQRF9IUI7etKgDC?=
 =?us-ascii?Q?lvBYgga6RzS4Dp26TiS6QmMdYV+lr57fG0TzTCmPxL/UkSrIbgWMMe9PY6cb?=
 =?us-ascii?Q?yf2lYk79OHIbsludPbl8JdWj8byRo7UC0pUwwmUqfgfktqcIWNd6dv8+2A8Z?=
 =?us-ascii?Q?68YooWRsbwU1lFSUuHnFRloJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:16:25.8563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae60c5a-5284-4eb4-e8be-08dc6e659b81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

If the `amd-pstate` driver is not loaded automatically by default,
it is because the kernel command line parameter has not been added.
To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
function to enable the desired mode (passive/active/guided) before registering
the driver instance.
This ensures that the driver is loaded correctly without relying on the kernel
command line parameter.

[    0.917789] usb usb6: Manufacturer: Linux 6.9.0-rc6-amd-pstate-new-fix-v1 xhci-hcd
[    0.982579] amd_pstate: failed to register with return -22

Reported-by: Andrei Amuraritei <andamu@posteo.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3ff381c4edf7..f5368497ee79 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -66,7 +66,7 @@
 static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
-static int cppc_state = AMD_PSTATE_UNDEFINED;
+static int cppc_state;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
@@ -1762,6 +1762,16 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
+	/* Disable on the following configs by default:
+	 * 1. Undefined platforms
+	 * 2. Server platforms
+	 */
+	if (amd_pstate_acpi_pm_profile_undefined() ||
+		amd_pstate_acpi_pm_profile_server()) {
+		pr_info("driver load is disabled for server or undefined platform\n");
+		return -ENODEV;
+	}
+
 	/* show debug message only if CPPC is not supported */
 	if (!amd_cppc_supported())
 		return -EOPNOTSUPP;
@@ -1781,28 +1791,21 @@ static int __init amd_pstate_init(void)
 	/* check if this machine need CPPC quirks */
 	dmi_check_system(amd_pstate_quirks_table);
 
+	/* get default driver mode for loading*/
+	cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
+	pr_debug("cppc working state set to mode:%d\n", cppc_state);
+
 	switch (cppc_state) {
-	case AMD_PSTATE_UNDEFINED:
-		/* Disable on the following configs by default:
-		 * 1. Undefined platforms
-		 * 2. Server platforms
-		 * 3. Shared memory designs
-		 */
-		if (amd_pstate_acpi_pm_profile_undefined() ||
-		    amd_pstate_acpi_pm_profile_server() ||
-		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
-			pr_info("driver load is disabled, boot with specific mode to enable this\n");
-			return -ENODEV;
-		}
-		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
-		if (ret)
-			return ret;
-		break;
 	case AMD_PSTATE_DISABLE:
+		pr_info("driver load is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
+	case AMD_PSTATE_UNDEFINED:
 	case AMD_PSTATE_PASSIVE:
 	case AMD_PSTATE_ACTIVE:
 	case AMD_PSTATE_GUIDED:
+		ret = amd_pstate_set_driver(cppc_state);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
@@ -1823,7 +1826,7 @@ static int __init amd_pstate_init(void)
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
-		pr_err("failed to enable with return %d\n", ret);
+		pr_err("failed to enable driver mode(%d) with return %d\n", cppc_state, ret);
 		return ret;
 	}
 
-- 
2.34.1



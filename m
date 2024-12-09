Return-Path: <linux-pm+bounces-18849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516419E9E5C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA232827EB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009D197A6C;
	Mon,  9 Dec 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lEAhTSE6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787C1865E0;
	Mon,  9 Dec 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770399; cv=fail; b=cp1/lfsMuAc6J9d3LarjGJqdKHdxUx8kotWguygO2Ge8mD7Sg36I/SStm4kaFw5aBBJniFl6DfqpSyKc7zTqJsKznc4DzE4B+7HmyFSYwb9fOq4atATZjUFllsifiBO83drr53uFAu0eXmjrsPTJmrmzz438vT/CV4xDNChu+48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770399; c=relaxed/simple;
	bh=UeYbhWvQcmWInVcHnNY1JbEhvvPPfHrL8JLlYCSFOJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOh2rz58hCZAVhdSDDJrHcx5ihOC2Zf4oVrcxVLfJ1kC97m34C3Y7zy6cn//01+M3UOqPEq/FBBRJcCEpyN0kessZHt3rfgQVjAFAYz7HD1Bj7tu49gpwNUK4qK/EQvaJN0kxeelT7tS34jSSeP09EBCPP0dKmKF0QQqgqPih4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lEAhTSE6; arc=fail smtp.client-ip=40.107.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWnjVUkMo9I7ayAJqM71zYu1VEC5Cabf97TuS7nDI9Hapa600w8j0UK4SO7+YGy83UUHJpyrQar4h89qX5GqFBABl3DFP/2P/9PCX4UyxEs6MJrYLH6RiYL58ymUqT1PGqQq10IdwgwWWyV7JvOg/9mQVHkazcUy6ywAvtQYlL2dxzTC0kdP6tFAQmT769M5FUwzEiABFimWOv9QJLSkjiPs9vVPeOAFlTJDdqCbN5kuXNym6SGxXAyWHajU7z2koF3FVpOpGBSHEPsTuu1Xv5bSPF5bxlIBo36bDUIufs1HQnv8SfZMMr1AvyRF7+UsA4MG230Hxwj7R1YPLhI0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFQ7YJImPddudTRBlzJyzW4I+aKSrlmWqIIyVP4Ca9c=;
 b=QMM9pLFZucQ/cC4buBbyCKfvvSyunDYe0iPDdrVhc9jct7IJ5YjDpkWDBtDGIeePDDcDt4AuD1mNSL5FQ6k1+Kb8pPA8LhhI+Tt1RNCYtWcgXvzVZ8NOkTWNtm3lOlCwL57CNQM1fCuV9JvugtPmGH7Sxkm/3xk3vt1bYLhowCzyLfe9vR1qBySE41OlLANpZWO+cB5ANhSNUR0wNkSuCDJU+nn/HHLAclDcIAhFWZEGU0ngA3lEkm3IboysjaKW5jfcbYa0A1sZH54CIvuhjK1krenqtyCHY5RiiSNa+H7GcLaKuMNX+9L4jbswtW5efYVmZz5vkz1sQtfIGdSS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFQ7YJImPddudTRBlzJyzW4I+aKSrlmWqIIyVP4Ca9c=;
 b=lEAhTSE6Vfy5A9sCtrTAJk8gyLtRtPXWKEDdBhNdyh88N08kZ9a0+lh6Drh1j4+PEvI9s+Motrz+SJXux6cnTSlpwR9xVA7r8JFJbazOHov4O+e43MltVH0me0IA/LCpTbkNn0BbR8Qx4shb4t3duAwPzEnmqVJ0tQVQ/KrfDBM=
Received: from CH2PR19CA0020.namprd19.prod.outlook.com (2603:10b6:610:4d::30)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 9 Dec
 2024 18:53:11 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::e7) by CH2PR19CA0020.outlook.office365.com
 (2603:10b6:610:4d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:09 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 01/15] cpufreq/amd-pstate: Store the boost numerator as highest perf again
Date: Mon, 9 Dec 2024 12:52:34 -0600
Message-ID: <20241209185248.16301-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209185248.16301-1-mario.limonciello@amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d8cd2f-e185-4c10-ae0d-08dd1882ba86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v/GfTwlUE9cHn9i1PC1zYAMqmLrox4KYq2w8/YbnkuEqDh0Lh8BbfifxPY8M?=
 =?us-ascii?Q?xODjsP2Xkc2z6U7YoWCt7gNes1ey0x82GqQWHnBIgBIxEQjVXz/nl/s59d+s?=
 =?us-ascii?Q?gTw8RUeCugf+DpST/S0LMXXEiadR61wJxKQu+35MrpiPn3aKsvqGg5YPQOYX?=
 =?us-ascii?Q?AAA67gIO8tyj3qdlplaC7ReGUJPE54VSwEz9WC7maXJBukKoKRiwRTF/dEkX?=
 =?us-ascii?Q?bgv8C15rfl23CJFQDk3SvtCHqfU3KG04BzBViZaTq70b/dtrt0aCiEccWQDk?=
 =?us-ascii?Q?fjTQ0svtIOKjAb45VwyUOFmU6I9qxafjKkEbGXazMN9BcNJxsvL/MAaM7Qs2?=
 =?us-ascii?Q?rXMyO3jOGnxxJeib5LrXbswLd/QjcemSGB1Q1q/AquMfZuXK/y8fbfetn3OP?=
 =?us-ascii?Q?XDijK9+DZ1KU8r2ZtGyFn8H3Tvk4NhjvrrSK1AAodGNaeRLKZ7quhuijVGV2?=
 =?us-ascii?Q?V/MAiMUApVLt3FU1olP/IRtN8wIAugp0fN2wikzN5ohyGyDangYD9wt+4KyG?=
 =?us-ascii?Q?CS7qqWRSp1cezpsK9nHZpZi2rwP15l8shUQ29mkVU9rvWTuTFZB0slWMB0Au?=
 =?us-ascii?Q?FoY17nWP5GqSYLljjBf8/QktmPwAa7WtnizxFo/iHKHBa6Faf4p3bqPohM8B?=
 =?us-ascii?Q?klHWmqyJasJmJ94Z8NnOdEG0pVgjlXCVHUIrBNUYcYYZ7GgnMD5oDwV8ZmqQ?=
 =?us-ascii?Q?ZE+ZuhxrRy0Hjn8S/4tmCUi0ml5k/Yn43zj5HqfbVOramZJ0M0WrM1KlUi3j?=
 =?us-ascii?Q?WxjSKqTlwRaP89eB8wMu4nIDlqRrafPkqzk8BMbuweshpnA54uG7V3RSHEbx?=
 =?us-ascii?Q?YHSxC4O8aLWNJBNXxYZjiGE9KiDNe4qOX9DsgjRFGh1s5+9eAOh3uQ2Plrrv?=
 =?us-ascii?Q?7AfqqofdqNbKtuqlCx28ZooekY/7/8Ig5krf6ddkgDW9L0F5Z1xNTRR9oztc?=
 =?us-ascii?Q?eFmm+nh/SkyzdZ7nF45Jg26X5FH0jKhj+C6AEnWO1fnSv/XjvxrKZkYkqjpR?=
 =?us-ascii?Q?JYze4BNFt6wobc9JP8/9q9Mf/LyWa7QPPTQPcSOEu77CaB0ddyEbXup4Bzoy?=
 =?us-ascii?Q?A9IbAeA4rcOD6mzLzLW/tjgf38UaeHhfFrZJDlrylUHxrdSkuYDPFane5FNn?=
 =?us-ascii?Q?JG3j5XWskhH6Goqv7RX2gi8sdFI+a4QA8FGCOjE4VZuN8QGVZwR7rpcIJvcv?=
 =?us-ascii?Q?w1Ejbcp6LYpaP3ALYd3xwSL6aitkqW9DOm/kegTEDjWO2L6sEaTa8nV5Pk09?=
 =?us-ascii?Q?ln5nkbq//9tBu1ETgwLePiU6pCZFOIHWNVIaHqAaXU81Zpr69ai0vma6flkt?=
 =?us-ascii?Q?QpIzPo7Ant580AZq7evKFt6oNt1ZNH4zOaFN/y9mlx50tL7h04EyF3itkBGN?=
 =?us-ascii?Q?JOyIoC5u8diRlRS8OQBb3C0DZtcs1oTbF0iBL6Ttnp/8G2OHcUoxwkCciAt7?=
 =?us-ascii?Q?C1uUH+RtYeOTudWfguXdPG+erWFpirNZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:10.9744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d8cd2f-e185-4c10-ae0d-08dd1882ba86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811

commit ad4caad58d91d ("cpufreq: amd-pstate: Merge
amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
changed the semantics for highest perf and commit 18d9b52271213
("cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled")
worked around those semantic changes.

This however is a confusing result and furthermore makes it awkward to
change frequency limits and boost due to the scaling differences. Restore
the boost numerator to highest perf again.

Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Fixes: ad4caad58d91 ("cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst |  4 +---
 drivers/cpufreq/amd-pstate.c                | 25 ++++++++++++---------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 210a808b74ec2..412423c54f258 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -251,9 +251,7 @@ performance supported in `AMD CPPC Performance Capability <perf_cap_>`_).
 In some ASICs, the highest CPPC performance is not the one in the ``_CPC``
 table, so we need to expose it to sysfs. If boost is not active, but
 still supported, this maximum frequency will be larger than the one in
-``cpuinfo``. On systems that support preferred core, the driver will have
-different values for some cores than others and this will reflect the values
-advertised by the platform at bootup.
+``cpuinfo``.
 This attribute is read-only.
 
 ``amd_pstate_lowest_nonlinear_freq``
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 66fb7aee95d24..c51026fe636a9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -397,15 +397,19 @@ static inline int amd_pstate_cppc_enable(bool enable)
 
 static int msr_init_perf(struct amd_cpudata *cpudata)
 {
-	u64 cap1;
+	u64 cap1, numerator;
 
 	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
 	if (ret)
 		return ret;
 
-	WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
-	WRITE_ONCE(cpudata->max_limit_perf, AMD_CPPC_HIGHEST_PERF(cap1));
+	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpudata->highest_perf, numerator);
+	WRITE_ONCE(cpudata->max_limit_perf, numerator);
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
@@ -417,13 +421,18 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 static int shmem_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
+	u64 numerator;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
-	WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
-	WRITE_ONCE(cpudata->max_limit_perf, cppc_perf.highest_perf);
+	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpudata->highest_perf, numerator);
+	WRITE_ONCE(cpudata->max_limit_perf, numerator);
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
@@ -912,7 +921,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
 	u32 min_freq, max_freq;
-	u64 numerator;
 	u32 nominal_perf, nominal_freq;
 	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
 	u32 boost_ratio, lowest_nonlinear_ratio;
@@ -934,10 +942,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
-	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
-	if (ret)
-		return ret;
-	boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
+	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
 	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
 
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
-- 
2.43.0



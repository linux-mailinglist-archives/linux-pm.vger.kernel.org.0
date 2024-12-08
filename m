Return-Path: <linux-pm+bounces-18753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6959E83F6
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7947D1884896
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23214D70B;
	Sun,  8 Dec 2024 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XlZxw2Fl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76D149E17;
	Sun,  8 Dec 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639467; cv=fail; b=R+9axDqmkawJ8/fcdEeN3WtSMM7/6k8+WK6R19Vfq0qUbXhexoD/pvrRUPrVg6LGmOBcvre+jx3hk9yBLAS/Cn02CPKA2q5zPRnB8Ohqg4w597K0RIKv+IVsmic8JietqIdbLJ+APr3M3mjxrQLo/GUjH44Pj+A4r8h+Vg6FBjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639467; c=relaxed/simple;
	bh=AwZXjv+db6RTp0lU5VLcJiWHv2AG9kP+T4CZKHiGgRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gwc2sHAYeJYDB9EQP1bfyqnYloM3t7lk4RrveBLnrF0AEeC7vBH6BayM6Dpn4QIrOF+hjcuBhI4Fk/htcRt1M6h9wj53iBBZ2iMkW/BCDW1qiclNXoAMRbcTLt/fZo7GnJgslTc+ZmDsiEy3i2zMUeNuBZA3rXAAQlOw2Fs9eFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XlZxw2Fl; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABOjDn6mbgEvoI1+QYT/YqPgUVZxgSekQb95BQSroWVKvoFjxBIAQkDj8jGunaukV6zLzuQiaFlDEDFDXGv0wGY1/rDh8sHMvTWR7gCzPMqbi5lSAwnHRqqjMx8g4v6M01Flrz8esBwsngioNqdPcRKt7jI62rtlO7qx836iMtkaiaV/0d/OekUQvflN0oHDYvlmHP4ZKg1n8xlbADW53CBRSIT141Yj3KLmFG218HWMl1xfP2FWq3HkfrJIm+9J1f2wT0L3aQcmO0pZ7JKLMfotLvgHuCK9XYtX27UxXVkas3bH9zVRZRqtv6toP+Cprph9xlTeHfUPEX2Nwmw+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1Rs8gVhH+rT2+4S+fdyTLEdm4k86DuUXXfVda7IC34=;
 b=ctGXlld82pscQaPqwHU3kvUInBPu31migLYRwrvXWqcUIleURZmksoWpgU07Y8nBiXk4cKL5OGbzZZAUgmvQHGlYmmwSF0MtfsaRi/5HJ/1Ue+IrzdypDuC346PnSJo4eKY2FDv8bA2OWnabiJlJoTEptV2BzTzXTndZ8bRe8u0HIjdlbhtpec+c0kXNZptr6r9EQERIS4EoT5RiOmBNSJnpInL9IVxMk6LtoTLT79TTNevCfSwNY2xccpf5B13emHRcLTsETZS9gXamoXIiIS3nn5ft8bgWt9NJ2SAmyA86Xm22PL5l9WaHei/liaYJqiTubP34ATT53vdm1xN20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1Rs8gVhH+rT2+4S+fdyTLEdm4k86DuUXXfVda7IC34=;
 b=XlZxw2FlpYW6+U78NM7MO/oe8vvvdTZCiruQn2nMnARU+fAuZX6oxQE32eWU8SKtc0nqQueXzApNTFQ3DMXKK43yA2HVmGOohc63z8RvjdWsQgTCaHbMAS3WStcI9GxgCVBwTBio769GLm0yxUHHyKXclg7asWvyOj3IzsLkuUM=
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Sun, 8 Dec 2024 06:31:00 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::c9) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:31:00 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:57 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 10/16] cpufreq/amd-pstate: Move limit updating code
Date: Sun, 8 Dec 2024 00:30:25 -0600
Message-ID: <20241208063031.3113-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208063031.3113-1-mario.limonciello@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f42a17-c6d4-41ef-5b22-08dd1751e1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q01gqTUfCmg4kkC4KZVzm0UpEKOhOKxmZDPj6aKB2QT8BxogqBXcRRcjeycK?=
 =?us-ascii?Q?1uHgEIEtvs6BjfOyU6crY3syu+w8vb7OAv0tLKIaY/+DWIjfN1pblq/bJn0S?=
 =?us-ascii?Q?VefM7jTFTiGu4/poH5/oJdFEbwolMCyMY2qrlnHtG0kXeAX6PT5AUDl7XqWa?=
 =?us-ascii?Q?zMkdBZne6vZQgs4vCaHilpgBC+O4GqQyTuoB3djWGCsb2kOr4ESJT2qQu0hI?=
 =?us-ascii?Q?u4cgl1vN1Jj2eJXLI5jUD9j/yFt9BrSpcpTXR7Ch/kM62lsiBuZLv5PBeE1D?=
 =?us-ascii?Q?v//2MPWB7DF/LM3WPcMn3Z/xtJQGcj4l74gxv0QDX6yRRiUoHuPgzlZ0nBEl?=
 =?us-ascii?Q?evrZQe0R1xv2owSpLobLnLo0k+TYss0iL5q9ZEyUv3jnuO01RtHKppm5xWiG?=
 =?us-ascii?Q?CsSnXaOehi+WVHoUi2FuUo0W4WykZjCwU8dkOqd2BOYBXzphhfbScG6OX/jX?=
 =?us-ascii?Q?uFa1v2BNitbIomIcZm//ueaoHeQGAlK1S3rM99RtJsQH6yMNxOiQItBKGrUU?=
 =?us-ascii?Q?6EPU4J4clsTWCduTJ5HyYTqECHvo7cG21iApfdqBHDI0nNTek1OyWJPY1yop?=
 =?us-ascii?Q?AvEYdzZJJcU90Sug9yVAk2d/TveCOlkaW0WbPN4x5UvMpFBir3qjiAkMPen0?=
 =?us-ascii?Q?HQCK4jwa5IYiM9pYV/sPm2MPE8YE1XUHlIFFPTHSWg9UrtOIHCqAKoD0sqv4?=
 =?us-ascii?Q?XiQOu4eRlo3E9wZY3eqffsn0bvk9CjMl/l9WQumcqoJuqu3a3i+2kJ2HCM+n?=
 =?us-ascii?Q?sBN+Ppi94YZ8MOY3Bjws6BKojW9QK9GuDMixOhZeIJpbvya+aXCaZN1iyicD?=
 =?us-ascii?Q?jNw8ASbYI8gMWR2fjwAqLbLHAscnuLWRq+ma+/bkz32CRv9qtwCVYJs6Ewp+?=
 =?us-ascii?Q?6ZUZoA/UkDoyh9N2Gkwwuz203QocFmRoikWzrLiiGgDx5R1gZcjVA6dKeYue?=
 =?us-ascii?Q?GSvu1vBUZsAKj3kav5vWXDAe76nReC88Zx0rvIH2l5W19ANxNstfqYXyjIAt?=
 =?us-ascii?Q?vXw20chDlOsDLYN9XNUTt+iGxPzdeya1zwvRZx+naQZ3bbiW8d+QlHQnpsS9?=
 =?us-ascii?Q?WPJgMnoQg+oOEtMk9MHLam+mHTFkhSuEoMVHdEAnQQZIyL0XGZCEILd+PBnt?=
 =?us-ascii?Q?txX2wAWgFCpA4RKGbxuozr+DIAlCEiJD04/o/+HJxIQ57CL12yKp06v34Tfh?=
 =?us-ascii?Q?j57+ysoZJzd8EKF7LAanlkB0lEDRXWHaSYWjWKcE/SSWiJ5F+pvNXEzsw47o?=
 =?us-ascii?Q?tMTNbgTyRZ+YJcFJIcG+v14lL/afwr6CueXpvw46UKLL+5DGjaOnIQy6cjaR?=
 =?us-ascii?Q?uHcY9p75kYO3YD9AFTqpsko5qRmX2DH7tU1nSeyM9flJb1EJq0uDz2lyw8pG?=
 =?us-ascii?Q?buDIlRn8IKcg2zNa0Sa7zIm5PY51SKEMnHm0QU1Uz5nXHGEYFIiQfjCYp2ao?=
 =?us-ascii?Q?fOOU7iyjBG1cMjTqdtEYSXzahxPdtQgE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:31:00.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f42a17-c6d4-41ef-5b22-08dd1751e1da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

The limit updating code in amd_pstate_epp_update_limit() should not
only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
so other callers can benefit as well.

With this move it's not necessary to have clamp_t calls anymore because
the verify callback is called when setting limits.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Drop lowest_perf variable
---
 drivers/cpufreq/amd-pstate.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3a3df67c096d5..dc3c45b6f5103 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
-	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
-	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
 	max_freq = READ_ONCE(cpudata->max_limit_freq);
@@ -607,7 +603,7 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
+	u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
@@ -615,12 +611,8 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
 	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
 
-	lowest_perf = READ_ONCE(cpudata->lowest_perf);
-	if (min_limit_perf < lowest_perf)
-		min_limit_perf = lowest_perf;
-
-	if (max_limit_perf < min_limit_perf)
-		max_limit_perf = min_limit_perf;
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
 
 	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
 	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
@@ -1562,28 +1554,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 max_perf, min_perf;
 	u64 value;
 	s16 epp;
 
-	max_perf = READ_ONCE(cpudata->highest_perf);
-	min_perf = READ_ONCE(cpudata->lowest_perf);
 	amd_pstate_update_min_max_limit(policy);
 
-	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
-	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		min_perf = min(cpudata->nominal_perf, max_perf);
-
 	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
 		   AMD_CPPC_DES_PERF_MASK);
-	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
 	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
-	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
+	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
 
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
-- 
2.43.0



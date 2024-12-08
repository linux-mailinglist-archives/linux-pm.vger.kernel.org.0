Return-Path: <linux-pm+bounces-18757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD5C9E83FC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6809F281A39
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1432155345;
	Sun,  8 Dec 2024 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CPxotDaa"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D485E1527B1;
	Sun,  8 Dec 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639470; cv=fail; b=sWIbdDZUAmqB0eoUAQqQqchZmPNEWlDM1a6OqQNqMnnKKyp9oVR0894XZdKg7ggICBC5kKT7eAASLu3avehAQK4ZuIJ/hsxwdkxWrXcEl6Gb+ks16y4epigPI8zVTjxbcPLdqnuwli8z/OwZlWtzaiTbO3YwiwTSAcHc7H+2PoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639470; c=relaxed/simple;
	bh=G7WZmQjJGwWyTzoGvIVBBc1zJ8j5hbkCD5y1ZkKPQN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsJuaSDmyoCCux8D0aG/iwyXnLEPCtJB+laUnlNW+7xmIG9v5am6rln2yDjlfi0X0xe5xruCOqyd1FEOKJ3e8hYjrvDkGV0G0epHLUgSarN/ZCDi2bBejpCp6GwICL/dAA7ILkJBq2xNGp/0e4mWKdPjXNi+y0o3nkZmdn12r0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CPxotDaa; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8+GZuHSz2apgmVRfMIKYSyxLV+Hy+x1Twu0bJgviJLbVUkv7groE/JOrKB2q40u1Oi1WG5U4H0VI3KoZtIg2RnsBaiHJXL4+qAd7QTuAf1GwqTzKNRuGJNwPvMQYcnaqrzUFxJTUYkHtKivAj4C3npd6af0dZPNUNZISY1BcxRp0bzJ/xCLyfP6PJlEPBUWSTsUnmRVoWEb7aNWHPZRigjjLiy3pfHRQTmKE+Lm/zlgZDMNOlZoWANPPZwLomHknO9m+rWt8U4A74fKvusO07EeFYDISl1BZKqDXVoXdScU9XmR+b/gJt7liCyEEYZuOwPu/dI2e8DgMS+wRtkZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPpGPbIaUvcdCsXFPkO0a59YD4NddTekCjTv+uiRGqc=;
 b=aS4szqmOb/fH0BZp259GMhACq8HXIuhkbzEHexN/SKdcYbWNO57AzGCwyaFVg45uqgdA+Gs2+H+amWK7a4WL3rC25Qkja75IqQ7RM0ByZQi76Bk8bNrZ8u0KzF+WvfeMyUmzJFZGOBRJiL3dhJhzsL9/4NKhcN37AVvkQ4AVawTmrHNT0Is1g37O1hd2q0ivnh3fvsgxzkaR1Wl9/0B6OKSwP164l6XQNf2i2sfH84DuCTu5ZcKMrJNI/WwjwF9hLZn8VMVf7h2DAc2/2K+cJFjfp/MQsinlaPCMriRhWx5P+UhyPD/uQh6Q33oP06ruw2yyUMFjQ1BTks2IMsRMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPpGPbIaUvcdCsXFPkO0a59YD4NddTekCjTv+uiRGqc=;
 b=CPxotDaaGqWae/VTnxfElTq1AGU/3yf5s9SOwx92IuIaucpDFMD3IihD6F8pNE8iNLsg8FWjeumW0SyyiowutqhmKrM3aAWKkX72luhCHMPZtTMmnJKNyHPZQ04ef1uc9XvBkYLyhiZ/7ZuuGfLCZC4aMNoc5EsBhnRghPZnJWY=
Received: from DS7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::10) by
 PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Sun, 8 Dec 2024 06:31:04 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::ec) by DS7P220CA0006.outlook.office365.com
 (2603:10b6:8:1ca::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Sun,
 8 Dec 2024 06:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:31:03 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:31:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, "Artem S . Tashkinov"
	<aros@gmx.com>, Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 15/16] cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen
Date: Sun, 8 Dec 2024 00:30:30 -0600
Message-ID: <20241208063031.3113-16-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: f3736dfb-6d42-4a7a-55a3-08dd1751e3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DbXlOPtULInm7eR0/jd8zQ6DEqiWsu7xtZ9S/GxZ97IXoG/urGhvj+oghfjw?=
 =?us-ascii?Q?ElQR/kV8VaPA2NMwNafu4tYTj2nk68kdpolR8xgW5cpgRBqCarA4z2XUAl4f?=
 =?us-ascii?Q?7iw6s4wHM8Li5QOHvz7fv/lOb1/fRok3THrpi/zu3ywyuzLZeCPPUpHi640m?=
 =?us-ascii?Q?YcY34no9HFa/VWOGZIVHYyj51ca43Hl4dAMhk/XCVhE7HRjenjB4CDmS59f9?=
 =?us-ascii?Q?zGk3G7AqOPP+H4zl+X6Pzk7AJJQEHlyqflVxVYZ2DeS+qaki3klVOJ+xV4G1?=
 =?us-ascii?Q?NJPPv+EkUn7OsVRtkPZBRkqSjSYxTI1aqZieQE0mCs1PkDy22EX6bI49yvlR?=
 =?us-ascii?Q?0d6ZZ9ewInAZMRpuNnbUIgCUtBHVKIBFrKo/DqR7cyyr1K4qvf1T0Dsck6B/?=
 =?us-ascii?Q?ME2sD8Tne2OuGKwnm2TWKluNwYe89peb65jfoe8oXkYPq8rqeAcMEGWPp7X4?=
 =?us-ascii?Q?isP7yAJ54rfFjSXmr0TbfG+new81sh/Wq362l7+egGDZFtrRHIjx9vRITUL9?=
 =?us-ascii?Q?u1MYoLgE6DF+zaLlFsmyRXldi4wkg6ljilzPW2o6hiU5WqqCqAz9U6wyd6/a?=
 =?us-ascii?Q?gQ+MKTPYPuG5GoUxiN2CBhdtuji2lGTwV7zX8H5lVnvZAy0poH323aIfKSwj?=
 =?us-ascii?Q?l1sbm8S1yNIeDv+OBX8lT1nA5h8bQ6KTLLpRw0Z2FOOKNq2xQhch38qvu5d6?=
 =?us-ascii?Q?17vzFhfqnD6ZfxrwjndNf+G1pH/UfNdVb5VzNQOwgTr2RSCBSytekPmN5WYX?=
 =?us-ascii?Q?h+vkg3YCwDc1BOt53Ep8bHSzVVc0knYe5YoQjiX3QynO5/QPa60Uy4o0mj7T?=
 =?us-ascii?Q?63Uil+d49jUhemLBrc5uUHF4njTENvPDxLcbb+R7Kax0avvxcLf5D1QNpDPG?=
 =?us-ascii?Q?8+UdkUjCg7L6d3iXAROM42fGUK27E/GJpGxyyXAIGd9t1qhPb5brsF8NaB3o?=
 =?us-ascii?Q?Nm8DTv5atXtfzyQCljoY2+pA3FUMrG0PcJFv9DymKeBZ5QZpgaarvWQqHeCc?=
 =?us-ascii?Q?SHXYxzRiSNXIDd9zkEWMDgiVYxJ7Zv3BfHQg+lyTz7K/1na5IJDQBGx1DdFq?=
 =?us-ascii?Q?Plpqbxo9lNKcmYJkVQk2kXDIwrra66TAnGlgKORC+YpSxic+HAAdm99OXXwR?=
 =?us-ascii?Q?1HoCJ1vk09Lp5nEj0BRaJ8Qywi28KVSJ6Jtl3btlhwWt0oRPhSWY5vXzNRsl?=
 =?us-ascii?Q?Io4Ylmj94NAqYOs2vh0bqbIBN1gUbiaYAIOaa3ykqaK2Yd3+eH5ADkk4VRKM?=
 =?us-ascii?Q?4qQge8ev6ibywlcgYjSHdJRvFn7sTG/ON/gF7kczaBg/mP0cWQjfKXMZh0Nz?=
 =?us-ascii?Q?KzkCHDtXQMbGcBsafStNzw7ZlmURt0wQ927R1PYQ9fOC/o85SgLhj4kx25Oz?=
 =?us-ascii?Q?NdSJEbG+lv2zCNtgkL5jDo1Fc7zaclCBQpCYNkcPhUnDWSN8wDCQ9vAyWn2g?=
 =?us-ascii?Q?cRaX05mHuXtHOv5HmnRO57NfHQ2q7des?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:31:03.9670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3736dfb-6d42-4a7a-55a3-08dd1751e3fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

For Ryzen systems the EPP policy set by the BIOS is generally configured
to performance as this is the default register value for the CPPC request
MSR.

If a user doesn't use additional software to configure EPP then the system
will default biased towards performance and consume extra battery. Instead
configure the default to "balanced_performance" for this case.

Suggested-by: Artem S. Tashkinov <aros@gmx.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219526
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5869bcd287e87..a4ededb8d89df 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1501,8 +1501,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata);
-
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 
@@ -1513,10 +1511,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	 * the default cpufreq governor is neither powersave nor performance.
 	 */
 	if (amd_pstate_acpi_pm_profile_server() ||
-	    amd_pstate_acpi_pm_profile_undefined())
+	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-	else
+		cpudata->epp_default = amd_pstate_get_epp(cpudata);
+	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+	}
 
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
@@ -1529,6 +1530,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
+	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
+	if (ret)
+		return ret;
 
 	current_pstate_driver->adjust_perf = NULL;
 
-- 
2.43.0



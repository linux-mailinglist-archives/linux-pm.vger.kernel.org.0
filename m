Return-Path: <linux-pm+bounces-7553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1DF8BDC38
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4981C22FF1
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7BA13C3E6;
	Tue,  7 May 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tsi6R/31"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919953D0BD;
	Tue,  7 May 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066160; cv=fail; b=u7fm7REWDV4rbTbtQGe2xAiH/ScFCo56M1Gq/fvdT73e/6v5gQ/4Dq+YlbjFe2vs8gIBkViKbZylLecUPHEc8ePmxW84GkKrmEAuLs43h34Vq5AMKqdayfwSQfII2npBTh2k7DSw4Fv8wa1v4RGHRNnkfADU3rq5b0+RjHgJLSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066160; c=relaxed/simple;
	bh=jH8CQ4Wn+B6UB4F7Fb8VdeXWuEeYZPXP67r2BOqwDsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIoo5dTPIziNKVq8B5wE5qQ9D29Rq2tUc5y2aD1iNnL25FtsRiCN8No9h1woXO2DTGZw/CQuoME7ZuD/9auaR0Tz2wF2Ca3i8311GttWeFx37IjSgqeQmXLC8DyMwXVQvr8AlPlPGY3w+v6XzWIhGuSiqfksu16HD9oaAW2Zzfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tsi6R/31; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXbn/b0D/xJI5EGHnvUKDpBxRQXZomJfmBpH2Mnw1frl6UVQtnjjCzU/zsq8EkKTjSTkqTYNjLRrkt4b2bXLnUngxyYaQhdex2mu7Qep0MjOPRBKKzPWehI5VUOcOIz1DfUB7yfJqmQli5r8UUw7H7goVMFb5HtphWUq6u/qAL7Tf7u+RllGu7snTncZLqvejxds45Rl/NgYa+NtzqDX6mozoebfh8+ydF8l/qD3oA70OKYdi0I6aCWLf8L7259+1pdQtQQUbBQ/7Yi5RDehyIzu14CWc7ZUbUtEVOcF5aVVBEu4cVPkM2CUwqtHjIo2M2F5YfdEPKWnyUL6kBhwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiRRcVZ0J94KrN9cUuHFGSKBISXZdjGzhcD5w7OZFi8=;
 b=eWWmoSJg4p+7DFkbc/nSRO6gmZvyY7uNT9wUQVzkgmi2GGPedrpuWmYE3LA9b1HhKeg8nxjbv4HToXdVLiINh3SyYaitIxB2/h+AMkprnsHS1pD4RfCoGjMXLamqdH3RXY6xP6HzCeIv2cIXWUhmtmBBz2eGn2WFEIDDcCmLxni2JAFZ3teEpQ+3E7iWY9n5SCjNeB6/NqBkINGgki2eLTuqJIqT2VprABpAFQyvpczuQo5U4/aewrGXirjzAuPRSwNFD/fWVEI2rXv1Ar7aXLMzCyOO8iHfzOP6xeesyOvZpMCZT2Tq9fuwXCdLFi0s/SH07qpAmMLBJ/YWCot7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiRRcVZ0J94KrN9cUuHFGSKBISXZdjGzhcD5w7OZFi8=;
 b=tsi6R/31HFp1pX6q452/Eryh6lpI568HUO+PgTRYKdsb3s0Hh4JMv3jUKljHOjnS1W0sSCxwvp9OLrABBoXHEkzwgbiIX9Wsm462XmwdmMIONr7nEJ0rfso1VmTg6ZJh+LgU4aJH4oaEt/PxdvJ89xRF5nQBDnKjshWdvnKGYAQ=
Received: from DS7PR05CA0078.namprd05.prod.outlook.com (2603:10b6:8:57::24) by
 PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 07:15:53 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::b3) by DS7PR05CA0078.outlook.office365.com
 (2603:10b6:8:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Tue, 7 May 2024 07:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:15:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:15:49 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] cpufreq: amd-pstate: optimiza the initial frequency values verification
Date: Tue, 7 May 2024 15:15:17 +0800
Message-ID: <0049ad44052b051cf57d1059bf71b7ce227a5f21.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: b9af58c0-607e-42a4-a09c-08dc6e65880b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?97S6plXnCR5DUXT8F3zJnbufV3Zu+CUmPX2FrMOWnwuGhN5UCSLjLsmKamP3?=
 =?us-ascii?Q?TLHlF0yGI9OwSOXAZ2a0hj3nRj1lHFbJtvWSIxYThzICNu9v4jyHduwz3zO/?=
 =?us-ascii?Q?E4KimnY7hZKBvruw8KBxhDisW9STkV9vNp1NXjGIDfbt5sgeuwASNFCrTB5d?=
 =?us-ascii?Q?oHw5Y7ZXhj4OaiBMj8RRCjUzB59afmLb6PRtJuEtWSvfJ2xdyaoSm71SfYlX?=
 =?us-ascii?Q?U4VL+zIzMQs+OtvGNlEL40iss3SgWkDmD9EmxI0MMj89hlVeO36nCBAddpDa?=
 =?us-ascii?Q?v17pslS04y9uPyhHIh851rivixkni2MCd3/u+exF0BATAvBdn8Kk0f2YNiGi?=
 =?us-ascii?Q?LtnOeJbS4K+utpnS1wqFTyxyxWn7taDsvrEqV54sjkbdJqdJIRZpNnh1wmuh?=
 =?us-ascii?Q?w/02IeWpSzf6FDVTPCfdZ94LPZCtQnCnFpsQNaSdcfR1SJzkE7sHDL2ubzCo?=
 =?us-ascii?Q?uDJZNGXCtBxbrBUXhXrq3vzYvpYKIVggK17bG3oHF8+JXRTPMOhy/+6LrAti?=
 =?us-ascii?Q?Q+KWONEL/0wYHoZLv6bdMBlBmOp+38Y2Z1EiXbqZAGQbobIbCHxUqu5vX6r2?=
 =?us-ascii?Q?V4+XLIKa/CjFafW42cPm/E4zl0oAKWTy//O3EhRoNdolX5vYG/bt4XV5b+y/?=
 =?us-ascii?Q?xYS0tRMUMIbvPjGDL43fGpXkffg3gc/gp+VnQcpQpHfXbQfOLuzgLvnVqg5n?=
 =?us-ascii?Q?3DQ77qNFeMVnADY6PkbqTLSpecmwlLX+0XZ3xcVeGepdWgaHuPN0acoza8hx?=
 =?us-ascii?Q?G3/GJkNt0/oEiLPJAdbbS9SnYpKYl3j3wiH7KWFZWg9EOsk3MJdYr85/pzd4?=
 =?us-ascii?Q?bdAXxE5sbHgwWpCZxPk0nxnCijEeQ5e2jMkp5jCdSB2NEMmd5q6YIaRHQsfU?=
 =?us-ascii?Q?PWrpDCPU+94vA5Ngnvq+5JpE+P1RhtuBSoCX8Gud9Rc+V3L7ZFZhyVJEBElX?=
 =?us-ascii?Q?yOcn/KZnwDOPn7OVncgIujpgiQJp9bRVvvl4voUYxrPx47LBx/XFko6D/1OC?=
 =?us-ascii?Q?bHBYLRzDNOCGUvCEmyvvxjRceQst8xN+AIApKjKR00IXcUhuQ+hH3hwVV3IO?=
 =?us-ascii?Q?h1qN04NO4U5mHJhw7JEtZ74UYx59hPIz/foS1xCZxdwBNZkLUPOxiVArAD1L?=
 =?us-ascii?Q?0ZcFyc/URM9hIcpSvU2ROqtjM0AUEc+UcFeyPob7iKQ4wuHAV0R5O4prsH8r?=
 =?us-ascii?Q?F5LV6qqnNE2vnByByIWVF361gU3UZb9HVNO8bHbJM0J6S0Luf9MbhUVjdBZl?=
 =?us-ascii?Q?QRfnRMm1kYCXcCKisRsEfmdwjDBtFhDyKdAiZRovk0DTHo+jJB/OnuYaZ1gq?=
 =?us-ascii?Q?xqJkf1FU9ApI8KM/Ktd+Dn0GDHmkvJKED4ehkaKPTkQpW39V8ZsauW46CEPH?=
 =?us-ascii?Q?8Tib2C2eV3UA2zzHd3xlLhBov2po?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:15:53.2202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9af58c0-607e-42a4-a09c-08dc6e65880b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

To enhance the debugging capability of the driver loading failure for
broken CPPC ACPI tables, we can optimize the expression by moving the
verification of `min_freq`, `nominal_freq`, and other dependency values
to the `amd_pstate_init_freq()` function where they are initialized.
If any of these values are incorrect, the `amd-pstate` driver will not be registered.

By ensuring that these values are correct before they are used, it will facilitate
the debugging process when encountering driver loading failures due to faulty CPPC
ACPI tables from BIOS

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2db095867d03..be7f2d3c86b6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -873,6 +873,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
+	/**
+	 * Below values need to be initialized correctly, otherwise driver will be failed to load
+	 * max_freq is calculated accoreding to (nominal_freq * highest_perf)/nominal_perf
+	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
+	 * Check _CPC in ACPI table ojbects if any values are incorrect
+	 */
+	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
+		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq);
+		return -EINVAL;
+	}
+
+	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
+		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
+			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -911,15 +929,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
-	if (min_freq <= 0 || max_freq <= 0 ||
-	    nominal_freq <= 0 || min_freq > max_freq) {
-		dev_err(dev,
-			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
-			min_freq, max_freq, nominal_freq);
-		ret = -EINVAL;
-		goto free_cpudata1;
-	}
-
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
@@ -1372,14 +1381,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	if (min_freq <= 0 || max_freq <= 0 ||
-	    nominal_freq <= 0 || min_freq > max_freq) {
-		dev_err(dev,
-			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
-			min_freq, max_freq, nominal_freq);
-		ret = -EINVAL;
-		goto free_cpudata1;
-	}
 
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
-- 
2.34.1



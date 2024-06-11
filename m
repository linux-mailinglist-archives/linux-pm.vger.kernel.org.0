Return-Path: <linux-pm+bounces-8917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557590371B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A493428A687
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23317623B;
	Tue, 11 Jun 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nxX+sY1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28162176222;
	Tue, 11 Jun 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095971; cv=fail; b=awdDPWEJLIwmJMJmy0IIQwXuCwAIaG8qh72dlr4DlF/dTRGUENmHue8Tf/um3ABSq67CkreHCIhWyG50MGKvtYEiSe3yISw+iUgvlx5KHXbJKodOKL/Uftst+5Y1O2ojzbx+zMSmPRW19cpxdNU3kVFauk4X5PzUo7otbHITD2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095971; c=relaxed/simple;
	bh=FlWoHYyH68BTr8AFBfqUJBJTgme1+FbeJBCetictUzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c54rKoHDYd+++mJvC051LlJI9grVKbeUEHzs4fAclVU8eIGb7X0XH+hj1r9QvKSXv4rLN9C1uUYGtID48DDQQsHikZefLCppgf+QsF6UJ2/0JhSUgtsGe+P6eYVmVnAtAlkoHqKoHwuMO8Mw5RO8/pd6/NKp0SigYo6fZHakvwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nxX+sY1e; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYO9YY0qM8IKSJ9oYoS8b+eEG7H/HCuipRhWI316NFc5+gcKeMOuLxvT1OX8GahxGwzhNs8FnojbGlQrpOyrX99OlhRelrcvm5UgO7lnrauywTOJwoAOhogNtR3isHbxUwPF1F2wl/Bsk7ZYpnmv9lKNL80pQx4ohbO5SNd2O8WJYTgEkBolCi+rQfe1FwhPGo+Hn6B7cORCnmiS5EBjnbzRa9SxjFPXz3iXkbfdsuLWQYZALZwasgmmfR6ZZVqHP+6OHkpsMeCtMihHB3F5yTB8ykfYFiTEj9S1qr9y84zVxYLRBIB92kyC9DgxvdrGEqYARzXOhUtY5togKZGMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPxB8jcSgJitubJnSKC2xIccMKbCgoBiCk1HJhRnCks=;
 b=gprnB7MvSs8tAiGLp5MllmOScGFWQWMS0QYb9i8cRF3z8CJE1ALTiphQqHNw8qR3a5h0vapQ8OJpUNp5tEeVN960ZFuTw2jC0VhWA4Ze/z1auDJqNMsmsHvkVP03c8XqRwTYsOYB9vwCzTTeBDeHEUZTeLoRK67pF/VRPt3Ky48+eY1etZmCKBLRzs1QC/yhQpRq1+lAL4kjBwOuEUtQ9fSJwZdaZf9RDa2SzOkXcTWN0pF8t+nuRrDXAdlsR3vknNDSoJvLHcmmgFeKpzQLb2jqcYGTlP12i2xuu7sfmZLULagZ5fkMQ6L90ttdKdzLrHG/LWUw+NnlZtNwc10eCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPxB8jcSgJitubJnSKC2xIccMKbCgoBiCk1HJhRnCks=;
 b=nxX+sY1eVOQxg2Shi3aAnA+6imt0T2fAhroJKSiVnInp0qGwTxHlHI9w6pTr0jRkXPYSzn0QBnEKhYRTN5Vjs27KfyRf0qKByAPEX5ObOKmpOuyu2HHIsh9K5fkOVjYjyuh1RFab8/lDG511YGsPZfL+gifxfCQP/dy/FlyWDtA=
Received: from SA1P222CA0153.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::17)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:52:47 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::d1) by SA1P222CA0153.outlook.office365.com
 (2603:10b6:806:3c3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 08:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:52:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:52:42 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/10] cpufreq: amd-pstate: optimize the initial frequency values verification
Date: Tue, 11 Jun 2024 16:52:17 +0800
Message-ID: <c3e867be691b6fdb3d34e378199b297256aeebff.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 2583f796-d651-4343-6acc-08dc89f3ddc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22RC141i5+BguVxb9P6rsVzLRJtpQ+oyjBqK5fUpZfXZOkwsZqliDK4TLNiT?=
 =?us-ascii?Q?y/YdWBliR21FASeBNBX2XY+hh9C/4PmynMo5FtuD1HqBnKRgL4ZAqsc+FAmd?=
 =?us-ascii?Q?OhE2n3UpKXd4Mm6jf76tEyEJ3MSAg5QjeAx9vwfNxmcgOo5zATRURhcht4Mt?=
 =?us-ascii?Q?dHTeyfCc6yx6E3n4YTA9mrE0DAEUjxmK0rjtQql0HwCsDt/XfeV0Sy+dEo07?=
 =?us-ascii?Q?+pmmfIoFWMTXxmjYTkJc46tJSrIweYvtHkxyP+n/Hly1m70o60noLlL28Wwb?=
 =?us-ascii?Q?YRqA9LJXm20cAXjZW5Hw41wOAPaQxkYwSxUE/vRPgQoFC0mEt+4WBLipVAmR?=
 =?us-ascii?Q?Fnh8CTUtXjrztytUnfb7Bp3iGv41IcFZNkwARCGbUPwysyzQROfRfmJYrc8H?=
 =?us-ascii?Q?7YXziLJy7RTGEhjV13oJ+R9Mf0K+M61VseE+cTVRLIg+LKd5gTV2IO1zI5vz?=
 =?us-ascii?Q?fRgPgv/mHLbIAOqnE83gxiGvJp4mL9/eo0ICokF3Vk82qSuGJ+Mwv+LT/prD?=
 =?us-ascii?Q?5JKYVr3Nvch5UCMEIzuaYCROrOQVw+rdsmTiHdZMntBit6YabGcn/tZ9LvNB?=
 =?us-ascii?Q?TncLcHoLCjuUDJXl81uDULmBnQPGmxxh2P2/BsFpR1ad3JqsLuf1yXpEii+K?=
 =?us-ascii?Q?c2qIfKz1cMSjuxCQyEoufeFXDdKghR1dimzvZ5eWYsKvrFiIO4uf8jxDkkJh?=
 =?us-ascii?Q?Vdb5LcB1aH3wKfzDl4p8mKbdG0VWIDx+6MaqudDLRur8gdjnck6K7ryNq/cx?=
 =?us-ascii?Q?xaaDPPLCJS93MJMVGp+bCb6o6BYgKjfp2h1CCS62j7ZryotDwxmrmsutHvKT?=
 =?us-ascii?Q?Z6YV9ziYE6z+yHQsr43nyl4dsRwLJgp9K69Va9YoILTGZpDYnnlMw9oxgGWz?=
 =?us-ascii?Q?mYXfDxO+UKqNm6i3PTUWzB30kFifcnSe7iIWlPhfl+KHf9868gxLV6nmR+QF?=
 =?us-ascii?Q?bnHzONYRdXR3GFP51rqaed04rUj7GTgGwyd/MsVMb9wdLLeW0vDfPWJj1G6m?=
 =?us-ascii?Q?1K/TIrZiJtAfX12cwSKnyjqYvTKJTTT+8Eopfi80AJsFq38FFrc8ccIizQbR?=
 =?us-ascii?Q?lPBhbaNIoHi9+ULAuLWnzkYgZxVdi8n3jzm9YRROAwkP88YI3v03VYkNcvfc?=
 =?us-ascii?Q?pmqS+VEt2/w1tHvQPur8ERlyzvot32DCXUqhmEmm5B7CG84dsxcTvTbGRZs1?=
 =?us-ascii?Q?tQvSY+OoCzfb0BmNuIaeihX81NWe7HOYen20ugO9TWnLHM2q2BiWYvJFZdMg?=
 =?us-ascii?Q?ZRPHqhImjx4xLSer6sQGFGe8G/7poXkPblwPlt3zHB1wlHW4rgAqGdqDkkXV?=
 =?us-ascii?Q?yAlUu2pKNEn5CQIuLnp8uKW0+2XxPn7WNu3aBCKHFWLuecIgQLM8aAJj1C1p?=
 =?us-ascii?Q?bph9llyuLdikoosPITQQnHJsMagK4+p/GAOw1ZGDNlGFsEXnDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:52:46.9525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2583f796-d651-4343-6acc-08dc89f3ddc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985

To enhance the debugging capability of the driver loading failure for
broken CPPC ACPI tables, it can optimize the expression by moving the
verification of `min_freq`, `nominal_freq`, and other dependency values
to the `amd_pstate_init_freq()` function where they are initialized.
If any of these values are incorrect, the `amd-pstate` driver will not be registered.

By ensuring that these values are correct before they are used, it will facilitate
the debugging process when encountering driver loading failures due to faulty CPPC
ACPI tables from BIOS

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ad62dbe8bfb..37fce0569d06 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -921,6 +921,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
+	/**
+	 * Below values need to be initialized correctly, otherwise driver will fail to load
+	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
+	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
+	 * Check _CPC in ACPI table objects if any values are incorrect
+	 */
+	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
+		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq * 1000);
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
 
@@ -959,15 +977,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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
 
@@ -1420,14 +1429,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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



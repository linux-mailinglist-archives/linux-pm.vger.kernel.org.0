Return-Path: <linux-pm+bounces-18747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D009E83E8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E423D281898
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F9C13D896;
	Sun,  8 Dec 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmrZxJHQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2683CD2;
	Sun,  8 Dec 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639461; cv=fail; b=JBNPhVg+JtD9ZaULLCF0Rj7QaRKvlvN61rhL0W9Vi9JCx2EskJvhdXJ0g7XtoZw03uiOVI0bEKW703b7yWEkbpVrkDZyBFSm1pGkTgU9uLNo9XsbSuVs5ZYnUsitFvHGFoYv35JjnE0Hw5+naTl/szpnvnho+Iod6iTbytQy50c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639461; c=relaxed/simple;
	bh=8IcjiCBRBloocPYDiXM+yy0x6VYm2tN+z9Yn19WjWAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpLHDr+wSjAwbdkrgtdvxiToAMSzxXZG1iRYYpFVEhkf6UlYo0NhnuvIRcywnYuKy0VTBQagIayvyNIzh/M82Ff4urzVEv5uEoEla8V2AOGqKs8jsAEEPFsPn/PdYBwKa7EjWQ4MWaC6AVQ28j/yTyiLG40+1Sa39qOrju5/bDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MmrZxJHQ; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDJ25I0uDTvz3dIRjo7Tmm2JFv8owr5AoiXDLL46VxOWYHretWvWX0tM/d4l6CI/W2biHTGcDlnpTieUydR8UUhHRVmTP5N5ROB0vuxJAsp8cyf0ZaRGUVty/RrOy5tZJ0xH9IHagGaAfkVpXnMqxRSMVTuoZTRR8iLK99ipGrF0qmRHqMGIxJp1lDwGF+nYshPVVTuEU5XTpl00Lol+3Biq9JP3pltlb2IrwwngJo339grgbVnsxVYtWw9M4frnYRcVHQ8V+fH4imLf9vGX9+OufAxtNz3WT8zq+ANCgQiIxK/KREW30nSlSyUMzj0WX87F3KR5MifLonQKf7s33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9okcBsyNIrSTLz/dzY0VUNNUwo9aBdy5mYXE/fMqWg=;
 b=pdN8QbcYy4pa790RX5Xuoeod0s5WEobdifosxzLNA4pm1bmVYhdDr1bjgij1/jmUuqKORST3CVafJfuhaxUXl3ml+S/PMOs8hw2znlcI+yK59JnccSfIUoJ0EBEylKik2cWdR9k7ONUqK04XS90REB33pHiF98NVRZxYMMby5WzLe9036kLWgrmC6+4t2T9oGkdVHUg/kRRco1OD/VGdGgqf7xmQtkhcP2zouEkIhaPoHSHbQVeWRzpKLQ271b2HRyx2FxxAGzGPWvrRicR4rMWncuIgpTNUTZKvUghbLCw+P42XeWJvDBRrskg1iQ2hQd9/Bp+yeOEH/kijsZPaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9okcBsyNIrSTLz/dzY0VUNNUwo9aBdy5mYXE/fMqWg=;
 b=MmrZxJHQnEmPLEF+i8zAT586oz2smYInxjO1vZqQQGngKNxDCRapwUziExxSAosMMbVRdFHFfsz7fIyfoscO9Yep9nM3/bPJByKXDlePJjXiMFU0Oivv5B+HvADqlspH1nyfmoyaiW96lP/5ohThIFF6s34MoHizZqK6pWBjHfU=
Received: from DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::17) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Sun, 8 Dec
 2024 06:30:55 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::25) by DS7P220CA0003.outlook.office365.com
 (2603:10b6:8:1ca::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 04/16] cpufreq/amd-pstate: convert mutex use to guard()
Date: Sun, 8 Dec 2024 00:30:19 -0600
Message-ID: <20241208063031.3113-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 03609699-0f0d-4ac1-aa3b-08dd1751de7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uSaBRfH544oeuHTUeiQr0iNFeF+BW75fvNzx6RMcnTcXiOXWVpjsx9+XRMB0?=
 =?us-ascii?Q?h4jDfORKUL8RjAN7GDQs2c7Te0K6nM2HSZsowFThuZZof6FOApXPx4LDCsfx?=
 =?us-ascii?Q?G1q7vpbWBYmSeGV468ePwPKYXwv70JefImWrPykcP1DLJ2DImZlfMgKbiFVd?=
 =?us-ascii?Q?2ZGADw0E0QHmMKfzMd/lsSvVZIpyD1ntA+0Mv/oFJgBt+5qnOWnL0rOfBf4g?=
 =?us-ascii?Q?1TUQ3IGMSSMzZ85EfwOpLb95yHOAcpE6EqLsinGkDU4POCLrL84fZsRqO+cz?=
 =?us-ascii?Q?utwrEwXHVQlSnr9yKvL3cTxUsJuCYS9qc+u+iSBhK9iC0Ue3LeIMiq+IpzIk?=
 =?us-ascii?Q?W1EgJL5P++gBOg+AN77HaopNIoe4/YUezFH7bgd2ttdXm6oGqkvIB6ZZlgE8?=
 =?us-ascii?Q?o/ie9jVZE14J4QPoCEfYpK51AutjWbAY/K20q/3Jzj0dsd5ow2wY0LwNUMyK?=
 =?us-ascii?Q?q0YhyMd/ZAdi3E/yjeWQI8C4CtA3GFxWsn9yptVr2WBlDht5kAO+qTrDTTD1?=
 =?us-ascii?Q?LPNxQ7sRmMMjSlcWMKHPR4agSX90+50EsGSf24nXHXR9gknj1ICWTDaA5a19?=
 =?us-ascii?Q?MowselvIfcrGcWqe2PsWToBGnoYfzYj3agD7zB8F4zfugv0U1gUepXguz7G8?=
 =?us-ascii?Q?bVPOhEN2F2wQfIF+OvB0zBOQ32BNd5yYWayTbsaryev16tk/fzk2qqykVniQ?=
 =?us-ascii?Q?FbpJQU+hOh2KaT94/go/i/uSJ42t1/n6Lvu2i3Sm3KsvyKV0xsUwigk1ANFa?=
 =?us-ascii?Q?lpKODdbYV+hAsQEz6CaHMwBIBVYOndtlvxZNifFYRY/FBFVgDtS5eo3Z1rfr?=
 =?us-ascii?Q?VcIlDVKXtxn2K/fQN4ADIxDcMcjkntF/Dh8EVjvBEQaQiJSjXadAGehDB6hG?=
 =?us-ascii?Q?ovE2JtqJifDNA/tEoUo0EJ/KM29DRxao8Cyx/jrkkV5Xft2RwHZTB3MVqxSE?=
 =?us-ascii?Q?AiRLBIu/YviANWI8f7jbfng+mjRS6WAa07wgXqjNf3UuuNTdd4aN7BlnrjpO?=
 =?us-ascii?Q?+wpbMwz4yRWgtxiHpMZg+0miRlq9sQLKJ6EsLOjLTd5KA1vhJ9ThpPAFqHvZ?=
 =?us-ascii?Q?uVsBuVZnqkRwc0JOcXvXcvgCX+s9ZTrFbdhCRWsVdAvhp7SmOObKDtJsatgJ?=
 =?us-ascii?Q?HnGGZ1CIpYug9K0XOgyvPFOMXm5EMSV+kmLOSJ3EX378VBgVRg27pp8xtyv/?=
 =?us-ascii?Q?2wwDI5+Ycr7u4eP+BTdos9xXMY4YlQulYbf59LKsLZNXN94qdP18zIu34HF+?=
 =?us-ascii?Q?PsG6QOoI4aSYv4GUXzAeN+31jEkhLth4rxZRpeigKiAYUP3WaW5Pr5JjHaWo?=
 =?us-ascii?Q?pllKJMe1ZN+gTXmA3olt8Du7KwXXSIgleV+wORZuqndlZ2JrT2e5viNfyYzF?=
 =?us-ascii?Q?CL+8tU51bn6bS58o87T1ektGkuz5Q4GBhghjqi9b2tK++fFVKAIhjYVDkRzQ?=
 =?us-ascii?Q?rkmPMqL9hShcqGZXL2m6Z5o39Bn5Tx84?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:54.7483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03609699-0f0d-4ac1-aa3b-08dd1751de7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289

Using scoped guard declaration will unlock mutexes automatically.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a59c897dd59c7..6a96d3a24c77e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -758,12 +758,12 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EOPNOTSUPP;
 	}
-	mutex_lock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
+
 	ret = amd_pstate_cpu_boost_update(policy, state);
 	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
 	policy->boost_enabled = !ret ? state : false;
 	refresh_frequency_limits(policy);
-	mutex_unlock(&amd_pstate_driver_lock);
 
 	return ret;
 }
@@ -854,7 +854,8 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	if (!amd_pstate_prefcore)
 		return;
 
-	mutex_lock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
+
 	ret = amd_get_highest_perf(cpu, &cur_high);
 	if (ret)
 		goto free_cpufreq_put;
@@ -874,7 +875,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	if (!highest_perf_changed)
 		cpufreq_update_policy(cpu);
 
-	mutex_unlock(&amd_pstate_driver_lock);
 }
 
 /*
@@ -1203,11 +1203,11 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	mutex_lock(&amd_pstate_limits_lock);
+	guard(mutex)(&amd_pstate_limits_lock);
+
 	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
-	mutex_unlock(&amd_pstate_limits_lock);
 
-	return ret ?: count;
+	return ret ? ret : count;
 }
 
 static ssize_t show_energy_performance_preference(
@@ -1371,13 +1371,10 @@ EXPORT_SYMBOL_GPL(amd_pstate_update_status);
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	ssize_t ret;
 
-	mutex_lock(&amd_pstate_driver_lock);
-	ret = amd_pstate_show_status(buf);
-	mutex_unlock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
 
-	return ret;
+	return amd_pstate_show_status(buf);
 }
 
 static ssize_t status_store(struct device *a, struct device_attribute *b,
@@ -1386,9 +1383,8 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	mutex_lock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
 	ret = amd_pstate_update_status(buf, p ? p - buf : count);
-	mutex_unlock(&amd_pstate_driver_lock);
 
 	return ret < 0 ? ret : count;
 }
@@ -1689,7 +1685,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 
 	min_perf = READ_ONCE(cpudata->lowest_perf);
 
-	mutex_lock(&amd_pstate_limits_lock);
+	guard(mutex)(&amd_pstate_limits_lock);
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
@@ -1700,8 +1696,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
 	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
 
-	mutex_unlock(&amd_pstate_limits_lock);
-
 	return 0;
 }
 
@@ -1730,13 +1724,11 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->suspended) {
-		mutex_lock(&amd_pstate_limits_lock);
+		guard(mutex)(&amd_pstate_limits_lock);
 
 		/* enable amd pstate from suspend state*/
 		amd_pstate_epp_reenable(cpudata);
 
-		mutex_unlock(&amd_pstate_limits_lock);
-
 		cpudata->suspended = false;
 	}
 
-- 
2.43.0



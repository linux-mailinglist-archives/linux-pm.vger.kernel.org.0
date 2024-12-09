Return-Path: <linux-pm+bounces-18861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9389E9E75
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42491882CE3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B419D083;
	Mon,  9 Dec 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DeqSfLnl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64EE19B5A3;
	Mon,  9 Dec 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770406; cv=fail; b=fpDNkH4NCzBiYExz4OrJQruAu7lYdFOtUv71XCfleppxGgVFhMSwHUEpdNQ93JKoQU7r1Mw/1ls/DuntJ1U9YJgQbpg9oJKY1AgChLdcme1iP2IxNhF+YaRNmj+GS+mzXC3NLyP0TU1hXLpwhelO00DcNULRs1GdQ+/PtOkuJpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770406; c=relaxed/simple;
	bh=8IcjiCBRBloocPYDiXM+yy0x6VYm2tN+z9Yn19WjWAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fetwy9j/Az0XMhB6vS/aj3dRH93K/+awbEnp0jfTFNxadSpvnDiuczB88B6Fmo1l8AgRT9nVhuhHMjuwA86w4Q/UFuPtgcNLy6lC2Ksad48nwiV/2+zpa1/vpuHYQxQ77PzwCbJZ5/UXs3GkLTt+C4LvekdagVgRGlyiqSbSj/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DeqSfLnl; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1n+p+lkNbXFMgcYfINW4m8uIZdwmWM4gbhUWkW1MvNTT9Cabllk2prr9CO53h4tGJxRxYz5kFwXNqr4BuAYX6yb+GwQbaRnC+lGyoiMDo7zMabANk7orrAJq0Hqd344mWPjN7YjVXX9+15sQR0WdtHRQ6hNmtu/1JSL8nj+/hFcsCTFE+52DaBmXklr6fQaMYwSpeGn8kp4jLYw1BASAi/sLf4NwY8cDpewnUtbvCs+gojfXodSVjZrVfvW10TQ3ce+dAwywAaO99k0rN1j2OojAY8I64oT16S/YHb9oI41upj6u+IuLDD9aGWSvAn9ot5gJ5S//G9FZ5NewDGxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9okcBsyNIrSTLz/dzY0VUNNUwo9aBdy5mYXE/fMqWg=;
 b=wICqK+cw9j1AQWofdkypuSZq58p3prutaAtE+B8Yc5zq09PhAP1SnfKo8fPolVKBUg1OxUkWx4u3Xxm3rDBXXLIZWffDag2v6ffJwr6UTxDrtpGM+mdw4P4JCaye6svFgNpuPhownT6oVYDHYe3Yhm0FZXf9KukSb8QxHYfqJWdYB4o1qRRwH5XA+dDZnuS55jkiN05b0aRZa83kooGKllNnfpUegllYZCriXHWV5jCXkPqGiqCyzwTrfrN1VYpg9kp8dTnsu+uFUXATlfFN4Kgy/4S42oLuDyQTAax5xFWqMieIfGg5pob8yAkbmqCyy6Qa/RXagwuJdNzIBdhQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9okcBsyNIrSTLz/dzY0VUNNUwo9aBdy5mYXE/fMqWg=;
 b=DeqSfLnlii7HsFBPk+3OSrx1wwQ88Ld4D4xiBFlxwdRlBqDxFeLuCnw/YyY71acsah2k6hPGUFyJvbh3lSLYSp+jeIgKgbQ0UnrZToJ11k7TJQ6hI5bVtENz7GzaJbgQg4ZNLHfRsCMYwviX9kZ2oytyKcInP0glmQ6cOe0REqw=
Received: from CH5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610:1f0::25)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.26; Mon, 9 Dec
 2024 18:53:14 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::c6) by CH5PR05CA0023.outlook.office365.com
 (2603:10b6:610:1f0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Mon, 9
 Dec 2024 18:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:11 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 04/15] cpufreq/amd-pstate: convert mutex use to guard()
Date: Mon, 9 Dec 2024 12:52:37 -0600
Message-ID: <20241209185248.16301-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: b6112dc9-e337-4bb6-2323-08dd1882bc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/KN2QkJMIZUAnWO/8xxzw97xR/VWiAU1Vak3rY3ddiV4EIMQx7lsCvy2iTH?=
 =?us-ascii?Q?gYQiHXW5mJQ77hiWzcFbeGGcYC63Z9LEIDFEPTJ1iXoleMRAyR3cLZO9NMbG?=
 =?us-ascii?Q?lecJTG7bBwV8zxq2KQTYo7HQxBEXAHZUwKO4QkwA4HwGdlz3EgGsBXlLl9A+?=
 =?us-ascii?Q?m2NNzpjmaWJpQV4RcR7M77sFBG5VBUYpFx+EXwZkpKY30UTcFOmIQvAAqtHq?=
 =?us-ascii?Q?Lc1e+vpmiETggJcmxLNWnHtk7de5zulU93P0U942fN5Tcd27ZjWfdOI7i6M7?=
 =?us-ascii?Q?Wrx/kPEB8ouou14b5z9jbhwkMtMtbVmC1iC95jwsPaL9qIdau5lfuffPzlkr?=
 =?us-ascii?Q?9t7MvAVgnxuzZ16WatyrkPenI7vgGo8UCp23+ITdD3C9chVBQ3Ee6PZ19Kzu?=
 =?us-ascii?Q?xOxT4ECrISu/iulwfIZxJPMNioL6fxI+O4WoWkz/vqJ3TwU0cExnt6E5GPob?=
 =?us-ascii?Q?ti+eR26AxrRGhyaAkaMzlFn08RZHDrmPVbxdeDFKuCz20CuMFQlFERUR0MFy?=
 =?us-ascii?Q?lue/ylwEeKlk8C6OMfM3+tlhJAapWZt1uvW9uY7zc/E/bCcex/JipSUnTnnf?=
 =?us-ascii?Q?cWmUY0+33ac3mM8cEcU5XoFmAIBhUmbJqOZBGNEbqN4PsBvoOKoQE4U2kGQv?=
 =?us-ascii?Q?9vtqKCu8EL1pGvu12acWJmiO29Gdcl+TKbIqZP6VkOVv2BTBrZpZVoFYQ63N?=
 =?us-ascii?Q?NiTv9iS38XZ4PkWehvXxUINovcAZiSjJx/JeUQWSLFwsf7gHiSvfYePriT8q?=
 =?us-ascii?Q?ppsXbQ+EJimHmKCVSgYaj6v0tDp+9qeAB4sgxjK4GdpEX/amCMe3PwW0A67O?=
 =?us-ascii?Q?RJkRWw3U78LHiB0UyKvrXXwWV6sv08s7w7UQQA6Xr910/dlnZU2vgQ1yNiKd?=
 =?us-ascii?Q?kPCTAPafkGXFI4dlWpkMMfhI6/iWZNTpRlI+bzoFUenhvnv7kYwIRDSCcZ+T?=
 =?us-ascii?Q?YhrreXQZHCXN3CqGpunQYkSHJ+kU+FCS/1H0sMzdyWvICweokAP+TIS6DWSX?=
 =?us-ascii?Q?KIcoXlfCV5cVTEt6PCueB2YaZoYi4UFDVYFNLzR/lozaKXyCQtGGvJ2YrPcN?=
 =?us-ascii?Q?EkxidOyaYKzbCCWELw2rrS3XU4MZ0UjxysxrzFsxzozhhvUTai7RXE9238Sz?=
 =?us-ascii?Q?OPPmlFKnoy7g43xL3g+9z6sjEC5c40Happy4USa6kdNMQfWPMVWs9MGqT/EH?=
 =?us-ascii?Q?dklXShy+1sMaZxCchB9jBhcahzhjYLQGxgA6w43u0Rgrr0PNde1AvydlLBiM?=
 =?us-ascii?Q?2Ze4ePMtaT0b3nucCyAJEqsdn4bUEOwTXfTJPNXNJ/E2n+6t3dznLGVnDi3C?=
 =?us-ascii?Q?K9wy+C5nIuc1LtOgNddrhysGsD+BKO2/tVkheDZNe2n49fKqfiA55w+wlTPH?=
 =?us-ascii?Q?7R7kTk+8QkENbWXvOiP7s4B36VGK9DqregSwaCYfqjez2HcLIeil7ywT/oH/?=
 =?us-ascii?Q?VJV/9vJA5HVU1vfVwXDH5u2zt1gvRAW5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:13.8544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6112dc9-e337-4bb6-2323-08dd1882bc3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861

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



Return-Path: <linux-pm+bounces-18649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663339E608C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABAD1884A39
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D661D47A2;
	Thu,  5 Dec 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ORX5y1l6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AA1CDA19;
	Thu,  5 Dec 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437752; cv=fail; b=lmQeH5PtDCkrGXQ85xye7jLaOvAQS97QBioJ4zyTjlXDdwZ8D7syFsvydPnQomiW+ObWveSSW3aytv/WytFYGrGmXt5tq6PlnB6KfUBajqe8GV6sv/WPmwW/dYOuoPSXdBJV59oaXyBYI5oDUKkvick1dJ/h7lVjjaeLrt8tqvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437752; c=relaxed/simple;
	bh=WEaWDZvqk0aQJ2EJJfYQ4sSSLKRk8oigHHJONe6OSOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pkgm5PIh/wl6ZOxSEX7zQmLEsPdaS7KcSPIesuKbe2nTA633ZAgXEkowUGI8BB5UeeJ2BJqN79N/FVVVn2SWkHbqp+Eq5rCw5gQcWnKsw2i9C8kp6w2ugIAMtaMMf+FFvJfrZhkbQMfM41NDZPbLNgcbo4ttyPH+2rycwvOQo5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ORX5y1l6; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGpFDlL77hNMmhPApaobyS4fbe3VUnQ0MX/CQeHS1LLpy9C3smsL1VausBglsQ+oO7QS0pqSCu3dcleVZVTdpRTRcorDr681ehb5eorOgqLTPxdXa0P0TzhxJm6MuB282pWYcCja6jSW9EQx4p88bIBbgIyo//uybyxu22y2mfKpOb9Webb6MTgz+gEcx851eqNSbFp3fuKApG4K1J8IwGlCA+ZPvi3dPvoiZiF9YX5eDci3VAfJuCTUVyjdJH6jVVa9oof/FafJnEmndfMdxsDx1wq+6TNEFBisLAVWitEOHoM3eqQ2CjG+17MitJ3uW77h210m67fyQfLabsxy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kXqM2duLwSJatyowtz5stWvLN1kyDQ1uVPelxmCdzU=;
 b=EcSbf15K+6o2xQ4xMrJgs+rwpbr/Bm1vywWWLPxROVRHu9JAPGbXg0UPPofkEwYB4jUN9jZ9dcgBuyO3skHNlNT4vEI/N9tU0PsL8FQtFORlOivnKtWLx0Ei686ntKilwP+/KT9AHZJ0S+wDxshblhuw0t+IfNGbK6Uw8BuOISaFUkXwd9JdA6r56ddim1NeNuvsVrVd9l7tvY1wFjsGEbN4VUtVW6+ijwVqqzB84O8FBDm4flpMg9nZ3mj7dm2Kf59dTx/k/s13FvOwtg+BUrdIkjvbyL4ZzPOQOENvdcWQkrY8hLSRgUSxlb1eZ8rrg3LlSSIFXxaqxyR06GbrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kXqM2duLwSJatyowtz5stWvLN1kyDQ1uVPelxmCdzU=;
 b=ORX5y1l6NqGk9eU/LtNAckXygHRn4caTcTJhjgHVwhq5lgfw3x4eqsOzD8xXCo23R/NdSdn0WOPQ41imSDNQwJ9s69Om1LhJzq5x4Rg62TF4JkSL4loKOoHmPHoJ8nPdeLlqtQhd8JcyD5TNG61FMEJdNalx41K7SOJJw+xdmY4=
Received: from CH0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:610:e7::21)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 22:29:05 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::82) by CH0PR03CA0226.outlook.office365.com
 (2603:10b6:610:e7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Thu,
 5 Dec 2024 22:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:04 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 02/15] cpufreq/amd-pstate: convert mutex use to guard()
Date: Thu, 5 Dec 2024 16:28:34 -0600
Message-ID: <20241205222847.7889-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205222847.7889-1-mario.limonciello@amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: ec594263-3195-4be2-31db-08dd157c3a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?od8+MEOanL0/7hHi0HU8lmIlqbiteAgQRTAoZyc5lLoRBDR8vkMZ2A2zYqaT?=
 =?us-ascii?Q?tmF3UIRGOFyickk4IgnNEH8qWFfX4XL3tnPUvGkNaBcujn35xzL5p4iPHOPf?=
 =?us-ascii?Q?W5I91uLByQOVY+mJ9ao//uFHACiUqZD0B05aEoW1q2OduM5un0DLlWWl1VhA?=
 =?us-ascii?Q?LnxEkWyqllU4zmV3N/2UxMQ+fufJNVe3h2eY7ZX/5BQpPROEDEUsvh1jbWGV?=
 =?us-ascii?Q?WISleZwJqXEpML+1QDP90bXFFMjdfaQa6WmLxnqRBv03cYjhG0o/rb04JfqJ?=
 =?us-ascii?Q?KkY7h1x04dRY79oXydMdOvbpSIwrY6qdYcLAuTc2ndzKw61vWn7OkJtsIzt7?=
 =?us-ascii?Q?j9wnt7NVpWcQWmRw6slcBOb2fWdzsNgU1SGKNbBcAtbV3PO8oCuKGkP2Q4VN?=
 =?us-ascii?Q?MpPnpuDZQtZsT3MsU4uH/13ieut5MD/Krwcftib+5tpVcsG9ohGXgrLrA+D+?=
 =?us-ascii?Q?YyD3Ok4KoUpUJ6MZzxYQ62WV8Bd4gT74xZJTSkGD05j2+GJq/2HiWDWOJeTM?=
 =?us-ascii?Q?GQAjrU2Gy5vTNGPJIRf7G0X0XnM6LaLApBC6vfZNUQthrQ2f4Ae5TilEZMMC?=
 =?us-ascii?Q?7yoo/eWmp8u7aKjOQzbeXXf+BekvbwXE/oFa64tEbdPKypFhMbDh4l5sZ/ow?=
 =?us-ascii?Q?YCbRlmvr79zCIlGf5Kb/YoAhMpnBIsNlSYQYVJDOUkmV6hrlciLm6Gz9FSvd?=
 =?us-ascii?Q?yex0njRwTi+vHZ2x49MB8ZvUv15i+rw8qrN68FLUJGSLQx2Mpiqa+Egrwsr7?=
 =?us-ascii?Q?X/FOw2v9m3HeJszu7LEYbLs2F6CCjRX/MjBcI3QOWFksP/gL9zg8A5xWLG7K?=
 =?us-ascii?Q?hNVb3oLMY+gULkqcrWgQ/W3ndwzSBSan6RkEvG/TrTCeI5EwsMue/PWWmh9Z?=
 =?us-ascii?Q?taw4blIXn5L8zGW7FeDK3C9HQze5VpTri0E2x0iBTfOZ2+vIz6W6p4O5L3r3?=
 =?us-ascii?Q?Po8KdqSxzKIRtan91PVfBlcS6T5tdjB20TqEDuAHC53l5QnoCP7ugU4EqTqV?=
 =?us-ascii?Q?7mNmjBDF4qqirtHLy1RU/CRYrIUzOPe6zgwQYPycv7xcwMCfzDNNi3GVHWwi?=
 =?us-ascii?Q?rMqxIOtq41RweuyIuKZNy1pf5s2e+Xm9FXj2lr/YiWVMfSh114yaRTCUHMii?=
 =?us-ascii?Q?Hhx9IREoEBTjUP2JyhSPik2FkHexq/nGnbRHcBBvbj5fQ0XurDo/QNY+aldd?=
 =?us-ascii?Q?JK8tTBvJkCdPIWTeqekSO80QNeoN+uYyFqO2OKseO5jTX2dZUJ/FlL2Rkm4P?=
 =?us-ascii?Q?XICW31GoSbO7r5Zdkdi3ACtzrexkq1H6puT+55u0yTJ1RNqyyI1wXCMa/+bx?=
 =?us-ascii?Q?Z7EoT14+EVlYknGSVzTLyJst4J0D264oIDdVzdLMyrn7aurhVizTl4t7XZ6a?=
 =?us-ascii?Q?ECzDpbEzIqmCUj8KInsqdOFk5Q00yeFi6jEhPd4o/sREv3YchpkuXrlamAPL?=
 =?us-ascii?Q?BAhxdwzjB7EAp+XbNyJArnt5opseU11X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:04.9995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec594263-3195-4be2-31db-08dd157c3a1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638

Using scoped guard declaration will unlock mutexes automatically.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4d1da49d345ec..7eb013585df51 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -752,12 +752,12 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
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
@@ -848,7 +848,8 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	if (!amd_pstate_prefcore)
 		return;
 
-	mutex_lock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
+
 	ret = amd_get_highest_perf(cpu, &cur_high);
 	if (ret)
 		goto free_cpufreq_put;
@@ -868,7 +869,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	if (!highest_perf_changed)
 		cpufreq_update_policy(cpu);
 
-	mutex_unlock(&amd_pstate_driver_lock);
 }
 
 /*
@@ -1201,11 +1201,11 @@ static ssize_t store_energy_performance_preference(
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
@@ -1369,13 +1369,10 @@ EXPORT_SYMBOL_GPL(amd_pstate_update_status);
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
@@ -1384,9 +1381,8 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	mutex_lock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
 	ret = amd_pstate_update_status(buf, p ? p - buf : count);
-	mutex_unlock(&amd_pstate_driver_lock);
 
 	return ret < 0 ? ret : count;
 }
@@ -1687,7 +1683,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 
 	min_perf = READ_ONCE(cpudata->lowest_perf);
 
-	mutex_lock(&amd_pstate_limits_lock);
+	guard(mutex)(&amd_pstate_limits_lock);
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
@@ -1698,8 +1694,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
 	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
 
-	mutex_unlock(&amd_pstate_limits_lock);
-
 	return 0;
 }
 
@@ -1728,13 +1722,11 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
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



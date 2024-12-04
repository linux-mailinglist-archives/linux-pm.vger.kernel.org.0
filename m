Return-Path: <linux-pm+bounces-18551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0A59E3E2C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 16:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB62B3F7B8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8555920B217;
	Wed,  4 Dec 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uvmlHwR8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD920B1F3;
	Wed,  4 Dec 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323821; cv=fail; b=Rv++Nyv14RaTqtRmJoeFb6RJMsQdBQFkF3ZMSCzGeLdobq2ycK32WVWWdYAvQcLlGb3+BhLWM0jddeFV589OVPF2TKA7n3iH0UiGMBa112BEfWR9bQ7v11Vh5PfUYM71A7JgpUoK3kJwFOTThqr9x/TKR+7cLHoKJbWblsmCS5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323821; c=relaxed/simple;
	bh=ZaEP6yqTRwZ3Up3SAFODPjJ3U/FlBENra9Ifb2XRsyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prJnb7F4shvPgPD2y0/vEnYySIacbuwB0Rluhpub3n83OaT253IzCzhXvymLY7RdfWRgXkY6C6T4H1u8n3iTpDw/PPpXvdZtAyVEsHzsIZbssSYem/m5nt+jO5D9aS1FoXF1jyVpL4jhHfuqfiUHUzf+qOSvgsnVU7QessbgLs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uvmlHwR8; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bilrq3/ukhNPVER3ckMgZ4ThQ7nE8XGxnATMVwrfYQ2PikeFJQ1QBaUrdtayCay9FesJ5fqwdf38K/DlHQwqJYuMMOLdfolcbBbvf1DGESngmalrDkaQVcdgZE8l1QvAM8gamFkxORA/DKXHgr1eTYstsaVPA+JJLSsxcLXKRYATpXETe/1VL7vtnI6IXITCJqS4G4ziG/yRGkb9RGCSKcOyapxsarDD4nU8y4zK1VVo9bqk2nxM6vscn7wpwCGbeBgxCBxb5NY3bPZWAufKE7cAWmvWGyqh3fVOrvWzk7bpyykZODW6VWlTUb6oeeLMzfvh+x2egqgTCtXIkTaOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAN9rYY9devfMYPumnR1SYaZit3Iw+DAqoWH6mNBBN4=;
 b=GMsCYvbIcMXCtFm5TUX9w6yHyeHkiT1pQ1OLcPFFg/6sUzpQdWQbz/wzcIShzJuRXFlpozwu8v2TX0jI3hRDrIIm47rGD806QAiyzEHb72fufyDF4CvbYUzP6Tj/f15/HyjhEHKIOLTIo2ZRZMr5iXkbTV0CMAQXWGlJaUtm9rFUkXHgepGexJ9vTA+85YzIF14zeaqqnT/kiiXZT9TclYVMGH4zb0KX7m6x6otzG0DseUT7IJvyFGlgNRaa43nn6oGdoahoGb8DGVmqChUhKUG7ewOPUoF+A7NMVDC6lerkGzcD5p/52vrserEwLBGMcruAWi08z/HQEt+cd1+JKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAN9rYY9devfMYPumnR1SYaZit3Iw+DAqoWH6mNBBN4=;
 b=uvmlHwR8y4wdOjqaL66l/23jVaqbelPMUdnfk1f7Tr4Gv1o6pUOC/4JZggTfXf5CisXyiuQf4ju2NPkOG/L50eC0tC1DkYhuF7L3W8OEgf8eewbVPuszQ5bKlUovHz9t5UefqyE2D4uoBw3/69BWo5yL2g8nrv330MEjh2ibrEw=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 14:50:14 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::ce) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 14:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 14:50:13 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 08:50:08 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 3/5] cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and amd_pstate_epp_offline()
Date: Wed, 4 Dec 2024 14:48:40 +0000
Message-ID: <20241204144842.164178-4-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: e87508f1-15ee-4106-18e6-08dd1472f560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ITsuS29qAo+XXzuYzrX3Z14D36HAFI9qC9e2Cz7xZkVATYp4ME/xlUt+l1W?=
 =?us-ascii?Q?OhAmeKzO6zVbhv7rZHH2oM5lMSbpH6VxMrklOJlREObbOWfvHZuCavc6TJZ8?=
 =?us-ascii?Q?cU4M+017AiDyOvPYvGgxSp7hMF7RDmnnGEZIN9RvmwKS+EUd6sdBnr9S3c9/?=
 =?us-ascii?Q?kT8a5+MDzxnidodSHhbgr3E7WYB84H/b4GrFvD49n+GfL4db9yO7NOCofH5A?=
 =?us-ascii?Q?FZU0m/dcwPr8FDp2Ccz3zOLuq6XW8ZVvI26dTqOc/s1nL/cG1S8pQ0Lnjqzw?=
 =?us-ascii?Q?ev/neiVvO2uNvBjiBI7+Cz+xeOf5j4uze75rh0czzXOP3BUERxWx6WwsL4lI?=
 =?us-ascii?Q?Y/pXeH1o5NW8nLV6C/LR1zLmTGCl0rdI++5Z4UVIXVEcVuPddZoVhM3WiqgK?=
 =?us-ascii?Q?iQAnS+T27Zz/Y8Fi0hU9SVaG5AN7Pggq0Bag0CuBDlrAEYs89KSB5rRR9Xso?=
 =?us-ascii?Q?SAZElReMJGFY90QtsMJqlnHhiFl7y4pSg9xPiwka04e/HGvFtx+SvEISwP6B?=
 =?us-ascii?Q?vmOjrpT2vJX3KDnSY39LIqoPww7VAiQa7ukY/0thUw5CZYmgGiWKDqFnCHi1?=
 =?us-ascii?Q?9RaEsO4d+KRnrl71HxLhygBVSbdAJeIaxH3OHrjS6OVA5bIL9ttxkJ8Hemnq?=
 =?us-ascii?Q?Ck9Dq/iwq/oYGeSgZrulrB38VF6kyrTQZSXvMKq50JRFKrDyGqunpY9va2Rj?=
 =?us-ascii?Q?Opmus1twp+qTtUMth5RYbBZ18OFJF1xN33OJbbR2Paf2+rq8kSkz8in58EQk?=
 =?us-ascii?Q?iU6iRqaP2GKrMITpcgtntKQvzK8/KNZmiVEcLbcI0n23iotEgl85IpVJtxJC?=
 =?us-ascii?Q?woV8Xmp8tMi9012eRoVCHw1bI2zEzWAum2/WtgTeime1aUGr05/aKzOxtFnj?=
 =?us-ascii?Q?C+Tq2ZntRAtWOhAfv8eDrlJjc7x2e56OOBJzfoDj4MG2fZfRt4Yab9KKW6wF?=
 =?us-ascii?Q?gOi/vt+fjFKAskfuNCTSOnHvUlgL7iCcvNCeX/wwL9v4C5Q5qqmtuDz9/LQs?=
 =?us-ascii?Q?sbXal+Ov6IJPOTJaT5HdnQgN9eU5aDjcOyu7ql3ac6Ajwy3DdJkS3qx/a+Ao?=
 =?us-ascii?Q?v3UG78BNw7GBeO8Ty/XqSW9nAMhVxasyCDKejNoOFp/9Xd6g++JwJR/wF+/r?=
 =?us-ascii?Q?S/oSb9BvFMYlaJAJmEOGLIgoou1HQdVYIuySD47j54sTBE71Ynv4l/0JmNU9?=
 =?us-ascii?Q?jedANAvnsrEnfkeEYDa/WeyX8t+zKrrO/FC4IPx1LJEi85/Q4vMsgGaYW6V5?=
 =?us-ascii?Q?vTaKvf6E3aEG5e4f82GghpBhR3zlZmeMzGjZHoFl8JNhhfNsJoMf0b5oq/a7?=
 =?us-ascii?Q?Zv3cmszC5Vun6AQdHXBPObxUTALNcjdHjxPsYvfiRd6LoKKK2yUgM8uFykdJ?=
 =?us-ascii?Q?xauThs2vcMnHfh9ujqYwAYNWcizjumMBvqMNf1K8hArjilYVAAQEad/olYgK?=
 =?us-ascii?Q?B10RyZE5qN9NLZMiOhG5MJu2jsahJwps?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:50:13.0458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87508f1-15ee-4106-18e6-08dd1472f560
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521

Replace similar code chunks with amd_pstate_update_perf() and
amd_pstate_set_epp() function calls.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a1b2393cef22..a38be7727c9d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1630,25 +1630,17 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_ctrls perf_ctrls;
-	u64 value, max_perf;
+	u64 max_perf;
 	int ret;
 
 	ret = amd_pstate_cppc_enable(true);
 	if (ret)
 		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
 
-	value = READ_ONCE(cpudata->cppc_req_cached);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-	} else {
-		perf_ctrls.max_perf = max_perf;
-		cppc_set_perf(cpudata->cpu, &perf_ctrls);
-		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
-		cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
-	}
+	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
+	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
@@ -1668,7 +1660,6 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	struct cppc_perf_ctrls perf_ctrls;
 	int min_perf;
 	u64 value;
 
@@ -1676,23 +1667,10 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	mutex_lock(&amd_pstate_limits_lock);
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
-
-		/* Set max perf same as min perf */
-		value &= ~AMD_CPPC_MAX_PERF(~0L);
-		value |= AMD_CPPC_MAX_PERF(min_perf);
-		value &= ~AMD_CPPC_MIN_PERF(~0L);
-		value |= AMD_CPPC_MIN_PERF(min_perf);
-		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-	} else {
-		perf_ctrls.desired_perf = 0;
-		perf_ctrls.min_perf = min_perf;
-		perf_ctrls.max_perf = min_perf;
-		cppc_set_perf(cpudata->cpu, &perf_ctrls);
-		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
-		cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
-	}
+
+	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
+	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
+
 	mutex_unlock(&amd_pstate_limits_lock);
 }
 
-- 
2.34.1



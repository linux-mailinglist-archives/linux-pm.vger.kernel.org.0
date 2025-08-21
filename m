Return-Path: <linux-pm+bounces-32762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1153FB2ECBF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC247B50D0
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 04:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022627A108;
	Thu, 21 Aug 2025 04:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="10Yi7Qdg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1DA36CDE0;
	Thu, 21 Aug 2025 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750434; cv=fail; b=UEZNhog52TG39hZ1iThSUuBQ+kDukme4NGC8VtwAisgjA2eQPljf7gW8A00ekPDb5cVO+3gXkk+uoMzU6ibL0Y3CKqh1Ax2J7/xh6o3LdDW+/Kipz+Cww8Knz/MFqFoOI1uq7eIgqIXh0DhNlTKuzHmjYfWXvTQrHIw9QoZYM+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750434; c=relaxed/simple;
	bh=Rywdc4/vrERXqtEZ51GLY66IXWBFxGqbv7rcARJSNrc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdeZbSRvRmruWA2gXUfA4ASa9HG59DsFa/whqMb4wFh+fB6i/1FpfB/AbIsORCl+JMnLkO/wjY2XM1O4BsdIVDxpfKlPN46qXCywqSmL0U2/B1vFPqFR/eqd2TJ/vbAi0HdjEJWIZiR4AOenzFYbXru3gsVozqXxDdwxs7dZEVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=10Yi7Qdg; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvi1GTg8KzVUWkweEJiR1BBGY+jG4BIhDW7hczEnfR+pgI3k/9foOr92nBnv5S71Q2CuUV7BNdcAjiKTiBH//hBo2o5xCP6mkFwZRZQotjFzAwv1pS6nFwMrisw0aa+B6vv6fDeHNk4BxEPysdLlFQfmoDQV5apQZiYcLCkz6DLlXLRHfZu0hsnjpU4jc/Z8dKW103tIUSI63ce2/81/fdQZy7PP2kZIiMY8PcrubLCj0IGXsrih60o5Hbi0jAgv9dfFEpkQ4k7c++OSjvDzfzsshgOXVN3MMDTvW/+QiLKx+KD5Y4HBSm9lXc2feMIvzNaiZaLEOwBzwm5XU/S1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB8jhvTRBUlKkPNlEK0AyndHI0kc369bUO7treqCyJs=;
 b=Nk5+JZpilXcb196wrFJrGAVn0xKsh9SM2QWZ8PC0P5jfs41dgoAeJg3Q5MxdvF7NvAHu4Esbn1WtDOC56ZoViS2u7lhyjFmhtZ5mdZ6G6LR3nm8N00JjqHUbQasolKshieflIQmXpvd5IfKb7m8LrFijCDOHiNhj8LopE40lk+j+CpT5aNgNO7vN6EgJZIVuPxeAKb+g4g399n2DGmk5eum5Yz0fPxdZJHi0v19G6y/wdc/TH998snWdNE17nNQGDrY/agI5HyKSCXvcw/J+w8H77VzE2KqlHftF3DEIEZFPpXZtBcz19hQ83N6EJl3TazWuBSX5JuzFKgAGCbHOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB8jhvTRBUlKkPNlEK0AyndHI0kc369bUO7treqCyJs=;
 b=10Yi7QdgkdB0E3aDege/AiTrqA4BFsAzkTB6Fo2XgDP0gMLRnoDKpHWYCM6xbZbyJxobWGu7MHTV8Vo7+v8Q1iyzz2wAJDHVTFBxmsVofN8gf/o5h24w9LvZJU7ZDK+hbYW2EL+/wK7e8OIW/K5OFr9DhrA2ersqHRHJ8/voPI0=
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 04:27:08 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::84) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 04:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 04:27:07 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 23:27:02 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan
	<perry.yuan@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix setting of CPPC.min_perf in active mode for performance governor
Date: Thu, 21 Aug 2025 09:56:38 +0530
Message-ID: <20250821042638.356-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab210b4-0ddc-4a5e-c387-08dde06afd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MHBvbMPLXVPizLrj3Fif0peGZpoiierCFi75fKlAzb9xx+NGyC/Uyj0e3/v6?=
 =?us-ascii?Q?f7Jg57PrEDt9qVkPOF9dT0jESlxJE0+BgYlO4d4wJWdZw6n+1ghJA7BYrhfe?=
 =?us-ascii?Q?7+cREiZkotaVZBDl5j1/7jig25M/QglBt13n1SUL+4LLcvn/OeFVmo+TL/ss?=
 =?us-ascii?Q?HrkMeVmUBFZNR1Q4Zj2YsekQV96/Q1deJ5k1Gb5FJTR17sOvBLprSfFsdnoj?=
 =?us-ascii?Q?3984FjWRKpvPdtsKDTCWAUH/Dc9ASSx6fNS1c46r6Z80pNDZjeh80XZiwsyV?=
 =?us-ascii?Q?zYoITTrsnKf9gSBUJeYdHT2QSTq3kX3n3qw0MGXhMWvuA+3GCGhLEfQkDHHB?=
 =?us-ascii?Q?R8pjjbOeSzJcOf9etAJSrbDereE1LNiB3Zx8t+OLQrjYOV5ydW5XlqXogoQB?=
 =?us-ascii?Q?7guYyqXUfA32Dq0KvJDI2HsmWmG5hdie6rsPRqkXNA4lSomJUmf8kuBfK8hF?=
 =?us-ascii?Q?K1D0gZ9SGNvCc6mTvOewTncH0kzGOhQN6huEEHX4BQ+WHfcUTUsCSvQmmcBX?=
 =?us-ascii?Q?ZZFVYqP7i0OPs9j8ZM3zoccnX74cD7H1AsPbbqUU8S5Pyfd0gbOWHruACLox?=
 =?us-ascii?Q?9/uttHncJB3X08iTiC0m+EL9BbpBy9NQegmJyFqOF+3WrlvpMwpWVpg4n383?=
 =?us-ascii?Q?vapyuVU0yE81QxbYyfitnQeNztvMglxlQay9GADm61dF9dsXijPxT+yaE55S?=
 =?us-ascii?Q?LjzIHWQb7Srj9R8lvCfV6it/r2TN2SgyplCDtgrYGB44Kl3tjG2ltPQXWRfo?=
 =?us-ascii?Q?NcxYhw2L6A84xsisdfOkVgCdZm9bWBH6X+lsR0IeJvJt2onU8xSbLBk3/0bw?=
 =?us-ascii?Q?gBGYI6LLpzEaJu2S4pc/Lv4JP6N38lLBXNdC1eM3sxDjTyqVsY57H6en+UAH?=
 =?us-ascii?Q?o8B6cRsr/ExUvHrS4KyBea5u3vKLlUwKmG4Q4qd+WtLh9mCABK8gxUXMDR6T?=
 =?us-ascii?Q?hOl8TPQjX1HLeZ7rbnZfDfPYJQ1Zn7+fWIKZl2h3VwxqAVmY9ee5eDXdI+ts?=
 =?us-ascii?Q?R2ZmqzaSh78UzsjmFhKlNDr5IA5ljizSHCA7g/rSv1iaiuftKnOVEZYWFmg2?=
 =?us-ascii?Q?lr/axj0P3hxA3Pz/CA2+x6kRTHI3jUN7KDYqsLffAu3GiyuVkXkfkA2XUYg5?=
 =?us-ascii?Q?WTcHks9yWzxHXuGj6kp0TsabL3nTjCEMZEE7J8A/NxZhgXf1oGYLGWwaVkQ0?=
 =?us-ascii?Q?DgzDxQynFOqqgr4VikaaOhzpfAIxBHrRhz3e2QL9Ik0RW4AUXMp6dC0n9Mht?=
 =?us-ascii?Q?Gm8N8tzfJLUZTBaA226xdH4DdYxT5NKeIKNvem/AUUkTCf1lPztQWSNsL32C?=
 =?us-ascii?Q?LxGa+lY84qyJhcUQpT5uhOYqtB6GDcA4jTUQTtYXOKaz81iAq33br/QG1mCx?=
 =?us-ascii?Q?9t7mEmIeAku+yzRRUkgOWF2It8GRYp0824TxypEmufopQSwOqUvr8FEnA+f2?=
 =?us-ascii?Q?yNrIUtgOBmSmttgGXi7nPl41o0EGo2L4tY8etnez5Hi+ht+kp31uKB7bHef0?=
 =?us-ascii?Q?spaVKMA1teKSp3uXE0oENrp7RljIiLnQld67?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:27:07.1643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab210b4-0ddc-4a5e-c387-08dde06afd03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413

In the "active" mode of the amd-pstate driver with performance
governor, the CPPC.min_perf is expected to be the nominal_perf.

However after commit a9b9b4c2a4cd ("cpufreq/amd-pstate: Drop min and
max cached frequencies"), this is not the case when the governor is
switched from performance to powersave and back to performance, and
the CPPC.min_perf will be equal to the scaling_min_freq that was set
for the powersave governor.

This is because prior to commit a9b9b4c2a4cd ("cpufreq/amd-pstate:
Drop min and max cached frequencies"), amd_pstate_epp_update_limit()
would unconditionally call amd_pstate_update_min_max_limit() and the
latter function would enforce the CPPC.min_perf constraint when the
governor is performance.

However, after the aforementioned commit,
amd_pstate_update_min_max_limit() is called by
amd_pstate_epp_update_limit() only when either the
scaling_{min/max}_freq is different from the cached value of
cpudata->{min/max}_limit_freq, which wouldn't have changed on a
governor transition from powersave to performance, thus missing out on
enforcing the CPPC.min_perf constraint for the performance governor.

Fix this by invoking amd_pstate_epp_udpate_limit() not only when the
{min/max} limits have changed from the cached values, but also when
the policy itself has changed.

Fixes: a9b9b4c2a4cd ("cpufreq/amd-pstate: Drop min and max cached frequencies")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f3477ab37742..bbb8e18a6e2b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1547,13 +1547,15 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	pr_debug("CPU %d exiting\n", policy->cpu);
 }
 
-static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
+static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy, bool policy_change)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf;
 	u8 epp;
 
-	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+	if (policy_change ||
+	    policy->min != cpudata->min_limit_freq ||
+	    policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1577,7 +1579,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 	cpudata->policy = policy->policy;
 
-	ret = amd_pstate_epp_update_limit(policy);
+	ret = amd_pstate_epp_update_limit(policy, true);
 	if (ret)
 		return ret;
 
@@ -1651,7 +1653,7 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 		int ret;
 
 		/* enable amd pstate from suspend state*/
-		ret = amd_pstate_epp_update_limit(policy);
+		ret = amd_pstate_epp_update_limit(policy, false);
 		if (ret)
 			return ret;
 
-- 
2.34.1



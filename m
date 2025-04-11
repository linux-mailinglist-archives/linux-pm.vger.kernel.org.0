Return-Path: <linux-pm+bounces-25205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77966A85649
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 10:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6626D4C349C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCF2293B50;
	Fri, 11 Apr 2025 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hIu6DLzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C86293B49;
	Fri, 11 Apr 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359306; cv=fail; b=ajwDW1MCo4ZtwhGGIGS8pKgsyV1BzFy5Z3m15Kko/sgU/YFXUIVv5360W7wVeeVA/iHGdkLBGc+kLNhC3qSYDv74WD6AR6Ad9W3L2QnM4dZuz1EMSMj177HUBLqc3gLbo71iMSxNuryhfyDlQMaONAGgpQzvkNsIsq7amjeKIAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359306; c=relaxed/simple;
	bh=cWDHCI/iFjQj1gv6BzJP8SWUl3QglS2OjZOSrklIC4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a7YjrkU2TWyscHdpq/rn4hHBZaBfRwAdQQFVkmX4mEDMVby/Lf8aNlor2MnJQ0n3C2I1hXvn/kuAStNEwn5zJv6jU9GBkMmk1WltMbw7p/UUHQfixOC/kBMdylizD2hFH76x+PCHO9p6yuA9oBZBbgb7GAdkEo1g6+KalZNWlNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hIu6DLzL; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8VoL6JqcwgYWtPk23MWDsyxbfElX+OKu5l4nbo7PpespbHOUXawMmnDW4C3MjHWg2PQgOBXUkxgLIQKMelPKWgM+YTz9DQDIY2gqsQE8JFTCjIJA6rOFO5Vk7Kr5T/qiFjd4r4W3zibFCb1FmOZnXdmzvBzYUfGMbQIdxWefOe3wz7Jsjgm0lcs9ZnZO1K0OhqWN8GEnbH4k7EvF7YC13wHElqXNuF6201YR0aMiPgBL/Ky3lKEj1c5okaoiXzvVgLC5TCFAbpGaS2DdTvGVqfNLFzJD2Wc4KjkxjbPsI6mK24Af0RUS8DswqEJW1oqwDCoVTLtp+ORXUz9bOpDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGJjk857vg3I3BkUU4n+5qV5IfGvTd8lMkJaYdRJAPU=;
 b=l9dsQ/wsGQKjp7QQoSyWGmDu4x2EpdrAzZQcZHAE8Qmtd2jGd0uiIZa4cnualiyRAaVxWuQ2fkWvvsZACFn3ApMqNmf5ZT65fo1OzfAPrIhH0GNGnE/iiZrNdHSJoKyRZLmB+Yf/KMUVPrDfgqHsgO0f7UduDRDtCSxbq8EFOC9zT3tmSoOWaF/nlscOEIU+njOvm8IzuokVRy/Rm9z6uspD6+V6VpetArxmmG+haMv6CX0UWYVCWUa06DO8MS8EEj1wTA0wlAHnPJRQNCrwuxDZdqCd6Bg5rFk1tLC2t+SoEqDhsDPzAWUp9POfrNsB6uWCBwxcpEETee2ZBIDlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGJjk857vg3I3BkUU4n+5qV5IfGvTd8lMkJaYdRJAPU=;
 b=hIu6DLzLB40BWylwPL8Oxkx9Fx53hbmIiENwOEEdYgE6bIxNEa2g8VoexjOryn5PfWakpxd3VZ1l2DFpZwBbuxTvyEOBZcjW65ZlA6L4AIti8e9vwWrYvV9tFokyTfZfv9pPGfnhmTr/JEUGL2cAzLwy6iKm022COiOcgmCKYGA=
Received: from MW4PR04CA0209.namprd04.prod.outlook.com (2603:10b6:303:86::34)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:14:56 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::e8) by MW4PR04CA0209.outlook.office365.com
 (2603:10b6:303:86::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 08:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 08:14:56 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:14:52 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, Huang Rui
	<ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, Meng Li
	<li.meng@amd.com>
Subject: [PATCH v2] cpufreq/amd-pstate: Enable ITMT support after initializing core rankings
Date: Fri, 11 Apr 2025 08:14:39 +0000
Message-ID: <20250411081439.27652-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a74526-e280-45b7-c5ee-08dd78d0f1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XDKN/1+NTb0FTwt7ZefFOGTYthPWgmN/Rd/evptzzgt+sHO5v/VyG4zpi1BO?=
 =?us-ascii?Q?jPuAqmk/3AJJc2wPTsoNYsqLI4uWFrL1kVINQjy94H5tLQbdIrje2lZUvv2R?=
 =?us-ascii?Q?koqz/TAoH5y5fS8dQZz4wFd1S5NlL3slpTBjK3+HsvDCB0e5ThYXoga4foD0?=
 =?us-ascii?Q?k5wkE6hWsu20yC+KHMZG5zNYUV9CAbUHZQlN5LsTKmuaQP8jR6MAT/wZBZKy?=
 =?us-ascii?Q?hJdeJZJpzuYNFIGnkEIJaG+69o61+h+UgPNVXseFEchKjhEV4mvICplMLy7H?=
 =?us-ascii?Q?3NEOW6f89UpWxTmMAikEQKjwAWkrRPinZcHBDYfDAyQLmqvDc4sqYByDznct?=
 =?us-ascii?Q?ecr6eZeA7KfADYwpbXjfLq6fHjheOVzzaOb8dRDIx9Goe5cCC4qz2q2m7g0L?=
 =?us-ascii?Q?EqqnEH7rCs7K6kDF0vZiqcUYIYjZLRS3awM0VjxZGyyF2OueMW/Cdh6uQbvd?=
 =?us-ascii?Q?CikRr7aMF79BC8O5BGpKtdIY8yz42VR5f8IIlexrk4w7N0EbCAeVpEri632H?=
 =?us-ascii?Q?/cQzzizGjV9rSsWDNqBxXaPbstXeEVHQyc6vxXjEDHFmqI5hjFFC9QWvs0op?=
 =?us-ascii?Q?FcdRzv6bEiy3ySzE272lhDMjUAC6SB891ktEPeZ/J43OBHGRRQxjOQWM+KxO?=
 =?us-ascii?Q?vChIp56MIe8wdlZAuyvd2ozemq9t5wtDo92AgETqfDwJmtMEnXCZP3mta5Pm?=
 =?us-ascii?Q?2z8kJXkn1FuRl0uryn84J7FviPvuB1WNlnuDxoKBviIkvARNWizhEdzGzYuy?=
 =?us-ascii?Q?Jc1zDN8lo1JnXB8bmZu0laJmOufgZQjlrQ46XylIXHsmRCKnoAO5GwVrmUOH?=
 =?us-ascii?Q?L+CIZ5Pj+T3+C29hSdB5jv8DzCf3LWALh+qAOKHdKy6FeP5BA/EUlNf6iQ3R?=
 =?us-ascii?Q?N2NLWyufnafdWzVVRk1iRs01YEw6B+ItTVtbv/Ai0Z1FUDTC9vBEV+wslWq7?=
 =?us-ascii?Q?RtZ9lyYwi5ScvyWJpHIGMAw+BIPyW60SrvdUVDfSk3N0bMt5dO776ECcNY8d?=
 =?us-ascii?Q?EYTRv6pcljPeaPRxmoDSGk5oS+PSj41fW86V+N4fNUZAVzTNLrG6HEJpChdu?=
 =?us-ascii?Q?0m0uTJrYxJaVVIpFUiFpadHkextmSK4pCJzyHBvCxGAJDyEdIjUHW5wyszPF?=
 =?us-ascii?Q?PphWPiWAH+oRD4yGzaZnKUmhlwhatNJqOWDeb35YDO6UsrZgVi1ubI5GxqAI?=
 =?us-ascii?Q?T+z9oF4/4cELFKaEKoAfjeR9fvSeavw7x0N15Vb407Juz1TVKd7sUtET2t8x?=
 =?us-ascii?Q?RNNVeySo13N3xtph+MZ8yuMN1wXWfkBplD91vysJxDb4v7PNmeRHtC29qX8+?=
 =?us-ascii?Q?dUWFIfKdkqKTJgBaWfrU8Dxo3Iobepn+d0+oBt2mmFNGEhevTv1hLAzxdzST?=
 =?us-ascii?Q?7F30nfq6Sag2atu3bgQUjkcoh0cTlLaSY8nxJpVxhbPTxuJ9pcIpDBNwKqIS?=
 =?us-ascii?Q?CzvB/e0FFx5YzAhvnvbEgGXfLTQsNlrBiL5sS33kRlBgdL7XXC2iPMSgHW3F?=
 =?us-ascii?Q?OgSSuZ3wCl8IHOFtM34Y7nB5PgyFs9FxVJk4Zkev7A0ewloaWDwJTTzRSQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:14:56.1773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a74526-e280-45b7-c5ee-08dd78d0f1e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

When working on dynamic ITMT priority support, it was observed that
"asym_prefer_cpu" on AMD systems supporting Preferred Core ranking
was always set to the first CPU in the sched group when the system boots
up despite another CPU in the group having a higher ITMT ranking.

"asym_prefer_cpu" is cached when the sched domain hierarchy is
constructed. On AMD systems that support Preferred Core rankings, sched
domains are rebuilt when ITMT support is enabled for the first time from
amd_pstate*_cpu_init().

Since amd_pstate*_cpu_init() is called to initialize the cpudata for
each CPU, the ITMT support is enabled after the first CPU initializes
its asym priority but this is too early since other CPUs have not yet
initialized their asym priorities and the sched domain is rebuilt only
once when the support is toggled on for the first time.

Initialize the asym priorities first in amd_pstate*_cpu_init() and then
enable ITMT support later in amd_pstate_register_driver() to ensure all
CPUs have correctly initialized their asym priorities before sched
domain hierarchy is rebuilt.

Clear the ITMT support when the amd-pstate driver unregisters since core
rankings cannot be trusted unless the update_limits() callback is
operational.

Remove the delayed work mechanism now that ITMT support is only toggled
from the driver init path which is outside the cpuhp critical section.

Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:

o Retained the name amd_pstate_init_prefcore() (Mario)

o Moved sched_set_itmt_support() towards the end of
  amd_pstate_register_driver() to address mode switch scenarios.

o Disable ITMT support when driver unregisters to prevent incorrect ITMT
  behavior in absence of update_limits() callback.

v1: https://lore.kernel.org/lkml/20250409030004.23008-1-kprateek.nayak@amd.com/
---
 drivers/cpufreq/amd-pstate.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c54c031939c8..b961f3a3b580 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -794,16 +794,6 @@ static void amd_perf_ctl_reset(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
 }
 
-/*
- * Set amd-pstate preferred core enable can't be done directly from cpufreq callbacks
- * due to locking, so queue the work for later.
- */
-static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
-{
-	sched_set_itmt_support();
-}
-static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
-
 #define CPPC_MAX_PERF	U8_MAX
 
 static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
@@ -814,14 +804,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 
 	cpudata->hw_prefcore = true;
 
-	/*
-	 * The priorities can be set regardless of whether or not
-	 * sched_set_itmt_support(true) has been called and it is valid to
-	 * update them at any time after it has been called.
-	 */
+	/* Priorities must be initialized before ITMT support can be toggled on. */
 	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
-
-	schedule_work(&sched_prefcore_work);
 }
 
 static void amd_pstate_update_limits(unsigned int cpu)
@@ -1196,6 +1180,9 @@ static ssize_t show_energy_performance_preference(
 
 static void amd_pstate_driver_cleanup(void)
 {
+	if (amd_pstate_prefcore)
+		sched_clear_itmt_support();
+
 	cppc_state = AMD_PSTATE_DISABLE;
 	current_pstate_driver = NULL;
 }
@@ -1238,6 +1225,10 @@ static int amd_pstate_register_driver(int mode)
 		return ret;
 	}
 
+	/* Enable ITMT support once all CPUs have initialized their asym priorities. */
+	if (amd_pstate_prefcore)
+		sched_set_itmt_support();
+
 	return 0;
 }
 

base-commit: 56a49e19e1aea1374e9ba58cfd40260587bb7355
-- 
2.34.1



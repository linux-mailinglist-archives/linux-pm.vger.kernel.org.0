Return-Path: <linux-pm+bounces-40406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 752D5D0025F
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 22:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B29304C903
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7564E28A72B;
	Wed,  7 Jan 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WXiwmQXu"
X-Original-To: linux-pm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72F2DA749;
	Wed,  7 Jan 2026 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820843; cv=fail; b=cdtgqZ219lwY+RumWR/Zvbs5QRsNMivQVzs2m5fNpgwXnDegAxxrCKMA3haTsBFuer2xK8JSA5dk6RAlCNf1LgpSSmrYwbw7wIMcuMPJvo4ZCGoOYl4K0dumz/Ur+6NGmxE5by0p6/Nou64+QD4WxtjmHzC/O2B/IVHEhIXAjaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820843; c=relaxed/simple;
	bh=54Yyim27TgwOSw0tIRwSiDmmOR6YJxep75cEDLPwbrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTAXegS83OmiDxsekPFgcGxQKZ+3GMTOg7Aif9DiZz5R2RRg7ByHYKlz7gr5rcsrVjNGgg6CjqahqVHcm0cqnhkQ2PJhzj/jIip1eTeGkZillABVmwRvzOGAkdb2WtxkHXMBdL/2+iomcHddyv5cRzZDqBM9K8XaivoikfmQC1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WXiwmQXu; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l995diGCDBbXj1J0vFFaOsykm4waQF/XhvLwH8j/V2rgteGjv2UWPZVlcFwlfirH1dYcv8pJ2NNSt3SfH8DmnjmFAXE3ZqkaYFEcHa4SqliFIM22whDYvh/wKzp49v++/xJkpj0U7ukNe1fUXnozWRtz3hVskr3aEUHJG2Oos/7uF1EHCzUoxR0EtbcNr9RY8xQS0pM7bqE/HZNCaIXKuOmgVmLzeZ6jh992/gmM7U0HIlwK2FeXZMxpcO2QTtDgKcwZ7YcIXAaO3EcOCgDsUVNnFzX0IKtcn8qFy9E/DgWgiDHRXjyzWgdXsUJ2tNvgzHb4mVoGsaVVxyGIhZ3ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEV5pPH7GZm+BYCzxv1h5lcM0m6NgG6SNMegf51A70Q=;
 b=xd2vedUzU0LD+RA2B2dnGhR/ZOd1VCZU/3oFgntqGVLXetFmQFR+6vHd5RIxLxaDI0MeoT0bwzk+SerkL34VUxu+5m2dHUrt66BTIEudqlo7FIIVCmyjd/6Iq+aQkkWPYBRz/24VPSYJdc6BGxhG80BRghgxc7+x6YcsKL3PeebifuzjJukOfBoIuxbLczRHz54XhslvvC6PmLZ3XISVUELPXK1OlV7cX/XH3m3LQmLJwcvWyF8LI6tjHF1lTmKGtfEmkoLd0LLADBDLJju+g+Mc6eCQkqyLE3K9gNP6JOPokmRiRulXeiT0ChMPMMpBck/LrlR4yUH5JYcbWU0Quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEV5pPH7GZm+BYCzxv1h5lcM0m6NgG6SNMegf51A70Q=;
 b=WXiwmQXuxD7VcW5+nJjnDyv7PSni3QkjT9JKMUWRZn4MJepVvCzf0sQ2q4fQIrpEKTjcpLO4MO2iugeEHpUejhO0wkqjJo9sH/j60r8DWvdDeyfgd2Nr83Grippdiyj3ZHKEVy+sZJ0cJtTHLo6USIsis2jScje1VXbwiZNC1XM=
Received: from PH7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:33d::34)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 21:20:33 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::a0) by PH7PR02CA0014.outlook.office365.com
 (2603:10b6:510:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 21:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 21:20:32 +0000
Received: from AUSJUANMART02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 15:20:31 -0600
From: Juan Martinez <juan.martinez@amd.com>
To: <ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Juan Martinez <juan.martinez@amd.com>, "Kaushik
 Reddy S" <kaushik.reddys@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix MinPerf MSR value for performance policy
Date: Wed, 7 Jan 2026 15:19:19 -0600
Message-ID: <20260107211919.38010-1-juan.martinez@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f35218-0cb3-4d26-2671-08de4e329762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iPTe9aii6uybnq5i7my2ZWh2yZmlLhbujxm3a6vU07OvUcNWoZHMlW49H5P?=
 =?us-ascii?Q?zTust7sMNVX00wMIlJG22KwpCl5Dz+uCGJUJnFlQJHbA/FqbAfiUffLBCxuI?=
 =?us-ascii?Q?lvO8FGVdVj2UYkOibeVHzkiG6CikUE/YJAm7scr3ppYJ23RCUaSo6+mp0oma?=
 =?us-ascii?Q?opi00NR/Od8IjtMOfsf3K7oGfwAc6fx+lXZgohP79wq6VZlW7SUAGwXrksfZ?=
 =?us-ascii?Q?Zsp7yVGF1ABLyj2Y/MLI6pZHmNDiLPl//oEigRYPttTvC9Y0kEtoyTRLelsq?=
 =?us-ascii?Q?VNyrK0XfdwAD3rYfYL2gcikuhVY7aau6FwLjRF3wCp9sjCPF4mp/nm0hNF1+?=
 =?us-ascii?Q?Yh3ob1fUM5mVKZ8p5Y4GWasS+ojIMmEHJdBFJ3rcIfRgHBzbG9mqn7wiqXVI?=
 =?us-ascii?Q?nL1A6XdcOXnXzgvLoKrUmcGZwkmG1zvpAAhEu2FOC6xE8fJZQia/LsawWzzq?=
 =?us-ascii?Q?GEx7M8chOYJhRxBblYLohgi1CISJfPHisXGAUuZu5gAh+5Lz9fBmrHI1bdg3?=
 =?us-ascii?Q?my6gF3JVUj64ZBaCwzYFK6K/gLgXRAczJQuVHnqPfBaXrO8fr8Vt/77f6SVt?=
 =?us-ascii?Q?YW4nHaZuKfnjNIGrpGCG3INWINrXSgIpVDsW+mlk+C/9hT6DwVaWKn3aLGu2?=
 =?us-ascii?Q?gW5x0KJjI58B4AcgAozlsHCE7P/thxW2wg9B9HLFV+YPPluHfm6GOlOj/x1F?=
 =?us-ascii?Q?R73EiHzncepGSjvdXLk8fN8JdCuEgVxfXY0TuNeRMRNJhZaX11aL/f4dbEE/?=
 =?us-ascii?Q?KoA0QznbzsmlccWo+vkg407F15F137EfMty/Vor0y70j+Vc7HN8K6ZxsvFmv?=
 =?us-ascii?Q?s6YPp9/sOszqywGwgdmZpxenWHtoHkAC/VbFc/zMtAmba56eljE4BuApT6ps?=
 =?us-ascii?Q?Bn1RzfNXzQvS7Jd0QDhEoYPg9H4IGQBgCOVS+M7Ybg9roB4GfAfP44ippA72?=
 =?us-ascii?Q?OYkrgRosd51rj0QYSRs52WnX7UC7QTOxFMvA7ZFtJfE3EfHoDqB6tBMkh2Hm?=
 =?us-ascii?Q?vrlA3NLuXG+m7XZLu26v11AG6Bz9aqzDP/Bt7yABEvtiC71ONhoZNBhiDtsA?=
 =?us-ascii?Q?BEgq0+Z/N7Qzyt3LganE54GBrGnCYWeAtvK86P2bMPrL0qWKbksfcn1A0YWj?=
 =?us-ascii?Q?JvBkX59xZzPNrK89+HDv8KH95DYTu8ApJWt88RLtWlsb27TdiL080YKj2i54?=
 =?us-ascii?Q?YQziQivd+kwJ0nWDqHFve/I0TjfSwKYtEE4EBKVa0T97uDoPlOA/cIs2Xth6?=
 =?us-ascii?Q?oC/j7fr+8cAxWseTvA9vPGG6aAHcE1aDoE45fQxW0ExkLjtcizgDs1l0qdVx?=
 =?us-ascii?Q?/bfrCTnO45detbACQhSPD4gqshQ53QsczL2OmfkS7YIsmSWJbLeW+Oku2fdH?=
 =?us-ascii?Q?2rcbzj4Zn/q3HsSldMNawh2Izxsztmd0D12MIfADqFBB7G1gjLJ3JCKzPBxr?=
 =?us-ascii?Q?bQdpSWqKhBtfan3gmQYavZvj6EeXamttfZxyESMOSPv/qoqEt2cJLGc3Nb32?=
 =?us-ascii?Q?WcCryoyVAi2V88cSZb45+25cUk4katLhup/WHvqy7tMW1cOYKhHCgVN68Qvb?=
 =?us-ascii?Q?vwuzPbbmQ8rqCQLqyRY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 21:20:32.7455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f35218-0cb3-4d26-2671-08de4e329762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481

When the CPU frequency policy is set to CPUFREQ_POLICY_PERFORMANCE
(which occurs when EPP hint is set to "performance"), the driver
incorrectly sets the MinPerf field in CPPC request MSR to nominal_perf
instead of lowest_nonlinear_perf.

According to the AMD architectural programmer's manual volume 2 [1],
in section "17.6.4.1 CPPC_CAPABILITY_1", lowest_nonlinear_perf represents
the most energy efficient performance level (in terms of performance per
watt). The MinPerf field should be set to this value even in performance
mode to maintain proper power/performance characteristics.

This fixes a regression introduced by commit 0c411b39e4f4c ("amd-pstate: Set
min_perf to nominal_perf for active mode performance gov"), which correctly
identified that highest_perf was too high but chose nominal_perf as an
intermediate value instead of lowest_nonlinear_perf.

The fix changes amd_pstate_update_min_max_limit() to use lowest_nonlinear_perf
instead of nominal_perf when the policy is CPUFREQ_POLICY_PERFORMANCE.

[1] https://docs.amd.com/v/u/en-US/24593_3.43
    AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Section 17.6.4.1 CPPC_CAPABILITY_1
    (Referenced in commit 5d9a354cf839a)

Fixes: 0c411b39e4f4c ("amd-pstate: Set min_perf to nominal_perf for active mode performance gov")
Tested-by: Kaushik Reddy S <kaushik.reddys@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Juan Martinez <juan.martinez@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e4f1933dd7d47..de0bb5b325502 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -634,8 +634,8 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
-		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
-		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
+		perf.min_limit_perf = min(perf.lowest_nonlinear_perf, perf.max_limit_perf);
+		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->lowest_nonlinear_freq, cpudata->max_limit_freq));
 	} else {
 		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
 		WRITE_ONCE(cpudata->min_limit_freq, policy->min);
-- 
2.34.1



Return-Path: <linux-pm+bounces-5185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0F0885836
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 12:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E51C21BA4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DC57867;
	Thu, 21 Mar 2024 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T93ozBM6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598F58228
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020239; cv=fail; b=XBxC4iQCT7bw5byFtqM1sHYZrUT/XJWXY1VsI0x/7c52MJZsK17fFzgRMqcTMtM2cxk0/QdJvYwsXS0DbChQxqezCrKkqZ7CPOml37uQmQZehISfZ0ityu7HCUVrmahwgZ4kq3UdrPrvGMdSZlQoiXwOnBiz8DCdpSb8XYCUUwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020239; c=relaxed/simple;
	bh=qLfPY5nCOSpWZonTQtJMnpecWcTWwobG1KXIRvKQRYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RsBxaK7JhylZNOvkvtfxF8/Dj1l4eBwV2mXp4qKHQYSCzo47ZctBYgwOgjoKJaQkLKoJWPoV52YH1w1Vf6QT/aQXae7CLxL4SVta49JzZhT7DZzAEOeQf9ulNFSgbTql8PN5g0th3gH3C/p2zGlvaMIGD8bTGdXpzmFxKaY+hZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T93ozBM6; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5shiViTRzO7r7KJaU1DiKGa7ExjPVfU2wlJi7T68J3WpkJE9c0Si8g1MejLWjq4nUZgMb/iMbK0TGHh4tcN2WIZ/L9H9pI/6Wip/0IPtMLxPBmQc++3OKkErPecLQmDqMIYQFTtGIKWKZjqi9aKYi3O8qrSmO3vWfsqEfxZRaLOTgfvz/mqYvW6X4jT7dvMG4xs+G84jbycc0hxkbqUW4W5nyalD4QwOGRMGGeMjopxVwz6vukYcsYE+ftDB6/VQXtawXDRXtM1CYhhuPlPVJtoPsl6B9foB5+47NeMK1PAJLDh1dbnA1v01AM7AnoR3njDC7M1eiKqdKk5IXG+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEHznbmDEl0K89+HxrJqo5Cbyrcy3k+sjhJWqjPTTs0=;
 b=g7JT5AMko3ezk/V29Jcl76EUkcsTpFqzF1dzo+eDPnYQpltpozgtYWu9ylUXAGLqcCasDYS+tm3UrNONN4/0+duXOnhLn1Ig1Hkpkriqba5tm1eUZ6jPLhDzI1cpXwIXp1a3cOXSnMvL4iIep+o9bIyWy/LHpNlZGZ5Ec755f2uYS1NPznkwwzviXAnqNi9RowjfwjIAEr6F2hc4IiVkfUOctDmyK5FDc9hdvHydJAF94eq0qb3AfvEv1bG5Dv5TKZYmoSDa8cKJ0dYRsQ+Ifh9oJ/4pc2ZV1YJXB8c2hhsGXTVAIOl/25GwpE9YJEBEz9W5c390YApZKBIYvY26wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEHznbmDEl0K89+HxrJqo5Cbyrcy3k+sjhJWqjPTTs0=;
 b=T93ozBM6+iFChgkEsDIMBvtRYei6manEuY2FeNvQMMu3eqaE5ewt3+2WGsbinzP2vIZaY+Y4VGfxrMD823NR5wHQLCWyeEjxvBjjV2JfUqSYReuOyWSEO2NWjQzkVZvNW5f1h7JLaqJGx9bxfieQJHbiiR27vSOZWS9Dyjwg/pA=
Received: from CH2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:52::14)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 11:23:51 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::25) by CH2PR04CA0004.outlook.office365.com
 (2603:10b6:610:52::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 21 Mar 2024 11:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 11:23:51 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 06:23:45 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-pm@vger.kernel.org>, <Perry.Yuan@amd.com>, <rafael@kernel.org>,
	<Ray.Huang@amd.com>
CC: <Li.Meng@amd.com>, <Shimmer.Huang@amd.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: change cpu freq transition delay for some models
Date: Thu, 21 Mar 2024 19:23:30 +0800
Message-ID: <20240321112330.832204-1-Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 001ab551-9b1b-444b-8362-08dc499962a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Fsj+I7MpMy6SPywfd1iCLKo2j3ih/KWvFh/1OOoAVAEReTNtwwfszJOSaDEHKuwAOIGAppmoLeqY8bb2w3Kylgn4gvsap5uXElXE1bmuYXzGu2LrsFnsrEGKLmZwyJZp8AtQz372C8NH932O765sfZKVlNzryx2KMEuvqIdWEwuc9eK/Fm4cJNaorzQhspsUB1gfF4naySFYa6+SyXlzbewwbULLaZ15o+ZW+ziaLHvuCZYeEKqHt+W4VPzRKfB3C+E573yyRxyQ1moElKDEqm9wRQMxLse+WSDNyRPrWSYdIEhLy6cpjzohM2TyJvMRF7WgfW4a0luGW6SPszO/9UGeQhtllXIjHjsEOxcJNeTfqcRfdLhG0LedCAibTivZNbHLj8aGR12T8UOuP6nkFCAuh72v3BMopBRekc+o7KpULONQ7wpq6qiu0kfd+QCg5dh2or1ErMSmGnszk1I9KUIf/DOAeuRovjpvrHkYnkmBhcMgZPuz9/Wgr4QVAIa1w8qrw5ec9U/tEs5PuH5Da0H5ZOWet7yU+soJknuYJMJX9jdkcS+IDUmJje720FQFBvtoyq7D3RJZoGPJnv9qyD1p2X/3ppY8vDWuJfruFv34285IANDxZi3TCIuLfuw6P2MNU5zTvvHSgkCHMLhVDe7jLdYCif1NDcM7HYIYE1X3Tl3ComFC9WfVCk4jGkQgTI/urmK1dsiOFmlZNBUmwyxbsUSl5LIyQxRj4tdd7BotzI3qPJZOOcVqigaoDuR
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 11:23:51.2849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001ab551-9b1b-444b-8362-08dc499962a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643

In AMD Phoenix(ZEN4) APU, one new power management unit -- MPCCX is
added to control the CPU frequency clock, it supports to adjust CPU core
clock more quickly and more presicely according to CPU work loading.
This patch will reduce the CPU clock transition delay value to coordinate
with this new pm unit for Phoenix APU, and this change will only be
effective in the *passive mode* of AMD pstate driver.

Some test results on AMD 7840HS(Phoenix) APU:

1. Tbench
(Energy less is better, Throughput more is better,
PPW--Performance per Watt more is better)
============= =================== ============== =============== ============== =============== ============== =============== ===============
 Trans Delay   Tbench              governor:schedutil, 3-iterations average
============= =================== ============== =============== ============== =============== ============== =============== ===============
 1000us        Clients             1              2               4              8              12             16              32
               Energy/Joules       2010           2804            8768           17171          16170          15132           15027
               Throughput/(MB/s)   114            259             1041           3010           3135           4851            4605
               PPW                 0.0567         0.0923          0.1187         0.1752         0.1938         0.3205          0.3064
 600us         Clients             1              2               4              8              12             16              32
               Energy/Joules       2115  (5.22%)  2388  (-14.84%) 10700(22.03%)  16716 (-2.65%) 15939 (-1.43%) 15053 (-0.52%)  15083 (0.37% )
               Throughput/(MB/s)   122   (7.02%)  234   (-9.65% ) 1188 (14.12%)  3003  (-0.23%) 3143  (0.26% ) 4842  (-0.19%)  4603  (-0.04%)
               PPW                 0.0576(1.59%)  0.0979(6.07%  ) 0.111(-6.49%)  0.1796(2.51% ) 0.1971(1.70% ) 0.3216(0.34% )  0.3051(-0.42%)
============= =================== ============== ================ ============= =============== ============== =============== ===============

2.Dbench
(Energy less is better, Throughput more is better,
PPW--Performance per Watt more is better)
============= =================== ============== =============== ============== =============== ============== =============== ===============
 Trans Delay   Dbench              governor:schedutil, 3-iterations average
============= =================== ============== =============== ============== =============== ============== =============== ===============
 1000us        Clients             1             2               4              8               12             16              32
               Energy/Joules       4890          3779            3567           5157            5611           6500            8163
               Throughput/(MB/s)   327           167             220            577             775            938             1397
               PPW                 0.0668        0.0441          0.0616         0.1118          0.1381         0.1443          0.1711
 600us         Clients             1             2               4              8               12             16              32
               Energy/Joules       4915  (0.51%) 4912  (29.98%)  3506  (-1.71%) 4907  (-4.85% ) 5011 (-10.69%) 5672  (-12.74%) 8141  (-0.27%)
               Throughput/(MB/s)   348   (6.42%) 284   (70.06%)  220   (0.00% ) 518   (-10.23%) 712  (-8.13% ) 854   (-8.96% ) 1475  (5.58% )
               PPW                 0.0708(5.99%) 0.0578(31.07%)  0.0627(1.79% ) 0.1055(-5.64% ) 0.142(2.82%  ) 0.1505(4.30%  ) 0.1811(5.84% )
============= =================== ============== =============== ============== =============== ============== =============== ===============

3.Hackbench(less time is better)
============= =========================== ==========================
  hackbench     governor:schedutil
============= =========================== ==========================
  Trans Delay   Process Mode Ave time(s)  Thread Mode Ave time(s)
  1000us        14.484                      14.484
  600us         14.418(-0.46%)              15.41(+6.39%)
============= =========================== ==========================

4.Perf_sched_bench(less time is better)
============= =================== ============== ============== ============== =============== =============== =============
 Trans Delay  perf_sched_bench    governor:schedutil
============= =================== ============== ============== ============== =============== =============== =============
  1000us        Groups             1             2              4              8               12              24
                AveTime(s)        1.64          2.851          5.878          11.636          16.093          26.395
  600us         Groups             1             2              4              8               12              24
                AveTime(s)        1.69(3.05%)   2.845(-0.21%)  5.843(-0.60%)  11.576(-0.52%)  16.092(-0.01%)  26.32(-0.28%)
============= =================== ============== ============== ============== =============== =============== =============

5.Sysbench(higher is better)
============= ================== ============== ================= ============== ================ =============== =================
  Sysbench    governor:schedutil
============= ================== ============== ================= ============== ================ =============== =================
  1000us      Thread             1               2                4              8                12               24
              Ave events         6020.98         12273.39         24119.82       46171.57         47074.37         47831.72
  600us       Thread             1               2                4              8                12               24
              Ave events         6154.82(2.22%)  12271.63(-0.01%) 24392.5(1.13%) 46117.64(-0.12%) 46852.19(-0.47%) 47678.92(-0.32%)
============= =================== ============== ================= ============== ================ =============== ================

In conclusion, for AMD Phoenix APU, a shorter transition delay
of cpu clock will make a quite positive effect to improve PPW on Dbench test,
in the meanwhile , keep stable performance on Tbench,
Hackbench, Perf_sched_bench and Sysbench.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1f6186475715..107dc2778d37 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -744,7 +744,15 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
-	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
+
+	if (boot_cpu_data.x86 == 0x19) {
+		switch (boot_cpu_data.x86_model) {
+		case 0x70 ... 0x7f:
+			policy->transition_delay_us = 600;
+			break;
+		}
+	} else
+		policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
 
 	policy->min = min_freq;
 	policy->max = max_freq;
-- 
2.34.1



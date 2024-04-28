Return-Path: <linux-pm+bounces-7234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079738B4AEE
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE01C20BEC
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4B54BDA;
	Sun, 28 Apr 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H1Rbu3/P"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E772EAE9
	for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714295522; cv=fail; b=n55/lBlFIT+ol4I2eYjQc3CNPD2lw08mnmOf6t3uZUIT2t91xQ/6VxbyB/d7vO3ezNM0AJN1LH1qULApXzz0ciGL9mv/5b2PAaccKoSSzH+lcPbGNufYoky6whQYgFYtNVl2WzhfpU0tEY7dhni+/oNZCb3gJ9LuTDOeHF7lAOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714295522; c=relaxed/simple;
	bh=9eqzXa1iwgTiH0uGFLgK/7PZRVtEuk3TwiboFBA75Iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgkjSrZZOfvm5xVzpdAAqQW+V6nBAaY4iK1Njee5H+Ym0lKo9REaKPU58NUtqeLxQe2Jn0P/ek28xUmB1ufI3PAup+Z78wtCKjz6R6c+y9i2Xz3vrL/Ebh0o46TxJyn9DumTSHa55rhwgYPqJTZSa9r3D4cy/RZozDmT/zD078I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H1Rbu3/P; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvFZaZsnzWvcy7sg7UFgKwQhqgvrfrDVaDmY8n3vm5aAXAbDU8myrH0aSR2sQsJa0GVbgWieQHdlRE2OpdQ90R0PvGZ9kzWlildQ6cwQwd0joJ3jQFo1g8zK5cvRqbcdrl2IRJeh5Xfl2zXTOTt7QSxpwcWPjYFxzbpBbNJtBAj9L+s20DIOFk7INmyi9pZEllOq/rS2JoqFYdEhR8yC+KLhR7GLgA2qzbYVzfiz8uMOO7+E+ubjKyDEDKhLVWstbOkMX4yYyshg4Hx2j2Zojv8YhNjL1flLoQQiiKzyKSQlDwJ4Lpw9Q5hpkt3s+/j4A9NCLjryIS6VwvWsliEwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD5keXYSgtpPpkiog9lQQg5mjM17XJl+MtHnlG6oVUc=;
 b=Mi0CwM5SRvJZNPrj5iyXlhTPqDOQWFIFhw/Fk8QcXRJxDkyqU0U3z0RfcQ1MB5sMSoBVgQFfOfkjATdrJ4jAGy1AU5Rk89j6ETAef8fgGpH3+XMqreLp5Pa64XJVtIxdfRGBCysVJm96c9MGBLWxZ+pJ7rbR6VxID5WhlHqh4Qdoma6Nu5f/hhbs6KLdDHxLClQV+ZadPTVnhsVtynQKHTomjhTWHDbIl+gcmuyCHzD/Epu/UClWN431OqbDA96fjVK/EZry2guYGc9mCBfmRYwm0wVzEciURDsd2GpNi5Y/9H3yHrx6B5ShIFH2CgE4MVx79pckSZZvx7Qkn0w6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD5keXYSgtpPpkiog9lQQg5mjM17XJl+MtHnlG6oVUc=;
 b=H1Rbu3/P9giGXnEh5/WYjcItpg8UIiVcyDa0xPGHzVcU2487rrDxiZ2h/mZRXZNrLIwswaRXDiHfZ4HbzbIBy3BN+KLmKrLBL0Po8+oFf6N1iqESgzt7ELoJ+REEwdJX84HuW0RCOtOO4cSnQp90C23T/FuySaq092Rhxsbw9rk=
Received: from DM6PR02CA0074.namprd02.prod.outlook.com (2603:10b6:5:1f4::15)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 09:11:55 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::2) by DM6PR02CA0074.outlook.office365.com
 (2603:10b6:5:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Sun, 28 Apr 2024 09:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Sun, 28 Apr 2024 09:11:55 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 04:11:52 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-pm@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <mario.limonciello@amd.com>, <ray.huang@amd.com>
CC: <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH 2/2] cpufreq: amd-pstate: change cpu freq transition delay for some models
Date: Sun, 28 Apr 2024 17:11:33 +0800
Message-ID: <20240428091133.592333-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428091133.592333-1-Xiaojian.Du@amd.com>
References: <20240428091133.592333-1-Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a21a8f1-995c-4c74-e40e-08dc67634007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hqc69ARR2RgVdGronFIDsgiFUKv0M+r/bXeMBIeNcVSJuwwNJSB8tVMyTD89?=
 =?us-ascii?Q?2HDGTy/ScraNiRrw8VND2i+DfhTVSVMwx22C429IbiJcdEKxZMf5O/ceYd7j?=
 =?us-ascii?Q?oQ5bl+UPyvyVUxND3hnpmgk2LvDTv2ahJGk2qIQQQ0JqWQE+yR9iuXE081mX?=
 =?us-ascii?Q?75a0nHGE8ybf2AMFybyUG6J/62W6v05YF2ICfyLPgFpBi7+x6TJkAbwpvUey?=
 =?us-ascii?Q?uXXmYLyU68k9Oe/RMTdCBEn978fTfmA1qiFKnPyKP7dod+ICYq0i3mvYv5eP?=
 =?us-ascii?Q?uRFzxqIguEhXk2ExNSAJMyyHKb0/nEh8IiDcgbCGUk2CKx8VSgP6VtZFoWM7?=
 =?us-ascii?Q?sBDPXjGDjS+U3bTOEC3MreVjladmAIVOWSfALCunZdOMMerhiRqrDMP6inbP?=
 =?us-ascii?Q?Sw1iEqUhrD0EoGpVkuKpLTMLAmwRZ2dgvt4yCqXxGly0tv237DTl2BSx82/2?=
 =?us-ascii?Q?S4M++b2UEtiy1I6Dz9wv5qBVc2BWsP80dnsNpEfMmymXHvKdKyQsKn567Cau?=
 =?us-ascii?Q?JHn4ciHiLC6zPnJ26smbN/8Hjnxrk88gEyyqQLp9g2a1HZftohswM8Ib/l07?=
 =?us-ascii?Q?B8OCVaDPOTDDsdwh4q20glO6Y4mqAcbd0b0FXEMLF7ufRef/tiXzDKQfKgdM?=
 =?us-ascii?Q?yrvWy3MZuI4mzznQiWbv1WbWAZwagYjoqSyXVX3Ruw8m1IGnsPhqX6gyzEQ7?=
 =?us-ascii?Q?OkPdyssrUxwcblo8NiP118ewbmJilUlXrJ37wp63iqemO0rbj0TpGJRWkZIo?=
 =?us-ascii?Q?m8DbKoAxNi0qgrmwOK0c4vLm40uyKI5Q6GWU9X4XWOFROcpEPY36isxgSDW6?=
 =?us-ascii?Q?5iNJIK3B1p00ipam3gUXW+/nmPquIfIKqeZrZ1RrUFjC0eFadDpZVf1pZmTq?=
 =?us-ascii?Q?uHWAXzZCPCGSRpy6Gqv2rsDAExo24hKhgKURVf6q+636wY2M2EwkH3cpQ59j?=
 =?us-ascii?Q?yJC9XECfDfqtOYq6OXIJ4RAQwN7Gyn9GloLVxPCGYSPEFVev1cuZ++YANZOu?=
 =?us-ascii?Q?nNjeD16iR5/iDR/CEICkuHEbX4GBZaO6ENFP/WmlJUUl13oAMr/GQ0Vs7KOf?=
 =?us-ascii?Q?lc4Jks7k5cPsyourxgUXY+ydx6aVw/9gH+M0sqmuQUf9wPyfTdP2HDgQ0CGh?=
 =?us-ascii?Q?gRar1hmrbBKvjVMkDPKDPDFn8Tt5cRQDYOQXe24BeuGR10VpEnVe5I20OayO?=
 =?us-ascii?Q?or5EXrohd3V+/SU7wkWoA1H0qUHP9EXwJRrvg7/i8c9MoiRf34GxZ/BVO6ND?=
 =?us-ascii?Q?dDSlhP1o7AYjggOxrPZw/N56a2b+y1Km5ldwjjKynONcyc6Q8AenYfygLO02?=
 =?us-ascii?Q?yK802+itPR5qbOiOFJLRJcSKoPnAjRjSZwg4+b6cNaTXUH0KcXvh8trHOWDb?=
 =?us-ascii?Q?ernHMr8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 09:11:55.2824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a21a8f1-995c-4c74-e40e-08dc67634007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204

Some of AMD ZEN4 APU/CPU have support for adjusting the CPU core
clock more quickly and presicely according to CPU work loading.
This is advertised by the Fast CPPC x86 feature.
This change will only be effective in the *passive mode* of
AMD pstate driver. From the test results of different
transition delay values, 600us is chosen to make a balance
between performance and power consumption.

Some test results on AMD Ryzen 7840HS(Phoenix) APU:

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
============= ================== ============== ============== ============== =============== =============== ==============

5.Sysbench(higher is better)
============= ================== ============== ================= ============== ================ =============== =================
  Sysbench    governor:schedutil
============= ================== ============== ================= ============== ================ =============== =================
  1000us      Thread             1               2                4              8                12               24
              Ave events         6020.98         12273.39         24119.82       46171.57         47074.37         47831.72
  600us       Thread             1               2                4              8                12               24
              Ave events         6154.82(2.22%)  12271.63(-0.01%) 24392.5(1.13%) 46117.64(-0.12%) 46852.19(-0.47%) 47678.92(-0.32%)
============= ================== ============== ================= ============== ================ =============== =================

In conclusion, a shorter transition delay
of cpu clock will make a quite positive effect to improve PPW on Dbench test,
in the meanwhile , keep stable performance on Tbench,
Hackbench, Perf_sched_bench and Sysbench.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2015c9fcc3c9..8c8594f67af6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,6 +50,7 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
+#define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY	600
 #define AMD_PSTATE_PREFCORE_THRESHOLD	166
 
 /*
@@ -868,7 +869,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
-	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
+
+	if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
+		policy->transition_delay_us = AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
+	else
+		policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
 
 	policy->min = min_freq;
 	policy->max = max_freq;
-- 
2.34.1



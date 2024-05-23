Return-Path: <linux-pm+bounces-8067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6A78CCC24
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 08:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD971F235AB
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 06:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F730481B7;
	Thu, 23 May 2024 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z/iOTbsN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B665187F;
	Thu, 23 May 2024 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445059; cv=fail; b=UtqtanVkzwGs3l1SKC4swalmTkJikIl9IQGD6Livk7kR6c/7oUD6lZYiEfab+AXSPLWXB8GZMKk7pAz+a9VrXKMkxLqgjfRG4FlY1cno9wVtSJXa2U4VfHnZhctDJ/f3+dF58wIfZrtMUWWzQQxSXBSBwakmpG/TwWWYJx8fyfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445059; c=relaxed/simple;
	bh=5W450A4OA/tDPi8v3Hq/hsuNj6aqeScgGT/+R0I2qe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtbbhwqtndEh0LJOjr4VmpdyhfT4xVCSnCXysy0dWdrel2TpukdmEjMGY7Rw2OuaJPooABZd5HNlVfvqN0YLuwJStKlGwy4sITXPloK7rcC5pHj1L5yfyI/dqkMQqZR069onsyTvEHIz0afo3OofcO2eDCGmP+qtYY6k7UUmTuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z/iOTbsN; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjdoBZmAflTMaU3yOpemGrSl4RfGtnK67fpleL8ffaad/1QEnmWnqr2juZqUutp35tN9jeKqI5MAo9KeRxmQtIiE5Vjb6fXoCHpWJwrCJFn9KJ4ud8alOGrF5QVeGpxL/3fZqX6mcf3R2yV4oOsiBtDwWDBtSvScsrFYkfslrSm+jD9f+/4w5WnG7nHjkoeyRLw+cix8fA2z3mWJRyCG4aeYGBGsV4ne4AiLjepxqpq/KcdPaUJxwd4RYAre2n31MviIn/iq4bzFmb8AYyQZ5EuBj8C9VDOYn5YQyoR1EZuKxxHzk6G3WGHHeVL6w2xpqNKsZSGBmQVjaiHd+Ex4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYADc4a0EGMHe4KFR/rNv9z2oEHxbArNMIpqnfe4MIM=;
 b=adyvz+aj/Pl8/2Cmb6achzcvjBwxGXVN/x7vrhiozGJkGgZl07HyZiEec+nsjK+GJLS+eWWpTqcsL1ViDnQOCZOFEbRh9CFutfqCm0a8d2pbXawDIw6QBcpuzT6KG0kGJ32nyO4nggDvbIjQk83+6Om7Ydb7wQsjL6v+svcrjbK4MA0P0sbyTHBaIkFdSXN9bMEFZAtmi0A6m4TPbX43XPGawnFhgK2HRWQnECtyx2lcoLiMRblZIEbPCtOQi8iB1LAdm3grWgHIcLdrBxKwX+SbFg71n1A4DkpcXzkezATlz6UPK70YyxduGqhRhyIMrTGLO8snS72kZi24nwNcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYADc4a0EGMHe4KFR/rNv9z2oEHxbArNMIpqnfe4MIM=;
 b=z/iOTbsNZkKzJDAPScIJMsU36g38B5rz35V+bCw1w9lSWx0E4t5wxSVGCRAo32ONvw6hhtwi17NCi8AHQGr4dRCNr52cn9vuc5XwrzmxWdNSCwNPB7ND96nsIvBAzMsR7rBMn6z1SrYx/lWQx3DrJAfa8WSIKOdF3EMshrhVuwQ=
Received: from SA0PR11CA0118.namprd11.prod.outlook.com (2603:10b6:806:d1::33)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.37; Thu, 23 May 2024 06:17:34 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::b) by SA0PR11CA0118.outlook.office365.com
 (2603:10b6:806:d1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Thu, 23 May 2024 06:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 06:17:34 +0000
Received: from jenkins-amdgpu-chagall.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 01:17:28 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<Perry.Yuan@amd.com>, <gautham.shenoy@amd.com>, <Borislav.Petkov@amd.com>,
	<mario.limonciello@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Perry Yuan
	<perry.yuan@amd.com>
Subject: [PATCH v3 2/2] cpufreq: amd-pstate: change cpu freq transition delay for some models
Date: Thu, 23 May 2024 14:16:58 +0800
Message-ID: <1754107f24b1dd0167069d6c8a7ae9e5e12994a3.1716444920.git.Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
References: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea71ccc-67aa-4665-e85b-08dc7af00918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?REmcCOOE4eWfJNARmnOMk3mwAq1mGc+lD61F7W/5U3awqtr/QzA015gCIEC5?=
 =?us-ascii?Q?t+pQKnXiuOlkONQ1NEoflwYLAsUaOt909FejEZoE14um33O/8k8GUtt8C/8v?=
 =?us-ascii?Q?fOyqNVbYL4RkKKgYvciP/9AkN9RuNTEsneuzI6FcPOUYffI9McksJdZz4aFd?=
 =?us-ascii?Q?8iKX2dlUM7/S24fNpJRHrXthObemOFtNe+J/iuqmzXqDDTr5Z/B5FwJfIw0W?=
 =?us-ascii?Q?8L1qnXOqaI62O8P+PxJVNnvGOFIK4Zy7XHmPe+9KPFzy3Ekf4387GbBraufz?=
 =?us-ascii?Q?KJ6mwrgpgdwb4KfgMhPaZiwClYYCqbceWeflGV9sUe4T8ipR0tNHot/VpG4l?=
 =?us-ascii?Q?f8OTZd2z9hlyVXkDV1Qx19IdLjpwUygneKW2n+l0dTPgKIgelbFbz22cXfr+?=
 =?us-ascii?Q?Sudp8Q0ag4W8EuazUTRDQ25ogpmkpdC41BtdSg9lWfLlQFRVDvtW3LqEONwG?=
 =?us-ascii?Q?1n/ecbphiBvkrF2GU/ypwZ+LY2h6S8cm8wU7MZyGSssrXfq9MgOev5Q06KPm?=
 =?us-ascii?Q?R6nrqGI4yWmgP3+n7pqx/u/BfbEhXLY9eA+01k8OPMYp1xhr+clW3AXM50ou?=
 =?us-ascii?Q?aX+J1spnFvjOQkThnXOd1oRQORBynMAjjtr6aVfQbeis0815jm+T1LohCedQ?=
 =?us-ascii?Q?Ggt0aI4IQgctb8+Zr+itojmGdKEYPqMO5eghWTsV/q1thieFxomhGxqYaHZ+?=
 =?us-ascii?Q?3eySHQyuK8Xqw24gTq4VXQduDr3tHf/YocF+5wh5Cmh4rwYbcx9ZD8MhFDEK?=
 =?us-ascii?Q?P4Bim4/cdy0inAXFXC3Wicjc7KpPpn+z1HrvJGDoTlnGqidJJ0ZwO4X38f03?=
 =?us-ascii?Q?BWgZqudwcGCIwwS7Gc849/lrX4BVQ3S5LecWnDpegPcEkXta80W+DjTCPF/8?=
 =?us-ascii?Q?SNBkg4APvqDEjOF84juw2BBn/ORHsYLQpQBcmwxWPFZZZXT6H2DFCby8wTWd?=
 =?us-ascii?Q?BUXVBgPIaYCx+trNs+xvp/EErpsZ+TwKfdDEwnA8m2tIXoXNeXdCYuD9AYgT?=
 =?us-ascii?Q?ozXwKAAUITsewO58nj6NK6gpBDI1I5EnLkXssyNEZJfa/o5VaHLsQxi0ZmCq?=
 =?us-ascii?Q?s0oMGPuS+b5wHhToO/uNPS0ruOpqQv8yXB/9uX5rFgnvlPKEN3LAvpDyXMPx?=
 =?us-ascii?Q?o8ptj+ainY9qEpTO+s9dYDMBVnUBaTJQlG179cFf+TpkrsCTEpwM3WWHng8G?=
 =?us-ascii?Q?ezSr/CT4d4C73yjru2p8xEHaUfYmwLu0QQEDTxPTVYRSiIUvLDyvLKh1Lxu/?=
 =?us-ascii?Q?agzeQ4Kfc+CxHKAUdL701gSYa/FlJL5iLb3Q+/GZAiF0WE12AYZiH7/qIJ7H?=
 =?us-ascii?Q?93Hx/oMfjSG6xxfF/RGnXSln75uPZilayjgSoydl0Rpm0kba/i9PAQABMcOd?=
 =?us-ascii?Q?gLzjflc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:17:34.2509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea71ccc-67aa-4665-e85b-08dc7af00918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216

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
of cpu clock will make a quite positive effect to improve PPW
on Dbench test, in the meanwhile, keep stable performance
on Tbench, Hackbench, Perf_sched_bench and Sysbench.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6a342b0c0140..aa157c2b8ba2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,6 +50,7 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
+#define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
 #define CPPC_HIGHEST_PERF_PERFORMANCE	196
 #define CPPC_HIGHEST_PERF_DEFAULT	166
 
@@ -817,8 +818,12 @@ static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
 	u32 transition_delay_ns;
 
 	transition_delay_ns = cppc_get_transition_latency(cpu);
-	if (transition_delay_ns == CPUFREQ_ETERNAL)
-		return AMD_PSTATE_TRANSITION_DELAY;
+	if (transition_delay_ns == CPUFREQ_ETERNAL) {
+		if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
+			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
+		else
+			return AMD_PSTATE_TRANSITION_DELAY;
+	}
 
 	return transition_delay_ns / NSEC_PER_USEC;
 }
-- 
2.34.1



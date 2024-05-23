Return-Path: <linux-pm+bounces-8070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E48CCC2A
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 08:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C398328399C
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 06:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65BD13B590;
	Thu, 23 May 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pDOvOiG/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FE13B58E;
	Thu, 23 May 2024 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445087; cv=fail; b=p0yxxYtVgJe1HuLO61n/ZC/LBfK4brM+ideZD9kWXHmQNTwF+/7/ju3idDGHgBr0jBYsdrmugIcGmP2+cfW5TtjT0m7K8lzRz5L2TW6ng3nKOXxLBvgZyk0G+F6iGLRaKDdWLeZIYyXILljTFEzvvLVze+NYTadKyev3WPMLLBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445087; c=relaxed/simple;
	bh=5W450A4OA/tDPi8v3Hq/hsuNj6aqeScgGT/+R0I2qe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIrml6ekXz+6g2XIpHulXqV+UaUeTaEBDiYZTvcgXly+di8SxeRNBVHb+kn/eC+z4/OeS1Fnz7zZTo9pM4Z4l96vtkZoSfmCStZRagLIi8S8J/H40LP3ZZIv7Gju4qyE3MbBlw2cEGzb6yIxjZqN88O5n/uMFZ4e4N+cuEJUvnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pDOvOiG/; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTWcwJZPDNoQRKzr3YRqUxgSO4MLlXVwq5IxbeC0n/ZprRneBFpZ92FdmwhSJQ8Du+KpjI70HZJilQuBnjgmA2NpaFsvr1R4ceUmSK0ubOVAzmfp7SWr99f8uvR8ckTSAFGTNWy+1iOkZBEHtRxi3ffzTNKRRT+fnc8uomXD49WErgxVxqQ6JRLa3WSpls4BZ+7FfkwB4mcSwGZDqQF6YvQj6a0qnVL2E5ZqrUv1RMG8jnZt+r0kYpGW1QlkTtEhLzzThOq63QMA+DMmNEG5Zqf45qCuaMK+wpgf2a7CFCZdZy+eHe8T57eff7bTlUymnRDmC+7Facz+2MkAhDpHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYADc4a0EGMHe4KFR/rNv9z2oEHxbArNMIpqnfe4MIM=;
 b=hoJ+Ueknks9+L3U9BWbajOEqRxa0PVAtS6t5KhXvh7OAoHZuo3vsQnIOj0XzPBmnS8Bz5EaqbmJYVypMRl407HUeZuLbqAFpje17zQnr8aMKh0xe/Fvcqk3MAEjYkt0kPZ22hmxqP/wZq29ZGNAiNqfduz2oGdfx1/dKxdgi6lkJFtPuDurivl6rSPNDzC/5eNzgDw6xRXyhYPO2W4299G5PfcvVyLK7x3VypuCgW/vZoe2YIkmxDpVC+Ai8oSnv6xaKkxZ1wIWgQH6YZOeBBqTd+k78z4Bjmd1LPtJPlbEnNhl5Vg4iQA6nQ3dDc51xMHnwsb7g+yTZtTNjxCkxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYADc4a0EGMHe4KFR/rNv9z2oEHxbArNMIpqnfe4MIM=;
 b=pDOvOiG/bZwvGohKjemSyH1B3mGppTIX/mmBlyrV/HFMnYbku6393brxPF0qw1EL2/id3fUZtccXJ8dRljg2Qe1TqKAtDyUiGoPOStlavCoq78S/MUBR8TlTPL0izh+vjWz/Ki3KXBOzmIZcPgXnTfZb92eIdCcMidrUYB4By2M=
Received: from SN6PR08CA0002.namprd08.prod.outlook.com (2603:10b6:805:66::15)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 06:17:44 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::56) by SN6PR08CA0002.outlook.office365.com
 (2603:10b6:805:66::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 06:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 06:17:43 +0000
Received: from jenkins-amdgpu-chagall.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 01:17:38 -0500
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
Date: Thu, 23 May 2024 14:17:00 +0800
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4daefe-1110-4513-dfd7-08dc7af00ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?li8U8onfKIfhS7up2HIT01wkzqfuVsYlbvLOulrbRC+77huuMsTY04SQEwDQ?=
 =?us-ascii?Q?guItoLBA3w4TJLnGO5UNKN4NfNk1oqQVRe4EVDPTFDDnly6qus/t+P+7lnJ3?=
 =?us-ascii?Q?c/bArlpb6+Q8rV2W9DisqVlJ2mCJzXsfR/gxZDBAtHJfu0nCERrMkNevPo6n?=
 =?us-ascii?Q?5RouIwNzO6A1GoXa4eYXSMVPPXgzdEVoj8+EN4vjfsOSIuvGNoBDaDMSgBnh?=
 =?us-ascii?Q?kZOVYSre8tZiJnugnvhomWPdS1TyCScWjqn1ie6P9KA+XTE1vrynwxsAXUfM?=
 =?us-ascii?Q?qlyYAsRZ+rlelIXzLoFrquD4L34ezPQa/RPQiz3tpIUU461L76UjSiv5bAUh?=
 =?us-ascii?Q?T4UwSFFF0SG9XSv+VX/53xdoI3IUxJbgmXt+X4ppRU2qc7d2xAF7koRym4Fm?=
 =?us-ascii?Q?fouQAGxQVIKPmxEcCuaPVJ4ECt/gRr/6XnOJki9XR7G756sddIFiER72K/gj?=
 =?us-ascii?Q?uzTvSrMTmTx7bTR3op4jDI3JiIDVZfyzfzagkL/pFjux5QUnU+HHeT2ZXB6O?=
 =?us-ascii?Q?gtK6JUueqidtxZpaDCzFi0QIv3mth5gw/2WFxclBnJeXxKOvwFL+VJTNn5z6?=
 =?us-ascii?Q?/QgmKT43GrehM+rhYX0In3dzj2H4/qSQEJZuAO5KodGHmdzhOykSQNsH/FVv?=
 =?us-ascii?Q?SWvBMbXMqKX0GRH8fKRP1ppJtayNz8mZ8LahLNJBAhjpPGV/v3W4gGSbE43s?=
 =?us-ascii?Q?GpbRj9BfRPEh7n0lW9R2dLZYwptk/oQxz6kKmFtRxcLJJvc0KYcyk54uGi0v?=
 =?us-ascii?Q?hK2OgVk266pwBL5jNvFbzNdEwiO1T7PQz98DgzRBw0xuTX10FCYA/22zTImv?=
 =?us-ascii?Q?vhjNiu3SK5m/5sqooVv/qooPyvAWOYZ1LrCbpzY13c8m+Q6EcX9d9Sa+dzFa?=
 =?us-ascii?Q?ZVLYeAn01tEBN0vxcpb11lLay3hCamrrH+Yz+HCSDCqSwKdij1z9xbqzkFdl?=
 =?us-ascii?Q?gWCLrBt6s1nXOGZFDtXTAt13QTk9qH7B2yMvi58wXII6SoMQETyYnxinwuoZ?=
 =?us-ascii?Q?dkLQgFte09WU8+ce33xik/KBr5xTp5DZXriwYSvKHGTqBWrIaoQhrHfFBAPS?=
 =?us-ascii?Q?vgOH33XLo38wk5R+OplSzx1HsRypcvyemojN7NIJmyhGfgK/u09YJZToZqP+?=
 =?us-ascii?Q?SlSdgQzcyK7VcQImUHnDEaUka5P1B1/3z0SRx0XREHPwEjQRvoIf69HWKzdz?=
 =?us-ascii?Q?IK7FbIfEnLwzp/6LRshmRsX0/tehBg2nPVXeVMOi+yxpQRv9ZkzglqTIKzwf?=
 =?us-ascii?Q?2fpBQowdEEnQu2OmoNAVEmyMKrtQpcVXYn4S2krAzVZCBgz5cKOdeOCA3idr?=
 =?us-ascii?Q?wUT1JohnU/EeGd4/Un7y5eIudkFV/o+eT4QQbmVp3GQu++u0bfxcPo5m+SFD?=
 =?us-ascii?Q?qgHpz7M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:17:43.9828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4daefe-1110-4513-dfd7-08dc7af00ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425

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



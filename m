Return-Path: <linux-pm+bounces-8037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A788CBAC9
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 07:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0495A1C21593
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B978B4E;
	Wed, 22 May 2024 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jp5oWady"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BF7711F;
	Wed, 22 May 2024 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357062; cv=fail; b=ma/vylIUejQxCVWSNRwmUOHlARtP5ax4J6rDbtPmWeemQaKbfxX2iMTyRpuL6Uo+1Zm3Q44OXU90cEf1oJRyyg9efk2NSRIpMgXweI/7GgHifIL6UOR+Jn5BQLRTSac9S/zUmO5l+oEXGaogEk9ih7CepgQiJZZzLtUGP5ooICQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357062; c=relaxed/simple;
	bh=h7xIJwYvmZYf3zFG5i2EKEE/MZH6cjQBgRNVi3fZaQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXIJvc9/kb/cfilnjRmRJ6R13iYKlBSxQ7kkORtXFHqcsxpAADfq5jSKg9highJaH9JLxLR64lN7U1J5rAVtok/zyYyDtaamS9OOeAFnzNxnSmjPugo7AONgReeRhewCTkIiTr7GMGkwIf5vwfBhwyTO6iF6LldAVV4m6hmUi+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jp5oWady; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCmNxv2cZ24VO4rnun5cRgHw2DbeouBPZWj4iEPK3CaF7Fv6Nu8hcc1hesnZcOdYUF1rLATYneCCWTbP2Bv3blqzYRyuTt2tBIuR4IydsHq1p9WIPVOSG8ty2UGf0oDvDDLCEbAiKfJDql205qmXFYN//WiOfUCBUNngR9vuFU+TQyGBaFIuC/tCgBrlUUBJbeN9InDwTwgDeTi2mJP8avSPsfzNUg06KbishdRwbvNXP1FbkjRmV9LenPibvlH1YpoxbgQxSXw6JH9gL8qUMwV01no+FW7qGYuyGMz03wVjTh+JzkEK7UR9VoPSCf+yQK3sP5a79sGXxjm69GEL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFXrQtIlJQVGuELDSIRcwMxnUOQ6bV829Bc8t3wz4Ho=;
 b=jrbF0A45Awo8/G7+My+Npz3WAzou01aTZ5HdRv6oxZGOtFommsAHJ5nRdK5PknTMv7Lkw/braHZxmQiEUWTCowkQZ9IVT5gohzENmF3cAe4hbOZ6a5LCdzT8E4sW3rkLXeDN1PiSSsTc1mfKaTvzb35/P+Dom2jr5pp9idwkgP5+6URrxKB8AlAkd7jVxOwekItoAzes6AwO/1GMbyEbpW4Ce423k/yL1Q+EOHgkBuB7eMeLoO1x4iD9DP8943XFDMny+NkSwXk3UQFObOJUj4EYHXwMXv0l4UnVz0sySd7VDCdQE+6jQcrGrB57yn+gXVhPC2ZkRiRUWDGWaO50sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFXrQtIlJQVGuELDSIRcwMxnUOQ6bV829Bc8t3wz4Ho=;
 b=Jp5oWadyIqqVshi50AihvBafs8MCMt6UiIgLExrPmBAGsMYLeJ2LewgPFIEHiCiT4HmvSxNNZXVfl8PU0+QysTNyGEhaAvhBqi4aAMQw4tqrCY8TK4pztE0tAyY1/9US8ldfXGwHaLxCkgryfiQR2OkrsYHxiV9Omcn0mpgxwwM=
Received: from BN8PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:70::35)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 05:50:56 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:70:cafe::a2) by BN8PR04CA0022.outlook.office365.com
 (2603:10b6:408:70::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 05:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 05:50:55 +0000
Received: from jenkins-amdgpu-chagall.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 May 2024 00:50:51 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <perry.yuan@amd.com>, <x86@kernel.org>,
	<ray.huang@amd.com>, <rafael@kernel.org>, Xiaojian Du <Xiaojian.Du@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/2] cpufreq: amd-pstate: change cpu freq transition delay for some models
Date: Wed, 22 May 2024 13:50:20 +0800
Message-ID: <b2c8fb2da41f9fb21f095f67d99cbdbd0aa34091.1716356681.git.Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <691ec6cf79788e6db919965f787505434b072fac.1716356681.git.Xiaojian.Du@amd.com>
References: <691ec6cf79788e6db919965f787505434b072fac.1716356681.git.Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: c81282a6-bbe0-44ff-8319-08dc7a2325d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|1800799015|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gMoBECll+6K3zSCyduAlevdB1pQMMmw+GssPpenlgTjTsG0uDJwoQKDJGr4j?=
 =?us-ascii?Q?kzSpvwGjZBzgQlr3umI2BbRbrP/hhMAIG+Uy38Nn5vyS1KR6+P9amY0EUm2q?=
 =?us-ascii?Q?KrBCWEg8VPqIcOxg5ziDjTZ46sEe8+kcLyH483wRFlGC9na/YJkVavhG/Ef6?=
 =?us-ascii?Q?8SNwP7S4F7pEbKUG7wBAKS5mncK3xUufbjZt1rga/q8DxkuSIQvDSPnMFCvl?=
 =?us-ascii?Q?birWQ1WmVr2+Gq2IVCEiadbP/KF8MYXjqxwfRmWD5yevhF/L21XPxi5xIGAm?=
 =?us-ascii?Q?PTfib8qyHk2/QBxe4E67zeUhQkmnZyWr4OHMiaC6xscHq6EOgEi4CNsHVVmM?=
 =?us-ascii?Q?Em9JXY5b/Wh+1JFjLQh8W/WKR/v2tTbkTIurq/sCp5vDMW0EflPQIKPyWX2x?=
 =?us-ascii?Q?SCk88uiU3pqQO74Yfc0DE/G+WPAcnXtcDU/XIF8dy8Ss6481MvS5E9ZC280F?=
 =?us-ascii?Q?3nz23wjrqeR0KLJVHRiOaY0ZDmuc4tgw5r1RSGVLfQO9w1Ao1RZxR0F3UNMd?=
 =?us-ascii?Q?GN5x00omBE8mNlOU9IhnfKDkn5BTWWfeJqShz7AWuXiTjdYTNqr2lR0dv3sa?=
 =?us-ascii?Q?GB01RNrXhr4sIq1fgL+Oo4Innfbe5S98FrC+Hvqeg9fyCzLrF+vpS412P/2T?=
 =?us-ascii?Q?Xk0Kd48qzc0bQjIIIYdgv0sJoaZxizY8RHjtt2OG/QQ1D0pgJdgA3NbrGkYp?=
 =?us-ascii?Q?pmSh/cLubcGHwBotAS5NRsWmDhKQ/s9Xk9FU1advx9HonXcSUcBaMYaFRc1O?=
 =?us-ascii?Q?NYZKJlCyt4nQhLEEgcFx2t57qKy56ttCdYDE/lK7Dqi+lq70O6E0paJ+6Z36?=
 =?us-ascii?Q?QpwB99TL3uVbP7qeexlzUyrokJetDjvAPmpXGYZkM977DRybyaXpdYvOHn60?=
 =?us-ascii?Q?/XI+BAVtifR/K+j4KaQiDpbuIFg93xWJWEcNMEEZgiMZSiA30SNhFYa28pkP?=
 =?us-ascii?Q?x7ufixAdvAH+j8PzMOYwAPgC22LxzGlb8ipL42aZIQV4xB83dLyEa6URmTME?=
 =?us-ascii?Q?3gYDfbg3S8coZRTFBuWtgBbgTylBlnT6iBk/PkKz/qDtYLWK8vPCD5GDKbGB?=
 =?us-ascii?Q?OZLDJNdj5A1aSKnTjnf1fQv0lpHKzZdN2FLw9mKZX0iAdb4yVBSJFc63Ee4l?=
 =?us-ascii?Q?S79I5WB1gIMZAEbfQBt3HSLKJLupvvqTwYxa3rrwsw9JHVJD4/ludWGAu5EY?=
 =?us-ascii?Q?zYufP4w1C64PHKwam+Mj2beHe9VIz64C3WIWTuCmjtQnfibtAkSWJcjfDfN5?=
 =?us-ascii?Q?xGSktFAR8zsW2airqfuEyQBz4LCFIVQLBt3fgr1dW7mforcb9tDbwAvezImM?=
 =?us-ascii?Q?3NiPIbTMaG1CCOOcOAmGUPz8hdCtGkKZ2IvTnXucMhwpxsE/HqJ/Vyl0yfSc?=
 =?us-ascii?Q?uvhnRyg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(1800799015)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 05:50:55.6230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c81282a6-bbe0-44ff-8319-08dc7a2325d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490

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
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6a342b0c0140..572064a7682f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,6 +50,7 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
+#define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
 #define CPPC_HIGHEST_PERF_PERFORMANCE	196
 #define CPPC_HIGHEST_PERF_DEFAULT	166
 
@@ -818,7 +819,10 @@ static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
 
 	transition_delay_ns = cppc_get_transition_latency(cpu);
 	if (transition_delay_ns == CPUFREQ_ETERNAL)
-		return AMD_PSTATE_TRANSITION_DELAY;
+		if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
+			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
+		else
+			return AMD_PSTATE_TRANSITION_DELAY;
 
 	return transition_delay_ns / NSEC_PER_USEC;
 }
-- 
2.34.1



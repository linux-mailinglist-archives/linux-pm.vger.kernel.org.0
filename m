Return-Path: <linux-pm+bounces-8117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6E8CEFAE
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A80B1C20B60
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13969944;
	Sat, 25 May 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jm5/bV6X"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1963511;
	Sat, 25 May 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649761; cv=fail; b=C2gHgDYNDf1+SJOwWKhXGRtvS9UuC6FJmR14GRlDhkk+lI0O1ql8QbXiRKl+qpxfADFmzWZTw2KRPv3Rgw+7iA8Uyz0NPoSAlcyLKmNpn6BG0kNMdzT/m718gbQu32rjWJ9R8+D4IQv5vGYfV5rPWvB5IfajYzi40ED+XH+Fp1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649761; c=relaxed/simple;
	bh=5W450A4OA/tDPi8v3Hq/hsuNj6aqeScgGT/+R0I2qe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJqzqp6Avez/EJc413EOxZ0CaufNmArOJJvHSgpR4gVcRKYR2Hv+pPLNmWWdaGvjHSOYe8PbKdyM0enEbdIX5FfBRkwS3tkfBQG9VO1aMSwTPbBejJvJ1N37hF5X5AJBHAyya8VwCRcaI1hksbnySE/dmUzMrXNDc+1feHQiXd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jm5/bV6X; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+tAq8wEMpAGFBSguXaRXAevNQXZ3K2+9Uaij/PHxZUb3AWxji/xb5il3hDImhgAbrBHA22njtLFoOuAlyUgTSQZ9aH844PV1STc+XsxNj7G44kuwwU7qVD2nk8vMHXDuYpIIVDIUEjH1DjS4zhX3dOXySqkNZ9sxVOME1/lkv/ws9ygHbUrVIj7AIqAfI4fHFa8sFooCtxr1j/+IAItFEFtSzatp53pKHd2y2fDLGO6/wL1+9kb2q2PTMTEC6lUgkj8TPFgrT0kkg1t+k8KNoxiw2Tkvh5Q5Bh6LM51bkWxunyfaBUNOcGekkyxso1J2g6cCgM8daVhANZ+wcxa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYADc4a0EGMHe4KFR/rNv9z2oEHxbArNMIpqnfe4MIM=;
 b=JlQzNIt/qcFt3w2KGTzgGt7NE44sLlckbw4sl11x0UMs+AY3Totj9uzy2343d162Xh1NnzAy1h/s1F1gj7XDLqltc0sYH1JJYjA/ODJhB5RdxRbJID3YN0StgDjSlAkQBZnzcItMqFIuVuOpnKWdETtg6IDdj8VCuZeZv+uzFpdsXYZ9zclV7jBy8Hu3zyBkMKgWDF2BrpIDklD2AL7ETUKT6CPN31r0cLbZpg2Zsgn26OuDnz5v5aI8cBwjzemEniI9F6aBzDURgcizpwAR2DtSD8legwcdNKwclQ9cB07scIS2XzcJM4AqeZWyi2mLeb6Ov6kDP3pzOOcnNWCW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYADc4a0EGMHe4KFR/rNv9z2oEHxbArNMIpqnfe4MIM=;
 b=jm5/bV6X+cEDQDUeDqc2K5N3OGaUb3lvT0ZWRB0yYu0UxK/cQsNxbe2pqj55/k0lD3Bp585dNXeEODwVUjml4iqXVa2mtK1Tu+ZS8TRwAm/eaElZmNeU/shRFAKpQgkjk/4SkX9qE13fPiQmCym0SCO50NNld4nUXgDn3XKaEQM=
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.27; Sat, 25 May 2024 15:09:12 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::5e) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27 via Frontend
 Transport; Sat, 25 May 2024 15:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Sat, 25 May 2024 15:09:12 +0000
Received: from jenkins-amdgpu-chagall.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 25 May 2024 10:09:07 -0500
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
Subject: [PATCH v4 2/2] cpufreq: amd-pstate: change cpu freq transition delay for some models
Date: Sat, 25 May 2024 23:08:44 +0800
Message-ID: <e37a5b6f2461d8f86a353ed6cd28edc3db54896c.1716649578.git.Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e717feea3df0a178a9951491040a76c79a00556c.1716649578.git.Xiaojian.Du@amd.com>
References: <e717feea3df0a178a9951491040a76c79a00556c.1716649578.git.Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ce6790-8223-427e-1482-08dc7ccca2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PAHShkiOQMfngff6UMaEI1UF3Fun8GGxAl1kM6VcolDtxRzU+o5iPkopR6Ff?=
 =?us-ascii?Q?DZBn3WNuAkDIPRdkVj8gnUXQNYIFWE7UUfHuH+ZzY1QgamN/iUaCJUIjgvup?=
 =?us-ascii?Q?zFZ0mHnCsPmjSCxUWszhFaKIpLaGW9NdDzkunMkK+0ZNpheQ5xrXYorc7Sog?=
 =?us-ascii?Q?CS2Mc4MOIkh3ZP+ENORS+f4ok1RpG6zKLne9CHZR1MR9FmHGSM/Ch7taPO8k?=
 =?us-ascii?Q?q3uCGdDGDZMFVXbaFi4wlJsrzRxyx5O7sgeHwBzkFeCHi2dlZNZ/rzbaLc+N?=
 =?us-ascii?Q?GnBxKU5nO2lj7CsV2fYZjhsUFreTQCqajzOpieobfXXrhdDAMr1FICAgr7kB?=
 =?us-ascii?Q?ksiqaLgK/rxuM+u5ARdpGp/9pkWN2dkzzKoTNnRNP6YqVtf65oIQh/WYdboE?=
 =?us-ascii?Q?pBMWqduBgxhEF3Y+QNwbaU3cu7Ocx1h6jYFCIZrp8yqeQj0Ue+A6MQbUZHNZ?=
 =?us-ascii?Q?9iGY9h1KtVjnM/sOQkU5Mtz2ESRMa08fsKAOx0kjHzF/OvRyVi3+CU5qv2C4?=
 =?us-ascii?Q?BfHHzYnNXcWNoztzdQxqvObwCHDut+H751lEAS0uxTGGQZuEJ66AUUss5zfz?=
 =?us-ascii?Q?9q8TVFVBQhZFLc21Po2TZyk8ljgh+/BlcTJ3UTCFw/ChWb6WpqvIypIq7MtT?=
 =?us-ascii?Q?fHYxSHLNrmgVSsIqsiDwjjgnN8Vp9ReGpl3h+vMxAHRlEwIHGrtYOUoyr6+s?=
 =?us-ascii?Q?nnOR4X4aQswYNdh92PqQ+IdSsTtihk99vNuVrxM0IeI06o+hG8U9hJfV0AwI?=
 =?us-ascii?Q?PY2SRzcjRu1WGKgZ4to8fP0A6m9K/5Vhakxj1SO9Nzp8+IKR6dcjsQlBTAaw?=
 =?us-ascii?Q?rXjoCUwAiBKEFRLp3GEtI2ziLb4n/VLpGW7UAt7bGPtY+8Yav25LXDRkXyZ5?=
 =?us-ascii?Q?s6w0Z635yOJk5EK+dBy3DjrzZlMEziUs8WkFX2u35JF1ITmpNghLUbCZhCjY?=
 =?us-ascii?Q?EVaAtqRtb7Y7cIMRcPWxe2dkn5BhPwX1SkC6RYrMX/bmMqCvcQECKl6uO5gm?=
 =?us-ascii?Q?zc830wkhsLq7t7TkyQBMsm2B/4YmIFA7mOKM56F66iaQqkMXYZ0HPFOYpgsS?=
 =?us-ascii?Q?a334HGwo1et1Q14ksqhhjk0pqFUK0xA0+XAoyn36DtVEJp7i3Ha4To8hHDXV?=
 =?us-ascii?Q?5tT0GEv/Ckhj9U7o5wnGUjXuyiC2+z3k58vLrkkIwmb05/UObk4WE2cgXeQV?=
 =?us-ascii?Q?haPV15cY77zx+xiQMQ2CqLnkUirvhAf7JNfMbDwSFSoPCSVsBVBX++wBs4MF?=
 =?us-ascii?Q?V3QPA4RUf/9kSk9RSXkA6k8etEjCeX3AepkbvsC4QKD+EFhPrw24C/AHPAgG?=
 =?us-ascii?Q?Gp9EOOWG1aE33fczMuSV1A83R+DCJ3Zvs0fZFvkxYmBYXnEM03tPWIDJ1Ojj?=
 =?us-ascii?Q?MrMBCGk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2024 15:09:12.4787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ce6790-8223-427e-1482-08dc7ccca2c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125

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



Return-Path: <linux-pm+bounces-7599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9558BEACE
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 19:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6150E1F26024
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7CF16C854;
	Tue,  7 May 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bsGU1B+B"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0915B12E;
	Tue,  7 May 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104124; cv=fail; b=JIY6AARy6UfFKU4WzWU/qGKFG48zcdV1T9GikXlgJfw3Jpn/pBHr7N160LxyIFSj7P9g5wddwZEz9KoasrODM3hBGrXFBR/TBkObUW5HU3HW1Il4+DSOZmiyXnMvxFOkSn9tu/YMf+FiEOLvTQZkmQ7XmramZtJaNxSLV03ZhKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104124; c=relaxed/simple;
	bh=4K5ZdOocmCdFISI5RBbWdlQ9dFAf9p5UjD/lzJuUWo4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cvTqdWApoHp1PdxDAzMCps+y4vGXb7uqP1Uzfck/DOrKHJkU5pXw3wyq46nj0X8lzjNlT6UIqc90IRzYLLCNzmP2NE5bSincH+WZl/QnKeTNDEaQlYCsy4vQiilU0RF86UJGRg9rcseeFG3REszGCWN/fbJzaH2Zhr2bHZJYvuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bsGU1B+B; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+Mz51Kjd8iaKj/6nqxBGhL5ThqSCMCWHMZSu1ijJANS0Cja8yat69KAGLTOeEeKZbHUsmu3bueyPUFgVz0xpsD9JpNY0MgaSWFVp06Levg8jA3ibeCH7iy0/ukkrHLxPp/PMlcC4hUnDpQAIts22JSwdQ3Gg3LZdusMh/KfhdZ8lfT8RN6z1zCBMVXlav9O/caDDwpA2oF7VNvu/RJ/3kPr03WNpUuOSo5tyw8jylvPvndYfKKFWqVHFi9sGEq/VVOkBkMo5sffEPAsvGnoRXL0IiV4hMr126j4Wceo7S2tCo6OBonn+FWUcVJWBrFwk8N65CV8a1xtCJStIn3/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vO4I2Ov3yX0hzquSBknXcKpIap6ggnm541Q9PA30iqs=;
 b=LH3SLEMSv9H3TLLc5amMlYRwNOOZuTjD86fWrvUCi8S2XsJ+5nhjme+o/MiROkpJK+OQQDLNAMSfJ1UwWVlCwNR4ddBeeWTQmiHtKKjfLKrZqZ+D+lhbed8EOFaXHZ3a0UU4Ic0Iu0QF98UteWdiv88ZlWnlSxCX2gEPt7JoH1Hdl50FmpCE7Nt2XXk1hrYevcrcECq0UIlK4BLUPIbdWqx6H+tRnudU6Z/4Zq/+FRlOBYq9t/nhWR8MsuH/Hm5XE24AKhWLP1/oKudL6pq0gDGX4vwhDGZkaror1y9d4/9ja6Mg+7IInxmq6BzSCLgVTPSuvOHdhPSQPfbcVe+klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO4I2Ov3yX0hzquSBknXcKpIap6ggnm541Q9PA30iqs=;
 b=bsGU1B+BmMrhEJ45R1mJ2/S2zaq514fglGf5DC9ON2q+ZHtPE8d/F1610bN86AcCHO8FpA79R+AF3zhyPnWw3Ep2DwHB9ZZcwc11XDkTN5rBqjg58URmRkOVNuExNqkO0KLic4yI4CEszToELjinIe9cuic5V/Yj9zbkfD4guEA=
Received: from DM5PR07CA0095.namprd07.prod.outlook.com (2603:10b6:4:ae::24) by
 LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Tue, 7 May 2024 17:48:38 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::99) by DM5PR07CA0095.outlook.office365.com
 (2603:10b6:4:ae::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Tue, 7 May 2024 17:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 17:48:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 12:48:37 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <gautham.shenoy@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<regressions@lists.linux.dev>, <rafael@kernel.org>, Perry Yuan
	<perry.yuan@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: fix the highest frequency issue which limit performance
Date: Tue, 7 May 2024 12:48:10 -0500
Message-ID: <20240507174810.46709-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4c1114-42d4-4877-3a1a-08dc6ebded1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wc7Wf2AmPYwtuwsRuWNC2T21qZJAKiceByUQIoTY3NB/GU6PJMYNtGF87N7Q?=
 =?us-ascii?Q?8Xn7SF0aLFcJBmeXocK1VaJZWPrwY+tpkRYFkhguDDKsYfTIA/Jx7xuWf2ec?=
 =?us-ascii?Q?tCMwAgShqCsCUBYsjE7kxvTq2l3iE/bXYOZA2bretMZLoHiv68xWQnD1+ztl?=
 =?us-ascii?Q?WSyYQoYhtw/X9vO4aHeEmB4PxgT/kpAKe77sylMUkjI+AmuJ24akkSzjTmwO?=
 =?us-ascii?Q?fZ4Mhx/vNTdShvQKLtekQelXTQ8EAMp+S5HxScggEVYuK8VgwT0SmartS4BG?=
 =?us-ascii?Q?LI29aDsKZBOAM+pShoq29ELZsLL0PlnaM2J3doJAUtLoobFJvDUD44WwGWuM?=
 =?us-ascii?Q?Dk+TJEIrjANMN6PlN20JCoX+xItlXd8rEAFU8Zf8lwguM7DvJ7g/5UIWS83i?=
 =?us-ascii?Q?7o+Fb6PzlstVf2Km+cWiHNrwiRtO9gtthJI/2ND1phH+qFo/AB3I8jSYQYRk?=
 =?us-ascii?Q?scWtid07lIFtguG0ZHWHEUJtgNiJ1nZOkNbgTQCBUiD5x32G6NWTWsR3a9eP?=
 =?us-ascii?Q?nzsHWYWwsJf7MAlM3YwnTQyzr8gcmC0QV0vawofmsx2UEGrtWalIufKN2O3C?=
 =?us-ascii?Q?ZaTUlgcrMMQIjoGKXl2AH1Ut+dJJp0ll2ujs2wCF+xps0rdqhPnJviKLqcW9?=
 =?us-ascii?Q?QkK+ZfvBmiqfJG5BwRwtaal5bMxFFlxAGJij1ngy2xD/Dgr2yR6X5f3lTtlp?=
 =?us-ascii?Q?0Z796WeqHTDYkRLoDD/I8hoNcbOuXqhV9zs2z1oMiJPnLS5a7TIqJhMLWgXp?=
 =?us-ascii?Q?I6iEga6J+O5fL2E7EKXK3Er6h1zNbAebc6aug97cQRwOtEzTzkOlDrVuVekX?=
 =?us-ascii?Q?gdqZeUQIPVaadzhFQJz5hgLqOnvXElAYLJPUMIVGdtTLnPJrKFXH9XMkycl7?=
 =?us-ascii?Q?4zclNPgcQdUXfw+fD77l1YuOR4TENNjVXS5ts7u8Sfhz9MwV0+G1wwGXFYDm?=
 =?us-ascii?Q?dWkwj1iLk095N0RAGkw7rB1/2fys62UUKyrT7HmV1JBuU3U3rn6/vcfPtDJz?=
 =?us-ascii?Q?Mx4iPTJMvs3WfrkztKC5q6/YufLfHdx+Nat025FcmSmYJlhjMC6I/dQDEE73?=
 =?us-ascii?Q?twqeuDuNJ6wlhJxJBd1RqGqVb0/kKP+nNwh8qnCp/O/QEaxAcEDkHur4tra7?=
 =?us-ascii?Q?RdCqDDWfI641PB/JF8Gl0dNn6u58c3Sc1Pg6mPPGJNXYvEeBGbtRD1144k/N?=
 =?us-ascii?Q?svMbYm02adIZbL78weXvBaYEtOmeDqxpdDyyDrUzen9z69je5MouNZxpBupY?=
 =?us-ascii?Q?5gdrOWO2SyZjrxqyCvp2z3w6q9PM6TOMeb4ze1tsNDmIyZn0krmCGbctELHA?=
 =?us-ascii?Q?HJyKlvxFGiEQ4AppNoK3nTKzbp62jkIQMIdBDp4jXSn3mA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 17:48:38.4951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4c1114-42d4-4877-3a1a-08dc6ebded1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821

From: Perry Yuan <perry.yuan@amd.com>

To address the performance drop issue, an optimization has been
implemented. The incorrect highest performance value previously set by the
low-level power firmware for AMD CPUs with Family ID 0x19 and Model ID
ranging from 0x70 to 0x7F series has been identified as the cause.

To resolve this, a check has been implemented to accurately determine the
CPU family and model ID. The correct highest performance value is now set
and the performance drop caused by the incorrect highest performance value
are eliminated.

Before the fix, the highest frequency was set to 4200MHz, now it is set
to 4971MHz which is correct.

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
  1    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
  2    0      0    1 1:1:1:0          yes 4971.0000 400.0000 4865.8140
  3    0      0    1 1:1:1:0          yes 4971.0000 400.0000  400.0000

Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218759
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This comes from patch 10 originally by Perry in [1].  As there is a regression in 6.9
it's pulled out separately from the rest of the series.
This should go to 6.9 final if possible; otherwise 6.10-rc1 and CC to stable
at that time.

[1] https://lore.kernel.org/linux-pm/cover.1715065568.git.perry.yuan@amd.com/T/#t.

 drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fbe57d356ee4..4859902eaf1a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,7 +50,8 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
-#define AMD_PSTATE_PREFCORE_THRESHOLD	166
+#define CPPC_HIGHEST_PERF_PERFORMANCE	196
+#define CPPC_HIGHEST_PERF_DEFAULT	166
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
@@ -264,6 +265,21 @@ static inline int amd_pstate_enable(bool enable)
 	return static_call(amd_pstate_enable)(enable);
 }
 
+static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	/*
+	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
+	 * the highest performance level is set to 196.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
+	 */
+	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
+		return CPPC_HIGHEST_PERF_PERFORMANCE;
+
+	return CPPC_HIGHEST_PERF_DEFAULT;
+}
+
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
@@ -280,7 +296,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	 * the default max perf.
 	 */
 	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
+		highest_perf = amd_pstate_highest_perf_set(cpudata);
 	else
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
@@ -304,7 +320,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		return ret;
 
 	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
+		highest_perf = amd_pstate_highest_perf_set(cpudata);
 	else
 		highest_perf = cppc_perf.highest_perf;
 
-- 
2.43.0



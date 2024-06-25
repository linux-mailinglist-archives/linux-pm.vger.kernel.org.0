Return-Path: <linux-pm+bounces-9951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EE4916949
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D372D1F27F0B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B460B15F31D;
	Tue, 25 Jun 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lag31CxH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED01E494;
	Tue, 25 Jun 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323209; cv=fail; b=qB3uagCNjYH4Edh0mhMvUyksOxcUg1yL1Wz1PrQB7Wcfzx+UfEO6KVsIMz3pGUzDZ8C3/gPbaxSkTYxP11d4yV04PVdbUAj93vGaTeMEovxo28YuYOcPpmo7/ZlBYS0LBaxxrkAJ73bjmrQTgtzahrb5fgw4n6ZC8QYGguGxQt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323209; c=relaxed/simple;
	bh=Qq7d09J/b+DDoAFofk/vsMwU3bWbyXrI87WsVsGmF3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ae9a15/hNzehyTeHWbPA7ItW01Nuh+ln4JuaeRv0T7y3J7UIhJBwBjJaZLTrj4lymDLylQSojgFILRq74MVZ616WLvSy4OtaOOuhhE7P2nos4hhz+aEovPIiiMoHKU7w1t+OOlDwRxTrpedInaho72+2xmAKjQ0L6PKSlsmUcVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lag31CxH; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D73Zve4lBzFaP/oOdnEa+7R9HS1tBN2j3Up4ss3ZTlHjePkmkPiPTBC3pitI3ePVqu/mZUHQCBksUA1/I+z1o6+FATvEAJS/ZwmtgFqbutmB9Tg9LGITRxKYCynOB2HanFpwvKB8ERITQWooExNDnO7pwMRhOhM8tnlpsHEtt+KCZDE4SxFT/03K77RP64CGFHeALEwON3k59XQzo1jpJXgV2HeQZMF9kdSjcBVfeFaAQYGcoB6Si407c7urW0GX6TW8xzKm131kDHaUxyo+GQ7LBRlmdWwyV6jfwLShKaDi7TsVucG2MHa67PT8UwfnwJdfRxltBji2Zt5HPq1omg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ7mF9AKNAfuEOouVns+sC4bViFPyA93qjge5lXmRLM=;
 b=h6V1DgV974kBPnH1kAT3jFJUdCczv3OtIn0J1uNN/LfHBAk2N8iZnu1/9O/Y9a9UdeQIYUcG2RAK8OM83W6tQIL/srsxY7Q5jPitXAQc8JHvzcMNJZbMnHpFmly/EbZ6pKdBd93FGDTfEOd8kpW5LW3QCESguM5gwHUs58PKvMUoPZCdmR0CWkgHxQhP5UUQ3ZaCGHsuZlCk0h66MGIe0+JDb8bskxFGUSKqaTIVR6KvVekiWOrFTH+4lUJZMwMqv2RYsYcscq26Ef7icdNNNEnJEGk54nFrkZf8qHbAAzW8An/ifXFAc+WSKwY5err8oANorZcCuAPzp3rF/7bAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ7mF9AKNAfuEOouVns+sC4bViFPyA93qjge5lXmRLM=;
 b=lag31CxHNcovYE07LnGrxOlOREoL4JnBXXuqX3MLIviS/X1StLKPNRcwxbD7DdW191Y3FyTMlcwOTAiJOmAnc1TNzZAfO4DDwh69USNJV+ztkYisSv6kOX+ES+MhA0rktdY/fkaj/KQtXSrLmn96v0TqdXjvdyF124n/u201+5o=
Received: from BLAPR03CA0158.namprd03.prod.outlook.com (2603:10b6:208:32f::24)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 13:46:43 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::a8) by BLAPR03CA0158.outlook.office365.com
 (2603:10b6:208:32f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Tue, 25 Jun 2024 13:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 13:46:42 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 08:46:39 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>, <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 2/2] cpufreq/amd-pstate: Fix the scaling_min/max_freq setting on shared memory CPPC systems
Date: Tue, 25 Jun 2024 13:41:29 +0000
Message-ID: <20240625134127.4464-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: c5461196-f628-432d-68d3-08dc951d3f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O4AgdWcMd4sQqkkLtsXEgUGxL0w+SbvXmMsIR3wc1DxwHXEwSgCGOB++Bhqr?=
 =?us-ascii?Q?yzHX0HofJbozI/MJRcJ4a6WNRStooJyf8+2Cj6L0ecZR+Ue0Vxi47fhznpHO?=
 =?us-ascii?Q?QDiWW+q26rFALmDVIacr69HsDJ1bRYeo1CgiCHlHSBgqQvzBb7kQSolw5k7j?=
 =?us-ascii?Q?RqNqUUyc01DmVH4r75nVlEvW2vLRVLEqARU7NzNVqQaNgknIp7mphQHc3Cid?=
 =?us-ascii?Q?LCG6NPg/Hfz71Fu5Rpp98+6l4Skp+yPRIFnnuh2VV3JuPnkOqTkso5gtzS6g?=
 =?us-ascii?Q?39Y/fNJAL5Tivy84WgbR0FGHyV1pkGyEdWtcOxKnnCkcJ4KMTY/ksmazZTQ2?=
 =?us-ascii?Q?YQXoa6o7iYqq6uEdOQWXrwMBSyut8qrlWZR2azVqayjzPPt4T1oDFVyLV6E2?=
 =?us-ascii?Q?thN/IEsG9UnWb5UH9DApZzucMamWZTDrlOXjlP/j6y8IDhx6DEjkMod1ydJx?=
 =?us-ascii?Q?5IBwn2vv/aaw+AbEA4T6gue7R4fDthPH3UCOvWVog2cra8QUEkzCkg0PnMWt?=
 =?us-ascii?Q?fejuDI9ktrUa5QGu/OBibEVZUPZXTpeXLr18q7qxBRl7WYwIZsekK1DEHNHY?=
 =?us-ascii?Q?aVo4wXtL5pGydD2QVYmFo/Gc0HUrVjifQQg07qyXm8YaHfrULZuDWUxPwZch?=
 =?us-ascii?Q?Q+rLStoR9SEoWsYG5f7pSlqiH2bgaen1M3SnLnovp7pcYm4pZIVmKTFwYsmY?=
 =?us-ascii?Q?BymdOZlRDenGs8BHxz7dTluCigmgql1uVLnpne4JXPSWHw1nwN17+9X2m1SL?=
 =?us-ascii?Q?GyAY7T2y0qbG/XY4vPkD4DOy0fHdVsNONNxaMJAwNOXulGXAPKfIBR1NOUhb?=
 =?us-ascii?Q?2IPmMakJgCyWr+Xuzz3Y7uyMkUH7qL9L/FJP/ABs2jwUiz7/q7bDy3tP+OTx?=
 =?us-ascii?Q?EojkXWsCCyf1QH3bn57nE9xETbFL8cUJf/5m3y0F5pT6PXy+WM5IqeGky1hE?=
 =?us-ascii?Q?Xt6RopDmRyRygqlB1Gyr368/Q6DodcoRSLhL8+ECj1lIC5oP2rBNWBg2QKgQ?=
 =?us-ascii?Q?RhGYFpFrlJrh8wnhXfxv/SQkv60dVj3uEbNEJJNfetX75bAe6XpDD4n7BlAh?=
 =?us-ascii?Q?qK07IOP47nebPwA86Lyoy3mo9zuik5e3qy+FJOUGXjmM6EzTYCO8d21my7yD?=
 =?us-ascii?Q?rLUu1TjCutsu1qMS6OaM67kJKjucxdrqWgyXaPkeyRbIFKb7OqwyqFRZ3/bo?=
 =?us-ascii?Q?I8/lh5fCwibtX0B2kHqOHkGLDWvHwecVIkso7uiCyE43rTDObPwjTWLkj6d8?=
 =?us-ascii?Q?hBni3xDKNZPeYMYf+h5LWxIPWK7FtxXCxa4YVQeBrEcZFxNGKeixU3T8qvua?=
 =?us-ascii?Q?KhKakSXUIOdAFxbP0GymCWDGE9gwbCBZSlT6EJKZZyYXvx7cz5nBC1pird61?=
 =?us-ascii?Q?KDVW1dK9zPz0S9ewceCB8woaZ+MHS7NxuNfJ9J0/PyhubAnZLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:46:42.9933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5461196-f628-432d-68d3-08dc951d3f6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812

On shared memory CPPC systems, with amd_pstate=active mode, the change
in scaling_min/max_freq doesn't get written to the shared memory
region. Due to this, the writes to the scaling_min/max_freq sysfs file
don't take effect. Fix this by propagating the scaling_min/max_freq
changes to the shared memory region.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ad62dbe8bfb..7c1c96abe5bd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -264,6 +264,15 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
 			cpudata->epp_cached = epp;
 	} else {
 		perf_ctrls.energy_perf = epp;
+		perf_ctrls.max_perf = cpudata->max_limit_perf;
+		perf_ctrls.min_perf = cpudata->min_limit_perf;
+		perf_ctrls.desired_perf = 0U;
+
+		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
+		if (ret) {
+			pr_debug("failed to set min max limits (%d)\n", ret);
+			return ret;
+		}
 		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
 		if (ret) {
 			pr_debug("failed to set energy perf value (%d)\n", ret);
@@ -1547,6 +1556,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	}
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
 	amd_pstate_set_epp(cpudata, epp);
 }
 
-- 
2.34.1



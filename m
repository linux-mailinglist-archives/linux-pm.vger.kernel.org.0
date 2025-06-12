Return-Path: <linux-pm+bounces-28544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E2AD7051
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D361BC6569
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B62459CD;
	Thu, 12 Jun 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J+UnCYvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4D2222A6;
	Thu, 12 Jun 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731093; cv=fail; b=OLSlUXgQhpdRtr96hAzIebkyD03UOI6xHOpBbwFwh2lPuMlngOsfLi12008/1Kjhgfa8ndbv9VCOmH4IyZaKTRxGayFsTdrfQ27qLckbQ48qCYtbT/x+PnvRYHttCWKpwkrExTHAQOG5xDnRwfVU4sBZVt97cuguB+zIoeWvHRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731093; c=relaxed/simple;
	bh=9U2aLDX5oK++RGFNdxtuhXooNYRu1/Cs+D2OelhBejw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0ddtqITa9eYf6wu4JDXbgo8qLC37dDG9Ae0rDHZe/iI/7kvKKeDHiXG77a2R6X1eNCnuRDX3YjekgxasbXBWK3hNVl90liqv8siTlq/vVfNah34PXaeGOTAKiQTRpM4LavkLGlXFJxHfNUS0fmEYrQgr0v3bb8ZxSDaXPzPiE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J+UnCYvh; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUWKxnVaMu7tL7ANj6AzgqPuGYOpHuNN8zq26Bw3uJbZG9RD9lQDvLxo5x8sbj7Frynl2Esk5pYIGlxr0DOTU1ZSJuOEQXYEcLwYDwdSsbYmq1ChiYYS7N1g4++68+4UukqXRKCE0wFnlDOgmZBP4HNktfgNyvSbAas++BDDlAGD7K57TUh0t66rPvS2cVGwPFkvpEnGFwe/adPEZRmfy+prXREa5OaoBpd5xRb6QcGz7dKiNCqO/j61OmPatozMLMJCboN60/rmk01pdd0803KMR7rkfASosoVPTSEo23kiEi4ZY6FfWuwf0fU9mu6fcmT1DQKEq3RI5Zi9HRmVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcGKVTkt6gV9Ti1TbGzt5QoXBAp3zmSRMgmcIwucWr4=;
 b=VAvXprZFEeMADeh0PS5cHhIgw4lxHeFG5MZm3fLXHYgcO8tyJyQ7Hk3w+J2RUDWwFMgxXBmmnnjHUsjrWcHMXG/njAV9whIajr1HHfFYgOaOlfVAgWvieyHRCCSzLlziDvptxeguoBwTWixYwG6XbpqFj2uD6mh+ajLbsD6NOuwA1cAXnla3H2ZgDYH/8vKOL7dbjGdipStjrWZ8s3Src+BnleJ3ByqyCwwT9vSWYKlAnLM5lm6mKh/G0IlnnYyL4W4x2FAY0CCpvkqC8z0WoKl0EGieW2Fm5CjdNxZl8m7ICs8oOQTRZ1+PNrY8KXekJG0AWsdrGcAsKeCfonvC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcGKVTkt6gV9Ti1TbGzt5QoXBAp3zmSRMgmcIwucWr4=;
 b=J+UnCYvhpzinRHKrVtkV8lwlPc3GSXN7kFAOVupKu0Ub6Jez4h6mk0UUMEHOY66C9yVCoOp5cjAi6RfA3lQmUedDm06lC6BYS89M8naFYtXnHSpuhJ3DPU/MvtRDuSQBPhTKtw02AHAUx7Zr0C5yiB9uHAFkimGErviaICHkacc=
Received: from CH0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:610:119::33)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Thu, 12 Jun
 2025 12:24:44 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::5) by CH0PR03CA0378.outlook.office365.com
 (2603:10b6:610:119::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 12:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:24:44 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 07:24:41 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, "John B
 . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 1/2] pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()
Date: Thu, 12 Jun 2025 17:53:54 +0530
Message-ID: <20250612122355.19629-2-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612122355.19629-1-gautham.shenoy@amd.com>
References: <20250612122355.19629-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: a6751fdb-8048-4450-98b5-08dda9ac1cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CA9SRjM2f32WfbczbYPGNYcgpgYyjriPIapzuS2bSFhKUekE8Bv0F/czvJFg?=
 =?us-ascii?Q?cuydv/On2lwEVCIzSeV/fy14yO8IZXJiWAzOH9dOSToTSirhC7MdP9LbOCOH?=
 =?us-ascii?Q?0QF5MU+wvP7q4f6qQRE0uE2xKb3uit2oKinKxjdO5QGT8lFQ52SMzEqiBnJm?=
 =?us-ascii?Q?JpL7F3GPbquLSSvYxBoT7YGGeFw4sUiWSHDKf+9zMqC2uJzgm1ogLOyv9T0K?=
 =?us-ascii?Q?xFC2RwiAYNSZfXNrr28+iE82yhErq3x2J2zQkXLtyZTLKqL5USVxcfoRsl2P?=
 =?us-ascii?Q?PW47GAb8XaJghpDauoY0Javy/TLqYOryn0M0TD2tDZPAjw55Svg2D+fGKH4M?=
 =?us-ascii?Q?K2m+Obk6FOw3elfc5vLtXp5Me4mimsGlGBtUJ2t4L2M1ZDnUuRzT1K18tIWJ?=
 =?us-ascii?Q?wHjE68lRlZ4EB81jjzB9vsvLFy/GmQ8FNTzP1fq4+nA0Bg9HI9aiFJSXdzzi?=
 =?us-ascii?Q?Ta88G1kjQu92+HqM0Z8+/F7FOXZLAHObcA828Fn+kgaLzOg/G5HqJYWxNiJ4?=
 =?us-ascii?Q?52kP9XR+HCj64tHdUgV4ODNFPAKldUCvLC0wrMmwMBe4BMIdDgh2wKwCYr/6?=
 =?us-ascii?Q?kl7exlGMsIpWd97+EpVs2rRd214cpM/2KfKVVu1BfDTW3zeURq3dCWDbD3bl?=
 =?us-ascii?Q?gzmrO1b1+sidAjceylWiKxW9ziKgoWfKTd8Iec7CBmYxYUF8DdzraCEO8AVt?=
 =?us-ascii?Q?O8ra2vmtfQwKEzMBgYLd1rNWgsDhC3cjTyOr99eS2J/Rou0vjwXnpWBJ4I6v?=
 =?us-ascii?Q?pymWuGILoSCme0QC7stt9dqHz5HD3kaA+m828DJNWNisUy5x7PhnVf9COASl?=
 =?us-ascii?Q?WcTlzWpbjCHJgzUbCx53BZpPyk67WRDxEwKF0nrXTiH7AuGmx/c7YaPRyIwg?=
 =?us-ascii?Q?APgb3CcqLOImAvjXAI8d+f8b1od4G8sNnOVzmvWqSdN/Hk+VRG/RMq71FqUJ?=
 =?us-ascii?Q?6Clw6iUajzn5gHT5zHb/1cg/lLWuHnQjh55IlFkjj60kfsw9B3aujm/Bohw2?=
 =?us-ascii?Q?cBQ6g5qOxxGwqhGA8SECbQFLZCE+8qy46u4F3rXgWVY8eGmkWPgaq0fI7rka?=
 =?us-ascii?Q?JDGXk2x9DNcBseWOUdOaZ7L2eCnbcUjWnT6Vv0I4KfOK+LOaa8QOLX0hsSGM?=
 =?us-ascii?Q?BRihLsFzv5G0uM4Q+LiVp+Vg+MipoTbtm+kDbiP5wLdgQVgOkB3Se+77ZP+F?=
 =?us-ascii?Q?nTXebUVtLiQCu3t2xzbryP2eprt9usBLGS767/vxeHSoFMcNnC6Pjq6HtT0B?=
 =?us-ascii?Q?1qB0pAPBbw7w4iIkcuXj+DRfwg2NCsJ4NmT2hJxm29eR+oxJDWSX34i1F50s?=
 =?us-ascii?Q?9WU2oIPNQ8qSQl85BoKoW7Y0IBwWgAsO5FJeVw0rYACCBrlvU99XCJSboV3y?=
 =?us-ascii?Q?IbmDoYiML5cYqysYsYSSyHiE3kopCG/wAOWnXUKVT9K+cLFCo40LOAU31eSe?=
 =?us-ascii?Q?PM1HsK116CrXssXTMohYbHJkLXBvx2CO8AZ6OYd1CaTISfAnl2zmjTTS498j?=
 =?us-ascii?Q?QfgkDFD6y5dE/VDgl28FWh1tHYjy/+wA97j3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:24:44.1392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6751fdb-8048-4450-98b5-08dda9ac1cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

In the function mperf_start(), mperf_monitor snapshots the time, tsc
and finally the aperf,mperf MSRs. However, this order of snapshotting
in is reversed in mperf_stop(). As a result, the C0 residency (which
is computed as delta_mperf * 100 / delta_tsc) is under-reported on
CPUs that is 100% busy.

Fix this by snapshotting time, tsc and then aperf,mperf in
mperf_stop() in the same order as in mperf_start().

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 73b6b10cbdd2..5ae02c3d5b64 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -240,9 +240,9 @@ static int mperf_stop(void)
 	int cpu;
 
 	for (cpu = 0; cpu < cpu_count; cpu++) {
-		mperf_measure_stats(cpu);
-		mperf_get_tsc(&tsc_at_measure_end[cpu]);
 		clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
+		mperf_get_tsc(&tsc_at_measure_end[cpu]);
+		mperf_measure_stats(cpu);
 	}
 
 	return 0;
-- 
2.34.1



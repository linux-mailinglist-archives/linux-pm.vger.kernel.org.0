Return-Path: <linux-pm+bounces-16983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30249BBC7F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D1C281827
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861D31CB316;
	Mon,  4 Nov 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W23ipBuT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1F1C9EAF;
	Mon,  4 Nov 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742886; cv=fail; b=QehsBJd+io1JL45UUiEORQkrY8/2bnQyyS9exDn8fhWpaCSDlyhiSSA3do+x/GQ8P0xHY9FQGnyRKLHCx5RHCzWliB5uwXE+20NmUPzue2HH+bif/pqe2oww6kCg3MyXJm0+Y0Jm8kTvVqyA0kfjZJCf9UkvSBk2Ic9N+wmsVxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742886; c=relaxed/simple;
	bh=6/GNpT2p5G0nMQWNGh63AxQqGIghyA/swYKFuepemJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZNdFmg4oAw8688yLgEPM5BdUVbLMgT9kMjcJ8Dd+5BTTD8D/KS9UBY7qaYx7FiavKqsy2tTQ2/ysaCz/GARVLbU2lL77E/H02bIOSVcfhtL6zfhdR1YRQrY2hD1dHAeqeGqb5lPRauXbrisUGQkC5Qg0jfEW840RCnhNgCagYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W23ipBuT; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYiMtRoA4VAqCPCeDVH5e4NzZ0nHW+BvqEGN2kCVMm70vKrUhwCpNGex/DvRBNCyJqCyQv+rYLMu25gGemsfr1SsbYQ0j3FU5EngQi1nO5POzrrnpctx1HqrTtKyuhwK6Hay9PJ/pH619rGPLQEhd4cpRBdPh2SwaroI4VSyuJ6FOYgElANGz280MUxif7E0Lq0PWpvYGRtsuYA23NMXhm6yRbDfbKlz+WrH29p4ymrCURwGQbTPF/U1AGBJtMn/ImWAO8xJ/xc/BsPL4CztIH+Z8BY8EPRKWOXrebzCDyo7VDScysrAl21m1CR3c0FeeltR+IKa+66or040sHnQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=xD/OoV0xtXlqbxMB/H5KsiPKjqTskCWrdm+zJwFlpti2F/WH+t+r486mErcUWF7fbGrCnSuTW0leh2r/6MKKct3Qvet4wYQcXvmArqBykAZbwANqd6c2nuPh9b29zaWpcdw0TwkMDNEPkUHQU9462NsFTq5eqi6NMkz4nxtW7wRDFixyAro0ZmJHPYWU4Kxh8C4JxuYRS0DHuirXvwgka2ZYgGHyLsggURsKJNZ/cMVeMvTS6aqV1sKFZLqfGKz057tIJMRmYPJLUtZ8N6Sgol3mFOv6p6m3+qIVoMQTrj2/hxn8qYsXEr60JQTlVpURQWhPTgDgVGMdcZS+hQ4Vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=W23ipBuT+Rah4ejfucqpm8NwEh3I8J8L8EFiNpSRmwOeSbz9+5NwpCGV1x57p/I7xGB6+yrCHf97zLT8PscqJaVuh3hnDC+t/RyVoKgUUz9FCgZB7oVCJyIlXYvAknmz+1LIPe6rRAizNN+urE0Ki6iGf5ue0s8FK1lgfQ88Hrs=
Received: from BY3PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:39a::13)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:42 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3c) by BY3PR03CA0008.outlook.office365.com
 (2603:10b6:a03:39a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 03/12] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Mon, 4 Nov 2024 11:53:58 -0600
Message-ID: <20241104175407.19546-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2dcb76-4aed-440a-007b-08dcfcf9c27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OPvs9pwOJzoYpEOor8mAtdHwL8rQOrDZv93Bq+J1DHoLYbyvzJCqg5Kyk1kr?=
 =?us-ascii?Q?xGmviqE9FCUlG/4RSWPTSyRxN528f3CBFMFOokOqvj8YzXNWI3psUDCtddcJ?=
 =?us-ascii?Q?rfrxjKh1CosS6PwJs14qhWandkhbhhLwZYxM+/zNb3hbBpPsNCHwiXXEYBM2?=
 =?us-ascii?Q?iGwlHKQKEAKJ0SNjE0qLeit/8N3ousYBqZJJfP79u2X9/OAipJNQt6GYUjul?=
 =?us-ascii?Q?WrY+qRhMq+huwIev/evLmt0wr4fjji157dfFbr7e+fitcmgW+A5K0lwitpoW?=
 =?us-ascii?Q?7+CLKjlw6o8m4tyTWyi9BQTrSTO6S28WAkvk/fdmqEj/eVQ5TxU5r5YJEptN?=
 =?us-ascii?Q?iGSBi85Z9Qg2Y4njskVZUZnakU9Tfmm6RkEFjg1iJyO+vzTB4g5IaU2oFLP8?=
 =?us-ascii?Q?DCx0U1kp67quzY4Y5Cr2SwTYaQlQ1uDTP9529VaQpvLO0pw9RqUp9WPxlq5l?=
 =?us-ascii?Q?pjpxHmTjvRYgrlIDZ/MpcAjxzeF+wvZOPAslTPqjjai45RjQh5vgcOKpZwoZ?=
 =?us-ascii?Q?8radEPB4IUL4PBKjC2eMY6ums62oV01tafx/pR/vBsn4p4NRuaVUTm7bT4hL?=
 =?us-ascii?Q?cXHcwJXowa4oAu04PHsruGBg/wyGlSlIMksGEM6K7fGCo2n/Z1QYFYQ5H9Zn?=
 =?us-ascii?Q?PogPXewRz4I7zBtfaDcCIUmFlog7LfrMx6YwTpLqJipxmmYnC0IQDXWRUUZJ?=
 =?us-ascii?Q?h9hmY7e65aYISjZJtY+55Tapza4RPWg6/7KxJyQ21drWJUWiDw2klpTCaTw9?=
 =?us-ascii?Q?OZUepYz9noN18wKa+alEiZNwqZkS+PaA86uymwq+i5RYXQU0gGPDwp1r3qm5?=
 =?us-ascii?Q?Eiz17+OzcRLWB6QXRf7+/27I9t1ujSjquEQAm9FrlAG/t7KPYgWTwXdQEkYN?=
 =?us-ascii?Q?xj05WYKAQLKXD7jSYpuzwpZhDIeGQwKrBQUdIfMRddh1RpkNT7FS8j9J+SWP?=
 =?us-ascii?Q?O+PrKj+fPh4z9DSGChhSOQ08yG7QrJjEnSaLKt73vCl577cnIt0R4AAFJZFh?=
 =?us-ascii?Q?XEu8ZK0Q/bMTaxuTWcBbrkBL8fvZ/k9xnESPoyIuEcbrXrLNDL1LrxU2plnW?=
 =?us-ascii?Q?kgx5hbVZCgTjfHKEctHcPDVPpQS406mmHEP/i5Ef5US2SsmbJJKRqNZ1TKDn?=
 =?us-ascii?Q?DT0ptetEvkQ7SFz+M9+bsmGS5aF+43QnmEIKY7bj00qjL4mIqD1mj3qVjooG?=
 =?us-ascii?Q?MfgFVzqXz7t+0f6+QiaXFGFydpLrWz/P6prYN0UiYUly43uNxJtDg3v21Psh?=
 =?us-ascii?Q?lEqqmbCi/+plIHlVDMgSXfe29WQGr5vjVHRKZi0wy4craMW8Lq69WRozpfLT?=
 =?us-ascii?Q?0NgXSnOdnnlBrObeeN+RcAk801q703uhwhF/BAGHPdKrZodR/FJg6ONogTrH?=
 =?us-ascii?Q?jkC2wLCXpa78zWzdKjmhlWhJ1xjRhIlzc9UdNZpuEckw72TTBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:41.8036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2dcb76-4aed-440a-007b-08dcfcf9c27a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121

From: Perry Yuan <perry.yuan@amd.com>

Introduces new MSR registers for AMD hardware feedback support.
These registers enable the system to provide workload classification
and configuration capabilities.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6db..0cd5ffe50f4a4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -712,6 +712,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
+#define AMD_WORKLOAD_CLASS_ID          0xc0000501
+#define AMD_WORKLOAD_HRST              0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.43.0



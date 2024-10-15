Return-Path: <linux-pm+bounces-15709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC4799FA64
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7119DB219CB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D66227B9B;
	Tue, 15 Oct 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ww3pyaY1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002312101A7;
	Tue, 15 Oct 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028265; cv=fail; b=K8svhQ2vyVMiNFJ7Ej4uVKQu60adbuzTED4NDi1AId+XnBHyAM1dKW2zXfAMyb1L+2tyLKVhFx1iNVEtk/UiCbKK4LM1sIs+SUt9ipuyK+jzkNH890ep8SgBlQvOUu2VjdBqlBCcweFzvHcDPiGId63fs80guTPJ+5xZLoYL+0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028265; c=relaxed/simple;
	bh=HJoYs8CM3OsvXicgnR/fNtM4qyoWAOL1j7CKQTEskzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bH8KD1nEbKp3jacaJc0i1MaAvr3txsz21cnY01xgFadaDzEVUykipBcmePXxDsu2ITf2aBvSi5F8jHuN7qkRtlNPWi33Z+ZcgRBm1+FTlcaAZbl2RTa9+IZ/4XJ1lTTkZk5yDI9efjiVYf0/01OLbHu6jWfTy9vVWfWNy5+GKns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ww3pyaY1; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFiVKSj2VBnG4j3BKD6d0yhLxqhInj/hHzCXu7TQ+WVDEkbd/j/K+DYOb1iZWINKvZgSC5Mssgs/mZ/tmmTG+QpwVGpE7ZVYIOSceOoyluGxSWkrhAXuNTinpZI81NKAU19kbG8+tL8Bvd60QtrK1qhWK/RfYPFqDh/UtJuCr1gmt3YjCTDM8+KZtADpfPsIHFAqpvoI2nG2zmoGwTs0Si7vZHbH7FrXEoRYwP1E86H0h3JYIJTgPFq+spraFnmp8WTM7tebnz1A1tgtJIgmcFSL9mmoDsALVsQamUQVTmu177oztgu7lhY+lVQIvp8P6TxI5+Z1ppe2RGS6T5ovlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMGZUYuqdzZETPuMmjwyoi+jH9poFcLM92dMo/5sI74=;
 b=YoOXbLIlWhUKO4LionLSjS25RcbAcTQCCZRDQzG8pq9lra6KOH4NZ27dDgVXNT0pFlJ3Z2aF58J3Kqagj6n4UrGS9AbGKBGSNehGll0UcBq16Te8npGdgAlY+aHvH/U7waOVZP9aQSY/dwroUIArJq9e/tWqn8oxfy7andB8kyrGulYatTLb8G13NnpaAzOoLDnmnvfaQ2J7hcULyGK4TIIoHLK9cZkMY+HKtY0lAWTH4U+YAlALBh5VMdiQblnEcd6OJ3rzPqUmZNhGuCgUyxbhxLGgMHzWvzsVVa4Nv3SgUydixCpD2MHGgrZjroPNtLwROQCJ1ht4ZmPl4aD2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMGZUYuqdzZETPuMmjwyoi+jH9poFcLM92dMo/5sI74=;
 b=Ww3pyaY1QD2H05+LGW7QM8OOkxsrghVGKd/eWM8mm9sr8HM5jFzaVZq0Jy+bfC4PKpschUIOUCcOmkW9mvN+Qwrs6mHAfOHwmbVYUvhTHzeSzpPBoksJMmUWaSbh/txia6/R3LglnpjjDCIiDhwZ6aTt2vaxSGy1jMCpYF+lz4E=
Received: from MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 15 Oct
 2024 21:37:35 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::d8) by MN2PR20CA0064.outlook.office365.com
 (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:33 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 12/14] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Tue, 15 Oct 2024 16:36:43 -0500
Message-ID: <20241015213645.1476-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4940cb-656f-435b-541d-08dced61951e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMP+vSYLnaDf3+M02yCb6jQKVE591xA07Oio0xtKruNp/2EM3wqlqtBALNZT?=
 =?us-ascii?Q?JEcQKeZm6B5uyV6Siag/0nEZNLR0wYHbZ6mZdwOVFs7y2jjnrP5zjB3wB6lY?=
 =?us-ascii?Q?6QgXjTlA0QB5kSReM+oiYINVBFF3z2qk/f8Ly8R+a+I0prIPC5K6DRDfA7TO?=
 =?us-ascii?Q?vfqkeRwJUtNgbWGxeo9dM0r9KYjrLb4+62j8EowWoco+60Garl9BBMQuWvmA?=
 =?us-ascii?Q?z8D5UCu69qfEqk3492RdzXroqIkVsuwIzSfWIBs1OOu9VTmdp1hiqPudjV3/?=
 =?us-ascii?Q?x0rslplsfGdIOOAUFDBAu/ZVZBnPOOfF8zWRgy9mrTgnbAN3LD+nuhFC8x3R?=
 =?us-ascii?Q?+t79cmZ25fbhXeRktf7s7DpBnJvrczu7/BBOmIK3NVXCitx7tQO/4vuTLbmT?=
 =?us-ascii?Q?XJe6eKzWT5I3Dmwj8vtZHOc+CqHvWae+TPjILZwwSHtAlV/5uQkhNYEcW1Z/?=
 =?us-ascii?Q?/BB1oMx7XLkpP594heGNC7q/r6HXz7SiG7hw5hE7hsBjt6+wzd82hzlk9XV/?=
 =?us-ascii?Q?zpF1zvtigm4+6tSHJQ+Aw8dNEHqEETSzKT9D40gPvD6glWTwwD60KxaXAhOc?=
 =?us-ascii?Q?/vi0wJ9TLMgHf8KcSCb22Vv9w5MAojpNSB92EL8QqPU9wTbIH3h1D34RpKKl?=
 =?us-ascii?Q?w2UwHpVF0Cm6qPB1mT8sc7tFj0bxthrCW/hxvo9u2JKEYPmCjxPt2k7T1UoQ?=
 =?us-ascii?Q?aPbD9e67ld0un3cxLbaEzQcY0UKiPNhH4XbTc5mQay8G9QBV7O9GuoX5CjPM?=
 =?us-ascii?Q?851ugXcoU8bxU/E4+I3t844fbOYQJv0K/FqYdGMABDVfy5sOKzMwck8a8sSx?=
 =?us-ascii?Q?zQn6q8h8xNCZCMxtpk+itzyJiDwKMg60cVuA/R5je9XzwuzfETkkVAboTTFh?=
 =?us-ascii?Q?8nl0PJ6b/JauEKta1FKvNce9Zo7cg9qdFzXifa61MhtZTfO+YH9Tq0iMlX/B?=
 =?us-ascii?Q?7sn603NXlSqgn/ao1w8WY+SyJxTwWM3xwyI388mVQlH2zfWY01B6pgukQdq5?=
 =?us-ascii?Q?9AazWac3LLY9W9UlZqi/6or0X7tG8WqCP6Ppcv7x49OcecFiHKmLx1WR/YBc?=
 =?us-ascii?Q?arHSiCVtUHiU4uXfQiHTQ3jXs7FQvXLu7dnxUtDq+A/uCjeNEi+bGJbPJEtS?=
 =?us-ascii?Q?U+aepfvc9TR5SpjepPxYCDJFLWFWVUlHD22ca2uJqztXzXawoRPXGnWusc4X?=
 =?us-ascii?Q?XqjcFyl8edB4N43OlomBE1KMu7JRX478r/FUL/ig/YzTuVqziQiqzsG1tcna?=
 =?us-ascii?Q?LBuOYerrIQxKMpfBSeEC7sE1IjVBklCus1IDEKxy6oi4HNmHvBKWqj3VgSlC?=
 =?us-ascii?Q?IxXHWdrDnVJkj1lBJx2o3lwFBKfiKUHSO08HmXqKOTFqeikOw610y+kL0bHq?=
 =?us-ascii?Q?2n3WD+pnVE4SH8W3NVSHAs91ebl6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:34.8546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4940cb-656f-435b-541d-08dced61951e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Disable prefcore sysfs file too
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 90868c8b214e..f2a23f622843 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -763,6 +763,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	/* user disabled or not detected */
 	if (!amd_pstate_prefcore)
 		return;
+	/* should use amd-hfi instead */
+	if (boot_cpu_has(X86_FEATURE_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI)) {
+		amd_pstate_prefcore = false;
+		return;
+	}
 
 	cpudata->hw_prefcore = true;
 
-- 
2.43.0



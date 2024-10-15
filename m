Return-Path: <linux-pm+bounces-15704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F599FA51
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044721F21562
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F306E20C002;
	Tue, 15 Oct 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QQpkS8Ow"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71A208D62;
	Tue, 15 Oct 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028258; cv=fail; b=ZfSbLytuK87TjHuMW2z4TlpVbfTzK+LzrkKMmG3RvCuZy5vnvS3AuIcsp2xbXAPkSachEtyqYVP/ryJ0LkzwjeraPrkfCyLfktS6Qh/UexMUG+Cx7AMK5lV4aHulDbUZV6AZr+3EZFl66tv923T01PaVBA3weUy57rB6fluWcp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028258; c=relaxed/simple;
	bh=bk1pXc5w/Z6XCOmUNn3AFkqPn7BS+gU7wAS0Jdem5xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgCTVab38XOHsUsFbv8sAgCI5fZjET/gpmdUAZmchDzBKZyi+v3EtShE298k1nHDcJFho5/CuXqMVDvuYXAb387p3nPloTeOO1GUfIAKfnwBGBdgZMLpHNn65t+xWF7fg5NzftjkAcKp84/1mkVso1+jOcRPtZH3aJ8Z/xk8lx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QQpkS8Ow; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+bM51KgR9+2cYzAVXAgvbb+prfeJikMuCWUHJwUx32wEilSsVmcy5HfPSbs8PwOQKbCnf91D7ftVkdntSFVLaoqcmFPkc3OYygCfnA+9fMhdIp+sNplM7mRB4Hdcnqe8Y8KyciEgZzHHCFBeXjLVwR7/XZcTU27ycUBHW//1ATRBK/akc3ixKk/i8YvWY5lJD/vKRy0rmG4lY3gbBktDv2l1QOg2LmIbkPUwNh5uT/jIKR0hsT8KqxEqXMGdeddVihFyX4kknvUq4h3BydFD0nktTsdk2hUAjR+SJahAWwxCQnajaDutPB4WP3+3D0E1wwM/p/LABmLuKkmZFDRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myNXrZpiled+NLs5v9muNSNgBrdbZeZ0A1AUa5emUD4=;
 b=I73MpgvgqHN+Qr0FQFeyAQkeZS22RqMd9Pe6cFiDdd+ylXmDq4U55Q6Wu8htiiQyXL7t2ypB24IddoI+j1hVDSgyNbyoeGRiLFO3Hws+fEcYsXrJMHMNQBdt06cAYoDOy64+LvmZlrE5TqHrxvvCbAhJsKfdNMxY3AdGki0Vd3cWiTwr6fYHjgWmHCVWEM0svYZeRrObu9p5nrk7X7T9WFIEGb5QRt47AxuR0cOKCrGxE5U04Qb7Jwb1xPSAIPqlnpTfsWSOvpEQBcM+5sptmXbenZ4vlTWcs7wF8E1X0slwz30ybRzHMZGHKyb5gIzweeuZTf1Tc7uuG1r3RQ1FYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myNXrZpiled+NLs5v9muNSNgBrdbZeZ0A1AUa5emUD4=;
 b=QQpkS8OwcSJegnHkVwg5n78IH5Gqyrvd4F+SE6M7N1Mpva/yeBfQbCifhEwb/+vARxGE3BvnUMOeukKzEgh7spmNMobF95MFIfkQGXzx3EcKgwqsyefisP07LZp8GgrurmxyKcLcUQQM+yFPb7CmeejnJ7UWV4N49/17TXi3FsQ=
Received: from MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 15 Oct
 2024 21:37:33 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::a6) by MN2PR20CA0064.outlook.office365.com
 (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:31 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 10/14] x86/cpu: Enable SD_ASYM_PACKING for DIE Domain on AMD Processors
Date: Tue, 15 Oct 2024 16:36:41 -0500
Message-ID: <20241015213645.1476-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: b10e290c-36d3-43d2-72fb-08dced61941a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k20T/E790ErMiOSNYuA3bM4JhcyCfQL7ks996Q+pz+YinZaepy1xdoH7z/v2?=
 =?us-ascii?Q?CQmhadE6+asb0rxfYeI4IlrCh4jRqMPKov9XphKVZSgbxfba4urvConqM/lI?=
 =?us-ascii?Q?jwwqXO8tSoNf4IIuHuqzA5cVNPsEqbDgtKx+d5LmMEr7mEBlcmtoHJUs00wp?=
 =?us-ascii?Q?JtyPZQS+bHzx60YHtbs27zEA98OHYSan+S2HU8JpIf/JEQ3z54Na6zocJjo4?=
 =?us-ascii?Q?+AYajZJiFr9F4FDf4JU2dewTl4CW3tTl5EHW/NKcQcQa+8rST6C1JQ0aG7z1?=
 =?us-ascii?Q?hN7UT2ReqPix/HpVTgJQiJA3Ts9P0ddceoauv0prIrB4vfgoNQndJd7vz7J0?=
 =?us-ascii?Q?3Z8ne4N0W/odZgCPk/44BpSrrYPRZfrgTRG20C/+SEU2UJZLpVCeTQnL3SHh?=
 =?us-ascii?Q?5cll324+jUSS+rlO1G1Nndx3PPqLLJDy4HVmLs2y3ownrpf0EHH5rfLj2EqN?=
 =?us-ascii?Q?71YqJLSzK+eQNYrKfCH15/qL1N092hFnq6hFbvklL3X3Y2UaII4V72col907?=
 =?us-ascii?Q?t62L3uzpD+j0RfDCSZ3jfMVSrw/IF9a6yIz4qzGXz3lqHGxswbzE17BD8386?=
 =?us-ascii?Q?RGXNN7kY0tDIpdyfsVOZQCtx5Q7euHr9o3ULjAA7BmoNhK3sjAKojhcIby/p?=
 =?us-ascii?Q?MiILMQAt8QQ+95Lx0YM9MVZpkyVPeQSULYVTgzMCtL7N7VmzO2yatODw4drz?=
 =?us-ascii?Q?KUT700uZDDuefCgc1LtN0ZS6rzQfPwiQyBWLbCVxMqYQwUbcIPFmQt12d3OB?=
 =?us-ascii?Q?Inx9b5hWLLPyyRdAcnkXRQOxCKEaXcBdf0lTyKCHQz1NmQMbd+P/jzCdCkE2?=
 =?us-ascii?Q?DzY5hXz57ide+yWIZBIki4lD923eb3SRt/L+rjOtOgnOBKj1fxBdMfhiO7iW?=
 =?us-ascii?Q?vaNSSosjjpVI0zrnsfCZrv4zW+Dw8uvm9WRNNvOzgjQ19c1p7zGVcl8wZcO6?=
 =?us-ascii?Q?kC/Sb/CrLxnPZdabBzEZldfzDLrP2XOBQQEqQprpChLNFXrBmLOroBLjGHSu?=
 =?us-ascii?Q?lUoagP+tv8y1LumveyyYlB//21oexMhM9/QKIJdlWnTa/4I05aJYaPvDiUd+?=
 =?us-ascii?Q?qbGEHQl3MFdMIhk54JU4xEGLw2gx0FGRvVl7AIDL7+QGcVbuVMceYLrtDajy?=
 =?us-ascii?Q?RBO2XGQyuwBrb/9T+bCTXnaluX0X0MULR9NJL0xqboHkY2CRhd6aoJ7/9p7j?=
 =?us-ascii?Q?8U+9h2HEW4tpDgFHS8sxKrmXx9fstSQwAO+YpMogF4vt+PDeo/XRCmav14tf?=
 =?us-ascii?Q?pUHTRzk0K38VQlW2X7AV5ewy9kmbDdE7AlymlHnbbw2MqjmDn4afs12lZ4Ma?=
 =?us-ascii?Q?v9UM7h3w9wGLE3QlA9sR2AnPDDnIa4E18XfLV4JX+SIPx/WeFLzaaOBx2ghR?=
 =?us-ascii?Q?ckVM7H2iB46WXe3RNWd7MSzf8hHh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:33.1514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b10e290c-36d3-43d2-72fb-08dced61941a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

From: Perry Yuan <perry.yuan@amd.com>

Enable the SD_ASYM_PACKING domain flag for the DIE domain on AMD
heterogeneous processors.
This flag is beneficial for processors with one or more CCDs and
relies on x86_sched_itmt_flags().

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 766f092dab80..c01bb75d0375 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -497,8 +497,9 @@ static int x86_cluster_flags(void)
 
 static int x86_die_flags(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-	       return x86_sched_itmt_flags();
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
+	    cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
+		return x86_sched_itmt_flags();
 
 	return 0;
 }
-- 
2.43.0



Return-Path: <linux-pm+bounces-7556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF1F8BDC40
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905431C2305C
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA5713BC29;
	Tue,  7 May 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aE4aTkUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A813BAF1;
	Tue,  7 May 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066171; cv=fail; b=YyO4F8C3UBqfYaqNxDwmKdzcDQr7O/xxEhhVKs9V8T3z6hnwkw03mmR31w3Nq64QpDcJclk9mxkShp/JwvJipHwLy4eggCoAjgPMgs635XmQ7E1ulOR21pIF0n+pq6bAg7kdQT7MvH1EudlWKnXEVvDuoj7SG+pTY9JB5JWhxpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066171; c=relaxed/simple;
	bh=kh4vsJmdPfAdzdJqOtOv0F6/1hGxUbSaPW3t++NNOiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MP3deUAmf7E+a2tlUhDWN2tz5dbRZ80VhgkswfNmvFYiczZBzTXdnrDtzg367Va3jZjnZe2QPitfB63NWCClpjAFSAIec3/ufag7GmwgbmN25cYJvo5MEHVu851wMGOp6zQWGQzc0UUQaN+nFdGrkf7AfgVIDz440DPamwKmldI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aE4aTkUx; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHmM8JEQX60YcXnSZ/zjbPd+MEQars6bim+oR9stABahPDWXD6/gMgU2lShOh8PqSIBw5g+50LoGcJwxL55uG6ZUp4DIL8yGlJ+stgPPMcNcWi4c5RDygPE3zVMgYao67rxF6vFjbFt8+hR1E9t+QEbusosKvTJV3WoIfh+ipmelfBjNXgPJboWOkRAU5Vbtrq6LU/MB+cmpEjLhjwUwu38oW8me7nQGQE2Z2NBF8ElfrI5JnDoASUA5KatO6L5C9YBYQxt49wQcMxQIWonoKOB+FPmTNuxg1eQpc6AJGUNgg61SpH2KmTMonD2esuqagOoSKG/+FXH43L00lgDgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMpzZk2coezREsd9CfS15Sii3PkKhjR2Tzjh/3iQR2o=;
 b=lo3Sqafv6JS6hYKlzW8B5gmJPLuuUDs6Do7QmIHKPYgRLU1sl3TnNwpBGXi1HJhXUWvIJzSo0HJGyKmsPU1rq11z2Yuh8fzzEMYUagPyc3w7zpQoMN+Q3odib4EBnATKwFH5nlXEzJjn1xpFAd6j+m4Jf+EtrPzrAqwZJem7jcntT9x28zl4bucNvKvuW9CeRcs5KKmGcxtA/wBPMICHQVT2um31eriSLasYSDE6vcCGtPaCvV0kznGF5VeOfq6wBlWPquhe4OkOT90UUX+X+BRNeYTela+EYd00ayVM0dWMN4TfSd8GBr1otFrouXia9xGSazAec5RKXrEORoKgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMpzZk2coezREsd9CfS15Sii3PkKhjR2Tzjh/3iQR2o=;
 b=aE4aTkUxuNkztvxm34Ac5yQzlWVkyYHl4RbR56bIy4zxTvOVIz0DGSPgBepch9AeWmtyjgPOCp92IuXtl0QkRQCk2zBaplXu28od74+YGKcMQwtru5GFfs1odRzgXca1J8eZ6RaobfNIfF4hQ4fsQjOMJoIZ7ZZD/jbAYZUWPnM=
Received: from DS7PR06CA0032.namprd06.prod.outlook.com (2603:10b6:8:54::17) by
 PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 07:16:08 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::ba) by DS7PR06CA0032.outlook.office365.com
 (2603:10b6:8:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 07:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:16:07 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:15:59 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 04/11] Documentation: PM: amd-pstate: introducing recommended reboot requirement during driver switch
Date: Tue, 7 May 2024 15:15:20 +0800
Message-ID: <cba2303c23bb579299f7c268b49286e62782893e.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715065568.git.perry.yuan@amd.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: df8941bd-01b3-4e18-d743-08dc6e659092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7L2J5D0nCYpykB1N6tzfk6yNe69pFJe85EtxhZVd9kgIxkrq6ud6VkIeUeM?=
 =?us-ascii?Q?HqRaFA84mrrhRz3vfAYceICFjPj3D4qm1c33Mb4Id9LowFYetXrtxsJXrXD6?=
 =?us-ascii?Q?L80395XYZ6vYLD0jz9BSUq8+aiIimfn/NE0G1fiWLqDQ2akb8kMnJ9zmb8aE?=
 =?us-ascii?Q?XP1pNWQG667uIk2VmL1IsKNUWo1WWg98ppS+IoU3DM4RXt/oy7XFUESF+0DM?=
 =?us-ascii?Q?WmgRKJ5ZMlma//qKK55r2wNgwBHKXFdp0uhtkENyAl5rIhUpvwkBERR5Mq6y?=
 =?us-ascii?Q?WIAoTRdxoEo+X4VKKJ8TzvZVm0UMm9ropa21OJM8HqMFQS/j1anfae5WC0Qn?=
 =?us-ascii?Q?Z4Rv7RnRC47Fj/XGrW91NyLS2bRSsQ/R+sZUwrcmcUc3DH1gc622irhc5aRx?=
 =?us-ascii?Q?ksvSOYSTcByj5m9gdQhqB4nrbazoEd6I/Mk0eanh61nwYPUasa7wnHORR1CB?=
 =?us-ascii?Q?AFHOMIsigBhMGkiJyVQ8s5SAQQRW54AD8OyaRR7Of7Ll9vwv5OMCUJbYOLhG?=
 =?us-ascii?Q?acCfTF2sbzkStYYxuiMxK5RrscyEhWbWhKWjZJrqMK1EG2NT/dJPCm93B5Gt?=
 =?us-ascii?Q?J4ZVAEUYzfUps5Oa74aem1mhHAK88YyYjAWTUwD2W8KZJ9qwuYPeZTj9Vdtp?=
 =?us-ascii?Q?raYsCmgBzYeRmPxf+LoHCBIoazQtEo5RUJiE6E+EilAOlZCN7GLO9OxlknsD?=
 =?us-ascii?Q?/A5Io0vgcc9BDGC2gBfRqNoDqZa7XtFw23smS3poakGzGLcuYBBKu8O/QQ1+?=
 =?us-ascii?Q?5MBVU3vR9wBhnF+CZHD3gR23/kYqi/cpB91zmCsdmwGO0siYQomWuF4O2Z0O?=
 =?us-ascii?Q?ONRgN7AW/p4oJriPLqjFkZnYvGdunWRU69+Y3oVsHy331eFlVuZgrYiO8DTo?=
 =?us-ascii?Q?X+u7zlkq0TFFpBVQn6uXCaz2c3JrPiTkRX2OjUnWyKo6YVfrN+ZZc4SF3YAN?=
 =?us-ascii?Q?PgSeCeq4JONOeKkPetvpuqIasUgENV0DEWOobqlIKP181JBVCilp7ks9Yf8x?=
 =?us-ascii?Q?unwFWLJFdlPmjpmCFta8adPCum39d0exk7GqZow7F24VAOmew43N627ocos6?=
 =?us-ascii?Q?Bm1Xbe3Lol1/UGopEAqqqv1MjtSerHye5J/JeuxDuC0pVyoTxpdOMV0cLF+A?=
 =?us-ascii?Q?tFBf+QWjkHLFsNKp1sWM8LZDPywVqbNVtdv+eloS+q2EM/WKM2g4/7DVaQ5i?=
 =?us-ascii?Q?iPm93EkUnfDhNzmkqBVSHlrASj4ejXjht3vkM4kTT5sAhO0Br07L6IP+Bo2I?=
 =?us-ascii?Q?DIhS9M4oeEcS2H1schRscEYoOr8xLHSCZ+VRLbqK1k4Sw5UurnJwUYigLrmF?=
 =?us-ascii?Q?ZyYoESQxewWGlWrGBJLLLIjg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:16:07.5281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8941bd-01b3-4e18-d743-08dc6e659092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

It is highly recommended to reboot the system when switching between the 'amd-pstate'
and 'acpi-cpufreq' drivers to avoid potential unexpected issues.
Rebooting will ensure that the system properly applies the changes and allows for a
seamless transition between the drivers.

Reported-by : Reported-by: Artem S. Tashkinov <aros@gmx.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215801
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..2695feec1baa 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -299,6 +299,10 @@ module which supports the new AMD P-States mechanism on most of the future AMD
 platforms. The AMD P-States mechanism is the more performance and energy
 efficiency frequency management method on AMD processors.
 
+When users attempt to switch from the acpi-cpufreq driver to the amd-pstate driver's working mode,
+it is recommended to reboot the system. This is to ensure that any low-level power management
+control states are properly switched to pstate control. By rebooting, the firmware can initialize
+with optimal power states, reducing the likelihood of unexpected issues.
 
 ``amd-pstate`` Driver Operation Modes
 ======================================
-- 
2.34.1



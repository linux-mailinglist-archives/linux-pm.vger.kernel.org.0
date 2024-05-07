Return-Path: <linux-pm+bounces-7558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D98BDC44
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E583F1F250CB
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDB613CAAA;
	Tue,  7 May 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5eaHaIjP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C113CA93;
	Tue,  7 May 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066177; cv=fail; b=d4IduL4P1Y5dHswa7An1StDU2e836j4vh0XQueUdXpZMRLdtNpgfRQfY4B89XkS4W1GJ6PgsPMKx51JKEcwtB1QOcKWmqZDR/YUKOxv+IfnLEXWzB496LkoHSug6lMOUxzslBS03kibQs3hgWPyZ4K2LoHKBIAQayeH4Fja0f3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066177; c=relaxed/simple;
	bh=kyUtgaEdq1NFrdnzA6tXc4fA/gczFkBocKudhGSU9sI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLPNbTrHAkGf7R+GMTTvtlN6sGtKiRLoZ6rC46pk25OD3OXRZZXgW86stiwkx5BBsg9rctYvM1e7vcaGyglcIkNqw/kE7zRpgFGCnVnW714eDrdWsRHvcZAjSxc9YgfSvAlRMpsfH8A/9BaDw13ep53KoPacGUa+g4jY1lj4IV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5eaHaIjP; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJLpp0ZpXolmW+mVMtgSPJc6Hfp9numO827aUVH9PnfHTi/ChBAbl40JBGkwk74K/Lx1EqRCnBWju8H0IvufEgDFfhtftOoqOZmPxpYFtESSy3OOtrg2R5c3ABrdGONh8bQI14YmdBSAFBK2GofcqTamG5YdjNmKSPXN9E9IstsxuhAGJnq9nMnRuzxyHhYT2yGo11cobi8h2M3Iny4Xqe7kzMWThqKyC5ClJbNYxng/q/FTdpBoATYUli85+MmWUx6PhNAQYhOcNfC9ONIySr4b0rvlJASCiiv/3wCILKpiEWjIyC1igbIMGChqzzKYSuNfELDN5IZXav0srz41/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWxlwwf/3e4KGyMmhNjJGdvVlTm15BOwgIcaX3Nkb48=;
 b=SHGH2b4YMQy6F2mhs3esHbaqPEabICbfFno2It0s4EgXdXFHCaSvf2RMVAO5gFLc/u75UkGl5reJpRSw6jW3ff3G+GGvzhtDAdp2cgs+YQxWs0zs4/am9ik9AIJfRCYQO1YZCZLb9mgsLmMok2X3sDHIwfVGlYC7IWyxrSce3wtM2gzj1LFmBlPwPEaMGcyASIlxHIAF9Z4LkRIlqWQM4n31T2F8BFh+UjKpgBWjbYBY0Nss/+0vXAEoXEuFHW3CuFleu3GIwdu06/UHCrSWK3kp5Viuie+QenL1qrxneNEN4ECKeousQnGV7SafoXys4jmNvjLB0RinHWN0fe2bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWxlwwf/3e4KGyMmhNjJGdvVlTm15BOwgIcaX3Nkb48=;
 b=5eaHaIjPSFUIQKCgjUqS68YRxka7UugeXrdPyS8EjpMHeV21943yoHwIgEILTsxtOrCUJlywezJmcsvzY/qx2/P5DJGAvWxM6rdwU7VPrC9Ci5MxZvdMdrPhZuvXNJbQ1uyWTDNw0L0o13786qv+CyFymfkNwWZUejEXPxpJjQM=
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Tue, 7 May 2024 07:16:11 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::e4) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Tue, 7 May 2024 07:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:16:11 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:16:06 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] Documentation: PM: amd-pstate: add guide mode to the Operation mode
Date: Tue, 7 May 2024 15:15:22 +0800
Message-ID: <651c35dfa654b4331e597647b38a21fef477083e.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fb9d95-f993-41a8-4964-08dc6e6592ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nO/1dpqv/A7pfYMVIoulaXbYYRiR3UNvydUiCYkHhAxiXozwNfPOdh7GiOZO?=
 =?us-ascii?Q?xD0e3myR68oZat37PsrQJRzErafDaap5k5ptpzieXyWvzDxGFMqtrS+AX9m8?=
 =?us-ascii?Q?1wBRKSMIL4qnYsN/3TSrHf3nAWpPqDSAIJ+U9sgpjiUHyaMD6FSP1FsIjZ+3?=
 =?us-ascii?Q?nayYtuH5wYaCoMx/7ip7V3vzZpZn5bxGiqfncP/o0Clsqgyq596OHW3D7QOC?=
 =?us-ascii?Q?TvWxthh52grNYOqZvEx6xvosoVcnKmXUmAq3a/oN28s3C8h1A7bR8qjH0WOa?=
 =?us-ascii?Q?CQweLKGDR5TqRxeu4Hc47pE8p2uZr6OKSXc7Y0MtmX5zO41B0nMp2tynQKWt?=
 =?us-ascii?Q?bs5+1GWMMyr811nvr56UTSdzFlm2B9gkXWzoCTdNIId4tFQjeYSYYTH/6uA7?=
 =?us-ascii?Q?SvkPVsoAHHf0gOfSO1CsqIo7bgijFCmh/Fh3y6NGvJqdPthqkPUd5KFHr/WT?=
 =?us-ascii?Q?jheYo9gHgEH0uMLkI7SNBRNmhJIzzrq1z5Z+9SfSsGZP5Mub8MW3M/LtVszU?=
 =?us-ascii?Q?hVT1CLUc2kne+JVNJ38udYKcwFIRENDrf0hBnpTLhw/rhwvnYVGWxHXMELLC?=
 =?us-ascii?Q?8Kl6tCRn7uy2omD5eXZiSMxd9ussHlVNWRDG2HzyhWD0kOTDFkOpwY2qO8S+?=
 =?us-ascii?Q?YTwugjKzni6M7d8o/OJQiH1tthIglLKsQjA6py6uz+dOv7KTnXEXprscwegE?=
 =?us-ascii?Q?LnpjqWCnyRP1ySDOIV6TB0iIWeFZkyReSA+jSUNUmfK1nlKk+ZQRQuHB27rY?=
 =?us-ascii?Q?qShMKP/XGlCQWH1Xg4JUv8LAaWHJ0HYIKaWagBBefoYh8nT5jqO0qMOO5iSG?=
 =?us-ascii?Q?x3mohHRxzNwpqpaqoKnYSTt9LM2Poq91AOjcTRrePwm8M8oqPpMsWSuYFG9O?=
 =?us-ascii?Q?y3ylhYCi9zgbd+qwn09srHjrc0uUPYTpGHFh0bXh0T0fEZcmlsudkvWYQsy7?=
 =?us-ascii?Q?8QmZTWAbhpcCCb+xXF2Ny+TwvwbS5xz4W/nYh5VUfejlaM8tSAkg2j60NmaI?=
 =?us-ascii?Q?IMfxUOWC4GCRLXuo1WuKQ/HrSd1AWfGheeNs5AnJ3KW+vJnsyCMY58FHtGqH?=
 =?us-ascii?Q?YcW/Yr6+Gfr6EZzrQjtlkTZvZIZj2On904Rz3ru4aUzUjmTiA1HsKCs7WMDL?=
 =?us-ascii?Q?R1ZpAFYTZfOxowjU/7sPrJwGoo+sqReGupjB9WZpxYfeb8HTvUqmDwK7hBeq?=
 =?us-ascii?Q?J9RcPKe8vsGj48h87ia0lEYsjGnKHwAnWfOFuS1RW/E5Z4jjFlleyiMCBkHT?=
 =?us-ascii?Q?sFqNMt+VPsGEL/xgI04wD2IfYWWMxNqB8U5dKyp9gtAje1yuWUrULCVDbVsb?=
 =?us-ascii?Q?j9sjGG8XOoFtUQdlb+HOsTdLL54zNd8hBJc5uPuMVIaas8QUh4RpbeFRK8w6?=
 =?us-ascii?Q?Yf/XOOitEkSn8E2pyHn2TfR7oRp8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:16:11.0437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fb9d95-f993-41a8-4964-08dc6e6592ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

the guided mode is also supported, so the Operation mode should include
that mode as well.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 230e236796f7..9fc924930595 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -410,7 +410,7 @@ control its functionality at the system level.  They are located in the
 ``/sys/devices/system/cpu/amd_pstate/`` directory and affect all CPUs.
 
 ``status``
-	Operation mode of the driver: "active", "passive" or "disable".
+	Operation mode of the driver: "active", "passive", "guided" or "disable".
 
 	"active"
 		The driver is functional and in the ``active mode``
-- 
2.34.1



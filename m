Return-Path: <linux-pm+bounces-15141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C69902E0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 14:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89848283880
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354515C12F;
	Fri,  4 Oct 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mQBkO51r"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3A156861;
	Fri,  4 Oct 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044622; cv=fail; b=M6HqqfMqFtc2xuG4AHtItuKZbkC9ROuTaqzPSNXkVxRWEAci7+O7RCMw/C9tBLQ13BLthVIqxF/JsyWrw32rgMpRgq0EGZP5IZfIRRKgY2f+EGXLQivR19Qvc750esExFeKh5LhD0a23IA7bpfYoxcLMspQCPag+jLptFTzmhLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044622; c=relaxed/simple;
	bh=nYfRVTdFSHqODN63UlQ9SwZX6Y6eR/O8w6K3KN+Y22U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h3A9h5j7+woYLQuS/M0oPljef45oZ7yzNLCRMYmFOQnIyPQwKxiVf+MNo0EQJAoaEOqyBci7crsoo72ijnv0PpB2+PyNhDHBFYknIUs2WsjCxRDjaHVdKRyYLGwrzVLQpCxguzr463I3UHjfAVd2/lP5bP5NGWjnjHS9S8XX9us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mQBkO51r; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EynNUrhs14zXzz7w/LP45tInTsDV7XyvF0azVjhxXQAFuD9S9CkZLLuEtrZgl9QtYLzMPkxxXdimYJ1s+3U8duFlrLWG8mxIE0hSGUDB3C7z7bIbCX2jW+JjDj+u4boVroVZAxuJ78cZnZH4d02rG29jBrFH+FduMw9DIXSDLVS02pjgc/bLkNba+1uSvnsv3b/GttBy+Hfu2X5CBUB48oUCDQtwVCqNbAqKT8sxUmow8uUas3eusLfdT4xXUY4M4lcTPifULfNZhRzfhe7G6chr+mXTAPGBuxf2U31RoI9QGUJHlX6NX7yHkQkRh1IknsJQuY7sIGJme9ELYpxK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I1NLLLQKExMOASHJKjIz0X1aHKP/P/YqlLEyCH3Ijo=;
 b=pkuNluDmHXwD+dg+sGXJRmH6t7b3E42cF6XOa47HjZLHiWy1si/d0r2ohHpo3F8kK1Ds1dhvPVSTwxFBGySmli7xIjOWlbG2MoYgnwGZUwJ3ow7KS0QGv4gfFyS8o6NZ1RiMrO81ge8SOzEtNazo2zTgvcjHAfcE2zzkMkKuFEmRCojGNWnCOkSAYYRD/qUG6Wag/wFMnkHMmO3HhnfBanck1+NcigBphKLCQLHCbi0kZf2Y5gYCaZF6Sjo4p0uvigJFdfUpnZi5qnKrLHxrCWRgfOjJ3iQt6eM4CKnTeEieGrMxuaJE3TE4OgD4jiVVRHeJmMq0orkX6HHZWFjFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I1NLLLQKExMOASHJKjIz0X1aHKP/P/YqlLEyCH3Ijo=;
 b=mQBkO51rUetHJJraTr0s0oLD7ABZwe9v3fAjMM3Hwb0+dx19M7u82SAXPM24WEbxxIue5qjl8KgFjvLM9a93hAa95tISAKkollUaZjF+kuVKceBY2tOs5WkTlrAsF8uTvUC6rq49DjhE2i3TZi3uBScgZTT22WkyESgQoEvgji0=
Received: from BY5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:180::44)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:23:37 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::34) by BY5PR13CA0031.outlook.office365.com
 (2603:10b6:a03:180::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.10 via Frontend
 Transport; Fri, 4 Oct 2024 12:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 12:23:34 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 07:23:31 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory systems
Date: Fri, 4 Oct 2024 12:23:04 +0000
Message-ID: <20241004122303.94283-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: db082848-9614-4ed2-7e93-08dce46f5e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4uUP6LeJv4kenF4N8HJ4ctMPO3Yx5Ryx9Dp/0I5+MLdkVlxUece/yDN5FS+W?=
 =?us-ascii?Q?hZJIG66XRSSJhtBoMFeh5UiJ/nf4+Robs4UKvbadoDNvmFQ1kX5TyX+I/Tox?=
 =?us-ascii?Q?W4x5tE6Eu+xBsNnL9JaLhGpNlVAlvvdyvWM4krvXn6bGF76jiqo+hVePO71a?=
 =?us-ascii?Q?4I0OCUTFY/JUcuYyoOaXjAeiXz/CIuvwwifOQOp4bLLad0z4eIO9nPH2rCp4?=
 =?us-ascii?Q?ukHpSwkSZo6FtUkkAPD4Enll7rshUO8H+JJ8zQa1hzKn7b/zMIVBZnY3dBhv?=
 =?us-ascii?Q?ju8ssw9wBInBzdQ+BJFLJxQtNKVSP4u0hZ0vCdDWaXQ+JMlUFfoTrsdAhliV?=
 =?us-ascii?Q?2Hm360bsipPnJ9oa4YtIobjFtZjf+5ICzhidLWe5P84eDh7pFqnCpruRwtVr?=
 =?us-ascii?Q?27QplYogHuKD+SBgTwL94iLURpw2qMrTyzUPcStBcdMuzoIBy0t7LjpXemAp?=
 =?us-ascii?Q?4aQ/rsPZW6haOeFNEfrsrV0kNnDTzOsUvhd+6kD6Nyj2q+H4R9dMz9AzRvvS?=
 =?us-ascii?Q?nwpASTaoP108TK9Ol/IlFJe37Qzsw5QbDj8Xnd94Q1oVf9MVlliNW30+YDu3?=
 =?us-ascii?Q?TIgUgQtXBcat6Ho/fjGPuNZXKX5t1NmvKBR+BYa2U3s9mh0kDg2/gUU2CkWc?=
 =?us-ascii?Q?cEdv2WeOoJzU8eKo1Mh+BJ4RT5bBG3pAL8nN6Oho1n4GeZfFzGGbv4gslHUe?=
 =?us-ascii?Q?Zc/TMokhu4NDMk+baImHcrZq9SgVRIVVtZB5+nQsi3O0027i04SpbY9OBADx?=
 =?us-ascii?Q?Sz0R2bIzFzWbWaGhx1IFMcrKHqqVJottajqVJhvwmI3oyeqnjq7bDlJwYhB6?=
 =?us-ascii?Q?x+r8cs8txNOIfHPxh3LDMjikVf62NyDdkDqQeBz4NCvxF/Oh9ztU670WPHeT?=
 =?us-ascii?Q?12xrgwe4duWCSktJGT7x1rI1vmodlNH3zUGOu1Ys7r6R+O9HjLLB5FbO8bjZ?=
 =?us-ascii?Q?vcW+OzISWm3GFeVovivtH3OKEvmfp4tOnMCrc35ZEU1znEcBGbld44bw4FSo?=
 =?us-ascii?Q?u0seMTb88BaDSvjT6OctmDSCGKZZ8nxyIXyFUZB1FO2z9WHADFnZ8gNCr/s8?=
 =?us-ascii?Q?ExNsF5Xow3c7KtOV2i3/CQ/mA6i+0AnI9Kv+apHTwRm//EL6zO922b38ciwT?=
 =?us-ascii?Q?QbK0fKDT6EDX70plM3XqC50Vyou0yxSgvg1oEOrUz9ZzlXN/A1WSE3042bxx?=
 =?us-ascii?Q?490nhC7t/qcMW5JZcmEuNPL8I/aXBp96IX4WKZGOg96RKx51I9MXWF76PDg8?=
 =?us-ascii?Q?/Gk0XoGdu+uI23/YeEuS6d2oOYPBbRKF4HeNofuJuZ8BMlLM5fk4A7/iMFf1?=
 =?us-ascii?Q?M11KlU+5UJXXHZtO+NWuE1VZqL03wQNgrpWHxGPr9oP/e6L+v2Kw/fhcQT86?=
 =?us-ascii?Q?f/HY0KMonJRbaA3VqH6zuNgEjxJG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:23:34.9472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db082848-9614-4ed2-7e93-08dce46f5e10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

While switching the driver mode between active and passive, Collaborative
Processor Performance Control (CPPC) is disabled in
amd_pstate_unregister_driver(). But, it is not enabled back while registering
the new driver (passive or active). This leads to the new driver mode not
working correctly, so enable it back in amd_pstate_register_driver().

Fixes: 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control support via sysfs")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cdc08d2ddd52..4acf5fbeb116 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1191,11 +1191,21 @@ static int amd_pstate_register_driver(int mode)
 		return -EINVAL;
 
 	cppc_state = mode;
+
+	ret = amd_pstate_enable(true);
+	if (ret) {
+		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
+		       ret);
+		amd_pstate_driver_cleanup();
+		return ret;
+	}
+
 	ret = cpufreq_register_driver(current_pstate_driver);
 	if (ret) {
 		amd_pstate_driver_cleanup();
 		return ret;
 	}
+
 	return 0;
 }
 
-- 
2.34.1



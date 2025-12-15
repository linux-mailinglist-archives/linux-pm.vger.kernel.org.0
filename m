Return-Path: <linux-pm+bounces-39538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECEDCBCF52
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 09:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0AB0301345C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F49281368;
	Mon, 15 Dec 2025 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MqDHPJaA"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8523D7CF;
	Mon, 15 Dec 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765787294; cv=fail; b=PbXocchLU/EUKrNC/UWpZNmjzJtWsihx26czNnrt9fJFYRPs0kdFJm4o94p19UIQDkP1ISs6J9tZx1LWHxHuWz8SPg0w8g2q+Vk9HtWQrXrJArMMFd3PcfMNbBApsmfcgLNHf/1QRWH8KzcebsWEW7+3dKaUc+WfLi4AEBa3lwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765787294; c=relaxed/simple;
	bh=Uzr2aCZkqTE/xUG8OWk0O0oOsPG2ed2mQS3kCRqou1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KwbQuAJTbUV1BTm5WkzD6wdi6mptNLp6sAN4B1OZqT2iDD5d8bQD1rt1YlrZX8UV5JqrF9csWFOQI62CyrXvi7JcGduKY7J6Tra060+YL9eKTi5J/zjK2LslaCra7uKoIJXxkf23HtD4kja2Rum+rJGgzd/+3C0drnFY8NYvB2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MqDHPJaA; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koFVJGc94roRRaN1sA/J0gHNfCJzgNh40vTgz48EjKgMQvRJnSpgKOsX6wo6R/2tyjGsi+fmcw//N1Xb5/CN4j8jtaLb3Ojk5RwabSdwwE1Ub31pOGVtsvB+bopZl/8HFxQtDEnm0dvCJKoYEMJe79P479NIIlUut18WUA+BIkP2FEzA7HIEOthcVJu7OaL6PTG298mq68pPrDJ4IqDq40ABzrT8bi6Egy5OvJiVqH0y4ia4KNAo+1v25SwmS6V/z7Hw+1Vb3yEz0B49O60CidLgQEuDW6mrdwOxcSbznfr739CncvKFjZ1QOeZf87ODsfd6XmpghqrDTcBuSW6fGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynP9mA/5Tm8kNIomw785iq5NS9OeBZIo0Le9u7Iizu8=;
 b=bP8FA64WocFknjxXas/DXK2z7iXYAqSkcCUnCJUoDwwNI2H6S2my28j/+fewRCthwjyejcrsyJQm4dTAtO9SDiB/IT/CGRavARUVr9B5hdKsmoXBA4SJ9CD4+MIsIpV46E5LERVkyw6g/H6QqBuPmJZ/9JJk/+kk6GAE8BBNwlzVCqSy30rNWnn4TtS3kGV18Zu7vujGGhxZ9Vmj9i+lRCmO9FqFbWC4PaSFPEci3yMadi7r5mOrT5xBPMxw0pjbd3VI/Sy3QGYmhN2oNs2kiCkwHxY8B4bOFJqE/77DaPGBJ05DQqfjQ+XBrT6i9m39BhEZDG0HWk4LwvisPIsK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynP9mA/5Tm8kNIomw785iq5NS9OeBZIo0Le9u7Iizu8=;
 b=MqDHPJaAKA4ZdEAjMkkGBpoc0hZrFxxnCwOMEm5NMZs1dCq7akuG/LDiUWcOqCRU42Z7DjqiKw931+e1uLK+eOBm7u+qwup9GGeViTGve377mh20T6xl1DQBMgx2Gqyb8fxFoTvcJ8coginMlHnyYMoJh5anbTJwmlnlrFpBTyY=
Received: from MN2PR19CA0070.namprd19.prod.outlook.com (2603:10b6:208:19b::47)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:28:06 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::dd) by MN2PR19CA0070.outlook.office365.com
 (2603:10b6:208:19b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 08:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 08:28:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 02:28:05 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Dec 2025 02:28:04 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@amd.com>, <git@amd.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:CPU IDLE TIME MANAGEMENT
 FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: [PATCH] cpuidle: zynq: Switch Michal Simek's email to new one
Date: Mon, 15 Dec 2025 09:28:00 +0100
Message-ID: <ebfbf945d90b0efff3ce0dc17fb7f1f0db5b6628.1765787278.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=michal.simek@amd.com; h=from:subject:message-id; bh=Uzr2aCZkqTE/xUG8OWk0O0oOsPG2ed2mQS3kCRqou1Y=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTaH5vEVCii1qDVLGfRu9bCqy1C+7+G99kZv81uCUk4m O10tKrrKGVhEONgkBVTZJnOpOOw5tu1pWLLI/Nh5rAygQxh4OIUgInMO8XI8Pj2PNtK3/4k/Y2r XitrBJ8397rqUGfK1fNjp3nJM+b9txgZ5vXs7J+W8uPy2bKkLpGuWrEpFV3BU6zjLQSeOX7IVpz LBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 082ce1a5-828b-4ba6-8e20-08de3bb3df43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X3dGWzsRXtYzqmZ3ozZRiL7uyxbOTDs658aV03j6BRce60veZIiPaFhN2esD?=
 =?us-ascii?Q?R4NLlpdPkIWArad0M+Wma9LCt9Blr3K8parSroh7+BELSlr9YfP/ECSYPK4N?=
 =?us-ascii?Q?m1QU8jGRBl1mi3VbuCbLyL4yewXoM0hFzlO13VSWz6y4KjfCFxEpjfUo6+jd?=
 =?us-ascii?Q?VLTrx2DrptjF4Ow2fnLpLnwWApuJhpEmbk9rniwuxjVymvaHVveZUfwaPRAX?=
 =?us-ascii?Q?fvm3RZaopnborRaBPe0IMLjePlHoQSHgM/LjA/tBgjtUtBbOAwfYOxiXcaLL?=
 =?us-ascii?Q?YzwPpVy+bd8DEGLeMjJcnmaZoYcTKkec6jj6F5iFMDLt1ctS4xrwL5VA8xWi?=
 =?us-ascii?Q?pux8jdqefvLaE82GNVpEITnb+U5VU4zBpL2eh+1C9jj2BbVeZU2cgRVV7AnW?=
 =?us-ascii?Q?aC++sRozt1kWPPlt2ulBBZHuXmLzEuYde3qEzU5mYIwZIhgQsXdk1otXwFmw?=
 =?us-ascii?Q?na1C/U8qS0DWr3KLYGZdiYVoJwQB3Xjl9K5TB4Vf5NNAOW+5FKMc3AWbfrtt?=
 =?us-ascii?Q?4W3yQDY9SNxDYNo69wCS+uP9tsmjBKGOF9QrN765tvJx91Ly5erxw+DknBtz?=
 =?us-ascii?Q?2cavmgU6lY6w5DKvNE/u8UhS37bJ4SSSg7AyBX0qIwUA5gvs9ekcjIV5ha88?=
 =?us-ascii?Q?8s9jjFVpgDRWTS9iem7Y80l83OAn9sNsCnkqVXLTinGnBFP5JugLFJQctFnt?=
 =?us-ascii?Q?W+bDbVWZaOXZ/3OOD/0vfJdX/7JluMIwDP4BjvYxvAkKdCaaI2jQdb5eyEoi?=
 =?us-ascii?Q?1AgjugzRv8qa3E3B9NQR4GIa9GTkr/KXxqANfygSHdmsaKje7xmg8rYIfmnK?=
 =?us-ascii?Q?YEHqYFhxQdZO3TkXcI9gGTpTsZuuHuljwrTQQTvZywZA/TBRUU7qYAwFWbKO?=
 =?us-ascii?Q?5J4AqKjSJmNSI5dB6qqD61QCwz80KgY5nM8S+QISUf7TQ2lZFOKLkOz0GqCT?=
 =?us-ascii?Q?iNjCWl1qbNqhnD5O0BspTS+Kq0uVW1BL+LPok6j6ocT2A2lqKj9xqqgtg68n?=
 =?us-ascii?Q?A93zm7xgmNqut+2CGf7M6RwH6SkHIHLPdoyq8ffUI+ce+QjUvqtyNR+lQZs2?=
 =?us-ascii?Q?DFJJh0vDAcAykA5KdexuwEWBWWLJ+vYr8AO/QKbdK/OpD/zREeDstn7CZwRz?=
 =?us-ascii?Q?7A+qRBtLgU8PhHtmB0XOmFMDhJI/AK7IrZD1gR0bjM5tx1wkTbEKGfToytnQ?=
 =?us-ascii?Q?7S0+DKXxu132By+H7oOSE61SInia3Mw2wmO5CcgOMytspw7IethTN7A3So4C?=
 =?us-ascii?Q?2FDYfcpQirbJW4ihJoSko3bWnMx14us1hk/gFmSo3XHHfOLjFjQvDVnmyFd1?=
 =?us-ascii?Q?/+wOLU0FJGNL2XwdAlhWj56JuWw7/tIjv2cNZlfD2oR0SVGHqbafn8XbEQd5?=
 =?us-ascii?Q?PDetNaJvI4OFTuoUZIySFNXcro4+yizTozyWPilEveyCM9XxSHSvVVsjlnk7?=
 =?us-ascii?Q?fVSe4b5suTX9E0Nj3CpgWD5Do5f00k22ISndXx/bT3S4uwOn/bkpAAoaXfZJ?=
 =?us-ascii?Q?iwqgD56MUuGgtIV2ZNbvE+LJO8R3sugb9WXiMGHdIK4j2Kp/meeOOp0Sp7Dq?=
 =?us-ascii?Q?N+907bds9puQtikd4Es=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:28:06.3770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082ce1a5-828b-4ba6-8e20-08de3bb3df43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/cpuidle/cpuidle-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
index a79610e723b3..89448ae4845c 100644
--- a/drivers/cpuidle/cpuidle-zynq.c
+++ b/drivers/cpuidle/cpuidle-zynq.c
@@ -11,7 +11,7 @@
  * #1 wait-for-interrupt
  * #2 wait-for-interrupt and RAM self refresh
  *
- * Maintainer: Michal Simek <michal.simek@xilinx.com>
+ * Maintainer: Michal Simek <michal.simek@amd.com>
  */
 
 #include <linux/init.h>
-- 
2.43.0

base-commit: dc5aef63c037562500723d0041e863a092997124
branch: zynqmp/soc


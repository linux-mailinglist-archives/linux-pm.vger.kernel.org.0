Return-Path: <linux-pm+bounces-9922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E897C91591A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 23:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D5D1F24502
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF21A0AEC;
	Mon, 24 Jun 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OonNLpmq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465E1A0AEA
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264868; cv=fail; b=uHyRVtX9ipn5pAOKaDPTzm4NSW0f/gPM6CYRgOfkAt/VHAQMrxf1i1chEBEtow/zuaxBUaTZyvxnyH1NmJrTYnlA6O0CqZVR5YNeT1lK6frW6EQ+f65VJ0VMZj6T+aXt/yX4y4RkM4+AsB2U9zOHPUMr4zziENbMek4GKl6TyMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264868; c=relaxed/simple;
	bh=fIQTwCttE/A4pglNkr82i+yZLS5IOMvs6RHwNVyGKZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNmDQBqchSqRHtPeFJt6PZwdQzZdMKWLgoOels5zoaNOBSm8vLJugR5xRojNxEU81GuYKBp9mEhlVk/1/dSwGjMNyoaCPQITSMP8UhV6cKqhyFk38d/PHs3PEH8h9OLu1MgZiuR+4X1ri22bGuPnTcLxoRtGU5wuyRYGiRvMRsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OonNLpmq; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9Ych9IIm2yyxYTDTjJnDBWUBBXTsBbxZIqsviIhcLi98wmQzaLOkyhrgQA9PJe2x5zDgUP3/2fqRuPW61YZOfvfNmqyXEWYV+rinwin3pRgFZG8A5HyqO9+w+92XBp1C/BRGcXE0HkUrc/Z+kUzHmTSYw3o4ICFnz0c6E/OI/FFYEDru+JMl3t7SJP6DcqD89KVUJo10CM6FOg+U4ggAAkFaHFuf9swld4dBvrkU06i7ZwpOIpI6MCOst61DyR3Om0jgryf7iH79ccvbFeLsaRbmpV4uAbTdvcLUDxSK6tS1K0ugt9gjn/di26yots6yRtVmNXF47Egl0tqhPkNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVqeQtiD9MCl7lMNezx9ewTX60OsAAfE96+3HzzKLYc=;
 b=Ahlh61rOs1AEbQNrp5SmYx13U0uBYkOfQ+k9X5n29FO09hRoAiZUuD6AfRy8Dw5EwJ4cAP9Bd2kunvGLPAbg6Gn4qMbFAIbOZYt7G9poBE2pomO1QW3u1P4/1ICrAVSCrwXGf8OHDOV1hec9ad35P8utLMJCoVbnAxDnz22w3PNQyhK+rfxAclZHAez80Rbq8j7JzAAoLC5g1iiXQzOQB2pbaHFy48AQFGUtuHqh2eOaZcf7dWO1Yy3YnmqS9MPCRNnZQKACwb8uqT0c4QYExE1wbk76AvoIbBin74ZvO1JV1oLhUVwNkzd+JCc+E+FHT0MibCYwwxftQSprR/Q9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVqeQtiD9MCl7lMNezx9ewTX60OsAAfE96+3HzzKLYc=;
 b=OonNLpmqXGnyGg2GhwUXJDPC/SQ1N4u8uJWmugQuOESvAzXnPqU7aq6mSIa7xVcsKLhVBBhiJmLosLTzhF7MEljjt8/Q5uB4flYMasWl3n5yVv9Ks5kTkuxyvHPaNSgHNh+hhm5bk3zJYqtSYRw6kCpEH+IozxwHNrPFRK3L0QU=
Received: from CH5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:1f1::13)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 21:34:21 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1a) by CH5PR03CA0015.outlook.office365.com
 (2603:10b6:610:1f1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:34:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:34:19 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v14 4/5] Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method
Date: Mon, 24 Jun 2024 16:33:59 -0500
Message-ID: <20240624213400.67773-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624213400.67773-1-mario.limonciello@amd.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c31f58b-b9ef-4553-349d-08dc94956958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xe1LFl5KRvU3sIyqGWxlHZLY5Jglq6lRhTdKqMTwXNL9MJqipbmtF4tESM3W?=
 =?us-ascii?Q?0LzvSRWcmHvJu7yWfK7WxLQZPY/5g72uRJr4yxwLMxG/5GEF1LbrVLrADI7o?=
 =?us-ascii?Q?lYn7x7X3vGG+lrNDc1Z5zok+rpfXZJUofiK0bHstBgSjmhW89e1gmVKv1u68?=
 =?us-ascii?Q?pPM6alLRNiwGNUswlPmSlGpiSZmRN0s6k7KiKICt/xMuXJUAiaRf4uSnBWXK?=
 =?us-ascii?Q?A0M+2l/horS0UlxKa8p1tJQzpxfXXM93Qs51cccHwZb6HP3W90cwY9S0Sq4V?=
 =?us-ascii?Q?hJWGwSh8xpglUXldje0TNjPfcb0f398WaPVj4uEC7BHu/QFKOg1VEoLfIfcS?=
 =?us-ascii?Q?z8C0ZYXbHb/m/0gPaZgCDF+Viy71euAKBB/01BPekrpxTO4SPsVYAY4lXRnR?=
 =?us-ascii?Q?MU65iA8FUa+ybR87mvcT8G9z6kflhtprUV7OfOz6NogXwSwwfvqrm14QwR3a?=
 =?us-ascii?Q?WzCBbxzXMYDk08SlVYxNnkUK+bN2LqpqHLhfDluPkWb5wvxQO8VDzGi5i7zl?=
 =?us-ascii?Q?Cix6uWniPimytCwRfr4arENsuX3HYzsBcPyuPdQ6O+XJyT9VD6rrJiS+KPIv?=
 =?us-ascii?Q?wIgemDMRqRdKMbu/vqbebgsj33ws5873Yc6pD3pa4qOceVLnVP2wpTJ1aaD2?=
 =?us-ascii?Q?48WvyrlrJjsAK20GVqXHsWSRonoi7psWdha73ERmdcrvgSO61VWfsiWMbHKd?=
 =?us-ascii?Q?ld/Fm86GxLgrM5aTOYmSLwgjVwIb2NV3XoZ5nb3yRMSONTxHVaUwTyV85Oz1?=
 =?us-ascii?Q?vCfnXHOmNs4bYaVB6Ry72y6lqaMYd8fv3LSK78ooNSQ01rj6Gjd/HmpEzism?=
 =?us-ascii?Q?NcnmlEwMlJEeapKykxMM7SaIhtsS+OssmBRLHElsbeSW0e3KtwmbIOdFhC63?=
 =?us-ascii?Q?zkqIct3SweeGFLLPqYyGQOfkMD4Keahau0jlkqQfGRJoKyJC/weEuYcHJI6M?=
 =?us-ascii?Q?L0pXcRgmq3qLfIBAUMYREpVAW34CEpIABAC8LKlEt3j/5kwThNHHjQxalUd0?=
 =?us-ascii?Q?ELOfENk0Yv95okn/jkIxMzpYjJ2npizJvFJ1L0TnKngnqrcuMv1hB2DMKiyE?=
 =?us-ascii?Q?N7w+0YjmSwQ9UQ84aV78+yRmot0qaP9erax/v4PRAT4P3a9vFs+vULOfO5xd?=
 =?us-ascii?Q?gJAfXDMhQYLe9+242E0LD0HvfY3I+cj+UIaGZuQvWDPxEEqHMeXpruvy0TTn?=
 =?us-ascii?Q?HHLinHzOuz3nIhZoYNycGec9VytVnoV6s06BR3JZPcodXBw5u58EnFtVcebg?=
 =?us-ascii?Q?ON+LhascVlD1qy6u6sp+JlAKeSy0f1lIpiADLL0/otYlsDwI6wkYuTlxIcwz?=
 =?us-ascii?Q?yLjlSmEePhc/ZHvDl0Q6Ph3y7Crw94XHJPpbacruKZayJWnOCOPiWCSZNlfL?=
 =?us-ascii?Q?gABevL7UN9BIgSkJ8JnEJbwJvtzPQBZQLRGFZIY0DcwH326fAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:34:21.7256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c31f58b-b9ef-4553-349d-08dc94956958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527

From: Perry Yuan <perry.yuan@amd.com>

Updates the documentation in `amd-pstate.rst` to include information about
the per CPU boost control feature. Users can now enable or disable the
Core Performance Boost (CPB) feature on individual CPUs using the `boost`
sysfs attribute.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index f5ee81419a93..d0324d44f548 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -281,6 +281,22 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
 firmware, if EPP feature is disabled, driver will ignore the written value
 This attribute is read-write.
 
+``boost``
+The `boost` sysfs attribute provides control over the CPU core
+performance boost, allowing users to manage the maximum frequency limitation
+of the CPU. This attribute can be used to enable or disable the boost feature
+on individual CPUs.
+
+When the boost feature is enabled, the CPU can dynamically increase its frequency
+beyond the base frequency, providing enhanced performance for demanding workloads.
+On the other hand, disabling the boost feature restricts the CPU to operate at the
+base frequency, which may be desirable in certain scenarios to prioritize power
+efficiency or manage temperature.
+
+To manipulate the `boost` attribute, users can write a value of `0` to disable the
+boost or `1` to enable it, for the respective CPU using the sysfs path
+`/sys/devices/system/cpu/cpuX/cpufreq/boost`, where `X` represents the CPU number.
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.43.0



Return-Path: <linux-pm+bounces-9994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BE9917726
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC901F23C30
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8B13A404;
	Wed, 26 Jun 2024 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a7hQRUqe"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DE12FF6A;
	Wed, 26 Jun 2024 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375122; cv=fail; b=GTLhDHPcJdxflP01TaGw2sDgmQKldpqsIihR2RWBgA2aaTGxbWneOYZEbRP72/d9uHc+J9lYiHqE9c5TX2fG4ZDOXVLTQfkMmQxdE5jjKTCjt+M6pB12xotqHCS9qaFbNPcpPO1hVSm2uBncUp+nFHxDY2n08vY0+lKCQrNlAPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375122; c=relaxed/simple;
	bh=zoaCEGiBVG4BkCAuyz0va1hx+WjFNNlxoijEVDH4t0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8llSnri0yEHK/OGAPss1XrtDwglwo1KevnMJN1eoWaunyhuyPEsgvIVqcmV9KOTJpxZ6H/yfkWQYG6hNbkmHRVluZBmGuKvTIh3eY6KE59g13Dx9ZM0rwbkwdyyjmkz6JYcpc/JTJyvF2sHYXf2gRPOzOxcI1CaOTItRSPjMbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a7hQRUqe; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0Ij3KNDp6FxD0wqUX8t86r+oxQPDIGOtLto+gOaK26zPJQZXgQa4RaYZoyndpOILoZ1j1lmPI15Y0mqWJvaeMebeETSY9T2eqaess6X/DF8GqqMZRsAISRTa1rVukZ9cFKe23vKWiKueQSt7K7JqvgDesvuouF6STlFMROJD6cPVpO43fej6RcoTF1Nng2XU4w3qtZYgJIwLRRTBD9GXGyKSmkM2C6xfYX6gP0H2smYB31Szzy5JYNzCgEK1+5quQkpzdMJ4qn/TXAj6VuXekjYLzIwh26bTId76EJQLy9dfUEFEZQjeEUICYGU24BOqD+uNtn8FRnTp8h3LTjwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaBuk+0E3owmR4eT/SHgRaPJHp+0TdagQL6JbuoROFM=;
 b=k9/OaIzq++xTKVJhIPCHZwNbmtLthCixRGO8EzQzmwZKgwImQnTYYOTQkvY2r0bHULzKfwpsjoRTCKISThtUDKhYHvpbHEDkK/B/4eEVRdx6MGOwW/6EzgKRe3W5YerzXJ1GH7SpVz9yEO4kJMuWNfT9c3b2cQVsrIJEx0Vr4KjvSsKZL/9x7K89eVjgH9u+PbA9RkBH0jICTiZeMO3Vql6T0sJaubwkVDHLkNFGKU3QU57Pp7Kj/QUaXKHwU+HGm+nNs64LJxBgss3caU5uGYmjlO/38jcc55cwUFu3BZrj/xT4m1+hM3qAvsfejbUig0GdrUxGkN4GHHjUbuuspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaBuk+0E3owmR4eT/SHgRaPJHp+0TdagQL6JbuoROFM=;
 b=a7hQRUqe4wuckPpymObQ85BGfdIsAkhS12x3U5nlWfBeoINp71rZuRWgU2iJt+j5sJxDYDuz1V+5TyMSbbZkgNwhex49FPjLevmWkNVBv96kYXp898I14vykolrz4TaadmWsKqLPq91AoTFVowJk8cnNU5c0aRsOfq68EpjsKy4=
Received: from SN7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::8)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 04:11:58 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::20) by SN7P220CA0003.outlook.office365.com
 (2603:10b6:806:123::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 04:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:11:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:11:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Gautham
 R . Shenoy" <gautham.shenoy@amd.com>, Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>,
	Yipeng Zou <zouyipeng@huawei.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>
Subject: [PATCH 1/2] cpufreq: Allow drivers to advertise boost enabled
Date: Tue, 25 Jun 2024 23:11:34 -0500
Message-ID: <20240626041135.1559-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626041135.1559-1-mario.limonciello@amd.com>
References: <20240626041135.1559-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a1c4ec-fd1a-4726-7f01-08dc95961f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5HoaPvSn6NKKNJtuIjatScue/S/9zfsWxjBCkh9vblfIlXEyodnBZRLUzTz/?=
 =?us-ascii?Q?NURGWZ2YyFazV8P6o262Bw1K3kOfJ8/CxCH0pkF5ofOtrKQ1IRm+lqlAjAuJ?=
 =?us-ascii?Q?rjlZwuHMFUmN3ycobEKE2Z8piuuFwMII5KFuYXPgWZqFzrR+sX6wmp9c0pnT?=
 =?us-ascii?Q?OURCyHd12sG+pX1q/FkRT04L/cSRKTzGQB94bmiTYskgaegDlj9Y4tuE1oBW?=
 =?us-ascii?Q?MzNOwvL3WAOEZpTTqccZ0plrrqiIJToc5CFkA5A8znh6CIXMMoPOJaCynxaX?=
 =?us-ascii?Q?T1PAL1JrUZu/MePSBMOP8X8icsyFTUNGGvCUaPx4A5HZaDq8TCQC1gl3r0nW?=
 =?us-ascii?Q?wLU2AE3Zw1MEZ5JPRD2yDI++NHwmXhznDkFcgDvTe0ezt62m7As1GBW8+h4W?=
 =?us-ascii?Q?/L63+HDTMJb8YXNrXDVHFI3CgWXo4kQ4ensqEisgTRWfx/jOPRxSHA+TWsPx?=
 =?us-ascii?Q?iBq0XYvHXYuVcXcE5xKCow0jWNQQeMZkUjkUoOfGHWzg9DRtxEJXpZJcnqtm?=
 =?us-ascii?Q?AeqhsD5xpHmNNCCnPB1FfYMignhzOJrXUJZdG4dG5KXQiB5bmD2W6nyPvd+5?=
 =?us-ascii?Q?8qwIZ+5VC6XpZ8cg0LpkAYrrIzHKYMw6bRINN2kro6pJOIoUtcDp/g6HtkDK?=
 =?us-ascii?Q?OAVxDFX4GEK077sBHWdOQ/s4CEynLPVkrL1vX6f3TyCYrSTiy/pd+PiRRgrp?=
 =?us-ascii?Q?T8bHpX6KV7XslwFtajOgRvZ4T4ROu9JaeYDVRagIyI3Y6Bmjd5C3puH4Ebjs?=
 =?us-ascii?Q?WrRfu6Jzo97A9igzkYvruA6eIBrM33/Db/qmDaF2jjY5LFnostJDyCb2sxid?=
 =?us-ascii?Q?udkH7UjwDGIwNYnbilWhiOPJozPUdlFqiS/LekMSOUZsNn6ugi6DXMiya31U?=
 =?us-ascii?Q?akwUWg+SPhEXrgMIYsoehpN53V6vDL7K1+HK815ZBTrVgTwD0E2a3hYHgXlc?=
 =?us-ascii?Q?WbCl8N/KGcaf0F8JNCaS4A9fH2E3dticwlc5Cxufq5risnvnApF/gPo7/5n/?=
 =?us-ascii?Q?r71toJOqk609z1Y7cy75i5szor5+1Fvmzw482k2u2AhMEHLb40EtVxsm+QWR?=
 =?us-ascii?Q?RLKwHZONCNGZTXAL7oL4HthxsUFA4Y2hzj47onyjkkwCYrVZHAYCpjg7cVFr?=
 =?us-ascii?Q?jQvlDVLpJ03unZKsBcv1Gimnvo+Kb8hk6Kvr9s5ZMyqDu5brzfTSgtJ5mUAO?=
 =?us-ascii?Q?Yv3YgBIiIKndsQyywZ7yVeTOju587DTVsgn1+HI01j8D4tK21WFuNtDGqZ/j?=
 =?us-ascii?Q?TEqNd+wgWkwy8e/iJdLzTty8i2PSW2oW7MszBGcrmpN4UkzpMonaOzqUU5bd?=
 =?us-ascii?Q?abDAhF9nMWyQxFJr6V1T5mmbl6G0WQnL7iS54yZ2kphnYrRLuHxDhvaAe4Me?=
 =?us-ascii?Q?+CoddLgZn10CwG50HhN1qjdViKPiPFPyLRngs23MXxtzhFLPDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:11:57.4074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a1c4ec-fd1a-4726-7f01-08dc95961f1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355

The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
policy incorrectly when boost has been enabled by the platform firmware
initially even if a driver sets the policy up.

This is because policy_has_boost_freq() assumes that there is a frequency
table set up by the driver and that the boost frequencies are advertised
in that table. This assumption doesn't work for acpi-cpufreq or
amd-pstate. Only use this check to enable boost if it's not already
enabled instead of also disabling it if alreayd enabled.

Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
v14->v15:
 * Use Viresh's suggestion
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1fdabb660231..270ea04fb616 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
 		}
 
 		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
+			policy->boost_enabled = true;
 
 		/*
 		 * The initialization has succeeded and the policy is online.
-- 
2.43.0



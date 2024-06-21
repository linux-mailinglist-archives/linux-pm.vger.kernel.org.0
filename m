Return-Path: <linux-pm+bounces-9780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF2912BCA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB12F1F24CEA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CAF16D4FF;
	Fri, 21 Jun 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oPGrUMVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27316ABF3;
	Fri, 21 Jun 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988693; cv=fail; b=Jso9792aDKtiXIdgOCzmUNhGPFdQ89gwVuousjSHEsgzyRZzPtrHwKvSoz9JzG1Uta/hUjDcm4Ify8n4WrGJtR3AY2yhRkafCF09aePOzjS3rfUiXzbV2CQ5VLNnN2Y6Q/Q/yNTFbmJPHoHaWr/z8z/eq91BJQR7OxSIgYvIIZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988693; c=relaxed/simple;
	bh=VPnkaK6QQZKyd0qyGfloYPwag1g/W8qHeGJbJPcnjN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDWziIdRISbY2uplpPdrIORFMgdSlNVY4wCa0UYeDbjsiLehxgVsLOEKvYtJipTNd6YmFhrZ20G62NVV9OtDImN48ne9VanKcp3Tcq5ArWzOGfitFBgBSsmUfX0vN2Y8gTmv6XUDwzN8bfWssgmroBVr93M73jk90JN+ODMoCoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oPGrUMVa; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcGCZ/7FTSHsnCapcKnPN7N28FZjPTKsTlO/W4zc6sCPhVfNEWIMCrDYJYXeJzKwgqOM112WGznhM6pj0yf92KTx9PBKEgUmZW5chgVs9AMBpUrzU+b+tqRvrPMLpciBYlLgyxZALD/gpB23AiiHdwew8mvcERBGlbko852oKoKlngh9rMcpu7RkpIc556ksexCQ6ZCZyfvnNYkotUcFkS/tuVaBq8THLRtU85eFV3HUbZ2Vtpt0qNBO4P/gruW2nxt9Dy7IYF6jUWtPwQG/Gf1tdMZBP3OpV24cjKdeRfteA8+92jtGBxUTZNvn5CTeQyRKH0mA2k34h4+vG0qf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkBgW1FoEz+y4K0wWUhOkxzqKaui0JxO5sx0rMNUGyg=;
 b=LLH3RoGlDT9yOwzhskE4w+7Z3RRh2/Kss9bmRSO3tArYBwlSkeXoDKYqJxcPKfgNXW0cFTHSuGrsLaJVjmD49P7WRgN6udzE9ESRyWg9VAwbQfFnxr2xx4ydYNWemZBIlYRiNL15ySL2bsjWhCJ+7aKnB/rk4mCi+ikuOyuorgQcg4GArb1aLoq53yYpB6o+QoKpo7rmTlfTMKQnaRuME930vdTgp6TAEWPaAy/cHpq2RCJ94bW4qf0YDjIo7NqjxE3no5wf1TWF9xeqQhrZkXBvPRuF1dRs3xzASGThoi4HhzrwjFjhtJ1W6gG9XHy15ZX4oWIrp1bhXig1KjwDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkBgW1FoEz+y4K0wWUhOkxzqKaui0JxO5sx0rMNUGyg=;
 b=oPGrUMVaOzbPDiWZqkKBFApLkl+jLnd7Dm+Z5A/Bjqh4hIe5YtnRF39Ig6Fl/FtfAPekIBni/TJL4fbxlyfGM47cRPFxs+m30gYbDb0TFZvsTT9taR+IqEiH8wz0x/b8aokqHtINJbPYFCtYZ8UTHHe+B37xVsTSrVtj5l98pvk=
Received: from SJ0PR05CA0191.namprd05.prod.outlook.com (2603:10b6:a03:330::16)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 16:51:28 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::37) by SJ0PR05CA0191.outlook.office365.com
 (2603:10b6:a03:330::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:28 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:24 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 3/9] cpufreq: introduce init_boost callback to initialize boost state for pstate drivers
Date: Sat, 22 Jun 2024 00:50:58 +0800
Message-ID: <fef324b46625e5a9985b0c0c1bcfc05067d40e36.1718988436.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718988436.git.perry.yuan@amd.com>
References: <cover.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 01172b1b-ef7e-42aa-97cf-08dc9212652f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ysg90GrcWHcvU4nzuULA+osMXUyXhDo07bJ/Y5YmFfD0OXH7z8eIRAfLYisE?=
 =?us-ascii?Q?BAMHkV0We/4QO/n81WY6L7kHkRI2bvUQ+/JCvQUdkL1WVS5QonlwqEvqBupG?=
 =?us-ascii?Q?bRj44VPCVAnEyAAz5Hdx7C5LB0g1Ry4kN1+YnuWxY068aJEQTkm0yaZmGpcG?=
 =?us-ascii?Q?VQo75awWcc0ndnwloDbwiV5DMzOYoci7ok64gh7KsC6QexXLRSnwNfjcTdEC?=
 =?us-ascii?Q?kpFGG4HgDN8xjr+xL2iAyT17WuBBByi8Aluvdm/icxklRqdZKOYOUYnFQdCl?=
 =?us-ascii?Q?fPyh3i8K4JDHeZw4AWoVoajAKbyNC/2c1cgjhjS6J0n/pq4oD3vaEa1PsAAq?=
 =?us-ascii?Q?pv2lNRBH9pBlhbXeewcs6AwSqhoDLFLGJxlANoAgHFO4P19xqWuLdGueHpbN?=
 =?us-ascii?Q?bLu7OkCfMEpFnwTE0gRQTwb+Yw7AeaQ+ai3mxM77vpmlnRXlyAcdr1eUt2te?=
 =?us-ascii?Q?F4JftWeVrE5RrRjuikZjeNfc1EgUWZQXDszneHR1zmWdXQK/WmBO5QWtrb+W?=
 =?us-ascii?Q?BdsVMRkjNYE6aEWC9lt6Y4bl3ZkqgijLey07+bQ36wCyeziuk2zVGZ94O5iM?=
 =?us-ascii?Q?+80G0FzVK9saKujsqOlE/IIniDOsRbqVeXMamb3sSAdDszAWXCUWxfQtYUUt?=
 =?us-ascii?Q?jkSvd8TKets9XbvnN8NUju9t3pmmD+ckkUCWRVNSRFI7Lr8QkXTbzo9E2Buv?=
 =?us-ascii?Q?agko0haEernNQiy8VTK4D9K81W8c1wmp0LIL4rduX8o1t9khn/+Lbo6EhUZs?=
 =?us-ascii?Q?QNmPeYMSlufX/IkMBxAUwKh+onNKSAfNeU0WYCqzaaGHeeRRuGJQCUWfUyH1?=
 =?us-ascii?Q?vuyBCj6G82KsOJjSzx8NlOTD7ixwDu+CXMBsw4YS6Iehm+mzIXYgM/3f9+gc?=
 =?us-ascii?Q?LPi7xDYAgzCkCEWZxFfSSS7SQgpj8TshCZRldRoFjphstiHor5+wTgSbcjlD?=
 =?us-ascii?Q?OCAhru/4JSpXfmSu71KzErz1qRqXLDfCFuer2SR11+u9/okK8SJi1nXf2tIC?=
 =?us-ascii?Q?1tSS+I5aQ756w1fVUnjiCpxOYOjyp1xNrWBbXsUktoS6NWTQEZfi1tKIdLFL?=
 =?us-ascii?Q?v4dKSCOft3V7apCE/CEiv+Tqb/HBn55olJGh8Ez5ilwQNovc4zXFCPvqItp+?=
 =?us-ascii?Q?0WFEAf462Rs2USnepnR6FWrq5tL5nIlqID42IzZQ79uMMsN+YCZ9WsLM5OPs?=
 =?us-ascii?Q?CQpDVS+y7VhjX76FhcvIwwGr/T4QGfegbgsk4JLyGz0rs2UZLYaZ8tsswgyl?=
 =?us-ascii?Q?asGIx6flL2ygpeVqXtDo/LjNCTfX/gxAPxKkEWjeUFqZmuZvOt8BVNVxrThY?=
 =?us-ascii?Q?+GDM3shaDRAU2O7C27YZY9P+QJ8gWZ/Le2X9tP/vWEBEExTkR3sVIBbCsNki?=
 =?us-ascii?Q?6nH7jasr5rhg/qMdg+MCm/JKFkkXXzjUjlZIF1UhFpaLlPxbUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:28.3046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01172b1b-ef7e-42aa-97cf-08dc9212652f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

Introduce a new init_boost callback in cpufreq to initialize the boost
state for specific pstate drivers. This initialization is required before
calling the set_boost interface for each CPU.

The init_boost callback will set up and synchronize each CPU's current
boost state before invoking the set_boost function. Without this step,
the boost state may be inconsistent across CPUs.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 14 ++++++++++++--
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1fdabb660231..0c99d2dfdb53 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1429,8 +1429,18 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
-		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		/* init boost state to prepare set_boost callback for each CPU */
+		if (cpufreq_driver->init_boost) {
+			ret = cpufreq_driver->init_boost(policy);
+			if (ret) {
+				pr_debug("%s: %d: boost initialization failed\n", __func__,
+					__LINE__);
+				goto out_offline_policy;
+			}
+		} else {
+			/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
+			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		}
 
 		/*
 		 * The initialization has succeeded and the policy is online.
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20f7e98ee8af..0698c0292d8f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -409,6 +409,8 @@ struct cpufreq_driver {
 	bool		boost_enabled;
 	int		(*set_boost)(struct cpufreq_policy *policy, int state);
 
+	/* initialize boost state to be consistent before calling set_boost */
+	int		(*init_boost)(struct cpufreq_policy *policy);
 	/*
 	 * Set by drivers that want to register with the energy model after the
 	 * policy is properly initialized, but before the governor is started.
-- 
2.34.1



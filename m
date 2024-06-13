Return-Path: <linux-pm+bounces-9052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673EA9064F7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A231F2465B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A6113B5A5;
	Thu, 13 Jun 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y1L19VD7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6513B588;
	Thu, 13 Jun 2024 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263554; cv=fail; b=XfkBdtCXE4ccOqytviac+b75qlvkB2FnbWJdMT4ww4m0Tn0Z27sd0LHsBZHpVTCD5QiZvWUeUxkIf1fdOfoxakSMnZhRMLxuSF7zvauFs1dKyIfoSaWurN7mgIKZpFdUf5l5gV9b8ikcWc9WSlAvM5PYxI6C8PmWwJ1I7toKdw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263554; c=relaxed/simple;
	bh=jjFQc90GHno+HdVLSHzRJBiHljwU9rcmXZ5lPHIRUZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0OcCWTeA9uzACA6KFWGB8vuUD/1KkXeGmAgcTH1BRZVcYUtlqPmO11x9O+VOrdjYKF9TJkEUss/Q3GshWpI56j5n79z9C9tMP54c5/6ZUei+cOU2qqaC39po0Bw2ssuDjWYBdtA+mmxWLJl5dZZoFziwGDYTB/tEJY1e0wFpxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y1L19VD7; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvNPOV1eMs73Yrgnd0nA+JV79JwXTxl62smq9NOb5Ei7z788pmh2hFxtUr7C8vpEPtwd1zbmgItUMVtaAPewP8V0VTA9RdzkHxVlyvfLoey8b2tOaKrpFdqvn1/T+zU5kcbTjDJ2JYxEbTOP23UdvarEg595Sbr14PDdPw8cqfW7sQvO2xBrgc3TPWujOffpxcvwrnRqpuF6jJAYWhZgGiB+nXP7hoYWGh7ju5Os0ZqsC3oBx3W61kGwlC+SMnYAPsOih+y6fUdCJQ1sf0cqIXo3TKFV6xfzlsKcFWUPYspoyerJK3WWxyevB9upy6I562XtYrWdRYpQjFPTw3mQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpzsXCzz+HmVthFkBZD+Z7pbeE9121Wka5BbkKC/KpI=;
 b=km6FNYdTW7nUtAQuIiD8ILm+9bKGV1eolm4LeM3twU+W9zDCyZnFonOqc6zx7ZNQMQ+4eKZlvCurx0nvg95LEiorntCYnTlRwLOd6BvNrF8Q7HaCvy/CcmyRHqp1lOd80Z2RTu6TZfOMIL0LwHp0W94Te6B3hwnARXNboo9AZVU72dk/rgx+quQLFTerrVnI8C7kKBy8KOX9vAUUDhEj3mb+W4pBzinrv5GVsxLHAxyDU/etZNxNfRCQnP7Wk23DG8EdV8GlaCb2N9SuEC/HAi2kJgu+MtwKOn3iTFNuWXH8YYDGN/ESW501tpaPzLw4ydV2nhG3V9L1BrHsf1hepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpzsXCzz+HmVthFkBZD+Z7pbeE9121Wka5BbkKC/KpI=;
 b=Y1L19VD7N4dl4BEZuDZz6UrpV4rKICxLlWxUI+HW6Bc4eD001cnXrknX+bRkthh6DB2DX4D64PJLe27/Sd2jf105NiCkU4snqTSaxmh4slYR1BLKaLbkY9kDg6Fv4K+/LS46z0w3tYStJf1SM+oRj7gcskAXbhXJoLVZ8jQDvi0=
Received: from BL1PR13CA0070.namprd13.prod.outlook.com (2603:10b6:208:2b8::15)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 07:25:51 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1f) by BL1PR13CA0070.outlook.office365.com
 (2603:10b6:208:2b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 07:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:25:50 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:25:44 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 3/9] cpufreq: introduce init_boost callback to initialize boost state for pstate drivers
Date: Thu, 13 Jun 2024 15:25:15 +0800
Message-ID: <688d8e1ce875655c344ac3b29876da5dc0456739.1718262992.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bee58b-5e16-4026-b996-08dc8b7a0d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|82310400020|1800799018|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAoJqk6ut58RXlDrwiDo7cgBOMrcybB4Svpg19kT0w5luVLreFwLcU3tuwxX?=
 =?us-ascii?Q?bAWzMCdIaEZ2eb41R2zJZOc9Rg1hM3dnAslBeN8XEdegPplWEUt0ffYseXUQ?=
 =?us-ascii?Q?JOf+xNsa5E9ainlHMKJHroPXjlWk8kpvRoVrDrx1/z5G6tfjBWuViMh9FOVI?=
 =?us-ascii?Q?yZgSr4bk2hwvmXb4XC41iCXEdK5EzhktCQVgSupt9FosO+yGBYWswkEJrCLz?=
 =?us-ascii?Q?GQnyJI/yra3s+v64572Ywg5qUQO3t0jsYUoE6ww5/B7PBluGOohK1RZ0IjTh?=
 =?us-ascii?Q?3YDgEBi9JI5Czskgmoa+BV0HZ10tE3V/sJhXHy6dTcx0WW5OQRQZZSSZ0NzK?=
 =?us-ascii?Q?2ybMyWcUE2fenZcxhq2SaTLvI5nulp2sNOzuLQQ8v+ZTL22SgsKLPqzPEJjz?=
 =?us-ascii?Q?0R9M22SWL71zlRZf/GhtozDbna6OCr3tWafXqH+dV+YAbH6/bMjNmdHB1+aB?=
 =?us-ascii?Q?mg7SjgOZZt0lfIHvn2X9JOxoragIKI9+6lTHxaTcVwqvWDrNYDLgusNiKAjQ?=
 =?us-ascii?Q?ovVYx2nHVFT1DcS5olRuX/VNL4SCpiCsjZjN5scYkCI5du7iUbuX4pqw6iP7?=
 =?us-ascii?Q?DRfME3H+yVtGnjC8c1tNHx/vM175hRvguCsC5dNIbPpfOCqfzuwGAaAFGnlA?=
 =?us-ascii?Q?ydMsQDBHeZDtY049Rj2mChqzwGD5BjFI/Cd0sS0TioHKWFbHL0zLINzywiiN?=
 =?us-ascii?Q?JVkHiGXnb3oyfnRO1F+7h1cbFUGDG6U0lHWjeXQR4pmFgJ2K1sWQVxYUEUoy?=
 =?us-ascii?Q?xCkN4yOB37xH0wgmlqaKbwc8KSsqjAqhGMSfnIfw8GPQ99NEPMcvIjLEGgVI?=
 =?us-ascii?Q?Rs03rZFiukjg/lUATCcaLJGH3C4Gd8ikT/SJoTp8FqI20BHr85Khof4hKVJK?=
 =?us-ascii?Q?3Ur6ujfw1+Hl2TyqxkH0FW8+SsMIHxCJhuIqhEMW6DTC53e4rkADVoiLCi/4?=
 =?us-ascii?Q?N+JYSq+zkHOH4pAsE6O7vFjzqPVnzsKINHsJ1fv7MCGgV5e57Zn0pBg48M/e?=
 =?us-ascii?Q?cib1WzH1GUxYqcP4Ad24wrJ6hGSHnp6cBPESZhYq+zcM+zMzLGD6P70W7OhR?=
 =?us-ascii?Q?uPR5me/Mnf8yR8S/9dYDdLEzQi3PO0vKmUTBDlKp4JK5H2pPAMWqGt7HgOUA?=
 =?us-ascii?Q?Px207WS7lUMQPbAtPBkjFLJ0Gx8LX/BMO3Vj1cqNzZBBzv4V/e/NpoAzmQqy?=
 =?us-ascii?Q?LV+kqYiij7SswGf9tVk/HAvmOVtDWW8RHoIfLJjGVYMHZRh0WOl0jb8g80aZ?=
 =?us-ascii?Q?8NqKq7glp1NTBmKiBpygxzCI5xjdv4ZrwXpjPjApeiuVQ1xnfAQQMIc0J7R+?=
 =?us-ascii?Q?twK8PDsVBueJyGfYgJfaelPVB6DndsXjdVuSB+/5icXE+pI+gMNNg22yVnYB?=
 =?us-ascii?Q?8nPgw6w+YdsaL130dSDKFKGAmrZGMHr33gkWCv2vxWiReiNLzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(82310400020)(1800799018)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:25:50.1844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bee58b-5e16-4026-b996-08dc8b7a0d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215

Introduce a new init_boost callback in cpufreq to initialize the boost
state for specific pstate drivers. This initialization is required before
calling the set_boost interface for each CPU.

The init_boost callback will set up and synchronize each CPU's current
boost state before invoking the set_boost function. Without this step,
the boost state may be inconsistent across CPUs.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 12 ++++++++++--
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1fdabb660231..e1a4730f4f8c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1429,8 +1429,16 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
-		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		/* init boost state to prepare set_boost callback for each CPU */
+		if (cpufreq_driver->init_boost) {
+			ret = cpufreq_driver->init_boost(policy);
+			if (ret)
+				pr_debug("%s: %d: initialization boost failed\n", __func__,
+					__LINE__);
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



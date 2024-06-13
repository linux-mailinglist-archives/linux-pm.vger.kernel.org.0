Return-Path: <linux-pm+bounces-9050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273389064F3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2A4B21ADA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9251313AA3B;
	Thu, 13 Jun 2024 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ct8foqGP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9913A863;
	Thu, 13 Jun 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263550; cv=fail; b=TS/GpJAXrsd0sCfu8K6a6nyighTLJ47MGTUTklb6+qz0BSB9FDOTrEjnTrbx8KJ87HgJhJrWW+HOZTTfUVqbiHvCM07zYqphiTcW+2VJpNj3eMS9z0KxcZOUtMl2m3f2FkPiW5RP9u702lJOKMDZw1OcSvi84o9bxqmm3VMZz2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263550; c=relaxed/simple;
	bh=vsendM3U+E9e6e+rLkMKQ9YDWjUbu+6LwfwzXrpFbso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0JjBxjgQ1dbEEENLT3eTz0pq6M5uioZkwdnd3Snp342MVOb4s5WbtADqncevHwjA7mrK+b7QgPLB+zx3YXU3FXUrU/iy/kJavCavNlKpKob9VjVTYZJHtlK8kFVW/56qx9mpeo04qIkaCX/aLzM9eX1FGHSjscCWQfXBCJ4ZRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ct8foqGP; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYf7GGt3yAs5PSBWYpz+R+yRLKOz2ALdDT5EgXRFF85wP0llCVW6tZbXHtJeHONzmSN2rwbDjTFoadpMd3Wi3wzAk5tDBAhOpgt87XNQEf6fqDISWVDpMyZWVvxohvq2clLSErILUAeMBuMPvZ+ZQJaG8ioNT9OvrurfMzdYniY1dE7d4qf9Q1HQwN0aIpKqmCVwXJ7UvTWHgnwcqfS+2cQuqkjDESF3U1JIy0QpjzdEVYFI0MvCld8eM/pK/AknZASSNRQANSURFHtFAxgKwei+TNJhUvf2c56KNljNwWO7iwD51tAmOdlukXrWjjvzbCH26zTWwv0BuWyYh3Dphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyuolwsbPTaRoS6mFUOMhmMWrDGNHcEtdcu6aMTmL2Y=;
 b=euU4hg0RFcME+CRUgOfMRan4yqKxN2sYIWuD2EE5LO1n4LYsameMJVY8QU2nfFQcDQT58CYd3SwVx1/5k3CZ1VB2Of8nOk76HydPqKiynGEuKIQ1DhfX9RuBtPRbOMO98CV1oc38E68OLzbHMaOKaFrXgAqNz3b6IwdUsz6uVf2Z0+v8dg1zWyOks6Sb6kzmB1M9bXa1tPi+R1zrLtDnBVmyxiyJJ45//ePn+usY9oJHErq0CSpLEvVZ3TNJ2KZbkc/IrGbVulgCea9l+rNNVG5R1RiGU9hgz46MAHUdiR4k4JLfslNviiop4QFzh/kEPc16SWE+lKPLQkgMsX/gyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyuolwsbPTaRoS6mFUOMhmMWrDGNHcEtdcu6aMTmL2Y=;
 b=Ct8foqGP9gX6zvJld+24miPNbh8FzUJnLPaZANUyqqLHfJjoLJD1mffdlZPwj4LRCm4oAOOUyXt5slfOuQPisd8okIwhWd/F1MLMmRaU5SuLU4hqlr9EwKP9TJN37cJCofRORqFs9Xxn8BhruGL0fol1HuSQ0D0WCDJNSy5gSSo=
Received: from BL1PR13CA0090.namprd13.prod.outlook.com (2603:10b6:208:2b8::35)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Thu, 13 Jun
 2024 07:25:45 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::f7) by BL1PR13CA0090.outlook.office365.com
 (2603:10b6:208:2b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Thu, 13 Jun 2024 07:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:25:45 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:25:41 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 2/9] cpufreq: simplify boolean parsing with kstrtobool in store function
Date: Thu, 13 Jun 2024 15:25:14 +0800
Message-ID: <490341a4cec543fb95aad76b257a2bee525c515c.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bd9d00-06c9-4b8b-3f44-08dc8b7a0a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|82310400020|376008|36860700007|1800799018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zBJNfwWoQ/Sld+9hSxt9xe9QxJfVgezQl3E1LHkJ87jA7ed0sb2aErBCoi/D?=
 =?us-ascii?Q?bFKgtNlzgnXMwvD/pg72GhKKS9Nv/BTtavtdPwEHa4n+EvB/BkRqiY5azjsq?=
 =?us-ascii?Q?J5iT/aZykf9yjw4m8pS7cyfEmModKmIXPm3k5XCIcGXfHYDMJXl1YL5TYwGe?=
 =?us-ascii?Q?S8QtmgCE/CeeYGHAEqqr+AsaDvZIPR3e0/PmLl1yztlpUuGTN9i8mEBQ/DqF?=
 =?us-ascii?Q?bb8SpCKDH7Utg9pYPxTK3BMIxRKR9Xve2/dNZCCtadUBvjw+ENwHG7GNX6t4?=
 =?us-ascii?Q?tOq0dUsq4vFgHr/0iQt/oJS6x5CdpQKvEDYdPBTSZPXI8nv+upl1QLAR3u/L?=
 =?us-ascii?Q?Za/6y3Ox3b6R8UKX4OrIUn4rECbsfIH0dlWPMjimxkmMXpUbzYKzHrfb8E7k?=
 =?us-ascii?Q?lLTnlr1bWw8okiKnFt6dknEAIQKpMTW+wwHXW+BddE4Crzm4KobSlGs/HqEK?=
 =?us-ascii?Q?rMaPfRtAV97DWSQZYMt6Aqx4lBOzObjaXPzhTEAKgx4Nawkam8YQGXiZFL97?=
 =?us-ascii?Q?OWdAVYKkhTiNLyFmHhIPN62y5+WzvOttvWe8csdPJ7RqmVkKB0TgSFfrLpsa?=
 =?us-ascii?Q?KCu+Y+f6WjTw8bthCtXEfQeI4nr8pGEJwCHox/SsrP90I0sHt+EluKqbVYCx?=
 =?us-ascii?Q?awiVrxiYeMMLasXNonkynKZZ9oxpd2R6eAE3zBBjJtqV/bn0isLJSj4T0GpX?=
 =?us-ascii?Q?Qo8MNrjxcmZqrYD4AVIyCkQL6pFCfHJU3UWMOganx3lWf9yqb99l9N++zVf5?=
 =?us-ascii?Q?rLkWbeX795Q7aByfOaHiiDaLctYROueRacIMDfDWH5MxUVKA7PvM/M0iTmJn?=
 =?us-ascii?Q?4fxSVzojIdBEWlDuWLHC3RfXpnp4nb7dYIGlTiM9fy1lX/5uaqo+/Gol7ivY?=
 =?us-ascii?Q?z5LlJw3rQWLB3AuYWyx5ZXGteWzsExbdR8olBBAzcgCyWj+/2HiZa/FTxL4m?=
 =?us-ascii?Q?ajLY3f4IUWtYpruMUDRaPwTisTUAGrZnFWrgSmKHMhLgSidaGzCfDXc8kVVx?=
 =?us-ascii?Q?MpfaGzRn7GyLpJrr0FvplgHemHS/J38evYDkfkq1x7OtOvC0GVqaM2xMUdgq?=
 =?us-ascii?Q?6QOgdMq4HNpoYhCtmOJ5Akk4k2H0HCaC5ki7sRnzMl0hA+Vl4q8wptf1Dh7W?=
 =?us-ascii?Q?Ub62Zsp2dVJYnDFCCy0LJkm4RQ2ng3mUIraRxp38jclMGvGh/L51EhYIHLYX?=
 =?us-ascii?Q?IPqF8g5S1UVGJpXrDphrMnC8wV1kcYXZv4ePBxnKJ9ZdX/yMDkLDURLgaK5j?=
 =?us-ascii?Q?lgzo74pHwDvJOvoHlkAOnbXU1P6GSkin+WpbOaU8BX7MF1Vijs60dBrUEHjQ?=
 =?us-ascii?Q?DN+X6gFMcFXcFS4+3FDVIiyXVxavg9O42NSlzQaTr/SCtRV38MuENj9We68s?=
 =?us-ascii?Q?jjdg6o7uwxhFGOa7Koh2E9xHOMkL8eYDggIp1dbCZ7Y3NoVm3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(82310400020)(376008)(36860700007)(1800799018);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:25:45.1062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bd9d00-06c9-4b8b-3f44-08dc8b7a0a39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

Update the cpufreq store function to use kstrtobool for parsing boolean
values. This simplifies the code and improves readability by using a
standard kernel function for boolean string conversion.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..1fdabb660231 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -614,10 +614,9 @@ static ssize_t show_boost(struct kobject *kobj,
 static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
 			   const char *buf, size_t count)
 {
-	int ret, enable;
+	bool enable;
 
-	ret = sscanf(buf, "%d", &enable);
-	if (ret != 1 || enable < 0 || enable > 1)
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
 	if (cpufreq_boost_trigger_state(enable)) {
@@ -641,10 +640,10 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
-	int ret, enable;
+	int ret;
+	bool enable;
 
-	ret = kstrtoint(buf, 10, &enable);
-	if (ret || enable < 0 || enable > 1)
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
 	if (!cpufreq_driver->boost_enabled)
-- 
2.34.1



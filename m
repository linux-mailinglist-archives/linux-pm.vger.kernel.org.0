Return-Path: <linux-pm+bounces-15777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A049A0D35
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C021C24CB7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321AC20C493;
	Wed, 16 Oct 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UIqTaquv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27720C486;
	Wed, 16 Oct 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090135; cv=fail; b=bq7yC+Vdv0rSmCbSCmfkWUT43gNfXzzu77xpYtvtoQu5jQDPaR72r9ehKUSPNMntYpIhWIKdPn4WTMtrS3kQLgZF+8nz/f/uFIiQndozoPvDsi13o7LI6tfU/LIZ9lqeEAZqjmH+PD4pqXoyibtSnG6+NDsbSlF8Qzi7NLSjFkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090135; c=relaxed/simple;
	bh=FF/pPF29l0Ee+AJiYC34Zl2/8nvhF7ylGA4FNA5HClQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lhw1EIPkFK4zIKuAe2bi7XjmQIXuqcPhc8hPnFdRMWLbX+7LbG8IcatuQRsIUTBDFUz6qLpHfcLa/M5S/MPLWVkKawCXRoTnIQZlT9fTdxkoZLKYobPPzwc9W7WXAk/MzPBSSuNTEZJiYviCgekLWzyEVZwvE5Og2pCEjWxVonw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UIqTaquv; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtOtIcJBkfXzP+Vjf0r39rwxA6h1yWKxoOpiCSNQLoWniu4UHpBySy190dsSa8iUDDWs01TGNj9LA7CqaEJUgOoAc8SJ0FdAvlUOfXjQT7BepvyarQ3jET5eVPS3iqRejGpSLngCMtkQ0e6XWSr16MrFVBa/tikMy0bzRHq1O8y6N6+rfL+wu292GH1zoj3dYCOvMnSdUmuJc6cGgnhhEuS2HyxtdVQZjR8f+if8Qhd6reXUaYaH5Hd5FJ/KuIzl7mvpxktjSiHTxqvTzQnW7isfy0zXcBbIzLGNo+R6Wp3KbRTcKXcxRDVOdSvc6HrQFGCjc/Q/yrOqh8vsdbXxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk4AQoRj9dXX+JIgFQbkYdkVZqz6ekK+6wm5YMZC7qc=;
 b=YXqmlEbjnNtVD1xqTsN5eiHUdd9ULnvATPcHfLHLkmJg5w2YnuVJxIyRpPrd2TDv6YuKVolDog+56jBPOY18a1C+rD3KyAIrJ0INJmDrYLjDzAGnY6yCaRRadj7YeTPose/PGL5FA3O1B945oNptBPVhpy8z+qFbD+bDC51l5mNhV47eBxtuREFg4WV6PxcKp5iiu1tIvazrLiURGYUUzzX6j99sLtRiAYynSObRTuMdkPnzWuafhQCLIQiuKCFSBqbmh+ChiUe6jh5dsa2az/5LEbBovmzfkO9mcWSprR9GPttcTKFQOBcQ3dXzc86OOHOK+Xy/a937zQT95k0oHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk4AQoRj9dXX+JIgFQbkYdkVZqz6ekK+6wm5YMZC7qc=;
 b=UIqTaquvH0VbY92U8uuNlXdDoJ6WtNszgKxYEUkC/QRQ9+ke8pFvxE8qXQaXzl/s1wLXDnwAjNOHTNG0fnsmCTZ1dJgVvIBkKEkZXOavRLde9VqUvlRpYhysL4H1t2OqFmmLJ/iI/jqL/jEyJEYuyA/ZuMxGDavc0ZNZVLxGJGs=
Received: from MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::30)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 16 Oct
 2024 14:48:50 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::de) by MW4P222CA0025.outlook.office365.com
 (2603:10b6:303:114::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 14:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 14:48:49 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 09:48:45 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2 1/2] cpufreq/amd-pstate: Remove the redundant verify() function
Date: Wed, 16 Oct 2024 14:46:40 +0000
Message-ID: <20241016144639.135610-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
References: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: a2185f75-3403-4d39-c44d-08dcedf1a572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HwRZoJVf4GGNbt0+mO694dMQEveX9xaJ0eGWb3stclLLMUeTm0AEBwns+XC/?=
 =?us-ascii?Q?EisdM2+AyLXooESQZHZiN+MhdcW0l/KFnq9TKuXxVnOt4j0cl+IjP/LqTNi3?=
 =?us-ascii?Q?KfWJU7rq6B1mDUDg6aBkE64zBYepj7vFIIRKM3UWTBExg9nxBmEBImyjog6Z?=
 =?us-ascii?Q?cFef3LguJxaV7Aon5Ej3Ipu0pJpsYPJzfsDne/46LynrgwxMFk4/rkG3sGf7?=
 =?us-ascii?Q?Vsa9g9kCASL50gHg3+BUup7ut97sgfNtiaonINCK+WMehqqUxy0RjJS2cvgG?=
 =?us-ascii?Q?NuWrvs236QLSIJMI+dyzeKz4FH1shBH+wgESuoNC2N1NajeQ3rR1DK5GU/07?=
 =?us-ascii?Q?mmfAaiiwKd+GGV0Mt+xBpo7TB6XTLgm5tWOxPnHf7/kxSaVCvnCmGOrp7Lez?=
 =?us-ascii?Q?tiwNcwIecC1H3ubZbbk4A5+f/7iPPd+071tlVA2Tvm1jxY9VET2Ql2fR0/4T?=
 =?us-ascii?Q?m9ijKwaH/exFzGXxEkVw9VXMRq/sW5lcpTOdmlIQ24evEadeg2HMyD1hAK7X?=
 =?us-ascii?Q?wrsia8lGv7desF+wZ8eD+nupqCM9DZt/TGD/c/KvUwieq4YFnwWRawHNMIXu?=
 =?us-ascii?Q?wgT4wvQNc3jpTIGW1BUEijsIyaGzP2921aWd0fZcj3P9DPZG8A4MJ8Ya8l2L?=
 =?us-ascii?Q?OvEs23iCr+PeNW/zrQMpO3Mgszhfqtgs2wTchYggLiAaOCNtfCdw35CsjRV5?=
 =?us-ascii?Q?xh0L1VX5HDgBN58N+VFHQo3Z84oNF5zwaf7z110tNwjhWnmg3oWL+f4hoDO4?=
 =?us-ascii?Q?saD0EjGU0ZYueQCX0QaZ+4b4YlMdi6P0Y0Gho9kx6a8yv2gRgWOJq71kQySW?=
 =?us-ascii?Q?jcSJjfj4d7PXYyolXrD/yGxn1nqggicOf9eJ+daixnWsAjrz7fPG7Lf2yv0x?=
 =?us-ascii?Q?5tdkKsXgfWr1lknNOr1bcJgepm9cFwU25DuMdJFRtWZYTrNSZuHFqprziFgz?=
 =?us-ascii?Q?NANG7MB6gQSBKZwrsYtqt+/W4q1IoqJHcZzjrDT+fhBf45ozD7NvW70se0Yp?=
 =?us-ascii?Q?BRqLb03HSQxO06yIw1B3+BediV3SAI973UtCl6J1f67XnUhXgGWBMRH977Ay?=
 =?us-ascii?Q?9uZIXQcuGGwaf2LZwSYqkleyUT5M+SBEx4leJKpvWkqpqNF07Buam33ViUiM?=
 =?us-ascii?Q?KMz5mk8YZ0C0M98tsLYnvUXF+z0f2FBP0HFZe7KeK0/6wTeSsjdFDqJ/JPdD?=
 =?us-ascii?Q?96s2zE5u9R4cFFcELUptqyzYUGGTM+VR1Z1O9D7en+1qPpN6D/NaUQpq1apD?=
 =?us-ascii?Q?5dKXbSo+heZErMiexjHC25g7Imh/hK6opwun7bDAfbcSSQs9kgzY9/hrWCf6?=
 =?us-ascii?Q?Hck3zptJoYkWRzEwsWUJgk/hSGTuJoj0tJGx+EGXvsUoasGVQo/HvOMl1rOs?=
 =?us-ascii?Q?37KWSc8YH+UE1fOudDhL/MrnrTWy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:48:49.6556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2185f75-3403-4d39-c44d-08dcedf1a572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

Merge the two verify() callback functions and rename the
cpufreq_policy_data argument for better readability.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b7a17a3ef122..fa16d72d6058 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -527,10 +527,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	cpufreq_cpu_put(policy);
 }
 
-static int amd_pstate_verify(struct cpufreq_policy_data *policy)
+static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 {
-	cpufreq_verify_within_cpu_limits(policy);
-
+	cpufreq_verify_within_cpu_limits(policy_data);
+	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
 	return 0;
 }
 
@@ -1661,13 +1661,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
-{
-	cpufreq_verify_within_cpu_limits(policy);
-	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
-	return 0;
-}
-
 static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -1723,7 +1716,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 
 static struct cpufreq_driver amd_pstate_epp_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
-	.verify		= amd_pstate_epp_verify_policy,
+	.verify		= amd_pstate_verify,
 	.setpolicy	= amd_pstate_epp_set_policy,
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
-- 
2.34.1



Return-Path: <linux-pm+bounces-9280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B12290A65E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F31B261D8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7291118C337;
	Mon, 17 Jun 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2oTyiEF+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB818C326;
	Mon, 17 Jun 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607625; cv=fail; b=DbWpN/98vWNzk1J+fgIPi1Yt+jp/kjzm2I/10V2UlcpTj6qF+Yg+Zg3eN9qUAsEqwq9KPxE2z43nFOrQvcql7aCKPaZwTbU7U6DvgTOX9W7AOwZ0lm66vzOXWa5zmolgyHAsWtwU80rfjjD/xd6BY2fjfB8CgKREbSf9+uZeUcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607625; c=relaxed/simple;
	bh=SaQ84A9mdXOlivUfJ6Y0mpDmxq4O88+lCsp0/N4Ix5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsMLs+IaKxb26wksLUqORBHcwiJySYG/Fv6Z/iqsdF2S+NdZMKuLp7t24ggjp0mAzTsJPHUhC8hbKzF9nw1w2ax7mh+2/n4L6en0ccMNQx+BXud4nxI1I9Legn8fZzRfTK+nz9smQ2Im+E6yYpfnnQi4AYBsxXBODDXN2bfFmBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2oTyiEF+; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXw8K9oTY7TJ4neopJRb2R5WoRbPGFTkv84jwUWXmTKfocdh6zvQWQevunBdtgsqyFyAnuDeiG/AUx4CDaf6nfEiMB7a8YjZtkGAf46atfw4WKX2l03+gwTwCxw9rteunVQMP6tKdGVAaFlFVnkRpNbJWcsbhsw9X1MpuI6Js9Tp8UuWlPvvi8Q+UDHwHTGwb3O2XF9loy2tX53/3FaEkgIi18yRU/vo19K0M/IQqysYFfXhCdd6GnzEPjXdhO5ukg/pb09QYQCcrEJJ5n3Rrnd58nfAlD1k0DGCDc9eG+r2S8Wri+uDaQ2+lpIprJvdVUbxVQLaWGMusSEmEzgtsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ASNxod0sbZOLlFkXfgYDq7sgE7KelcytOVJjua1Dx0=;
 b=UZx55E9qFEmOlM2AIhjr4o1Lx7MITEzpoo2psaDXH5ugJi69/+oCVFLvc6ee5jDtIdqWrbrM8HZ8FBmXB1r61/2j4Jxsox6/lUn9qrSzN+4ObWCFDhRrj+6U4gnNrLcVvMVMXe8sifJQYEDUr6/q8qPpHbd6xWrFF20hRkLx0jin5+2ZmtUrYP8gA/NdEfbTGyqNX9rKfCAwEHT5TOi+fAB+8PodT855udONx1SPsRaCQ1yHaqXwUFh5ZRidIDv5mMnmsNtBMukeDhMxVHIDZ3Jo/dcZhWWdYecTBiEqaoT2jFtoBsqUyAnK0AHc5U15yUao6YDnjbCiTNT8sTL4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ASNxod0sbZOLlFkXfgYDq7sgE7KelcytOVJjua1Dx0=;
 b=2oTyiEF+98lleCwuFDbG61CuCNTCW39NiA7hU+BS+/QtlZDevvYsHn1v6625Agt9mwTutss64xhOWfqVRsrDuYvX51R6D66Q0G58d/1bMnPUn2q3RQaFK8ilYbr1R68pGlfUuyvfny7QtaakA7E78/Uty4jTwL9nhJZiThbi3IA=
Received: from DM6PR08CA0005.namprd08.prod.outlook.com (2603:10b6:5:80::18) by
 SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:00:18 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::79) by DM6PR08CA0005.outlook.office365.com
 (2603:10b6:5:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:18 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:14 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 01/11] cpufreq: amd-pstate: optimize the initial frequency values verification
Date: Mon, 17 Jun 2024 14:59:03 +0800
Message-ID: <b011b7ce45ca9fd36655f89e4f5d5388d46db0ed.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b5a677-807b-47ee-5ac6-08dc8e9b259b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?byHQT34duPoKCajuIixAUuUEAHy9C8DcA/fIuHKwQuK4gmtb87Gze8AKfBoS?=
 =?us-ascii?Q?YpidVU5JMkfgS1520kmPoghYNi1LaYsmJUNbyxCTP3Fq2eNX9oDSwl27cxmW?=
 =?us-ascii?Q?BGUrWi7DOnPATbCMKMs3bY8O/947C3snxeQ0TogiMa7qwys1Yz4t/SzfcvQi?=
 =?us-ascii?Q?xBKfw6rER9v8GzC4V8Zd4xJTDXXSZaS1nSCFxpuxQTVeLqd7DXjFQVhLIOt+?=
 =?us-ascii?Q?imzINNXk5QRAqORCOZ0M3MA4DLQ8kZdzzUpfBiumdrYHfuxqtt+7U6hu15VH?=
 =?us-ascii?Q?gkn7ZpakgJsN9qqw/Iue/llRM34hxQltxdyb8wY+f9AVto3w6MSj95T9TSnO?=
 =?us-ascii?Q?aKcFn5/Kz7I8oXTLC94HAH9rt+UFAHp35zshlF3sVsOqf46PHo/OLwB0BtnK?=
 =?us-ascii?Q?XasdZAG0GHsTcrcpaTWfTT/FIQReVLwqs5OOOxtaV3qo043AMEqgGBMXYH01?=
 =?us-ascii?Q?JGOQ/27DMeyG94+I05lNfB9MNf1DaWiKsKByvVroAOPQAbXoJNJk9ZcZ4366?=
 =?us-ascii?Q?6MJ/RS3mYQDsUC4afyjFk0VT7NXcR5WTyAHzjPkWE9hIBppRCnFz775eF/C4?=
 =?us-ascii?Q?/F3jpsJ8Oa48LtTmqtBmJcbOavYEEXLK9HepEGb+DTxmLsWMQMPgJX3+KMA1?=
 =?us-ascii?Q?MjWIwtMI8WgUlAFxJcn7KmT6PwuoiBpKymnzPxbVzXaenMIkRPhzApJqv8kS?=
 =?us-ascii?Q?elqPABLTkLmw+PfjgjeCifJEvdZhXOhmxpBALSlV/VzkazcGW6dtQZBfBum2?=
 =?us-ascii?Q?CN3vn28xyTZlP1ik9IdzljUwiHsaGnh8LIxGSr6kWbyPqDCh7JRPgxr/MtL6?=
 =?us-ascii?Q?ACIZW5vUZq2q0yh5kLqEVLSti9I5pvdRFN+y2WmZgnd4E57hkrDhomndNL79?=
 =?us-ascii?Q?U4vP7h/pf7Coiv6f1gkI+di+iAhrYwDPKqwGUdk8110BrSezK+JyiTAvYexn?=
 =?us-ascii?Q?0m3njx9FyT45xgpifFuRDOFakk9OSxJA1A/Hj1HKkc/C4b8uzJFrs+D71upU?=
 =?us-ascii?Q?T0tdy97qfjMXepVWlOz5RzOQyQgPIz+xZVilS6XpQ7H6fPAu9dnLFO2gLi2z?=
 =?us-ascii?Q?Hpj4orhB4d+a/Yv0s8BcodmvYftMiLRNo3HxWctUzPzejYhh1/3QjfOVHQqo?=
 =?us-ascii?Q?PKHc8pj2znSyBZ7AbjLWOgBzQX8I6DNV3INacp/P/vzPxRYVNqdr+D+nlo12?=
 =?us-ascii?Q?WuAIp+j3ARP1KzHxLbR9Vc5oHr3lXl3/7HIPngvPEw3ptmJ/AIH9ADDlBglw?=
 =?us-ascii?Q?43GrspIhgA+RCYjp3UaS/CTBJAtSHOkMqKOxDOR9hrIVNvAPPo4qDyakwzNC?=
 =?us-ascii?Q?qzEsyqA7LPoTU2alavPT0eXTOkkPrOJBuYgv4uQffwwvlMQ05mU7YEBVnFKK?=
 =?us-ascii?Q?LK5e68lJjbIjIAd9D0BYC9Sy0oY5Kp/RGI0Pjjoo7gRogO2eFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:18.0842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b5a677-807b-47ee-5ac6-08dc8e9b259b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

To enhance the debugging capability of the driver loading failure for
broken CPPC ACPI tables, it can optimize the expression by moving the
verification of `min_freq`, `nominal_freq`, and other dependency values
to the `amd_pstate_init_freq()` function where they are initialized.
If any of these values are incorrect, the `amd-pstate` driver will not be registered.

By ensuring that these values are correct before they are used, it will facilitate
the debugging process when encountering driver loading failures due to faulty CPPC
ACPI tables from BIOS

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5bdcdd3ea163..d4d7b7cdc4eb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -924,6 +924,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
+	/**
+	 * Below values need to be initialized correctly, otherwise driver will fail to load
+	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
+	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
+	 * Check _CPC in ACPI table objects if any values are incorrect
+	 */
+	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
+		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq * 1000);
+		return -EINVAL;
+	}
+
+	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
+		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
+			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -962,15 +980,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
-	if (min_freq <= 0 || max_freq <= 0 ||
-	    nominal_freq <= 0 || min_freq > max_freq) {
-		dev_err(dev,
-			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
-			min_freq, max_freq, nominal_freq);
-		ret = -EINVAL;
-		goto free_cpudata1;
-	}
-
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
@@ -1423,14 +1432,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	if (min_freq <= 0 || max_freq <= 0 ||
-	    nominal_freq <= 0 || min_freq > max_freq) {
-		dev_err(dev,
-			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
-			min_freq, max_freq, nominal_freq);
-		ret = -EINVAL;
-		goto free_cpudata1;
-	}
 
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
-- 
2.34.1



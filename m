Return-Path: <linux-pm+bounces-15832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C379A1A30
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7790E284579
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFF313D24D;
	Thu, 17 Oct 2024 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZgrrPPzj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A6156243;
	Thu, 17 Oct 2024 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729143631; cv=fail; b=Jfz9N9SyE7HW7TJ9+KQ9NDh6HkRCTkr7ApDuFH1t3/iCIzU+f8066VYZNgN1VHt/pID1xNMtryau3zRWwz8csG9+UYso56K+Ybw3ZPmHR1y90KLp/gAebVxJTKhTLBby85AGeTrtbWiz36a7zsyyHsylY5EaXxTH+hbUQRDsI2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729143631; c=relaxed/simple;
	bh=mvQ5QgmaGhCMt9pOeaI2FYN5k/BH5AnrZXVjAR54kx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7J615bYM1bPd7wkRYD4Ce0a68saph4hB1hZ3gr0lnihoY7qkEhubbS53MdZCe/Ck/6yso3Cz3s1KLPZ32oFabIXc6TuwmLH3NeY6VYHHeBliiE0R6Y92HqHvXpuchSsPMfBMmAb0oRZDTeKFCU7E3Yvs1vepnK/1faog+vYrtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZgrrPPzj; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjReUTQFWgt30AxHR6GJi3Ul04ozgvrJS97t1UpjJ6gl26q3XwOz1eLNWsmnqSD8M8uOUy+Y9lmJWmHYtCI58fxr7ZJ+MSMgPm4wPGqPoeTGqCRn2KHsWSuFP14Sx5aqWNlbUxtBEDOZ1bT72vVhjdHTKyepihrMJV3UN8JsAfDISgMm0ACJGGnHwe1T2NHigZrDY1YPI9W2b6iCBt/oMbyfQLkRYfyCJErHKZatHydQrUoeQbIpWjdfN5AlccfG3iTlr1aIyDRg1MsY4F1GgRt02caz3ETF02QRUVHYd41XNZ8vE8T7nSIVeJuEE8v/cCqs68ycLCnfgXWsy71JKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DofXEulEPleTP7rSp8k6vCXeuRPe8tFtJfqnTrhOxE=;
 b=praX99EfAUl9khxjIn6lPEZ88Qu27QvBe6Wo2VOo6XEdVoRc29Z0JSqMBbBsSdT6hsjyYCT5+lJQD/AZPrOP3YoFv4JXTepHdS3ArKxCSESYADRFbM9YHc1AHttRrniLb9ffpvr+vaAyfNDvyqCUeT/QY8jexQQFfGdiF2jxe+jofETX3lU1lgF/ukXK0/KA0FZuXpNl7IISkwr+p3nYVCfaLpycYRN1Tsj+D0F83fExcbDTZ9QLPDbLPxVA3d3ZqCG0NVP/tDN7cw1UetHe/JZDF+4rkUEFnKbo+IOKgvbuhEW8qDJCYT0Wv1hgw+FSw/ce1k7yh95W6yagWpcq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DofXEulEPleTP7rSp8k6vCXeuRPe8tFtJfqnTrhOxE=;
 b=ZgrrPPzjawtLwLRkc1RXnPmfvqf14cCogag0nhP6AXFPxUqzBCIGZ1MDAnrO2m0t2wCum2TmAWJzHWX1JSmad7okHukQnWOmMCrpKFDGe/tnrL+5DzGNaoGaOZPwLPJpfGQMVPNaIhHKIwppP7ks8vyNlg6a9zDFBXzvIJKFa6s=
Received: from DM6PR02CA0097.namprd02.prod.outlook.com (2603:10b6:5:1f4::38)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 05:40:23 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::62) by DM6PR02CA0097.outlook.office365.com
 (2603:10b6:5:1f4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 05:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 05:40:23 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 00:40:20 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v3 1/2] cpufreq/amd-pstate: Remove the redundant verify() function
Date: Thu, 17 Oct 2024 05:39:28 +0000
Message-ID: <20241017053927.25285-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
References: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 96987f88-3b96-48f2-6ab7-08dcee6e3248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zoJQIx/pdaEn0D6G9JM7oR8NghQQ8TqDNlYZkE1r3p0RLqR8hZTFlOSEalRQ?=
 =?us-ascii?Q?HvRPKhQ/ZY8lhyCvs4EmhKBtQR5wip3GWA3vxY/BHY9x/DJfKbWhd77K9Xuj?=
 =?us-ascii?Q?75oebdPpekC0Cp4KsFNerdOsmMTmQIYv+spSF+POuh7WAWnPE+fvfbTD/0EL?=
 =?us-ascii?Q?Y6Q88baXNRZ6mQGQGead2K0pj3Dnx9KQCmfnMuCrBCv3UBAUATI1ov3FwHGZ?=
 =?us-ascii?Q?Bho9H3EM7qjXpyD9ZE2c6DAr1fNvns1jj44r2XhQt5TpWgxvJwaakhG0I2em?=
 =?us-ascii?Q?FXyccjQ0VWyyOsKycvjHU0CbiqzlV71pSMPiyI82PEOA0yoWo9T59x/4M+ss?=
 =?us-ascii?Q?C3h9ey6v/lP8Xe642TeTnPMOnyf/u5jS9PH0lbANbOkiQFsC2MqHV1Dfi55b?=
 =?us-ascii?Q?Jqu6zHQEeqSVbtGwM2QG6K9eW8VbjqNQDzhSTJRF4r1LqUNWMgBpTiSqGR7L?=
 =?us-ascii?Q?DwZ5ybBT51uApUTHfPcixaD8euFhOcuZEZgiHw7MfVMgyFS5yfd9w2uOuZ9j?=
 =?us-ascii?Q?9932xPYi4q+hIBGk+m305QXkBXi6TZwwjbGfYY0+YHS6ZxTFQ3AUtLY+eQJW?=
 =?us-ascii?Q?R4mvhYMqrWbafIMxW2Mvd8xDG+q80Jz2mzbxy/5Nnnz6F4Pk8fENgkjCgI2a?=
 =?us-ascii?Q?azkZKkL2Ez5/+h2IMPKEcfovFTuuE33Z9bbCoc+gj3wG3D+7M1GV4KT0R48L?=
 =?us-ascii?Q?HjbrP/j/S7XwKOaQyMjVWV2iA4ibdDKR9Hd3yHgWrgCsmpYOm2ZjCCENQukm?=
 =?us-ascii?Q?ODFLsgDrqNKjUvBXMvFOdBBzdgHhxw2ydryNadCT7TElI156JYtiB62/5flb?=
 =?us-ascii?Q?yjvueirCX+MJAifqreyzoSVq3LBDwE46NrAG3AmSKiTvaWITDzVPq9cC4fK/?=
 =?us-ascii?Q?VtSatgA6EXLMuFOwlriKOip6uQUIklhPrn2sjyLss/mwdksLC7RDM1/RQuBi?=
 =?us-ascii?Q?Rsk94MedlpAwn3jus7Cn2Iq0BVDkCG29rPgups1jwUdLq8jV42j1Jwcm9M3h?=
 =?us-ascii?Q?rYf4vAoUNY8ieFIyYle5aigNh37Z+iLTOM567BTRIsoOdCZAhgcR6L7GrWcl?=
 =?us-ascii?Q?oUhx9ZF3AYecME+BiFNuGJQ1BJag+JknKGq48z5YCNwvbvijjOU6aUA0wCu1?=
 =?us-ascii?Q?/1mjdwGC7SwUuXgZ5t4kswmsqLP8ERVe4HO2isyw9r1VLMluUQ2STxPFhInN?=
 =?us-ascii?Q?v9dnL1iNIpNQZ8pDa8VAfSfLsVAHxxq+13gsl7D5y2YNJjwrlejxoBOMMRTz?=
 =?us-ascii?Q?3cpeKXWeFuWb7LrBkXPp8YI8qL/8AFHctmJ51gz0uOOlspSggmhKeTCoN6+O?=
 =?us-ascii?Q?7LCiptcXMTaephrCfwWLRYwou9aT5rsGvylWG7gm1eSKxvE7o+Aoh39jMBgZ?=
 =?us-ascii?Q?Z89WSi+5lbjnprpy0vFoZnAdXZlUyYT4jj3wLDVOLuICS2bgRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 05:40:23.6250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96987f88-3b96-48f2-6ab7-08dcee6e3248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137

Merge the two verify() callback functions and rename the
cpufreq_policy_data argument for better readability.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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



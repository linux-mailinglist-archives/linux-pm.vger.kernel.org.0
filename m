Return-Path: <linux-pm+bounces-11739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F0942938
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 10:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855401C2189F
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5F1A7F86;
	Wed, 31 Jul 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="krO5nCkM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DE1798C;
	Wed, 31 Jul 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414747; cv=fail; b=QOiewG6WiPO+yRyHf70P6kQBiJtMdMdARsrOwezusTR6xwSAy5oJKBn/AuN1rw6ysv5UwSY/BaVCXV/EZurjRr2VYFiX/UVZDY1ejgiLc9qY1sFJ+3H1xSJBUFNfNhyCU/BVBYnW+cEoou5qbQZ3Q+ZD600vDLMKL68Eu5Qd+wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414747; c=relaxed/simple;
	bh=memRygpI4o6FpDKM3ZAwzctqBhaSmnyBAlZYQz6TVSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k6CBXLQBaTtEKE+CghLVgYdtJgu+KDgCvmJqRR6nyCO1h2/gNiAF/x7q0kvqLTxhMaRcvVpGeZCjw9mRH/iBCjnCTKa0DogbJMJFVIznEuqXsuqRBext70h1RUk6Fj7VtQaAqiskCCuC+7Ke3Llr+N2gEhmFY3L3CZ5Gp9O8IKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=krO5nCkM; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKsGoPadrjwzAVj0LNn6vbBl3DfCaY9FqelYDR8HYJH3P/lz/ak6Oqlsd57qmy+hgtZME+SjSilymlCVDNBp3qA07WqcM2scqZn1kC6ncQIncg7OedZE84Il0AROXRIzbXK27RNAmh/34IH8kgM8vkXZRaffWOXLhPGi/FdjyojpJAT1Y4BvuRJHwgATxbYxObv5Lu2dF0qUCqWGocoAlgDOvTzHf5AQsBglJuAL98DMdrDYFPxqM9tCe6MNI6uOSpZ1l6JCCJzb3SLLG+oTVAo3O9GyPf5RteuGdspeayZYlRwFeZu8vouldn3SWQpnwtUauzgDy0hn8A9wVIDtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QQ6397E9YST7lI/+iZs8wNeKZMHfz9VvuBA640/rAE=;
 b=Ln6eyGOgSSKSyMSq/naY/gh8fmodMJ042+k4QOAOAzxdXGP1pof9W1Y5NihUGKiZo3eMmuCWBjFw1CrVFNvux+dbn8lq6JCfHSm0dBVA2mKLt0n7gbWOdddK/qGHMOOr4igpKTKRb4Q4qXtoGJ9CHnkSo4fuHzic+KMFTyXknYwpjGU6EhGp55uLaka1dzvIU0cVaNQODeZPkjOv41CFp7EMD2SRcfvTVRPJYZHX2DkyzCWx0tKCcgDGrojItHmInKK80nNdy7MCvgCcNNDqfuLIz/3847rw3SBgSyykza5X+Mg3DrltG8W0ZJUy2DaH6EHDw6lbSgbznUoB59a+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QQ6397E9YST7lI/+iZs8wNeKZMHfz9VvuBA640/rAE=;
 b=krO5nCkM71mKbb9toVXBoyIBD8kpbj9+SairRPTNkiCNvfYEA7dmjU4rTQdCFZry9QKdlwYr4JrCdH/i5U97bviOzc1f6irU3Z0eOrdy78WSvhvSu50MVVgH7atBkgZSf9q2z5WUkTqNAeAIPRHUOVeMpAEdwH7D5IXqQwTu6r0=
Received: from PH7PR10CA0011.namprd10.prod.outlook.com (2603:10b6:510:23d::12)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Wed, 31 Jul
 2024 08:32:20 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::b) by PH7PR10CA0011.outlook.office365.com
 (2603:10b6:510:23d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 08:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 08:32:20 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 03:32:16 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Date: Wed, 31 Jul 2024 08:32:00 +0000
Message-ID: <20240731083200.169985-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 88af0f00-1ff0-43de-576e-08dcb13b4b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnUOSCeIxxCzIjUjNzyb22SJ2DnTsTAat4NkzHogBGip1qchcz9BfiLBjA2G?=
 =?us-ascii?Q?CPG4Pg5DdYPoWpQsLlesWmGKybdBRGyXhWTFp6G+uqIgJdkg4BRCi+gZ11CO?=
 =?us-ascii?Q?p8YW1eaBpop221hLAoa94P/ODbs1H3JLmUS9f12Enq5DnOVuyHu0DWmQO8oF?=
 =?us-ascii?Q?jt76DWuDt7236dBHs4LT2QDbBBVFNzwTgAsuF2SBJH1kpVa7bj+6D8ECcWiM?=
 =?us-ascii?Q?fpqTKAv+4UAU9BxV+Atl1rUuAAHU6TYLdU0bdSv4yLQXAkhtwtk4gaQtsMpn?=
 =?us-ascii?Q?43V02vfgjSWaZXZCH6ugw/I7oaXTUhgU2i77ZlVOWRw4tO4V0DuHVt9vG6o1?=
 =?us-ascii?Q?QNNor0UEHWFvIuTysawW9W4Y9Ae3KccAJ/pjKI2aBJwqJoJg+4rAfcMgaZ16?=
 =?us-ascii?Q?+dDSEth3IwWlwKb270lhVHCMg3ak0Y3MXxlC/53ZiAXS1mIiYUtcP+ofN3xx?=
 =?us-ascii?Q?UMhhl71a6JWJ/WaaNcoEdpTWFTf0qe2sipBoY7OvONgZUL0emGN/6SCfXvzH?=
 =?us-ascii?Q?Iti18s1YT7T6uFpV/ylphtK4L+umVhqC6YSOAIW+rxNyycm9KytviFvS62tS?=
 =?us-ascii?Q?qWl5mqx7ar1zkPZhSor3ZlxPU7oHlzF/KQSfSHsEh1w5E7EP+CRyXcqG7Hrm?=
 =?us-ascii?Q?NR2NdYopJ3C+uTGg3CrucADLjWTtaE7p2khIegLb/FXr4eau8sb4qnRFtDb1?=
 =?us-ascii?Q?BG3XI1u2v0Y6YuWbIjG7T5a/sRxisiv7wxoA+sVyidyo3HTI2bXwi2H8KSxT?=
 =?us-ascii?Q?p7asE99dCfmB08dzL6cFVSGa8+dldmXTSOXjtMh6rwGwqetv5VUnGhTaMrwV?=
 =?us-ascii?Q?9hJK5wpcXVwnNkA4UFgn/dm4pBf4ayTOSHsbRJiIFk7MyepCHTL0lS/CC3Ex?=
 =?us-ascii?Q?o3Esi8qMvx9dhGeJYuqYa5w1j45Sfs7pbnvYeheg39/ZlodPbCJyWMS+q+6D?=
 =?us-ascii?Q?SWXBFPsptzKGl0UXSBlShXH7GWQOIX3WSAmDchm03ABP969MiOXq0Xecmzg8?=
 =?us-ascii?Q?aF9MfF2Io7slnZEdUJM/nGJRhOGQOIOykyNyRJVR8EVpNXDnsgHxJcLZg+lC?=
 =?us-ascii?Q?twdaXpp3cFniQPLBKBTM0m5fhcYIKrpv3K37NXRNEcebmUNXlhjww3Pdocvv?=
 =?us-ascii?Q?hhc9AWBFFIFErohLW8Loew3z1LtPDUBIr9jgjCQXuK3avWTlP+/KVgFzk+s0?=
 =?us-ascii?Q?+0TwSO5FCfeTkxoA1vOrlO+IgvWfj6kYNi7D07pz+WxBfK4ZjqbKn/EX0D9L?=
 =?us-ascii?Q?hAssopqJ7g0WPEM/MtzY60ecU1cmX2S/N906evsOSg043qiX//IJGGFIfoxw?=
 =?us-ascii?Q?dlMPa7nQqtnwC/6N1rTJGVhUzrlsoNL8FI2jnRYeXb1PnVtk8ooCQU5O462F?=
 =?us-ascii?Q?0sMCutOs34u61AkLZBWjMJuSd4/6/ACqtCI4kKaSqPNCboRYAGzNFfpB3Luo?=
 =?us-ascii?Q?m8IfxI3kFR8BkFABDPY4aGddhqTjwmc6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:32:20.4712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88af0f00-1ff0-43de-576e-08dcb13b4b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

Fix the reference counting of cpufreq_policy object in amd_pstate_update()
function by adding the missing cpufreq_cpu_put().

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 804fab4ebb26..36edae40db1a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -560,6 +560,8 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 
 	amd_pstate_update_perf(cpudata, min_perf, des_perf,
 			       max_perf, fast_switch);
+
+	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_verify(struct cpufreq_policy_data *policy)
-- 
2.34.1



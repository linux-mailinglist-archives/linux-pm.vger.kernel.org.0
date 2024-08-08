Return-Path: <linux-pm+bounces-11995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1794BDA4
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 14:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6651C22677
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C1118C327;
	Thu,  8 Aug 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YIgJuwTH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75663D;
	Thu,  8 Aug 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120674; cv=fail; b=e0h7teSqitaTewh1mR6DWevMmQATG+fYEn1+Jixqi2AFH4o5S1zklxMgcLpSPFzeR9Sb28ToKa9eaK9qA55TesuPH7TYKTD9/WsqMGQajvojjWZiumcAV5GDPv8+5+B2TPJFdZAGJ3xhKvdjanTu1J7Ls2p25MHNU+jrTKd+NLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120674; c=relaxed/simple;
	bh=znFBPoJLnQzgpAyU1LEd4K36b29KXw/px+Gr6XIzC+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p9Tw3SC1od1GmkBR+5yK4e7qThgT6FgqhDuu9jYFgSQH3NtYcWk9POZ746aKyeev/hyfq4eAnzb38lR5sEUR9gYDidOzFc6fSSBRnIlf+8ZByQACvqzLmUCsfRyowPbk1kri9sD58JlyCdPwClWpNhmN+mV7+LV8hm+Iyg1Ootg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YIgJuwTH; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA/vLRrO1lYgsZ8vgdZZK0ijK1MgV22nE7euqtbxDDTdHvHKiikJaakuAGIX31IQH0ZJKyMIvyuKNIGm5368oVOhb5AKAAmknZ1UDT+BgbdNt0SGQ529SNi6PXsCc+FHIsVR5LnPcSatvV4z/kC9KIakF8X3pQIXgBf/NXGoL8Ej1cfUpKx8ireo8TpxaYUMgqsKAxmaTckLU0WHPjtt6utZKy0gU6Wu1WM/KDUyfW4M947+GBJ26AiG1cnVfgVFXN7DpRSXTeTsffmZAJ/OEU9ZaMzDHTYVjfQtOfFoZ53FHoZ2Ra0HYshLTD+j5bT0BHKkUF50PmWzd7AsOd/mRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez011FTiXme6+4NfsNAKOh53eo4p4Mn0gtq4skhxTvU=;
 b=m8riO3ywJaCNlroJWB3KbX77EWFrz6lXSAze/8QMIkrrIw7dWh05tRK4YByOkNOjSGaiLqxrKEMTG/arvjsxrowRKf8XheYMYb89mzlNjmPFJH25EKgzyI9AKHA/lEdKxlm0p76uQJqQuoQJMIteua2FoKKcrOZQ9USSCPcvMTiS2Cxvs9jwsAI6EjMYqcveCcxde/0WcxmYgoexPy/CYLtjAliFHNGlGA3PGYFLmn9VrRKCuiatVoP0wNxqXLAidVoyNJt7AwyVU6CXU76LZtI4OVFxR9KNitgFV7cIUfL0XgKH2y+TJaRLWRoWF+8ImAWkOP4/EQLd0yIuSMG6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez011FTiXme6+4NfsNAKOh53eo4p4Mn0gtq4skhxTvU=;
 b=YIgJuwTHCEKqaosKzu1/0onWrXmiw7oWsYotc6lLatyFe9NzN5tb+3QCEhdMxpSZkEvRHHOdRQo2Z8ov33Mj+aLlXUf9ktE8O3z6tg8xEnjfjM7KVMsoZk1sxWW6PSpTL24oEhTaGQuUaEnsZqWEK2vsrdXJMIzQSCAO3/zLVFg=
Received: from DS7PR05CA0058.namprd05.prod.outlook.com (2603:10b6:8:2f::11) by
 IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 12:37:49 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::31) by DS7PR05CA0058.outlook.office365.com
 (2603:10b6:8:2f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Thu, 8 Aug 2024 12:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 8 Aug 2024 12:37:49 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 07:37:44 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <li.meng@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Date: Thu, 8 Aug 2024 12:36:52 +0000
Message-ID: <20240808123651.3741-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e356ee-844a-4fdd-884b-08dcb7a6e9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FvJbgUoRrcrLqitF18BHXg7GeZQCbgjZd8JW2Ca2XLKihSIEHv4tkemLypi2?=
 =?us-ascii?Q?e1UrKmNeHvCHW3SLNH95PE++nc0avTmzxUnJiih1n4MAcEtOxfbZOMtXRMMq?=
 =?us-ascii?Q?Pe0yEr9jyHUhg+p5WVk7My/WNH69NvgH9wf1NAwaWdAOlC8aZPw/5T5asb4H?=
 =?us-ascii?Q?r+Pn1hdj9t8bH/4HAa9ZxTcxlQLOMTZvmHBZBZwBlDwiAwN43KZdy52N8tvQ?=
 =?us-ascii?Q?wOfXDGrTArHPJxuN+mIOjOnhh5AOd0p6GxICBNAzSJ7Nfd8V4Bh7M8m8lTJy?=
 =?us-ascii?Q?Gge/euOXwfowfMD3b1q1CqtQBVJOcgljuipgJCQjqO/0sLCYxEmqw6H8ghVF?=
 =?us-ascii?Q?n/++D0wc5mWAa2/uHMW5g6zemt0ScbXzdpbU6Lff60y4lLmutduGsIy5cWDk?=
 =?us-ascii?Q?OtgODc0Ff5krUfpKaijYPyqVBKJYmFPLhmsP6bj0L8xqmK/LSEX2EOkXJUR8?=
 =?us-ascii?Q?tTVoTlDQ7UStst84w64bWN7JJYnK5qXs2nRHzHag8AtIhFv2AXDhiR7DGKzB?=
 =?us-ascii?Q?tEUEh2LRIYXqvhixVU3ixEGGnIb6wbbapTCGS2pIl9t+lHb9xfdreuSd6xD8?=
 =?us-ascii?Q?iggbJgXsK2kJbngpWpZhjTNPb+1s6cy0KDivKnbfuXsHBpkuSslH1oUTfN8D?=
 =?us-ascii?Q?MsS/gLl4EenSN8Wwt/T4FpOGCcHabZ/S6YJQ3OmMxpGkbo3Y0LtwuU7o+y1Z?=
 =?us-ascii?Q?P1HWDgwEVhzzjRAs5btujlqiRP8X8TAgzoIzAq7aIRip8jC9moN7WFprEVfG?=
 =?us-ascii?Q?JSYo/Q1fMLYxwtgWFwwXp3Nnb6yXbd+LKLxMGKpZjwoVOFyeNC+8gxD5yv7f?=
 =?us-ascii?Q?NXWmPXTWqvUNAhpAE0yz+u6zydA7Enf+wmgz3vdW/MqfRTZM2pC2LbpnWQpV?=
 =?us-ascii?Q?AwTbXpvrUoIVgUydb+f8F+AWRFphzWa4TSLXLPjaKpJ0tSFdD0jvqxcUYCW3?=
 =?us-ascii?Q?oYVChKkbg2w5tVHwulhW+m2p//m6RDi6UCVfnm7KJNSdJmuAQX4YMsyOuQoX?=
 =?us-ascii?Q?gTHyRMhGSA1nZclNtxwl09bwU3lalyWcRb5Iusc/YoGDQMBP+RAb+XOTJ9hG?=
 =?us-ascii?Q?6ja5QapKWulY/l7JCotTE/AZqchUY+Q9JwJMTlKV5ntDiBAV5MOAvx5FGT3Q?=
 =?us-ascii?Q?o/PLtS8ErBLmXe6qRRl/b1z1ZWD6Fqe90LHmVTqDiwedj75Oyuu7/4UHRAFa?=
 =?us-ascii?Q?br6I/bO2pK5NXR4wV/BhgTuuThGkOoo5F8n+ERR/0K6BsLMv5De5OSc1DnKt?=
 =?us-ascii?Q?NsoZjL9o3jivks2w5I9om0iyj1ZRShkK3r7UC0stwW3lZz6bKEY2aYMqgGv/?=
 =?us-ascii?Q?k4vO0W7pI6VoABU5m9bM4/VWS6nWDF6VXndx4oY6y+ZatQGiTrCwHkOCpUaJ?=
 =?us-ascii?Q?W8koz5WpRIjIS1hWii3CVTKbGhflLUtJma/gnmh9vVpGIZSYJPVd1Flcf2SG?=
 =?us-ascii?Q?2ddl3HxwP0sQ9U3KIsoK6jWD8BDhpmz1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:37:49.0704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e356ee-844a-4fdd-884b-08dcb7a6e9a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

Fix the reference counting of cpufreq_policy object in amd_pstate_update()
function by adding the missing cpufreq_cpu_put().

Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
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



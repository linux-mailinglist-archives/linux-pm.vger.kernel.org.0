Return-Path: <linux-pm+bounces-10079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B0919967
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 22:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14364282FED
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94971192B93;
	Wed, 26 Jun 2024 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="blQPOBrE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D066E5FD;
	Wed, 26 Jun 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434867; cv=fail; b=WPI2xFmJ0NvK+o8a23AxkbuBdsRH2ixw99yAWosN9x83T3sQEYf6FepgILmMK4PYyKRcGR99LAdHnwBHG7s0fYLP1PEY7bXqJP5MteqwgNMRJvfK2++CmLU4ELmByKAveAx2jp7WJcH/Y6CDm1p9Nm8Eiq9sqZLAuHNe17ev+/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434867; c=relaxed/simple;
	bh=inePYGi8keHgXtyAd+CAY9vNB8M92iLnmjOdW9H1EMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upnuyR+5T+JfT4awZcxN1pFJDzri0PFAKeDzT+/ESkFn9w4UZ+7jKgYTMOOY3vvBymGeNlgZTAMrMVZeLaokvvwcx+Aack/shixRD44q/C0T0YaZUj3ELZcPbmsJ2ihoYwJgjlU0/ybwxArS74kn24ovDFxm0yoyxLpc4OGgdZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=blQPOBrE; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oqa21VpiJ6oQRMFp1Ee+JcSR4y5idY+XY6YR/pavi2gu71+tPzT13Tf//DnDuR6uRdsBd7rX5t5i8ZO+bB2na3VroCe5N/unOH+oLx28pLoyWr75oSEmvDLW67oeFlLq2lYOXTpdycr3Ir8uEueM9J7UHmW/zCvYBwdVybBeTYgkJ4bIc9HO5vDDuLJ0zWgzBo2KIyTmKuP4YP0GpiCjr08KGMUO5Icw9s/LnvKPLUu+Mt3JU9wTz9iQA9oJ0h58HLa6H3S7b5XPPCw6g4hHh7mUGKpNThQJ3XIIZI+10LECOZgyWcNs91tTJnxkhQlYWkhBfFnp2K/2SgCgsr8fKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNpyi2alj3eb1hRauKooeYDQRZJyD9joEMfkimWVb/Q=;
 b=dRYxdfVYIC6OixoQSHbvSlPfQW0wh5wns1/O8dMGcZQHHkzvD//5G2c7ghzWfCEEGtoIkVeF44Yw0pIrZpFjocEmiRxegFuDXXv9bffz3F4+Uk01Bqoj/3hrAy/HpYTvoAt2RCjmrGuOU9MJ8PluVuI8rx3E2UK2dAKyk+npkWQP4kxKP/qU5Bvk/Gx1jOzefl5nUjYBFArZV+ySP71+E3NKWTSMstU2NKdG0Wi2IHxZiz/KvQc7FHoskHK9EQldHuHDAiQb6dxOKFYYzh0me44QGOOkq6U4VX7JzxsiSmvBfOBWt9SwRxAEcnRJ2wm5yZyAw79HHww7wAYhkM+iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNpyi2alj3eb1hRauKooeYDQRZJyD9joEMfkimWVb/Q=;
 b=blQPOBrEUxuDTo/W8fkQTNmbZR3FpDbLaqWF6z3pnASb9dMpYgZ/AgKMaO3vidSYp0el4QKHDwdWI/IOLuqP3EuMw8VMo/YvqVooVqUuEZOwNzH1W7FEPyHTucXdxT7xDlHHhHzOWwJMtqalWC/qcXzC60YiIGoi3qdnMnohYYI=
Received: from BLAPR03CA0113.namprd03.prod.outlook.com (2603:10b6:208:32a::28)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 20:47:42 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::4e) by BLAPR03CA0113.outlook.office365.com
 (2603:10b6:208:32a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.39 via Frontend
 Transport; Wed, 26 Jun 2024 20:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 20:47:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 15:47:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Gautham
 R . Shenoy" <gautham.shenoy@amd.com>, Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>,
	Yipeng Zou <zouyipeng@huawei.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/2] cpufreq: acpi: Mark boost policy as enabled when setting boost
Date: Wed, 26 Jun 2024 15:47:23 -0500
Message-ID: <20240626204723.6237-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626204723.6237-1-mario.limonciello@amd.com>
References: <20240626204723.6237-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: cc415eff-9573-45d0-7a7e-08dc96213988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|376012|36860700011|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TTLwwOgjtgLWPxXpIhTZk49RocJaKO5hjeS3HvtIfwKMcy9gvub3C0J0UTT1?=
 =?us-ascii?Q?OX2BR0gqxsrGiF5t3ZglgX65ZUCyKyWSiSnVw/02xZP/2Y8iNFBc237oedyg?=
 =?us-ascii?Q?xLPOkph/Z747kVFfY4FOCDIz8MNwWCF2QuXR291+ks1Y0+rTeq+VeHPNTMeR?=
 =?us-ascii?Q?J09jI8JoI2+Wgrtz0OpgFRosiVfAForuoKNqe9Ni9ZqbuBv107sGXWpE034p?=
 =?us-ascii?Q?AW22mOtRLNyeRV9Qz0IXaCbT+rEaUq0dgfRVodHI72dqOqWjOSYzAlKD9s0O?=
 =?us-ascii?Q?xXFPiOpxbdHuBq7Ug6Q+o+B0YJuSEqkKKyVKZY3PTDBRa9gNmK8B9+Nh2YRz?=
 =?us-ascii?Q?dzCELsSTXUNV7eLepL5aYGVvUoyJQ1Pduhao9USu4nEdqWWva01wjwnhb7ct?=
 =?us-ascii?Q?liSriTNLPEEK1wH3EPdc5zaCYPrWfRzkf8cgYxGw7m/mvq7GaUeKlB3cqq7Y?=
 =?us-ascii?Q?8jsbvmtWgCRcHQtFUKr/ROtZvRCw9NFVlYIo5WdUwvowXqtbjaf8tvstRvOd?=
 =?us-ascii?Q?qgeO8MEEOqPwM1bGdTEToApEIjw4mr0lJKoErIThNS3iIIQgVBceC7QrCxux?=
 =?us-ascii?Q?pVLjwnvTmdQ4JmyfPC5JbXrvFYOvWU22zCmsUv2xqOKVNvJWOWqoXxHdbfjs?=
 =?us-ascii?Q?A7EgCj1SflNN+HgYSssEPSLSdaX1vT7Haj73pKJUTsfKSJcR3DyczGPnP9bx?=
 =?us-ascii?Q?4nqfeu6bP3D81bCpsMFHDvSyZ0xt4omr+Rx34qP9O3deYhEx/ThGq/67wrS9?=
 =?us-ascii?Q?FUzt3g5BDK7O/RMwe9aj2VrbcKc/s+RCXhXZEu87wz75/wwgwtYUwtsKov9H?=
 =?us-ascii?Q?VZNLgS2HIu8VgVPiUN5BhdiRk3a8J7TWn5M7tiKWkUUOyrkILGJLjCAWMV57?=
 =?us-ascii?Q?PI5wwcEMcwYL6Rtiw9QOW5R4jyyppPSX5KazhzCIyRusnauuNAucjTeTDmam?=
 =?us-ascii?Q?xmpuYjyT8NBDTw4cg6X7WD0aG8vXk///WhnhoiApRjkdfBK8L7uxFVXGM2Bf?=
 =?us-ascii?Q?zv+6+gESGfjjxIQgr3Q4dLPbuzRRkx268n/6F752wXSIJ/XsYmbD00gi2z7Q?=
 =?us-ascii?Q?fWjIqiN1J5xX5rbySkCDfJjXeqKcifUUf06T7gLFcZuBFI7+UnttS9h6eSsh?=
 =?us-ascii?Q?nkMqdjITwYqoYHbV2T+liSQseUHtcxSRSbRRDr2041atcsP1FnTD8JB1JwEv?=
 =?us-ascii?Q?kFagcCx5sgE+wi6DClQg7nR0bxcaerocNrEhkAZmWputUIO6jFFP01k9TBC4?=
 =?us-ascii?Q?QQo49F3V69+duME/7LIAtjLVSuAt9/CpfG7poGiIrOZWJ+vUHnagBCghIves?=
 =?us-ascii?Q?MyM/ZgvW3kGmxc7V4su/ioiJjNr98VOHY3PKC1ukdedF+H5745C87kR8QnIA?=
 =?us-ascii?Q?qlX5TEXcSzMnaH2iUkgGHP6hg8JsV3m+EPLP5VdhJHYsIuuFQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(376012)(36860700011)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:47:42.2319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc415eff-9573-45d0-7a7e-08dc96213988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242

When boost is set for CPUs using acpi-cpufreq the policy is not
updated which can cause boost to be incorrectly not reported.

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
v1->v2:
 * Move to init as suggested by Viresh
---
 drivers/cpufreq/acpi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 2fc82831bddd..fa2664f9f259 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -888,8 +888,10 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
-	if (acpi_cpufreq_driver.set_boost)
+	if (acpi_cpufreq_driver.set_boost) {
 		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
+		policy->boost_enabled = acpi_cpufreq_driver.boost_enabled;
+	}
 
 	return result;
 
-- 
2.43.0



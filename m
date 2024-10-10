Return-Path: <linux-pm+bounces-15488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B0999299
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289D4281032
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044951E500F;
	Thu, 10 Oct 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LIT1hz+L"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACC1E230A;
	Thu, 10 Oct 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589073; cv=fail; b=H658GwckziTqydxHflbuR18INadDkYcYvNJxi+aguwxJGqlpAQkDu+PynJ6w4JToGcBOUZeLNUb6Ti6qhvnkdMaSVAfJ9TmJcI5C95+Au0w7i/gBOy/sFTZE2UcxukLw13t2FfeGrG8Q2VyUNXYp3IunQQjxRV6osCz9R3rFqY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589073; c=relaxed/simple;
	bh=muiMyhQ6HOByCuQz5kAf6ocvBnUsDnmDZ4WHyAsUlWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecUzvRkqU/Sz6BsljF1Oa3GhMDqLhe7ydtM7EQoRU4WH3TvlfMwa0l6cL1FbP24N3QDV4R0r27waTNPxnV63Prto+dtuOK6ijRaCM2bE6ghDk/MjhOhQclsRwbUUNvrkYGvSSzWwZwylEuYWgBGErR26T2oXV/Npa70OP7dLjkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LIT1hz+L; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1B3HBmFiyJeuq8pD9/XKC8aYz9iKwLKobm73WwCFZPcpgsk8AYtsZ6wkMUJ8wZS3oGG3RR+c0gpZLs00DHBtSIRWfD1PEaFO8hQJYqRcx/b0iKjCRdVdrQZHVEKq2HXfZTfQzoB8UTJb9kMgpjmhDGUcB8wBseMu3SrnJqV6WR0c8kpP6IWQsjzJmAheHmEn0dFtVe2D+H16CLON6rQeID2DvjK8jgQVOVgRI36PgbHLEM7eZ6pDR44hWNS0QhYULH6pzyrQ0izNUrxSaYRzv5vpSo/Ri3I6iPnEr0peQzvJO/V61rLh1g0nCoTMmjZUOVbi6LiHjUU+2qtSfh7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFx/aQdUqk+kQqflSePbD/Gk+tbhSGqsauJki3fOICI=;
 b=bX2UD9Th2FXjgSXjtu73y6r0ZndcZIvlEbUBF+ITAqP5uUp1KIbq++udElTUKsrvFsO+M+zDeuIC7fmD2FmTamG2mOQv00hqKjd7B5CbFaNt2otk0odLeZ3LlvBwFAZ4jXyDIMXLRw/XdTk0Cx2CO2LB55CW43OY0TPlMrGgXT5Aedlf85/PGCZ8fGwxGJkTPQhiRYp7jZxbPLYi2Im6DxSfB3nHrr0M/Z9Vh+ldRd+D1sYxRE25qPklU4MOkDWwsfxmVHHsnWEjBtog4WuNElgnfyxOiwQj2Tp+grCxKjz4HmvSJ/6684w3rUPcvLrO0Sg9TRFUZR9C4XJlzL1yaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFx/aQdUqk+kQqflSePbD/Gk+tbhSGqsauJki3fOICI=;
 b=LIT1hz+LA1U27lKnO9D79/dUH/Q2Fdbc3jecm41djpTjwWF6lgYMbyeP3SbqnquvXfSHzNo1C6oFYmDhx/78AHodVBhV2QuwhxisZ/Fa7pEBqslhKhMqYPZBtQhHNYV/5kkNj/sLK2asDPZUOXgrS0xPELeA10xPWxWC9GYApjM=
Received: from SA0PR11CA0083.namprd11.prod.outlook.com (2603:10b6:806:d2::28)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Thu, 10 Oct
 2024 19:37:47 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::d6) by SA0PR11CA0083.outlook.office365.com
 (2603:10b6:806:d2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:45 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 07/13] platform/x86: hfi: init per-cpu scores for each class
Date: Thu, 10 Oct 2024 14:36:59 -0500
Message-ID: <20241010193705.10362-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010193705.10362-1-mario.limonciello@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2b95ba-8501-4405-825b-08dce96304dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VuHKUbOqUXK/SY1GAN47n3CoyxEyIDQGYnjIeGlqfI2DAllETF1Sm/JQ9RkX?=
 =?us-ascii?Q?kyeFZLBo5wiG8kA5h8Ks27aohp6ppe/wzfirCy2XQ9Dpm2sxp+VH50+sSULo?=
 =?us-ascii?Q?wSpylKcnXEa3zFyVoAuZ16QsFwWAHJADGV8I51avUbO+aWGeqet92C2r6Zh4?=
 =?us-ascii?Q?4uTlPomrMUz6uZT1ubeZXPxU9Q3xt11KGdN7rcmOyKuvNkZkGSb81m1lIIAV?=
 =?us-ascii?Q?DeD7YF5ZmD+mejg3LlS0IPPW9x45Js1AFmoVUAxGfHF0mHYh2Jpu1xwxUEzh?=
 =?us-ascii?Q?6TbLtN1FfWfoiTM/SXM/KbSBspOsJvD41v6XYfKt3DgTHtSbCuzwQPdWmYDN?=
 =?us-ascii?Q?VrYyCYzaVCgZMNOkylTlVSH8UPuWNrRYjF0z8glTC7bNMr+xW9CaeRNhfk33?=
 =?us-ascii?Q?BpusWlSl03B7Hs/zn/AFtkkRNhhoDBc2IqfR0RlMmv03sPuW3xgrfnrxg4fQ?=
 =?us-ascii?Q?U5RKR2qKfa+i92h4gJh+j+f00CMLuXI7ME2gz2dY9wVQTNDsdTAWiua3wKXp?=
 =?us-ascii?Q?7EJGDK6r0G0HN5n3rGGjtCjtnFABYWkKK1gHjgyyyaDnKyBAx2hetLsKhrP5?=
 =?us-ascii?Q?gZlzpnMrZ/kFuz5qIbRe+WizFlyztyUy7YO58aX1KZgjHNJGrrNHSe8o1TgP?=
 =?us-ascii?Q?3qxetaXSvxmP9NYk5oEO9w7ZtPr40sDwJELf8IqB4v4w2Mee/7iAs2/NJPnl?=
 =?us-ascii?Q?twcsq02KU1gxZKEqIFWRogjV3Z28jC4SaIxhZUUr8eDcurHgG8eIF09HCX0q?=
 =?us-ascii?Q?d/zpvf3nOvDOR+O5XM7+7Bzqvxd/CNTJXVDRV05kKRwn79cjvFO412MuycCu?=
 =?us-ascii?Q?tuICOMN7/30wYTBA73g/i4E17jnBucjiOELZ8PXWRC+LjkearrncrNOzq6eP?=
 =?us-ascii?Q?CIEgKjCqD5i+ZixnnnDHfy4QOLcCgaWOAA7ca7DNjJ1YME9yaSG44LtPgzrZ?=
 =?us-ascii?Q?60T1d3MBQ9iKWbOXV5Bo+dIVNU4qN3Tdx+LDqhCeWG7D52m0PNAoFVYXdp6H?=
 =?us-ascii?Q?csWZnay0c1ToosuEK7HBD3W5q1jB410wH6BB2guHJqENT/VAvr3dE7HvvuJp?=
 =?us-ascii?Q?fj1ce0ehl02Ow7VJx7JUJg8gcbyvIEhGjFnGI/7fAL1HS9CLwnof7q6hbAru?=
 =?us-ascii?Q?fuzX98wjQNw7kNF46V3qd+YkccMxrsGV3fOPLiGhrQl7baMjZ+LFiyIs5mB+?=
 =?us-ascii?Q?0JMAz0Ep0oRZk6y87jywnKHqvej24J7qs9q+woPGGedgDfphI4MIrs/gIYFj?=
 =?us-ascii?Q?Htog8bMzNagn1Go1aHE/jiKs1hbgaartMbSovJ+vclO/WpFLlZsPEMv/NfaR?=
 =?us-ascii?Q?iZOOTmjT4IOHYUuC1l/JiM4Q8Po/Y2TxZ2ozP+aYWQoWQVqqb0LovMWRdneR?=
 =?us-ascii?Q?epS65+prI4EEmIGULV56QcMp48/5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:47.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b95ba-8501-4405-825b-08dce96304dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

From: Perry Yuan <Perry.Yuan@amd.com>

Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

`Classic core` and `Dense core` are ranked according to those values as
energy efficiency capability or performance capability.
OS scheduler will pick cores from the ranking list on each class ID for
the thread which provide the class id got from hardware feedback
interface.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Rework
---
 drivers/platform/x86/amd/hfi/hfi.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 10651399cf75..c0065ba0ed18 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -119,6 +119,8 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -233,6 +235,31 @@ static void amd_hfi_remove(struct platform_device *pdev)
 	mutex_destroy(&dev->lock);
 }
 
+static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
+{
+	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
+		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
+			   hfi_cpuinfo->amd_hfi_classes[i].perf);
+
+	return 0;
+}
+
+static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
+{
+	int cpu;
+	int ret;
+
+	for_each_online_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int amd_hfi_metadata_parser(struct platform_device *pdev,
 				   struct amd_hfi_data *amd_hfi_data)
 {
@@ -330,6 +357,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
+	/* set up IPCC scores */
+	ret = update_hfi_ipcc_scores(amd_hfi_data);
+	if (ret)
+		goto out;
+
 out:
 	return ret;
 }
-- 
2.43.0



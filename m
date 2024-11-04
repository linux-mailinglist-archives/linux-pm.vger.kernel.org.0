Return-Path: <linux-pm+bounces-16987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573799BBC8E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B16F1C20DE4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71D1CDFC0;
	Mon,  4 Nov 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qhE9F5Wy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAC1CBA01;
	Mon,  4 Nov 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742889; cv=fail; b=EoyK9Eu0Gn0sGXcytJ93tYWS3mH+XxGWDHbpPI0MEeVb4Vh+9L78lEDovJMpG4PCazrokK86O8WWcpdiH53K75hJt7jKvEjxuCpNWaHxfILcUMG4jNqubVU+rDuFT/CVMNoDW6oeB6QRoChJJGYs10BeU9z7d3zBtyUQDytB058=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742889; c=relaxed/simple;
	bh=eGxK2Y+vS6ZwqF8hHY7GKtVt6LHQ+atU6Qa3AJey/AM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLPeaobiSFpjF1jCZdvqMsFOKIRjd8SoKjXm6rfoVKVC9x2ida8XC9SpBWCgOf2dpxw0V4534V4XzwuVo6H/QSiEjWJ6cyaOpFWiFSAp0ORmKW/7oiZcTv/+ZsurSLuK8QrPKf0t2ivNF0oYg21xkISw5IXC5H08DzB8+U8wVn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qhE9F5Wy; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqcN+WchgSaa/zgiREYAKDLyS+ofYAJ1SxjhlduCRodRdqa4GzC2lkbWoQWKbURNf05EehT4Cu0EGbGl70Ivw16+1Dxhrd64Q1bxPKIiOQOz/ivz16NmBKss0gbkJ4QDXEYu8axNJd3DvBgzGdfJppKGFC6H3PZTFiORzjkhWw4iUV3029FkPbPkQZhCgNjTRvf9lV0C2ie0B6Bru5tKuBXjsB9Vc9eXdUyoMevci+rxtbGaPO4k898kWJlDNTVD3w/lnF1S/v0/5h6m8JJ7764d8stir1VvvTXfK5L6stxXePTsN5aOXrNM/gGAvLeRLSDKDgaYK/a6g+mIU16Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQqn5inL38vxsHpZRPV2GUD/L8Bnu2nVxRJ+eYqkMgU=;
 b=UyjkLEWOk9jCD9y7cz7dlCoeqlbsValdQYxGSf9M6sAMcNzq5UsylKRRgxByHl+IiSUrttufdOuTOGTE94ogOhRJMS3uxJXK1YPgVLN4+Mk3oBksImVVP3mtEv4bOURoFdeF2jAJ1e4Xv4DJN9uQFsFoKno/bvtJ3WOGxpdDRECOY+rqBlH6rzRDyazfr+YIVq3y+9gXCJDcO6dvh4RsE+Au/1ZSqEuCdc7jOH7lvG9YhzUTTIGZ7ONfO+YMiWV68oiCjcyjkKF27cjvn9ZnNFwBs5nAP8SS8WWSDpztdHb/21KynKjVqxqKxRqKRl6uiaOaenj16LikwCeuCBytwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQqn5inL38vxsHpZRPV2GUD/L8Bnu2nVxRJ+eYqkMgU=;
 b=qhE9F5WyEiOLojPRpSODaZg/8xFtZXyO018rTY81ypD1U0sGHQz0/5qq6cnidaTQqDTvUVZ8SuvxM0mftj0N7czaMScGhNOgjnDduxDTFBz3gjW2SWq/UDwJAVQILys1CrN+/dpmZAgY7SRcOW8rFWkWmw6gbaBIwQkRrUTSSbU=
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:44 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::4e) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v6 06/12] platform/x86: hfi: init per-cpu scores for each class
Date: Mon, 4 Nov 2024 11:54:01 -0600
Message-ID: <20241104175407.19546-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cd4d36-f274-43ff-dcdf-08dcfcf9c3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQR5Wsy98hXLuAErrPJYzrgfeNuQ59KiggRrUgfNzLqrBvuKVHdFncXAjezW?=
 =?us-ascii?Q?1dcpFqFgEP7eeOEfNWGw366pC5M3mSnAkk3AjTFQj8ZIf4cpDyVU24inkLGd?=
 =?us-ascii?Q?s89mHbIkCOnMje/yKH2jTZtIVbw/Q4x8c33moUTjHpeDSzTkevkOPs5WnUHv?=
 =?us-ascii?Q?gVCtnvXAV5Qm0bQ2t53k2c8o7anEm1n7L0oOCiFlJP7WjCdwLE6XTmdh2+n4?=
 =?us-ascii?Q?yplLbApMVg9v9u9Pdjk7kBAzpPQpb/8aoS8NusnXj5NPkqBJwcP0L6m7wvvG?=
 =?us-ascii?Q?xz+dFcbV9T/hzmXRvP8FJaDlhkmc7TjPFcCWmUfDSZTtonR0dIJDQ6BBBER8?=
 =?us-ascii?Q?rEYNP5oCSlOt3hDWf+84enUdqpIeTt+wHyhweJkSSuZHKBo0+26Z4gkk9HBu?=
 =?us-ascii?Q?1W+V+6fiumGEO6TrZe43Z289ECNEz8+wpfQGA067p4PJUN7lEKpksoppWdf3?=
 =?us-ascii?Q?wixCOPw2DPPAZ7eEKs/cpQjiEX/6JXI3WHN/KsrfEcqE/lr5cbnCAbHa0yzQ?=
 =?us-ascii?Q?LRC3HbGmF9HywGj622NiGVvN8+fXQH/bIt4lUiETsp4AGeuLLXAzUZECWq2D?=
 =?us-ascii?Q?YUb3Gg2MnCKDD38augppcNIyFSc0BDdMkxRkoZjxxDWsX48nfGUb/JaDBpcO?=
 =?us-ascii?Q?i5p60jvA6AhDUrDeiPmtCKUlZQYWRbsCQxF/oVECMkbECG2DybMvpD6Hy08A?=
 =?us-ascii?Q?Pz0SsBIkkaTfWdX698MceNRYlOQxIP4EPe86nB2VCxVfM40PujcHitrPx04p?=
 =?us-ascii?Q?AH5ag1zhLXnXt6+8wkEyDfeoUTfbhQYQsMHh6ZKFuGj9TzHzYhyI+M8onv8W?=
 =?us-ascii?Q?6IK/1ENGGNJsTGiRLFG/lznXoAhT0FeJH+/aq8ods0nnTlvyNM3EETIcug8E?=
 =?us-ascii?Q?CCxn+NKJwF5FeKgbTi6ex43W1b/1T+7cQT0LssPbSxNkPQAXWUvQaV0Ly7P5?=
 =?us-ascii?Q?ozRxMgoW444r7MZTh9lUfqQo+FkLEziYlX6SQvz+Ey1P4bAGVxfBj/Jruc9D?=
 =?us-ascii?Q?rwxb7WU52lilEjBcXuNoJtOkTwJ3la7X4CCRbNYw4yt0lQS0B11X620Ieu/j?=
 =?us-ascii?Q?h6AHO/hRZP6cgwSizxznePQjcgWs6v8iFJ/1NCu4VpBNay0Uw90uTLJc2zVT?=
 =?us-ascii?Q?usVnn9kjit5lTh7ThY1ypSHpgsTcg18UDGDWKOX7qP5XzOijkKRIdXm6q9M2?=
 =?us-ascii?Q?03O44S+S3fEXrltZd/WEis9atNSpCMt4k36hN4KtxUDBG/P28PCiePIS+L8r?=
 =?us-ascii?Q?T8hVq2lpgHmLypXEDkxg4sJx4FkjU5bO52SNRCXJOVU56aMyls94R0pUTVVm?=
 =?us-ascii?Q?2Ffn4+qzWpnWKF6uT2ah4sKzgbZLW3bG4Bw0+6zvjlHvZmaIcs15GBGhkRuq?=
 =?us-ascii?Q?kOCtagHt4OChig6TpzMXHDmyK2bBQllfZm5Wmq+w95NWpBv2jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:44.3193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cd4d36-f274-43ff-dcdf-08dcfcf9c3f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167

From: Perry Yuan <Perry.Yuan@amd.com>

Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

`Classic core` and `Dense core` are ranked according to those values as
energy efficiency capability or performance capability.
OS scheduler will pick cores from the ranking list on each class ID for
the thread which provide the class id got from hardware feedback
interface.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 708d7d18fe2f2..9bdd9d9a615b8 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -113,6 +113,8 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -226,6 +228,31 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 	return 0;
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
+static int update_hfi_ipcc_scores(void)
+{
+	int cpu;
+	int ret;
+
+	for_each_present_cpu(cpu) {
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
@@ -311,6 +338,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = update_hfi_ipcc_scores();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0



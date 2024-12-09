Return-Path: <linux-pm+bounces-18850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE54A9E9E5F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423631882289
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB9197A87;
	Mon,  9 Dec 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pBbJvxRI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA7189BB5;
	Mon,  9 Dec 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770399; cv=fail; b=m9yOsBgx/ERArtFJS8NP8ApZ6776DDKAFcr/mqwP+AF/+1HRy/VBo1aHqeu8wfbVeozVJl5fqJlnhexHm3lPxVxaRZVMv4J02L6BKBXq19MphnNl4n+2TeTOkB32zKtUbkACBPCqQbycTDoJKu57o2c6zsTITNWb2hhWzsUsjkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770399; c=relaxed/simple;
	bh=8rrIrjCDFbNsIF6xmI6OBAOMh30oWMQvH3qh+qoEXk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu9FDtYUekVUtAFO3kzmm1ceZNWsxL99BiHj2hHCZAsjJFfvITIQ2lQnfyELFzic+c3eShZ0lg3MSt/S22gr7pqysfmELHWW9mEHKhveMWUGznU4APFsv+MvP5M7XlzPi2qSD0gwefPLcSFDqXdKe6v2mrA+u0ZBSk2c1nY+zZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pBbJvxRI; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9XKi85Ooww5SDTHWeU+79KQ/QtsCOgUHdiOVhdBo5G5b2DS900Rv9CEBNHi/GbEckrC0bwazkHQ93+oQgyFu9BpP1D/40k6hxJ9UDiYRxbJTLHAUmsUzHn11H90UFSNNGfNN+Gslx+1+FdiT47S7n49AWXWfW/J7tNFww1iQmCmOr6FtiJs3CHOrKbgcNTKB3pCNHHXTnpmRtaYyIeyfoz+OUpvYUb9lR/slCew6aOL64IvFVG+kUy3WZ6cX6RkAmuPu0jg8bRA2PgMoS5oV+I9hXuovuGnmMvnePV5XMqSNoBWF54SO/gdmdqE+cqM0jbTuQjUqxUMyfrzgFBoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eroh5IEn3WgUrc3OYPL2JcIXey2+LfsFTzzdzmAMo+c=;
 b=P3BPSuN64X7dnnG6J/CVMq+V3wmfMfkp/vb89SnV6KmUgadahuH/W8rxJhfkHCLM3/gvKxAN+dP3u9GdXw0SRZ7Bbq2V+mx+hcgIfWIL8w3LPcJOQXXItIPzQoZ/gVUdCkQ36n5BK4lzh5jI5lpDXbWCMfXnLSVzV6ms8r+UAX2+XtXkanqYCFqeWNWo7KvARSog0/AyTmz9pLTlQ7ccOvOlJGEhVHXkkLmL7GwwALBeQh20Sz3JTCggYdcY5o045Bacw+fbbLqklfHb171/hjvXMRqxYjDGEJBuEEzb4K929O/wstVGh0igR0KiV7Zm6HhgkNZbrzkYta94FEcssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eroh5IEn3WgUrc3OYPL2JcIXey2+LfsFTzzdzmAMo+c=;
 b=pBbJvxRIq/GfAgwsuvy2QaDnFhdgRXp69TUuDFkcsj0LodkC01oG0sbx/O1ODmi8Jxtyi2YSCDOnytcHvPBypxTmPZUbpdFUdz+b+5hNRSkCrH66UeMK4eZ+To5I/HsHo0LLAeerkmUzCQr6h4ZrThOgmHAmi2a7lAw1x7FLqLM=
Received: from CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:53:14 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::87) by CH2PR19CA0028.outlook.office365.com
 (2603:10b6:610:4d::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Mon,
 9 Dec 2024 18:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:12 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 07/15] cpufreq/amd-pstate: Only update the cached value in msr_set_epp() on success
Date: Mon, 9 Dec 2024 12:52:40 -0600
Message-ID: <20241209185248.16301-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209185248.16301-1-mario.limonciello@amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 827873a5-6d8f-46ed-8059-08dd1882bcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dVG0vewoa1qE1UznaH9cq5mjy5MrWPb2S8jpWaKe+QFApfDk/DHvB/xZzjtV?=
 =?us-ascii?Q?EZN203nTLBuLK+cCNmUhAEOpVfOVanuk73XpAQ+I4xQOwmZ4aPYGsldoXZ4q?=
 =?us-ascii?Q?TLQ+CAszMrZX6/LWGtrkhzmAygQ+DMMi62xA7sSR+YO115ZuqYfmopgPagc2?=
 =?us-ascii?Q?utXhqlU2JJ14JlqAUAaeLQjtHZFptBzQSODRWTvg1RjA4rOGc1Ojcns0+Iuz?=
 =?us-ascii?Q?veKDZQaIMzvgWIKiwFZL0RljUDQ3xJanKxXZL+5qMH6pdetFqwI6Fm3GnWmK?=
 =?us-ascii?Q?ISc4DJdCeSh4zlg3cTksk8HeMi3VEyU3Hwq5KzKJi9G73zStHqQ8dsvKFsEo?=
 =?us-ascii?Q?jx/YlV03QAsee8pZgR938KEEcNHfHrVl/irXJlY7ANlHmwM2P7A3NSFWE9WU?=
 =?us-ascii?Q?HYHgiXWsdqLmYf1Bq8sig4ZUJIrVQL3cF4LIAW9RJSrWAET2MajJb2CULfOK?=
 =?us-ascii?Q?JlM5fsONdMTPhsbBDVIa/Z41u7gu1JHioAU5+0A0iEGelu4GBO1/jbv6rzcV?=
 =?us-ascii?Q?viuAKUk6DwyExj7URmukLFitnmpp8y1gprV/x+FnFZDOUk9G1msx92SkZUZB?=
 =?us-ascii?Q?oC7N2eSOswrBBJ5233u/5n1wStGayR+fsIQHMas56CufQeSzd9atvy6xN+Ia?=
 =?us-ascii?Q?IWD0XcMlwFj2EddAIORA/GhJ8oKpng4keCbdjq7O6+ReSAviwRjRFib77usN?=
 =?us-ascii?Q?v9K0H8Qi7vKYpkEc2LfxDjK4L4/sNdK6L+Np9dhP5eK8epHn/FObrbcbrO9b?=
 =?us-ascii?Q?iX+Kuq3cwW9Vo3V8jcKHVxdTd4KmcBzn5CWMJnxgOhSA4XMbF6a9tJuTfxwx?=
 =?us-ascii?Q?s7KY1bUyWG4TfRAHcl86RMjvQGy+RWR07Xv8DS5YheRMcyLSEmOoevUdAMnu?=
 =?us-ascii?Q?B0sUzDsJ4NkQ++vS1N5UErPk7JWZNa9Ja0BT3I+gUNbvI57yYDW6htv/nzJL?=
 =?us-ascii?Q?6QTTur8GiN9kqraO+43SNhQ9CHbAbPm/pwI8YwEPztUWWhWQDG+A9WldMVwd?=
 =?us-ascii?Q?VXUrPysQcorDbL1XBOIq58eFQ7FqhsFRV/IiN9w1Re8sIiHbEMH3E0HvGNKy?=
 =?us-ascii?Q?z8SIZUGv5BkZRH1SXTsSZ0UqCvYDH4xsch5dxGYzsskNnZn4EZKYBRbG3o3O?=
 =?us-ascii?Q?twC6LrnXwEKN2IPFR79ACPuSxitkXKemdOPps/ihzrZIjrQsOR7eA+wirrk7?=
 =?us-ascii?Q?MHCUdFXSmK0cR08waI76lvA8586gTD40ViXBZEDYN9ipaVvR181Ea0jSkbxq?=
 =?us-ascii?Q?NK/FM9BKjrHeXZiTZgHH0NK6oWAYc/EdciVryxuheDrQC0UlJaB4qUQEjBxv?=
 =?us-ascii?Q?YWjGVMoKmyHriav9bofFiaWgn/xTa4J1OUm8ATMxe2MrzEx1QNWrR36Kwij2?=
 =?us-ascii?Q?bcqDXdkmeYGsus/uMRGj+YeUI2mcDyjJphW4GVii9mYIlGj1BrrIUr/mGsdz?=
 =?us-ascii?Q?dBe1xjXQOFiuBw64MsmZpg4TEgnl/iSj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:14.7244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827873a5-6d8f-46ed-8059-08dd1882bcc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465

If writing the MSR MSR_AMD_CPPC_REQ fails then the cached value in the
amd_cpudata structure should not be updated.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0ed04316a8d80..263acce2f4b0c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -278,11 +278,15 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 
 	value &= ~AMD_CPPC_EPP_PERF_MASK;
 	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-	if (!ret)
-		cpudata->epp_cached = epp;
+	if (ret) {
+		pr_err("failed to set energy perf value (%d)\n", ret);
+		return ret;
+	}
+
+	cpudata->epp_cached = epp;
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	return ret;
 }
-- 
2.43.0



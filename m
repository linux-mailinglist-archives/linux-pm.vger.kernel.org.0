Return-Path: <linux-pm+bounces-25793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA43A94DA2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 10:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7173A8E25
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 08:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CE91E32CF;
	Mon, 21 Apr 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SgkvW/bo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27F12B63;
	Mon, 21 Apr 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222734; cv=fail; b=EeB6VRjscArhr/QbIoifn7QSpU6jekYXAm103n+0cK92UU5r1PifYF/Vk7v4qgSEYGdzOfWJVYn4cSOCPqrbZ5RK5fx0czhM/duM8RiuHiJEsdOmKdXHlTnTHd2qOAPKv3/ImWxjL3K91813XoDui5BXS6jsNRf8qq1pW8cRX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222734; c=relaxed/simple;
	bh=bqUtwFEN9ryEUuCMTCnBTcuKPgU+xEqdnus+dqPLoZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lb7t0qo7aHtzTImN67M5dSrWEnj7x3LYCI54oJh8RjySEW7st+nNo/26CMrNzfNg80wkwpW/c6zOBoD5p6iXxmXmzyYpOx5cE5eVEe7cmIgY55iayINv80ptErHmcZG9fuNd9GTT0+/7ppXuG4W6DJHrbtFeiWorAsU409PcGCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SgkvW/bo; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMvxj0rQD1NtE6F3WIp94F5irp4F2m5zQHsImaWrDcz39VqiOcauJSflnPWFbq6wb1iaSc1/20pjnl7NupuhKXmumQ14CKOvfEZgl6qYOQQzFxwTccSWNwLVUGQGYUYR0Zq7UHI8pdeAUEK2F6UH1urC24cbe7Yd36OT2TRmVDyEccUrBlcSjsWLL6lKGgtxigqYKIudryxo+uHNZANDywf9G2wun4GKiYtBpt4KJ0dYdpDD5GjvDAPeKLxZdbztF6PN4GoY5UoMJnhAAVrikKfF8p0Ab13+oirigYZyIYbAO0vyfhumzmGl+xfXU5xH6u70D5WGsKgGmClSJjIN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W64t4/OV+vWYwIaE4De2LX71D0qZW74dJFBFY6JHdBE=;
 b=yFYdlDrk1u64Jll1ew3WwFkv5lo9yzOW+GaW8eBo3IvKuxbUeDJrjetJfLm4h1bhObXReBnNdlk8nlapi6zAhJOPIk1TlzhSl799XLsa04njyY8Mx5MEcY8deYfEXg5jSSZR8VD56+sECWK1rFPZyUgzGeT+vAun1jeeeILaRQ23sGycUr9qu574hDoVHvKG20o8EBLOwLI3L5R/oKDrE0A0fkMVMBs8rEQqqQlxqMMZyTvRkz81k3H9Yg5ZPM9W25VAybYqjcElZWcQ25lywhSALX34jOLGzA9Ugh8dcnI4NTXsw8kHPMaHvKzJkhVSN1hLdCMHCekMvX62DEd3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W64t4/OV+vWYwIaE4De2LX71D0qZW74dJFBFY6JHdBE=;
 b=SgkvW/bogQj1xW0TK3Q6qxVls9ZYTgvSLg0NhXUm9fh++ULystWhtkFQ1XkcRHSFDBFDlb3FKSJuYlF2TWnfNdSUIWDUO9mllWzCaLLqhBLXDq6erWPIRJIy3t/5DQuqNiAD5lcoJmqE1f0l/ArB1E50MWSL0iAYuGl2ahUoc2g=
Received: from BN9PR03CA0962.namprd03.prod.outlook.com (2603:10b6:408:109::7)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Mon, 21 Apr
 2025 08:05:29 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::6) by BN9PR03CA0962.outlook.office365.com
 (2603:10b6:408:109::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 21 Apr 2025 08:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 08:05:28 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 03:05:25 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 1/2] cpufreq/amd-pstate: Add offline, online and suspend callbacks for amd_pstate_driver
Date: Mon, 21 Apr 2025 08:04:45 +0000
Message-ID: <20250421080444.707538-2-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
References: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: d832818d-dba1-44b5-908b-08dd80ab4769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lVCmLkLEIWybtV8Eome4gsyVB4VbqjZNY8HerFyv5ERJ+EU14w4I+RHJ2ys3?=
 =?us-ascii?Q?HI4VqzNkwVV7eNidvgDKNkDSpFQd0PvsfOY2eHP0nJSKpV34GoHb3J5TA6VA?=
 =?us-ascii?Q?GJw4cFzBNxKRoUMEkvpdeyitZk86RIu4EfVrGOV3k0L8fdSidN50NcGvHRYL?=
 =?us-ascii?Q?ToxPy06Cv5NZdYcAGyIgsamx+D6cX069c3XPmaY2aKJfR+HgdSyk9LPUI8GR?=
 =?us-ascii?Q?46wT0j/f+JnKoP/D6/khz/OvUEGvEHpGTqGdiAIPjubQrho6x7tNi0BF8BcK?=
 =?us-ascii?Q?hvsdCWJsUaGRF++LVtG07lNT5cEt7pgmJPy8AAtbO3c108IbbqhdV+XSq3te?=
 =?us-ascii?Q?JwN414VzMAP8gZOAbi345ym/ma5JVP0NX8JQLc6Si1ohlJqCSliLmbIudRyQ?=
 =?us-ascii?Q?91P2X0DftpV55Q+4yvc4ACxejxJql2RU2D+I4PWamCWQCd/3FB8ze8uvyM7L?=
 =?us-ascii?Q?lhfK0babNzImXGC1ITbMa8uIGesqUuGRQ1ELlTiO8AkI665DnnVTU3cHbtw7?=
 =?us-ascii?Q?dc58r12jb1rxLvfMFbqi6QjejUuNDz7u3UYYRXlzxSU5wk5C8SeOj36T4wTs?=
 =?us-ascii?Q?C2B1UVJed3JhwznmWbIW1lmdgZUs61815lgE7CA8gVtUP5oIgVlTUIqG1HMb?=
 =?us-ascii?Q?xIDjd6N2HIqFW4di6NTdIYmUTcDz2Y+GLi/y5avd0+jmZx99MLPBdurKKYIi?=
 =?us-ascii?Q?+pRc+2cZEvox/UEvTslEx/RWaRoxGmhAR04IllrTrJcoyVRtSXGK6Gc4tcYz?=
 =?us-ascii?Q?xZVTes8wBKKDFt7fMu6h9uOS3ft7D94Pb8mkXiClMsTawqK9oHjDjn1DtAgG?=
 =?us-ascii?Q?Vr+lKIrvF3OO96LXSGac+NORGQSkAr4Z1y1zRePVdEzCvvVryHIjK2rjJktL?=
 =?us-ascii?Q?yRvxHdmD4L2W6E4KifcchDhUQt9bBq5IecT47qsRA3WXZqkjgam17cA39YBl?=
 =?us-ascii?Q?Gz4lYofWxAWfmI2m5WnMIAvsai2sIymA+n5UitMk5oLX1Q3gDYcAEPXP5QhY?=
 =?us-ascii?Q?vxA+c9z18THjGl5gAQHAvy9FcP/PFoVHK+3NqbGmetVSrYKvfNHH0UJHxr6/?=
 =?us-ascii?Q?XqCF1NIQvIEL/szVzh1dSMbRVGv01A1KaFnq0xyUT23EYNlB8yHPJ/jhGR/J?=
 =?us-ascii?Q?N87FZ2pwdQU+RaJbp9ehxlDz0ydt/BZaPdRcznTSryCaedtKvsKnf0xDqT6g?=
 =?us-ascii?Q?79DzcjD9FVubeT4cM9VftaKLljAo3f4NjG2MtE5DEpRkGBZ6Hr0Qt8618gi4?=
 =?us-ascii?Q?iTsQulMqP+FdB9U0VIL+WiJD7kRbgGC6pMVj8Y73g/Pcn0tnlVtxKJVCfBz7?=
 =?us-ascii?Q?oTBqTm48KAavCwqTJhU76EGEMfl7TtWoNN80meTJcRZBRAqYjF5uWb14Zcgk?=
 =?us-ascii?Q?cvBdx4ab0cWWLHuwWnDOoiyw0e5D476J1NMdDZTVWrw2uwZm+M4vu6yqMdLA?=
 =?us-ascii?Q?dt2zuMBF6QZjtQyRJvDwcN6c8V/1bNFxaTHOBlGxy02dvSiUpQKnXIWxgrnk?=
 =?us-ascii?Q?JtuTX/UpCQzk7LnKfqkY40YQraynDMjzYIHo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 08:05:28.1873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d832818d-dba1-44b5-908b-08dd80ab4769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337

Rename and use the existing amd_pstate_epp callbacks for amd_pstate driver
as well. Remove the debug print in online callback while at it.

These callbacks will be needed to support the "Requested CPU Min Frequency"
BIOS option.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c29840ba3b30..02de51001eba 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1568,19 +1568,17 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
+static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 {
-	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
-
 	return amd_pstate_cppc_enable(policy);
 }
 
-static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
+static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
 	return 0;
 }
 
-static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+static int amd_pstate_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
@@ -1618,6 +1616,9 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.online		= amd_pstate_cpu_online,
+	.offline	= amd_pstate_cpu_offline,
+	.suspend	= amd_pstate_suspend,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
@@ -1630,9 +1631,9 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.setpolicy	= amd_pstate_epp_set_policy,
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
-	.offline	= amd_pstate_epp_cpu_offline,
-	.online		= amd_pstate_epp_cpu_online,
-	.suspend	= amd_pstate_epp_suspend,
+	.offline	= amd_pstate_cpu_offline,
+	.online		= amd_pstate_cpu_online,
+	.suspend	= amd_pstate_suspend,
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
 	.set_boost	= amd_pstate_set_boost,
-- 
2.34.1



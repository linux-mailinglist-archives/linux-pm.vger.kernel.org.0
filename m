Return-Path: <linux-pm+bounces-15852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D349A1F7B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63951288CE9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85291DA624;
	Thu, 17 Oct 2024 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZnRC/Tv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEE79FD;
	Thu, 17 Oct 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159771; cv=fail; b=iWDM+1ujMuMm65hgyRKfFRTvL67hADWUbCemLw9PNb3wgevsEqolWNXsXiT8Q2jnNib6OnTKApAzT2Ok6M1iQVY0s3avMamLhrfZt+aKygE8H1CKgzXfY1rEXIZw6Om9Oe7uNeDTPw3khcaSxm6lT3W2rjldd5cFlE0B4mX4Axw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159771; c=relaxed/simple;
	bh=/nuaUoMskNbrRQLWZycWtEOezRWPa28W9kBl6b1PIsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvC3w9e+0PTRtpKmpvwyU1Z/eLIbc6D+EHRIM1E7GFbuegiLFozXoELs61qgVHh4xmnueAK/6YNt/HaFGI/iQ50teprhlmS/ElwD/zBKDaE2/d/fMQTAaIVCL/n+aCCf3bTX7KfEumWPhKN70j4RjqXDG0ghcYX1+1XflqTj+8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZnRC/Tv; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPUbzu/bWBU9DuO1GzsjQpn/lVgjiMJN/2m78qqd5+sqcJTgvXu1zQZuHFEeU6JrcVhAj6ljedmSRumb79EzWJWxftORxqt/CP2pDfZYzF2TKoGS4mKGIR8PZbYtowlyiPGtoQxm0Hbsr23b7sCVqWohHLO3Kigluw9uiyAjg4ielGx0AvV9havIau7AmBOGVpBtUKL9KNn3ghwCJysoBolQTm6bKRfkSAmtcb8SLfx/Fly0eDvQgucBIi3RYO65mOYVHD74VwYoDABA12uWk61U3Yj6ILuZkssQhIQog4nJnkV2nhdKblet78YQOfH+3nHwiqtvxnv0biDeH/IMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QduDCaOD2bqDylcRhEFSnNr/GBlo5ezbhSFw0ZCMZ6I=;
 b=gspEDYCabqGd38PSVVgpA0loEVDmbYqWGLJ4zUBcm8uOuO3Vp1fCOszC5766J1lzhOvRLsDuAPVv8LJvnRgmLZnIXz3jh/vrMjj+2OxG913TG0RfKHUzZklBa3j+dc8ujn25mzSHTSDOrMIEnqEp5EP3gQg19TQ5qXt6P9b3r5ijmYxPk02gEWFDD9iptKq5DkTJLazN/F8uWD/IgvqQcdkG35h6I09FhzY6mV7y3PIsLBNsYjkSTJSOWGJ6m3qrKMuQVLm0/9eTBo+EYZYvkpboNc9bRWCmZY2191JcM4xFCJVw3oiF9fUIktff2VUaznFTzFXjAJ5aolFAfPZ2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QduDCaOD2bqDylcRhEFSnNr/GBlo5ezbhSFw0ZCMZ6I=;
 b=0ZnRC/TvhPN+58+pf1w3pImsxnZxuDYf22IAzO8weCW+CvI5yoQu5gmRmwxDgq1PPVtEmuJp3hsHsjtxWol5vzEWvBDLaH8EYf/011EGJc4iYB6DLJAWUrg2er5l64p3OfH0AO0iVXwAHSIVYgLD0bu42NJFV+sSzKvihNsiBtg=
Received: from PH7P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::10)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 10:09:25 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::2e) by PH7P220CA0023.outlook.office365.com
 (2603:10b6:510:326::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 10:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 10:09:25 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 05:09:21 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 4/4] cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call
Date: Thu, 17 Oct 2024 10:05:33 +0000
Message-ID: <20241017100528.300143-5-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
References: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: c661a197-1843-429f-86c0-08dcee93c77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dDm7EPigEf7Sfc5fX6f6G76gvXOFELlXoEEIpnVQo7qS4EFSa9bGada+pPgQ?=
 =?us-ascii?Q?ijSgWmDwC2IwZFPU/luYyY6bhhvnKjZo8HZuDw4x+8ANFvwyfR+t+Y6zY9HI?=
 =?us-ascii?Q?jQEqDPAr9vL1Vz4JFJ3Fc6ZKWG0hLtLvHn3lIaBn4p0u0P/J9q8M2KJTAQ8y?=
 =?us-ascii?Q?ddXFnthN/CU0XbJ9DJabzjWNSFZJNao1qm6ozL8q6nEMrjwNAquUPXczPpb9?=
 =?us-ascii?Q?l9dTL58n0OuMuQ4lDfdc+a734Ix8YSQZQO9FgUE2PJYgbTLxwG7uZ5IxnlM/?=
 =?us-ascii?Q?bmsDsgRqHSK+dG1iTx/diwbRFahda/yNiqHDDfAm8dCTJTCNNlWdJIbi4I9c?=
 =?us-ascii?Q?OZebGDhyCEBUeJsqVIISvUWLqwDhrZ0dpu5u+5tPq+/NnnEUwELl+H4mHSZJ?=
 =?us-ascii?Q?ry4Gf/Vx02l9BN0oZ4BEPnb/8Ts+Jd7EbGloFuXraF7Y7imvg1PWx3RlFXEp?=
 =?us-ascii?Q?IUpRMJm23K5zj7CucdCsTd5uv2ucdFtnsXxuu8xlpqZDwQkTHLyFnDP60DUF?=
 =?us-ascii?Q?9lNMUt14Fh9sDM/Yes1sylxuisWZqIEph4sMgM04zmfLRpQTityV0e6HDjeZ?=
 =?us-ascii?Q?4MoUQz25nuByP7RA04Fghmi/029mr3eaXnSAA7ouSYOyS5R/hxj6lthEH2A0?=
 =?us-ascii?Q?9byBbMNqG86r+YF5Z58pGaTJxygr/eA2Fr6tnvIl6d7pJ38FklGYweUFxwDM?=
 =?us-ascii?Q?K2QLWuueBPWKYHGBcIDAdp+nvlj56LkLUdZ+PXgx3A/6LIRsj7q/aiEwVf9V?=
 =?us-ascii?Q?Mt/0IbJE3UQ9ELcswuAvqRME7cWC+qlXHptagYpFeI0kldzn7xcpIROmudnU?=
 =?us-ascii?Q?Elq1EWTkh8aIHaSo3RneTapVxVwtGNhOG1T3gyzdMsZHAR7Uxk0/Zc9wOiOU?=
 =?us-ascii?Q?fcmXZplMKeCjuC5zUkHl4NpMsk/BB7Kvt/tM85G4t1UZieklmohJHEQS5VF2?=
 =?us-ascii?Q?cB+pZ+OEpMtFnB4iP9mF/yF6VoNAEYdgeD9jMbTgHkFQUqTZQltB6GJTjKNi?=
 =?us-ascii?Q?FBbfl8n4+R6pLvOQi+kUGD/zSkI8toMjVFoR1KklRNagTMCFL6Uw0rFvkb3+?=
 =?us-ascii?Q?sWXShe58zZa4JrEwdJpc3OAHms6bvSPUUCO7PpaLS2xywsdbU2qLpCHsd7cs?=
 =?us-ascii?Q?iwtEXdrKIURNCcZ1ka+AZ6ImqA/lbyE4pRLeg9s7LzE2SI0Q9pCrzbYhJqRH?=
 =?us-ascii?Q?cAkCQx4S8btl16PLct7IGHxlDRSF+DNnZPMw409+DUP8Dnzje7jTs9qhQzo8?=
 =?us-ascii?Q?bYmrIQgGZkfEPf9zaV2WBcqOM0sGgBGPDVSlrnnzPUO3DIJ5nprKw9jZj+PA?=
 =?us-ascii?Q?JdGENt/fJkXAmBUgmu3YkksbS2kmZIan9yZCkQ+4nDPcO/UnJTPkAl7vOa1g?=
 =?us-ascii?Q?y2u4O9q5CY7zYWN6SqYPO+rPUZsy2AUAR2+fL0Ogpr/gnbe77w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:09:25.2388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c661a197-1843-429f-86c0-08dcee93c77d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

amd_pstate_set_driver() is called twice, once in amd_pstate_init() and once
as part of amd_pstate_register_driver(). Move around code and eliminate
the redundancy.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 13ee5cac901d..6f6d961879cc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1848,9 +1848,11 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
-	ret = amd_pstate_set_driver(cppc_state);
-	if (ret)
+	ret = amd_pstate_register_driver(cppc_state);
+	if (ret) {
+		pr_err("failed to register with return %d\n", ret);
 		return ret;
+	}
 
 	/* capability check */
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
@@ -1870,12 +1872,6 @@ static int __init amd_pstate_init(void)
 			return ret;
 	}
 
-	ret = amd_pstate_register_driver(cppc_state);
-	if (ret) {
-		pr_err("failed to register with return %d\n", ret);
-		return ret;
-	}
-
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
 		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
-- 
2.34.1



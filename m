Return-Path: <linux-pm+bounces-15850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339809A1F72
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55F2286262
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3051D9688;
	Thu, 17 Oct 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GmqPbfsm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF01D89F5;
	Thu, 17 Oct 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159686; cv=fail; b=GP+n2NrVM/GDhWNqM9nke4tOxm6iBJ26riC+B2PFtW1ez9w7mvM9m2y2jLe36+7B7XCcxq55DBHEGqT8Fvly5hSdMx7jdfDjoHzlGDYODN1+7HLY81TcT7GJtjG1iijlg9IgJjTsuCV/YgNuNmLSjJWILo6rzuswLj738vORooY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159686; c=relaxed/simple;
	bh=iMQ/RfFJAB6/ZPUDgvWylY6gaKv8e9GOj7JMBTpHv3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S92Nax61G6k2CtXhMJROozuD4lgcXXoBEQHHNdAnVUogWWSms6M9cVw8pKCY1wt4cJXs04UtzokCM7IJsQ8MguQ/se9H40fHkWD2waiDM2h26hRNtAZSi08aHwcLU8wXARhYSEvjQxpVMMy6lPzr5mn1gQwU30vACoK0P4ddFDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GmqPbfsm; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soGfFW3Tj8eUQFG6n4ZOcNYHQ1wdKuU81UQ84LWhKrc3HIIeHWySh66/lpC6V06gOR1u2E/ZfW//rRBAlMYGmTbnCAWgBwaoXzuRDEuw2NV+0PEZhDHPWm+FV7FYWQqjz+9bfGZn2HCF3WyKgsMmL0394lPL51BlTEkUmC/G78cG1ABzVlXgf+d/ptk9DJNUVL0e6r36G2OrdQvw44EnUUnSVDAcowAe12xGG/ud4u9JshJGyOMNMKlVfx4XzMo1k11EBMlZAjMGnQU8/DFqKVdZXqpGOznxhJDEbz+oitH92TIxeM5ZK08s62+NnAPBQ5eGtrdSzMX9cKXW815c1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MsnO0bZqP1Ofc/njtqojvZvmOXvF3Iew9Atks0Wljc=;
 b=I6myHGkUOdJq5JF/ZvAVzEZGW4s279nhFfo6sVnARb3CV15/sSO3nwUugi91S4HNuiLrPlBOtr0eHo+/Xs9sTAiWBWml6iO+NcfbBflzo3Wx5RX2XH9ccRpNoqvzqh2HsrKYccBTHUFPLjpdDlUpnrlPdy8k4GJy4lyVdmr4D+t16BHhMf1U4FdlQCOzgvwT4NpntHKz+Q0lTDuWK6L0oeI1+zEawwWgtmxuy/djyGB1XzxlEilHHvCms5LemcS292VvQ4j7l3Q+CAJZN2GElOTZNFrxTG/m0H/IsOCYDnBZhml14ZVDTQy2jrq/M4sWPMxE+Byc4V8lg6MwoVfehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MsnO0bZqP1Ofc/njtqojvZvmOXvF3Iew9Atks0Wljc=;
 b=GmqPbfsmLYKo/G+/mF0Vgzzc0UKh214SsRt2J+NvIWH1fcOnmwA+ye3DBMLALDyIGtPCkvR8CHZ66eh/L+tTeW4FdWUpkObftUML2LUj/jf9BUrFJeFPtQlySAmIDbLKwWbV7gbmaDWSa3iAL0kOXIPK2SFqgA9Qy9IolXMR2pA=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 10:07:57 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::58) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Thu, 17 Oct 2024 10:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 10:07:56 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 05:07:52 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 2/4] cpufreq/amd-pstate: Call amd_pstate_set_driver() in amd_pstate_register_driver()
Date: Thu, 17 Oct 2024 10:05:29 +0000
Message-ID: <20241017100528.300143-3-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4b163e-0c58-4fa6-299c-08dcee9392e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VKH/wY61W7+2vj66xsabQLXOAdE94ohOmv1ZtI+JGaGUe5haUr/W43SEsCdK?=
 =?us-ascii?Q?32NsyFcrbGDBYHyl3z5+8JvkraeQ0GpaxCeBtqD3pdBFwyGtvicnTz/iugbh?=
 =?us-ascii?Q?9xRj25bgnHS376Hpp0tB5v+YW13ANuZW2uqk+sNGCoF1qmuRb4N5/t/S3FSj?=
 =?us-ascii?Q?VPGoWzgaiZre0yGVvHQH1qOthVPUc1a5Pj6ZpiagUSR3uIo08l+nZ9ky1RaM?=
 =?us-ascii?Q?o2SyjwYm1Ms3HuSOtAQlmrHEN28TUZHW4UugIXV2szsaXH1u/XukiDTFla84?=
 =?us-ascii?Q?S+jXO2qqkClTks49XywTciroBg6j/UOm6n5nwTlLOKrq2m7az9qNONM87FR8?=
 =?us-ascii?Q?66/dX+1FJrd8Sum+dzF/IF8LiVT/UjDtrn9yj/bjy2GTVzf365ZjKBvFZj9g?=
 =?us-ascii?Q?pVuSbZ6tIZDxkbd7jIEWjdcBueOezvP1TZ0SekpaiwjKb/iU0oSydeBsA/YW?=
 =?us-ascii?Q?TA4cHUmHf3a153Nnkx2N0wD+x1bG8zrpDG5aG5sRv4Zfnd1cu/ohsnpGIyTA?=
 =?us-ascii?Q?oxF2SlnFwK9FqP1sEnZEUEFyPeDZ9OKyaEcGeZghGtIFoTuNSlQtn/HvSmfq?=
 =?us-ascii?Q?28VetKacsJXDvP3ffpwDRMXtKNPcKvnSPiCC+rP9f3UTmbnCyhOM91vf42go?=
 =?us-ascii?Q?wIV5uBw5WC4ZNgJAaw4lu2CKKEMIwR2KktQxeBJw4Kw+dPytErcRMaaoPp4c?=
 =?us-ascii?Q?ZGXkHM3Pp+1pPs5xOxdSWarbQVcLlXkmJeb8BaRtyJyNZh8SMM8KrTErR86D?=
 =?us-ascii?Q?idpERa/PXMehrCg0fLyVVF06feumDtpWndC81VH0DP2O1ilrFqpvs754CkWr?=
 =?us-ascii?Q?HXqriLWxN9wUXYPzuN9XN96JQmzLcLCU2Vh5TeszCURoaWKxBfe3AvBWHVFr?=
 =?us-ascii?Q?AewdJFRDH32mXIBDVrp2a6fr4+d7MCgmleJdtNrWtar338NYtMJOZcnzPVfZ?=
 =?us-ascii?Q?gjqc4jXXVs1g2l3+lz05tKvUfZOEuZBDl4ddC1Sygic6vOocIUIWLJM4OQy3?=
 =?us-ascii?Q?BSm6DdD6KNTTyb3gHpOaoZulPeeDAsdQw11KIeiJZUpkjLy3e+ALHJXelL92?=
 =?us-ascii?Q?ZGUtMHCucP37KyVO2dURPQKI7V0yzT0gJnC8Es73EIBdtYPfhXI/25QZMmrL?=
 =?us-ascii?Q?BRwti81jJZQ1FMOVsHpWN9msWlmPp0BFgZuRQeafS/96Gsroa1N45iWT7bF5?=
 =?us-ascii?Q?YGAsMKy8OIrvd+l7o6h4/Vplf9+LIvLWSsy53B7sW2QqlQC1y3Qt4abeeU5y?=
 =?us-ascii?Q?NC8fxgbJNMm3K6ISRT9EHdMY/qVuZc/gEIwbKTtx5o4TlnEgNPQ+nIG8sL6a?=
 =?us-ascii?Q?Ism7aySRh/aNtd8RYUpU3OjnxdSZ/qe9Vo5csPT+/wNRNCBVfP1v2RgZTWhi?=
 =?us-ascii?Q?yYTDlDNUX6b0WRSub6rzHOppR0i3Oxs7npP6RwpPDmXG+wwagA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:07:56.9856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4b163e-0c58-4fa6-299c-08dcee9392e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

Replace a similar chunk of code in amd_pstate_register_driver() with
amd_pstate_set_driver() call.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 47 +++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 856f0d11983e..5155fc0019df 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1191,16 +1191,32 @@ static void amd_pstate_driver_cleanup(void)
 	current_pstate_driver = NULL;
 }
 
+static int amd_pstate_set_driver(int mode_idx)
+{
+	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
+		cppc_state = mode_idx;
+		if (cppc_state == AMD_PSTATE_DISABLE)
+			pr_info("driver is explicitly disabled\n");
+
+		if (cppc_state == AMD_PSTATE_ACTIVE)
+			current_pstate_driver = &amd_pstate_epp_driver;
+
+		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
+			current_pstate_driver = &amd_pstate_driver;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int amd_pstate_register_driver(int mode)
 {
 	int ret;
 
-	if (mode == AMD_PSTATE_PASSIVE || mode == AMD_PSTATE_GUIDED)
-		current_pstate_driver = &amd_pstate_driver;
-	else if (mode == AMD_PSTATE_ACTIVE)
-		current_pstate_driver = &amd_pstate_epp_driver;
-	else
-		return -EINVAL;
+	ret = amd_pstate_set_driver(mode);
+	if (ret)
+		return ret;
 
 	cppc_state = mode;
 
@@ -1726,25 +1742,6 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.attr		= amd_pstate_epp_attr,
 };
 
-static int __init amd_pstate_set_driver(int mode_idx)
-{
-	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
-		cppc_state = mode_idx;
-		if (cppc_state == AMD_PSTATE_DISABLE)
-			pr_info("driver is explicitly disabled\n");
-
-		if (cppc_state == AMD_PSTATE_ACTIVE)
-			current_pstate_driver = &amd_pstate_epp_driver;
-
-		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
-			current_pstate_driver = &amd_pstate_driver;
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 /*
  * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
  * show the debug message that helps to check if the CPU has CPPC support for loading issue.
-- 
2.34.1



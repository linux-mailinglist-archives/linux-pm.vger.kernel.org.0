Return-Path: <linux-pm+bounces-15851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BE19A1F74
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 12:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EE1F28BBE
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CE21D9694;
	Thu, 17 Oct 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tLAFmmhw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B01CCB44;
	Thu, 17 Oct 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159724; cv=fail; b=sg0p3XEe6N4341srTUF/kadH2fTmWQjHjndmISUdXaKIC2qvz/Er4xqlc152e/b7TH96C/fKVCB84aNDNfBsakl+gu6eEkKGpev/I616wwYEUZiKggoND586WDBhQA9cSV3ERBulwYLntuiNI0h6i2RwLFSL4WDvkVTh2UXXSsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159724; c=relaxed/simple;
	bh=3111Xd2FxX110br+W5Ji3fc3QlF4itA0K+MiSgaB+OE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiFd4G9VnGWwV6q3LirTmlhl7bff3TWfai6XRx7l7CgY/xUufIZu44mqcY+EtBmBwKVnrHzPqZ7Sn+sJZPRbtISRjnQ/82AGHSEx3bJdASSGDGW2LzUfA3JCEOKsGtVk/99LN+gW3OMqArYJQy1E1O6Za8J8+OhZQ9HYfSxBtjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tLAFmmhw; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7UytCfeoIwaMKY4YU1YhT99w7Z/zlEh8MNHvESpCqtWCjHAoMQSQfaC1KOCUd25IXozS1HkSAUzMUhA2ZUn+gjNJrKfbb8+Fea9oLupZ2bvNVGLfky/Ad0/6HSo2A4tUAvAumsqCDLeOB1ZcwYYcVjqwZGIP5pv3mXZ3VeVtGqU3wBlpUroTeozIJL+KcJkVquU/pNLpqitL8UcbS7/kDqZ5Fvqq5jKvwVgMbGqpXC7c+hfcB82j52OVs4l+bFxFPg7A4VRyndw6d6IqPzPQM4QOVUy4vH/oX0fmjpipMQSocM5j4HVjDpNz9TQBLG0zkp4EfrK4TTOJLBBVUuUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX/6asCDmmCQmGx13KVZqjiUpUKq6gVhy6QbbEbRJxw=;
 b=jTnOpvB5P1SOOXofLh1wvJw6h2bhsFaXDi/9m8PTh/TpMokZheaO9UANikkplq5TAj1Vj4V7jM/BEWEzGsZkKh7C7nDulqQTtbWUY3MvGxRBLjPI7wdHAZF4LiwooLvHD+dPv1ChOGeBHDGHhR/1Sx89Vl+Vn7BEoRfaHUKA/+cSe0HIe/LXuHUxh9y6t7DELsX4OuWPBn1Oj6tkKrc0MzwpL7OUVifLHLcDaqNMRWPPyTH6TuaIGoBRKgAgkdYnOngQdPBUFQ0EJZB4J4r5XWvXbRICFDdOZzB+2YDqOiZ77a+XYpcKf33RRl8x3z1oRng80jAa0eD0PRrAxB38Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX/6asCDmmCQmGx13KVZqjiUpUKq6gVhy6QbbEbRJxw=;
 b=tLAFmmhwqsC326AoxJX45wlO3Cfbq4PTH5kLahGKVUBLTjL4pHDahqHgHEaDPOuJOGU2s9NGCWNS5DcgP4qVK34Fo7MnqnTvcCdJghJAuY5x1PLAq+WfzG9cIuFm2J2aQhBKozQ2Xp8OGBUKr6GNunr1Zcse74zE5tuXezDRTis=
Received: from CY5P221CA0066.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::43) by
 DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 10:08:35 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::6) by CY5P221CA0066.outlook.office365.com
 (2603:10b6:930:4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 10:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 10:08:34 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 05:08:31 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 3/4] cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
Date: Thu, 17 Oct 2024 10:05:31 +0000
Message-ID: <20241017100528.300143-4-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d33908-30a8-4a34-f8fc-08dcee93a958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXrjIfv8s3Llmk2zx4bCD6ztFvUg72pIIUjeE1fsUe4ndziIbjy7SQp/rwWz?=
 =?us-ascii?Q?wOj3Wtr4fXUkN3inB6UsMxVFippwG9C7KWUsjNfKYKlg+X8/YJtWa7+9OkQD?=
 =?us-ascii?Q?1OOdBjXL/QMGZH+igtLSzrp/+pXhfkc0o4QigrJyYvLeRiLf3Aa79dbuAoah?=
 =?us-ascii?Q?BMbT+JHPT7QoCBGAs0516hwHFWuW4MwymVKZMvWfsyz0q6+SvuHMt3xNS0nP?=
 =?us-ascii?Q?lCb09i5cwIRBLvOi5YCmsFDp17Uj2UXOmZVijYjw0iPKltw3Jc2VFFdChwS1?=
 =?us-ascii?Q?C8h5dIGkSY/S+rx5Ac87Fvq1PtjQBXiF0mel/ExpPaCQV5icPKMfnZBVA+Ci?=
 =?us-ascii?Q?Ho6MM7FxVEam/qhR48hZtzZkWLZa09NrIw9fPPwbOgF2g0oeCqxJp6sXx5Jr?=
 =?us-ascii?Q?2l55ZxHoSF2JQf3lzfmVZltgBCctpLuVT72Fb2xKmPWVGika8fbc0oMd6B/U?=
 =?us-ascii?Q?9r48P6a8X4yLdx54RcazW5xSmiH3be0lq7Fg1NkBPm2zGF5jrhWY3Sep0VfM?=
 =?us-ascii?Q?ZxfiXrpsuvLwdvTm1U6By74Sh4PNCTqqDnQwomXhk1z95m8Gcuk2eSyEKvTV?=
 =?us-ascii?Q?c5cPOY030c5gX6TDxHVzjXBwKs+NZvTZvYu8jTPWGqADaOTKiUjbUxaqu0RJ?=
 =?us-ascii?Q?Md+UO7fATiL8shpReC9U6LqqZFoYRIqiQfh12lcHMpir6LIrrDGlEPRhh57E?=
 =?us-ascii?Q?sEZazYfcKli5NJJVt4Abh6gTVxibN8whc+VFf2zcttKUo+HEW9wXGk3nqvtJ?=
 =?us-ascii?Q?hx4j6i6vWWr8D5TlWqFaZT7weWcOw0167fWlASal2ffFqye0frTRmF/cokQS?=
 =?us-ascii?Q?0QWLnX90b0JJAmeRKlVCQvkCvMQAu+zIOSTLgRQ6yDk4gtN5FnKlbNuTPFQT?=
 =?us-ascii?Q?uB8AS32eiJxM2KnT+KAH4TWcBdlF9fnkxoTaaotVoeSvgBJr/bRins7d34K6?=
 =?us-ascii?Q?d6iDRQZsMrpuSVxhwVME7dspJuDL8MLbSA9RRCJ2Nb+N0Xb5E+sqUxHnGZ/h?=
 =?us-ascii?Q?CB6H4Cr/pTo+N8UeTS4ahIl5EstyqrKYW84Yri87aZ9UIX8wvp20Supe5QIi?=
 =?us-ascii?Q?LGNxjHFjVorYINrIVU5jZMpksLt+wYgf9HjvtG2Y9V9oJu3pV2HNAbpRCLcD?=
 =?us-ascii?Q?tG/Nud3vM8fKou5a3fArX9IKnvpknaW4LDkB/PKPTPP0CBu8Qn5Z1/gC+BSK?=
 =?us-ascii?Q?dQHYjEMISzsaEtVXRmEYQxHKCajg4ijJHieCehdJsmF/EVHR4ToJsFLbGzBA?=
 =?us-ascii?Q?BThIR3AEJZGl1IckxCDIR8cgTU5nnCCJQlzRsdD1R4u5B4TIp/IDQyAd7QEV?=
 =?us-ascii?Q?D5FKda9FfWy44/G5IKwBKjSMclOkPGZiU0X8avrkUV60n3LYSaH7OZ4bqkev?=
 =?us-ascii?Q?+1vLLh5/nKa3E2PNHw4xn16QMEKx6TOw1UCLnpamtS5pajEXlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:08:34.6988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d33908-30a8-4a34-f8fc-08dcee93a958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349

Replace the switch case with a more readable if condition.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5155fc0019df..13ee5cac901d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1843,21 +1843,15 @@ static int __init amd_pstate_init(void)
 		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
 	}
 
-	switch (cppc_state) {
-	case AMD_PSTATE_DISABLE:
+	if (cppc_state == AMD_PSTATE_DISABLE) {
 		pr_info("driver load is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
-	case AMD_PSTATE_PASSIVE:
-	case AMD_PSTATE_ACTIVE:
-	case AMD_PSTATE_GUIDED:
-		ret = amd_pstate_set_driver(cppc_state);
-		if (ret)
-			return ret;
-		break;
-	default:
-		return -EINVAL;
 	}
 
+	ret = amd_pstate_set_driver(cppc_state);
+	if (ret)
+		return ret;
+
 	/* capability check */
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-- 
2.34.1



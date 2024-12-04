Return-Path: <linux-pm+bounces-18552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A159E3D42
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04C3283B7E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1520B21A;
	Wed,  4 Dec 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nCMDLnWd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9A20ADF2;
	Wed,  4 Dec 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323836; cv=fail; b=hBiwKF4HFCirI60f2xQ7aFK5Ps+Cr1SkGG0ncHJVR4FLUMzRXKutfIuoGFIaLDW/DEGuMk8TaElItqj9In3RweWasU2AXgQGcSGfNkyyMYyR6+ZRYYkXio1tITIk7jriFSABN8fP9pGYdm/LVLwJgEIS/P2KF+p6dQoU4jR+q7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323836; c=relaxed/simple;
	bh=gqLKkOHcLQ8UxbAW2Pqsjdsm6AfLIG89krD5xF36xEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiJTRqe8Io/zj8Xx8nB304S4IFEHcSpc6roI7iJpWNm43lNAv8jMLcZXVe/bQwDj3Z2r015cShIhFsrtF4a6dUDbdZofKviAS93Rj0rbNoOaaCLLXf8twpXMsa4zWIam7d/RFNXTaYQE6ELC7MysVg5PowDYdydK6Rq8r346i5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nCMDLnWd; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrGWxWDcvziwxGNKDFIqF21ToUqkNcHj62/XyUuZK5UEnF7AsIHadehnTNimtLG7IiCTPb+9cBHggqgeeWglZooEpzBfnCJBMLe4C3vku9ThUNJI0fB9ZDisLGzvBm3o6zorw36HlDdH1Ve7AQSnj2wV7JgZRCd9gQKnRy+qcA8pJ4cHBoZubXOLEcCbDGdvz+rjO0U383hj/g/hI0wdGvPIyOKXCehzZWS3uoqasaeflZI91RcpqAfl6J5tJPHMweA8GXMNvlNin+3vMdp/y+yVCkEkQ3ENJrZrbr6JMDo1tLNbJehxm5QteBLrTSEt8MMds8fPZjI2gdshhWgeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9E+IPuG72e8SC/XTBZkRSoTBQRWf9sqlCFIJVsaplk=;
 b=QaWtZQRHv4+/9nyNs6qNcwQiUhvk+FR/pI8kGU5e+6iQhjQ+Em8q4sapWwuqNP8GJWNULnVKhVEyhIDrRkTIKlQzCdyh144ovDxrS978PN2yNlRle3PlDEAB4c8Uq7/NSUXbrYJtwlpk174CJAaol1lFPRfTT9dZAj10LVubNnu94+9yHoCOQu7Cds+RCRbyYy3EBAZk8iIo7QEFs2c7fWDwlcq/TB3UfAtZdAe8j89cibkxZhsTfIzfaLWoTndV48BBMpCL3ej9shBx591rsx0u/nTwan7lJMoEoxVYrKn2Dhqqz4MQSP87FEWqb06FDA/KTYsFbaRG7jFbHLUB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9E+IPuG72e8SC/XTBZkRSoTBQRWf9sqlCFIJVsaplk=;
 b=nCMDLnWdMH5GW8nxu8jh4/SZIKPO/hOYpsW4Hiryj53n5LyBYt3Kd1ZqwSi/f672OADHQ+Aoe19qirotf/Az7xrVifAQRKMlgdLxwxmEFzlYO9oh6uL4JTxxq5l+eCXLVWHc6Fh0ZSxwzqQVjPa32RSi2Qy6iT+BP/QoPy5O124=
Received: from PH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::13)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 14:50:28 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::5) by PH0P220CA0009.outlook.office365.com
 (2603:10b6:510:d3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 14:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 14:50:27 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 08:50:24 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 4/5] cpufreq/amd-pstate: Remove the cppc_state check in offline/online functions
Date: Wed, 4 Dec 2024 14:48:41 +0000
Message-ID: <20241204144842.164178-5-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: f117871c-0c27-46a0-0b07-08dd1472fe1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9N2Yfe63KY2jMHDLbl0w6sOGumCIOOBXbeSZCd5gbUi2V/qF1i4OBEt8K6JH?=
 =?us-ascii?Q?yj6hnQTLZxLG3a3Fb4Vnrz5lAOMZQ2eKU4GuYK8Y9QTVGfSWwT8n7Y5TK1oF?=
 =?us-ascii?Q?i9mzTZj/PZSzm0fLC5sI8cTqMz2XJPcr7r+Hqn1va2HtG1K5DHHsxBfbvCPi?=
 =?us-ascii?Q?c/CTe5o9zX0eQ/1Wrbolk8w/LtFEP9Cuwt/WBSnXLnQzIQkkTcattVyIChK3?=
 =?us-ascii?Q?95XwxZaXeP1xmr8qRAKqaWeYgt/v1OZ+dCe43zaK9r4zDnwd9uxkBxZfoYxc?=
 =?us-ascii?Q?Ou46F+xUcYDhy+6hZhr5Zr1TL3V3UD2TNjvBv61l0Aod+GqiagzkPDLfRfP7?=
 =?us-ascii?Q?Sl5lHCnw/L0MnOnWpcho+PqcGpJYllqHZGzd91J+zwNrZf9M3bk3EIKtguyD?=
 =?us-ascii?Q?wa6vs6Y4PHG5FvtKNSnGCLQK1NstW9IJobs0JoMLfG4nGRKd6Ty4xNcRAHf1?=
 =?us-ascii?Q?6/A+qimJ8sjeEP/i4JjeQZOhY/UxOshJPfjfgPgfoENJ4UU12SKHNLb0eRc0?=
 =?us-ascii?Q?FNHFYl+bqv2B9GMVz8etM4DAdlpS9x20p6/WCYAwxbXFWkdlGNCQX7vOJ7H3?=
 =?us-ascii?Q?QH8A1wvNXKPk8QxF+ouSQuHJBvh3CMN7KB37FkUVNr/G2wdMA+7i/RvYra4R?=
 =?us-ascii?Q?zBSSQ9jPrIOfTj3euvpOvaFf4wZcrlj2nTa/d+Sb5mou8/BtK9jKeoQFankt?=
 =?us-ascii?Q?vQxCoy+3i7yvhV6iY14Ppb7SkAbIGLqv98H8qcMSE7JFiz6YDJOqfekipjTe?=
 =?us-ascii?Q?aeReUd7K46vjn+irPaqsqXTUnViv4lPbBy7YmuQE+mFXtGVlAsy+j/C9hyJ3?=
 =?us-ascii?Q?rY7fzeD0VRAWtgk/Tc+qdXu7RuNboZuVJrbebWac3rOGf3amfRq8ye6GUxL+?=
 =?us-ascii?Q?gcMLyt3MBkj+aGEayTfJuH2s82zaQKX76eCUdpMgMPX/EgiJ4+IreeKAyMxp?=
 =?us-ascii?Q?oosF1w1daL6ezgpLkWYjhW/TZBOLyPpzhs+IRhevyvbnmahXXQim1EgTqQ7n?=
 =?us-ascii?Q?DZunM42BhrLUoRP5D5rt6m6sQsCcZis109XjWwVtZgR+Byp2ZhUYWRXYN6RM?=
 =?us-ascii?Q?JZopyUJ39TgpKPzrzHQiz8V6On4INRWMfeiJsPQHit1F9T51nEgNor0PEP7A?=
 =?us-ascii?Q?XBvPP6nXeBMBHGAkY1H3PfQ6bN9XMUHm24d/PsQ6bcRE2PVPnq9u/K2YV1eX?=
 =?us-ascii?Q?ai5pttybmiFingXcCNpBFlNLgUrHlpPBnxlBK8yZBakx4XK/HuczAzuoeRnT?=
 =?us-ascii?Q?ETu0xlUjnoO+7rLCCNOcoThYanHOPpZbdjfTWStwgWcE8Nhnmyd8UXTO2F5z?=
 =?us-ascii?Q?SRA/ZtJ1FcPpO3uCa2sV498hwL7nsbGVIhzw4zr7P0bKpksdpKIAZbCkbBMH?=
 =?us-ascii?Q?AuJdFLs2deW3yjYyv0t2wCgHtPJzde1OrRtvwud8T1R19qk3IoUfS3VwDWWw?=
 =?us-ascii?Q?WTyVhPOV8aFkFLS0hLZ8bFFOx6TiQTxu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:50:27.7971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f117871c-0c27-46a0-0b07-08dd1472fe1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282

Only amd_pstate_epp driver (i.e. cppc_state = ACTIVE) enters the
amd_pstate_epp_offline() and amd_pstate_epp_cpu_online() functions,
so remove the unnecessary if condition checking if cppc_state is
equal to AMD_PSTATE_ACTIVE.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a38be7727c9d..08a10ef7aa5b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1649,10 +1649,8 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-	if (cppc_state == AMD_PSTATE_ACTIVE) {
-		amd_pstate_epp_reenable(cpudata);
-		cpudata->suspended = false;
-	}
+	amd_pstate_epp_reenable(cpudata);
+	cpudata->suspended = false;
 
 	return 0;
 }
@@ -1683,8 +1681,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	if (cpudata->suspended)
 		return 0;
 
-	if (cppc_state == AMD_PSTATE_ACTIVE)
-		amd_pstate_epp_offline(policy);
+	amd_pstate_epp_offline(policy);
 
 	return 0;
 }
-- 
2.34.1



Return-Path: <linux-pm+bounces-18553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B459E3D4C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6214E28104E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BF720C017;
	Wed,  4 Dec 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ca0Cy6xe"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA820ADE8;
	Wed,  4 Dec 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323852; cv=fail; b=jMM//FH9bfTFY4UBqhlTr+9o988u6GgvUVVH9m/gQ+41NVqT0lxfjgL9UoT9tTRC2fXmAkFR6B4zL+3lrhc4jIO5d8q0ErnozO9kfwWXDJTOlcB/KfkocY2jf0ySeC84opg+n4KmjOLqEZIZ2KLcj0SJU21MXY6mwTMESO3Mvfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323852; c=relaxed/simple;
	bh=lM8g9IonuBVsR3yiRFWJFDhtKkqh53YREPOzPgTKlj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U52pTGd9UbHKh0q9UpeCgcdnq0lssCRN2Mr4MFPHZUcI/7VsPCGSAUb0ljnc1ExruKzwn69oxAEtd7+H6vIeIrs/JXDTAlSDv7WhyxeWjCCzQ06aRZv+LBr+d0Mu8Q7+DFyaFxzxfNzb+v3k/bFJJtflExklL4ogxD3sHacTD9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ca0Cy6xe; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNwGtuo+1MzUowcchsbyAzSrH/qLzPS1BAIw2NYfZS4c5s4mdM9YRRRRqE/aDjn+ENh0AdCHciQnhP+y5jivifdczs5YgKrTriXBCZUIXklF67YaDdPAhGuCdEPksj2RIq11Osd8adxmo74zzEJDXs4KCuZ/hvOyubWINUMuPf3QRs6y14cEYPDTmVFRiwas+l/gTfAt2k40K5FEAS6aLk4qnS3GykmwpIZTeWqCXlBThtw+847hpKp6XvDIBeP3gg6xGFYDzKQ8WAm2nQF1NkIEUqTsAOeAnX3VubSlJDJEgABYm6caDFF1yJy5x6XhsjKdtDb+ZKBtq+PUGkIAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg8wdDAQS4KVcKon6AeajUBsitYeJKKNANIlCeGVL/Y=;
 b=UjhrG6+MqmJGW4uNgvS6Gsh852LPUbFO4WD35d14r45vNbeNk393S7H+e1aFaW/VE2diUL1mLeKZMOW7p8TVWwnIzwLxhs1v2NhxaRJoOxn199k8i2Hsnhcr85B0d3YywOg4zigJ2lH3nYwKyTiS58rTIGOZQ3G88jtFNRBSBs2FT4o73AEva32nSwipC4gVBeBkoAd+hGFinVD0tGqbDObIQfyNejQfhN6DdVeo1Ma0nEEhIykLPt2voVLb2OD2oGmueIztLSdIZlbyXNUO1mj4itmLpujMTxVRRfuCzLDYP3Ri+BvbOeQoTuz3mW9wOQBOwuesqzR6CHX9MwhrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg8wdDAQS4KVcKon6AeajUBsitYeJKKNANIlCeGVL/Y=;
 b=ca0Cy6xe3Cyp5IMlAyokIY+L7mdOx4ADkCfQAwBeSjqCZHhQUypnLKPrPX/JquiPiS9ayJBnjAcbOZoyRrMqKhBJTqQX827Fvpb79F5LC4hpRjE6mshsjkSDeSFpk02gKH+GNip40ojliE3oOGwOhH1QqMi5LWMsKWmrVEf7NPs=
Received: from SA1P222CA0153.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::17)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 14:50:43 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::7b) by SA1P222CA0153.outlook.office365.com
 (2603:10b6:806:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 14:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 14:50:43 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 08:50:40 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 5/5] cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and amd_pstate_epp_offline()
Date: Wed, 4 Dec 2024 14:48:42 +0000
Message-ID: <20241204144842.164178-6-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: f423e94a-0399-41fa-d6d4-08dd14730790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rmsyy1ZSTbi4uy3t4Ir7DKdjT4UuXgePPsmACrtjAyS5HLltooZiyvLNRPJs?=
 =?us-ascii?Q?UzV77kvjpEDbahn2nUbcNw5M4VuCnQ2pmM5yZjlWLy6z5JxEiUtbxFUEkpgN?=
 =?us-ascii?Q?BLNSgkNqySbs/axE7cDR0GpOLXUc5zlP9UoQRj1D9aMl7z2ld9GntUbvr7+v?=
 =?us-ascii?Q?D7IJosRHAwiCy/N7Sn6csYm7ZQvhEd1SoY7dwQZG8BF/eamovSlqOeH8X+Nj?=
 =?us-ascii?Q?zFtaEC3f3y8Uljh28zmmyc+uQwU+sZAgV8xqljkzi2G2uTTV3LTCGYqhKtbq?=
 =?us-ascii?Q?W3yzB1iolyYekp4n3rmKLeCPWMggWJhGKE6yd1IG0chiDrc4yzuy6kSH6WRM?=
 =?us-ascii?Q?UeOkzBfzZ+YUz/trQsxKwLXEuEY1I3uaA13nYMYSQpwf97F9teoKzZV8Up7k?=
 =?us-ascii?Q?LM55ESkFrVAWJujAbaNC06xlQ2y7mtsAedXucAAl++TSue7R/W2FvGVP0Xx6?=
 =?us-ascii?Q?GlefVO1AHMptssN4woAeuw71MXZFboRfj9AZkyBEcjlPo7R5QJzSVLwFGlwp?=
 =?us-ascii?Q?9cEiXnD9+h8II6v47PYAbjmpGhrj/QhHbbuKmrum6qz6XaKqa/vhba+oBM0v?=
 =?us-ascii?Q?nRv2hQGHOLLMqFULFeAC/4/8Mm0rQ6uxNMYNcCHJ7bCed+I79k8Cuwp847O1?=
 =?us-ascii?Q?TW7a18lY95JDmp3eTBVIEfUQI3AmMwe+fz8yCmZej63aEGUchYsc1xe20URW?=
 =?us-ascii?Q?sa/+OW4lAMBIZNI6US+5g2w/3eHeRuYBnsWocmJrY+WbiqSy1/jowQm8Pat7?=
 =?us-ascii?Q?f0t0ayF0nDUujxV0t6i74paMOfFmGo9CGz4RsnEE6s7xPeO6rtmctjETY+L9?=
 =?us-ascii?Q?HV4R6WBo5hgUNO1SSn910VAUfNGRAlwGS7dGvdwf21FoAgMe1uLf4PC6uCfB?=
 =?us-ascii?Q?7WZBbBVfooitExdQz3zcCex8JBYWWV5UE431mYpY9/Sn3XngZrHmyn8AqXo3?=
 =?us-ascii?Q?FSHELFROdTgB9J4LivEEvnbVhJY1L7i2zFVW5Uas6BL8v8GA9cIXiJ0JvUQa?=
 =?us-ascii?Q?RWLBUogxTdDBzFxz1RJR8jeYD8SP0AQrrh6FWZi92yniyy2IazrFO80HMoJq?=
 =?us-ascii?Q?CtxuuNLyHW7207jt1xGGons4Qnw1wB6afU4MefsP3oDfKhgIyKzhk6E0M4hR?=
 =?us-ascii?Q?F54o6Xqvk6sdc16kEzKFg2xMn/NoGv23yZftoGzCe/qunMHyw9i/Z7Z/mnHG?=
 =?us-ascii?Q?8muzC83DM5NHFo7CGtAbr/4Z1uJFmAK4pMdk36mglg5IpIAMigr6r8VksXz3?=
 =?us-ascii?Q?38GcEg5RGkM3glgP6IIN9olIXaL8fk2cqehSZnpdegqFZPHRGunHFrVUFFuM?=
 =?us-ascii?Q?fYwycx+nwF92X3YTT/ZpE0KlyyIqlY+SzNh4uJ02ubTwQ2sjwlY8Ts4zQy5L?=
 =?us-ascii?Q?zXpwR6JFMBS7ZG+BY1MUJozlkNJBONCcX4334wiXj9aEZrvXaI+XT4NS1TxQ?=
 =?us-ascii?Q?4TuyK4oKx6kVD+jxsOqiOg9QpR8tF8po?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:50:43.6424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f423e94a-0399-41fa-d6d4-08dd14730790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

amd_pstate_epp_offline() is only called from within
amd_pstate_epp_cpu_offline() and doesn't make much sense to have it at all.
Hence, remove it.

Also remove the unncessary debug print in the offline path while at it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08a10ef7aa5b..298065912976 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1655,12 +1655,15 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
+static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	int min_perf;
 	u64 value;
 
+	if (cpudata->suspended)
+		return 0;
+
 	min_perf = READ_ONCE(cpudata->lowest_perf);
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
@@ -1670,18 +1673,6 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
 
 	mutex_unlock(&amd_pstate_limits_lock);
-}
-
-static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
-{
-	struct amd_cpudata *cpudata = policy->driver_data;
-
-	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
-
-	if (cpudata->suspended)
-		return 0;
-
-	amd_pstate_epp_offline(policy);
 
 	return 0;
 }
-- 
2.34.1



Return-Path: <linux-pm+bounces-9018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E49055FE
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64581C20EB7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179E17F387;
	Wed, 12 Jun 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X/qklaEK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E417A931
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204281; cv=fail; b=V44UQsQJfB7b/kowO9Tb94uIy7IMmVGVfgo8I4KP23h6N28VaRnH9f9+jRhuKOy/eyiUmJlZ+3KqCBYCNKuYcoDCvzhVsQLFP3WyHuiolGIzpWk9iDtWZ7gLWyoA7CDoORnP+FVgOdnCuATvFjpCrT3nVJQpkZby9e1l5HoFL/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204281; c=relaxed/simple;
	bh=nXhi0tG7DMQn5cPdJ06QyVP/nEgKtu5Hwzo1yM+qeUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h52A49MoK8k1mFr8wtNSjwqNvoCcQ/owc/UvcOaJJ+zxDzXgR1i+ZywRIvknqX7ICjH4JH6FNQmZE8FSoHLBQ3Dw9mgM8aH83+M8DnOrUU6xZCCAndue2y9AQxIEyoAe0lGQ/+qOztBo4KZjd1EluL4VwEYJTIEONvcNBHULKiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X/qklaEK; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js6SQrGqjrRgyLJGIUntDn8IrfRoG3e+9RfTAf6F4ZfwLXZJyy8xfM/GqMr/zVyp5AQLTNcxPPM7Qk3Wn/NAw1P0lfy5btQtEttrPfUx8ZALXapWroDT8vCgDnEcQrgGl2fiomOwfTqh+gzqmABOYLMNUGTSZATPdbmkYLE6x+GX5gISuJHoh0P99kH9ZyEG34vlHykTE+vb2GVTVZ0OXHTMyPuM3gVBVGFAaLVUQRVu7L2rM8C6jGMytNjsjYxbAq/J5L/PqorjuoHODOUSmpHDZMsE9pFL8eT7Iv9MlJ1T+OpwnNsjeIhjaOYCimDG91FPtjJYOyJ2cEyWLVUm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHiZaZL4QyYdnbqG8yPoALKL/Nkum/YRoEHdzVucs5I=;
 b=I9pgqBntyRtSPqXzT4D+blQhXC7epAwV/a7NfW9PXQGANkuPSqTW+D2ujwg9bVWrlAeCOzYV6Fu8pIGL3pVCl5flQjzuqbMJYkuqCuFVMnY3uKJiO7gD1RlgNWsZa5ay0MZjKLPHYXOD4cw6OrLrUfh20OkuNdMO3eGHvzRVWJhDUZV+SiGmzv7RgBvh/GHBzgopiG7wRWuzy3aDo41XNr+agaWRW9K4bGPZlSyeZnyg1EnysVL4iYl3mEQwUCx0MjHaJDHwxchNTtFfM3nhrVHRk/r4mDU6hLLX93amHbHEsFAJbeGdPxfATm9AYZ5R7BUPt4/pnHX5pxMzp5zZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHiZaZL4QyYdnbqG8yPoALKL/Nkum/YRoEHdzVucs5I=;
 b=X/qklaEK0uFxEyZmGWtwkZ/7MC/zAdhTCOdth9yPGICUrWYy4/hlDorssCPUVjI0pBzFiVFEh+84ly35wcr3dlY5qaXNY8mMnpxQcCDUIjT/GvNRDMTVYaJK+ra1ORBFC+BZtzouEXL+IaOzs+sjL2MGw2aAuhP4C0hTv4UtYec=
Received: from BL1PR13CA0107.namprd13.prod.outlook.com (2603:10b6:208:2b9::22)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 14:57:50 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::bf) by BL1PR13CA0107.outlook.office365.com
 (2603:10b6:208:2b9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Wed, 12 Jun 2024 14:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 14:57:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 09:57:48 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Artem S . Tashkinov"
	<aros@gmx.com>
Subject: [PATCH] cpufreq: amd-pstate: Allow users to write 'default' EPP string
Date: Wed, 12 Jun 2024 09:57:37 -0500
Message-ID: <20240612145737.1618-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 054b3e50-d0e7-4b40-2f2c-08dc8af0078a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|1800799016|82310400018|376006|36860700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iwj+3xMaYrA4rqM9kGOR40S6+nIaWLtJ8DCrY9hSX/nSVOSkoLoh0HkVXVAA?=
 =?us-ascii?Q?1UyYzmJoTr3FLkJBYls9X6yQxBUTfhs3GQWLymFBRk/Ci9aF0+TG+yBpiAI/?=
 =?us-ascii?Q?5ocDcbkzTpVNgmMan5I5qpmeizrFtFLWwxZtZzSxR/4ekrGEqIYHftuEZSUZ?=
 =?us-ascii?Q?dZaTKCaIAGebaNiZycPop6Tya+l7sbdVo1omR12rdqAQhUf5jSLSvIOBoWIW?=
 =?us-ascii?Q?TjGfnzjRfXPF23OL1roo7AV4xuThlWO1JEmTuPTdcuU5fiuITNpJuvWgNJN+?=
 =?us-ascii?Q?5dCmWw5ms9huaGGajiee7ayIDvYV1+KkYykjY4OvNXaVmSzAqPRJQtIgOR9A?=
 =?us-ascii?Q?XbNIulTPJsDwp7t+5eS5YleJGx8tNrZy2gkZt96FGrEqN3uIYn0izsD6Rroe?=
 =?us-ascii?Q?GOUNdDr3CWwNLDrLD8f6wClLwJ0FXDeH4wA75bvtJjSW3dAsmj80MnG7VlhL?=
 =?us-ascii?Q?kXl6J/h2YAXRODXe1QR3NOUTx5qVz7yrFwtwy/7Q1lgjFw9SEyobjjjTjakH?=
 =?us-ascii?Q?7PQf6Ik40ByclzEWhbc6h1fmvT69A7N1MhWf2nhC5J/MSvU4zraSbz7oru3f?=
 =?us-ascii?Q?8bpv8AGRTtCqPwa+Z3H5+b2J0mcwKgClPqlqnqw4tnSe3ZY7fWfoxFXKevzf?=
 =?us-ascii?Q?+D/Y//sbQQ8BHa5y42YXMckRSwR2mMN40XneFl5Wgnky4yoFXzSMcUuiz5Aq?=
 =?us-ascii?Q?he+L23BARUSU7jx+0HoviGeuyaioa1A0RsECMgcf9S0PDQex2090ZrvLJbMT?=
 =?us-ascii?Q?7fB5wV8/bDcViM2Eoeniba7zLifzXq57CKt52ueQtRLN2CZQNs0kcuOgDZHl?=
 =?us-ascii?Q?JFn8TX9p14+R/V4PqwaD345A8Yy48IO3KOqrTkqR0DtotD6zME6JG+EE5ayY?=
 =?us-ascii?Q?N2lY1Ptw4J7NmcmmhfukkOVD1cpXbj3WNEHiApOtdggtIMFlFjI1JpEBT0pK?=
 =?us-ascii?Q?atgJKj6TA7uPU4ydDSYLEn+vy8w8rgoHLP8AqM7YMw5X5MPLuAz56WcuxrJR?=
 =?us-ascii?Q?opxDl69UJRPdCpw8d38uZ8lCVdeuJTCaSsvhL1LmlJPlj0LA9JnczfNI9z4j?=
 =?us-ascii?Q?72rE0VkcCQu9STLsvo58/2bnTGtovcLWiAmyv97pc86mntpbTuXBEr6+fOzN?=
 =?us-ascii?Q?FMhv27srQNFJhVWTRS08efc+il9vlojCwr4xmN3pC5u73gcHnIMSR5Rf5kXl?=
 =?us-ascii?Q?3I4syf3NSnM1kTEvkzroVUso0VsOkAAjLbVxps/fR1Ep3knjfVXKZIu/xdiR?=
 =?us-ascii?Q?Wsk8RWHHkvxvc/LNAl/TZJ0Z8fvwb9lQJVmS9SMtNtbL9X4MDknbjMMLBr5B?=
 =?us-ascii?Q?KvJEIHknFbYs8Q26SuPa85mUf/n1irlFvZknl4RUKvSZKo/C8T3wuIVDqsmT?=
 =?us-ascii?Q?bLV310I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(1800799016)(82310400018)(376006)(36860700005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 14:57:50.0860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 054b3e50-d0e7-4b40-2f2c-08dc8af0078a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

The EPP string for 'default' represents what the firmware had configured
as the default EPP value but once a user changes EPP to another string
they can't reset it back to 'default'.

Cache the firmware EPP value and allow the user to write 'default' using
this value.

Reported-by: Artem S. Tashkinov <aros@gmx.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931#c61
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 8 +++-----
 drivers/cpufreq/amd-pstate.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fda8f86c90e0..5bdcdd3ea163 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -282,10 +282,8 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 	int epp = -EINVAL;
 	int ret;
 
-	if (!pref_index) {
-		pr_debug("EPP pref_index is invalid\n");
-		return -EINVAL;
-	}
+	if (!pref_index)
+		epp = cpudata->epp_default;
 
 	if (epp == -EINVAL)
 		epp = epp_values[pref_index];
@@ -1441,7 +1439,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
+	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata, 0);
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index e6a28e7f4dbf..f80b33fa5d43 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -99,6 +99,7 @@ struct amd_cpudata {
 	u32	policy;
 	u64	cppc_cap1_cached;
 	bool	suspended;
+	s16	epp_default;
 };
 
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.43.0



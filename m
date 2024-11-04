Return-Path: <linux-pm+bounces-16993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F769BBCAA
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC0C1C21704
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFEA1D270D;
	Mon,  4 Nov 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C3m9dWgJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AD1D1E8E;
	Mon,  4 Nov 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742897; cv=fail; b=E7vEPb/1aIbZ2DZxwQYPrgANT8uhY1bIKEEU2HkHkwFiiu87Gluf4u8h+i/6iPGtF66I+ql8AWC0R6FbKT4Aj4tkdkP6OKXK5zqioQUYnA6LfFRmYsCLeB5H2d2URTWnLgBIzOrBLAvLGJNOf/BB/MXcJp6T07Pnp77yGLmcTww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742897; c=relaxed/simple;
	bh=10H316tACHv9yeq3U6t3bQxdz2Rbs/5sYYPeNWMmITY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6fZ7LjXmqgMkQUW+r2ksGsrmL1YMnWgu9UAu09rvZuZGZPvzs2Bh8bX/5ogP/w0WS1BB/phzjWE3oRKAtgTFUVtzHpufsnDYgvCXbdGxRuAg6i1c3hrRYHAVY5heMDjQjOjShijdjZcjvEoszcDSQBS8eOoAgBF9qWsPtIuuPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C3m9dWgJ; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFhN57YT3dSSjgbL46CGXmrVXeteetPYHA4wfLdiQIbEYEdFFyVS3xfViOl+1dE6TsqL2jt4RZZ0SKXR1bXIvbdp2XYgWt0yWVn53ds4bAlgX9+xBnjdLkhi80MWL4AK/EGpJsVKzKMn/FZm+5rq2V2vd18X9a5MBvv9Aud3aslKvnhO5enOKlvOJZbkG+5NGzcWIIHyvMer6EWUl3mQf/5I0ev4jOqmjQHTh5EKcDNVquWHwnJzNOilIlAWZGk1wrIEdpFOLm0hUOxA0WDaamyQ/5KG3IibBQ8PF7dThFYbKHp0GzDqHJiXo/yvQDeoS1sCJTzKgAQZ7b2dp6TcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esECsZTZzmpe+mXpfNUyZtWMv9UTjO2lrfk4s3FUxX0=;
 b=bpBEr6Rm5NyNUb1YySxKnv6o92+hN054Te32dhiUhdp/Rwo/NzXtRXvil2jyEy4k7QlfxnmKlYxn8cIK6erjIWsn6go8rg9Xja1FeQcQOVKhPIwqtxbxZNlX0IXkNVPleyqN4MFxgSvrihg89X7YM5DLqnuJOZm5+fSvTdboaVPtKvSIPSf49tvTd//Kv9+o6QgH+d5a3oIjIeF7qHRejll3+y8p5RuAqLs4f/YBKjPTAotttRHKtdg/wqiiywPAdGYasXP6AIsP08IbqYiTgeJXotZzhiMmgRnHacyh7u9D7r5LiAPCvzZ5ra5qEeBt8Ouh5WGz1rG4LqgXgCmr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esECsZTZzmpe+mXpfNUyZtWMv9UTjO2lrfk4s3FUxX0=;
 b=C3m9dWgJ03ae8PS3abz8tTY3Uff1yZVWV1NAyKzhx3MwFG9UnnCKibcRCnZGcQq3KpQeEF1fbPMgC7S30Dw1qfnDdpPeKx4646YVscwo/LQENAFxWA+heQ0E1q3kGuUMk5De7xQLtk7v28vyr+SO4UTGTYtdAWpqA2ppH47brNk=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:49 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::d9) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:44 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 10/12] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Mon, 4 Nov 2024 11:54:05 -0600
Message-ID: <20241104175407.19546-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5d05bb-9fd4-4c00-f70a-08dcfcf9c71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I9B2Wt5CceGHO6bv4gYlinzOyPNGRQRH2+k2RacPrT53AlWyKRw2LvsXXzvL?=
 =?us-ascii?Q?wRNlvi0lv/83TqubP/2YSAb1ed3ftqhoShaqXl2RdMZuqVnxaZ5ByjqKgckk?=
 =?us-ascii?Q?KFkpTRRZ2bKMywalftQXUjUcdd7sag+qBUaPFZj4Hy9FYKuOAsqWMCaQ3gOO?=
 =?us-ascii?Q?VIKjbO/434NQcpXbSx3zr1jq3iYwv8Li2HGQJtZ1dsM2t3YCLgMNCwFC/RbS?=
 =?us-ascii?Q?CkBmN28le3KKie1C6u3oKG+ktmLD/oddBUz3GxDt3tNB8gm96IsHGWOz0GFC?=
 =?us-ascii?Q?hBl2DOkEjm9DjixieBPZGAtBh70vGwfh68N2MGfcRlSIrcSADqmdwOMrjsrM?=
 =?us-ascii?Q?ZjTBnH/jFPCD4CcOfWuyfNgYRg74+svxVyT1nmYqAYNEeT77aGJdgZO831/m?=
 =?us-ascii?Q?sYkdGtnGOiFYvg/hd3O36K8KNCRmQb8AXLHvk3EvusvpndokCpsPolER1HKe?=
 =?us-ascii?Q?t4Z1Wk2Atq6YSDmecLNayquIM06VHoHd8SX5p0TLw8J5dSl+ZiYIYDjQcrYi?=
 =?us-ascii?Q?0XCUcs+m26V4SVzvR2jM8mYbcgMYI8hQVmwJY8sjI6HLPd4fHc5/QXt6sfNj?=
 =?us-ascii?Q?f05Lt10mUsvtW8LedM5avQyM8xz6t4cDDYWJvAoUVwx3dvQbZVAdjfTdqVNj?=
 =?us-ascii?Q?CQPdp+ZBotbJEUOk72uA67802xRlqjl68pnWsLUBbrZcPWRbkPoa11ghq4QN?=
 =?us-ascii?Q?lDKsZXggTPzjXL3uDSKKjth1xOOOMuUePXtLFyE7zFD7f1bGsNCz5sV42vnh?=
 =?us-ascii?Q?DMFspXO85T2829Gd3xyt1MgZd7zIYFvNxMg0WKOKVRCKhtEPtb893hude7Sz?=
 =?us-ascii?Q?ln1jchsAbKiIGsojGYN+1AMIKUKH/GoSyhG/+1V3Qp5yvnCPt+pG8nC8P/pu?=
 =?us-ascii?Q?ASvimMg2xTQoIUcVXNszYawSK37jngQm6nW+Z6KQqwcPAvi6gxPsxM9JPT6n?=
 =?us-ascii?Q?m7ws9dsy8DWxCHNUo424sbCk+2mYMQrg1HIJ91r+wn9EOfr7rYqIkzIG0GCf?=
 =?us-ascii?Q?SILBpguXCwIOF1UHRUR8xJ/Q1SpngEx+4tJqTDZ5iXuQLT0vKKyDC+dM9vDy?=
 =?us-ascii?Q?FHApMxFFpWq2Ki7WiMpFC+cNq8wRQMjOX88dlrzTZg5k7vEkeh+SOxppM2Ae?=
 =?us-ascii?Q?YHBNvcphP/f5eCB4xhy2Zo0tWPI0MhraIDwn7JlZ1WfuAL2apcsvGg7eCve+?=
 =?us-ascii?Q?aoDFMC6y8EBOkpcWfmT4oJaJvam+vq7coAoA/PkBtkukpdY9Izx96PqfEZDl?=
 =?us-ascii?Q?mjdbezX/Pqbira+BUr5FXDU5G7EKXhZxs+kgDExx4NQSYc4FBFdNp40I+kO1?=
 =?us-ascii?Q?vtKHN2qv6mG25kPHL8mnNjgsqJvKR2Qi6TQIw95uml6oupvCB/PKUXxSC34n?=
 =?us-ascii?Q?0j1WAGcWYdYHOe2gWkbdwJlchuzb/G386SUN1mXk0D2tqaHkiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:49.5694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5d05bb-9fd4-4c00-f70a-08dcfcf9c71a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6:
 * Use cpu_feature_enabled
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 32ddbf37a9f0a..84840666f1d3e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -780,6 +780,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	/* user disabled or not detected */
 	if (!amd_pstate_prefcore)
 		return;
+	/* should use amd-hfi instead */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI)) {
+		amd_pstate_prefcore = false;
+		return;
+	}
 
 	cpudata->hw_prefcore = true;
 
-- 
2.43.0



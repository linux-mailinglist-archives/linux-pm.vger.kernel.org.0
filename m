Return-Path: <linux-pm+bounces-18294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403439DF1A1
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0945A1632F1
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7C1AFB31;
	Sat, 30 Nov 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AURki1qG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E091AC438;
	Sat, 30 Nov 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980066; cv=fail; b=ibs66i3Rl02oyqQbvCUodYeBVcIvcYsI+c2CJBlZ3m8VqezCs/p268UYKRGDPsc3J6Anlav0vNQCMvovJXsSm8AU0gH9FpoEP1MLx+jproT5tmoZol/g12zYZprCoO66beb1TAz8o0g8r1TJI9QTh+KDT5zJO9KAmbqs36cFUoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980066; c=relaxed/simple;
	bh=raN5KExkCsujKrVcAi0TXfz8VmpAYeESNZ7vG3LUdsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYsAfs8ma/ARP5bjyWX1wselAH8Qy4h47lRWe/8/tSNA8h8nDHxlWYh1YGU2JevIVPHXKgHzeaFDQUs4nYW7IPod0s5LLFU5qkXb7lZpowAOeCLlQQSNeeqaC3DI8KtIS8rDnHerO/qR79CHAHidE+zLckY3nw+msbT6PE4Z8D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AURki1qG; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF97xYaThIiMXS6gz0E1vUd9NtsgBvEuqWb9YuSwxA0yWzX3Uav06nx3gSWfOBX7gzb7vRsaMarx4y2cvq1gb9BCxM8MNOpVnZRQX+r2KQPe4LFhZgQLvYPwC0izkBCJC4KxyeiZEjSR8dMouhnIlV0tupdIxSHwk6a53oAEHGbQRUGg/lhJGsblNSCRS8yHGxTUyq7dEFVujC4q+IHyWaSq90h2cX63TAOLXqyO0/oM/5ZKRnzEvoTfVDFqjuwmSanMkHIPw4H63HCPzRHobY5oYbRufAFbgR0okB8rZYMp8DonbLKqCxWyqDVJ1cO7lZaDPwiwckzAbs3JsmSnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QADJVeRreoewXJvxyin7Ng4jHEleXsWtt7TUFdQLkMw=;
 b=l6qdqhjaM9gNV8CWk3xV15xTF5abgOiKvOmz4LGAFpByRzYJgYtpFe9OuvRFoJh4IAFS+izJv2nB5LiKP6cUe/k2wjg/a1BrkG9fV3kVI+hhN7RKfOfjpsMhzeAF8FnI1K46bjiLkkmCUM8lY4+8D4wjw0uZ8Dwa68zOQQY1EXbr7wWLnzT2GroZN4TWBrWquHFqfRjYdo5bhSSNIaLk134Q7bZxNz9LTwzJ7Dtsc9kLH58v+gn3oevdeMvMIuX+vzT5Fxo4yVPuA9wHVAwfJb9NXsD0dcVnNs27C4lnWnQ6fYMzu3O6ZrjSyapv+ucvXVbQ0Fi8u+z/w+krP1M5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QADJVeRreoewXJvxyin7Ng4jHEleXsWtt7TUFdQLkMw=;
 b=AURki1qGS75AdWmgqPEAWNlBo+pjKpmMtLgdaEPYC1dK2YefWGbRJriFQF8kAdGLa4zH8xRcw2E3pS0+6CExvOlIORNWb999ax1hRuIkoKp5pjqI1o9MvKGjYw7Oyciq59hRhB18e1dElQVOehQ6jBc3bVePZgTZRjrUfYuPL5U=
Received: from DM5PR07CA0049.namprd07.prod.outlook.com (2603:10b6:4:ad::14) by
 PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 15:21:01 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::27) by DM5PR07CA0049.outlook.office365.com
 (2603:10b6:4:ad::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 15:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:57 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v7 10/12] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Sat, 30 Nov 2024 09:20:21 -0600
Message-ID: <20241130152023.684-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: a04cc726-13b3-40f7-1d65-08dd11529838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XlOabpxwo/HYSwF9eD76BgXICi4YgoAPtMfx/tYjiWb0490AC8IGiMnQVRdL?=
 =?us-ascii?Q?73TT2wh2jUGkcyyFt/+9ad5Nz6iO9vLkEt/FZQHksr9NA85nwm3iahvsHNWE?=
 =?us-ascii?Q?LtuRPxgadjwLfZh6iUI5pgFqTEmr3sac+3AwAcOlvNfs92Vcn6yzIA7WUj4n?=
 =?us-ascii?Q?mBRHGERMJvphkS2S8AiTwSWezTsjOvPLFiY2JPcwR0G0i74sasA+8AA6x04p?=
 =?us-ascii?Q?LvMBiTpEw1EYkSIoGkpydzfPyx51FjqGVz7bKk2+ccx440/HBarh7xWHDXHg?=
 =?us-ascii?Q?U3aD/6Bo8zMan4iAWksNHogRWLPDRnNjrHJG/nya0OoIebgSrsViux9ZVsX+?=
 =?us-ascii?Q?xAxARzf8/Sba86QT6e74mET7xcBI/+/Bin2ByMeK5HBaTpmRfvxP9QWXmNxC?=
 =?us-ascii?Q?EnV5nTNxE60SN97o3PfklkU/g+bOg48pGhyWJSF4LQkYZoSXy3bj+Mqh3z/V?=
 =?us-ascii?Q?UECFUxSuuxZ+xxbCNravoe06qPPtS3qQWu68XXYZvwbkQczUQPxwH5/0DAEF?=
 =?us-ascii?Q?nED0nttcX5VuqqlxbKjWyzIakM59uTSjj0XrwxAjK3rhjfH6eqF80UBESnXR?=
 =?us-ascii?Q?j8M3QrdFDHnsuPm8EbBAs4YEjgbqpV3Qu17y2+/Qb42XEi4WMWPoQjRcJQ1e?=
 =?us-ascii?Q?E6Cf+hiR2xIj8Xn9Y4ukWQAZlMWHIG0Y96cjMKsRBuSY2kAgLqTeG2dBapiG?=
 =?us-ascii?Q?IZLR5lu8Hao0t5kESc/e8LeR4sZMXwcj2nmakx2qVHrC4DYgNoM5nSgSItou?=
 =?us-ascii?Q?w/ZvMA8UPfG3pcju4YGCSh1ZrHpyI+fcwLq8GIyQ4J4S14RIIJF+38nhHaYJ?=
 =?us-ascii?Q?oYku7XsoP+zAZxjxaediUTR5QGXLyxKb20hHPFmstaDDvKW/32an2by1vaXJ?=
 =?us-ascii?Q?CQ2I6jpwVncWgV6jbkQ3eZdhrkwo8tEDZAWsXmX6rIFUStTDki6HK6AcpweP?=
 =?us-ascii?Q?r/i01uF1fSOxXpnumfiFJXIedCR8485HKZRbnfulIqpy5UjxnU4Lb9hLWDog?=
 =?us-ascii?Q?+Ql85+1d82tVzVoQKLifd7DF7dEHClVsAFTB37/z3myh4LhR4r9yghuJ5HXx?=
 =?us-ascii?Q?DdQbUi37YoFM7fizq2otpNYh9/BbnfMfoupmXKWo6Fi1HKIu/7N9XPscoicW?=
 =?us-ascii?Q?sFxl2utF43RCfhoGfCkBxu4T9OixgeQfA3AIdJX3Kgr1EMi0wyb+tBQUs3Rg?=
 =?us-ascii?Q?//p1vYB59VA7bXmi6gmHM7fSNVyGhykFpyQNSwXT3kN1bL07DNSXm3ZdB0z3?=
 =?us-ascii?Q?QP7zHjrzAjMLS9D44/sX0glqjWYqYn88MnBI4p0LAIeCZgtrrF/N+UXPF0yv?=
 =?us-ascii?Q?GadFrgxL5SJ/DSMlJT3/CADK4rJ5flpLs9Pf9hBx0oT8LeXFzvFCNG8iShb+?=
 =?us-ascii?Q?xpHYTVyVGm22phJKCuecEPKm6yaA0amycn4hcNkNLo4yQf9E8lipL6jmaY6Z?=
 =?us-ascii?Q?m73UJf3U7R5C33QLMRA3FK415RMbivsu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:59.4189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a04cc726-13b3-40f7-1d65-08dd11529838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7630bab2516f..6039c719961d6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -788,6 +788,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
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



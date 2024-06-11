Return-Path: <linux-pm+bounces-8920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCA903721
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FC528B805
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856D17799B;
	Tue, 11 Jun 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eacUZJdr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FB17622A;
	Tue, 11 Jun 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095981; cv=fail; b=g7vdK3/yVcvtKmgjAmqTzWqRGYVOdmEWBkSQYbFjRJG0uNuvi1YzE81MM8i1RgmgsMl8VDyV3pB0t31DVboYCVolFg0Lrd1FGwQZDy23fG4IX3bO7yByTh7CrQGDEflG4YwoH6bIMPB/ejwQfTNLZjoxCRBGUB086E1TiqLDBi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095981; c=relaxed/simple;
	bh=fHRmpdbfZx3GtxKeesg43a9Dqy1v9IsR3A+IIikIXHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvssgbB0CJs7YA4qZWfeE5/TubZdpG6mLE+TIl4q/r6fOSh/exhEYswPd5+WW9SngfpKyOLu6kptAkr+7msvwkUNaeH4LRWWe8J7QhCscxSm4PHFw2kRZppeYF9i6uVNHcT3zju9zNen1RrDjRN+X5XzNn2YZWARIf1AupGdIy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eacUZJdr; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHMv1DOFN1IPKro7xt1p3IsLZVWjKj8OMULHObFBB1t3rW2EcKwqDKKXg0kVJcTUWIaGz4BcfU/2AG7u8p7HECs9+H5NuV2naO+Oat7+YndWFghPmpt+TQFuJB+FqRKSobrNV4S17Meqh6FBKPQnZpeTRBCokiDc9d7YWPtlN7ri6Y88db7XXKFO9RZ+BuGlff8lezZmtlOj/JsKN1r22nZkYYRMtvGsy+kUN8SMtRHE4zE1OTsvXQ6PQwDhOnmGr/dKi/990zeLCsfHdgKGdr/FkkHF04ctQSELJK7Zo4qfT+ovZymt7vcJnj5FTF+JQERGekHjyJdUKLKFXxsstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbZwkCgd4HQoScuCxe6RAJY04OogKDrjFiUfu90h2Js=;
 b=kXCpzG+3G1zSpogqWyj9XHpK9TxQRLxZ8dHyglTg1n0MqMUQdAu4n3+1gNmtlSwpR6F28E4eqKEqr4ooU4dJbv/g3TIKf84AfwbPbxSDFb7HnyLbxtejP2BNU5u2SCsHR+QqGL0mpFHnpOQUYP3+wSA8mFVKhkBtYEp2Io9YeTnyNYnIwgl2t8fGbpdgZtFF+vsyyM46vqVJNMB8+tE3yGMSMUODACxDc4VkQFxOD2LT44L63NbxpL95MomWEYRboFa8xqZLjLSad1Rc2rGVGjWCkJjDYXvQxrl5IfLUXqaF9QrQVuGXcYKLSurgh1txgleZWPe3djCsky+76FHKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbZwkCgd4HQoScuCxe6RAJY04OogKDrjFiUfu90h2Js=;
 b=eacUZJdrPpAyeSnpmkCDzHdHXEc+ytyEpRbYheRaZA/WiNQ6ezzKhr2JtKc1R1cvHk657rtNCKkAIywqkK2wyP4iCcTuOgy7FxtXFpyfBhioPQuLgWo2toEypi+xnYbA9TcqDPXVxvJdWfX3a2Bx4EGiDWhLGDhon+W6G6cKQns=
Received: from PH7P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::10)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:52:57 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::9c) by PH7P221CA0007.outlook.office365.com
 (2603:10b6:510:32a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 08:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:52:56 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:52:52 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/10] cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS
Date: Tue, 11 Jun 2024 16:52:20 +0800
Message-ID: <adf1b81c44806e73a391aa6bb49a9fddca95550c.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bcdd20-52b2-4cc6-5cff-08dc89f3e383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PC870c5dv67h06oSjYR1JC7/7sZsOYV8O3/2ju36OvROAJn3ROEeWHGeswUP?=
 =?us-ascii?Q?9yqeqLroNpni36dOTO7qu0TDLe8P7J/rrrXYkZIrQrENpP27us5gnS5jcwmX?=
 =?us-ascii?Q?vpGEL4q8+TOzKDJ99HrUuEBgv057JWOjJf53TJEMjiG4c/oFF4qLs+Y/Pb6g?=
 =?us-ascii?Q?iatlAY1LzgfKLM/64LQurYBEM0lJka7Wwp0OvRifwyqvdPBAoTApwSKLy2i9?=
 =?us-ascii?Q?9ftZu/TUDjUyHb1W0cFzGg9dEa3D8iaoBbYj/Rk9bCJQWcmg1wyrH8ewbQHF?=
 =?us-ascii?Q?P4ymbu8dnz9r988/mnl1MlBKKI16xb9BoFJtZ6EoNO8ObEbG8ILEqxfceSCB?=
 =?us-ascii?Q?N0u5xdSLGQ+oAfXUnAk2L2tRnN3i0s/aSRQ0C+dgZuLeCCmcUFF85RZ7SOxr?=
 =?us-ascii?Q?AG+V2KPYZcga3CXr92N8yRb6bo3Q8ZLOadcIFaJEYr75oWQ/4tU0ahiCU042?=
 =?us-ascii?Q?27zhJy8TJ6qa17lu6WvLq9KFCIFYKobH4zfsdsaml28zokkvF6Y2kTYfDkZJ?=
 =?us-ascii?Q?XpOtXzDptZ8njOz6/HtYnwOdGsep4hqgKCVTM8lovEphsonAsHoIPyW7Hri8?=
 =?us-ascii?Q?/WFZSqQVLtDnm1mRXYMhC9/eOF5Bs2e5zkS2Mk5FA6fPgpa1bwrFrbLGRVPL?=
 =?us-ascii?Q?elCY89zZ2BrbrbeMNKp9dMaVtXw+py++2ZFvX0jUu7vRwu/um3ezmAjFNxHC?=
 =?us-ascii?Q?fATgxaGexIpu1lwyXZUk64AmWvFMLbBfzv1FurbU6gSVhaF2we7JY2l9+txW?=
 =?us-ascii?Q?Ww1G11yNxtdkVpIM27zskiJXySlXR0DQFabti5HkPk3/5kYWIm+KfJMLtlgk?=
 =?us-ascii?Q?pOlhfRLUNFsWw8VYWSr12okWRizzXIFzbOqhTUhkspOOEmTNkgjWfyFl2bPp?=
 =?us-ascii?Q?eHYXwhXPMWig4vlHuXBrxqWeUlt4cDDi9dsQGowuh9uFgp2K4PxGZ4v6hb/m?=
 =?us-ascii?Q?Tj//c34VrTCntCe1495jpEMAyQQA04FbLLJQS3+q9KCRh7CG4EFDmV7rEyLI?=
 =?us-ascii?Q?z98ZS9L2Z7s0XXN+/Yr+t9IRIo4TFPmkWzRSNZIT3IfpHJ0H2L76RIKqLd/8?=
 =?us-ascii?Q?L7zLtauTQ11c+7DFOqJEQEXpHpNrdEHai33NqAyDrUoLyjhc79YN9QKG7ejq?=
 =?us-ascii?Q?h4ZLw5m8CN+5Kjwo+0s6FlHz1iMFcKCTJh1tOgFeQmq4B8ISRHb4PvvQOtoN?=
 =?us-ascii?Q?EbwbO3FH1Rn4vpDrhL96AdwCAsHynlVZvBcUfLpSIxEu36oDEmAuyDzt/xSv?=
 =?us-ascii?Q?otz291NVsDttVR3lEObafZHq09wdA3FVes/GPcjCcHRJ2izc98Cmga8yMwjI?=
 =?us-ascii?Q?XbIiN6IDHaX2ZdPUPMjaC9R4hDUuMHBsaEhvH3r4Y4hk9e+i7OjfDsgY7SHo?=
 =?us-ascii?Q?oPb2ick=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:52:56.6081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bcdd20-52b2-4cc6-5cff-08dc89f3e383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

If CPPC feature is supported by the CPU however the CPUID flag bit is not
set by SBIOS, the `amd_pstate` will be failed to load while system
booting.
So adding one more debug message to inform user to check the SBIOS setting,
The change also can help maintainers to debug why amd_pstate driver failed
to be loaded at system booting if the processor support CPPC.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f166b3b94091..6b9fc24001f2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1746,11 +1746,36 @@ static int __init amd_pstate_set_driver(int mode_idx)
  */
 static bool amd_cppc_supported(void)
 {
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
 	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
 		pr_debug_once("CPPC feature is not supported by the processor\n");
 		return false;
 	}
 
+	/*
+	 * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
+	 * the AMD Pstate driver may not function correctly.
+	 * Check the CPPC flag and display a warning message if the platform supports CPPC.
+	 * Notice: below checking code will not abort the driver registeration process.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
+			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
+				goto warn;
+		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
+			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) || (c->x86_model > 0x40 && c->x86_model < 0xaf))
+				goto warn;
+		} else if (cpu_feature_enabled(X86_FEATURE_ZEN5)) {
+			goto warn;
+		}
+	}
+
+	return true;
+
+warn:
+	pr_debug_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
+					"Please enable it if your BIOS has the CPPC option.\n");
 	return true;
 }
 
-- 
2.34.1



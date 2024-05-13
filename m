Return-Path: <linux-pm+bounces-7750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A88C3A06
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEA1B20D53
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B019137755;
	Mon, 13 May 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ESsNEUs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F7136E09;
	Mon, 13 May 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566085; cv=fail; b=NHW3A4UcWT1he97xFQ3129+pcBw33R7ie301fyZ3kFWfxuV/GXlPqNJkoGOk1mnSW8qLytw7IwM40IZTx0t154Ktw+BXqYGBYCI3EDNpq11q7cp0j8f1PuhzEw214DAQ+Df4h/sEirI0VoNVR/XWdQt54Ph7lbSCaH2W13J7EF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566085; c=relaxed/simple;
	bh=7hPMIh/Tae5hTLWDa2hrzWL5Sl2PAO1vnlF7Nswfg3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDYfsyM6vgKQth8Wz0Md+GmLgHst4yxILKZ9t1+CA5RmP4XHkPl6mu5qoefLD1aWRyAFZDmWEAZgfEVZ0onmfIlPkchGQ/z07hrVrxEigL9Kv47HwIN3bZkfmWtpZ0HhVioiaSCtI2+8OgehbbNWz58RRlQ9Co7ET5LQgg+goUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ESsNEUs; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEmzb2vIogTBkjUrkh7OWANZi+u2O32AWhAQHX1SRAtTJd1kXVJu9niqbudIVt/XbZEv/HExizIsU1KxIQQwMCpjTEWzSPw3hFEaZEe697MEr8B6Dh2r5+fNjKzu+ECBp0JoIE9rBpSbZC7yhYDoVbx+F768SDL87PNpsgpk4Q2XE3H7FWacea3HBnq5ABIBDCKwrErBNj3Atfj9KRuaD8Vfa11aVT+iZYi5fIc74roPDWkrW0xONA94qxw16SMkxULgX9HPvI+rHD+Zu1KSNdkoCkZcQJMsixQLiObefP2d6yrpR/HPTL88bFDsLnVOvCzGggAKvQDZXv1bIUa3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWEEwnWXbvodA5o/rpCsBp4P6REBonT8BhfFs6ONT34=;
 b=OU2UZlxcaDIbcZbZRpujLmZuu7f1zAgXITn5j0elEXplNxIaNmnzN0nzOGYOKjKCbq//8QgfcMtIGwXGfIJZhLGzn4/tv2U6wtAxsJ3TewpBp6Xe+aQCYPm/r6R+TIHPCDX2RfipkgNUMObUfC8+f7eE0PD5acXs1ChoYiaU43qh4nZrtCpR+yjFm3/ADXpFK9l/swGcRicQJ5ZEWrBmt307U7IQboRvOJNG1nsJ6GzpBE8HkTmxXIo3E82IzgKr588vfrRWw5nSdCCDURfF2PCb7ieR1QTHLDr7oXYT1DZVQsDuoSdw8NxvCv6oM0C25trcqe2DDWiLS8ojiX+GkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWEEwnWXbvodA5o/rpCsBp4P6REBonT8BhfFs6ONT34=;
 b=5ESsNEUsbB4Q6mR7cdt8T2KMALfoheqCAxi/1/Foj6dU0pinJp+GagLj1SY/TGVgo4oFjHbjpLY50Un3CVh+Yx38PbRIXY4UV5FvZHgLRcQtsZYRHjXnNqUbvEnjl7Zfg/wC0XIzSe3FKWcO+ULeGjYCw4aITcixbm6nWurapgI=
Received: from SJ0PR13CA0189.namprd13.prod.outlook.com (2603:10b6:a03:2c3::14)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Mon, 13 May
 2024 02:08:01 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::97) by SJ0PR13CA0189.outlook.office365.com
 (2603:10b6:a03:2c3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:08:00 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:07:57 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/10] cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS
Date: Mon, 13 May 2024 10:07:22 +0800
Message-ID: <94ad4bca2d8e44a5e53082959220a184c0222e1e.1715356532.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715356532.git.perry.yuan@amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 883a0e79-0e22-4f90-2a73-08dc72f1843c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2UhGpE59nSN4jKvsHuvRDbGwFPSYWwQ2e1DIwRGbqmpfZDnixejUN+ISZvC9?=
 =?us-ascii?Q?k4upeIAx5oE5nPTLozoW4ozHSofTubCF5kqbqVSIcKMWvYKvlZgyAVkB2ivJ?=
 =?us-ascii?Q?CcJnRBNdLYwwNn2hMCx/LJtTW9qB9bFRzNmBqmLeoskTyTfuMfNKq77hnX34?=
 =?us-ascii?Q?ajsgK84nK59n6p7Zcgt8c4dYJtBy5D3Uy1n0xK3BWZ3cxFwokNAX2hr+FUk/?=
 =?us-ascii?Q?w0BJwZM0Vg3d2TOCqroBkLdD7Z0gmfzEKbuxxBgAKADxwPnPoimqnw+YbbOo?=
 =?us-ascii?Q?QVhXRtVnkKxgsgVEru0rZ3Xo9V0YF3F7w3LxUodKUuqFbrOWFlwmJXJX+s08?=
 =?us-ascii?Q?c2njmwh0WFXczbm8ZtEzap4P9uiXqEjlBc7acJ2lkn8w8/2Krkh4igzmS6kc?=
 =?us-ascii?Q?SUS+5lp++9buDAU79C3lxDJpV0dsyW3VJ8j5fd5MaoVc4YX7rk0WJT3MYSaP?=
 =?us-ascii?Q?ddHNOvinly7DdE/sHHbkc6XMRTdJcy3c1hpbBENDRcIiEsajrxfq8OEMX0+b?=
 =?us-ascii?Q?gWUaeayjdk5HaWgZr9r+8l7q8lgAmpkbpACuRK0Avp3RVvtRJaXKpPPYzO0Q?=
 =?us-ascii?Q?SvstX1CKLKxhcy6y6nSy5N1K2Wij1By1XJAFqNc0Bh1BwtzjJKx+SW8TmBH3?=
 =?us-ascii?Q?YIamp1OIFtt7xELy82R9ZFP5YSUlosc9udBE4iPCqYWZfucwhEAPx/shg5D+?=
 =?us-ascii?Q?EXFlpvAO0wIKbX3xawFGgeSmfa6lkvKhsxRsCxIfyYfDSbIfRT+gkKR2DB1N?=
 =?us-ascii?Q?/LrppQ6/tjscMG9b2FpHOe0mWqcXtRcUIGfSYYH19WjHq+HjDYGA4y7kB6X1?=
 =?us-ascii?Q?bNgNPyEa6m15+X+aKfb/F/2RffWwIMORn/C4eJp6vJsRwkyxLflcJFGNqQDg?=
 =?us-ascii?Q?S1p3lXufUPV6CgSIT2OKtz9+/mnpwpxRmdwp/zryQcn8ICQBkjedbXrhzmMV?=
 =?us-ascii?Q?9rlCGHnDg1IyF8NWzdAuLVPQrJ05bg+A0Es6iuQe6t9hEkhIoCD4Po0L0HAt?=
 =?us-ascii?Q?zAVkga2ZnCpNTlEgPY4RgoOZfyyai9JTevkqfbcjBz9bNwWGUA1WEMhJ9v4g?=
 =?us-ascii?Q?YHVCvnFuEI6uswEPp+gZx9cYtPv5v41pg6IfULmpvlAgiW+FvrPJHANEJPoM?=
 =?us-ascii?Q?jAxQLV88ur2yAC0JERux8OVwu9TNsP2hh1gVfY068bjrMx1VHZE5VVj6nB/w?=
 =?us-ascii?Q?EU6CBRZcfwn7RX55vB9QKFLENpedoOf6ICcxeiiE/ytTyjQUS7KhbfsQoNE9?=
 =?us-ascii?Q?iWNlzT8GRVQSlJoXS3ropMN+BjRzJBzajOEiEnS+YtIKvEaUJ9kFT0z0WfoB?=
 =?us-ascii?Q?VsWbjOy3m+OGL2vOCoXeJqYZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:08:00.9738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883a0e79-0e22-4f90-2a73-08dc72f1843c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

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
index 3109b46fb02e..8b624c79c287 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1707,12 +1707,37 @@ static int __init amd_pstate_set_driver(int mode_idx)
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
+	 * If the CPPC flag is disabled in the BIOS for processors that support MSR-based CPPC
+	 * the AMD Pstate driver may not function correctly.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
+			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
+				goto warn;
+		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
+			if ((c->x86_model > 0x00 && c->x86_model < 0x0F) || (c->x86_model > 0x2f && c->x86_model < 0xaf) ||
+				(c->x86_model > 0x1f && c->x86_model < 0x1f)) {
+				goto warn;
+			}
+		} else {
+			goto warn;
+		}
+	}
+
 	return true;
+
+warn:
+	pr_debug_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
+					"Please enable it if your BIOS supports the CPPC option.\n");
+	return false;
 }
 
 static int __init amd_pstate_init(void)
-- 
2.34.1



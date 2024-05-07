Return-Path: <linux-pm+bounces-7554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A78BDC39
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F63A2820B0
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F0913C665;
	Tue,  7 May 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2/mW5Nna"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3113C3E2;
	Tue,  7 May 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066160; cv=fail; b=MyxQQi1nmpRgNc9I5S2+bB/00cRabljTjtzaYYKFQis7NqX795M7ILFody7TE+QI77Xh93YToeKyi+IoE3EZTsoqnU6SzQyLIlQxPj93i+h7IY5Y/sr9LCXgYdLrlQde8YpyLIDgxfKY0yabwHSWG+Q0pM15+LMo4BT2/isd1pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066160; c=relaxed/simple;
	bh=iOvtDoiTLZmQdiVipx1+bV5FMKwtctzH1qqIM/KQlaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wpvyt7HzM8LCFgGXK95G96/XX9JQXGpNdHM8DrorglfxabRFL8wifdB8F8RCH30Uxipr/kTkY8SBCOgkKXnbBNn5DMEYuaD7E/xwPwe9/LyPG9zy0qY1mHob2UJjaMyz1cFW/H2tA5JCOt63f7ToMW9DORBW2M4yHgaIbWQncFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2/mW5Nna; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chGH4gfnT8jhiQ2tgYBnOHe3NhyjLLt4zuJgRIwSy5TQEUlO/5OTPSeC8h9/Setwn283c/ndrSLs/mg1Y8JZ9f+5p1qtO0H151AH3+w0sZMzs8bJJEgyQ371hxNP7JJbCGnG5UdRM7Lwj5fTcs5W4v/G8bBnK/VERF9p5oV4kYn5NPQ0NOaDwMc+1RKQ4Xr0lHQAqgcNgLxRCLatynhPHi/FJyWsR0MTtH8Ygn2MxdlumqL4MnZgbqt7anhy60inb4e6pHtbNeAjExisLWnJekp3Cjo34nvMuPjiYKEUuqimPMAFwhg7ej/yYhHPBXrYAuXpusdF4N2eGj+Fh4qcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z68DErtqRizxYolil+rAFq9AxTipK39aK6ASsMhpOn0=;
 b=n41gi9RfqD/kfv2753Oed6sUF7qWq9d//mpAjopccwyr1eaX2vZJrsnuRtTHqUBGn+AeE1HATRK0i7IpVtaxhf4eIrJdzqUtNB+Yf4xM1KBHfRZOIKkFfMGMGSO6ouzwSz/qsKU2uDG/OxuJhZm6GdbuR4NC93CO4pBc9H6rRSZ5uleM1ZX464KPeRnItwAL0UcSW1EApT28bXMHcSJ8Bp8DEaiMIzMmmUwvjytZXy39Glq3vmR/xvuuoNEAFriKuR9dTRCEXqswzLpc1v5qv9h7CCzMynjWl4+FdolXsLaz9w4eq+Rb6HQLha+BBaDud08cyXF7oswQilHI1SBeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z68DErtqRizxYolil+rAFq9AxTipK39aK6ASsMhpOn0=;
 b=2/mW5Nna/kddjn5PC3KnC9Y5Vzjr5OoEEsPVftT6XwkeTObWYUnCVMiN16/iHESaKOIwVGbCTZ4POyRp6iKxpgSVyyowD7TRZk2RhO9JHEWwDUnU92T4K2bImXsxQc8nBwBBeOZ+8AWVQVlFRli+GXgvWw/ELF7g36sowN/ho8Q=
Received: from DM6PR07CA0092.namprd07.prod.outlook.com (2603:10b6:5:337::25)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 07:15:56 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::6a) by DM6PR07CA0092.outlook.office365.com
 (2603:10b6:5:337::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 07:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:15:55 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:15:52 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 02/11] cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
Date: Tue, 7 May 2024 15:15:18 +0800
Message-ID: <4b4a1a6b30a2dc6c95e550c62b230bc3788af415.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715065568.git.perry.yuan@amd.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 124674fc-ce6d-4384-2095-08dc6e6589a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qBZWZYMb4KAWYN56vz62KhXQXqaUSYU+nZKjq+txccKRtcRpC3SW5Lse+2DK?=
 =?us-ascii?Q?XBqumC2tIIHvqjjvOMx4MG9AuE107pTunejSc6ks1ujUZAMOkp9LwTtXbpgm?=
 =?us-ascii?Q?bXwDICNGZrGXMGhY5VZNFtECt/MxfU/DbGGn0KcIx3TL3L2L7VFUWmVVPxwK?=
 =?us-ascii?Q?nfYkPLh4G5x8rHnzq+j1PHYZhSwVIHWUtslinHtS/2QQLUXx7Qy2Kj9WA3u7?=
 =?us-ascii?Q?VFqNJKYNk2PAu0fQqPmacQqv9V1qbKlT85qaLTkQRTO/FXdyWVMkEEpnopwj?=
 =?us-ascii?Q?/ZEkwO2lgXYc59ry4Z0LQfRO5d1CCu+gUfCEGtT+uNYd5aqmOunsomFoWuEi?=
 =?us-ascii?Q?ul6WW4cjLIpZY5Q87/GYgsB9Ylec3f45ScrkI3kq2tvtKcCrrNBsBDkrPVKF?=
 =?us-ascii?Q?Pmgjmloc9PvhanDtUQxuDDp58VgJn3agxrwxp9EvzYTN6vFqH+nVOQGY7Veg?=
 =?us-ascii?Q?I8UlYJM2HJ6uoiyNdl0OI57cXqHNON+0EvIUInGpHggiNFAGOJb4JvrSyk71?=
 =?us-ascii?Q?OVmLnrXlBvUBJG6i2eXNCnaFF8i04c1UbkKttYKVVgnYG0IFDnsVYGAkjRg5?=
 =?us-ascii?Q?EqhCCZfFKLUwdBR8hvHo+jLa9Z2F8LsPFFlvQjKq37/ljNwoPioBg06lVGPd?=
 =?us-ascii?Q?J3PW/R5aanffi3sd/NFSFby73feYjEGNJkUkL7VkRhpkzvK3CDhLWOoEarBI?=
 =?us-ascii?Q?yt7X69vwW7EsvZNQZkObjwPuTtUiOoOfc7W3FF70MVlWclJ9RPcJebDiVjmP?=
 =?us-ascii?Q?yDVRVwhVm9AZh7rlNgNuVY3FA0NJhCyp30gz57IF2vkp+B9Fw/mpb2t9iJle?=
 =?us-ascii?Q?4femoyyGZoT+wyNR24XtJq+PaoeXH5DM5dvwjxg4okQPsKArr6TXaj9xtxwO?=
 =?us-ascii?Q?Gar+pJYB3wHf5KLvvgupA+f3f6ctGCB0KG7rUt+2aG6xrhU3DAff2E/ovia6?=
 =?us-ascii?Q?f2dCs0tOTTVmbcMntEWx15jPqhuDICAbaLyafxA4N4/BhNbEo4Y0ZYchThLf?=
 =?us-ascii?Q?eBcBjC3Wgjyc1IDUKBjWvQzSWDx+o1xyVYPVcTZ0bZg+/zQgVu0RqhNwU7js?=
 =?us-ascii?Q?OypiaC5Z1qq2xJ1ODrccFtloX7kN05uHpS7yKpvN0mMhlfJX75WAozxKhBHJ?=
 =?us-ascii?Q?CahYEtMWvsMq+ecVUx5pSWZdaVj/H8OFW+ImEX4AEBMjt9E7HQau4wWXaDOL?=
 =?us-ascii?Q?7UljWqIupEA5VyYTVztZKLDoYSa1yg2qOyG5QBdgpKHI8gLHuBFeQ0evJaVI?=
 =?us-ascii?Q?p/9vch0X3yw2NonJxnNh7oKYRhleqMk77vmjlu4VGmJEOFygg8KlBLquVnYc?=
 =?us-ascii?Q?KNs7BY3K0u/ChFOwEV/MzmxQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:15:55.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124674fc-ce6d-4384-2095-08dc6e6589a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

Add CPU ID checking in case the driver attempt to load on systems where
CPPC functionality is unavailable. And the warning message will not
be showed if CPPC is not supported.

It will also print debug message if the CPU has no CPPC support that
helps to debug the driver loading failure issue.

Closes: https://lore.kernel.org/linux-pm/CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com/T/#t
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index be7f2d3c86b6..cb766c061c86 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1687,6 +1687,20 @@ static int __init amd_pstate_set_driver(int mode_idx)
 	return -EINVAL;
 }
 
+/**
+ * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
+ * show the debug message that helps to check if the CPU has CPPC support for loading issue.
+ */
+static bool amd_cppc_supported(void)
+{
+	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
+		pr_debug_once("CPPC feature is not supported by the processor\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int __init amd_pstate_init(void)
 {
 	struct device *dev_root;
@@ -1695,6 +1709,11 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
+	/* show debug message only if CPPC is not supported */
+	if (!amd_cppc_supported())
+		return -EOPNOTSUPP;
+
+	/* show warning message when BIOS broken or ACPI disabled */
 	if (!acpi_cpc_valid()) {
 		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
 		return -ENODEV;
-- 
2.34.1



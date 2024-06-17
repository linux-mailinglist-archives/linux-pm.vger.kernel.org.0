Return-Path: <linux-pm+bounces-9283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933890A64D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DDB280C58
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7818FC8B;
	Mon, 17 Jun 2024 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TBJN2Fdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05118F2F1;
	Mon, 17 Jun 2024 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607635; cv=fail; b=I/79eymizBDvYoMsOCCCahLskTU59RBY8s3NXPxf5wpvKQuiA2Zw03mR4sCGU8hv8lwpAgB7VwA1xoaH1id50c9IVMZYnIswwk/fuRgZHEXtbgltN4Sy6mtn2fw7+8jkr6xJfBv3lDxes+ZJnqMylUUCFJ0LwcnJbZlSbxHxnMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607635; c=relaxed/simple;
	bh=EctfehHDJedEbtZjxHIa4xGb6TD1KwnMHqOe1jj80cY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pU2VyzN94WFpyorhgB5Aiy1PJfC85l+2ujAAH9GbwATG/4cX5JvExIxJM6Wduyhz6z7Z1+z4fvXGwfzeq5myO2265OwisjTIgSlgE/gYjMQ9beny0MKy/ehHZdWEc/vFQQeen7tvZQnWPxS4gtgE2pJs43Nv+0iXo35IhpYzc7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TBJN2Fdp; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrSpd7oqSpatN+/zSUyNew/K9efdDoZOsk1qm1OAukc7/NABPi0tvrmVBvjcu8xf0V412EByqrNCSZvh7kgHlDG1RaGIy9i6lcfaQ8geiPmJSKqeatYUqtgseKc4HbMts43eijZ2hF0S16xSBWMZGAh4R0F17TIiZwVeQMHUpvZuMwJrrOf0dhcUDSEToqmFJQu36kWKLMFneDjquZLvuyhoZHwCrO40+CTJFC9SrFxS4hgOwiXlew0unJnoKA7o67EMjSb5z0ut6XSsQVSMZ3wSRO7uveyy2gssZ0AYl2BDkrH3kBZuH5hvypZOip1PWuqVfGSD077OLptgGtzLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDjUagZXRuibwtXVkk706LAeXHLwjoS9T2WCRChvabs=;
 b=AEX44KayuRJGerlkk2TWWnuyEVMMmMtS4rjBEVAwX5LvBN95GJGVhCHBiquyEbOWT12FRDpZ+XclkRBgzG+MBXPFqGHqMfKtUqn4Cx+7UoD1jsYoIECqHMqnSNGsa8sbg6RF184aOvR0fQrLc0hMHQCgFYFQVStU4lHN+1O2x0qE0cjsBF4JF7s++h18SNSs7/iECyrjJwRkV0yBNU/3mIBe3mFjlGuOhCvpJiF5HSFgt1L3XeDIqdA8ECGsVrvCeRHAmuSqtzNA6EVLufV6kjRNVAAvQTUqnferGuL+dU5JtkQ6zyeD/9mhLdBSYaaQ3VrJfNvn5sTEnDCXqC2Lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDjUagZXRuibwtXVkk706LAeXHLwjoS9T2WCRChvabs=;
 b=TBJN2FdpvbORaE0UhzMUWv64Vqdd54GS2cwUjKVQE74mbYS5w68ch0pgtJdIFMBD+zlG5cB+ht9pCgllGVTnuLXsSl0TqF78tP5M4Pk+OEVsXEyhAQ1SrUX0ZGjfMJmSACmNFqEqSafR1M02mVxIZItnqi6gpQcQBoH2D3PMGg0=
Received: from DM6PR08CA0002.namprd08.prod.outlook.com (2603:10b6:5:80::15) by
 IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Mon, 17 Jun 2024 07:00:28 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::f) by DM6PR08CA0002.outlook.office365.com
 (2603:10b6:5:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:28 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:24 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 04/11] cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS
Date: Mon, 17 Jun 2024 14:59:06 +0800
Message-ID: <2f5dc55e0537b089e1f4d31914c0b5c5c12792ac.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3604f03a-38d4-4639-a1ff-08dc8e9b2ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wk1vxIxHSm6S9f5QEj4lFpDv9+3S1D2gUR3FRO5dZRJCbWG4z4D54iH5U3lv?=
 =?us-ascii?Q?lunoj6Cf59WRPYgXTG1ZYre13phX2RJNSJ2fz2S1TIOSpZWf23SivBqf3WUL?=
 =?us-ascii?Q?ah2NueFVdgaMN55cNqj854+7HoVF1ICU0VvKt/se2AiC/RmFQ07wMBA3Q5FZ?=
 =?us-ascii?Q?ZEZ7deB/w7UKl1cDHp5vmweTlYI+s+ff5QPbWaUqC2dgEZANygGh+1IqSe3r?=
 =?us-ascii?Q?iMTeu1dLilO6WFYdAg2UaooEhZj/Y3rFm1X911cpnhlPyiRn5A+b/EQ0NVYC?=
 =?us-ascii?Q?w9Py5JSa9mGKVo0IUD2iYaZjpinDCA8J8gqV4wjDiWU0IHExBWlk9b9YcJWx?=
 =?us-ascii?Q?ZZu2oqNkEriV7SVcM5l6LWqZ+CdeX9wirQCbDq5+2CwnsOdnrn5astmPcVqW?=
 =?us-ascii?Q?VE74GvcpwhXoMzQ4p/6lXYyKbJQHAApoKEHhZm+iSAwr7vxIQ0kkeOqGIPIt?=
 =?us-ascii?Q?7WpTZm7gBb1DH0XYWGBcKJjp/skywB7csQwg+0pIwYAhR/au70TVVm4Gd5QR?=
 =?us-ascii?Q?o9opJzwu9yNJozQkrzMOaU+6Qe1wrXkQ4VR+LMkqW4eT4mmWnTuek7Le3G1x?=
 =?us-ascii?Q?5kpmu8Ta1UIM8OkWgoT77HHNhrsTpn6MpCu5PtpQP5nZqgVt5u9wDB8aPuYC?=
 =?us-ascii?Q?6bmQkJX9wzdINebaG49177QlQCD/kE69vsUCizND3hINccpY4+eJkoLMLzbt?=
 =?us-ascii?Q?NhYH6sS5cJnxtppZVMTqf+sMnqW0LctBdmVuN2znBDxqdaPp0bnVDqN/ADEa?=
 =?us-ascii?Q?jD09QHUIGyvZzB8R37FfJi67jppV9uq5nxkIXlE1Z8AkFMpn7hsKDhSLTh4s?=
 =?us-ascii?Q?vC25En+7r3TXcoGZ4ZgatXdHsn5NdKQEesEsfBZwZ8q0zVlhKvMHuYJFKk5N?=
 =?us-ascii?Q?VAwEu4fvRha0IaSi+XEYctuVycR/ZLYCkqIZydDZKxgmTXWfBON5M9Mkgg/Y?=
 =?us-ascii?Q?mZuixIBZW8D9z2659wRbn8yRvYU6M+Lds6Y1LSM4tIdsZKP4Nz8lRnvfNZ5K?=
 =?us-ascii?Q?XuaN1RRdB7XsqZ6yQs3KkufWWvDUoSbyqteDaOorIxuJU0TX1Ss0+HNJUGUP?=
 =?us-ascii?Q?iYbpUCf0qCIrhpPO9vcTvDqbDC5cTK7TYXSJoSPqEiA8ld4ydwqV/I0LKmVZ?=
 =?us-ascii?Q?euyxk4+SwQaBWXTb3MH/egboZqf+Zkm3jdbI5R6m8dzKQUepPtIRG7rSlu15?=
 =?us-ascii?Q?YCB1o+XDDWTNKGO0ZV2dq/xn4ZRTudeBx/2E/8d7+zVESz8bI3Qc+j+ZFZ3f?=
 =?us-ascii?Q?LznHiRRahxJvvVKUsV+lwicSBMZjQoYzNjC8MpVRlRhMOFEsnl9krIYggP8A?=
 =?us-ascii?Q?u8BTNRmItb29ugAEhS+leag0CrAYejUZdRwZegiHm1wEFES5VS8JooqVZKzm?=
 =?us-ascii?Q?Zx1C3aE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:28.1958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3604f03a-38d4-4639-a1ff-08dc8e9b2ba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

If CPPC feature is supported by the CPU however the CPUID flag bit is not
set by SBIOS, the `amd_pstate` will be failed to load while system
booting.
So adding one more debug message to inform user to check the SBIOS setting,
The change also can help maintainers to debug why amd_pstate driver failed
to be loaded at system booting if the processor support CPPC.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 76419762c04f..9aa220a0e3fe 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1749,11 +1749,37 @@ static int __init amd_pstate_set_driver(int mode_idx)
  */
 static bool amd_cppc_supported(void)
 {
+	struct cpuinfo_x86 *c = &cpu_data(0);
+	bool warn = false;
+
 	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
 		pr_debug_once("CPPC feature is not supported by the processor\n");
 		return false;
 	}
 
+	/*
+	 * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
+	 * the AMD Pstate driver may not function correctly.
+	 * Check the CPPC flag and display a warning message if the platform supports CPPC.
+	 * Note: below checking code will not abort the driver registeration process because of
+	 * the code is added for debugging purposes.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
+			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
+				warn = true;
+		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
+			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) ||
+					(c->x86_model > 0x40 && c->x86_model < 0xaf))
+				warn = true;
+		} else if (cpu_feature_enabled(X86_FEATURE_ZEN5)) {
+			warn = true;
+		}
+	}
+
+	if (warn)
+		pr_warn_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
+					"Please enable it if your BIOS has the CPPC option.\n");
 	return true;
 }
 
-- 
2.34.1



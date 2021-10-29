Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC70D43FD04
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhJ2NHY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:24 -0400
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:22481
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231696AbhJ2NHE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daF0yDI3K6KT5taTu5+ZTH1voCqePU96GGPk/nl5kZ+QXRnyajusJJoYGSDyhxW0xhi1dGiufRp5Xc3hBVtLUpCsZFvDrwtRSnX7V40encZLWR13Wlnhee4mNc5Pfh5xOP9Z6StE8vULRPMx7UK72N473pIoJWs4uBydwYcJZ6rcRX4kaFK+Jk0UnlE0xRn+qCXNAVWskn620P7SMf9FQwHKH4qhMNt2byz0dSAbbeRTDBVzv8KmG4P/XJw2qS+aNirdDKaeGKk/UculhrKp78iOMA35ToXdAhl8dtopOLuwMFNCOSBCTci+7ylXMUs+JG397Kr9Mj6tzVm4+kSyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggtBMGzJNT0gf1w54AjpMAmINQmo2vLf+BXHb6ym2hY=;
 b=FaDti8Zd4Pu32cG1G46+fi8y1jAcIg5o6zYpvyHr4U/yo/mOZZnjpdHljXy5GrQ6GVV4f0mqRDcBGqmQu1tR5rbWC8SoldgBZW2/C44HRrdcyX7ChtvbX4VigiFx0w6NMcfsayLy/CJoZQ3UTrZix+Y0t319BIQiGNq/ncFkysu+EAizFGXUurBxCKq4l4LU3L9ggsAgYtbiNP5L5uh+1JHA5enycJ2D0iC58S4l0oM8zO/ebMJe94n/os6BL71d9HZEjSOP2PV16KDvix9wcLVb31HWvM9vesjJ76+hw//usgBFTw6ny4cVVfgrbKpLdIkbkhWlOAxOo5v7EP+oOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggtBMGzJNT0gf1w54AjpMAmINQmo2vLf+BXHb6ym2hY=;
 b=XSfFBm4BFWesD3LxX8q6up+PYNVJqAJ2hqcBDEy0dqRWJyFJHFOLT6cGVK66hxAmvfff652GdQEuXSg+xsUj/6DWGUg/HkRwW//m+EvQYdDSYYkDhAZVWtGmwojJgDsv2bvJYx9fkTJP1ed+Od+AfCgoBngvdGdUQh0c13bKGg8=
Received: from BN9PR03CA0694.namprd03.prod.outlook.com (2603:10b6:408:ef::9)
 by BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 13:04:31 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::f9) by BN9PR03CA0694.outlook.office365.com
 (2603:10b6:408:ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:31 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:27 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v3 15/21] cpupower: initial AMD P-state capability
Date:   Fri, 29 Oct 2021 21:02:35 +0800
Message-ID: <20211029130241.1984459-16-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 409315bb-6dcd-404e-4e9e-08d99adca5df
X-MS-TrafficTypeDiagnostic: BYAPR12MB3416:
X-Microsoft-Antispam-PRVS: <BYAPR12MB34164C492F304B813B578C2AEC879@BYAPR12MB3416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KX87V7XPuk4VrsfLu0QNYojgtR0/Xp42HluNTQJa3JcmKn/18yeXS25ZcNcLSAbUaj+cX6ZIhht1GaOvqVDDZZ2ZA2ez7IcNE16UhREXka0pu/a/YL4wq6OCEauzE8vufLAGMOqdBiNKqlW7ehf9ASZhdlD3wQfxg1Cs/SblXPZ8IKYm+MGtxhFfL3gFpn+tIRTNU16jqkqZ1pKlg/e6CbZjOF9T++BtECKd4Lc49hDv+G+e3oynXSka9KTn+8he4GXaSFP+pYdtsQBSP0NoDGJCeYi6irwyG0yV08ARuhbNQKnLJKdRqZ2kabLmtPG4Or864qEHtzJaR/VCj9KV74KdoG3OqKYpJ75i7T1JTPqciYi94VuPfhyAq4ohW1WhgZgyY41Lphffsuj5v89IbZ4qR6SvJh2UqYarvnK+m06xxxfP7lAhb6kGHH3g5C7JsfM7P3U1MsGNWcDM4PCHKK14iWxeiu+w0ORIPSNd/OlKy8ww4TETlVzxCMvg7dwSLW5iY+c4m4f0clFHNTGP5GKvksQaWJvNjcySJYt2MVXy3PaelZeKogOe6Y1ThEz7yp+kYXOxDQ8ev8I9b/8QDi15SmyKgOzt5ORt3A0UNrGMqht4s9iEmstZfoxnB1ENxa+XqB2LfhdtEUGK3zTYyj57Nf+8mAjfWDMbaRdQ0822GHDG54/nVTi4v2S5W4tvvFuw2slFajnNsvAd+FSbntPbfuh0V2N/FfM3kSLRzM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(186003)(54906003)(4326008)(356005)(7696005)(7416002)(82310400003)(8676002)(81166007)(1076003)(2616005)(110136005)(426003)(70206006)(336012)(26005)(70586007)(5660300002)(16526019)(36860700001)(6666004)(47076005)(316002)(36756003)(2906002)(86362001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:31.5224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409315bb-6dcd-404e-4e9e-08d99adca5df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3416
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If kernel starts the amd-pstate module, the cpupower will initial the
capability flag as CPUPOWER_CAP_AMD_PSTATE. And once amd-pstate
capability is set, it won't need to set legacy ACPI relative
capabilities anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 72eb43593180..2a6dc104e76b 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -149,6 +149,19 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
 			cpu_info->caps |= CPUPOWER_CAP_AMD_RDPRU;
+
+		if (cpupower_amd_pstate_enabled()) {
+			cpu_info->caps |= CPUPOWER_CAP_AMD_PSTATE;
+
+			/*
+			 * If AMD P-state is enabled, the firmware will treat
+			 * AMD P-state function as high priority.
+			 */
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB_MSR;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_HW_PSTATE;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_PSTATEDEF;
+		}
 	}
 
 	if (cpu_info->vendor == X86_VENDOR_INTEL) {
-- 
2.25.1


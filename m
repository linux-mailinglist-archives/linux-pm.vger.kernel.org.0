Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D134187C6
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhIZJJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:20 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:6241
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230498AbhIZJJC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:09:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax9+cN5O7gBdX8ygEnbQEByXoEBjKWS72BGmQfAPvv+4+WKee3pjvwpv1Zh1LIqn8rkUW8G/WAjwlJ/m0URtAWC7FScw76r+6XrKCsnck4QRbqy0Gtwy6dQZh3nWyLpsSlSr+SsAjHAT2pW7icvmWHcPATDzm+sWkDGYFhasXsfTVGRWKcrKBZhjyuQkSLC128Oh09d3qaB/HVqBMxcJzBwnn/Anbo4EGLVG1dy+Iv/rMLJBtTU3MexM8KzfQRR1i42OwTnnUNs0kgq+xBmzk9xmhr99/Kuxa2g6xjEMIbZzOy4ey/CVZYParyNVN6QUkeKoCPalCQp32qZd6dcosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ggtBMGzJNT0gf1w54AjpMAmINQmo2vLf+BXHb6ym2hY=;
 b=VDK3K3YVB6Is/EhcIGsHgrIMLfgH6ULgAav9kwaBy+aoCXldO79nvWsmDjNh8ZZyeGBovKnNdLt5ZXjo02rdwGfufor5uc7SeP/ocr2XDQoLwJPMz8JnFF8WkdfWAouUSNUj81bCIUw39iMhBWyAS3TkwWU5I1UHD2Q97xpXyb2yWbLm1K0opuB0dApmFLK0T/nyxJdsMBlk2uBg5SSayl3ChVmCZknuPNiDT3Qkc8bcPKa5xR6jfKMwWrrqPtFr+2aGDKAOc4dEWhjFft5NVt2C91IQ0iTsTTZ0fe/3DNojnXWi6ayMxzqV7CfgcVa5PP/EV8J1Z4vBZVWmhQ8xNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggtBMGzJNT0gf1w54AjpMAmINQmo2vLf+BXHb6ym2hY=;
 b=ZF0aPzeRarReXgwBw8MVoriK61y6K0iCHhTg1RD1170qYtCWCm95xntBrSgV+MIpDW+P8sK7z1EVPD41xvtNpE93MJm2Q8tKnBoriRx71vDqXRk1nk6OFHP8Y6GFNmbLQu87CNEWMugUpnFgcuZS8k2A9fzdrGvliNR3ugZr3Uc=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sun, 26 Sep
 2021 09:07:21 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::d6) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:21 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:16 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 15/21] cpupower: initial AMD P-state capability
Date:   Sun, 26 Sep 2021 17:05:59 +0800
Message-ID: <20210926090605.3556134-16-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926090605.3556134-1-ray.huang@amd.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed99ba16-ba28-462a-b3d0-08d980cd0c50
X-MS-TrafficTypeDiagnostic: DM5PR12MB2581:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2581F0FCC73235BF96F2F197ECA69@DM5PR12MB2581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /njLqZfEqZvQxcki4HSeMTBROVUg2lvJ62OooUVKmf2rr7hTcAq72BshDFMHEtCdnDliv4IyFQ4zaVyTEkr2NrYBHVrlTM6RIaUWF+5C4Kb7nyBDPeN7kXtAiKISyKSxZYsdvjCSAApU7E2QiI7oKr562dWN3Sc7i6WGRIOC9xShZfpVeRyzEB6TFogrmgwoRf8kLGNn7nmnr11UxBaSVBZ/e/4LtA5u+ClYK2i0/9VFA2FRQJVgsjKyasHMtK7cht9TOhgqbV4znSE79TbBawRFxUTJYcX4QBq5KyjGbrlYHdQoftzjMfHd2blyV8BPhhyE/ZlkhYAhP9CprwnfiS5HaPCIweomPC05mdbQqQFq2j7VoHMr3bgnyZRlDMHWwnIwHumDqVarMxEejxma9UyL9gayz8ldmIlorJGXd/fbkILywYk4UEVeCw4PbUQIpykHB3XuE9dQVf6T0C1KsxY962kIKOeVHPJ/TbrZAD+JEDNaIxMb+6O3jerl8COCVFOEaudNrbRTIcBBJEE1GO/A1ZcRBICP6uoCNHnBIUHg6YUEK/nxMNi7hERpQYVmqNipISCwqQKfX8q288wUytMbbZgZoBQ70pKcuwWrUwQeFWA7wWI+IsNElgdlDYhRSExIwBk3OoedRuYsCCR8iRBn0S+/PgcGbPMJVAFHlZPHFkg1oNnIc11yK882asYHq9/gyIl99W8GbBiTmh1VURKOZViEheMtjQdJLFJVKC0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(70206006)(47076005)(70586007)(356005)(6666004)(110136005)(2906002)(4326008)(316002)(54906003)(5660300002)(186003)(36860700001)(8936002)(7696005)(2616005)(16526019)(426003)(336012)(8676002)(81166007)(86362001)(82310400003)(26005)(1076003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:21.1283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99ba16-ba28-462a-b3d0-08d980cd0c50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
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


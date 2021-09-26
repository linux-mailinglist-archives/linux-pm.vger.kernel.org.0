Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288B14187C8
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhIZJJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:24 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:33025
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230484AbhIZJJJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heAR5zChVRzTrCtHg/81B+gCMyQ4TMqhsHmTdFOMpz0I1owPy6n3pcl6GVhla4inBOwYpEePIRcHWAfvu9VMTf8QRWOZnnbpfdsmbMQzctTFQIkM8MZNXi0+7O9d17irMJL8kTQyrqN33+9vChwWlbKVAIb6UlJO0ey5d912932+dGMzydsYUiUTUYvMYlMtNM81rQFUBF6tNjKpveLJyRyn/e3jErPJTeqNVgk9w8R4lhNUj/ROZ6f2/1/VdNmMe/abDkR8TBM2xUtwbSnZLgv/smWg3on9kgHTn7g8KwdA6fQee+7i+03wT3GEnovk4eO/zcG6TAD4HFQC+HE4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Iowkk08eetJNR5QtU/ESfafsDTNErY/Mo4CSEHY/CnI=;
 b=dkPf0Jq86kCxPMj6a6hWa+hO0upwTiGh5IGVmPDg9yHZnOL1O91B7QgIAeSHO9HpOf3WScr1z6WgGf11XfdiEgzsWMtx/RX0Uip7NBoufLBhSfqrczuXLmPLrA/E8fsrpUy83YsmrMx6YUTN0AIBMaj+l7mDkqkJaG394SlKNomgOBMYsm1WbxQ9BdidnsWIrvuvILf3OnNFTKevoB3PAHNO5on69PVI4gfrMHLbdADwXjmXd+DirndTdWDjFFMTapx40rJAp2gAYWF+e98S3eSIQJVh36PM5KRF1zObQBYOTOUiq6L39A2ew0OMwmrNJB9Arc3/GSleeW10VUW8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iowkk08eetJNR5QtU/ESfafsDTNErY/Mo4CSEHY/CnI=;
 b=aWoy1fcKFhO9c29q8WF5VP+f7919CaKgYAb8zhueHG404LvOuP3VdTgoIUTDrHsJUtutZ99Cf/wOjbRST+Qa8fcaS7y66NQv/x2YdJ2MIEKVHdTlbLUKv7hGyC3enTKB3rfuaCnVTvTOc40m7t3mfOGZ2vkOVeOq6e1f9PLrMBU=
Received: from MWHPR22CA0068.namprd22.prod.outlook.com (2603:10b6:300:12a::30)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Sun, 26 Sep
 2021 09:07:30 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::57) by MWHPR22CA0068.outlook.office365.com
 (2603:10b6:300:12a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:29 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:24 -0500
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
Subject: [PATCH v2 17/21] cpupower: add amd-pstate sysfs definition and access helper
Date:   Sun, 26 Sep 2021 17:06:01 +0800
Message-ID: <20210926090605.3556134-18-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a07badff-10b2-476e-27c1-08d980cd114b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4306102201A79321C326278DECA69@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Qzezu2GmZ0twf+W2Eo7PNVQshJAdV5K/EUCwqK18tccBQLg/nIU/GkmArzPgu8X724/oSWjwhCOpoWM57k0EsJD4fuPWsvtAbxWedVO/C84Ss3SxLrf8Wd8gI9i6ZrPnh4+ZrCuoFX9Vmj19erohr25sXKZnSCZDiHq3ktpu2r2zQwNcvZzj8Hh8Xm8Ic1DYEC5D/lCtjmnTpHIr21niW3Y3bCv6tX3ziWyRg/8nGkO1uc0M4xJJzM5nZJT7jLHZ9BT9y4PQIdtmhIXEceRYD5Eu3VUwHE0xGjGI3XzqAO1mBdN5CxywCaBpRL3ef0STf9PLhaIeSuWIK5UKWxN4Vd9AaeYLglVtmGbZXDq6zRyNlxF9PmSg6bnc/nv4fdv1RbIabnOF2c/lZxOLCWhtjNzJMR5kdanfIZjESEJQOz3oBGlm4kju1DNEHumAyHB7ajKlItNymRVF05LTXXMLnBuPqbX0VvWECDBzVshdlv0kJbXiPb5ACCpO9aA+8NwMrapHadQ7dG6HoMjuycXs5HgoPb40OQi9d6OlTEP5zo1bcDdKaQ3L7rM+Ve7/X94D9NX8RR91q12tRgEFr3zxL1S9w96a7wqfZZ67f9rkeom2gXIchY1pLS0xXhQXJq0pfMxSS+DFmA9+zye6e7LEQv8Rn0MuWAMe0tdKypXM9Awz3WAa6Tsq5mw0dlOxEbacvgEDb4emm/fHlxUu7GmXxYSkl19W9AhhlsgQUEksAU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70586007)(70206006)(81166007)(36756003)(2906002)(5660300002)(7696005)(356005)(82310400003)(508600001)(26005)(8936002)(110136005)(8676002)(2616005)(336012)(426003)(6666004)(86362001)(16526019)(47076005)(186003)(83380400001)(4326008)(1076003)(36860700001)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:29.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07badff-10b2-476e-27c1-08d980cd114b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the marco definitions and access helper function for
amd-pstate sysfs interfaces such as each performance goals and frequency
levels in amd helper file. They will be used to read the sysfs attribute
from amd-pstate cpufreq driver for cpupower utilities.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 97f2c857048e..b953277215c0 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -8,7 +8,9 @@
 #include <pci/pci.h>
 
 #include "helpers/helpers.h"
+#include "cpufreq.h"
 
+/* ACPI P-States Helper Functions for AMD Processors ***************/
 #define MSR_AMD_PSTATE_STATUS	0xc0010063
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
@@ -146,4 +148,41 @@ int amd_pci_get_num_boost_states(int *active, int *states)
 	pci_cleanup(pci_acc);
 	return 0;
 }
+
+/* ACPI P-States Helper Functions for AMD Processors ***************/
+
+/* AMD P-States Helper Functions ***************/
+enum amd_pstate_value {
+	AMD_PSTATE_HIGHEST_PERF,
+	AMD_PSTATE_NOMINAL_PERF,
+	AMD_PSTATE_LOWEST_NONLINEAR_PERF,
+	AMD_PSTATE_LOWEST_PERF,
+	AMD_PSTATE_MAX_FREQ,
+	AMD_PSTATE_NOMINAL_FREQ,
+	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
+	AMD_PSTATE_MIN_FREQ,
+	MAX_AMD_PSTATE_VALUE_READ_FILES
+};
+
+static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
+	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
+	[AMD_PSTATE_NOMINAL_PERF] = "amd_pstate_nominal_perf",
+	[AMD_PSTATE_LOWEST_NONLINEAR_PERF] = "amd_pstate_lowest_nonlinear_perf",
+	[AMD_PSTATE_LOWEST_PERF] = "amd_pstate_lowest_perf",
+	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
+	[AMD_PSTATE_NOMINAL_FREQ] = "amd_pstate_nominal_freq",
+	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
+	[AMD_PSTATE_MIN_FREQ] = "amd_pstate_min_freq"
+};
+
+static unsigned long amd_pstate_get_data(unsigned int cpu,
+					 enum amd_pstate_value value)
+{
+	return cpufreq_get_sysfs_value_from_table(cpu,
+						  amd_pstate_value_files,
+						  value,
+						  MAX_AMD_PSTATE_VALUE_READ_FILES);
+}
+
+/* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600C1456D92
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhKSKgK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:36:10 -0500
Received: from mail-dm6nam08on2081.outbound.protection.outlook.com ([40.107.102.81]:11233
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232301AbhKSKgI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:36:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR7Gc5WMkZZMXmY9o2ta020IjQ6d18xABYQA27no6BxtP5eEn4G7cqUwVPJfrCLjbVxnHuV4RbJ45DQ9eQvjkTROeiI1jAN1suOYiSDqluEoVEsEF40MaeEE9SRh/aHI7hfEvuxP07qtAJ2dto7feO8rx3YnsM7lOJU2cxFYe8ZT6WL+o3qOffiScg4acLKHb5RE3zsrs9PzKKq775yYOKw/M49Ln2xo8u9qyg2m76YG2MM9fgrqXgOUAkwtF2/MA3dwmX/9P5jbsTGkJKBhOL0nrEA4iB43tFxbQQ+gnm74UOT9GbsvjJkpWSYAHraNkMMK7l2QLhrpYYPO+PA+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu3SrDgaX6m4px0wjGMTsorM326powF56ZcWTWjHoWA=;
 b=JAqJxt8Bhj/LINo2O4WJWCY/eej/rf4NHvw2id1BLRoLS+yL/ZxvTE6WM3IxXd+pfBa/nYT+XkvGORljJqYWg3K2iaupMB6COrekwdoLLeiaG5B0GjO/dZ10eQLjRSVi9t6sWg/eCWG7ZiosJrbpF0nWaQ/VSzPfc67WESaSP5sA7hkOaJ8QAN/sUuNxctRggV9yZzBdJrAGh6uJld/eVv4/9ddpZjvnJN5zZUoen8oWdRMlMUaX/k0wxHNiuXBClGTg+qrWmpJPwlBgTgZt9BTmu/4zemzP7s6IrVj6wTzBKemLO3cyKlVgTFjfqZnBylBQ+iCjoOIFL1dke8mltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu3SrDgaX6m4px0wjGMTsorM326powF56ZcWTWjHoWA=;
 b=zoNXZ7VYp1P1Qs9lETouwsrfp2GjTX/QFm5NHx6Yn/RzeR7Xd3gOSujQwzd8KGYfYqHlE7vfaHR45wIRbQsGqh3nprUJ8lK6aXjZI3sapypAEMC3BNtKTdlkl++AUbXXKTfumLI4ruObKw0+sCtPPWI0i++4WADH1pS4vLVqqbw=
Received: from DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 10:33:04 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::d0) by DS7PR03CA0066.outlook.office365.com
 (2603:10b6:5:3bb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 10:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:33:03 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:56 -0600
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
Subject: [PATCH v4 18/22] cpupower: add amd-pstate sysfs definition and access helper
Date:   Fri, 19 Nov 2021 18:30:58 +0800
Message-ID: <20211119103102.88124-19-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119103102.88124-1-ray.huang@amd.com>
References: <20211119103102.88124-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f15f1cb-bdb0-43e1-c7e9-08d9ab47f784
X-MS-TrafficTypeDiagnostic: MW3PR12MB4475:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4475EB4F419121EFE8F2C7BBEC9C9@MW3PR12MB4475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kq3l2SE8bj/fVFAXFFXWCY508qoCFBlSEzYMHHITVUivMZm7+P3gB1RD9Sfk91S/TWe9Spmjxwh/iO72721bTPvgGdnEJ4uSQ/DK/juDXKVuejMeDYsHlFQzgiAdrrDAbn1zjPAEqM93Rypsr522CaO8u0jTJY/ZdcMw3gfocA9JM289khboZE9MvzSa7HEjtAu/WA2nGKnYsFPo57kiRtQUMEXDWnTj2+t167a0taYvqtxTrpGeKKgfNf0Zs1iZlp6+MTk8HXjxjThcZwTSVKVM9CKfHc7/OKhYQkdO5g2CvHPKv3H1QfngjKDeFNz/X+5Ve23aJ8xZY+Nw0oQJLm7nL4wTIxV614lnE2sDBtq58JadUyM5IISKEwFTraehuhEIqVq2yUZU9isS2sr4PSMJE5ugrlUHutyoikMQtehjbjVGsjp4r3aI5KIFGuQU4I3llX02bmPzZR15xbjwJe35nlOGVbQn4griFU/MTCtRykz8+Dd5Hp9Y5XcA0AU1+JYZzBcjiWq5PSEGOSreY6IMBXVwAgrYekntacXWKLB2bQhTwCytq3MfnXyZEKqnrhQ1GRLOvcsQ4BSLlbb5ITbrDChPz6u0NFmmABL6nBeeB3yz5+8AP9BVcGEdbXIL8/VKRWdwlv9WLJxD0JcqmROUKsnbn0/LRweM9/Xe+IFGeFc1tnXt0aY8kxFgTfHNoV0LVc+6SwPF5jeF7Tz9SLSvguPX/RkOip71YP+1KxY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(70586007)(1076003)(81166007)(83380400001)(356005)(186003)(70206006)(36860700001)(336012)(47076005)(2906002)(86362001)(2616005)(7416002)(508600001)(16526019)(7696005)(8936002)(82310400003)(316002)(54906003)(110136005)(5660300002)(26005)(8676002)(36756003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:33:03.2458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f15f1cb-bdb0-43e1-c7e9-08d9ab47f784
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the marco definitions and access helper function for
amd-pstate sysfs interfaces such as each performance goals and frequency
levels in amd helper file. They will be used to read the sysfs attribute
from amd-pstate cpufreq driver for cpupower utilities.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 97f2c857048e..14c658daba4b 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -8,7 +8,10 @@
 #include <pci/pci.h>
 
 #include "helpers/helpers.h"
+#include "cpufreq.h"
+#include "acpi_cppc.h"
 
+/* ACPI P-States Helper Functions for AMD Processors ***************/
 #define MSR_AMD_PSTATE_STATUS	0xc0010063
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
@@ -146,4 +149,31 @@ int amd_pci_get_num_boost_states(int *active, int *states)
 	pci_cleanup(pci_acc);
 	return 0;
 }
+
+/* ACPI P-States Helper Functions for AMD Processors ***************/
+
+/* AMD P-States Helper Functions ***************/
+enum amd_pstate_value {
+	AMD_PSTATE_HIGHEST_PERF,
+	AMD_PSTATE_MAX_FREQ,
+	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
+	MAX_AMD_PSTATE_VALUE_READ_FILES,
+};
+
+static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
+	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
+	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
+	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
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


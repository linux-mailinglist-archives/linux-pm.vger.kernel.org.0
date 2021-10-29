Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99A443FD03
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhJ2NHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:23 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:18555
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231754AbhJ2NHE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRqq7aljMENnYHcT96vpMloKg+NHG0I+/qYnXBg0NiRqQVaomQ0prDXefWhC6cDT9ZjEHRdaF67ERo50SFmt7LkFDpjsYfdeqLe0Uxpy7z3B+hiwIa82/9SiRaS0X2P+BhPwQ7JnYXdYltLdhHjmM6ckjYgxYEAr+ZtbDh9vbVtZrfPoUZuLLxVkdaivLmpB94TClW3d07jokj9hnwGXzJys5YwjU0mS2DqDw7Bw/bupWBvs2LptssTisYPLZczmBHjddP0NK5GyHrHlxoVk8+ZYLTMSIt6SEDqUtTrV/gGI5rK4AN7B78+PkflEb9F8BKFtsZrE9HW2yBphFBfSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcWX6wnAZ9kKR3lnWrFfRGLYbt7fR1JVVSvMwIGnjnk=;
 b=AFyB/T0mF5D69A5YrMlWFITJSu+PUVNreXGusUKDOB80kYEoW5uKLZKE4gcUEIr0gKwigQCWtEWwJwtIkx3fW6Ow75nuLG71KhT5SCxHAfCTNVAXG/T4KznkmCGgtvqr355HcGewvy/HDhIqHfSVF4sLd1FkU89JgOnDhhx5umzXQcBqoO5y4zFhpTuilqvCL3GQfcI9jDcHvt9jmN/JxZH5t3EOQxnmK6B5izkjXefVyGXrLs8gMFzWxJeUvGnBJijmujfhtcy+lUmt4w1/LDwywEcPUD5XU+T2bUmKl1ZEN8fEOgAfJvB/gXkd2ogzKlxjnOC4zKSs0lsaUgX5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcWX6wnAZ9kKR3lnWrFfRGLYbt7fR1JVVSvMwIGnjnk=;
 b=a2aBwqk4ZiHWMFGD3+OwiZKboQFTLvf+96/rL/8RB9PetPMZNPPfR17XZZhN1C0ZZwGyLMnNcxqn04RkjRNTULYa5gkQiXcsDnGnX5sUcLp7ybp3wGsAaQ4q4cMf5byzzCNukRLLi3OYdDixRpdrhfWuJln02/FxIpDscLD6oQU=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by CH2PR12MB3752.namprd12.prod.outlook.com (2603:10b6:610:15::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 13:04:29 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::ad) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:28 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:21 -0500
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
Subject: [PATCH v3 14/21] cpupower: add the function to check amd-pstate enabled
Date:   Fri, 29 Oct 2021 21:02:34 +0800
Message-ID: <20211029130241.1984459-15-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 879de70f-93ef-4899-76e6-08d99adca441
X-MS-TrafficTypeDiagnostic: CH2PR12MB3752:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3752B76FB893E58445D3E391EC879@CH2PR12MB3752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jCoTZZE23nNrso9hKFOuODE1OFJAsT2WcRzMvHINnom1bbDqpoxIJVJhuTsmIO5ai4dbJ8bZQmryJgmwZO33R1smZqOmCYtj4ZLR/P9SWi3uJzjwa3DtnQzbvSgr3VxyILWm2o+Ghyx/yWclWT0xqvG6MXX65iPrWP5/LUvFovUd2bWgD/oGIsX58dUjhHhFMcFlADU0qI/O9l3pIyI/vMjRraFP9MDIHFiUzvOslKReQoeHdhAYDym2pQvGPdtj68CCMdPptC1guo5GgIKKsylsKQb1er5c6yh2lHOvPWgB4RFdIr1343B+dTL6SsVe35KdXQyASJN0AaLrlqSeGHXm1/T1z5yqTxESp3tvV1d39lUCrZbUTOmDT5pnOE7EZPVHdsMqTfTM/iJov6rhspRMUsnR3QBsGpDYxTniBYzF0HtvCzUERGsm3/JVn1+/h9UmFBk8Rv7NVpyrqw5QlYBwrRGqvnaC0Ghmqw0/Q+VO37lAGDgIlYoxtbwB+27UUctIkZwfEl1uxRi/i4rwhUn24QQIckh1gYZ7Gm+O2Eig+gjuJlHpDbXeaoRT+x5Q/6G38AxgX5RbFNDmlSU6vwqPYSPaAquZ/e9FPr/V7ft34fiB+a/epZ3afR/JFXKuwFQHPcgP2si9w72Aqg/RhoJUY6feuojIuiypv1oHmisJy6euuHZxlcVTsCGJWQUQrNHy9G4eHBAmFNht9vn6nZNfkEZvbzvOvEsVDoTcjU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(36860700001)(7416002)(356005)(81166007)(1076003)(5660300002)(26005)(316002)(47076005)(2906002)(8676002)(6666004)(16526019)(2616005)(426003)(82310400003)(86362001)(186003)(110136005)(7696005)(8936002)(508600001)(336012)(36756003)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:28.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 879de70f-93ef-4899-76e6-08d99adca441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3752
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The processor with amd-pstate function also supports legacy ACPI
hardware P-States feature as well. Once driver sets amd-pstate eanbled,
the processor will respond the finer grain amd-pstate feature instead of
legacy ACPI P-States. So it introduces the cpupower_amd_pstate_enabled()
to check whether the current kernel enables amd-pstate or acpi-cpufreq
module.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/helpers.h | 10 ++++++++++
 tools/power/cpupower/utils/helpers/misc.c    | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index b4813efdfb00..e03cc97297aa 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -11,6 +11,7 @@
 
 #include <libintl.h>
 #include <locale.h>
+#include <stdbool.h>
 
 #include "helpers/bitmask.h"
 #include <cpupower.h>
@@ -136,6 +137,12 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
 
 extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 				     int *active, int * states);
+
+/* AMD P-States stuff **************************/
+extern bool cpupower_amd_pstate_enabled(void);
+
+/* AMD P-States stuff **************************/
+
 /*
  * CPUID functions returning a single datum
  */
@@ -168,6 +175,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 					    int *active, int * states)
 { return -1; }
 
+static inline bool cpupower_amd_pstate_enabled(void)
+{ return false; }
+
 /* cpuid and cpuinfo helpers  **************************/
 
 static inline unsigned int cpuid_eax(unsigned int op) { return 0; };
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..0c483cdefcc2 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -3,9 +3,11 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
+#include "cpufreq.h"
 
 #if defined(__i386__) || defined(__x86_64__)
 
@@ -83,6 +85,22 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 	return 0;
 }
 
+bool cpupower_amd_pstate_enabled(void)
+{
+	char *driver = cpufreq_get_driver(0);
+	bool ret = false;
+
+	if (!driver)
+		return ret;
+
+	if (!strcmp(driver, "amd-pstate"))
+		ret = true;
+
+	cpufreq_put_driver(driver);
+
+	return ret;
+}
+
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
 
 /* get_cpustate
-- 
2.25.1


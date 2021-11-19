Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0F456D8A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhKSKfu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:50 -0500
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:19553
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234862AbhKSKfr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBChoP5S0Vu2aXXa2CsrWpoYwYjWCQw3hQYEWLj/3S013UKPC4KqbgmtxohQhqu9TDwbtMPnOjmFE8YkNEcxY3WU0CwJrmfT5NxboEIPrVBAdecNVlm2WvMELeBQkzkr60VjgAA3BQJ/7QxxCa/EuKaz/5jDW6WTekFbBLjbU4cdxzE/tKhPljxi/mhJ+WOwh1Dzn1vgtMEEn32fxI0D92lW3U/iLpiUCt3910EzMjpVWIXyf3WhYZ8AxYDySE6RDsZUU1bdet7Diqg/NZUf2Fav5nNnyrEe9ec/axK+J4o6Qvf6cqkxgCrDqrfzjFdX5FodeF2vGvNWRTYnt9LPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcWX6wnAZ9kKR3lnWrFfRGLYbt7fR1JVVSvMwIGnjnk=;
 b=g6BAsuHhxrfIXZ3c7R5AYFr3yr4v6p6vMRubfAFG37slkqpwJ3q+IxV4gvcdg+3oYGfoWASFA4atYYiauhnuaVi3IEmb+rOm2e7PRF8Qcik0mGi23wCcSJ9vmuLDCodL601KfeihkwU9wntuIbidrShLqvroEIpMVrd/Bq6aEgQkSVEqppbqdEkGSyTjY15JYkOWJqt5kIsjuM1rQoVYNRqu+sY3WD2oKOOKk0diyUnNkqJiw7khH1wUIBhvpKSWWUl4CYr7ubo3okXC6fPNEN1OFJ+bQVoTomDr7fkYs2IOPWB/+e86kCNilzjyMyuSsRTcWh3pmgrPoi3lGEcQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcWX6wnAZ9kKR3lnWrFfRGLYbt7fR1JVVSvMwIGnjnk=;
 b=O+4b6JkKWWc5/M1VcRdSZwQ3b9MPewjc7gxh/HuXVBGFJcVenCVSIfbz2T2OhzZW6Ka8m9KIHFgj8JAL0I0G3cLLetXZQugTiRyC8iNCGPld+n7fns6bYUzx95x566oCHV9wZnyXg4+3xgL6hid02qZMiBVb19lcqfbt9n/bY4s=
Received: from DM5PR04CA0054.namprd04.prod.outlook.com (2603:10b6:3:ef::16) by
 CH2PR12MB3751.namprd12.prod.outlook.com (2603:10b6:610:25::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21; Fri, 19 Nov 2021 10:32:44 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::35) by DM5PR04CA0054.outlook.office365.com
 (2603:10b6:3:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:43 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:39 -0600
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
Subject: [PATCH v4 14/22] cpupower: add the function to check amd-pstate enabled
Date:   Fri, 19 Nov 2021 18:30:54 +0800
Message-ID: <20211119103102.88124-15-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26d55fde-5bc8-46da-31bb-08d9ab47ebfe
X-MS-TrafficTypeDiagnostic: CH2PR12MB3751:
X-Microsoft-Antispam-PRVS: <CH2PR12MB375101A873A305F29F59A7EFEC9C9@CH2PR12MB3751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZERZH3nwlZXCAs4DSbbJysBI6OdXMMMP/4OTb5CTuTHgBpbS0Mm5eDEWSDCEpS2eQak1CzhK9ka7wRAkL8VYjcPMi1FPBN1M/xgJrfqSN0OpDvQSiKUYvusDblXIFZnEHJ2BNTePnHCa3S9n7arXm6wzl4ukoDjJ0DeMNW/trd0q9TJTPv/U+qFYMyX68r9xgCz6f2AuyahIgSf0n1BN4ljfr9gAt/WTwJpkMo1T4udZfgHQ3qgbKlAnEMTXPHSeqgVwfvXQ7Hn4/lVuNsPGNaKwMFbEiTfcDuFqI+li7I2I4slOQeQaZZ/pw9id52J+bhC5COV1dc2Gab657TkDRrYtXpDRjh8Zg4WYArBH8RKSpp/ABJb8s3PF6kPKmj1q8meLvLnkASRrMYI8yzhudLTN/2SGTOnmrvpalni+uygdXVJW8VedWohKKMtZOww5GJjl04l7CFdgdXW8T9Lry4v/um+yc3bZ43u+cvBvXOQWuXLOGeskXGJxyd4xN5fP+PVPqk3a+VTzhNiYdaGVIYVemhfhfg1eTncX68KcOB0tsvvT4p+XuX1kjjfMtKMf0vuYrMGmnIb6xlzoJ3brRiwV5C9nA+nk3Fng/NJtkhk7nsuvzR1NarXGPayG6Cf2A359cwVeBRGwUyw1GSNzRFLmbcH1dTgPNUlUL/oK8rmTBq+5FCjm8ViAO5P+8bE3G5kNoQX1lktlBVp7uTcVcTwUUOFB9D5QaiRn5LyYT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(7696005)(26005)(4326008)(36756003)(70206006)(8676002)(16526019)(186003)(8936002)(82310400003)(110136005)(36860700001)(2906002)(86362001)(5660300002)(316002)(2616005)(356005)(47076005)(1076003)(336012)(426003)(54906003)(7416002)(6666004)(70586007)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:43.9118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d55fde-5bc8-46da-31bb-08d9ab47ebfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3751
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


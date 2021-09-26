Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652F34187C3
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhIZJJG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:06 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:34848
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231129AbhIZJI4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+8YQ/jyY68Bl9YXzjc2NW/JLu3wwVmCH8NiBzUhpFd63jo3AN6OijCXYnQPnam+w96qsQGg6Upvhuo2jwN3rnuhnYMRWkroPydkfwiJKd0q9ZhXwekwZiAjeOfcMJluTPD4R/3mP6fDgeZ0O2alx8nypK0p8goTGfJlV8pstOFedEp4nI+h2HKzhGVzHZEe2JeZOb6qAHl/yId/R9pPm0DBEPYoc3e/PC3Mu1dnRUQE/jpcjnWJqoIvEIZ2OkfbGqEoI++cGqghet66EbNem265oMohcIb6hJORpAI7gbGFtNLz15vAYtMo61tjQvQhulB+Z2F4nZ2DNtSl669CLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6Oz/1HUUQYX3qIS3vJcQb4QgxX77+Dv5ooOHCGoiSz0=;
 b=eg+69GAvWl60PLgXrZx2n9xucWAkguheIzklNxqUd1Jc1KxdyA3kxrqct0my0iMX+5EeJ8A0qRGPtvsSE7GSMgIlXl2Yf9nNK1UirhYnwPXV06H5Kkhq6Q3hXVfFBFOWHbjbF7rUbgMdIrkWT3L0EPuXmsSLPybdR0M/zZrs2Yp7voG0xuSEg/F7l8wVR79MT8Pv51nVVCoyr8Alt+ztfFhzQeP+RInG9RGzHe4J6hkDwxylQ/ZxB3pRULiLuLIWKQZ+Qqz9FV1dCOE0+mAbz0FInpYeTnjUXvZOhybftwQ11NOihjR3ur8r/CgCHd5yrlbT0R6y8B7cBwNOFnv99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Oz/1HUUQYX3qIS3vJcQb4QgxX77+Dv5ooOHCGoiSz0=;
 b=mh+fU1SqqxW0FXcynl3PoqJgEh+yah8EKr3Kfx2E7HI1ZC/iHa8dWcNbIlha/oQNc62zKHCBtLegXGUYeBlTsp9w8DFyvRvkIvrBquPAgk80zoW6AEmW/f0mw6ZmSabJQKfR1/Pf3E5wyFcg2067VwItVboailvViIYDXkzxwLk=
Received: from MWHPR17CA0078.namprd17.prod.outlook.com (2603:10b6:300:c2::16)
 by BYAPR12MB2871.namprd12.prod.outlook.com (2603:10b6:a03:13d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Sun, 26 Sep
 2021 09:07:17 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::d0) by MWHPR17CA0078.outlook.office365.com
 (2603:10b6:300:c2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:16 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:11 -0500
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
Subject: [PATCH v2 14/21] cpupower: add the function to check amd-pstate enabled
Date:   Sun, 26 Sep 2021 17:05:58 +0800
Message-ID: <20210926090605.3556134-15-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2789d619-4bc5-492a-6ef8-08d980cd09cb
X-MS-TrafficTypeDiagnostic: BYAPR12MB2871:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2871F97A0F8147F3CF87560FECA69@BYAPR12MB2871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPhctI+o/z32G1xrTg5vMRI58OWqHrRt0xIupRhOjaR8GFUlMZ3x9sMb38zt5tQGC2bNQMGpYYFBaKyV5mYi1KlvqpbKxcHyakU+cwo6I2asYjUkelPvEoS08pJWByfdqGYPHwaH6YpUjI+4ZJxNosln997zwa0KcCSAcS0OA5Wt8JHBrhDtp92G87sVsgdxW5LHiJQNCEvrgdS7Z6lwDBTrgu+RaLVMR9qOwIUQTfwqktc/Ph1zB73MTpaJGND8PZF7IEJ7XjY2YyfcegHGhS59HOfBQLxlhuz9c0y6hlRkP5EuHB0nTAEPAXCYF7P4TNrI3E5yJD0zossaUj/BQhZqD5f1oGivx/XaOxM/fdjLb9MmpYZgnQYyQqtKDtReaCwwuUVl04bTwISVbqEFJIJKVGrDRRS9seiQhG0GREwOrnc9h/KD5Ok1f9+73omj1jxxFUfNFEsvGl3O8DZ3aTN2xAkt5d4twsDet2Xj4rjdOcKzqKH22qsI/KITTphqw0rADFnPOYG3VLJFNQXST0vuiFzNTT4Wv3x+p3CK8YUI8Sg0A/a9KIDh5RuTVrMRPYcNfCSkGHfl7ce/Mv+dZwul7KKtuDmfYoxgOUJfkuRFo4BGHGmuf6+YezCEIOhd7sI9HBjPTYYpmVmRUSOCH3hVefRbQT261o2ObG2/BFOVepfQOWOw76DwW0KOE4U0Q1mQyh5uuXkXth4Raa0MiFAa9U8+hKLsvfeAPwtFCcA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70586007)(82310400003)(2616005)(2906002)(86362001)(316002)(110136005)(54906003)(426003)(70206006)(4326008)(508600001)(336012)(81166007)(8936002)(5660300002)(356005)(8676002)(36860700001)(26005)(6666004)(47076005)(36756003)(7696005)(1076003)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:16.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2789d619-4bc5-492a-6ef8-08d980cd09cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2871
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
 tools/power/cpupower/utils/helpers/helpers.h |  9 +++++++++
 tools/power/cpupower/utils/helpers/misc.c    | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index b4813efdfb00..ae96efac759f 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -136,6 +136,12 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
 
 extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 				     int *active, int * states);
+
+/* AMD P-States stuff **************************/
+extern unsigned long cpupower_amd_pstate_enabled(void);
+
+/* AMD P-States stuff **************************/
+
 /*
  * CPUID functions returning a single datum
  */
@@ -168,6 +174,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 					    int *active, int * states)
 { return -1; }
 
+static inline unsigned long cpupower_amd_pstate_enabled(void)
+{ return 0; }
+
 /* cpuid and cpuinfo helpers  **************************/
 
 static inline unsigned int cpuid_eax(unsigned int op) { return 0; };
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..39ff154ea9cf 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -83,6 +83,26 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 	return 0;
 }
 
+unsigned long cpupower_amd_pstate_enabled(void)
+{
+	char linebuf[MAX_LINE_LEN];
+	char path[SYSFS_PATH_MAX];
+	unsigned long val;
+	char *endp;
+
+	snprintf(path, sizeof(path),
+		 PATH_TO_CPU "cpu0/cpufreq/is_amd_pstate_enabled");
+
+	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
+		return 0;
+
+	val = strtoul(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return 0;
+
+	return val;
+}
+
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
 
 /* get_cpustate
-- 
2.25.1


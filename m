Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB9456D95
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhKSKgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:36:13 -0500
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:25632
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234872AbhKSKgM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:36:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW6nPf7PP4dcgt0Ajuhy3GCbGo9AMPxNOJg6rTrAAsByi0pz0sJbfoMTIwH8ifnxDZMYtwtq2Bk6/3kkwYfyVsa5Bzn9XWkXBGqPAlfH+1TSNkBgORRZg1I89dib/oAI7dNoqrVyrLVECj9o/Gxon8PSE7IMjX6Z4n4hPH2dx1zqNVJzuQuxoicrKeqomqoBdg0ZUXdXnpybUwFNcNIDiXDl7qB8N/nCOIo+o4Qmy7dsNDZfawGgZKbQKxW5zjOTg2jeHwdNDluX3XKtLIgzzrV8pk9xEMT4dUEvGjKGcJUxefQPS1g4I4ZzuPXIcquJaRtx4ctiAyuhZnlK0FO4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ZoxYKeFuCwEWIzDfr8ONAa8ASibQTmUMy9E8/1byc=;
 b=cxr0+IcNrwtkNpUcD8/aKtERdcOODpt59Y5JOnO9khGDlKToIrXVaqv8Ti2HB4cKlHtwv7dRwyoAPQZo1+1pXNp/okAjPK9rEiIO/nMnDYUrEZfjBExeFBlLzc7KtvmsV2+9LNPgTAHBzVj8vRJhgkRAJYRFtuy34yXnJoeXzzpGu51hMziF54uVjhKCba8FJTbrH+XmO6zJpx9B5qlRuxp6UarYfs93PDlPyNwJQlDA989aJM0rVU3O5rRvmY3wWWV3NfjQpcjn4I06hYLGczKjfraUE1RAwIjr1FKQ/PgHE8qQl+Qx3vEiwS1CS8DuO0O17Q0E+nRTydU9E+cXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10ZoxYKeFuCwEWIzDfr8ONAa8ASibQTmUMy9E8/1byc=;
 b=PGZ5z/nhB3+m/PJIRFU/0S0tmma9fVjepqPTqDOOnAn77KhR+E4j05ynoHSeWk8UV1HgM6D2E3vaDdI2Yo2gac29tK7PhRigEiUd3g22+lEcBOuBH0LbtMXnCbN5XP7gIVHKJYSfeM2iEy3Ad+luzKBBzgCch5+WSH8LzdVtf8o=
Received: from DM5PR12CA0015.namprd12.prod.outlook.com (2603:10b6:4:1::25) by
 MWHPR12MB1632.namprd12.prod.outlook.com (2603:10b6:301:10::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Fri, 19 Nov 2021 10:33:08 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::9f) by DM5PR12CA0015.outlook.office365.com
 (2603:10b6:4:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 10:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:33:07 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:33:01 -0600
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
Subject: [PATCH v4 19/22] cpupower: enable boost state support for amd-pstate module
Date:   Fri, 19 Nov 2021 18:30:59 +0800
Message-ID: <20211119103102.88124-20-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6043853-692b-4085-43a0-08d9ab47fa02
X-MS-TrafficTypeDiagnostic: MWHPR12MB1632:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16327C81F7E7F1EB316CA5ADEC9C9@MWHPR12MB1632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MTqCCo+wxVh/1BQhBDCCmszt1/TTf7SoGpRctKlqawLowJcj5tgqDf71Tj84PmA7f//4QnZLn/sGYw/KMuM2/VqYNXVF2sLvfEuvfjrtk5CBWbUJd9SQPQC1Iwk0gC8Bz38kvIXyaw2FhvtLIGBC08R7pGP0uIxMcwvIOUx1gqspiHYxL1cdINIIHSseiSMAyoYP4aqCu0TaKCKZs2y4Ip4LdbTcx1JyKEHfMknbpfFPfGQWPLhEorF6hlxSv8NIg5uO4wK43F6JWJmm0ncsssxZGqLrR0mNVDNxvMnw0dbzDG3jq4064RU5iQHJ7vSgtkDkLUGRKJq5ht4Fk4oHF7tmnOP33sMt6fpodwRczk/eX2NK5fgZ/6WwgAn0NPOGPTO5JXhYwfwJ43kHqZ+urya4jlxwiY6zeYfZg1sHWgLpAYMLTTcfZ829AGgWRpZpPYO6FTF2GUMX3EEEdSJHqb02TE38F9UXOP17qySlYOzo+cB0azk9etRh+SlYQ7Z6PloqY+1WsqtyuWugPjrHfq9dh6FD9xwiSGkqlEDk3Bt+NH6xFRCCL7aZ6zblSt2viMn+vPPAkxEwt62M4UeCLzBESIdBcg7pEjq8wz19nwIbBuNsJpum7+MhnPGyed5GCCapgjkjFjjepm2COy751NOFapBhXdrh7xMN+1vEeQvX+34GPl5+OzM+9PIFmc/Dtp1nBCpdwcFxVgedryjYSCUj5WObGNK9qWna2CR7k4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(86362001)(36860700001)(47076005)(508600001)(4326008)(7416002)(16526019)(2906002)(7696005)(186003)(83380400001)(336012)(426003)(70206006)(8676002)(316002)(2616005)(70586007)(54906003)(36756003)(8936002)(81166007)(110136005)(1076003)(5660300002)(26005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:33:07.1657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6043853-692b-4085-43a0-08d9ab47fa02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1632
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The legacy ACPI hardware P-States function has 3 P-States on ACPI table,
the CPU frequency only can be switched between the 3 P-States. While the
processor supports the boost state, it will have another boost state
that the frequency can be higher than P0 state, and the state can be
decoded by the function of decode_pstates() and read by
amd_pci_get_num_boost_states().

However, the new AMD P-States function is different than legacy ACPI
hardware P-State on AMD processors. That has a finer grain frequency
range between the highest and lowest frequency. And boost frequency is
actually the frequency which is mapped on highest performance ratio. The
similiar previous P0 frequency is mapped on nominal performance ratio.
If the highest performance on the processor is higher than nominal
performance, then we think the current processor supports the boost
state. And it uses amd_pstate_boost_init() to initialize boost for AMD
P-States function.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c     | 18 ++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
 tools/power/cpupower/utils/helpers/misc.c    |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 14c658daba4b..bde6065cabf4 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -175,5 +175,23 @@ static unsigned long amd_pstate_get_data(unsigned int cpu,
 						  MAX_AMD_PSTATE_VALUE_READ_FILES);
 }
 
+void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
+{
+	unsigned long highest_perf, nominal_perf, cpuinfo_min,
+		      cpuinfo_max, amd_pstate_max;
+
+	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
+	nominal_perf = acpi_cppc_get_data(cpu, NOMINAL_PERF);
+
+	*support = highest_perf > nominal_perf ? 1 : 0;
+	if (!(*support))
+		return;
+
+	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
+	amd_pstate_max = amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ);
+
+	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
+}
+
 /* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index e03cc97297aa..c03925bea655 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -140,6 +140,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 /* AMD P-States stuff **************************/
 extern bool cpupower_amd_pstate_enabled(void);
+extern void amd_pstate_boost_init(unsigned int cpu,
+				  int *support, int *active);
 
 /* AMD P-States stuff **************************/
 
@@ -177,6 +179,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 static inline bool cpupower_amd_pstate_enabled(void)
 { return false; }
+static void amd_pstate_boost_init(unsigned int cpu,
+				  int *support, int *active)
+{ return; }
 
 /* cpuid and cpuinfo helpers  **************************/
 
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 0c483cdefcc2..e0d3145434d3 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -41,6 +41,8 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 			if (ret)
 				return ret;
 		}
+	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
+		amd_pstate_boost_init(cpu, support, active);
 	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
 		*support = *active = 1;
 	return 0;
-- 
2.25.1


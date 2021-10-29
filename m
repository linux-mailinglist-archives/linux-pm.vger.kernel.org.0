Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CB643FD0D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhJ2NHx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:53 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:56704
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232013AbhJ2NHX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GINBYcMsbIHYMrqJpKXu7y13ckp0nMqsNMsxysJVqwWy9zKZV/zOP7X49fdEXpnsa1VhP+pjIdELbnIioN7A41Vvq6doKjdZDeKxOQmpHz12aH6LSz/J7icxQIDTMnRyyn67rFOiF7K0IWr1DlpSs/7hU2fAVI3KaMsKZpzy4mAn4jH6KO5sXBlTTtimkXRRkzQ0w+aXXBbUWD9Br7dh5a9+j7Jn2cI3if9TKcfWobnN8fye97Sd5OkjvXctxJ2212cdKByVEsrp+LTwAFkvRDVtEe8t0RWSxqRvaZxOwtmJwKUoNx8KGV6PkTb+VKagkYUozljzQKhN3tUKvf9Xeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxosAJiN+PnNwCcHHDg5g7DhiiraCgyGkLTkbHS4TpY=;
 b=aLYGqqRk2fGSWaiLk/LLxLwP9ysdxLN0XWMTLMcgKvC2PSpMjSKnYtWC7lYeokww+vwKU7J603z49dQGwZ9LsA7tmTTC33UYIpGhrG8vcJrOYBWJsxr3bOB/aLG04gthKDbCcEa/Y0j2NYTMKTvc0cIfMdE0aX5j+ccRPQzYBmxFE4iy1K0ie8Rdf26FY8/TCBDepVtqBq+QTLxzKS6SHDqfhYjdP4M8wV4s3Ky7igjRF/Qw/JFZZS9iUkokeNZgpKUuFrxhpiVaAsSGkZ1fUi4vaaLioTANCiWV/bju1z5q0et7SMMpcZkUuqlvFZXN5/FF1HMUAyImiQcUFuJXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxosAJiN+PnNwCcHHDg5g7DhiiraCgyGkLTkbHS4TpY=;
 b=jtX3+6AIAkoP82N2q+6FiEm9WhqLcjiy92dfFpUMDfrURCLxc3C+dKkBI30AB5KILXtk2toaTQY9qjWWtX2K37NQPnx1Qgk+6rmiCNvRAxlXVcXoZ2fZnoX0ZoXGYPZAEL1qzrXgz3aeG17Dz04wbEIV7977n4QZlQpBEEeXL30=
Received: from BN9PR03CA0677.namprd03.prod.outlook.com (2603:10b6:408:10e::22)
 by BN8PR12MB3347.namprd12.prod.outlook.com (2603:10b6:408:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 13:04:45 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::5b) by BN9PR03CA0677.outlook.office365.com
 (2603:10b6:408:10e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:45 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:40 -0500
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
Subject: [PATCH v3 18/21] cpupower: enable boost state support for amd-pstate module
Date:   Fri, 29 Oct 2021 21:02:38 +0800
Message-ID: <20211029130241.1984459-19-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 108ce025-2e4b-4aab-c267-08d99adcae4f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3347:
X-Microsoft-Antispam-PRVS: <BN8PR12MB334731D9F373F94873AAFB1AEC879@BN8PR12MB3347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tvcWhjlsxSO0kWOR4Fw32yExK5ihEfMk5dNTbtnQffCSY/y9ruWAMbmHZCd/9Xoq2T6onvv2T6EFAyCf4HXqq/SK6CsQL3J4gyWOhW4cby2a2jnXJOgo8PpK3wpMCNO8F51V4wF90DzuLtuD52LMG8Zt1E326ruxlfBIp2hiJGO8wZXH3jAIej1wAVGXscnCq65tTyjsZpBFoTjUbn9sT/07UPCt1fJJDz7nIzFbLbvzbpOSBGBF7w6EEd6ouBTmYDCKEnM0vXYndozbNOKqGiq9JMper9VFOkGg1Wa0sI1DMmAFz/ciVTadRG3cIk3hk4NSw0YWnY8jv+OrWioK5z2SCVW5hI48OXryN9D5lbmIDeQB1QafUa/K/V49z3jNMKYWRR1rfQCTLEGE6okJiYqTyiRItKDzMK/tOVhcQ/Bor2jmlxt2JHR897PtdHF/zfUIj+r7BiR1iOyYzXRBPqqARfqWuvy414OA3U07Q5VlxU4w6X/izY2F91tlD5zINTfERj6LYEmPlEG8RcozwZEHtCC7TS7tgCXAJQmbzW1zkBYeI1giDWHASH3+oiB4RpcqZylP5392vEcsp5zePuSGENppuNGVz4hgi2NfNtqNrN8ncHzIcVUWfZr989Y+UxnDCcxqQxvXxpn2g9xmocBEl4HSWi7I9znljJN2N1jfiI7qmhrGw0jk59JzrrTDeqdQj/RmudKXwXej451VRtHcCn/VVSmcBOkzEBDLlE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(336012)(82310400003)(2616005)(86362001)(426003)(26005)(508600001)(36756003)(186003)(16526019)(83380400001)(8676002)(2906002)(54906003)(110136005)(316002)(8936002)(5660300002)(1076003)(7696005)(7416002)(4326008)(81166007)(356005)(70586007)(70206006)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:45.7151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108ce025-2e4b-4aab-c267-08d99adcae4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3347
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
index f233a6ab75ac..92b9fb631768 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -182,5 +182,23 @@ static unsigned long amd_pstate_get_data(unsigned int cpu,
 						  MAX_AMD_PSTATE_VALUE_READ_FILES);
 }
 
+void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
+{
+	unsigned long highest_perf, nominal_perf, cpuinfo_min,
+		      cpuinfo_max, amd_pstate_max;
+
+	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
+	nominal_perf = amd_pstate_get_data(cpu, AMD_PSTATE_NOMINAL_PERF);
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


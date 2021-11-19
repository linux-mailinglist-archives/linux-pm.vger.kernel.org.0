Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8243456D97
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhKSKgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:36:18 -0500
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:43393
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234960AbhKSKgQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:36:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db/30OFTetErjcoYHIlMil4a6z2bjQSphBpi54tZ3x9u5WUn904YDwURwVt2WJQ7IBKMSuuK/+xqcF2l9PGVgeQq6ecbeLiJE+bCKHV5XRKK6jkBHukCeUlRaBGQui8KY932ZvY3EkxGIP2qIBcvTS0Gj6kqFYN5i3AlUKhzzxIOgnORPMWxiE68ZcxK/eq8ZketowRJfBkmvmW+A8v0EbRRLSWNrwq5WSD3aYw64FDYUdhxTh+/N++kuwxxodQQMNF6mgosb3qoCi3zuACET6mYPBcnBv6TODVNmdNsTbuG4Ia37PoU4gd2O+LrCN49WSl3eTj09x+IMpZZjww7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLuKm7guG/EjmNklr9YbZSw1vi5jb5wNC3n2jSyi8CM=;
 b=hcKeMbcYPegHnWkmB1XoSzBQMwsajNKzrFsIynLMGMGxLGwLy5qDQOh+sGbhGZRn3xchL+To08i2SbFfEu7aQKhJhhc/aJtyaulbaCzWSmO43Y20DdxBqD+ddwxTFUthOsevrP+qcKeUnLKx0DfSC/4BEvm9z7hfal57uTHr5POnTn2vvthahqsj7bsD6svzlL0rYD4ev/JBFEnPToTk/f/7880CReAtCFnoXUXZ8zwb+9UTvzNsnFKE/BYYoUzhzLPfvq2Lj4SIXAyY8fCtGC/r/slrAPv3tjyEZTlPiMiy7IHH/a3iZFu3wUfDBT6OdLqSr0jRmtZvGD7ijaKQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLuKm7guG/EjmNklr9YbZSw1vi5jb5wNC3n2jSyi8CM=;
 b=ia8gS4OTVeGelE/rr92bU+OkLpXPciyt63h7fFrWdpAD3nx1x4Nk70Gf3BLVZCqIO3RuIJU/rsQZpUn8NF5O2nkJDiGOmLYZM/kiRE0uMM6hCBdhxpNlBnyDrFtH56EHUjTlDi49t6+HoS7gjiqAlmFtux3rM7wKWQVuopWmOXE=
Received: from DM5PR13CA0039.namprd13.prod.outlook.com (2603:10b6:3:7b::25) by
 DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Fri, 19 Nov 2021 10:33:12 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::f2) by DM5PR13CA0039.outlook.office365.com
 (2603:10b6:3:7b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.11 via Frontend
 Transport; Fri, 19 Nov 2021 10:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:33:11 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:33:05 -0600
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
Subject: [PATCH v4 20/22] cpupower: move print_speed function into misc helper
Date:   Fri, 19 Nov 2021 18:31:00 +0800
Message-ID: <20211119103102.88124-21-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c82fff33-6a29-4324-ed8f-08d9ab47fcbb
X-MS-TrafficTypeDiagnostic: DM6PR12MB2876:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2876B872A6F6F21F8DDE6A30EC9C9@DM6PR12MB2876.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kgFrMF3Qkq7MwZ/q8ZGFXAUlwsRkaGzjBAcE5rx440XxoeQxS428sb7L6OtJjTg/manI4uchS++wUWG8JOt2fqhDJfrDtnZt2myaksPaeRJQiH2vIS/NOZPDAStDAKmJQ2uT90KKZwqSvb+w3uZ13CM35UAfB6Oi1fAKM9RRgox48DzyCNZd4aeA6QoCVrE678awaJGgFiWDLampaiPUCB4GOC4HnQQqabNoIdxFCUdMILv6fEJ67j3qidxgraSdJ9lMdiCCoVDlDT+/R+L+r6aVwIVP9lsHAONw7KwaSaIWtigg1UU0ebak/ryuvFgMKkLsnzYMmP+V8BCAlg+1eS0qD27anNhRcFn0KceAZNWLntlj+HM3wgI2DpTD9Td7VgmT6vBFXGt/PrVMXTIHs+5plUcMV+Pwk6YYUs4cB1TxO0vg7Bnbwc2j2wDiuAAa+/qliKohq2shkb/w2LH7aNMBY8TDckcn/NsU9JxJuKKNiAivh/oigGa0TD+H8e0KZ2YCuWZpi4W5Q9a6dAV4zHyQJTeZDpeVLABYT2P1KOGyTJjt6RD3+5tfH1l9LXNHAiLP3eosIgTEmEic5GGrF4h3SXb4Mv7nTpH3sFxInEoCZDXanczEcZQMTY3pOd0WwAIcxJmPuiXmrCI+ZZDsP1sSMupJLFwjocRYd804ZY6m5RMx/vudxB1wWlxFECWEQSLe6WElOkSdUzseo0scFmVs2a39JRbYKLNziupzQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7416002)(70206006)(86362001)(6666004)(356005)(16526019)(316002)(8676002)(82310400003)(508600001)(336012)(81166007)(186003)(36860700001)(8936002)(1076003)(110136005)(36756003)(54906003)(2616005)(83380400001)(5660300002)(426003)(7696005)(70586007)(47076005)(2906002)(26005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:33:11.9578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82fff33-6a29-4324-ed8f-08d9ab47fcbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2876
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The print_speed can be as a common function, and expose it into misc
helper header. Then it can be used on other helper files as well.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c    | 59 ++++----------------
 tools/power/cpupower/utils/helpers/helpers.h |  1 +
 tools/power/cpupower/utils/helpers/misc.c    | 42 ++++++++++++++
 3 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index f9895e31ff5a..b429454bf3ae 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -84,43 +84,6 @@ static void proc_cpufreq_output(void)
 }
 
 static int no_rounding;
-static void print_speed(unsigned long speed)
-{
-	unsigned long tmp;
-
-	if (no_rounding) {
-		if (speed > 1000000)
-			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
-				((unsigned int) speed%1000000));
-		else if (speed > 1000)
-			printf("%u.%03u MHz", ((unsigned int) speed/1000),
-				(unsigned int) (speed%1000));
-		else
-			printf("%lu kHz", speed);
-	} else {
-		if (speed > 1000000) {
-			tmp = speed%10000;
-			if (tmp >= 5000)
-				speed += 10000;
-			printf("%u.%02u GHz", ((unsigned int) speed/1000000),
-				((unsigned int) (speed%1000000)/10000));
-		} else if (speed > 100000) {
-			tmp = speed%1000;
-			if (tmp >= 500)
-				speed += 1000;
-			printf("%u MHz", ((unsigned int) speed/1000));
-		} else if (speed > 1000) {
-			tmp = speed%100;
-			if (tmp >= 50)
-				speed += 100;
-			printf("%u.%01u MHz", ((unsigned int) speed/1000),
-				((unsigned int) (speed%1000)/100));
-		}
-	}
-
-	return;
-}
-
 static void print_duration(unsigned long duration)
 {
 	unsigned long tmp;
@@ -254,11 +217,11 @@ static int get_boost_mode(unsigned int cpu)
 	if (freqs) {
 		printf(_("  boost frequency steps: "));
 		while (freqs->next) {
-			print_speed(freqs->frequency);
+			print_speed(freqs->frequency, no_rounding);
 			printf(", ");
 			freqs = freqs->next;
 		}
-		print_speed(freqs->frequency);
+		print_speed(freqs->frequency, no_rounding);
 		printf("\n");
 		cpufreq_put_available_frequencies(freqs);
 	}
@@ -277,7 +240,7 @@ static int get_freq_kernel(unsigned int cpu, unsigned int human)
 		return -EINVAL;
 	}
 	if (human) {
-		print_speed(freq);
+		print_speed(freq, no_rounding);
 	} else
 		printf("%lu", freq);
 	printf(_(" (asserted by call to kernel)\n"));
@@ -296,7 +259,7 @@ static int get_freq_hardware(unsigned int cpu, unsigned int human)
 		return -EINVAL;
 	}
 	if (human) {
-		print_speed(freq);
+		print_speed(freq, no_rounding);
 	} else
 		printf("%lu", freq);
 	printf(_(" (asserted by call to hardware)\n"));
@@ -316,9 +279,9 @@ static int get_hardware_limits(unsigned int cpu, unsigned int human)
 
 	if (human) {
 		printf(_("  hardware limits: "));
-		print_speed(min);
+		print_speed(min, no_rounding);
 		printf(" - ");
-		print_speed(max);
+		print_speed(max, no_rounding);
 		printf("\n");
 	} else {
 		printf("%lu %lu\n", min, max);
@@ -350,9 +313,9 @@ static int get_policy(unsigned int cpu)
 		return -EINVAL;
 	}
 	printf(_("  current policy: frequency should be within "));
-	print_speed(policy->min);
+	print_speed(policy->min, no_rounding);
 	printf(_(" and "));
-	print_speed(policy->max);
+	print_speed(policy->max, no_rounding);
 
 	printf(".\n                  ");
 	printf(_("The governor \"%s\" may decide which speed to use\n"
@@ -436,7 +399,7 @@ static int get_freq_stats(unsigned int cpu, unsigned int human)
 	struct cpufreq_stats *stats = cpufreq_get_stats(cpu, &total_time);
 	while (stats) {
 		if (human) {
-			print_speed(stats->frequency);
+			print_speed(stats->frequency, no_rounding);
 			printf(":%.2f%%",
 				(100.0 * stats->time_in_state) / total_time);
 		} else
@@ -486,11 +449,11 @@ static void debug_output_one(unsigned int cpu)
 	if (freqs) {
 		printf(_("  available frequency steps:  "));
 		while (freqs->next) {
-			print_speed(freqs->frequency);
+			print_speed(freqs->frequency, no_rounding);
 			printf(", ");
 			freqs = freqs->next;
 		}
-		print_speed(freqs->frequency);
+		print_speed(freqs->frequency, no_rounding);
 		printf("\n");
 		cpufreq_put_available_frequencies(freqs);
 	}
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index c03925bea655..fbbfa6047c83 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -200,5 +200,6 @@ extern struct bitmask *offline_cpus;
 void get_cpustate(void);
 void print_online_cpus(void);
 void print_offline_cpus(void);
+void print_speed(unsigned long speed, int no_rounding);
 
 #endif /* __CPUPOWERUTILS_HELPERS__ */
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index e0d3145434d3..d693c96cd09c 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -164,3 +164,45 @@ void print_offline_cpus(void)
 		printf(_("cpupower set operation was not performed on them\n"));
 	}
 }
+
+/*
+ * print_speed
+ *
+ * Print the exact CPU frequency with appropriate unit
+ */
+void print_speed(unsigned long speed, int no_rounding)
+{
+	unsigned long tmp;
+
+	if (no_rounding) {
+		if (speed > 1000000)
+			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
+				((unsigned int) speed%1000000));
+		else if (speed > 1000)
+			printf("%u.%03u MHz", ((unsigned int) speed/1000),
+				(unsigned int) (speed%1000));
+		else
+			printf("%lu kHz", speed);
+	} else {
+		if (speed > 1000000) {
+			tmp = speed%10000;
+			if (tmp >= 5000)
+				speed += 10000;
+			printf("%u.%02u GHz", ((unsigned int) speed/1000000),
+				((unsigned int) (speed%1000000)/10000));
+		} else if (speed > 100000) {
+			tmp = speed%1000;
+			if (tmp >= 500)
+				speed += 1000;
+			printf("%u MHz", ((unsigned int) speed/1000));
+		} else if (speed > 1000) {
+			tmp = speed%100;
+			if (tmp >= 50)
+				speed += 100;
+			printf("%u.%01u MHz", ((unsigned int) speed/1000),
+				((unsigned int) (speed%1000)/100));
+		}
+	}
+
+	return;
+}
-- 
2.25.1


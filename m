Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0434187CD
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhIZJJ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:27 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:53440
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231341AbhIZJJQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:09:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTyXs3kCJqAsL/0E5vpFb/Ys4TuCWSpIFG5olEXsiUkQhPAE37TYs1rnaI+8mtU9S5Vk1Em9xJ+Ll8JGa75Gfs7vUpHumOro6tysH0VGxvZn5L7MjmeQg50a9lAmZIX2yr0uKcIwX704oXyA/KemMsMIihF5ww6yB3K1YwSWFgRkVDgUCKkaw5TvZHwo18DZV3bpDMVEqvGiqOSggICgL2bY7myUIx1HVRq8kqYAJk/DiaeDbBppwYujXi/h+dUB3tOJTuNFzhlfIHs27K9V/XCs07OCzz6kxd8wFttWNIqiCURJjHy+UBNvD2LiZQrxj4bH8WKP8VLFYWOmsCulmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lSywZx4vw32meAi3dYF7s96ag/rhILm887/ADuiSWyA=;
 b=A9Eniv8pjcx1hKe8J4k4zozyCaRHVV8ky7AziAatfO6scNZAOSP0xqsRvxW/+Nr+fq2JF4yqMT5SJIzs7LU0N/nENHHKSXtvQuTOsYfsSulBqScMXt8Jiiqxh8TXowI+Zg2LqGRJig3GeH0pB/P/eou2crNd9HOce1x7rFaXXQj/3zipJOB1AgZCtckY/nBJjKE/HQpukLkvDjWqVp5yVztQ+uULvpTdu9ejc/FTzzlHsVXIxxty8SDXPMRMU3vPZNOBR3VC/4ZLvjP16Ff4M8CSQT4BE1+pNc8WGbA2vAL84ghXzY2cs2d9BCBuiy5MjH11JW67ZdmHXG/XV5DppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSywZx4vw32meAi3dYF7s96ag/rhILm887/ADuiSWyA=;
 b=2PEPI3E1v+v4iyWsIbxGAgz6M0lwJHADcYNPPGgC2esNJz+qQG4Q7OZE779ue33r/12YjXUGNTWYEInaua5MUDwiozKkwqXwfNZF3KPLl+H9bruwnegSoTXVYpuK0m+dHk0GCC72z6dC6/5c57zPQZQ7FfPIfXdnAhD0y33IWq4=
Received: from MW2PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:302:1::31)
 by DM5PR12MB1577.namprd12.prod.outlook.com (2603:10b6:4:f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Sun, 26 Sep 2021 09:07:38 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::17) by MW2PR2101CA0018.outlook.office365.com
 (2603:10b6:302:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.1 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:37 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:32 -0500
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
Subject: [PATCH v2 19/21] cpupower: move print_speed function into misc helper
Date:   Sun, 26 Sep 2021 17:06:03 +0800
Message-ID: <20210926090605.3556134-20-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d651f7a-1ead-4454-3471-08d980cd1606
X-MS-TrafficTypeDiagnostic: DM5PR12MB1577:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1577C9EC7D0BF7602C314A4EECA69@DM5PR12MB1577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoqcKcU79m3AYS46yBXhtQ+TmtFTOs4TgHfbFBHSF7B9McXaLUc2FLA2Juayb7skFbdB/2YXbpuTfJfbQIcGImSStoQ0Uwq55bNjm+lcIr1TBbgAp+0as4btZdO/GwSw+AI1n4P5F0hnYs/rv6KN3oizws32VFVyvgPzkufscbFOBzmG+D/CGSfbNwKmobsufX4ui9LGH2V3lQAh69tH2fiXaJlU3g6K/HwFaxijwhAWq2+1fn1l0R55YS1jkpnZp0GlQaNnVc2pJwCVr9BzDTp5qHfmQ4F7kWjGM8TkOm3hAfC9POqh/hMAvU3gCR7WsfneY607Jp6MeBfu1kgWO/CrO1pQtwbjueAi60FZ8l12hggh2ulmBrWyxxAIdtfUiQBhLgPrdYuf6215EjLGJ/Q8fLO3GoF5jUZ6kF9xjVyG956VKuC6PX/0OoNJWPu2C6FURAEDIy6EAiTDmglqA9PqME2nGWuetGJlP2kdaJQLM82xHtF1Lk6giKBDjb3Iido7YUAtoqh12rDmdUrIHXyvZxDW7uG6BMD5TQBW7gUrqVRE3c0ONGh0hy7HudKTiiN+8teyoPn4vljWlP3HFhbAWmygB9lDSlwq2GX4jATorxsYG/AUW71GGEuEgW9XFrhEqxu2xW1TGUjn5PdBh8pdYqK4fyOOa724DQNJ7BzmlzWOl1k2jvA48ICcM22sF2AlGhuQXsPYLRkTrSAKymyc4wBC8NipfuxUTdqDIxY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(316002)(6666004)(2616005)(70586007)(8676002)(7696005)(36756003)(36860700001)(54906003)(110136005)(82310400003)(336012)(426003)(70206006)(81166007)(47076005)(86362001)(4326008)(508600001)(26005)(356005)(2906002)(83380400001)(5660300002)(1076003)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:37.4233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d651f7a-1ead-4454-3471-08d980cd1606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1577
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
index 976c142ecfa0..0b0f6a55354e 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -199,5 +199,6 @@ extern struct bitmask *offline_cpus;
 void get_cpustate(void);
 void print_online_cpus(void);
 void print_offline_cpus(void);
+void print_speed(unsigned long speed, int no_rounding);
 
 #endif /* __CPUPOWERUTILS_HELPERS__ */
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 99d1dc8917d0..730f670ab90d 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -166,3 +166,45 @@ void print_offline_cpus(void)
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


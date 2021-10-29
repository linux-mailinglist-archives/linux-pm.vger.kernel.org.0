Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF143FD0E
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhJ2NHy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:54 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:2776
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231700AbhJ2NHY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9Xg2r3daklnfoJfEIGZBW+rcO2mbxOq9zrllj9I6miOuCVXN7UZhR40+9Q9wTaGVQwbXhIeOXkuJWPQbKNE+Ya0RkU/KxUEYVMKTklC/Kt/ELOEaDz26vSm5RGQvvQzTaAHLVRv6IyLgSKnzdYLo5Die/oPLivVNgqvrcII0e6gRfB0Oa7bJV+eEeL+XeHR5hbuSTYQuXmljogwi6y2oI+PkGyWO7BSiGNnH9SEy5zzJ7ctCWgSAmuzYFM2Ky41kbG1TgLAScFeCqCPhIAyMZZSoHw6IwKjbKs8ck9UvHulpCl055pQhIJbp1Kjs57QvkBtYttYZYs9Cx8XqyyI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLuKm7guG/EjmNklr9YbZSw1vi5jb5wNC3n2jSyi8CM=;
 b=iduASOhElzFUQJX65f2nUl1ex9mmtjJrO4r+oHQKAZK3D4MRUK/+mINe4cs5z2K1u+n+vYGBWxW6dsS2qOwnkQYlU5FacURwWfILbp/d4ly8f7JM2DyZc9tnD6cFwJWPx4I8zCaGL5hHUuQYITT4I1nl67Q3MY9/tl4R2etT8Z5H/PvuBHvfQ/6tc8HZmz+RIFaVW7CPqZIJw15uy6pAvSJiGVTFJtXNWaL5ZmjOXuwR0A5xOaxPDY+ssDXvlJrb0IKr3zVFISfRLW1hXHSnfNhZgquXpbZlsyGErmGjEa5TQZ4r9YUBXNeE5hMJ0FBbMCWUFgYtt1zs85VijaXYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLuKm7guG/EjmNklr9YbZSw1vi5jb5wNC3n2jSyi8CM=;
 b=lwh10DajK5NJr7+biOtd9wCMvI9a7oRVPqCun6wAC/ZaEPrrF0CKYFo8wAH1HgSdWUpX+VmPaoy8AeoOlKNZsxOSq6bEs+6g1WFfT5saUaQCPnimAovt006ju/NoEBsw3TTcTrCj0R+ThOtkQVRLXYDi6RUKokhzxiGBL6dChwM=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 13:04:52 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::f9) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:51 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:45 -0500
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
Subject: [PATCH v3 19/21] cpupower: move print_speed function into misc helper
Date:   Fri, 29 Oct 2021 21:02:39 +0800
Message-ID: <20211029130241.1984459-20-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bea388a7-d0d8-4f3a-bab4-08d99adcb1ae
X-MS-TrafficTypeDiagnostic: CO6PR12MB5492:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54926203D0352F1A7E1E235EEC879@CO6PR12MB5492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfxWHz20fIBKuDzHEO0MaMAIir5gtGUzgyjpn9Ek8jdChMOiG0qofItxKSdmT0v/ucaculAfvD7JzOpM1nJghQFYhFfx6fGpNgtOQgxIQ6nAwU05qaZafuEfh324yBdO95Po744qttspuGPOsy/jRboBezHtmuBao3JikzWLoj7AKT9swQhsorgj01S1ZplQ7uUO+7AnyTpsyVMlUfhZs8R8tMGO7EXLTZWfYPxTtkipKPeUlGVa1dHf7Fam/S3DDqIlxxkObVeg6AfuX13TRLagZs29w4qC+zBNtN4C6JtC3MOYCwBemCTluIfJP/e/tqRf2E5UOvFNvrAGRNkmV8C4wVqyJC6GBT3MIRJczNUpSD+Vu5ab9Uis86E7d5PSAt2zmNlU9zzAjiRCQt5bJyN9B64/024izNps5EE/PRXIwz11G4HqpNIXBFl04YZGP1IvAZ79a+qgAlW9q0yUtXPGLeNcV84gdIp3o6Q2rbByTsKyCfuhj/sC8yjNSaws7Z0jQzACRDyb4IZDdV3H0V5MzpmotYCKmkUHZ4s+qUc6Hy9FPV7ChacdasLl8iekWOUEGFRk+kh6dW4EXrp48invG3rSsEYfQgnkjWuvOV6QGbaOw/LUQXDf5xmDrKq/REICIMrMjJsJ4pY/SRbu65Q7jdVu2d0GFO2t9ONt5zlS0QIhgeZRxTNxePPkxz220JRDV9Kqb14lFWzv/BQCABFnAZy1VMR0KMQDKaUgf5Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(82310400003)(47076005)(7696005)(316002)(16526019)(86362001)(70586007)(4326008)(26005)(81166007)(8936002)(186003)(5660300002)(83380400001)(508600001)(70206006)(36756003)(36860700001)(336012)(110136005)(6666004)(8676002)(356005)(1076003)(2616005)(426003)(2906002)(54906003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:51.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea388a7-d0d8-4f3a-bab4-08d99adcb1ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
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


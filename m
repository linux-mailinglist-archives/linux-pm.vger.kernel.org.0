Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31247456D8E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhKSKgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:36:03 -0500
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:30401
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234319AbhKSKf6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY4anH5qHDMr8euaqPvQ+ahTjXgFkTrlR7kZvBfd7UmEyQhX8U49dpgnyBbkI/4A0wZSVIMHmDba7ZcAFKhJJC3TElDFDGLKmaaR+Osaeuoz0CuTpAsklUrEIMgJf/UB75nshVLJqd+A/Mns/zKF0vDYKZPcbJhrgyzoER8QdX3uboKsBN+LnKLMfnYMTT1x/qV1RSFGDgpDmlohrQ4WopWNjOpVn9DWtiyp5VRexPTMRhrFWBN41pYO6/a5sS9esOnASAu06nb91Ql3e9mRso0ENGaFXb2DzUrLy8m5CXp1TfdmxQlr3THBX078cXHjA3+hpzCoE3mxUGRu5NPXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcxEzM4rnHy67HV2hgOvkc/C/omrcf+HN6ySnnoV0C0=;
 b=jODGwJPsgxP/ofjvxneLR1lSIk2/uERGnzMyzjF6s1+pTjDtHdnlaytUIYRIb8yJywpb/cVOvpCWxvO218yRDm24YfO0eudWgQXUHWCzc/idG4pMGgRQYEIYF4c7PMPzhVQV5hh7fBEsYJB+KUFk9OkTgHAhtYHUbqyA3nmtPryoJA/kauNPfBkXHq6f+3GBNKpCcHuuWeLuXARTvwfLBjPnR6uvcJG8vmCBnRTcIBkAyb23sgmDdGQGkomHe8kjldLIRJxDuidT6TR0IZZbQgLxflV99CHgdiYj7W0V5KL9XDfGACL7Y+yWNXKH8P+ocQgAxEHyV8bsAkcun/+o5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcxEzM4rnHy67HV2hgOvkc/C/omrcf+HN6ySnnoV0C0=;
 b=H00dzPFtzQJEuZMWo2fKHDRonO8Kb+TWl8HlryVBMt2jchCwcnsMopdAT1xk0AONxcsUgdnDTj8PX/Gi53yFADt+EvPQxSWvZK8r6H51KXsmbAcdJgC8XIT7CjRpSZNn/kHH8mCT2wbKRl7KGBClMS6XtXxNfPpWvEzc4oOvDUM=
Received: from DM5PR18CA0078.namprd18.prod.outlook.com (2603:10b6:3:3::16) by
 BY5PR12MB3715.namprd12.prod.outlook.com (2603:10b6:a03:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:32:54 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::ca) by DM5PR18CA0078.outlook.office365.com
 (2603:10b6:3:3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:53 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:47 -0600
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
Subject: [PATCH v4 16/22] cpupower: add the function to get the sysfs value from specific table
Date:   Fri, 19 Nov 2021 18:30:56 +0800
Message-ID: <20211119103102.88124-17-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f0b85278-c2cc-44ee-edc2-08d9ab47f1d4
X-MS-TrafficTypeDiagnostic: BY5PR12MB3715:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3715BA9D27703D49FEB29880EC9C9@BY5PR12MB3715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPvWlkrN0J4rzcVy4jABlHUVVXW5INI0L+uGHZUtiDXVa1u+Ru2v1Em7d7gnRfwue6VzP5SrmAwaNkPJDVrpHoFlNGziVjZfShl9qdYJrq9nfftGKZdyX6fxHeQPo9FPQrjnlOaH/n/PqNKN6ZZoAhy2rFSW3GnRt4Q6nNnxJXHvpb66VcAZQtFzs80XLQCuIPMBS+PpcguoVIGNW6B4FI8pQu4yiy/AovZ5AkoSdeLpRCKwdIJWlUeGzk4Lom+D39iu4H8sG5/Eqw3MPLWkKCGxYyo0temmDoR9aJKHbNtZuPFf5i5A6JzZ1s6PnMfDAPU+MptePE/N4Ww+uVAr2qEWmpfiFcQE7R1A7Uhp1EZcJR04uc7hG+nDD6cox4p6OrwVhqCSNdCQmF7iA/8Gyasu31BTIDAs3X+ALOu79fyV2TZvcgwpNMwA7mlpM+Lskri/vAhaKx1esbN/EE1lv7m5EEteM9s8//vds5yPR+EHk67eQkMyu1DBlxJ0Kg7CJRtRxqo/7+OJYEyMiJXll+WyiwbuuQVafYeMralLFLlUPSmXqSsAARG6iDy2TcdZYDzH6jMXgGAPtlK0zHt/0Oj7Jtl4lYGJAa1+ntwWN+OhCKlgUlVY08I37WXl7XwiPMKEWDoGsP57GFbhcJK9yrMiePSKpPcNDsBv7qAqeZlKB9MuplqkKIS7nImTi+EDmF87fTfTOu/CmEWhxuBvKHvzw30jQZFdTYMwGx96+E7y2cq3KU6GYeR/uKBMUnhdhw2Dsearuk1+QUB4cSefTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(26005)(5660300002)(508600001)(4326008)(47076005)(356005)(81166007)(16526019)(82310400003)(426003)(336012)(7416002)(86362001)(2906002)(2616005)(186003)(7696005)(70586007)(110136005)(36756003)(70206006)(1076003)(54906003)(8676002)(316002)(6666004)(83380400001)(8936002)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:53.6977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b85278-c2cc-44ee-edc2-08d9ab47f1d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3715
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose the helper into cpufreq header, then cpufreq driver can use this
function to get the sysfs value if it has any specific sysfs interfaces.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/lib/cpufreq.c | 21 +++++++++++++++------
 tools/power/cpupower/lib/cpufreq.h | 12 ++++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index c3b56db8b921..02719cc400a1 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -83,20 +83,21 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
 	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
 };
 
-
-static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
-						 enum cpufreq_value which)
+unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
+						 const char **table,
+						 unsigned index,
+						 unsigned size)
 {
 	unsigned long value;
 	unsigned int len;
 	char linebuf[MAX_LINE_LEN];
 	char *endp;
 
-	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
+	if (!table && !table[index] && index >= size)
 		return 0;
 
-	len = sysfs_cpufreq_read_file(cpu, cpufreq_value_files[which],
-				linebuf, sizeof(linebuf));
+	len = sysfs_cpufreq_read_file(cpu, table[index], linebuf,
+				      sizeof(linebuf));
 
 	if (len == 0)
 		return 0;
@@ -109,6 +110,14 @@ static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
 	return value;
 }
 
+static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
+						 enum cpufreq_value which)
+{
+	return cpufreq_get_sysfs_value_from_table(cpu, cpufreq_value_files,
+						  which,
+						  MAX_CPUFREQ_VALUE_READ_FILES);
+}
+
 /* read access to files which contain one string */
 
 enum cpufreq_string {
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 95f4fd9e2656..107668c0c454 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -203,6 +203,18 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
 int cpufreq_set_frequency(unsigned int cpu,
 				unsigned long target_frequency);
 
+/*
+ * get the sysfs value from specific table
+ *
+ * Read the value with the sysfs file name from specific table. Does
+ * only work if the cpufreq driver has the specific sysfs interfaces.
+ */
+
+unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
+						 const char **table,
+						 unsigned index,
+						 unsigned size);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1


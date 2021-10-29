Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98C43FD06
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhJ2NHe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:34 -0400
Received: from mail-bn1nam07on2046.outbound.protection.outlook.com ([40.107.212.46]:33604
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231882AbhJ2NHG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWvOCw/iNlSGHCwziZXCxVhr3n/bmnrRu0hUjYShRHMAaTPiEFoBhTts4Qo1HYpq2JJKJkUvdIqNzaA/uQQObYBHqkGw0QztxN3mTpvfUPoNEvjznV+FSlvSar2rIu5g9yWGX3HXB6jEyIUyqySDo+dJylQC1NW9TBUgayxe2epSoTf6z14Q+17RLmYPugNaFamI6mG9x3vU7uMdbqyMsxPQUpbV+Tt5M0tlAYNwDhVgcJv+ccmMeHEdRWSB2hKVaOTCqsvO7MmPvUz9fuJt0Q5vcbzkhr7pZZwXZaeNX+u+KMZWrHt2E32ths0YBaWaVRhSEHyLiKEqITw+ARKlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcxEzM4rnHy67HV2hgOvkc/C/omrcf+HN6ySnnoV0C0=;
 b=H/TYJoHBM1BYNi2Yw8mTrjB6D6tJe/mZXmGwTiJGKh4ICPY096x/vd4Nqlfj6XBihoHIBcFPsIsqPVxNDax+e3G3gpkODnzt+HQV9mK6Ix3Y4/M6Iu2Gq5WCBB3U17vCuRBS+scqOWYeMy30JkNtWg5dxOOPdId+r1xJGLSFfdqD/ISsESCpGjC+NoHphI/HDfTGM2Re7zo4HayaSGxmLD9sl2kp5MA/vMT77w1TCe/fIvyJt67Xkrxx9VJuk8aITjsK0RZgZrcx3ONf9f53G6tT/DKVb+ClG8eHQZpcEaN9773WHCbe1yBpvRenhvWvadCedbSojvWagCJnGndRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcxEzM4rnHy67HV2hgOvkc/C/omrcf+HN6ySnnoV0C0=;
 b=e8pccTTzHJUbD+4jxgpm+uIlh4SSpDbQH0bkXa6fybgfOBk8YwDs4RRg0CAJ3DCyLbP4ZS/KYykZQ03VlkCbn7ZLPt3uakm3s2ikQrTgp8dlxbIiyVSazgkZZpLuDm3jYd4Rt1VPTzMdY+xSHR3f3NB55lPtcIunNCNPIBJ0+UA=
Received: from BN0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:408:ec::8)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 13:04:36 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::c) by BN0PR04CA0093.outlook.office365.com
 (2603:10b6:408:ec::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:35 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:31 -0500
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
Subject: [PATCH v3 16/21] cpupower: add the function to get the sysfs value from specific table
Date:   Fri, 29 Oct 2021 21:02:36 +0800
Message-ID: <20211029130241.1984459-17-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3433a568-fcff-46af-f666-08d99adca877
X-MS-TrafficTypeDiagnostic: MN2PR12MB4422:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44221EFC50E6231F2FA4F7BBEC879@MN2PR12MB4422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vLWa+uZfncRhDxJErpaRhVvvwI1nDh3mkO0UTGj5DaxTmoQjHaiqky/lEDUBqUu2clnznn2vBiC/eU4U2NkdLRnoyQjw586DDWwcLG1Fq2BLKPJWssElwAsPo6Cb8DpqOQRMY9UYc13xV86oJHTeoo6RC6Uk8i8ra5FOGdTzbzNK1bXcKN9YXNHjoOqvA1dChNWjx31BB+5HCXXzrjDAimGHt0SxLMgLHoYIEo9U2kMzh4dwn4gOFCpcfMmhT3jgrqlicR3OZGHG4ci1KpepHEdOW6ppd6kf9vy/BaMqQRsRVgaQiR0anLJ4Lt4TZDz7un8uNc+BCbHIg86DGgGhAi9+XDgLdphV8bP665TCY55zqcUJqgB4lZ86v7qYaNVgY05lTfXsF6m/Dl+0jXff50XIGxtUebZs7QPW1NluuD8apRSevYe4nfYj0HX/IrEubFE7SSWyp3P0jWvoztd724UxkXbtVBIeeYLkDBMxWnnaYGZn9SSyUCOgvfh01N8EEK2RL6oKVd6gGmmscfTg8M10pNgGKvIiKHGLxS5hZkO3Tv+RX6qUIg00pd4pDdAmbQVsphkFCahmha6S3KtjbuoPq7PofCO9q+8KWDC35clod9vhQrcVa6QM/nvzF3lJZ9FWONBSav+3EM6FQAZLpFnHITgIk1k8fmY4FVbEXpBpap93XJxDJth4rxj11MgqlWvaeFwvpZs+paSCdl7KbqzGYxoVQvw4Afu3t4Oa0RhXTltga1aOVvtAXLLmIC8ghLyIvNPPsxD6fCalXRA1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(70586007)(70206006)(316002)(36860700001)(2616005)(426003)(26005)(16526019)(86362001)(336012)(8936002)(186003)(2906002)(47076005)(36756003)(83380400001)(356005)(4326008)(508600001)(54906003)(110136005)(8676002)(82310400003)(7696005)(7416002)(1076003)(81166007)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:35.9112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3433a568-fcff-46af-f666-08d99adca877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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


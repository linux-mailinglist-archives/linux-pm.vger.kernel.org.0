Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723354187C9
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhIZJJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:24 -0400
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:35680
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231321AbhIZJJK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:09:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQDXN2EbSjsoh4R70Oet+xkYjX7p/Zb3lHMf8IS/kTHtAOoU7jEgZTE+dBoWxIPAnrNLIvTkDN9rrI6e3ra4PQAvLRl0OkBoiD1iX24Av8VMVDaSg7kc/DNjuKcqNwZ1YQHvjXyqRTsr49b0DFpnI7KDJbJ0ja/ViOFtdmng8qAMoZ9b+nsiT/LWVQTi7pmGJF7MoyB38v3UVjg2EM2x5GBfhI8QTloQy6IDjwRCPpd3brswnsh9jLHMTEqlCzgti48dQFRgV7LA8wiFmaBk5ZqYZZFYw4eXoVPUAsMmSVQHd6cgD9c3valB2f9wHChf/cVzTAOdFw8JMmcwy2A0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JcxEzM4rnHy67HV2hgOvkc/C/omrcf+HN6ySnnoV0C0=;
 b=E/8CJXG+g0sKfEeS5ejRnoWupbBSggHA+FtRZtfjbmiYZPx+0vAnZEnQnCTF93W5ha///APgUw4IndrzbqwPNZmwRS8336NgLhYDLdjN6wXNVdeOyw7XM3Xs4rEC3yOdlhktf5q2zMdvspbfIESxzDRJr3FujIhssF9sU0bpAj+25oIMEYmq1GngP2/p4gP07pSyPmUqmDhi9dpBXiUwJP2QyUrKybQB8pDkLEB7NEJgMGiQpyMvMJtZ31wkgKnat7qzJQ7kPnvzDxhG4AWRbu5QO1htVIScULUTf89UTjPSsrNR2q6wzHfo0bFUCTnpB5RK7td/fAUIYWHAr1pEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcxEzM4rnHy67HV2hgOvkc/C/omrcf+HN6ySnnoV0C0=;
 b=a5rpdyR1mXSX2+rpsUE5uQ+e9Nb9gNVhJJ5kvgTJZ7GtMmt8p/cuIIXr1qaraWF9RrWfRkDXhB4JPNZrQSRBQ9KR3F9DRWoOPugyr6TteI0rrhnV1kvDZ4azRxIVb9mvMYdbmssCHZQcxSJP8GY/cZb95pL73qt/PIs3rGcOBWo=
Received: from MWHPR04CA0052.namprd04.prod.outlook.com (2603:10b6:300:6c::14)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Sun, 26 Sep
 2021 09:07:26 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::3e) by MWHPR04CA0052.outlook.office365.com
 (2603:10b6:300:6c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:25 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:20 -0500
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
Subject: [PATCH v2 16/21] cpupower: add the function to get the sysfs value from specific table
Date:   Sun, 26 Sep 2021 17:06:00 +0800
Message-ID: <20210926090605.3556134-17-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae464b3e-17a7-4a0d-64cc-08d980cd0ecc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4244:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4244514135A1D564C05E9037ECA69@BY5PR12MB4244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9+Avo1feyQkJ3ndkaNGJfx1BFfI+TT6uTCxhM0GrbjkGTDMQx2wfeg6gTgehg/Dgh4ngwvqvny/2127vXmyoLK1uGI6PEWwyp6UV/zip4dw3tOSQJhdqUJOOSHFvmKfhaOhYzrk3LMyOk/OhTLxmZGXBMySqDO70wcfuDzjd5T3tZXZydMJBriIMHNUec6OJPs4eUM1aYgUu+R/kgT6f/V6B41j25EJjpYlaeqeB+o9ZtO9hDPhL1tWRL/xLUZ/4DEtVpXwoBlT5C71/SSA3ZwbAUcnhSDBd6QMahJUdVGEcDssW/NjdQ11k3SAp1MMmULvypcFdq/fZZG2iSHu5G0uGOEK3FwjdnfS6K+CZgwoDmVCekD+n5uBjzB52AIMyQZy/ZjIh10uH1Xe7N3MkVq9oCp8Za6sf7X5dR5MDdNXta30N3C12nPI4L9qQD9hLS+8FiABSVh2DaPVPSQJ8XnWhYWi04KswEYuYMhCn21kFlNmfqqccB88kltqmceZeKPVEfBOHmISkJgSMBGsPMo+t3LwI7z+4Kz5RD3D7WGzvLgtFKnkBIA9xfSVmiIedie2fz4MI/RlvtiXKKSA9teS6cHKWHOsSzyYDwshxaz1G0XfvL0QbnUf7dDqbx7fRw4i4eSfH00ws5y2IeXHxATJGH5m9WcoHAIuDc6Kb2sGpEu12Himc4pEH5wEt1WmRB6V4VrTOt9OFxQ7Hny2t+TakDhAmTWHfNLUPdXiTfQrvYzLM2HcYt2AA1ZnM7gZxgmqnnHyG406ymXcHyx6nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6666004)(83380400001)(86362001)(54906003)(5660300002)(16526019)(36860700001)(2906002)(110136005)(316002)(336012)(36756003)(8676002)(8936002)(186003)(2616005)(1076003)(81166007)(356005)(4326008)(26005)(70206006)(70586007)(426003)(508600001)(7696005)(47076005)(82310400003)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:25.2933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae464b3e-17a7-4a0d-64cc-08d980cd0ecc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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


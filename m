Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9F456D77
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhKSKfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:12 -0500
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:12704
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234765AbhKSKfI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm6mfdW6UQdZp1MYrKPyoF4IqQz3VfehrVWZ/S0Iq/jxu/ZLvief18aMZf2IMR7+xSvQMrUUl5jmHPwfla09eyiAzdh7G+g8sDbJI82YU/jkGdmvOBpHSbQizegD8FvnXBHpeJ4qtMXEsvHeKga4TRbJeMbVF1qcBVxNa8jkoEx2ekLw0bAAnGvR3l8WFUWwjD5lZZSCofpW7sfWLJnLtC2jhWVwFIUYHecpEYAh2SRqgLsD+Ext1H1vY1Ut3Gi2cHTH3LlxRm4yf0FDwA4zglfci6yMHfDAAf1PqJ2XtfZMotmWCPxU9kuxBgYHqklE2EVSzz6D+6pPQYy8qFv7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWkb2gJJa01lVW9tULlBzYKUUQMaGUZN8bXnAgokfoU=;
 b=FNZaog0e+H3Cbj/2akpKwbgJjDMBjiagnERQxRPpF7Hl0b7jq03E5ZRbFGfIvtYSUV9SgwWmiERm76oMYR2Azz9omwqMHSzmc0ws/k9tQ1A+JtOny36KKKjrWJiBisau/do1spJOHD7z3fk+7MASAf+gHHwOJ8so+jSCznEOXDk73LUroY1sNdSbqurmW6JqVi7KUWHeDSQgh/Fq+HxpaEst1bixFCQJtfbvo7O9yzncRVxXG7hWYe0AnKH1vh7OQ5ctg4eGVu9misK/1mzAhSvUwiZVofjQJ6H6RfblPSjo7Gm+yZVwnhumBMvySKNod1r92r7kLvZ0ksgGNNe6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWkb2gJJa01lVW9tULlBzYKUUQMaGUZN8bXnAgokfoU=;
 b=YRChxDwwWtIsRn8UwZmSCXq3cvmGsZF7yZdT9tS1irwuJSoHZKEQdb04xB/6oef3SrrkJnzU365OIVE+Nzv8quaOGq1jGt5qy2cKEyM1folb2C0pAOODp+I2X3rj6btN9kYUI9aSotTVDNt5reqqYMkyhSzZ5qdrzp2dORcKoak=
Received: from DM5PR2201CA0005.namprd22.prod.outlook.com (2603:10b6:4:14::15)
 by BN8PR12MB3330.namprd12.prod.outlook.com (2603:10b6:408:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:32:04 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::8a) by DM5PR2201CA0005.outlook.office365.com
 (2603:10b6:4:14::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:04 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:31:59 -0600
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
Subject: [PATCH v4 05/22] ACPI: CPPC: add cppc enable register function
Date:   Fri, 19 Nov 2021 18:30:45 +0800
Message-ID: <20211119103102.88124-6-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbee7d12-7494-426e-6a2b-08d9ab47d453
X-MS-TrafficTypeDiagnostic: BN8PR12MB3330:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33308CE86E0830C87AFC0404EC9C9@BN8PR12MB3330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjweivESxgLQYY/KnaBZh9XiswSnaF69f1RtVXMaZSGRur9UDWLOpqe2rsObDyMdqvUpCu2opDv6Z6rIv3WpuQTB9ZePHoqBGlc83AcemcLaih1Aa9m2OEpyglI4fhbyq5C9wKvyzVLFzW+BS4Wy+EHrjlBlb9KyqJyvrBC2Tc3wrSamCi1JBJYhsuFGAIu/Xgd/nyQp6QpFs/h7guM59tVu6rIfBGn1YlrRdbkPs8yb/hWvS8AzKfRexYk/y2GCm1iMPyrXvfzFTeUf/dXrq3WIYIJbw2b2XqX1E3sLKb+rFRIggtNToyXBS9egdtRtgg0HtAqt8iJyc5RZmX7YU7Mtj7uNFGh49/tP3z7m8yoRYxr/2LvJ71b2//oQD6cPUr1rFICYNgeiXpqZLL0eLZkbaLyLvzDL1A5stqmCN8gwaZIwi7+dtvMenkYfriX0NQqrI2pFwN4Qks9MMDQNMYnVkuMeZVeR681V7YVbqLz9ZyiFPqgV6PDcBQNhd8JmmW3Jk7rEUfMBP2g779JQeqwu9J7dhodxjKvbnCeA859ZGjzoEB8sBBxIku8ro3IKvwyioeysey84WRy40tTVuX/fWMUe7PE+gqXIaodaLclfBuC5RfMZ6bKUUupVm8iYPPxEIUb8Mb4ajaiKShDKAUse7TQeZIHGbN6/Css64sPeOSypFSQyX/xrIuAvnfFk164Cy1kpvO0N0HHNIEfk/k/TwFG7VlxSzF3prm4HAdk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(508600001)(47076005)(26005)(54906003)(36860700001)(86362001)(82310400003)(5660300002)(316002)(336012)(2616005)(186003)(16526019)(7416002)(356005)(70586007)(426003)(7696005)(8676002)(70206006)(36756003)(8936002)(1076003)(2906002)(6666004)(4326008)(83380400001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:04.2040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbee7d12-7494-426e-6a2b-08d9ab47d453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3330
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jinzhou Su <Jinzhou.Su@amd.com>

Add a new function to enable CPPC feature. This function
will write Continuous Performance Control package
EnableRegister field on the processor.

CPPC EnableRegister register described in section 8.4.7.1 of ACPI 6.4:
This element is optional. If supported, contains a resource descriptor
with a single Register() descriptor that describes a register to which
OSPM writes a One to enable CPPC on this processor. Before this register
is set, the processor will be controlled by legacy mechanisms (ACPI
Pstates, firmware, etc.).

This register will be used for AMD processors to enable amd-pstate
function instead of legacy ACPI P-States.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 45 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a46f227dc254..003df9fba122 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1262,6 +1262,51 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
 
+/**
+ * cppc_set_enable - Set to enable CPPC on the processor by writing the
+ * Continuous Performance Control package EnableRegister field.
+ * @cpu: CPU for which to enable CPPC register.
+ * @enable: 0 - disable, 1 - enable CPPC feature on the processor.
+ *
+ * Return: 0 for success, -ERRNO or -EIO otherwise.
+ */
+int cppc_set_enable(int cpu, bool enable)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *enable_reg;
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = -EINVAL;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -EINVAL;
+	}
+
+	enable_reg = &cpc_desc->cpc_regs[ENABLE];
+
+	if (CPC_IN_PCC(enable_reg)) {
+
+		if (pcc_ss_id < 0)
+			return -EIO;
+
+		ret = cpc_write(cpu, enable_reg, enable);
+		if (ret)
+			return ret;
+
+		pcc_ss_data = pcc_data[pcc_ss_id];
+
+		down_write(&pcc_ss_data->pcc_lock);
+		/* after writing CPC, transfer the ownership of PCC to platfrom */
+		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+		up_write(&pcc_ss_data->pcc_lock);
+		return ret;
+	}
+
+	return cpc_write(cpu, enable_reg, enable);
+}
+EXPORT_SYMBOL_GPL(cppc_set_enable);
+
 /**
  * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index bc159a9b4a73..92b7ea8d8f5e 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -138,6 +138,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool acpi_cpc_valid(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
@@ -162,6 +163,10 @@ static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_set_enable(int cpu, bool enable)
+{
+	return -ENOTSUPP;
+}
 static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
 {
 	return -ENOTSUPP;
-- 
2.25.1


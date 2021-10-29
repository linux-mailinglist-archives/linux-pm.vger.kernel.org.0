Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8C43FCEB
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhJ2NGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:06:21 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:52033
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231675AbhJ2NGO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyRcwCQK8+3GcmMqblC+5XhSKhXanOVzrUy7r0Xei/MsUnJeozTU0N0s4nzbKDNN3uteGTAI2DTiN7G6q2i5Pwn/jV56K6xIl2maG6lyao5TQKCw8xGu9ab11qypUN0okVvpH++kuPSy3LywENzhI7z5nXhSiQDd/KzAsU/NCWvBQcsJaExKGkIv9DN/XkAkrl23/9pgYEOwLhJ6Q1FPtcVDeukRPRH9Dcn6Y1hotOLVxuBdeo5ff7uAK2fOFkbsTbH/nrOo9+v1N30V+BbKbi7DRI5Sd/y2e396jo8NMpS4t0HfAEBUbeZZxe02hHw1Liub91dz87AmUm2Vt79f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulqWiFO2OQVl+qsQNAFOw9lFRIZakoliWCa7zqH7RTI=;
 b=bY0RFVqo6KgENFy+yGe11OGorIBor28jiWzPL78n7oNu0bCkUoKktrQe+R5NkzMsLM6mGEdgqMPp2nB2vp7oyRN4oJbOrnqIATbRxvhoopFNrCQl6uIdgpWA4c7Kzq7wtj22hMaQq9jVqUWDk9BxgRn1I7W5x9Ji7xSOxruxyPFKd/1pUjaNibB+86sGfJbGWS04AtVTaQZzhwmfN2ehdEmIYiBj6zCkOB374giujjAleMei8FKcdGsaYej3FvMrVei3Q+X9kQWreGENuCZwrj5QdV7uEX4ESDd4Tzet3XRu8yj/azd7xzqCto8uz1XU7IQvXG9htMweK5y2EJoo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulqWiFO2OQVl+qsQNAFOw9lFRIZakoliWCa7zqH7RTI=;
 b=4qSSFrXbgV6CSeCwZDOJk8LDRo80kwN2SdLVEtnNuBdeBpnBeCOCBgjsiKuAJdKRIY9uLUzgbeZOpNzs2kw0LUDFIH5INOE8PXAbSDav1GXxsmN7jbPB2SI0IfCv+LIMmDUNg5zKF0axVZwzJlmgMmtSKHXwsockcICZ9jEHvlg=
Received: from BN9PR03CA0574.namprd03.prod.outlook.com (2603:10b6:408:10d::9)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 13:03:41 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::5f) by BN9PR03CA0574.outlook.office365.com
 (2603:10b6:408:10d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 13:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:03:41 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:36 -0500
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
Subject: [PATCH v3 05/21] ACPI: CPPC: add cppc enable register function
Date:   Fri, 29 Oct 2021 21:02:25 +0800
Message-ID: <20211029130241.1984459-6-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 393fe9d7-e514-498f-25e4-08d99adc87ff
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174905312A87CB7347FE626EC879@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E38YsRBVzyyKD7mx4SVSEWG07TmpGhDqPtLaBZUg41mpgxuQxxG+nMFZHdc93CKkbXGFk9/6+13uLdoIMd3qHXr8qLBSusAHV8m1FknmKyKlyd0ArTzdXzxqCspRx3gNUhVYgR75HhC/4kogzy8EKaQj0UOodEPHoBq7J1sM3VxqpC7tHX2ByX9nMc8Hw7740l8FttGkjw6XNjjUYAzIkU+Pj3FTDb8KINxaMh47EOehpOIUL6DeCfEqVZ8WmZamO0sbnN3MayxAov+nn3HzyEjDGxUSBj86YmuDEMVTobTDcQL0Em5OSwDnHMfG8aM7V/2p0BlYJLoQAx6MMt+/x827AbmicZouIRQB5LoaW+/FUNmCz0wR6v7NJv7V/lMXWs50CsO8fg+kkzsInc5HAhE/ULrIWlGMlIq/6V5xeGXiGwYSRvYXsADbRA1TnzPFJYrrLQdYIGqHt+Q7Ui7YrcoItgwHMm7+klo6chP36Ag0aGz5mTHYiZ1yNq9g0xulf6J8JZsTgEegouLRfgAr84SXqu3eVcABWCJtHkg/jpX7gjBjFdnfn2cxNipQfz85TfYjm9kvbZp0dqziVkMbOsxtzjtWtkkvhckA5v5mwUcjp3CIcoXLBc0/8SPhHHVivN689/nPbVBCr4CHRQle2qRZK63f2xNC0unJS/dbNT+/gfsgICuBhoqPPAtICE9d+Da2nqTrumPewmeR+yvhMyi1HrDjolhDNDBdRyEsOfU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70586007)(186003)(16526019)(7696005)(426003)(70206006)(26005)(5660300002)(336012)(83380400001)(86362001)(47076005)(1076003)(8676002)(2906002)(6666004)(82310400003)(36756003)(110136005)(356005)(508600001)(2616005)(8936002)(36860700001)(54906003)(4326008)(316002)(7416002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:03:41.3884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393fe9d7-e514-498f-25e4-08d99adc87ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
index c9169c221209..2d2297ef5bf9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1275,6 +1275,51 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
 
+/**
+ * cppc_set_enable - Set to enable CPPC on the processor by writing the
+ * Continuous Performance Control package EnableRegister feild.
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811D54187AF
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhIZJIU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:20 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:54752
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229848AbhIZJIU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcObNrPS5Pz/oOobj7EKE/cuQHf882I0isLTP5WR6XbHFI5U0HvnlummqKw4VAT8d5qcuK98DF2Sz62kUlBcDFDvPLRgWxWMw3bxqAPb8/kaCPVwKL0L2TclaepI41vnxsYUmmY1wXUeXA7QjzW53Qdskw+NaZx2lut5cQmMrANaBh1lmR4OLGJ3+b4GDJyfRTKF0FQYX6ONgnXlMozlCqRM1EXsJvyjXf/ObCz96OQ3dWYd3rfaPVarTFB/+7jp0au0h4ta9UR9/xL5hiV3zyGKWGHZERrsi58Tt8DhWOdIRByq7CxxTccJsWnaM/qnZRhew+QI4flPwEucodLMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Nd+AttDycePBZ3qR2Uyn7r5GGKiySFYm2ujubiIE2vo=;
 b=WOV9oVhIo30bVq12H4Y6b4ZQjV6F6/YTKeCbfQ1dLVbzrOjuErokUzVpZp2n43t1gm0axxUrduLoWWokIZgDxfXXTVmXYwileEDMWpPwCJH/PWA092f8WsVFInXbe4bhKyDXY82HukIqxcGZ4kbPWGILEGDZFwBatubTLKRGPVS7+9s8Ukxbm8LZ/qRWmyPbGoxTGuwg+41ROWrqrrNjBGE7q8n+A7UsIiCJPOUFOTT8hIv/BVlqJfpdWwTJH4QwPo/N0o7yJZzteJpBE7sZW+SrbqTlFJ4pAeZ13nl+W85drccvvSqYEgRr+qIDiJ0MZHZp0ed6aWlHKHLjk4mXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd+AttDycePBZ3qR2Uyn7r5GGKiySFYm2ujubiIE2vo=;
 b=hBFec7oKy9S6rZLRqFnC7ZhmUees0Rp6fPuzvqPbFliSsMq0RDZtRtCTkvcQUezsgR4YJtVsi7YaRCCHEG26hGsYGTgpigWdHtC3TtJWk6HSmFn4EtdyEfJfqJ3xH37RwpDZFoBGAmXTORfvRun+xj9a5VpjYlfi6boov/e7X+U=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by CY4PR1201MB0056.namprd12.prod.outlook.com (2603:10b6:910:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sun, 26 Sep
 2021 09:06:35 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::7) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:35 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:30 -0500
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
Subject: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
Date:   Sun, 26 Sep 2021 17:05:48 +0800
Message-ID: <20210926090605.3556134-5-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1cd0ff20-b8d4-446e-15c0-08d980ccf10e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB005669894003379A34DCB8CFECA69@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ijt5rMtqCjdyxGTH1aB7cdXciK3uEEDBV3zFKxpNu8RS+n4j9GyuEDPlJO1fAw8K1p7WadUmBb6qr2+1Ygssgjs4B0IagrPH4qqv04wlDP8rMOJQLNayIvmbphAUK4Rn3PKBMEf9oe+v4dfFDWOEksPqCAq17a2LVf/PG4U26UnAvc9sYk1mU+Hqq7NOpibsIr1Gac9gP1/Mu+7az97a2zECT/WhWnx+6dshlN9obHUsQ6RyZtGOOVzRur4VEDAWhMAw23im5SxoD1loWQkE2w6B8O9X4EX0TMUCYpra7bW3ZgZH2pBefZJkVJVYxbB6PfA7Esgls9qii3u03bwSQuNBdWVvLFZF+DGKXBrNmru88yyP+64mwO3uYivRNW+ALpn4WVh6ZAp6KJdNzZO4IqXfdAzY3zp26K/LQiPin9d4x/w5bN06yNYaEMY6hLgNYsvRKkpekrZv4n5ykITDOSOkI1EyxL2xJ1haNEhNs9fZGqHPJn4OaMszfbLDpB5ImFZSfCE+E5vvBATYCySIf8kI6MjuuDLbNiwbYMg7YSGDlzd4vFSLaLUqnMmkkyb/bi7B6ceCCQtdaj8vJZpFXb5FsIFAXesTDYLvyHTsU1h0cdMyJniCW3k9UIvXN5ey7cVO7kQt75SLRBu+wVGg6xFJpT7pr2s4lDFFJpdD2BRNjUt66qifO7lHsyajpHJsbHj0ZofWBqbKFkd62TLt2qafDPTwRhJCCNY9n6KGIA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(186003)(36756003)(336012)(6666004)(16526019)(70586007)(70206006)(36860700001)(110136005)(8936002)(5660300002)(47076005)(54906003)(26005)(316002)(4326008)(7696005)(2906002)(81166007)(2616005)(8676002)(426003)(508600001)(83380400001)(82310400003)(356005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:35.3932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd0ff20-b8d4-446e-15c0-08d980ccf10e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jinzhou Su <Jinzhou.Su@amd.com>

Add a new function to enable CPPC feature. This function
will write Continuous Performance Control package
EnableRegister field on the processor.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 48 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2efe2ba97d96..b285960c35e7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1220,6 +1220,54 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
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
+int cppc_set_enable(int cpu, u32 enable)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *enable_reg;
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = -1;
+
+	/* check the input value*/
+	if (cpu < 0 || cpu > num_possible_cpus() - 1 || enable > 1)
+		return -ENODEV;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
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
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_set_enable);
+
 /**
  * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 9f4985b4d64d..3fdae40a75fc 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -137,6 +137,7 @@ struct cppc_cpudata {
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_set_enable(int cpu, u32 enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool acpi_cpc_valid(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
@@ -157,6 +158,10 @@ static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_set_enable(int cpu, u32 enable)
+{
+	return -ENOTSUPP;
+}
 static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
 {
 	return -ENOTSUPP;
-- 
2.25.1


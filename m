Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02133403C1B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349550AbhIHPCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:36 -0400
Received: from mail-mw2nam08on2077.outbound.protection.outlook.com ([40.107.101.77]:22369
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351992AbhIHPCR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPfFtMwPL2S8BwNSYlWdVApMxLwAD+VM4fcOhQY6D/xjTEB/ubbw/WROKEJhcj3CxWgfBueIHMng23wLDmeTpBXU1+gX+V9yzfNYggUYkB+7GLQzTxyVr0GbKvYKHcj8GQEgBAoxgJ1vx+2nffX3FgqxJubo/bqE47CtrQux7LCTepjsQQTXQL8PIwNj7UDqJEq/cZEzGIgMK61BC1LNux0zjJd4ETxkO/SXWhYLxrs35Py1P2JuWhumPThTZfvmIavot+1nbN+oCIIgGhMtwJydXZZqX9h9jRBMUtdciP8nQS31cILkkGMUWyzUM+GNtnQkfHwC1/dj4c2tx1cwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uUKPiXN0BjWmKPdmk/FZ66q/4HDuKnMNTn7hDLqR47Y=;
 b=jsv4o1ziVruwSkXKTOrY/cibQf9WBAu8XGvzlH0wVeS70nowIE90KegpuF7xr5nUDoHJgNLR7h6hp1XQPz3mk0rAaoDLdGoK0/k4zGpSwqvOPlRxE0otZ9h9tDmLEe95+ZAqNOR0ugs5zBPby1Qy9IHa6hSDYe0Aj2mrwYf4ICTKYsUNnysj78JZoa2IhLOTZ87B0NggwjqYoP22CKTxvlPdIexfsIhlF7Y2YBjFVxU0Z1KSNUJwfZzMkOo5xrkP7RHdVjEQbiQzbIpgQJqP02cYdhlPgvMR5nvT8EPYU86eekEoYZ/CjJpl8VvwlcyvVghLegz3b/cFhZZA/BSbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUKPiXN0BjWmKPdmk/FZ66q/4HDuKnMNTn7hDLqR47Y=;
 b=W78/f6aNmn2Qh4AjT66R5ctiufMZ3GdTOnnrHE0j4d38v5DtHofR2rDuI2h+gjkAWKQseOrmtMT4Sdu9rYjmFEU2KrwL5dDDz325dSIB/QAzENgZnqXqsNZcH921SlPuUJ8EhjwyagbXFXSw82ksScloByuER6IrPECM4ngTEcg=
Received: from MWHPR11CA0038.namprd11.prod.outlook.com (2603:10b6:300:115::24)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 15:01:08 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::e9) by MWHPR11CA0038.outlook.office365.com
 (2603:10b6:300:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:08 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:00:57 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 03/19] ACPI: CPPC: add cppc enable register function
Date:   Wed, 8 Sep 2021 22:59:45 +0800
Message-ID: <20210908150001.3702552-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908150001.3702552-1-ray.huang@amd.com>
References: <20210908150001.3702552-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e77b2fe8-9366-46be-a82f-08d972d97d15
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4203AFD86670B8C8BA682175ECD49@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqsj8A/X89bopYaXeEgRsj+hfNEzJ8pkcD4vhf9MV/8BcQiDJSKCFrOyD3DKsVcoMEpx/NWhP1COaIQD/+gBx/j88utC33jpPbPQ4k2pOeyOOBCEZlenXwSunF5VfDJPDCqGmNoxFN/hfD85LlSip2mGQkPEk5GfRRZF+cXa2ihJgHJPlZVekwOVe9ATjBi6VAx10SKdFaax97OniCZlJ49wM0hSCYutr/0RRd6MxbPHKOvLSFsGgmGnfJ2QJZgB3znS+vkAr8vIlco/m8ezUO0XmUWFIYnnPz2vLjNqKWjsRDFBcLWSCj0DAf9REsMWcpdY0AcgPuI7oAOSHS19x4hu+4ChklYdWwJac6+7xc4YIKyBkJVb/RLbN4SrxAFcQx/dW/itjVg+bB0MwTGJ08VD/sSqTuprUh7n8C+gHl4TN9/sp8NP+q9vUNFSRPhnNJjy35t33vAtD+KeQxTpvWd5GVS52mSD9E4CRHXwwCsVL48MKfmG9RTPbfNY6NvKmMgeueGAWrwzk7MWaevL2YyNNfvzMD+qz4AhaFPxPnnHtVShSdYMFF9pRYdHOfg8+zd7sYW2gWP2wirBrrNjz8SmwdN+DMAGiogRFeV/FQvP0BU3YV0Vvj/hKB73SuQCjHbVJ0Tr/wOLktFIjgTH+O33WUeaYg6cRY78JAP7Fz5T9//wG6fQpR845vojJkJRE46O/NzZOktltROqtOUi29i/toZ4Rg4pcvVXwGuQLBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(36756003)(356005)(7696005)(1076003)(54906003)(70586007)(110136005)(81166007)(6666004)(86362001)(36860700001)(8676002)(26005)(4326008)(47076005)(5660300002)(2616005)(316002)(16526019)(186003)(336012)(426003)(8936002)(83380400001)(70206006)(82310400003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:08.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77b2fe8-9366-46be-a82f-08d972d97d15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jinzhou Su <Jinzhou.Su@amd.com>

Export the cppc enable register function for future use.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a4d4eebba1da..de4b30545215 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1220,6 +1220,48 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
 
+/**
+ * cppc_set_enable - Set to enable CPPC register.
+ * @cpu: CPU for which to enable CPPC register.
+ * @enable: enable field to write into share memory.
+ *
+ * Return: 0 for success, -ERRNO otherwise.
+ */
+int cppc_set_enable(int cpu, u32 enable)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *enable_reg;
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = -1;
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
+		send_pcc_cmd(pcc_ss_id, CMD_WRITE);
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


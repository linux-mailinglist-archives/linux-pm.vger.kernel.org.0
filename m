Return-Path: <linux-pm+bounces-9053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068869064F9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39921C22FCC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B413BAE5;
	Thu, 13 Jun 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sz6wZTSG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4913B7AE;
	Thu, 13 Jun 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263558; cv=fail; b=KSDRHEMmcQ/gA8oau7iHiP3WMr87RmeBB7Szd2nx12UjrTRyzOgXc8Yfc4DZ6y2CSjEaY6YYZkecBLi2gXqoSXpato1jZBSlWgxSa60yDYr9Y83rEQs8jFFiFJC1vuynAGKNWgVuy+jGsDtwz9UBmx/Fig9BWV//WQEuj7xuqSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263558; c=relaxed/simple;
	bh=nr5wynFq+liy8ngfVfVoNT5ybdINz7sxTUrWnZiB/bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULI4dPAxfyv14k+vIvfbYxmdMcsjtcnzJ3cDCr/N5w460XoF93HN0sKQOHuouYtdmR0sNdAnmW7jkjnUvPnzlOgYCItWETRMQA0CZcDCM139XUnPmWz5ONdk+6ZJB4z6ZXy+4k8ZrWfpR6aoEjod4w3r6UL6y6ikA1QIoHxI5BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sz6wZTSG; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrGLZ0hRg+FhQTLy1+9vd5cq8qG6XItex6ey0NZRT7u+mXGgLxyCDBNnGq+BkcbaZw9osJT3Cw4FaccpO1P/EQK79nZ4+KRoEy26zNqlF17BNgBtsCsut/q5ZA5gavHMF1j7OQzCR5a7myeIt2AmAUmLfay4nfZcd2Bk9O7BGqSxnk8V/HZmam+ShphC3+ysMUALp/ots2Q7BCvl7Dvq8lOqMVQ3XScq1numjTXo8IKBWxQzKkS82lRJZaqjBrqBz6Fl5IUVGIzTbI0ze5hLc38sHOvDG7QqKn4gRzGZoUmLQN0XG1MdWIOwVAP9SOHbmDXV22YH2bmgKFlWtG8Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eCh20QlPpy5up+Jj5cqWd8yzvHFCHXYpaxzehSXorc=;
 b=K6XS6izgCOZu3kejnLWyyzAhvP0AwGwmfmR/NAuxH/EA5N0x2S7U7Ljogvup0hEfBC5G4Ji/4ZN27IxTRY/dHBda5OWjajcCVFRFiiDaw6lU3TguKGz7hvTx+uaSIAYCjriM8f9HJrGBvzgKEFU+BRNi0B05kPddRqStBlMYQ6L4PdZsyf+6VZzBrVd2tl0pc4zyEkdk+UtzqOnfyoGrHM+gZXoVr4VbByx4uLACU3bPVkNe5kJsbxqD8QcZSnbdj0cyHlPgB1vUvwybHA4/fvK3utaAW1FphQEW7J6JXPHlf2mRfQ9+Fsuzsy+UZ+vMegz+l+VoLpoKc1QSZgOdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eCh20QlPpy5up+Jj5cqWd8yzvHFCHXYpaxzehSXorc=;
 b=Sz6wZTSGU3kAHvdX0lnl7ue0JSvJSU1rizGvcLqLIpOF0bqzj7vYelvDnKMxr7D0fgKPTDnqWS0jhOPhIup7aPdsoMapNaGbrIRbI6/G4zmGittqHPUCiW1JpuxA4zf6+GTR/E6EPHk6s2UZomGQGZaF2/hsChFWiKpWfXTaQfA=
Received: from MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 07:25:53 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::6b) by MN2PR16CA0026.outlook.office365.com
 (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 07:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:25:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:25:49 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 4/9] cpufreq: amd-pstate: initialize new core precision boost state
Date: Thu, 13 Jun 2024 15:25:16 +0800
Message-ID: <b5faa3f5e27a5991402c356f8dfb8299aaf03a09.1718262992.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 1282a955-f243-4c11-1d36-08dc8b7a0f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|82310400020|1800799018|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j0VtqspJE8LZ3tD4lgXC90SSr6UOEeE0XT86i1OLNKhYCET9QmXGiPUZx7a0?=
 =?us-ascii?Q?2C1ZuJsdyEAAgS6cwQldcOSwTq/ZEFOd6jfT+jlUF4j2Pi50+EJnCNbzFmEN?=
 =?us-ascii?Q?Fck1oo52LwtiYXQj251AhV2X/6zPSVlcnEllyiqh2WHf/pMwuTPY9R1t5Xho?=
 =?us-ascii?Q?ZAKZC1fOeJwfQcXls3P4AIWwv0MVEU5nXwAygXVjLBqJU4J3SbNozuDSwXFd?=
 =?us-ascii?Q?a7fTIlTaPx+aGg7vywHBzVRVRXfVSc6zXNsucKkT98KmXv7GxfaBd+lSmnfV?=
 =?us-ascii?Q?N1kS+V02qC76ZVGF/syGYCtDy6fzufE22/3WtDem/NUQNfNWF2dtUiq+gGQW?=
 =?us-ascii?Q?K/KumK1SRaUEp+YiyoAEs97GZj8sVOuIrg+Haoy3whzoxyn708+Rd2X0QLtm?=
 =?us-ascii?Q?D8UaUEPSGwS6S/k5Et48N7XUWuLcTU12W+ykBH9N60Au79oDrecScds5PqDj?=
 =?us-ascii?Q?zwzGVPFJmYGy/P3VUG+1ndzOWsYrOnT5KsgH83+w2SygStx7oJPFworta3fE?=
 =?us-ascii?Q?IcpOfiPxUOZBO+fcAGRk8mxxdCB3CCs/aoeiG4mAgzuRW2wRdQGYY26xCsxD?=
 =?us-ascii?Q?Ux0XLr/4Y+q7wfDlax1991ZPqc1B4p5YpNxOfz3ccjWK76bionVE00TtSy+0?=
 =?us-ascii?Q?RNpdaQ7vYfIFGNrEosStVGWdGwwABnNhwlsmWlkKeOQoOa5RRs/1o12rqP6+?=
 =?us-ascii?Q?RNU92BHV4HrNbIHL7cXj+PoF4GYIWAE+JybCRN31BXVI8G9FlbMbbSjuT3KR?=
 =?us-ascii?Q?pp5BgZN77LkV7TOezZYx+4CffnrumrKpgqYIXDEo7FTb5KUghcVh7MaM6UPu?=
 =?us-ascii?Q?peLT2ANa+vMxY1UASBBkUxy2XdgtUEyp9PwsbV45U5wzr6C+Zs0YGSoq3zFf?=
 =?us-ascii?Q?KteFHHCMC1OQSR1It7d8cysRyF8xZCbePowXmKb4rFoJy5lw+g9LNddLAGkC?=
 =?us-ascii?Q?bnvvF3jI3LFnJsb45oI8xUAkNrG0OhYfiYlwwDUn+Fd+V8cPAsH6RkZT8LrA?=
 =?us-ascii?Q?L/urWVrDBVflmWe4sTn1uYq0KHXuJx+g9e1VHIAkhCjQlnK5m93Vo7vVHEV4?=
 =?us-ascii?Q?1c/gQ09ktklbqPcnAS3xFH1lqolkokX7u9mP1cwIbv6M1wsNbqAW+XUOwlNG?=
 =?us-ascii?Q?5Nw9JDBAX1cTGh8kaWz6XuOW1i4zTb56WqyKvQ1w35/5UUi63CwpABWHBkO7?=
 =?us-ascii?Q?6xzvS/1b7atNQYrGOUosd7PLgy/GamlsBewbTrRixdun5c8Nn3MYbJKX+/FS?=
 =?us-ascii?Q?zjlGllC7cHIPtDBeZXdKY6rRLBoll8U3u80suTE4OgCJDpZW1oeVKoVCXRKb?=
 =?us-ascii?Q?jemPJhFdtnuXr6pfYvmqz4vNTJbDppechVIJ0NCIixtbgoGZhaQBt88tam2+?=
 =?us-ascii?Q?Bsl/XlE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(82310400020)(1800799018)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:25:53.4178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1282a955-f243-4c11-1d36-08dc8b7a0f2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566

From: Perry Yuan <Perry.Yuan@amd.com>

Add one global `global_params` to represent CPU Performance Boost(cpb)
state for cpu frequency scaling, both active and passive modes all can
support CPU cores frequency boosting control which is based on the BIOS
setting, while BIOS turn on the "Core Performance Boost", it will
allow OS control each core highest perf limitation from OS side.

The active, guided and passive modes of the amd-pstate driver can
support frequency boost control when the "Core Performance Boost"
(CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
has an option at runtime to allow/disallow the cores from operating in
the boost frequency range.

Add an amd_pstate_global_params object to record whether CPB is
enabled in BIOS, and if it has been activated by the user

Reported-by: Artem S. Tashkinov" <aros@gmx.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 59 +++++++++++++++++++++++++++++-------
 drivers/cpufreq/amd-pstate.h | 13 ++++++++
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fda8f86c90e0..9f42524074a9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -102,6 +102,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -696,7 +698,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 
 	if (!cpudata->boost_supported) {
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	if (state)
@@ -714,18 +716,38 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
 {
-	u32 highest_perf, nominal_perf;
+	u64 boost_val;
+	int ret = -1;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
+		pr_debug_once("Boost CPB capabilities not present in the processor\n");
+		ret = -EOPNOTSUPP;
+		goto exit_err;
+	}
 
-	if (highest_perf <= nominal_perf)
-		return;
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
+		ret = -EIO;
+		goto exit_err;
+	}
+
+	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
+	if (amd_pstate_global_params.cpb_supported) {
+		current_pstate_driver->boost_enabled = true;
+		WRITE_ONCE(cpudata->boost_supported, true);
+	}
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
+	return 0;
+
+exit_err:
+	WRITE_ONCE(cpudata->boost_supported, false);
+	current_pstate_driver->boost_enabled = false;
+	amd_pstate_global_params.cpb_boost = false;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -1007,7 +1029,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1389,6 +1410,21 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 	return false;
 }
 
+static int amd_pstate_init_boost(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_set(cpudata);
+	if (ret)
+		return ret;
+
+	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
+
+	return 0;
+}
+
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, ret;
@@ -1467,7 +1503,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
@@ -1706,6 +1741,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
+	.init_boost	= amd_pstate_init_boost,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
@@ -1723,6 +1759,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
+	.init_boost	= amd_pstate_init_boost,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index e6a28e7f4dbf..0b75a6267fca 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -101,4 +101,17 @@ struct amd_cpudata {
 	bool	suspended;
 };
 
+/**
+ * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
+ * @cpb_boost:		Whether or not to use boost CPU P-states.
+ * @cpb_supported:	Whether or not CPU boost P-states are available
+ *			based on the MSR_K7_HWCR bit[25] state
+ */
+struct amd_pstate_global_params {
+	bool cpb_boost;
+	bool cpb_supported;
+};
+
+extern struct amd_pstate_global_params amd_pstate_global_params;
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1



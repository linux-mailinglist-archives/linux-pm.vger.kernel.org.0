Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80F403C23
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352040AbhIHPCo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:44 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:47520
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351981AbhIHPCZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZtyFP3YClzfHuyTZNbVOdxbdBXO4sb7W68sQdrnmY67XFd3yX+O37pDR+gWdMv0Gle/m4XVVUv5oZRay1oWTnAHTuXxSwGLB7+gCbRqwB9rD1BiGhF9ZhzDUSuWV6daEB5ofo/rycYLPsYhc2VxzUk/LPftoYV2y25tKbCFMPFBImOm777IAIae7o4eb6Dg9isEACK9pMXPktfGmWUELKX3WEPrJ6NhtqJLRahXzJf45ODh+DKciq0YqD/oQOnYiehKlBJC120OikI+ohYsYkaG/PKGx+vRO9e6hsvoqkUYY2e+Gn7GwRheAXldQR2G42WD9zDtkP/iTvqMgVkRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kICpFLu37eoB4wt/Yx0uJ2udQSVOEfwp4F6L+dk7Wko=;
 b=hN1U2Sc+UocMxDv9ZXLYpvJNHFZONJ/hivRuvL/idgtaumD0Al0AFtCfbev1lML0JwYjKTVv0uTsZsVQrH5NWF/xj9N24rNK65NXdcYqdcpkILJjgtdn1y+KtyFnBRlDXjYTadhe1Hwa55RMU6gauDMevAkob6BxZCT8tVAGv2V6b5ET+jf6NrXhRAVo5T1aLV0lroCcsmYJggYPW1wNyazDLAY4P87sA8U9WZmghZ6+1pjPWHnY2eDFhGQSQtwA6dHJ71DDn8MUGAdYiJfYsIQL4812XLZEtgIogHLd3nDZIF2HByT8OPYKA6FE+qmZpSzmTdTJ62StHqTAtubhuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kICpFLu37eoB4wt/Yx0uJ2udQSVOEfwp4F6L+dk7Wko=;
 b=vJZH4p/7tFyh+aPFZ4blW78XaR8lKzH06ry0BoL9s4NogsKpuIahJpQ1AvVx0YP+AX9b8bTHt6whLXDwPuL8MLSHUpONDPpMk6Cgh76fSHgMrJ7DiVr5wNf2pCBGR5aW82lb9P956jzpL0hTL33zM1BXIApc7rSCsCOJOaHfdKQ=
Received: from MWHPR11CA0038.namprd11.prod.outlook.com (2603:10b6:300:115::24)
 by MWHPR1201MB0143.namprd12.prod.outlook.com (2603:10b6:301:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 15:01:11 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::cb) by MWHPR11CA0038.outlook.office365.com
 (2603:10b6:300:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:11 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:05 -0500
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
Subject: [PATCH 05/19] cpufreq: amd: add fast switch function for amd-pstate module
Date:   Wed, 8 Sep 2021 22:59:47 +0800
Message-ID: <20210908150001.3702552-6-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9751629c-aa0a-4fae-86d9-08d972d97f38
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0143:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01436B37375DA40D6602D665ECD49@MWHPR1201MB0143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Nr+Ib6p6gSYR610owIZbVKm1+izZ6SfCGolmTGk7J3VSTHwFRBeRLzNJfbW6XBLEQAn46xABp4dv3Z+e1D3aCf7HeNZOTkoJVxvQ3e/+Esg2iYVd2czC0FJ3cuGJTVGjeRIlp0cYGqSAoUggGmUX0AwAdRw8j0YHwTjzrFrxmzcjLpjNHdGadTMqhhmaD8YqR2uB/pRHTlEbumMLezyBJmIRYktxAQBl/U96/dKRUaiXaex99En3m75t6iug5xA4r8bNlGxddvz4PEy4fphbzxunC7JW6AOciJ2zPRMkjXMhvT755rxwkvUJeqfkX0aEre9l+EdcvDd4LoFaG59YZ+ExuIZx2g7Ac9iRLwpoWKU2tj7fJWSGQ6lWd11bvo30zuohEqi02+YDsJHdgcjxT71ZW1AeyldnymP6FxFlGftF0ENVGJ3T3olqwJCW4CGTztiCkwJQoLEiCRZzzjtuFSMm7+1SSay7vE3AE2BNk1zJyPsutWSrYd+lTP8pO0krTr3vMBwOS/bZSret8DXJEanR34/p5mvb7IodDDBnHHZDKJ2SyvcqecgSNFJ9QCzZoDryX4svUxZ4YpF94CJxNQE4k6vIiJDNcMljBU8n3TbW+tvyFSbtkS15XwupX2AIbgmoSvr/RB5HPXIBAvIrPAcdrNCnGKzAOIieoDIZvdvVLBWp4uVN5j+VgZcjvnAnvVtsg4r/2ugNrHctmVWI+CBAUuPIh4sQdcLdPYlEGw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(83380400001)(36860700001)(6666004)(70206006)(70586007)(2616005)(4326008)(81166007)(36756003)(82310400003)(47076005)(16526019)(2906002)(316002)(186003)(54906003)(110136005)(7696005)(8936002)(86362001)(5660300002)(26005)(508600001)(336012)(356005)(8676002)(1076003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:11.5847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9751629c-aa0a-4fae-86d9-08d972d97f38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0143
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the fast switch function for amd-pstate module on the AMD
processors which support the full MSR register control. It's able to
decrease the lattency on interrupt context.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 64 ++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4c9c9bf1d72b..32b4f6d79783 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -212,6 +212,66 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	return ret;
 }
 
+static void amd_pstate_adjust_perf(unsigned int cpu,
+				   unsigned long min_perf,
+				   unsigned long target_perf,
+				   unsigned long capacity)
+{
+	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
+		      amd_cap_perf, lowest_nonlinear_perf;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	amd_cap_perf = READ_ONCE(cpudata->highest_perf);
+	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	if (target_perf < capacity)
+		amd_des_perf = DIV_ROUND_UP(amd_cap_perf * target_perf,
+					    capacity);
+
+	amd_min_perf = READ_ONCE(cpudata->highest_perf);
+	if (min_perf < capacity)
+		amd_min_perf = DIV_ROUND_UP(amd_cap_perf * min_perf, capacity);
+
+	if (amd_min_perf < lowest_nonlinear_perf)
+		amd_min_perf = lowest_nonlinear_perf;
+
+	amd_max_perf = amd_cap_perf;
+	if (amd_max_perf < amd_min_perf)
+		amd_max_perf = amd_min_perf;
+
+	amd_des_perf = clamp_t(unsigned long, amd_des_perf,
+			       amd_min_perf, amd_max_perf);
+
+	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
+			  amd_max_perf, true);
+}
+
+static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
+					   unsigned int target_freq)
+{
+	u64 ratio;
+	struct amd_cpudata *cpudata = policy->driver_data;
+	unsigned long amd_max_perf, amd_min_perf, amd_des_perf, nominal_perf;
+
+	if (!cpudata->max_freq)
+		return -ENODEV;
+
+	amd_max_perf = READ_ONCE(cpudata->highest_perf);
+	amd_min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	amd_des_perf = DIV_ROUND_UP(target_freq * amd_max_perf,
+				    cpudata->max_freq);
+
+	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
+			  amd_max_perf, true);
+
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	ratio = div_u64(amd_des_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
+
+	return cpudata->nominal_freq * ratio >> SCHED_CAPACITY_SHIFT;
+}
+
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
@@ -356,6 +416,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
+	policy->fast_switch_possible = true;
+
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
 	if (ret < 0) {
@@ -408,6 +470,8 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
+	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
-- 
2.25.1


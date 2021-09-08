Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A36403C29
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352056AbhIHPCv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:51 -0400
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com ([40.107.244.76]:64824
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352051AbhIHPCt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqoxlOOT2snvMVXTBxGpuMBRzTkMjduiXjZhsw950FhK8RtT8MVoQUMq8eCO6JT22lCfmkMOuKGK4dCXMWDefUeZq36sS94XnnwLccmv+KrXlQdU+TEF0HiiWikNH6pb8UK75774+bhBoIbiXb09yqI3/KTkuLhxtupHuXCPG8rCJ3fhr0L8RZZRmlbXlFrAP6HPaLBe+Z3K74xVbPGBp39vx7zahNvP0Eq3HOR+jpF2l92hUATNDPHTx+mNXkGl5cWoua6oO9GKstkFSDNsSlprFG/ZmEr0QmeeWA/Gt/dgmeuvIYNBwI36Qpn65a8kbdMiEFlnd0B5QueyJJ+yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MNtlu/gAPeM+OZYCS5Pth5+YYeRlT2bwsxIlrI6SDBY=;
 b=BrVMQVwg0QYUxtezL/NeJ7wvgE48kQQAWzk3kIXPuLHCQMXJLIH/2e3OUZQptpWgIyBQy/QVDT5HvTMIx5DbURGasmRqm/vIfPCnwcTx4iL7CH9+rgXMYNweYssULjKVLAVHnb3u7EdadyYLDxVUBTQpZwmugnyjU0O5w0W9ZxJUtSJPILCC30BWjaKRUnBVhqyFBfpsUa384O8ObZJR6VZOZzFYL2GL4jxcqXQP3VniNzyH69jQt+09DKGpDmwghzmfYKM2BdMzB5wSG9237tOV2KRZOG0UbTzab1rY1gsOMQoqmsLSJDpdYIiUNdLCACx1c7SUSmF+4AUo6jcVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNtlu/gAPeM+OZYCS5Pth5+YYeRlT2bwsxIlrI6SDBY=;
 b=xIsY91GvP59IT5mj1djAgalhw4VpX79J/g0X1I9xCdrOAxOgOBbnUQD6L1wLDAV3kS0zeZfFlG41TVcBnWxI9zbz7v/9ra+19cP3NjAa4NoQn/2TkxiFIuZCLIWgohIhq1kBaT5iEVHN7CPWPQrAhjf/e5apCsq3uFCzmH1oNnY=
Received: from MWHPR10CA0015.namprd10.prod.outlook.com (2603:10b6:301::25) by
 DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.20; Wed, 8 Sep 2021 15:01:37 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::79) by MWHPR10CA0015.outlook.office365.com
 (2603:10b6:301::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:37 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:27 -0500
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
Subject: [PATCH 11/19] cpufreq: amd: add amd-pstate performance attributes
Date:   Wed, 8 Sep 2021 22:59:53 +0800
Message-ID: <20210908150001.3702552-12-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14e447a9-6261-4e6d-3a7f-08d972d98e6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268AF2EF4F2A4D9392C9B3AECD49@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIRfA/fu+SltCDeNkIH6T1jwc7NSGWKqhjGsD6qxOCl8+4TR/K3Gp3/ryYLl7NIct2MkA2LKoRtA3ILWxZA41scqzMfp6TsMHpfEyK8BuBBx8loU8N9z2ih8YgVsLv7DZ/7+G8iadL5faBz4F2kn5gGvcmm4YsjavXQt65V9fR+68dap76eW1X3MotXybyFgLSG7+805NRnw2HKNIEm5NZ3A4XTjvYIT9Hy2zvmERFVsaUN+Wm3lpuF3z0JKcqezR8G/P9Pl/qrfMj9KSbIMP9Kc8r94UV1KCthG7zIWx6+WHCd9S0tmUlkuZ7vfqlxEok9qHTLDx8pG59X8Vc97DvA3WC+IZH+Nknclh8P7o+cHmNNA+L2CcTNSjXzKyCKukNOMREeCa2xjjVzMWLX6N/lO8PRdmF+hbyQx1zUqTMb/XyUkp0XxSgR2TR/i61kYfkH3k01zaeHOqnew8i/Rn9sugpZbd6u+mTXxgxVu+bik92SZANf6zVRGK00uPDV6NwoZ36PF66DL/WAob7UaKtfR+GQsA84fJneoohhAgZs6bctfC4RQ/0yOBmMmsNujzliZJxn+Aznm1vFpqFsNokWyogOvg9hLqcARrhK7O6TnoLVj+wEUrL407fxGcT2HShCIIDS8RE6w5oII9t1c154EEZ5wBXzLKFROV2SGl3aq56ilTcwSDX4Cl59IveqeR3fOdMl/PhwCw1ayKqxHxfHF9D8haD0SJWZSp3uRpBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(83380400001)(36756003)(81166007)(356005)(6666004)(426003)(47076005)(8936002)(4326008)(1076003)(5660300002)(82740400003)(36860700001)(2906002)(336012)(70586007)(316002)(70206006)(54906003)(7696005)(110136005)(26005)(478600001)(2616005)(186003)(16526019)(86362001)(82310400003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:37.1220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e447a9-6261-4e6d-3a7f-08d972d98e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce sysfs attributes to get the different level amd-pstate
performances.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 66 ++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3c727a22cb69..9c60388d45ed 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -647,6 +647,62 @@ static ssize_t show_amd_pstate_min_freq(struct cpufreq_policy *policy, char *buf
 	return ret;
 }
 
+static ssize_t
+show_amd_pstate_highest_perf(struct cpufreq_policy *policy, char *buf)
+{
+	int ret = 0;
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->highest_perf);
+
+	ret += sprintf(&buf[ret], "%u\n", perf);
+
+	return ret;
+}
+
+static ssize_t
+show_amd_pstate_nominal_perf(struct cpufreq_policy *policy, char *buf)
+{
+	int ret = 0;
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->nominal_perf);
+
+	ret += sprintf(&buf[ret], "%u\n", perf);
+
+	return ret;
+}
+
+static ssize_t
+show_amd_pstate_lowest_nonlinear_perf(struct cpufreq_policy *policy, char *buf)
+{
+	int ret = 0;
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	ret += sprintf(&buf[ret], "%u\n", perf);
+
+	return ret;
+}
+
+static ssize_t
+show_amd_pstate_lowest_perf(struct cpufreq_policy *policy, char *buf)
+{
+	int ret = 0;
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->lowest_perf);
+
+	ret += sprintf(&buf[ret], "%u\n", perf);
+
+	return ret;
+}
+
 static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
 					  char *buf)
 {
@@ -654,17 +710,27 @@ static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
 }
 
 cpufreq_freq_attr_ro(is_amd_pstate_enabled);
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 cpufreq_freq_attr_ro(amd_pstate_min_freq);
 
+cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_nominal_perf);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_perf);
+cpufreq_freq_attr_ro(amd_pstate_lowest_perf);
+
 static struct freq_attr *amd_pstate_attr[] = {
 	&is_amd_pstate_enabled,
 	&amd_pstate_max_freq,
 	&amd_pstate_nominal_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_min_freq,
+	&amd_pstate_highest_perf,
+	&amd_pstate_nominal_perf,
+	&amd_pstate_lowest_nonlinear_perf,
+	&amd_pstate_lowest_perf,
 	NULL,
 };
 
-- 
2.25.1


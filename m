Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B163403C2A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352015AbhIHPCv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:51 -0400
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:44640
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351868AbhIHPCs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx1XrqjOyNwe6MsYtOcCA3rFftSQxLjc7qzuWCMuGgDQVWrOiIYFpgnkhX6mjey+RuuGUcm0NsgbB1U2ihTxTyzC627SJMbJPsAR5DfhZYi6OwmbD9V7UliFtmzUh6tcwEPDng9yZru/qv9aY9tSjxzKIXAPHbZEvwx11Oz8YAqld9ovYlm8X39xKrWTNrUCr2Bwa6S0dW9GvXmWtO+2KcG4gNno9GWnkJ7i108J1nJvMQnTPcRt/4prorpFVEsNx7TG/XMiGMwE0ARnxl2GsQIqfnacLEP9pGsFr1DOtqX6w0VvpgLrIehJQPlhZLVxs9MpyD3bP0T6ejxwuJq8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DxYicm56pYRNbYHA0LVxuxUV8cxXlRe46LHD4NMrx/E=;
 b=gSP3OMWFDKCUtUt1KXAFzDcLHDY+VpGUBQrOlb4py+DDro2RZhL/yUMSbmQsVRLAtDY4TLSmaU/4ldSJcaTRo/2lPGLZYOMm7FjmO8baezUBj+S6fu/+RjNQv3peAOmVax7AeWfqqXiP5BNCTUttXPgi5bHcknZdroDTe9bywW9DSDDeiTQmn1mxmFgPJZeGRumvbfnv8LIBWQtrZydhtU9MaN4/SQ9/25rFUWQ7jiD5a12IDYNAd0qqYBH2/FpLaxmfwswrZNXhggSYhKm1J5Hls1q6Kn0NgcYpduE9XLuW3gQvCMMnxkui60WxeDcBPYtJ78wTZe7srxTNlPKYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxYicm56pYRNbYHA0LVxuxUV8cxXlRe46LHD4NMrx/E=;
 b=YlGdDJTexOr9xpZ92kczdvDgJBGQPdO3qVFm/HVrqhHu7wh0jDPHgHEO/rdM/nSSspHJCbAc3XQ1dZHycNWEPPDapJXmDFKbUTW+czUHhNx9RLrdL7YvZHdO5BZUDf66hpeVw5bmLtIE2Y9fgEBdx7C1Oh0yzINBi7Bf1PeGod0=
Received: from MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) by
 MWHPR12MB1487.namprd12.prod.outlook.com (2603:10b6:301:3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 15:01:32 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::ff) by MWHPR10CA0017.outlook.office365.com
 (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:32 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:20 -0500
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
Subject: [PATCH 09/19] cpufreq: amd: add amd-pstate checking support check attribute
Date:   Wed, 8 Sep 2021 22:59:51 +0800
Message-ID: <20210908150001.3702552-10-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2d8abba-6be8-4114-35ea-08d972d98b95
X-MS-TrafficTypeDiagnostic: MWHPR12MB1487:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14871EF4BC004A35B4B69805ECD49@MWHPR12MB1487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCcM4NisxY06vO3FwcUSs9IGFV5pLduZVASogN40cP9LLS9LqlIw3gXBOBCO8SVIrbzO1ZJCRFVLHpP9tjDssHRi2m2c9p1mN6X/vslnKSFutE/Qz38XukZwViVXLCZ8wB5GYlKWN/ZW6sC89GSYmSAYAxX0IWiNfM7/vAIaHo2KPOtCeXx9BPJU4B6cCe9A8lYJ0ogb3P1MRnB1Ow8ZtL9a+e02G02NZ0G3QnCI2vc1LAr+R2qxgzz36Dc3l6BZQhCztUb/mj5CqFDH30uSHgPkimnHR4WD2xH+1+7XtbdIao4w6Zx/3uG9aBfkXEAXPmwpf6fYlCUstjPwEFVu7vgz0soKN5gHWixd/LE+BSzVoZ34QERXZNEl+5y2yHiDhbjxjj4p8Pqc3sMfXNqIF26BfUW3GoI9oWc+2n9kwixHwMltFrWjjusWLlpW5xyhIJhG3gEw2UEYNd1YA0x63HaqF7ZYvgOITaZjPK+lMuneVnXaLjtOWtS1Z+nWEs/DLVwKU/qswzJBYgLB6d7hjC6NrBMs1Zwa94re7wmNURot8tNJ/Z0EUIjsP/9ZFSU+XlYQJTAGeuqNBq1HVVClhBLmsSogIDurICC8LEBwEdredxuSupmHzOKqIS7ptW0GAXyFeUtaeISyQ5zbriUaTzQiGSkNtp5jv97sbLzSmS6FuWK9oHp3tqczAH1Or4rbwiIZXWZzT/s5NB9KfFZ45BVhSO57lfuqBxWJeFl/YE4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(16526019)(186003)(70586007)(86362001)(5660300002)(478600001)(82310400003)(8676002)(70206006)(36756003)(82740400003)(110136005)(8936002)(316002)(356005)(336012)(7696005)(1076003)(81166007)(47076005)(2906002)(54906003)(6666004)(26005)(83380400001)(426003)(36860700001)(2616005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:32.3368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d8abba-6be8-4114-35ea-08d972d98b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The amd-pstate hardware support check will be needed by cpupower to know
whether amd-pstate is enabled and supported.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 67a9a117f524..48dedd5af101 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -577,6 +577,19 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
+					char *buf)
+{
+	return sprintf(&buf[0], "%d\n", acpi_cpc_valid() ?  1 : 0);
+}
+
+cpufreq_freq_attr_ro(is_amd_pstate_enabled);
+
+static struct freq_attr *amd_pstate_attr[] = {
+	&is_amd_pstate_enabled,
+	NULL,
+};
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -586,6 +599,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
+	.attr		= amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27943FCFC
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhJ2NHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:06 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:11232
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231920AbhJ2NGr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsobCOWiqm89pYUwQjVOelXt8gGuc84nIYbsCQx63wUDQ+gLzRVXaxqKhR6KkAg1swuUEHMoKYCzkvsW/VFLN0jZhK2q4BPcO8fHeFl5tD39rYtfy9Xr3Kq8UamrIcdktxypudxood7VOwDoC2CW6deDKtLFmQLcCw1dzyGB0s9+qJNCdIzoo72jFMJ5BhwEbC3eajxJ2oxSFyLuPEnqU9Wv+SaGiEa7oX4zKtCF0V7XJtJnFxg/CKDi+PRg/PK/gTNWHqHCAgDfTxXga9gdwFveyFfdumaA1FOQHeI3p3f6aXpTMgwTB6KxIPdDgcj0SN0reFayG4cwQsA4pHx+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb8ciqFBKdOK/bq7nvnPNbw4yMfxyw6naY7nk9/rgfk=;
 b=WBBwasXq/yhdRMUr0ii4gg0jKTl3rgCqiDqGMMCgYJQMOqWshNMrqGNacVaQn1MnexmDEb1QqqeqdNi8qSR7IVtNMTro0fh1LEVVftz8iEX/R2lG0hT9reElcS3ZLHMhKsrEXpXsJ6GuOJlmiJH51hzJ0oT15MzTtfmHGpGa3u1dENj6Sm2EI4I6r4KBsKwWY56mZzRP6FeTNJhaxAMZhR+iOGbGZHjzgMSJc+HHGlddwPKPmCQBVyW0qMwRWeemcu6zQfI5iVPYTxtMptZpFnP4MXfQ0mNExHJGXSAbjPfhODNjwTqiKwCt2RzryB+kzYERUSmHhVeiA4bSc1Y+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb8ciqFBKdOK/bq7nvnPNbw4yMfxyw6naY7nk9/rgfk=;
 b=dNnBl3Wv4R1h6fNcUWPxgxakn4R/YuAAyy7V9rjSvMVq6whQMiDKJeETrhn9+2QGSwfCwh+o9hjkiJQC53T/ITmfzqC4FAUAYJN0yzb5htXjy3IvEQd5Cah8IrhgjVOieNEBKJwzqyeio6afZcoULJWxWa6selA2+CtOvV+XmsY=
Received: from BN6PR13CA0003.namprd13.prod.outlook.com (2603:10b6:404:10a::13)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 13:04:16 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::c8) by BN6PR13CA0003.outlook.office365.com
 (2603:10b6:404:10a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:16 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:10 -0500
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
Subject: [PATCH v3 12/21] cpufreq: amd: add amd-pstate performance attributes
Date:   Fri, 29 Oct 2021 21:02:32 +0800
Message-ID: <20211029130241.1984459-13-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58869c22-71e4-49a1-6038-08d99adc9cf1
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5422:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54222AF4048CB29DE4C84A49EC879@SJ0PR12MB5422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgtHFQmNlPQw+XDuwOHvfKfh3a8zSGABAaHYonlqP9P4AJWOVxzKpPMpsmOxpzNQTJViGlblfOJnQhMyzx8ydE3cxLtkvh9r5gbZMWWZP72Zis9c1H1W78jl39f6vRvvCiAobdLmsFTPRLYce4CnzE0MYT+b2/O8KWFdAUJXa2jFUPI/KT1hTXX03vtQnlxvhIm3S4gfw6alNrIjS/BfXDZLYSaoySkrhFORKLsUu/SJE0V7fW3SDVkSXvO+0SGHhTdZq+jkD8/nAPNvbUu5SWQ+Kf3EaCcdP0AOJ1pecvYjnFe2puV6IxHhGKBoE/Pga+TSZrRv4J1DA/x+qFPhg7t41SnXbdPeOj7lJ/EcDCMxHLR+MEzIyJFl8iBKvAB9Lk+yVARprF3e4EBukS37oU5Io/dTv+QgUcP89XO3picUJfOYi/Vd8sYdDoQQBxlmB1MS/akVD3ieQ3kAs01CjJM5DGwEslpzUtuDxHDzSYUV37WM9N4Evvxv5qh+z2TrUuVSSSRXUNhNEXeMFegb+TEI0mi+GMg7JvKWNg1fc1UvVQMqsa18Kkvx2WFnDBHPG3DtbMIsqA/3ilQ2HJJ7RQuC2vHgI+hqy/N2ysUMZcbxthI6Jn8sev3+R+pVuGZJ7n6OZ4Xk+dwl/4Hyzx04sQKhsC87eD7vmzLsNq+hUX4QJVM8VETseGgN+LugUaYJ0kSQhNEq1t+QLm4JoOap3YGwjCdGLhMiBgyFD0uYqnc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70586007)(5660300002)(7696005)(426003)(8676002)(2616005)(86362001)(83380400001)(7416002)(70206006)(1076003)(36860700001)(36756003)(8936002)(186003)(336012)(6666004)(26005)(508600001)(316002)(356005)(81166007)(16526019)(4326008)(54906003)(110136005)(47076005)(82310400003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:16.5753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58869c22-71e4-49a1-6038-08d99adc9cf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce sysfs attributes to get the different level amd-pstate
performances.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8cf1e80f44e0..58ee50bf492b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -536,14 +536,67 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	return sprintf(&buf[0], "%u\n", freq);
 }
 
+static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
+					    char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->highest_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
+static ssize_t show_amd_pstate_nominal_perf(struct cpufreq_policy *policy,
+					    char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->nominal_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
+static ssize_t show_amd_pstate_lowest_nonlinear_perf(struct cpufreq_policy *policy,
+						     char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
+static ssize_t show_amd_pstate_lowest_perf(struct cpufreq_policy *policy,
+					   char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->lowest_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
+cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_nominal_perf);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_perf);
+cpufreq_freq_attr_ro(amd_pstate_lowest_perf);
+
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_nominal_freq,
 	&amd_pstate_lowest_nonlinear_freq,
+	&amd_pstate_highest_perf,
+	&amd_pstate_nominal_perf,
+	&amd_pstate_lowest_nonlinear_perf,
+	&amd_pstate_lowest_perf,
 	NULL,
 };
 
-- 
2.25.1


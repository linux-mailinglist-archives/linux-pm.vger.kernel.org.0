Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E304187B6
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhIZJIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:40 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:14285
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230300AbhIZJIi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7F70BY3GQ00NnnroZgqozcg0Bc+WnW8mbkFEFfv5hZiKS93yr+iXk330cNywOLjhEFm32EUktP2G8wF5By8Ui4KsW32vQ8likgjpVrYZd9SO9CWwCf7zQG+iidvIe2zPd8LTK3T9mrPsfmWL33fTJ6v5GZayCsCu2IXsWEa8EmRxMPKgE21J4FZuojmKzWCSRNQhIEd3gXRWf9nU8ay0SDGz7JGT4zP+E1Wp8iCWdiUWVQiaiWBuxfWgsM+ce5Ff11CAs/iaoszOo6EVOsTY7ZMUzZkIq6j1mieGVTSn8XDPzPWNHlL/LiD0fL6z31GBuX78uhayifW7AAt1q+zXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=V8S1ZLLd8Am2t3Dn+x4qs9zKrd0ACKw4TB0pE1sChaw=;
 b=MqDWyaNK8erjOMeep56bApIqks1e0NslvvPMlgPfMO9H0RIlCfqehITzmIa0wvrQyFiSxk6ahZzKIeY9EoeIcRwfY+/wV1aVGVWO52NcGzZ5tA+6cSSXCWhJEH6qH2NgOVx3CU1qYbsH0t1PrMrAj1Ut+3GOYawGdyIz7pbyUsvZTWnwVI069eKKNfQ0NGYOa+4iSzHQLtBGK3ajjyFdznwWkmNW6/HhTSZjHTXralYcwpIti6aLjajyP7Gwdz/EbbzsJhq7xstxyaEyc05C189hY1fCemKSPjAET80PMf2+wvpj3AicsfkNr1e4lfJLXM/38kPKy1ht4s0hlBXStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8S1ZLLd8Am2t3Dn+x4qs9zKrd0ACKw4TB0pE1sChaw=;
 b=JUerCjsinBhN2Q6uBBvuKJLCG2RYTb3xYrfz7teK2gwDKcx+m1uBazq2P2/bSvpKijmQKYYGOh0aEqsomqErjkpNH5yDUiVxWEvJ/THYG9B1WEsTdwy9xqIYKcS+9V6zZFESomqDqSdDw0QEmBoiEUxQq+K2i9R64LD7SiWqzms=
Received: from MWHPR12CA0046.namprd12.prod.outlook.com (2603:10b6:301:2::32)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sun, 26 Sep
 2021 09:07:00 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::2a) by MWHPR12CA0046.outlook.office365.com
 (2603:10b6:301:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:00 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:55 -0500
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
Subject: [PATCH v2 10/21] cpufreq: amd: add amd-pstate checking support check attribute
Date:   Sun, 26 Sep 2021 17:05:54 +0800
Message-ID: <20210926090605.3556134-11-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ce632b3-a490-4d9e-a721-08d980ccffe0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5296D6127DE55AE51742BF05ECA69@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tucNN6vdOlcoC05LBsD+jLSi9Z3cPF6YqCvQS4MMf8UG0FOq/6T5cXg83kZmIGxb281QQsA5rmX87O6Aj6cgkPLLq3AFA1uKxJx7gvXx4hQMKouqsTZsFBmhpT99I+x025ubjVol7aYZQjiXV9SZcE2TXs7fygknlpnmB/jupCjoNlF/hwEOGlkH1HPG8xbbIvYFr9ABFIAywVodNpJaYvqTcWSYH/85d8J8XnpU02r0r1wwiq/E3E28ZX8L0pqfdInD9nuc0b3DHXFX+a9rdQYq3DkA6ejb1dqtRHrpkaeSMuk7B8HKVTsLKIPIbFTRLeftMfgzyGAGFuPCN0Oq+X7G65CKQkOfvg5LtLglKcOxCUQmvtY/KyF22L5bSdEnvoPaclKvvFwGagj6cdyv5bwAc4TWPRvAQq6Cp208kMHU+mHhfMAxt5tLSRJacdDcveX+y/CD338BlQwEPk/0sMCyUb7cBBLXO4g9xog1imapY3zPmLom9E3u7zP3dSHdgL+1mwXlmJxGjUQkxzoyCVHO/Cw6HgRJmyC8O0+hOdEQ+PjA9Tdeiw58obhNsDfSzlYWCt7YGlz9t+JDNPxtn6uUslNOcxoThnvZ3vt0MVw/yeg0ICTgTTHZ3cudf8AGVwlv3H/HFb5DyErgtcTsqnuQbTkPR3BIjfjmKntTi8/cAgSfHMBOut3z9j7JL7qz/hEU+gWYFg5jXmmTtCr5Z7i87bQ0ETSU85P8m+69Bh8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(186003)(16526019)(70206006)(54906003)(83380400001)(110136005)(36860700001)(70586007)(36756003)(7696005)(4326008)(508600001)(316002)(1076003)(2616005)(82310400003)(336012)(81166007)(426003)(47076005)(356005)(8936002)(86362001)(5660300002)(2906002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:00.2623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce632b3-a490-4d9e-a721-08d980ccffe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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
index 847ba00e3351..74f896232d5a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -517,6 +517,19 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
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
@@ -525,6 +538,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
+	.attr		= amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1


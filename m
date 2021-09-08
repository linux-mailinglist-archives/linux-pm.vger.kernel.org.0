Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AFE403C2D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352028AbhIHPCx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:53 -0400
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:57760
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351981AbhIHPCu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIqY9vFJvbScoEtyQocYD2SN6iRqUeSPZoHn+GEzJmoof/lwydleSSc/oTb/6ByMI1gYYKegx5kZynL9V0Icq1d+xDaA/dTwex/3gKxPN9pTi2eZGwUbneb1gNLk3ePPA0C8UeS3qi/68y8z7HI9wmGIM/nYZ6kbTM2vqkbzTdtDRzZQNSF9XE7tr1u0VNY9t7I1D3Y3SR+EAL524j+4wXIWGfNoYeTc2DLHzwT2fQIsiMVSv5uBUJRYOWL12dJ9MK88EvlI9MkLgbdbOLO8VSsHxMO4ubk1qKXOuIpkF+a+XzTlEdRVz206ocnkar1tT7SHJuOOkrpkTPuzkBBIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ccvgLGXMmqJ33bBs2A5cCQooNFOumTwff+lvc6oq7AU=;
 b=fFM39dwTAHUTq+0Y1AdwCNw8wQT5B+prUIJlYlm9mYe3B/PXWDS8REalcgke3LwmHv1tmxx6KyIkNEo06DdU0+/67RNpPavyw8O7kIf4b3yi22D0NAJCSnNIPglcbreV2ozlf9ECGb2FNtku/9Lzs2RnIvkIQCChRoXO9kID9JyumbJTm6pMaHtpzH1YLmLjUmxtNU0UYINfH3es0ewI37keAQy+J+rMaWgGB4btRavpx13j0FIzviprD+3BGDg66dTlD43d7N8e7F9zXCi9NNRVMi8PS4rTANfz2LY7zuoxvisr4I1U6G8oRaM40JngUSPoLYAIHDZiF5aeCZ75/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccvgLGXMmqJ33bBs2A5cCQooNFOumTwff+lvc6oq7AU=;
 b=4LHlLQKQMGkcH2KtT4PXHrelUFBS85OZUB/mpGU0Y803TS3nBiwHC24IMhgyTMKMVnpt+2nideR4Y03hvE4HlrV6NQZhH3wQGOpd+p6P1E+ZCODEcP+ZkH354V9yzp0Vp1GbVF77G1rcYt4jsh/ei/u/t9qX8Nk39cKmgPs4FOs=
Received: from MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) by
 BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 15:01:41 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::52) by MWHPR10CA0005.outlook.office365.com
 (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:40 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:35 -0500
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
Subject: [PATCH 13/19] cpupower: add the function to check amd-pstate enabled
Date:   Wed, 8 Sep 2021 22:59:55 +0800
Message-ID: <20210908150001.3702552-14-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9de47605-7254-4efa-5d1f-08d972d99059
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51574F10342CDD9990E87F9CECD49@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRa5wpkVX2HhFF3y7vmWOgs6gXdVJblk//GnuuuJ1pac1Q7fFysD4LN5J9rIZkGhrJLUYqViPjHeYykT61Q8iDih7v4Q+SKHP54uuwoKJKYeZPTKe/4EFkv3WvY4J8xlvGgESxKDrt+p/etiqRkrtq0bGBLHg3ZhuMUYrqGmIkD0b5eJo/voqmLxd4r3ivlrjipSJHgqb7GZb2xIRSv0yLTslMQYxVCXeHV1nH5mK/1kOAWhUNDNEU1N5XYXVCZ5GgchneeN8WxynLcaxdlLYs+WtWXaFKMym5DJH7KlVxP3SSW8v1+XJhF31Nc9DyDKQVIc/XdDMiP/hA1ahZR94tMx/A3m6Ra+bgKnWqB7DBaWNG6UVUsDNOuTdCOZNvl9/3Hc6WUeU+Y/D/j1wCzxghERV759XsCDESlixYQSBqYg96/vmwGCSkxGwWhgsgZqWFugQcZyS/Vbc3phHnvA15V13kylq/RCZIw1zkzTG31Zm4Kxlu2EtPOxpZ6HkPobPMh78gP9bkrON48gTUMuL1qlH0sBpCHwvZaw10+UaWozLxuzGr0eHQsptTVJU9BWGBuM051NA7B6NVpRc+BKfOzeFLhwB8dAhEGfjoAGZa8WCujnajAxcTJEa4+lWJspjphI8SFWOpKVruMgp+FdH0dvwOE6JB/2xL/SGYbQT9RMt/e1WRJrmczLYgg8wxxnlHgK3CeN4OztuCQDWYi5jPgNaiMVLL4V0RXn9Hyko5A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(82740400003)(356005)(81166007)(4326008)(186003)(426003)(1076003)(70586007)(36756003)(2616005)(36860700001)(86362001)(47076005)(6666004)(2906002)(5660300002)(26005)(478600001)(8676002)(8936002)(16526019)(7696005)(70206006)(110136005)(316002)(336012)(82310400003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:40.3352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de47605-7254-4efa-5d1f-08d972d99059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the cpupower_amd_pstate_enabled() to check whether the kernel
mode enables amd-pstate.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
 tools/power/cpupower/utils/helpers/misc.c    | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index b4813efdfb00..eb43c14d1728 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -136,6 +136,11 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
 
 extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 				     int *active, int * states);
+
+/* AMD PSTATE enabling **************************/
+
+extern unsigned long cpupower_amd_pstate_enabled(unsigned int cpu);
+
 /*
  * CPUID functions returning a single datum
  */
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..07d80775fb68 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -83,6 +83,26 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 	return 0;
 }
 
+unsigned long cpupower_amd_pstate_enabled(unsigned int cpu)
+{
+	char linebuf[MAX_LINE_LEN];
+	char path[SYSFS_PATH_MAX];
+	unsigned long val;
+	char *endp;
+
+	snprintf(path, sizeof(path),
+		 PATH_TO_CPU "cpu%u/cpufreq/is_amd_pstate_enabled", cpu);
+
+	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
+		return 0;
+
+	val = strtoul(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return 0;
+
+	return val;
+}
+
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
 
 /* get_cpustate
-- 
2.25.1


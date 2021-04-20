Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA3A3653BA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhDTIKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 04:10:46 -0400
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:26849
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229521AbhDTIKp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 04:10:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzpFLNPras/Pbhgo4sLUmqjJdp63fB+eI5YcPp2aea96pUelCyp470vYVdbinaHThko8dzb8ZIcvokiqtk8iOTZWbC9KpqNI5SWDk6vX2J5X7y2Wt+c2FhO0XaPuTLd+cZCP/r5nxpoesWlq7IQdLRkVHk0RkJjLpEzTJASRgJTG9ReG1SvUPbXe93do0PguS+T1ImG6XInSaFnEdBXnz2DuP6AlOUxIby311hUvj9EttrcvSLFswL80MmQf1dPCoi6rp8uimSoMjzInECFaAaRTepZ1YNJdkNs1mOeg0A10QAH3SfhMyxUFZlbP+OKkrhNPrDFvadsN3pZVXeXNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb+YPNi/jLWg3XQ7EIvgsHgV0wC92vCOhyzDfuEiHP0=;
 b=FAfwrjSHnozHrnDpQGJIWGw2LjTBM87gl+AFcxFPgOcqhUWEpoAphTQ8AqvcGm3yCiuZfoWuQH+J9C5Q0FxvaSHW21mdxPNgLOhdjFjtnjIinPCNwodbVKbRdsT0hbvdcQH5k1kOX40r0LawkuEIvooHlL6tJAiQtHKO1NdflsE+G6L1zHLKbjw08xMPbdFY69GPdGEux4to37JBWeIxuzoV8j6hrfF+AcqXE/WGwTRVo1rGF2nFjRzT9D4V1MfAfbxE6IReBpEhB5tG7kUwKRGTWoZz5fca+kQm4rytjko9XipXi69Pz54CCjN8p2HeMVXrBgRn+OgqgRfGRejMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb+YPNi/jLWg3XQ7EIvgsHgV0wC92vCOhyzDfuEiHP0=;
 b=YTpk/wijGmj6FNlMcl8CuOfqEgbCoRsO75wjELqNacWwSRyUmDNxxqOPmH8hpmrxBmC8inOmt+hhc7Yks/YMKy1j/NEcxKZmHbZlewquRAKhzZMeNhzykYUMfWpjnAZlLam1/eir1NvJzQBzIN6Y5TamA70pG4qmRBJ06EMOLwQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1454.namprd12.prod.outlook.com (2603:10b6:301:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 08:10:12 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:10:11 +0000
From:   Huang Rui <ray.huang@amd.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Jason Bagavatsingham <jason.bagavatsingham@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Huang Rui <ray.huang@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: [PATCH] x86, sched: Fix the AMD CPPC maximum perf on some specific generations
Date:   Tue, 20 Apr 2021 16:09:43 +0800
Message-Id: <20210420080943.1045886-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by HK2PR04CA0054.apcprd04.prod.outlook.com (2603:1096:202:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 08:10:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a0995a1-df69-4c66-752b-08d903d3b81f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1454B05667667BC9923352B2EC489@MWHPR12MB1454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcXhrofAO86CzkV0MSYAH0c2WMcy/Awo+V4H+dR0lx8x2vQbAJaO0I88qCPF3o5qL46By0Ogc4+PA4BBXEK7UYaZi5UuLAQg2Iv/J+WkelZqohwnY3h6MqwIaEhgplDmm3wq6czCGveiLxA65/eBh7Le/JLMCsVaz2MsgJxOEGZgC1KuAGx/E8vUVAdvgqesfngirx2x6yeE/Y8nVNijWkZWdqAW8nPCMmjZlXzlOdnYPjWmQvoOWYgqVxgQgmC2TYbYJPWFNaGzni3fY7j8gw9hIodacj3OHnbix1oqrbRHBMbyM547e0TuDv+8VclGqyf4v0pO5YvbL+2idBy14rO1v3hPkph+tV6Cu2MbfnvCv3knJ5gUxD+rtVFLVRBBVbJwWFyCtwbDD+VMHLIn0+SkUwN0cOIiA0naz85KMP6cRmqBraiLgDAUBN4xeDwJS1ustaQlvORlIUiUzQiGl/HUCndJjrtyyEhr/CYxasmCQN5Easfo45FgclIXE/egYGX9d8gYAHI3RuE+lcan184/DYripzzXGzUyqF9oPJfhB1VtdgrjdgsLGPwXV45a8pMlH9IoPvsJwNCDMkTbBiuQNi81Iv46CfXrzvjMNC14zMYBT5a6wrXaHWGOmDo/1tHy5mjHmfkWpbR4uDcHQ53U8CCcSaQdUKqsaWxVz8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(1076003)(8936002)(86362001)(316002)(38100700002)(6666004)(2906002)(54906003)(2616005)(26005)(66556008)(52116002)(956004)(16526019)(4326008)(186003)(38350700002)(6486002)(66476007)(8676002)(5660300002)(66946007)(36756003)(83380400001)(7696005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lwIspPblju9RKDquuvtoCoOif+lrgv/Yz2E+OqTFuJk8PpzDkvbzoei9wED/?=
 =?us-ascii?Q?plL22P2u/+D0ZQdlcfQ4KcwVaFCJq3ZbgFmB/i6nNlsXmOkZITzgxzp5iiXn?=
 =?us-ascii?Q?C2XesGKkiZoaqbVIbvamzZ1eqIPhzO+bxoZNnJDVLv11un6hOnVjDQ3vK469?=
 =?us-ascii?Q?d0oEc4Y4geMu2Vx4Q8P0Dcz/IQ0m8YqNHx303n1LSG/CJzbM4RpJroePHEHE?=
 =?us-ascii?Q?hTj0sBFge5wAhX57/pKtcHRVw1aK94Kuv0AvqhfRDlGysq6RTLfogyom2P9+?=
 =?us-ascii?Q?UiOUNx7erfXg6rhZXkdbMCc7w4RojTkNGyVDTvcmvcPf7a/c21c9bp/mG5Hz?=
 =?us-ascii?Q?95Jnq11XYRuubhjwYBLzYbUSYy3eGorsEEHQp/w1+s2p8pO7Jxi3ffeg8uR5?=
 =?us-ascii?Q?KmDOWMo98Fayock3psrXCgorkuahS2xJOyNpgV0Y18gOSn9HhFbO12d3Oh3L?=
 =?us-ascii?Q?vGzGlaa3QYdIGW0BK8cA/pR5eyti1rvmQxxE7F0RqvXjohRosbOVGx04o+S0?=
 =?us-ascii?Q?/x5kTMF8w+jOQ2VimR5IWRKZUbXyNbq+3FZNw3zjMaXxbWjPHEz6RB/At65q?=
 =?us-ascii?Q?PMtMECK9aTsjbLJm/lxOTthidPTXS5GUsPmRBhLW/IIsXz/izQ6SMaY27NhP?=
 =?us-ascii?Q?cgEmuacMaKzVmPQTTtXy9WNpkzigkWhmt7+EtIkkA8+Nh1PqJo8LmLlebjcI?=
 =?us-ascii?Q?rHadL2l8TrCFTpulTvyKkdnJD06NzvasNCJwiHpQrNFXuG7aRqcUUhpXsIeY?=
 =?us-ascii?Q?wk9N+piXHWzQpgQkipeZTFNQ3IqufcuEjmudL1gMGWkj6jokIwNenUJ6lJJw?=
 =?us-ascii?Q?MTYgbuosXRaiocblABCnGzsQIIKEz854CKZkM5LLhdstrYNYpZhOqUbWMWn/?=
 =?us-ascii?Q?ZjLPMLFgDuC7Z9wUbpEPZUAvineFvTX/z1IUKCdhJQk5MlagctTAxleghxOU?=
 =?us-ascii?Q?2L5UiDPSXDjj8k+nHXChAMNFd6EsyIldnOydkaan9sU5zGNpMvh7HFdIp+FL?=
 =?us-ascii?Q?vklQ9462klCcaEqh9qLVza58yfX8ORELD5bbXp+OlaRYcDlyQDU+ejgfyfNr?=
 =?us-ascii?Q?+XZgvpASLDzdT2fLkfndflZ77qtRtbBmkyjmkerZ8Q2KDENS7tf/XJ+gbenI?=
 =?us-ascii?Q?9Jn0l+lnzzwDtlrw8SuWWQ/qit66Gc1uV2r1FWLrjcL8E15DUs6X8udpEZw6?=
 =?us-ascii?Q?Bms66eMQFYRXsOIuq4ubkE9EzSawb3RGlYijDuCnXrdY8NuyAZp9sq8T5sF6?=
 =?us-ascii?Q?zxbQRUWa4Pi+b5Ggm7txsuSY2dscDVZPsGwN02vOTJ8ueV0SqQvLU6QyQQ60?=
 =?us-ascii?Q?FjMOUfJpksOxTp8ODPaUbyEj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0995a1-df69-4c66-752b-08d903d3b81f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:10:11.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxFN/vJQTbl/AdiCdUc+xWtsDOEHzKn6PHZr0/56nvvcEj/ykVoGENpZSXvQo7NTlY9DtJ3inkMS3EIk6M7ydA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some AMD Ryzen generations has different calculation method on maximum
perf. 255 is not for all asics, some specific generations used 166 as
the maximum perf. This patch is to fix the different maximum perf value
of AMD CPPC.

Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")

Reported-by: Jason Bagavatsingham <jason.bagavatsingham@gmail.com>
Tested-by: Jason Bagavatsingham <jason.bagavatsingham@gmail.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Nathan Fontenot <nathan.fontenot@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/kernel/smpboot.c      | 33 ++++++++++++++++++++++++++-
 drivers/cpufreq/acpi-cpufreq.c | 41 ++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 02813a7f3a7c..705bc5ceb1ea 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2033,6 +2033,37 @@ static bool intel_set_max_freq_ratio(void)
 }
 
 #ifdef CONFIG_ACPI_CPPC_LIB
+static u64 amd_get_highest_perf(void)
+{
+	u64 cppc_max_perf;
+
+	switch (boot_cpu_data.x86) {
+	case 0x17:
+		if ((boot_cpu_data.x86_model >= 0x30 &&
+		     boot_cpu_data.x86_model < 0x40) ||
+		    (boot_cpu_data.x86_model >= 0x70 &&
+		     boot_cpu_data.x86_model < 0x80))
+			cppc_max_perf = 166;
+		else
+			cppc_max_perf = 255;
+		break;
+	case 0x19:
+		if ((boot_cpu_data.x86_model >= 0x20 &&
+		     boot_cpu_data.x86_model < 0x30) ||
+		    (boot_cpu_data.x86_model >= 0x40 &&
+		     boot_cpu_data.x86_model < 0x70))
+			cppc_max_perf = 166;
+		else
+			cppc_max_perf = 255;
+		break;
+	default:
+		cppc_max_perf = 255;
+		break;
+	}
+
+	return cppc_max_perf;
+}
+
 static bool amd_set_max_freq_ratio(void)
 {
 	struct cppc_perf_caps perf_caps;
@@ -2046,8 +2077,8 @@ static bool amd_set_max_freq_ratio(void)
 		return false;
 	}
 
-	highest_perf = perf_caps.highest_perf;
 	nominal_perf = perf_caps.nominal_perf;
+	highest_perf = amd_get_highest_perf();
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("Could not retrieve highest or nominal performance\n");
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d1bbc16fba4b..e5c03360db20 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -630,6 +630,44 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 #endif
 
 #ifdef CONFIG_ACPI_CPPC_LIB
+
+static u64 get_amd_max_boost_ratio(unsigned int cpu, u64 nominal_perf)
+{
+	u64 boost_ratio, cppc_max_perf;
+
+	if (!nominal_perf)
+		return 0;
+
+	switch (boot_cpu_data.x86) {
+	case 0x17:
+		if ((boot_cpu_data.x86_model >= 0x30 &&
+		     boot_cpu_data.x86_model < 0x40) ||
+		    (boot_cpu_data.x86_model >= 0x70 &&
+		     boot_cpu_data.x86_model < 0x80))
+			cppc_max_perf = 166;
+		else
+			cppc_max_perf = 255;
+		break;
+	case 0x19:
+		if ((boot_cpu_data.x86_model >= 0x20 &&
+		     boot_cpu_data.x86_model < 0x30) ||
+		    (boot_cpu_data.x86_model >= 0x40 &&
+		     boot_cpu_data.x86_model < 0x70))
+			cppc_max_perf = 166;
+		else
+			cppc_max_perf = 255;
+		break;
+	default:
+		cppc_max_perf = 255;
+		break;
+	}
+
+	boost_ratio = div_u64(cppc_max_perf << SCHED_CAPACITY_SHIFT,
+			      nominal_perf);
+
+	return boost_ratio;
+}
+
 static u64 get_max_boost_ratio(unsigned int cpu)
 {
 	struct cppc_perf_caps perf_caps;
@@ -646,6 +684,9 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 		return 0;
 	}
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return get_amd_max_boost_ratio(cpu, perf_caps.nominal_perf);
+
 	highest_perf = perf_caps.highest_perf;
 	nominal_perf = perf_caps.nominal_perf;
 
-- 
2.25.1


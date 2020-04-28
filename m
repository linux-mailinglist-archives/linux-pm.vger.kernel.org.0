Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA73E1BB781
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgD1H3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 03:29:55 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:42161
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbgD1H3z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 03:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBCxLjfZMaDwY16m8CvzFc/BlF14otozi9tteHp+0kEHZ+c60SMQ6AdM9GJPC2zJlQ3ucpptI9I4Mu/I3thHAELTIumCwCOs6FvPE7UPMte4juO6h0hGpIsfCUXExFIteJMbbbplgs/s6hs/xsx9PKEIuZKUmtUzTynRAkOhRZfhKbon23BKmPxmxd60nXnpGUsMBatDzd8Qk7dasad9Rje/8UVNksF12PUyggIVoQ2RppKmbjTH2LDA5BwQnYWemd1MQc2QBUlntPRSQpJpVmVeAGcN8rsm4refrP+Dnr+NlYJfbEH0e3jKuQ9318VqquLGPOGWQeCQ+dBcWehfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpMJ5vUVFRV/S+/nO9QMI9/Rz68qTeYWnQMZTS5qJUE=;
 b=fqO/V7oQMOU5b1s8WVUNC15TQmdbYp1JgWx22NT5TdhMgi8ADQj6CMDixIUlYGJGOqIbyTULdcPv3lupQR3m9RG+S8raPXSkfb4uHAq7uXtx90+G1Rd/KCbu0QNNXWCmd03WCHAEeA1Fy9bzvlcyBrP2P59wrfG5BeI7smeJw94yA8qtSQ3iXEIj2hWSz4KVpGJL7CnvZPNmF9/JPCO0HLYXy9TblfZgLUJs5SYCyaN+GfhegwhB8Dl+MgEpngKbwXC6H2MEPYyz2y1Nn394CJPoMsK/rI4tIuiab1rXTFy20ziL2UUFy776Gj0vTIQzfXjovjoPuWC7DzRKqbNW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpMJ5vUVFRV/S+/nO9QMI9/Rz68qTeYWnQMZTS5qJUE=;
 b=Xz7AYfiEz+0STfrfmbyN8u+506gdHugufHP7uvZ7mJIkkYu/3QbFWviFM5wgT7d45ofAZrvd4C4kUwLsAKPUW9UsxU/j8mkeX69kY05h1K2m0y7rs4VNzYk2ZZcQyQ6IUgVNU06qW/uhQiYVUlhuuvWFnY4K1lFFAJbotaCjHa8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2885.eurprd04.prod.outlook.com (2603:10a6:4:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 07:29:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 07:29:50 +0000
From:   peng.fan@nxp.com
To:     viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] cpufreq: imx-cpufreq-dt: support i.MX7ULP
Date:   Tue, 28 Apr 2020 15:21:00 +0800
Message-Id: <1588058460-11105-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0109.apcprd02.prod.outlook.com (2603:1096:4:92::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 07:29:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e5e1f2c-a46c-4765-0397-08d7eb45efc1
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2885:|DB6PR0402MB2885:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB28859EB4FE21A227D856A73D88AC0@DB6PR0402MB2885.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(9686003)(5660300002)(316002)(6512007)(6506007)(52116002)(69590400007)(26005)(6666004)(6486002)(2616005)(66946007)(956004)(66556008)(2906002)(66476007)(8936002)(86362001)(16526019)(478600001)(8676002)(4326008)(36756003)(186003)(81156014);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njHGOdrj2D9VT/vb8WwGSTNJoy2zXutS7p+Fsx9UxdBoHx/GpI1xMa+HocXuoKmcHhxNP3VJKR3tetliTXy8mMpwgwfnzByuti2HB1wmfstbsIzr+euGt1/KPAOIDhNMtqTyybqMguF8D1/rNI10iWQv8kQ4punbJ44a/B65JGut76qsHBiabu6NcaHQLq5sEbMcAX9QT+EhBeVpJibr2Ng3whkYQhZO4/m3XF9mUoWvjwqUOgsTEfDlGnJes0dB5VhQTlrTCFKSKjOZzWiqIMPjTRvAjG7GItg1Xnt7IBTFEamvpsxBrZ42o3twusA+ZnAVsyZpl4IxnbRc8wGtWWQ+1qZ2fcq4GOs6Htbw1oiWDrpv7mn2clD33rIZ4Y26CvMwHYyhqX4r/uyah4wJGn+rSOXnteyKhPqs8gAznN+3Gi02lNs1P1Z4oFaQJjhbm2uY2M8FO64bMeHgvZgWyHgB6DqOY4M0VBsZCtVkViA4ttSjdP2BN2p7mFsCyohd
X-MS-Exchange-AntiSpam-MessageData: c5Ti7T3ZYcmzd18C9ZSofsXj/iwS+7ki8Me4yTM5peZh+tVi9X6j2fyQcQBVoXMcirLz53aAjvEX0l8amJYN++I8vMgrIwNqLheayYw0vs5swfAyjUNjpNQF+IB5BZjsJCVWWWKpGeFmPlwYme8T3F1bTy1PulSvtvop7jgAIL5gD0ThZhVvsQLZHNwV1BBDPXirIKPwIlnOScUOIbzOhzVtB3uMhLNENC5eW6TrmWD4Ca5uBFfvcd2CClrJed/bQWVSNdr+Tev413nbTtSdaYrIf7PUHgbpa/jmON+uo7rp8X83FiLuiSkVoqJsAoAjweE4p8/Fl+3B+14EpTL6ksYv0PdWfwL7Whqgk/ksD9doXhNAGd992sK5zlAg7yDat5UhS+tmrO9BCNkWGOQbF3ysDWlWST7EOpJ0Z1B3kjZkhzyEDFKnFA+AD6fzGXcqHlRBpDg7Uij23O5jAKk9qh5iCLpte7WvL2HHm5Nop8njNi98KnElxbQ0kS0o23tgMoy539B0ZBTYdkh5fFePrvzxZIar2ZxrcuWd65YjoLtJClaOHpUQyaQN9jlqXSPb/o5lIeagllQtL8bZYgyxH4IjzWeXZIuYfWxmXLNbhJShvsXMA4vdXW1gJe5faCnv+fGXvPX2PThe0scY0oWADDQ4G51967M+rfbF5YdRX2To5sQRvUP7QiC5KdwomJE3rl0ZXvX5AnjfUTkqg80NCfh/O6syUuiUykY4N1me4XaBnBEeQk7vE+237ji6sssr1hUQIobbUHtW/T0iEEMOtUZ0e/O3RTll+OetFWVkIQc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5e1f2c-a46c-4765-0397-08d7eb45efc1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 07:29:50.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKkk5xbiw0JdlITdETnffmQJoAPaA7Ri1y78+u1M8XcvYizKm9FOqkugabUqwDtmHOltoYkh4dys/4VLnVSXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2885
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX7ULP's ARM core clock design is totally different compared
with i.MX7D/8M SoCs which supported by imx-cpufreq-dt. It needs
get_intermediate and target_intermedate to configure clk MUX ready,
before let OPP configure ARM core clk.
                                          |---FIRC
     |------RUN---...---SCS(MUX2) --------|
ARM --(MUX1)                              |---SPLL_PFD0(CLK_SET_RATE_GATE)
     |------HSRUN--...--HSRUN_SCS(MUX3)---|
                                          |---SRIC

FIRC is step clk, SPLL_PFD0 is the normal clk driving ARM core.
MUX2 and MUX3 share same inputs. So if MUX2/MUX3 both sources from
SPLL_PFD0, both MUXes will lose input when configure SPLL_PFD0.
So the target_intermediate will configure MUX2/MUX3 to FIRC, to avoid
ARM core lose clk when configure SPLL_PFD0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Fix boot break. Tested on i.MX8MN DDR4 EVK.

 drivers/cpufreq/imx-cpufreq-dt.c | 84 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index de206d2745fe..3fe9125156b4 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -3,7 +3,9 @@
  * Copyright 2019 NXP
  */
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -12,8 +14,11 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
+#include "cpufreq-dt.h"
+
 #define OCOTP_CFG3_SPEED_GRADE_SHIFT	8
 #define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)
 #define IMX8MN_OCOTP_CFG3_SPEED_GRADE_MASK	(0xf << 8)
@@ -22,20 +27,92 @@
 #define IMX8MP_OCOTP_CFG3_MKT_SEGMENT_SHIFT    5
 #define IMX8MP_OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 5)
 
+#define IMX7ULP_MAX_RUN_FREQ	528000
+
 /* cpufreq-dt device registered by imx-cpufreq-dt */
 static struct platform_device *cpufreq_dt_pdev;
 static struct opp_table *cpufreq_opp_table;
+static struct device *cpu_dev;
+
+enum IMX7ULP_CPUFREQ_CLKS {
+	ARM,
+	CORE,
+	SCS_SEL,
+	HSRUN_CORE,
+	HSRUN_SCS_SEL,
+	FIRC,
+};
+
+static struct clk_bulk_data imx7ulp_clks[] = {
+	{ .id = "arm" },
+	{ .id = "core" },
+	{ .id = "scs_sel" },
+	{ .id = "hsrun_core" },
+	{ .id = "hsrun_scs_sel" },
+	{ .id = "firc" },
+};
+
+static unsigned int imx7ulp_get_intermediate(struct cpufreq_policy *policy,
+					     unsigned int index)
+{
+	return clk_get_rate(imx7ulp_clks[FIRC].clk);
+}
+
+static int imx7ulp_target_intermediate(struct cpufreq_policy *policy,
+					unsigned int index)
+{
+	unsigned int newfreq = policy->freq_table[index].frequency;
+
+	clk_set_parent(imx7ulp_clks[SCS_SEL].clk, imx7ulp_clks[FIRC].clk);
+	clk_set_parent(imx7ulp_clks[HSRUN_SCS_SEL].clk, imx7ulp_clks[FIRC].clk);
+
+	if (newfreq > IMX7ULP_MAX_RUN_FREQ)
+		clk_set_parent(imx7ulp_clks[ARM].clk,
+			       imx7ulp_clks[HSRUN_CORE].clk);
+	else
+		clk_set_parent(imx7ulp_clks[ARM].clk, imx7ulp_clks[CORE].clk);
+
+	return 0;
+}
+
+static struct cpufreq_dt_platform_data imx7ulp_data = {
+	.target_intermediate = imx7ulp_target_intermediate,
+	.get_intermediate = imx7ulp_get_intermediate,
+};
 
 static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 {
-	struct device *cpu_dev = get_cpu_device(0);
+	struct platform_device *dt_pdev;
 	u32 cell_value, supported_hw[2];
 	int speed_grade, mkt_segment;
 	int ret;
 
+	cpu_dev = get_cpu_device(0);
+
 	if (!of_find_property(cpu_dev->of_node, "cpu-supply", NULL))
 		return -ENODEV;
 
+	if (of_machine_is_compatible("fsl,imx7ulp")) {
+		ret = clk_bulk_get(cpu_dev, ARRAY_SIZE(imx7ulp_clks),
+				   imx7ulp_clks);
+		if (ret)
+			return ret;
+
+		dt_pdev = platform_device_register_data(NULL, "cpufreq-dt",
+							-1, &imx7ulp_data,
+							sizeof(imx7ulp_data));
+		if (IS_ERR(dt_pdev)) {
+			clk_bulk_put(ARRAY_SIZE(imx7ulp_clks), imx7ulp_clks);
+			ret = PTR_ERR(dt_pdev);
+			dev_err(&pdev->dev, "Failed to register cpufreq-dt: %d\n", ret);
+			return ret;
+		}
+
+		cpufreq_dt_pdev = dt_pdev;
+
+		return 0;
+	}
+
 	ret = nvmem_cell_read_u32(cpu_dev, "speed_grade", &cell_value);
 	if (ret)
 		return ret;
@@ -98,7 +175,10 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 static int imx_cpufreq_dt_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(cpufreq_dt_pdev);
-	dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+	if (!of_machine_is_compatible("fsl,imx7ulp"))
+		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+	else
+		clk_bulk_put(ARRAY_SIZE(imx7ulp_clks), imx7ulp_clks);
 
 	return 0;
 }
-- 
2.16.4


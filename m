Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E5D176A8E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 03:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCCCVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 21:21:23 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:27328
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbgCCCVW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 21:21:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5jjpqgXLVPZSfrjZiRYHtdlKXDh4zzTdOX0jXNmNYSNWL6BYobaHn71wd5VrdrCyf8VMRnWCTJ9MISg8Q/qJvcIm1zjqSb5ypexCl8Rl5dsUNCyMqX0qkpdSKT3G0F759imPipWpN2VjhII6lgQJwC0fU0jREBEnnGMl221ALshmJ5XKRzUD4scUHKiyMV0IxmUs9wEDJ5xImvW3Mj/nrqst4XpwKEIa94HjGNagtnwk6PRlk3Fg669RyhsXJUlKj4KQFbqOe/xFLpTtpYyHJWU28cLHGVs1SZ+ddl4EpULfwzHtzj70mfFimeW/sKhviO6z3o4ZVznOT9yOhATnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcIjfMNSszkRgswGErQhD6UiZ9vloNM9seQptmVWLBE=;
 b=ZaYdKIhXu5F0jBIoqWGWXrt2q5d2Y9jo0Z2Kr9d5rUwalCxUrXyDH01RzpKhiOhOiTFrZafxD0wXGfCfLQPKcF1jm4LNJcnwgde5qrA3RNbupQ0aHVYSWbfc1vL+SlM7g0U9jIoPjwaw+VCIt2R+Z7hSg6cCAzlaNlIx5Lp+9tvFtYc1wVjD5aF5y+hmNv96sjcgfPUnS14C8C8Xytx7RIB5nfi5LLZKoQNzUjWgUia3rfkBGkUUIaLGL9+0RV98f+7liKro9kCkYHnyMPQ1OYbxiuR9ZiTw4dNbj8WdxeX4xqSXyTX1G0wPTUPvTkS/8PYrMb6j6+h3mpmbJB2/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcIjfMNSszkRgswGErQhD6UiZ9vloNM9seQptmVWLBE=;
 b=pjshkVxPQ0kkoZi74PVVLOExb7Q6ezTBudf3rEGCVqriWCwo4Y3lYQRBk/llvmYu/B82VTljNeNknP28rhqXGqE9DeRMCX0OtCo1HYkU4OoCVh11VQwmC1gCqiSW7hlf1/B9dO5N6TIA74g8P6OAi3P7gwRV5nZrLgLOI04YSBI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5283.eurprd04.prod.outlook.com (20.176.215.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Tue, 3 Mar 2020 02:21:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 02:21:18 +0000
From:   peng.fan@nxp.com
To:     viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] cpufreq: imx6q: read OCOTP through nvmem for imx6q
Date:   Tue,  3 Mar 2020 10:14:50 +0800
Message-Id: <1583201690-16068-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
References: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.1 via Frontend Transport; Tue, 3 Mar 2020 02:21:14 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3be7ea0-eb06-4329-91c4-08d7bf198e6b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5283:|AM0PR04MB5283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5283187AE5E9BB687D04363988E40@AM0PR04MB5283.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(69590400007)(36756003)(66476007)(66556008)(66946007)(2616005)(956004)(52116002)(6486002)(6506007)(5660300002)(6512007)(6666004)(9686003)(16526019)(26005)(8676002)(186003)(478600001)(8936002)(7416002)(4326008)(2906002)(316002)(86362001)(81156014)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5283;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6eK7zhP6iWYlqwTMXS+vzboxj9j+GpLTuL/pjked1/XeW9CYDWUZyGQWeK0DRWfUPOdB5y9q1oKs15DpNeXVlUSkbdVh8ygxH7d0C96BoiGc2pHAHTb8KM4PsDYr6/BgTuLEdLZwHjJPYf+C6XpwANIeqcsYWMwcCwo+eI7vVhDTT5gjXPoD0gmpuRc27WAVx01xvcHobcHlR+lzMdzF+2zBJWKpekCuKE9YNsQM/iECb0Z4rTv7ykd+SBJcHMpAgo8bZ2NI8NbL2XskJvU5JAXf2oHtAOtYtvWGH9yG+ksh7ZMYQG8zfxklevN9RDzTR8JSaBpv3uC0KjmS0ULSl2HxBlGCfobLL7ZKQS4siTTjSttgnP9+4vR79LDVCQAclskvSzBfbLsNdzhWrG34l1KeroHP0zTcWxmHT8xh7hC/wh9Ig3D80lycqrXMeJFzs2xRiGZUkSBCxnn1mcMZ904uHN2973jF6QiKQ4RdXaEU9Bf5bCVnoZGkJXhRQEZk4LpKH22S1gY/jMAJxYRfQ==
X-MS-Exchange-AntiSpam-MessageData: zDmUIeL/awM2hv+j0PEO0XxclT8IWI5UY1qYdkArbQlWrAcoJd/CDdRiVaf8jahFdnd90yoE9UbhEDum0qlE7aRTHJsXOOvpNStpB73FJL7NwTpaSMvN4AokUg7ue9WLlFBGJ9aobEzsS8ZVhPjsKw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3be7ea0-eb06-4329-91c4-08d7bf198e6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 02:21:18.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4s41txjSufHWlnKH57eHASCOVSzEyIjDbO83pix35WQeK/t1jnZVq5Xmi+bQ6TfY7OAVUCZQ8YtCri10WKIlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5283
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Directly accessing OCOTP registers should be avoided, because
it could not handle OCOTP clks and could not handle defer
proper. With nvmem API, it is safe to access OCOTP registers.

To make sure old dtb could work, the original code still kept.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 67 +++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index b634a73d1f8f..183c03a44187 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -216,31 +216,41 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 #define OCOTP_CFG3_SPEED_996MHZ		0x2
 #define OCOTP_CFG3_SPEED_852MHZ		0x1
 
-static void imx6q_opp_check_speed_grading(struct device *dev)
+static int imx6q_opp_check_speed_grading(struct device *dev)
 {
 	struct device_node *np;
 	void __iomem *base;
 	u32 val;
+	int ret;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
-	if (!np)
-		return;
+	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
+		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
+		if (ret)
+			return ret;
+	} else {
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
+		if (!np)
+			return -ENOENT;
 
-	base = of_iomap(np, 0);
-	if (!base) {
-		dev_err(dev, "failed to map ocotp\n");
-		goto put_node;
+		base = of_iomap(np, 0);
+		of_node_put(np);
+		if (!base) {
+			dev_err(dev, "failed to map ocotp\n");
+			return -EFAULT;
+		}
+
+		/*
+		 * SPEED_GRADING[1:0] defines the max speed of ARM:
+		 * 2b'11: 1200000000Hz;
+		 * 2b'10: 996000000Hz;
+		 * 2b'01: 852000000Hz; -- i.MX6Q Only, exclusive with 996MHz.
+		 * 2b'00: 792000000Hz;
+		 * We need to set the max speed of ARM according to fuse map.
+		 */
+		val = readl_relaxed(base + OCOTP_CFG3);
+		iounmap(base);
 	}
 
-	/*
-	 * SPEED_GRADING[1:0] defines the max speed of ARM:
-	 * 2b'11: 1200000000Hz;
-	 * 2b'10: 996000000Hz;
-	 * 2b'01: 852000000Hz; -- i.MX6Q Only, exclusive with 996MHz.
-	 * 2b'00: 792000000Hz;
-	 * We need to set the max speed of ARM according to fuse map.
-	 */
-	val = readl_relaxed(base + OCOTP_CFG3);
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
@@ -257,9 +267,8 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 			if (dev_pm_opp_disable(dev, 1200000000))
 				dev_warn(dev, "failed to disable 1.2GHz OPP\n");
 	}
-	iounmap(base);
-put_node:
-	of_node_put(np);
+
+	return 0;
 }
 
 #define OCOTP_CFG3_6UL_SPEED_696MHZ	0x2
@@ -384,16 +393,16 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	if (of_machine_is_compatible("fsl,imx6ul") ||
 	    of_machine_is_compatible("fsl,imx6ull")) {
 		ret = imx6ul_opp_check_speed_grading(cpu_dev);
-		if (ret) {
-			if (ret == -EPROBE_DEFER)
-				goto out_free_opp;
-
-			dev_err(cpu_dev, "failed to read ocotp: %d\n",
-				ret);
-			goto out_free_opp;
-		}
 	} else {
-		imx6q_opp_check_speed_grading(cpu_dev);
+		ret = imx6q_opp_check_speed_grading(cpu_dev);
+	}
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			goto out_free_opp;
+
+		dev_err(cpu_dev, "failed to read ocotp: %d\n",
+			ret);
+		goto out_free_opp;
 	}
 
 	num = dev_pm_opp_get_opp_count(cpu_dev);
-- 
2.16.4


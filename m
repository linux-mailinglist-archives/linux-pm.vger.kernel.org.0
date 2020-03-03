Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D45E176A88
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 03:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCCCVO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 21:21:14 -0500
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:40120
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726859AbgCCCVO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 21:21:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPzYBHPdXGSMSqx4u6cVFwf0TtvScRGhBJtSvQtEyuFlWMJgiTxPwO2pBZQIWxF3KkSk/WJINmVUgLG13wLMkI3Zn2HqhAPLW3yzBqHnuvGZHT/yWpvKnkySRT9jnnIsWr2sggbVOXNrTJ5HHMASJgimJUeZZks64BoGmYshO8zgujW4dxVKh8+dqWTXGZ2px8YiZ65guhHf96VhZoWN1QtQPUZnxW+bsnl2qD0oF4Wnfiy44kTmalJJIlNodFl2DFvEpm+2xp6j8QJbKtWBTec078ALGesErxCUjcAwfdM04glIVkRepNgQaRY5Vr9vsd0d6Yg9mjEgk6rehGfQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCrYa6UVr535yA6gud++b1JoFowyzn2rIiirvMltnyI=;
 b=lSuOTtgMHmS+vUWfD8WECYnB+ebKsfTEMc8gsy7w79zda6sWLvgLH+lScdjD/MJUJD9dw/Z9RnoCUJquBPvVumkMFgt4OmDkKZamQBSiI7FKcsJMB435MkOZ4bdPP9sfRdPWaGBESzqsbquWc9omW7uVOXjtK9IvWibRT22IuoElbXmNaNoMM+g9rrotWBI+pzqTa8EpZaqzYzb1RbKOGrcffXMswSZ9pe8HGqiZ0Vb7fQjRZC2HvdEgJZTNXhGNKkg0EBto+i1DbxTj1Lt4eLMbRV4b/pjwEWBeFyi3Ek5ema3fDEKz2f9qalF6Dccb6ZP0Hi/iQbACxc6895Qjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCrYa6UVr535yA6gud++b1JoFowyzn2rIiirvMltnyI=;
 b=jiYhgiObGBgNqwI6Vf93qUwMmKsUIl/OnvxMQ6tpl3hYLyem1yl0F5PP3+YlW+NyeKXQ9Yw0oOFHeEN1jfXNACxKNDLd+pVtJZB9gvYDuQCT8VZmvgsuzsOW1SUJrirg33rJPH2Aa5zy8NVq/ztpQJ4fWVY9U7duqSCzSKqtCHw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5283.eurprd04.prod.outlook.com (20.176.215.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Tue, 3 Mar 2020 02:21:10 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 02:21:09 +0000
From:   peng.fan@nxp.com
To:     viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] ARM: dts: imx: add nvmem property for cpu0
Date:   Tue,  3 Mar 2020 10:14:48 +0800
Message-Id: <1583201690-16068-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
References: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.1 via Frontend Transport; Tue, 3 Mar 2020 02:21:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba817743-a1dd-4bbe-90e4-08d7bf198973
X-MS-TrafficTypeDiagnostic: AM0PR04MB5283:|AM0PR04MB5283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB52836810873471B5B7636F6588E40@AM0PR04MB5283.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(69590400007)(36756003)(66476007)(66556008)(66946007)(2616005)(956004)(52116002)(6486002)(6506007)(5660300002)(6512007)(6666004)(9686003)(16526019)(26005)(8676002)(186003)(478600001)(8936002)(7416002)(4326008)(2906002)(316002)(86362001)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5283;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWmENS3oQVOPlJO5XPN0NAsDnEsKzcc8cafJsVDEpPsEScE/SXkAf4O22sekAEgUzZ2HQu/VZvlWjaFnhwF/E4OxinHtDQMXktYxW+dsV2SkF0ijYPhlpZzprxMMUkmcQchlu5ZmOfkHOscyCOnX3FXHPFaBhb1KxoTi6OY/hBXxmkomVpF/vfTB8qlugXbjR7MtY6lurnkeJQKDvFXhKPe243KmDCRBN5OyONU4JFbMiBzjrUVENfYKE5Q21gRSA3zosxfariP17ID6ikb8lRhvW/RSySKFsmQG/97gRCahpURjGj86U7DEudBgsvH/N8+nrQKQxV+hiN2c+RonZ5ZBnzGM0hm43OHbJSrO1NxlVr2msUyp7yfOixAekBeXWDRbXT/SRHEOiNDwkjmY6Jm+nolyx0FAfGBx2MS+5klHHfAsTiFUxsZAPzCqvByKtkAlYFaGIsZ2mqSqq6Yjpvg4Q0v/oas+ebjAtXKQi92wS9Am4u9LLbe6hhydbgAO
X-MS-Exchange-AntiSpam-MessageData: kTgzw8nsnLVuoKrNsVKYyKuTPChXAn/FVYAfg9kzaJYwdx882e4MgXBG+7TyR+C6lyEw/b1wyzskMS4X/0H4R5+DNoMMvpGxkDXEBhdjZbAdEEH7MJWaEbbsbXGCDDJr3A2GyCoKBEnPp08DEub8/Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba817743-a1dd-4bbe-90e4-08d7bf198973
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 02:21:09.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2b3j1lItYKk+lQ87kNKpYAUBhWQEzC8P7EOnLGMdsprTVp+DI17xEea+QsYuID9Z7Yr29oEXyRnnAt8o/5/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5283
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add nvmem related property for cpu0, then nvmem API could be used
to read cpu speed grading to avoid directly read OCOTP registers
mapped which could not handle defer probe.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx6dl.dtsi  | 2 ++
 arch/arm/boot/dts/imx6q.dtsi   | 2 ++
 arch/arm/boot/dts/imx6qdl.dtsi | 7 +++++++
 arch/arm/boot/dts/imx6sl.dtsi  | 9 +++++++++
 arch/arm/boot/dts/imx6sll.dtsi | 6 ++++++
 arch/arm/boot/dts/imx6sx.dtsi  | 6 ++++++
 6 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 4b3a128d9260..055f1d875bac 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -44,6 +44,8 @@
 			arm-supply = <&reg_arm>;
 			pu-supply = <&reg_pu>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 
 		cpu@1 {
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 0fad13f9d336..d3ba9d4a1290 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -49,6 +49,8 @@
 			arm-supply = <&reg_arm>;
 			pu-supply = <&reg_pu>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 
 		cpu1: cpu@1 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 70fb8b56b1d7..982f546b0b89 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1165,6 +1165,13 @@
 				compatible = "fsl,imx6q-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6QDL_CLK_IIM>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			tzasc@21d0000 { /* TZASC1 */
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c8ec46fe8302..de943341e4f2 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -74,6 +74,8 @@
 			arm-supply = <&reg_arm>;
 			pu-supply = <&reg_pu>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -953,6 +955,13 @@
 				compatible = "fsl,imx6sl-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6SL_CLK_OCOTP>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			audmux: audmux@21d8000 {
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 797f850492fe..6b7fb3cec9f6 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -72,6 +72,8 @@
 				 <&clks IMX6SLL_CLK_PLL1_SYS>;
 			clock-names = "arm", "pll2_pfd2_396m", "step",
 				      "pll1_sw", "pll1_sys";
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -791,6 +793,10 @@
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6SLL_CLK_OCOTP>;
 
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
+
 				tempmon_calib: calib@38 {
 					reg = <0x38 4>;
 				};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index e47d346a3543..63aa19d81b42 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -87,6 +87,8 @@
 				      "pll1_sw", "pll1_sys";
 			arm-supply = <&reg_arm>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -1058,6 +1060,10 @@
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6SX_CLK_OCOTP>;
 
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
+
 				tempmon_calib: calib@38 {
 					reg = <0x38 4>;
 				};
-- 
2.16.4


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EC54F1AE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380542AbiFQHOc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380372AbiFQHOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:24 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D58D64D0E
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:22 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2109.outbound.protection.outlook.com [104.47.22.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-qacQIvEIOVe0vOo7h3zn4Q-1; Fri, 17 Jun 2022 09:14:18 +0200
X-MC-Unique: qacQIvEIOVe0vOo7h3zn4Q-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0347.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:33::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Fri, 17 Jun 2022 07:14:15 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:14:15 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 5/9] ARM: dts: imx[67]: Add trips points
Date:   Fri, 17 Jun 2022 09:14:07 +0200
Message-ID: <20220617071411.187542-6-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::15) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2e8494d-a88f-4636-1264-08da5030fbd8
X-MS-TrafficTypeDiagnostic: ZR0P278MB0347:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB03478304F1906BCD513CC904E2AF9@ZR0P278MB0347.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: JtenFEof1ai9LyMADGPuNWXLe3Bm/VBDk2oVtj+1Zp/JeOLeTjDoYdu7jzF9IdFM61jaM8geKtwr1LqdAqvzUhDUr3pCIHM/Sr09K56aAw70vVbNMa1qCZ09hfNMkWPthxgJvWS3YRljf8RpTX5Z3LQmF4vpJHC9eDGrsPDWN17AA1vx2KqDoGtiuYgS11zYfrgkfy4+QlP821JcGiZ3UYYmgUWevf78gKY3GztVjgj+ye5uPakBnNb1Zch3sDDZWit0/qPIQQkV+Rhey/IZwrKywPnk08yYLrDLjTaQ/LSFvNu0zdhYHibjcRHnZ1jU8YSMC53ht9US8HGPp9PmX+kykC4Ha3dbcsjenDjAo7COs1Hu1pHd8Y0eirreSFFuk07sZj85M1c1xqaiXye7/H4HxnIBQh3JJFdzDOnyEc3AL20M5VK+voLcp/4VcMBDZfCFEh2lrWCqEzTqEJvU80koVJVw82KugH0b+udoiAzHPY/vCLmNHG9Lj6bMKwnbskFHBMZg8egrOXaJAA77O3QPu8XFtxfFdEJ49YrQmA0YTrNehy9m34Repl8mGNjRM0u7Mfnmu2RUrQ6h6xS/iOfOyNfyNAEI9jxHgj+jEIR4ehxgWTa8PKJ/IJjZjt67U47OnZ8M0+RjGTnJKbtd8egs/yyBL2HptDmkUlD2Jhz8b8Xsq+kwnZfz3vX4kcjU01aeDHkxr5eNhfvzKHrGzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39840400004)(346002)(396003)(66556008)(2906002)(36756003)(66946007)(8936002)(4326008)(8676002)(5660300002)(86362001)(6512007)(52116002)(44832011)(38350700002)(6506007)(6486002)(38100700002)(41300700001)(2616005)(7416002)(186003)(66476007)(508600001)(6666004)(110136005)(1076003)(83380400001)(316002)(54906003)(26005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IvA+lzDXXSvB5wpwhJm2xjRqQNlHUlNiC7DLtVeQpfkyPSIwNHJ4pfWrGfeq?=
 =?us-ascii?Q?6kXveFp1/z9Ch15lR+ETyNZqaS0l0cIP4GhMhJAm6kVjdZ8pb/TEMqvPz150?=
 =?us-ascii?Q?ZWcIGGyZUd0ck6s1lJUTR88vC99ioheCL2MH+vth9/xwELEtU+qa2ApCV/uk?=
 =?us-ascii?Q?CGFsxK93rEMtoQ4rWWxZ93aQZ69G83liSdr9aEUzVnbt81Z+tgeHBHQuW8j1?=
 =?us-ascii?Q?DeCRzY1KutN9bSr+T/f64J5qLBVdHcdAmtZqT+DcoJHQRNosDtH1TZNbiDWI?=
 =?us-ascii?Q?3N09dauNR0fMUn3MjPG24qgMUhZFWa2FuVz723IGyuq3aZ+k/bnSVRl2iHQ1?=
 =?us-ascii?Q?mmPpA8zc/XoMpRAWy8CBSdPk7zjb79YqjJU1ZOPtD0pEJPNc9rkMZcvns620?=
 =?us-ascii?Q?TsXtwzPjB6RbWh+5SipCN/CUotCw4yQB0acMn/Yya+BC+EUcO4n5H57VlYOq?=
 =?us-ascii?Q?zZ9Jv3hfBP3LubjLzSJBt8qHS8dO2PZrYNnfXpSBM//HTRIlq0uBPwj4RzYC?=
 =?us-ascii?Q?wVojRQn4PGwQkrKgQGDpWP3MN5pMTy1fB4ykjtrbl11dFdQtcB+Y2gLWzP5n?=
 =?us-ascii?Q?mlGTOalnUYvS1Ku76G6owOEFW5lEGsl8c5YVsrXuLNQaaH0Lni2wXJpvACv9?=
 =?us-ascii?Q?gZjgTHwQoNtWFcWgZlX4KMzrudSaVzt/YxaJ23XOQ1UtrF4crNEtVFhmTKHq?=
 =?us-ascii?Q?U1hCP1VO1GphFg652tKlxdtm5cGae5MlT/Og6uvVEUOgcOxPlAd1zD2jcQx2?=
 =?us-ascii?Q?JBtpRU3kROA6Up/gOGzuqJM6l+G3HrVVMOnMXunJ1PvDfKF/RhDf/rspFh+L?=
 =?us-ascii?Q?sffK6sFKZhI5DXsQm26mXt/pwl2tulsazGz0wkca/jrI5a1lXAbXDOr3ugQN?=
 =?us-ascii?Q?50gIbUb/Fw/rcJMaclG0fvoZB50ixK4bR4oX7AJfy5Lg5uuDpSyEGeZB6Jis?=
 =?us-ascii?Q?qNZxfhO1d9UFZlZOvVKlBN/0ZxvIsf4z04RQKzAI96+z+VqKLuU6qeLxyLVj?=
 =?us-ascii?Q?Hn6S1A7nyF4QJI/6k7vitegnd4mB9UMyEO593+47Jq3VaE9mYQQoBrNfagsh?=
 =?us-ascii?Q?XUkobCm9WGLWhk49uaXTqlWslPWOlhyRBe1P9EdFntMq6MO7NFV2oaxDHM2E?=
 =?us-ascii?Q?oxSZZeIGs3w4c83tXKTHEluMor437E215Y+YGMvENqvfKufsczoPzHyTUV/3?=
 =?us-ascii?Q?RM//x+JStQozz3ta9VKStoyJQYW8oPmPdLoT5yZpncAgIN+SrmT3rM2kVv+f?=
 =?us-ascii?Q?TwaD+LgY3Ivk+DmyTts7HL78LwwrCRVy1jIP9uBjOqXNCmNBeLHZ3dumL1rM?=
 =?us-ascii?Q?tXNaH0NRFPR+opT7H5t/nLVZ9qA5bo+slTOp29/ygtKtgSQ+hXgRAnw7SfhZ?=
 =?us-ascii?Q?A0jtLljQIAIg1JNqifRV0LBTzOFV1CkOK9hLvCrN3SHBNBP06yllc6zKnenC?=
 =?us-ascii?Q?SZ+V6Fv96yCl6MftM2xPc6GB+rflQ2J9u3j/qWcIFZRgclKVqZrnE5Dx4GFD?=
 =?us-ascii?Q?rLK0O0eOZ/QAUo4uG5d/UBY24hucZEyH1i4qC/1VbFSfkAb+CwZ64ExntAm/?=
 =?us-ascii?Q?MgNzgobSC6YK5fkLWPTE06k9Xv4ltvQ4+XObs+tHsoe/V1qLJ9K4Ng5oDF59?=
 =?us-ascii?Q?yYbWZIAPtRfurO7ZNd4DLv1951N4kgUXOoOyiu3ZEIJuk6wBtgBiTQL9/MXy?=
 =?us-ascii?Q?PWQpSO9I8nSD4I8OYtjhKMDFwG3XrrFkpj1x7v8vQZlnlBiWyypU1BkxG28w?=
 =?us-ascii?Q?FkZ0ImOTeE7zhtnAxfQW+aspIOlAxXs=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e8494d-a88f-4636-1264-08da5030fbd8
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:14.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fohAwixt2sg4Pd2WxCTqDEC7D87ajleBwU4nIFYIrFlpVt7coeqgA8M7QZ9OEDrfEp9vtuWDHnOQsMLnIkJKcKvHLIrMrMv/rme4ixXrxUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0347
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal trip point to the i.MX[67]* dtsi for each available
temperature grade.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm/boot/dts/imx-thermal.dtsi | 61 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi     |  2 +
 arch/arm/boot/dts/imx6sl.dtsi      |  2 +
 arch/arm/boot/dts/imx6sll.dtsi     |  2 +
 arch/arm/boot/dts/imx6sx.dtsi      |  2 +
 arch/arm/boot/dts/imx6ul.dtsi      |  2 +
 arch/arm/boot/dts/imx7s.dtsi       |  2 +
 7 files changed, 73 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx-thermal.dtsi

diff --git a/arch/arm/boot/dts/imx-thermal.dtsi b/arch/arm/boot/dts/imx-thermal.dtsi
new file mode 100644
index 000000000000..2303f1a99d84
--- /dev/null
+++ b/arch/arm/boot/dts/imx-thermal.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Copyright 2022 Toradex
+
+automotive-thermal {
+	trips {
+		temp_trip_passive_automotive: trip-point0 {
+			temperature = <115000>;
+			hysteresis = <0>;
+			type = "passive";
+		};
+		temp_trip_crit_automotive: trip-point1 {
+			temperature = <120000>;
+			hysteresis = <0>;
+			type = "critical";
+		};
+	};
+};
+commercial-thermal {
+	trips {
+		temp_trip_passive_commercial: trip-point0 {
+			temperature = <85000>;
+			hysteresis = <0>;
+			type = "passive";
+		};
+		temp_trip_crit_commercial: trip-point1 {
+			temperature = <90000>;
+			hysteresis = <0>;
+			type = "critical";
+		};
+	};
+};
+extended-commercial-thermal {
+	trips {
+		temp_trip_passive_ecommercial: trip-point0 {
+			temperature = <95000>;
+			hysteresis = <0>;
+			type = "passive";
+		};
+		temp_trip_crit_ecommercial: trip-point1 {
+			temperature = <100000>;
+			hysteresis = <0>;
+			type = "critical";
+		};
+	};
+};
+industrial-thermal {
+	trips {
+		temp_trip_passive_industrial: trip-point0 {
+			temperature = <95000>;
+			hysteresis = <0>;
+			type = "passive";
+		};
+		temp_trip_crit_industrial: trip-point1 {
+			temperature = <100000>;
+			hysteresis = <0>;
+			type = "critical";
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index d27beb47f9a3..0a492d9750dd 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -800,6 +800,8 @@ tempmon: tempmon {
 					nvmem-cell-names = "calib", "temp_grade";
 					clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 					#thermal-sensor-cells = <0>;
+
+					#include "imx-thermal.dtsi"
 				};
 			};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 06a515121dfc..3719225126d0 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -628,6 +628,8 @@ tempmon: tempmon {
 					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
 					nvmem-cell-names = "calib", "temp_grade";
 					clocks = <&clks IMX6SL_CLK_PLL3_USB_OTG>;
+
+					#include "imx-thermal.dtsi"
 				};
 			};
 
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index d4a000c3dde7..3192dae452fd 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -530,6 +530,8 @@ tempmon: temperature-sensor {
 					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
 					nvmem-cell-names = "calib", "temp_grade";
 					clocks = <&clks IMX6SLL_CLK_PLL3_USB_OTG>;
+
+					#include "imx-thermal.dtsi"
 				};
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index fc6334336b3d..d88c89696554 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -718,6 +718,8 @@ tempmon: tempmon {
 					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
 					nvmem-cell-names = "calib", "temp_grade";
 					clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+
+					#include "imx-thermal.dtsi"
 				};
 			};
 
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index afeec01f6522..70d503c74e73 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -639,6 +639,8 @@ tempmon: tempmon {
 					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
 					nvmem-cell-names = "calib", "temp_grade";
 					clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+
+					#include "imx-thermal.dtsi"
 				};
 			};
 
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 008e3da460f1..887b3618d20e 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -604,6 +604,8 @@ tempmon: tempmon {
 					nvmem-cells = <&tempmon_calib>,	<&fuse_grade>;
 					nvmem-cell-names = "calib", "temp_grade";
 					clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
+
+					#include "imx-thermal.dtsi"
 				};
 			};
 
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDA054F17D
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380452AbiFQHJX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380453AbiFQHJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:07 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CE8764BDC
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:09:00 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-Z4S1hmKuNrut7qCJJOoaGQ-5; Fri, 17 Jun 2022 09:08:57 +0200
X-MC-Unique: Z4S1hmKuNrut7qCJJOoaGQ-5
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:08:51 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:08:51 +0000
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
Subject: [PATCH v2 5/9] ARM: dts: imx[67]: Add trips points
Date:   Fri, 17 Jun 2022 09:08:43 +0200
Message-ID: <20220617070847.186876-6-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0101.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::16) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f970999c-05d3-4863-753d-08da50303b38
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB02632E9DCBE955593FA0A535E2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: o+yqQYmRCwYiMCbkhSHKA0fuOnqyDoBC7UtgaJ2vs9r+IuXshZC+ci7kXG/lQXArkS2MXj83UXFbi3mJhDDxejVBXkkGCIEJMEbnBG92IuvGRPGyFY1Oxn39TDcq2z5GKQcjCA2lZk1OOf+uqz8T7AKEsiF1hdwglz406nPfRbvnPqNhGbS7oiHaRsP9gbJ9XbzCNNtdud2CMV8DSHd6prURAUtMqTPMXU/Dh6KK55LaCQPoklSW3mfbEfLmRpl3QznrpxPNGL5fk22KCTT6o7rhEucF3zMPYYo0YcdEKb+tF8hJ9h6+re7rMMg0GAL5cZwxEbn04TliD4eD7jXcklxJDiNd3EiiVhfv/mBePxFWgm4y1Q955Rz6ZO32oGi4fcKrXGpur2vNLQouW2mHkYtP3gTXIPbdMR8FJ9TmHExmpN92eD4gJgO5BjHb1pxXPmGWHWA5gj7+fli/khPFbI0iyqlTKJp8eQXinSs5cuOEPUKl/g8WpC1kG+/V/FJ8KXEti3UvL+1KxoFo+gun35VHvXf+s/OkI8HKfp2OzbTbDeC4ZITa4sG0QqUFd4siPoflo+zNlMFs6E3J95gHl6b+Evy7yVQKNGY+OqWs+pQdcEy7XIsxaYnsHCs8VoohWPzlfLZjpHs4SibDCBUHHq+BhgXb+ZUbFBTxMu/ew8IGG+a2eA1qDpu3qjw7lMERZJFfcl4P+wvGILJZet9o8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(83380400001)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+OLBH6TZ8rlY629YNRBkKNY6yVoSKhkIFr2TsGz7iTvkzxqd2lSeP0ZvKgOZ?=
 =?us-ascii?Q?Bxmk0Ig5TNfz0cUlZlN5L8MSGovtpYEyJVrEBtwFIOF1v5sqkHYS/G8TuStA?=
 =?us-ascii?Q?GBLnOqDTyqpXWp2EuMYtwiWxEEPyYzeweEkFJAGObuRGki2SrMx1BXquGL+q?=
 =?us-ascii?Q?J+fXLyIfDpW/nU+VQFvO6FuQvHW1hvg5Ie+lo9DVg7NpLMxLVGxrUnNMvzSR?=
 =?us-ascii?Q?KL/L6NP3lsEhTgF9c4ua2vz0y7rJabDVbcHnLq6S/E930tbrTVSrmtmj77eU?=
 =?us-ascii?Q?55Zu8J1jydpVL8ScLqz/wsaXStDNiH4ZUbXoMyZa/1CPFn5KvdoMUx6fwVqJ?=
 =?us-ascii?Q?kmIsEwXIaSZb1QxfwYHzHXOrwAdhlRxKoLCcj9qqdX6LgSBpsrW/q8SAyj57?=
 =?us-ascii?Q?FRHwSkzmyqUI84uHP8z7VIc0Wq6RvuKe6uKl4HtqTj7gg7TaoVNwB1FUrOlI?=
 =?us-ascii?Q?thnVcdJBrcIt6kBAiVz0oE16WkO1oH5rh4ThAIVmSASyYF1VhajPv6SaHdsp?=
 =?us-ascii?Q?n1Nfhsk7vYYiKEdLiBi5z8f9cZxmJsm3BmtJHf8nOv0+0oiyvEkZuu0rs58m?=
 =?us-ascii?Q?dIVvQ5zFFSM/SQ9WiPG8EvhNk2V6/3rxqWl5rZ4fH9cTKuzz3/jOqWrNjU58?=
 =?us-ascii?Q?QJWiGGP/+J56IHN6ZYdpSxBJgfQ7f28VbQYYJ72P+Y/yoQeeghnPuMo15XOz?=
 =?us-ascii?Q?X7rOlvuwOvmDQFl9ZkSEDga/o0aQHe8Z05b+bnHdMPlYxlCd+4Y2UVgES/4H?=
 =?us-ascii?Q?xYvvUvuxoaTJprQ7qxL6dFtg5SaZ4lCOomjnooQsUnStCxkXTc7Hy44JzN0T?=
 =?us-ascii?Q?8mpq7UL8PY0/+tYT0C0FhVhG2bvnp41XxSMy3Zq8cJUss1g+/WFYU7LH4k44?=
 =?us-ascii?Q?t/MIZ/uu2sebWHoUFjKiOjvEmto00SdnrmEMKHqCo3WkHy+9AKryJDYh1k9M?=
 =?us-ascii?Q?ZWEp0hNZwkfmFtJpA/12c/m6Km4XfuZbzftm7SifKZ+neLjah4VEOcd8gxCI?=
 =?us-ascii?Q?IMz/kCyqbp3tygrOibkkiH9qxPodWY61dFGtClHUnOX3331xP9e3xXxDSg/M?=
 =?us-ascii?Q?n3nvBHW5VTdJV44DCLbmWPJrHAgutij2N+F9qhSm7rXKb05LuBrA2qi4jx9l?=
 =?us-ascii?Q?YtkPhC7ZYai6IdLwTRy5ZeoiIFr4+g16NYt5W8BB9fh/vLAz9CSqWRMO0m14?=
 =?us-ascii?Q?KO1e9y3e/ZBc8ynuqsaWmz0nQm9Thqockzx7gF0R5gPdmtQc4jFulXSmClsB?=
 =?us-ascii?Q?X18Z1RhxhLi9diwoEShAE8tzklevJnechfvgRNfczHBYi/iOPO1mkKiDCLd+?=
 =?us-ascii?Q?pfV79CV9nnkBCIEFlu3ho8JdYIp6rBuJCGk485UiAxOi4vjTQWetw3U6750+?=
 =?us-ascii?Q?Q/5QmslTadEzKLmZToPwAne1plCD1shIhha3jvub10vzzzMmBwjqw+WNNfIh?=
 =?us-ascii?Q?m+fFsMIQCCGHVBxx66ofcZL7kR3E8rhBFLT7kVYAokstvq01DK0wfeoVMlYY?=
 =?us-ascii?Q?dcPMZHsQdzFQ3ElEiowrGEs8grple5KyhZJVx7q8G2MPL6r1l9RQ3trLohaO?=
 =?us-ascii?Q?+d/i9MwhWNXGxDUMEQfU6rz7Gg3ldV36ltHxt8HKO5MpMb7CsolUOczGSMrH?=
 =?us-ascii?Q?IaqU3GDYSpUv6jEnJdsn1DHgxEof+yPIDY40+FhOHXXzHbtVcrIFK4Cg/IWW?=
 =?us-ascii?Q?7aG8FTxfb9QEdA+yrQ/7ka20kXyQWumf7wH5VutestnxounDRF4MBgHmYgq6?=
 =?us-ascii?Q?LISap/DpxrO9x/9xx5p3i1xz1Fd5jDs=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f970999c-05d3-4863-753d-08da50303b38
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:50.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slXMO/VXbkxmnuaRx+Z8wcOp/vJ/Wqz2LYDCnokvv6cI8AyKVKW41jevii0W5TUedZzH6JAzNThtNmVOOcUp8Sx5bZkBmGNfl8AelTch2WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0263
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


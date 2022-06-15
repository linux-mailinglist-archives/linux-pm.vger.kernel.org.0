Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A854C503
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiFOJsl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347613AbiFOJsW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:22 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DE6F46CA5
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:21 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-e5qwAzegMKaNs9kcs8tfJg-3; Wed, 15 Jun 2022 11:48:18 +0200
X-MC-Unique: e5qwAzegMKaNs9kcs8tfJg-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 09:48:15 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 09:48:15 +0000
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
Subject: [PATCH v1 5/9] ARM: dts: imx[67]: Add trips points
Date:   Wed, 15 Jun 2022 11:48:00 +0200
Message-ID: <20220615094804.388280-6-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MRXP264CA0041.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::29) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e6731c5-2c10-4079-bf19-08da4eb42a42
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB03923F115D8F9CF44CB8B0CEE2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: bikdPB/ss76ooXRr9j4j2K16ioG2SBb9ab4GY8PnLGuuYN1gmjLSvIGmd3jPc/LmU7/eM2qo/9sTHCoZflRr526ja3C8KrHb1erFpNvsKH7YEYRc0qNX+gyM1hP505ackmoh6x6BuJOI13AgfYgcabWVbNJTFgbmu2LnOG7cbESV+2mbiYD3+vHC1Za488BogY4zw5XvSYa6nWWTTjzUDpPoO3DOMy8S0dvP9ZVgOemrcWGqWGUzLP3JCnN3fjUsowLSN+tE4SGJSs9yegTAqOcXXtRQ8RoP46vWPcLD0lgZ1sH62ZF5e7TwBxDUVm24/so+xYJPJ8sBUn8C5AutQGjGd8ChOLxqNqyHF0gJ7SOlA7VaPQu7A53y0jgB3AZVINKcR1Q6nCAZZOmXfFZ8EoA/5BuoKfhkmQ/BTdld1fqXoFs8x/ZTJ9VRzxVUQY1mOIkviJyzZM7yLwuXHb0uNtgDgplY/pP5PgN47uvrymtFv5MTVFM6I+u7IlxyGn9NYPx43skGUUvP7gIME/ZfliaQlYw/SS6Wro+ASUAPSDC1JGKHEOXrOahvcOufj2Ds7A3ejBKhw/1NJWrpzaAw5BlG6INGpZJVg84fOOymdJ1KG23kBCkdlfu6agMh/mNaBM6/r05yYij1lbY/HPN0PCtIyUWInbJgEuqDdh3s3Pe6B+INfj5QAYn+/8KVIMswpsz5FtyAbRTxeou9PDAgRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(83380400001)(38100700002)(44832011)(5660300002)(6486002)(186003)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GA28BUAxn4zKm02/fjCEOXN4tpeZiRAHlRj6nRmqzOn1zsgWyJVmypq7MqNf?=
 =?us-ascii?Q?i+jkxg8Z8731aCIAZWKB2/NxHpHRZUcAWkc2twiA04jA6R/BHq7QQmxIGofI?=
 =?us-ascii?Q?bXHT9MprFhxL1a280i0QCM6LF8HYrr65M6UqQSetRwz9SXRGjDSgFaapXu1+?=
 =?us-ascii?Q?0IZzNmakyE3P93HXv7tMS0QOKRO3aHkNdu438ZRCpyq3YI/i2bGyQs4yWeV1?=
 =?us-ascii?Q?hwp1a0W2T2KFCbY75wziZ0f+Z/GCCYO/LQjV9z94+MLnGb0YrNYBR9p7ffEd?=
 =?us-ascii?Q?fl35fMLiImvOWFQFUl+PDnDGM+hs9QGriCYILvG0hbl1d2DEYZpQRpWk/hHx?=
 =?us-ascii?Q?K3bXNY/aiPmpoFF9CGaRuA0FJSxU3u+UVrfqkTL43lQxed+nv468S4bufZbS?=
 =?us-ascii?Q?SthZ9yAok2SV4P6u0k8wg6Z/0NK2GtHdgF9FrwgmoN19RoK2gFrDsvtMkzlb?=
 =?us-ascii?Q?S9JM1OYSp+xIKs0WMf2QP9iA/v+bD0WGgnybSKp0uaQ8xuROXf8rt8+XZUum?=
 =?us-ascii?Q?T1UyqfIQRiNfdV2K5jsicn1WCzSjtvMoprtB8IX4cbox1rFImKaYNFgGE8Xa?=
 =?us-ascii?Q?LEgTYDlk0GWZg0dp1YCsR20oFar6B1VvDdGymyGPWxkVozA8TsX+RnNBRh59?=
 =?us-ascii?Q?7pNM4T8y1Ep4/kswPUad8x2+YktCdph4iDJqawT6NxqowM6X80oLs/eXk4YG?=
 =?us-ascii?Q?TCKZldrHoVite/MB1R142UtOOwx/m8ADLylUoClj9Utf8hzi9Q8pIS+q1KEm?=
 =?us-ascii?Q?L2HHuigoB+ointh9bgu9xfChtcrxyAD5VtPtC8aKkO8aoBd61gcDg3Lz2B5s?=
 =?us-ascii?Q?qW72dl3Gxk431TO/r272WPj7+xUvRFt+1GnH2FouL1jmS9TTNsOCKc66JDws?=
 =?us-ascii?Q?HQASRjfWyYig/uAqfiFq+Yk0ujcJbqcif3v/XShcv+l4w6POL9dju8xl1mOr?=
 =?us-ascii?Q?55vlPyiRoU1a4rJDFL2NplCaoatCw1KJQ3ZdsGQSMBp6BUKNlAgbyWZn1FJ+?=
 =?us-ascii?Q?NX1vfbVm0O8wfXcVm1B/M4IbsdC83aEBwchWwlSYxkQO6dVQNeWLwS70FD0K?=
 =?us-ascii?Q?mXOQXhGMMCiOEWLqNEwpPGHMbZedftsc8TieDnYUriwP5tAUOuvEJeZN4jeb?=
 =?us-ascii?Q?oUS/y3USY00ArOJ1UDA+vJkG59jn7yCRPmMtn33028QSZ1cdyeHOUmoRqbei?=
 =?us-ascii?Q?EpGh8dWmpzhCsntsUQec4kptlFFL0skLjsZHI5FyqgskqdkPNIgaRlnjT5mN?=
 =?us-ascii?Q?KYog4afedQ3QUTB9JE5PX7AiVkMUcduZlsRBML+qO4c1dyP/PmgBt1ToIcrL?=
 =?us-ascii?Q?QvGbmNUpG8Vq/SNxJdp8feNnI4nKH5AaFip5IjsxLIaPfNH9VvoVioBf2CWa?=
 =?us-ascii?Q?NMg/eHoqoFVbYzJEiJQ2dZ7LaF3bA83CD95L/hkqfCci9dGAvGQAdoCeR3kv?=
 =?us-ascii?Q?5JVKtnhPtnUG+tzlL47+DSXW2NWdL2CPyTbTQmxkY1ImZ1pg9X6DGTF8Ojc0?=
 =?us-ascii?Q?cCxNgO9J0TzG4flrBEZeKco2VkXv24EtwACLT9j90BH7Am1tgqlZLkHEss9w?=
 =?us-ascii?Q?YGVfzy1qPnIPVtUB3/vloW3JHm0nxIm69stmM7sznEBz4p1S7Jxx8YXAR9qK?=
 =?us-ascii?Q?COZoiRyuKS3eYlb8UAcFFINpsBGOYa6tby/7ywBJX2ksQBQeJi5hqZplz5KI?=
 =?us-ascii?Q?OtzWFPV4h8ZTJnOcHXjWuNrHQFMS3RgajKIWruaaFfPGR9kSrvrxZvIvZjP4?=
 =?us-ascii?Q?MRlGuyLCmXFoNpHHLCXDRNxtr9aWB9k=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6731c5-2c10-4079-bf19-08da4eb42a42
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:13.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3ZgLhgsM4RzdhuRXGEi7IOSIszT8lQdPSM3U/IZzsBpvFYAdcdDwTe7s5FO61M97ymka6rQvyRplYWS00jKY9g2yg83eJLRZvp3Y+DvEqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0392
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



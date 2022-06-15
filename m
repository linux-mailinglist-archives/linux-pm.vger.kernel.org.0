Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF98554C50B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347627AbiFOJsp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347641AbiFOJs0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:26 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3600F46CA5
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:24 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2042.outbound.protection.outlook.com [104.47.22.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-b2yI8NakMo67c_ZUP3cFQg-3; Wed, 15 Jun 2022 11:48:16 +0200
X-MC-Unique: b2yI8NakMo67c_ZUP3cFQg-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 09:48:14 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 09:48:13 +0000
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
Subject: [PATCH v1 4/9] imx: thermal: Configure trip point from DT
Date:   Wed, 15 Jun 2022 11:47:59 +0200
Message-ID: <20220615094804.388280-5-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MRXP264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::31) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c196331-b62b-4bdc-87da-08da4eb429d2
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB039249D62465F813FD5818F9E2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 3khyPStUl7MH7vt17yO2T0Gb+npu4U+Ecyq6vLdeqSTAZ3fBzgCuIa5PIRUxveUCGcp74hC5TE1m90pPEjomPv3sbwdv43yt4Hl//1CnN7bLkZKcjYnQmZwOd2Q24/n+BJIxB0yQ3wHeBtJ8b8d6sFROGRXWca7iYIIBtAd5YUTulnt/J4f99kgJamllLbkt4es1mlPSX1JHXHcDL5Cqf4x7w7gJB8KPbQ8DcBH963gKvmqXm66/wkOp4uCdCmO/Dsw3MzyoFI8cpGva612fmXK1oAuToGyeuf0DJKPx5WVeVPkPJqC42uYhlYpfXO9gUjeCrHz/6MdjVx6pluwUo7Dr4IO5K5iOXG4EtcHCQ2bEoV8LD2tcVRUklIQ+SOw6gecO1HRz9M2o+qUG1FbyLpa8JWC3fcIDUAGqctIQrXLTwZ974AFKiAqH+HzWcMi0+BqbgFP0B3AeZFjH7+lhPAspXPv85zKWO/pHAdXqWgLw9iwhLVpUHbMF+TJChbiI+yJjzfDU3J6NDhIAk4LKwkp0WdyMq/Z8FMivPVswxqu2XjEK7Tu/am7mZZm90DPUgcd6iWlG9upNo6rav2jpkdWGmsXppkbr9LwIlYSPXOMj2ZhCu2voB47h3bkoRmy6uFf8x9LNfwXGKQAHnD94uPc2h1sCA/vWwc1liYTIOKl4v9b8qrHtq/pHp63J6K4NN30DHbJoeoOeKayX+uVoHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(83380400001)(38100700002)(44832011)(5660300002)(6486002)(186003)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GCPrv6sUnpYLMhvQK9IQnNxQPVO0YHavV695Q+D7F7RH4C+LdcYW7+VtJFbo?=
 =?us-ascii?Q?4xrJzmBmnlafJiFlmk3oXcyS4fOx2OK1Z81peLrK6LY0L33eDHEdjYuDXuDf?=
 =?us-ascii?Q?khWsr495COvtCQrcq4yglmB4Z+f3h3+TJmUshisio8YgSXAaE13ZBB7U06O0?=
 =?us-ascii?Q?ZJiTa4EnQzTeZxwRFougyM6EazPdWQmJSkPPWAPtx6TcFCJnV9dUWyzlKLJ+?=
 =?us-ascii?Q?itw+XcdIuu7GwngzSIkOZYIpLCSPcQd4KM8tLYIumXFi9hbTAfna4EH9jXqK?=
 =?us-ascii?Q?CZMR4VsUUicPbh2HbklqPu0WBBY1zpcv0NHg+R91yqV0I3aUllZ+YSoh72pI?=
 =?us-ascii?Q?HsjVCyRKhB6psayJCZjBkYYgWeO4CSTclNO4eX/dvzZ+fWezAUfRyii+TwTH?=
 =?us-ascii?Q?N69mAGZT2WCWU/PLQ/1FvpxEWHA7zLUTffqlLVU/onjSj3LQpMfBYhoUy7ur?=
 =?us-ascii?Q?1xFdbWkjWRr6ymcYOJM+jlzAaDkn1h6D3gu18C3kIyhn3LLnMiAJn85K1Y36?=
 =?us-ascii?Q?KpTy95zzGZXczZGfUrBXUBy4yHYopkixl+LEHYmN89b06M95ptWuhdGS/RBI?=
 =?us-ascii?Q?KzG4JGPZuLxHSVZLGLeMpDk1VqGHQkdHW1ulQRZZz+C/TmjcGwIsQASNJPdd?=
 =?us-ascii?Q?n+XWsKXez4qXcjFCh2q9JlRuVJ9IHfF03jxxFc/EwZxIuPPAhFeQ6iRQ0GXa?=
 =?us-ascii?Q?U/FKonUSbi/VCdoIj9Dgt4dzvXeFfCZcC3dxQlL9HcLfsTxnJC9Y0tZi7JVe?=
 =?us-ascii?Q?KPu18GAQMt0M+Dug8ZKZmEbkLXPJtVhgeKPGWbA21NfZ6QFiZ7bN95zi+Y/8?=
 =?us-ascii?Q?X4L6enQ2UYRy9+3KFDVovhrSFAbH2t2mgSRb4i9MuNjkQTCkTe1V4EDteQtX?=
 =?us-ascii?Q?Sl/1ZtppVxE2UH9sMjbO+kJIubjI439kdQke7JjpGXVz4W4q/80AB3jC+oTG?=
 =?us-ascii?Q?TLyRHEjdolTpwR+H8MrexUi6GFxnDrjpBpGxf1lrqPSyxvs/aepC1I4NVsBy?=
 =?us-ascii?Q?xzrTnNyxRnDgB++kfEXFjh7RScwwdHcftg6qn+XbIVSLVnSXr3O4J/L/IjDG?=
 =?us-ascii?Q?igNjR6uwvrynEENO9EykaFe0Dpz3jlnJXx6mOIGDUNSndmqGjU/+uURP8mkN?=
 =?us-ascii?Q?/IRYZzNxM6p1ZavkwqVz+7ZvOzhB03hkfR3ZEMFsoBpJ+P446+45yx8d11qX?=
 =?us-ascii?Q?dv11rPvoo52PWjR3byqdlfLBViHbgV5VW9TBhFXLjDxfwAzVKjPA2a0htScG?=
 =?us-ascii?Q?OfVClX2DNfBIOmDvXpcgNo3sWDFXx5P3FT5HyvIm5YFB8NhCm4OddxYKJKV3?=
 =?us-ascii?Q?ZXjQKvHcRlyyeUllNTtAa7hgDH7ZmtsHqans4uM0EMRx1KQfxtTvws/Jzb/I?=
 =?us-ascii?Q?rvMCbvyEueorHtoqD5BMuMDLBi0se5/LBerE+xF6MDFFBqBrO40UZv4QhO3o?=
 =?us-ascii?Q?6cmgs7SW+/Mp8iEFUSpP/S2legS96SWdB/foYBTaUngI8fjoCBXqOI95kJYl?=
 =?us-ascii?Q?jjmGCiU3Is2Bqfoabe+K7d93EvY2iFrKWPuU06nJv4UdAdLMeHuK3c+spqa7?=
 =?us-ascii?Q?LEvJHZDpV8WnSWxEr8eyETqjlMrr/m+oi2xLmBA0A7U/8fEl6bia2unP4cMx?=
 =?us-ascii?Q?Poz5aYlIQBpjVD4X336hh5t4xP2fhsMSqJ32o6XOmjN0MHsvsXr/fYedmzsM?=
 =?us-ascii?Q?QIeJifcZ6gAy4pBwcy28vTP9bwXZKE7oWrgdQGi9FqrKCe25ng6HUSMlA7RD?=
 =?us-ascii?Q?DtbDrkjCuYHggsAQE8hPK4BzeN1fxHo=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c196331-b62b-4bdc-87da-08da4eb429d2
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:13.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNMRwWF5mzgD0m5CF4BhENtefFdWToRJA8l2hcl21WoPC2UOF0JDNymNEPoknA2wYF0t2vCRzlzQvBV3gPGhpc63vz/XJxuvDnAn+xl4+O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0392
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow over-writing critical and passive trip point for each
temperature grade from the device tree, by default the pre-existing
hard-coded trip points are used.

This change enables configuring the system thermal characteristics into
the system-specific device tree instead of relying on global hard-coded
temperature thresholds that does not take into account the specific
system thermal design.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/thermal/imx_thermal.c | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..ef3e152b5ee2 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -17,6 +17,8 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/pm_runtime.h>
 
+#include "thermal_core.h"
+
 #define REG_SET		0x4
 #define REG_CLR		0x8
 #define REG_TOG		0xc
@@ -479,36 +481,83 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 	return 0;
 }
 
+static void imx_init_temp_from_of(struct platform_device *pdev, const char *name)
+{
+	struct imx_thermal_data *data = platform_get_drvdata(pdev);
+	struct device_node *thermal, *trips, *trip_point;
+
+	thermal = of_get_child_by_name(pdev->dev.of_node, name);
+	trips = of_get_child_by_name(thermal, "trips");
+
+	for_each_child_of_node(trips, trip_point) {
+		struct thermal_trip t;
+
+		if (thermal_of_populate_trip(trip_point, &t))
+			continue;
+
+		switch (t.type) {
+		case THERMAL_TRIP_PASSIVE:
+			data->temp_passive = t.temperature;
+			break;
+		case THERMAL_TRIP_CRITICAL:
+			data->temp_critical = t.temperature;
+			break;
+		default:
+			dev_dbg(&pdev->dev, "Ignoring trip type %d\n", t.type);
+			break;
+		}
+	};
+
+	of_node_put(trips);
+	of_node_put(thermal);
+
+	if (data->temp_passive >= data->temp_critical) {
+		dev_warn(&pdev->dev,
+			 "passive trip point must be lower than critical, fixing it up\n");
+		data->temp_passive = data->temp_critical - (1000 * 5);
+	}
+}
+
 static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
 {
 	struct imx_thermal_data *data = platform_get_drvdata(pdev);
+	const char *thermal_node_name;
 
 	/* The maximum die temp is specified by the Temperature Grade */
 	switch ((ocotp_mem0 >> 6) & 0x3) {
 	case 0: /* Commercial (0 to 95 °C) */
+		thermal_node_name = "commercial-thermal";
 		data->temp_grade = "Commercial";
 		data->temp_max = 95000;
 		break;
 	case 1: /* Extended Commercial (-20 °C to 105 °C) */
+		thermal_node_name = "extended-commercial-thermal";
 		data->temp_grade = "Extended Commercial";
 		data->temp_max = 105000;
 		break;
 	case 2: /* Industrial (-40 °C to 105 °C) */
+		thermal_node_name = "industrial-thermal";
 		data->temp_grade = "Industrial";
 		data->temp_max = 105000;
 		break;
 	case 3: /* Automotive (-40 °C to 125 °C) */
+		thermal_node_name = "automotive-thermal";
 		data->temp_grade = "Automotive";
 		data->temp_max = 125000;
 		break;
 	}
 
 	/*
+	 * Set defaults trips
+	 *
 	 * Set the critical trip point at 5 °C under max
 	 * Set the passive trip point at 10 °C under max (changeable via sysfs)
 	 */
 	data->temp_critical = data->temp_max - (1000 * 5);
 	data->temp_passive = data->temp_max - (1000 * 10);
+
+	/* Override critical/passive temperature from devicetree */
+	imx_init_temp_from_of(pdev, thermal_node_name);
 }
 
 static int imx_init_from_tempmon_data(struct platform_device *pdev)
-- 
2.25.1



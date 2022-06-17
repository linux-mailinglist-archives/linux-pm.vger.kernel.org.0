Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2754F1B0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380550AbiFQHOe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiFQHOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:24 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D75865400
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:22 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-Uz7mLjrSNSydKNOMOzBtkA-4; Fri, 17 Jun 2022 09:14:19 +0200
X-MC-Unique: Uz7mLjrSNSydKNOMOzBtkA-4
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:14:15 +0000
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
Subject: [RESEND PATCH v2 4/9] imx: thermal: Configure trip point from DT
Date:   Fri, 17 Jun 2022 09:14:06 +0200
Message-ID: <20220617071411.187542-5-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0188.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::27)
 To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 638b06b0-7000-4645-350e-08da5030fbc7
X-MS-TrafficTypeDiagnostic: GVAP278MB0438:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB043850185FA4E0630669BF4CE2AF9@GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: q/tYp7sLaM+sP1+vT7QWFYqbVN7eNdzuF1G37PvyI0UvEIF3AGAgWIX+Tcm/nAyeW8H5ARtTmOfskdoK6Yk4nQ1eNOwDwczpgdZSWtkSBKinx9JLqyiwiRtcdNAAji+6tslEJuUiC++kbbyVq50RmlJh7gfiDVvm14j+/RrTKzeeZ4pmk8up663cz8WLCjHRmhst54joDFNoK+A65ABP01WmlRAxmXQxJZ4OrvE1Tz0DSGXDilGQk9k41917+TaJpeSHwxy459n1F8RhEj5wD3ZxyHc89DQNQfK+rdmH5QDFPgf4H5gqhc4LltnriVqW2FrCStf8ykaC7C+WxfcSMJMishG/WXf/jCC0/DZvgUmyzXM0T51rxynaIsgzJPVKHlYhHHMl0hlEJ5NzuHdQw7pw0AZC3cfYn8qAcT8xkRSkP0RbLdO1Ku222NHxopkfkIXjmxqx94Ff4xXtJuVusI2js5iiAJhUz0eSo3gg6NqxCThXhLbPgE3hiTdNEztTLdctJlF/YyCVY5r9kzmScJET4lXJcdW6EG4ITumjvsBDXctBL3qoysuQEknYKLl3DSxEZHgO5TFvTG/FZwIdfds2ZuevIU1yyr2xPq+owhR0/XkT2dyoTXKCyZev0t/OFNJtVKS8FhaiB2mfMIMBouUBIjUDhF3w1NvyqvgmlL6OhqZ5XYQqRmh0DI/K8PBhBRvYmtvgSDt4JVXL0chsGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39850400004)(346002)(52116002)(38100700002)(38350700002)(6506007)(2906002)(8676002)(8936002)(6666004)(6486002)(316002)(66946007)(86362001)(7416002)(508600001)(5660300002)(44832011)(83380400001)(110136005)(41300700001)(2616005)(26005)(6512007)(36756003)(66556008)(54906003)(4326008)(66476007)(186003)(1076003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYYuuc7AMDDmDsAe67J+xV+/6W2kQmitfSqKvm7yk2Lt/Oa4sb/ji4LSU9Jn?=
 =?us-ascii?Q?UyiAlKLjABaZt+vfPifpvY/iT7DSVuFulRBf/F6ooF/WEY5udTt/S1OcF4+t?=
 =?us-ascii?Q?6iXg7HZ/FXW3zuOPYBMAktU0KkofWYWak7KrHNneFfyMyA4qc3J7N1FTlJoV?=
 =?us-ascii?Q?vZrWspqXSOAzMQOJWzvI3U1Mf+CFQM4KhGuXbLmU5GBLv37FsXPctCJnHJA9?=
 =?us-ascii?Q?Rf6uHnecpXrUbUUoueqZAbTRrMNFP/8daSSXHZr9BQKbHoafOtwyRiR3BpGG?=
 =?us-ascii?Q?gUo6IgK52WNyD/jh2XUA56N1X1Ljt0byqUq0KvyoNBKtEVb2ABIRfD2oYC/Q?=
 =?us-ascii?Q?TdcrjkU7VOlQ5vf/sCIPPvLrfurF0JODqdGzui/epbGy+CxTD+kJjhw6YQ/T?=
 =?us-ascii?Q?pmEk0vkWNbzIUooJGTGGyPRhuD7pSIjgTBiqQvVoBXQN+Du2ZwWVvA7+RKzl?=
 =?us-ascii?Q?y0iZudt+KvD01wXBmgP8XW0ZDEfLenGw5lla1tU8BMukTSvErh2ReAm/YJme?=
 =?us-ascii?Q?s5mcT1eoTjBVBv722nwoEcf1ADTYSSyVYxNdNx1I5mRF8MQy+tCs5VlvTbc2?=
 =?us-ascii?Q?/g1WCBELNaaBlFJ4T58fiPLcwrmk7hcFoKM5wfCe5S/Z5ZgV8c90abui0lQh?=
 =?us-ascii?Q?IRrk/ywD754cbiP7X9pvIZ5NaVfvzu6wz9Qskb+/WKLXAt0llXBNxvgoFRB5?=
 =?us-ascii?Q?5HsKs6QhBdtBC9dPSUrKOmAdW9gowL58YQKfxPljl1/RAMGmHRHGk2yYomrE?=
 =?us-ascii?Q?kmOvdZhX9XHgbIzAxtoALyiXrdckt/5E0+Drou7xOI1Lox8LHrdTEOdUci8x?=
 =?us-ascii?Q?CZIl3IUjUfdYS8NQtKbiEwx+WjyE31GJJm3wAHfyb8041gxrjVIz2YtUcj4Y?=
 =?us-ascii?Q?HGW4aOgJM6fk++NwRAOBquXJ8AbvEvhsZJHn9dQCDNkahPG9DQmo/CAXjvEO?=
 =?us-ascii?Q?tdzqk+4/IOi5VUNX2D/mIR2dqrxIDdCjj/pZStj+bTnfX8N/O/AeQa2kb2EE?=
 =?us-ascii?Q?tVS5AzJmoCQoRllJhCw7wWHbYQ0uykz4Gxa0ohB/A8btOUPqBFs9xpCxXVAI?=
 =?us-ascii?Q?Vgryz7fwKll0c3NVQu5RO5utM0EegQmsxhQkaecjKGGSMefMhNQIHveZuuaj?=
 =?us-ascii?Q?I9RWCn6RAIQPblm8Bw9x00GEWz5TqL5cfGS07qGEM8jfIEd6cBmzBA7NK7T+?=
 =?us-ascii?Q?m3RieLaqTzfqwv6E3F+J6ZO7xM65WAinn7K534ZqNmyhCGnbhmS8MzUAbbTs?=
 =?us-ascii?Q?L8pERRDczjobMVbWi0tSqUOPWbuMPgx0ztWecpHmCQ/+u6d9Y411nowZu4YG?=
 =?us-ascii?Q?zUpbW1qStFx7tInbgYHp5nlOHGq7DMy+q33oUXzzxKHpImg3pmryCe9RfZj4?=
 =?us-ascii?Q?Ae3VU8x4DXFuw859k2oUAxXHTjCIwVppN2CmkayVFyWUSV6i/ZRWUUQ/kjsn?=
 =?us-ascii?Q?Jy2cmntFsQEIRR73AtLTQlebs33eohEGA0MDYRiYMj94GnYDcZ+hRoXZdG5T?=
 =?us-ascii?Q?6DKRc/pYAz4EmyIDauJqLpPCaVZtbDMN0PpodqbxBCSrvx+hIP7IYzJ/oIuB?=
 =?us-ascii?Q?cFyBA5WVXIEryXfHLQgRjXk3nhXRDf5JYGJtsHEpSHKsrnc+ghYp+Ix7G+9w?=
 =?us-ascii?Q?+m1P4NlJoiQTFLDxOhhsfrDd46yZDor8j8/fQEpPe9e5EUWSoug68WJJYucd?=
 =?us-ascii?Q?47w2GbZ1saZ2N28BvaZJ+wUk3bZ3K8mdBXAj9deElU5rIJwYwYlJ7tX3gWg/?=
 =?us-ascii?Q?6fWDZANNCHTfjOM/GceNH7pTdoe+WsQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638b06b0-7000-4645-350e-08da5030fbc7
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:14.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP/YPN6rHwvEZW6k41vlxl0SWujoN6iKgni3gtBLLU9KonPYPfl5vA/y4o4ORlSuSUKU1l0i/IRdQJKFSb+9ANEPLi/PFvXguTWQkSkfQYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0438
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
v2:
 - return immediately if no thermal node present in the dts
 - use dev_info instead of dev_dbg if there is an invalid trip
 - additional comment in case passive trip point is higher than critical
---
 drivers/thermal/imx_thermal.c | 58 +++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..a964baf802fc 100644
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
@@ -479,36 +481,92 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 	return 0;
 }
 
+static void imx_init_temp_from_of(struct platform_device *pdev, const char *name)
+{
+	struct imx_thermal_data *data = platform_get_drvdata(pdev);
+	struct device_node *thermal, *trips, *trip_point;
+
+	thermal = of_get_child_by_name(pdev->dev.of_node, name);
+	if (!thermal)
+		return;
+
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
+			dev_info(&pdev->dev, "Ignoring trip type %d\n", t.type);
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
+		/*
+		 * In case of misconfiguration set passive temperature to
+		 * 5°C less than critical, this seems like a reasonable
+		 * default and the same is done when no thermal trips are
+		 * available in the device tree.
+		 */
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2655754F17A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380458AbiFQHJX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380457AbiFQHJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:07 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9801664BF0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:09:01 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-inJrkMMeN7ilk6Iy1a5WUQ-1; Fri, 17 Jun 2022 09:08:55 +0200
X-MC-Unique: inJrkMMeN7ilk6Iy1a5WUQ-1
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
Subject: [PATCH v2 4/9] imx: thermal: Configure trip point from DT
Date:   Fri, 17 Jun 2022 09:08:42 +0200
Message-ID: <20220617070847.186876-5-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::6) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45f7e960-8879-43fb-9ee0-08da50303b20
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB026374752E359F40D6AD8AF9E2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: ocUC4vZEmZjch65m1MjMyi3x6dGnIg3Eek1H3taveVrCI/oKi91VnZwy7OiqPrSlwCoIhIG1c7ie0EaMv3Wpte4Zvxk1bf2kfwuyzAhERlxP88oC5dtWZjQQGVsJ9sxDSAgaZ7E7nwT1N4a42d0eAz30Nnq8h1D8yI2X3uC+NYpPvDCa+XofPUDSvwD4so7eG13dm0WnsH9InspamZ57BtqPBOkWqGjSMRavC3FPENj0ey5sU3fqjpAwuqNOom14d6Vp7T48MO45SD12OChlFtQndpspLeNN5YOinFEWMGNlQS7Y50bLpYkaWfvyDNb1HvfIXW20eD13yNnGcypDcHY3Yz2QdEKAL7fh7qR0lfU1zr+fJ6F3bnk8Di/pFsybjueOcTfJ5dRysbB3zTACDo1DBbmFL443pAH4G/uI8sOMOhU3YTbG1Ewv6gSCSjfqkJ5zQ4mQN/TgfJh10S6H8CrNzdZnBNWm6k5iOJZV2JezzscFG5bULsp9NX6HWMuHnVrLttHniz4Cp94xcbV20a+Io8PCbQc7lzHbT1/MulilJqcZQWLvDJE3nWQHT9tJSf1o6gNNnez1sLAdcZeDnydwxsbZuJ4zUHRksRhxS+d7dKqXWO0C7RDLYITWfXpSRMmW+GyDLaQ83V2ED1nB6ZtWVWFGwy3YhLlVlOzl2XI4dkvj4WFLDf6ov7CYWA0gH5ZCQktteo9JZbgg37cFVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(83380400001)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u/TcxaIDgQATQot86UfP+djSB6LC8gj1KrImI6ZaHE2Lie8uVk41pLbHAY8B?=
 =?us-ascii?Q?/gK3Bk8qBkn5EXfmEvPZKz1yyoXrSETfGqlvdxIhSaSyISZiywe3o1InoaKU?=
 =?us-ascii?Q?86yOzJvVa2khLL7xvz3kGBuEUelnvLdkYIHgUwE6pxwsJV0TQ+7qX866lF//?=
 =?us-ascii?Q?t3IFKP5Fy5AU+Ihl1uGChd/z2JwnPUBFxXyF0rTYWGYW+QjKcaHGl0yiBTBP?=
 =?us-ascii?Q?NpMHQKxHcgj4AmzuvHJ2B6v3HfKIW9xmpyMtfYT1BkT8XNTN1na7BuZ3+76s?=
 =?us-ascii?Q?N91dClKcbpeo3sH1B1T01rxOjTgs/rU8AcjCVuOfFr76CaVOysxpBRVRvouS?=
 =?us-ascii?Q?08BAKn+FpPOuhdkGBsWvkqfUC60gXm/gKssxu4rBRJDIyk0p2XxBKLF31fw2?=
 =?us-ascii?Q?x8vt64v0RVgM0NI8EopGepeo+Kf6d+5QcehvOjsoHChhaqG/x2qdOppXx3MD?=
 =?us-ascii?Q?PRmJhPFJQ7p4fJxO8BzG8ZA9uksJ3QO+OIlFgrVuedYqFbi39+KI3OblLL2p?=
 =?us-ascii?Q?oxtMwHgTkEHuTzaloxdmlJ2Jwj8nm32F89NRyXRhrq9EsVMejLdcr7GAn5hT?=
 =?us-ascii?Q?cH2qm430UqnoX09+H4NTKr7miKp/dLRYy8V62tnGBGu95VhWpAcEls4KUoR8?=
 =?us-ascii?Q?ttVYbwEOW8Ea0blKmDq8mbnMCd59rFNzz55zfKW6w8gxItiuK1S2iuR4hAh7?=
 =?us-ascii?Q?gkn3xYiwcP3Ht/G4N7Q/Z3qJgdspofy9hNu5sZJYAuR5qTAOC4POTBCqNoZw?=
 =?us-ascii?Q?7AEXZqmeBgE2DJ1k3VHSLSzQ1oW8f+vPhTrE3InCQ+8+E4su529wN0KjwDUW?=
 =?us-ascii?Q?lFDCaAuFvcNB8lkQvuK1kqK6brwdlCvlB0IBV/3p6+rlyvjggz+pxyxBUbip?=
 =?us-ascii?Q?j4pPmU2JTGkCbz6Q0HpplwXtwNs+RRNL59qG4k9eNwr74EdkobiELZGwn+tw?=
 =?us-ascii?Q?HDEyuS54lDJcxdu9RAxWp9BLHdxQpElfSaf/dfqH5IqZo0Gj5odSPuUJfdJb?=
 =?us-ascii?Q?vAKQ4vvUHc83MXR8eDWHQ6psU1DJ2WB/KYWI8kgsuxMwN/OvAvjyNcPvfecE?=
 =?us-ascii?Q?1+TShm/uX/n4piflZnfaJJYGSoAMEWtJZ8X5jjbGNQFx+moQ9/EMrYlUwfIA?=
 =?us-ascii?Q?fPEDhRHp3kxlFwJGGsHcNY/Y8AnnL/XEcolXrokOOH1dnEe5X8FFwSmfYKnZ?=
 =?us-ascii?Q?6ywNmV9EJB3XPdt1hLslCYLdLyzCctKWjHfLBHyqPHpvKe92wqSRxMcor9pp?=
 =?us-ascii?Q?HMXD6BjmLP251S40fNkas9sNJZ5Fm2fdLImQfwsuY5hDi9CVUPv/vKehMW0X?=
 =?us-ascii?Q?WpahWyqsnV1U+tMnX8GbVhAFBxoF0Vj8M7s38h2HhHYqYfibSRH+ROZxqviL?=
 =?us-ascii?Q?0vatR/NSpnY1QVrd1djDz3L+uBXWBQgU642g5bmyesZH20g2hDvzsT9wqzMp?=
 =?us-ascii?Q?7cPrfg7EY/llfczF+NE2ajelSAV3pYdJ28MEYzJDIxsA05ZoylOhCpRhkmFN?=
 =?us-ascii?Q?IRdqfnaHMmPweo68ShkFWdGkdwnWkzMtV+zcpONaoGkyqtm7IILnBOdZdXhi?=
 =?us-ascii?Q?fRISc5K/fw1nAhb3COh3TtNJR38gkZIBAcYpclet3WTvOpwyqMam+O+foTt6?=
 =?us-ascii?Q?IoAlNuHRsHLpSiMnqdf99YUhA08cT3b24PjNpkxLich+gBKNgeoX6M7exDBF?=
 =?us-ascii?Q?H59OgJr6Z0ASfyXn4UBv5ocErJMHnEajST1Nl4NyKxXJBdrTOsVC8zQgEZQN?=
 =?us-ascii?Q?46o+NhnRVBw2+4x2ecHFlR9QhhPN3GQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f7e960-8879-43fb-9ee0-08da50303b20
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:50.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8488D7bxBNG1E9AUM3wbX/+k+WDusKXb1QV7C4vaKIOsX4aqm3THGGGfk6rGxVn9LRg8FI96JERh9/4qdUadyJzG7nFXRo/iHCdZnYik+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0263
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


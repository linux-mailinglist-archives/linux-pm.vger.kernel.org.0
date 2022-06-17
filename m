Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7854F177
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380413AbiFQHJV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380412AbiFQHJF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:05 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 884AF63BE1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:08:57 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-Dh4YVhQxMS26iIzfskeUJw-3; Fri, 17 Jun 2022 09:08:54 +0200
X-MC-Unique: Dh4YVhQxMS26iIzfskeUJw-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:08:50 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:08:50 +0000
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
Subject: [PATCH v2 3/9] dt-bindings: thermal: imx: Add trips point
Date:   Fri, 17 Jun 2022 09:08:41 +0200
Message-ID: <20220617070847.186876-4-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0138.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::30) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae209dc8-7505-4b4c-e4c7-08da50303abe
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0263CB2CB98385CDB850B62AE2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: gvXmXcCAk6Mx+DOKY12wFMntoxzEsAzzWmhFvM/nhdPpf5bqg2QJJqicqQbjEWbUi58iDG0LshOd1wRDZqacj/T7xISr4GcXA+TcHeVXMFNxNRmRqDhGdWRGRikfZg4mgM5a5u6mQWgNHorKnFHGvF4RM6bK9q1lhZS7/fcziPTxboVWa0Xp9O0LtSX+K6gTYiZiMP38tU8SpyvtKRZZ73OXxQyLYeNZ2MTxtVWD0zwDjLT7lCFD5Ry9OFQioD+srMH/jJR4fKA78ZuGYVxRT/3rh+5agMskPOJmKL7qTOAenIgkpGhXcuAtWTQMdi8fBv5sRleN9HSR4J8g+yEFzDqwwRAu09JKWONLGrlPvqPdGYwLYrw9w4RgY0SbCeJ/0JtkOtVFuJhlyF0KNjVvG5o+mxFQFsq9CUSfSjwlG+RyUkZrR2Y/upxVrQ079z5vCj2PwF76+G7dZtGJvR0qGOFAArAc7H4T2jRdlunG+XDF2GmhUUyg7AEUq80zeSr/xigmrBQ9NH3N6iTFmlVj0POr9irfdw1lRI5nlWdrNwFH14Wdv9A8P1of3boxF2DJZLrEkUWMOSJ1vMRFM6cOTFrRUOFXrCqTiWJvLroOYruMZQ8gApEvYJ+vHKxrCUCF044QM+V+wi+GgNqQbIeCgSSBLUpQemvEJN+e3GZuRRM1/Dp2xu8I2NQ1aiG3qkzlnIOr1I3F/HuJPQDIz0I4+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(83380400001)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85AKQR5F6UOE8I9EUdfBS4uM3o5GkUh26xpk5ojbwg7vWwiFHC4FNNEstpAi?=
 =?us-ascii?Q?mlEwX87jtpQ8eV5zA/8oPO7xMOP3VT5AJBEduOIchLWF/TtOX0l4U6P6kU9Z?=
 =?us-ascii?Q?8X9ZHcWrOjfw1WjhFokY+8upXT/VaLoaYZsJwWnQLnC3yGuQP6adIjjs7HOo?=
 =?us-ascii?Q?OTiZezvTk/suWS7QwIL17mdo8CM8+9nzyH3CkyCTxkJXpBI5OtJUNipoS0MK?=
 =?us-ascii?Q?Tt2fyjreVs92BGayJEeI+6BVCZPRc1FhLM/r6v+5INi79tNF9343vQskVDSR?=
 =?us-ascii?Q?+hHIsYbXT3kuDkIGrrvrcjw80Gr2QtPhC5pUFjtoAlAz0JXVAxvhPMHf2lFV?=
 =?us-ascii?Q?epZkGNj1/NJRD476ipz+f8q/h08MJJZ60J07EILhAbzURvg0jozv7f3BRINf?=
 =?us-ascii?Q?Z4du3B41O0QnOdNb3JkH3K1jYDMhYhNudpl+u8F0idsZQ+pGlgSRKCJys20h?=
 =?us-ascii?Q?stwLLV8SIdH4LHEbebDBtc9S+WnYnw+Iwee8fpj/IDExJ6bdgCNL0Da3BbG6?=
 =?us-ascii?Q?8y1LKTwTWwox63vGe+BB/raowLPheel9lvcjXq/RtqZbXCCeyQ+fAGiySphW?=
 =?us-ascii?Q?X2FKV0nulx6GbL9HWmN7EYUNhlFPg1ku8UbYK/go8MiQw75wimYx+B7GzmCT?=
 =?us-ascii?Q?lAieaulKN2uTgVOzqotWN10HemZC+uO4Eu21IAtzSstkytnfkMytnYgz85nu?=
 =?us-ascii?Q?aeuxiUNmmim/+0mp4B7cgHWSJv0xSDPqallXXoidonMoCfYmjjNZAXFW98Sl?=
 =?us-ascii?Q?1C3B/lLpQSMFwtrXbD1nVI2m+dgfheczIJEecZi9Byq/bGnet796ItpUKkIV?=
 =?us-ascii?Q?i2qTWuzyy366P2Xmzoh9r1yVm+vTDrVaeAv4eQ5/+XnTE+tR3YbLk8DVwJaV?=
 =?us-ascii?Q?7KcH0UI94FHQaIs9EAn/7zNPAmqZQtlJfvoX2Hv0IJddkkw3GWsWXs8glASy?=
 =?us-ascii?Q?Z8Tc/2QdEEh/ggZiQtAtRLlvtsm8eRrYsuOETVZFvM8yy05lvdy8KoST3gmB?=
 =?us-ascii?Q?TvVyRRywS0BBUGS6ha2am6nOV7sZzL2VwzH2fRjpuJ3zmYubsElRaOpK496R?=
 =?us-ascii?Q?6UVDaVwlRNqIvlJqw3GpDoXQBC5RfdUTzlO8jZ1l8ftY/iRLeccoVZEG6HJw?=
 =?us-ascii?Q?9Ks2onFobdEJiMZlHTNSJiHhDu4d4UWMlswqbnbnOOFtmbrJ55Wet/UH9bax?=
 =?us-ascii?Q?1TtZ1fjSj3z0EMK/G37WAWla399EE/aFTu1nOY9I+FBKYpRtMD0nK7kAka69?=
 =?us-ascii?Q?cC8RMV5yDFOg/hwP1B5JSMRNTp58o5LtoIm0Pcbk7aS8R/iM/yS2PRoRYFYc?=
 =?us-ascii?Q?FWFLgQW36wVygdc0t0uWlcesjzrH42xam5DJ+QXWku2fZN4UZn7tmMKTGRhU?=
 =?us-ascii?Q?m35RJ0YqFy9Y3yeGg2XMCnrrDe9gt6eLBTUzyGhOskqnTavz7FH7n5MgWgnn?=
 =?us-ascii?Q?/Z2FPd+utmGVeKvXHksNWP7138lAtLvF6Php7WMA4r/iGSj143RHfE+B+ZZB?=
 =?us-ascii?Q?A3CjigUv73gkiJkXkui3pDekCaTfSiC4F3Tku3VJ68vDW/HhJdieMUHorp2u?=
 =?us-ascii?Q?u5bOKSgs+K3iDkiXV11FnaQeojVo05CCZ5lh28GAXV2uMik3PgYqEqMqyx14?=
 =?us-ascii?Q?IhfAZ85qJZIk2Bvh3Nl9xRlxqxw3YHiGMt1luDsHQl3sm19PNWKL6rKPigzO?=
 =?us-ascii?Q?LNKX/D78QuzAP6UEN6zU3imIEcW3NeuYoKDtW/MUI0SR8zR3c2aW23AASrtL?=
 =?us-ascii?Q?ZWPa9BtTzaBOPOY9s0bVLCJqsQCdZB8=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae209dc8-7505-4b4c-e4c7-08da50303abe
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:50.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRr3GiisuQ6ts4TGfnmGo5eHgfL3gdv0gJSarMKouHq+qi+ikpC7R4cGEAWpqQE3HDQ/7NcLCyFO9lSIlcPO4lGZlu1m6BH230WMKCN7XoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0263
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add trips point to i.MX Thermal bindings for each temperature grade
(automotive, commercial, extended-commercial and industrial) to enable
specifying a different trip point than the hard-coded value.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 .../bindings/thermal/imx-thermal.yaml         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 16b57f57d103..e6349e40d6c6 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -54,6 +54,18 @@ properties:
   clocks:
     maxItems: 1
 
+patternProperties:
+  "^(automotive|commercial|extended-commercial|industrial)-thermal$":
+    type: object
+    description:
+      Thermal characteristics for each available temperature grade, this allows
+      to override the passive and critical trip points.
+    properties:
+      trips:
+        $ref: "thermal-zones.yaml#/$defs/trips-base"
+
+      additionalProperties: false
+
 required:
   - compatible
   - interrupts
@@ -98,5 +110,20 @@ examples:
              nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
              nvmem-cell-names = "calib", "temp_grade";
              clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+
+             industrial-thermal {
+                 trips {
+                     temp_trip_passive_industrial: trip-point0 {
+                         temperature = <95000>;
+                         hysteresis = <0>;
+                         type = "passive";
+                     };
+                     temp_trip_crit_industrial: trip-point1 {
+                         temperature = <100000>;
+                         hysteresis = <0>;
+                         type = "critical";
+                     };
+                 };
+             };
         };
     };
-- 
2.25.1


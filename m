Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9354F17C
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380520AbiFQHJZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380512AbiFQHJI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:08 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CFD864BC5
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:09:00 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-6SI1p9w7M8KLL0ipN7mrjQ-2; Fri, 17 Jun 2022 09:08:57 +0200
X-MC-Unique: 6SI1p9w7M8KLL0ipN7mrjQ-2
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
Subject: [PATCH v2 1/9] dt-bindings: thermal: Define trips node in $defs
Date:   Fri, 17 Jun 2022 09:08:39 +0200
Message-ID: <20220617070847.186876-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::32) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4f854aa-8c9c-4739-4e89-08da50303b31
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0263B312D20192853BB946D7E2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: me1WG8aupkuS4f0WTnZYCMt5nnsDDuphqKiR8z2/wj8yXJuj+ggGLXg+m/wNDrWotSrOG09Q75Z3FZElH1BrhCugYKj06ShCOojhwqxl3dWWRaQY0cDSixLQSMPbJd5R4IbvqROV4rDf+qlrYg+TQPOq79V6x/Rt7XbDfy1lG0Jsy0ygu1pnpkwN/jOFTfxz++e81M/qzQ3S/FDcwEG9ccAYyx/Tsm++ehk42M7emw4LCzcRYYMoY+/jHT3E47DBdvGYl25ZZwRwN3BGYFwNiKp0BOZZ2fmLKevvXMg/uwZ7XIEQH4WbLCYI6cVKeefxSyju7wIqm9U2Qf6IRAwlu/vkoQtB2dhcUOJuUr8cUVD/dLg+W6lSTAuX1OSBTSKfgA/MmcgVw9+xWWN1EDYKNDgrAC9yt9jZuEgXT025iWo0exJjJBA8cBYe+CYX14AvijdJfDve3y4s0NhhBOU4xbSB4atd2U9CJ2P7xzhcHAlydAZtp4C1cG1eQyGPQiPsCT2oxQzd6l2zwLqjKcKEgP024uzunNuKIFop61/gZG5tdx7FQaQSja8ZKUqFN0Of+KlXfZUdZKbdyOJeVt6fro8wa00g6Pf3p7Su6+f1i0KICgHagD1xs8qZM13G207MU/mWMFP+wnA0PYnUF5BW5qJd3c/5LnIJ0WhNs/rKOAeVCrzZ8rFQPSsKO8HEdVoJieZYkGIgVSXEPox159jHDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(83380400001)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aQsLJcqqGeE+NcY9eBMYg3MD5mta17lfoAFuwUE7Rea/GaZTJL8ObbUVeHF3?=
 =?us-ascii?Q?s058/oYPZLW+t+JzQ0XMPk5OHDA+1t7/c+L6JGjmcVYtjYJod2bkwBAEpsm7?=
 =?us-ascii?Q?sfidw8QsuSxfrT16dN3NoLCZj9p43rj6wSWuQSIe+6SOC+a5qjg4HLAFpnkx?=
 =?us-ascii?Q?8fNRxkt3OegMtVkg3S/h4O9k6Jb8b4t1d3+kNrisGU2OzJbK+LeWLfQfqQkc?=
 =?us-ascii?Q?kEZYrUop3zA/eDLJaR7CEjT8f+uYlbBYJGqFl2dX+ULImr/VookOrk0GUl5G?=
 =?us-ascii?Q?EMyCtDDfmw+h6iAfFHAszGU7sS0bafsdbhczq8UZm/gc/EsgROvmbGOhqTpl?=
 =?us-ascii?Q?y2SN9Ek0KBz/psc7WJga324K7kPSdRzfawEM9dV2PX3N0IMvfQM59kqMZ/kD?=
 =?us-ascii?Q?nZvecnk/I8dMePfodqeG2YBND+5MX4KFmn/7s47LPpQcdWum08aqipXf0LCa?=
 =?us-ascii?Q?8TU3qZ0pkjhOqK4FJLGWLoVs9WBAIW2f/Dwc9AGPEAB8NQpvTCZiLW+Eto0o?=
 =?us-ascii?Q?s00G0umm/y7pKmBdN7ZATAdD12/uL0kZ69nBMDEVJjuahLwCsnMXYTmNUr8Z?=
 =?us-ascii?Q?bKKRc/4cHSE2xWjGhUAbdaAfAkAfqHO0XJiwPrAUPBur51gaUs0BqM9txAEX?=
 =?us-ascii?Q?sgyQe3OuCJ1NS2nkJiR6eVhRuHienb1TIBdR2NTqBc6Ipysz5QjLFQN0eT/O?=
 =?us-ascii?Q?42C10dybgNcYwcKXBm75CgxnxgAUXfvjSdIoKlI9F5bTuNGoOs01sxpQW1Ub?=
 =?us-ascii?Q?CPUCawpZNWsJ0SKKNxAUf6P2hOjaiePyVcaB+dAJvkM5xBByOgtH9zLNJj6W?=
 =?us-ascii?Q?CLJ61Bp4rLwQqi13etAH8MOTcl4o1E/Ol1SavA+GNIPkW1u0CQHNeZ9gnFFN?=
 =?us-ascii?Q?v8kkBy38PW/15mL4dNjp2Z4DhfAILD7v5yiVaE9XDgxhMEM4gNqsGHFfFi6h?=
 =?us-ascii?Q?6p2UWaDEGlJ2da2+coP5LoaEtFArop83RUmpqq8fE7kCDEMVEHBtqM2fnNSc?=
 =?us-ascii?Q?Qr3vQu50tONB3knlb+isMmxWGhXl1ylyUAkrdkB30Ix4S6UwBzhyfT3Ho6P7?=
 =?us-ascii?Q?GVmlTxJg7MEM7cc5kPYZZYk9qgA9Xx2s8qmxi7L8jPgsas8RIOA6ALKMh0iq?=
 =?us-ascii?Q?0bLYmWU0EdaL6268RJq+s+C0QxM32EouJ4F0Ky1jFOToQ9gSK7jE6NOEG8Vc?=
 =?us-ascii?Q?u2yBKtOBtxpL/JQGHLnp9yMhkaIGk2uaeFGHFNheCPEH9MoLunMboJkib8kQ?=
 =?us-ascii?Q?T4e+2/fLxhw4yxE6n4phYE1E8sM+vqf+uFweFhZq+Lg2P2tMZseD4DCKyiJG?=
 =?us-ascii?Q?2wzFYu3atEm7bg3kMVItKNSokAY5OfXA++Yrdo9f3lUgqJCg4qOA64vffJF3?=
 =?us-ascii?Q?sGnGGmWO186u0UQmglHa3m5O17jtIg5myZ9DVDUY3eeG21bZcvNYHyThaZg/?=
 =?us-ascii?Q?Haf1QeASjzthXs0R44n3iSKWMz4QXUTpP3qJnwBkbyLdVZfk7o7IuAkUrCOF?=
 =?us-ascii?Q?hvdMTG+7RQ3Zq+88wr+r03xaKCEaXSyDa/CoqCMOIubOyHpZ4OrMI40BNnv3?=
 =?us-ascii?Q?U0aKNcV+HxweIJDK5z8TVXNt4RlNxs1cthLdviUk2ulIap1BvURpVYKWDeZA?=
 =?us-ascii?Q?6tlNNlAkNOwUjvn6HU1dJ+LkR+gZHQX5QRZVSY+wTK7DMzFqru32eTIY+s2f?=
 =?us-ascii?Q?haHea3xS/stR/2shRXvhlu5mhIklMqgvzZgi/mYHJ9iU6OYPxgncDvGMRsAu?=
 =?us-ascii?Q?UM5iv/7Y8WG+umMcoY8LVJ/0AIMGuHQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f854aa-8c9c-4739-4e89-08da50303b31
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:50.9491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx6oFfSHoC0w4azkdFDZJ+Ib7UG2qZmNzT3b5Z9NGIiMC9SlvcfA99CvRFqoBljXRI/cm5oYiCbzxlUAPbEhYu/2jdyDVuP521PxKm/XScE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0263
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

Move `trips` definition to `#/$defs/trips-base` and just reference it
from the trips node. This allows to easily re-use this binding from
another binding file.

No functional changes expected.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 .../bindings/thermal/thermal-zones.yaml       | 130 +++++++++---------
 1 file changed, 67 insertions(+), 63 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 2d34f3ccb257..ba84233d20b7 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -10,6 +10,72 @@ title: Thermal zone binding
 maintainers:
   - Amit Kucheria <amitk@kernel.org>
 
+$defs:
+  trips-base:
+    type: object
+    description:
+      This node describes a set of points in the temperature domain at
+      which the thermal framework needs to take action. The actions to
+      be taken are defined in another node called cooling-maps.
+
+    patternProperties:
+      "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$":
+        type: object
+
+        properties:
+          temperature:
+            $ref: /schemas/types.yaml#/definitions/int32
+            minimum: -273000
+            maximum: 200000
+            description:
+              An integer expressing the trip temperature in millicelsius.
+
+          hysteresis:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description:
+              An unsigned integer expressing the hysteresis delta with
+              respect to the trip temperature property above, also in
+              millicelsius. Any cooling action initiated by the framework is
+              maintained until the temperature falls below
+              (trip temperature - hysteresis). This potentially prevents a
+              situation where the trip gets constantly triggered soon after
+              cooling action is removed.
+
+          type:
+            $ref: /schemas/types.yaml#/definitions/string
+            enum:
+              - active   # enable active cooling e.g. fans
+              - passive  # enable passive cooling e.g. throttling cpu
+              - hot      # send notification to driver
+              - critical # send notification to driver, trigger shutdown
+            description: |
+              There are four valid trip types: active, passive, hot,
+              critical.
+
+              The critical trip type is used to set the maximum
+              temperature threshold above which the HW becomes
+              unstable and underlying firmware might even trigger a
+              reboot. Hitting the critical threshold triggers a system
+              shutdown.
+
+              The hot trip type can be used to send a notification to
+              the thermal driver (if a .notify callback is registered).
+              The action to be taken is left to the driver.
+
+              The passive trip type can be used to slow down HW e.g. run
+              the CPU, GPU, bus at a lower frequency.
+
+              The active trip type can be used to control other HW to
+              help in cooling e.g. fans can be sped up or slowed down
+
+        required:
+          - temperature
+          - hysteresis
+          - type
+        additionalProperties: false
+
+    additionalProperties: false
+
 description: |
   Thermal management is achieved in devicetree by describing the sensor hardware
   and the software abstraction of cooling devices and thermal zones required to
@@ -105,69 +171,7 @@ patternProperties:
           10-inch tablet is around 4500mW.
 
       trips:
-        type: object
-        description:
-          This node describes a set of points in the temperature domain at
-          which the thermal framework needs to take action. The actions to
-          be taken are defined in another node called cooling-maps.
-
-        patternProperties:
-          "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$":
-            type: object
-
-            properties:
-              temperature:
-                $ref: /schemas/types.yaml#/definitions/int32
-                minimum: -273000
-                maximum: 200000
-                description:
-                  An integer expressing the trip temperature in millicelsius.
-
-              hysteresis:
-                $ref: /schemas/types.yaml#/definitions/uint32
-                description:
-                  An unsigned integer expressing the hysteresis delta with
-                  respect to the trip temperature property above, also in
-                  millicelsius. Any cooling action initiated by the framework is
-                  maintained until the temperature falls below
-                  (trip temperature - hysteresis). This potentially prevents a
-                  situation where the trip gets constantly triggered soon after
-                  cooling action is removed.
-
-              type:
-                $ref: /schemas/types.yaml#/definitions/string
-                enum:
-                  - active   # enable active cooling e.g. fans
-                  - passive  # enable passive cooling e.g. throttling cpu
-                  - hot      # send notification to driver
-                  - critical # send notification to driver, trigger shutdown
-                description: |
-                  There are four valid trip types: active, passive, hot,
-                  critical.
-
-                  The critical trip type is used to set the maximum
-                  temperature threshold above which the HW becomes
-                  unstable and underlying firmware might even trigger a
-                  reboot. Hitting the critical threshold triggers a system
-                  shutdown.
-
-                  The hot trip type can be used to send a notification to
-                  the thermal driver (if a .notify callback is registered).
-                  The action to be taken is left to the driver.
-
-                  The passive trip type can be used to slow down HW e.g. run
-                  the CPU, GPU, bus at a lower frequency.
-
-                  The active trip type can be used to control other HW to
-                  help in cooling e.g. fans can be sped up or slowed down
-
-            required:
-              - temperature
-              - hysteresis
-              - type
-            additionalProperties: false
-
-        additionalProperties: false
+        $ref: "#/$defs/trips-base"
 
       cooling-maps:
         type: object
-- 
2.25.1


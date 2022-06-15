Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6920B54C500
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbiFOJsj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347492AbiFOJsU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:20 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99B0346CA5
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:19 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-5Gm0WjbeOoyZIhzSSzAsLg-2; Wed, 15 Jun 2022 11:48:16 +0200
X-MC-Unique: 5Gm0WjbeOoyZIhzSSzAsLg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 09:48:13 +0000
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
Subject: [PATCH v1 1/9] dt-bindings: thermal: Define trips node in $defs
Date:   Wed, 15 Jun 2022 11:47:56 +0200
Message-ID: <20220615094804.388280-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0074.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::14) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e798e596-538a-4aab-d844-08da4eb429c1
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB03927F28DFA1293241B1C1EFE2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: tMmZJDRnqEA8YQQD3RVIsV+v7XqhI2z7FXKjKi1wfdHNZHi4a7bnDX5USXZiPYB6r3iCvaIypNtmnJQlsHFe7YEQt9T6/VPM1RrTWdzPVu3Mz5KBZOb04Cbi3DL07Uv4xwZ1GZUEe4hE64BvODNFuO7OpywKKgR+h3BDUb+FOzgYV+nH4dZVaRUkoI/NKXVVZ0wNOTiu+X+41aJ9w6LuKSF+aA9B7nkWyDwgpwlCDdLyMyfbIiUIkFc85CaKAnUl3BpxCazfLYhtpl9u7tmOaa+xH8RYfOKpj3jMwYOzVimvWQpDiiwh0VZDSv8B4mnHzF0Ra7bD0/BHcYaJh6pYrTDXCUO97/o2x4NkcYDdjW9yOEPfpPTnvygcfrDpDbFTEHuv9RM19q3wzWQZKyICaNH+RnvGzCrDtYYUbCKXTzg3Hf/Rrm4g+SZfYt7NRHIuwlZLkGpZ8mjt5hAy7t8wODkHZUp3PF+/EBKT9PS/xf9zCDm2/S3PDe3kvYpCy5+qIg5ZBiQLrvcfenvdl7HAioac3vjTe9XfwByIdlC1vmV8Z3AQIwZJC4S0TdI9Bc0jpz6oA4T+G0oPLkYFh7PV3PCRXMJm2lgxDWnbOYEmtWDUIvB7j6UKDwVz4P4uoYbYMKgpUADBvGtkbYSGgZMhLtiC2OZaLpa1D08Qom8YtbBdmS0+2ILk/ZKlIG6bWtVsQHY1SIHZ8s/iCXtUsfjqDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(83380400001)(38100700002)(44832011)(5660300002)(6486002)(186003)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yIcpwDR/OicJxOCOIRtZ2Pv2Y9A1CRJt7vjD0vSjmhmlrbFoXAakU/Vot8FC?=
 =?us-ascii?Q?M57RPpKzX7urjdgKqvg3C08ln6PFn2nYDinw5VwBFDRDrqcD6Zdy0aSNpNfP?=
 =?us-ascii?Q?LBFwXTeNQ++3Wjgbp8Er5Zz/nijX0ZeI9BlLxFbVwH27W653W5Mls3HEHaVC?=
 =?us-ascii?Q?Z3FPEi0h5qkk/712nxGom9M6WzHKchXYA2dqFguKC161cxmh7nX8ExWrfYko?=
 =?us-ascii?Q?cN764yEe/lbsrBUYS4T4kfCvgm4hKqwzdFMLpaAYBAtqdMDxfZAeXe869IIV?=
 =?us-ascii?Q?vOGZcYV81kt8KcK/7NStPlbgCVxgXAZckwk/U5cI0YsPPBqpX6EnO7sLCRFo?=
 =?us-ascii?Q?poHPEGz01EV7JCi75hAnVrZi/ELLgdhYZRrQQb+MC50o6rYsQ3gc7Cs/9vyr?=
 =?us-ascii?Q?ijzEy9NxWJY1StZH66e9ywc4TaoZP1fFzXYU4D8sN/NPq0kgcA4v/1cipHjH?=
 =?us-ascii?Q?1CiuTZ7pCY+dFJ6l+UlYLOthKT6mAI1XkQ/w6HOalMv+OhzDB3TGGekm/Psk?=
 =?us-ascii?Q?a1T9Mzt8bEnpcxTf6qSnlK6iuPjwAnAg9K1rivIy/SwwcrJ6CwhtAAOXhEdy?=
 =?us-ascii?Q?Y21oRcsjGlsZw8TsxQW30QLsVS3iijP5Gh/Mlty/F93VgMMexqSI+pWxJEgM?=
 =?us-ascii?Q?nXDL8RFmZS6FIk7Yx2fXpYA7VSK/C94ESJnTUJ7RS6aMxgeeNPGkiGv5G2aF?=
 =?us-ascii?Q?Vaki1f8dgMRfoevzPnF2RKycwe/yVR7YzoXDQcwN94sslMvqBJsV3w1BbgRx?=
 =?us-ascii?Q?Fo4rd+Sg6vV7LeTAU+E7olYlx/JgBiLbZnfRz+wS4vGgW/MsWliQxN38PXYr?=
 =?us-ascii?Q?ZjD+w0GeUyYK/NewhCT8mg1f0UlPdZ1Kzjcw6lDFuvly/Rag/q1DKd7JlnYi?=
 =?us-ascii?Q?Gb8W0GnKyKFMcdkdFECBxfLAKfgWfzFvbTK2C+sX40DS8zRec0+LUK1L91RJ?=
 =?us-ascii?Q?YV5vk9h7qKtyAJDYqidKRAzHcITzrGz1DexWMJfAdaWzY6aEwEmJ5I1M8Zhz?=
 =?us-ascii?Q?p4Quk16t19kCjpl+uaTm9FDnDJNrS2dL9FYq4aF4tLn2O+rPNytUCoQugzhV?=
 =?us-ascii?Q?NkZBOz7PoxtGLMH+7O2xks599PnHDU88fR5X1/OM1NJqykgQdqdeSpVAmL4n?=
 =?us-ascii?Q?RFMsY/5snk6+qe/99aOXhIBhJy6qDkh781/VYfJQlFUlMAc9ZmUznzy4wabW?=
 =?us-ascii?Q?eRxtGB3xCtUXQtXJ0H9w/6PBodCm5vVURSCbV1k/MU1ktRuCsz72SvVSjrm5?=
 =?us-ascii?Q?qY1EN3vjBN/Qr1XBRJLWr58iElGwrZE/za7nHGvGgGgBjh0yYQMQwi05BMiE?=
 =?us-ascii?Q?pIqzmKr688hViW6w1rrZ2ZPmUpM/cMMacfY3LMPfY1KmrplyzB5PrplrItcF?=
 =?us-ascii?Q?6Ni3UhpVokelEM/vOaROwoE7R153DRk7znBWVqymBS2gldTLqrWEE6BiYhgN?=
 =?us-ascii?Q?kMJXklDt3jjhVTU0pyKBU+Av/jUHQAKt3ysvnBKELDzKVBaVV7sKa4pcg8Gm?=
 =?us-ascii?Q?BdM1PmTiUORcHXo+xpQGw8tRO2U1SRIzi5BBek/KMZScDYo1bEopYog5X5pw?=
 =?us-ascii?Q?HkpM++mwk6yZbCm0WYhpSsZJXOXzjEaK3W7HpQ2dfjW8bUtzxHRUbwZMbD2V?=
 =?us-ascii?Q?oNeFpkGClZ3AGvQ70MvGE6GUu9/MmEzI0AHO7O/n52qVERLwhLKLQc+NZsLw?=
 =?us-ascii?Q?ZU5wPk/dHGoivkmTEYFh3Y4Iu7tvOE4NDype0gLhgZ+wExvl7pv06+6RzjdL?=
 =?us-ascii?Q?pH5lyetUGpnWkOy1ud/IIBLrENPAx4k=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e798e596-538a-4aab-d844-08da4eb429c1
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:12.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve1LTIvPR5BZTh8K0pD37sbAjTXexppto12E0EMNH2fZtLmX+DrsVMZ++7TMGtswjvge6lOfkJnEo0jPQVcARwZ5wUX8AroHAM8x7YmX/rE=
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

Move `trips` definition to `#/$defs/trips-base` and just reference it
from the trips node. This allows to easily re-use this binding from
another binding file.

No functional changes expected.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
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



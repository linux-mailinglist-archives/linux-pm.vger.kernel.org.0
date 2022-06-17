Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B254F1A9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiFQHOa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380524AbiFQHOV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:21 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CF4C66202
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:20 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-vtkNLl0MNjWlE6NYCSBtCw-2; Fri, 17 Jun 2022 09:14:17 +0200
X-MC-Unique: vtkNLl0MNjWlE6NYCSBtCw-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:14:14 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:14:14 +0000
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
Subject: [RESEND PATCH v2 1/9] dt-bindings: thermal: Define trips node in $defs
Date:   Fri, 17 Jun 2022 09:14:03 +0200
Message-ID: <20220617071411.187542-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0168.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::16) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6310d4b-ea5b-484d-2608-08da5030fb95
X-MS-TrafficTypeDiagnostic: GVAP278MB0438:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB043876F807BDB11886FE760DE2AF9@GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: GEh68tqCZjv/A5tLd9S2V345v+Qu+jQmHP90H12m38Qwv3FUkEuBq4GM0+/8ycRbAqCPLTd54w4tIABs9NkktEvLky7T8tQg5EmNJ0VmTTaK3e+QDlUan1rXRvnyQk2+hrvarS72h0GqMF5thw8RJlGu7/EqemHFdcRdAFSgHyskGA8s0LKpuHXVVjGeRLVrNVrdia5to7E8KUyEK8yORZbB5EOjQRlJdIRleWp07A1QWcAhOCybnfgWVJlDH4Hrg4/Qt6KaXTLlWsRWoG9bDvpG181jogx6C5YvYIwAJziPJdzcC8QobFkjIE3pnhTwvnfBy0dbIgBGJmpNglR/tGQJPJQjZZxVCO0v3etSNI9ztWE68c11gkyEafGm/KIQcb32MpNGx76/FQvibKWMBRnoDAaOVLpcacMUQ2pqRKBQrUUluuYv2RjAQCSdVslFCUGSt1+/zZpsAYFv5GddgwxssavEcDXbQVDYhh+S4Ppuc2c41GxXngPokQqPY9N2a/HVZxv5cTgad2GKSls0JdLtjBwZx7tjFKkcaAIWU69UwYUxDjIpsoenH19uI7yPUzpiKLU3ZltEocRKS60YP+buQezfviIvDHw40CA1jYkqcsIpFGfe7NuWhBQCEfYRlimXUv8SsVoqkCVcGcebmwSntFyBYvsFQdwyUdfaNzKmd7b0DWYmVOeY3npNSoXW0FHVjtQjZgAT+f3j2i42Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39850400004)(346002)(52116002)(38100700002)(38350700002)(6506007)(2906002)(8676002)(8936002)(6666004)(6486002)(316002)(66946007)(86362001)(7416002)(508600001)(5660300002)(44832011)(83380400001)(110136005)(41300700001)(2616005)(26005)(6512007)(36756003)(66556008)(54906003)(4326008)(66476007)(186003)(1076003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2i6Et2EgTj1S8/WtUZoDD3lyR+eLgORnjJ+j+dY4E9Q1GXFv2AGt5QjqCqo?=
 =?us-ascii?Q?KZEVHh4qUCe9p6K3zfw0nzWr3xmD+hSP8bxo1NbWU4BrqYOckwoRfjN04tJu?=
 =?us-ascii?Q?/mqPfwhToMGnNSHy4cz121xAryJ9+ZvAiCHBJhEkpz1h6qzxkFnlrn2VJDtx?=
 =?us-ascii?Q?unUH5xDjEvFSXbUMcFR9v631Qo7VcJ2a6bfqnD5RLI/XXjbmowgqjfQxjyjL?=
 =?us-ascii?Q?r5iBpSF3ix3I4waQrS2vQOGhaPZlQdRu174dwJq0EB0tX8Z0XUFUeNdFBMhY?=
 =?us-ascii?Q?S3fthpz+6ho7rzZwsoBXjo+jBr+fm0r/qP5wh0OSnkh9uY3MU5sCO3AmrHoz?=
 =?us-ascii?Q?/VmuD+uLf+ZSr8zqZhO2qZwjIpLGV86G/Twy56+7J5OiprcizSVUEllM5FE3?=
 =?us-ascii?Q?DERLMHp0P4MXySk9XvzDj3oJOI4qatHZ/UsOGJWlkqES3i/2Q4HLToNh1Yw+?=
 =?us-ascii?Q?qCbJWAjsTYesjk5mMGSF/iN3QDJ7TheSEm3ik2BZJXfVq9VVMuAVNb3EKQCa?=
 =?us-ascii?Q?iqw4qHFgnnYwUJ0B0rjRvVDfp4LOeax2QRyGxA/NKnivOm5qY/HYKXWyXHMC?=
 =?us-ascii?Q?o4fXCQsEb+34RMzoNMEjWiggWoT0Ithu/6X7vg+PHQ6TCa4fFVoqrIXYX2bV?=
 =?us-ascii?Q?LuFuXLIMhlJXPwKclAoIWBdqRIHvRClTMzx/yMJnG2sXz224TxQoMG4+Afoa?=
 =?us-ascii?Q?PzkSOHvRbe+FPl/wGWDMcf9cnmXEPQL64H4pIalwq7p35u7dpXfmhS+R9vOd?=
 =?us-ascii?Q?6yYxL308+8y3HBlOFpOvFsDzRROljhTv8pdQm7Dr0SjKnMum8Kp5aF//1RcI?=
 =?us-ascii?Q?slTuUteflmdxxyFj2ZLlMb+SoNdt68JkZEu7anTcGuC8GldjCbjpqN9T2Kpw?=
 =?us-ascii?Q?mUMHquX17TevB4E2L8CpofSpKXAxlMCABCK9nfijmDDnaTZFB4tak/QT6ftG?=
 =?us-ascii?Q?vCp+nnlw0JoYeAK7dr2vV85Qgq2qmOigqFnsmkatTDPbwp4CBCqBxUYPi/Xa?=
 =?us-ascii?Q?7/G17W+ZAccooiC+OOXlJMvkGf3DpM3qUZJ3S3oVljGc4lDm47QIn6UhggxQ?=
 =?us-ascii?Q?UcN6bKiziBYYCZXl4z47qWZlpbbezKMNrS0Zn9TRzXlBTyDMz9HtI5my6frr?=
 =?us-ascii?Q?HJ4PYgXAdmLcOZPXcYEywSrM/t/WY9Ev0EIJNGTJOkOLJjX9xdWYeUO9f/gR?=
 =?us-ascii?Q?MI88XtNt/AL9s2loC690Rfv2cyt76ZGx02XhV85mHvaWQkkZYXOTVVvzmmBB?=
 =?us-ascii?Q?qbxkWyo6Q64R4QGCloBap7l1lrr0R647s8ehWmCD4w5eCOvnDy4T3ztvdcng?=
 =?us-ascii?Q?tHgRHvcfHR19iQZ/vFrcwhs9XrXMkanRsRsLImrZjvzk7shDc34hM/wwnpI8?=
 =?us-ascii?Q?dJC31nMbWKYCne//P4fSsaawprycjicDEy5LMd6uVThbNVPCPbK2kQtnPhgy?=
 =?us-ascii?Q?GEK2luWfK2szOVj1KRlxK/Lz+M2yj1X7d+vRunv0bBGecrtGh/2RhhMmHRsd?=
 =?us-ascii?Q?kjKHSfFgxX4CFLSj73GDqyjeboI3B8DiPTNgyUgLSQTZazV7jJx6/Zd3w4mL?=
 =?us-ascii?Q?i+RijFFmh5ZgbDoIGcBNXV1a1qf1IqCq/Mf1TiSoW/MlnUMM9g3FQDlNKICB?=
 =?us-ascii?Q?8oxajUfkK1vRWMhCC0o46ZvWo3W5n0pc4nps08tKfnu1CUATG1FlcEUP0atO?=
 =?us-ascii?Q?vcaeBtXX4sc7E+4Kx6I64qk0rN+eUzL5dTmA5psPRIRaQl+w1dYEab/5MMsj?=
 =?us-ascii?Q?sdQsg7ioCq7TmwFiO5T4NtIVv56HyoY=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6310d4b-ea5b-484d-2608-08da5030fb95
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:13.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLNgkCT6eXpwBoZsQ8zSmmE5Z6bhl4tRxJLCbV7/EgegYwy9YPuR43HLGHdJVRwDeu25f+UC/fO9JNp2jiPefrTf18Z2IMr/Sr055zHmmfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0438
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


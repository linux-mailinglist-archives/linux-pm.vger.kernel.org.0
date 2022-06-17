Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEFD54F1AB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380537AbiFQHOa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380542AbiFQHOV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:21 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5D8F65D34
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:19 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-e44_sS4TPWOU68I9wyiL2g-2; Fri, 17 Jun 2022 09:14:16 +0200
X-MC-Unique: e44_sS4TPWOU68I9wyiL2g-2
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
Subject: [RESEND PATCH v2 3/9] dt-bindings: thermal: imx: Add trips point
Date:   Fri, 17 Jun 2022 09:14:05 +0200
Message-ID: <20220617071411.187542-4-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::28) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 793f2309-754d-4018-de32-08da5030fb48
X-MS-TrafficTypeDiagnostic: GVAP278MB0438:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0438304EBF737DF2845A2BBAE2AF9@GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: jKYECH2k5onn0rCadqheGsmHZmMmP1ZKQEfQvXSHaRHu8S1b/SOQtddks93aAxWNc3h7BYiel0bmH341A9pFFKrZS4cPNgL40FOavP1Mghjfyd4iZXfLUwA4//FN5Jq8gRw9Qzk30rg8TpZ93ASo4LkYvCx0vpN/CBOA+ck4hlP4bnRqgnzHtLj/z/1UqwM++lrzLqkgqO0f1kLgPsN423MKQFNEHkXPQiBZ3neXQ3Hh72l+V7aS6IWRkm5L7XkJZTCTACBURxtV7QQHlA8GICE1PllgAlFewdz6teIGMnVSxBIeVtnfPrLV53Hi4wW+c/nI1KwNjqoA2QvT/VvcBVVEVgMfGJNnUbDKJ9jOyHu76EXy/TYMaGDMBxS789jqs5u7x7260k8p2WAcwdkLgpkBsVIGptANe+lvIWALH59e5nO8PTezNAqBGpqOIEtn8SQGL4et0Avzdv0obOJfM+66z3yz9IWidspAXKBm9ajHNXSPo9kOIXP1kVR6D0EChuocPnZckSLjpfFE/ih7G3otFHtRN3Tazc4MD+KiS9rqPhpq6fY8ln5qKThCctNSOHy62Wp+6azrlixEP3ic/50bIoSUU2xyWAmDXrOoOY7myqYOPAUm3s4DNjaYGQAnY4zMOY1/BpPou38lkSD/wdf1rWCMh9LTz2ns/c7W7kjuLMo1s+XruPqH0qltWFh9dmdnZoha8ifwe6//AYXfCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39850400004)(346002)(52116002)(38100700002)(38350700002)(6506007)(2906002)(8676002)(8936002)(6666004)(6486002)(316002)(66946007)(86362001)(7416002)(508600001)(5660300002)(44832011)(83380400001)(110136005)(41300700001)(2616005)(26005)(6512007)(36756003)(66556008)(54906003)(4326008)(66476007)(186003)(1076003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P+/l+88tQ0cvgcfZlS1Amql5F5LaxD+jdcuDGE6DVDdxTjsM5gTb7UH/sUMY?=
 =?us-ascii?Q?t8apLSrv5DLsEzF8ZQRkssFmKNdrMBTg4XVbVWvnxhC0T8S3XRG0stERnfgW?=
 =?us-ascii?Q?K7N24RKjHLvaFN/4Lec5zwuZwLRlnzCSGfkl+sMOvmR2P5VdbSkeKZKYBANO?=
 =?us-ascii?Q?sc/+4f1IwXTiuD+gz2qTlmfFUEAnk9JhiYkZh5Am2Teyh2f6uAkGtytMER3R?=
 =?us-ascii?Q?2cvUdwCvP5X+aVFZnPGMoVA6m5AeR/nA68WD+PXYtIrGHr5Gjt8pYbd3eZ4f?=
 =?us-ascii?Q?BIhGUg2JGKmeHh5PWeSIdG9VFRGIH/qEglAJmWvJYFi26MgsBASBW/sXvhiU?=
 =?us-ascii?Q?pp9RkP85ARGs9oWXC6BxFn8vvRc/QINpvk1stRhb8VF2Cd36fePkUP0hkAV2?=
 =?us-ascii?Q?QAGX+O6AsHINqqzfiQsfdT2Hwn3NBA13+eJWdh20OG20dfCV4lToP19Pob8e?=
 =?us-ascii?Q?gnaVXQ3ZVmZN+fHQWiB26T3ElAkDh9XrpsiYD6KvLrnRVKx2JiBssHfhILpq?=
 =?us-ascii?Q?FEaB8TpsMLKJo5yCk3J0huglISQevRVs5vJcin/EHx5aXHWz9aGIRv4lQNDV?=
 =?us-ascii?Q?Q3o+woEfgX6OCcXS1jBmq28DYeLIQkCi+ka3Hwgw7JzbFH/QZKXO+wmm8Y7B?=
 =?us-ascii?Q?WYlrC7vbjGJ3zonSXYtIgw8jxpwCXMacMjnOEkY9u0Ly42djzGA0wRQkX6hl?=
 =?us-ascii?Q?w3Rj9Vb+qbNpl93kdY7BB70Coeq64K0B2XbIxBIxATUHdJeSnilQPsGhZCl6?=
 =?us-ascii?Q?tcdfq6nRB/LVEu8RoZggP+vlaRS4GFaad8UTKaOFJa1trL67pbqqWGLf30+D?=
 =?us-ascii?Q?ZsxFboze3fGJd1FDvrwEfJDBQzBYgGrPvbuOZa0PpPh2ZCL3eNaBxZjEFmLF?=
 =?us-ascii?Q?drHgAGGnM0D62t8SilTpgB9c14j3r2KjNFCYrHuCQxJoS7yAV07nokT2ZGvF?=
 =?us-ascii?Q?LR4bRlfbRDVQO5i9ikg4+RZAbftRuo4bp76bZuX/RCx6KTBf8w7f7I5dRaBp?=
 =?us-ascii?Q?5ikcnHmsclMrGMdFvk7trXWej+oc60BW49qS8b51FLQAi+bHAQMbHqeFPKGE?=
 =?us-ascii?Q?B7xtAksFwGveCt7vJRt7WvNrjuViRL6DAJUxjFB3LVwAuWIigESMIMv39BMu?=
 =?us-ascii?Q?ILSnjN8fW311jly3SAcvKwatORrcGH5hUgoPGDITUDcetaq37GtlbVIGSMyT?=
 =?us-ascii?Q?1e6Ufe8JDsPomTioUy6w/suUmQ8vMMBgDkkNophiuDFOfYkOMDu2w3Tcobyr?=
 =?us-ascii?Q?BVKcFPZIcpkZNQe5nhPWZi5RX9ms784AIyDWE48CsPbVJa2NKoYfth2tFQdy?=
 =?us-ascii?Q?2PcIC6aDv5XCsS/N5AJD/FWmfwRQaGDSHE1E0PjhLIb4j0bXe7Bi/SbhT2AF?=
 =?us-ascii?Q?HvMpk72W4NqdQInU66IMdVxS/gw8QMlpylD+Yp4icRqn/4tVdmwxC+Qp7RNL?=
 =?us-ascii?Q?YR0B74koXyRobO0XmX3inl2F781eNpgakwo6hI9hxwa8/AGf1h99HW5dsOkK?=
 =?us-ascii?Q?aSTleolY6y1xxVhgrCl8OTNyqs+LzJvsK0iLcvTym/gGS0iYSDZwLcbNklLp?=
 =?us-ascii?Q?aE1XAt39+vqcjyqgIfKj27KSRw62uXDy3XEkgdxpzd8oyv90iNUnNkDP41nx?=
 =?us-ascii?Q?wsld21kIGVepieU/55oiiVJLWTEnurmiEUGOm/89BHLsySqaSwNhY0tky7b+?=
 =?us-ascii?Q?Ast0+1J72WAqWbY8HQM9G5SZQkPwwEb8g/Zg0ilfDcknM+vfU+zg4XLNt/qa?=
 =?us-ascii?Q?L1NuY5J+GGC2qSg3DHs37w3wKUPMlEk=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793f2309-754d-4018-de32-08da5030fb48
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:13.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZuFOENv1yb/Iq0SoD/GaRxMPiG8/3yanZAhN0FWkjOMM0hAVulNhMTos7Au4d7f77PC8W2mPSPwYUwXvnEdDA4T+LlaKQhWhoOzWwNsPAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0438
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


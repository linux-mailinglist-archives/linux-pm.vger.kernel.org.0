Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7854C536
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbiFOJ5V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbiFOJ5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:57:21 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6CDA4A907
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:57:19 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2108.outbound.protection.outlook.com [104.47.22.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-fUnjSoLMM0SUPAfwXtujYw-2; Wed, 15 Jun 2022 11:57:16 +0200
X-MC-Unique: fUnjSoLMM0SUPAfwXtujYw-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0296.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Wed, 15 Jun 2022 09:57:14 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 09:57:14 +0000
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
Subject: [PATCH v1 3/9] dt-bindings: thermal: imx: Add trips point
Date:   Wed, 15 Jun 2022 11:47:58 +0200
Message-ID: <20220615094804.388280-4-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0156.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::17) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da4a8508-5bd6-4a15-79c8-08da4eb56c9b
X-MS-TrafficTypeDiagnostic: GVAP278MB0296:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0296B27444C7198BCFB5C994E2AD9@GVAP278MB0296.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: MyH69wnItQVk/OzJdLAttOae1hVil9OPlDfKk91fvFz+kh4j8CDZZC9ewj/fr/2wuxSgaXNvu8ygFvIoigcZwkUrNnqzzf21gaAQTdnsSgYVCEDsJqusHIiScLwy6c7HyJhDH7YC8to026/507Tt4KKCqws02cfRT5O+lZwAwY+jlk/BfkHnHqAIEeHn+r6jXtbiPAGfr3baVVTWgJq/4LIpdHcvJbTEwAjI7DJQjHvZmJ0VsrZF+anIILiMhRfaZ+smps+PY9YyW9EovfjtNNOt5w5TI+/RqZgfHUTNTg5UQSDdBNPt/On6msgIHuaP9ZJIPv5CunQvjpfZ/xgCCkyVoG6H5HPdcRZO8c3ckEzl43wp2xQdfzEnkVySYYiW4yLg0RKG1aXM+/DlY2AadI5Y71uwz+Kb7IF04iCQ3TZadpvDi7b1cYNrxZ0ks+XgUbjdeliu/wxJ9uUr4TBt5SQsQ2W0mridjshoQvFqVnGWCu/kAXkDWXEpjp13MEbqlLNHHZV9QdDVPMOwzl8bbQZJf3a3D2R7prRuwbPPFlP9U+h7SdFim8yvLf3gOGGC7isVcslM+wKglZxY1/0LFILZMtPrj3PhrYOl0c7iGyR1RbOP2EpBqNASjKXRf02m3VjgjNWLhFF17EsHBlqEZeIcn9kGQhP8BsPOVpw3u+xajhfHt6z3GpeRQkbQ7p+BvMxSdS0bkVN5BKz6zSGSdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39850400004)(136003)(366004)(508600001)(44832011)(5660300002)(83380400001)(8936002)(7416002)(38100700002)(2906002)(6512007)(66946007)(26005)(6486002)(6666004)(186003)(86362001)(36756003)(52116002)(66556008)(6506007)(66476007)(2616005)(316002)(8676002)(4326008)(41300700001)(1076003)(38350700002)(54906003)(110136005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3xsPZKBUA2saNyzvD8l4/glZiSyYVvlHP06NCG+HVx0Oq0zijTd4CFvRbgAU?=
 =?us-ascii?Q?UMWbw6v+8un4EebEv6M4VoTBAlwHrX2sMlfYYj0jtBGyOk9WWCSjgNMTgmTs?=
 =?us-ascii?Q?YFmnfEViB5ZMmd0hQezRF2El5DBvMQiUyQir1p/uZ8Eq3rqCUEQQQDRmGkpi?=
 =?us-ascii?Q?lHpx1wB5lvghLY3q71nNw7QyVzOLUysDVMyUGyNd9aI++N1IEwdtb4038Boa?=
 =?us-ascii?Q?9AQHX8V+ZKi/FQ7kSnwlie1T6TgnPxDoiPqkBmY/lgk1O2o43/3/xSrta3bj?=
 =?us-ascii?Q?3cTP7QXMux/OT3cis+1w5RZWN6OUHZIFGDc1i7TNcfQ8fM8Drdjic+MXBP5V?=
 =?us-ascii?Q?stDCJVLeda6GVDuW2YrEqx1SDolwwCe8cwPyDEBQOJBD/nXbj0TtLnLQVOmS?=
 =?us-ascii?Q?2lFzjC6VHDXqyS+lig1QSGGcM0o5w9aDMJXkBXtmaaeSwsltc9CFE610KdRg?=
 =?us-ascii?Q?9cyHRym9b7FJK4chKaFOHiqlgE/txMlSQYgGIW4cYJDjNw75BGp+kX7w5jN4?=
 =?us-ascii?Q?lKcADdaaW+6UfHFKcGNmboE8uNxCbbNO4ld+52cly8Sgcm9xuZI01VcvA+Mn?=
 =?us-ascii?Q?KbH5QoVJDHvl4W5Ve5YKykLN2Z6WNWb6AwfDyeFNP4pLCazWvseRSoV4fexC?=
 =?us-ascii?Q?kk3OCMVT3WjUhTmX1Qgjxz4M5WHWXXoOoveojRQ7EgL0PcnrSZrluB6x+r97?=
 =?us-ascii?Q?sevUZKFX9wsbc6ozpRPpsn0cUFNaNDS3l7JMybx5WNy0cd7+qxO6E+vJCiou?=
 =?us-ascii?Q?6wAae75gqPjlNopnE00WMTC47w15Z9Dfc3cWobRADY7fK7cvSkidexuwy/j1?=
 =?us-ascii?Q?67tOL9r+R8XKUo4ZI1n8MX1DUC4NJJeB3GSc3ZaPn414upOHvBcGtkKrOtyF?=
 =?us-ascii?Q?Wo1xyNranuSc1ogmqXJCsi9/vUg2TOmC3XhNh+1EuHMVhk58/B97JUcuxfgg?=
 =?us-ascii?Q?Al2DB3tjCShWN8UdsU3qOoXfaOqYsK8DjZo9Dp0FOvpD2e/mp811x+J8YfHp?=
 =?us-ascii?Q?5ewgI8PoATpWjjJAqppXCdv+GtyJTdOrSWVf7YrWvbET8nLYbPPNnQ9F/2+d?=
 =?us-ascii?Q?uYZK9UEfv/ECCHrQBZZed/hf99KV+pf03IwNz/Ln9Ijfbw2K2CsLFBM4Dioh?=
 =?us-ascii?Q?cSAXrSW3zLU/NhX6+p8LxdE5Y59QOlbfRiqoVzz81eXKVHo9WYILSTRIp9Tu?=
 =?us-ascii?Q?l1Rko2VJZXPAxk6i1wEONHr0Cn6auXsqPvCU6ZxkSQlknt9VLHW3xMwV2B5s?=
 =?us-ascii?Q?SmVZgmvsIt3izkTd3PUyrIx/zZoZzc2wI7KkuVKoT1GVhTuyvs/d0ZniGkPp?=
 =?us-ascii?Q?55oUBJMGOn8+A1Ss/f1XujrkeCikviqgpPF2bBYXlMl9tl3egVM5BEXei8sq?=
 =?us-ascii?Q?vSBYfPNDe861Rc7S9vJ14OsgOluSxQouZoL+0No9kn85WVj65JnIVq2bwJj2?=
 =?us-ascii?Q?nUkxSkwa/Thbey3Du4Sqkk4n8qqdQLJX/uLkIFp+3aBqdpAvsodxnqvCTnPE?=
 =?us-ascii?Q?e1whZPLhT7JZkE4lRjqzL6tOY6fm8EfDHmk2iYbRKuPMWYlx7G8xs8Fgg0fH?=
 =?us-ascii?Q?auXCyeWa+EidUdI4+qMOwn/DoKz2L29UPA/2b/XcQ11ze9fVmEHF/xJJpCQC?=
 =?us-ascii?Q?G8DY1nPPU0Yj+F3T8EWaRzCGXY6OK0/vrcGau/zwhLWspe8RoNHa5M0gGPu3?=
 =?us-ascii?Q?t27N/3aqcf5TiVkk5+LpwFiCF5pXZoUysgaASbjfx0DSqkzKFz4xU1gBn9D+?=
 =?us-ascii?Q?CqLiJ8PLcQ27Iv4yxzuvixTwXbYt76Q=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4a8508-5bd6-4a15-79c8-08da4eb56c9b
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:57:14.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRVjKEraaAvOa3nYwsWjzHmYNyhaI4170Qp4K0ugffzDFj/MEUb12xziPBrPjnoD/mtjQGBx6s9/Smf0MV1WPq/5HqvjHo7oUYnZrHhZsxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0296
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

Add trips point to i.MX Thermal bindings for each temperature grade
(automotive, commercial, extended-commercial and industrial) to enable
specifying a different trip point than the hard-coded value.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
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



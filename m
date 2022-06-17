Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B702D54F1A4
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380523AbiFQHO1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380537AbiFQHOV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:14:21 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E765465D21
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:14:18 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-GHOpG-1qOf6KL5FIBHnXfg-1; Fri, 17 Jun 2022 09:14:15 +0200
X-MC-Unique: GHOpG-1qOf6KL5FIBHnXfg-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 07:14:13 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:14:13 +0000
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
Subject: [RESEND PATCH v2 2/9] thermal: thermal: Export OF trip helper function
Date:   Fri, 17 Jun 2022 09:14:04 +0200
Message-ID: <20220617071411.187542-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0142.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::34) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3518745-29dd-4b3c-19dc-08da5030fb44
X-MS-TrafficTypeDiagnostic: GVAP278MB0438:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0438BF7073AC8AB93F32B59EE2AF9@GVAP278MB0438.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: txDlX4ieZlW0vXDXCkgTRWhOCxsivL+rTIycqZusuXiDgnb14AcCJ+q2MSRFMTnRE5cyEGbEiAoBLY/kSx0eLF3OA3Z9DVXh5FVrOQ0bu57vRXtexW4xG12gBCMgGuk9i4UsXh4+G2cDtQT+7MMWI98HdeMa36f2m1Gixrvr/90ocW7S8fx/9D9RUOHjxj4e1bRsMERWb2Gfof4xTxQPIUPsfAAAd+xVZ0PX/NhCic/m80YCsUcZEsvndtT2Onz5F3q2cl8i3G//Cycdlqbwg8cLUGEtEfjLI9rEnJakIlU2Yz3GSowmkIsULogn8bCNcLKbRGwDyrULZ991q85Y6QK446Onbj5aoo+DP5YBdrggjczZ6mjI+lg8XLhZgjcerdbrl9SjgNVNwh7Gb15+j4efSZ6Iwqm7GFqlbEoe1uF9MZSeh+5OJmHR2ggTj4O0pTtCA1tYK0DeMbZtXVyyjtLenfg4Jln215sBmzb2oZBLt8hJxhDHgcOPqaPu23qibbGhDzpO2JRuU0KTUPqw9RyrEbS2IBQGDFwuGEfJBS7nyoXY2QBhCqqC/3HpZY8q498JPsK15s7PwarqSYd1HQnD9upFGTrJj81SN4/TyqHeecpEaZhgT41ICQraiAhZqrvo8ivHLj2hE6uR696H8qg7GX4o0muykrrZvS7WY8kf5XPnM7642+O+50OdfQM7qSWiYbrv3IzBet1RYT+XPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39850400004)(346002)(52116002)(38100700002)(38350700002)(6506007)(2906002)(8676002)(8936002)(6666004)(6486002)(316002)(66946007)(86362001)(7416002)(508600001)(5660300002)(44832011)(83380400001)(110136005)(41300700001)(2616005)(26005)(6512007)(36756003)(66556008)(54906003)(4326008)(66476007)(186003)(1076003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqpGMR6/vrwmQMFlFoaOVX2ukogGuOsGFFNYIsUkwQWwS0t5UckZqbMn7K26?=
 =?us-ascii?Q?L3BjAbtRsuSU+7r5JkmJCNGeAjM6oEOTpq2VHzAxDrSOXUzI9yoru6uBrXbs?=
 =?us-ascii?Q?CEv+y/AtTGrrcrf8qYpJgzwrauD6BnJ8RkYcEAz4WXQqheZkRiuxfTFUKQRn?=
 =?us-ascii?Q?jslWroPzIvl6IWvLbiaJvMCo70zTwFGDQyQQGLk/BQlaOSb/q2k90Lk36boH?=
 =?us-ascii?Q?eQ9w38WEQDHNatdEFplYrn7y6EOupixFoIiCo/H9zfwUQ9jy3An4afqCx9rE?=
 =?us-ascii?Q?gMun5sC3b1vil33a2BEEXrzNTCyrCvO78+xU8RyB3AbYSRopfNhmKxEDmbci?=
 =?us-ascii?Q?eqoVLzxU8N6ZABtiZjxfx+J5/lgNQRE3xPegSHce3org+yKrJgsP0EQNF/+D?=
 =?us-ascii?Q?iWGGlEn1wiO+8U9TjCSHm5BCRLx85rabiD5qF2dwai8bbcLcPeGZg8aBpFCk?=
 =?us-ascii?Q?V69Ce3f0mGwIRW+aAXGHxUZee+caOetlTDfZplXFNA1yuDJZwn3va6VjxgGn?=
 =?us-ascii?Q?EnKo2A7Rd4zUBGXZnL5WfCbVl9/iP26pbOXVo9lsulb6MJB7nJjme8v1TL2E?=
 =?us-ascii?Q?p+sP92atTxT6pZxIqR4OTZHFgnL+SRJQIct7TNtE/Z+3+STiAE8lc905rg/y?=
 =?us-ascii?Q?Ez7JRjWg6i+G9ZWLoU8DakuNYWFIULia6VX7hba9D/eTIrspfNLnptVI3Fva?=
 =?us-ascii?Q?XuvoqhIF7Gcs2lq8VZ3BjqHkQ/jrBMBWFbZbyvbJoKtiPLApGxdig9+GdO6X?=
 =?us-ascii?Q?lxwBdKuuG4tvsqRqYfVB+Hhn4BdDsF8YoSkndLGNK7mNrBqMczfha49JhzQY?=
 =?us-ascii?Q?S1bZdOYzSHfJji3mFkZHXtOymB8JuVQDjAreR4d6m2BLtZ53IxNu+T/1HFwk?=
 =?us-ascii?Q?B5q2+upDdCCglAde6DQ2XaDafSXYOc2AsSz+eg7GfOP0ZvFvYKdETdt4jwlB?=
 =?us-ascii?Q?oyscYwe7ZxPdUK3dxV4huAUWcxKiX46corbwXSMCgnGum+hVlynsYylnSqV7?=
 =?us-ascii?Q?WMS6e8kDX3+vKTIJV80DibHfBNwXxQ8KBcLhQpzNPsYlK9aFSVR/HQRSyp8v?=
 =?us-ascii?Q?AvTrPKl9vjmcrFO64KH5HDtfTsTgWjTqeB5732CvgwicTb9aVhp0cDi++6e6?=
 =?us-ascii?Q?VVg37xVWj2ATXxZtcOvcG0yBrztZVxPfNuJm784Mzgsy2+ksSxGNkyw+GSXL?=
 =?us-ascii?Q?rTko4TmeL4ByL/qdsUoJroRRQjGcBJiQ263UgxVbFTI6WCXKty4MCIiD6qt6?=
 =?us-ascii?Q?QVWQKjyj1ojwuJfUbaJQSWkvXIv/AclgyyDUQ/CDV+ZDol62vl3raGKcV3zd?=
 =?us-ascii?Q?IfYAPrsGAP3UjEtUSi0hZNJ6pVbDboIvlgRjdTPQxe/c0rCCe4BulUYU3SXC?=
 =?us-ascii?Q?sXF5lnD/+P/F5/D7dbnDjtIO9bmovcCpg/qpT44OBV5cwSuYuZbz9Zoc6xs+?=
 =?us-ascii?Q?DmUPCXCBCvUqsiEFg2Ouzo2RM7Ge3BOVxvL3XwiReCH16KCwmPrKN/ffeEIL?=
 =?us-ascii?Q?U9UPDV3wMGydM9FXDtAIJCWkYVegHCxGHLNJyUrJ5pMUTqvCqqsL/ImmXtth?=
 =?us-ascii?Q?SVUBmcFtstOViU+L8GyJDxp6XYzJKwR/htgisOX34HumHY4icButoIvk2VBU?=
 =?us-ascii?Q?nMq4ZCNPNP3cN6dxxQNbExY0oa1SCa9B8hZdMmhSi7soUll3soDykhoJnUdF?=
 =?us-ascii?Q?aDpsnfj7pB6bo2IVIbmt+L5/XMRm2VRyj2VpU/+FQZF24jtSJfquCyLWpFlf?=
 =?us-ascii?Q?PAvvhqYlzqO8I1JwB3RRhx7rUg/qzzw=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3518745-29dd-4b3c-19dc-08da5030fb44
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:14:13.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xymG69DaySbuhFDtTrU3o/NdvRaWizLH+H0t5/OyasY1Q2kNjbYk/YSOsZbZfUvTnchnSrqDuOkla/hSIYvYnIHqfeqrUVvOS5lIMoZNi10=
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

Export function that populate thermal trip struct from a of node to be
able to re-use it in thermal drivers different from thermal_of.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: fix build error, use EOPNOTSUPP
---
 drivers/thermal/thermal_core.h | 7 +++++++
 drivers/thermal/thermal_of.c   | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 726e327b4205..7d429d299d82 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -155,6 +155,8 @@ int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 const struct thermal_trip *
 of_thermal_get_trip_points(struct thermal_zone_device *);
+int thermal_of_populate_trip(struct device_node *np,
+			     struct thermal_trip *trip);
 #else
 static inline int of_parse_thermal_zones(void) { return 0; }
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
@@ -171,6 +173,11 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 {
 	return NULL;
 }
+static inline int thermal_of_populate_trip(struct device_node *np,
+					   struct thermal_trip *trip)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b65d435cb92f..dcd6571a3871 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -817,8 +817,8 @@ static int thermal_of_get_trip_type(struct device_node *np,
  *
  * Return: 0 on success, proper error code otherwise
  */
-static int thermal_of_populate_trip(struct device_node *np,
-				    struct thermal_trip *trip)
+int thermal_of_populate_trip(struct device_node *np,
+			     struct thermal_trip *trip)
 {
 	int prop;
 	int ret;
@@ -849,6 +849,7 @@ static int thermal_of_populate_trip(struct device_node *np,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(thermal_of_populate_trip);
 
 /**
  * thermal_of_build_thermal_zone - parse and fill one thermal zone data
-- 
2.25.1


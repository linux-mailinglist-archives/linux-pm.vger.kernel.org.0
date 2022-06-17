Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9266554F181
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380506AbiFQHJW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380490AbiFQHJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:09:07 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C731764D11
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:08:58 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-HiX9Ztl5OHGCcyCCHrYQow-4; Fri, 17 Jun 2022 09:08:55 +0200
X-MC-Unique: HiX9Ztl5OHGCcyCCHrYQow-4
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
Subject: [PATCH v2 2/9] thermal: thermal: Export OF trip helper function
Date:   Fri, 17 Jun 2022 09:08:40 +0200
Message-ID: <20220617070847.186876-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0149.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::15) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f29491f6-84b8-454c-e4c7-08da50303abe
X-MS-TrafficTypeDiagnostic: GVAP278MB0263:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0263919736839A3D5936164CE2AF9@GVAP278MB0263.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 68Ipod9J7oUIltabKYSX6yy0b+/lzGEdyvKSJSDjXMBuW91NKzr6Ey2xSWIVdKlVP8ih3G1cGyhptVmt91ZWFNY8HF2otvYvooEs/pmfF+fnv3iumtunUE86QIJ6p+QWF2+aM/htCPSzqOUOdrJhTvg1E7I6yFalnHwaufd6V4kGNqAJ9GiwXtFW8Cq9Mwd4sk+yvDbmNChc9AllxrtlS/c8JefIjkPrS0zRp3w3h0g9RISIcxACqJ/8bugSYVQWVNDRrbJnw7Eafmp+RUFR9XxgFjXK1NlJsyyAGoTjatOwZAFAmWrtdeY9UDYXpFjmcEo/8ZaTDpRQFfROcgZGMbAY8TvfbxDRihuidoa2tgM6sml2r6Rdo6rS7bIgzW2XMhiRHcUEhWOqJrLKcf4+8liOqIfeM2KHhiCbEU8WrFs4kvoeVkQgm5gfqVsww9zIJPXIFo8mDesWoaD6sRKRzwsWH0NSn5zxK7h1IKUI6Php6+ggYxdm994iaS8KKfKZBrUbYB8TnR46oBJOl/gLV4/kzMHeNqcTwz0SKtXVVWyKs9iXbN1tSB0jAbjiPaFcQ1orNw9LhOipblbSu7iV5U0NnYFVV2F5+/CshpXvf13nxsuHOmAVL//GiiipgC9TEIPB/MNUEQrtWCjr8UCakjbc3V8mqNQqmes3plfRH+lmT6JoYQ1uT/W/bZNJtiGZnyQwbMYX+BIlDw3Ix1E+3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(396003)(366004)(38100700002)(6506007)(52116002)(8936002)(6666004)(6512007)(6486002)(26005)(83380400001)(2906002)(110136005)(5660300002)(54906003)(316002)(36756003)(86362001)(1076003)(2616005)(41300700001)(66556008)(4326008)(44832011)(8676002)(186003)(66476007)(38350700002)(508600001)(66946007)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmg6VvfWvfNHFg8cNppHGZY76ahWeyqIyO1SZCvSewR+myTnpZ5OSkGqeG1h?=
 =?us-ascii?Q?aBULheGnLFXZcqnLIDTvrO+EYR+dzhOPQ4NhOUUT52nal9YMJ2YHonnLzvLL?=
 =?us-ascii?Q?hianh7+1rfueFik4OdDuHZ5TTxReWnQVDbIG5cjDJwYPOY+WUZ99gcBz02N3?=
 =?us-ascii?Q?DfTDKlBVO4I/qVv0gLr9qf3yIDrk2TExjTUZGKNpCxWP9NIGo43mClCJqfVS?=
 =?us-ascii?Q?b25nDHfIjAzqi6sioRirGGjKFleLq4Gq69TDdMaL7w0usgfcm8EIPbc5ls0O?=
 =?us-ascii?Q?sMgTAZOEirzz1UdA/uPkHBM5isPT+ft5j+CxmM9jr8bTRbHBvBzW/BrHAUTd?=
 =?us-ascii?Q?tGrgoRIl3jzuZSV/Ry1dVC3tkrKkslUHvnMjAU9u/UBhadjz6YwnHUbsZczc?=
 =?us-ascii?Q?Hf41EmAjkvl/31C/FW8sOFadz5fPqQlR9aU6a3ODePwad9r7nRfJpJjJzaQA?=
 =?us-ascii?Q?uIjW6KC87XjApPTmZ7VGAFnHkvPD+M54MVhyw/br306CAkDeEjvQvegPkd94?=
 =?us-ascii?Q?Un2OUioD7Xd0nEJ9UEiGL8JvjpPABcmYxLptWNOmt43voZvrEkWqxOQg0Ax9?=
 =?us-ascii?Q?bYCIHdwFdGK8MUTFm2bsgugR9qgOmio/g9uIhPFp/EMJetaBDC4FjfJIATCG?=
 =?us-ascii?Q?QymPhf4fF0XGysvikzQx1F7wVwSqnpTd1bkC5qXpfMvyAIiWEKpZTR2Kq3bp?=
 =?us-ascii?Q?3VPqaUnxGTbWcnKEp3j01GbZS4VvzIiWvUHAbpMtM0TyGCVn58zkbT6UIvvz?=
 =?us-ascii?Q?OGJ01ami1PQcKk1PS35A7dzV4QhTLsydrDkGhRgUjgub/YH9aNOmL08dYUEp?=
 =?us-ascii?Q?69LwFwQD4c56t0ngneQWWbkeIQh9gzbXqJJX3KNx9urbJ5HwUH/6rvM2HvIh?=
 =?us-ascii?Q?Ya9p5D11sqDyMRYUiJnHE4GHE9OxF00u5xVXgz529t4vAxVJXq7gsC6gHon2?=
 =?us-ascii?Q?WXXqDanzYGS16+URgpQpFIWYlP9hTHdRyS062o5B6zinV3nzNdKXi+mv1+Lz?=
 =?us-ascii?Q?tURn9zwwCd5kgysybumJ+azm5+QYzmmzu8kVxPDvry5wg4qV1vCOyhfnD1Yc?=
 =?us-ascii?Q?Fr1hD4hqIzNeP0HSd4lAXD9tC96knTzKIdfYqTSaCrI7Uo1RyuKVceN3eDV2?=
 =?us-ascii?Q?o5LIu5U8o2o93ro5iyVV6JBzGqbzMVJsoNLd0FW0fWHnYquUqbW5gPEHma9l?=
 =?us-ascii?Q?HgVjYSt8RJV3TXXf6qL9u/AJ2DqClQ0lVakhAUP2REFKMNwuiT+jGCo0P6M9?=
 =?us-ascii?Q?X8d25/4bjIiAMRzndVzKkrbagxScja0EDc/SDm7gDRDdBYa5rs1s0YxgLkz7?=
 =?us-ascii?Q?QrnZoO7LApIDWhyimFR3lFEhoXdAUs296qg1FP3UCCnTKUZ8oKXKZkUAiGih?=
 =?us-ascii?Q?qg7JvLWqxshOEkqPB4wyeWephHv+KNf6NZZkeC/7XTMKdcLF2OpyCCauMiBN?=
 =?us-ascii?Q?kFW7x4KpFAGRB4H4kguRNyv7iQtjUsz+Q4kAFS/dIXt99bUc3Ju9jQ9s+RGN?=
 =?us-ascii?Q?IKLr8wEBbE8ya6LeKNgSzN/nkSu5+lEcmV3AdisXTJvpf/g5ijYFs/mSi/4O?=
 =?us-ascii?Q?d8dHK22i5QFw6KLpD2JhjA2vZRYpcnY7oFAlyzlbomKermiw+Y5ESe5DRCjd?=
 =?us-ascii?Q?QPsJCp+SaROdIgEb867h8IFL3ysfIOY8qNkE9RFydWW7Ts8in6BSSMc3IkGp?=
 =?us-ascii?Q?tlU7nVhokRge2H7JxvbuTfkAhWMTopzpo9Xuldh8yMsT2VF6aQMcd7xHw1Qa?=
 =?us-ascii?Q?sSN8NyCw+6PTL9Zlxix1Fc9Lyc4NAEM=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29491f6-84b8-454c-e4c7-08da50303abe
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:08:50.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRUMhGYnWl4xuqfe70O1x7m/JY2x4BCOu3c766dmWom29b5DFF2OYJ3ipc6XG3WBIMGEYnAst+DRK6pNYjVd79DCewcZmvqgTLh2amlKtPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0263
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


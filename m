Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532CC54C501
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347492AbiFOJsk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347586AbiFOJsW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:22 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA23C46C81
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:20 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2042.outbound.protection.outlook.com [104.47.22.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-tXfN3WsIMt61Jg9Phr7tCA-2; Wed, 15 Jun 2022 11:48:15 +0200
X-MC-Unique: tXfN3WsIMt61Jg9Phr7tCA-2
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
Subject: [PATCH v1 2/9] thermal: thermal: Export OF trip helper function
Date:   Wed, 15 Jun 2022 11:47:57 +0200
Message-ID: <20220615094804.388280-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MRXP264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::23) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d191499-b57a-428e-3a8d-08da4eb429c4
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB039265AC07BA8FDED1CCD3A0E2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: Qcj9N6QXesJFNWYCRGYj2wXL+xQkI0YYLHMT/9o7Re2/wwsNx8X+5rlCy1401XZfxbaUfGj/x1ppnPNvxeRs/to9PRURNh3pErRqCRL1datTZUvB/mTmDiqAKqW+gmSEyYomfYmmmDrT12XtGC0vagaedaIJWgHED6bDZgw3VhpxAvJUBpKA2EDryKhn87duKRoEBG3sDa6LKUoRMpIQBhbQ4I6nQW2FFQi8HVS+039ocSET7s6PCf37BeRgHbElAIO7p1umkMfZYA8YnIgYRG+AdylCiFzOgQIQUswmuLOrY2jCmy354vgkDR1Ef2vdF9mAJ/XLByiaAB0mOKQDA9x8ImNf9JNHNYvxt2DO3ibMoTpqf7SVT/QBSpa3LyXdJVHP4AVBcZH1FMTMQjzJ94kqDwUMPFTPCV51Gv94f5qpids7TAJtmTyBmNSLl3M5gIQDan3kiXjktrzEy1FaINyOgukXOLNV3shK7hs/sWxJgIgeaWsV/deVps/KagN/aJWrsHRQSGdnnzN4OlzABW1ARjAfujVoeaiMk0mwlyeeHaJh/1tieE5upwgVzm5kj3cVE+bLd3LL3txqUJqswc80j/4l0J6pH245mR26m0mHbdfsDURMMRy6WuweDDk2ItTgQPfzgcVv7FXXZ9oO5MLoistmN/pc+725X84dM5x0LFtqki5Hs0k+vBjMKrabWZbGVWN3cmO1OLAztMSMaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(83380400001)(38100700002)(44832011)(5660300002)(6486002)(186003)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45S4v0CRn4w/pjepl9hXi9TZgWyOZnDIFd5TtSf5lv4E85Uqo9nLMygMcbiz?=
 =?us-ascii?Q?uOtg69ORyef/gGOraDpyvM2kdW/f+uSddErPFoMwVn4WfGjoICCnUpe5OoDD?=
 =?us-ascii?Q?Pvpo/eDXew3tE2FOv8CH89Ehc1piE24DTB5C96GJlUN532LDJP88GSfW+T3U?=
 =?us-ascii?Q?9Mu8rukcC7aUb6VR0K+fFRaPh0fIGNKWNI9x6LIeit5UiFfNvvjprpCi6lgu?=
 =?us-ascii?Q?tUFLdTC8XDJnp8/kpiYqSkn5eZaVaOHKeE/VzgBagohOftQfFOHkNbvqYPWf?=
 =?us-ascii?Q?THxU7HgIbm6GNQJEp5qYftbOck9nDvR0syhT/pYATB3ytJF+0ky12LSr/6ha?=
 =?us-ascii?Q?oLNwnrdAGQS5m6Z3q/fScsEvFSoou/oE8xl8Az8FiujYVcISbJxLi9BPlcgE?=
 =?us-ascii?Q?sIYFS7xbEWqKRuP+vzPXxXlVD3Mj+vyq60nH72uavLkYe+rCesgkkC3+ofqu?=
 =?us-ascii?Q?uVbuZdHLAiCgQ+CkQa2P8fwAx3X4XZ1jiGsBJ49sDtotZjOprC2oZmNJZcYM?=
 =?us-ascii?Q?Z95n0SrTgGZ9mwR3L5gOFDcmbXLHLXFkbeXuf2AcjPNCym/G/ys7jtYUABcZ?=
 =?us-ascii?Q?M4A6zQT/5rcLsvaWlZrVP9MS5oxhEj5yqELZUYCrFAQBdS48deCiPqDUKa2s?=
 =?us-ascii?Q?DetEDIEqBDDONYo4ENFKuYJ+mvgojHqU5z6zRyKk+0qBu833WRMjtvPHGG6y?=
 =?us-ascii?Q?CxOS4gIAkf+ya5gsXnZtM2g7iDDACkvd+K81eUS6U+oEOsT+97gQQZJKrROx?=
 =?us-ascii?Q?zWA6YviUso0VgorZ2wsi/qnpRsV+1UXfq62OUoR8YX2uXXq9qLrKEw8ZHfoJ?=
 =?us-ascii?Q?SsTogDj9ncPmyduFwnQA7UOmsrBdE2MMzlX4H2s9Nd4s/URtenRkKICvQ/Cz?=
 =?us-ascii?Q?+ZqKid+1jFPxUAIPwkEmZW/G9iV9NxfORJHISfUSLgKRcgF6sQW6MvenBlG0?=
 =?us-ascii?Q?QDh9pWEjJni+88I+REvVC/7qIym5Q/zqwFlv5Y2VGqSYHsTZeRsLBKXDN6of?=
 =?us-ascii?Q?PKVs332D1k3q5xiJHVlmuQnN5C1d2rh+QlP4F1/xjc7eZsgkbx+Qwbzp+2yr?=
 =?us-ascii?Q?KLuA9YvtlWX/dbYAuNXHp0jD4Rvk3YyjAUHrsawsD5bTAmpI1NIQZ41FvnTc?=
 =?us-ascii?Q?OF2I9biGJOt8/+DOCIOfAgt3BchjS3XKDvS6xxMalU/k7CsNcgPVngfkRmbr?=
 =?us-ascii?Q?Phn0RiE+7e8U3v86L50jBtUc4+eDL5DJZBA0MPO1QzU8XIIWtgkLYsNoTomY?=
 =?us-ascii?Q?x5lRpzZPsyXtIqj0Nj+pr8zZOagvLjoncqqDPombsWM9d+KoVBNrHaGrAuDq?=
 =?us-ascii?Q?qGdrUXUfpeMNegE9DukIZGqdLM3pVz3Nk7hg5tNNQBgMm3gZq8q5RgCO1I1l?=
 =?us-ascii?Q?IsbW8mgUzHOTaRm7b8Vk1PslEQFTNTZKBf/ZwSBERQbyJFAOGj9AN82XhqLA?=
 =?us-ascii?Q?5H7AfF5Ydq2Kw71IzvVuKsxsTWHbL/qPO7OmIN6/l7L39WQIPraLCtOj3TyJ?=
 =?us-ascii?Q?Lv0SABhaoTa7X1oQxFqx6GGY0VdgX4SWiLIWxG2Vz1q0bpM8VBAiJPpfi5jB?=
 =?us-ascii?Q?eeNw6rvPoOpF8uWMDn/5YmCZh8HshBh5f/GCqSvrqNyo7sh7sXfxUr6Jnld5?=
 =?us-ascii?Q?uNucn3Ze7ly3N8vjcIYyKpVmAHVXSGlQw+I7siWy8A4pljgE7oFi3mqwlRVK?=
 =?us-ascii?Q?yHAV/calrJwjqZw511Z1XSbG6G3Ghk2klt6Yn4VCH6/YimDsRHsDFjZfjN2c?=
 =?us-ascii?Q?X0wVGDgceeX1VTEgB3gY7qM78XA8vAY=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d191499-b57a-428e-3a8d-08da4eb429c4
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:12.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kMcFiNeDq9jYasKGtbBSfEeykjihYU95i34+4UwECQk4rZNlQVbnzhXjXrpIPLpH/fayu553PeFeUB5ca4SXaOAUNGvZEqq6wHbZUg2UEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0392
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

Export function that populate thermal trip struct from a of node to be
able to re-use it in thermal drivers different from thermal_of.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/thermal/thermal_core.h | 7 +++++++
 drivers/thermal/thermal_of.c   | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 726e327b4205..81e6d041e79c 100644
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
+	return -ENOTSUP;
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



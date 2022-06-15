Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3A54C50A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347831AbiFOJso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347652AbiFOJs2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:28 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C911347540
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:25 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2042.outbound.protection.outlook.com [104.47.22.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-HanQz1KWN8i4r9CjeJF_vQ-4; Wed, 15 Jun 2022 11:48:18 +0200
X-MC-Unique: HanQz1KWN8i4r9CjeJF_vQ-4
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 09:48:14 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 09:48:14 +0000
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
Subject: [PATCH v1 6/9] ARM: dts: imx6qdl-apalis: Set CPU critical trip point
Date:   Wed, 15 Jun 2022 11:48:01 +0200
Message-ID: <20220615094804.388280-7-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MRXP264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::31) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb4d5fd8-e162-4674-31bd-08da4eb42a21
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0392F5F32AE15F573819FBBDE2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: YdKTILDYRanf+td/98pzO+shMI0G5t5QFGBeHm6q+lkR90dxAT7ZEGb3wpGuQLBwnK1nfton+YjdwVI0RthZOU34Bj4t/C/k1n/0dVP/z8V3yVm3DG95ES0f5mi6EYCl57gNcHd7IfpKUbmLfloXcl/XxkQvJSucQ7HCHYH2sEgSAlaEI+tpfBkUxu/ULEb9/x7yUgNY9NqouJQk4PqM7bfnJu+GxR51GPs6h0ogGVVrk+rCmCFXmt0i5gRG6A+TOSGeCPM0UrxE2sVKy7IAMc9LMkDaWadNZ5VWxrz2jauimKpctdFI+DDo55uQLJkhiCGXXfdSsWgrF+G5rvorfAZgEln7LX/HHW8o0DzaVKngWogxEmRRPSVkx1PLRSbR40YG2Bfa0MIW2jwRZDGqo/9lL95vJyRp+CnN3w9Lyt1QXgldCOSPczWogomoeiRGtUAj48TK3hflulCgZXocjht6augufZdDJHwsWk4mTddF6KCTkzuXXa4KV0g1cl03FKNX8qDz+JUlkGUEmWZrunDfExVCkbsPz06ABB7RLlUKuzTo5Feo/Np1lhhWRsdcle43nvCEQbhxx8bs6rVkV4Pbre4PpgRhLv3AW1W5rL8T9lzJe+beEO/3emfR9MKi9jgpVWqMibBP2MHbyyXq64YjuNX9gM1AvC2zP8pkMXvCs8K5+M6Hmwbc7E8oyzNPSkZmVlo7mKBzP0dv4XYVGGkJ0NdZ8k2UmULqonFz4QQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(38100700002)(4744005)(44832011)(5660300002)(6486002)(186003)(7416002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OMEqgfXRk2jh+s1zezXs6oKpy3/1GI2Kvjlo9NxzdkA1SlzQ9Zlo4Q6VGrXz?=
 =?us-ascii?Q?9QWozoPZuK/0j1g7YX9rb7iSpNdkanrcpkf5CX6+3p6Eh+PiWo6ueQIbxhz9?=
 =?us-ascii?Q?k4kEfZrWONSSEP9zv4eeUhT8NxRuCK9+BZD9jkQIWTGWhj0e2DZt5lnGGzcu?=
 =?us-ascii?Q?9yi2TDzpT7NepWxr3JMWr/B9o0WinI6ROSNcowlAgSdHVxm+wQL8AfzRW9hr?=
 =?us-ascii?Q?autw4VDGVUHfgbBTbX7WpYGp9toYgv9Vi11vjIpPcHzzZRnmk4y2W7/AGg+v?=
 =?us-ascii?Q?QyNyifE8mug8x+cXue7vyYAPSfdR6pI2gyat4N/sstQ9o7ul186sj2R2wNkT?=
 =?us-ascii?Q?gLrkybVibHJv0u67kZXr5+j32DWFNMcnM20XkX+cG4SYhBhALOEPGKLOmWLj?=
 =?us-ascii?Q?9Wz1krgLgHvad6ZokJ8anZFdKLf/sj9VSYjKlN1Cg9uhbNhDKGD5oOcuE+qF?=
 =?us-ascii?Q?Fai53IN3cEaAoA/5E4UrWB8NOpYNcYG8u6OFFH7Zr2o0H9uucHfrJLTKIfmD?=
 =?us-ascii?Q?vjdr/0JK8xtmsD4U81y7th3xIqnVjk55HcW/cdcxxuecVI8JOeoS5MOFGPAW?=
 =?us-ascii?Q?aAk4VtgIIIcZo0a0LrfanO89vq7bkzIb6RQcgEiIibORJvJ8ZAUX9GwD4iRC?=
 =?us-ascii?Q?cpXbhep2ibQufWB9SXCHM2RTLMEWA+LjPQd1yUxDIXmZQoojUhgUl1Iwv4sE?=
 =?us-ascii?Q?AVe2A1PsYS//3ajMdNJYnJo7VitAg8PpvsAYLDGu9OQs/YLx5D7S34n+7Cg6?=
 =?us-ascii?Q?t+/yxoniPSPKj4+XSjmV6TSWcg/wi93IBdwQiY9/OvoVCdqE/IjdZ9h8x1K0?=
 =?us-ascii?Q?Y7ze5zEb8BJeV1+kzwPNnGi81HUSi5+GjCHODVcfeQQubTjLjNawYNJSHv28?=
 =?us-ascii?Q?zfO88EUOWsUHCFyBJNvykjX9UAUKZocy+fakgb09yhbjJbDPq85b2MXxptDS?=
 =?us-ascii?Q?+QvxqKAyJtIDCaHLn+pjWflyCQs4dVjwfi9FDEsFEiUBBhFCbgnB68YPYC4Q?=
 =?us-ascii?Q?ZlxDLZgYhGmyzZjRWqqOQxVRyOa77aEvx+oUyIdXuQjYehhS4brGaLYN9fRL?=
 =?us-ascii?Q?LmQq81smgRnhAUbfj1/22Gndzlk3hrZE8p9KnI3nBz7rj+0QekkEjjLIaCho?=
 =?us-ascii?Q?8mlDZ1fp0juMOdkCqdE1k/KRmx4JfANtATJJZ8ZYUuYeWkiuRSMuLmb79L/D?=
 =?us-ascii?Q?u48cgJh4xakwcxx2cw7VORxbf3jorxGkb+VWi1Y3w2R3sTn6wW4PDu9CvmEm?=
 =?us-ascii?Q?hjnvvHZm45+HlmWSywBCfRbcVjDHq0Eg3ryWKxuO3Q5HlalRHo7wUrsidJVD?=
 =?us-ascii?Q?CAyoWDCZpEWq9yfEJSXiWJQUIL0177eBhoGAUmBRXRPMu9KI14z9GO6nAbf3?=
 =?us-ascii?Q?QQvyz7tWC6ghbshfsG5zcQx6+4OWf0gmc8Dvwr/IuNbIZpWcbjINk/VIX7TF?=
 =?us-ascii?Q?VuoPE80+oXFyqv/lNrr03IbIUUPuPWuSemi9avHFxTM1pnzcMy3Jj2t+8y2k?=
 =?us-ascii?Q?2bZRJm7ivroiiXEI15zhxMWSOi8f4JH4+AtJ9KS4eCQe/uhap52JLXak0ecx?=
 =?us-ascii?Q?hC9O+dpH3Nja0Gjn7gCJ198JwH4ItFT/bk3a1Y9Ut6sk0vRzVp/moD0uodKA?=
 =?us-ascii?Q?mgSys7ETxpkfCy8nDeNjX8hlA6r1cH723ISlJgx6UNmqCm8kh1Q1dFftMNNL?=
 =?us-ascii?Q?ofwyWQ1sKjAFonBNGS0Bl5T5aJqonqchQW22gtufBNNY9RcqnbnaxPaQ/Lfj?=
 =?us-ascii?Q?sh5hFWBsU3bAebFjk984XBJ9ksE93AU=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4d5fd8-e162-4674-31bd-08da4eb42a21
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:13.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj/2vfh2NQjtB+CKS4mIL2uRFnwcfs90aUjhuUtbZC13anO1vkzwqV/L7G+XuLVElPLEH5fdQx4ppD43XEG7g2FHVX3auUzx3kyJuLJ9lyk=
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

Set CPU thermal critical trip point to the system designed value,
95 degrees for commercial grade modules, 105 for industrial and extended
commercial grade.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index bd763bae596b..21ee16f3926f 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -390,6 +390,18 @@ &ssi1 {
 	status = "okay";
 };
 
+&temp_trip_crit_commercial {
+	temperature = <95000>;
+};
+
+&temp_trip_crit_ecommercial {
+	temperature = <105000>;
+};
+
+&temp_trip_crit_industrial {
+	temperature = <105000>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_dte &pinctrl_uart1_ctrl>;
-- 
2.25.1



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF99554C50E
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347636AbiFOJsq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jun 2022 05:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347673AbiFOJsa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:48:30 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6980E46C89
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:48:29 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2113.outbound.protection.outlook.com [104.47.22.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-ESRzgEV_OYGUbqc5zL6KJA-8; Wed, 15 Jun 2022 11:48:25 +0200
X-MC-Unique: ESRzgEV_OYGUbqc5zL6KJA-8
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 09:48:16 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 09:48:16 +0000
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
Subject: [PATCH v1 8/9] ARM: dts: imx6ull-colibri: Set CPU critical trip point
Date:   Wed, 15 Jun 2022 11:48:03 +0200
Message-ID: <20220615094804.388280-9-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0077.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::17) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a85ebaaa-e05b-445b-332d-08da4eb42a58
X-MS-TrafficTypeDiagnostic: GVAP278MB0392:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0392CF170B321D0237713558E2AD9@GVAP278MB0392.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: pzxGptJCAZiJ6wtIrtIrgNvAigow/smLqsHzoScs0moSPp78aVNovfH75dvdF/TO0KMxIi1bSzj0dn/c9Jusvh8vZvf2BbzncAp/P3M8FaOZockA9eJisMdZFqAb+MRl6sWwCedt2YJlturGTdfwTIDf9sjhgJRcTa72Lc5VNCY0NcVY6A75VWHoPw0QOiiMzqM+Gv1N6L8bZymuL1RmwzufNSWol5iKKBkhWG8e93OOq80EOKJiX8v8syI5CY+0reuK1hFUFbCLI/8gu1XQIxZgYNdDjDHspCFQOryAzzXS9v63QiPD1tFFRSlO9hXFZXicdYqGRGdpUbamL2yiKHRPuZcgGN4wEK2CPS08lCxVgzjMdeSSsoG+kPQa6MUVykDR8YNANHXxnX7xijkeErTaV06GFUX4EDpyVx+4OTXHA5qltHvSULJpVpfrmIF4rJnv5yNqO5jxlpHY51MDLjSuQ2b5f/RDPdrMReV6W2zBvg15nciiMg6Ox3s3ipVbjL9LT6iGWzwE6IGQ4K+6S9W4CbBlKc9IekFwMuk8eLMkzyn6fL9b20m5yUfLRF2BYmZFKmFEpX0cbH+LZEqhgqCuGxleoufqfwAqz0bSTjFwOVTEALwnqOWRGrZu4PYNfLHzjTCV332PGl56tnRjcTI90lbudRQ5KWND0ITA18w8YJKxcrseuZ1ND8ka+2mGsYTUEXBbcIN0q7u7tFVDrsYuDnzHu42XGmz5UhLLPFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(346002)(366004)(1076003)(41300700001)(2616005)(8676002)(110136005)(8936002)(6666004)(316002)(66946007)(508600001)(4326008)(86362001)(66556008)(54906003)(66476007)(26005)(52116002)(6512007)(6506007)(36756003)(2906002)(38350700002)(83380400001)(38100700002)(4744005)(44832011)(5660300002)(6486002)(186003)(7416002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1BHIHuUGqekcwciBCABUPiF6MnA75dnslaczqPgyyr9mN8vkoZkqrbjowEcJ?=
 =?us-ascii?Q?+BK1MI/ikrAoctOrrmw8Z8ATE/6BAdRZzFmZ5tjuu5+ktGeeTgHnYR22+1lP?=
 =?us-ascii?Q?/w5eB4J9Ryu7+rh6p0fk9YrGy1tyfkOBuyJ5QsEejYAVgSijQNi0iaBx5Wsl?=
 =?us-ascii?Q?oVyuehg5b8KyV/DhSAbx8zfOwfrMd/mBJUVVk+qrbXrJPrJBXI9EKKVGc08E?=
 =?us-ascii?Q?74S8L1sPJXhhfEXwtZ6YR9eOvgTTkNH1NiCU0jUDR/l6iR2GCB+ezzd/XfwE?=
 =?us-ascii?Q?TpiIFLjDovAfxWaV4q0mfZJcqLQS1tmZcovfGUcRZeD7Mls9cflUgpuU1dHS?=
 =?us-ascii?Q?dji/1HOYBDSI1wt+2vohYW3dNIgw6/3Yb7UA9xhx64vRKVbdgKLwG+rQysi6?=
 =?us-ascii?Q?TSttvpYiD5j1kKTRufT/KbfKkGkz8DTAbVp564grZU9I0kzIDO13LGkNB6He?=
 =?us-ascii?Q?qNQqCWbbx3BGkZh9DIo4fSvIG3h+DsxcDyvF0vbTKgufTP1dI/KHriSGlWkG?=
 =?us-ascii?Q?Ba/QMYDqqa5uXSzDAaHpU1wX2lVNXc/mrfUiG2eYdmo2MbbH17aX/f6WseZm?=
 =?us-ascii?Q?EhjVE1A4TTDQ3pkPkCmW9iAzPBfXe5GM7MO6obvz43WajFpjO+jo2pFp/lZz?=
 =?us-ascii?Q?wB5AgzEY1cMHu0RoBXj6BXrtGK9pr4BjPnBRRqzyugCfY8Imu/Hly0CnHURT?=
 =?us-ascii?Q?J58rc6nU8c6vTaoGAkEM2DcbIik+VIyCeYSnO1CKk0sBZXGEPG7vGmU0ioeo?=
 =?us-ascii?Q?2Ya4dx6GMf4sE0S0sMUbMpTjut0dysepeXT1QK6isUrKKJ+I1LcuLZJ5yrPl?=
 =?us-ascii?Q?bl+A4PBObaWfBp7wSsM8CP15JO+58PyK7/Xtw/06fePF1djoAmW6GJyaXI3f?=
 =?us-ascii?Q?HLMKBUnAini70SVvKVwpSm1r9HXHEgFArFGqA6tztc5Z0ljvH7FTsPoZzYb+?=
 =?us-ascii?Q?n7r9CRA588H7o6+au1oWtFnMP8NzNBU4e/gibVq7aIfoNwnSXoQBHgNaomx0?=
 =?us-ascii?Q?P8+zr0kcQRtKaJ2ZcuoW7Gq+CdbkQrsRkqZ1cQiO2/o8hR86wYJ/C3i6rpJZ?=
 =?us-ascii?Q?Mb4bZOrhbM6Ul9VZFCM1ple6VrKWE981+78wF59hpT+0TGQ3KKZuPZWiGR7B?=
 =?us-ascii?Q?hWrBllzkORwIWIHErLv/c4PO1oBHxcL1OU68LX9saHFELUJwmQzk1hR0mRVA?=
 =?us-ascii?Q?uPoFFE+CJxy/OqwdD468KzxSa7KNmT/kL0EeiVwWP89fv1BdO8owWaBQCiX7?=
 =?us-ascii?Q?PAwRknh4fBF+V4nYCIp02u4Lw9iE8zi7e0c0WJ6OV2soaHgXwjHq5dzKc58+?=
 =?us-ascii?Q?QB8nhzgcNvMwcj7K0xUgnFUfx2pp1R9XsRoabtfWGvXvqcOk+TwWnptQcG4N?=
 =?us-ascii?Q?VMMsc2FtMZZJ3dO1La9yaLJbw+ZOWVXZP45xDR9/ayU/l7+QR48Ca2lljPf6?=
 =?us-ascii?Q?9YJJRxCBz+28MM2g/l+rgvh5Z9MI3hjKIrBT4LrKa98dOgoAnKdJRMIl/vTS?=
 =?us-ascii?Q?KOZgRjEuQQ/Lq1ukeqr9bCs++CInSyZ/Q+Z+zj+boBUvibqVFM8UK9jF2/7p?=
 =?us-ascii?Q?WGzxI7PQ9+PBYt8Z+WdEyv3Pz1oXIwbWm848G25BXK6L5ZzbRwLtcU/AyPBF?=
 =?us-ascii?Q?g8EBzQWfLYfDnTUIuQfpTuDFtRb2gxs9L/bYPq51P944/0nbNQK357FbfLJ5?=
 =?us-ascii?Q?bxBSPg55kGD/JQ6rfS/2fU6rW624i80ColKTVGY2UVjU804uWgL1UjTWzmAM?=
 =?us-ascii?Q?YUAE+DmP7fgxhMyHUA7NZA+ow9AhhlQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85ebaaa-e05b-445b-332d-08da4eb42a58
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:48:13.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t78K/eAHZxWwLnEN5jE/VxNYYRsl5rDpjdkoLbEIr879EGFyY/uD2IaRSvPPcnhU8ZyrAEt7VEJD5sy6HRmJMSAe1apOqmSB8bw/G6aCFRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0392
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

Set CPU thermal critical trip point to the system designed value,
95 degrees for commercial grade modules, 105 for industrial and extended
commercial grade.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 15621e03fa4d..6d8e1ef0315b 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -250,6 +250,18 @@ &snvs_pwrkey {
 	status = "disabled";
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
 /* Colibri UART_A */
 &uart1 {
 	pinctrl-names = "default";
-- 
2.25.1



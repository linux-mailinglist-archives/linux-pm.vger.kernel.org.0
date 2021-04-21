Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4483668FD
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 12:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhDUKQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 06:16:29 -0400
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:12162
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238664AbhDUKQ2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE3vs4G/XXLSSJOkxIQ+NT1VwMHWapZwl7kGg0MQwQuIE+IAxkK5N4+gVSeu6vYDnEJ0BoDEsMC/JafGhv7SZsjeE9LxCBNG1tkO4Mc/M9AP1uCCHc4CubRX0MEcLvOqgV0TfkTkUo4ez/f/ZaxZUifWJQb/oi0SCMMbxvDDR9AFa2zub4HN1ee9AfXkQydrS5++HLbkJaqj7pldye9l8G0Iwo+8o9+X3eFkBW9fHYBMhiQoKuXqKhiI2lhLJbqYCyii4DN8BV5F+yUt4cKaOnMD9VmvRAPOLrbnMnnGNSnjcvXs0GJha6L7W58k1KP+JE9rELXj/teNSkyANKaExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG2abqWgECduXQzuCz99Jq7p6AgL9jL4EUJcuD5FOuQ=;
 b=NRnf02Ou+yCX3ZWhZTLo6yNbiwqXqRKKzu6n3tX1E1UG8s/t44CifVn43/lwJYidtJ61dQzZGx3WhpijqMD5ywmetpidrpQfzPiuGcmeNcJH0pGRoCAPMCTowa8Ad3onO7SRrXRC/O/VeylssaGMsZJBFh+IkPS5uZQTdC2HFX+s5FcCfLu01NtkoT+HoatV/3zyWqi9FwdPHIyTgVkqxcpThO+7yhX25ygP/Sqm/4ohDTeP5SXV8TqBo0K/iFSfcYgKa2VZlYZk2JVocaDsbzVKIq/3pCD7bClGrE7tXMqKENog2S709KwWfovmkXnEmImFa7RBaXz0BJG+LcK4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG2abqWgECduXQzuCz99Jq7p6AgL9jL4EUJcuD5FOuQ=;
 b=Sw+uG8Yl03Y8ZGhU0cXdRsYCyfiH6yDSyGQs3yZQCIFk/5MyYVOU118QAhYhpglXfQR5N/y7bRg+PzqGDYk7dfAo6S9S5YZzyoTFWlnIvfVzWGKCMav0+KgGUb8k/JgdBKqndime05fStT7WmA0gR2FMQlSDAc6d5ueFgy9yKZ4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Wed, 21 Apr
 2021 10:15:46 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 10:15:46 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, ulf.hansson@linaro.org, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 3/3] firmware: imx: pd: make driver look more generic
Date:   Wed, 21 Apr 2021 18:14:32 +0800
Message-Id: <20210421101432.2043310-3-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421101432.2043310-1-aisheng.dong@nxp.com>
References: <20210421101432.2043310-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0213.apcprd02.prod.outlook.com (2603:1096:201:20::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 10:15:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79ed7e47-5c8b-4efd-f649-08d904ae6dbc
X-MS-TrafficTypeDiagnostic: AS8PR04MB7687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB76876C1F0EBC47B7C4FE697680479@AS8PR04MB7687.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqlMFJEy0Ox18/OKHnl+0byZocIY/3pie1bAZuTWgkCGtfQfdssu3/fFzieRugV5CmKu5KEGcJJvR5or1LyykRdXUV3zLLZ2CV1Py2BFku7pb7lU+Rndf0rQn9dK17mO5LdFg9x44kAeK/snAgpli9UVPq7mWVhK+7OS3Zi0VcY4k5y6iP7h8f6pQ2/LGq7UmeFQmet/VbylMY0rOQ7heZa23zDRDP2EVgcT7zp9VasUTX/Jsse9MO/Y8aezCqsDx2cG0C48nnvi9eGAQjcPORg/esYAE4rtqD/iIfzJAjQhsLmVYVZ2ILjx/9NaU6qCc5ljur+PMuEisgD/RQeJh1k9M7BThXsxTjNpgC2qRJeinrfPJ7S9mUoe8XssAuPNbZsDmO6djAcXvcXN10nywB9yBT8jX9zFdcidQED1KSrBC+WLw1RRj9TgvatXUwfn+a1SH0LUfap4PIs/0XvLuVAHlQ0Df2YcUOUBwRxhAM+BNuC9ubEL/oVlx9ZEKgJ7wGowu8cOE7DtLb4jyO5LAskT8ugg95loAVPrQCCYW5ZYW8mwoqvi/ex6MyozoW9kujXmd14btfV81TAZ1bWVsq3JsnGJoBvKca4HPI/7QQFuOpEoXi+RdXVMVEpkvJ5eETslG9W+hkaGQUgDCJYF79+7HrCz6QjMaFddmn7SKO7JVd7q1hQSNG0dQCBuWbXxucwf58Nf14OCEpSIukdlaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(86362001)(2616005)(6506007)(26005)(66476007)(36756003)(66556008)(6666004)(478600001)(5660300002)(8936002)(66946007)(316002)(186003)(16526019)(6486002)(8676002)(4326008)(83380400001)(38350700002)(52116002)(38100700002)(1076003)(956004)(2906002)(6512007)(69590400013)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2Wpgtnl+BEQVyG0jEE5Xaq+VaB9nBFWDzNn1dbKQowCbzd5ZRfFH6lphDJ4/?=
 =?us-ascii?Q?vDuThGtM9bd0ZJBYsNkqv8GrFmW36UbCZ+CA/J2STaoTCmGzxXLzptKOKFqd?=
 =?us-ascii?Q?WhA6ZZurfQjMoLXlBwj58tvuN1l7hvEOkJ2+VCbbyY7XUabQJrhMY0avsR45?=
 =?us-ascii?Q?C/rlQ51N9Qttzj1KvvogUsUdm7Kvpm2uqMoppmeX53wrzoR+I4Isb9knbNsf?=
 =?us-ascii?Q?hHdXfSMFyJgk1B/n/YL+25UO7NzrDWHOlrsN9bUih5vlPh8UxUJ9qRPAg2HL?=
 =?us-ascii?Q?qf3W+Is1vTiC8UZ2gcOIFa4d/Vb1h1T7iJFQUzbLLpZIRMK+gH0Jj/ys0uMw?=
 =?us-ascii?Q?Q3/wly8Gm83boo/SL2UtFvOw5NwTCug0r7hji4PhZ4G9T6iBpDfgvBqH8jm/?=
 =?us-ascii?Q?O+xdlOqLXUmmYTnJk4VItuFJxyKc3pt8NnMsKKg8/VOASiRqC62kW584j4Ku?=
 =?us-ascii?Q?gXFBBkmAiW1XkNbMBNsmKLcRwgKOQOa1I2oTpIXTjjFjRfO06QDGSqDU8FlC?=
 =?us-ascii?Q?1FuDClRTVbdD+58tDOVMnBptJHK+kkKrK5OSsMczYSeKye5NZ5rsQlPTkP7b?=
 =?us-ascii?Q?qg9lFR0QFBCXdnJAwoOXxf+cfATGnjXO5h1Tj0joPEpqrgps8eQENGlPDJlg?=
 =?us-ascii?Q?HitCVuFX8y4ueq9AoynTWUeNM1fdOttYn5uivN6Z9TjdBnbEgVQOInrvox7a?=
 =?us-ascii?Q?Iz8qgsvX2CpS/llRq0W5/rdE/vykc7vOnpOWCUBaiSIuXR4xcQgBzQIyE9+E?=
 =?us-ascii?Q?qv7vLcz8bZae5kj0UwTWfEGljPJ1NaB2BozdL/qs1cxt4ajlCSWEBwiDDhyw?=
 =?us-ascii?Q?ozpNxBdCYzwTi0dr6DYrrjXxVclMfUZRc+80sm+2Zm9QbxgfQ8xqz5tL0Y6D?=
 =?us-ascii?Q?MyxfX9zktx+MFP3s6IyoxNhAaWiOomYn8oKXaDOH3LSv3FaOxx/iqGgqakhM?=
 =?us-ascii?Q?Ux2W88hbdaAlnsGvqb0D2SvrkjzNAKzsIVGwo6eM2Y89u9vuZfsofz7tdg0k?=
 =?us-ascii?Q?SI7CFdscYjB+5NxrUxODDoFlgWPQJIaMe64s8+84QBOAa1qhMJnsN73+OSi+?=
 =?us-ascii?Q?cAUCIdsmQNb94kTMItsevLlUFCOY7Kyyg7r0mWi0wUXP53ULv+vaAMm7/Q7N?=
 =?us-ascii?Q?7nskJqAYuaknVYBYg3sh5shrSGNytvIh0wEwVkrPiGU1BPL0ZziQFF3SDfyR?=
 =?us-ascii?Q?DcuahfWI2RS5sEQQPGQ2qIKkDJtbQl1/MOxMMdH6IZst6//MWyn5GkYk/QUT?=
 =?us-ascii?Q?aHWFxpj0U3g2zjoh5o03g0B7QWaimqWZdmvQ4lWyxdcn9Ze+xneKyP0F5K+5?=
 =?us-ascii?Q?92tvTmq9SFMKUPkLTT3MBfFa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ed7e47-5c8b-4efd-f649-08d904ae6dbc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 10:15:46.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Rontj6Tz9TtWsmQkruckLnJAD+M1x/GuFeEy5p3lV1Nh3G64dDKsOl8++pcdkUWOLhO/PTUqUUbLfrdCYM30Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SCU protocal is platform independent, so make the driver
code as it is by dropping the soc prefix for structures.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 446a4f9f0ec9..bdf88aed6dca 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -95,7 +95,7 @@ struct imx_sc_pd_soc {
 
 static int imx_con_rsrc;
 
-static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
+static const struct imx_sc_pd_range scu_pd_ranges[] = {
 	/* LSIO SS */
 	{ "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
 	{ "gpio", IMX_SC_R_GPIO_0, 8, true, 0 },
@@ -266,9 +266,9 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "board", IMX_SC_R_BOARD_R0, 8, true, 0},
 };
 
-static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-	.pd_ranges = imx8qxp_scu_pd_ranges,
-	.num_ranges = ARRAY_SIZE(imx8qxp_scu_pd_ranges),
+static const struct imx_sc_pd_soc scu_pd = {
+	.pd_ranges = scu_pd_ranges,
+	.num_ranges = ARRAY_SIZE(scu_pd_ranges),
 };
 
 static struct imx_sc_ipc *pm_ipc_handle;
@@ -463,8 +463,7 @@ static int imx_sc_pd_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_sc_pd_match[] = {
-	{ .compatible = "fsl,imx8qxp-scu-pd", &imx8qxp_scu_pd},
-	{ .compatible = "fsl,scu-pd", &imx8qxp_scu_pd},
+	{ .compatible = "fsl,scu-pd", &scu_pd},
 	{ /* sentinel */ }
 };
 
-- 
2.25.1


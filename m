Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F423668FB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhDUKQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 06:16:24 -0400
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:12162
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239172AbhDUKQP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcAtX8Gc7zvzP9JdzoXr47vnVA8QajuRTlTFYc5tNa6JnbHhCc8RH/IEqPvtwPyrnMiJiPR9hw4UBTsj43RnKBjze8yCUuCuz6cGP/JQRY7JdY5CaKyRuye/OhyUklE8K1ZLedaHjqCxp3z/XXQDu5172Vr7Q8giMb/f5205OMCs8H4xE2LUeMnEowGR/+hiVwY3MF8eK1sHHiuX52xiHgRzJLLc7wr1368MOzncyvII6GQcvwb7qLLq/j84IbBs0p8chLF8Mctzb1Qm15Yk2NVcONCJN7uwDqWensZPP4Im6ExOY28lenNnC3ly2nqfFfMfKsJFhTxq4nFtWSQq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQGrPr42DgKzvHRGhCEwcNIzY2a0dTfqwSBO8fIfglE=;
 b=m8rPiR4kbUG8QIRPixL6smTzD48W3qgL7ZUBL/Xk/LiEq8M4/Kis9p98I1y6TessRdMh2HhuQqFMhAgGZ0yw9PmYHIvbczKDdi8uY1fffTTYd6ijnYEtpD6S0DMTk1RoUVQiZJlLzbCaESUWwywVyvPt3B670EkreGpb4Rj4JWszJoTle9MHYq3sPECb6FPWc/g+6CLRRGNCEP1FKQ1Q4HewoaDqsV+uEQEGgauSpUoWd2/L3sDvkVl5K8jlIVXtbFA67pxgxgDToYyoKtWOYmWJWsT0sDaSMvmK3xLanqCrLlFxub9Ggt6cB03zFhljOILE9D+wx7uq7+nha/ZouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQGrPr42DgKzvHRGhCEwcNIzY2a0dTfqwSBO8fIfglE=;
 b=YA2wH5Wc0GoYF/b3KcF6n78dYoFgmWn0YQOj2hkzGk3lm91VormoDZLfzjk1hcWYgdWjHQ7j0cObMlve9Dt8uDMc/l/FptEXX9J+9Ek6txgTC/x00pu1nlQRaBQ9f4AuMTh0ISslNuNLG0JOmL1LHYGFCj7k9xsQ4X9ItQ3P9IU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Wed, 21 Apr
 2021 10:15:40 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 10:15:40 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, ulf.hansson@linaro.org, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/3] firmware: imx: pd: fix img-jpegdec pd names
Date:   Wed, 21 Apr 2021 18:14:30 +0800
Message-Id: <20210421101432.2043310-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0213.apcprd02.prod.outlook.com (2603:1096:201:20::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 10:15:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9ebc99d-829c-410b-0aa5-08d904ae6a07
X-MS-TrafficTypeDiagnostic: AS8PR04MB7687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB768763FE3464A8528AE1767F80479@AS8PR04MB7687.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aU2bu45O9YQXoF7z6XfIgdx4KJYUDbOpRbEpIuI08PxoSjGkSOIfqZU07L3Ma8T5g83tH3qyMssWyE/p/sYxX99YKLTU5EL/IryBM/1vn21dAE9qwJCqQSWKz3DgEME5ZOWX9FoQFQ4Zx/GDuexMNzf1vBHREGFYq1osrdoNfhc+dp/jt5YP0LekQAlUKQcbwjQ3txik/jKHOxdPBwbzazEmz4w7E9sAa8R/gVEN7QCiMOVp+mnLBW905TZzEgrMlB+9QdNRuP8GD8ds+vfANHzO42JJ4c7B43KhVFPM+gBurWCMryeCbTLbNa7gT6QmPKAgvsm3S0OPOqdcoKC1jYqR/bFyQcNgfutJTou0QfrA4QkTg8L6UIJ+ukfEpDDFkWTb4rHGw/p34Ssy1mwfsncstCJwST98dPZTQWCphUxv8J9OKrzTwvW5EHZ8BMXwuqzDRHmULig2OVzAaSFFSOQWgoVsfdi0BPFhW5sW5TYDd3ZLAiw6HUYdZFIffCjJu39u736DvnvSiF/1I4kQZz0hbptI5K6U80J+JJxBYKBhWHBhrSWIUvKQHEB0ObySF1E/bcVgOco9QJrVqVwGiaZbNat+DGv4Hq7OVlti0AhYb/HD39qbf5T06kHbR2pGZiZzXEL1ji1tUh0c6EMCuF2BcB6XzgVbXOFhkP7neN98BINn42wPMZcxW2TV0xYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(86362001)(2616005)(6506007)(26005)(66476007)(36756003)(66556008)(6666004)(478600001)(5660300002)(8936002)(66946007)(316002)(186003)(16526019)(6486002)(8676002)(4326008)(83380400001)(38350700002)(52116002)(38100700002)(1076003)(956004)(2906002)(4744005)(6512007)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xtUHzQj84MLqxPCLxCKV7ux8JCamKIzBbLBb0JhYpxl7IK8WWNWExO22YbRo?=
 =?us-ascii?Q?dVQRi3PSehQyi0ihqbOqWMDPWUXEvdpLaXyiE/HYGjMX1KxESwcoN+PvtkEA?=
 =?us-ascii?Q?daBlEvx1mIV+28uRQKhTj2+IFCe/BC3wMC2+PkSX+d8cyMd4nuyUZ6zKTUXJ?=
 =?us-ascii?Q?QIknIVaZ7rYhb3Qr8gq72ENu6pRyj7D/DqzFxyw5SM/FJ3YOvyDY71vOIfRO?=
 =?us-ascii?Q?hD4iwjNKEW/zE48Jdi6cgkUD0QjtTl5KqmirzMEe3L4X3ju9T7cVLice0JIG?=
 =?us-ascii?Q?aFIRqSoS26HCjPe+EKiE8ZbyDLbXSOPwfJSBa2WTwyrHZigz6w71i/o66fvV?=
 =?us-ascii?Q?wGnhzz1tNXCW6XXE31wh9x5NSGAr7r37HArdva/KgnId3I27h06xMy3D7y15?=
 =?us-ascii?Q?tSSOZlZXEZUzcJdLfi5/4jdd2ZZffZp6dMvdOkumcfaAMexS11ymL4lKY1lj?=
 =?us-ascii?Q?NwwvWePmUiZvnrjAYbKrrLpBME5CYapU3kX7Wl3B9xeZs4WFbD9Y7+a2vYKE?=
 =?us-ascii?Q?HtZ/G2cEmFbV78LwUW/8hcnyDOBqSwsbM8cnr2Q8yMN4Cy1w5YM+Z1LVAaZ+?=
 =?us-ascii?Q?vzQD9aOzntdVuNwkgJfKPgXCSPpS0yUchDJ4Wf71tLTgneGL+ECEwKSXHA9s?=
 =?us-ascii?Q?588cGy8riBOet9+EhZs+xdH+lgsxJD3/tPvBWEWvtyPYXfkCEV6Vt3+MVu0U?=
 =?us-ascii?Q?+EMzBvn0P8fmhDznQrB3vN8oamViRkzTrnkl+lI2293MxM+GlEw4seap45oV?=
 =?us-ascii?Q?kJdaFv2+dYFuVAwjRUUCgO0NYTE91hq2kfCPdDUsPW5Cb1JUhk3JjVISW985?=
 =?us-ascii?Q?7hi0qWd60r44Lj1dotbuYBS5Dyw58uIfCU5J2Tsav/VnU9GhxkxVeh0NTN5U?=
 =?us-ascii?Q?xMdL4sGpha9+ycCt5GS2mADmfwfsFDYAKafPHUW2E/UsZeQ5N074TQ7HHD2T?=
 =?us-ascii?Q?spf3kamSE9vvHN9H6xvFV1T6zLJz1j6Ly7231/xWKfv1TDCrtbyHBTQCUw4a?=
 =?us-ascii?Q?DGhBRKlhbn5IAu/TLxK/Fq8Xjjl49domfNk01TdV9KsN24Y7rv5e5vm6685y?=
 =?us-ascii?Q?2XGAQSYdIReUHd8KfJEoV09pqrM+W7As99jwqU5LVHDxjIgv/VT/J8OnRJoM?=
 =?us-ascii?Q?I42zD8LREDo8hqXRU55yfNLAC0q7SiQ4hJj43wdwInQwTCttSoWSX0O+cV31?=
 =?us-ascii?Q?h2qRGA08fDAKThP/QzhPy1dItYysw8KM+KOMZ1sXS6eChKAxEM2ouJ3q5XlD?=
 =?us-ascii?Q?u/GLmV/ozoP9wm5pKs9sHsg8vbhvEk7foerS1zHR8gWvbeI9f+56hrg7QM6V?=
 =?us-ascii?Q?Jb4o4b/Aa/hUNmtqeG6nclQr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ebc99d-829c-410b-0aa5-08d904ae6a07
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 10:15:40.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BeHULQfUfZxCjnSclRJNIwuOnqkP2gFkBYHhqZe5vVHIdLIuuVnKg2AvCjIiTFHJf0lchy3y1csvEoJ3XfbIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changed as follows to align with HW better:
img-jpegdec-s00 -> img-jpegdec-s0
img-jpegdec-s01 -> img-jpegdec-s1

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index ff6569c4a53b..a7589cc5ac23 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -198,9 +198,9 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 
 	/* IMAGE SS */
 	{ "img-jpegdec-mp", IMX_SC_R_MJPEG_DEC_MP, 1, false, 0 },
-	{ "img-jpegdec-s0", IMX_SC_R_MJPEG_DEC_S0, 4, true, 0 },
+	{ "img-jpegdec-s", IMX_SC_R_MJPEG_DEC_S0, 4, true, 0 },
 	{ "img-jpegenc-mp", IMX_SC_R_MJPEG_ENC_MP, 1, false, 0 },
-	{ "img-jpegenc-s0", IMX_SC_R_MJPEG_ENC_S0, 4, true, 0 },
+	{ "img-jpegenc-s", IMX_SC_R_MJPEG_ENC_S0, 4, true, 0 },
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.25.1


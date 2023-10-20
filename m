Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919967D06AF
	for <lists+linux-pm@lfdr.de>; Fri, 20 Oct 2023 05:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjJTDA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 23:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTDA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 23:00:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F8A18C
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 20:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxDz8+XrdNtCIWLsVDfEfhwZOw7nRURgk2LdGDS+hTWMz5xI7M2gPE2ekRy5cym+rJW8fRTgIu5oQ2zBLALl+EwopLQNij4o9DeeAH2qpDETvXhK2IcxxnAgV5x6oI28XjqG86jqowoanCDVOCXi/U+trjB5jRu08CjVhhduv7J8Hk6XH+Wqfymp0+8sJJVpZUKN5rs+HZ/VKr/0Sjw6pVNaK53/O/FDUbAAXwbSEES4BAjGK+JUSpWHyOj91F3zw9arJfZj6qZHlX5RA495FoPmIioIyJi2kHoZIcTUEFtEOnkNueNhJclugYtbl+S3ROLRy0wlMbHNNcqm/XQlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t80/7CCyfN4mpL4wq0UzsbiJ/y/3YeveyP7iAIaIyw4=;
 b=hHHYywhWWPBS8rJauGy+RD+NFfwwAvsAuAHjyrvGVp7stO0Eu5mfq4NBZ6U5DcISFDiF1yG9DdMSpbn+Z5vCXB2XuBBeIVw1UJJgJLaEYqMmndCUp1ADowZit3BiwIQYdyMQr6kKR3DpRU+0K+zrBeWf1TTwu4FaRhwOGXK4PADReM1yb5YHanhBD6tE1LWsAW//xWDmTAlAWiSv3+BK0KbKHwzIsIEJhXh4FHku85J+9KB2iJQYg0DW0VqeJMpIOSc83BGei/GK4BYD95jeaKJ28CeL4M7nYkN0lI3gfxoVYLy5RSC0O6V0HFi0JAD96jRVijs0Ojl+i7Mz9FBLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t80/7CCyfN4mpL4wq0UzsbiJ/y/3YeveyP7iAIaIyw4=;
 b=cDUZEOav/ctKcP/v8rWNTgy36KdQphPIO+xH+VZrmD/mWegRMxA+ys0WTBkWUcK3JWZDp1VvIKlJWFO1F0SE5TiMsFT9szY4FGp4LCPt4Rs7mWvvxD1H1tRV7pv56Y9Z6Ir295HoBA+T42johOOpVGuRqRqqPyuGYTEx9LODIv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18)
 by AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 03:00:21 +0000
Received: from AS8PR04MB8753.eurprd04.prod.outlook.com
 ([fe80::c3aa:ebce:c927:68f]) by AS8PR04MB8753.eurprd04.prod.outlook.com
 ([fe80::c3aa:ebce:c927:68f%3]) with mapi id 15.20.6933.008; Fri, 20 Oct 2023
 03:00:21 +0000
From:   Pengfei Li <pengfei.li_1@nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, linus.walleij@linaro.org,
        rafael@kernel.org, heiko@sntech.de, robh@kernel.org,
        pengfei.li_1@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pmdomain: imx: Make imx pgc power domain also set the fwnode
Date:   Sat, 21 Oct 2023 02:59:49 +0800
Message-Id: <20231020185949.537083-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To AS8PR04MB8753.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8753:EE_|AS1PR04MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 9527dcc0-b7b8-4b15-df00-08dbd118b2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/WznM+I/VwbMDkocU5QuFCyZddXxoE7EhrxIoAZlhq0+AyNiif2cglpSWDbfdTUqEkFclpvyh9Pwgc8JNHt1W8vVTbwDPvxUYuYzqGD9eWkwMVGBWJK2KQ5tS5wCotkjk9/QDlDAOQaA2dFhb2NTp8jCLFzkHCtl+axoTDB7/ReSBkZMjVdyxdQQTrva56XAE32CBW3YtLyp9jQ/41SqU6Oyri718okG0uLLU7yDSlpOvGInT+qqYt2wIWqBMaw2/XYfFRCKk7cmPiiPJYXNNZqoVLb/BK375txEtJxNkx4NdODZ0z6Zfd1TmXhlGIL+bFnBjKEjbajpvdeiAqZ11LYzvcH+IKzGEjRVIaidtaP8bSRHiu/RpJiWZYElGUgZkgIvVY+x5+/ccL2iaIrV0Rs0laVQmt29QAAH0WmxSapOJQPPfN+5goyKFxdZyCmLBReQxH3OlT7zzeHyjTpRTZh2gpS2TTGiM/Bdcjt+KmDdSoehCLC7r/lhyMRfdYPwJj18FNbsnvNcULfb3oMSFlo58NGb46wISvLRma7SGPZ+Tg41Oe8+WNdP4L+LEXe1HwkAF/8oyi/VgbHr8BEfbxSPjQqxk17AL9qB7jVqCifrbHxSrECIk1VpqZO11TY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8753.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(8936002)(66946007)(8676002)(6506007)(478600001)(6486002)(66476007)(316002)(38100700002)(1076003)(6512007)(52116002)(2616005)(66556008)(26005)(7416002)(86362001)(38350700005)(36756003)(5660300002)(6666004)(4326008)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prbwrk6l7MhAEC3m2O3WmuAwHdZ7uICT594E0UUi8getardfk4GownVTvdH3?=
 =?us-ascii?Q?EHVzPJv0ylFqu/g9SFpl+xqYW2Gg+ddc0XbdhJVJUMYa9KgLaF+q3zd95wuO?=
 =?us-ascii?Q?5FBwA9tVYkuXgcVDBqrGP3we1DsIva6Ukvh3n73VXW1T4Tfj4JxVbEdzskpW?=
 =?us-ascii?Q?riNxn9GOXkuUblVxKzjP105AWc5MMJkLSuqqiwAkiIkj9SGD7gIZY5jrfQeB?=
 =?us-ascii?Q?5k5OjMFZLmJADUPcStmo7z4MpfqJe3irb8nCQvBSJKJSDokwOvnhOVBmRkH+?=
 =?us-ascii?Q?tjXfnVNSxlkeYPzHCz7T2rTZ6hz36dFcF6QMleZP1WuRwNd1Xb2Go6ZoQMRn?=
 =?us-ascii?Q?9Z+bOE7juGShD37i+e/Dt5bGIL5J/nJL0Bvnb3K0rWOEMAA8Pt8RELKCknB2?=
 =?us-ascii?Q?a8nOyH+2txQRKT/MvQbB0uVdJghPl6HI9jNNP0Lk/fWa0mjqKQJFoc7+jGna?=
 =?us-ascii?Q?1qYKDpsSfUaZjw6erLawXzJRv68pvSQGDWodVaOzNZSfZav1SKJ6VHCLN5D9?=
 =?us-ascii?Q?VLAPjty1xTzUXLqgSH3tDBAQgt5GghL+/9FrhNMGsLGIwCZI0CWAlWV1ws8K?=
 =?us-ascii?Q?sxwoijK+nobLuJH/OmN42In31NBtXeIn/MSw8Zt/wc+q7lJ0ALENxwBA9Zr0?=
 =?us-ascii?Q?RKyLrTMk3USfwnKLTbiLv73dGUVtg98Hia7ZmT6mPxsrebcGkUepzRPK2+B2?=
 =?us-ascii?Q?NeHHy9qu7LHBqrXucZGLVzMKesRJ9wDiOAIm7+oCC5NVBdjJJbwbIaIcdTdy?=
 =?us-ascii?Q?VclIJPE1syvkg1J+p17nS+wjNbQY9dCIIS9meXxWx1klgZLgnEy65Ep87kYs?=
 =?us-ascii?Q?2BVxkWtGhcPadgtzHAMgFZIYDmWndE5lIz2pldeqsmEGh4ZkbX3oGBAVD/yT?=
 =?us-ascii?Q?CFoiXUO/UI1iza+pKfM1oh/fOf48SWRxX/ahb5v2wE1Q7oILdyAXd9kEyYTS?=
 =?us-ascii?Q?o9nNC6ObJvMa74USiOiQr1ko4vq0c/iGITN1a+DJkwJsF3i2bOJGN9nGjpjc?=
 =?us-ascii?Q?vQZuOXCZAhWFtDXDUUCgF1VVQUYQnmBwhW9uhBx7J5kWwjCo6hlCn5P5oa38?=
 =?us-ascii?Q?uNzXQ1UWOFpMZFO7cJjbJu6k4LMMZG4oHbz6x84OQxcwlNmwZ8DoTr5kjlHx?=
 =?us-ascii?Q?QISCl7jyWCqCLqK70WG6hoxfK0XBUXS05PQQIlvG69/CxdXyP56HEmr2FhWI?=
 =?us-ascii?Q?XF9SqZOv9aw4cTmB33nE3xiaVr8+0KbX8SwfQzUyi2bnsmiU/ewm/Yx8F/O6?=
 =?us-ascii?Q?4P1otmLh10MOjeR08m3MFAD5BHfnFFDZMdZifhKbKQYU84szIsDgOn6Vmlit?=
 =?us-ascii?Q?gmdkVnFDtrzWwTzy/VrZunpFi2I6WZjXKqRtbqbQelfIBs6t6tBkllCuK+VE?=
 =?us-ascii?Q?cXD6dnte8yv5Mxb98fqNmtn9g74XvuvfEnFOieGio4oD3Ji91BssjyccFhK3?=
 =?us-ascii?Q?1rostiGE4GKxTD9fZzLTDHEzZO8qCKIhXpBr/kMwB6lgptsBbCTwaS5BQbu3?=
 =?us-ascii?Q?D1I3PYcgRpiQVA2i6WswSe2t54J1YlNKAkGFAcS+dm3JsXJY/rqcfkbUEigS?=
 =?us-ascii?Q?MnsGVtwu4fqp51BXQhyqgznifj0sjyk/IUj9TvT1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9527dcc0-b7b8-4b15-df00-08dbd118b2c3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8753.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:00:21.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmeLKAgdhx0uJ30vvCViZHaLX97hbemBoBdonLXo9Hk51nP1m3mfbkxjXjCho8LlYp8R9GYoJk6M81tPFfeo9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9630
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, The imx pgc power domain doesn't set the fwnode
pointer, which results in supply regulator device can't get
consumer imx pgc power domain device from fwnode when creating
a link.

This causes the driver core to instead try to create a link
between the parent gpc device of imx pgc power domain device and
supply regulator device. However, at this point, the gpc device
has already been bound, and the link creation will fail. So adding
the fwnode pointer to the imx pgc power domain device will fix
this issue.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 drivers/pmdomain/imx/gpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 114f44ca07dd..7d81e3171d39 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -497,6 +497,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 
 			pd_pdev->dev.parent = &pdev->dev;
 			pd_pdev->dev.of_node = np;
+			pd_pdev->dev.fwnode = of_fwnode_handle(np);
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {
-- 
2.34.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDE07C6F10
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 15:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343733AbjJLNW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347229AbjJLNW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 09:22:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2117.outbound.protection.outlook.com [40.107.6.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FBCB8
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 06:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBASVai/XNgEXqxKHlC7osYzWxMdi8QfnMnuTYgQG9g2Dga1WcgZRjdEItBvJ3e3C7UGzTPGrIYC1xLry5cIZfXhFNaO880Uc722P+xx9JGd4V7Ktsx8qstNxq8Zt85BkzdMGgWYWYYR8FQ6wX+K2gHpmAx7vIBbAehT5BUM4MlnVEF5lx9+KF+mqd7/4cZ4oHn3bUHqQ38llE9eA8PHVB4UhE5daGN2xp5TT5TTnROAC+p+EVc+rHzTZ42moNNC++sF8i4YBhzHBsC96hXUSYmrb5cV8qWvpSaIbK2+sGd9/HvX+YZw8D+h3ffhhSmHdusOolaeu4Zh1DzUho9Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anVx85z70ZhL2r17Ypc/qpLvtbuX7Cv4BDoOe1Zi5ZM=;
 b=ZpV+ZbCs56yqCsTr5MmN66V1CjXAK4eolUx8JIjbnJPgLop5F/J8M1xCgiR3a8vO4/RY+0in5c6bLkNjh6BfFBJqhxOc4iGT0u6OlEAkylgPIPDgESDd/vrSjENJcEnsJ3HtnuLSZ75p7IdQRJP2gAR9NRkaQgfYmg9gDsNe4YtUryv4KXtyikWttIDoqqr980hdQ5skJS/LMFVDek3KNh366SqLYADbeE+bWLJ5jbH9dc+iv3X8QAOdAuY114zmaY59mFM+3NMrIPiB1VNxGjW3kcnGbCweqSUVkjhEOabQISU64hobzftCPQPib+DexPRsXBtow+EMsggXRNvsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anVx85z70ZhL2r17Ypc/qpLvtbuX7Cv4BDoOe1Zi5ZM=;
 b=XrMiB1KLQV6Mv3kSWpOs8scnuy1Hskw+T0GICJqrXKUKv6kDw1A+S4iibZGMlPsUmdNxjYWiy2nIwd/T0X94+f6GZtptDbTQ14tYUzYaMHGz9f8gCOoemMcOeB9cKl5iUdu/Rc4K7YGfWWOUMg6vtY0NDedKhZn03y61bdG40K0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
 by PA4PR10MB5635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 13:22:50 +0000
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1315:9ecc:6928:f486]) by PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1315:9ecc:6928:f486%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 13:22:50 +0000
From:   Emil Kronborg Andersen <emkan@prevas.dk>
To:     ulf.hansson@linaro.org
Cc:     emkan@prevas.dk, saravanak@google.com, linux-pm@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
Date:   Thu, 12 Oct 2023 15:22:14 +0200
Message-ID: <20231012132214.257207-1-emkan@prevas.dk>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:10a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB4576:EE_|PA4PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 7594d44b-a9b3-4df7-bada-08dbcb2654ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EDe+hWQolgMajUOrS4/0ME6W3+JMfmNTwiDcxR1WA3oWPxshx5Ye0T0mKm+5LfC4zXCW2DzG3P8oxcj9Q8r6X6kjpqmW7+xwQzZ0JugHcRAp7FyYlAXmRydPyuj688+UI5+MmldwKopYSgUl+HKEr8aHJnZnLMEVgAK73cWxlgjHkw4r3Ks/usAiWlbjBL0S8zezx/mVr3M7brP4SPPPYDbIqBmKlfrjluJUJCbND55hGzg+H0+cEX9fEM//+RYSF1tLjAjmWwSe31P7LRHQIXVBjUo5IWZ70d9iAu0+3399MT09T5wN2VUoyZnM3pwxOLIu+XtzBY0L9hXPEPDtlA82fku59VxWTtoFwyOJqzi2PVKKAXISFwC3cGgtOOaHwDMeTQVv7jupzDgSqy0sYqD570hlLz8Z/oAXEgxcGJMes4OL0gY+009kJ9TwnPn1d+lAE7hRKs9PGAOfkF8hxSSPR6cDKM9fnISojKv7Z6pGVhP2CzUyfmsxcXFjbhowuiyg/3RAxJQaci+jcmr7XQxV9lvXgfnRD7NeTxLwrb6CCiVtW7QxP6yYGPSi0EESpoZX+kxY1C7Oiky1sQsnwROAoI0irGu9jFJgeX5BaPwSE6svjzdjS98S8BMbILx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(366004)(136003)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(26005)(2616005)(1076003)(6486002)(5660300002)(41300700001)(4326008)(8676002)(8976002)(8936002)(86362001)(2906002)(4744005)(6666004)(6916009)(316002)(66476007)(36756003)(66946007)(66556008)(52116002)(6506007)(478600001)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mXN91e3HvPbo/i4yDU/x03/bS/IJYVI481osuKkOsJDCQJ+Bzqz4BNcH8Q9u?=
 =?us-ascii?Q?yUI/OlELYJRvl4nkhjSDQQmL7Txxxseh1tZ2cRVPK38U38UCRtYaeO2thID3?=
 =?us-ascii?Q?jZ0CxOz8pHhUCCUkasG44yhaxCCnyXK4e0pVJbogFhDJ0iTTqHo1jc1ENIMC?=
 =?us-ascii?Q?h2/xTyMqfxQozxFxWHs8HrjtHcyt3m+OC1me3gl3m73UA5N9kep3ce8m4xDn?=
 =?us-ascii?Q?t0GInAAgb2Xxs5V3QThDNqmt/K/h2YspdGsmmUTypAoxIPQv/PWNqdoKpfD1?=
 =?us-ascii?Q?S1BxCuARDbYD0cQZIk2nobps7Ko32RFbqoeER5WORKQGCtm5ND7GQavPIFWH?=
 =?us-ascii?Q?JtByrFn9QfzgQRUfKIpVHqaSjwG1dCZL0/Ic7XZZ4flnKKJi4RZz2POc7sAP?=
 =?us-ascii?Q?m1KUKH/DvWI79IDF5Z5gCdsOVq5VxTbCD1scmoNLRM2WSn1gRH+A3GgnqiiV?=
 =?us-ascii?Q?A7h3Om2c70mL9Y4B6ZlAvmgyq38bCyjdM+FsbEEq0r9UPDit5QGZoM/etsXd?=
 =?us-ascii?Q?kHBxiSzZbzFo73HwSYxr1SRsknnTeCux6W5t+RfWiSjJ9dFqRboWGJNkImeM?=
 =?us-ascii?Q?sW8Y/VW/nmjkvpdwRjIkgNdXLr5EYWfSIaZ9rS24bD/8uqttTJ4zEVRtPvfB?=
 =?us-ascii?Q?oVUmEJgPqfuj32KOt7fD3fSKlZfS4N5Q0HBfOQ+PmOE4nDy10FGcYtyjiqYy?=
 =?us-ascii?Q?TB6U5HL+ne82oh0i+CxuQnvpOTHEB0RqdhsBHQuNKpi00AN/PPEdzN1OcMls?=
 =?us-ascii?Q?bw4SQYOTR8//noouxGLmq8UZ6pZ3NVzFEU7WBYuUSLNglh2yW/XIaUkc3wFx?=
 =?us-ascii?Q?inGiUxfI3LtGpJ52fG6R6fCZIGEt35+Jef23Mg+0vH0Jnm35F9doXssjwluC?=
 =?us-ascii?Q?Qfvz4c+RI6FNj42P1RJLnn2H+PzhPXov4OhIV83c40RzzyjbXl7L2Oi8Iscl?=
 =?us-ascii?Q?nRXeEmRkX+CIqAcwEY2zSKkeqhgzZDmSVnd9lkTWsnzWicUliQUGgTSsNCl5?=
 =?us-ascii?Q?Twyqshj2U+9BTwh34mXJ3DUYvw4uKFjz3/GNGJf9pUA6jeoEVY/u97snBpbJ?=
 =?us-ascii?Q?+RHKTid3Mu1jCtzUyU3SeobxcM+GyNLlkUScJ4mr2tCJ0jEMmBCyN3HBSijV?=
 =?us-ascii?Q?22f8oZq1yMCs9vi9cFhAPnQNFIoxPF9UHlFJtClz1DtLMto/BAWGBiA7IbpP?=
 =?us-ascii?Q?EPnYynV3jmiWQUdEHe3+0fd2ga4naqixvSGDiBrA3faGMivoRCWwo/NDaIEh?=
 =?us-ascii?Q?Mq9IHzw5ohlGLMqeooQPBDDuR4/86kYkx5LHOUcBlO2Nk/Ce5TxM4e2yipX5?=
 =?us-ascii?Q?uxnoF3fJR3G1EeC35o1qneNOZdImwo3m7Rdw0q6ROzl03rzL5iITmGdgYAnf?=
 =?us-ascii?Q?EvBeHtdftQXcgBsl+d538SsO71SKR4NVhz5zScZoRQ2WuByY2BijbIt9fVNG?=
 =?us-ascii?Q?MBlfpaAZHnM0WOs3puD3vdBsi1Hjs039BMVTAAEkrWE9QcjwwkqEO3NHqWvq?=
 =?us-ascii?Q?wFZ8cdcGfaFVqEbn7Ab4jwG31L0Frhac//fs9Xj72vobjbrWGuHpRUXlSw1w?=
 =?us-ascii?Q?JlQRqJk5nAfS7yoHVxEeWiYA4vTadP8rk+zvMgc07Wk7M8OCZzDUt/cZxNB+?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7594d44b-a9b3-4df7-bada-08dbcb2654ea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:22:50.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fp/kdcZmJ1mupl02KkFEzTHXRHQGT9e3KUCBaGSQoI5RpPbjAw03FkQ5zoKdQAVnWFUXEMsHQUdQv27SjQ2CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5635
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Before commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
detection more robust"), consumer devices without their fwnode set
printed errors like the one below:

[    1.039830] imx-gpc 20dc000.gpc: Failed to create device link (0x180) with 20c8000.anatop:regulator-vddpu

To fix this, set the fwnode so fw_devlink can find and handle it
properly.

Signed-off-by: Emil Kronborg Andersen <emkan@prevas.dk>
---
 drivers/pmdomain/imx/gpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 90a8b2c0676f..8759eab72880 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -411,6 +411,8 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
 
 	/* bail out if DT too old and doesn't provide the necessary info */
-- 
2.41.0


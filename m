Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D493887F6
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhESHIH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 03:08:07 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:37696
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237212AbhESHIH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 May 2021 03:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BchdGFwJZS+KQ1AzVFcRuYo3w0bdVJJ34IfAjb7ldnwUj18hpB1czMAfNAiu9wooSgmiiqq7BPOZW9JyuGIMdYZ6AztKJQpIR7TFHA7PYDoGrwOBoKr515V2s/sU1mbHx8t4nyhQWJfJFioti9Cb1xbe0NPwcM1qUgNoe9s//ocu680IsT0nZuqyYeXgY+3VTxKSg8QYoHH0ykm8/WWO4E0g6DlM9e/BqUWljt7aQ5yV9vBOxKVA2VVoATiKnf3+1J9mNQwasjt9uDCnuTXivZi4xNz4AocVxVoMNYVN3x9TisrSiqgzmMuhqHdXncHar98GNTMzlDDjaAc9CvgFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyq/JjLietWNQd4O0gbx/QIX0zIALr17NZMz6mhVzUY=;
 b=SorwbkuHSvDl1A9UyUfQwvqUn+Ev/dDI4C/t1eHvqrErKt8m/MEwWk+ulAlioJg6/zIllNpfeetUNLpOnN10EncT+gy/+OKyDj3MRNI/7Xiw/hq/Uic7XApk9dLYxk2Pf4GdqgZpZ3KMX2aoioL0Jgn6SGV1QvFkTgM5GoMHsgSlGhlUZR/HXbzgwc/J2gKAKQR0I5gBq2sw78i1HFjU1eEJ1kswJa7pgqs9xeasEQZJYCVpCEV6pJp9ci7H/eQ4CK93pZ8THSO2x06EYCnvWXWgJcX+CkQAU7iMUfRLTzYLDJLFW7+1FSKvCK71N2G2hbVN2zRzqfVz4RJRAjUW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyq/JjLietWNQd4O0gbx/QIX0zIALr17NZMz6mhVzUY=;
 b=mivSY1QOgq6LrYmoNnWFV0jKac4zZE/M9e8yg4jDnX4u6YLmGjznxUumMVH4fBkyYZPtsjilGMsRtDonyqoqGw4OVSiz5ppEY5bqGaINwUOkDuUxP4XXJ54e2/hU/ulUY4hypxsxbpNHQ6hGQ+TQZoXl98ASP49DK3nvMZPweb0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 07:06:46 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 07:06:46 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        linux-imx@nxp.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, shawnguo@kernel.org,
        kernel@pengutronix.de, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 2/2] devfreq: imx8m-ddrc: de-select DEVFREQ_GOV_SIMPLE_ONDEMAND
Date:   Wed, 19 May 2021 15:05:45 +0800
Message-Id: <20210519070545.1728197-2-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519070545.1728197-1-aisheng.dong@nxp.com>
References: <20210519070545.1728197-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0056.apcprd02.prod.outlook.com (2603:1096:4:54::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 07:06:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92d9a1b7-4349-4049-d4f2-08d91a94a9f3
X-MS-TrafficTypeDiagnostic: AS8PR04MB7733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB77336D9EF8530589A82F8817802B9@AS8PR04MB7733.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxKWY4XnE+ozr8LDeMDKXAPEFIzTM3e5sk3Pf7j7fNpGNelOzv8eb2+VFkLzHSDRKl5c82gHW/qD2YmuzjftyMLdYbMpf8myzGv+jr3SrcdzUMXHgkn/XfyT10bt0EGleBDAERaV8Rr08cEdcpS3soBGIByH2AS8Uj9V3hgWEsCS/78fJAns/7CpTXISlFkU3N3qHV01KF65PFygVv/o3WP/QqGmWUssG6zhK9x2DeJbsHDP29TmzyEjiNlojJY4D6Raa/xsWCl03vjVhtR/tNLLdWZJpOidc48htVIFUWjsMGSF0/7uoGnMntAm81i4jrTm5YSEK2Rko6WWeQCKXLxiHxTvuNJEK7ZSxbGZDXtiojAbANviGBukCN7XjCXklbnwB1S5FQScvVXOlQhe+nlu+MSEU/7rmX6pHZnNhHxkiCuVlYuFB+S/0fU5Me3YuBOhqfqaZQOi7JbuodeV7qFP9bg93DcAE7Vk3wM8AP/V6hXkLJJ8XacVHgO3AMi0KC8C0rXSIB6j2P/sIoD3wobwFTWZqCyfjxHeuam8Tt3gPki7KOV/6tsGFt5Cv1b8CtFi5f9aMfMWgzyJ+hLXbgKkaUB0hEWPj8APBETwLarb6MQkE01crJ8+zxi3GqtjkxiYNCVTcoQIyt3jbTqVxNRatHRojb0oV6R1fjCAAz7oS3qOvbJiiqcxTIrCYUnVjy8scVqR/67t8O65cFy4Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(478600001)(26005)(2906002)(6512007)(4744005)(36756003)(1076003)(83380400001)(316002)(66476007)(6506007)(52116002)(16526019)(8676002)(66556008)(66946007)(186003)(8936002)(6916009)(6486002)(38350700002)(4326008)(5660300002)(2616005)(956004)(86362001)(38100700002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4RCrK5MVGiDoptJmoJIonbTcRnjyvqAfEruqzrteM7Jsv01mXf+B+JEA2krm?=
 =?us-ascii?Q?B/h3WvFwiDqxJ7eNIwK6UWm5m0c6r2YsGC1h/E7g60gNuDTyJk5sKJmfhS6c?=
 =?us-ascii?Q?cZGf/DTNsGOrFisXFod7mB5Z2/WNyt0IY2BMDp6BvVdBwVU3kKpWdk9SaY+6?=
 =?us-ascii?Q?EY+Vo1Pp6LWsigQbeBmCNGNZcJqCyViSAna0Tn+EmPGCiz45rQGDYaJ+LUiH?=
 =?us-ascii?Q?t71mp1osQXHMWUI1i660Kf6/GY3U0z1FIPLA10ELEMbPn4oJaE8GjCuztDCE?=
 =?us-ascii?Q?Cb+a6U4lytYpuJreTIpI/qketjbSQgCN8RRCgjkHkyqjPz5fuWGeVJLJ8gbD?=
 =?us-ascii?Q?rQIFgVNAVqyNA/b7+WypTree2hbH69gmWkH47HuPhLrDwo+7/85knsCI1IX6?=
 =?us-ascii?Q?HGR6VHqQ2+wdtJaNnNumYxNTBsV5qWdEYz4tWSAonoQKudcAD8uQwieND1ad?=
 =?us-ascii?Q?ssqhOKAb7g2iesrw9NbATwO8IYlttVXN7AVLD1TUMgXiP/T5ol32i0VaDJDv?=
 =?us-ascii?Q?BY+L1DqIwzx78JRKzqRO6+dBIdzSn8UUiKVlWYa6I2Hhp+M6v4SYt8jSbsxd?=
 =?us-ascii?Q?CzfKOy6GOyYPwZWhL8sbeMh1A8gRjPb03RqBM7Wrv32+rcrjkJV6A1XPxq4y?=
 =?us-ascii?Q?siDqRd7zCWlSY/G6/tpuielIckZkeu0RxRf/Nc8Opqv5z6ogP/wVD3V4U1Oc?=
 =?us-ascii?Q?z50GaCNTCMLgqYz7q5eMgTfdC8TjTcDQIG/Y5dYUDVCNwIiCwHrBi/vboAUc?=
 =?us-ascii?Q?J+Bt42k5SF9tK7pkgXBhVVwc8zCjFLij1UKe1+hNjSRtIh/bZCtBcK7gnmSW?=
 =?us-ascii?Q?VGPbRmC6umez8irriH+byJ9XAVU1a7B6lYnqnjS9C9Dwvhnz85gNB9Ps4nRw?=
 =?us-ascii?Q?bT8TtpN0njuJWsCzHhV2ysB4I5zzbomslEewbOhaeiGeamLa4k2R71Oga9Zm?=
 =?us-ascii?Q?atD9hiu2+XpiTog5heRwgjQrnpeL8JStOEHYflEPTE4VWH4M6ALbpx1tbXG1?=
 =?us-ascii?Q?3fSbrdJtsDGPn56uJtaadfhyIy/HWrTUHkHRa8oWF5hdoyko/vWN322D8syp?=
 =?us-ascii?Q?B8dvzv+kM3Cg05L8PzOLSwrKd/jEZs23MEhAfeYK5MouMaKQBw9fHgrTbuvg?=
 =?us-ascii?Q?SiqPpRbDjgPEPOkgUI4kitt1Ds/nHWWyGALsGkArXs23DEIhs/3AHQtoO6/S?=
 =?us-ascii?Q?pQnx97PZoa9vi2/qI/vkjxqBQ5tcmfRKDeUWy9SE1O3UHoIRO3JD6S4tMtSs?=
 =?us-ascii?Q?vCK6VgM5k4CL4yntMfC1No39VddnaeoY5FmCx5l3eNxSiZ3CwKRFSapYCLT3?=
 =?us-ascii?Q?PkQOuGva/fo2zFI9SEHoNKEq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d9a1b7-4349-4049-d4f2-08d91a94a9f3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 07:06:46.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUWDCWZzXa7SsKjyPwoqwBhS7r7MStGxcQMqDELLKS7O2Z/Go+3Rr/y7teUt2Ud01vGmyZ3mRbQ9DNCugVtUUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver can't support simple ondemand governor due to missing
.get_dev_status() capability.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 20373a893b44..e87d01c0b76a 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -103,7 +103,6 @@ config ARM_IMX8M_DDRC_DEVFREQ
 	tristate "i.MX8M DDRC DEVFREQ Driver"
 	depends on (ARCH_MXC && HAVE_ARM_SMCCC) || \
 		(COMPILE_TEST && HAVE_ARM_SMCCC)
-	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select DEVFREQ_GOV_USERSPACE
 	help
 	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8D2C22DA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 11:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgKXKZV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 05:25:21 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:29187
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730944AbgKXKZU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 05:25:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdBmFY04EG0QV6JQ2LsnFkhM9mSjrjjVVPvolaprx5aamxH12AHc+g7nlLZ7SdT+duCrHpsAAiRLbc8k/a18333SnYSlZWjUQl/yu3b1F/Y80qYqb9+sfpCaFxiTz+Dwtn/MOVJvhgo+zwxz5QZVcOm11/3UwIe3BcvLQS/bOXIR/TMdN5xTk5lC/3Hb8bj3/hGce+rFxLLPfmSxIRcZsiuvmJqjgPQtc6K9WDlv4z5AmtZQmi3z17gcheGJ5xKglV3Gd7sb+31l3jE6eEWc/xZTinN414lTZdyiHIw11kVfNb6gNNp7Va1LK7OOS21firEc8kl72g3sf90GRfteTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZPMYtA3ngh4NkOQ+QhFSH9OQO/KU7B5yLkdotB4vhw=;
 b=gwu4E9+g3N6kr+dmCRciY1kn0vWn9z+5vAi1Y1A6JB+342MXhWLX9MHgtqdk83Phz5E03bRkx1tri3+14bMUrYjrPY7iHgdbCdLoMUVhrjy11OHlHSVUZq70pIlLKxQU+FEDeXY3zSQtvbXOCzKkrvc0dzrk5k4Xsp5MxAe5qU/8CmC52RPJa/JMpFtjgXIAylNeL3onmYk7VY7bU6T2TSg5sosFsc/5yl4b4XFGCdVNpU/k5gCZ8MLDVnygJNNGukhbhNXL/8RNzLFuACSmC1+z5ONcTFsx7RZ4FFGDkqpfpgZEiGOJuyVoyQdwHP9ue9u9U8I5vTQadjHUlKKuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZPMYtA3ngh4NkOQ+QhFSH9OQO/KU7B5yLkdotB4vhw=;
 b=bSx3JCGEG20TvWbkPf2g1wZqkddDAzksux9BV0fWkWioFGJ3Addma29wx+ETITpMnHQUZwCo9bpKH1mvTDxv34eAcRApmzRiPucIEVAhPmlU214rzt47+fZS0twx34d/n6173VhbW5GElAtdQHm6+CYB3LT9Nbq3XQTTop8JywA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6648.eurprd04.prod.outlook.com (2603:10a6:20b:f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 10:25:13 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Tue, 24 Nov 2020
 10:25:13 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        sudipm.mukherjee@gmail.com, sboyd@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/3] clk: imx: scu: make scu clk driver depend on scu pd
Date:   Tue, 24 Nov 2020 18:08:00 +0800
Message-Id: <20201124100802.22775-2-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201124100802.22775-1-aisheng.dong@nxp.com>
References: <20201124100802.22775-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 10:25:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d37aaeb-7302-4824-110e-08d890633a93
X-MS-TrafficTypeDiagnostic: AM6PR04MB6648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB664800C688A0A44B1086C38D80FB0@AM6PR04MB6648.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwsWIedVO4Np09Ljn8w13fwOwD+zFtpQCLXcD6T9r8ft7IW240wgKV1SUPiNviy5dWc3EaskTwYUDO8W2CRt+UuBZz/nf6eF2LxrJ4feCM0gTT98vGNK/64lGTFK8z+hoAUEw2HvsuhjCfMQifp+SYv4X0Iw98mQkNJiIPM7S6v3XFRmIMyirU9DOEw++/XEAGCUDPGwsA5p7eWk+3Vf+aGMHTdfKPOQIL0VnZVMo9CSMTrDDVFx/myGFL5KpA2zkoqQV3oKgW39nGGfOdmmHBXgsQqkp27nm2+69rq6oUIq3uKMlPcB/iS1qWT5/ZyDCQkCknfcD1dM6jE5n+IOjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(66946007)(6512007)(66476007)(186003)(26005)(83380400001)(16526019)(66556008)(6916009)(6666004)(4326008)(86362001)(36756003)(316002)(4744005)(2616005)(478600001)(2906002)(8676002)(6506007)(1076003)(5660300002)(52116002)(956004)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iLmR6XerNDXn3vNoqDTTuYbiyZB6DD1bBEPhRCgliBwlbK0Oh9LdR5v2kt5ImdlgzIrLwaKcc39HicC0AyJmf+omkAybcb4Csv2aMryQApMZzkE45wN76OSmX9rRyO3fMjOdJIhey0zGCMbJTqLqXPSTmtXoV4RtRWNyU7gu2LI+uxxzL747CEjTA69rMn8VQ+dfDdYXzD4KYDFN8J3gJnxiduZ778JYwktrFzED0RuBmGazSoyQRrkU9kH44smowk2obVsyWFR5QbzSl7KGsp7RhylBeQY/n8Dy31jT2vXrkq+12mH8FFTxZS8nNv8G9L7Q1+DZUl7WSH0SFBJjBagR9EzMTZQqZUodeTVojtoakliEsP1vJdSGQ4NxyTCUbJ4ecA8LerSboo5RSzso2yJr5wS6TVeTMLs5jH/iRvBOMHRGDMK5/y86Ad9g4fGNQA0nWUPaBrFh7G1PFDDuoLEhCf8qOOHEwHSnlokrfjcsdqcYtzGMovwmLgF78aNba5zyMM8vMfJdca5nvy9CfMi9EH9jbUtehQvjejEQ7S9zBMV+nZmDc+s6ZXDv/LEE4ekSfzxj2XQL/cVoPG+pYhp4mnzok/AC2kA8Nq0hiGuDVBTPhWFua/pgVUM7KTmbe59swe5BVprxVkU15UE9yPks2+ku8KAku6Uicd5IvPahZd11ZTI1R2SNpN3c/2r8VYL0a2TxuobiLw32i/iOpWdOnETGt+kvkCaJFO6F/mgUoSX7piXEW+7Um8xQHzXu8jAPt2XLe6OKkBI9dkAotHOkOjN/FUiBoGQxQ60DeDS1ZGyAKw7nAAz52HaqTLaiYoUZCnYAKh1i9O0HkIRMPeVDh1YfrqTM/Jy+mhRYoKg4g2y9NjvVJ3JxT1iC638LkRFsi7JBpyC0wa/7mcC8tQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d37aaeb-7302-4824-110e-08d890633a93
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 10:25:13.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOG5bKujDmWdjCedZa0FQJ8roZCaqUaEYAYP8cUqqjhMMRXafaBcitQNxxJk9UfaE+qqMTKD0cYUfwIlHxsdOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6648
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SCU clocks depends on SCU power domains.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 3b393cb07295..e79375c76159 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -7,7 +7,7 @@ config MXC_CLK
 config MXC_CLK_SCU
 	tristate "IMX SCU clock"
 	depends on ARCH_MXC || COMPILE_TEST
-	depends on IMX_SCU && HAVE_ARM_SMCCC
+	depends on IMX_SCU && IMX_SCU_PD && HAVE_ARM_SMCCC
 
 config CLK_IMX1
 	def_bool SOC_IMX1
@@ -96,7 +96,7 @@ config CLK_IMX8MQ
 config CLK_IMX8QXP
 	tristate "IMX8QXP SCU Clock"
 	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
-	depends on IMX_SCU && HAVE_ARM_SMCCC
+	depends on IMX_SCU && IMX_SCU_PD && HAVE_ARM_SMCCC
 	select MXC_CLK_SCU
 	help
 	  Build the driver for IMX8QXP SCU based clocks.
-- 
2.23.0


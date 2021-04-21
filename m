Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678433668FC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhDUKQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 06:16:28 -0400
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:12162
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239220AbhDUKQY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCTrgVtw4v4/Uu3Mh6NmgyONkVuAiDDOHWVS8FzmqZLXT2hXnnJvW5gQXpmnaM066VSIp/1STlA5YipL1yvpyHgN9aG4EqmwyodmwuOM8qrsDaMQm0zvTIndUR/KY78xRyTZ5C0Te3Msbq0W3/0ezqeztyX8e29WvV/6ytYpnHQaRp+IbHxkLVHzrpQcTr2RoswWd12OP4NTzCVGQucn+x/bLbkQFLNwRVCzBDYvRdqdufp7xEC4OLYn0mGP+N8P9a3W126LoZfqYk94YEel445Z4LfjxqE/017J1wS3auLAuvOdEB8gsJaDpUWliAF/g3cFd7rPAanvUeRqwCi4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZuSHxbI6/0JSTEohDZsBqCcyIu5wyeP7JGQp7zCsJ0=;
 b=E6ylUHfAS8eDIXik27u3vz9FfOMavgK7qAmWU0YG5JtHmMEXdHmQkT6Zh5mXa6TipStx3GPFyZyRDO6IbuhHPqFvuXD2qvclw95Tualy8xrYsRKDBt8uphgYwp/qqxc1JjlalN41DfRjpecbesEYcCbV14Eju6wOOQahVfKKnYwQcEIrq32avtU8IwfhE2tttcq3AZqqYhlFGbuwg6m7QGN2mVJQ7XYVEVkMEvBHQEuIE2303RVlg4PAA8TlO3xMmodF2URdd6E5l0Ax87h5zw/MgCTYMP8g+3GW+ubusWaMhuMv68lp7HM4fSfa5127RsFLREVYat2O0O4VQ0Jv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZuSHxbI6/0JSTEohDZsBqCcyIu5wyeP7JGQp7zCsJ0=;
 b=htHVN8xmlqLgBWyr7nSRSYUTHNZB6NcT08HQcYVvLpvPbWn6HUikk/DcIeOlgQ3s32SePTA/sZ20C91jagv3Qku7oZPGUyo1TTOZ/aW3hT1d6TqEMNfKvzXy1yi570y3bJVqH9xJDfnCS0tmrZ43ItSZHBjK+cJXJFE/0jEz5jA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Wed, 21 Apr
 2021 10:15:43 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 10:15:43 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, ulf.hansson@linaro.org, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 2/3] firmware: imx: pd: add missing power domains
Date:   Wed, 21 Apr 2021 18:14:31 +0800
Message-Id: <20210421101432.2043310-2-aisheng.dong@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0213.apcprd02.prod.outlook.com (2603:1096:201:20::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 10:15:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55598049-6af3-451a-60c5-08d904ae6bf4
X-MS-TrafficTypeDiagnostic: AS8PR04MB7687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB76871233DA2C133D02130C6C80479@AS8PR04MB7687.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:71;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cxqbnLptfms27EWd8CAUSWObzwSG8sMp3Y02gpbJ7cfTgH0wNM8/6cKna1slWyY/onrHuMDC27i3diH5Qg002rag3+5OeozWLA+SNlNn10H9Af/z2Bp/+gLYwhe9JMyHUulBuQJZXTECJoRY0ngbEw10wQh6fxTXLQzxvmXG4v9foMZoNAbJCRRUPogG+CS8fsmy4OKZhmy8Ba85KG5sRL/YC0SQEICB1s+LewN4zkA4I8UWBa4PXmdJU7zOSZl/zyXlHdgXpkIsfJsXb3g8QKW3f7uK4wBHiQLsNYPleh2ysIl3r0QGovj2ckW8AAcTHB8zlD+vnucKNWut7RmerNiIdlLHqFSKtCS2UMfD/sdVWA1cxzh6SvSB8ZLqHzYz4NhVwx2O4GcERICSPHxpfuhBOrMqrCH2nXclftWv8xmwGyDGdCD3zu7KDZY+M5Ne9qGXG+ByfJcNZ71EVtRFlh1oFl1mfZ2wcdBtZ31saCfkF4b+KD/MrnBd4jDx3mTqAE9dqmQOhp2AEHE5wqoMpHswEunh1D2F/EF2chczG+ee8CE2NXmInTjb6MExwZZSvGop+i3zBknmW08jpWnHaXEW2GbSuZM3CS5RZx3EONscVxd2rF/p3Bfu455lX1Ws0knIYFdeAZR2SBrkjmHlfUaVYTUDZpM6idVlQa78xTCSsAmWeqluKuQz0FaX0WN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(86362001)(2616005)(6506007)(26005)(66476007)(36756003)(66556008)(6666004)(478600001)(5660300002)(8936002)(66946007)(316002)(186003)(16526019)(6486002)(8676002)(4326008)(83380400001)(38350700002)(52116002)(38100700002)(1076003)(956004)(2906002)(6512007)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UloRp7SJMfUofHTM0OXgoe9FvfFRf3rwvEsnOGo4bbJ7YsB+MnpVRs0F3DTV?=
 =?us-ascii?Q?wWvjjRNOiHHJ8Ho5+4Xeno60IcdI3fXUR9Y5a6eKSGiDnYsenT/cngOrjUqR?=
 =?us-ascii?Q?0z/wHL6mHJS4JTSa+FIx2rw7gVrJqg799idgVzPi3yY8s52oUuLPuHJWf/5E?=
 =?us-ascii?Q?oheMmBUNpdSNOyUqGQ719H+R1JKmrorfmC0dLCOMTbx9TXiwJi/PWLCBvkc+?=
 =?us-ascii?Q?PLariJE9hqXHivF7JVCMiUQKX2JhbbNbiTFmXJefiE5caZDxngfk+DT5UgBB?=
 =?us-ascii?Q?I5MAVxVqR9JiAbv6HgkOTp/eA/EdfFDvCj5YTnSQtMR6CenaDg8CzQmMcknu?=
 =?us-ascii?Q?0fB+vb3S61IiQKXb1Oxu53pNBdMfIrMJ+RzvdGiWlqh6WzxN7I/5Y6jVOtmw?=
 =?us-ascii?Q?ho24fKLaUqCpM9xd7J3nS+9usU8SsoW6JsiWFtlIisZwSyqqCghP6xALIBVw?=
 =?us-ascii?Q?YijEjn7Y6aU+aKJalSTE175KXZcpE7tZ7YXPAxYvssR5Qb3RX058OY7JqGdj?=
 =?us-ascii?Q?i7HqF12rzHzXEtOzj4Db4QF4DVMECmTyDWLemTKXgjxQ5HbCZ2eqmJPI4QqT?=
 =?us-ascii?Q?ow9i5dDuCUBcCdeESoCjS/6UiqXUvev5wjf0iV0Tg4IY8+BNfYXuZkiTb1tn?=
 =?us-ascii?Q?XUlgtalGqSYCPBsA7YJEusoJD6rcp0ZGQh0rte9PnYPzQmPkDdLcSrfukJF8?=
 =?us-ascii?Q?Ht1oY8+E0p5O8Q7+mEisMOXr/Nl7qoCCv7PFgTBVMrftGIvf31LOrGUQL3YP?=
 =?us-ascii?Q?FBaLe/Aq7rNHsvTqwm0EjxOuJhdEJBOPPlXqdq8HGY60DcmTokxlmv/mJUAP?=
 =?us-ascii?Q?D0wYE9wCZuHkFy+KccOfZmcGN75joZqI3sU4wua9zFxDhTjQP0VSGCMk4UsT?=
 =?us-ascii?Q?OOGDgKXWRkJLUVWs14IGHUJ6iQbMcn7H9P8K30YJ56L+rpPrZaWnr2m0v3G4?=
 =?us-ascii?Q?U7dOuCgSD1dlRyUv63UBcitunmkv8HZ0e87LLpsGOFv/QTn6gqZB1EiqGvP0?=
 =?us-ascii?Q?6N6GlJ9joAWCyE7ckpWraNvC0KvV4HfU14797Wq+WyAsXZqOGmi+WWBEUKos?=
 =?us-ascii?Q?71VDsBkDXSvVmHdN2Bm1lSo1jh2AiPT625K30EUBAYNiyM4XIvrUggMY/0Xa?=
 =?us-ascii?Q?GlUIg3zAtOw8yHSLq736GXE9Ym2aCx/pyukZ3Kk1/eRLpI97/l8ggylAKz2j?=
 =?us-ascii?Q?50GkRf+aUlQTICTDETyc9X5kWBf5v1lOdMaH7tGjgHuy32C2Kjyy8/1oIeMn?=
 =?us-ascii?Q?9Lo6PSgHmz0CYobqo4U1g5iFfOAO/HMppTMGRA5QxWiYs66PWcBQ0A4rf8dQ?=
 =?us-ascii?Q?dtAZRHxOwnyUApNyXiCR/EpR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55598049-6af3-451a-60c5-08d904ae6bf4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 10:15:43.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWmDxGvfeX6DsaBAsnJB+f0fb70WYHFvXPWEvinqCx6llzU3DVsB0/1aJLl1DB4XIGU2qEOSqS3kNJxHwirgoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few power domains supported by SCFW are missing.
Add them for driver users.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 69 +++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index a7589cc5ac23..446a4f9f0ec9 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -120,12 +120,17 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
 	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
 	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
-	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
+	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
 	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma2-ch", IMX_SC_R_DMA_2_CH5, 27, true, 5 },
+	{ "dma3-ch", IMX_SC_R_DMA_3_CH0, 32, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
 	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
+	{ "esai1", IMX_SC_R_ESAI_1, 1, false, 0 },
+	{ "mclk-out-0", IMX_SC_R_MCLK_OUT_0, 1, false, 0 },
+	{ "mclk-out-1", IMX_SC_R_MCLK_OUT_1, 1, false, 0 },
 	{ "spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
 	{ "spdif1", IMX_SC_R_SPDIF_1, 1, false, 0 },
 	{ "sai", IMX_SC_R_SAI_0, 3, true, 0 },
@@ -142,11 +147,13 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* DMA SS */
 	{ "can", IMX_SC_R_CAN_0, 3, true, 0 },
 	{ "ftm", IMX_SC_R_FTM_0, 2, true, 0 },
-	{ "lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
+	{ "lpi2c", IMX_SC_R_I2C_0, 5, true, 0 },
 	{ "adc", IMX_SC_R_ADC_0, 2, true, 0 },
 	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
+	{ "lcd-pll", IMX_SC_R_ELCDIF_PLL, 1, true, 0 },
 	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
-	{ "lpuart", IMX_SC_R_UART_0, 4, true, 0 },
+	{ "lpuart", IMX_SC_R_UART_0, 5, true, 0 },
+	{ "sim", IMX_SC_R_EMVSIM_0, 2, true, 0 },
 	{ "lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
 	{ "irqstr_dsp", IMX_SC_R_IRQSTR_DSP, 1, false, 0 },
 
@@ -155,13 +162,21 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
 	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
 	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false, 0 },
+	{ "vpu-enc1", IMX_SC_R_VPU_ENC_1, 1, false, 0 },
+	{ "vpu-mu0", IMX_SC_R_VPU_MU_0, 1, false, 0 },
+	{ "vpu-mu1", IMX_SC_R_VPU_MU_1, 1, false, 0 },
+	{ "vpu-mu2", IMX_SC_R_VPU_MU_2, 1, false, 0 },
 
 	/* GPU SS */
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
+	{ "gpu1-pid", IMX_SC_R_GPU_1_PID0, 4, true, 0 },
 
 	/* HSIO SS */
+	{ "pcie-a", IMX_SC_R_PCIE_A, 1, false, 0 },
+	{ "serdes-0", IMX_SC_R_SERDES_0, 1, false, 0 },
 	{ "pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
 	{ "serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
+	{ "sata-0", IMX_SC_R_SATA_0, 1, false, 0 },
 	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
 
 	/* MIPI SS */
@@ -175,13 +190,21 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 
 	/* LVDS SS */
 	{ "lvds0", IMX_SC_R_LVDS_0, 1, false, 0 },
+	{ "lvds0-pwm", IMX_SC_R_LVDS_0_PWM_0, 1, false, 0 },
+	{ "lvds0-lpi2c", IMX_SC_R_LVDS_0_I2C_0, 2, true, 0 },
 	{ "lvds1", IMX_SC_R_LVDS_1, 1, false, 0 },
+	{ "lvds1-pwm", IMX_SC_R_LVDS_1_PWM_0, 1, false, 0 },
+	{ "lvds1-lpi2c", IMX_SC_R_LVDS_1_I2C_0, 2, true, 0 },
 
 	/* DC SS */
 	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 	{ "dc0-video", IMX_SC_R_DC_0_VIDEO0, 2, true, 0 },
 
+	{ "dc1", IMX_SC_R_DC_1, 1, false, 0 },
+	{ "dc1-pll", IMX_SC_R_DC_1_PLL_0, 2, true, 0 },
+	{ "dc1-video", IMX_SC_R_DC_1_VIDEO0, 2, true, 0 },
+
 	/* CM40 SS */
 	{ "cm40-i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
 	{ "cm40-intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
@@ -196,11 +219,51 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "cm41-mu-a1", IMX_SC_R_M4_1_MU_1A, 1, false, 0},
 	{ "cm41-lpuart", IMX_SC_R_M4_1_UART, 1, false, 0},
 
+	/* CM41 SS */
+	{ "cm41_i2c", IMX_SC_R_M4_1_I2C, 1, false, 0 },
+	{ "cm41_intmux", IMX_SC_R_M4_1_INTMUX, 1, false, 0 },
+
+	/* DB SS */
+	{ "perf", IMX_SC_R_PERF, 1, false, 0},
+
 	/* IMAGE SS */
 	{ "img-jpegdec-mp", IMX_SC_R_MJPEG_DEC_MP, 1, false, 0 },
 	{ "img-jpegdec-s", IMX_SC_R_MJPEG_DEC_S0, 4, true, 0 },
 	{ "img-jpegenc-mp", IMX_SC_R_MJPEG_ENC_MP, 1, false, 0 },
 	{ "img-jpegenc-s", IMX_SC_R_MJPEG_ENC_S0, 4, true, 0 },
+	{ "img-pdma", IMX_SC_R_ISI_CH0, 8, true, 0 },
+	{ "img-csi0", IMX_SC_R_CSI_0, 1, false, 0 },
+	{ "img-csi0-i2c0", IMX_SC_R_CSI_0_I2C_0, 1, false, 0 },
+	{ "img-csi0-pwm0", IMX_SC_R_CSI_0_PWM_0, 1, false, 0 },
+	{ "img-csi1", IMX_SC_R_CSI_1, 1, false, 0 },
+	{ "img-csi1-i2c0", IMX_SC_R_CSI_1_I2C_0, 1, false, 0 },
+	{ "img-csi1-pwm0", IMX_SC_R_CSI_1_PWM_0, 1, false, 0 },
+	{ "img-parallel", IMX_SC_R_PI_0, 1, false, 0 },
+	{ "img-parallel-i2c0", IMX_SC_R_PI_0_I2C_0, 1, false, 0 },
+	{ "img-parallel-pwm", IMX_SC_R_PI_0_PWM_0, 2, true, 0 },
+	{ "img-parallel-pll", IMX_SC_R_PI_0_PLL, 1, false, 0 },
+
+	/* SECO SS */
+	{ "seco_mu", IMX_SC_R_SECO_MU_2, 3, true, 2},
+
+	/* HDMI TX SS */
+	{ "hdmi-tx", IMX_SC_R_HDMI, 1, false, 0},
+	{ "hdmi-tx-i2s", IMX_SC_R_HDMI_I2S, 1, false, 0},
+	{ "hdmi-tx-i2c0", IMX_SC_R_HDMI_I2C_0, 1, false, 0},
+	{ "hdmi-tx-pll0", IMX_SC_R_HDMI_PLL_0, 1, false, 0},
+	{ "hdmi-tx-pll1", IMX_SC_R_HDMI_PLL_1, 1, false, 0},
+
+	/* HDMI RX SS */
+	{ "hdmi-rx", IMX_SC_R_HDMI_RX, 1, false, 0},
+	{ "hdmi-rx-pwm0", IMX_SC_R_HDMI_RX_PWM_0, 1, false, 0},
+	{ "hdmi-rx-i2c0", IMX_SC_R_HDMI_RX_I2C_0, 1, false, 0},
+	{ "hdmi-rx-bypass", IMX_SC_R_HDMI_RX_BYPASS, 1, false, 0},
+
+	/* SECURITY SS */
+	{ "sec-jr", IMX_SC_R_CAAM_JR2, 2, true, 2},
+
+	/* BOARD SS */
+	{ "board", IMX_SC_R_BOARD_R0, 8, true, 0},
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.25.1


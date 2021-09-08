Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9164034F2
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 09:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348709AbhIHHMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 03:12:48 -0400
Received: from mx20.baidu.com ([111.202.115.85]:57816 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348636AbhIHHMr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:12:47 -0400
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
        by Forcepoint Email with ESMTPS id 3224E2BA1E951A9254FA;
        Wed,  8 Sep 2021 15:11:38 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:11:37 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:11:36 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Santosh Shilimkar" <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 1/2] soc: fsl: guts: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 15:11:13 +0800
Message-ID: <20210908071123.348-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908071123.348-1-caihuoqing@baidu.com>
References: <20210908071123.348-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/fsl/guts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index d5e9a5f2c087..072473a16f4d 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -140,7 +140,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	const struct fsl_soc_die_attr *soc_die;
 	const char *machine;
 	u32 svr;
@@ -152,8 +151,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
 
 	guts->little_endian = of_property_read_bool(np, "little-endian");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	guts->regs = devm_ioremap_resource(dev, res);
+	guts->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(guts->regs))
 		return PTR_ERR(guts->regs);
 
-- 
2.25.1


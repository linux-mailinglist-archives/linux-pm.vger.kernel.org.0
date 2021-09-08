Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05F24034EE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 09:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348560AbhIHHMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 03:12:45 -0400
Received: from mx21.baidu.com ([220.181.3.85]:57630 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348522AbhIHHMo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:12:44 -0400
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
        by Forcepoint Email with ESMTPS id 1004E927106F60D5A71A;
        Wed,  8 Sep 2021 15:11:35 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:11:34 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:11:33 +0800
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
Subject: [PATCH 1/2] soc: bcm: bcm-pmb: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 15:11:12 +0800
Message-ID: <20210908071123.348-2-caihuoqing@baidu.com>
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
 drivers/soc/bcm/bcm63xx/bcm-pmb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index 774465c119be..7bbe46ea5f94 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -276,7 +276,6 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct bcm_pmb_pd_data *table;
 	const struct bcm_pmb_pd_data *e;
-	struct resource *res;
 	struct bcm_pmb *pmb;
 	int max_id;
 	int err;
@@ -287,8 +286,7 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 
 	pmb->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pmb->base = devm_ioremap_resource(&pdev->dev, res);
+	pmb->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pmb->base))
 		return PTR_ERR(pmb->base);
 
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33897A8307
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfIDMfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 08:35:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfIDMfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Sep 2019 08:35:04 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 96905D15FA8A6C9EB11B;
        Wed,  4 Sep 2019 20:34:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 20:34:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <miquel.raynal@bootlin.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>, <eric@anholt.net>,
        <wahrenst@gmx.net>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <mmayer@broadcom.com>,
        <computersforpeace@gmail.com>, <gregory.0xf0@gmail.com>,
        <matthias.bgg@gmail.com>, <agross@kernel.org>, <heiko@sntech.de>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <marc.w.gonzalez@free.fr>, <mans@mansr.com>, <talel@amazon.com>,
        <jun.nie@linaro.org>, <shawnguo@kernel.org>,
        <phil@raspberrypi.org>, <yuehaibing@huawei.com>,
        <gregkh@linuxfoundation.org>, <david.hernandezsanchez@st.com>,
        <horms+renesas@verge.net.au>, <wsa+renesas@sang-engineering.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH -next 13/15] thermal: thermal_mmio: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 20:29:37 +0800
Message-ID: <20190904122939.23780-14-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190904122939.23780-1-yuehaibing@huawei.com>
References: <20190904122939.23780-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/thermal_mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 40524fa..1663152 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -40,7 +40,6 @@ static struct thermal_zone_of_device_ops thermal_mmio_ops = {
 
 static int thermal_mmio_probe(struct platform_device *pdev)
 {
-	struct resource *resource;
 	struct thermal_mmio *sensor;
 	int (*sensor_init_func)(struct platform_device *pdev,
 				struct thermal_mmio *sensor);
@@ -52,8 +51,7 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 	if (!sensor)
 		return -ENOMEM;
 
-	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
+	sensor->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sensor->mmio_base)) {
 		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
 			PTR_ERR(sensor->mmio_base));
-- 
2.7.4



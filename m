Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BBC37A415
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 11:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEKJzn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 05:55:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2627 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhEKJzm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 05:55:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfYB05mV4zlc7f;
        Tue, 11 May 2021 17:52:24 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 17:54:24 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] tty: serial: sifive: Remove redundant error printing in sifive_serial_probe()
Date:   Tue, 11 May 2021 17:54:13 +0800
Message-ID: <20210511095413.4938-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When devm_ioremap_resource() fails, a clear enough error message will be
printed by its subfunction __devm_ioremap_resource(). The error
information contains the device name, failure cause, and possibly resource
information.

Therefore, remove the error printing here to simplify code and reduce the
binary size.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/tty/serial/sifive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 0ac0371f943b688..4b28b5ae72899cf 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -947,10 +947,8 @@ static int sifive_serial_probe(struct platform_device *pdev)
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(base)) {
-		dev_err(&pdev->dev, "could not acquire device memory\n");
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-- 
2.26.0.106.g9fadedd



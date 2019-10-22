Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD75BE02AE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 13:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfJVLTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 07:19:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387405AbfJVLTE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Oct 2019 07:19:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ECAF0F3047404F2B73E6;
        Tue, 22 Oct 2019 19:19:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 22 Oct 2019 19:18:53 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] power: supply: ab8500_charger: Fix wrong pointer passed to PTR_ERR()
Date:   Tue, 22 Oct 2019 11:18:56 +0000
Message-ID: <20191022111856.44118-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Fixes: 97ab78bac5d0 ("power: supply: ab8500_charger: Convert to IIO ADC")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ff2bb4411a22..8a0f9d769690 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3393,7 +3393,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		if (PTR_ERR(di->adc_main_charger_c) == -ENODEV)
 			return -EPROBE_DEFER;
 		dev_err(&pdev->dev, "failed to get ADC main charger current\n");
-		return PTR_ERR(di->adc_main_charger_v);
+		return PTR_ERR(di->adc_main_charger_c);
 	}
 	di->adc_vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
 	if (IS_ERR(di->adc_vbus_v)) {




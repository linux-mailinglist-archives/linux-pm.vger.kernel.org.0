Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE18357FE4
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhDHJtp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 05:49:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16087 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhDHJtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 05:49:45 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGGdN5Kxnz19Krq;
        Thu,  8 Apr 2021 17:47:20 +0800 (CST)
Received: from huawei.com (10.67.174.117) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 17:49:22 +0800
From:   Ruiqi Gong <gongruiqi1@huawei.com>
To:     <gongruiqi1@huawei.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     Wang Weiyang <wangweiyang2@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] thermal: bcm2835: remove redundant dev_err call in bcm2835_thermal_probe()
Date:   Thu, 8 Apr 2021 06:03:29 -0400
Message-ID: <20210408100329.7585-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 3199977f1e73..c8e4344d5a3d 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -184,7 +184,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	data->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(data->regs)) {
 		err = PTR_ERR(data->regs);
-		dev_err(&pdev->dev, "Could not get registers: %d\n", err);
 		return err;
 	}
 


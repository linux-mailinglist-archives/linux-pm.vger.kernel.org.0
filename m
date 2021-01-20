Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4B52FD425
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 16:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbhATPdE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 10:33:04 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:55002 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732346AbhATPWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 10:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=HSOMGmJKfL1rX2qIMN
        /0Rl6FIRq81VcX1sAW1LqlfqU=; b=ml/ixOdtO7GbHbx36eyL332hIBPp89v1E6
        atbEKoIpvlF3TH5EACTUDTGs1rw5EeFjDTfx/10+sD5wny+ypYUypySR8Dfu2B0R
        SyabV/PENPt6hevGgRxfytCnaaNU/NL13SiDYsj+UqbMhTZHyS7SjIVxRfO3g2n7
        QgPJAja8w=
Received: from localhost.localdomain (unknown [111.201.134.89])
        by smtp5 (Coremail) with SMTP id HdxpCgDnI1_7RQhgBWkCAw--.303S4;
        Wed, 20 Jan 2021 23:02:25 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] thermal: drop reference of child node on error
Date:   Wed, 20 Jan 2021 07:02:08 -0800
Message-Id: <20210120150208.24868-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgDnI1_7RQhgBWkCAw--.303S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43JrWfuF1rZry5urWUXFb_yoW8GF1rpF
        4j9FWIyrWUWa109a10yr1UZayqqa18tayxWr1rC3W5uas8trZ7JrWfWFyUXrWrJFZ5Ca15
        A3WDKF40van5C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1BTOUUUUU=
X-Originating-IP: [111.201.134.89]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiNgEgclWBluMj4QAAsG
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop the reference of the child node sen_child before goto out of
the loop.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/thermal/sprd_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 3682edb2f466..e843f10167b8 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -387,6 +387,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 	for_each_child_of_node(np, sen_child) {
 		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
 		if (!sen) {
+			of_node_put(sen_child);
 			ret = -ENOMEM;
 			goto disable_clk;
 		}
@@ -397,12 +398,14 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(sen_child, "reg", &sen->id);
 		if (ret) {
 			dev_err(&pdev->dev, "get sensor reg failed");
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
 		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
 		if (ret) {
 			dev_err(&pdev->dev, "efuse cal analysis failed");
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
@@ -415,6 +418,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		if (IS_ERR(sen->tzd)) {
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
+			of_node_put(sen_child);
 			ret = PTR_ERR(sen->tzd);
 			goto disable_clk;
 		}
-- 
2.17.1


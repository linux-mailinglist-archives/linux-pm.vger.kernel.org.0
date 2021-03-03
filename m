Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBC932C2F6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350316AbhCDAAJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:09 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:13204 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358536AbhCCMNu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Mar 2021 07:13:50 -0500
Received: from localhost.localdomain (unknown [222.205.72.8])
        by mail-app4 (Coremail) with SMTP id cS_KCgCXnT01fT9gGtX6AQ--.1282S4;
        Wed, 03 Mar 2021 20:12:46 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: axp20x_usb_power: Add missing check in axp20x_usb_power_probe
Date:   Wed,  3 Mar 2021 20:12:36 +0800
Message-Id: <20210303121237.15284-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgCXnT01fT9gGtX6AQ--.1282S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1fAF4rZFWUtFyfAr1kKrg_yoWDZwbEk3
        yxur9rtry8WF4jyrn0kw1fZFZYkFnrXF9rZ3WUtFs3Jw13Ka4kJr48ZrW3u345XrWUCFsx
        Zr4DXF47AFyxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUb1rW5UUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgENBlZdtSlmQgABs6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are two regmap_update_bits() calls but only one of them has
return value check, which is odd. Add a return value check and
terminate the execution flow on failure just like the other call.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/power/supply/axp20x_usb_power.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 8933ae26c3d6..7ed76eef8417 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -614,8 +614,10 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 	if (power->axp20x_id == AXP813_ID) {
 		/* Enable USB Battery Charging specification detection */
-		regmap_update_bits(axp20x->regmap, AXP288_BC_GLOBAL,
+		ret = regmap_update_bits(axp20x->regmap, AXP288_BC_GLOBAL,
 				   AXP813_BC_EN, AXP813_BC_EN);
+		if (ret)
+			return ret;
 	}
 
 	psy_cfg.of_node = pdev->dev.of_node;
-- 
2.17.1


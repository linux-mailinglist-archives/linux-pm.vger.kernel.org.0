Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D708211F57
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgGBI65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 04:58:57 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45104 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgGBI64 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Jul 2020 04:58:56 -0400
Received: from ticat.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb97Mof1ehGhOAA--.19S2;
        Thu, 02 Jul 2020 16:58:52 +0800 (CST)
From:   Peng Fan <fanpeng@loongson.cn>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH] power: supply: rt5033_battery: Fix error code in rt5033_battery_probe()
Date:   Thu,  2 Jul 2020 16:58:52 +0800
Message-Id: <1593680332-31884-1-git-send-email-fanpeng@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxb97Mof1ehGhOAA--.19S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1xZFyfZry5JrW7AF45Awb_yoW3trg_u3
        y7Wr97Ar1UuF15Kr1DC34xZFy09ryDXF4fX3WYqrnIva15WwsrArZ7Zwn8u3ZrXrW7Crs8
        CFZFqrn8AFyxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUbKZGDUUUU
X-CM-SenderInfo: xidq1vtqj6z05rqj20fqof0/
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the function rt5033_battery_probe(), it should return -ENOMEM
instead of -EINVAL when call function devm_kzalloc() failed.

Signed-off-by: Peng Fan <fanpeng@loongson.cn>
---
 drivers/power/supply/rt5033_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index d8667a9..f330452 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -125,7 +125,7 @@ static int rt5033_battery_probe(struct i2c_client *client,
 
 	battery = devm_kzalloc(&client->dev, sizeof(*battery), GFP_KERNEL);
 	if (!battery)
-		return -EINVAL;
+		return -ENOMEM;
 
 	battery->client = client;
 	battery->regmap = devm_regmap_init_i2c(client,
-- 
2.1.0


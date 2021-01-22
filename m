Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEEB2FFD02
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 07:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbhAVG72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 01:59:28 -0500
Received: from m12-14.163.com ([220.181.12.14]:60476 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbhAVG71 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 01:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XziX7
        wuqLrXqMdu6rnp1SHulJFCgoR4SCagtxXh6kW4=; b=laY1cRfbLsAM9mdQ+ZWna
        FxJsbWpDrAB7968ZB3owBF2PmGsKHe3+/f/0B3DZp0f/Ogs3KqgRWlMIhvuzUhA8
        87Fyxx0MB0u/vCLQuANe6Q693nVXMXnWf4dS3ZimpVkGK3/hEw0KvzvEhDYsPA67
        Wn3ZAqVC1UvWPn2SmZ0pco=
Received: from localhost.localdomain (unknown [119.137.55.101])
        by smtp10 (Coremail) with SMTP id DsCowADHzRmRcwpgUzMehQ--.47632S2;
        Fri, 22 Jan 2021 14:41:22 +0800 (CST)
From:   xinjian <xinjian34324@163.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xinjian <xinjian@yulong.com>
Subject: [PATCH] power: supply: bq25980: Fix repetive bq25975 with bq25960
Date:   Fri, 22 Jan 2021 14:40:52 +0800
Message-Id: <20210122064052.40880-1-xinjian34324@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowADHzRmRcwpgUzMehQ--.47632S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry5Jr1UXw4Dur18Jw18Zrb_yoW3urg_C3
        yjqa4xZrW5ur1Svw4qgw4xXFy0yFyxuFyfCF4vqr1aya47Wrn0k347Wryjy3W5WF1FkFs0
        qas5WF4qyFy8AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8D73DUUUUU==
X-Originating-IP: [119.137.55.101]
X-CM-SenderInfo: x0lqyxtdqtkjisu6il2tof0z/xtbCBgoiCF3I0fKwJwAAsH
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: xinjian <xinjian@yulong.com>

The i2c_device_id bq25975 is repeated, and should be bq25960.

Signed-off-by: xinjian <xinjian@yulong.com>
---
 drivers/power/supply/bq25980_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index c936f311eb4f..530ff4025b31 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1285,7 +1285,7 @@ static int bq25980_probe(struct i2c_client *client,
 static const struct i2c_device_id bq25980_i2c_ids[] = {
 	{ "bq25980", BQ25980 },
 	{ "bq25975", BQ25975 },
-	{ "bq25975", BQ25975 },
+	{ "bq25960", BQ25960 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq25980_i2c_ids);
-- 
2.25.1



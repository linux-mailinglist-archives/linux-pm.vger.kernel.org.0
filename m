Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F8A1387A1
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2020 19:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgALSJ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 13:09:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40130 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgALSJ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 13:09:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so3581204pgt.7;
        Sun, 12 Jan 2020 10:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YFlf1XFp+d/uDi+uNrIPUk2Y6SDrznnoWTCo2qHOO1c=;
        b=Ga9pgm5C0iLfeWe33cE/koxxKjwfcNFvrEKZf0Ky9E+MhCXRIhF55ivsqpgOWXHnO2
         svJHmJcAZKyc3wiybnfIPa9oksPPTYNxafloj1RYVq9WvoPiEl4LBvk0MKcHiUREiI2X
         5pAtar9oUyns+ELlqUCO6hfI+J6sltPPex4G1qOIIP2vCX7Lk+fvxuphQ+IZIDeWKcsQ
         TNEx44J6zuxPNdvd16G7obkCswt/HQosXzudv8rCo8d9mKp5hhHUZ0em9rsFHoJgEqq8
         iHuSHaTW/09OqWfW/VZ82DTfg8ZKYOgHTQ413qc1ohs3ZZwOoO/BM7hDZ6hRjY5tXulJ
         ee9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YFlf1XFp+d/uDi+uNrIPUk2Y6SDrznnoWTCo2qHOO1c=;
        b=jmifh1cu/KP8/qPzFz87CtalBryjG5Ih/k2wxA06g2Ba8VE/SNj3wjG8e7NYgzM1bo
         sEgRflJtizVFbtiUpehJdZ/l7sy2LPLqFiHa8Ofxek+A1BLuynDcfJnnNmCKM2+DozpB
         sufb/KF5r5ZQdFiPPhs17kaNSB2m7+BjKBpb6BtRmVFZNSg/Ag6sRa0jLGChrO9vw/Qe
         9hRkyuAzEWALX0i8UWpISZkv9nQVH0USDVFk2wKNifT/Vz+p3sA3K5bqxCsBEOkfR2Yg
         fItSIIpQDYsWuiKc5vtRYKaaSXlglFQuUByWo5YG0eJPR6OQftOePlDj35n9aSNpuiCF
         uFKg==
X-Gm-Message-State: APjAAAV7fKwuJDYbdnztrjX/SxNi7uK45MZYFrz8qk8jtk79z7Dac45S
        19vpS3RWkJyO0A648+XbrhQ=
X-Google-Smtp-Source: APXvYqxEgc9wZ0mKVVT83Rm+ImBq7gb/sKaV6A45p6k4lTER/9OBierK3/qh/wcJSzfWagVHGso/og==
X-Received: by 2002:a63:234f:: with SMTP id u15mr16705116pgm.88.1578852567496;
        Sun, 12 Jan 2020 10:09:27 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id d22sm10183754pgg.52.2020.01.12.10.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jan 2020 10:09:26 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     anarsoul@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, mripard@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] thermal: sun8i: remove unused variable and unneeded macros
Date:   Sun, 12 Jan 2020 18:09:25 +0000
Message-Id: <20200112180925.23705-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cp_ft_flag variable is not used after initialization, so delete
it. After that, THS_EFUSE_CP_FT_MASK, THS_EFUSE_CP_FT_BIT and
THS_CALIBRATION_IN_FT are not needed, so delete them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 4bcde9491edb..bd7549f9ecba 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -54,9 +54,6 @@
 #define SUN50I_H6_THS_DATA_IRQ_STS(x)		BIT(x)
 
 /* millidegree celsius */
-#define THS_EFUSE_CP_FT_MASK			0x3000
-#define THS_EFUSE_CP_FT_BIT			12
-#define THS_CALIBRATION_IN_FT			1
 
 struct tsensor {
 	struct ths_device		*tmdev;
@@ -88,7 +85,6 @@ struct ths_device {
 	struct clk				*bus_clk;
 	struct clk                              *mod_clk;
 	struct tsensor				sensor[MAX_SENSOR_NUM];
-	u32					cp_ft_flag;
 };
 
 /* Temp Unit: millidegree Celsius */
@@ -244,8 +240,6 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	 * register values and this will become a calibration offset.
 	 */
 	ft_temp = (caldata[0] & FT_TEMP_MASK) * 100;
-	tmdev->cp_ft_flag = (caldata[0] & THS_EFUSE_CP_FT_MASK)
-		>> THS_EFUSE_CP_FT_BIT;
 
 	for (i = 0; i < tmdev->chip->sensor_num; i++) {
 		int sensor_reg = caldata[i + 1];
-- 
2.17.1


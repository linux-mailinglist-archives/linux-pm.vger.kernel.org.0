Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B186CB491
	for <lists+linux-pm@lfdr.de>; Tue, 28 Mar 2023 05:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjC1DK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Mar 2023 23:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC1DKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2023 23:10:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB702136
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 20:10:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y2so7022154pfw.9
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 20:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679973023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUxMnnBoBjKrP6eT7G8iGitEYRUBySq8m73f+BY/FXE=;
        b=KdHMYTZ+x9N6Y2ZHPvM5OOf1HdzpFEikBS2iQZV+B3QYXIXaprCuBPEykGaIjjMmmF
         9yBnctCbUSfOtGcS6D2OKWoLezvO0rWEsqrEsAbWMSCdVqW845rKaQWrVUDNWzkxkAVA
         NGl8Zrn5UXoCHPws2BjWSXs8FdoqXZyblqoUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679973023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUxMnnBoBjKrP6eT7G8iGitEYRUBySq8m73f+BY/FXE=;
        b=wTAVqT9GS7ILLSaXj+ODk5lF2kppOj9RkEXJtEvmg6QmXdzZmdea8Mzgu9ctETjDmw
         za37/6l/cAoqS5V6v2p1Z3AZsylgW4FqDUR8Czr8bZ3rO1qqhO/6PnRaIubcIvxjEN+S
         UgQVecketQQSCMhB4+4OfFCkkb5QdW12/vyxoNIBiY6T1zSh9v+W8UYx3rWBWdUXa09i
         mVccrTH+i4SAfUxz8644lw29m17DSB/iwO2BcUrjpKiQpaUFMkr//ehypjJ85f4Qh5v0
         ZXClgIhvxLBZY0PDUOt68hTfJRpJyWnWKYeC2vP9fQ16Y83OkYgcAQFFFS1tHSu22ldv
         8Hdg==
X-Gm-Message-State: AAQBX9c++BkuhOKVh0vB3Ueo95QxvfdegnBZvhBowc7feCZrzAPpZaGO
        ZxGYIbwCsfWnea2Cq7c437D+SA==
X-Google-Smtp-Source: AKy350bC0L1BKVrEfalM7Kp5nZEIaRUuRJee1hKp+ImAy2irYV3TzoJlLwy5gM6RcRC6DEXB1+GhuA==
X-Received: by 2002:a62:198a:0:b0:626:f692:5b1 with SMTP id 132-20020a62198a000000b00626f69205b1mr12059691pfz.22.1679973023114;
        Mon, 27 Mar 2023 20:10:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:da70:de00:9a3d:7067])
        by smtp.gmail.com with ESMTPSA id n26-20020aa78a5a000000b006260e5bdd81sm19548719pfa.45.2023.03.27.20.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:10:22 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Fix sensor 1 interrupt status bitmask
Date:   Tue, 28 Mar 2023 11:10:17 +0800
Message-Id: <20230328031017.1360976-1-wenst@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The binary representation for sensor 1 interrupt status was incorrectly
assembled, when compared to the full table given in the same comment
section. The conversion into hex was also incorrect, leading to
incorrect interrupt status bitmask for sensor 1. This would cause the
driver to incorrectly identify changes for sensor 1, when in fact it
was sensor 0, or a sensor access time out.

Fix the binary and hex representations in the comments, and the actual
bitmask macro.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ca16c90e1d55..d87d3847c7d0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -66,7 +66,7 @@
 #define LVTS_MONINT_CONF			0x9FBF7BDE
 
 #define LVTS_INT_SENSOR0			0x0009001F
-#define LVTS_INT_SENSOR1			0X000881F0
+#define LVTS_INT_SENSOR1			0x001203E0
 #define LVTS_INT_SENSOR2			0x00247C00
 #define LVTS_INT_SENSOR3			0x1FC00000
 
@@ -396,8 +396,8 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
 	 *                  => 0x1FC00000
 	 * sensor 2 interrupt: 0000 0000 0010 0100 0111 1100 0000 0000
 	 *                  => 0x00247C00
-	 * sensor 1 interrupt: 0000 0000 0001 0001 0000 0011 1110 0000
-	 *                  => 0X000881F0
+	 * sensor 1 interrupt: 0000 0000 0001 0010 0000 0011 1110 0000
+	 *                  => 0X001203E0
 	 * sensor 0 interrupt: 0000 0000 0000 1001 0000 0000 0001 1111
 	 *                  => 0x0009001F
 	 */
-- 
2.40.0.348.gf938b09366-goog


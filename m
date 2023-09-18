Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6440F7A46A5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 12:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjIRKHg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbjIRKH3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 06:07:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23E9B
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 03:07:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so2758221a12.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695031638; x=1695636438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CIzAQBDBRAbXi6odnAuwsq+At6oBbxMnuT61WOfur8=;
        b=Gh/Ts+Axe0ftgk653P1e2h0uLTcgF41Q6cvPbxwrQVAXECl1OtdliVPm86cmvNo30z
         y0sOHaMQ1TDUfyIRT0uhLxeCif5Ew1F1UCoOGqaynDc01KicnMXvBmDKl/XSOi4hJ6CX
         X+b9MXfSF+uxFVN2yP3uG1oLQgdW6t5yjH4wbWWMMeYSt6i2g+8Gzx09sNtkwQcWoVYr
         KFbYeztQfyMfU/k8oV4OzQ5hVr1ps4bPDf7ALOp8S02oG+sQcqP30s2zwT98EogeneSl
         mowzI3hrpgaZgg/qUA3MccDGpx+BNfeZ9ycKI5LpSoPMBwgxvEI92mr5swVqnu8DNj8L
         CY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695031638; x=1695636438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CIzAQBDBRAbXi6odnAuwsq+At6oBbxMnuT61WOfur8=;
        b=aKapEz1i8GiwwNe4gl9trFZMpbJID0CcFVsw6N8tiVEFV35KnNM4/QEHV2t/NVYE/T
         p9M+6jkxFIB4Wbtp5etHWYcHs3Q00NBdrAS6HXxws7zKKYZVqL5ljzM8syAuMg7wibwR
         CN4pAzlyHwnHu9WOWfH+D2/zL7M5DL1fTIv/+PNUajzEB2MCsJ3w0pTMN/TX4B/7TDwm
         hNvoi1A38PJaAodaImNddqsYOWfNvYUJmxmKQ6GHIYFp4ON8vg+Z9TwqqYUhLpk/Yza1
         h4itQwKSzPCj2x5/JLEsGzr1lOoCR6sWaf4fR6vNtZn7berQ5yAv5sg/sqENpGSP2IPK
         hlGw==
X-Gm-Message-State: AOJu0Yzsk0tQ2BCpHP8TsSp6Ngp8Gtb9mHJK+/lycm8my333W1iQcbMt
        mpSAEA7hdGXN9jU9g3HzsFmiynsdSFabYM3KUnjmYA==
X-Google-Smtp-Source: AGHT+IGidGqFde6MO6aKF0/Be311hyX6HKkzV2FNPU58Qptc75KDLExfyXA/sohTN+Ue1NGSHZDpCA==
X-Received: by 2002:a05:6402:3494:b0:531:28fd:ad10 with SMTP id v20-20020a056402349400b0053128fdad10mr1459070edc.38.1695031638376;
        Mon, 18 Sep 2023 03:07:18 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id p21-20020aa7d315000000b00522828d438csm5824096edq.7.2023.09.18.03.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:07:17 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH] thermal/drivers/mediatek: Fix probe for THERMAL_V2
Date:   Mon, 18 Sep 2023 12:07:06 +0200
Message-Id: <20230918100706.1229239-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the probe function to call mtk_thermal_release_periodic_ts for
everything != MTK_THERMAL_V1. This was accidentally changed from V1
to V2 in the original patch.

Reported-by: Frank Wunderlich <frank-w@public-files.de>
Closes: https://lore.kernel.org/lkml/B0B3775B-B8D1-4284-814F-4F41EC22F532@public-files.de/
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Closes: https://lore.kernel.org/lkml/07a569b9-e691-64ea-dd65-3b49842af33d@linaro.org/
Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 843214d30bd8..8b0edb204844 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1267,7 +1267,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	mtk_thermal_turn_on_buffer(mt, apmixed_base);
 
-	if (mt->conf->version != MTK_THERMAL_V2)
+	if (mt->conf->version != MTK_THERMAL_V1)
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 
 	if (mt->conf->version == MTK_THERMAL_V1)
-- 
2.40.1


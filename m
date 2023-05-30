Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4B716E11
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 21:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjE3Tvl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 15:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjE3Tvk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 15:51:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5D106
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 12:51:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30789a4c537so3347294f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685476296; x=1688068296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMbc7ZMxh3N33Yc+ipgSHRqfEAA1Um0qlVG11Tvtq50=;
        b=SQBjpmxhV4in/9DZqzAkeEBpua4/dKoQjL/6zGi7N6k7Qnv+gudpP6eiebLLyKWWtv
         xcYOgCaDTg9Ad6kH84wmmIvD3sSwJON2ESqPBayJ+uk49FpaAoc+m3ak7XPNUzCl/Fa/
         DPelZdwKMFeb9F8UrqQtyJyG2E5fpEElIzdROCJL2NMRSj7EDuZL8vxmaBcmn8YCdFA3
         cj80QMxxkZ6GnJ4vhksdj/6L86a/wybg48m/BNYVSNkulCNi3aVORvgK1+ftAYJytKTb
         hZWrAGW3J1UYmQzUEK+V4+e3lqyGKQ0CFdEkiX8wthmR+6XZUucxm4Q2YkX1iTpha4VD
         rQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476296; x=1688068296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMbc7ZMxh3N33Yc+ipgSHRqfEAA1Um0qlVG11Tvtq50=;
        b=Dr9y8dBNYYqAiroFb48tjQMpouZ5rA4g1/sZx4sfrUJxzPXuxTZJDl00onJjdFPs1s
         xufjPzK/JpoH520jMJdo/lW8Ux2aoG2RfNRxVY3XfOTwxVbXkH2NcVTj6ybJS+c1R15c
         Cli2/u3IfWFrwVMoTVLR4S8xyv53zUxswhuM74cqAKCyidTKI7afRPXxHIho0rei4Cxb
         O4uSq6p/DTiNrqPFwOiwbPCuVZFBubC37Up3Xmr+f4UllOSG+ew5IbKPR1Q7AXSXBxlt
         AN+5Cda3d5FR9MbrxkusP/RPZnyKf7duXw/3cRnjGB7PIvkmf/gQWeDfOMZgA4cvlFV1
         Zebw==
X-Gm-Message-State: AC+VfDxISJ9plP9FlnkD7zNeiS2D8RFHWXJXzXiys/J7VXAcqL8EIMjr
        0WEhLELUvSfnWDfGZmiwCvqnKT6YO79SfMp7f9BJ0g==
X-Google-Smtp-Source: ACHHUZ7riltF1w2kMK9/FEao5kDHEzupgwhRZfvGHIzNT/weB2JE4bnLo/0VpcWlOnNPmEC32Zpg7Q==
X-Received: by 2002:a5d:4d51:0:b0:306:2c39:5d52 with SMTP id a17-20020a5d4d51000000b003062c395d52mr2033984wru.57.1685476296347;
        Tue, 30 May 2023 12:51:36 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe34b000000b003078cd719ffsm4271545wrj.95.2023.05.30.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:51:35 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v4 1/5] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for mt8192
Date:   Tue, 30 May 2023 21:51:28 +0200
Message-ID: <20230530195132.2286163-2-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230530195132.2286163-1-bero@baylibre.com>
References: <20230530195132.2286163-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS thermal controller definition for MT8192.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../thermal/mediatek,lvts-thermal.h           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 8fa5a46675c46..5e9eb62174268 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -26,4 +26,23 @@
 #define MT8195_AP_CAM0  15
 #define MT8195_AP_CAM1  16
 
+#define MT8192_MCU_BIG_CPU0     0
+#define MT8192_MCU_BIG_CPU1     1
+#define MT8192_MCU_BIG_CPU2     2
+#define MT8192_MCU_BIG_CPU3     3
+#define MT8192_MCU_LITTLE_CPU0  4
+#define MT8192_MCU_LITTLE_CPU1  5
+#define MT8192_MCU_LITTLE_CPU2  6
+#define MT8192_MCU_LITTLE_CPU3  7
+
+#define MT8192_AP_VPU0  8
+#define MT8192_AP_VPU1  9
+#define MT8192_AP_GPU0  10
+#define MT8192_AP_GPU1  11
+#define MT8192_AP_INFRA 12
+#define MT8192_AP_CAM   13
+#define MT8192_AP_MD0   14
+#define MT8192_AP_MD1   15
+#define MT8192_AP_MD2   16
+
 #endif /* __MEDIATEK_LVTS_DT_H */
-- 
2.41.0.rc2


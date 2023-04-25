Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B6F6EE30A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Apr 2023 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjDYNbE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Apr 2023 09:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjDYNbC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2023 09:31:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64189CC29
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2023 06:30:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f18335a870so37463075e9.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2023 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682429458; x=1685021458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh4GXBQTeeN3DdxaOs5pVxlWxuVqOqd+rT6j8+6l8sE=;
        b=i5QsdqollPNfcncQQEct9tIVIBdnrKJeZc3eFnysExlh3i4xDszbMag5cktSnxtV2p
         sbuXBvzAfsOtLCIjIRQft0OEriAEzdSsneG1l/zY9VSduSznZ1RTHqBDw4d3ffPomGRm
         xBqgGeYSZZ6QJbE1svq2CFPyY48SCMdoOQ2R5/CB21o2D+LssoCHHI9P9Yt9TM6ch7Zs
         IMXhm0DmQwACXr1vQ6Pr1U6ba9QyK0oVGHLkD3y4fQ2Y2676V89e23qCg0YZWMyFATEu
         mb2WYuarZ/mpKl7FG5aYqJTZm4L+/Lpg/o0EkcM02iek47DZevrkPmPz07EiYeQFbxc5
         Pn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429458; x=1685021458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh4GXBQTeeN3DdxaOs5pVxlWxuVqOqd+rT6j8+6l8sE=;
        b=LQ1BcljiUzeclynfVYKpQi/lhwe+S+fYDeOMv6CQE+wFIhXdQ91MELQYkGe7jzPNvc
         j6l90kJdAe+Yc4Y093b8QcpmN4e6VJwuczdoeNF6DZx4smhdoEWIzo3gPL2uP0ORk1YR
         md3c525FAwMdP3SOGKNyDzcvldLDOQ0c5IiosJlC2CYSoTjHVbQV2b43x+OwDjskeGAz
         KwxJ168YUA40NE2XKtLQi2tXONuLzD+HJUtxezjI+r4OfCXjfaKQTJBM/KGTMWH1JpuA
         yDeX2OFVJJqaec7oIpiIXsxoGC5Uw3RJVLnJXHVE5Cd9na+np9z6cyavqG6gtFexGIiM
         xIRg==
X-Gm-Message-State: AAQBX9dtJum2YEViVZZmiAzlzHraGpFbAc1KH4xHvytY0O807fSO/NEA
        1M6GcJbzSKeY+Uduv1cs2IVY9g==
X-Google-Smtp-Source: AKy350ZKZyuO0Sg9TwdCmnSzf+Gqp7U+OucY+l2AQvE7H7aj7k8OrWIxVGzwl7JhuxzVDKWSWUlZwg==
X-Received: by 2002:a7b:ca47:0:b0:3f1:9acf:8670 with SMTP id m7-20020a7bca47000000b003f19acf8670mr7954690wml.22.1682429457838;
        Tue, 25 Apr 2023 06:30:57 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm18575434wmq.38.2023.04.25.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:30:57 -0700 (PDT)
From:   bchihi@baylibre.com
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
Subject: [PATCH v2 2/5] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for mt8192
Date:   Tue, 25 Apr 2023 15:30:49 +0200
Message-Id: <20230425133052.199767-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425133052.199767-1-bchihi@baylibre.com>
References: <20230425133052.199767-1-bchihi@baylibre.com>
MIME-Version: 1.0
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
2.34.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30238714E9F
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjE2QqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 12:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjE2QqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 12:46:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0FBBE
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 09:46:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so3773983a12.2
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685378771; x=1687970771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxiLnH0M50rO/qW7JX7iQtyXgKtx4AkJoJmCH1LebW4=;
        b=PibI7ffA9bBX6+x+JjrVc/w2AtIj2KQz9bHSi7VttnfkI2ZPnN5if7C07dvBLWSW2d
         weRes3Hd1QPpQcvo3POp/tvrkp2oIEdReemvYsYG9FbVbg3mldjfY3IMDDhToLEWzyAL
         yTxOybUXSpRIbqPJ5nuXrpHQHzXv/z1yDltXM9OHI/BxWELLgVTcXvUvGSSB8WnO44dB
         AOl62/fqCQkXB57zIEgAMOlXnNN4CC2SjZIKaLuiCleZqTQESdLi1DSWxGpfz8uW7qkY
         2pcQIk2OIeXZS6kstrpadwun7XKLtMaAXFewu8LlghyYhPzzI3TPkUjZVsRSuu5EB1pT
         xqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378771; x=1687970771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxiLnH0M50rO/qW7JX7iQtyXgKtx4AkJoJmCH1LebW4=;
        b=GU8I/P2214t3nFRt2naJUmwiLcDhOMKptTwPuFBu8TejB2QFl4XyMIitgTWO2LHua/
         s6jYIdN3WHALIRYkYEPB34BdYSO/dPj51dDAI9htICMGCLK7swFFtDbnQP+2oPLpvmr4
         sctoU64YS1MItA4+Tc331xV8Z2aXmGRRu9ita2K1/kI9MT0tcWh2hHKqKCO3sHxPL8iV
         LEuJThdJtWh1zXiLiiQ0Ld47+aolZYeXrgOFoluGAa6gQZ2UMqZZAUnKg5vlBzLDNMEq
         H8kM4GFd7jCNTZVKflaWP6yYUlqFbg6rCYvtsFja6DmObObDX2FKiDykZi4MjiZGNvju
         9NOw==
X-Gm-Message-State: AC+VfDzcF4Dr5u/MAYB7BIS2rjS2f0wWMAuqUDGDM3ZX2IUj3UqM2bvk
        Ec5Do6OHjLyi1U6xB+Grr0hEMlTMmtRqgGiqJqXptA==
X-Google-Smtp-Source: ACHHUZ5gNCbXtMLfCqjRJ0nH0WPEiGrvsb5IpPrrSsXe98TatjsMehNONAcxpuek1O7918b3E4G+Kg==
X-Received: by 2002:aa7:c317:0:b0:514:a0a7:7e7f with SMTP id l23-20020aa7c317000000b00514a0a77e7fmr223165edq.2.1685378771160;
        Mon, 29 May 2023 09:46:11 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f4-20020aa7d844000000b0050d89daaa70sm3248578eds.2.2023.05.29.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:46:10 -0700 (PDT)
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
Subject: [PATCH v3 1/5] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for mt8192
Date:   Mon, 29 May 2023 18:46:01 +0200
Message-ID: <20230529164605.3552619-2-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230529164605.3552619-1-bero@baylibre.com>
References: <20230529164605.3552619-1-bero@baylibre.com>
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


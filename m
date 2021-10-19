Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF7433267
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 11:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhJSJin (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhJSJil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 05:38:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00242C061749
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso2413335wms.5
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJsCWcU0YdDyrwMeRQ7adfzbBn9rJ1IRoawBpqp6LUY=;
        b=a4CDa4TY8RYsyf7Ov/rhPNU9JCjBEheWYFGjZ6M0fICmzqhK5+vkmDMKU/YI/iPSAe
         dhQdYbJ5sngCM+Yg0WcU+C1SnMh7BBiM7XI8Y4zFepF/ek5KXIV2uFha4YAd+n89I4fd
         hAkiABx3Q3nVhuCHGuvvTldrFhel/udGiW5h33GXk4Vh/NmEIOUMeZoSOcRPSnEzHhpr
         e9nRg3t/1KKxaflSVB4zdNl6a8RS7Tbp6DaHUriiI7T1AZQyW5+F/y4xjmzQzqE1yjxP
         0zfmI8Wwr3FkiwXL37JohYx0k0eXxdkKvxEHEnvohFXM52RGPKtwcu5WjB0TK3fouwbs
         5wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJsCWcU0YdDyrwMeRQ7adfzbBn9rJ1IRoawBpqp6LUY=;
        b=om61uTgWQKjIQ/a4C6azvIwj583CkoKKYmhWnNXSfaBYhtW1aWbgAnbwk+moT2nNsT
         WQ3Qe+vhcDQXFXh8ssPGk+PQ8YfURMKxQVbOFwBCcThd5MO1ZfcjKTe9poutI43GeN/y
         Pi8NplrDw75LDTfl8cC7YpU7dGZGgDWNQi1qi4EJSl2+USvLbizAlbbKZWeLSqKzf/w+
         oIlwILzdbU32YRt94dwct8SgRvox51+dztiBFswQ8rq6649ZqB/txNxKT4LSeZV14nVZ
         1v1gaDVbfKO5Ab6BsyLAc4d5BZs2nq/2ZTVrlqt4JLenxgU1labOC00XcHmf5BuI3BYu
         vPYQ==
X-Gm-Message-State: AOAM532gOoZ8WN6ZnG0qGyAmvBEpDvOj+9S0f4CXXRfmW6VKRjlTHIOi
        dRtqCUqgsf06WWhekP+mLgTQyQ==
X-Google-Smtp-Source: ABdhPJzhrEXmzMbsOs77lioFuMQGNrVk6F0Mecc/zs/NbpM2tEsMZAwoONXUBlPSFvrPfNoD8x+fiA==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr4821476wmb.37.1634636187595;
        Tue, 19 Oct 2021 02:36:27 -0700 (PDT)
Received: from blmsp.lan ([2a02:2454:3e6:c900:5142:5fbb:5821:5dc3])
        by smtp.gmail.com with ESMTPSA id o23sm1765765wms.18.2021.10.19.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:36:27 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 1/4] dt-bindings: thermal: mediatek: Add mt8365
Date:   Tue, 19 Oct 2021 11:34:01 +0200
Message-Id: <20211019093404.1913357-2-msp@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019093404.1913357-1-msp@baylibre.com>
References: <20211019093404.1913357-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This unit is present on the mt8365 SoC as well. But there is a
difference in the usage of an apmixed register.

This patch adds a distinct mt8365 to the list of compatibles.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 5c7e7bdd029a..ba4ebffeade4 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -14,6 +14,7 @@ Required properties:
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
   - "mediatek,mt7622-thermal" : For MT7622 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
+  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
   - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
-- 
2.33.0


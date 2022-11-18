Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2218262F32F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Nov 2022 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiKRLE4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Nov 2022 06:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbiKRLEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2022 06:04:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6114899E86
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 03:04:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so3277752wma.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 03:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBJERhtOth+rBeLxVgFfkJsarNx9GtznV7fQ6VC3SrY=;
        b=vvdRx4XhO7STmF3ODXXs9rwYg2sCM9Fbli4LCPgXKFyjJe8pMcz+dyzPGZzvn67Yk8
         0Na7a9HlLh9G5bnvBX7jfnE6BlcjIgQzODOm7EvmKfOfmwMDXTYlUDWLHHrze0GMO6bo
         tDwRXzapE4HZWUu0nLh0M4J5sDZfXHI+6u0aoVrkeaarympPczI5z6sajFhWBk+RZwT0
         hwvixXzgkettkfYltivaVdJ+8X25LCTHQoVTNMUi8CkCYRiv3e4ioHqGPeVvzw042Sii
         cVsWm3Z2HiKFx9UiZ+V/il7ikboqZB2yg2Og2zVTGt23R/grQuR8WVeZ1yq9rqctmVkb
         P1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBJERhtOth+rBeLxVgFfkJsarNx9GtznV7fQ6VC3SrY=;
        b=kC+LRdHmbp9V1YnKA4WfCA4p1TI6HgKFfa1Q9JMOI9VVAj3UkIuHXXIllO+vdlEfyV
         LHaYOjOwXmba2xeObJST78KAQU4xmk0lriV+SN0+TNgolAzdhjWj4LbtYerNtsWEsWHa
         /Z/SVf32A+2DiuS7I3f2EwRBdv/K1h/E0dazaDywNAMux2bmkXW8pBed0pln9PiBwH8i
         EnYvB9u93F4iD3sHnaEb5uAzC1U/h2O9K/YhShr7My6zZMD1/4ErHJCQxgGV3/ePOoZg
         yFgTy+RG+D/zqFGpxGXA7E6evO3FXXJGKS3UxKkudH7VupKIG6HZOQD6/9EF0G0W31YG
         wWhw==
X-Gm-Message-State: ANoB5pnvVCNOz+yt6WnBfPWT3YM6jFsIR3AUsSJSBaOL/EgFuptfY57S
        tHb0aHP7TFvUeDwpdx9lReXQHg==
X-Google-Smtp-Source: AA0mqf41qGV0bEND0GwPSMQhFkrT1VnGlLZtWZn2lyPUA5nTaZUlKkh7q3SAfsl6Dc+JAGpnk4/4Gw==
X-Received: by 2002:a05:600c:1e0f:b0:3cf:e9a4:3261 with SMTP id ay15-20020a05600c1e0f00b003cfe9a43261mr8273759wmb.41.1668769483874;
        Fri, 18 Nov 2022 03:04:43 -0800 (PST)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id i14-20020adff30e000000b002368a6deaf8sm3316948wro.57.2022.11.18.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:04:43 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 18 Nov 2022 12:04:27 +0100
Subject: [PATCH v7 1/4] dt-bindings: thermal: mediatek: add binding documentation for
 MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-up-i350-thermal-bringup-v7-1-ebf08ff2eddb@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michael Kao <michael.kao@mediatek.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668769481; l=1269;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=fY1CncUk6oCKZLxDY+iXmY9IFHJPxuBaTQTmU142aZo=;
 b=Oqt0uOOMB8WLDgzdVBOKBcnTWdGXbWz+ipYlESQz5dRiUdvgrn/7hHmra43XQrdY49ee/m/RuMPb
 tUHkhzfMA8azF4mWIrudIIRQqMDPrbMJ5OHNnqlI88SliBqaaPis
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add the binding documentation for the thermal support on MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
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
b4 0.10.1

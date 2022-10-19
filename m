Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948D0604952
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 16:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJSOeS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 10:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiJSOdp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 10:33:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE27141385
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:18:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u10so29399960wrq.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBJERhtOth+rBeLxVgFfkJsarNx9GtznV7fQ6VC3SrY=;
        b=JPvOjOjxdsNpbrCQHBqtoxywW6mWGG18opKEyaUSu6nFu34JNAixSJZTiggazyIuKO
         JpmcgtX5p4jP8v//2TP3u5gQ/PpIn0q64X6IP/dI8atpdOuf1R60J7ZYAIKBOyQuX8Tp
         t+HBBuhQi8gMLHjILayvZyWQ3+KRCt8wR3CxnmoU/QsFSVbQo+U856lECGsknFYLU/B+
         LW6RYt6WS+9TCjP7HqLvjxskkLe5oxGU6dQbmxni8gnZ6S4KwTrd5mehV010ElybwUwy
         pUOYWISU4Y3sEicdmgzg2uLd2tY8l7onGpVZXwZYxg5NiXnuR6RRLpArgKW1GsQS6VnP
         nXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBJERhtOth+rBeLxVgFfkJsarNx9GtznV7fQ6VC3SrY=;
        b=kYGHC+Rzzamh8UavGSgWwFrqBwqcJVrphpb6ls7hj1cXF8zQ/6d+83TlfwAtvsTY5j
         +OxPFOxTQN1DeSvjmU3tVtv68FMTDy+AH5QPUFuR8axx70yZcVATIgSPO8o+NFJhBSPH
         NHHsMAQpxJc3cX/+UODEKWh8tqMpJXYXTcuACRJmj9GNQ0Fnj2DoUToMKLPT1VvF8ELO
         VY8lTNmadDyJJKY1wE2fi80z1mZtwIX6tAOhE/2G7PHOPTnHd4Cman30y1vh39kFoT5V
         VYvrJ/WbRPvJLnHdCGsvox5xXxttasSrPJ7J7iJ1Lk9ohuwcwQauYkr1Fmnide7XpoAG
         8vNw==
X-Gm-Message-State: ACrzQf2Rptb7XoiExuaeSl91tZWtn0xs/YgViC/omN0vqxSlwl28NvbS
        +NM74yYYbLZ1O5O+LO+gFUq5qNNfcb93Gw==
X-Google-Smtp-Source: AMsMyM48WaZ/8SPoMcLucOsUO+1QzG7wrI5cbSiVKHWebZnaFwP8u3LfGv904PwKI8eTR2zF+60r1w==
X-Received: by 2002:a5d:6dca:0:b0:22c:c6f9:57d2 with SMTP id d10-20020a5d6dca000000b0022cc6f957d2mr5371565wrz.474.1666189078381;
        Wed, 19 Oct 2022 07:17:58 -0700 (PDT)
Received: from [127.0.1.1] (rtr.23.90.200.126.unyc.it. [23.90.200.126])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05600c3b8900b003b4ff30e566sm2126577wms.3.2022.10.19.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:17:58 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 19 Oct 2022 16:17:54 +0200
Subject: [PATCH v6 1/4] dt-bindings: thermal: mediatek: add binding documentation for
 MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-up-i350-thermal-bringup-v6-1-c87b9f75550b@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v6-0-c87b9f75550b@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v6-0-c87b9f75550b@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666189076; l=1269;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=fY1CncUk6oCKZLxDY+iXmY9IFHJPxuBaTQTmU142aZo=;
 b=VpCgMgtCTDppg8K0f+sJTcN7+zAUVonGGeuj6re/jwiuSI8UCWEnobcpOClxnqKzEtedrcwYytlg
 NT5c/aJOAQVmTuTWyPBVC6p0MeUuhkYPArkdPlkRIaipl/4eODXq
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

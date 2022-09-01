Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C95A9939
	for <lists+linux-pm@lfdr.de>; Thu,  1 Sep 2022 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiIANl4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Sep 2022 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiIANl0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2022 09:41:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2B356C5
        for <linux-pm@vger.kernel.org>; Thu,  1 Sep 2022 06:40:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w5so6238617wrn.12
        for <linux-pm@vger.kernel.org>; Thu, 01 Sep 2022 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KCPcoUB7YiwSSscJBnh3JUInbmnv/uLJ/66Lvn6Y6Yk=;
        b=DWof82jkuxZ3n6qKS1EJKURTcSwcpmtxTYMAj/vYMQobBAxY2dZV1YyE7wyJpx2g2E
         2LKkmPmH9KHkSJ+JUqRatHWEGRzoCsS89jQe5VGzGWBHD4UPkFPrdnI154eRSDMPDSMP
         4F9Q0rmuAkQyRzb2LsOFyCXFa7JDTVvy6wEnlKGxMfrz1TiArI1xgnjCCix7ognj6S+y
         l/B14A4qUpHABLSuQ8hILmqGLFcQeWlUT+kqx1bxS+qIyg3ANii4YB40pSAezoOLLqs6
         TYWYGehFj+25Tgv99GVaRebUxsWdI/W2TfKTuA+TFQPgvNuDqnt3j411E7ow6099AUnt
         Blkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KCPcoUB7YiwSSscJBnh3JUInbmnv/uLJ/66Lvn6Y6Yk=;
        b=0nTzgVqXxgYhZKXZe/RJHRqtumHHDUUMVl7orMQrrw5rSBJd8x79DYymSY34y99qYF
         HtZL3p0XiYfJk2NpImbrw64uvYYIHkW7Mwl7hVpRbeaI05Lk2Xf0AAnmxNv7D3ls7hug
         tAIzb7ZTy3/dxJ3CVpzgm09ixfkFkFnCiSy7352h4LAGIsUDT17MaBYHhZBAXHjeYe2I
         VpYlyG14lEVnLLK5dKYpNUtqANbPhMhx9D2eMeTDb7yLFcNvmeEGQbpcukvzpkEhkRXd
         kYZ8jn3D+BjTVrWZkHLqmvzL6nM8+OStbFZk6Q4OR0+qKl8THfAWm0IQfy6LCvlrfesx
         xYOA==
X-Gm-Message-State: ACgBeo1sHPvQ8wN8FAHzPMmq8bV2DLT76VlHEeU/g4qDWUsFAUGZOJoQ
        xd2pn28yz1n/ONlIBboyk9yaxA==
X-Google-Smtp-Source: AA6agR55XF5dbEcnTiR/UclqwGBi/5TuoAKQ/vTJ0Bk12CiomfceiUFfMs0rxZEZ/oAupen1Fx/ltg==
X-Received: by 2002:a05:6000:1374:b0:226:93af:9c26 with SMTP id q20-20020a056000137400b0022693af9c26mr13887160wrz.188.1662039602954;
        Thu, 01 Sep 2022 06:40:02 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id e3-20020adfe383000000b0021ef34124ebsm15399016wrm.11.2022.09.01.06.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:40:02 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     Fabien Parent <fparent@baylibre.com>, rafael@kernel.org,
        amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 1/4] dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
Date:   Thu,  1 Sep 2022 15:39:47 +0200
Message-Id: <20220901133950.115122-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220901133950.115122-1-aouledameur@baylibre.com>
References: <20220901133950.115122-1-aouledameur@baylibre.com>
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

From: Fabien Parent <fparent@baylibre.com>

Add the binding documentation for the thermal support on MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.37.3


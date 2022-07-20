Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8924457BD96
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiGTSTm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiGTSTi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 14:19:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00C26B26D
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 11:19:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a5so27251129wrx.12
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZaKDRIi1mwiob1WvFjjM3OHDQMYuXFWnH3kW9ZW5SAg=;
        b=PsYMIxchceuMbJ1CYX1Lrbh35TmnoRKSEf1vIjaTvY/UZvH3gBMGBuouo7S69kLVgm
         nSNPnSdFJWxJkJxc9dI9j4SMPOljPPgIyvOHlFHurFBpVhbP/jxmO58faQftUEr3lR4m
         LqkenqpuNZhMsXjBngfX4hGQN96QLqmCyufF4rN7VV8bn+98z49tnqB3Xd0dDMVvDNBz
         wf600N0N1bL/1Kq5XZeQ0nlnP6OEEb2BMg9uq3rJDKqqF+kDSWya2YpU+xvSvjrD7YV5
         WjwHWdE3T0pPMx+lfoosC2NrEAkSaAHhVhOrje7/m2eO9/AUEfQ78yACHHQyshF926tl
         QG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZaKDRIi1mwiob1WvFjjM3OHDQMYuXFWnH3kW9ZW5SAg=;
        b=qnMzPWRFvF3lKTG7KXiY/1WB6LDczti6pCYcrj5Ig4Gi+2jqMQ76IxOsmQw3jwVJgG
         TPaLC8NXaHwzMth3td9Z6iMy3T48wtDgM+7u3I1uKvBVPYGlBAOQSNx2mAO9OjKrvT3s
         e1tcvIYaQd/bvxN5OxeWP1Gp6i3va8/10FYUwDNAWdzNJA8yxuJkkQMeLEK+0Jz6EQn/
         pT+lFG3c2uZSB97CgFmAtlV7BmeD6HoIvHENXIHrvZ3UB+i8xHCe/3w+vZ+Lo8fbLVbh
         ERupwDN4pvQQGWpKeJjGr+E3O21hZSJpSneLQdDmkKAkngr9NX770k6HMCykP1puxt80
         MGFg==
X-Gm-Message-State: AJIora9tXxOFQ02yiSiUeRTFsbrXtRrQmKGKhh0+q/TKNvmWAJGEUvcP
        zO4/mCnYEQmivBz+nRToicm22Q==
X-Google-Smtp-Source: AGRyM1vjGU1aqaq3plo8ZMZ8Ne3fvGE9Cpnovf6zPJ/qO2LpFTeedX0ODd747EfnXKB+paAVbEXf8Q==
X-Received: by 2002:a5d:4b51:0:b0:21e:504a:b597 with SMTP id w17-20020a5d4b51000000b0021e504ab597mr1221393wrs.175.1658341175489;
        Wed, 20 Jul 2022 11:19:35 -0700 (PDT)
Received: from amjad-ThinkPad-T490.home (2a01cb040613180084408ac44a1fa242.ipv6.abo.wanadoo.fr. [2a01:cb04:613:1800:8440:8ac4:4a1f:a242])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003a31d200a7dsm3400093wmp.9.2022.07.20.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:19:34 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH v2 1/4] dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
Date:   Wed, 20 Jul 2022 20:18:51 +0200
Message-Id: <20220720181854.547881-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220720181854.547881-1-aouledameur@baylibre.com>
References: <20220720181854.547881-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
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
2.37.1


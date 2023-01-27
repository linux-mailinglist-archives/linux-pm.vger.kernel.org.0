Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1604967E9E2
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjA0Pps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Jan 2023 10:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjA0Pph (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2023 10:45:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C80984FB4
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 07:45:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso3773881wms.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPsz6CoLNjPAxyd2ASpUS9AhmaiVkC3z8HgK93csZ1U=;
        b=0naiJqR3CXP1CSUH1JQR7KqPG5pckDblSfUbPNiY67L+/CLsqv4wi5V5lnThoQnQfl
         XBC9cwMNuPjcBILcxSYXsUZqO9BE9yCR+xJTVP4s/uQnxBlrR2Pr8EuZ6r4G4RbpAur5
         fLaMjFycUMucwjXPSWBteTfKo2O7UPlo5UnMzfZRccczYDKBW7lwXcpvQoooB9qX9cjY
         D/Wt7zpopMVtACqOu/iwYdKALBWTYIdAamnjV1/C4XrzUr+jGYs8W6BG6YjXMwmbukX1
         Wn1lkzevcAlX5ax3PXci1dCalYpVZi9obzdYHx850/weXQ5a2jdpRJfni0sUdxt1bsEU
         4nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPsz6CoLNjPAxyd2ASpUS9AhmaiVkC3z8HgK93csZ1U=;
        b=N+SQtFd7Hhg/85GRUTwIwIFPFRlPt8tEcsoeF6zudaN7bCcoeyK194568QEh3LreX/
         O5KMzD6+/kla4BRWAUhzraSYRClnGYmSIJjDuWpiV3EgkVbDJJHGHCGHutl1to2zlplu
         Lg/4hHo+d5d1b9pk71uT4bQbgSmKH9pypqtO+eqkSuZxyj6fnKWZFsHI6IFfgfI6iS5r
         7pFyNSxXzJ6R3SdtMsF+ifXavtTR5XG2KmsDNj8RQDuun2EIx0D3gc+eEkjIMj6kK2wm
         Echy1xW6wZeU4ZSp01dnM40wHxZ6PP1zoDBuQd1XQ4guOl/z1Fsn9we6ZBagg/45KKMe
         600Q==
X-Gm-Message-State: AFqh2kqS9+xAiR+3YisqmuNvpt2SZboRoMALwKx14FJFjOP2JgTaNc0q
        dQDG/IN3eGjdiQeOTuSdNhl5CA==
X-Google-Smtp-Source: AMrXdXsg6RnczMKZuJgcZwxUHpUG3sqVBTrRPEnjW9UFwbQg6oRXkOpof410jj6/R6m59blyvzTJ5A==
X-Received: by 2002:a05:600c:3b83:b0:3d9:f758:e280 with SMTP id n3-20020a05600c3b8300b003d9f758e280mr41502552wms.24.1674834315495;
        Fri, 27 Jan 2023 07:45:15 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm4381153wrp.53.2023.01.27.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:45:15 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 27 Jan 2023 16:44:42 +0100
Subject: [PATCH v9 1/5] dt-bindings: thermal: mediatek: add binding
 documentation for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-up-i350-thermal-bringup-v9-1-55a1ae14af74@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Michael Kao <michael.kao@mediatek.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674834313; l=1282;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=C4Y1Pt62EoG+4OlWvlrEg4v27fXBsImkQVLZNvvWkNY=;
 b=p84J/BeWtHAWzJ/Wpyo21Fc9gYwpI3/1DIJKFge6sSwRcon816f95HVnjLyZsd4fyWILpsQ8U34m
 FjtNhucEBTBh/OBALocVjgieplh21yx7IezruVT933+1fiowOTEA
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
index 38b32bb447e3..ac39c7156fde 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -16,6 +16,7 @@ Required properties:
   - "mediatek,mt7981-thermal", "mediatek,mt7986-thermal" : For MT7981 SoC
   - "mediatek,mt7986-thermal" : For MT7986 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
+  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
   - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller

-- 
2.39.1

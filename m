Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5443860494B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJSOeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJSOdb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 10:33:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7901EC523
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:18:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so104004wmr.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=tgE0FLvM8ucDhQ/XFC4TsW1lQP/cE6WWYc/1CEGZeM4=;
        b=5/SwuTkh9AuZjgBO2c/82wyMw/fr7W8mDdVmMEiV+XWpKq8UWeBWJcheHnJ+jJ5ZxB
         HUML7tRazDOcItLtuJNRnh695/rDKb7B650uXDhDJXiTZe+DS+Da8V35L5Zfj1r2LRoi
         QsKBZ76KN9NTva8BGtSPwv3AZebtftYk8CPzTlkFmUYPKJeeRH7A91IdWISOtzFxYn/Q
         C5ZD6HgOOGoBisWECtKGC41QwksD8IdccHA4di+pqz14N0rjGgCWpyRtImrXdHE6hxXO
         o9N8MsNpiImXFThoRN7zIvOoeIHlQuL45PQ+URY4DBhQZc8uDU9Yj3QqIDUuF55GYs4i
         7VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgE0FLvM8ucDhQ/XFC4TsW1lQP/cE6WWYc/1CEGZeM4=;
        b=VsDMOE+CuPEFcD3vqU1cYKj4AxVL2OaPhSkSGRE709/A90af2ceixa/H4c9yHmYFDM
         XYco8zr1fxQWmShOi83+A/MHxp+Bw7QndwW0TizZCcNFgreCy/N3+vqGAHQfgDVtZCd1
         ZbsNcWE5rZD4ESd9ek3zYpq9d82Xf84o89pAF2i6kU4+sJV+OMHUMRFuj7fYS/t8O8Z8
         I8k8ROX1ScVirYls17TNywGCO3eN4/WqNnrv9aO79+BsC1nU3xwZbvLWVSxiD3sQINM1
         YjnwYyP0FCqQjiuzxEkMzjlLSk09jmGNsuglE34h8UGW9NkopfyvKB/Ni0M8m/g+gMWi
         fGAA==
X-Gm-Message-State: ACrzQf0jDN9zGpfDBOEzDBvXX0VLKkERYn5DCKmud3mabfkGCjWm5LkV
        RzqiUkeW/fA/EA+QSSERilcI1Q==
X-Google-Smtp-Source: AMsMyM41t4ieHvPEMZSwVTSTH/SaFUbZSisbnlHXyyDLRTf2X+rqyNcpCqzj4pDtpvuqYWysDO8SYw==
X-Received: by 2002:a05:600c:3b88:b0:3c6:cef8:8465 with SMTP id n8-20020a05600c3b8800b003c6cef88465mr26386904wms.64.1666189077476;
        Wed, 19 Oct 2022 07:17:57 -0700 (PDT)
Received: from [127.0.1.1] (rtr.23.90.200.126.unyc.it. [23.90.200.126])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05600c3b8900b003b4ff30e566sm2126577wms.3.2022.10.19.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:17:57 -0700 (PDT)
Subject: [PATCH v6 0/4] thermal: mediatek: Add support for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIABEHUGMC/w2LQQqEMAwAvyI5G6gtVtnfRBttoMal1b2If98cZ4Z5oHEVbvDpHqj8kyanGsS+gz
 WT7oySjME77wc3zHh/UcLo8MpcDyq4VNHdJKUwxxQmN8YN7F6osUXSNduvdynv+wdpzSLpbgAAAA==
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 19 Oct 2022 16:17:53 +0200
Message-Id: <20221018-up-i350-thermal-bringup-v6-0-c87b9f75550b@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666189076; l=936;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=AkQkB8ukw3UxEfgonly6hxwIDLwEx/thToGWUZdxIJE=;
 b=SUWFXCNucodISbrUskCDh0YoTCsogZWud3XzdBli3zQmimygHWg70FPtlIqqm07DyoyO9egxtzMa
 qhul2jb6A/7tt607LQkz4h/HD6jC5iu8Fis6htcIgDiP2uTf8nru
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

This patchset adds thermal support for MT8365 SoC which contains three
thermal sensors.

Changes in V6:
- rebased on thermal/linux-next

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
Amjad Ouled-Ameur (1):
      thermal: mediatek: add another get_temp ops for thermal sensors

Fabien Parent (2):
      dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
      thermal: mediatek: add support for MT8365 SoC

Markus Schneider-Pargmann (1):
      thermal: mediatek: control buffer enablement tweaks

 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 drivers/thermal/mtk_thermal.c                      | 197 +++++++++++++++++----
 2 files changed, 166 insertions(+), 32 deletions(-)
---
base-commit: 68c0c5a5d991b6633e2b2d3c55713d123113fb60
change-id: 20221018-up-i350-thermal-bringup-ad386d37056f

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>

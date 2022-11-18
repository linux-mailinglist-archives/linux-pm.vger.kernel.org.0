Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE7F62F32E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Nov 2022 12:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiKRLEw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Nov 2022 06:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiKRLEu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2022 06:04:50 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF698259
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 03:04:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r126-20020a1c4484000000b003cffd336e24so2568634wma.4
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=W5utuasYQCY2PHwGIWNvE6GgspjSjL4TUNPHSyHes/I=;
        b=rSp9wAeTTAd+4EW6fNzgLlHHLU+EUHjuaCW7QbiIc2imX1FEIYxAES8RXClaTTvszF
         W8YsZh4otqH2pIO/hYL8a9lO0CzpX76WgvRaP99NHKhQPMvWn26pyWvD3xYNoNfDbUqL
         BtVrBxGY06h/2Yywyu7E8uHCdbLTDMkhLrMfhId2OnRzAcnS8g7Ryw0TpXqxWAWKSUrE
         +lcxoiJKVtwx8on9X8mrNfx0dheTs1cYexAJ991Y24BajwzMQkfXuH8zT6MmW+zSrG44
         /1MM9wk07INizSU6dquUIgv1gCP0YliHX2OABjs34fgun6+YPuQXbL9GXvuboPXqRqJB
         1bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5utuasYQCY2PHwGIWNvE6GgspjSjL4TUNPHSyHes/I=;
        b=DzUC1ADeZrwUDzo5uqPFjmC/vsZm4rBGXksSxHnygYyOmuOIiTkFXmIijR2uaqydXt
         Xs4AfMlYlxzaTFpJJghuhJCHbMYFbpvocHAbWRJFzKozHasynYagwYq6UTgKvqfi29F5
         CI6arqTTGo1stZpK+cDXH2baQ+DGuohLEMKYhIv4vXEUUTRgdsIB75inXbqx2VG41onN
         BhUrwseHRM1HPneSspNGBtCP+rtXQLQU4sgrNJ5vdSwttU8mNdzRoC55kTPYQbtoWBo8
         AMpYlrUvOHcugSBTky9k2aNTc0IAuFZ+zo5OCW53nO5Occ0Qko+jDQq78d+OaBidpVZw
         c6jg==
X-Gm-Message-State: ANoB5plVr93g05wwXdIobX2KQS2ejsxZVCNh22VM3FAnCuS6q8WK+eAU
        z8sKgtUYqeY1QTAOTfaoRWJGBQ==
X-Google-Smtp-Source: AA0mqf7vxiK6P3WffMyqgJ/8O3L40bk6P5sB2XrwVhiaTgxXC7+NTxtdHsFvSQzKB4yODDsSh9V93g==
X-Received: by 2002:a05:600c:2241:b0:3cf:9ced:dce4 with SMTP id a1-20020a05600c224100b003cf9ceddce4mr4440637wmm.120.1668769482928;
        Fri, 18 Nov 2022 03:04:42 -0800 (PST)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id i14-20020adff30e000000b002368a6deaf8sm3316948wro.57.2022.11.18.03.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:04:42 -0800 (PST)
Subject: [PATCH v7 0/4] thermal: mediatek: Add support for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIALpmd2MC/4WNQQqDMBREryJ/3ZSoJLFd9R6liyR+zYcYJVFBxLv30wt0NbwZZuaEgpmwwLM6Ie
 NOhebEYG4V+GDTiIJ6Zmhk09Sy7sS2CGqVFGvAPNkoXKY0smn7ttN9a6TSA3Db2YIc2uQD99MWI5uB
 yjrn4/e2a5b3/+FdCyl8Z9xjMEop6V7OHpFcxrufJ/hc1/UFFjuc5sYAAAA=
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 18 Nov 2022 12:04:26 +0100
Message-Id: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668769481; l=1063;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=pMaGIEwsrzpZmq4GokUNu2T3+sSq40Jxnt5PukxJb8M=;
 b=q8wORfumvupXVJQ0eIbhIXe7py+37KKcDffQKokfWVSbm5S8yMAD9qYJilKiWAIgwU25Mw2RsN52
 5oNC9SGcABiEPep3Vj6BgcRGwlaB+KYwjBL+tHIyQHhDJ5OZEqfc
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

This patchset adds thermal support for MT8365 SoC which contains three
thermal sensors.

Changes in v7:
- Fix devm_thermal_of_zone_register() error checks.
- Link to v6: https://lore.kernel.org/r/20221018-up-i350-thermal-bringup-
v6-0-c87b9f75550b@baylibre.com

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
 drivers/thermal/mtk_thermal.c                      | 192 +++++++++++++++++----
 2 files changed, 161 insertions(+), 32 deletions(-)
---
base-commit: 9d2bc364f67793cdd115f3ab92a18eaf85fee66f
change-id: 20221018-up-i350-thermal-bringup-ad386d37056f

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>

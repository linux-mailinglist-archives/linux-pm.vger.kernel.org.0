Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5B6AE52D
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 16:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCGPpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 10:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCGPpc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 10:45:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE2D36FF6
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 07:45:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bx12so12554457wrb.11
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678203927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NMT354TdG7a+Mjd6nR8XY28RmDaq3SVnAflnava9+4=;
        b=hMkvX07ZWoEiUrNshSUONwBDA8mCpjSl9GndL4JQtN8MUn8/BnoS2vISYH7f/VMaBf
         3hveIte2Is2YGBevN1S5N46ox8c4WHSl4yZCnT4eydXX6lN4ozH2k/5Z9P1C1p2yY6Y6
         UXvo62ShrMcy7kC0Wpd3efQsBiXiMT5Vi24vQ+bIxtTENvmbWZt7b5w+PIFu40sgcf+w
         4tcZHu3Ncvf7+aFNMnKhCIWk16fLycz2FCVwP8noBTWbzETc0mefmwm+lz58SGhoQNbg
         z80QcsPVIuLS3/Au9xz8pUr/yUVnBkLaJx1LSJmLuXzSvsLrN4xxUONwQYZZyY6efQkk
         fErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NMT354TdG7a+Mjd6nR8XY28RmDaq3SVnAflnava9+4=;
        b=O5CKhvyVfVvCpI6r27HXzPRtIorMFkt5IFY0o1zXg9CLzv5TsN5Uhw1Q7wVl6ua1Ry
         3dGaB6AslP8FUiqInZadDmhx3wtNwof0zHolFzkt4dpuCZ9GuwOlQR8e/LQS5CwfQ8U5
         +TuCN2LkpE4ZdOWMQ9D2QQE0Lt6X/gg8z7U/6rpU1pOW6u9bY47vzE8gf2pQaB32jIlb
         3pUomxZTtokDfdGyt62cMiK+QKECKQ1WdTqlVG0Qkv01AruXt6M2uHc7h0ieGjCx+f3P
         oK+LK4kABM7D5qwx8M3v9iIOCHX46zy6FNakkLUDEuidxERtvKxNfaYMRRjUkmrHMyH+
         j2jQ==
X-Gm-Message-State: AO0yUKWH1fdaiikQF2m7A+EM5z2Asat4109EWvGMmkbgGIR2zOjh5JkP
        cN92CUaSou2ulS0jwJ+Xfh9IeA==
X-Google-Smtp-Source: AK7set9EHu+HV/Mv7v6/4EnH+ZLw8tMFVfGqynaBEs9+XXablQK4YXk5bcSSsrLRLVgmSo2ZJFT/wQ==
X-Received: by 2002:a5d:4bca:0:b0:2c5:4ca8:a5a1 with SMTP id l10-20020a5d4bca000000b002c54ca8a5a1mr9236688wrt.23.1678203927555;
        Tue, 07 Mar 2023 07:45:27 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002c704271b05sm12697905wrt.66.2023.03.07.07.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:45:27 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH 0/4] Add LVTS's AP thermal domain support for mt8195
Date:   Tue,  7 Mar 2023 16:45:20 +0100
Message-Id: <20230307154524.118541-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add AP thermal domain support to LVTS Driver for MediaTek MT8195 SoC.

This series is a continuation of the original series "Add LVTS Thermal Architecture" v14 :
    https://patchwork.kernel.org/project/linux-pm/cover/20230209105628.50294-1-bchihi@baylibre.com/

Based on top of thermal/linux-next :
    base-commit: 6828e402d06f7c574430b61c05db784cd847b19f

Depends on these patches as they are not yet applyied to thermal/linux-next branch :
    [v14,3/6] arm64: dts: mt8195: Add efuse node to mt8195 (already included in linux master branch)
    https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50294-4-bchihi@baylibre.com/
    [v14,5/6] arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
    https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50294-6-bchihi@baylibre.com/
    [v14,6/6] arm64: dts: mediatek: mt8195: Add temperature mitigation threshold
    https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50294-7-bchihi@baylibre.com/

Balsam CHIHI (4):
  dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal
    controllers for mt8195
  thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195
  arm64: dts: mediatek: mt8195: Add AP domain thermal zones
  arm64: dts: mediatek: mt8195: Add AP domain temperature thresholds

 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 180 ++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c       |  94 +++++++--
 .../thermal/mediatek,lvts-thermal.h           |  10 +
 3 files changed, 264 insertions(+), 20 deletions(-)


base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
prerequisite-patch-id: 73be949bd16979769e5b94905b244dcee4a8f687
prerequisite-patch-id: 9076e9b3bd3cc411b7b80344211364db5f0cca17
prerequisite-patch-id: e220d6ae26786f524c249588433f02e5f5f906ad
prerequisite-patch-id: 58e295ae36ad4784f3eb3830412f35dad31bb8b6
prerequisite-patch-id: d23d83a946e5b876ef01a717fd51b07df1fa08dd
prerequisite-patch-id: d67f2455eef1c4a9ecc460dbf3c2e3ad47d213ec
-- 
2.34.1


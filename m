Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3FB5B30BA
	for <lists+linux-pm@lfdr.de>; Fri,  9 Sep 2022 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiIIHkh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Sep 2022 03:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiIIHkT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 03:40:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304A12F202
        for <linux-pm@vger.kernel.org>; Fri,  9 Sep 2022 00:36:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o25so1267492wrf.9
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2022 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4e7RlBTjQ/k7/7tVuA9R5TTzLZ8Baa2EHE13JLauQ6Y=;
        b=0jHVBB6vKhPCnwAJHFWzRMHXXiIrqoOYDn7Zh/vMmaV7ZC+JtEUN1G1S90boOZRoMO
         Snu4nB3VgcjpYiTT3Fq2KEaZbayZhCjF+50KF39bzaEQr8GoI3WuxwVbTQ/+xbmy2fY8
         pgzMXcKRgQhv5mWnmqaI8iKdQrJV9IVfvYrBcZVG5zWTiJ2ehpBQleR7aas6uRlj4kKq
         AmhZghYC42o1WEQHynaLG4dDJPjHnlkcRnz2BQT9hkczL231U9LW1oZiYxW04iFAxx0v
         rZT3I5ejiH65xkXAd71h6uRXTQpMF+83RFd/VOyOHYugFswy2DOJQlHVwiZ3fMXG7TP5
         iKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4e7RlBTjQ/k7/7tVuA9R5TTzLZ8Baa2EHE13JLauQ6Y=;
        b=SSft06Rvm8gOFLjREQNgdhMMrKuFIrd9u9Q/wDZYJK0tLjD7hztDmIM+u3hBB0g4IL
         NGq3m0uCCmINxLmTg9GDIMcPWZyGj1h4/YOHffzllsLWZ44iL/8EA3HNvxNXJK/323R2
         wermsPi8k7/QZB0zpfei6OLzClCDU6iivBbEY2/Z2nvOwCQRO9oRwZ9JYfYxeZvLL6+8
         8GNzlG38YenMfaNPJy8UZTFX5CMB7uBt2Qv1xyng5bYK1+KBlvP1ieYRhnFosxFFVIJ1
         vbwURvnPqbglqN6b2lEgrp+AOHtkYVQATWF94pgnisuHGWd3dfRVZIEYYN2mGbip2Ckh
         Sz5w==
X-Gm-Message-State: ACgBeo3SB8jVmTvvBNJF+myOyhkJjT7v7cgWFoj/fgaUmW67/A3wqD3W
        S+PGmzS0ObNG+BBkM27dy7ub7w==
X-Google-Smtp-Source: AA6agR7krDdgNfaZrjk3h6m6Rzfrva10aTZHIv8TVDFrCMcpmMU3UrZGl4+8EOO5Zx+4WYxcvFE3+Q==
X-Received: by 2002:a5d:508c:0:b0:228:de49:b808 with SMTP id a12-20020a5d508c000000b00228de49b808mr7014788wrt.23.1662708982694;
        Fri, 09 Sep 2022 00:36:22 -0700 (PDT)
Received: from amjad-ThinkPad-T490.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c1c0500b003a682354f63sm5345901wms.11.2022.09.09.00.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:36:21 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>, rafael@kernel.org,
        fparent@baylibre.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
Subject: [PATCH v4 0/4] thermal: mediatek: Add support for MT8365 SoC
Date:   Fri,  9 Sep 2022 09:36:05 +0200
Message-Id: <20220909073609.32337-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.3
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

This patchset adds thermal support for MT8365 SoC which contains three
thermal sensors.

Changes in V4:
- rebased on thermal/linux-next
- Use callback for raw_to_mcelsius()
- Use struct 'struct thermal_zone_device_ops' instead of
no longer existent 'struct thermal_zone_of_device_ops'

Amjad Ouled-Ameur (1):
  thermal: mediatek: add another get_temp ops for thermal sensors

Fabien Parent (2):
  dt-bindings: thermal: mediatek: add binding documentation for MT8365
    SoC
  thermal: mediatek: add support for MT8365 SoC

Markus Schneider-Pargmann (1):
  thermal: mediatek: control buffer enablement tweaks

 .../bindings/thermal/mediatek-thermal.txt     |   1 +
 drivers/thermal/mtk_thermal.c                 | 197 +++++++++++++++---
 2 files changed, 166 insertions(+), 32 deletions(-)

-- 
2.37.3


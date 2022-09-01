Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4635A9935
	for <lists+linux-pm@lfdr.de>; Thu,  1 Sep 2022 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiIANlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Sep 2022 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiIANlW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2022 09:41:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C52625
        for <linux-pm@vger.kernel.org>; Thu,  1 Sep 2022 06:40:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1474419wmr.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Sep 2022 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fbdFWdGoT5TyChVzYAZHBA9+fCifaM+n+YZpxGlEIlA=;
        b=YkyloLFSaMRlRbS0LNqxBw/KBaGy50J7eVlBh3OgmcCNcKEYvHjsdT6riJKiYAApuz
         70gS8KwXJe0jglFkZ4GXcFGjMqAt5/xKEx9kNugUhWkAKPHy4OABZ+wxMI9273tig6bC
         FZZyd+vijCPQMFe+0II/bsw751CjzwxUx7k5bGr2oCehH2CgC6s/yXtlSkV+qn9yZsM8
         qbLqH7Sia9HJ2B4+hgVYpoKdCGOqrtvBDCX3pKyRXXsdpn33El6WupdSCqMP26HjMqcb
         SImbyKhefhB6zd9wasjJCfbx+7jp19L99HRu6ZmNNxOpsQUZOruxQN+wDCVGfpXdoQOS
         HBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fbdFWdGoT5TyChVzYAZHBA9+fCifaM+n+YZpxGlEIlA=;
        b=XMoLCjAEvDWZMLxo8XMFsntz2rTnAPjgTPiwyMxO4R99lpUIehQ6C8r6yYnkyCyxWu
         z5YQQ5S2RuyHGunCvG2TkArKiECPpNgr2v11KELMwCwY9SnsTDnIZt+8Obllg6BGSBI5
         ymGOTW1O4OCoxAfFwbT2c9cFAeV9fNxFKwWpxECMIXkm69d1DIX4B5ZpUx9YWXZXb5EP
         LMTLHsXta3FiaM9aj9JgFrtCrS9NcCtREXARoz2a8dp6aF2vRGHXySkOt3EQe3Phrb30
         ViqfajzilumtOYwUhuyhxrRo7MyVU6ZXL+Qn2PfI56Q1aFTbovNan3sVHUSwXrxXKd83
         pVjw==
X-Gm-Message-State: ACgBeo2h/uxX+4vVE+7ASC16pbNN7lVP9nd42ep1O4BJ8ExNv8dO2O3J
        4LGdeQByEQs9jWMkBn+rjzm4UOVA2o0QP/1I
X-Google-Smtp-Source: AA6agR7Qo1EbkHVH2Rb7zV3Lv9+qvbPXOjb9N1DAQF94ZpIh0K/Z7ceowWedOH8REBvxlFzOvJfcdQ==
X-Received: by 2002:a05:600c:1c19:b0:3a5:51aa:d041 with SMTP id j25-20020a05600c1c1900b003a551aad041mr5235294wms.172.1662039598864;
        Thu, 01 Sep 2022 06:39:58 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id e3-20020adfe383000000b0021ef34124ebsm15399016wrm.11.2022.09.01.06.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:39:58 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>, rafael@kernel.org,
        fparent@baylibre.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
Subject: [PATCH v3 0/4] thermal: mediatek: Add support for MT8365 SoC
Date:   Thu,  1 Sep 2022 15:39:46 +0200
Message-Id: <20220901133950.115122-1-aouledameur@baylibre.com>
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

Amjad Ouled-Ameur (1):
  thermal: mediatek: add another get_temp ops for thermal sensors

Fabien Parent (2):
  dt-bindings: thermal: mediatek: add binding documentation for MT8365
    SoC
  thermal: mediatek: add support for MT8365 SoC

Markus Schneider-Pargmann (1):
  thermal: mediatek: control buffer enablement tweaks

 .../bindings/thermal/mediatek-thermal.txt     |   1 +
 drivers/thermal/mtk_thermal.c                 | 193 +++++++++++++++---
 2 files changed, 163 insertions(+), 31 deletions(-)

-- 
2.37.3


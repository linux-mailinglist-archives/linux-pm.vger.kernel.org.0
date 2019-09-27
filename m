Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E593CC0B72
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfI0Sn5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 14:43:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36302 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfI0Sn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 14:43:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so4341062wrd.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BlLuKMnAqwTIEJThXWcT+NCQrpuc31hvcyRBdlbTc+8=;
        b=gEAZsKg36xaTruyiqdmuUhST/Lw16pTt6NvZCi8oFmvWKVaq3wQVtqci8/3EnBkk3/
         HT5sfz/tfMSyCyYHnRd+jOUKuOOSIPtna3cgYa8t9fGu0Km8O+zeG01iQQDUfpt6GBLh
         ica5zJitiOvbmJYuWnzr36l++X1vsvvRL/75xfhhdgQPJrjIKByvv2yWVEy5hH3INNpM
         aQLPAjfgmHfpfOcOslLrksDQ4eocq/BBrKJuIDXSHOXOu6Yt8wYBjF/bGiga2KeX8BaY
         +J/l5zJGL0WzQQhwA8w3RegQUC/JiwnokFq4w3ogg04g3OxBn4YF7WuXF73uOTmPlnW0
         kCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BlLuKMnAqwTIEJThXWcT+NCQrpuc31hvcyRBdlbTc+8=;
        b=T80KoHl0OiGAbPjqFFkR3MuUHPQ1SVN6QwoThQaScQ3+7iSQ0V74p4ic7VXb52/gVP
         ImhzYT9EWPMcPga2ae+TPvt1Sd0auLWgPtVXtKzNZStCU6mHgkXcK48YfoGIQqPDF8mZ
         ppov1S+dKVO6tMWSav+49DCtpU9WeLQjGzh37VMqhK7jfDebCbiBR18wXuHgoDjmU7gm
         y96PNq1B/B5QQ4kMvG1tHirJ5ScY8DjUMN/0FTqkjijijFGrKDdCP5H/3bisp4dnj/zn
         1tZawWww75emdwffXICNFbFRX76/F8lJBnww7MY8AMATlFn3b6BSJCTqVeE/ldx79vWx
         AORQ==
X-Gm-Message-State: APjAAAW7W9ey+PgymXhTKZnATfyr3/Gd0MyV8UVa+qGXZenmAZ9g1GZA
        11qzVsLT+36nQJ2rM2I09mUh9A==
X-Google-Smtp-Source: APXvYqxgRo3KRebRbFSHXBAYv8zrdjIWybW5ueEgqgeeDgsADeXUR38eeRp/Rru7dKw/2IGg4cEpDw==
X-Received: by 2002:adf:e488:: with SMTP id i8mr4333542wrm.20.1569609834506;
        Fri, 27 Sep 2019 11:43:54 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id r13sm6246272wrn.0.2019.09.27.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:43:53 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 0/7] Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Fri, 27 Sep 2019 20:43:45 +0200
Message-Id: <20190927184352.28759-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

Changes since v5:
  - fix patch 5 and 6 send twice

Changes since v4:
  - Move thermal-zone in soc dtsi file
  - Remove critical trip point and add passive one
  - fix commit message
  - use devm_platform_ioremap_resource instead of platform_get_resource

Changes since v3:
  - Add cooling map and trip point for hot type
  - move compatible on g12a instead of g12 to be aligned with others
  - add all reviewer, sorry for this mistake

Changes since v2:
  - fix yaml documention
  - remove unneeded status variable for temperature-sensor node
  - rework driver after Martin review
  - add some information in commit message

Changes since v1:
  - fix enum vs const in documentation
  - fix error with thermal-sensor-cells value set to 1 instead of 0
  - add some dependencies needed to add cooling-maps

Dependencies :
- patch 3,4 & 5: depends on Neil's patch and series :
              - missing dwc2 phy-names[2]
              - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]

[1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
[2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
[3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
[4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
[5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/

Guillaume La Roque (7):
  dt-bindings: thermal: Add DT bindings documentation for Amlogic
    Thermal
  thermal: amlogic: Add thermal driver to support G12 SoCs
  arm64: dts: amlogic: g12: add temperature sensor
  arm64: dts: meson: g12: Add minimal thermal zone
  arm64: dts: amlogic: g12a: add cooling properties
  arm64: dts: amlogic: g12b: add cooling properties
  MAINTAINERS: add entry for Amlogic Thermal driver

 .../bindings/thermal/amlogic,thermal.yaml     |  54 +++
 MAINTAINERS                                   |   9 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  66 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  24 ++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  29 ++
 drivers/thermal/Kconfig                       |  11 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/amlogic_thermal.c             | 333 ++++++++++++++++++
 8 files changed, 527 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
 create mode 100644 drivers/thermal/amlogic_thermal.c

-- 
2.17.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39887C6D4
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfGaPgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 11:36:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56254 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfGaPfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 11:35:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so61300991wmj.5
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7WLjxnI8g1thWsUDdq2Hfl/ujp9OHSJIwkbSbhOm62c=;
        b=0BPP66usc+st7NTNLiYHcT9I5K1u3a3FEnCC+97RYYsl5JXVb4fBlUXZzVS5LwBf7n
         JTbKUH4p+DVBgg45Nl6ztxJKXrgO+YkenDp/0q8Eh3Ydn+k4m+f/ktpR+xKmoRLE+g6+
         4X6jN7AGogvDcQWFlsSg8svTa1InuOjfbGbKMGHVxQbsqoGXyDdABcwqcJIHeSKTXv69
         /gefxIJ4R8j1z5lsN+g3Z+OwfZVRSfu+Vqw4JiTWNhmI7MuIho7o3To837fdMnqrN7jP
         Sd5lBLUmT8egE95rs1uVvzchYHQ3G/g+300vxT6y+sc00+5YRAV/HDgkPf/iOGFu/oY9
         aMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7WLjxnI8g1thWsUDdq2Hfl/ujp9OHSJIwkbSbhOm62c=;
        b=eqmq2W7iY4UtRmjk1fSsqeRTZQ7iU9bRtNHOJ9qbVV1mwYJhRhSvf4xwPGgicfqcdU
         1isk3933yr7CfE7LeJ56x4ceXqiXyWrkS2zc74nhz/jM5xICZLyR9Yw2ZcqmP9fHE6e1
         S5aFWGOWk5P6PI1uk/oatlZCZHrrAenIJ3fHRQ1l8xJOU3XsfRAcBrd8Fuwtw6alR1Bx
         hQ5twYu+XHBScfu/ijvRdSG2CTIt9+CIulo6dPIZTrYC/e4QBrpOIRhz6bALn4mTfLtH
         Wra7RyIRx7WuxENZ8u9Lm9GlRgxQ0pPHBFfPr13PGlT4sF4DZCMaG4ggv/I2IdxSmFPd
         NETw==
X-Gm-Message-State: APjAAAW0HiBG+j6Xdoy4LW8IAeuQIr5pyy/nZqqdpu39j2rd33qbKZLH
        rzmQSzbQevKJ0Y9cYFqehPGwpg==
X-Google-Smtp-Source: APXvYqwwJjY3FtKTWbfPIEqttUCqL8C62yZwUYcZbMGgyaXoMKyDjYkpr7m8Tzh4baLNN8dmQs3MwA==
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr114781417wmm.153.1564587331749;
        Wed, 31 Jul 2019 08:35:31 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i13sm62834396wrr.73.2019.07.31.08.35.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:35:30 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Wed, 31 Jul 2019 17:35:23 +0200
Message-Id: <20190731153529.30159-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

Changes since v1:
  - fix enum vs const in documentation for compatible
  - fix error with thermal-sensor-cells value set to 1 instead of 0
  - add some dependencies needed to add cooling-maps

Dependencies :
- patch 3,4 & 5: depends on Neil's patch and series :
              - missing dwc2 phy-names[1]
              - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]

[1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
[2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
[3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
[4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
[5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/

Guillaume La Roque (6):
  dt-bindings: thermal: Add DT bindings documentation for Amlogic
    Thermal
  thermal: amlogic: Add thermal driver to support G12 SoCs
  arm64: dts: amlogic: g12: add temperature sensor
  arm64: dts: meson: sei510: Add minimal thermal zone
  arm64: dts: amlogic: odroid-n2: add minimal thermal zone
  MAINTAINERS: add entry for Amlogic Thermal driver

 .../bindings/thermal/amlogic,thermal.yaml     |  58 +++
 MAINTAINERS                                   |   9 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  22 ++
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  56 +++
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  60 ++++
 drivers/thermal/Kconfig                       |  11 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/amlogic_thermal.c             | 332 ++++++++++++++++++
 8 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
 create mode 100644 drivers/thermal/amlogic_thermal.c

-- 
2.17.1


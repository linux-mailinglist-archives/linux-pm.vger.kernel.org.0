Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164AAC0576
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfI0Mry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 08:47:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36788 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0Mry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 08:47:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so6047634wmc.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5nfsuBQARAaBBmwNqsfwCMEnjyOr8SwXnC8MGaFfPbc=;
        b=Lmd5I2weT/CLbzqu8U0AzVZ02d19bxTe+oGwl7weveUIH5QqjVhLpCn2ppfW4UwOdb
         BAQXl+idGpTR2JqZYmDG2jfUuDlB7o+9m0izlMk9efwnBQCgLp3sDZv9DCRkWApwhl/C
         27gqFXsobnH0uvNGPKrCHMopDzJhZdi4gciwKydh6pyULekFY6mx0EHldxQcwbVDDYoG
         YKV+Cm0pDgGZyn3vjAoH23TjOjzsDHB7IDBKgblKrKSLw/qQQX6LTlg83EdIyT/tC2Oq
         +3uC/RBKI7AwNln6XPDks5o5bYossAjdx2K8OqvUaQih9kXN8oYcU3aqxFWM9mfMHRCj
         TQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5nfsuBQARAaBBmwNqsfwCMEnjyOr8SwXnC8MGaFfPbc=;
        b=omWot/szPNVizqy1QPlo4EiK7r8GVi89tjlPdCSHCn3TrdwcgXDyLbaRLqrUCQN41V
         dRjHjvTiQuONM6ARyNZ0raioOnoAJ1c082o66X6/dOxpdT1qtL7e4Hge3CLAUBZHlVba
         GR9bExOQY8I42TQzmgyy52tTrDKio6ZxkmIHeMo95CvQPVYX1fQKMv+d5gM/d4IkQBEC
         VnqxmLglAAt+3hC7HUVtwGuIc6apQ1eYi7KxiEx3Zc8wSklOEEpQx8jctMtu8KL+xLRN
         19XTfQTcCdYWcz15pihKr62+DDI5vIoPzX8KBQMh+OR72sQJYGcHDvXDMlVz96AJYbax
         pmaw==
X-Gm-Message-State: APjAAAWI/urToWL8UiA17UbzmqY3Tb7SXHJxPrsKObj1PrsOoZt84YU6
        Yjkybrej/MB/XS8joxkqIWPf0A==
X-Google-Smtp-Source: APXvYqxLUxcPLNObTAWH3B8Ce/vrxLkKzpczxQPY4N2mta6NTnGqrSrm/65RoiX/D+py9JoOesJGdg==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr6776554wmc.175.1569588471586;
        Fri, 27 Sep 2019 05:47:51 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm2985564wrv.30.2019.09.27.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:47:51 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 0/7] Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Fri, 27 Sep 2019 14:47:41 +0200
Message-Id: <20190927124750.12467-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

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


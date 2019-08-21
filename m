Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1A9871F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 00:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfHUWYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 18:24:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36142 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfHUWYZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 18:24:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so3494299wrt.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Tu9KiiAh5enRZaMkZDdS91LeJuxWDEGtNB1BXoc97Zg=;
        b=MRkGRrhQlHfQ4yRktSubadPo620IAnB1HEqxZ63PsnGWczv4vMBpyYL+U3jWj8imdN
         TxKxhI1RoA4lSnao8+T628uV9XJ2zMCFbkTmz+x3apzNy2ZZ5lF3UTo/pFbxEJb5QF8b
         ahDlvtEoYZISmIyZ1JuvSWZUKwo9uRlXDEOjDKhevdNOhCrvWIEFNrDlKMGTo81pI/WD
         jUCGVzEJtrl0lPYHRsjzzLSaOD5tbPhuY7JZwOHI08ubbCBjArReNeJnFo5JVshGIjhW
         F+JW8LIam4PDS/wHLtRR0EB0Dq2blhJkUK4BeZzZ8mVNyNyKlQy8Tc9lh10UG6JOx36g
         oQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tu9KiiAh5enRZaMkZDdS91LeJuxWDEGtNB1BXoc97Zg=;
        b=TSobs5ehBYm6pPaMAkK1V418bRRun65ZJMB9H6DyOq8FVs/ONmA0U4GXmj1gEx9IMe
         uUdFgwO2a99Hb220Xyw0qjrCj/GajC2vXudo9CjrEkIdbpBOfqmvPY/WCIW3BK6rRaBW
         d/vpz3Xhu5niUHRhbcjTCdP1ISyaTAxCt1gxXH4njI7CAS/VjF5lPcMKq/ITYFxEPBC6
         fscAewNU1rnAJvmJPx4v1sExynkLJKGmAmO2Aed4xG1NgaecgTXI03/HY0KH+FKeaSQq
         0f1PIevfEOXCBgkK4sRmWEfBvw+r1Q3KBc2d22ks4aqr9llRuhZYxAqJ+U05vdDiFxIS
         dpgw==
X-Gm-Message-State: APjAAAVBjyyxZRxGLt1cq43MCBxb02NrE1PKHNYrshiC3sjA6snY3jWM
        uWBjjAe6+ffCgYkxRQw9Cogv2g==
X-Google-Smtp-Source: APXvYqwuyBB5WVfIOuZTlZUthOH4h97E4lnN5LJWiB3SBt+5ZWcNYajWVaLszb1NxfgZMOPqseCrRw==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr13201417wrm.256.1566426263630;
        Wed, 21 Aug 2019 15:24:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f197sm3548549wme.22.2019.08.21.15.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:24:22 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Thu, 22 Aug 2019 00:24:15 +0200
Message-Id: <20190821222421.30242-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

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


Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Guillaume La Roque (6):
  dt-bindings: thermal: Add DT bindings documentation for Amlogic
    Thermal
  thermal: amlogic: Add thermal driver to support G12 SoCs
  arm64: dts: amlogic: g12: add temperature sensor
  arm64: dts: meson: sei510: Add minimal thermal zone
  arm64: dts: amlogic: odroid-n2: add minimal thermal zone
  MAINTAINERS: add entry for Amlogic Thermal driver

 .../bindings/thermal/amlogic,thermal.yaml     |  54 +++
 MAINTAINERS                                   |   9 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  20 ++
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  70 ++++
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  76 ++++
 drivers/thermal/Kconfig                       |  11 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/amlogic_thermal.c             | 335 ++++++++++++++++++
 8 files changed, 576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
 create mode 100644 drivers/thermal/amlogic_thermal.c

-- 
2.17.1


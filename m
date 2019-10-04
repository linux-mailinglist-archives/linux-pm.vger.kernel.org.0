Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C628DCB6CE
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 11:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbfJDJBS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 05:01:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35207 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387840AbfJDJBS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 05:01:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so6170611wrt.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EFydY0lgIP899wnAH99dy6et3EG1uYQ9KTgGCBLycYs=;
        b=qF0GVukplt92gp1dIgMULefb5vjDSNNhk+Ho8zlhKs5lWbidTiPF3rXtAV/OMf/cWA
         YLkSKjy8nyUM1mp1oJRyBI52MX4/1ErOfaNIxvRvwAubX3kc3rBJH3v3qLHXKvMs3UbI
         YcI/Ok0ScCFkD8rDOZoGkYDiJwXlmBWCFD3XB2uGQSV9jjBXM70JO/9HSPqcK/BGDIEC
         xWpCVkzTSpsysEwc2JVgLgsC4zIZNcdtrpK7cDk+k73kpVSC7zypLxAG7HiTT1tBNPJo
         6wpcKeA3yYNu+7hfFihagaIfl0fv0Ennk/vsC72bxoG/8zycuhVhESXsBE60rKCZT7qp
         u7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EFydY0lgIP899wnAH99dy6et3EG1uYQ9KTgGCBLycYs=;
        b=RjZFFDauoGT3VmBjoQ6zanTn+FFlXqCA+jXNjAyVOnQ+PJEQ0F7G61v7kVkz2K4egh
         SDVkemL8R6WeVS47ItN6qaGWWps5mDpEhYse/qzE6ltStZjpdjTH3ezTZua9oBIvZisF
         K0npbRHGGKGkQuIR0HGMFmAW3v9Ug1OWadEXMKNm3d8TqmQDFHhNnsae5+n2vJPLvizz
         C6/JZISeakOYWw6vKSRFfz6OVgF9SIUWoK9XBtjQcOBBHWDgaUFa4mh1cFD7r+v4eXii
         ywNGUu11llWHXKg/1ZWZkTccYIgwTfWtOjMeARsv5DVHXnj44nX6y6lMxYdMD3kUlFVn
         DxZw==
X-Gm-Message-State: APjAAAVyqBbjG+jKrnB6L01xXrRsGumHV44Qw6DbFV9GWxF1GygB9GeJ
        HOLl98Ip886N0/a1AASnufbdNg==
X-Google-Smtp-Source: APXvYqyRiGMXW/wfqsay/UYMA7JeRdE57EW6un20v5k0NxiOZ3sdeT1X4JHfTYukfhmSHqxi20GgMQ==
X-Received: by 2002:a5d:630d:: with SMTP id i13mr10380588wru.230.1570179676023;
        Fri, 04 Oct 2019 02:01:16 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:15 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 0/7] Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Fri,  4 Oct 2019 11:01:07 +0200
Message-Id: <20191004090114.30694-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

Changes since v6:
 - add missing critical trip point.

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
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  77 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  24 ++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  29 ++
 drivers/thermal/Kconfig                       |  11 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/amlogic_thermal.c             | 333 ++++++++++++++++++
 8 files changed, 538 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
 create mode 100644 drivers/thermal/amlogic_thermal.c

-- 
2.17.1


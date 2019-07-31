Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D537C0D1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfGaMOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 08:14:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38967 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfGaMOP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 08:14:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so16266387wrt.6
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=LjD7zv10OSEEYASmHj/VO2M7lzphFAaxTy5j9pYxJDo=;
        b=wq+OcFSyqHwlGFEmAGphrBhbP+jw2ZeUDJvnr2ryt0UBu4Kc8BRJiGhW6nT4CpumyV
         SKOb8IQMeNonlQPsKhQERiB/vwfGBTE0wB75t/eaDiGV22IphLZrF1IBc1ENghpzhQel
         ZYhMZKVg3ke0P91tgzfMITOJuO4O8bOJTwI3GPQteEg68oqQb8yfK6SSaGQ0qaQazN8x
         8t8ESnrCXgYEnHfjqb7iJQmssQOB0Al/KAIWguYzWba4gqqGSoYAoZAqEzF9AsSUX7Up
         WaZ6pwGSnfOltvm6IF58V/oAvcv+TGqUo0y3gUuOSsOl361ChIoMnUMxB5ahxtY1gEQj
         ooJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LjD7zv10OSEEYASmHj/VO2M7lzphFAaxTy5j9pYxJDo=;
        b=lwl22DNPCm99ubYH9suWQ6n8VrAdy4pfsBkMeUPKW0lfxosJtAOvGLtghpvWdRcO7S
         bT/5otdnpjDRaUPSeb5jaKjlt3so00QH5xmbiczwI+1SeebtZIB2VzH7SUyjQq8OQH93
         OUZN/WKhxG9uMRa30uxXJQUxrRmHEcGjvUwqygFQlOkGkiygROw3KTJfr10CJbt6vUSj
         c8qrHrkovopTZj+W/Gv+F2pWO5jdgzFwyXYZ//mQ7eDt95ppLngyj8V/ug+2Xo+5wqOg
         yVe0YX3yYlkD+sYYCtCQ87q/Gaj7T2Hs9fEIB82xd7YAcjxG4HJoPJRZH2Er6yKmtVxG
         xpUg==
X-Gm-Message-State: APjAAAX/mwNtJDy48iCtQkrzSA5IuLg2iMmHpJJftY2wSbcW65RBfeIm
        yfaEqANgxtvF+y/br8kpg0rirw==
X-Google-Smtp-Source: APXvYqxJbSn0OApVvnN6CpKmYBH7g0bhbbP4QJ0hUCNLf17qIH6FUg3NTYWzUkcC4F/NvISPNemGcw==
X-Received: by 2002:adf:db46:: with SMTP id f6mr5645832wrj.212.1564575253424;
        Wed, 31 Jul 2019 05:14:13 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:10 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6]  Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Wed, 31 Jul 2019 14:14:03 +0200
Message-Id: <20190731121409.17285-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

Dependencies :
- patch 3: depends on Neil's patchs :
              - missing dwc2 phy-names[1] 
              - rework on G12 DT[2]

[1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
[2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
[3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-2-narmstrong@baylibre.com/

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
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  13 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  13 +
 drivers/thermal/Kconfig                       |  12 +-
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/amlogic_thermal.c             | 335 ++++++++++++++++++
 8 files changed, 462 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
 create mode 100644 drivers/thermal/amlogic_thermal.c

-- 
2.17.1


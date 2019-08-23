Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22259AAFC
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 11:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393393AbfHWJEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 05:04:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39454 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfHWJEW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 05:04:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so8341340wmg.4
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dl/uscAowXukXuhpqgLF0MCIjY2hwV9HUJY7MTPFx+U=;
        b=m7Lm47K3lfmXXBH6bb1ALP6Euh07K7vyM5wb7vvgY1B/1TR9RRsENy/mPoA/yPIk/e
         p4efrhHsjMIdMdqdpRRb6j2eazLpFHK0x8RbKnmNFLtBD3KJ9gSq/RgvvS0jQ1xWpzDb
         Td7RNmf5S4vIqYxm+tQBGBfFowm9P6Ul0t2yjFo6I8FlGfhngtHEG1mwNBaLM5rxKIRe
         WLurq85T17urVVGq9y/qSw8gPnT7vV0ks2XJ/CA8pLLLdg5yJWFK4k5SlmGNe6bNrA65
         G6REu8wlkQTiZSn9ltQIqMPhfYCZpnPhmwkfksyfImvLuI/2yy3EEz5rHZv7/VmGEt2N
         Fj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dl/uscAowXukXuhpqgLF0MCIjY2hwV9HUJY7MTPFx+U=;
        b=F1CKMLxxXVLBBfuAcmyPrlf8/0UplafwKkyNh9pvfhgdQcTRy9nyOaSUJI/WHT7n7W
         o8kLTL7sIGDIdSo2GgOJZamtoFvRaoqJWtArhpiyq2NwBW0nTBGErZRZAyjnKYl2jy6/
         KRCFUJIKIuC0JWv9bS+gOZ4HuLc0K3BX8hiO3k/yByfP5We/LH+NBSN+PXXcuzGKqptA
         IRdidsg9RNnoWYSv86l5BdF5gHxfXGDvAWqL+C6nBWxntVCd1svmmGCgVnA8b01lwZWX
         qCu7y4kkOG4iVYflXF9h8An1RoLcjZLcp/MFCyRJ1e2ZiX5HvWTfHGYBVikO86ZE6Srx
         8MDQ==
X-Gm-Message-State: APjAAAWPOWvIXNKLgS//vr3Qlz8uO97wctTspp0syYitzYnfq8tOsSB+
        /ob1F7xcDi0OhJpr/M1X1tO0355CPZIvjA==
X-Google-Smtp-Source: APXvYqwmq4sNSi424dS+1qU5TMcPyATzSUaYYh47inFl7d7klYRZCt3JcgSepJzzLt1ujHPiHmZPhQ==
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr4038875wmb.154.1566551060583;
        Fri, 23 Aug 2019 02:04:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x26sm1625544wmj.42.2019.08.23.02.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:04:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] arm64: meson: add support for SM1 Power Domains
Date:   Fri, 23 Aug 2019 11:04:13 +0200
Message-Id: <20190823090418.17148-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset introduces a new "Everything-Else Power Domain Controller"
designed to handle all the different non-Always On peripherals like :
- VPU
- Ethernet Memories
- USB, PCIe, Audio, NNA on SM1

The current "gx-vpu-pwrc" process has been integrated to support the VPU
and the other power domains in a single driver.

Support for SoC domains has been made generic and easily extendable.

In order to restart from clean architecture :
- the PWRC node has been moved into the HHI simple-mfd, this suits much
  better than beeing in the AO RTI simple-mfd
- a brand new yaml bindings schemas has been written
- reset-names has been added to clarify which resets are needed, so we can
  dispatch them to domains

For G12A, the PWRC now offers support for the ethmac memory power domain.

For SM1, it also offers support for PCIe, USB, NNA, ethmac and Audio power
domains.

The DOS domains has been excluded for now, but can be added very easily.

GX hasn't been integrated for now, but it would follow the same scheme
as G12A support.

Changes since v1 at [1]:
- removed open-coded reset & clock get, enable/assert, disable/deassert
- moved to clk_bulk and reset_array with count check with a warning
- removed remaining sm1_pwrc in probe
- reordered arguments for VPU_PD and TOP_PD
- added get_power for TOP_PD aswell
- ported special VPU handling from gx-vpu-pwrc
- added shutdown driver call to avoid errors on reboot
- fixed patch 4 commit log
- collected rob's review tag on patch 1

[1] https://patchwork.kernel.org/cover/11106393/

Neil Armstrong (5):
  dt-bindings: power: add Amlogic Everything-Else power domains bindings
  soc: amlogic: Add support for Everything-Else power domains controller
  arm64: meson-g12: add Everything-Else power domain controller
  arm64: dts: meson-sm1-sei610: add HDMI display support
  arm64: dts: meson-sm1-sei610: add USB support

 .../bindings/power/amlogic,meson-ee-pwrc.yaml |  93 ++++
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  92 ++--
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |   9 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |   9 +
 .../boot/dts/amlogic/meson-sm1-sei610.dts     |  28 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  15 +-
 drivers/soc/amlogic/Kconfig                   |  11 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-ee-pwrc.c           | 492 ++++++++++++++++++
 include/dt-bindings/power/meson-g12a-power.h  |  13 +
 include/dt-bindings/power/meson-sm1-power.h   |  18 +
 11 files changed, 733 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
 create mode 100644 drivers/soc/amlogic/meson-ee-pwrc.c
 create mode 100644 include/dt-bindings/power/meson-g12a-power.h
 create mode 100644 include/dt-bindings/power/meson-sm1-power.h

-- 
2.22.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECE3F5704
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 06:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhHXEKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 00:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhHXEKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 00:10:46 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE50C061575;
        Mon, 23 Aug 2021 21:10:02 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id s21-20020a4ae495000000b0028e499b5921so3361795oov.12;
        Mon, 23 Aug 2021 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7s0jc31HPLAs0gXkmeRMnAPIKh72hl0mqHTuEnX+aY=;
        b=GGBV6KeWVbtgT6Mm6iQM27J2B036M/xQ9+GGgBC8Ru/8KZuIgTnoGtcmkUpZvpKDUk
         MY7xk5FDUfSWmdhgiCTKSFtVbK+UuvSV8wW3w7sIjYUK4YVRcZbli7PS4qIQzpXhNHFZ
         ZsXR0kXo6SVDk7Fqdb7kAw32MdGSe6MdoFBT47WCEvWd7v+7ajknW6q8P3vo5E7B0kqw
         r1huv6Te0ajpcW95LLyb0oBDyEd44jE4GKnOGWbXZNP/70d0DHxjXR6qHy0CzDImkST6
         SdwbQhYPvWu9WFLa4bLumCYJMboK9z3UmOKxbhl7j46GbibsPENkzb0P2HCyRa0Lz1oj
         G5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7s0jc31HPLAs0gXkmeRMnAPIKh72hl0mqHTuEnX+aY=;
        b=Pyy36iBfry2rl2mP4jYxIQSjrEmh1RxqUl45iXeJ3ClkDXct9XRD893pdIwHPC8Oo6
         sE5eFeb0JKblNtQriJRAf0TkUiBY72DCSOCOsahZ22OhptUcB/Kml4T8TbHQr4zSIV9K
         RyOw5uHvj5wqpSp2nNSULv0l5nUwyg7g2p6zCA54o0rF6RY/jN2W5FWio7hL6XIpvUXD
         mDjqdj/HDFqLS7BtibZ3yY6hA1R4YnzpOQ9xILBtVpZMHq182Sxm2ZC8aVvrs7/xGXEt
         SpsvrveVVOkiHtRBULFQcBJtvwYn2vXZ3r7BZ49zswhl7TZmhsrWM4P+4nk5kLuhkZa/
         IaHA==
X-Gm-Message-State: AOAM531uf/7mXEzA3ChekqKhqvTDFHaoyLgYNGVcjTa9rZ6j2x4HFaKz
        cLx3WPymLx/vF7+n/YYdHWA=
X-Google-Smtp-Source: ABdhPJxDcvzCfgf6iqIMItm82HL8VmZJ9GdO4AcSWiZgXL4fvrSMaJlYxIM5/kSCe+gZgYmouKRVng==
X-Received: by 2002:a4a:4484:: with SMTP id o126mr5055737ooa.90.1629778202181;
        Mon, 23 Aug 2021 21:10:02 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id i19sm3922818ooe.44.2021.08.23.21.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 21:10:01 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lee.jones@linaro.org, robh+dt@kernel.org, heiko@sntech.de,
        sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 0/4] power: supply: Add Support for RK817 Charger
Date:   Mon, 23 Aug 2021 23:09:51 -0500
Message-Id: <20210824040955.29112-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

This series is to add support for the Rockchip rk817 battery charger
which is present in all Rockchip RK817 PMICs. The driver was written
as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
myself Chris Morgan <macromorgan@hotmail.com>.

The driver requires some basic parameters be described about the
battery in the devicetree such as the maximum capacity, the minimum
and maximum voltage for the battery, the maximum charge current, the
maximum charge voltage, and the value of sample resistors and sleep
currents.

The hardware itself contains an ADC capable of measuring the voltage,
current, and temperature of the battery (though my implementation of an
Odroid Go Advance lacks a thermistor for temperature). It also contains
a columb counter, registers for tracking the measured voltage and
current at boot, and a few bytes of nvram for storing data.

Changes from V3:

 - Corrected issues in device tree documentation.
 - Added additional logic to battery to correct for columb counter
   drift when the device stays plugged in at a full charge state.

Changes from V2:

 - Updated devicetree bindings to use common property units.
 - Removed unneeded includes.
 - Updated rk817_chg_cur_to_reg to make more legible.
 - Simplified formula for displaying calibrated voltage.
 - Updated power supply type to POWER_SUPPLY_TYPE_USB.
 - Implemented get/put_unaligned macros for bulk reads and writes.
 - Changed numerous dev_err() to dev_err_probe().
 - Call power_supply_put_battery_info() at end of probe function.
 - Removed unneeded whitespace.

Changes from V1:

 - Fixed a CLANG warning regarding an uninitalized variable.
 - Fixed a CLANG warning regarding a pointer as a bool value always
   returning as true.
 - Added Maya Matuszczyk to the Signed-off-by.

Chris Morgan (4):
  dt-bindings: Add Rockchip rk817 battery charger support
  mfd: Add Rockchip rk817 battery charger support
  power: supply: Add charger driver for Rockchip RK817
  arm64: dts: rockchip: add rk817 charger to Odroid Go Advance

 .../devicetree/bindings/mfd/rk808.txt         |  38 +
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  26 +
 drivers/mfd/rk808.c                           |  16 +-
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rk817_charger.c          | 959 ++++++++++++++++++
 include/linux/mfd/rk808.h                     |  87 ++
 7 files changed, 1132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/supply/rk817_charger.c

-- 
2.25.1


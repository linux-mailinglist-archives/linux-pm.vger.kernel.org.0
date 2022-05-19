Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3352DA82
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 18:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiESQpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbiESQpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 12:45:43 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC59DD0
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 09:45:42 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v9so2481109oie.5
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3vPikjMrJ/sOxGD67uc6AI/57xp+LEL2ERbhK7XXUA=;
        b=qGdA6buGE7he5OAvsFwc9+qzJWFYexwGF5N1CS+dhRpoci7jYQsQ5GVUDiyq3B4iUE
         ig+LkclsIaSCkgNUaGAF2v16PEkkGdX0eZbIkerk0w62jk+E4qc5OgTUYRwOCiMYciUh
         WF8VhG0X2J2kOCKQEXCGPgG8LUfYf+LbfF1bbMlcDgjqhWX8x9Z2AgtMVqkQjUdDyzVN
         oSt0RisIkZ8gObHNB0e1iC9c6ef1G8t4S4BHvefTwM4VrqhzgEb6qWUaucZX7n/hrFz5
         BrWh7ipqLBLCJINsrNEy0dRWAlA8iVWBojZ0TaCiUGIS9ltDfp01+VThDxyczs1HiPAr
         Shfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3vPikjMrJ/sOxGD67uc6AI/57xp+LEL2ERbhK7XXUA=;
        b=wy9FufWvUAztBPR0fjZYgvvZ0DVtlp+Ycg+Rh6r3QlGS5whXZdUiD6tWyVjhVKqWiM
         U/KUHkxMAVu9acnQHmJcdQJHCsKcDcaMxeOFaHNQnYgOcEldmY3m+wFWFODklZQdtx9/
         p8uqQstzHCEqfTrSReDQf2c5o0oHdfPeOXjH6BhYipPa0+8uT+Rs5LyzAwDJTzJo6Biy
         YKQSz8x6t4z6XMuoeyxD9aFXvPmoVHvJPXUXX2Jx6RQxkElqU3U1ZB9IzDvVj5issqoQ
         8O6C7rQZYuuLUySl0oJIHAt9cGEHr5G5z6rGTgySjCp2rJO6d17QMMK2QkTeUwCr0Ck7
         hPFw==
X-Gm-Message-State: AOAM531/KwJ2p0FIMmK0U+ucj4XroNifNlNx6VTWx6tdblAuV8pKAeYF
        Vo0rkPR9T0CJCVRhclqjYzI/kVJX/XnoGQ==
X-Google-Smtp-Source: ABdhPJy1+PyYfk/d1jWWt3rldvPYaJPRzGumQAEyDKvEBFiAqv2WwRd7oKZEpHxWHaa2ZJCvYkIrBA==
X-Received: by 2002:a05:6808:1250:b0:2da:39df:1f92 with SMTP id o16-20020a056808125000b002da39df1f92mr3265027oiv.27.1652978741858;
        Thu, 19 May 2022 09:45:41 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id i20-20020a9d6114000000b0060ae5f10973sm575601otj.15.2022.05.19.09.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:45:41 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, sre@kernel.org, jon.lin@rock-chips.com,
        zyw@rock-chips.com, zhangqing@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/4 v7] power: supply: Add Support for RK817 Charger
Date:   Thu, 19 May 2022 11:45:29 -0500
Message-Id: <20220519164533.1961-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes from V6:
 - Updated devicetree binding patch to reference the required
   prerequisite patch in the correct manner (relocated it below the ---
   and pointed it to lore.kernel.org).

Changes from V5:
 - Renamed mfd-cell from "battery" to "charger".
 - Added note for devicetree binding documentation that it requires
   application of an additional pending patch (to convert documentation
   to yaml).

Changes from V4:
 - Massively redesigned the battery driver to improve measurement
   accuracy and reliability. Driver now checks values every 8
   seconds (mimicking BSP driver behavior), or whenever a plug event
   is detected.
 - Removed OCV, boot voltage, and boot current as values were found
   to be unreliable.
 - Updated first-boot behavior to perform a "best guess" at capacity.
 - Added ability to calibrate columb counter to full state of charge
   when charger reports full, and added ability calibrate full charge
   capacity when battery discharges from full charge to minimum
   voltage.
 - Expose state of charge as capacity (in percents).
 - Updated storing of values to nvram to preserve compatibility with
   BSP kernel.

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
  arm64: dts: rockchip: add rk817 chg to Odroid Go Advance

 .../bindings/mfd/rockchip,rk817.yaml          |   48 +
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |   26 +
 drivers/mfd/rk808.c                           |   16 +-
 drivers/power/supply/Kconfig                  |    6 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/rk817_charger.c          | 1157 +++++++++++++++++
 include/linux/mfd/rk808.h                     |   91 ++
 7 files changed, 1344 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/supply/rk817_charger.c

-- 
2.25.1


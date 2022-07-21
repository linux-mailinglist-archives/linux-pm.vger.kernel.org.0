Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0361E57D14F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiGUQSi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiGUQSJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 12:18:09 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01689A73;
        Thu, 21 Jul 2022 09:17:33 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o133so2531926oig.13;
        Thu, 21 Jul 2022 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrienpmK/JKb5On59DyVnzISjRJ+QMGVIPqHV8+Bi4Q=;
        b=dYF9wX2oQ+ldXB4tLLYM//Lkd5iPcHecBMElWfyevCQdOvjwUaBC9Kmx0UbGQ6xhp9
         1cwRiNGqNlKoEI23LvoT0cFoTWauMidgaMdYpo/eGAoK9trl9OXXIAE3Dut4YgFRDHZI
         juicmpduQTgt+SA6DZT2+y6lqMiGjCp8tH/bDBIdDW0y+WbQx3tkTMCdhXgr059E2LPd
         oBtuw0KDNxopqaWi76N9i+7kQ9tuh1zYYnnT6ygSO/naAbmksw3a529vI8Pzk1v5NG8f
         QKENjDWch5XhUMoqwQJmNJXkgw8oXSQOeMHZ5vcW3lrbNujcb3TmvURXiasTxtDyXMWq
         wK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrienpmK/JKb5On59DyVnzISjRJ+QMGVIPqHV8+Bi4Q=;
        b=jQ0+rc36bO8N5bmD5M6/Q+80EIBcRjPVGQ2CQSOLQwmney2ln76uGkdI9ufxHVt3Fx
         KC5Gb53GjMlytKk1prX2s2kE04r3S6qsQsIGQDVlYTQHv68mBYN736RM4Nes+FSBtIE1
         vFADxNWgsaHkHxBtM/jLe0gs1t+0b1qwxDcD4Jqks8eVWBR5rV3CsF7pb/ZxqJObIx6G
         n5JVUDcG3whrTjnhk4chMTsXd4pOSmlJzXfW/GVOuriAzEokewwIDBgDLvCKEJIVZss3
         I3ahMIwht5/w4kkEamv0VbHKYvLJflyYdjILgM4Oqa1IDgVIkJ5x8L/tWkeX5XsTHO+t
         QvAA==
X-Gm-Message-State: AJIora/J3rUv0j7O+O53yJmZ47BcltcemzAdAY/B8GBtLmE4oxEhq+P6
        PP0v52Fn00FVAe32bB+jkEcW1U1FtPk=
X-Google-Smtp-Source: AGRyM1tHbJ4+ofYcRKxSdc0KNBOCFnPuletJT8RsffzqLtINpk0XtbpgjU74DFe2TWs1gpeHLHw9vg==
X-Received: by 2002:a05:6808:18a2:b0:33a:afa5:9f71 with SMTP id bi34-20020a05680818a200b0033aafa59f71mr1134393oib.45.1658420252341;
        Thu, 21 Jul 2022 09:17:32 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id cy18-20020a056830699200b0061cc06a886csm951732otb.9.2022.07.21.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:17:31 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [RESEND 0/4 v7] power: supply: Add Support for RK817 Charger
Date:   Thu, 21 Jul 2022 11:17:14 -0500
Message-Id: <20220721161718.29800-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Resending as remaining prerequisite patches are now mainlined.

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


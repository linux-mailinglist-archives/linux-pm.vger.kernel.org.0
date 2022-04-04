Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888BF4F1F44
	for <lists+linux-pm@lfdr.de>; Tue,  5 Apr 2022 00:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiDDWri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 18:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345396AbiDDWq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 18:46:56 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376AB381B2;
        Mon,  4 Apr 2022 14:58:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso8127321otf.12;
        Mon, 04 Apr 2022 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+425n+823c6MPZV7nk0SKDFGg4SE61xIiVxspYwInXE=;
        b=oGKcuZA32wussQCmvJJTxirZwwAwPMk1TWARCef+uIw0puFG4UC8BHrHIX2OCuLjrt
         4ZyJdoqn5d8GYSxvViac/z+6EgoBDInT2sBfEy37UXMXTXAhH4PE3MMe/FUXas3V3cZY
         6qPvKtvYta42co/ZFgKTyfbhZakOhWOR8FLtumw4O96k/E5C4ZLBUYzOtakw6vPpCzHU
         FXexdd21cZEN0SwDUAQFuIX0mMlvm2dH76T/oFKWegybg+DoHWkOsp1lG64yNmc8Yn0P
         YGidriX6cKmL7y9+drLq39S250Csge6e4UVLY51O/3QRXWPQYxWolNEmOOxkqPmCAcHR
         d+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+425n+823c6MPZV7nk0SKDFGg4SE61xIiVxspYwInXE=;
        b=ZTlSPxWYGaGIitrGyS58Dp/VC/IcUh870y6BAJ+qt5hrKoNaJ3VR0ZWyg4PON7/bfo
         uuS7w4Wk+WA4dkgs+TYqd6BlNWk/p2+iICP98OGCMC5iUfv+17puozKI2cTmbEtEJWTF
         NpZYZfURk3uPdVc1qZPTWLpnzdZ9YmXUIVMemmSiFjOr4Wj0UDwWpGAdy0uAgSVAvlfU
         nRIZtstx+XVkjC2NfoZWoPNb501D6hB46tqAIatF8S3UvcaWyvGx8Sm46/qIuOcXDPI+
         w6HFo5qtnFv3yVCOtUGIE23SL39l0c5sJO5Sa0B2yIacjc8ruvhBOi41VwuODSXilNPi
         +ALg==
X-Gm-Message-State: AOAM533z6bEKfS6aVR0CKVH4f94/HuGqbFF0iVg6yFMi6oSze+a0zZpM
        Hq40jjr+LcE5jzpl6JtGBekpByG/ZaA=
X-Google-Smtp-Source: ABdhPJwumvcXkxofJekXw/aZRO2NgDQHAf4uX5R/O6ZrJAsHIOpc9jrXlcuPcVPVwf+upE/bI+Crog==
X-Received: by 2002:a05:6830:1681:b0:5cd:b61f:aff3 with SMTP id k1-20020a056830168100b005cdb61faff3mr140035otr.228.1649109484168;
        Mon, 04 Apr 2022 14:58:04 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r3-20020aca4403000000b002ecf4d70c83sm4646402oia.27.2022.04.04.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:58:03 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzk+dt@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/4 v5] power: supply: Add Support for RK817 Charger
Date:   Mon,  4 Apr 2022 16:57:50 -0500
Message-Id: <20220404215754.30126-1-macroalpha82@gmail.com>
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


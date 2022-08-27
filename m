Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40655A33C1
	for <lists+linux-pm@lfdr.de>; Sat, 27 Aug 2022 04:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiH0CQf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 22:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiH0CQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 22:16:35 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B99220E7;
        Fri, 26 Aug 2022 19:16:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u14so4161384oie.2;
        Fri, 26 Aug 2022 19:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=uCjhCul81Cqo/4TLKT7kgAedULjOyk61ASUhuZAyenU=;
        b=EMZPeiH/04z82Sz/VFDuBELHlTzkmPIgINT2ff17YAKSHrTvlXZ+QU99sboKZxhi57
         MQZkkFCPSVer4BI1MbgrLvzQ+0bJBsAQzodr96aWcSmYi2pkzeeiuGF3jocZtHRPYOKO
         SmrERCdXgHcK4RobplfnOWFuu7trXi9n3PRYBGzRFjJh8APKRUGVVj3jaNTjM/gA28LB
         dTg4HWqPchapi4vAkSY/+FFHGe3aIzkKMhGSxrQJyuFgaTo7/nsQ3Z9uDK8+xcLsVUvY
         vOLyLcKZW+YN7Z7y+cPooE19Ol6LsVABnSvJeSES+vYbhxDQKglbLuR1uEmcBTyNXW6s
         uV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=uCjhCul81Cqo/4TLKT7kgAedULjOyk61ASUhuZAyenU=;
        b=fJyjBJ4fClH280EEHtg3qAsEic42vLULBE6idA8lZgl1Oo/lmkqPhHCzAmq7/310m7
         EawwKMMAzbip5ipv3cQ6mv+zVpB33O+YLenIQCe+WE5y2DndBW7UH+yegM+4+jwg44eS
         D6RwL7zEefKInStpdDWJOxmhcGWCL/y2DwVMn14xjv+Yk3KJKU2gxerGuM5aMOG2jzEY
         3KylGi1pwMRAICTpMWunp4dkYsScLkf8EnUV8NjHMt3mHUEsFJLVzYrfJpVTE7EM+vlM
         4CA5qRVEncx4rvlLZ3BLX7vxtDxcQNWJHtevmjaigSV00fIwppnGCUYLBTC7aK+Bm491
         0njg==
X-Gm-Message-State: ACgBeo2VlCxwXNR4Avi4/jbGRg9IB6X7OgouzqPf04+uHAaGw5gjxUrU
        0YuAFB0dxdHqDO1Kw9EMbZNXFdOow48=
X-Google-Smtp-Source: AA6agR7+Q8vvl4O9bkoz/4+31jc8T2hEg+ElJGoMDJGBlVLSM7QSIHxcJTiAp7kfnXNEEIoN2sdklw==
X-Received: by 2002:a54:4e82:0:b0:345:47df:9224 with SMTP id c2-20020a544e82000000b0034547df9224mr2858650oiy.222.1661566593065;
        Fri, 26 Aug 2022 19:16:33 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d7c84000000b0061cd208fadesm1925752otn.71.2022.08.26.19.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 19:16:32 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lee@kernel.org, philip@pscan.uk,
        mazziesaccount@gmail.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V10 0/4] power: supply: Add Support for RK817 Charger
Date:   Fri, 26 Aug 2022 21:16:19 -0500
Message-Id: <20220827021623.23829-1-macroalpha82@gmail.com>
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

Changes from V9:
 - Corrected devicetree documentation to note that there are no
   additional properties for the charger than what is listed.
 - Fixed error handling on invalid parameters from the monitored
   battery node. Previously was checking for non zero values which
   could miss some error conditions. Now check for values equal to
   or less than zero.
 - After investigating an issue first identified by Philip Christian
   <philip@pscan.uk> I changed the behavior for storing the rsoc value
   to nvram. It actually looks like the BSP kernel and U-Boot stores
   the remaining charge in mAh, not remaining capacity. I also added
   additional sanity checking on reading nvram values before they are
   used to prevent further issues.

Changes from V8:
 - Updated copyright notice.
 - Replaced linux/of_gpio.h header with of.h.
 - Changed to use devm_delayed_work_autocancel to manage work queue.

Changes from V7:
 - Fix error reported by kernel test robot <lkp@intel.com> in patch v7.
   Problem appeared to be related to incomplete removal of fields I
   used previously in debugging.

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

 .../bindings/mfd/rockchip,rk817.yaml          |   50 +
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |   26 +
 drivers/mfd/rk808.c                           |   16 +-
 drivers/power/supply/Kconfig                  |    6 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/rk817_charger.c          | 1211 +++++++++++++++++
 include/linux/mfd/rk808.h                     |   91 ++
 7 files changed, 1400 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/supply/rk817_charger.c

-- 
2.25.1


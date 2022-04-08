Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E904F9F13
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 23:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiDHVXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiDHVXc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 17:23:32 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FAA19E;
        Fri,  8 Apr 2022 14:21:27 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j83so10118264oih.6;
        Fri, 08 Apr 2022 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gltze0pCc/NirzNp1/FXUGTqmLgu6B0jDaqvD1I8iMY=;
        b=Dsp8rPtvWcwrYbvDl/IpmrpoN6QIEmTRWEdXakNertRl/mfpix0mxJmKdY973AoJN1
         Vps6htKjHnXZbVnEO/634VisrzpKBlF57npnLMl6h0DpZZytdeAOpZHolf++InLrk3Sx
         3iysc65T1mZFE+XQN+Ktkx0kfPXnfgeoM9vvHVXLT2CB6RZGx3oC+AbdnKBqUIEvonQV
         nX4XaWfk7Q9qGFuAgWJ9QiI1CFD1/grR2wJpLjFQbhbol0dCwMVSDyuLAwrT6cVw5Hu1
         8VzYXn41ON275bPG9JttAeqofU3jfU0hkKWm7x4ip1kFxY9ydGSvL3E+pvLRluE1h+le
         /xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gltze0pCc/NirzNp1/FXUGTqmLgu6B0jDaqvD1I8iMY=;
        b=MYuiFk8idKAb/VlF0VPfk5jfPe4aVLrTNzY5PObXlu3CriGts/GZRlbv7p8SuBIpWz
         35VEpsjeXHeuqQCNiFOJzWu4Wj130oST8JLbc+eA9MHzKD1wxU3l+zz6A0tPg+pm8KpO
         QbGcgQCP2LSS7Bt1sjl0PfGxkNugdMqrQr/vPaymDKBVa33nw32l6f1HjW8kaqQcj5Ad
         QpGokPaiZ+JeF56hXgEPCtAcK9bCD0gs4Fzu3IICLTF6IcHxxaMZlUXQNNTy1tZrZ+mW
         dz7U0JIOz3kqYBXYw5g088WxdVInrDecu3miBkoOodAKHlEwmsCMofHqNKXScHYduK4N
         UsZg==
X-Gm-Message-State: AOAM5327MtaT0HRmGi7ciH6Q3aqCGsHU3K4PX4VbRKVGFLdMOzn9F7JD
        HJDNZmuBFrOqE9U3hyEt3B4wg2T5HwQ=
X-Google-Smtp-Source: ABdhPJxlGkyBIkvgx6uUXbRueFBanliWUvsag8uFhEt41803os3z3qj2sveWxbvG1DJo8cegwv+pRw==
X-Received: by 2002:a05:6808:f11:b0:2ef:1a43:177c with SMTP id m17-20020a0568080f1100b002ef1a43177cmr793769oiw.73.1649452886552;
        Fri, 08 Apr 2022 14:21:26 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000de98fe4869sm9950375oab.35.2022.04.08.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:21:25 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        maccraft123mc@gmail.com, jon.lin@rock-chips.com, sre@kernel.org,
        heiko@sntech.de, krzk+dt@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/4 v6] power: supply: Add Support for RK817 Charger
Date:   Fri,  8 Apr 2022 16:21:17 -0500
Message-Id: <20220408212121.9368-1-macroalpha82@gmail.com>
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


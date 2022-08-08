Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB87058CCC5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Aug 2022 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiHHRiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Aug 2022 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHHRiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2022 13:38:19 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7C4140B5;
        Mon,  8 Aug 2022 10:38:19 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so6946530otb.5;
        Mon, 08 Aug 2022 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LaM1Il9dI8a8vYNX4gN0hH1DxnTq/+g/W65fQiFlt+c=;
        b=Z6p5g/sMyWvF87n/OmuxEhJ9JDvumylNRBB2ncNdH40u0+UYGtMFzYgtjg4IVfMWUW
         AulNd1DjTSmjzyd02JziOQkILZLab9y4hrpP7ciiFc8pEoUzSggNv4Wk/d1onvlhkdIx
         joT2GezLn0/CLTuMHA1LAEnpE3zujurhMVp1vXhK8cgrRsWDewQED1L9ass2cQxQ4qTV
         ybbbpYqaKvGYdzSpNzsKJaux2GiDcnhTFv6Jy4SFticomdxfkBrspqplZMHUPZitGyx/
         cx/cNks1ZBihvMd02iFxHm1+aQMxijB40cids0DYSxmFhK+PyPP4O840vC9S0MhVHmtL
         qmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LaM1Il9dI8a8vYNX4gN0hH1DxnTq/+g/W65fQiFlt+c=;
        b=VT65WNMjjB9Cq8jHGTCWJcVhVTJtIx69cbu5igbHBAJ8u5BkAsymsB+YcCnjtL9q8I
         4Ae6q4qhJhSWVqsu9BD2R8xFJ0nrc295LrzNcrxrDyrjha0dEP9VSDr3HzUdA1uLkxpE
         gCfgKs1to9QxftPTu0gb1/KO9P+WsJksqwsPpS2a5HshJHRIfEbdTD8ZfVnCPCH5TlVb
         htDU+wbBK6Ol7emOolH6h3oh9cXzgDkK2HAgGKD4A/5w1MHreLLxzUmg85tUf6QXndJU
         PkMRcYVTanVerSusNQ2OEO/UnFmA8vksxoKLvnDaH1LEOkWbo2yvNVIHIzMwp2PBahQb
         Z+aQ==
X-Gm-Message-State: ACgBeo2841Doc7J05fwNPaGZSjHrSZxDTiPXH77fYJRtHAQ/8qZa6lOJ
        p0pqhwBa/ctIDnDkh2q/oXn45ftrZI4=
X-Google-Smtp-Source: AA6agR5MuwogWldfhAEFDPCabgQgOauUPdObIKhTacG+jHpPPPLkq1/PT8nVYQmcPFBYAZ//j50u0A==
X-Received: by 2002:a05:6830:44a2:b0:61c:bc05:3158 with SMTP id r34-20020a05683044a200b0061cbc053158mr7257342otv.370.1659980298058;
        Mon, 08 Aug 2022 10:38:18 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id s2-20020a056870248200b0010edfa2b0e8sm2429202oaq.50.2022.08.08.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:38:17 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v8 0/4] power: supply: Add Support for RK817 Charger
Date:   Mon,  8 Aug 2022 12:38:05 -0500
Message-Id: <20220808173809.11320-1-macroalpha82@gmail.com>
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

 .../bindings/mfd/rockchip,rk817.yaml          |   48 +
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |   26 +
 drivers/mfd/rk808.c                           |   16 +-
 drivers/power/supply/Kconfig                  |    6 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/rk817_charger.c          | 1151 +++++++++++++++++
 include/linux/mfd/rk808.h                     |   91 ++
 7 files changed, 1338 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/supply/rk817_charger.c

-- 
2.25.1


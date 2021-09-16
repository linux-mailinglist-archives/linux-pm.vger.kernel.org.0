Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951A740EAF2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhIPTnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhIPTne (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 15:43:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC9C061574;
        Thu, 16 Sep 2021 12:42:13 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so9767071otf.6;
        Thu, 16 Sep 2021 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7s0jc31HPLAs0gXkmeRMnAPIKh72hl0mqHTuEnX+aY=;
        b=dTNR08u17lmNeUCGekNoFNPAymVJ+EvYhpaWHvM3EFTIe2VmVwIoTOF3QkpLsHjlNy
         pd0ZClvLf/KnscJkMwN7Cs3R9D7Jj6V3TLMQ7a7l6eBdPty6zfyEO31AZJB3zGgDTrap
         eVOGDptGIcCdVUNVbjRZRoYyFBDX8u93xWyTf/cKc63suVAtFaFxoT6mLog93rEVdhqR
         d2xPcBOvXbsrw+zL1VBIfrNdWVok02S+E2qE7VTrNcKwnL2FxTdyO2R4/c02HP+Illum
         D/RfAkEn/55XI9dartV1w7KaIcEO74gjLoEc1GH8vo55PBxNWVGC+F7bklXJrA4KkwRP
         y9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7s0jc31HPLAs0gXkmeRMnAPIKh72hl0mqHTuEnX+aY=;
        b=xOfsQPZ7QEP2VZe1ijfldjjxVcBEqO4WDm2JoQXb+XJDQi82tFno0Wa2X/xfIt/s8g
         pQVEf4F8IEAW9lkvI8QJzwXMEhC49sFsS2Q/gJRstHsDDUZhMcTBb7xuQvzBVMtXUIcz
         hRS04QS/SJ8tDPhbpLbZedKLuRt9nHn8n5ilBBS57wYdWCcHs1dT85oULU3q4Y06SALV
         JgEkQG5OG56QzzmAmg7C6bB/znTrGC6hTB6/qsPcrertdEHWvU2m9TSeNipUQo+VC0wM
         MNBSxJZB6tF+iFbvuNUiKzpDULHKEd+gbmi226ttk8WP7IVhb/wzMOtLanf7BpLBLtdt
         6tNw==
X-Gm-Message-State: AOAM530ybVZYQfYbLjKguX+ZqGkTVL0z+qIWcO7bad2H4hEzHxEbM97O
        p6PACNfrWXFzalsb9rd4zro=
X-Google-Smtp-Source: ABdhPJzIoMzJpohFqllA5LVocwtyw6xysu0DyOhL6PvnjBo49cXhoyjk3ExnnR4ZJ2MwsflFQCseig==
X-Received: by 2002:a9d:71c6:: with SMTP id z6mr6181684otj.382.1631821333103;
        Thu, 16 Sep 2021 12:42:13 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id c10sm963359ooi.11.2021.09.16.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:42:12 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, heiko@sntech.de,
        sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 RESEND 0/4] power: supply: Add Support for RK817 Charger
Date:   Thu, 16 Sep 2021 14:42:04 -0500
Message-Id: <20210916194208.10387-1-macroalpha82@gmail.com>
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


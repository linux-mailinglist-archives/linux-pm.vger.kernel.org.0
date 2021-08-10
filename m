Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9573E512C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 04:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhHJCzN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 22:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhHJCzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 22:55:12 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F93C0613D3;
        Mon,  9 Aug 2021 19:54:51 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so20467682oti.0;
        Mon, 09 Aug 2021 19:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hp5elchFMSgljRTpgVl4ksQKLgHUDuHAq3O323royD8=;
        b=ToXi3M/FBrMPWLWRVLSfG93Yb3qdjE1LpXnI2cR4Lfa5qIVyph+6pw4F8IwaoWu+t6
         2pxkSa03pXMtPCSIEoPuWuvSF6xLTRO9sMvvVXTZEzLWws1mkke2Q1ZktydubzHl9ars
         WquzLIid6BQwPp8IUrYbezgyYAUV2Vo/heNOe5NuAJ4OqdLLQlLEHla1j+hh83JWWets
         W8fvbDHbaS8ASPZJDDVs/rgb4vmrZBBCbZ5JCBkz91StPyR48NKqtGpNxwg63woNtu80
         X7Wpn56MAM/1Ij8WyBXAl8h2LeUmRg1djFfNZkKSpgmNepZQEDP23cklAVVST9JYxXKk
         NqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hp5elchFMSgljRTpgVl4ksQKLgHUDuHAq3O323royD8=;
        b=A/r0n04hSl6uZhmZOqQwyPo6TK4HYCvFneZcfASZUxaqVTgWrMO992p6uIV0V6YOzb
         /u1qgC2lQJfZKYqkUnNAJBW84LY4/n0QS9yeM+4CGTXgseAKBDK6pEX4242GiRA2taaW
         zkmJMYF7NLJwNrSmakxDLRqmha9AOrNErXajt11n0m0xsOL7d6hChYD215HwQmffXNqE
         QZBv1d738zqhqjKH6vgFazBns9Y+fqGhC5d2pPHx7Y0wM8C/uND2rNO7CNUybLHWYAhb
         I1VBXnFNAPBgqedbeppt9DKllN2wBQG+Vk7J4KO81yP79jEjZRzcBFerjGzKhukhGw7W
         gExA==
X-Gm-Message-State: AOAM532ZTNTHwS/bnla8cfCn1B5EnZuXcx9o7Ga0Yd8A/ZooI+HZ48Aw
        /JLbsno4cKecUvX5GIc9TbI1q6iJIhc=
X-Google-Smtp-Source: ABdhPJxwJJCdLwwwG/zkqNWug2qEx45WhKQV0FyuMGaceyHb//lIfuvWxPbL+ekzOSLYhFG7+PHagw==
X-Received: by 2002:a05:6830:43a3:: with SMTP id s35mr18606061otv.262.1628564090599;
        Mon, 09 Aug 2021 19:54:50 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id h187sm3654898oif.48.2021.08.09.19.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 19:54:50 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, lee.jones@linaro.org, pgwipeout@gmail.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v3 0/4] power: supply: Add Support for RK817 Charger
Date:   Mon,  9 Aug 2021 21:54:32 -0500
Message-Id: <20210810025436.23367-1-macroalpha82@gmail.com>
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

 .../devicetree/bindings/mfd/rk808.txt         |  36 +-
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  26 +
 drivers/mfd/rk808.c                           |  16 +-
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rk817_charger.c          | 922 ++++++++++++++++++
 include/linux/mfd/rk808.h                     |  87 ++
 7 files changed, 1092 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/supply/rk817_charger.c

-- 
2.25.1


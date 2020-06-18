Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3C1FF343
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgFRNiZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbgFRNiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 09:38:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B2AC0613ED
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 06:38:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u26so6696848wmn.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwhiK4RhjFtcOdjK6HryhHeUuPTC4xHkMOd8pTbbj6k=;
        b=hIGjX7h4Ed1aDRIN8UX7il9ILTJaATXT2LwE1e9A+0Ttl1p93wik5BtfFvtdvm58Iy
         A4VRKDcRzoev7Krg3Cc+TpN1ZPcwQR1ahuc7rE7qJMYKav6VGORhEcNYUNtgiJ8htn0a
         2MjtDZSe4HhO9uH02//oio7CVGAV3FCf3Qr2fipRHVL7M5YXT/O8p774+V3c3iKfm78K
         cQhd1YkMZAzZ3bMtoxWCMFDXp5vtiXza1///NKM30bIftKHZ7s3M7WmMeKGW0cw4z7Wu
         WfsajUcRsp6vCocvj6gm8VHUrrMIhsTSB/hq3epoobz/wf15csEEEudniOiC6pG6A4OP
         fxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwhiK4RhjFtcOdjK6HryhHeUuPTC4xHkMOd8pTbbj6k=;
        b=aqiM3Pwn6k69IKBWb19Cu9glUukCbZFnYZPaAL7b3SubGkXEi2o9T6BMByFs2PNo3U
         X5ZiBr4XFYcLLPGwHvzB6EW3a+Qvc70o/qeiXAAI9Yjzk2u6NGE58/Q2zrJPRwbhEzCo
         RTKWOdy6FLFhEpVBJmsgPWXTsSQ9VQPZRebk6A3+NBJYwpr/1kipEM1bpb8JAt+rq4PI
         gd0mcOQpVi5k4lRpVjFUEVeaUzV444o6VbcaeI9vQkUEJ3UxyF4ixW9ZW1pSLpvSJq9a
         /9QC29mTz6KMd/N+nXrp6WXaWVI8b69kmdwvlUAyDIlgGi8BfBkU1qfGqiNoizLq2Rk2
         +TNA==
X-Gm-Message-State: AOAM533md5X95Py13uvLQOmhuc8u4M2IlFGC7s8IHEKYvk78Xz0l4kVZ
        Qe91q5zWJU27VVcjnmDIx25HdVgmmnXwbQ==
X-Google-Smtp-Source: ABdhPJxM1M3oFBMHiRXgEOIQ+T9TXk+NQLLWwxlZklKGkaqQUZVzMOTHIzXFfi0wTEV5dRjIqEAhdQ==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr4157067wml.188.1592487502207;
        Thu, 18 Jun 2020 06:38:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id o82sm3707956wmo.40.2020.06.18.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:38:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lee.jones@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Subject: [PATCH v4 0/2] mfd: Add support for Khadas Microcontroller
Date:   Thu, 18 Jun 2020 15:38:16 +0200
Message-Id: <20200618133818.15857-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new Khadas VIM2, VIM3 and Edge boards embeds an on-board microcontroller
connected via I2C.

This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
boards.

It has multiple boot control features like password check, power-on
options, power-off control and system FAN control on recent boards.

Thie serie adds :
- the Thermal Cooling cell driver
- add support into the Khadas VIM3/VIM3L DT

Changes since v3 at [4]:
- Removed Applied patches 1, 2 & 4
- Added reviewed-by tags for patch 3 & 5

Changes since v2 at [3]:
- Removed NVMEM driver for separate submission
- fixed MFD driver, header and Kconfig
- fixed Thermal Kconfig
- fixed MAINTAINERS files and path

Changes since RFC v1 at [2]:
- moved hwmon driver to thermal-only
- moved the SM1 thermal nodes in a separate serie
- added the bindings review tag from rob

[1] http://lore.kernel.org/r/20200512093916.19676-1-narmstrong@baylibre.com
[2] http://lore.kernel.org/r/20200421080102.22796-1-narmstrong@baylibre.com
[3] http://lore.kernel.org/r/20200512132613.31507-1-narmstrong@baylibre.com
[4] http://lore.kernel.org/r/20200608091739.2368-1-narmstrong@baylibre.com

Neil Armstrong (2):
  thermal: add support for the MCU controlled FAN on Khadas boards
  arm64: dts: meson-khadas-vim3: add Khadas MCU nodes

 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 +++
 drivers/thermal/Kconfig                       |  11 ++
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/khadas_mcu_fan.c              | 174 ++++++++++++++++++
 4 files changed, 209 insertions(+)
 create mode 100644 drivers/thermal/khadas_mcu_fan.c

-- 
2.22.0


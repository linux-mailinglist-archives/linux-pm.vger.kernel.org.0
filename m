Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E293D6721
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 21:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhGZSVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 14:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbhGZSVO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 14:21:14 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B60EC061757
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 12:01:43 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 21so12113380oin.8
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxgV/WZYrRnUNYZoq1PatOk9eKE1z40c/weknMKba3U=;
        b=oBkaZgqS+ToTCdwLGArw6TJQMwc4jZflXv97ufoNQoyvX9NC06ytD13DLoEZKCDSgo
         Vh6hfgmPuHRY5MjtHMjQ5yH17nl0sd3V2urnFx1pWDtiarf4Qd4W5zMxg//4LLyijG0j
         px3XDSKO5NuCZCU1IsIm7ynKDhPjpTDxM5myLYslYZ42tPWxnUnsAYXcxvxq68oonRvV
         EEJWpeV583BtrAgQ3KBgkYr9+mm0Cp3bRqQ9wKU0D1Z6PW7210ojhwGCMkXnOYbA6BAc
         1UYKXNUGGGIHHjgYJM17vJ6cOdecJu0sSaumPz6oUgWHM63RueW1uTKErIo1vp74r7ZU
         awrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxgV/WZYrRnUNYZoq1PatOk9eKE1z40c/weknMKba3U=;
        b=KhvsBOX5p1g3jjW8/mJnaOvwrC3sE00JGsJorwD6AFFl1j4o/QMM3kvFn+/BpTvcJM
         PBQaCtI70LUgmQp8GUouK/LE4S191ZjqJBEx2ko96oJbuePiYEMOrdVaNXvI4QddbyzD
         OMNVl8J80JG4zrjhAOQYtKdfVUOZXWiv//GCv72izndbBNoQUduYVEWstrfHoj1UdweT
         esR7gHZ4qVUvh0Ub/HzpIJtgy9ALpKXcxY9Wu+pVVefWrOlItsHfUVxThU73f8rpKQPX
         p3JA2LsVPGGATFE3n9uKdrm+5Cf/Eu2Ps2M3k+IRCDFYA+8VQOKXHnxZak4LlwJ3BTbe
         AYkw==
X-Gm-Message-State: AOAM532GsRgmiNY5dYtO21rTMhOdaSMART+822dTWyNpd25kZZH3Hjct
        zGOZOTiiPeqHM/GYeqTqYE6HfE/Chjw=
X-Google-Smtp-Source: ABdhPJynKmXLpZMrOUT118x9dz/3gv15UTef1yGOoG1U+ALqocuDZQjO4+fElncSE+N+c7WO6g2guw==
X-Received: by 2002:aca:b68a:: with SMTP id g132mr325537oif.139.1627326102435;
        Mon, 26 Jul 2021 12:01:42 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id v7sm106610ooj.46.2021.07.26.12.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:01:41 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, maccraft123mc@gmail.com,
        sre@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v2 0/4] power: supply: Add Support for RK817 Charger
Date:   Mon, 26 Jul 2021 14:01:26 -0500
Message-Id: <20210726190130.1973-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

As this is my first charger driver, I'm submitting it as an RFC so I
can get input from the community on what else is needed to make the
driver consistent with the quality upstream expects.

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

Changes from V1:

 - Fixed a CLANG warning regarding an uninitalized variable.
 - Fixed a CLANG warning regarding a pointer as a bool value always
   returning as true.
 - Added Maya Matuszczyk to the Signed-off-by.

Chris Morgan (4):
  [RFC v2 1/4] dt-bindings: Add Rockchip rk817 battery charger support
  [RFC v2 2/4] mfd: Add Rockchip rk817 battery charger support
  [RFC v2 3/4] power: supply: Add charger driver for Rockchip RK817
  [RFC 4/4] arm64: dts: rockchip: add rk817 charger to Odroid Go Advance

 .../devicetree/bindings/mfd/rk808.txt         |  35 +-
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  25 +
 drivers/mfd/rk808.c                           |  16 +-
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rk817_charger.c          | 932 ++++++++++++++++++
 include/linux/mfd/rk808.h                     |  87 ++
 7 files changed, 1099 insertions(+), 3 deletions(-)
 create mode 100644 drivers/power/supply/rk817_charger.c

-- 
2.25.1


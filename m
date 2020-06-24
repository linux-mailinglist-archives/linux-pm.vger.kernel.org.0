Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B92078C7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404723AbgFXQPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404681AbgFXQPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 12:15:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFD4C0613ED
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 09:15:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so2875973wmj.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OXl1VWgKNRCb648iCdiM0hRIiCL6AhzBqKEHJfyjiU=;
        b=qB6nG+KNrKtiZam3wMwJAbHJsDTlEi5ywCENbJGiAy/9gUHQzrWo/mlMOiLbh1UY45
         FrhwaE4dGPrFpoPYUGYx0/+QyOMPd9NhTaEp0tECkuEMTB5zenR1AEnWfsuHPecIaS40
         zPG2T3KkeE85K7IkzsqLajVYG6iStaPm93IThbUtJhjIy2Zr98UAhnToy2fIRJAClJRw
         KVQcZijjd4K8ZIU86mrCYHcIKXSAWJOpajk1oWIuxk7mMZEVxYjwD3J6ubhspYyde2yl
         tX0V6GpKBC+i2WCzq9B/yUkQnm+3BcWSMnFxexBGt582WyL6gYuSjcvkZVkqLOC8dZog
         PP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OXl1VWgKNRCb648iCdiM0hRIiCL6AhzBqKEHJfyjiU=;
        b=XhkoTerugfZC9rQBgqyivc4L30U6rI33dzWyNKyQIYZHZc2e2pxM4Nyh/DVZaF35PP
         7ieRA5lFysG/MSwBpbNIQeWBi+eybeIp06TazS497f+9Fe82hQkJrmSSS7UzmK+JT3pm
         xj2Zw3x6A4VxaVJYAfPD7QX87WY8WPr/o5vRpEE10+da23i2ZocdhwIeXeWU7vAVQLG3
         0gpczP+CCXifNUhPWTo7eNkCXkYUbzmLyv6WSWkw5m+iavC1xlGcU+RlDHuz9ATVvGmM
         dV3a8izlIKUy1+F9oG69/y6BahYZkXw5a11FsoKaBDVSPtpCKHGyUxXyh2SppLYrDXLt
         n3DA==
X-Gm-Message-State: AOAM531RLA94aSb/EygN2yaVSHY/uM1FugHiTuWh76ClL08UV/VqY9Gd
        /2z2jTpsOIC9mgr6fh4Svmi2dQ==
X-Google-Smtp-Source: ABdhPJwfsCqowmEbq8vy1eMaii9xA0WfQR0mUXBz8KRSJZyN8d8xCxvc1FQZ4gDIDuT/R9Xz5DEVdw==
X-Received: by 2002:a1c:2b81:: with SMTP id r123mr2106109wmr.72.1593015331738;
        Wed, 24 Jun 2020 09:15:31 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:89ac:d9e8:f44c:b137])
        by smtp.gmail.com with ESMTPSA id t15sm8716207wmj.14.2020.06.24.09.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 09:15:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lee.jones@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Subject: [PATCH v5 0/2] *mfd: Add support for Khadas Microcontroller
Date:   Wed, 24 Jun 2020 18:15:26 +0200
Message-Id: <20200624161528.12664-1-narmstrong@baylibre.com>
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

Changes since v4 at [5]:
- Removed ctx checks in thermal driver
- Removed the useless khadas_mcu_fan_disable() helper in thermal driver
- Fixed a small indentation issue in thermal driver

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
[5] http://lore.kernel.org/r/20200618133818.15857-1-narmstrong@baylibre.com

Neil Armstrong (2):
  thermal: add support for the MCU controlled FAN on Khadas boards
  arm64: dts: meson-khadas-vim3: add Khadas MCU nodes

 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 +++
 drivers/thermal/Kconfig                       |  11 ++
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/khadas_mcu_fan.c              | 162 ++++++++++++++++++
 4 files changed, 197 insertions(+)
 create mode 100644 drivers/thermal/khadas_mcu_fan.c

-- 
2.22.0


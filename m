Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED6C447B6A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 08:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhKHH6C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 02:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbhKHH6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 02:58:01 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798BC061570;
        Sun,  7 Nov 2021 23:55:17 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q126so10495921pgq.13;
        Sun, 07 Nov 2021 23:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=pvqPSiHglh+tgwa09KnyvArHLxkBsvPOohaV0vHhBok=;
        b=h6/TKkxNga6mtcYY//j82Dt4lsQKKe21TjiF6GaUA35aCV4sVHaMakk5jL95Tg/oP0
         yFIBgpSaKtM92TJnZVTRbYirIF9ESjE4uvzDNmMUuOifOh4Id4VUsfTtvoiyOoOq1eU6
         8ecGdCuQpx2Ux/QCwcl3OeJxz1jb1FmcAtUFAc1JwTEpOotlCLorCgYHxF1af88ejyWG
         HmZTHLVqjoCFhmSKSqPHJn6vnkEx3ltoCT8B+hoMFlvU3d/L4KdsJsKv68y2cQOHay2D
         /BoMqzChsg9ADDEFPAaTrJcSfw9jgOxxk7BZ5LYs98MrrdusQNZRIpbgf1epbBJvr/d7
         LxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pvqPSiHglh+tgwa09KnyvArHLxkBsvPOohaV0vHhBok=;
        b=ntmVsKefovqMmuGEE04dVkyyp6ZzbQxr8h5LYq8mqEBbWsJMzndFSiiy2iNTugyUdq
         Qp9BNvhcnuo/8He+Csd1Bbv60eY62h2ohsbIT/PgOw14kVnfvaoJeCnlA8vj6awdjTDM
         TLwUX7dKXxORheurpeEkoVFfFO6kY1aWyUzKpRZ5MTLKwZu1nskzx89Hgt4I141r/ik1
         IxxmNoQTPkDi+ga9G7CoQkGA7UCoJtB8f+gwTd4jesx3v1kENXZTxxKOKP3g5nZmocvz
         kEPdg5LTqFUXlxw+XPJLRYKIefyUqi3RZc3GJh0vjL5HEB0aKcUnVbROcvjfxsGwmoqe
         IB5g==
X-Gm-Message-State: AOAM532aeW0x7QW3wRLqI8rMPaQUBVMtsozB1mxMzBS4NR9fKH4gv5Aw
        Tws8xiBhbk7JFQrO3Q6qs1c=
X-Google-Smtp-Source: ABdhPJy8sGQvw5pDbl7DBLK5/cfTt8Gxn7fjM1Zi0IEgcuCHUWSS//1foL3ovJG1Rh5ITi8dbyx/kg==
X-Received: by 2002:a05:6a00:15ca:b0:49f:d22b:afff with SMTP id o10-20020a056a0015ca00b0049fd22bafffmr6612023pfu.35.1636358117543;
        Sun, 07 Nov 2021 23:55:17 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id ep15sm1631150pjb.3.2021.11.07.23.55.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Nov 2021 23:55:17 -0800 (PST)
From:   Edwin chiu <edwinchiu0505tw@gmail.com>
X-Google-Original-From: Edwin chiu <edwin.chiu@sunplus.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     Edwin chiu <edwin.chiu@sunplus.com>
Subject: [PATCH 0/2] Add cpuidle driver for Sunplus SP7021
Date:   Mon,  8 Nov 2021 15:55:08 +0800
Message-Id: <cover.1636356928.git.edwin.chiu@sunplus.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a patch series for cpuidle driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and 
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Edwin chiu (2):
  dt-bingings:arm:sunplus:add sp7021 compatible string to
    sunplus,idle-state.yaml
  cpuidle:sunplus:create cpuidle driver for sunplus sp7021

 .../bindings/arm/sunplus/sunplus,idle-state.yaml   |  55 ++++++
 MAINTAINERS                                        |   9 +
 drivers/cpuidle/Kconfig.arm                        |   7 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-sunplus.c                  | 185 +++++++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h      |  14 ++
 6 files changed, 271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
 create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

-- 
2.7.4


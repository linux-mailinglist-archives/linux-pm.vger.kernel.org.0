Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA824ED97
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHWOKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgHWOKB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 10:10:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4865C061573;
        Sun, 23 Aug 2020 07:10:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 12so3096124lfb.11;
        Sun, 23 Aug 2020 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NANA31JWruLrcn0siO3feQHx3tJIbgJqM7ymNtCvW4I=;
        b=se7nC3ieNSWbQcrWRlZWnEm0UwbgQEkWzMIJyNWKVgztbcdN5FVT8yZmPCfoBDrVYL
         Pl6s3ffUjrOkZePrtacE6bfgcuPUsk9mkMpAFHlkmLqUIyvOawp/Z+bIbbimQO07ESn0
         Q6Pv817OwLR+EMmgKOlVMRkZQB6henNF5bAv07lKSJehzTUnL5O+7OKE9DycMoL4k6yJ
         MV6AwKfga4/ofhETYNmHUnif7oqnIY2B2JgUdfNvJPFduS7KjR9dpRQYuv9YH36jGAp2
         UM3beAvcU16jlA826yXrouYf4/CiA/l2iDWE+rtEadyIcICZGcB5f4awho4tf4M8OCIG
         shHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NANA31JWruLrcn0siO3feQHx3tJIbgJqM7ymNtCvW4I=;
        b=H2MklGk71A5MbUbZ92iNzvimXrp57HgZNiQhwWa5Fe+yXFJ4waOtlH/xSuNhjWi/DQ
         2F7LP2vfCIaKc6ll0sq42VKtz+VLItHSETpgCYocDsyviXNGDabzxR2JhvJsw3aI5lqC
         1vN0mzpxAkZajAzZ6Z3khSGUi5WhyG+mhGTzsWZGZlw1V2JhL/QhRjowXfKhM/b5hbtQ
         KvQiBfe/F1bjVmYM5dHUtFwQpJobSPLE2Rrj+ld5mfoamJLlTZJY+PLXThTpAH8MwJE8
         AzSFZt2A9xTmoRsSZhsL/vmf8KXBAW9FaxqQzPVTobyIUzTrhpwIqsL+YUKIoFNSfAQN
         //yQ==
X-Gm-Message-State: AOAM531793wQDjPZLM9Bvz4YPCxhCPjDQCub9i7GrjwnThmaMDwhbHv7
        dUQxkw+jmMzMSzEXPSwnpWo=
X-Google-Smtp-Source: ABdhPJzz2yv1BREoxRroH14+MKjC5hu6os1OBV+zXQ2MCDvKPCCgUYXPDeHI0kBsS1R+ICioZP8o2w==
X-Received: by 2002:a19:848d:: with SMTP id g135mr649800lfd.1.1598191799388;
        Sun, 23 Aug 2020 07:09:59 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b17sm1641342ljp.9.2020.08.23.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 07:09:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] Introduce Embedded Controller driver for Acer A500
Date:   Sun, 23 Aug 2020 17:08:40 +0300
Message-Id: <20200823140846.19299-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello!

This series adds support for the Embedded Controller which is found on
Acer Iconia Tab A500 (Android tablet device).

The Embedded Controller is ENE KB930 and it's running firmware customized
for the A500. The firmware interface may be reused by some other sibling
Acer tablets, although none of those tablets are supported in upstream yet.
Please review and apply, thanks in advance!

ATTENTION! This series depends on a-yet-unapplied patch from Lubomir Rintel
           which adds the device-tree binding for the ENE controller [1].

           It also depend on the pending patch that adds battery temperature
           properties to the battery binding [2].

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20200309203818.31266-4-lkundrak@v3.sk/
[2] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200813213409.24222-2-digetx@gmail.com/

Dmitry Osipenko (6):
  mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
  power: supply: Add battery gauge driver for Acer Iconia Tab A500
  leds: Add driver for Acer Iconia Tab A500
  dt-bindings: mfd: ene-kb3930: Add compatibles for KB930 and Acer A500
  dt-bindings: mfd: ene-kb3930: Document power-supplies and
    monitored-battery properties
  ARM: tegra: acer-a500: Add Embedded Controller

 .../devicetree/bindings/mfd/ene-kb3930.yaml   |  23 +-
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  17 +
 drivers/leds/Kconfig                          |   7 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-acer-a500.c                 | 121 ++++++
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/acer-ec-a500.c                    | 196 ++++++++++
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/acer_a500_battery.c      | 369 ++++++++++++++++++
 include/linux/mfd/acer-ec-a500.h              |  80 ++++
 12 files changed, 831 insertions(+), 1 deletion(-)
 create mode 100644 drivers/leds/leds-acer-a500.c
 create mode 100644 drivers/mfd/acer-ec-a500.c
 create mode 100644 drivers/power/supply/acer_a500_battery.c
 create mode 100644 include/linux/mfd/acer-ec-a500.h

-- 
2.27.0


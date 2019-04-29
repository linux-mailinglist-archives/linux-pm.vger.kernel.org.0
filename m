Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6740EDB9E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfD2FsF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 01:48:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46827 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfD2FsF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 01:48:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so4516180pll.13;
        Sun, 28 Apr 2019 22:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLT7t8PBRMyNajJ9X5FXiY9soaMVZaxDHWbzSb9y91M=;
        b=PTModMY29lrcG90hHUqbFV1t0cDIUYJe4jHhcGKoiqS8xvcJp80gXB6JcldK7YKWxA
         /UENjQ16F5PsTuXL0jaSE3xhfBJgo47VajDeYhqIt8MSb2UU0GBfWlUB4R2/h76E9cZp
         EaQxOjXKZ3ZgcprbwhiC2fKG51PcWJsLhMcHIz1iZsLVf+DRc0W88YpunNBhDMTFzUA8
         X18jdal6rY/XTbiwbCQcmBn5y4myO1l5R7Ds5Nt638FE/TwtTesjBe8qs3KqjFo2kBRp
         cs0QNeZgaupb/RvvauqPBMahIf1/Y6MFsOMJPjjRbAYKRU6DP/yLosIfkIS2pUUIiUTn
         HC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLT7t8PBRMyNajJ9X5FXiY9soaMVZaxDHWbzSb9y91M=;
        b=oJsLNi1ISI8rxyVrMbgE90lsRwfdmaKp8VJb8Wt0Yl8yw34DN8GapHrgmsZFYvl3Ma
         5FPHYJwqbhBERLXJEM7HiudvinaQByVkm+KG/aUbhp/AdrHA0vT/Z4ZPhL01yry6RsGB
         g58ndAUeYd28IWeErvpV7/a8rt2iWC8StVXXee4lkJQM6oSK+o2yLEUrac+lsZ7wXmAR
         5ljOdJeAbL1BxRWkVoeicm+sYY8CZGQ8Nt7kSa/t/Tcfp4NZJY5ZvmA3ofosN8r5wZsk
         AxyqPYm5xXWWmFvS7jR0W5Avy38Mt0JGMAxyXnUhyb6MlKawLlHYlD/baFQPb6ZjYdfz
         n51g==
X-Gm-Message-State: APjAAAUJjWAkEPlUFe4mcMnX+sSJYMpNjd39uCDR5yBiKEG44Oju7gJH
        7vgWIgNHz9CmIhGYsXjPIk7Tfeu8nOk=
X-Google-Smtp-Source: APXvYqxBi/aUOK0/Q3hwpDWsvW4lM370uMGUyXQQ9rPNl0ysuxt06HmaVviJQkapq70DLnPVrCbM4A==
X-Received: by 2002:a17:902:a585:: with SMTP id az5mr26003981plb.261.1556516883878;
        Sun, 28 Apr 2019 22:48:03 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g10sm37856567pgq.54.2019.04.28.22.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 22:48:02 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Driver for UCS1002
Date:   Sun, 28 Apr 2019 22:47:38 -0700
Message-Id: <20190429054741.7286-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Everyone:

This small series adds a driver for UCS1002 Programmable USB Port
Power Controller with Charger Emulation. See [page] for product page
and [datasheet] for device dataseet. Hopefully each individual patch
is self explanatory.

Note that this series is a revival of the upstreaming effort by Enric
Balletbo Serra last version of which can be found at [original-effort]

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v1]:

    - Moved IRQ trigger specification to DT

    - Fixed silent error paths in probe()
    
    - Dropped error message in ucs1002_set_max_current()

    - Fixed license mismatch

    - Changed the driver to configure the chip to BC1.2 CDP by default

    - Made other small fixes as per feedback for v1

[v1] https://lore.kernel.org/lkml/20190417084457.28747-1-andrew.smirnov@gmail.com/
[page] https://www.microchip.com/wwwproducts/en/UCS1002-2
[datasheet] https://ww1.microchip.com/downloads/en/DeviceDoc/UCS1002-2%20Data%20Sheet.pdf
[original-effort] https://lore.kernel.org/lkml/1460705181-10493-1-git-send-email-enric.balletbo@collabora.com/

Andrey Smirnov (3):
  power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
  power: supply: Add driver for Microchip UCS1002
  dt-bindings: power: supply: Add bindings for Microchip UCS1002

 .../power/supply/microchip,ucs1002.txt        |  27 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/power_supply_sysfs.c     |   2 +-
 drivers/power/supply/ucs1002_power.c          | 646 ++++++++++++++++++
 include/linux/power_supply.h                  |   1 +
 6 files changed, 685 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
 create mode 100644 drivers/power/supply/ucs1002_power.c

-- 
2.20.1


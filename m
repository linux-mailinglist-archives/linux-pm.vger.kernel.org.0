Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7102A10443
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 05:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfEADev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 23:34:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33257 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEADeu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 23:34:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so2758061pfk.0;
        Tue, 30 Apr 2019 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPsVB2S9FC30k5ZDF9TZAWElHhifrxZfdzo+5rcy/7w=;
        b=dSeAplYcgPpHA7GV+7AMspoHKdxUW/iEIFzJ8nfRkqgg2Fua/DgBSY7Eyt3gfSrcVt
         SQmrONba1TbWF+tbaTkSxi9G5tIkgzPNqJLorDKWHQ7hS6Z8qaGViyuDcF2DlfAQ4l3E
         TZ2JP7/Q8NE6r/KoDF9tmKeBaQVDUVMnEFNOuHJIRv1DiizojkYj0XoEF704PUH7sV7T
         Ou1dcrv1W/JdOHr7dar1o8BbGk/VX7ImPItQf2w3aycqKd0PG6Vu1npmjbUQ4RwELuRF
         j+M2+ecqXNXeNWaS/bfn/UxejqwF9wn5tYXsNjs+gextF1ACOi58f6qcZlSAGXBvoiEG
         7ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPsVB2S9FC30k5ZDF9TZAWElHhifrxZfdzo+5rcy/7w=;
        b=uNEi6dRGC9bDBiOPGV3Fr/yCqVCYdVr9dfdMdExgXH0UxSMp53/6klHSvUJ8Q5fqNd
         0I3thjVTn/3OzmlKf0f8UfzmkexVLdWgXU9MVTSGaxQDSHG74RsuQKGNnuOtwqJFZneH
         y80akCbHT+s9PzBGl4HfdpZ7sluKU3rfH1i/4OP+JnEnxl2IgaUJEyL+rgtmlwA7BDee
         hvSONLLncoR62fRk0n0C7Hc8WM31n51tPStACoxYNdTnm0Btzt4gf0hNA6Z3UE9nBkHy
         aOiaU7UP72OSZEFF48fE0sRtKYozDuB1grb75numOUqEufOSClnQi/C4Iv4hGE6/rw+A
         MyIQ==
X-Gm-Message-State: APjAAAXS0F/WPtP2XrD9p6eYCzK1y6R0ARaTC+vtgAaXPMO8ucCh3SaL
        Rj9eA/oSP95I5VUv7f+yDRpB2kpIAos=
X-Google-Smtp-Source: APXvYqyIK0hLNhe3zMquhHD1+pgFu48T+Ge+QePKPU4G8iESHt7J94zXTAj2+d5q9os9otiZbG5aZw==
X-Received: by 2002:a63:778b:: with SMTP id s133mr8179547pgc.198.1556681689234;
        Tue, 30 Apr 2019 20:34:49 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id r11sm47421067pga.87.2019.04.30.20.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 20:34:47 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Driver for UCS1002
Date:   Tue, 30 Apr 2019 20:34:31 -0700
Message-Id: <20190501033434.18548-1-andrew.smirnov@gmail.com>
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

Changes since [v4]:

    - Chagned "interrupts-extended" -> "interrupts" in DT bindings description

    - Collected Reviewed-by from Rob

Changes since [v3]:

    - Added a check for negative values to ucs1002_set_usb_type()

Changes since [v2]:

    - Fixed a bug pointed out by Lucas

Changes since [v1]:

    - Moved IRQ trigger specification to DT

    - Fixed silent error paths in probe()
    
    - Dropped error message in ucs1002_set_max_current()

    - Fixed license mismatch

    - Changed the driver to configure the chip to BC1.2 CDP by default

    - Made other small fixes as per feedback for v1

[v4] https://lore.kernel.org/lkml/20190430064557.28469-1-andrew.smirnov@gmail.com
[v3] https://lore.kernel.org/lkml/20190429195349.20335-1-andrew.smirnov@gmail.com
[v2] https://lore.kernel.org/lkml/20190429054741.7286-1-andrew.smirnov@gmail.com
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


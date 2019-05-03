Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E726132A7
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfECRA5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 13:00:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43907 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfECRA5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 13:00:57 -0400
Received: by mail-io1-f65.google.com with SMTP id v9so5753833iol.10;
        Fri, 03 May 2019 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTbUIhgZYyKpsDYDRp4MfMyEXJIR47VXE6EtVxEkJu0=;
        b=mkmHELI/w4WO18UJsmI8W+qPs6MVtLJfL2UnMEYKjpOqQ9s+ZoSzUkhq8TMenx9fAd
         vtvZ+wFz8kufYakunf+udHAv7PqiblNiMutSwoabNQCLynS3SLMVSBDWNqBmUKHIA7aU
         BsVHatWsMPpg16Gra/EJCjqQUyPc9P3iYMzCwR6Imiwv8mOFLCu0KsjzxSA43BaXk80Z
         /mVwx3V1kB42IUbC8x2QMHddkyxEgNkUSZPIBrDCcshFHKODN3baYGtwqwj4XnuAeeOX
         jxywXScjmDY1tqPQOfWgYiH5zG2vzw+v2GobWcq+KYaRZ2PnxnScw7gjmmB1gdl8LQ1b
         OFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTbUIhgZYyKpsDYDRp4MfMyEXJIR47VXE6EtVxEkJu0=;
        b=IIL/bzlojUHeQnronjGA4drThNndmWrDWhGBVaj9+NMtzT1X+haAKDe3bDf/VBcinp
         GY3tE1Bbu6N2LLZiPWDZCOkEldsHZ8nrMZjAngYEG3tjJC3XFvbKybt8ezlJBgema6RZ
         1ORTm9Cw+a+sa4Ox/B9Yl1P/zCGFSF8piaGeDV1FpHhDsmVuG3RsZyk0TpzOUH04XBRL
         9S1Eb5zVVGTYk+lqO32jHORKa0uFPD7cpWaIKVxhZVpW7mpEs2ThK0a37u38TlUB9btS
         /J9VCW82mJnDFiVP9u9r5kwfzpeTCPdwL27ACKTPB/jvMQYdT5JKNn56fSCrwFayEGns
         iEaQ==
X-Gm-Message-State: APjAAAV9rh1WA8WgLdDbO1kkeNlPcKQIhApelbiSvaNPz+9Cj5Yq8n8y
        xDp+5r/Kfx19Rx1yUQ53XFKk8JcX
X-Google-Smtp-Source: APXvYqxLc8bElvECYOdB7Xyv2KXEZk73Rl2/Z+xbMljjSU7C78r3p1wUkPsuZN8b8ViQdP7LTGTScQ==
X-Received: by 2002:a5d:9a18:: with SMTP id s24mr2662210iol.200.1556902855739;
        Fri, 03 May 2019 10:00:55 -0700 (PDT)
Received: from localhost.localdomain (182-254-181-166.mobile.uscc.com. [166.181.254.182])
        by smtp.gmail.com with ESMTPSA id n184sm1342588itc.28.2019.05.03.10.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 10:00:54 -0700 (PDT)
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
Subject: [PATCH v6 0/3] Driver for UCS1002
Date:   Fri,  3 May 2019 12:00:39 -0500
Message-Id: <20190503170042.19334-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
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

Changes since [v5]:

    - Collected Reviewed-by for "power: supply: Add driver for
      Microchip UCS1002" from Guenter
    
    - Fixed Kconfig indentation issue

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

[v5] https://lore.kernel.org/lkml/20190501033434.18548-1-andrew.smirnov@gmail.com
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
2.21.0


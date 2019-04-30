Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F415DF0AC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 08:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfD3GqP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 02:46:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40621 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3GqO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 02:46:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so6371456pgl.7;
        Mon, 29 Apr 2019 23:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ny9jUsl8uuat0Ih56MKj3A5QL7L7pjAw7XWyUkIrdUQ=;
        b=DeSUdYeAG5RVmBI7UsYUqPrgBV5WFoJ6jNz0N1AUqRDtNdBqPhz42vN+XiwLSuYMqL
         WVkvd5mZX2cFaYBDG44etsB8dP2Sn2S2902GAtrR3g+1IMlIZZL0XqsyBQ12WiQqUsLS
         +5r3tVpvTRzg26ggz9Q2Gof83xHtTzbjYjq7A45Yop/rYNWL7IQMaTCYe3ddPecgy+PP
         VMbiIgzjUi2V+o9Mx1xiPfGzEpWq7NHwO5L0fJby6hELZ2EP0aDAmnT93uDoPkYoJsfG
         dpDYuBuFRsHXURuePtz5u57uHT5RNzmDZP022i1b5lQr5WvKHRXqpGU5ddR6j3Dvoc5p
         QRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ny9jUsl8uuat0Ih56MKj3A5QL7L7pjAw7XWyUkIrdUQ=;
        b=fm9D9NO4XjeMVwab4aTGVWoV8uYFTiR45u0+BTq1/rwNDWoL7njU7RuWBdPZ6eVZvN
         TadOSHO6rCCImYenSA3u3WaNJG+umtuvr9EPIaCmu5ZCpDPubF5TUVvuLhEV+EZ2Qv16
         5Bnvm/rq06GxhEarEpCr5Fs17h89IE0EdgA3/yz4kkx/RCb4bg2zOce4AzegQKXUgSZh
         GbjNwx3MD4LT19cIMQXJztKZMgazaAWc+b3WPNRyRzcjiZ1RwK1Z4MuejfEG1XK0pGx0
         JtqST0VthSqg6+Xk9c9bXAtxHnoGfQjy+e6JRi5+OpRdh6Cxlz8KgrX7j356S9CwSg7T
         brEg==
X-Gm-Message-State: APjAAAWR/Wi9oDTbu/4vwgejTSlnbeHk0P+7s6TSFpNTlP8PnsDTD8Fd
        F5AI88zE7G+El9uoBiIRIZ7uns0oWGA=
X-Google-Smtp-Source: APXvYqw5jczVZynupEVDwZS94Pkxypcw/lPFXdWbO6AoDhImmYahO2Cs9LwXWKHxTAMLacDOYTXbSQ==
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr21433095pge.428.1556606773602;
        Mon, 29 Apr 2019 23:46:13 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a9sm47336010pfo.17.2019.04.29.23.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 23:46:12 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Driver for UCS1002
Date:   Mon, 29 Apr 2019 23:45:54 -0700
Message-Id: <20190430064557.28469-1-andrew.smirnov@gmail.com>
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


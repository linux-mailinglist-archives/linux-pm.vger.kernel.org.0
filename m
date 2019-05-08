Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2726517677
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfEHLLY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 07:11:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54632 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfEHLLX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 07:11:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203so1577338wmb.4
        for <linux-pm@vger.kernel.org>; Wed, 08 May 2019 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CudbcozzaeKUq3DWNZdG3otz0fZIRmL0q4NFD8op3gI=;
        b=LdfpPzMpiacfFiok1ZAPTSkSm9gekwnzSeXjerAyeO0EAl44atgySrwVK/1S3+uCov
         T3QeYquOu1rc/U7S9MyQJYcbrOO+VAzuk8rA+/3lW9nb2alaY5LzfobBRWzJiAmXZkKu
         hTJIlBO231WRZs79AjSvRUfx0OpsNqkEYL513MG0J0KhdOQst9BdM7T6zzUyK8R0OhKL
         xChXW/vqzCZ4GTacIH9O6Px/opCR1VpAVwMZ2wxfC3E57mhtY4e8S2URnK7gsH6SLUeN
         /QQ1uD7lJ+M5tN9U8/o7lGBSZgf824SiapzizJ7sMNwq/H03OAWfztRuzAdZo/m/+mJs
         Ircg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CudbcozzaeKUq3DWNZdG3otz0fZIRmL0q4NFD8op3gI=;
        b=NDfJZ7KdloKQ5Ayml+JtyiiG1NKvT6BCJbRmPvYAYnIfQnYcfN4vN5z1Vy8/5SnyX0
         p8rBqcaDOuoGgfgbG3hDqMihuXJzPLm26wMJrNpc4UGZb5NwmLtajOH4k+MtdM75p4Ry
         PDaKDq3bJHoW6E93b4Xx6+MiDm6kOvB9+nZKFd7TbWgIHJWIAIbVZjpOEQuWh1YTGMs3
         G64p/FBELYaHvMrh/khAxGOe9kiOKG0oXTgoHDSeYuSPI9xSAaII2WDuEJzYbRTKFD8f
         EGvdcfBNatsCBaek/zF16NhE7ETZF9X9ew+BEDISoNe1BMyOPE1a21wVjebCJIWj+2xE
         mExw==
X-Gm-Message-State: APjAAAUOC2fKvr4DgtCVIKcUp6i69uB8V+U5gyUzvxOsr3ZQ5Nv2eKvM
        mNT4fyJ1pcI70l5Mk/TAMcnfrA==
X-Google-Smtp-Source: APXvYqwHxHzg+VsUu59uDR7g3sMlAR+jrJYJ2RFcO1V8dYuCtcSCuVY9lJnp+qeleM4eFH7vIfajHw==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr2739095wme.116.1557313880609;
        Wed, 08 May 2019 04:11:20 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id n4sm2944764wmk.24.2019.05.08.04.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:11:20 -0700 (PDT)
Date:   Wed, 8 May 2019 12:11:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [GIT PULL] Immutable branch between MFD, GPIO, Input, LEDs and Power
 due for the v5.2 merge window
Message-ID: <20190508111118.GR3995@dell>
References: <20190423090451.23711-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423090451.23711-1-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enjoy!

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-input-leds-power-v5.2

for you to fetch changes up to 796fad0101d370567c2968bd933b865aa57efaa3:

  MAINTAINERS: Add an entry for MAX77650 PMIC driver (2019-05-08 12:07:12 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO, Input, LEDs and Power due for the v5.2 merge window

----------------------------------------------------------------
Bartosz Golaszewski (11):
      dt-bindings: mfd: Add DT bindings for max77650
      dt-bindings: power: supply: Add DT bindings for max77650
      dt-bindings: leds: Add DT bindings for max77650
      dt-bindings: input: Add DT bindings for max77650
      mfd: mfd-core: Document mfd_add_devices()
      mfd: Add new driver for MAX77650 PMIC
      power: supply: max77650: Add support for battery charger
      gpio: max77650: Add GPIO support
      leds: max77650: Add LEDs support
      input: max77650: Add onkey support
      MAINTAINERS: Add an entry for MAX77650 PMIC driver

 .../devicetree/bindings/input/max77650-onkey.txt   |  26 ++
 .../devicetree/bindings/leds/leds-max77650.txt     |  57 ++++
 Documentation/devicetree/bindings/mfd/max77650.txt |  46 +++
 .../bindings/power/supply/max77650-charger.txt     |  28 ++
 MAINTAINERS                                        |  14 +
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77650.c                       | 190 +++++++++++
 drivers/input/misc/Kconfig                         |   9 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max77650-onkey.c                | 121 +++++++
 drivers/leds/Kconfig                               |   6 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-max77650.c                       | 147 ++++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77650.c                             | 232 +++++++++++++
 drivers/mfd/mfd-core.c                             |  13 +
 drivers/power/supply/Kconfig                       |   7 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/max77650-charger.c            | 368 +++++++++++++++++++++
 include/linux/mfd/max77650.h                       |  59 ++++
 22 files changed, 1349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 drivers/gpio/gpio-max77650.c
 create mode 100644 drivers/input/misc/max77650-onkey.c
 create mode 100644 drivers/leds/leds-max77650.c
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 drivers/power/supply/max77650-charger.c
 create mode 100644 include/linux/mfd/max77650.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A036D5837E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 15:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF0Nac (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 09:30:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37219 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfF0Nac (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 09:30:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so5694509wme.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xbq4KdqxHucz+vpFUkxO4MJyaiD5Od/cLcCD3lID9E4=;
        b=mjwcbA9iklldSmepid2v8Chbd3qYrKNJjxW/rysKzF2eNQzTZRNoDbYGiOL/IfD82N
         6gW7Qz76lf72OpVkr3jA4yWGkm9ThBjr/2Zpzl3DAzw8ODl+jFCDeaXMvHNcE4N/oZJU
         RKKMBMNHJyu+2raEIPRtXKIlq+ZTdD2zqPy6cgwgxd1gPXDIFC18gKH2kIhsLa1tAQaU
         sYzv/QIymUiCNQd2TJO7f9Ubb9eVMfCeLMyKbdD9mbZJAa2JuUFThhzJKuxTAH22kcnJ
         b3hOZoLePhBrkm5moeRivcOzrs2VEwcVOVtKUoiqCkESy6tY37RP0kqFakRFDS3LCzBv
         i6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xbq4KdqxHucz+vpFUkxO4MJyaiD5Od/cLcCD3lID9E4=;
        b=Tnn0F6odwSYZ9wD0qmXEfsp5VVFQLpNnd6kh7Gk9tZL9rg+wxMtxxMklOy/zoBXVLv
         DJCtPfhMFWP0xkd6tUTTgF9GgFAX/RbP052y6/lG+x+hr+VVhz/ojBh1Mz+6GVRYGz9W
         190mVyNXBZ36p5gbnpnHpTIfW/RhY8i7zyQgfkjYJdSthae4rrqpm/b36zHKLLg1+liw
         fsaV8Tiamm3xf0snSzS/aSNWF1gCIu+lN8RQRxJ7ZrR5MKRP5FHSWT8lwb8zRBl53UvU
         /9eXUD0FiyYoTMcw18oYR+dyRxxN93JD7gv6TxoULa42uGxnzDIzbPVXS/NRyPQY5lvl
         BTXw==
X-Gm-Message-State: APjAAAWB5WKaEdgVP2Cdn9aNxUmQTk+bDf4OCF/sc8SdNE+bjXiINNyG
        psufZX6UFeUm4Zkt1wHnN1qhAg==
X-Google-Smtp-Source: APXvYqwnCtGtIHU6oxnjOXis56rx3dsxnAGKNuysbzf/1YRh5Mc7ST2Z50KP/cLbucVnbJzfyj8BNA==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr3277916wmg.152.1561642230011;
        Thu, 27 Jun 2019 06:30:30 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id c6sm7876851wma.25.2019.06.27.06.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 06:30:29 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:30:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, Clk, GPIO, Power, Regulator
 and RTC due for the v5.3 merge window
Message-ID: <20190627133027.GC2000@dell>
References: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enjoy!

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-clk-gpio-power-regulator-rtc-v5.3

for you to fetch changes up to f8c7f7ddd8ef0855d06cff5d1cc7713b556006a7:

  power: supply: Initial support for ROHM BD70528 PMIC charger block (2019-06-27 10:57:24 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Clk, GPIO, Power, Regulator and RTC due for the v5.3 merge window

----------------------------------------------------------------
Matti Vaittinen (7):
      mfd: regulator: clk: Split rohm-bd718x7.h
      mfd: bd70528: Support ROHM bd70528 PMIC core
      clk: bd718x7: Support ROHM BD70528 clk block
      dt-bindings: mfd: Document first ROHM BD70528 bindings
      gpio: Initial support for ROHM bd70528 GPIO block
      rtc: bd70528: Initial support for ROHM bd70528 RTC
      power: supply: Initial support for ROHM BD70528 PMIC charger block

 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-bd718x7.c                          |  24 +-
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd70528.c                        | 232 +++++++
 drivers/mfd/Kconfig                                |  17 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/rohm-bd70528.c                         | 316 +++++++++
 drivers/mfd/rohm-bd718x7.c                         |  23 +-
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bd70528-charger.c             | 743 +++++++++++++++++++++
 drivers/regulator/bd718x7-regulator.c              |  25 +-
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bd70528.c                          | 500 ++++++++++++++
 include/linux/mfd/rohm-bd70528.h                   | 408 +++++++++++
 include/linux/mfd/rohm-bd718x7.h                   |  22 +-
 include/linux/mfd/rohm-generic.h                   |  20 +
 20 files changed, 2425 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 drivers/gpio/gpio-bd70528.c
 create mode 100644 drivers/mfd/rohm-bd70528.c
 create mode 100644 drivers/power/supply/bd70528-charger.c
 create mode 100644 drivers/rtc/rtc-bd70528.c
 create mode 100644 include/linux/mfd/rohm-bd70528.h
 create mode 100644 include/linux/mfd/rohm-generic.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

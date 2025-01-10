Return-Path: <linux-pm+bounces-20204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15CA090B8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D4A16A243
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56CA20E01F;
	Fri, 10 Jan 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQqjse6t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245120E009;
	Fri, 10 Jan 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512770; cv=none; b=ZGCs55iqjjeh0g036zOcQOLj0UWvO7RjEo7Nw7SY0uIO4JSUIhylHvvt9gcKPy5akdohZf82pYvmtbzuWI1aHtzVRjCHDe3efio/1OJHCef9OBpJUuN51Z9/8QI+vRflP7fRywbfY/fw9Odx5K3Q4+uiLLqmq0co13R2WvtaQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512770; c=relaxed/simple;
	bh=Rp3Dm03CLa293ovDrDZC/OSIYfcJkqVKGR6gZnyTzmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T+GqZmCLbb+vhMNbRIUEZ/bVLXq0/Y885YUNUWYhuJ+GHdVZ8JQDBqdpdwCvxuKCwSJhjO9elPITNOmTtXi5g3/ZBZJV67zdj1vjbHQdHviq5DuDF9sMLooeizL+L/zHUUVTiXCc3VZAh/FZv9hfeXrt+nw7rMyVzf1HcrfyjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQqjse6t; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso14760235e9.0;
        Fri, 10 Jan 2025 04:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512767; x=1737117567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0t5gqA/il+TUYTrY1HbHt1o/f4WC9ZnBS3h4GUuHE8k=;
        b=lQqjse6twiPPnXuIybhMlq7m7XWrj73vcAVgqxWENt/1Ra0buLYvRhq1qSy7pjdKCx
         g2piMRlum1llcI3DHjlaD/O+lj0qyYqn2ktB2he9OY7elRcX1qsY5sVjKQdqYFJDveMh
         c7MBEceCTgwQlo45j2RG1OWsVhtCe+3CR+ig/x23JFsQdccxnkSYCxFbyy7dOg0eD/Ey
         27Qel3oqjaPw4arhd66jNw6Mbw4SDInSABUglVHc6Timhdpqw6YohSU3HCLOAI38fCTh
         4HFYIXP0Z3wleXIyvDzxvp3bhLSpNw2B1wtM7Nw3VarCPxAddQLQPc/HesjOPLGhwgtX
         gLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512767; x=1737117567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0t5gqA/il+TUYTrY1HbHt1o/f4WC9ZnBS3h4GUuHE8k=;
        b=USXI3Cgel07d09oJxMzlkChXa4WDuwvKnHmtLHVEymyjfRvXjl8tYk86FUFYR2XmUY
         7lfl6NVNjWqehtvT8KeGOyd5gwtu61JcuenbZViEHtjv7rh7juY4oZMOBnjwS98xLBh9
         1jzXsYnAuz8XTfF3+Zth/2Q0Q0McvWS54jH/1zTUXV80Zjb3rq9fyCUY3MwgwSnGpBEA
         /lgO4fPvmJS0cl9ZV5YpSu+ubfW5dpWeMTp1mOQMINvZrO1XeV5TEVJKYfESrFPlVinX
         tty1PMeJws8gFjMBVoztHr9akqeXKcaDxkAa9MvLXeWWwfUa/NSWkr7ZnRbmcHoO+7/M
         OnLw==
X-Forwarded-Encrypted: i=1; AJvYcCUxm/QCa5nDs9sgxIz8AwCxqiBi3LK27RKPLVvXSj0gMVB3gwVtJcrjjQG4rawAsSg3TtPmNJbgzvcj@vger.kernel.org, AJvYcCVigQKH3oQfBqg+/85naInd22LfUIHapmnKhVgC3kvwQiR/dx9/tCtRcTRp6yud2+H4A+iCyTip/B009A==@vger.kernel.org, AJvYcCWfLCYwpQxqmWylLB1nRcFLJpkzZp5+LGUkBqyzlOW+KNV51QlnIWf+CiveztwxQ64MX3GI+FEgI2c=@vger.kernel.org, AJvYcCXZmQY1D2kB92zPBC7BtTHGWM7xb3Z9zG5+Z8BRlhLdvEmLEPzADSskIwwcvV52Qk9/0mOChz0jBWKP@vger.kernel.org, AJvYcCXcSUwZCma4KEh19f8IaKHaLoM1LP6CXg1DC5gjBRvAYmvkyQM8jQOySfjlMmPFA8n1p9vExMS8pm1lm5PD@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnm6jYPtgOuTOABqRhD6Cb3DPyGOSnbbUGvVQHB8xm9DBVzhy
	kXOkL+euoPx0EaNsQOYmTZPhZ+XIkz9LuznKmD7edT75jYsV5uTG
X-Gm-Gg: ASbGncvXgX/iTTIXDdNDxjnvVEr/PowZcEr/5B75GCJUafWmktyd4NwJQl4/c5ZaVwR
	PN8aEIpO1XxT5L1dX7vW/e0kcP0GUNyjnVkZKdQeeg9NqpVXbzFR3jeLErLALpcOmxI1xiHD99c
	A0W7SmnDH24++5yv/Jf/fdOZlvwoo34v1OeqvJhq1+OJBEGte7vRyQE7n4SChq5468Uj4OfWsvF
	Nqe1jdFXSsWVE+ZtjKOrpTdfAb8UlSbo0zyQ29ivgDILDW3u9LoTW5sEwKi0UkdCix1Fuy3zRjL
	k1bjrGa8vg0=
X-Google-Smtp-Source: AGHT+IE3BssODNjrNm89nwx4iOmLIapmHF85ffbErJN1wa3ZAlxSgiFL2xaIYFb7ZiAz0+f0TALyYg==
X-Received: by 2002:a05:600c:1c1a:b0:434:f2f4:4c07 with SMTP id 5b1f17b1804b1-436e26bd126mr104407005e9.15.1736512766511;
        Fri, 10 Jan 2025 04:39:26 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:25 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 00/12] Support for Allwinner V853 SoC
Date: Fri, 10 Jan 2025 13:39:11 +0100
Message-Id: <20250110123923.270626-1-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V85x is a device from Allwinner with video encoding targeted for the field of
IP Camera. It integrates the single CA7 core, and a T-Head E907 RISC-V mcu.
The SoC has the usual Allwinner peripherals and a Vivante NPU.
V853 is a BGA package without DRAM, V851s/V851s3 has the same die with
co-packaged 64MB/128MB DRAM (in a QFN88 package).

This patchset tries to add basical support for the V853 device family.
For review the ccu driver, I added a clk_summary debug output, maybe it'll help. [1]

PS:
As this is my first patchset, sorry for the rookie mistakes...

Andras Szemzo (12):
  clk: sunxi-ng: allow key feature in ccu reset
  dt-bindings: pinctrl: sunxi: add compatible for V853
  pinctrl: sunxi: add driver for Allwinner V853.
  dt-bindings: clock: sunxi-ng: add compatibles for V853
  clk: sunxi-ng: add CCU drivers for V853
  dt-bindings: clk: sunxi-ng: add V853 CCU clock/reset
  devicetree: bindings: power: add v853 ppu
  pmdomain: sunxi: add V853 ppu support
  dt-bindings: power: add V853 ppu bindings
  dt-bindings: phy: allwinner: add v853 usb phy
  phy: allwinner: add v853 usb phy compatible
  ARM: dts: sun8i: add DTSI file for V853

 .../clock/allwinner,sun4i-a10-ccu.yaml        |    2 +
 .../phy/allwinner,sun8i-v853-usb-phy.yaml     |   89 ++
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |   13 +
 .../power/allwinner,sun20i-d1-ppu.yaml        |    1 +
 arch/arm/boot/dts/allwinner/sun8i-v853.dtsi   |  673 ++++++++++
 drivers/clk/sunxi-ng/Kconfig                  |   10 +
 drivers/clk/sunxi-ng/Makefile                 |    4 +
 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.c       |   95 ++
 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.h       |   15 +
 drivers/clk/sunxi-ng/ccu-sun8i-v853.c         | 1145 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-v853.h         |   14 +
 drivers/clk/sunxi-ng/ccu_common.h             |    2 +
 drivers/clk/sunxi-ng/ccu_mux.c                |    4 +-
 drivers/clk/sunxi-ng/ccu_reset.c              |    7 +
 drivers/clk/sunxi-ng/ccu_reset.h              |    1 +
 drivers/phy/allwinner/phy-sun4i-usb.c         |   10 +
 drivers/pinctrl/sunxi/Kconfig                 |    5 +
 drivers/pinctrl/sunxi/Makefile                |    1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c    |  980 ++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h         |    1 +
 drivers/pmdomain/sunxi/sun20i-ppu.c           |   15 +
 include/dt-bindings/clock/sun8i-v853-ccu.h    |  132 ++
 include/dt-bindings/clock/sun8i-v853-r-ccu.h  |   16 +
 .../power/allwinner,sun8i-v853-ppu.h          |   10 +
 include/dt-bindings/reset/sun8i-v853-ccu.h    |   62 +
 include/dt-bindings/reset/sun8i-v853-r-ccu.h  |   14 +
 26 files changed, 3318 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c
 create mode 100644 include/dt-bindings/clock/sun8i-v853-ccu.h
 create mode 100644 include/dt-bindings/clock/sun8i-v853-r-ccu.h
 create mode 100644 include/dt-bindings/power/allwinner,sun8i-v853-ppu.h
 create mode 100644 include/dt-bindings/reset/sun8i-v853-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-v853-r-ccu.h

[1]:
                                 enable  prepare  protect                                duty  hardware                            connection
   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
---------------------------------------------------------------------------------------------------------------------------------------------
 iosc                                1       1        0        16000000    300000000  0     50000      Y   deviceless                      no_connection_id         
    iosc-32k                         1       1        0        31250       300000000  0     50000      Y      deviceless                      no_connection_id         
       osc32k                        1       1        0        31250       300000000  0     50000      Y         deviceless                      no_connection_id         
          fanout2                    0       0        0        31250       300000000  0     50000      N            deviceless                      no_connection_id         
          fanout1                    0       0        0        31250       300000000  0     50000      N            deviceless                      no_connection_id         
          fanout0                    0       0        0        31250       300000000  0     50000      N            deviceless                      no_connection_id         
          rtc-32k                    1       1        0        31250       300000000  0     50000      Y            deviceless                      no_connection_id         
          osc32k-fanout              0       0        0        31250       300000000  0     50000      N            deviceless                      no_connection_id         
 osc24M                              9       9        0        24000000    0          0     50000      Y   timer@2050000                   no_connection_id         
                                                                                                           deviceless                      no_connection_id         
    fanout-12M                       0       0        0        12000000    0          0     50000      N      deviceless                      no_connection_id         
    fanout-24M                       0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    riscv-cpu                        0       0        0        24000000    0          0     50000      Y      deviceless                      no_connection_id         
       riscv-axi                     0       0        0        12000000    0          0     50000      Y         deviceless                      no_connection_id         
    csi-mclk2                        0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    csi-mclk1                        0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    csi-mclk0                        0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    mipi-dsi                         0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    spif                             0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    spi3                             0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    spi2                             0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    spi1                             0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    mmc2                             0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    avs                              0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    apb1                             1       1        0        24000000    0          0     50000      Y      deviceless                      no_connection_id         
       bus-i2c4                      0       0        0        24000000    0          0     50000      N         deviceless                      no_connection_id         
       bus-i2c3                      0       0        0        24000000    0          0     50000      N         deviceless                      no_connection_id         
       bus-i2c2                      0       0        0        24000000    0          0     50000      N         2502800.i2c                     no_connection_id         
                                                                                                                 deviceless                      no_connection_id         
       bus-i2c1                      0       0        0        24000000    0          0     50000      N         deviceless                      no_connection_id         
       bus-i2c0                      0       0        0        24000000    0          0     50000      N         deviceless                      no_connection_id         
       bus-uart3                     0       0        0        24000000    0          0     50000      N         deviceless                      no_connection_id         
       bus-uart2                     1       1        0        24000000    0          0     50000      Y         2500800.serial                  no_connection_id         
                                                                                                                 deviceless                      no_connection_id         
       bus-uart1                     0       0        0        24000000    0          0     50000      N         deviceless                      no_connection_id         
       bus-uart0                     0       0        0        24000000    0          0     50000      N         deviceless                      no_connection_id         
    pll-npu-4x                       1       1        0        1392000000  0          0     50000      Y      deviceless                      no_connection_id         
       npu                           1       1        0        348000000   0          0     50000      Y         3050000.npu                     core                     
                                                                                                                 deviceless                      no_connection_id         
    pll-audio-div5                   0       0        0        614400000   0          0     50000      N      deviceless                      no_connection_id         
       pll-audio-1x                  0       0        0        614400000   0          0     50000      Y         deviceless                      no_connection_id         
          audio-codec-adc            0       0        0        614400000   0          0     50000      N            deviceless                      no_connection_id         
          audio-codec-dac            0       0        0        614400000   0          0     50000      N            deviceless                      no_connection_id         
          dmic                       0       0        0        614400000   0          0     50000      N            deviceless                      no_connection_id         
          i2s1                       0       0        0        614400000   0          0     50000      N            deviceless                      no_connection_id         
          i2s0                       0       0        0        614400000   0          0     50000      N            deviceless                      no_connection_id         
    pll-csi-4x                       0       0        0        1188000000  0          0     50000      N      deviceless                      no_connection_id         
    pll-video-4x                     0       0        0        1188000000  0          0     50000      N      deviceless                      no_connection_id         
       tcon-lcd                      0       0        0        1188000000  0          0     50000      N         deviceless                      no_connection_id         
       pll-video-1x                  0       0        0        297000000   0          0     50000      Y         deviceless                      no_connection_id         
          fanout-27M                 0       0        0        297000000   0          0     50000      N            deviceless                      no_connection_id         
       pll-video-2x                  0       0        0        594000000   0          0     50000      Y         deviceless                      no_connection_id         
    pll-periph-4x                    1       1        0        2400000000  0          0     50000      Y      deviceless                      no_connection_id         
       pll-periph-480M               0       0        0        480000000   0          0     50000      Y         deviceless                      no_connection_id         
          pll-periph-160M            0       0        0        160000000   0          0     50000      Y            deviceless                      no_connection_id         
             fanout-16M              0       0        0        16000000    0          0     50000      N               deviceless                      no_connection_id         
       pll-periph-800M               0       0        0        800000000   0          0     50000      Y         deviceless                      no_connection_id         
       pll-periph-2x                 1       1        0        1200000000  0          0     50000      Y         deviceless                      no_connection_id         
          pll-periph-400M            0       0        0        400000000   0          0     50000      Y            deviceless                      no_connection_id         
             mmc0                    0       0        0        50000000    0          0     50000      N               4020000.mmc                     mmc                      
                                                                                                                       deviceless                      no_connection_id         
             mmc1                    0       0        0        50000000    0          0     50000      N               4021000.mmc                     mmc                      
                                                                                                                       deviceless                      no_connection_id         
             ce                      0       0        0        400000000   0          0     50000      N               deviceless                      no_connection_id         
             pll-periph-200M         0       0        0        200000000   0          0     50000      Y               deviceless                      no_connection_id         
          pll-periph-600M            2       2        0        600000000   0          0     50000      Y            deviceless                      no_connection_id         
             apb0                    2       2        0        100000000   0          0     50000      Y               2000000.pinctrl                 apb                      
                                                                                                                       deviceless                      no_connection_id         
                fanout-pclk          0       0        0        100000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-audio-codec      0       0        0        100000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-gpadc            1       1        0        100000000   0          0     50000      Y                  2009000.adc                     no_connection_id         
                                                                                                                          deviceless                      no_connection_id         
                bus-pwm              0       0        0        100000000   0          0     50000      N                  deviceless                      no_connection_id         
             ahb                     8       8        0        200000000   0          0     50000      Y               deviceless                      no_connection_id         
                riscv-cfg            0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-wiegand          0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-csi              0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-tcon-lcd         0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-mipi-dsi         0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-dpss-top         0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-otg              1       1        0        200000000   0          0     50000      Y                  4100000.usb                     no_connection_id         
                                                                                                                          deviceless                      no_connection_id         
                bus-ehci             1       1        0        200000000   0          0     50000      Y                  usb@4101000                     no_connection_id         
                                                                                                                          deviceless                      no_connection_id         
                bus-ohci             2       2        0        200000000   0          0     50000      Y                  usb@4101400                     no_connection_id         
                                                                                                                          usb@4101000                     no_connection_id         
                                                                                                                          deviceless                      no_connection_id         
                bus-dmic             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-i2s1             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-i2s0             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-ths              0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-emac             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-spif             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-spi3             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-spi2             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-spi1             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-spi0             0       0        0        200000000   0          0     50000      N                  4025000.spi                     ahb                      
                                                                                                                          deviceless                      no_connection_id         
                bus-mmc2             0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-mmc1             0       0        0        200000000   0          0     50000      N                  4021000.mmc                     ahb                      
                                                                                                                          deviceless                      no_connection_id         
                bus-mmc0             0       0        0        200000000   0          0     50000      N                  4020000.mmc                     ahb                      
                                                                                                                          deviceless                      no_connection_id         
                bus-dram             1       1        0        200000000   0          0     50000      Y                  deviceless                      no_connection_id         
                bus-iommu            0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-dbg              0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-hstimer          1       1        0        200000000   0          0     50000      Y                  3008000.hstimer                 no_connection_id         
                                                                                                                          deviceless                      no_connection_id         
                bus-spinlock         1       1        0        200000000   0          0     50000      Y                  3005000.hwlock                  ahb                      
                                                                                                                          deviceless                      no_connection_id         
                bus-msgbox1          0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-msgbox0          0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-dma              1       1        0        200000000   0          0     50000      Y                  3002000.dma-controller          no_connection_id         
                                                                                                                          deviceless                      no_connection_id         
                bus-npu              1       1        0        200000000   0          0     50000      Y                  3050000.npu                     bus                      
                                                                                                                          deviceless                      no_connection_id         
                bus-ve               0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-ce               0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-g2d              0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
                bus-de               0       0        0        200000000   0          0     50000      N                  deviceless                      no_connection_id         
             pll-periph-300M         0       0        0        300000000   0          0     50000      Y               deviceless                      no_connection_id         
                csi-top              0       0        0        300000000   0          0     50000      N                  deviceless                      no_connection_id         
                spi0                 0       0        0        75000000    0          0     50000      N                  4025000.spi                     mod                      
                                                                                                                          deviceless                      no_connection_id         
                ve                   0       0        0        300000000   0          0     50000      N                  deviceless                      no_connection_id         
                g2d                  0       0        0        300000000   0          0     50000      N                  deviceless                      no_connection_id         
                de                   0       0        0        300000000   0          0     50000      N                  deviceless                      no_connection_id         
                pll-periph-150M      0       0        0        150000000   0          0     50000      Y                  deviceless                      no_connection_id         
                   fanout-25M        0       0        0        25000000    0          0     50000      N                     deviceless                      no_connection_id         
                   emac-25M          0       0        0        25000000    0          0     50000      N                     deviceless                      no_connection_id         
    pll-ddr                          1       1        0        1056000000  0          0     50000      Y      deviceless                      no_connection_id         
       dram                          2       2        0        1056000000  0          0     50000      Y         deviceless                      no_connection_id         
          mbus                       1       1        0        264000000   0          0     50000      Y            deviceless                      no_connection_id         
             mbus-g2d                0       0        0        264000000   0          0     50000      N               deviceless                      no_connection_id         
             mbus-isp                0       0        0        264000000   0          0     50000      N               deviceless                      no_connection_id         
             mbus-csi                0       0        0        264000000   0          0     50000      N               deviceless                      no_connection_id         
             mbus-ce                 0       0        0        264000000   0          0     50000      N               deviceless                      no_connection_id         
             mbus-ve                 0       0        0        264000000   0          0     50000      N               deviceless                      no_connection_id         
             mbus-dma                1       1        0        264000000   0          0     50000      Y               3002000.dma-controller          mbus                     
                                                                                                                       deviceless                      no_connection_id         
    pll-cpu                          1       1        0        912000000   0          0     50000      Y      deviceless                      no_connection_id         
       cpu                           1       1        0        912000000   0          0     50000      Y         deviceless                      no_connection_id         
          cpu-apb                    0       0        0        228000000   0          0     50000      Y            deviceless                      no_connection_id         
          cpu-axi                    0       0        0        456000000   0          0     50000      Y            deviceless                      no_connection_id         
    osc12M                           1       1        0        12000000    0          0     50000      Y      deviceless                      no_connection_id         
       usb                           3       3        0        12000000    0          0     50000      Y         usb@4101400                     no_connection_id         
                                                                                                                 usb@4101000                     no_connection_id         
                                                                                                                 4100400.phy                     usb0_phy                 
                                                                                                                 deviceless                      no_connection_id         
    osc24M-32k                       0       0        0        32000       0          0     50000      N      deviceless                      no_connection_id         
    r-cpucfg                         0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
    r-rtc                            1       1        0        24000000    0          0     50000      Y      7090000.rtc                     bus                      
                                                                                                              deviceless                      no_connection_id         
    r-ppu                            1       1        0        24000000    0          0     50000      Y      7001000.power-controller        no_connection_id         
                                                                                                              deviceless                      no_connection_id         
    r-twd                            0       0        0        24000000    0          0     50000      N      deviceless                      no_connection_id         
 pll-audio-div2                      0       0        0        0           0          0     50000      Y   deviceless                      no_connection_id         
    pll-audio-4x                     0       0        0        0           0          0     50000      Y      deviceless                      no_connection_id         

-- 
2.39.5



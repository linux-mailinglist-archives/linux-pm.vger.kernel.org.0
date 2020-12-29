Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9C12E72A5
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 18:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2RcH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 12:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2RcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 12:32:07 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692AC061793;
        Tue, 29 Dec 2020 09:31:26 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ce23so18987967ejb.8;
        Tue, 29 Dec 2020 09:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NpRbovEFhIUWDeLgLi1cmLAq8hw0Nkuzyn5MTBdA9MY=;
        b=cb9FFcqwCorBCPQ8N8ipTckD/AzQQFNpSvvMeqTM6ZitmkksK6Xf2Q8nov5FVrIez1
         HfpJRvWvPfin+VztGqsfHchJSXT2nJjnkvCwPEU2jBTPyEGMhkqtkPd2iKkWQPm9kT3R
         yCiZ19Rq6QuCEKjzljWG5k77s2EhgF9AYZ5+c+aubRwdt6ls0viIfY64IIl1FYLW6HK/
         KIfLWX84ZzTvuvA7wvatcsHBKg1y8+h7dn9v+VpzKGrgq6Tg+LbDH0psuhyCNJ64rkCm
         uMPwGwsYJN/Ftv5nU5EXeGI2kq5euNxEjyhzCTFU33B3as6aMnbYzsNBcoa2p/JXYbaD
         b4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NpRbovEFhIUWDeLgLi1cmLAq8hw0Nkuzyn5MTBdA9MY=;
        b=UcTNh9sV8zi/89wqlM4ts/RSGv4ZQpeDTLGQX8dVHKxf8cKN8Eq9yn89saBtGDp7a4
         7a98Hbthg8CZ/9sZTIKml/xvmNPzIdoG97uvUdvpa4XgRuZIT1cr+haUZWZo5Mi3cqhK
         MmfmRQwkd+2ZuFAR8GLfEUl8tE0fkqiBXPe/fkOR3q1GyVLZ9cp1MnDe+1BWV1hu5B5B
         JbBB187Z7wpDSpUggzDJ5ICSlN3bP16x7ueDFfujneu//l4y3VumldEF7+CDvR79ND1N
         jbwGcVWQhQmeh4puVh5vjwP651PrHdZDe2Rkt28oTQ9NFY7PwnfTrZOGxT0x1+5ENv3f
         jTMA==
X-Gm-Message-State: AOAM533ivYFkoRsho4rwJEDBmL7O0SgMIhL5wRfLnsbXtPdG0QdBaHOb
        temW29PA8vo0Aiw2rGgsJf8=
X-Google-Smtp-Source: ABdhPJwngcnyeFWq9S5cj8VQ/qbch7z2mOYsx5pDTPqOuhiSwX6UF9jtITAGWLy6Qy7qauFMMNCKFA==
X-Received: by 2002:a17:906:2499:: with SMTP id e25mr46484142ejb.446.1609263085258;
        Tue, 29 Dec 2020 09:31:25 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id q25sm37385362eds.85.2020.12.29.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:31:24 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 0/7] Add initial support for ATC260x PMICs
Date:   Tue, 29 Dec 2020 19:31:15 +0200
Message-Id: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ATC260x family of PMICs integrates Audio Codec, Power management,
Clock generation and GPIO controller blocks. There are currently 3
variants: ATC2603A, ATC2603C and ATC2609A.

This is re-spin of the v1 patch series submitted some time ago by
Mani, who provided the MFD and regulator drivers for ATC2609A:
https://lore.kernel.org/lkml/20190617155011.15376-1-manivannan.sadhasivam@linaro.org/

Since v2, I added support for ATC2603C, together with some new
functionalities for both chips: power controller and onkey input.
The ATC2603A chip type remains unsupported for the moment.

This has been tested on RoseapplePi, a SBC based on the Actions Semi S500
SoC, which integrates the ATC2603C variant of the PMIC.

Note that enabling the ATC260x PMICs on compatible Actions Semi Owl SoC
based boards depends on:

* the Actions Semi SIRQ driver (for PMIC DTS setup), merged in v5.10:
  https://lore.kernel.org/lkml/cover.1600114378.git.cristian.ciocaltea@gmail.com/

* the atomic transfers in Owl I2C driver (for power controller), merged in v5.11:
  https://lore.kernel.org/lkml/cover.1602190168.git.cristian.ciocaltea@gmail.com/

Additionally, please note that I have taken the authorship for the MFD
and regulator drivers patches, considering the original code has been
modified to a large extent.

Thanks,
Cristi

Changes in v4:
- Updated MFD driver according to Lee's review
- Handled ATC2603C's LDO12 fixed regulator per Mark's suggestion
- Rebased patchset on v5.11-rc1

Changes in v3:
- Integrated feedback from Mani, Rob, Mark, Sebastian, Dmitry
- Fixed issues reported by Lee's kernel test robot
- Added new patch for 'reset-time-sec' DT binding property
- Rebased patchset on v5.10-rc6

Changes in v2:
- Reworked MFD core & I2C driver
  * Integrated Lee's feedback
  * Added support for using the regmap within atomic contexts
  * Added support for ATC2603C chip variant
  * Reorganized KConfig entries
- Improved regulator driver
  * Added support for ATC2603C variant
  * Used helper macros for more compact specification of regulator_desc items
  * Added more regulator capabilities
- Added power controller driver
  * Provides system poweroff/reboot functionalities
  * Depends on atomic transfers in the Owl I2C driver
- Added onkey driver: exposes the power button as an input device
- Added yaml binding doc
- Rebased patchset on kernel v5.9-rc1

Cristian Ciocaltea (6):
  dt-bindings: input: Add reset-time-sec common property
  dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
  mfd: Add MFD driver for ATC260x PMICs
  regulator: Add regulator driver for ATC260x PMICs
  power: reset: Add poweroff driver for ATC260x PMICs
  input: atc260x: Add onkey driver for ATC260x PMICs

Manivannan Sadhasivam (1):
  MAINTAINERS: Add entry for ATC260x PMIC

 .../devicetree/bindings/input/input.yaml      |   7 +
 .../bindings/mfd/actions,atc260x.yaml         | 183 ++++++
 MAINTAINERS                                   |  12 +
 drivers/input/misc/Kconfig                    |  11 +
 drivers/input/misc/Makefile                   |   2 +-
 drivers/input/misc/atc260x-onkey.c            | 305 ++++++++++
 drivers/mfd/Kconfig                           |  18 +
 drivers/mfd/Makefile                          |   3 +
 drivers/mfd/atc260x-core.c                    | 293 ++++++++++
 drivers/mfd/atc260x-i2c.c                     |  64 +++
 drivers/power/reset/Kconfig                   |   8 +-
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/atc260x-poweroff.c        | 263 +++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/atc260x-regulator.c         | 539 ++++++++++++++++++
 include/linux/mfd/atc260x/atc2603c.h          | 281 +++++++++
 include/linux/mfd/atc260x/atc2609a.h          | 308 ++++++++++
 include/linux/mfd/atc260x/core.h              |  58 ++
 19 files changed, 2363 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
 create mode 100644 drivers/input/misc/atc260x-onkey.c
 create mode 100644 drivers/mfd/atc260x-core.c
 create mode 100644 drivers/mfd/atc260x-i2c.c
 create mode 100644 drivers/power/reset/atc260x-poweroff.c
 create mode 100644 drivers/regulator/atc260x-regulator.c
 create mode 100644 include/linux/mfd/atc260x/atc2603c.h
 create mode 100644 include/linux/mfd/atc260x/atc2609a.h
 create mode 100644 include/linux/mfd/atc260x/core.h

-- 
2.30.0


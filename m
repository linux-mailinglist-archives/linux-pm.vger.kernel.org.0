Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A032D0016
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 02:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgLFB1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 20:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLFB1w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 20:27:52 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEDAC0613CF;
        Sat,  5 Dec 2020 17:27:12 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so14218187ejb.13;
        Sat, 05 Dec 2020 17:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aLebgEqoATmMI8bfoDj70EDkjqNo0VIOaUKoftRAHHk=;
        b=elgJN9tOJwJjq5/wlZFk20P7bu9DBHKT7O6zdm2SPg5nJVESH8YHVZmNov161dgK4t
         /OHAdRY/56KLiCFhOatSzEa8w8qTbYc6+kiaCDpyeCrI/Zakkf5OqotXkeQlu3CUFxv5
         HOynJbE2F1qkxhZ76FAtQG3FNRXfZCDblz71FAc97Bz6psuEjeOgLA4v91dERGJ0KdCl
         9KV2wZIwSQ5nhR/JViNSOVoTkkw4Db+zXUaDIQYFEnBBeB8x/Z7M547h4rh0izE13u7W
         5RXhyydOYgDBKeOaO5jMU5cN01xrHIZEQz6XogrKs4y3Vqai/XMXYDexRmQ3ZPvyFEE6
         K3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aLebgEqoATmMI8bfoDj70EDkjqNo0VIOaUKoftRAHHk=;
        b=Jn4xIbvr9ylHeqX22F+78LapuuzOPCjke/gQhGQvRen3eFwypxW7ap97HPVbaGfTJS
         v4K6JZk+pGwTNBnHYRUdyC3uIXhtzlM9GUe9yaxr3uiAYdaFtcCex/J8BZxLgU8rLOw3
         Ms7M/elEAs3eS7tWDJgeoKSV5TR7ZNwNZXek8OlUYfKXh2h9qIyfD0Txscqqj/lqoU6R
         Uzfpr6pg4XOYDLz+lzrNdiPm5K4JB8U1MdnADKjzNpciYQJQUv1xLngI0nSGFpVmmNIJ
         ELHYZcrWJq5SKRomZcEPnrYwE/0sxTR/k2Vx9zm0/2MM6iXmItBdr41vZ6uhpQXTzsjy
         4GOA==
X-Gm-Message-State: AOAM533xDvCWnbgUc6pCZOqOM9HOebqM+7I4JW/Olnlj6lxX679DghVS
        2w50GxKNEISnQOVQgvg9AMs=
X-Google-Smtp-Source: ABdhPJz8X19bk3xopW1YmBt8KuvFurQipwJTwLtH4iihFosS9I1XWwAUarf9scl8qLpQ5LYGkVoNrQ==
X-Received: by 2002:a17:906:ceca:: with SMTP id si10mr13029820ejb.547.1607218030898;
        Sat, 05 Dec 2020 17:27:10 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id a10sm6157023ejk.92.2020.12.05.17.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 17:27:09 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/7] Add initial support for ATC260x PMICs
Date:   Sun,  6 Dec 2020 03:27:00 +0200
Message-Id: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
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

This has been tested on RoseapplePi, a SBC based on the Action Semi S500
SoC, which integrates the ATC2603C variant of the PMIC.

Note that enabling the ATC260x PMICs on compatible Actions Semi Owl SoC
based boards depends on:

* the Actions Semi SIRQ driver (for PMIC DTS setup), merged in v5.10:
  https://lore.kernel.org/lkml/cover.1600114378.git.cristian.ciocaltea@gmail.com/

* the atomic transfers in Owl I2C driver (for power controller), queued for v5.11:
  https://lore.kernel.org/lkml/cover.1602190168.git.cristian.ciocaltea@gmail.com/

Additionally, please note that I have taken the authorship for the MFD
and regulator drivers patches, considering the original code has been
modified to a large extent.

Thanks,
Cristi

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
 .../bindings/mfd/actions,atc260x.yaml         | 181 ++++++
 MAINTAINERS                                   |  12 +
 drivers/input/misc/Kconfig                    |  11 +
 drivers/input/misc/Makefile                   |   2 +-
 drivers/input/misc/atc260x-onkey.c            | 305 ++++++++++
 drivers/mfd/Kconfig                           |  18 +
 drivers/mfd/Makefile                          |   3 +
 drivers/mfd/atc260x-core.c                    | 290 ++++++++++
 drivers/mfd/atc260x-i2c.c                     |  73 +++
 drivers/power/reset/Kconfig                   |   8 +-
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/atc260x-poweroff.c        | 263 +++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/atc260x-regulator.c         | 524 ++++++++++++++++++
 include/linux/mfd/atc260x/atc2603c.h          | 281 ++++++++++
 include/linux/mfd/atc260x/atc2609a.h          | 308 ++++++++++
 include/linux/mfd/atc260x/core.h              |  86 +++
 19 files changed, 2380 insertions(+), 2 deletions(-)
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
2.29.2


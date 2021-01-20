Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4C2FD8A3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 19:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbhATSoR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 13:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404206AbhATSYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 13:24:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF1CC061575;
        Wed, 20 Jan 2021 10:23:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id b5so18443163ejv.4;
        Wed, 20 Jan 2021 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLdEtdixhcuzDsqn7NPt1vlh25weIc+8J54AbD9rTIk=;
        b=rWJWucwSMRpikb7+18K+dKLrzLNbDRtiwhCjaaGWSlTzDpHtqh8FQ/ekGOHdFnVo+B
         an7q3xTl+tG7lrXNGkBM4Z5k3NZIa6lbu065HRup4+W75KI9D2gRx8jcxVtBA4qBiyn/
         ayvaV0YLQISOUrTgZdcZUFYUCfSMgb1TeKTlqmW08lDEby5wxtB/suAfIiU1UyOcXcit
         LTx/5PYjLMh5Dk9G1T6Cv0Sqgap+QBzssPrDyxhvejHNCN/wol0KbkrwYSd2T8cltfDF
         MAojW/BRvjLvlclcqTNM0zh53/VVfu8VTte/JuXzMY5Y6zQnllat8LGvoUpD9FThlNnK
         f/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLdEtdixhcuzDsqn7NPt1vlh25weIc+8J54AbD9rTIk=;
        b=ZeDMmS2Zjkexv6TtcVeUHueUajXlSjmo3NmQ8k8vzMP1MeFDVo/+8vQXTZhPIZb63Y
         XuBpdXMI99pnNNfE8eDGItr/x/0sAkorHLqAzVB6qKGDVYqFXWskGaYkAG6omzrnarlZ
         SXvo9XpNUicK38trg/McHo+NW0uqbodWVIvI+mioRLwDfIXa+Yq1I3PoqOtG1c9Bk+1k
         8VnnDDTSdVs5GhyIg/Ob0kavcj+HPjw+8zC+cCnyY+dpn53eNJP+hJcP2OS7/rA48Jsj
         DxTwJm7kBprtWUN7IWfo26VuC1ye+L0+qdXsxIFDCo2kQ/bk6rs2K26UoGIa9JVJ52AX
         +AIQ==
X-Gm-Message-State: AOAM533MM6hStkNn5PESdA9CkxKhKLjKxPjfUoI1fqYukMsoUIhsk9wM
        juRucyWRNtZQPbUnoHjPMJw=
X-Google-Smtp-Source: ABdhPJyGUKWxVY5c9GdiWWlDtluq1Ay0X2pOpX1vhrKRJ8CQTQ9b8VWRc2uGJYwdSbDsaQnzI0blKg==
X-Received: by 2002:a17:907:104c:: with SMTP id oy12mr6862380ejb.503.1611167016173;
        Wed, 20 Jan 2021 10:23:36 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id hr31sm1158332ejc.125.2021.01.20.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:23:34 -0800 (PST)
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
Subject: [PATCH v6 0/7] Add initial support for ATC260x PMICs
Date:   Wed, 20 Jan 2021 20:23:25 +0200
Message-Id: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
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

Changes in v6 - MFD driver updates as indicated by Lee:
- Defined a magic number for max chip revision
- Adjusted code formatting around i2c_driver struct initialization
- Dropped the device initialization callback in struct atc260x and instead 
  provided a generic function making use of a new member structure to hold
  the hardware specific register information

Changes in v5:
- Removed an unnecessary '#include' line in the power-off driver,
  as noticed by Sebastian
- Rebased patchset on v5.11-rc3

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
 drivers/mfd/atc260x-core.c                    | 310 ++++++++++
 drivers/mfd/atc260x-i2c.c                     |  64 +++
 drivers/power/reset/Kconfig                   |   8 +-
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/atc260x-poweroff.c        | 262 +++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/atc260x-regulator.c         | 539 ++++++++++++++++++
 include/linux/mfd/atc260x/atc2603c.h          | 281 +++++++++
 include/linux/mfd/atc260x/atc2609a.h          | 308 ++++++++++
 include/linux/mfd/atc260x/core.h              |  58 ++
 19 files changed, 2379 insertions(+), 2 deletions(-)
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


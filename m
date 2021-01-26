Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7C304071
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 15:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbhAZNZx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 08:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391656AbhAZJ4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 04:56:45 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730CC0613D6;
        Tue, 26 Jan 2021 01:56:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ox12so22150192ejb.2;
        Tue, 26 Jan 2021 01:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8C8pdtrwOEr8Lcj7qoDN59MpfrhsdtkivzKyNfgBHVw=;
        b=i4fuVrNcQQvAg/YwF+wDvQKzO3U0KyXWoQb1U1Zhh1K9LMvLE6yHB9fYEf2yM5ryFe
         Zez+fSpWh+yD0axfaJNvX2UNzmrWQjmsDVjbmkhJl+nmBZbo4e8/ezVdsm54+UoQiFTT
         +gBvUQLEj08xIN+TLGe7DSmaopQSrsX6CiRy3crM+D0UF+FAPO3vFDaWVax0rf6ZVxnE
         pPbMzP/k1NkOYGHDpufPAqF9VwkpFzFg0WYn3ge2pFcY6iBmV7bhrhmQr8wD0s7WlR/8
         QZHfJ0KGvRd/GqGm/AuaKdV2HPDv7so3g+RqcqLiAs75+sCBcTxqfvscS2epCFuDA1nk
         GKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8C8pdtrwOEr8Lcj7qoDN59MpfrhsdtkivzKyNfgBHVw=;
        b=TYsLsQJyLr05XsrvE6Sr4H+xCRrekgZKA0SDi4g5Mgr8++LmMkvZFufhpuN+KlFvMq
         IgZklsGuyUe0W1osKHRCNOK+/XoQcAR417PmGnNNxjCCvRN5cGEgGHErOCEOjvsXbJcC
         Lh8zv3bf/pZAB2Sy20iXMHhARDzFgNJyrrzj64rIGYgRmqbWbLbWrwlyJGvbKQSuPMwK
         9n+WvQSwvtEJX/PRVCnMF96VTrOwyu+lvKeaAA+vyfM3iT+52xAivfKytuzpYbZYWlR8
         PA5cbHcA1k/ZoK+cpNXQSzZl0ifTOF0tkpoeny4k3y/dHk9DlkpmUWSrafnAktCeKzQe
         oc7w==
X-Gm-Message-State: AOAM531v7BvGQgQiZXaejklWDjtzCn892vqY00qo/j7pFQLUVOLL48D+
        Hz3n2XDnSNP7AXS/Kkj9/88=
X-Google-Smtp-Source: ABdhPJw9SauEqE9zZ6vtE2izjZwy24q35l+YqHKZ3cYH6XXfCRCl0ul8HQE0XjbDgtercPxBO81gzg==
X-Received: by 2002:a17:906:198b:: with SMTP id g11mr636151ejd.536.1611654963668;
        Tue, 26 Jan 2021 01:56:03 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id h12sm11648310edb.16.2021.01.26.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 01:56:02 -0800 (PST)
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
Subject: [PATCH v7 0/5] Add initial support for ATC260x PMICs
Date:   Tue, 26 Jan 2021 11:55:56 +0200
Message-Id: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
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

Changes in v7:
- Dropped the patches already queued for merging:
  * regulator: Add regulator driver for ATC260x PMICs
  * power: reset: Add poweroff driver for ATC260x PMICs
- Rebased patchset on v5.11-rc5

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

Cristian Ciocaltea (4):
  dt-bindings: input: Add reset-time-sec common property
  dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
  mfd: Add MFD driver for ATC260x PMICs
  input: atc260x: Add onkey driver for ATC260x PMICs

Manivannan Sadhasivam (1):
  MAINTAINERS: Add entry for ATC260x PMIC

 .../devicetree/bindings/input/input.yaml      |   7 +
 .../bindings/mfd/actions,atc260x.yaml         | 183 +++++++++++
 MAINTAINERS                                   |  12 +
 drivers/input/misc/Kconfig                    |  11 +
 drivers/input/misc/Makefile                   |   2 +-
 drivers/input/misc/atc260x-onkey.c            | 305 +++++++++++++++++
 drivers/mfd/Kconfig                           |  18 +
 drivers/mfd/Makefile                          |   3 +
 drivers/mfd/atc260x-core.c                    | 310 ++++++++++++++++++
 drivers/mfd/atc260x-i2c.c                     |  64 ++++
 include/linux/mfd/atc260x/atc2603c.h          | 281 ++++++++++++++++
 include/linux/mfd/atc260x/atc2609a.h          | 308 +++++++++++++++++
 include/linux/mfd/atc260x/core.h              |  58 ++++
 13 files changed, 1561 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
 create mode 100644 drivers/input/misc/atc260x-onkey.c
 create mode 100644 drivers/mfd/atc260x-core.c
 create mode 100644 drivers/mfd/atc260x-i2c.c
 create mode 100644 include/linux/mfd/atc260x/atc2603c.h
 create mode 100644 include/linux/mfd/atc260x/atc2609a.h
 create mode 100644 include/linux/mfd/atc260x/core.h

-- 
2.30.0


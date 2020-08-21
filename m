Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC824E330
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 00:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHUWT7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 18:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHUWT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 18:19:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42756C061573;
        Fri, 21 Aug 2020 15:19:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id si26so4268232ejb.12;
        Fri, 21 Aug 2020 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Euhqf0kKa8bJk8hY6VIiEQD27H+m7/Zjj9fyz771ww=;
        b=W7e8QLL/UILxZwiAdklCeQIidO1LLzLv/jj477YznHokzrs/jwc4XDHBocvHEKRcS7
         C4k4OTeS2MJBKjJp2p1+UZRWaoGFznWR4y2r15ULdQud9LkesE/Og1hyjN+N5ddNKj54
         eR0xfYGRlGOzsoLkDrFOgS2PPL/E80Ybd1I9Bs5NePnuitGku4JdnUlGtNqomoUsCBx7
         rUwvGwZVmjc/ayRjLa84HTtY9OYDVx7nMKIJBlMluEpZ0KBxS4pEg5jg3djiJI3oVfx4
         AUrJtyP2Zh187WNwWe5fKJ4mnNymXPMpe9PSM757wZuI53P/EuXETwae+Uj9pTbhcknV
         hTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Euhqf0kKa8bJk8hY6VIiEQD27H+m7/Zjj9fyz771ww=;
        b=qcb+n+aoy9P+/d8VPKzsgMm3vBvDlZz7hGpIaUBvs+FgWM/dwaAioz8XZX8zpQeiJZ
         GZQL/r8BVFuIKJTp6Dt9Qdpc/G7wRrjBn06xHbZ8GVVBxlosGGwqaI4xqbE43/rwBOEq
         gelRw3ke4wU43jz7VBGNu1vzZi826IqkMPBuRgCSFAQpXAs/siww3Ks0CzecnXNnI1BC
         em9AUN2DIHfWXDdukjEsco3V2onjkqnKPtuhOCG9bI2BH8HI8AD8eE3Yehjd1hMRafGj
         wy4wYDNRho4jbyHhEaqJ0tkA5z4SPxXyHsi89IuMbz0ocpRDO/O5h2YvpnPpsgL96QA0
         ehdw==
X-Gm-Message-State: AOAM533UA5vXULaFwEmzbf8I4IOEs/YDrg7c6bOrHdv3ua617DD4uAsm
        VUD6hVOlxoVKOv1G6DZv14I=
X-Google-Smtp-Source: ABdhPJytrtdq9zPLl7O5jmDFGa+bREqtkDfuGd6hS1X1/YZJjB0xIhkRKGNYMWTMKR6aiTXJBfI1eQ==
X-Received: by 2002:a17:906:d971:: with SMTP id rp17mr3788200ejb.31.1598048394799;
        Fri, 21 Aug 2020 15:19:54 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id p23sm1780147edm.31.2020.08.21.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:19:54 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/6] Add initial support for ATC260x PMICs
Date:   Sat, 22 Aug 2020 01:19:46 +0300
Message-Id: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is re-spin of the patch series submitted some time ago by Mani,
who added initial support (MFD core and regulators) for the Actions
Semi ATC260x PMICs:
https://lore.kernel.org/lkml/20190617155011.15376-1-manivannan.sadhasivam@linaro.org/

The ATC260x family of PMICs integrates Audio Codec, Power management,
Clock generation and GPIO controller blocks. There are currently 3
variants: ATC2603A, ATC2603C and ATC2609A.

In addition to the ATC2609A regulator functionality provided that time,
this patchset adds support for the ATC2603C variant, together with some
new functionalities for both chips: power controller and onkey input.
The ATC2603A variant remains unsupported for the moment.

This has been tested on RoseapplePi, a SBC based on the Action Semi S500
SoC, which integrates ATC2603C PMIC. An initial support for this board
has been already submitted:
https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/

Please note that enabling the ATC260x PMICs on the compatible Actions
Semi Owl SoC based boards depends on the following:

* Actions Semi SIRQ driver (for PMIC DTS setup):
  https://lore.kernel.org/lkml/cover.1597852360.git.cristian.ciocaltea@gmail.com/

* I2C Atomic transfers in Actions Semi Owl driver (for proper operation
  of the power controller driver):
  https://lore.kernel.org/lkml/b086ef6d355d9730c839359e15eb06175283e323.1596485741.git.cristian.ciocaltea@gmail.com/
  
Thanks,
Cristi

Cristian Ciocaltea (6):
  dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
  mfd: Add MFD driver for ATC260x PMICs
  regulator: Add regulator driver for ATC260x PMICs
  power: reset: Add poweroff driver for ATC260x PMICs
  input: atc260x: Add onkey driver for ATC260x PMICs
  MAINTAINERS: Add entry for ATC260x PMIC

 .../bindings/mfd/actions,atc260x.yaml         | 221 ++++++++
 MAINTAINERS                                   |  12 +
 drivers/input/misc/Kconfig                    |  11 +
 drivers/input/misc/Makefile                   |   2 +-
 drivers/input/misc/atc260x-onkey.c            | 304 +++++++++++
 drivers/mfd/Kconfig                           |  18 +
 drivers/mfd/Makefile                          |   3 +
 drivers/mfd/atc260x-core.c                    | 290 ++++++++++
 drivers/mfd/atc260x-i2c.c                     |  73 +++
 drivers/power/reset/Kconfig                   |   8 +-
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/atc260x-poweroff.c        | 274 ++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/atc260x-regulator.c         | 511 ++++++++++++++++++
 include/linux/mfd/atc260x/atc2603c.h          | 281 ++++++++++
 include/linux/mfd/atc260x/atc2609a.h          | 308 +++++++++++
 include/linux/mfd/atc260x/core.h              |  86 +++
 18 files changed, 2410 insertions(+), 2 deletions(-)
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
2.28.0


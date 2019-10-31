Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70024EB722
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfJaShv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:37:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46174 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfJaShv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:37:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id 193so3662588pfc.13
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2nYGKPeQWZBCF+i8MPNjPGjQ92pRq1yryrClg8ZxihQ=;
        b=XNlZB+uFwf+YEk52zj5fYFrMl+TYfnxJ8l5OOnSz4fxogzmG9rh7I/aqY7IUN3I8iw
         jHLvXy8BxL3FIYfzm9MzcEbBQHXG3T95PtNuEcm9xoQ2qOs+xGyk922A/y7a+JRTCURL
         uNJzArQp3mvvB1qTE0qY3i/6R6fzMXFeHeKsZWW4JhcsArOpvov31yZE46vsuvO9BXUk
         xkEoVt9J6mhcNdrPimKvSn4EgPwy0gs2+SUS28Agwpe28PfpHhh4YvoEochEJNabddb0
         7wqZ2T4aG0erbXPS2/bBQUc/WgYQEIcUi2cglMBScG3Qd+hx/354PbWvZ73eogRM56lg
         CTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2nYGKPeQWZBCF+i8MPNjPGjQ92pRq1yryrClg8ZxihQ=;
        b=OKiuDdj3WrojZ1k9e5WE9vCaqhNVSgEXkxCTVraysuul5QQ/ynO2ROsNwGj8LLkpkW
         4qF7B70HJ2SLu8jielOWTSmdra0ZFwyfjFp6Yk9dZpOWysotE1QgTFDkYMfwGNfSJPzD
         Cbkixic3SJZiF0kTdR7s0bWXXXmjw6O/tKL5P0vA/ZmT8D4OLpZQQIX877tHoMKdXo5Q
         Zoi3BAduK+tYVPKR9XC+adSgfsJeQUMzrPE53z7RiehP7zJE0zIpLSqB4QhbVou9R7WD
         l2nMB9auatBt+OoFBVnKxHWABUt8iF3XHPH1yTyLOe4q9ZkCqu7NmblNEVnNp5X057ic
         8EfQ==
X-Gm-Message-State: APjAAAU3upP3dp4Lf3STXUP5yC/LQWnE/eHkYpJxcq7My/szAzWFFmzC
        vkDH0i73xQ1EpKOohWgxBMsbAw==
X-Google-Smtp-Source: APXvYqyPHEkV60aWdkW+CKAXt0QX5BkXpxwo+C9E0ethNA36xWJaG6E5gnjBFVBSbHE6cXo1DdeHMQ==
X-Received: by 2002:aa7:96bd:: with SMTP id g29mr8447978pfk.28.1572547069886;
        Thu, 31 Oct 2019 11:37:49 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id w27sm4150620pgc.20.2019.10.31.11.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:37:48 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v7 00/15] thermal: qcom: tsens: Add interrupt support
Date:   Fri,  1 Nov 2019 00:07:24 +0530
Message-Id: <cover.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Daniel, only patch 15 needs to be changed in the tree being submitted
to linux-next. But here is the entire series for completeness.

Hi Thermal and MSM maintainers,

I believe this series is now ready to be merged. The DT bindings and driver
changes should go through the thermal tree and the changes to the DT files
themselves should go through the MSM tree. There is no hard ordering
dependency because we're adding a new property to the driver. It would help
to soak in linux-next for a few weeks to catch anything on kernelci.org.

1-4, 7, 14, 15 => thermal tree
5, 6, 8-13 => msm tree (already applied by Andy)

Regards,
Amit

Changes since v6:
- Stephen reported a warning that only shows up with gcc 9.x
  (https://lore.kernel.org/lkml/CAHLCerOkeOEEUgtJ=YgDKKXDiyFXHQ4LBdzg3-3VtKvpyceqFg@mail.gmail.com/). Include a patch to initialise the index variable to zero.

Changes since v5:
- Julia found a missing put_device() call in the success path of
  tsens_register() while baking in linux-next. A single line change to
  allow the error and success path to use the call to put_device(). Thanks
  Julia and LKP.

Changes since v4:
- Change to of-thermal core[1] to force interrupts w/o changing polling-delay DT
  parameter
- Corresponding changes to DT files to remove the hunks setting the values
  to 0
- Collected reviews and acks

Changes since v3:
- Fix up the YAML definitions based on Rob's review

Changes since v2:
- Addressed Stephen's review comment
- Moved the dt-bindings to yaml (This throws up some new warnings in various QCOM
devicetrees. I'll send out a separate series to fix them up)
- Collected reviews and acks
- Added the dt-bindings to MAINTAINERS

Changes since v1:
- Collected reviews and acks
- Addressed Stephen's review comments (hopefully I got them all).
- Completely removed critical interrupt infrastructure from this series.
  Will post that separately.
- Fixed a bug in sign-extension of temperature.
- Fixed DT bindings to use the name of the interrupt e.g. "uplow" and use
  platform_get_irq_byname().

Add interrupt support to TSENS. The first 6 patches are general fixes and
cleanups to the driver before interrupt support is introduced.

[1] https://lore.kernel.org/linux-arm-msm/1b53ef537203e629328285b4597a09e4a586d688.1571181041.git.amit.kucheria@linaro.org/


Amit Kucheria (15):
  drivers: thermal: tsens: Get rid of id field in tsens_sensor
  drivers: thermal: tsens: Simplify code flow in tsens_probe
  drivers: thermal: tsens: Add __func__ identifier to debug statements
  drivers: thermal: tsens: Add debugfs support
  arm: dts: msm8974: thermal: Add thermal zones for each sensor
  arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
  dt-bindings: thermal: tsens: Convert over to a yaml schema
  arm64: dts: sdm845: thermal: Add interrupt support
  arm64: dts: msm8996: thermal: Add interrupt support
  arm64: dts: msm8998: thermal: Add interrupt support
  arm64: dts: qcs404: thermal: Add interrupt support
  arm: dts: msm8974: thermal: Add interrupt support
  arm64: dts: msm8916: thermal: Add interrupt support
  drivers: thermal: tsens: Create function to return sign-extended
    temperature
  drivers: thermal: tsens: Add interrupt support

 .../bindings/thermal/qcom-tsens.txt           |  55 --
 .../bindings/thermal/qcom-tsens.yaml          | 168 ++++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  92 +++
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |   6 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   4 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |   6 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |   2 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   4 +
 drivers/thermal/qcom/tsens-8960.c             |   4 +-
 drivers/thermal/qcom/tsens-common.c           | 529 ++++++++++++++++--
 drivers/thermal/qcom/tsens-v0_1.c             |  11 +
 drivers/thermal/qcom/tsens-v1.c               |  29 +
 drivers/thermal/qcom/tsens-v2.c               |  13 +
 drivers/thermal/qcom/tsens.c                  |  59 +-
 drivers/thermal/qcom/tsens.h                  | 286 ++++++++--
 16 files changed, 1102 insertions(+), 167 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml

-- 
2.17.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D367CD898D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 09:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfJPHe0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 03:34:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36709 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731730AbfJPHeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 03:34:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so14159523pfr.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oaPZpMWVpeTaXyczMAyADaVhWo958LDrNtPNnm45k+8=;
        b=LHH658wbM0k+Va6D68qeWuqW0Y4HISxQ7+Chb07DJVuuyyRkDwj6wXRYQz323X9V84
         W+ep2amIpCgm+BTuNFr6j+z7O/l/hOaTEqmNiKMWVk10CCWWCwVADl8+rCTeZ8JRjiSf
         7fQ8eOOOxw+q1xg8IvQ9NGaUH3AqD2WoA5I1e2+8QB18aG8IbsfBBL0demeKmfDKx4cG
         cXZaE5tau0Kn00F91zB/bU1iBBsfHtpPeFc3tiSwRq1HlEAGE9vRzkzNW7HfCx5cuT/9
         bP9D3oK2xsBa9Vl9LMeSPi2mT2h5mWTZuMXzpphvQp0CTHIJUSIAxjMfIUxPiG+y06Ku
         XWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oaPZpMWVpeTaXyczMAyADaVhWo958LDrNtPNnm45k+8=;
        b=OwxqqDirO4RPGiWLFYIg3cz0IVuAgAi6aQiACGLBrp3yzSJFrfbvzmm7zMiEktqztD
         wt1lid0VRZk3c1KO2MbOSUZ5Zger1Teapn7dmVH7Rnwlf8xXxD+t39oAMFaxGxZWwg37
         unQCmsu+CrXSJxiaK09HTCChlFEg7pGDml6ndBfbdIAQj23neV34hH65P6y/9Nkar+T5
         0/I5UfXPFTe/jS6+5SSmZ5EBk4az78eMDiHjOxUDQinr8DyFkjTGGPohWwVvGOwHkly/
         3nU5BlRSazHbhrcB+VNE/flLRc2r8K7rJ7bkW0WVlDpbHqGpbMjVMRHEX9mDN8HoB5cY
         VI+A==
X-Gm-Message-State: APjAAAVqGeqm8bHHNge/OW94vrEXymZsvmVzzLExruVOVSnmIcrsdBaU
        9nIURtXFWrAljGnIEQ0z/nbuhlMKnX41rg==
X-Google-Smtp-Source: APXvYqxy/0e4eqIE4Ili3iqksq7BQ+lJQZd8bolWvI3oQgQtrJukriBBE5CvPXT4GwVhZmJGPhniOg==
X-Received: by 2002:a63:1042:: with SMTP id 2mr44558827pgq.59.1571211262784;
        Wed, 16 Oct 2019 00:34:22 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id x125sm25026657pfb.93.2019.10.16.00.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:34:21 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 00/15] thermal: qcom: tsens: Add interrupt support
Date:   Wed, 16 Oct 2019 13:03:59 +0530
Message-Id: <cover.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thermal and MSM maintainers,

I believe this series is now ready to be merged. The DT bindings and driver
changes should go through the thermal tree and the changes to the DT files
themselves should go through the MSM tree. There is no hard ordering
dependency because we're adding a new property to the driver. It would help
to soak in linux-next for a few weeks to catch anything on kernelci.org.

Regards,
Amit

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
 drivers/thermal/qcom/tsens.c                  |  58 +-
 drivers/thermal/qcom/tsens.h                  | 286 ++++++++--
 16 files changed, 1102 insertions(+), 166 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml

-- 
2.17.1


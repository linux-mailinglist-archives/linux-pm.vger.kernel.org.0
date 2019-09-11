Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D118AF68A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 09:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfIKHQn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 03:16:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfIKHQm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 03:16:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so13101658pfl.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qUxVco5+9ktkoNCi0Mi64R9yup9qLyKawGp7kQ7ed2w=;
        b=HFGSzct6wcdfRhoSXr4x1ifFQAt+kMTqekWwXS6k2NfgZj9w5KBMQZYa/T2W7mmK28
         yLrVs/h+VFNkNcx6TtF4LZmHNRuniUy4MX6M0sSCq13mL8WWNlbuBDv3kvKJTm97XvV0
         zCbE9oQDQfUoC7ezO3TgjdW+MOcv4QsdbIbEjb2ziUMCJDgg9zQmZJ5ImnisNzk9sSVY
         WiLZAwnvmjbeXimxHb6q7s+bKsDO+MhGyR/TW7A61HtD2qTGgNdQCtndZXgk1MxfZGbJ
         UFNxJfeRZdgmvBZ00BnmAVgYpKjjHa2rNtCMYmeEWSv1KWKpm59y8cCRwFyoJY0FtnKi
         Vx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qUxVco5+9ktkoNCi0Mi64R9yup9qLyKawGp7kQ7ed2w=;
        b=lg2twMURusHtELkjHd9aoCIz8vTRw5T5KGW5lVUw6q6FG4LPyBTPW7teL8ZCAcJ4e3
         t0Fg/kSkoJfsOm0f70+vOds2UVXVypGgVwVByXzQH2NjOjkTAICNZHnNmyAi9Y082UdB
         Lrrl5xerR5YJYCrf3Hh2O70+X1EraVl+Q7Pu/ksPNO/kvXOzgg3HmDv7xHY6dTc3JgoR
         LiUkRW5HXiTv+dbmAGFzYuS1d4OadtAxvpGkhn/1uU6knwgiQqdeVnxq2Vl9n63PZIoR
         FbONwV0OanG7pqU9xNme9ltA5GIosm6hy6RWS1kJYKm5Hb3TLBkVnEukwEaegkgnnwF9
         kpJw==
X-Gm-Message-State: APjAAAX6QQtcUEVIyMHGp12/ftDdeJEknitS24TuC2lsN+lm23CSP2GP
        SNpn761RxCXbk1YlJ1A0w8GMhw==
X-Google-Smtp-Source: APXvYqwIwlbCdDcjnWBcmrrRCBki67IYc6HmBfZIKB+VpmUNhcS8cnxox+j8Ctb9q2YUlHKloGPOFw==
X-Received: by 2002:a17:90a:8509:: with SMTP id l9mr3834867pjn.10.1568186200477;
        Wed, 11 Sep 2019 00:16:40 -0700 (PDT)
Received: from localhost ([49.248.201.118])
        by smtp.gmail.com with ESMTPSA id c2sm21933784pfd.66.2019.09.11.00.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 00:16:39 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 00/15] thermal: qcom: tsens: Add interrupt support
Date:   Wed, 11 Sep 2019 12:46:17 +0530
Message-Id: <cover.1568185732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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

This series has been developed against qcs404 and sdm845 and then tested on
msm8916 and msm8974 (Thanks Brian). Testing on msm8998 would be appreciated since I don't
have hardware handy.

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
 .../bindings/thermal/qcom-tsens.yaml          | 174 ++++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 108 +++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  26 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  60 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  82 +--
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  42 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  88 +--
 drivers/thermal/qcom/tsens-8960.c             |   4 +-
 drivers/thermal/qcom/tsens-common.c           | 529 ++++++++++++++++--
 drivers/thermal/qcom/tsens-v0_1.c             |  11 +
 drivers/thermal/qcom/tsens-v1.c               |  29 +
 drivers/thermal/qcom/tsens-v2.c               |  13 +
 drivers/thermal/qcom/tsens.c                  |  58 +-
 drivers/thermal/qcom/tsens.h                  | 286 ++++++++--
 16 files changed, 1254 insertions(+), 312 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml

-- 
2.17.1


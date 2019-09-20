Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1FB9930
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 23:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfITVwk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 17:52:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35257 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfITVwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 17:52:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so5416223pfw.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3IBI4VzQC8G6/WZtP5+yBukBePHmrxVtew1M4S8Z7rI=;
        b=ReRPawgWWpuLjKAAHsg+Pn3Nod9EEuaMXpsr4pvKofTa5KvWkvaUPYim3j6ZxGNSVL
         352bzZpZBYZJFhR6jL01AbubcUbSfVD4FC+j1zlpqnU4CoZhaGbdB4u1/bxeCWnS/zcn
         91aJlxTEDQAJY9R2xQpffXUKZ9gjsO0BzitTOU6iDyj0Gq4Gq4CocZZ9Y8xXlqcfVoLK
         ewJwd6XM/2dSBK/tvuF6N4A5vlU5O1beXJRpCr+4enOwGPFmV8DL7aSL/01ZToIdruji
         g1ocC/u5BSaMdIMlPw9kNhmVZOVYTwV2Y05p1azrrB6hcCu/5GGtdkTkh7faAVDyDkB5
         K/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3IBI4VzQC8G6/WZtP5+yBukBePHmrxVtew1M4S8Z7rI=;
        b=QJKrnUPGU9GLSw8RljUpvpPvUs8ztucoU7MOlU0OLMvUS/3Cp5mHI80B7QiIpdYZtC
         khnnu8XFbUHJKief/B7cjRqNJYfHNEMDFlhvcsd6dLAFMOfdwBy0lSn7kE/tlkRKgAqI
         ylNjceMWEaKETvgeaCQ17PD6+O1J9IQ9Z2IN/cC0bWmJoikeiwpZ8wafHAKMPEV/L8+w
         PHS4p7PHQu1vPxp0SN7ngKAZM5MFvBYoCHoDD/k/2OStlTDYh2yjzr3H+ZQhAQOfNWD+
         KNAsI2K/38f8Uv0C/yNe+kIcTrt1r/uafTlYgwwAWV3sSrFjV33Ro1A7VO5RwUZQ1fds
         xVig==
X-Gm-Message-State: APjAAAX27rMokrIspD/K3yB75kf9WDllEDNRSgTGHrAKyrfwpSZYpDtT
        RVg/ovhK6xIhcPezAdQdmoKx5A==
X-Google-Smtp-Source: APXvYqw/UvbpyEv99dkTW9ixHJR67Bs54ygcEkIYExmpvZdDHnXMZ+tQt5pIDrd7S0E1skX+XzyPPw==
X-Received: by 2002:aa7:9285:: with SMTP id j5mr3174329pfa.67.1569016359330;
        Fri, 20 Sep 2019 14:52:39 -0700 (PDT)
Received: from localhost (wsip-98-175-107-49.sd.sd.cox.net. [98.175.107.49])
        by smtp.gmail.com with ESMTPSA id ce16sm2001577pjb.29.2019.09.20.14.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 14:52:38 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 00/15] thermal: qcom: tsens: Add interrupt support
Date:   Fri, 20 Sep 2019 14:52:15 -0700
Message-Id: <cover.1569015835.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
 .../bindings/thermal/qcom-tsens.yaml          | 168 ++++++
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
 16 files changed, 1248 insertions(+), 312 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml

-- 
2.17.1


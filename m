Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814BC1F0BFB
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgFGOpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgFGOpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F080FC08C5C3;
        Sun,  7 Jun 2020 07:45:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so17335037ljo.0;
        Sun, 07 Jun 2020 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JDGZPQi2Yj5A7V6cJ2keqxjpiTi3mSoci6fXsl7qJY=;
        b=FBIyeUUzxRMOFRkVpP6z1gOqpoV/QrLzbk+0oiY0Esh+5vMnsYn2P30RnnHTXE8tlg
         14tMU7OLypG+lf6j8AbtZCwWflAX5Xj6AwkCVQg525NbVBoZf60puaLPqU+Y+A/87kOh
         uko51NBbuPqpBzDI6ws8h9JoqIZE9G/w6mAsQ76MlbXyaaSn1spg3Aoeh/OIg4TKcfoU
         gCkaHLNm7Sltsm0I9gcKiopojTzu8MXTYFbPLMaBpQCKaJE75lsqIy1sDi8BNb37pTOF
         7QIELX3AX9cu5AzgKCHl+W0B18V+tfCd4LWESbk4YgtWanR3hfbuMKRDx7400+4VDXbi
         gTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JDGZPQi2Yj5A7V6cJ2keqxjpiTi3mSoci6fXsl7qJY=;
        b=c4ezmzU2YQcX8KdYh5tAwaVUWLwQfZHsCqlI6qI/tflpGoIf8rPeOBB0AJNi312YDH
         Qop8ePrcPqVGvUgUMyNmO0qH4o1BQHHzqOdibubBs7rwnOJ0/SIGt1IUSF1lisuR6XBv
         vFzrt6vncwMpjxh89fcBlV0q4iRkDbdFfVPRaVZAKMFT5pvA7TWKam5J/lOzd44zAo13
         ZQV6T4I8SFEXSUg3m62AUHvLcxbu50+t8suEUhwY9QheEgADqoc1kpPw9UJZ8TgtAHO4
         t4EYU3U3jT8TjNgd57jHl6BU+jcMKqYqFlCieFrJMjPWJK5PN+3odCix7zTXyEUbwLUs
         JNcw==
X-Gm-Message-State: AOAM532YxDnbnX6e6Y00unE1IYK1SwmiQzYBjg1kUHnyH+ASLemZmECA
        Z/+iQhpc2oW2FQPLpqAyNuE=
X-Google-Smtp-Source: ABdhPJwg2H9+0okiFAhVICFLPP0sO3PmoCwOwLNNevTmOJR+dTOjD3Vqqvmwm1i2kjfJ1Q0Njto5kg==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr4455843ljj.132.1591541116251;
        Sun, 07 Jun 2020 07:45:16 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 0/9] Summit SMB3xx driver & device-tree
Date:   Sun,  7 Jun 2020 17:41:04 +0300
Message-Id: <20200607144113.10202-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We gathered existing patches, fixed and improved what we could and
final result is an working charging driver with device-tree support
for Nexus 7.

At this moment charging works with:
 - Nexus 7 2012 (grouper and tilapia)
 - Nexus 7 2013 (flo and deb)
 - ... and there are more devices equipped with these chargers.

Changelog:

v2: - Addressed v1 review comments from Rob Herring and Sebastian Reichel
      by moving out common battery properties from the charger node into the
      battery-cell node.

    - power_supply_register() of the SMB driver converted to resource-managed
      API variant.

    - Improved DT property names of the SMB binding by making them to follow
      the generic power-supply naming scheme (-microvolts at the end, etc).

David Heidelberg (6):
  dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
  power: supply: smb347-charger: Use resource-managed API
  power: supply: smb347-charger: Implement device-tree support
  power: supply: smb347-charger: Support SMB345 and SMB358
  power: supply: smb347-charger: Remove virtual smb347-battery
  ARM: dts: qcom: apq8064-nexus7: Add SMB345 charger node

Dmitry Osipenko (3):
  dt-bindings: battery: Add temperature properties
  power: supply: Support battery temperature device-tree properties
  power: supply: smb347-charger: Replace mutex with IRQ disable/enable

 .../bindings/power/supply/battery.txt         |  10 +
 .../power/supply/summit,smb347-charger.yaml   | 165 +++++
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  23 +
 drivers/power/supply/Kconfig                  |   6 +-
 drivers/power/supply/power_supply_core.c      |  18 +
 drivers/power/supply/smb347-charger.c         | 565 +++++++++---------
 .../dt-bindings/power/summit,smb347-charger.h |  19 +
 include/linux/power_supply.h                  |   6 +
 8 files changed, 542 insertions(+), 270 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
 create mode 100644 include/dt-bindings/power/summit,smb347-charger.h

-- 
2.26.0


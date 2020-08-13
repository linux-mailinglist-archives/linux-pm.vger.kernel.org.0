Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0183B2440AC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMVec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgHMVeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A3C061757;
        Thu, 13 Aug 2020 14:34:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so7788931ljj.5;
        Thu, 13 Aug 2020 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IThCDjeYxkkM18VbuagJbEDKwOsjCUD5KwOfUA5QrWc=;
        b=L0Vgyqpru8kmueUsI4cVMqp6htGxBMqzWsqUuXQPNeZvPK2y2MuDiHPu7qelLmRmJK
         cRLvokXPeEs+Pfbmq9vu/zr+xclqXoYNjOW9fYWfk8QFVFr1fQv8YHM3lUv2VI7vkuj1
         Dwc4gvPB9j9wy9nknQao6OgKHG4wTJjzIm/8qL3pvBRgBIYqPdRu1Bt3Er7id/8frVh5
         nPSlN9IzzY/2Rsx18Kp72B/98RCIh1+du2sII5gzZAqO39vsRo5Pre3ANx0dWIemEFU1
         znZNYXeLliGeOzNQCt7tK2jmIUKvykrEaOEmAd9mGcfJ3/L/9wEXlkUYam/C5UbztUgc
         AoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IThCDjeYxkkM18VbuagJbEDKwOsjCUD5KwOfUA5QrWc=;
        b=qUGyPZI5VfvZt0p0MZvVXIOjeZTO/KL00rYjQNbKjJUcwFOlqcbUYkp+irRh8jbzE+
         Cd/Zigocw9EwvEJeq5wMLGyQQ1Li9hEf/eknefQ/WLEAbV5pphuIWa7Rt7DpnrDbMVFM
         QeQwZQO5XZmExhXE7OQ+/Y22OhKf4PiHTr/5aO3tggoN0zbTYOpUIGf4EuSB30jc5JYE
         NskWsF9+s5J50H17JxXVlLKy1BvgcL9pHA0NavaOTIvXoes71AICy98X80g6U1ci161c
         97snsOyZxhwN7Xf5V5+YWtOoiukH/Z6/BHDHAeVyNAp83sWMnQL8kQPboECN+cMJfH9s
         zcaw==
X-Gm-Message-State: AOAM530kYap4jnrACXaMXuCkn4H44psHmsJWjBy0xhrKKv5HKGupgtsy
        Iqd+Wkm3vM8D/4APxrfKUok=
X-Google-Smtp-Source: ABdhPJy7yIGjPYA4/SOFJxhPGBV9c3CsJJwXuYU/XrKIbhdrF8Hoz43SP8lvuUwkYMhr8W94+XKQFw==
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr2736517ljh.70.1597354469716;
        Thu, 13 Aug 2020 14:34:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 00/10] Summit SMB3xx driver & device-tree
Date:   Fri, 14 Aug 2020 00:33:59 +0300
Message-Id: <20200813213409.24222-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
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

v3: - The uint32 type now isn't specified for standard units in the SMB
      DT binding because standard units already have a type.
      Thanks to Rob Herring for the suggestion!

    - The battery binding changes are rebased on top of the new battery.yaml

    - The new battery temperature DT properties now have shorter names
      and use <min max> format. Thanks to Rob Herring for the suggestion!

    - Added new patch that adds SMB charger node to the new Nexus 7 2012
      device-tree which has been merged into v5.9 kernel.

v2: - Addressed v1 review comments from Rob Herring and Sebastian Reichel
      by moving out common battery properties from the charger node into the
      battery-cell node.

    - power_supply_register() of the SMB driver converted to resource-managed
      API variant.

    - Improved DT property names of the SMB binding by making them to follow
      the generic power-supply naming scheme (-microvolts at the end, etc).

David Heidelberg (7):
  dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
  power: supply: smb347-charger: Use resource-managed API
  power: supply: smb347-charger: Implement device-tree support
  power: supply: smb347-charger: Support SMB345 and SMB358
  power: supply: smb347-charger: Remove virtual smb347-battery
  ARM: dts: qcom: apq8064-nexus7: Add SMB345 battery charger
  ARM: tegra: nexus7: Add SMB347 battery charger

Dmitry Osipenko (3):
  dt-bindings: battery: Add temperature properties
  power: supply: Support battery temperature device-tree properties
  power: supply: smb347-charger: Replace mutex with IRQ disable/enable

 .../bindings/power/supply/battery.yaml        |  24 +
 .../power/supply/summit,smb347-charger.yaml   | 152 +++++
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  24 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   |  24 +-
 drivers/power/supply/Kconfig                  |   6 +-
 drivers/power/supply/power_supply_core.c      |  19 +
 drivers/power/supply/smb347-charger.c         | 565 +++++++++---------
 .../dt-bindings/power/summit,smb347-charger.h |  19 +
 include/linux/power_supply.h                  |   6 +
 9 files changed, 568 insertions(+), 271 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
 create mode 100644 include/dt-bindings/power/summit,smb347-charger.h

-- 
2.27.0


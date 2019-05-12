Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B081AB25
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2019 10:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfELI0U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 04:26:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELI0U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 04:26:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so5485712pfm.12;
        Sun, 12 May 2019 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z7fqRlGKomLBOv7X8ZNXyme9e+4ESlFc2IpZxYNJbQs=;
        b=LivOin7NcHcNmpntbideMsybvPb498BcFq1ByK6j+Uq7qL0e0WJvVSp5vQ4Znq0DcI
         ajxGhn/HbbuGzQLBXHpG6wochn8ootEPLp5sm7Zyd/FSIsQzntX/ux5er9FaJzEiMQBg
         Rhq/rGnR3exp6P0UJa/AbHyPIxIIq0VkqmIS92Nvqt8Ugs/k+VP9SAVZwT/8VZHKsPxY
         xqwpgMmSHatKLFtk75kXaKCMrHbiju+9KA9tBO8tzbVOYn32laQl9jA6UKTeNRTMOid4
         9LO71V6c/jM6NdK38rwp2cU5N5tVX5UnRf600YpeivrxfL4DmzWPfsraXmWE2TzQVWQL
         aWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z7fqRlGKomLBOv7X8ZNXyme9e+4ESlFc2IpZxYNJbQs=;
        b=AiegK+tG+WVGx6VyYdnkR3wnhOcB0N4LHo13xlSlVOiQPqn7Rrzq+RGhalDyJmdusv
         lebeq3JLHwJZEyv0jgF/QmzXHMtgfSrwzIbzGn2vZgu19B8EPsdUlaUIZfYNcfudM5JU
         qBQmZ62aBidm3w7fPdgPaCtyJSnniMxR3C9Kr4OV1eptH/4FRyeeRViG4jf4elRwxbwW
         eJnH0QXZiGZ59oNwBrGBZOvZYOdIqDn1JC6HSj8XkAVPty07MMjxuKy0QvhwvyuiKWKG
         e3g4c8vRY2Vhb9Jo6W7KTcTcgohisXKs5m/SLiTQCt8CGL8mRNPpNpp+eIrz0E8Fa6vA
         dBTg==
X-Gm-Message-State: APjAAAUftvekOAoTb8Qo+TbgoEN3WFqD2HH1sxX59gZaslL8r7gdBxnM
        2ebkTKLBF0pPOiLxYasWACI=
X-Google-Smtp-Source: APXvYqx1A1kbLI9y/5pUCwvMoNIIk19yu+EqQtr6gApatuYzdCzGhzmtCXnd5sRlZo9Rzt2csXEEeQ==
X-Received: by 2002:a62:200f:: with SMTP id g15mr26215748pfg.7.1557649579414;
        Sun, 12 May 2019 01:26:19 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j9sm30306887pfc.43.2019.05.12.01.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 01:26:18 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        catalin.marinas@arm.com, will.deacon@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] add thermal driver for h6
Date:   Sun, 12 May 2019 04:26:11 -0400
Message-Id: <20190512082614.9045-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset support thermal driver of allwinner H6.

Yangtao Li (3):
  arm64: defconfig: add allwinner sid support
  thermal: sun50i: add thermal driver for h6
  dt-bindings: thermal: add binding document for h6 thermal controller

 .../bindings/thermal/sun50i-thermal.txt       |  32 ++
 MAINTAINERS                                   |   7 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sun50i_thermal.c              | 357 ++++++++++++++++++
 6 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
 create mode 100644 drivers/thermal/sun50i_thermal.c

-- 
2.17.0


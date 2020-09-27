Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E651B27A18F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 17:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgI0PKD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0PKD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 11:10:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB95C0613CE;
        Sun, 27 Sep 2020 08:10:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so4105372wmm.2;
        Sun, 27 Sep 2020 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNSBe0zAjluon9ill3hnifHC4ktxmqkt1PDQlHvm6Pg=;
        b=Ge3aF7MshyN28iK7O+AE8wVD5ytwxAYLrlMjJZIwSpogIG8K/pG0mmJEalGoHYm+oa
         ULzhjxlRNzJVNzYEPWGado0teCQDKTqNnhsqpL/IHb5S3XyPiZPWKJh6ykICVGYyHN+8
         xC54Sz0Ae75JyrOZ07f5N7pUkPmEgHbWlYTybpCYD0X4dPjYPAXV7GpoNPP1TjJZ06Kg
         z7ivCEf699pdVSaEeXtDns9fyAytsK2h2GXbzcgFrR7IwJW4VKhlkGNNu2Yowg2V8L5K
         hYMjVgG+Y1yfJqPY0J84H6TUEeHxCglfVHrbOpPs8/YKx+gOJSNu3TWfepj7oA0m6Lkp
         En7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNSBe0zAjluon9ill3hnifHC4ktxmqkt1PDQlHvm6Pg=;
        b=Gc4TQTTNggrTDZyjOhGfrveIScTv0EfN24w0lARMXjttOVvCZUxB1GesLgK+a5VlwY
         6b2dcWlzA+TUy4Dev2sVLo+MdRyOY9GpdJVdA2DDTotuq4KuR/5oBfJcw2aFtnBaKDyT
         5Vk19lpw/0VX18CAVjkUwPBWybKmLOzaFfvPF0ndt1tWPGEmbb74L+KNptfRvLtan5zV
         bCI7Llw51J2IVrwrHnhYtQHZTUXsVSFYxZuectBHqAIE4C7brtKz0ZgspApUOHopPdI/
         BJZb0CR5JMwFDcB3k+nVu7RJWPEH8rAuqud1vePRLqFhcwtMbAtvvrktsPzMIH1/agG7
         5IrA==
X-Gm-Message-State: AOAM530SVc6KCYmoHNSPGaZy7YdeBXASfkmldwxRyoPFAVj8ilit0Qrv
        2lbzM6HHDuHeEynITqGkSnQ=
X-Google-Smtp-Source: ABdhPJyQfBZuFJLSQfmtsxw396achk7s8orrIXlS/eW/HeoBrYMfZLeHLR+tmELZqpjWdK9h9+2xXA==
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr7301070wma.162.1601219401421;
        Sun, 27 Sep 2020 08:10:01 -0700 (PDT)
Received: from arrakis.kwizart.net (lfbn-nic-1-212-171.w2-15.abo.wanadoo.fr. [2.15.59.171])
        by smtp.gmail.com with ESMTPSA id s11sm9565114wrt.43.2020.09.27.08.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 08:10:00 -0700 (PDT)
From:   Nicolas Chauvet <kwizart@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v2 0/6] thermal: tegra: soctherm bugfixes
Date:   Sun, 27 Sep 2020 17:09:50 +0200
Message-Id: <20200927150956.34609-1-kwizart@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When using tegra_soctherm driver on jetson-tk1, the following messages
can be seen:
from kernel: tegra_soctherm 700e2000.thermal-sensor:
 throttle-cfg: heavy: no throt prop or invalid prop
 soctherm: trip temperature -2147483647 forced to -127000
 thermtrip: will shut down when cpu reaches 101000 mC
 soctherm: trip temperature -2147483647 forced to -127000
 thermtrip: will shut down when gpu reaches 101000 mC
 soctherm: trip temperature -2147483647 forced to -127000
 thermtrip: will shut down when pll reaches 103000 mC
 throttrip: pll: missing hot temperature
 soctherm: trip temperature -2147483647 forced to -127000
 thermtrip: will shut down when mem reaches 101000 mC
 throttrip: mem: missing hot temperature
 IRQ index 1 not found

This serie fixes two errors and two warnings that are reported in dmesg
It was compiled and tested at runtime on jetson-tk1 only.


v2:
 * Add missing tegra210 device-tree properties
 * Add the appropriate prefix for tegra soctherm
 * Use SoCs condition over of_compatible


Nicolas Chauvet (6):
  ARM: tegra: Add missing gpu-throt-level to tegra124 soctherm
  ARM: tegra: Add missing hot temperatures to tegra124 thermal-zones
  arm64: tegra: Add missing hot temperatures to tegra132 thermal-zones
  arm64: tegra: Add missing gpu-throt-level to tegra210 soctherm
  arm64: tegra: Add missing hot temperatures to tegra210 thermal-zones
  thermal: tegra: Avoid setting edp_irq when not relevant

 arch/arm/boot/dts/tegra124.dtsi           | 11 +++++++
 arch/arm64/boot/dts/nvidia/tegra132.dtsi  | 10 ++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi  | 13 ++++++++
 drivers/thermal/tegra/soctherm.c          | 38 +++++++++++++----------
 drivers/thermal/tegra/soctherm.h          |  1 +
 drivers/thermal/tegra/tegra124-soctherm.c |  1 +
 drivers/thermal/tegra/tegra132-soctherm.c |  1 +
 drivers/thermal/tegra/tegra210-soctherm.c |  1 +
 8 files changed, 60 insertions(+), 16 deletions(-)

-- 
2.25.4


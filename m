Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC471AB30
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2019 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfELI0W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 04:26:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35997 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELI0W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 04:26:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so5514857pfa.3;
        Sun, 12 May 2019 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SrTOiwR/CPBeTBREF635F4hrotYecrCbbaRjesXGtG0=;
        b=cLuOPpJ9Da6NeyQxhpSQyjD9xr3Gyw7I4lJmHc079PDwkPoQBRqYMtRnigdOsR4ESa
         6fxTI+xuv5MuJ2z2oCtGc+9O7ZFir2a7Bsnce3C/4m0ZYV2InRxKx3TG07Au+Y/ZSstW
         xcDnZag2RpsFXIMi2E6xs6+G11t9QJpWjTp58oXDLZSG3PnSGM8f2E/HH5jSVRgsy7Fo
         ryX4r22IiDHPqLnynoA1q+vCndBw8tT/6O4RlkbpU2DuH1HWuuc+I6uj7P0ZhvRgfGZk
         miuLL4ku153mkomHMD/VDRyPvVwFZUSxfdn8aLW4EmhibEFrvPilHQNTKRKzOJ3vG8bv
         XmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SrTOiwR/CPBeTBREF635F4hrotYecrCbbaRjesXGtG0=;
        b=gm0LZ1kqNxA2l8czsOqx03RnM5eopJWjRdqjkOkI2qvCYvurExyo62bnwq8NEKqa2i
         gHZ6O+C1FFGAjofgrVTd04kHZKLCXXDs8U4eDwpQOlX6CMUezLffeDgcUjrIggrQb4/z
         tqTN6aoTrPTucPujufkNXkvw1jQLYZHn3xqElGx8YYW1QlXjdhpA2oFGYD+4DE4o02cQ
         vXuCnIkhUwwq0o30BcGczg2Ao/GIkIaRcNrqd4TQZAZVQHXGLfNtRCcO3FNQfnNq0D1a
         zbluAp7pOqmh1sDvXFZfQn6Dd+u+9aeBCZZNRH27WPg4SQGxcFAfXm9E+w7DaQtYgWyT
         9A/g==
X-Gm-Message-State: APjAAAXSG82hBuGN1KUGZTKbekN7lTgZD6U2WrJAcM+vQCUnDmWkHlIf
        3KUv1c7VFkiLl0RMOSiPBxo=
X-Google-Smtp-Source: APXvYqzDllbAtzla73pnEa51Op3OwU/7GI89B6k5LpFoWVpxXrDzw8gblAKp9i29cTy8nv5IgMtzyw==
X-Received: by 2002:a62:125c:: with SMTP id a89mr26302860pfj.93.1557649581967;
        Sun, 12 May 2019 01:26:21 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o6sm1744062pfa.88.2019.05.12.01.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 01:26:21 -0700 (PDT)
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
Subject: [PATCH 1/3] arm64: defconfig: add allwinner sid support
Date:   Sun, 12 May 2019 04:26:12 -0400
Message-Id: <20190512082614.9045-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190512082614.9045-1-tiny.windzz@gmail.com>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sid contains speedbin information and temperature sensor
calibration information and more, which are important for SOC.

This patch enables CONFIG_NVMEM_SUNXI_SID by default.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..8c23dd60f906 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -736,6 +736,7 @@ CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_HISI_PMU=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_UNIPHIER_EFUSE=y
-- 
2.17.0


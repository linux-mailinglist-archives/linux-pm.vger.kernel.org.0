Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8432A666
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2019 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfEYSNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 May 2019 14:13:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36766 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfEYSNj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 May 2019 14:13:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so5442408plr.3;
        Sat, 25 May 2019 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EnB6+3mIR1GUxLAogalYOOntDr+t9u6MSm9vkJ1kPoo=;
        b=sf1yzaTwgKxt+8JN/8Rimolz5jnu9NNXetAgOkIApDyLNJDdFaArYWTeELrst+ysF6
         OSYnqiTZkrfnVB3cRFLG1/wpr673pY8FrlPEfzb0E1jSiQ00Tp4GR3TUB70v3povEMVb
         j7mqnt1fWgFe4kDI/gFfX5/cwTOO7x0syZnVkF05kV4qYXzJ+0RoQndloQT7i8rLlGaS
         JDR6h3bcHn1uLys10XUTwd95nyEM4NM+bEuMw3l+TMNrxel0VQhsO+Ie3cORtnR4nBeW
         1M7RLnhQ2jVU97gHKeXAfGqKyYqQPG4j2OqeRb8Xto4qa71HzwBL0KWJYT4mP/lnyyGe
         F9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EnB6+3mIR1GUxLAogalYOOntDr+t9u6MSm9vkJ1kPoo=;
        b=txOrLSRZ/Y5rWZyMZuzKmar5FEiGe//55eVX+E1bjypagpa28hchji86psFwNU1pbc
         BFiqxqsAc3bP6UPPu7vtSISisbt8rQN2i1weD+ofxDsUVkLhyeKk59g1U6VftzWmVrOI
         EHxg+8hvOfBzxq+4X/fdlpH9k8kZADpbhkrhJjEhHLKP4M0YuxHIfuXj/osFARIdSWeT
         VqeqlAUhbKcUhkz/M8moJVssEfgDDiBb5QgudW64QjaeRDqbUDZ9VaW281M+Hd1biBxr
         0rtFw26xs0rbxaSnrhjWClGRkJcvQDDkz1/ae/yXbyrsquwRSjWnuCWebyVKQC2KBHyX
         kApg==
X-Gm-Message-State: APjAAAWalH8s4de9xMdzu2y+eH4Bf9NMxxZ9EHw0eG4uFrYdOYgQ/613
        VBrmF9KZqV1TCYDLbXIgHYo=
X-Google-Smtp-Source: APXvYqzz6527zTMOTWddGiv92U6XysI9bjqHAgREMygNcxWlnY6V/lVUVwTzV9Erzysf5B8LGDBWJQ==
X-Received: by 2002:a17:902:2983:: with SMTP id h3mr88692846plb.267.1558808019178;
        Sat, 25 May 2019 11:13:39 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id s66sm18914576pfb.37.2019.05.25.11.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 11:13:38 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 3/3] thermal: fix indentation in makefile
Date:   Sat, 25 May 2019 14:13:29 -0400
Message-Id: <20190525181329.18657-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190525181329.18657-1-tiny.windzz@gmail.com>
References: <20190525181329.18657-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To unify code style.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index fa6f8b206281..d7eafb5ef8ef 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o \
-					thermal_helpers.o
+				   thermal_helpers.o
 
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
@@ -25,11 +25,11 @@ thermal_sys-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
 thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
 
 # devfreq cooling
-thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
+thermal_sys-$(CONFIG_DEVFREQ_THERMAL) 	+= devfreq_cooling.o
 
 # platform thermal drivers
 obj-y				+= broadcom/
-obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
+obj-$(CONFIG_THERMAL_MMIO)	+= thermal_mmio.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
@@ -50,7 +50,7 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-y				+= st/
 obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-y				+= tegra/
-obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
+obj-$(CONFIG_HISI_THERMAL)     	+= hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
-- 
2.17.0


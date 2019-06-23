Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3264FCF3
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFWQmS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40938 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfFWQmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so6107032pfp.7;
        Sun, 23 Jun 2019 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l52fWtW3aoPkxwNQa5fIqgZrHE13Sc/TSQJ/idB7mO0=;
        b=e522gMpk4cJiXZ8WanDck6Eu2glNq4tzW8JKnszog3QBvg4Ippfq8hNQnuBo94orbX
         u2gMCzLLiqfDEbsZASmbJ/LDbnQHM3WuwjsSQks2HwbcjZwW8bYclLUg8YNHN4cRskuG
         1mxiV6/zUeI2UHI4i07lZEVAddmJg3NlXLYI0Cea4XUSP2KJCoRdXJCu5ywoyQBBrO4J
         gSDJzHwbDUQ41U4Hp9VyyQS5koSpmaIYzZII/KVK+V0OGPFxqs7Nb+IC82AvHAMrHN62
         NMkiDDwZjezT0qG3aFg6JiCw+YhtJ2roIWJnfE6wpzAZTmn7ZmgEwFn1BGH1knsQvnET
         Lwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l52fWtW3aoPkxwNQa5fIqgZrHE13Sc/TSQJ/idB7mO0=;
        b=uXINXBbNJa3Vl8COQ3OB9TW439GKpeimY/ctnF/hLhRgTQ9TfantSuH7P+NZzHE4zo
         ET55s57SjOre7EnqZPTgSOIvt0pfX14x+AUjVe2t9OSPwHkuA0fCqh/y06upVj8B+Twr
         O+b/f12G37GR8UILIA5RLWVyTHV65IGONncWoH9g4cMpp5YVwjjAuyvGUgLz06C1l/Dd
         3HybF726/lal4e2FqxWzkHkSb3aD4noDrsnhwQ46FdEi3CuFo+Xa/3iRcGSshdiTi3oO
         RWZxe+IAPWtcdI1d8kXSjgLYvRgskK8d0xE7jMJFfbaRXkjG7GhOjqrxQ31+AhywF96i
         a/MQ==
X-Gm-Message-State: APjAAAUIMPosMngMEW8y50HWWxEPSl0FIAWjlXkN/y45efwag4bF1Zwi
        x9t4QyrLhctVP8I406pkwD/sOLEk
X-Google-Smtp-Source: APXvYqxwcVFm4cX8NcFvvREnvAiZRJODJ0isOyybQ/E6r9Z7HRNVzLSobEYtQ42YhiYekF7fI++91Q==
X-Received: by 2002:a63:8341:: with SMTP id h62mr17783424pge.206.1561308137073;
        Sun, 23 Jun 2019 09:42:17 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m6sm9744878pjl.18.2019.06.23.09.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:16 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 03/11] thermal: fix indentation in makefile
Date:   Sun, 23 Jun 2019 12:41:58 -0400
Message-Id: <20190623164206.7467-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
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
2.17.1


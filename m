Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B58886B
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfHJF3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:29:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37920 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:29:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so7152834plt.5;
        Fri, 09 Aug 2019 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l52fWtW3aoPkxwNQa5fIqgZrHE13Sc/TSQJ/idB7mO0=;
        b=SM0O7cIBHumsQ4jcRMA3jRfbG/8uHpdHyKP1/m9OqUsDitUK6fDmwbyMStdXWaYfeb
         uwG4TwQJwGkbIZDm+/oa/wTjePH1DL0w5Wa0fBWTZGkbVfmMq1dCXkazSjE9p+PXvxsC
         cb17n22QlHUjEYGxUKggT+zpvIIh5pgLmPF9m718SkEYNp9Wz9kpusTVC7yaiDIMBbrZ
         FZdMFDQYPzzXaDaUfe/5xb6CtgXTL2no5kW4FdG0AVJWimrLP6wOM+kFfTSjnGbCxLTO
         fn1pwE8bZtWUqWoege1KQLdDZvYMIZ+XB366MeBVsV3hSOuEf2q7HiMJQ24K7H+j5NX/
         QS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l52fWtW3aoPkxwNQa5fIqgZrHE13Sc/TSQJ/idB7mO0=;
        b=lBhHbrSgCF5Zb591F8ChGUJnug84AF69Ceka1QEBUKknCH4pLtpDKgFaGVeE0y1MfR
         obxKQZxeW8u5f6mkbKXx9DxHfMu1F+zt9DpVQkQA3b8KhBn1xDent2AhQx9oEOPgU6Um
         3yYS2qKhh2IT8/mrKirPw9C6Vl7Z9t02m1/l9ztqwAZpA9aQg6QROAhc2zFuiVQiRCVi
         +i0lHk9ATmrJC4oub616lrg38Dbk3ymnkWBJSfB4J8TjS+Fgmh2YyVEw2hik+hiqP/kJ
         lvcIS7s6DhQhIKRRaQWmDCg1QouRJ9hoRFiospdlK6dd4fxJc2Azr0ks4VNZPX9/A5eu
         6pag==
X-Gm-Message-State: APjAAAUPt2TdtdM4QsgFU3JOAmAztqMX//A+2ixpno9aXYIxWBTXpOiI
        hWlX53UyQb+qn3goAN9f5a0=
X-Google-Smtp-Source: APXvYqwUY/gyosJ94ferIscuoGwHXFjy46dluwnpWU7klQFptAP8nSXiVk8T0B+sedSgs2wC6IUWXg==
X-Received: by 2002:a17:902:ac86:: with SMTP id h6mr16333345plr.79.1565414960902;
        Fri, 09 Aug 2019 22:29:20 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id 67sm81943594pfd.177.2019.08.09.22.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:20 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 03/18] thermal: fix indentation in makefile
Date:   Sat, 10 Aug 2019 05:28:14 +0000
Message-Id: <20190810052829.6032-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
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


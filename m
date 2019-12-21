Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD87128AA5
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 18:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfLURhl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Dec 2019 12:37:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43185 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLURhl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Dec 2019 12:37:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so5900090pfo.10;
        Sat, 21 Dec 2019 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L9fyvYyivbBa5nndc7noKKMmXslny54OD1MjJbuNarE=;
        b=sIalyB7FZZ+F+NMXsRx+5f9uLho0AUi3hMtJnZ7fRMMWhNgEyhEgdxRhV8f2o5IWhI
         WkEhCc4n0Oodbm1E6hpebzp8XQHZPX9eIKG7LyyHwkuRBHjbkcEgsmryYZLKWwHOppEH
         oU80GxbureGkjaaHFfiTNdbqQhDDFAAsFg7lgRnof+fBtjqfCZbaUQA+EqFVa4sBsWl2
         TvsDKI5OsKsW/suwXNoeJv3EXx8FvpUAA/BPRu2BABlx2UrkOAtvpvwoTq3Y22DaX+7q
         LP18XD4PugQ5r+SgY01/vfkizSqnC2gNX6CWOY5kWMZSorfxNwa242M4YhsgK+dDQJiK
         OvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L9fyvYyivbBa5nndc7noKKMmXslny54OD1MjJbuNarE=;
        b=GEZ40a6QhZctilPBf9BFGaozgY49HZDijcx3Yrahrx3CaWzifjnysRENOgLgHTaQfN
         jYHcx5hm/QXB4ZyARXHrlGZa42XOHVyLMXvvqXxbClscBGtJaMmhTiknRpnU23jzMoKk
         +AYLw6TF8+udTXMBCUSIRh3A+5g1na74BWUN1aDIonX1uTMyite9I6fa3a/LjPhG2iDt
         9d1jWbdA574lREeIzmKy583FoDEyGtcSH+XKB1EFfpccF0n7R02tQh8IieCxMWHS/9Cq
         UWeWcXa6IOKsEbl8biVv0uSeshBCLHqaGuipmgFYh/oultjl5Kgxoyc/CKyXQ1Y4ZVi6
         Niqw==
X-Gm-Message-State: APjAAAWRhpxMWKpLYYDI1/Croy0Vb3YI6LRKsp5WhVCELRo7YWBu8qer
        2RKl52EkZ26xyAgTtoKhblU=
X-Google-Smtp-Source: APXvYqyXxyFHn14Ls5Uip9ujwcZ0DlZpOxupxXFamGQQljUfbdjRdLMbzW5ZmZ7jD9ApqYdXlPxIXw==
X-Received: by 2002:a63:e545:: with SMTP id z5mr21608990pgj.209.1576949860845;
        Sat, 21 Dec 2019 09:37:40 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id u5sm16826904pfm.115.2019.12.21.09.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 09:37:40 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] thermal: fix indentation in makefile
Date:   Sat, 21 Dec 2019 17:37:37 +0000
Message-Id: <20191221173737.30906-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To unify code style.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index baeb70bf0568..ab9389bc42b2 100644
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
+thermal_sys-$(CONFIG_DEVFREQ_THERMAL)	+= devfreq_cooling.o
 
 # platform thermal drivers
 obj-y				+= broadcom/
-obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
+obj-$(CONFIG_THERMAL_MMIO)	+= thermal_mmio.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
@@ -49,9 +49,9 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-y				+= st/
 obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-y				+= tegra/
-obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
+obj-$(CONFIG_HISI_THERMAL)	+= hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
-obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
+obj-$(CONFIG_AMLOGIC_THERMAL)	+= amlogic_thermal.o
-- 
2.17.1


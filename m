Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FCF103FBF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfKTPqH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:46:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43929 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbfKTPqD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 10:46:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so14395587pfb.10
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 07:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=K3vR2uD6aSmik2p5f+bI9hiJX4uAEUswd2VgOXlpWQQ=;
        b=v+OCpIVAIUha5dasNMn3UvNfvT62nwwgAYOV8SZl2s4KlPXzNx+Y4y++1y289foJj4
         b3iRbEixPzm4H6s9NnmRYjccAQ1YKlJHSXNG7J3NYVhSi9KYAkVZL7+r+qZQfnArJKNn
         Yw+IhGEIrPZ8HYEGcbWz3FpdlBjSD01zuR9DPZ8junhpswl8xHCTYf96heDEVns7SbdA
         oqXVAJ7lKIYa/hzP14UjsMuqpTfAsr4X/OoBdfEWPZhCK+XoJKn/Ni1kYs0UjzSYv59O
         Bo1+ORxjDzOFp1d4H1WTVGTV9FhN+VcdMDKqLxkkXHiR956QFnkeYxnNFjO3o19o7DeS
         lWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=K3vR2uD6aSmik2p5f+bI9hiJX4uAEUswd2VgOXlpWQQ=;
        b=nChSdoJzIHDhHacRvbubdtAm22tknYZgpBNu02Vh0uOjM0Fwtk5dDse98r8311wvXC
         OH62KJnjq2v5HSfO8r34okxPIQnA8i9Q2CkHwiRhRdNPbBPD8L1neaJeIr2YEO+iQelS
         AUSK3AUpP1beA0DZntJR9Lt6iHulH00L8vMn7e6OPpdEyOBlTKoKBDEM7BwIs9hCiVFK
         xGAPBAC37G4vTvdRDo9Nkr9uIjGyqJw8umYjSWNbWS0l89OFulKZAIZcd1bUz5FH06ei
         nGtnHz3UJ4WjSYT+9oCenY+R0Ke10MLu2kfpYT65jjG3fgm9XDm0kre1yJJ5ByOy3hA0
         3YRg==
X-Gm-Message-State: APjAAAXH2b8qXpHQCPf7IM+Agke4l6Tf6NJTV9C9KDjV+dQA4eLocEil
        iyYcDEARH4pKTs+99R7fHow7rw==
X-Google-Smtp-Source: APXvYqxCyiCzIH5NKxNZcPzn1VR+PddAQf1yOZ8U85b+2Izo7oqHFzfQTCS3bhYodrVfdki555hMYQ==
X-Received: by 2002:a62:83ca:: with SMTP id h193mr4757521pfe.218.1574264761731;
        Wed, 20 Nov 2019 07:46:01 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id z187sm27879675pgd.82.2019.11.20.07.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:46:00 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 09/11] thermal: tegra: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:18 +0530
Message-Id: <db764f71253bb2ad569b0aeab4c91207a39317ce.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/tegra/soctherm.c:369: warning: Function parameter or member 'value' not described in 'ccroc_writel'
linux.git/drivers/thermal/tegra/soctherm.c:369: warning: Excess function parameter 'v' description in 'ccroc_writel'
linux.git/drivers/thermal/tegra/soctherm.c:447: warning: Function parameter or member 'dev' not described in 'enforce_temp_range'
linux.git/drivers/thermal/tegra/soctherm.c:772: warning: Function parameter or member 'sg' not described in 'tegra_soctherm_set_hwtrips'
linux.git/drivers/thermal/tegra/soctherm.c:772: warning: Function parameter or member 'tz' not described in 'tegra_soctherm_set_hwtrips'
linux.git/drivers/thermal/tegra/soctherm.c:944: warning: Function parameter or member 'ts' not described in 'soctherm_oc_intr_enable'
linux.git/drivers/thermal/tegra/soctherm.c:1167: warning: Function parameter or member 'data' not described in 'soctherm_oc_irq_disable'
linux.git/drivers/thermal/tegra/soctherm.c:1167: warning: Excess function parameter 'irq_data' description in 'soctherm_oc_irq_disable'
linux.git/drivers/thermal/tegra/soctherm.c:1224: warning: Function parameter or member 'ctrlr' not described in 'soctherm_irq_domain_xlate_twocell'
linux.git/drivers/thermal/tegra/soctherm.c:1686: warning: Function parameter or member 'pdev' not described in 'soctherm_init_hw_throt_cdev'
linux.git/drivers/thermal/tegra/soctherm.c:1764: warning: Function parameter or member 'ts' not described in 'throttlectl_cpu_level_cfg'
linux.git/drivers/thermal/tegra/soctherm.c:1812: warning: Function parameter or member 'ts' not described in 'throttlectl_cpu_level_select'
linux.git/drivers/thermal/tegra/soctherm.c:1855: warning: Function parameter or member 'ts' not described in 'throttlectl_cpu_mn'
linux.git/drivers/thermal/tegra/soctherm.c:1886: warning: Function parameter or member 'ts' not described in 'throttlectl_gpu_level_select'
linux.git/drivers/thermal/tegra/soctherm.c:1928: warning: Function parameter or member 'ts' not described in 'soctherm_throttle_program'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/tegra/soctherm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 5acaad3a594f..66e0639da4bf 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -360,7 +360,7 @@ static struct soctherm_oc_irq_chip_data soc_irq_cdata;
 /**
  * ccroc_writel() - writes a value to a CCROC register
  * @ts: pointer to a struct tegra_soctherm
- * @v: the value to write
+ * @value: the value to write
  * @reg: the register offset
  *
  * Writes @v to @reg.  No return value.
@@ -435,6 +435,7 @@ static int tegra_thermctl_get_temp(void *data, int *out_temp)
 
 /**
  * enforce_temp_range() - check and enforce temperature range [min, max]
+ * @dev: struct device * of the SOC_THERM instance
  * @trip_temp: the trip temperature to check
  *
  * Checks and enforces the permitted temperature range that SOC_THERM
@@ -747,6 +748,8 @@ static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
 /**
  * tegra_soctherm_set_hwtrips() - set HW trip point from DT data
  * @dev: struct device * of the SOC_THERM instance
+ * @sg: pointer to the sensor group to set the thermtrip temperature for
+ * @tz: struct thermal_zone_device *
  *
  * Configure the SOC_THERM HW trip points, setting "THERMTRIP"
  * "THROTTLE" trip points , using "thermtrips", "critical" or "hot"
@@ -931,6 +934,7 @@ static irqreturn_t soctherm_thermal_isr_thread(int irq, void *dev_id)
 
 /**
  * soctherm_oc_intr_enable() - Enables the soctherm over-current interrupt
+ * @ts:		pointer to a struct tegra_soctherm
  * @alarm:		The soctherm throttle id
  * @enable:		Flag indicating enable the soctherm over-current
  *			interrupt or disable it
@@ -1156,7 +1160,7 @@ static void soctherm_oc_irq_enable(struct irq_data *data)
 
 /**
  * soctherm_oc_irq_disable() - Disables overcurrent interrupt requests
- * @irq_data:	The interrupt request information
+ * @data:	The interrupt request information
  *
  * Clears the interrupt request enable bit of the overcurrent
  * interrupt request chip data.
@@ -1206,6 +1210,7 @@ static int soctherm_oc_irq_map(struct irq_domain *h, unsigned int virq,
 /**
  * soctherm_irq_domain_xlate_twocell() - xlate for soctherm interrupts
  * @d:      Interrupt request domain
+ * @ctrlr:      Controller device tree node
  * @intspec:    Array of u32s from DTs "interrupt" property
  * @intsize:    Number of values inside the intspec array
  * @out_hwirq:  HW IRQ value associated with this interrupt
@@ -1681,6 +1686,7 @@ static int soctherm_throt_cfg_parse(struct device *dev,
 /**
  * soctherm_init_hw_throt_cdev() - Parse the HW throttle configurations
  * and register them as cooling devices.
+ * @pdev: Pointer to platform_device struct
  */
 static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 {
@@ -1751,6 +1757,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 
 /**
  * throttlectl_cpu_level_cfg() - programs CCROC NV_THERM level config
+ * @ts: pointer to a struct tegra_soctherm
  * @level: describing the level LOW/MED/HIGH of throttling
  *
  * It's necessary to set up the CPU-local CCROC NV_THERM instance with
@@ -1798,6 +1805,7 @@ static void throttlectl_cpu_level_cfg(struct tegra_soctherm *ts, int level)
 
 /**
  * throttlectl_cpu_level_select() - program CPU pulse skipper config
+ * @ts: pointer to a struct tegra_soctherm
  * @throt: the LIGHT/HEAVY of throttle event id
  *
  * Pulse skippers are used to throttle clock frequencies.  This
@@ -1841,6 +1849,7 @@ static void throttlectl_cpu_level_select(struct tegra_soctherm *ts,
 
 /**
  * throttlectl_cpu_mn() - program CPU pulse skipper configuration
+ * @ts: pointer to a struct tegra_soctherm
  * @throt: the LIGHT/HEAVY of throttle event id
  *
  * Pulse skippers are used to throttle clock frequencies.  This
@@ -1874,6 +1883,7 @@ static void throttlectl_cpu_mn(struct tegra_soctherm *ts,
 
 /**
  * throttlectl_gpu_level_select() - selects throttling level for GPU
+ * @ts: pointer to a struct tegra_soctherm
  * @throt: the LIGHT/HEAVY of throttle event id
  *
  * This function programs soctherm's interface to GK20a NV_THERM to select
@@ -1918,6 +1928,7 @@ static int soctherm_oc_cfg_program(struct tegra_soctherm *ts,
 
 /**
  * soctherm_throttle_program() - programs pulse skippers' configuration
+ * @ts: pointer to a struct tegra_soctherm
  * @throt: the LIGHT/HEAVY of the throttle event id.
  *
  * Pulse skippers are used to throttle clock frequencies.
-- 
2.20.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21953F1708
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 14:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfKFN3F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 08:29:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36794 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfKFN3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 08:29:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so5829237pgh.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Rxuz5AKRhYwDEc2ju4DSL4K4+pPb8Uk4j39gu0W8ZCQ=;
        b=EEInOP7DB8lbrJuWagzB9tYaHP/rrHOL2bKvo3JM0gyhWrT02CnUe9hqCCpm9PcO8j
         gMqiSIawVDAZ9mrcDA7xtuPbw8DnA9wWCxCIN03EONVvvd5nLDPAIWmTK2INLgKQuQCx
         r6Cad7CUa3txk8jRPoX6WL2fRVXxszPE6VbNZZyVPcayMLaYC1hAhJCMMz4iHZRF7ait
         66JHaWPmgAmyRGvaszkezzMGCCxKaBMwhpPm4DIP6mOB3GfVoH4vigDdZdfNMhuObvv+
         tosGonmI/ET9XLrsIZUy9SQ/G5jAVgOWFvlk9QFQA7r9xN/NIhsoA4jYgcd7AanNv73u
         U9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Rxuz5AKRhYwDEc2ju4DSL4K4+pPb8Uk4j39gu0W8ZCQ=;
        b=Q5iXBbSzuZo0OLQT2vSmHcomQ1+tozmFSPj8dpG2a0uWl1c4/231sHVbk9Bvayf50q
         4TFREYsnvIvM8XrstFoi9WH2jxIsgKgKbHkzUtkfWtOAt6FsfLPY9cZyY9Rcgs0IGzUl
         +CNrdJn3fjnpzZM4r1zyXRnorrb5ry9SAtBOUVMYHdgNhI79ahMWnS1ALdPfsMOCXg7z
         YUwnLjY9MnT+9gn7qtlZh6rw4NC31NmlBbz/RoQq2HO0WXOocv1lgHqGtRNbGyYL/scO
         UMO29iJecNz8yGK90U1IJaVrk4YB6qXZRf8L+KDz/83Pw8cc3lcWbcw1ypyGXanYxwqW
         kmjw==
X-Gm-Message-State: APjAAAVJ0s91RqVq4JMWxF0pGUNtCujoOfZZbYSwSgzeo1BfW1qmVST4
        4JGaTpEyehPiiLMWWKCcN6hw7Q==
X-Google-Smtp-Source: APXvYqytz/JuKcJu8N2v0TNGLdkW02GIDujkuuO3j9EjYVAQNa4OjvjOCsKfTKAhFD0GvFtzg+g6og==
X-Received: by 2002:a17:90b:24c:: with SMTP id fz12mr3761393pjb.51.1573046943798;
        Wed, 06 Nov 2019 05:29:03 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id hi2sm2412031pjb.22.2019.11.06.05.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:29:03 -0800 (PST)
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
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 07/11] thermal: rockchip: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:23 +0530
Message-Id: <290895a22aa8a13c13b3a4ae77c13244b4ecee58.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace a comment starting with /** by simply /* to avoid having it
interpreted as a kernel-doc comment. Describe missing function
parameters where needed.

Fixes up the following warnings when compiled with make W=1:

linux.git/drivers/thermal/rockchip_thermal.c:27: warning: cannot
understand function prototype: 'enum tshut_mode '
linux.git/drivers/thermal/rockchip_thermal.c:37: warning: cannot
understand function prototype: 'enum tshut_polarity '
linux.git/drivers/thermal/rockchip_thermal.c:46: warning: cannot
understand function prototype: 'enum sensor_id '
linux.git/drivers/thermal/rockchip_thermal.c:56: warning: cannot
understand function prototype: 'enum adc_sort_mode '
linux.git/drivers/thermal/rockchip_thermal.c:123: warning: Function
parameter or member 'chn_id' not described in 'rockchip_tsadc_chip'
linux.git/drivers/thermal/rockchip_thermal.c:123: warning: Function
parameter or member 'control' not described in 'rockchip_tsadc_chip'
linux.git/drivers/thermal/rockchip_thermal.c:167: warning: Function
parameter or member 'sensors' not described in 'rockchip_thermal_data'
linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
parameter or member 'grf' not described in 'rk_tsadcv2_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
parameter or member 'regs' not described in 'rk_tsadcv2_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
parameter or member 'tshut_polarity' not described in
'rk_tsadcv2_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
parameter or member 'grf' not described in 'rk_tsadcv3_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
parameter or member 'regs' not described in 'rk_tsadcv3_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
parameter or member 'tshut_polarity' not described in
'rk_tsadcv3_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:732: warning: Function
parameter or member 'regs' not described in 'rk_tsadcv3_control'
linux.git/drivers/thermal/rockchip_thermal.c:732: warning: Function
parameter or member 'enable' not described in 'rk_tsadcv3_control'
linux.git/drivers/thermal/rockchip_thermal.c:1211: warning: Function
parameter or member 'reset' not described in
'rockchip_thermal_reset_controller'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/rockchip_thermal.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 343c2f5c5a259..9ed8085bb7924 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -19,7 +19,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/pinctrl/consumer.h>
 
-/**
+/*
  * If the temperature over a period of time High,
  * the resulting TSHUT gave CRU module,let it reset the entire chip,
  * or via GPIO give PMIC.
@@ -29,7 +29,7 @@ enum tshut_mode {
 	TSHUT_MODE_GPIO,
 };
 
-/**
+/*
  * The system Temperature Sensors tshut(tshut) polarity
  * the bit 8 is tshut polarity.
  * 0: low active, 1: high active
@@ -39,7 +39,7 @@ enum tshut_polarity {
 	TSHUT_HIGH_ACTIVE,
 };
 
-/**
+/*
  * The system has two Temperature Sensors.
  * sensor0 is for CPU, and sensor1 is for GPU.
  */
@@ -48,7 +48,7 @@ enum sensor_id {
 	SENSOR_GPU,
 };
 
-/**
+/*
  * The conversion table has the adc value and temperature.
  * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_table)
  * ADC_INCREMENT: the adc value is incremental.(e.g. rk3368_code_table)
@@ -80,13 +80,14 @@ struct chip_tsadc_table {
 
 /**
  * struct rockchip_tsadc_chip - hold the private data of tsadc chip
- * @chn_id[SOC_MAX_SENSORS]: the sensor id of chip correspond to the channel
+ * @chn_id: array of sensor ids of chip corresponding to the channel
  * @chn_num: the channel number of tsadc chip
  * @tshut_temp: the hardware-controlled shutdown temperature value
  * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
  * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
  * @initialize: SoC special initialize tsadc controller method
  * @irq_ack: clear the interrupt
+ * @control: enable/disable method for the tsadc controller
  * @get_temp: get the temperature
  * @set_alarm_temp: set the high temperature interrupt
  * @set_tshut_temp: set the hardware-controlled shutdown temperature
@@ -139,7 +140,7 @@ struct rockchip_thermal_sensor {
  * @chip: pointer to the platform/configuration data
  * @pdev: platform device of thermal
  * @reset: the reset controller of tsadc
- * @sensors[SOC_MAX_SENSORS]: the thermal sensor
+ * @sensors: array of thermal sensors
  * @clk: the controller clock is divided by the exteral 24MHz
  * @pclk: the advanced peripherals bus clock
  * @grf: the general register file will be used to do static set by software
@@ -590,6 +591,9 @@ static int rk_tsadcv2_code_to_temp(const struct chip_tsadc_table *table,
 
 /**
  * rk_tsadcv2_initialize - initialize TASDC Controller.
+ * @grf: the general register file will be used to do static set by software
+ * @regs: the base address of tsadc controller
+ * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
  *
  * (1) Set TSADC_V2_AUTO_PERIOD:
  *     Configure the interleave between every two accessing of
@@ -624,6 +628,9 @@ static void rk_tsadcv2_initialize(struct regmap *grf, void __iomem *regs,
 
 /**
  * rk_tsadcv3_initialize - initialize TASDC Controller.
+ * @grf: the general register file will be used to do static set by software
+ * @regs: the base address of tsadc controller
+ * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
  *
  * (1) The tsadc control power sequence.
  *
@@ -723,6 +730,8 @@ static void rk_tsadcv2_control(void __iomem *regs, bool enable)
 
 /**
  * rk_tsadcv3_control - the tsadc controller is enabled or disabled.
+ * @regs: the base address of tsadc controller
+ * @enable: boolean flag to enable the controller
  *
  * NOTE: TSADC controller works at auto mode, and some SoCs need set the
  * tsadc_q_sel bit on TSADCV2_AUTO_CON[1]. The (1024 - tsadc_q) as output
@@ -1206,6 +1215,7 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 
 /**
  * Reset TSADC Controller, reset all tsadc registers.
+ * @reset: the reset controller of tsadc
  */
 static void rockchip_thermal_reset_controller(struct reset_control *reset)
 {
-- 
2.17.1


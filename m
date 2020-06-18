Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9290F1FF348
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgFRNie (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbgFRNi3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 09:38:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E96C0613ED
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 06:38:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so6082842wrs.11
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=ylgAfmZa4qG8lvGYsGYTl2tyoEZh9fOa7G+6c+AuwQxnAem7Q0lvEhEISkINnMWn4O
         /6KLd+uzK8NQZ+gcEE3xkI88kCfV6QrLk9KlENgFfWrA8BxGXy3QiSV6nQMhBeVGxv21
         iqRTcKsfeWYMTyn+ieaFqPBcOzoRUkv80n9Kdu/MXaec+P5reqf4IjRXN1P9HT9DY6AR
         GKbXoZ3V58FY4tk7UQdushRRwvIRPzAhcfac1ykoeL65uXdgHd1mMQ0pvs1D7BNt80Wg
         0W7bghFEeYzE9izavJZrlsTDZExBofb+RAtSq1Bo7r2orcCUXvFleutLUIRcYNqOU/5F
         Khgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=d4P8wobJdTZRTgP5UBMwKXHMG+yLmDthHbvh3zNK/Nj6ArpqPu8H4XRvYXHYkrzC/h
         FwXvZ67raoz553UEtT9SfIK+XUE5wIplSvxcWup8MSi736Lh68dLWQVU9Q8UkKRYPffV
         NJ5DqBbc52DPc4PW1PqFJyNe6LjJ8WneL/lZUJpwI+co47c0hSX0x2yHLhrCAH268WoX
         CC0XotRhUBN5KLxrRmz38I8xbXM7jGev3oo0w09Bwvp5uo0TCoM1zWQKpDaFxgZUKhs2
         gq9jWLHUwmZNvG6IEtrTINMqOZ+a69X6ig/qemUjLQidZoAxcBO1hxZugoBSqbLsymry
         NG5Q==
X-Gm-Message-State: AOAM533WuUqOx4jZR69WZM0I6/mNZLiSsZuVcxFbBkS7hqpVblzJZIZU
        c0LEfme/pioAy+xHxwR9o1kHzA==
X-Google-Smtp-Source: ABdhPJybozUZCzBjGCZrVC3Od5XlcjWEEO2s4bn2Mkl2bCN8MT+/licgjXfekypFGRBDooRjN3W4oA==
X-Received: by 2002:a5d:5551:: with SMTP id g17mr4450147wrw.45.1592487506047;
        Thu, 18 Jun 2020 06:38:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id o82sm3707956wmo.40.2020.06.18.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:38:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v4 2/2] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Thu, 18 Jun 2020 15:38:18 +0200
Message-Id: <20200618133818.15857-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200618133818.15857-1-narmstrong@baylibre.com>
References: <20200618133818.15857-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the Khadas MCU node with active FAN thermal nodes for all the
Khadas VIM3 variants.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Hi Kevin,

The bindings has been reviewed and merged by Lee,
could you apply this one via the amlogic tree ?

Thanks,
Neil

 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 1ef1e3672b96..27408c10a811 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -183,6 +183,23 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_active: cpu-active {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&cpu_active>;
+			cooling-device = <&khadas_mcu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
 		/* Realtek RTL8211F (0x001cc916) */
@@ -222,6 +239,12 @@
 	pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
 	pinctrl-names = "default";
 
+	khadas_mcu: system-controller@18 {
+		compatible = "khadas,mcu";
+		reg = <0x18>;
+		#cooling-cells = <2>;
+	};
+
 	gpio_expander: gpio-controller@20 {
 		compatible = "ti,tca6408";
 		reg = <0x20>;
-- 
2.22.0


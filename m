Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66652078BF
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 18:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405018AbgFXQPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 12:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405003AbgFXQPh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 12:15:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA4C061796
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 09:15:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j94so2890099wrj.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=HbBo8+WPRj3gAUYINsoDzCjuSTiw+4IVXg1BUTCPeS9//rIx0Msd7C2/3IOEqhT2au
         ifH40qsXdeHZFBuxYayakoHeI5GVZtrXYa4z/w6+0z4jER+c72ovBtthOxjKcI41NM67
         YXA/sWFk3I3nvVOvAOmNu0p9vJXZsy+n6tDOMAWADhcErgHqJsG6kn/gtiN8Efait3Vu
         g7U8caQMJnfPSx32TxlICATow4MuWMRnhUBnVT4P0Qt7NW+LmYXoK2t0ILvx+H877gGQ
         k9atIi2siVCtlFJt9Qsxt86a9HGAidyo95/yFVpj4YC7TNm3Lvqbki1DKAzL5+qtILlf
         3PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=XM6rA1CVqu/kctNMhChlx7OxoA5IOcE8DxUw7AzHtXRgJ7+UlCih3/C3dCgBPUi0x6
         e9sYmeEZMKJxZtUACBtYy/ItzbkmgqAy7/51fciq7NgdIk/c8jFNFptZuKbm+eMXE5ka
         jt0uGEjqls+7MHPsU+dhGWApsBc5elkTp9jog0LDsRuM/l8isWNbGw5JA0aG7sewDmdf
         UwoPn/5szTS737TPxIjzl4j/j9A8xAqKnu20Nuq8STvByIh8oLx8rKClMgwF637UgSnW
         CdTQpebv13IIP4xPLDSTROLae4oLUXa09TXT2Sui3LKaOBtNYWG6QvnjzSDB0RDL+QtU
         39kQ==
X-Gm-Message-State: AOAM532VntY0WkfDhlg2ZMhLTzjRy+hCYfD9HU2E5R0RH2AyotN8dxDy
        j4Y/dAaGai2NVR4wm9ucy6S5Hw==
X-Google-Smtp-Source: ABdhPJzU5QZYipbkQZi8xo157t2PrVSjzPMHytPFcg1TfZKTGu677lOERbPf8aPK6zEzeiz5pYn3xQ==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr5463690wrq.38.1593015335565;
        Wed, 24 Jun 2020 09:15:35 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:89ac:d9e8:f44c:b137])
        by smtp.gmail.com with ESMTPSA id t15sm8716207wmj.14.2020.06.24.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 09:15:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v5 2/2] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Wed, 24 Jun 2020 18:15:28 +0200
Message-Id: <20200624161528.12664-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200624161528.12664-1-narmstrong@baylibre.com>
References: <20200624161528.12664-1-narmstrong@baylibre.com>
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


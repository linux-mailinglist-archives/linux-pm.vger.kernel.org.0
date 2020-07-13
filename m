Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C8B21D025
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 08:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgGMG7g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 02:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgGMG7f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 02:59:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF0C08C5DB
        for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2020 23:59:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so14362491wrl.8
        for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2020 23:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=LOn2ya0S5OB7Y5uvhFHYl/XEYXEVgKVvfjwGLeRxcYVK8kubTPZZMct7qQYidJpeJo
         5RUTN+UHsk4k/Qyma5I22GYlfRjlugEU7XomNMheUP3bbRuVS3/7SVVRaLlvSvu9kIv0
         zNERj4P/Ai70ommBpNcyUDpRDqCTUpmukH7M8y7dkrOPktVxKlk2m9rIEQYdjNL4DXJf
         3dHT+wE8SFOp+bWdrs5z8K/msRqurH1sHrU/3qxb9ytCFJsAv3jeVQCpy/h6kbMLwWvc
         JUuFw3rEpW2tqWqGZlQUKhB2PfFXs+/fxA6PhzCBkW1019Sgorg6Uw2dk03Ajt6NceSh
         +oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=gJOdgrJwMllU0s5jaShWbjyS+wuP0TSwpZizU1yBkdwA11nfVAAEevT40wFWO4YLVj
         5YMuxGmKt/xOaEoZZVmpNQpFktMQKhvTJ2cI+SPoE6oiovd4DyTSJ9oN3r42Se3gZfk0
         F/lc8hvU50cgyr5Ravmwu3hsuxW+/QAATqszs3TW8TtIFu+jpDAOiEYOD3oqPIbbxmZ1
         D3t7I4D574PbSJr8c+oCIjI3fcBlJY1K6xUfqhuaihYJt9+1WZICaMsnfuMJ7EexQh62
         QQ3QdkDPnIUC/BgLV4HuOlZQV+jFxnRnOaxsUMxYSW/f8iUOJI8XqGeimJda5zoIJiF8
         u4cg==
X-Gm-Message-State: AOAM530KzYCRQ8yxvcBAU7KL8K1jnsxAB4r9BVFbb2sfKCwza8wSN0IG
        DuQmBQlyi5yTt1JIKOeT0mRFSA==
X-Google-Smtp-Source: ABdhPJyVPeQ7ShrahAXpJcoWO4VTZySPJoqio9Q2uZh9sFtU3rbW6xzIeLZOkXeBF0Flfj7vAttPig==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr76901144wrp.268.1594623573901;
        Sun, 12 Jul 2020 23:59:33 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 92sm24394143wrr.96.2020.07.12.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:59:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Mon, 13 Jul 2020 08:59:31 +0200
Message-Id: <20200713065931.19845-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFCEC0B8C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 20:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfI0SoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 14:44:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41503 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfI0SoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 14:44:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so4316439wrw.8
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uFRkuroOBs+uKwTPCimySu+UhJ9t5OAbbzvyFqNj3Aw=;
        b=MikSGlZe0uqOkaubiy1RQV05Ryu/fAimSnGuIod6zI/bkIxwYw871JO1JwE51iYQm+
         4uj9azF9xbXtpyJHchneV3CO3wKJhdY0T9rqVgqLqpeMXKIj/L//AjglSvJtOTd5vEL4
         JeAGn/m7kMiX5bLtvKI3izvMAcPnpQFpuwUZIJZnK7YRsxmwaQ5NMDxjXC2xuXlZNh8u
         hON3DP8hubHBv9LVkP07y1Zg5PE6j6IIGKm0nh/Skxb6DcL0YHKdpbG3GcF1pPNEhUBQ
         IOetegYVw+Oldn5XB6Y4Ve53PBYtSEpB7wU8CO8pmuGh/UZa+NKEh+fQ3t/1QSedFd7I
         dqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uFRkuroOBs+uKwTPCimySu+UhJ9t5OAbbzvyFqNj3Aw=;
        b=AbG+CIBKRYrXK6L9SsnFwIic2FiauT8lMD/fd5jcTEretcqp+KfWw/jH75e7SGnfiP
         QkLNTKp9QsKjMbBu2tGsj0iGXOSWCtXSwJFgOVOAUTlk9sggAc4iFpkx4CCzfzH49eHP
         IiKhMyWMai0MibpjBu0NiQqSD29pgQyunSO2pBHGpmAAXSgLHIFNBhcEQd394SXxkK4R
         zzrxdBFbnO2jfQmOz13JxLMD4OjQnMwUYknCl5x3DUWQhp09R9nbeGFu55J/Le2sjPsS
         qe57KALeNBZlfc70h5L0as5l0sMLR3zZnrY963SDeOaXWopJXstguv7WmQ/HUXzGQ0gT
         lcUg==
X-Gm-Message-State: APjAAAWxyEBbrPU4WypHvi29iU7UlG+9A1NAKw9/n6b9ExCiMSahDILv
        ZRXrhX72++438oagaWwNLXzqiA==
X-Google-Smtp-Source: APXvYqywejFLNmLubXQ+lIajg77P8IR0wPRSPIhJuiMQsC6g7ImkqPZHkFpB+MQ5Po1oPHBJeOnLsA==
X-Received: by 2002:adf:f081:: with SMTP id n1mr4402788wro.273.1569609838776;
        Fri, 27 Sep 2019 11:43:58 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id r13sm6246272wrn.0.2019.09.27.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:43:58 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 3/7] arm64: dts: amlogic: g12: add temperature sensor
Date:   Fri, 27 Sep 2019 20:43:48 +0200
Message-Id: <20190927184352.28759-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927184352.28759-1-glaroque@baylibre.com>
References: <20190927184352.28759-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 38d70ce1cfc7..0660d9ef6a86 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1353,6 +1353,26 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,g12a-cpu-thermal",
+					     "amlogic,g12a-thermal";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,g12a-ddr-thermal",
+					     "amlogic,g12a-thermal";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1


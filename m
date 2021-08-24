Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7288E3F5703
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 06:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhHXEKr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 00:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhHXEKr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 00:10:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C2C061575;
        Mon, 23 Aug 2021 21:10:03 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x10-20020a056830408a00b004f26cead745so42438162ott.10;
        Mon, 23 Aug 2021 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7nWRCZmwjD+iwvzS4vZhsQdwavMwcQaNBQdnSbFlKY=;
        b=QkSXk00iAQ+rdtYwrtSca9ZWFI2P69Ki3epJbMznO7bu1iwPljJNuWqwzz4XZLHUAa
         iSlRXcfWkO1cmUAjDNi2bcZs0tqFJ2XC+hM/Vzz1tAgYe7zYa0l8iqKbuhb2B3FMBwRm
         2jh/ui6StR7NLMMCwOa0nNYYWRGuctrE5jvQ53JG8RVoulaSdY3kNA8yvB/wSFlYAQmG
         AO8DRnutI+lJKmcN/8UltTPORy+dW0nxxolld4KOD6vGgNWW+70aLN4oI8YupUWDQsOk
         fVTDPSkbISjb1dlaBHLGypmae5VFO65SJ3M9iUlNDOKYlVxsT/gvEAkXbs9EWAIPTVtj
         1DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7nWRCZmwjD+iwvzS4vZhsQdwavMwcQaNBQdnSbFlKY=;
        b=nEjqk5yTSt7wPWEE9Mc6knpbPxIYuNcOYfmbVx3smna+LBG/B30ip64LDfLBGW9wLd
         9jBThMmeslHxL/dUTVzYBj6P3i9g5XuI87kzNok1X4sx0rmCZQEucQE4SGiLkkGe5pdm
         EyNt7u6fc3T3b29444q7xWBcBoCjGltxk5SgiE7BjDWTh2IemOaMZ3+OKh7NkGa7A1jR
         QbsPxa9G316gLPIR3PATJBFx21aRkOCkhI8Q/Hla1t75oSeYotYP3nzeIk067JnvxmgB
         2lSxfrhwED/MntGPy9XJln8iYYcqZFosiAHYVZieQQxeNY5PN5ESTRm0uuJA7xosmp+k
         S4CA==
X-Gm-Message-State: AOAM532Gm1x5DGdx3jvKtCQOu0EShVlCcxg/YJ56Cb69qOHCZfmv4i9e
        NlC0Qv8Il2VDAsK0dRlylow=
X-Google-Smtp-Source: ABdhPJwppY/hN/1drm4+0yxjVGu43UiUESmp2KIy2e+6sDvIvnE9q0jlBfMR7q7N1fTG+mQMMx8wXA==
X-Received: by 2002:a9d:331:: with SMTP id 46mr30954791otv.359.1629778203301;
        Mon, 23 Aug 2021 21:10:03 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id i19sm3922818ooe.44.2021.08.23.21.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 21:10:02 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lee.jones@linaro.org, robh+dt@kernel.org, heiko@sntech.de,
        sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 1/4] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Mon, 23 Aug 2021 23:09:52 -0500
Message-Id: <20210824040955.29112-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824040955.29112-1-macroalpha82@gmail.com>
References: <20210824040955.29112-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Create dt-binding documentation to document rk817 battery and charger
usage. New device-tree properties have been added.

- rockchip,resistor-sense-micro-ohms: The value in microohms of the
                                      sample resistor.
- rockchip,sleep-enter-current-microamp: The value in microamps of the
                                         sleep enter current.
- rockchip,sleep-filter-current: The value in microamps of the sleep
                                 filter current.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../devicetree/bindings/mfd/rk808.txt         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 23a17a6663ec..6e1b9fb1f64a 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -77,6 +77,37 @@ Optional RK817 properties:
 - rockchip,mic-in-differential: Telling if the microphone uses differential
 				mode. Should be under the codec child node.
 
+- battery:	The child node for the charger to hold additional properties.
+		If a battery is not in use, this node can be omitted. If a
+		battery node is used, the following values are required in the
+		battery node itself:
+		rockchip,resistor-sense-micro-ohms,
+		rockchip,sleep-enter-current-microamp,
+		rockchip,sleep-filter-current-microamp,
+		Additionally, a phandle to a monitored-battery node that
+		contains the following is also required:
+		charge-full-design-microamp-hours,
+		charge-term-current-microamp,
+		constant-charge-current-max-microamp,
+		constant-charge-voltage-max-microvolt,
+		voltage-max-design-microvolt,
+		voltage-min-design-microvolt,
+		and a valid ocv-capacity table.
+- rockchip,resistor-sense-micro-ohms: Value in microohms of the battery sense
+				      resistor. The PMIC only supports values
+				      of either 10000 or 20000. This value is
+				      used by the driver to set the correct
+				      divisor value to translate ADC readings
+				      into the proper units of measure.
+- rockchip,sleep-enter-current-microamp: Value in microamps of the sleep enter
+					 current for the charger. Value is used
+					 by the driver to calibrate the relax
+					 threshold.
+- rockchip,sleep-filter-current-microamp: Value in microamps of the sleep
+					  filter current for the charger.
+					  Value is used by the driver to derive
+					  the sleep sample current.
+
 Optional RK818 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -459,6 +490,13 @@ Example:
 			};
 		};
 
+		rk817_battery: battery {
+			monitored-battery = <&battery_cell>;
+			rockchip,resistor-sense-micro-ohms = <10000>;
+			rockchip,sleep-enter-current-microamp = <300000>;
+			rockchip,sleep-filter-current-microamp = <100000>;
+		};
+
 		rk817_codec: codec {
 			rockchip,mic-in-differential;
 		};
-- 
2.25.1


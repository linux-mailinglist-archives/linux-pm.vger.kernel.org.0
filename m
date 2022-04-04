Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDA4F1F3D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Apr 2022 00:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiDDWrU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 18:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345469AbiDDWq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 18:46:57 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5327E3AA71;
        Mon,  4 Apr 2022 14:58:10 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 12so11469995oix.12;
        Mon, 04 Apr 2022 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8/ao70Lm7W7LQJ7XYuDco3ISGwUQ9Ikm03scRmzvCk=;
        b=QzKxHUfbXFnJ0u75nM7iGWvmbp24E+K30nc4qIlK7BpuWtE13E9O9btBlxzPyKx5eB
         xZi8uK0oi3i1UAYpZF/oo//B/iNz5bl6mXsptokTZi4+W5boVL0BRiVGU2ak6EXmZpq+
         9mt7mUiSqZ4c69pUFmupJhsOZOlHeiSUV7LMe2Ean3773YnrgBpIOkboKUY9eExJIlt5
         4WzehvMs20sJDpKGe8SyGCPHT/NV6XM2nMxFNC2Kom2TlRozTJTVDuy92eFmVuStCAld
         i19WsGv1f70cUeT383GkTOGfaH3IQ8T0lEDSkJ6zn1S0KgRX4j/EDlDoujopjUI5fJOp
         O+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8/ao70Lm7W7LQJ7XYuDco3ISGwUQ9Ikm03scRmzvCk=;
        b=O6DzXbHtWZchll1w3Lm0S1Rc6zwNK0qQ9HqOaedyT6XdRRd2v2JyucFmtvIuu4Iyy1
         giMupJqO5g3UGc/UZxVZvoynwbnu2p3wpsux0pk/AP3Y0Bpk0qfjEX0Hfi5kOcvAV90G
         VzDd56VcBOaGcPtToV7UZ5w92nRiCKJvSh0BuD/qPxvLhF9onXA7Zta+kDMNVvwHKqgd
         1r+LzO8vhu+NaQAODrwzZkymXsaYPyd+vOiSloissygiYcvOE70pbomxmxjN4HpRrry1
         Y3ZOddGcsvKyQ95654OyaWFNOMjl7moSdF/KyJyy6f3RgA8g3N8RAMOlv8fo7u/5BQj2
         vvmw==
X-Gm-Message-State: AOAM5335vih4E5Qww4lQLh1OmsCX00PyL6jlQlKkmxWOeLOjQHR17zCS
        iJEnYLy+tGMJcgSsJgVnL3ug39rFWTg=
X-Google-Smtp-Source: ABdhPJxanMGtgrGVKdFhPJHAnQqqAFkMAGoD8rY/iWqoDaLegSP2H0jSXeIxrTGPvXEcKMpGtDZx3A==
X-Received: by 2002:a05:6808:1b28:b0:2da:51e0:d10a with SMTP id bx40-20020a0568081b2800b002da51e0d10amr173327oib.186.1649109489428;
        Mon, 04 Apr 2022 14:58:09 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r3-20020aca4403000000b002ecf4d70c83sm4646402oia.27.2022.04.04.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:58:08 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzk+dt@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 4/4 v5] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
Date:   Mon,  4 Apr 2022 16:57:54 -0500
Message-Id: <20220404215754.30126-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404215754.30126-1-macroalpha82@gmail.com>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add the new rk817 charger driver to the Odroid Go Advance. Create a
monitored battery node as well for the charger to use. All values
from monitored battery are gathered from the BSP kernel for the
Odroid Go Advance provided by HardKernel.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index ea0695b51ecd..4ccdb6dffa88 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -52,6 +52,25 @@ backlight: backlight {
 		pwms = <&pwm1 0 25000 0>;
 	};
 
+	battery_cell: battery-cell {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3000000>;
+		charge-term-current-microamp = <300000>;
+		constant-charge-current-max-microamp = <2000000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <180000>;
+		voltage-max-design-microvolt = <4100000>;
+		voltage-min-design-microvolt = <3500000>;
+
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 =	<4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
+					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
+					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
+					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
+					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
+					<3574170 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -472,6 +491,13 @@ usb_midu: BOOST {
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


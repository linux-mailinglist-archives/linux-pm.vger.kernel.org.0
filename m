Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7651F3D2C8B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 21:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhGVSeL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhGVSeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jul 2021 14:34:09 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB812C061575
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 12:14:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so6265479otu.12
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+oR6jnz6zJn9wlv4NnQHPf10GKECSgTuicsJlMVTSs=;
        b=VsmrZMkAU5l9/HJfKqzIIT4h9n1WOczI9OjnSQdAy2S9imnZyDS+RKZdSw1rCVzAPB
         /eCM8DmtqSmriBcicEkHqDRyRFrdHM24EqvG1FC8G92ZOrOluNa99S16DbfRruEnOJIY
         Re76Ln3CgfyKspCidfhTZBfa0UprN0c3EZvKgE1FPX/6sMsfcGW40qT0brlwKD3Oo314
         YGSX6CDXKFUQrH/d0pkiry/kpRm9nJPvDZdXepFWXyFEHV1Nthx2aO/U2jjkOA6+c/eD
         TPsQUTMrVN78Y2mwVhhj/6BpS61tTBf31eHrs05l4JALg9W7BwHzaqTt4ZlEW6YFybYu
         IKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+oR6jnz6zJn9wlv4NnQHPf10GKECSgTuicsJlMVTSs=;
        b=MJCYA7DCL+snllU+O2vwx/bQRGlW3K+kbYjgwrJIs9TAZEJ0n9avGsl6i5eGc54kLm
         qu83bY/XLKKlyFgOX8ZByW4WQyhcl68Xr35lcvYLSFV7OadT1NWjQVkb6SQ3wFTEWJ6V
         s6jJS7ys5EUhc/Ir99o5zX+gFvRYSqc1xICF80G46qzKlNEwCbZmZK1AVNhpMNXKGv06
         6Rc6ETJvOMgLpCN/FkHKbwfeI6pdkHWOjEkbzyxrD2lU/JKamxLdEKdaRK0Vcfqp4BG3
         dbQbG6bhEGwPzFZ7Caj1e/Q10UwRj+JtLuqWUxtEVSA8TDAUd25OxGIyExzWXBEIm93l
         AN2g==
X-Gm-Message-State: AOAM532TG1YXhjowcbMxyxsWRHEL3zUCoB47jYP2edml/jZ7x5P5foYu
        3pQ/C6ZY1BVxwZWIOvJ/qME=
X-Google-Smtp-Source: ABdhPJwcM8nmEZbO6iWa5H/3D5ddw+glMuUYtSKPzc4KvWY82aGNIIZ3WLZIH/PSG3oLTjKvE2JAeg==
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr880898ote.13.1626981283191;
        Thu, 22 Jul 2021 12:14:43 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r26sm3106167ooh.32.2021.07.22.12.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 12:14:42 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC 4/4] arm64: dts: rockchip: add rk817 charger to Odroid Go Advance
Date:   Thu, 22 Jul 2021 14:14:30 -0500
Message-Id: <20210722191430.28203-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722191430.28203-1-macroalpha82@gmail.com>
References: <20210722191430.28203-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add the new rk817 charger driver to the Odroid Go Advance. Create a
monitored battery node as well for the charger to use. All values
from monitored battery are gathered from the BSP kernel for the
Odroid Go Advance provided by HardKernel.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 7fc674a99a6c..47bff3f2bd14 100644
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
+		ocv-capacity-table-0 =	<4106000 100>, <4071000 95>, <4018000 90>, <3975000 85>,
+					<3946000 80>, <3908000 75>, <3877000 70>, <3853000 65>,
+					<3834000 60>, <3816000 55>, <3802000 50>, <3788000 45>,
+					<3774000 40>, <3760000 35>, <3748000 30>, <3735000 25>,
+					<3718000 20>, <3697000 15>, <3685000 10>, <3625000 5>,
+					<3500000 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -462,6 +481,13 @@ regulator-state-mem {
 			};
 		};
 
+		rk817_battery: battery {
+			monitored-battery = <&battery_cell>;
+			rockchip,resistor-sense = <10000>;
+			rockchip,sleep-enter-current = <300000>;
+			rockchip,sleep-filter-current = <100000>;
+		};
+
 		rk817_codec: codec {
 			rockchip,mic-in-differential;
 		};
-- 
2.25.1


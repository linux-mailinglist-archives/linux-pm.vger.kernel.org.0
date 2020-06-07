Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04AD1F0C0D
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgFGOpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgFGOp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1543FC08C5C3;
        Sun,  7 Jun 2020 07:45:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a9so13751195ljn.6;
        Sun, 07 Jun 2020 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfL/r1htdP9PiIBaZcQxVZ6voLKiwdEQ8IbCOeWza6A=;
        b=F2mKAwuzjxAgedp/+YsmHWSd/69jzNNmCqJbuVTXk5OZFvOBQ2uxLjW/SdgzELRfaH
         8onq9IUyf6hOkjsCWURnrDfC/ltXl8Qv3iwoa98AN3eSueCbgWOGhmA4X4p0tN478dXX
         U+m8CwOZmLhPmjzwqA17KZn+h1whAaB+5zOYIV4UM7y9zLbbf45naMpbpIEkq5KD10xQ
         0TcMRj88h/2OFul3mbMqqcRXrBR17F7YnqUGg17E79Q+y3rEjcP5vFyQPqvvwPFSVun/
         3o1oexIGGbz0YElqBWWLvov52XuwsRFuEvKToCOAgSyufte5awTv2jkVTW19oUc9UMCQ
         J0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfL/r1htdP9PiIBaZcQxVZ6voLKiwdEQ8IbCOeWza6A=;
        b=b4EAnJgnYuta7t/Lfz6303qPuQX/orkfYHBNLa4OfOE770zQJHh5img4+TGENTARIQ
         TnymuUmSvpdetfv8itFk+YWhD7KDHWLV/8qq5mPeWhAYdI9MRcl3+MZB548SN4WclcE2
         /9xaKY85g4JnFLpNTzuGExxdWuUh/d8MAXaVx4chaqWWckrSfFn7BcoCQb4nj4AMXcsJ
         5cxx53ejD8WdntN0k+f0QIOsuRxQQVnatzfpdZolZuhe1fhIBEJihIB4Werpy4F10vQL
         jEKyiDKl6mG8QsoxNepWjSNNNR1dwDQ/QE/BfDJ+r8p6ZNrADHDQfUJMk7LrLGcaxjNF
         80qw==
X-Gm-Message-State: AOAM5322i3uXs6GYOnwPfKxXr55ND7oQq80JOWHZ+vs4w4cI6NQzC715
        zTDNZBsW9+1yAXsxpvUIKzE=
X-Google-Smtp-Source: ABdhPJw2hnkRZpEz3xvP42UA6MOStGsDyxqyIF/rxMxPa659kz9A/8+dqsknHvl1DT4uiVe2y6zzeA==
X-Received: by 2002:a05:651c:233:: with SMTP id z19mr9481431ljn.428.1591541126619;
        Sun, 07 Jun 2020 07:45:26 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 9/9] ARM: dts: qcom: apq8064-nexus7: Add SMB345 charger node
Date:   Sun,  7 Jun 2020 17:41:13 +0300
Message-Id: <20200607144113.10202-10-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Add SMB345 charger node to Nexus 7 2013 DTS.
Proper charger configuration prevents battery from overcharging.

Original author: Vinay Simha BN <simhavcs@gmail.com>

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index a701d4bac320..7a7784206dd8 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -3,6 +3,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/power/summit,smb347-charger.h>
 / {
 	model = "Asus Nexus7(flo)";
 	compatible = "asus,nexus7-flo", "qcom,apq8064";
@@ -56,6 +57,11 @@ volume_down {
 		};
 	};
 
+	battery_cell: battery-cell {
+		compatible = "simple-battery";
+		constant-charge-current-max-microamp = <1800000>;
+	};
+
 	soc {
 		rpm@108000 {
 			regulators {
@@ -296,8 +302,25 @@ eeprom@52 {
 				bq27541@55 {
 					compatible = "ti,bq27541";
 					reg = <0x55>;
+					power-supplies = <&power_supply>;
+					monitored-battery = <&battery_cell>;
 				};
 
+				power_supply: charger@6a {
+					compatible = "summit,smb345";
+					reg = <0x6a>;
+
+					interrupt-parent = <&tlmm_pinmux>;
+					interrupts = <23 IRQ_TYPE_EDGE_BOTH>;
+
+					summit,chip-temperature-threshold-celsius = <110>;
+					summit,usb-current-limit-microamp = <500000>;
+					summit,enable-charge-control = <SMB3XX_CHG_ENABLE_SW>;
+					summit,enable-usb-charging;
+					summit,enable-otg-charging;
+
+					monitored-battery = <&battery_cell>;
+				};
 			};
 		};
 
-- 
2.26.0


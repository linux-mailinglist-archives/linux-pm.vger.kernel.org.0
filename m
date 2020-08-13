Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B9D24409E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgHMVfI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgHMVeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31599C061757;
        Thu, 13 Aug 2020 14:34:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m15so3794365lfp.7;
        Thu, 13 Aug 2020 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YV+mrC5kiC7QQYV/FBFX4qMy1dVded4Mn/XHB6H0W0I=;
        b=VoBDyM+tte4MJ8a9yQorB2SaOnVDp2m49O31ggdeuUOxgsZx/NdLhq0Lqoaza/aDu2
         wG8TmQIstDiqk4lLJajdCpj/ybwYDk3jrTLNqAHricGuQR0o/oByfcj9Yd41TH/oSmap
         +oxIDH2XqJptS6rFqsY+gUp8ePI5Q2uZg6sjDTbgGYxN9fkBU1XaFHdjLGeShR6F3pn+
         fTDl2QL2bkosXZrtZMUpaByw39DtX7+wv4AwWdxVfssNHPUiq9+hvFd++KOFL8xFkS1a
         1zv7MOcU4SBPk7RdhyN1k0e+7k2OwVXzKppK9kH6YOYUSjk9fXfNLuUzQ08QIP4G0DbH
         BLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YV+mrC5kiC7QQYV/FBFX4qMy1dVded4Mn/XHB6H0W0I=;
        b=mex+ij+MbQJA7twT+a/OYgVEkKOWiNiAYMNysEiMFc62PMrPtDYqXAl+7I1j8ql7LM
         OeLjOaBF1CuuAzIdl9uvlEYTiKMY7ZCakMZbh+9s/xTXu/GouM5+9jyX34C69ZQ2I06Y
         lkq/4axaYdQKYb7wFhiezgdKGw/bgk0+0GxgpJssDiFfczy+PDwgzhnA3zvKek0zGn5P
         FNcNziSl1c16wJ1vMWMDsw+6HUhu/komppWVB7zhOC2AXTFJsBmuLwYvwxBk3a2bWtOv
         vtWLkNX2zwzu54yrw/jmuGBUFa3jg3anmeG8m66jX8VAn7O3Z+af349YoXUFGgdlix7M
         /kHA==
X-Gm-Message-State: AOAM532NmcbQgbxhiQbpObTgAT8oaFb2nxoJSxTRCs2g39OkloOm49sy
        lDeYuNzGzjOjqXD2M0LLWJQ7jacm
X-Google-Smtp-Source: ABdhPJwXiz7uILUNUhDvRcL8o6/prwxG95Ifu0ZfXuChgZ6XNpf2ZV/Dw7EJODy4vNJYOdKNnPjysg==
X-Received: by 2002:a19:8452:: with SMTP id g79mr3227883lfd.29.1597354482652;
        Thu, 13 Aug 2020 14:34:42 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 10/10] ARM: tegra: nexus7: Add SMB347 battery charger
Date:   Fri, 14 Aug 2020 00:34:09 +0300
Message-Id: <20200813213409.24222-11-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

SMB347 is a battery charger controller which is found on the Nexus 7
device.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index e2d5fbacf9b4..903457292c04 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/power/summit,smb347-charger.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "tegra30.dtsi"
@@ -919,9 +920,24 @@ nct72: temperature-sensor@4c {
 			#thermal-sensor-cells = <1>;
 		};
 
-		battery@55 {
+		fuel-gauge@55 {
 			compatible = "ti,bq27541";
 			reg = <0x55>;
+			power-supplies = <&power_supply>;
+			monitored-battery = <&battery_cell>;
+		};
+
+		power_supply: charger@6a {
+			compatible = "summit,smb347";
+			reg = <0x6a>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(V, 1) IRQ_TYPE_EDGE_BOTH>;
+
+			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW>;
+			summit,enable-usb-charging;
+
+			monitored-battery = <&battery_cell>;
 		};
 	};
 
@@ -1011,6 +1027,12 @@ backlight: backlight {
 		default-brightness-level = <15>;
 	};
 
+	battery_cell: battery-cell {
+		compatible = "simple-battery";
+		constant-charge-current-max-microamp = <1800000>;
+		operating-range-celsius = <0 45>;
+	};
+
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
 	clk32k_in: clock@0 {
 		compatible = "fixed-clock";
-- 
2.27.0


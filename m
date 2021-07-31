Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188923DC771
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhGaRjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhGaRjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF3C0617BB;
        Sat, 31 Jul 2021 10:39:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a26so24867598lfr.11;
        Sat, 31 Jul 2021 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhtGFKsHUzTaL2MCRyNEETLxWQghXk5mgR3qIkfiMRo=;
        b=BQ1Xo+YEenzUxSlT7HYMI1/JJk7DUDRAGZKAfNoxlcPDXNzunb1sOoGUtUR4zItLma
         JPtvQx6eHUfft2OKIfKvsS906ssfUXiwbPDp9smEo8ZcHpgxGkpZpNjhnJ4rIiJ/UoYC
         xUaEOMiJiHeQIbx8bAbIEROHYLG9cTCoz5V4PQloeqE8O5kyUgaHhEa/mcEc3Fk17Uuv
         B9qnCuTbgdQ9j2hwjTyteNz79kKRNMSSdXILdGtdBaw0umaCBTfZyx6zSsxdkgtYLDho
         x6sdhishOIO+/VSROsQIF+waiJIyPJo6OPV6g31NdolNeS4ssnUGX7ix4l2qW2gTWMb0
         5XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhtGFKsHUzTaL2MCRyNEETLxWQghXk5mgR3qIkfiMRo=;
        b=JzEPBWrQGZiL/9g+UND1IWYGnXky1ASZzgIQakZ3Hkq/mU/+fYwA4BGmTTQ3XqZ97q
         PQ4PfcF7UTfE9Q63Ga4dmf7p6us/JD6Sl0WEUAstvdLT8o/ONYciJoRpyhW+/9KkDJ0I
         HuRyE6qwssiNKZy2DxnO7BDCDK54xKzjyAFpCoax2IMmk7kR8eCMxwwgRiCMtq7OPtw+
         QXWnyZpf7JX35hzU0rH3w4u9a2HdmEjur9mTOcz505IJ8F2WUEFoa+ZV3SV3b/I29wZI
         dBeCyP7wCbNjbW0M73b1vLFgaL5J/F1J1LTgZ3R5z1UscNLTx7J7GYzkH7ao5kLc9/o6
         b4Cw==
X-Gm-Message-State: AOAM531n2RbE1loz+ak4rH59POMkt06X/3TTuVx9RzArCsRYnCNjsEFA
        GWzrBGsHO5XvVucGB9xTKMs=
X-Google-Smtp-Source: ABdhPJwAx5eYxiCqeFHRGrR0LK4cP6KzryqO4i7f1g0cyHGb1mCAXyQot/6AH6pbaP/GTalKa0Y4ag==
X-Received: by 2002:a05:6512:1104:: with SMTP id l4mr6129648lfg.375.1627753145430;
        Sat, 31 Jul 2021 10:39:05 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:39:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 11/12] ARM: tegra: nexus7: Enable USB OTG mode
Date:   Sat, 31 Jul 2021 20:38:41 +0300
Message-Id: <20210731173842.19643-12-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Nexus 7 has OTG-cable microUSB port, enable OTG mode. USB peripheral
devices now can be connected to Nexus 7 using OTG adapter, switching
USB port into host mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index 4f116c26f6ce..798ac22a50d2 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -941,9 +941,29 @@ power_supply: charger@6a {
 			interrupts = <TEGRA_GPIO(V, 1) IRQ_TYPE_EDGE_BOTH>;
 
 			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW>;
+			summit,inok-polarity = <SMB3XX_SYSOK_INOK_ACTIVE_LOW>;
 			summit,enable-usb-charging;
 
 			monitored-battery = <&battery_cell>;
+
+			usb_vbus: usb-vbus {
+				regulator-name = "usb_vbus";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microamp = <750000>;
+				regulator-max-microamp = <750000>;
+
+				/*
+				 * SMB347 INOK input pin is connected to PMIC's
+				 * ACOK output, which is fixed to ACTIVE_LOW as
+				 * long as battery voltage is in a good range.
+				 *
+				 * Active INOK disables SMB347 output, so polarity
+				 * needs to be toggled when we want to get the
+				 * output.
+				 */
+				summit,needs-inok-toggle;
+			};
 		};
 	};
 
@@ -1017,12 +1037,13 @@ sdmmc4: mmc@78000600 {
 	usb@7d000000 {
 		compatible = "nvidia,tegra30-udc";
 		status = "okay";
-		dr_mode = "peripheral";
+		dr_mode = "otg";
+		vbus-supply = <&usb_vbus>;
 	};
 
 	usb-phy@7d000000 {
 		status = "okay";
-		dr_mode = "peripheral";
+		dr_mode = "otg";
 		nvidia,hssync-start-delay = <0>;
 		nvidia,xcvr-lsfslew = <2>;
 		nvidia,xcvr-lsrslew = <2>;
-- 
2.32.0


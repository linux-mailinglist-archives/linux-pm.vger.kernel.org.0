Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208343D6722
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhGZSVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhGZSVQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 14:21:16 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B0C061757
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 12:01:44 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id k7-20020a4abd870000b029025e4d9b0a3dso2485524oop.6
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjQq4w89JxvSdKOOfsY9AtY7TN3aPy/MaODSkX355Ug=;
        b=UngmKHBwhsMSd1k9L9YcJfhTednReksxg+DgmLwELsHoLdvANjLKLnqOZBAps7s0zM
         M2xWlEArxsY96VjtLd4xp6SoyFgQugQHPoS+tSwTJulBqIExEh37mA67XCaD1PaKeaeg
         XWahPoH1ncKsKj4DTG+ehgiTxpkbdot+ouqHv7E7wnA6F67kb9Ds0/oOstNV8hXlAb0d
         R66o6f/WN0jHxp548aBmhb2YrqEy0nG2w5JVazpjjCWOf7269N4e6T7L+YA8FQI/l95P
         yReocm9HWLPIQEqs36yHcYYRBYwNU11qOfn5DlRhh4kIa2PpgVV7z23WOQVMrQuA3cm+
         Dlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjQq4w89JxvSdKOOfsY9AtY7TN3aPy/MaODSkX355Ug=;
        b=deCGIRtGgGtqEGRd87Tu5VwDkApeCD7jnhoKrUyhToPKvg/WbJBv1Apnz50ByEtsiK
         YZwje2NDFeQIhMguv+2lXVqKyFGBa+ZYE9C4mRvFEdVdVWSqPzvFlEfM2alimMUIfE3P
         raQ2lMvfDuUtGxnpnoCrReoRCERTI2nyFY+jDQ2VHfuQyW1K2dSbmsaJmB/900aiXLd9
         KSlWyrgV5PquUabyL7TPkRPrRsx8gitUD7zL8KOQF/szmwN2VU0JjH45I6Z5f42hEX16
         EP/bWBFT2HFoXoN8fCqOHNNqCBQCLEVFQbEbvcj6dh6cPkxBd6evqC5Jv0sbac1GxY1y
         AP4w==
X-Gm-Message-State: AOAM531ELA+cEBEihYnlnfcrUTyt14+V7Ok8pnwPbKgBLqjWhUvQphq6
        rE9D3adDVQ5Bu5GcWxgAFETH+3aFZUs=
X-Google-Smtp-Source: ABdhPJyvXA3k5XqWanLGCHj51hHNxgycx5xHgCxTPsmupY+HaT+lZvA91oxoWDYFgZ3xtt9XUCyY5g==
X-Received: by 2002:a4a:e5c8:: with SMTP id r8mr11420915oov.65.1627326103607;
        Mon, 26 Jul 2021 12:01:43 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id v7sm106610ooj.46.2021.07.26.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:01:43 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, maccraft123mc@gmail.com,
        sre@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v2 1/4] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Mon, 26 Jul 2021 14:01:27 -0500
Message-Id: <20210726190130.1973-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726190130.1973-1-macroalpha82@gmail.com>
References: <20210726190130.1973-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Create dt-binding documentation to document rk817 battery and charger
usage. New device-tree properties have been added.

- rockchip,resistor-sense: The value in microohms of the sample
                           resistor.
- rockchip,sleep-enter-current: The value in microamps of the sleep
                                enter current.
- rockchip,sleep-filter-current: The value in microamps of the sleep
                                 filter current.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../devicetree/bindings/mfd/rk808.txt         | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 23a17a6663ec..fa42b6253d26 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -70,13 +70,37 @@ Optional RK817 properties:
 
 - vcc8-supply:  The input supply for BOOST
 - vcc9-supply:  The input supply for OTG_SWITCH
+
 - codec:	The child node for the codec to hold additional properties.
 		If no additional properties are required for the codec, this
 		node can be omitted.
-
-- rockchip,mic-in-differential: Telling if the microphone uses differential
+- rockchip,mic-in-differential:	Telling if the microphone uses differential
 				mode. Should be under the codec child node.
 
+- battery:	The child node for the charger to hold additional properties.
+		If a battery is not in use, this node can be omitted. If a
+		battery node is used, the following values are required:
+		rockchip,resistor-sense, rockchip,sleep-enter-current,
+		rockchip,sleep-filter-current, and a phandle to a
+		monitored-battery node that contains a valid value for
+		charge-full-design-microamp-hours,
+		charge-term-current-microamp,
+		constant-charge-current-max-microamp,
+		constant-charge-voltage-max-microvolt,
+		voltage-max-design-microvolt, voltage-min-design-microvolt,
+		and a valid ocv-capacity table.
+- rockchip,resistor-sense: Value in microohms of the battery sense resistor.
+			   The PMIC only supports values of either 10000 or
+			   20000. This value is used by the driver to set
+			   the correct divisor value to translate ADC readings
+			   into the proper units of measure.
+- rockchip,sleep-enter-current: Value in microamps of the sleep enter current
+				for the charger. Value is used by the driver
+				to calibrate the relax threshold.
+- rockchip,sleep-filter-current: Value in microamps of the sleep filter current
+				 for the charger. Value is used by the driver
+				 to derive the sleep sample current.
+
 Optional RK818 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -459,6 +483,13 @@ Example:
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


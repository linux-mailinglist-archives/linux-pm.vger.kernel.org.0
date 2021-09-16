Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0B40EAF4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhIPTng (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhIPTnf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 15:43:35 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A0BC061574;
        Thu, 16 Sep 2021 12:42:15 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n27so10675516oij.0;
        Thu, 16 Sep 2021 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7nWRCZmwjD+iwvzS4vZhsQdwavMwcQaNBQdnSbFlKY=;
        b=aq65laZEGaBneTeUAWeK0cRoJPs0aDXNFaqH9ALmB2M8PE0PG1LXTkb6YJ1Or6F9v6
         Zk8bWregqLPA9FTfO8PCbzy70/MnjEK8Y+Fn5qfqOfLzooP3l6NXDlHGSN+gy9vAQkEE
         X2LVnBIYv+FQ6VulRW/swQUSPLtn3e9u3CEoPfxD5xyoQOWjD2OgtpeJ6lxZT1HaTKXY
         sAvtyO/TgGjgxujfgVXSXexcWvxDZ4FK8F33W3FLxGfCtJx4b/s7YACqApptgjlx+Wxg
         V0epJG695HpLElIkfH0EhIEj1yJXqaSQ3LtZgDZkUhi+fIDFeLggAP0iC9/r5rnX+b4E
         pBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7nWRCZmwjD+iwvzS4vZhsQdwavMwcQaNBQdnSbFlKY=;
        b=vno1ii1fIsPgSfSi5LrtiiYCh/Ypbv7C0A4vn0j3Xug5yb0bwkNAs9gHWwNfyP91NY
         j6r7pnMRhCg8O1ciqC3p6CGO8SOwvVLUXGTkp7QRZ9ohkKyS1EmdNRr05ODSSJX1d/Is
         4JalHsG+VG+E2pL5bpuPq5vLsDJKSmK149jVpstEzZ/uKrX1oOM+c9mQ1vdS2xKa81NX
         fZmx3HJjfAnHJIjvkCanWoT3gHEKGYCO6WOKEHbrBMlgy1sGRv3ByofCNCWjTJvRh5Ke
         UVTqFPGngN1tOQ3NwbHO9izLu52yUQaRwX/UgwRjLgILZ92drmN+eMfA6VOamiFzVDGl
         fkNA==
X-Gm-Message-State: AOAM533rsP/ZTgh4ZLQRlesgXCzsfTt2393B0LQIAAFJTdzjF+RG7Em9
        7Z+UjRibrtCetvolo+6IFhU=
X-Google-Smtp-Source: ABdhPJwm5s/uqFNpTdZIvJyXMFkPPjyG0uo/lKViHNAMfiQiuNeY79omrgLK6DLyUtu1D7Dn6/2glQ==
X-Received: by 2002:a05:6808:8e3:: with SMTP id d3mr1194590oic.92.1631821334367;
        Thu, 16 Sep 2021 12:42:14 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id c10sm963359ooi.11.2021.09.16.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:42:13 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, heiko@sntech.de,
        sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 RESEND 1/4] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Thu, 16 Sep 2021 14:42:05 -0500
Message-Id: <20210916194208.10387-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916194208.10387-1-macroalpha82@gmail.com>
References: <20210916194208.10387-1-macroalpha82@gmail.com>
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


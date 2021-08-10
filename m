Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3FA3E512F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 04:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhHJCzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 22:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhHJCzN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 22:55:13 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA5BC0613D3;
        Mon,  9 Aug 2021 19:54:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so16047329otl.9;
        Mon, 09 Aug 2021 19:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXpc99n4MUgAooECetaziYMLNx4QWnC4XCxkO2+s1cU=;
        b=JE+3dodsleEaqADGGlbjnZthv7gZfg+EBun52/Qc1VojEGuv0XrF0qqNTJCSlg6oV9
         uxZA/YJPO+XBxymoZLVltefPd99EQfDV+XZAAxYh8tqd7yXt00nV5CwP1eTWmXGHBoxf
         KDyJAFGG5hk5/y+CGC2eIp2VEt1E9NO6gSxI+cODaWusb0gD9KYj5o4mDvtlHI04WoSd
         1KlfyBEvb/Cvke+gX1aIIsn8BAzdQZHhyk8guIbjdIfKk33JD5OywmPA2OyQCrsIo5qN
         Pps4IKzO56bK8YuIMOWNXtrvS7TutnhOhnTOb5xIO9DRDcFvLj7UYqgYIcJ+gfM6jqkq
         9YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXpc99n4MUgAooECetaziYMLNx4QWnC4XCxkO2+s1cU=;
        b=ombxO6k1FTIX6UBcQPmhlGJsRufcaj2Jf9F/8apw6EWgI8x7AZCZMP2wEk9sRlmo7n
         zU47wHtXoBG65+KosXJb+IPU+dNR35AuaVD+tqZ09mQil7FVbruPraL4aL0AgFZbM4M4
         INCMztcC68yi9Zz5hQ+kIKyMfN0YWc6up2uFtgeHOT+5uV9iXrrWYElAgtc7CyprOSFm
         p+vbQdULf2P2Bo7T7vk0/HwaCDVANvDZa4frEwKD89faXsUksXin3kSMNwPJVy+noUTN
         h8rc2QgQ4IQo1n8O8yBKMlL1ongYYY3KI2R3vCi3TBP2aqXTOdf/wj2lzEOii17i/laM
         nykQ==
X-Gm-Message-State: AOAM530Si4l1/2ZUOKRhkJK8Xw2HODOiW+CkJog/fn/8sZwIdl23ls5R
        /j0JYatV5TKIQp/UBOVaeyYTQR2NAZE=
X-Google-Smtp-Source: ABdhPJw8yhd/QMz8mC1JOUkbfGSmv8jJhlEP0HqaeySBW/7k27lvYpjSdJzO9dRbcxg8tNgoVTkhLw==
X-Received: by 2002:a05:6830:43ac:: with SMTP id s44mr19084601otv.74.1628564091566;
        Mon, 09 Aug 2021 19:54:51 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id h187sm3654898oif.48.2021.08.09.19.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 19:54:51 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, lee.jones@linaro.org, pgwipeout@gmail.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v3 1/4] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Mon,  9 Aug 2021 21:54:33 -0500
Message-Id: <20210810025436.23367-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810025436.23367-1-macroalpha82@gmail.com>
References: <20210810025436.23367-1-macroalpha82@gmail.com>
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
 .../devicetree/bindings/mfd/rk808.txt         | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 23a17a6663ec..89b9fa7e10b5 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -70,13 +70,40 @@ Optional RK817 properties:
 
 - vcc8-supply:  The input supply for BOOST
 - vcc9-supply:  The input supply for OTG_SWITCH
+
 - codec:	The child node for the codec to hold additional properties.
 		If no additional properties are required for the codec, this
 		node can be omitted.
-
 - rockchip,mic-in-differential: Telling if the microphone uses differential
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
@@ -459,6 +486,13 @@ Example:
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


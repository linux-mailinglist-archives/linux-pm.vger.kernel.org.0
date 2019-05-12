Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3DC1AB2D
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2019 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfELI03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 04:26:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42706 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELI02 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 04:26:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so5501188pfw.9;
        Sun, 12 May 2019 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qI16oqs6X+YZXj2yLfBOsFJ0yl1UeyG9NZW0E4qFEjM=;
        b=aNTi/o2B+xeystVa+Q3aNwsJJV+tvjZ2fAEK/aibVWkK9S6v+PEwnez16nUwBe1qS8
         upiIjBaoImpcTzZmnd2zg+ZNfHl4G9Gtj9wJyx/MeMH4rvgv9jRjHDAHZKmjgaNCIoYt
         ZhPCrUXvEAxzeOJBttD9d/nSYnwcgncT0lfVkCX/P9rHPTfvzH+mvOBGyYQeIZ08+/nt
         E4wp+KD5lNwl2y/hcYcwzfFeoJB4i9BD21y1V5TjiL7xpZI54mI995MwBx7oRqjMPULL
         cyYzBD/jHpXbPMm6CdpkN9Y09H5KG/zNuginFXcFDxhxiBW5TdnlbZPVboQYf9AZDKQX
         +gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qI16oqs6X+YZXj2yLfBOsFJ0yl1UeyG9NZW0E4qFEjM=;
        b=cGdXjHqUn+V24QxEP8UVSiZptOaT5lwpYuMnhwi0QrYXWqDXM1vdJAMjdRLe6F9b4p
         /KYRBmk/9l1jhEk38Dru3VjBnozDGOd8yHhvDIypwI2kilj7Ye2cfXzZ0UrfG/3Pe0fn
         EdCjcQJS48qyOxcp/n+AAJNI1G4pnSASWN5rB5uCzErs5zs16UmIPtnbx3liM4h/g+9Z
         2cnAIrbUraXikzuAU7roC9SZoSO4ND+wdFxlRLl18QD7l51FKYeOgMtfhCc5hDBvbXfF
         iswvd7iiVlwoVFxccOEZFJOVoRyzPo6fOizb89hsZBfcaRc5aKqvqw/efiDGORhwj3J9
         iUxQ==
X-Gm-Message-State: APjAAAU8CKd4O+a6wPx1wFgM2qUji6qjgxISFe/JfhShyAIiaCg2vNpT
        5yPmk8YzzJB3n4Js7CJv5oU=
X-Google-Smtp-Source: APXvYqw0BUy0j28XMpYRMC1njFl6TsjR5ScQQirgG+92GPsuGEoaMq3sHF4jM3DGqBY3xKz/pGmRVQ==
X-Received: by 2002:a63:8dc9:: with SMTP id z192mr24480707pgd.6.1557649588155;
        Sun, 12 May 2019 01:26:28 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l21sm14297789pff.40.2019.05.12.01.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 01:26:27 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        catalin.marinas@arm.com, will.deacon@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: thermal: add binding document for h6 thermal controller
Date:   Sun, 12 May 2019 04:26:14 -0400
Message-Id: <20190512082614.9045-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190512082614.9045-1-tiny.windzz@gmail.com>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds binding document for allwinner h6 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/thermal/sun50i-thermal.txt       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun50i-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
new file mode 100644
index 000000000000..67eda7794262
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
@@ -0,0 +1,32 @@
+Binding for Thermal Sensor of Allwinner SOC.
+
+This describes the device tree binding for the Allwinner thermal controller
+which measures the on-SoC temperatures.
+
+Required properties:
+- compatible:
+  - "allwinner,sun50i-h6-ths" : For H6
+- reg: Address range of the thermal controller
+- clocks, clock-names: Clocks needed for the thermal controller.
+		       The required clocks for h6 are: "bus".
+- resets, reset-names: Reference to the reset controller controlling
+		       the thermal controller.
+- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
+	       unspecified default values shall be used.
+- nvmem-cell-names: Should be "calib"
+- #thermal-sensor-cells : For H6 Should be 1.
+			  See ./thermal.txt for a description.
+
+Example:
+
+	ths: ths@1c25000 {
+		compatible = "allwinner,sun50i-h6-ths";
+		reg = <0x05070400 0x100>;
+		clocks = <&ccu CLK_BUS_THS>;
+		clock-names = "bus";
+		resets = <&ccu RST_BUS_THS>;
+		reset-names = "bus";
+		nvmem-cells = <&tsen_calib>;
+		nvmem-cell-names = "calib";
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.17.0


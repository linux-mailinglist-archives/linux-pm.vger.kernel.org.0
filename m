Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2944B4FCD9
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfFWQmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:42 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:38028 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfFWQme (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:34 -0400
Received: by mail-pf1-f178.google.com with SMTP id y15so1470748pfn.5;
        Sun, 23 Jun 2019 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vc2TrqpD10fc/Gfq4unesnc+WEyy7mH5ktLy+6dZnog=;
        b=na5YZxEqKvs5q15uC5P1TVCCMSkxBW5asCpG+6XNTePIxjvDEvT+nm/nJ7Mhtz5n20
         IOL8H362bj7nNRmdZxlMJuiG43M5be4/MzEz/4tbEjzcZIhVOpUlTVZQD3SkHTx+r9gD
         vhAV2xRiKaGcRlZ0j5RsCsvmR4GdP+CxJnSyGdkB3YcG2lDyALrhAZKPreixUBDpkOPe
         KbhdYO+xaP7XWzoUy9L27kkSPZymBFpNFsOzgZypoZfhhSN/vKyRxfU630VyVWxq8iV8
         Fn+epGdLDRGIJdu/0IBsiiuui42sm5NKERE9jBgfZZyF+QvXmeFWmLs5x5oGd5IgyUFO
         k15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vc2TrqpD10fc/Gfq4unesnc+WEyy7mH5ktLy+6dZnog=;
        b=Rx/x0chVGBgJrtPb68zM5Kac/lTQd/VKYFyt0PsgTnCy4jFHbxZ7B8ZzU6w2/Qb9Qk
         Av9FdKwMJ0Ps9mYprj5Rj4I90EJo3tbKOR986RKlIYY5u02BczW+MyGp0t3PqcR93laQ
         NAXTY5O3T2/NUfZCV6VmhSZIWsn9gU/3uqsllPDf8HTIP6DGBIFtdXavnckXsgW/jk5f
         W4Eep9zUiM9PJG6r4t54X7+5UZuwzqJmIA1pfrxmDvKklMJJLcv3iKVCUbww0i5gvurf
         Y4DXFg2piFzvnvhI4Hw1pRJuscU8fkFdohBT80ZVHp18Dg9Zro5EYRJSrLZNlwBR8sXe
         oTDQ==
X-Gm-Message-State: APjAAAW8AJ/Smf0roleEH5sLc2+EYNd4jUGrg3p9WLyt8/hmUikRL+hH
        eLG0HdjssZvFg0+3PAiPYO4=
X-Google-Smtp-Source: APXvYqyN7ZztOZynAS2zVYioqIvY15L9IUm9DgxfrduwN8r28+SgkhFt/Fx4DayR43s+eDagPc/BCg==
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr19898276pjq.134.1561308153126;
        Sun, 23 Jun 2019 09:42:33 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j2sm10687361pfn.135.2019.06.23.09.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:32 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 10/11] dt-bindings: thermal: add binding document for h3 thermal controller
Date:   Sun, 23 Jun 2019 12:42:05 -0400
Message-Id: <20190623164206.7467-11-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds binding document for allwinner h3 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/thermal/sun8i-thermal.yaml       | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
index 2c5acc61ed03..1eaf68b5dd5a 100644
--- a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
@@ -16,6 +16,7 @@ description: |-
 properties:
   compatible:
     enum:
+      - allwinner,sun8i-h3-ths
       - allwinner,sun50i-h6-ths
 
   reg:
@@ -29,13 +30,22 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 1
+    maxItems: 2
 
   clock-names:
-    const: bus
+    items:
+      - const: bus
+      - const: ahb
 
   '#thermal-sensor-cells':
-    const: 1
+    enum: [ 0, 1 ]
+    description: |
+      Definition depends on soc version:
+
+      For "allwinner,sun8i-h3-ths",
+      value must be 0.
+      For "allwinner,sun50i-h6-ths",
+      value must be 1.
 
   nvmem-cells:
     items:
@@ -55,6 +65,19 @@ required:
   - '#thermal-sensor-cells'
 
 examples:
+  - |
+    ths: ths@1c25000 {
+         compatible = "allwinner,sun8i-h3-ths";
+         reg = <0x01c25000 0x400>;
+         clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+         clock-names = "bus", "ahb";
+         resets = <&ccu RST_BUS_THS>;
+         interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+         nvmem-cells = <&tsen_calib>;
+         nvmem-cell-names = "calib";
+         #thermal-sensor-cells = <0>;
+    };
+
   - |
     ths: ths@5070400 {
          compatible = "allwinner,sun50i-h6-ths";
-- 
2.17.1


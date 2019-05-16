Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04220DF6
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfEPR0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 13:26:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39725 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfEPR0o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 13:26:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id w22so1888929pgi.6;
        Thu, 16 May 2019 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IlWeur6t+kwpySn24VqBEqPmtDVwsekAH2F04m0wTVs=;
        b=kmjzUz3GIXj8W64WIGM6+ZbI2+dQj9d4/0V7occ3VNHHmSGZx+WJbW4ov8IlbOpc/Q
         H06J4n6ZaSwGd7m/zNkCZ9brpjtsO2VyItzHeZv76NCFPvMkRDKroHSdbOFS86s2oaX3
         4ENJ7aXVpwPqGZZP6sEuEJDitLli+kY6sS2YgtkdKDb33mMc0H5niZSwvwWoq8cE25es
         z1n5KkU7sY3BayPkuPe3wNxlR7eqmuf7UOfxNRGzeyh3XGQCGFgjGJy6QZ0ZK86TBhSF
         MkLcU9S8HW74a4Sz25uQLuACZAbr6wfsMD/3Kk6VY55w+awNLxFQhazriM2XTAoBknRT
         GOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IlWeur6t+kwpySn24VqBEqPmtDVwsekAH2F04m0wTVs=;
        b=cANxjfEYUPFy9j4JP2hMVfideVfCaFDTlTT6GHykju+46VqYUcQ99dLFjmDFFbtm59
         CeT/zd19YuD9nsCgg5wGYri/90y+fqIQpI2Nh3EVU7IuWC9Ty6sSXPMaeUSkkUgVd3q6
         o33WHJZBSPR0LrbT//2y/7bUrvKpATtFD3sI18bWm3+pbYEVz0JoSgny3kBs8E2nTAnm
         xU+uSfHVIKToy4YL/QrkmDQCgHMelNrC8hIW9kloERPN4skIWcbS9Xu7KD4FTtmyfGWt
         uV3kQoJBEe6aVMW28BRRVZa6ulugGhz+Reo3Z9VHVqo4JCYl1DWXsrgs2xYMuSpgfVMa
         Cxgw==
X-Gm-Message-State: APjAAAU8T2sgVHO2C0GRBnUHgZlIyy4Y4Afh+crC8y4OktAcxbGCXinl
        CGDnwZhA65voc87nODJgWC4=
X-Google-Smtp-Source: APXvYqxvISxdB727dwDNTOKXmKUrUn9+Kd3oUXSQ3tEcgfKkDjc40yubFAx2AFYNL5X0JTxXM4yK/A==
X-Received: by 2002:aa7:8f22:: with SMTP id y2mr44011586pfr.22.1558027604243;
        Thu, 16 May 2019 10:26:44 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id r18sm16175557pfg.141.2019.05.16.10.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 10:26:43 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: thermal: add binding document for h6 thermal controller
Date:   Thu, 16 May 2019 13:26:33 -0400
Message-Id: <20190516172633.12607-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190516172633.12607-1-tiny.windzz@gmail.com>
References: <20190516172633.12607-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds binding document for allwinner h6 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/thermal/sun8i-thermal.txt        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.txt b/Documentation/devicetree/bindings/thermal/sun8i-thermal.txt
new file mode 100644
index 000000000000..bd417260501f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.txt
@@ -0,0 +1,34 @@
+* Allwinner Thermal
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
+- resets: Reference to the reset controller controlling the thermal controller.
+- interrupts: IRQ for the thermal controller
+- #thermal-sensor-cells : For H6 Should be 1.
+			  See ./thermal.txt for a description.
+
+Optional properties:
+- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
+	       unspecified default values shall be used.
+- nvmem-cell-names: Should be "calib".
+
+Example:
+
+	ths: ths@1c25000 {
+		compatible = "allwinner,sun50i-h6-ths";
+		reg = <0x05070400 0x100>;
+		clocks = <&ccu CLK_BUS_THS>;
+		clock-names = "bus";
+		resets = <&ccu RST_BUS_THS>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		nvmem-cells = <&tsen_calib>;
+		nvmem-cell-names = "calib";
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.17.0


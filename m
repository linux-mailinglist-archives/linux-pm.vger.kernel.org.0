Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7995202EC1
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 05:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgFVDA3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 23:00:29 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:53166 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731220AbgFVDA1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 23:00:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2037645|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0497008-0.00175125-0.948548;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.HqMydez_1592794774;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.HqMydez_1592794774)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 22 Jun 2020 11:00:21 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        srinivas.kandagatla@linaro.org, linus.walleij@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        p.zabel@pengutronix.de, clabbe@baylibre.com, icenowy@aosc.io,
        megous@megous.com, karlp@tweak.net.au, bage@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Frank Lee <frank@allwinnertech.com>
Subject: [PATCH v2 11/11] arm64: allwinner: A100: add support for Allwinner Perf1 board
Date:   Mon, 22 Jun 2020 10:59:07 +0800
Message-Id: <20200622025907.32574-12-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622025907.32574-1-frank@allwinnertech.com>
References: <20200622025907.32574-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A100 perf1 is an Allwinner A100-based SBC, with the following features:

- 1GiB DDR3 DRAM
- AXP803 PMIC
- 2 USB 2.0 ports
- MicroSD slot and on-board eMMC module
- on-board Nand flash
- ···

Adds initial support for it, including the UART.

Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 arch/arm64/boot/dts/allwinner/Makefile             |  1 +
 .../dts/allwinner/sun50i-a100-allwinner-perf1.dts  | 27 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index e4d3cd0..ab780db 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus-v1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-emlid-neutis-n5-devboard.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
new file mode 100644
index 0000000..d03fa26
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (c) 2020 Frank Lee <frank@allwinnertech.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-a100.dtsi"
+
+/{
+	model = "Allwinner A100 Perf1";
+	compatible = "allwinner,a100-perf1", "allwinner,sun50i-a100";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
-- 
1.9.1


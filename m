Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4745B5A0
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 08:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbhKXHij (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 02:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbhKXHie (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 02:38:34 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AF6C061758;
        Tue, 23 Nov 2021 23:35:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BAD314267B;
        Wed, 24 Nov 2021 07:35:18 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 09/11] arm64: dts: apple: t8103: Add PMGR nodes
Date:   Wed, 24 Nov 2021 16:34:19 +0900
Message-Id: <20211124073419.181799-10-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124073419.181799-1-marcan@marcan.st>
References: <20211124073419.181799-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the two PMGR nodes and all known power state subnodes. Since
there are a large number of them, let's put them in a separate file to
include.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi | 1136 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi      |   24 +
 2 files changed, 1160 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
new file mode 100644
index 000000000000..1310be74df1d
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
@@ -0,0 +1,1136 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T8103 "M1" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+
+&pmgr {
+	ps_sbr: power-controller@100 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sbr";
+		apple,always-on; /* Core device */
+	};
+
+	ps_aic: power-controller@108 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_dwi: power-controller@110 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+		apple,always-on; /* Core device */
+	};
+
+	ps_soc_spmi0: power-controller@118 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_spmi0";
+	};
+
+	ps_soc_spmi1: power-controller@120 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_spmi1";
+	};
+
+	ps_soc_spmi2: power-controller@128 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_spmi2";
+	};
+
+	ps_gpio: power-controller@130 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pms_busif: power-controller@138 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_busif";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pms: power-controller@140 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pms_fpwm0: power-controller@148 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm0";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_fpwm1: power-controller@150 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm1";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_fpwm2: power-controller@158 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm2";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_fpwm3: power-controller@160 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm3";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_pms_fpwm4: power-controller@168 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm4";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_soc_dpe: power-controller@170 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_dpe";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pmgr_soc_ocla: power-controller@178 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmgr_soc_ocla";
+	};
+
+	ps_ispsens0: power-controller@180 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@188 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_ispsens2: power-controller@190 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens2";
+	};
+
+	ps_ispsens3: power-controller@198 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens3";
+	};
+
+	ps_pcie_ref: power-controller@1a0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_ref";
+	};
+
+	ps_aft0: power-controller@1a8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aft0";
+	};
+
+	ps_devc0_ivdmc: power-controller@1b0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "devc0_ivdmc";
+	};
+
+	ps_imx: power-controller@1b8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "imx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_sio_busif: power-controller@1c0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_busif";
+	};
+
+	ps_sio: power-controller@1c8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		power-domains = <&ps_sio_busif>;
+	};
+
+	ps_sio_cpu: power-controller@1d0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_cpu";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_fpwm0: power-controller@1d8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm0";
+	};
+
+	ps_fpwm1: power-controller@1e0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm1";
+	};
+
+	ps_fpwm2: power-controller@1e8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm2";
+	};
+
+	ps_i2c0: power-controller@1f0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c1: power-controller@1f8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c2: power-controller@200 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c3: power-controller@208 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c4: power-controller@210 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c4";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_spi_p: power-controller@218 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_uart_p: power-controller@220 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_audio_p: power-controller@228 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "audio_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_sio_adma: power-controller@230 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_adma";
+		power-domains = <&ps_sio>, <&ps_pms>;
+	};
+
+	ps_aes: power-controller@238 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_spi0: power-controller@240 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_sio>, <&ps_spi_p>;
+	};
+
+	ps_spi1: power-controller@248 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_sio>, <&ps_spi_p>;
+	};
+
+	ps_spi2: power-controller@250 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_sio>, <&ps_spi_p>;
+	};
+
+	ps_spi3: power-controller@258 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_sio>, <&ps_spi_p>;
+	};
+
+	ps_uart_n: power-controller@268 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_n";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart0: power-controller@270 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart1: power-controller@278 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart2: power-controller@280 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart3: power-controller@288 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart4: power-controller@290 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart5: power-controller@298 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart6: power-controller@2a0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart7: power-controller@2a8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart7";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart8: power-controller@2b0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart8";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_mca0: power-controller@2b8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_audio_p>, <&ps_sio_adma>;
+	};
+
+	ps_mca1: power-controller@2c0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_audio_p>, <&ps_sio_adma>;
+	};
+
+	ps_mca2: power-controller@2c8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_audio_p>, <&ps_sio_adma>;
+	};
+
+	ps_mca3: power-controller@2d0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_audio_p>, <&ps_sio_adma>;
+	};
+
+	ps_mca4: power-controller@2d8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_audio_p>, <&ps_sio_adma>;
+	};
+
+	ps_mca5: power-controller@2e0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca5";
+		power-domains = <&ps_audio_p>, <&ps_sio_adma>;
+	};
+
+	ps_dpa0: power-controller@2e8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa0";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa1: power-controller@2f0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa1";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_mcc: power-controller@2f8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Memory controller */
+	};
+
+	ps_spi4: power-controller@260 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi4";
+		power-domains = <&ps_sio>, <&ps_spi_p>;
+	};
+
+	ps_dcs0: power-controller@300 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs0";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs1: power-controller@310 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs1";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs2: power-controller@308 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs2";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs3: power-controller@318 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs3";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_smx: power-controller@340 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_apcie: power-controller@348 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x348 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie";
+		power-domains = <&ps_imx>, <&ps_pcie_ref>;
+	};
+
+	ps_rmx: power-controller@350 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "rmx";
+		/* Apple Fabric, display/image stuff: this can power down */
+	};
+
+	ps_mmx: power-controller@358 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x358 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mmx";
+		/* Apple Fabric, media stuff: this can power down */
+	};
+
+	ps_disp0_fe: power-controller@360 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_fe";
+		power-domains = <&ps_rmx>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_dispext_fe: power-controller@368 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x368 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext_fe";
+		power-domains = <&ps_rmx>;
+	};
+
+	ps_dispext_cpu0: power-controller@378 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext_cpu0";
+		power-domains = <&ps_dispext_fe>;
+	};
+
+	ps_jpg: power-controller@3c0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_mmx>;
+	};
+
+	ps_msr: power-controller@3c8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_mmx>;
+	};
+
+	ps_msr_ase_core: power-controller@3d0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr_ase_core";
+	};
+
+	ps_pmp: power-controller@3d8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+	};
+
+	ps_pms_sram: power-controller@3e0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+	};
+
+	ps_apcie_gp: power-controller@3e8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_gp";
+		power-domains = <&ps_apcie>;
+	};
+
+	ps_ans2: power-controller@3f0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans2";
+		/*
+		 * The ADT makes ps_apcie_st depend on ps_ans2 instead, but this
+		 * doesn't make much sense since ANS2 uses APCIE_ST.
+		 */
+		power-domains = <&ps_apcie_st>;
+	};
+
+	ps_gfx: power-controller@3f8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_dcs4: power-controller@320 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs4";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs5: power-controller@330 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs5";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs6: power-controller@328 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs6";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs7: power-controller@338 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs7";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dispdfr_fe: power-controller@3a8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispdfr_fe";
+		power-domains = <&ps_rmx>;
+	};
+
+	ps_dispdfr_be: power-controller@3b0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispdfr_be";
+		power-domains = <&ps_dispdfr_fe>;
+	};
+
+	ps_mipi_dsi: power-controller@3b8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mipi_dsi";
+		power-domains = <&ps_dispdfr_be>;
+	};
+
+	ps_isp_sys: power-controller@400 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sys";
+		power-domains = <&ps_rmx>;
+	};
+
+	ps_venc_sys: power-controller@408 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x408 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_sys";
+		power-domains = <&ps_mmx>;
+	};
+
+	ps_avd_sys: power-controller@410 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x410 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "avd_sys";
+		power-domains = <&ps_mmx>;
+	};
+
+	ps_apcie_st: power-controller@418 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x418 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_st";
+		power-domains = <&ps_apcie>;
+	};
+
+	ps_ane_sys: power-controller@470 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x470 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_sys";
+	};
+
+	ps_atc0_common: power-controller@420 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x420 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_common";
+	};
+
+	ps_atc0_pcie: power-controller@428 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x428 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_pcie";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc0_cio: power-controller@430 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x430 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc0_cio_pcie: power-controller@438 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x438 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_pcie";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc0_cio_usb: power-controller@440 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x440 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_usb";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc1_common: power-controller@448 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x448 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_common";
+	};
+
+	ps_atc1_pcie: power-controller@450 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x450 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_pcie";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc1_cio: power-controller@458 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x458 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc1_cio_pcie: power-controller@460 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x460 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_pcie";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_atc1_cio_usb: power-controller@468 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x468 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_usb";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_sep: power-controller@c00 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xc00 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on; /* Locked on */
+	};
+
+	ps_venc_dma: power-controller@8000 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_dma";
+		power-domains = <&ps_venc_sys>;
+	};
+
+	ps_venc_pipe4: power-controller@8008 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe4";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_pipe5: power-controller@8010 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe5";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_me0: power-controller@8018 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+		power-domains = <&ps_venc_pipe4>, <&ps_venc_pipe5>;
+	};
+
+	ps_venc_me1: power-controller@8020 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+		power-domains = <&ps_venc_pipe4>, <&ps_venc_pipe5>;
+	};
+
+	ps_ane_sys_cpu: power-controller@c000 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xc000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_sys_cpu";
+		power-domains = <&ps_ane_sys>;
+	};
+
+	ps_disp0_cpu0: power-controller@10018 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x10018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_cpu0";
+		power-domains = <&ps_disp0_fe>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+};
+
+&pmgr_mini {
+	ps_debug: power-controller@58 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x58 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_spmi0: power-controller@60 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi0";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_aon: power-controller@70 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x70 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_aon";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_gpio: power-controller@80 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_gpio";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_fabric: power-controller@a8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xa8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_fabric";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_sram: power-controller@b0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xb0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_sram";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_debug_usb: power-controller@b8 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xb8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_usb";
+		apple,always-on; /* Core AON device */
+		power-domains = <&ps_debug>;
+	};
+
+	ps_debug_auth: power-controller@c0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xc0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_auth";
+		apple,always-on; /* Core AON device */
+		power-domains = <&ps_debug>;
+	};
+
+	ps_nub_spmi1: power-controller@68 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x68 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi1";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_msg: power-controller@78 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x78 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msg";
+	};
+
+	ps_atc0_usb_aon: power-controller@88 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb_aon";
+	};
+
+	ps_atc1_usb_aon: power-controller@90 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x90 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb_aon";
+	};
+
+	ps_atc0_usb: power-controller@98 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x98 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb";
+		power-domains = <&ps_atc0_usb_aon>, <&ps_atc0_common>;
+	};
+
+	ps_atc1_usb: power-controller@a0 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xa0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb";
+		power-domains = <&ps_atc1_usb_aon>, <&ps_atc1_common>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index fc8b2bb06ffe..0487ac64fca3 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -123,6 +123,7 @@ serial0: serial@235200000 {
 			 */
 			clocks = <&clk24>, <&clk24>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
@@ -131,11 +132,20 @@ aic: interrupt-controller@23b100000 {
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0x2 0x3b100000 0x0 0x8000>;
+			power-domains = <&ps_aic>;
+		};
+
+		pmgr: power-management@23b700000 {
+			compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2 0x3b700000 0 0x14000>;
 		};
 
 		pinctrl_ap: pinctrl@23c100000 {
 			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x3c100000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -159,6 +169,13 @@ pcie_pins: pcie-pins {
 			};
 		};
 
+		pmgr_mini: power-management@23d280000 {
+			compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2 0x3d280000 0 0x4000>;
+		};
+
 		pinctrl_aop: pinctrl@24a820000 {
 			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x4a820000 0x0 0x4000>;
@@ -182,6 +199,7 @@ pinctrl_aop: pinctrl@24a820000 {
 		pinctrl_nub: pinctrl@23d1f0000 {
 			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x3d1f0000 0x0 0x4000>;
+			power-domains = <&ps_nub_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -225,6 +243,7 @@ pcie0_dart_0: dart@681008000 {
 			#iommu-cells = <1>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 696 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_apcie_gp>;
 		};
 
 		pcie0_dart_1: dart@682008000 {
@@ -233,6 +252,7 @@ pcie0_dart_1: dart@682008000 {
 			#iommu-cells = <1>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 699 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_apcie_gp>;
 		};
 
 		pcie0_dart_2: dart@683008000 {
@@ -241,6 +261,7 @@ pcie0_dart_2: dart@683008000 {
 			#iommu-cells = <1>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 702 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_apcie_gp>;
 		};
 
 		pcie0: pcie@690000000 {
@@ -275,6 +296,7 @@ pcie0: pcie@690000000 {
 			ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
 				 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
 
+			power-domains = <&ps_apcie_gp>;
 			pinctrl-0 = <&pcie_pins>;
 			pinctrl-names = "default";
 
@@ -340,3 +362,5 @@ port02: pci@2,0 {
 		};
 	};
 };
+
+#include "t8103-pmgr.dtsi"
-- 
2.33.0


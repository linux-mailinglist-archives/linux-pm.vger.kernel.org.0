Return-Path: <linux-pm+bounces-5419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E975F88C136
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1191C3E62E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 11:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0386CDB6;
	Tue, 26 Mar 2024 11:49:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444B6BFD2;
	Tue, 26 Mar 2024 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453747; cv=none; b=pDfjrkSpaghXeOqOnZ3hAj530N2khR2rMlG2MT6e08TuCfLL4khf+ZOv0UwbqRwamZhLy8xQxL+Bs5s9hugE7fYk+yftTvNdDxt+jebOwwyVOj8N/yd0GNEBStEB8E75clJau5L71AxkOS/qjzJuBQFE4l6YMGVfHwh2XF4SLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453747; c=relaxed/simple;
	bh=XhNk0EU5qW4iT/6uCinMLR0F/dKVzKhDelbR2BQVBqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akvC7GTdapRhVNoSxHaJ6mZi7KAEgoKj1K8R9LEO/CbWXPn4YBKzC39Nzi9ZuK94jk0K9/Wt0KCtJe0SNZURp3YssKSPR3Q8/rdMz8LABqckaSaNzpe0tm5HshGX9y0DeGDOy8tEES4pwMvXAPO5QcVr0s0ODiqfq216IBtnyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C27A62F4;
	Tue, 26 Mar 2024 04:49:38 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A913F64C;
	Tue, 26 Mar 2024 04:49:02 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v3 8/8] arm64: dts: allwinner: h616: enable DVFS for all boards
Date: Tue, 26 Mar 2024 11:47:43 +0000
Message-Id: <20240326114743.712167-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326114743.712167-1-andre.przywara@arm.com>
References: <20240326114743.712167-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the DT bindings now describing the format of the CPU OPP tables, we
can include the OPP table in each board's .dts file, and specify the CPU
power supply.
This allows to enable DVFS, and get up to 50% of performance benefit in
the highest OPP, or up to 60% power savings in the lowest OPP, compared
to the fixed 1GHz @ 1.0V OPP we are running in by default at the moment.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi      | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts       | 5 +++++
 .../boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi     | 5 +++++
 .../arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts | 5 +++++
 .../boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts     | 5 +++++
 7 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
index af421ba24ce0c..d12b01c5f41b6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -62,6 +63,10 @@ wifi_pwrseq: wifi-pwrseq {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dldo1>;
 	/* Card detection pin is not connected */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
index b5d713926a341..a360d8567f955 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
@@ -6,12 +6,17 @@
 /dts-v1/;
 
 #include "sun50i-h616-orangepi-zero.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 / {
 	model = "OrangePi Zero2";
 	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &emac0 {
 	allwinner,rx-delay-ps = <3100>;
 	allwinner,tx-delay-ps = <700>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
index 959b6fd18483b..26d25b5b59e0f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -32,6 +33,10 @@ reg_vcc5v: vcc5v {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
index 8c1263a3939e7..e92d150aaf1c1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
@@ -4,6 +4,11 @@
  */
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
 
 &mmc2 {
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
index 21ca1977055d9..6a4f0da972330 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -53,6 +54,10 @@ reg_vcc3v3: vcc3v3 {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
index b3b1b8692125f..e1cd7572a14ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
@@ -6,12 +6,17 @@
 /dts-v1/;
 
 #include "sun50i-h616-orangepi-zero.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 / {
 	model = "OrangePi Zero3";
 	compatible = "xunlong,orangepi-zero3", "allwinner,sun50i-h618";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &emac0 {
 	allwinner,tx-delay-ps = <700>;
 	phy-mode = "rgmii-rxid";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
index ac0a2b7ea6f31..a6458b7a86713 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -51,6 +52,10 @@ wifi_pwrseq: wifi_pwrseq {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1



Return-Path: <linux-pm+bounces-22887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD20A43FEC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 14:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E205917C47B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A4B26988E;
	Tue, 25 Feb 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IHwUmb1t"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CA268FD8;
	Tue, 25 Feb 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488284; cv=pass; b=hLfvuWyJMIz6OTwUrw5ASDopPO5k9/qkEBWyVMmCaPCwjkpuRrF58r1iB1DM4eJBlJPm1HkuEAvz8NMDrjuW2jGmvaI90G5ba6cB63IalrSu9d9Q9X8aVP7o/j7mE4+iv5747jwU13iS0nTHq0hpFG0knjGm9soULzzPad+WlUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488284; c=relaxed/simple;
	bh=jAEe76elxBMYeqH8BFnSVXiTlfwvmQgt9R30KiBeaqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ct1nTvxLQbNJ3J6DFQE1TCVEKyQ+3BYugOH8iVcDPxhWMhu3HEqdQkUTafuPx8yNMlvUsaPQWNvZNYAogNBzj39bacic08F0rhmapoQfkdhdYxVvIJIPU8x32XSNfm7hjocTVMJzNOOqs/5lGvB5KuPnK9SQQ1L18JUi+Uv0gNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=IHwUmb1t; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740488266; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WbVgD9oGy3DepUvX3SqwjQpfam9LRr925GwR5s+TEUuRK/mIazxF3mo72BorkFMJKoLgEZOvQAEgJYj0WHj4/CIPLliCDjThoAE0RQqoVzg6KgtrFHe2cIOAeZk/945lmuYjU6TobM/UGRHlS4qsRyuUzbYpKFntoskGgHWIq/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740488266; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rOJZszzif1/HZY52xKVFqAjULL/Hvz7aQBJ2gFzmCG0=; 
	b=CC7yU/5JQDXEBWBorV1zUVvK5Te7d1Hwb5IpcAwJlTXQB2h41yNept6qipM4Egwttl+vEpSq0VIh5ejgUOwp/XH/AQpqY3nBaLEIco82XGCwJhGiez++p8WIHRmZRtLWJQneAPkXKntVWWy6k3/2rboSwWpP7m2RI+UtVs6yGYU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740488266;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=rOJZszzif1/HZY52xKVFqAjULL/Hvz7aQBJ2gFzmCG0=;
	b=IHwUmb1tHssbhJOq+zAAfI9IPEnmRnl3BXOORaY2IagPuWIZUtgFvqcrmI4vNFpA
	NJD8vvOmHrhhYiuJqwvEgjLLmqkggnw2QNwN4/LlercAVH5JaXqIEmfcOH62DF7l5Mk
	UNe8363eQlqyD6Ny3BxLku83VZ2/X9wHbd6NesO0=
Received: by mx.zohomail.com with SMTPS id 1740488265286980.3837702290158;
	Tue, 25 Feb 2025 04:57:45 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 25 Feb 2025 13:56:48 +0100
Subject: [PATCH v2 5/6] arm64: dts: rockchip: Add thermal trim OTP and
 tsadc nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-rk3576-tsadc-upstream-v2-5-6eb7b00de89c@collabora.com>
References: <20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com>
In-Reply-To: <20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Thanks to Heiko's work getting OTP working on the RK3576, we can specify
the thermal sensor trim values which are stored there now, and with my
driver addition to rockchip_thermal, we can make use of these.

Add them to the devicetree for the SoC.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 6603f442674c09d017a256bc272e33a2fea7cb8d..e7ce707e6339bcdddb2914eb7e0ed8269275c679 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1465,6 +1465,30 @@ gpu_leakage: gpu-leakage@21 {
 			log_leakage: log-leakage@22 {
 				reg = <0x22 0x1>;
 			};
+			bigcore_tsadc_trim: bigcore-tsadc-trim@24 {
+				reg = <0x24 0x2>;
+				bits = <0 10>;
+			};
+			litcore_tsadc_trim: litcore-tsadc-trim@26 {
+				reg = <0x26 0x2>;
+				bits = <0 10>;
+			};
+			ddr_tsadc_trim: ddr-tsadc-trim@28 {
+				reg = <0x28 0x2>;
+				bits = <0 10>;
+			};
+			npu_tsadc_trim: npu-tsadc-trim@2a {
+				reg = <0x2a 0x2>;
+				bits = <0 10>;
+			};
+			gpu_tsadc_trim: gpu-tsadc-trim@2c {
+				reg = <0x2c 0x2>;
+				bits = <0 10>;
+			};
+			soc_tsadc_trim: soc-tsadc-trim@64 {
+				reg = <0x64 0x2>;
+				bits = <0 10>;
+			};
 		};
 
 		gic: interrupt-controller@2a701000 {
@@ -1876,6 +1900,39 @@ tsadc: tsadc@2ae70000 {
 			rockchip,hw-tshut-temp = <120000>;
 			rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 			rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			soc@0 {
+				reg = <0>;
+				nvmem-cells = <&soc_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			bigcores@1 {
+				reg = <1>;
+				nvmem-cells = <&bigcore_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			littlecores@2 {
+				reg = <2>;
+				nvmem-cells = <&litcore_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			ddr@3 {
+				reg = <3>;
+				nvmem-cells = <&ddr_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			npu@4 {
+				reg = <4>;
+				nvmem-cells = <&npu_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			gpu@5 {
+				reg = <5>;
+				nvmem-cells = <&gpu_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
 		};
 
 		i2c9: i2c@2ae80000 {

-- 
2.48.1



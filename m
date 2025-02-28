Return-Path: <linux-pm+bounces-23198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C23EA4A3AE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B554017BAF3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D8027CCF2;
	Fri, 28 Feb 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="FUuhjxCE"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9027CCE5;
	Fri, 28 Feb 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773272; cv=pass; b=IHOcZn1DolQqJNdTFjnHyZMH8bSJ7ifKfjGzdAVejLQHp46bDGFhF6bOeehHkPn0xdMifxSh+TyQzd71LQ8XaXWzdiY9+Yp7tOvOz7PuMra3CRSrgGLPIQP4F8eQjtZKZENcO/wLgoj3dn+kVQdga4TbwRuGaEQboZFG9vvuX3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773272; c=relaxed/simple;
	bh=Z9w7V9sRCL5k5bkgRxx/RZQZmMK6ZR7oyHz7ox+ytzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAeBK+X5RUsNarKGZosfj7VKGDgJ+KocEby1z6zwCklTxuncbTya5d2vS7A+OSuW2YFfWmnl7KJmh8unsuKN6W4B4O5zgTsBU/j0O2UXO+FiUkqfS2xAmjf8oeqfg2KG0DS5rhMFOXw4vTvP4SKCtJbWd+ccT2uDmobIUwN8JfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=FUuhjxCE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740773252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XMkauax2Bi01wT1wkLHpHst5H/+XTJw8Ll6GTP7SM/u9+Fy+OU7GIAIxlKBlylGCJ6Y0aHqbiVvfud/P0x+pv5VvLOe4weYM7jhnH/FF6pHO/xIQ/ef4WhpC7nnsbJlB4CiPQlWKe7t+irVenNSio3JCtFXGFBICME6hWaVSEvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740773252; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hC0j5AIeLbOuxXZpJlCeSQapOYCA4pQ4gSJxZQkp7sM=; 
	b=jR3J6b9i94ElLJQg5rB1CaV+4Jyf5SpcZ8eiL6b4k7fkaBTp79n95HaZif0+226XHhVa64vgcuoBDTMNZ6gEF+RGYY6p6J7yJzE1AWOjmM5zwG+m1s89AJ7kCVT6jO4ZLcGNnR19gVTJzmi1eV3BfIaaJeSOTMTGP+YG/grggzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740773252;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=hC0j5AIeLbOuxXZpJlCeSQapOYCA4pQ4gSJxZQkp7sM=;
	b=FUuhjxCEqmbghbGVj65zz4fG/Jkj5GyYXAKRQxQ6YRYjWAcp4IATDff4C6QLc9h7
	E4mArEny0BwZYxGbg3glATqNt5bhyWQ2T7aVz3yWpzW7dlj4CIT1jUscRCpKMCqQfNh
	fzkrcITXNRMEC0fW28D4eEczp40XVPYEG14sUPgQ=
Received: by mx.zohomail.com with SMTPS id 1740773249474827.0097059128609;
	Fri, 28 Feb 2025 12:07:29 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 28 Feb 2025 21:06:55 +0100
Subject: [PATCH v3 5/6] arm64: dts: rockchip: Add thermal trim OTP and
 tsadc nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rk3576-tsadc-upstream-v3-5-4bfbb3b699b9@collabora.com>
References: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
In-Reply-To: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
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
index 6603f442674c09d017a256bc272e33a2fea7cb8d..1d589a961e7f25d1595fbfa3a19f69e3e8bcb990 100644
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
+			sensor@0 {
+				reg = <0>;
+				nvmem-cells = <&soc_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@1 {
+				reg = <1>;
+				nvmem-cells = <&bigcore_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@2 {
+				reg = <2>;
+				nvmem-cells = <&litcore_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@3 {
+				reg = <3>;
+				nvmem-cells = <&ddr_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@4 {
+				reg = <4>;
+				nvmem-cells = <&npu_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@5 {
+				reg = <5>;
+				nvmem-cells = <&gpu_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
 		};
 
 		i2c9: i2c@2ae80000 {

-- 
2.48.1



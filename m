Return-Path: <linux-pm+bounces-22588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4782A3E990
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BAC1760C4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3C22C859;
	Fri, 21 Feb 2025 01:00:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF162AD13;
	Fri, 21 Feb 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099626; cv=none; b=NnVIYyxwk6SkXhhAZavOv3+zBRkvJ0u2HoZmUqFsTGUTeSM3+r2hK3CombZ26NYL+lGZ3vdYfuYUGid5Aa9+ZBE+Vc/jt1nq+yDwYISjYPy9dgxu6CciravvPUQMIhlbOvfG5vB27WcWrHuKtEN/i6ODiu7AO+1KxjSWTBWyKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099626; c=relaxed/simple;
	bh=ZJ3ElqUDIOsv4AQqyKZQ5IAlKaqkiHZz5OeMewk1Rd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5d1jONHHhImGIbKWqugXPB5FZi8Ob/iq8sE2YY/OfeIFaMl7seLh+qH1ht45f88UJvxFTj/Kcktdy60BnXuPCqiK5KejV7K7JANKwJFd0e87D56vtutt3ONInAP6p1BdYMLaRuFjLRnL9W/pjmsbCqVOopu21Y+gLLtORZDH3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E7DD1C01;
	Thu, 20 Feb 2025 17:00:42 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56083F59E;
	Thu, 20 Feb 2025 17:00:21 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: allwinner: h616: Add Mali GPU node
Date: Fri, 21 Feb 2025 00:58:01 +0000
Message-ID: <20250221005802.11001-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250221005802.11001-1-andre.przywara@arm.com>
References: <20250221005802.11001-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 SoC contains a Mali-G31 MP2 GPU, which is of the Mali
Bifrost family. There is a power domain specifically for that GPU, which
needs to be enabled to make use of the it.

Add the DT nodes for those two devices, and link them together through
the "power-domains" property.
Any board wishing to use the GPU would need to enable the GPU node and
specify the "mali-supply" regulator.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index cdce3dcb8ec02..ceedae9e399b6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -150,6 +150,21 @@ soc {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		gpu: gpu@1800000 {
+			compatible = "allwinner,sun50i-h616-mali",
+				     "arm,mali-bifrost";
+			reg = <0x1800000 0x40000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&ccu CLK_GPU0>, <&ccu CLK_BUS_GPU>;
+			clock-names = "core", "bus";
+			power-domains = <&prcm_ppu 2>;
+			resets = <&ccu RST_BUS_GPU>;
+			status = "disabled";
+		};
+
 		crypto: crypto@1904000 {
 			compatible = "allwinner,sun50i-h616-crypto";
 			reg = <0x01904000 0x800>;
@@ -874,6 +889,12 @@ r_ccu: clock@7010000 {
 			#reset-cells = <1>;
 		};
 
+		prcm_ppu: power-controller@7010250 {
+			compatible = "allwinner,sun50i-h616-prcm-ppu";
+			reg = <0x07010250 0x10>;
+			#power-domain-cells = <1>;
+		};
+
 		nmi_intc: interrupt-controller@7010320 {
 			compatible = "allwinner,sun50i-h616-nmi",
 				     "allwinner,sun9i-a80-nmi";
-- 
2.46.3



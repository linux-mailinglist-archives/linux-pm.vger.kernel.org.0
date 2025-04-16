Return-Path: <linux-pm+bounces-25584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911EAA90EE9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 00:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AACA1901AF0
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 22:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AF24337D;
	Wed, 16 Apr 2025 22:49:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB2E2459C8;
	Wed, 16 Apr 2025 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843783; cv=none; b=THFULtCDEopZ2W6YELHl/yBUumzUzf4VtMNzSL4R4Ur1yOEdfJgzblVSJ3BmQ2g1blVeTvyJkMEwwD4dzd2Wf6YC7zkCijb0JhHgzSg43Pso1nPW9xi198/exuVzBhtHb7xrn/6ffjypwnvMK+d5UDjK0ZijpYwRUu16yxxoEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843783; c=relaxed/simple;
	bh=15IbJAe5dZgf9F6Fvy64YY/kZ+NK5Hp5M7Y/vMgUSWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQNCnPOSkDvewVa2WtNcxbxRf8ePOpSMSNBISpMGhcsuoE4Q5B7FvqcPOVDYSfsFZf4/SH0WgEuPKCTUv4LmkOHgzrU6Ty4HFfzh1lAkK8rnNHdrEQuLxuZcX9pgGsCEv7n/rXaepZeF1gnp40jjyJp/aQ/E+iOGaIo5EMt66CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F251595;
	Wed, 16 Apr 2025 15:49:39 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB4343F66E;
	Wed, 16 Apr 2025 15:49:39 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: allwinner: h616: Add Mali GPU node
Date: Wed, 16 Apr 2025 23:48:38 +0100
Message-ID: <20250416224839.9840-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250416224839.9840-1-andre.przywara@arm.com>
References: <20250416224839.9840-1-andre.przywara@arm.com>
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
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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



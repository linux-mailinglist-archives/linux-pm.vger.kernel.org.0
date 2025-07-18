Return-Path: <linux-pm+bounces-31045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6783CB09B7D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 08:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8BF1892FBD
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 06:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF091FDA7B;
	Fri, 18 Jul 2025 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKi/tRqn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2941DDC37;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820663; cv=none; b=dYwXjrP1YIsnjugQ/NpRCFzObKD3yQQPWf4VCQcdpfzVKpLGnyKV23GW33M4F/ZzhMwaV+LWv8KiAudn0xGYlziP4GW/Zl1E3E2nSxleJqbOqSAc/xrq7LFWopaB/fMVIP3IjmLZA1HwZZQdj64U7JzunUPYYykMll32A1YNWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820663; c=relaxed/simple;
	bh=Vg/Qxml+vCOWtwi27g4HsyyOYy1gOhqTGm45155VutI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pvnzs/tx2bpEgpE+g/icGnn+VaA4lkIRV1fSD2QsFlKd2c/dPnHCq7u9eNZHmYZidk/tfxJRsVXDXaK595evpGPSaIghvGcjIrf1QcHTsmjEnYCNsSTvk6Wujh8oxcMLNNXn60r57WWIdb4DKvsQN6huwRAvWRd+Fv/1i7wJxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKi/tRqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6296C4CEF5;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752820662;
	bh=Vg/Qxml+vCOWtwi27g4HsyyOYy1gOhqTGm45155VutI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RKi/tRqnJbZLGLSOWIEaui7ZZ4H5r7Z6HkMGueXQOKAn1EMtAKt+AXCQ0tn5c3duV
	 fmGfub+iVN9LqkTwXCfvaj7JaQTwprkvyZyaUPtSuKPUy4URG0634UdKbV8f14YxMM
	 vuNph1+sf2bKI246Q9nMVT4XDrxZsuOqg5LYrR8QMZGF5UdYi1ttduvfodrI4rfvFe
	 ef3D611H6MAJ6UKKr1vbSphdVAobgoV4BOjhpqieMBmSVObPCpiJtjSxpTNMcrHhr8
	 7Cznuaj53YsTbVDhRONyWNtsdhcw9ATUiNEWL2PwNaLgSucXRqdnUjtyAlt4YzLax2
	 nr3PowNkt9KgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F27C83F17;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 18 Jul 2025 14:37:43 +0800
Subject: [PATCH 3/3] arm64: dts: amlogic: c3: Add tempsensor controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-c3-thermal-v1-3-674f9a991690@amlogic.com>
References: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
In-Reply-To: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Liming Xue <liming.xue@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752820661; l=1117;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=vWhNDYyE9xSECm6+/EYb548/qKTRV6MGziQpMJtR/5A=;
 b=GfoyeV+CAv/f/E7OEN1Tz3QApTOrFtWdFN5Z5fCvJjhDvbhe1bPYlFP48Z45K0KrxlaDpsS2P
 Ibg/ocitfAYCay1tzVjxBphiYRlbiSXlUKkB0nSscl7y3h139ZVkMri
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add the Tempsensor controller node for C3 SoC family.

Signed-off-by: Liming Xue <liming.xue@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index cb9ea3ca6ee0..c853390eca6c 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -727,6 +727,17 @@ clkc_pll: clock-controller@8000 {
 					      "fix";
 			};
 
+			temperature-sensor@20000 {
+				compatible = "amlogic,c3-cpu-thermal";
+				reg = <0x0 0x20000 0x0 0x50>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc_periphs CLKID_TS>;
+				assigned-clocks = <&clkc_periphs CLKID_TS>;
+				assigned-clock-rates = <500000>;
+				amlogic,ao-secure = <&sec_ao>;
+				#thermal-sensor-cells = <0>;
+			};
+
 			eth_phy: mdio-multiplexer@28000 {
 				compatible = "amlogic,g12a-mdio-mux";
 				reg = <0x0 0x28000 0x0 0xa4>;

-- 
2.37.1




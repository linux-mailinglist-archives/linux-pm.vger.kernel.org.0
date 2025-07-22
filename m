Return-Path: <linux-pm+bounces-31279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57AB0D828
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 13:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D993A5DFF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6372E3AF4;
	Tue, 22 Jul 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ87M1xL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA92E2F05;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183590; cv=none; b=IIM3BJhLe/7x/3HgKQA0zZOowIi2HOo06KahQtg8N1XpvcRpfyPaNkAO9FxQULT/unT9DkAW62ON1pJgr5ZUdSCYsXAlDlfNQ+4woRsTejEacmn9rv6hoZZ4Rthu3DJwusig66hlHQY3mmYUH3ryeFfrL6V2qvzUaIrznZFfRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183590; c=relaxed/simple;
	bh=gpUTUqXOWbULFlsiYSGEN3jZoAtqx3OWjHms0p86oTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zg6JV/4O1Hqoure7YSLOIparSudA+KLO7U7gFWPfeRx1025c8aC7+4iZCCU7NV+5AFkLbmSDaS3KOAyD+8kbZNQJQ5qsKu2o9CNQ06fHlIHAXKmCcLwim4pH7LZLnX5CIcyLkGPhYSoRNBfIC33lVuZxo5lMv/XgSLvOuTxICm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ87M1xL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC823C4CEF7;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753183589;
	bh=gpUTUqXOWbULFlsiYSGEN3jZoAtqx3OWjHms0p86oTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nZ87M1xL6Yk0BG7E0SFkozay2PjlaXgqwer7C0N6jR664uq26o+naJBL59ZRez01w
	 4TE5jePrre9dRrcoC3Tj5u2CxZ+K8JrPsOZCeOMVmucV63ZNO+vFHJDlwqy0jbEVPi
	 6+IEqOHUMtEx4yEyFGYP4b8CnNMnFPLJFmLja2ahGXwQdHArBl1W6SOPwuvQiG7+9C
	 ZkhYyDqHK1RfRO6gCiDeTuK+2nfRPpDXEHsN+Tnav1D1pNrlbQ7hnbhaSv9JXqIWgr
	 dE4WiETx19O8cz3oKSUW85vNHjoTjj9OPwClFJ+85m2y9Hjy8KdvSOaqbKo92/xAJm
	 vfxRn+F7uVJYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FC1C87FC5;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 22 Jul 2025 19:26:29 +0800
Subject: [PATCH v2 3/3] arm64: dts: amlogic: c3: Add tempsensor controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-c3-thermal-v2-3-b2231b4be79e@amlogic.com>
References: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
In-Reply-To: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753183587; l=1174;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=IoRBkt3TWKHWrtMJz187CwMxwu8yF7DTD3qyajQTJnE=;
 b=LmYFK1+8fHyOjr607kbVF4ATEFnyzGdngoasYURRQr2BWxwHZ8cPDjAMx45X65KAZp/FxwlMx
 Wbt4Q7TQ7uSApW4HfcfFSbzCQjIKrOLYrapEVKroqNXJs8E1KIBHOc7
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add the Tempsensor controller node for C3 SoC family.

Signed-off-by: Liming Xue <liming.xue@amlogic.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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




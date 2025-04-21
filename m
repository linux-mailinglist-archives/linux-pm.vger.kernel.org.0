Return-Path: <linux-pm+bounces-25813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB037A955C0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 20:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210D41895A52
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2B1E9B31;
	Mon, 21 Apr 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOrIlr69"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116981E8854;
	Mon, 21 Apr 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259233; cv=none; b=obyKjgjkHGvVIwfFzMQE1oXq6XBhM00wQ3idgPiMSh2tLXbaByrLUR+bcbZBC89wfYfoUysF6Q5wXt2BvqysPiUpTGx+OHCmlkQk6yzH8dOMpfG/Z+qvdVSz5IdUhmQlAqF3ETYYqSotwe9GGQkyE/FZReWJqY9X0plDIcPrlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259233; c=relaxed/simple;
	bh=5xEPkCKOVRabxXHHeF2mu6uzqMA218cBnnVPAnWjDKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7HmFuCthz1vF44uq4sNmk2s1gz+teBNtmm948Jca7QmWLR/aws9qmOgHqxUL6vQNm5G7DkOG04V4r5wqhPCY2LICCW6fDk7G5xs6yJyz2RxGennshR+sYLMiYmlHeZh6EGTkZAaN95GIkREHNcSaJPOpCDd59voFUBNt3T59KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOrIlr69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB3B6C4CEF7;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745259232;
	bh=5xEPkCKOVRabxXHHeF2mu6uzqMA218cBnnVPAnWjDKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IOrIlr694miPvQfU2wp3lnwc7P631sDN8U+hIUlcI3sV32VBnRhVwAf98A9aGl49Q
	 oTa1GcLupUCKz71t3LjmW87kJnyeG3F6nKq0tT3WA8m5bmqDHok4m5LFYCja9CEvV2
	 BIDBvdOL3Sjkez5/Kgayg/+qoSaWPs54drYOkFAjexReHrPmLDu0ACERgeSyiN2kZ8
	 bI/Zdpwbtb42R2l2/LwjKgJZEQiQiji6oBzS6OoUAggGsZC+wjb3C6dqHzzkFM+DJE
	 MHjfGQOOzKKLkqgBhqJ9uw6pLsfQpvoph7L7UlM4ZXh10LhUS72d5jtjiDG4DOAVRv
	 MzlQXwrPlRxjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD30C369D7;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 21 Apr 2025 20:13:36 +0200
Subject: [PATCH v3 5/5] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-b4-gs101_max77759_fg-v3-5-50cd8caf9017@uclouvain.be>
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
In-Reply-To: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
To: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745259219; l=1313;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=+E8KTkRWD/mhjwDdm0OrzwMI0i7bo8G/TbulwCt/cNU=;
 b=3Vmi01/6lLR8bdWK8rEFtyFk8OJvaSSYwt+P0HGLokKmOmUByXF181HxjD28obfVkyXl2dRlz
 +rwW3Uw+43aDGPshLCK05RKjDNecb/srcSX5tw0KEv7JXZaDrFG9C9G
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

Add the node for the Maxim MAX77759 fuel gauge as a slave of the i2c.

The TODO is still applicable given there are other slaves on the
bus (e.g. PCA9468, other MAX77759 functions and the MAX20339 OVP).

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
index b25230495c64dce60916b7cd5dcb9a7cce5d0e4e..84fc10c3562958ab1621f24644709e85a9433b9b 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/usb/pd.h>
 #include "gs101-pinctrl.h"
 #include "gs101.dtsi"
@@ -188,6 +189,15 @@ usbc0_role_sw: endpoint {
 			};
 		};
 	};
+
+	fuel-gauge@36 {
+		compatible = "maxim,max77759-fg";
+		reg = <0x36>;
+		reg-names = "m5";
+		interrupt-parent = <&gpa9>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		shunt-resistor-micro-ohms = <5000>;
+	};
 };
 
 &pinctrl_far_alive {

-- 
2.49.0




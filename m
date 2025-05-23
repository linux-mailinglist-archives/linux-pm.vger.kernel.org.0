Return-Path: <linux-pm+bounces-27560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1BAC2318
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2849E6593
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 12:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06432E56A;
	Fri, 23 May 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LllHz6nG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90713D539;
	Fri, 23 May 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004725; cv=none; b=PKXl0XU2f1HbQUT8y5TuG2LorRzEbBKPjxbOAUH+wTKKAWfaU267Ky3OMv/PJKUaKgU9fCe92Ty3y0+79BbpZPaFijH9fj6elOnbjKYtzvnvEYcTwJDQTLIbLwI7HQyyhGkWhLMozcNRPUFeQS1fpYw49j2cneWfoxC1Gb7Rdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004725; c=relaxed/simple;
	bh=5xEPkCKOVRabxXHHeF2mu6uzqMA218cBnnVPAnWjDKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgX3AuNNYQ75JCrlQfX7DnXX5h8WEfLLoZ4hPyA39g2rc6SsDlRt8DZCLHRjMK/GaNEScueBYlGv0riZEb3VDbyQJMz6hP50NqYr2q95typMjOkjiKKczJNLCQrJ0qcywkCZDLuumhhx9mdWb/EAwhQyvjmez1MOFQ55YE+Wmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LllHz6nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 095DCC4CEFC;
	Fri, 23 May 2025 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004725;
	bh=5xEPkCKOVRabxXHHeF2mu6uzqMA218cBnnVPAnWjDKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LllHz6nG9P0P6lqF5UTY/3f+N9k5BG0zsxSI+UQHBPVr3KNRmJyXay69LCwZkSPzt
	 /WRBdnhVIqfaTj6h2DQimco3j992MvQbKYoTpGb4eI1+wA4xbXNM3wSm7fPzKqGaxC
	 8jKLug/4bnD6afGxSAmj3lBZVmwREwo6iM8J/lmOw9xj6EhgFMbNht3HXcenQ9zPpn
	 dq9AA2GOWkPa7Kgn5Oukh6gyxxekgxObSDszJ0S13qAq+VN1giK3JyzeyHGs3nTIcg
	 1OFED0bQ5cNEXTRotL0vPMEGDie3m/4kFH8HwtQRf4LooFg34exhKtCHdTDwWE9fY9
	 rHahyelbYV3XQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE8C54ED0;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Fri, 23 May 2025 14:51:48 +0200
Subject: [PATCH v4 5/5] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-b4-gs101_max77759_fg-v4-5-b49904e35a34@uclouvain.be>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
In-Reply-To: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748004728; l=1313;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=+E8KTkRWD/mhjwDdm0OrzwMI0i7bo8G/TbulwCt/cNU=;
 b=MYix6XzRqq6cT99BsYFIb7MAMuaH8dv8cWyZm+XbOlmT+uPnbhQ8flVvXyGL8f+B0C3wLpesh
 EXi+XggFsWTCoM+id863xpYa859aiKBzlF3SGv5TvKbKUBqcx8PPhB9
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




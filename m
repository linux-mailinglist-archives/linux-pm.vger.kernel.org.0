Return-Path: <linux-pm+bounces-27181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB6AB7DD7
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EEC97B2DAC
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DC5297B62;
	Thu, 15 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbDCdIb8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085C296FC4;
	Thu, 15 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290135; cv=none; b=kOP43W3LU4sNRZ2uOKWyrtZcUVuNVhDnQNtabbf/D/QTFJvJUZ5cS0EMsEkiyafjV9XArUO/rz8wyoaJntp/EoEJawwwzQ0qr9URhdaSYfxpM0uUu5sj9SZ9RFXQp9rthaCSrIBxddqQbVuOxFJjMJfu73knd5F0H8h4D7ICeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290135; c=relaxed/simple;
	bh=ykNBi3KAREJBNtyaAZC4bxd1zGBY/JMXzTnD8rnh/ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsm3etOrduCO1JDz6rP4R46sQnoBPvZn3Fz96m/k7fAw+wXY+XotmJ57lLNrK6sBn5KOFllqOj6N1bD2NnoapTwDBXXfLK9cuqfl4j5ntr3wSaLzdtMI5amkU8u2caMw2ZRTiXU4Cb3Yk02vfUWf4rS315inyIw1CCjYodhqd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbDCdIb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FD01C113D0;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747290134;
	bh=ykNBi3KAREJBNtyaAZC4bxd1zGBY/JMXzTnD8rnh/ZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MbDCdIb8/xmQqRfrlrfWi0hDpMmtLotme+EnuZrIG20oD7RbRZfMV4vcjdI/y2qUJ
	 rgXyngeD33Wd1H/RwR+Ica+rApDXV/LUdxh7WZ1yIssdtWGe6MKXmK0YuAxxGwUpUg
	 puvvjnmh+uksZ1IvnStWxjIKjvZIDnwZBpjocRFwT4r3LkgdhoAVOuRZ7j31lVlE3D
	 1wnk2smxKnq5ERgBveGAk9vFk+L2wLoZH+L0p9UbqfRzrHSCfZN+gagmQTt1iwfylL
	 aHLe4LS5ONv6zTr+H2q+H8V2rpQhWBHmckpknNN02uxopzdzgJecQMZmF4j7BQOLeE
	 sXQjt/ZM2kTWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969C9C54756;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Thu, 15 May 2025 06:21:20 +0000
Subject: [PATCH v6 08/10] arm64: dts: apple: t8103: Add SMC node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-smc-6-15-v6-8-c47b1ef4b0ae@svenpeter.dev>
References: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
In-Reply-To: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=gdzfbJLb26UAFB0bjqwbBtrfsteBwHoeOAqTxBIzTeA=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZqhwDnTDaR3+Vvu709H+1wZJa8t+9vDPvF79kL2e7G+
 qpVyfd2lLIwiHEwyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACZiZcDwT8O4m1/P7X3nT8a/
 Ovs/y8qyzOkKlp28gkXqSsh0+RWxCgz//Zf0e2fPbrDhbnYWsNujWbKuz2zZfpMJ/3oLzyUoOM7
 kAgA=
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 20faf0c0d80927b2e18dd966a61b5507b322c72f..614f2986518cdefee6277e048377a27e22aee570 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -836,6 +836,41 @@ wdt: watchdog@23d2b0000 {
 			interrupts = <AIC_IRQ 338 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		smc: smc@23e400000 {
+			compatible = "apple,t8103-smc", "apple,smc";
+			reg = <0x2 0x3e400000 0x0 0x4000>,
+				<0x2 0x3fe00000 0x0 0x100000>;
+			reg-names = "smc", "sram";
+			mboxes = <&smc_mbox>;
+
+			smc_gpio: gpio {
+				compatible = "apple,smc-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			smc_reboot: reboot {
+				compatible = "apple,smc-reboot";
+				nvmem-cells = <&shutdown_flag>, <&boot_stage>,
+					<&boot_error_count>, <&panic_count>;
+				nvmem-cell-names = "shutdown_flag", "boot_stage",
+					"boot_error_count", "panic_count";
+			};
+		};
+
+		smc_mbox: mbox@23e408000 {
+			compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x2 0x3e408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 400 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 401 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 402 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 403 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+		};
+
 		pinctrl_smc: pinctrl@23e820000 {
 			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x3e820000 0x0 0x4000>;

-- 
2.34.1




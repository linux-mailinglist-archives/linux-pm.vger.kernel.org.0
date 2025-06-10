Return-Path: <linux-pm+bounces-28399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CFAD3E7F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 18:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373533A48EA
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E123242D6D;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+aaPdC6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286112405F6;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571840; cv=none; b=nb5Mt2+Al+lTlJNXPFPqrjQWRFS/I5pBtaecyNZq/4RDt7BEGX2qh62Sd/RmlYNpWFMoHLKKk9cHprnSehozdSQBgYeq+h4TXjOles0ugOQjOdblv5EIpQtU9LuNhyRN6lyitVrW1ZJGVaLRYQwyxoDvgk24WA0wz9Gk08qUjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571840; c=relaxed/simple;
	bh=p9Wj3SDsVd05bKRi33m2+hhffQLnDh98AT3iDP+7Aiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMPcn9PLIWOhzgFnAM0TJHygVyQPKJTmJLhA6BguiVw4DhI7gULboER0u/Xu36AtRrJRk2EcdKX+zQ/1alfr0swGvsTQ2NM+RFHH3vpLR4xEXw1Ecm1/AYHb557PpDhCMsu5KzVQyN8DDIfiiuF3yeRTjgdYpNPkMA9die9Ude4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+aaPdC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBF9DC2BC87;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571839;
	bh=p9Wj3SDsVd05bKRi33m2+hhffQLnDh98AT3iDP+7Aiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y+aaPdC6FJr0uy5k85ey35yjOAi+vwFTy1iyC4sNRHVSaaJWIir1dcX6qIAYCACTb
	 N0/xk2rpWUabqxZodeIdfRw5ma1xn86Z6pOIBLqe83K8tzijASVS2DDd6KHDnCllRR
	 jEFOx5/qG+Tj6eH/PJjA8J8HlhjjgkQMkDIoMRAkBxqGWYmKptXj29oQxX4k6b86gk
	 +mqY5NJvtMbBzonW13jNMoIEByegFNIFeTfecqftdgVzzivT/mxQGOLtT0qSbXW6zo
	 PYIHLvbZZ1M0RB11m6A3i9dGORHbCL7jnkO8YHt6oWMxLH3c/ZvXz/dVw92KL3ybte
	 XRLitSMTFR8vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E30C5B543;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Tue, 10 Jun 2025 15:29:49 +0000
Subject: [PATCH v7 08/10] arm64: dts: apple: t8103: Add SMC node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-smc-6-15-v7-8-556cafd771d3@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=QseMb+jJFna0l2+kYOBbQAO/bcEYjG/Mne8IFhJOnBM=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4aHfyVPnVPBhes8u9xPHf6VWdQUWetZncVilbeE30hA8
 Xf5licdpSwMYhwMsmKKLNv325s+efhGcOmmS+9h5rAygQxh4OIUgIlk2TL8d35galj+Kypb8YAd
 Z2Oc9cfW938z1+5IXz8nQ4o9JHqpASPDt4/t++szCwKOarXfd9inNlv3r7+xrZK3WqnbSeGAfnZ
 eAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
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



